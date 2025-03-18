# frozen_string_literal: true

module Rancour
  class Response
    attr_accessor :application_id,
                  :context,
                  :data,
                  :guild,
                  :locale,
                  :token,
                  :type,
                  :user,
                  :version

    def self.from_payload(payload)
      new.tap do |response|
        %w[application_id context locale token type version].each do |field|
          response.send("#{field}=", payload[field])
        end

        response.guild = Guild.from_payload(payload['guild'])
        response.user = User.from_payload(payload.dig('member', 'user'))

        response.send(:process_data, payload['data'])
      end
    end

    private

    def process_data(_data)
      raise 'Not implemented'
    end
  end
end
