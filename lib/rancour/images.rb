# frozen_string_literal: true

module Rancour
  class Images
    class << self
      BASE_URL = 'https://cdn.discordapp.com'

      def image_url(path, format: 'png')
        "#{BASE_URL}/#{path}.#{format}"
      end

      def user_avatar_url(user_id, user_avatar, format: 'png')
        image_url("avatars/#{user_id}/#{user_avatar}", format: format)
      end
    end
  end
end
