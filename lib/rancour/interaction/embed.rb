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

      %i[image thumbnail video].each do |field|
        define_method("assign_#{field}") do |url:, proxy_url: nil, width: nil, height: nil|
          @children[field] = { url: url }

          @children[field][:proxy_url] = proxy_url unless proxy_url.nil?
          @children[field][:width] = width unless width.nil?
          @children[field][:height] = height unless height.nil?
        end
      end

      def assign_author(name:, url: nil, icon_url: nil)
        @children[:author] = { name: name }
        @children[:author][:url] = url unless url.nil?
        @children[:author][:icon_url] = icon_url unless icon_url.nil?
      end

      def assign_footer(text:, icon_url: nil)
        @children[:footer] = { text: text }
        @children[:footer][:icon_url] = icon_url unless icon_url.nil?
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
