# frozen_string_literal: true

module Rancour
  class InteractionData
    attr_accessor :id, :guild_id, :name, :options

    def self.from_payload(payload)
      new(
        id: payload['id'],
        guild_id: payload['guild_id'],
        name: payload['name'],
        options: payload['options']
      )
    end

    def initialize(id:, guild_id:, name:, options:)
      self.id = id
      self.guild_id = guild_id
      self.name = name
      self.options = []

      return if options.nil?

      self.options = options.map { |option| InteractionData.from_payload(option) }
    end
  end
end
