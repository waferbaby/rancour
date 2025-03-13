# frozen_string_literal: true

module Rancour
  class User
    attr_accessor :id,
                  :username,
                  :global_name,
                  :discriminator,
                  :avatar_url

    def self.from_payload(payload)
      new.tap do |user|
        %w[id username global_name discriminator].each do |field|
          user.send("#{field}=", payload[field])
        end

        user.avatar_url = Images.user_avatar_url(payload['id'], payload['avatar'])
      end
    end
  end
end
