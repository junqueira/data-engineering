class Attachment
  DIR = 'public/attachments'
  attr_reader :file

  def initialize(uploaded_file)
    @uploaded_file = uploaded_file
  end

  def create
    Dir.mkdir Attachment::DIR unless Dir.exist? Attachment::DIR
    @file = Rails.root.join(Attachment::DIR, @uploaded_file.original_filename + '-' + Time.new.to_formatted_s(:number))
    File.open(@file, 'wb') do |file|
      file.write(@uploaded_file.read)
    end
  end
end
