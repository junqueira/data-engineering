require 'spec_helper'

describe PurchaseOrder do

  before do
    @file = File.open("spec/fixtures/example_input.tab-20141119001757")
  end

  it 'when valid file then create purchase order' do
    PurchaseOrder.import(@file)
    expect(PurchaseOrder.count).to eq(4)
  end
end
