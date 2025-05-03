# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QImage
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType
from PySide6.QtCore import QUrl ,QObject, Signal, Slot, QBuffer, QByteArray
from PySide6.QtLocation import QGeoServiceProvider

import carla
import numpy as np
import time 



class BackendAPI(QObject):
    front_camera_frame_ready = Signal(str)
    back_camera_frame_ready = Signal(str)
    vehicle_speed_updated = Signal(float)
    collision_warning_signal = Signal(str)  # Signal to trigger a warning in QML
    critical_distance_warning_signal = Signal(str)
    CRITICAL_DISTANCE_THRESHOLD = 3.0


    def __init__(self):
        super().__init__()
        try:
            self.client = carla.Client("localhost", 2000)
            self.client.set_timeout(10.0)
            self.world = self.client.get_world()
        except Exception as e:
            print(f"Error connecting to CARLA: {e}")
            sys.exit(-1)

        self.vehicle = None
        self.front_sensor = None
        self.back_sensor = None
        self.is_running_front = False
        self.is_running_back = False
        self.collision_sensor = None
        self.lidar_sensor = None  # New LIDAR sensor
        self.__spawn_vehicle()
        self.last_frame_time = time.time()


    def __spawn_vehicle(self):
        blueprint_library = self.world.get_blueprint_library()
        vehicle_bp = blueprint_library.filter("vehicle.carlamotors.firetruck")[0]
        spawn_points = self.world.get_map().get_spawn_points()
        if len(spawn_points) > 75:
            transform = spawn_points[75]
            self.vehicle = self.world.try_spawn_actor(vehicle_bp, transform)
            if self.vehicle:
                self.vehicle.set_autopilot(True)
                print("Vehicle spawned successfully.")
            else:
                print("Failed to spawn vehicle.")
        else:
            print("No valid spawn points available.")


    @Slot()
    def start_front_camera(self):
        if self.is_running_front:
            return

        self.stop_back_camera()
        blueprint_library = self.world.get_blueprint_library()
        rgb_cam = blueprint_library.find("sensor.camera.rgb")
        rgb_cam.set_attribute("image_size_x", "320")  # عرض أقل (كان 640)
        rgb_cam.set_attribute("image_size_y", "180")  # ارتفاع أقل (كان 360)

        rgb_cam.set_attribute("fov", "90")

        cam_transform_front = carla.Transform(
            carla.Location(x=4, z=1.6), carla.Rotation(roll=0, pitch=0, yaw=0)
        )
        self.front_sensor = self.world.spawn_actor(
            rgb_cam, cam_transform_front, attach_to=self.vehicle
        )

        self.is_running_front = True
        self.front_sensor.listen(
            lambda data: self.__process_camera_frame(data, "front")
        )


    @Slot()
    def start_back_camera(self):
        if self.is_running_back:
            return

        self.stop_front_camera()
        blueprint_library = self.world.get_blueprint_library()
        rgb_cam = blueprint_library.find("sensor.camera.rgb")
        rgb_cam.set_attribute("image_size_x", "320")
        rgb_cam.set_attribute("image_size_y", "180")
        rgb_cam.set_attribute("fov", "90")

        cam_transform_back = carla.Transform(
            carla.Location(x=-4, z=1.6), carla.Rotation(roll=0, pitch=0, yaw=180)
        )
        self.back_sensor = self.world.spawn_actor(
            rgb_cam, cam_transform_back, attach_to=self.vehicle
        )

        self.is_running_back = True
        self.back_sensor.listen(
            lambda data: self.__process_camera_frame(data, "back")
        )

    @Slot()
    def fetch_vehicle_speed(self):
        if not self.vehicle:
            return

        velocity = self.vehicle.get_velocity()
        speed = (
            3.6 * (velocity.x**2 + velocity.y**2 + velocity.z**2) ** 0.5
        )  # m/s to km/h
        self.vehicle_speed_updated.emit(speed)

    def __process_camera_frame(self, data, camera_type):

        current_time = time.time()
        if current_time - self.last_frame_time < 0.2:
            return
        self.last_frame_time = current_time

        img = np.array(data.raw_data)
        img2 = img.reshape((180, 320, 4))
        img3 = img2[:, :, :3]
        img3 = np.ascontiguousarray(img3)

        q_img = QImage(img3.data, 320, 180, QImage.Format_RGB888)

        buffer = QBuffer()
        buffer.open(QBuffer.ReadWrite)
        q_img.save(buffer, "PNG")
        buffer.close()

        base64_data = QByteArray(buffer.data()).toBase64().data().decode("utf-8")
        data_url = f"data:image/png;base64,{base64_data}"

        if camera_type == "front":
            self.front_camera_frame_ready.emit(data_url)
        elif camera_type == "back":
            self.back_camera_frame_ready.emit(data_url)

    @Slot()
    def stop_front_camera(self):
        if self.is_running_front and self.front_sensor:
            self.front_sensor.stop()
            self.front_sensor.destroy()
            self.is_running_front = False
            print("Front camera stopped.")

    @Slot()
    def stop_back_camera(self):
        if self.is_running_back and self.back_sensor:
            self.back_sensor.stop()
            self.back_sensor.destroy()
            self.is_running_back = False
            print("Back camera stopped.")



if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    qmlRegisterSingletonType(QUrl.fromLocalFile("Style.qml"), "Style", 1, 0, "Style")

    qml_file = Path(__file__).resolve().parent / "main.qml"

    backend = BackendAPI()
    engine.rootContext().setContextProperty("backend", backend)


    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
