# frozen_string_literal: true

module Rancour
  module Interaction
    class Embed
      RICH = 'rich'
      IMAGE = 'image'
      VIDEO = 'video'
      GIFV = 'gifv'
      ARTICLE = 'article'
      LINK = 'link'
      POLL_RESULT = 'poll_result'

      attr_accessor :title,
                    :type,
                    :description,
                    :url,
                    :timestamp,
                    :colour

      def initialize(title: nil, description: nil, url: nil, type: RICH, timestamp: nil)
        self.title = title
        self.description = description
        self.url = url
        self.type = type
        self.timestamp = timestamp

        @children = {}
      end

      %i[footer image thumbnail video provider author fields].each do |field|
        define_method("#{field}=") { |value| @children[field] = value }
        define_method(field) { @children[field] }
      end

      def to_h
        {}.tap do |output|
          output[:title] = title unless title.nil?
          output[:description] = description unless description.nil?
          output[:url] = url unless url.nil?
          output[:color] = colour unless colour.nil?

          @children&.each { |type, entry| output[type] = entry.to_h }
        end
      end
    end
  end
end
