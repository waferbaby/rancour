# frozen_string_literal: true

module Rancour
  module Interaction
    class MessageResponse < Response
      extend Forwardable

      def_delegators :@data, :add_embed, :content=

      def initialize
        super(type: CHANNEL_MESSAGE_WITH_SOURCE, data: Message.new)
      end
    end
  end
end
