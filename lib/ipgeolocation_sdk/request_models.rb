# frozen_string_literal: true

module IpgeolocationSdk
  class LookupIpGeolocationRequest < ValueObject
    attributes :ip, :lang, :include, :fields, :excludes, :user_agent, :headers, :output

    def initialize(
      ip: nil,
      lang: nil,
      include: nil,
      fields: nil,
      excludes: nil,
      user_agent: nil,
      headers: nil,
      output: ResponseFormat::JSON
    )
      normalized_ip = self.class.send(:normalize_ip, ip)
      normalized_lang = Language.normalize(lang)
      normalized_include = self.class.send(:normalize_tokens, include, "include")
      normalized_fields = self.class.send(:normalize_tokens, fields, "fields")
      normalized_excludes = self.class.send(:normalize_tokens, excludes, "excludes")
      normalized_user_agent = self.class.send(:normalize_optional_string, user_agent, "user_agent")
      normalized_headers = self.class.send(:normalize_headers, headers)
      normalized_output = ResponseFormat.normalize(output)

      super(
        ip: normalized_ip,
        lang: normalized_lang,
        include: normalized_include,
        fields: normalized_fields,
        excludes: normalized_excludes,
        user_agent: normalized_user_agent,
        headers: normalized_headers,
        output: normalized_output
      )
    end
  end

  class BulkLookupIpGeolocationRequest < ValueObject
    attributes :ips, :lang, :include, :fields, :excludes, :user_agent, :headers, :output

    def initialize(
      ips:,
      lang: nil,
      include: nil,
      fields: nil,
      excludes: nil,
      user_agent: nil,
      headers: nil,
      output: ResponseFormat::JSON
    )
      normalized_ips = self.class.send(:normalize_tokens, ips, "ips")
      raise ValidationError, "ips must not be empty" if normalized_ips.empty?
      raise ValidationError, "ips must contain at most 50000 entries" if normalized_ips.length > 50_000

      normalized_lang = Language.normalize(lang)
      normalized_include = self.class.send(:normalize_tokens, include, "include")
      normalized_fields = self.class.send(:normalize_tokens, fields, "fields")
      normalized_excludes = self.class.send(:normalize_tokens, excludes, "excludes")
      normalized_user_agent = self.class.send(:normalize_optional_string, user_agent, "user_agent")
      normalized_headers = self.class.send(:normalize_headers, headers)
      normalized_output = ResponseFormat.normalize(output)

      super(
        ips: normalized_ips,
        lang: normalized_lang,
        include: normalized_include,
        fields: normalized_fields,
        excludes: normalized_excludes,
        user_agent: normalized_user_agent,
        headers: normalized_headers,
        output: normalized_output
      )
    end
  end

  class << LookupIpGeolocationRequest
    private

    def normalize_ip(value)
      return nil if value.nil?
      raise TypeError, "ip must be a string" unless value.is_a?(String)

      normalized = value.strip
      raise ValidationError, "ip must not be blank" if normalized.empty?

      normalized
    end

    def normalize_optional_string(value, field)
      return nil if value.nil?
      raise TypeError, "#{field} must be a string" unless value.is_a?(String)

      normalized = value.strip
      raise ValidationError, "#{field} must not be blank" if normalized.empty?
      normalized
    end

    def normalize_tokens(values, field)
      return [].freeze if values.nil?
      raise ValidationError, "#{field} must be an array of strings, not a single string" if values.is_a?(String)
      raise TypeError, "#{field} must be an array of strings" unless values.is_a?(Array)

      normalized = values.map do |value|
        raise TypeError, "#{field} values must be strings" unless value.is_a?(String)

        token = value.strip
        raise ValidationError, "#{field} values must not be blank" if token.empty?

        token
      end
      normalized.freeze
    end

    def normalize_headers(value)
      return {}.freeze if value.nil?
      raise TypeError, "headers must be a hash" unless value.is_a?(Hash)

      value.each_with_object({}) do |(raw_name, raw_value), result|
        raise TypeError, "header names must be strings" unless raw_name.is_a?(String)

        name = raw_name.strip
        raise ValidationError, "header names must not be blank" if name.empty?
        raise ValidationError, "header names must not contain CR or LF" if contains_cr_or_lf?(name)

        values = normalize_header_values(raw_value)
        result[name] = values.freeze
      end.freeze
    end

    def normalize_header_values(value)
      raw_values =
        case value
        when String
          [value]
        when Array
          value
        else
          raise TypeError, "header values must be strings or arrays of strings"
        end

      raise ValidationError, "header values must not be empty" if raw_values.empty?

      raw_values.map do |item|
        raise TypeError, "header values must contain only strings" unless item.is_a?(String)

        normalized = item.strip
        raise ValidationError, "header values must not contain blank strings" if normalized.empty?
        raise ValidationError, "header values must not contain CR or LF" if contains_cr_or_lf?(normalized)

        normalized
      end
    end

    def contains_cr_or_lf?(value)
      value.include?("\r") || value.include?("\n")
    end
  end

  class << BulkLookupIpGeolocationRequest
    private

    def normalize_optional_string(value, field)
      LookupIpGeolocationRequest.send(:normalize_optional_string, value, field)
    end

    def normalize_tokens(values, field)
      LookupIpGeolocationRequest.send(:normalize_tokens, values, field)
    end

    def normalize_headers(value)
      LookupIpGeolocationRequest.send(:normalize_headers, value)
    end
  end
end
