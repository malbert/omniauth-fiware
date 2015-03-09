require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Fiware < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: "https://accounts.lab.fiware.org",
        authorize_url: 'https://accounts.lab.fiware.org/oauth2/authorize',
        token_url: 'https://accounts.lab.fiware.org/oauth2/token'
      }

      uid { raw_info['id'] }

      info do
        {
          nickname: raw_info['nickName'],
          email: raw_info['email'],
          name: raw_info['displayName']
        }
      end

      extra do
        { raw_info: raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user.json', params: { access_token: access_token.token }).parsed
      end

    end
  end
end

