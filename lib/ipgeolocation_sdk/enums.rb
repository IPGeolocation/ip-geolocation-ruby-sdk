# frozen_string_literal: true

module IpgeolocationSdk
  module Language
    EN = "en"
    DE = "de"
    RU = "ru"
    JA = "ja"
    FR = "fr"
    CN = "cn"
    ES = "es"
    CS = "cs"
    IT = "it"
    KO = "ko"
    FA = "fa"
    PT = "pt"

    VALUES = [
      EN, DE, RU, JA, FR, CN, ES, CS, IT, KO, FA, PT
    ].freeze

    module_function

    def from_code(code)
      normalized = normalize_token(code, "code")
      value = VALUES.find { |item| item.casecmp?(normalized) }
      raise ValidationError, "Unsupported language code: #{code}" if value.nil?

      value
    end

    def valid?(code)
      VALUES.any? { |item| item.casecmp?(code.to_s.strip) }
    end

    def normalize(value)
      return nil if value.nil?

      from_code(value)
    end

    def normalize_token(value, field)
      raise TypeError, "#{field} must be a string or symbol" unless value.is_a?(String) || value.is_a?(Symbol)

      normalized = value.to_s.strip
      raise ValidationError, "#{field} must not be blank" if normalized.empty?

      normalized
    end
    private_class_method :normalize_token
  end

  module ResponseFormat
    JSON = "json"
    XML = "xml"

    VALUES = [JSON, XML].freeze

    module_function

    def normalize(value)
      return JSON if value.nil?
      raise TypeError, "output must be a string or symbol" unless value.is_a?(String) || value.is_a?(Symbol)

      normalized = value.to_s.strip.downcase
      return normalized if VALUES.include?(normalized)

      raise ValidationError, "output must be either 'json' or 'xml'"
    end
  end

  module JsonOutputMode
    COMPACT = "compact"
    FULL = "full"

    VALUES = [COMPACT, FULL].freeze

    module_function

    def normalize(value)
      return COMPACT if value.nil?
      raise TypeError, "mode must be a string or symbol" unless value.is_a?(String) || value.is_a?(Symbol)

      normalized = value.to_s.strip.downcase
      return normalized if VALUES.include?(normalized)

      raise ValidationError, "mode must be either 'compact' or 'full'"
    end
  end

  module LocationConfidence
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"
    UNKNOWN = "unknown"

    VALUES = [HIGH, MEDIUM, LOW, UNKNOWN].freeze

    module_function

    def normalize(value)
      return nil if value.nil?

      normalized = value.to_s.strip.downcase
      return normalized if VALUES.include?(normalized)

      UNKNOWN
    end
  end
end
