require 'test_helper'

class DataImporterTest < ActiveSupport::TestCase
  test 'it should import a properly formatted tab delimited file' do
    assert_difference 'Purchase.count', 4 do
      total_amount_gross_revenue = DataImporter.import("#{Rails.root}/example_input.tab")
      assert_match total_amount_gross_revenue.to_s, '95.0'
    end
  end
end
