module Tabl
  module Formats
    @@formats = {}

    def self.register(key, mod)
      @@formats[key] = mod
    end

    def self.exist?(key)
      @@formats.exist?(key)
    end

    def self.method_missing(key, *args)
      @@formats[key] || super
    end

    def self.[](key)
      @@formats[key]
    end
  end
end

