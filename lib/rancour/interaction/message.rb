# frozen_string_literal: true

module Rancour
  module Interaction
    class Message
      attr_accessor :tts, :content, :embeds

      def initialize(tts: false, content: nil)
        self.tts = tts
        self.content = content
        self.embeds = []
      end

      def add_embed(embed)
        raise "A message can't have more than 10 embeds" if embeds.count == 10

        embeds << embed
      end
    end
  end
end
