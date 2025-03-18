# frozen_string_literal: true

module Rancour
  class Interaction < Response
    PING = 1
    APPLICATION_COMMAND = 2
    MESSAGE_COMPONENT = 3
    APPLICATION_COMMAND_AUTOCOMPLETE = 4
    MODAL_SUBMIT = 5

    attr_accessor :command

    private

    def process_data(data)
      self.command = ApplicationCommand.from_payload(data)
    end
  end
end
