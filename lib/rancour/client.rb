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

    def fetch_application_commands(guild_id: nil)
      get(commands_path(guild_id: guild_id))
    end

    def register_application_commands(payload, guild_id: nil)
      post(commands_path(guild_id: guild_id), params: payload)
    end

    def delete_application_command(command_id, guild_id: nil)
      delete(commands_path(guild_id: guild_id) + command_id)
    end

    private

    def commands_path(guild_id: nil)
      "#{"/guides/#{guild_id}" if guild_id.present?}/commands/"
    end

    def get(endpoint)
      process_response(http_client.get(endpoint, headers: { 'content-type': 'application/json' }))
    end

    def post(endpoint, params: {})
      process_response(http_client.post(endpoint, json: params))
    end

    def patch(endpoint, params: {})
      process_response(http_client.put(endpoint, json: params))
    end

    def delete(endpoint)
      puts "I am sending a delete to #{endpoint}"
      process_response(http_client.delete(endpoint))
    end

    def http_client
      @http_client ||= HTTPX.with(
        origin: 'https://discord.com',
        base_path: "/api/v#{DISCORD_API_VERSION}/applications/#{@app_id}",
        headers: {
          authorization: authorization_header
        }
      )
    end

    def process_response(response)
      response.raise_for_status
      response.json
    rescue HTTPX::TimeoutError, HTTPX::ResolveError => e
      raise RequestError, e.message
    rescue HTTPX::HTTPError => e
      handle_api_error(e)
    end

    def handle_api_error(error)
      klass = case error.response.status
              when 400..499 then RequestError
              when 500..599 then ResponseError
              else Error
              end

      raise klass || Error, error.response.json['message']
    end

    def authorization_header
      return "Bearer #{@bearer_token}" if @bearer_token.present?

      "Bot #{@bot_token}"
    end
  end
end
