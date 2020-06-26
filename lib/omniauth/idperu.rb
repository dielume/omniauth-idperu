require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Idperu < OmniAuth::Strategies::OAuth2
      option :name, "idperu"

      option :client_options, {site: "https://idaas.reniec.gob.pe/service",
                               authorize_url: 'auth',
                              token_url: 'token' }

      uid{ raw_info['id'] }

      info do
        {
          doc: raw_info['doc'],
          first_name: raw_info['first_name']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('userinfo').parsed
      end
    end
  end
end