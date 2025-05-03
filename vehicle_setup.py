import carla
import random
import time

def setup_vehicle(world):
    """
    يقوم بإنشاء مركبة في محاكاة CARLA. إذا لم ينجح النشر، يحاول مرة أخرى في موقع مختلف.
    """
    blueprint_library = world.get_blueprint_library()
    vehicle_bp = blueprint_library.find('vehicle.tesla.model3')  # اختيار نوع السيارة

    spawn_points = world.get_map().get_spawn_points()

    if not spawn_points:
        raise RuntimeError("No spawn points available in the map!")

    # محاولة نشر السيارة حتى 5 مرات
    max_attempts = 5
    vehicle = None
    for _ in range(max_attempts):
        spawn_point = random.choice(spawn_points)  # اختيار موقع عشوائي
        vehicle = world.try_spawn_actor(vehicle_bp, spawn_point)
        if vehicle:
            print(f"✅ Vehicle spawned at: {spawn_point.location}")
            break
        else:
            print("⚠️ Failed to spawn vehicle, retrying...")
            time.sleep(1)  # انتظار قبل المحاولة مجددًا

    if not vehicle:
        raise RuntimeError("❌ Failed to spawn vehicle after multiple attempts!")

    return vehicle

def move_vehicle(vehicle):
    """
    يحرك السيارة للأمام.
    """
    control = carla.VehicleControl(throttle=0.5, steer=0.0)
    vehicle.apply_control(control)

