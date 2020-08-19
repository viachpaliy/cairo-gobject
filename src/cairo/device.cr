module Cairo

  # Devices are the abstraction Cairo employs for the rendering system used by a `Surface`.
  class Device

    def finalize
      LibCairo.device_destroy(@pointer.as(LibCairo::Device*))
    end

    # Increases the reference count on device by one.
    # Returns : the referenced Cairo::Device.
    def reference : Device
      Device.new(LibCairo.device_reference(@pointer.as(LibCairo::Device*)))
    end

    # Returns the type of the device. 
    def type : DeviceType
      DeviceType.new(LibCairo.device_get_type(@pointer.as(LibCairo::Device*)))
    end

    # Checks whether an error has previously occurred for this device.
    # Returns : Cairo::Status::SUCCESS on success or an error code if the device is in an error state.  
    def status : Status
      Status.new(LibCairo.device_status(@pointer.as(LibCairo::Device*)))
    end

    # Acquires the device for the current thread. This function will block until no other thread has acquired the device. 
    # If the return value is Cairo::Status::SUCCESS, you successfully acquired the device.
    # From now on your thread owns the device and no other thread will be able to acquire it until a matching call to `Device#release()`.
    # It is allowed to recursively acquire the device multiple times from the same thread. 
    # You must never acquire two different devices at the same time unless this is explicitly allowed. Otherwise the possibility of deadlocks exist. 
    # As various Cairo functions can acquire devices when called, these functions may also cause deadlocks when you call them with an acquired device.
    # So you must not have a device acquired when calling them. These functions are marked in the documentation.
    # After a successful call to `Device#acquire()`, a matching call to `Device#release()` is required. 
    # Returns : Cairo::Status::SUCCESS on success or an error code if the device is in an error state and could not be acquired.
    def acquire : Status
      Status.new(LibCairo.device_acquire(@pointer.as(LibCairo::Device*)))
    end

    # Releases a device previously acquired using `Device#acquire()`.
    # Returns this device.
    def release
      LibCairo.device_release(@pointer.as(LibCairo::Device*))
      self
    end

    # Finishes any pending operations for the device and also restore any temporary modifications cairo has made to the device's state.
    # This method must be called before switching from using the device with Cairo to operating on it directly with native APIs.
    # If the device doesn't support direct access, then this method does nothing. 
    # This method may acquire devices.
    # Returns this device.
    def flush
      LibCairo.device_flush(@pointer.as(LibCairo::Device*))
      self
    end

    # This function finishes the device and drops all references to external resources.
    # All surfaces, fonts and other objects created for this device will be finished, too.
    # Further operations on the device will not affect the device but will instead trigger a Cairo::Status::DEVICE_FINISHED error.
    # This method may acquire devices.
    # Returns this device.
    def finish
      LibCairo.device_finish(@pointer.as(LibCairo::Device*))
      self
    end

    # Returns the current reference count of device. If the object is a nil object, 0 will be returned.  
    def reference_count : UInt32
      LibCairo.device_get_reference_count(@pointer.as(LibCairo::Device*))
    end

    # Returns user data previously attached to device using the specified key.
    # If no user data has been attached with the given key this function returns NULL.
    # *key* : the address of the LibCairo::UserDataKey the user data was attached to .
    def user_data(key : LibCairo::UserDataKey) : Void*
      LibCairo.device_get_user_data(@pointer.as(LibCairo::Device*), key)
    end

    # Attach user data to device. To remove user data from a surface, call this function with the key that was used to set it and NULL for data.
    # *key* : the address of a LibCairo::UserDataKey to attach the user data to.
    # *user_data* :  the user data to attach to the device.
    # *destroy* : a LibCairo::DestroyFunc which will be called when the device is destroyed or when new user data is attached using the same key.
    # Returns : Cairo::Status::SUCCESS or Cairo::Status::NO_MEMORY if a slot could not be allocated for the user data.
    def set_user_data(key : LibCairo::UserDataKey, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.device_set_user_data(@pointer.as(LibCairo::Device*), key, user_data, destroy).value)
    end

  end
end

