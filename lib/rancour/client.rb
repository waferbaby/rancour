# frozen_string_literal: true

require 'httpx'

module Rancour
  class Client
    DISCORD_API_VERSION = 10

    def initialize(app_id:, bot_token: nil, bearer_token: nil)
      raise 'You must supply either a bot or bearer token' if bot_token.nil? && bearer_token.nil?

      @app_id = app_id

      @bot_token = bot_token if bot_token.present?
      @bearer_token = bearer_token if bearer_token.present?
    end

    def register_application_commands(payload:, guild_id: nil)
      path = '/commands'
      path = "/guilds/#{guild_id}" + path if guild_id.present?

      response = connection.post(path, json: payload)
      response.raise_for_status

      response.json
    end

    private

    def connection
      @connection ||= HTTPX.with(
        origin: 'https://discord.com',
        base_path: "/api/v#{DISCORD_API_VERSION}/applications/#{@app_id}",
        headers: {
          authorization: authorization_header
        }
      )
    end

    def authorization_header
      return "Bearer #{@bearer_token}" if @bearer_token.present?

      "Bot #{@bot_token}"
    end
  end
end
