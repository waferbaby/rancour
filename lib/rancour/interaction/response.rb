# frozen_string_literal: true

module Rancour
  module Interaction
    class Response
      PONG = 1
      CHANNEL_MESSAGE_WITH_SOURCE = 4
      DEFERRED_CHANNEL_MESSAGE_WITH_SOURCE = 5
      DEFERRED_UPDATE_MESSAGE = 6
      UPDATE_MESSAGE = 7
      APPLICATION_COMMAND_AUTOCOMPLETE_RESULT = 8
      MODAL = 9
      LAUNCH_ACTIVITY = 12

      attr_accessor :type, :data

      def initialize(type:, data: nil)
        self.type = type
        self.data = data
      end

      def to_h
        {}.tap do |output|
          output[:type] = type
          output[:data] = data.to_h if data.present?
        end
      end
    end
  end
end
