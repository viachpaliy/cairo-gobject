module Cairo
  class Device

    def finalize
      LibCairo.device_destroy(@pointer)
    end

    def reference : Device
      Device.new(LibCairo.device_reference(@pointer))
    end

    def type : DeviceType
      DeviceType.new(LibCairo.device_get_type(@pointer).value)
    end

    def status : Status
      Status.new(LibCairo.device_status(@pointer).value)
    end

    def acquire : Status
      Status.new(LibCairo.device_acquire(@pointer).value)
    end

    def release
      LibCairo.device_release(@pointer)
      self
    end

    def flush
      LibCairo.device_flush(@pointer)
      self
    end

    def finish
      LibCairo.device_finish(@pointer)
      self
    end

    def reference_count : UInt32
      LibCairo.device_get_reference_count(@pointer)
    end

    def user_data(key : LibCairo::UserDataKey) : Void*
      LibCairo.device_get_user_data(@pointer, key)
    end

    def set_user_data(key : LibCairo::UserDataKey, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.device_set_user_data(@pointer, key, user_data, destroy).value)
    end

  end
end

