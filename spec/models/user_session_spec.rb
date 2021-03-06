require 'spec_helper'

describe UserSession do

  before do
    json = File.read("spec/fixtures/omniauth_hash.json")
    @omniauth_hash = JSON.parse(json)
  end

  it 'when valid omniauth credentials then authenticate' do
    @session = UserSession.new({})
    @session.with_omniauth(@omniauth_hash)
    expect(@session.user_signed_in?).to be_truthy
  end

  it 'when user already logged in then get current user' do
    @session = UserSession.new({})
    @session.with_omniauth(@omniauth_hash)
    current_user = @session.current_user
    expect(current_user).not_to be_nil
  end
end
