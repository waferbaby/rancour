# frozen_string_literal: true

module Rancour
  module Interaction
    class ChoicesResponse < Response
      def initialize
        super(type: APPLICATION_COMMAND_AUTOCOMPLETE_RESULT, data: Choices.new)
      end

      def add_choice(name:, value:)
        data.add(name: name, value: value)
      end
    end
  end
end
