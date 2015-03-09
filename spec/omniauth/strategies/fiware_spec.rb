require 'spec_helper'

describe OmniAuth::Strategies::Fiware do
  let(:access_token) { double('AccessToken', options: {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', parsed: parsed_response) }

  let(:other_site)          { 'https://some.other.site.com' }
  let(:other_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
  let(:other_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
  let(:other) do
    OmniAuth::Strategies::OAuth2.new('CLIENT_KEY', 'CLIENT_SECRET',
        {
          client_options: {
            site: other_site,
            authorize_url: other_authorize_url,
            token_url: other_token_url
          }
        }
    )
  end

  subject do
    OmniAuth::Strategies::Fiware.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq("https://accounts.lab.fiware.org")
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://accounts.lab.fiware.org/oauth2/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://accounts.lab.fiware.org/oauth2/token')
    end

    describe "should be overrideable" do
      it "for site" do
        expect(other.options.client_options.site).to eq other_site
      end

      it "for authorize url" do
        expect(other.options.client_options.authorize_url).to eq other_authorize_url
      end

      it "for token url" do
        expect(other.options.client_options.token_url).to eq other_token_url
      end
    end
  end

  context "#raw_info" do
    it "should use relative paths" do
      expect(access_token).to receive(:token)
      expect(access_token).to receive(:get).with('user.json', { params: { access_token: nil } }).and_return(response)
      expect(subject.raw_info).to eq parsed_response
    end
  end
end
