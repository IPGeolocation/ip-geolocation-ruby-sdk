# frozen_string_literal: true

module IpgeolocationSdk
  class ValueObject
    class << self
      def attributes(*names)
        @attribute_names = names.map(&:to_sym).freeze
        attr_reader(*@attribute_names)
      end

      def attribute_names
        @attribute_names || []
      end
    end

    def initialize(**attributes)
      unknown = attributes.keys.map(&:to_sym) - self.class.attribute_names
      raise ArgumentError, "unknown attributes: #{unknown.join(', ')}" unless unknown.empty?

      self.class.attribute_names.each do |name|
        instance_variable_set(:"@#{name}", self.class.send(:normalize_value, attributes.fetch(name, nil)))
      end

      freeze
    end

    def ==(other)
      other.instance_of?(self.class) && self.class.attribute_names.all? do |name|
        public_send(name) == other.public_send(name)
      end
    end

    alias eql? ==

    def hash
      self.class.attribute_names.map { |name| public_send(name) }.hash
    end

    def to_h(mode: JsonOutputMode::COMPACT)
      Serde.to_plain_data(self, mode)
    end

    class << self
      private

      def normalize_value(value)
        case value
        when Array
          value.map { |item| normalize_value(item) }.freeze
        when Hash
          value.each_with_object({}) do |(key, item), result|
            result[key] = normalize_value(item)
          end.freeze
        else
          value
        end
      end
    end
  end
end
