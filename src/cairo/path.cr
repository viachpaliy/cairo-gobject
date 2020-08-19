module Cairo
  class Path

    def finalize
      LibCairo.path_destroy(@pointer)
    end

  end
end

