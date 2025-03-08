# frozen_string_literal: true

require 'ed25519'

module Rancour
  class Webhook
    def self.validate_request(public_key:, body:, signature:, timestamp:)
      verification_key = Ed25519::VerifyKey.new([public_key].pack('H*'))
      verification_key.verify([signature].pack('H*'), "#{timestamp}#{body}")
    rescue Ed25519::VerifyError => e
      raise InvalidParamsError, e
    end
  end
end
