# frozen_string_literal: true

module Rancour
  module Interaction
    class Request
      PING = 1
      APPLICATION_COMMAND = 2
      MESSAGE_COMPONENT = 3
      APPLICATION_COMMAND_AUTOCOMPLETE = 4
      MODAL_SUBMIT = 5

      attr_accessor :application_id,
                    :context,
                    :command,
                    :component,
                    :modal_submission,
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

      def process_data(data)
        case type
        when APPLICATION_COMMAND, APPLICATION_COMMAND_AUTOCOMPLETE
          self.command = ApplicationCommand.from_payload(data)
        end
      end
    end
  end
end
