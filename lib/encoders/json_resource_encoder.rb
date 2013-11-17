module Lib
  module Encoders
    class JsonResourceEncoder
      def self.encode(obj)
        if obj.respond_to? :attributes
          return encode_obj obj
        end
        obj.to_json
      end

      def self.encode_obj(obj)
        hash = obj.attributes
        if obj.respond_to?(:errors) && obj.errors.respond_to?(:any?) && obj.errors.any?
          hash.merge!({ errors: obj.errors })
        end
        hash.to_json
      end
    end
  end
end
