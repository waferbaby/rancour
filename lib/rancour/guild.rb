# frozen_string_literal: true

module Rancour
  class Guild
    attr_accessor :id, :locale, :features

    def self.from_payload(payload)
      new(
        id: payload['id'],
        locale: payload['locale'],
        features: payload['features']
      )
    end

    def initialize(id:, locale:, features: [])
      self.id = id
      self.locale = locale
      self.features = features
    end
  end
end
