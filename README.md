
Up-to-date fork of Antonio Tapiador's OmniAuth strategy.

## Usage

Add this gem to your Gemfile and bundle:

    gem 'omniauth-fiware', git: 'git@github.com:rin/omniauth-fiware.git'

You need to sign up for an OAuth2 client id and secret
at the [FI-WARE Lab](https://account.lab.fiware.eu).

If you are using Devise, you can add the following to config/initializers/devise.rb

    provider :fiware, <CLIENT_KEY>, <CLIENT_SECRET>