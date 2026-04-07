# frozen_string_literal: true

module IpgeolocationSdk
  class ApiResponse < ValueObject
    attributes :data, :metadata
  end

  class ApiResponseMetadata < ValueObject
    attributes :credits_charged, :successful_records, :status_code, :duration_ms, :raw_headers

    def initialize(
      credits_charged: nil,
      successful_records: nil,
      status_code:,
      duration_ms:,
      raw_headers: {}
    )
      validate_optional_integer(credits_charged, "credits_charged")
      validate_optional_integer(successful_records, "successful_records")
      validate_status_code(status_code)
      validate_duration(duration_ms)

      normalized_headers = normalize_headers(raw_headers)

      super(
        credits_charged: credits_charged,
        successful_records: successful_records,
        status_code: status_code,
        duration_ms: duration_ms,
        raw_headers: normalized_headers
      )
    end

    def header_values(name)
      raise TypeError, "header name must be a string" unless name.is_a?(String)

      normalized_name = name.strip
      raise ArgumentError, "header name must not be blank" if normalized_name.empty?

      raw_headers.each do |key, values|
        return values if key.casecmp?(normalized_name)
      end

      EMPTY_HEADER_VALUES
    end

    def first_header_value(name)
      header_values(name).first
    end

    EMPTY_HEADER_VALUES = [].freeze

    private

    def validate_optional_integer(value, field)
      return if value.nil?
      raise TypeError, "#{field} must be an integer" unless value.is_a?(Integer)
      raise ArgumentError, "#{field} must be greater than or equal to zero" if value.negative?
    end

    def validate_status_code(value)
      raise TypeError, "status_code must be an integer" unless value.is_a?(Integer)
      raise ArgumentError, "status_code must be between 100 and 599" unless value.between?(100, 599)
    end

    def validate_duration(value)
      raise TypeError, "duration_ms must be an integer" unless value.is_a?(Integer)
      raise ArgumentError, "duration_ms must be greater than or equal to zero" if value.negative?
    end

    def normalize_headers(input)
      raise TypeError, "raw_headers must be a hash" unless input.is_a?(Hash)

      input.each_with_object({}) do |(key, values), result|
        next if key.nil?

        name = key.to_s
        next if name.strip.empty?
        raise TypeError, "raw_headers values must be arrays of strings" unless values.is_a?(Array)
        normalized_values = values.map do |value|
          raise TypeError, "raw_headers values must contain only strings" unless value.is_a?(String)

          value
        end
        result[name] = normalized_values.freeze
      end.freeze
    end
  end

  class Abuse < ValueObject
    attributes :route, :country, :name, :organization, :kind, :address, :emails, :phone_numbers
  end

  class Asn < ValueObject
    attributes :as_number, :organization, :country, :type, :domain, :date_allocated, :rir
  end

  class Company < ValueObject
    attributes :name, :type, :domain
  end

  class CountryMetadata < ValueObject
    attributes :calling_code, :tld, :languages
  end

  class Currency < ValueObject
    attributes :code, :name, :symbol
  end

  class DstTransition < ValueObject
    attributes :utc_time, :duration, :gap, :date_time_after, :date_time_before, :overlap
  end

  class Location < ValueObject
    attributes :continent_code, :continent_name, :country_code2, :country_code3,
               :country_name, :country_name_official, :country_capital, :state_prov,
               :state_code, :district, :city, :locality, :accuracy_radius, :confidence,
               :dma_code, :zipcode, :latitude, :longitude, :is_eu, :country_flag,
               :geoname_id, :country_emoji
  end

  class Network < ValueObject
    attributes :connection_type, :route, :is_anycast
  end

  class Security < ValueObject
    attributes :threat_score, :is_tor, :is_proxy, :proxy_provider_names,
               :proxy_confidence_score, :proxy_last_seen, :is_residential_proxy,
               :is_vpn, :vpn_provider_names, :vpn_confidence_score, :vpn_last_seen,
               :is_relay, :relay_provider_name, :is_anonymous, :is_known_attacker,
               :is_bot, :is_spam, :is_cloud_provider, :cloud_provider_name
  end

  class TimeZoneInfo < ValueObject
    attributes :name, :offset, :offset_with_dst, :current_time, :current_time_unix,
               :current_tz_abbreviation, :current_tz_full_name, :standard_tz_abbreviation,
               :standard_tz_full_name, :is_dst, :dst_savings, :dst_exists,
               :dst_tz_abbreviation, :dst_tz_full_name, :dst_start, :dst_end
  end

  class UserAgentDevice < ValueObject
    attributes :name, :type, :brand, :cpu
  end

  class UserAgentEngine < ValueObject
    attributes :name, :type, :version, :version_major
  end

  class UserAgentOperatingSystem < ValueObject
    attributes :name, :type, :version, :version_major, :build
  end

  class UserAgent < ValueObject
    attributes :user_agent_string, :name, :type, :version, :version_major,
               :device, :engine, :operating_system
  end

  class IpGeolocationResponse < ValueObject
    attributes :ip, :domain, :hostname, :location, :country_metadata, :network,
               :currency, :asn, :company, :security, :abuse, :time_zone, :user_agent
  end

  class BulkLookupSuccess < ValueObject
    attributes :data

    def success
      true
    end

    alias success? success
  end

  class BulkLookupErrorDetails < ValueObject
    attributes :message
  end

  class BulkLookupError < ValueObject
    attributes :error

    def success
      false
    end

    alias success? success
  end
end
