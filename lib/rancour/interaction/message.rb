# frozen_string_literal: true

module Rancour
  module Interaction
    class Message
      attr_accessor :tts, :content, :embeds, :flags

      def initialize(tts: false, content: nil, flags: 0)
        self.tts = tts
        self.content = content
        self.flags = flags
        self.embeds = []
      end

      def add_embed(embed)
        raise "A message can't have more than 10 embeds" if embeds.count == 10

        embeds << embed
      end

      def to_h
        {}.tap do |output|
          output[:tts] = tts unless tts.nil?
          output[:content] = content unless content.nil?
          output[:flags] = flags.to_s(2) unless flags.nil?
          output[:embeds] = embeds&.map(&:to_h) unless embeds.nil?
        end
      end
    end
  end
end
