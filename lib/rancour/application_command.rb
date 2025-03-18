# frozen_string_literal: true

module Rancour
  class ApplicationCommand
    SUB_COMMAND	= 1
    SUB_COMMAND_GROUP =	2
    STRING = 3
    INTEGER = 4
    BOOLEAN = 5
    USER = 6
    CHANNEL = 7
    ROLE = 8
    MENTIONABLE = 9
    NUMBER = 10
    ATTACHMENT = 11

    attr_accessor :id, :guild_id, :name, :value, :options

    def self.from_payload(payload)
      new(
        id: payload['id'],
        guild_id: payload['guild_id'],
        name: payload['name'],
        value: payload['value'],
        options: payload['options']
      )
    end

    def initialize(id:, guild_id:, name:, value:, options:)
      self.id = id
      self.guild_id = guild_id
      self.name = name
      self.value = value
      self.options = []

      return if options.nil?

      self.options = options.map { |option| InteractionData.from_payload(option) }
    end
  end
end
