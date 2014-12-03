class Cost < ActiveRecord::Base

def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    cost = find_by_id(row["id"]) || new
    cost.attributes = row.to_hash.slice(*accessible_attributes)
    cost.save!
  end
end

# def self.import(file)
#     file.readlines.each_with_index do |line, index|
#       next if index.zero?
#       lines = line.split(/\t/)
#       create! do |po|
#         po.purchaser_name   = lines[0]
#         po.item_description = lines[1]
#         po.item_price       = lines[2].to_f
#         po.purchase_count   = lines[3].to_i
#         po.merchant_address = lines[4]
#         po.merchant_name    = lines[5]
#       end
#     end
#   end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".tab" then Csv.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end

end
