require 'spec_helper'

describe PurchaseOrdersController, type: :controller do

  it 'should return a purchase orders collection' do
    xhr :get, :index
    expect(response).to be_success
  end

  it 'should successfully upload file' do
    filepath = Rack::Test::UploadedFile.new(['spec/fixtures/example_input.tab-20141119001757'].join('/'))
    xhr :post, :upload, { upload: filepath }
    expect(PurchaseOrder.count).to eq(4)
  end
end
