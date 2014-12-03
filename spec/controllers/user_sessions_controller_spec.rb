require 'spec_helper'

describe UserSessionsController, type: :controller do

  it "should create new session and user from oauth" do
    user = FactoryGirl.create(:user)
    json = File.read("spec/fixtures/omniauth_hash.json")
    hash = JSON.parse(json)
    request.env['omniauth.auth'] = hash
    xhr :post, :create_with_omniauth, hash
    expect(response).to be_success
  end

  # FIXME
  # it "should check if a user is already signed in" do
  #   xhr :get, :check
  #   expect(response).to be_success
  # end
end
