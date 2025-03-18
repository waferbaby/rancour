# frozen_string_literal: true

module Rancour
  module Interaction
    class Choices < Array
      def add(name:, value:)
        self << Choice.new(name: name, value: value)
      end

      def to_h
        { choices: map(&:to_h) }
      end
    end

    class Choice
      attr_accessor :name, :value

      def initialize(name:, value:)
        self.name = name
        self.value = value
      end

      def to_h
        { name: name, value: value }
      end
    end
  end
end
