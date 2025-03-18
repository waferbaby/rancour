# frozen_string_literal: true

module Rancour
  class InteractionData
    attr_accessor :name, :type, :value, :focused, :options

    def self.from_payload(payload)
      new(
        name: payload['name'],
        type: payload['type'],
        value: payload['value'],
        focused: payload['focused'],
        options: payload['options']
      )
    end

    def initialize(name:, type:, value:, focused: false, options: [])
      self.name = name
      self.type = type
      self.value = value
      self.focused = focused
      self.options = []

      return if options.nil?

      self.options = options.map { |option| self.class.from_payload(option) }
    end

    def focused_option
      options&.select(&:focused)&.first
    end
  end
end
