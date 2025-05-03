import carla

def setup_cameras(world, vehicle):
    """
    يقوم بإنشاء ثلاث كاميرات وربطها بالمركبة، مع ضبط زوايا المرايا الجانبية بشكل صحيح.
    """
    blueprint_library = world.get_blueprint_library()

    # إعدادات الكاميرا الأمامية
    front_camera_bp = blueprint_library.find('sensor.camera.rgb')
    front_camera_bp.set_attribute('image_size_x', '800')
    front_camera_bp.set_attribute('image_size_y', '600')
    front_camera_bp.set_attribute('fov', '90')  # زاوية رؤية مناسبة
    front_camera_bp.set_attribute('sensor_tick', '0.1')  # تحديث سريع

    cameras = []

    # الكاميرا الأمامية
    front_transform = carla.Transform(carla.Location(x=2.0, z=1.5))  # أمام السيارة مباشرة
    front_camera = world.spawn_actor(front_camera_bp, front_transform, attach_to=vehicle)
    cameras.append(front_camera)

    # إعداد الكاميرا الجانبية اليسرى
    left_camera_bp = blueprint_library.find('sensor.camera.rgb')  # استدعاء blueprint جديد
    left_camera_bp.set_attribute('image_size_x', '800')
    left_camera_bp.set_attribute('image_size_y', '600')
    left_camera_bp.set_attribute('fov', '90')
    left_camera_bp.set_attribute('sensor_tick', '0.1')

    left_transform = carla.Transform(
        carla.Location(x=-0.3, y=-1.2, z=1.4),  # موقع المرآة اليسرى
        carla.Rotation(pitch=0, yaw=-120, roll=0)  # توجيه الكاميرا نحو السيارة
    )
    left_camera = world.spawn_actor(left_camera_bp, left_transform, attach_to=vehicle)
    cameras.append(left_camera)

    # إعداد الكاميرا الجانبية اليمنى
    right_camera_bp = blueprint_library.find('sensor.camera.rgb')  # استدعاء blueprint جديد
    right_camera_bp.set_attribute('image_size_x', '800')
    right_camera_bp.set_attribute('image_size_y', '600')
    right_camera_bp.set_attribute('fov', '90')
    right_camera_bp.set_attribute('sensor_tick', '0.1')

    right_transform = carla.Transform(
        carla.Location(x=-0.3, y=1.2, z=1.4),  # موقع المرآة اليمنى
        carla.Rotation(pitch=0, yaw=120, roll=0)  # توجيه الكاميرا نحو السيارة
    )
    right_camera = world.spawn_actor(right_camera_bp, right_transform, attach_to=vehicle)
    cameras.append(right_camera)

    return cameras

