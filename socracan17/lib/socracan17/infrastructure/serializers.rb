require 'oj'

module SocraCan17
  module Infrastructure
    class JSONSerializer
      def serialize(object)
        Oj.dump(object)
      end

      def deserialize(raw)
        Oj.load(raw)
      end
    end
  end
end
