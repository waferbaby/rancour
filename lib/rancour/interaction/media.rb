# frozen_string_literal: true

module Rancour
  module Interaction
    class Media
      attr_accessor :url, :proxy_url, :width, :height

      def initialize(url:, proxy_url: nil, width: nil, height: nil)
        self.url = url
        self.proxy_url = proxy_url
        self.width = width
        self.height = height
      end

      def to_h
        { url: url }.tap do |output|
          output.proxy_url = proxy_url unless proxy_url.nil?
          output.width = width unless width.nil?
          output.height = height unless height.nil?
        end
      end
    end

    class Thumbnail < Media; end
    class Image < Media; end
    class Video < Media; end
  end
end
