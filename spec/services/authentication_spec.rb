require 'spec_helper'

describe Authentication do

  before do
    json = File.read("spec/fixtures/omniauth_hash.json")
    @omniauth_hash = JSON.parse(json)
    @user = FactoryGirl.create(:user)
  end

  it 'when valid omniauth credentials then authenticate from hash' do
    auth = Authentication.new(@omniauth_hash)
    expect(auth.user.email).to eq(@omniauth_hash['info']['email'])
  end
end
