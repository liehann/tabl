module Tabl
  module Formats
    module Html
      Formats.register(:html, Html)

      def self.default_value
        '-'
      end

      def self.format(value)
        ERB::Util.h(value)
      end

    end
  end
end

