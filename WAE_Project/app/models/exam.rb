class Exam < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validate :file_pdf, :file_size_under_three_mb, :already_exist
  @basename
  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      @basename = File.extname(@file.original_filename)
      #real_file_name = sanitize_filename(file.original_filename)
      # file.original_filename = (self.id).to_s + File.extname(real_file_name)
      course_name = Course.find(params[:course_id]).coursename

      filename = params[:posttype] + "-" + course_name + "-" + params[:year].to_s + "-" + params[:examtype].to_s + "-" + params[:user_id] + ".pdf"
      self.path = filename
      @file.original_filename = filename
    end
  end


  private
  def sanitize_filename(filename)
    # Get only the filename, not the whole path (for IE)
    # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
    return File.basename(filename)
  end

  NUM_BYTES_IN_MEGABYTE = 3000000
  def file_size_under_three_mb
    if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 1
      errors.add(:file, ': the size cannot be over three megabyte.')
    end
  end

  def file_pdf
    if (@basename != ".pdf")
      errors.add(:file, ': the file upload is not a pdf')
    end
  end

  def already_exist
    if File.exist?(Rails.root.join('public', 'data', self.path))
      errors.add(:file, ': this file is already upload.')
    end
  end

end
