# == Schema Information
#
# Table name: attachments
#
#  id                      :integer          not null, primary key
#  attachable_id           :integer
#  attachable_type         :string(255)
#  name                    :string(255)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file         :binary
#  attachment_file_size    :integer
#  reception_date          :date
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Attachment < ActiveRecord::Base
  #include Concerns::Dirtyable
  bucket_name_env = ENV['S3_BUCKET_NAME'].blank? ? ENV['URL'].to_s : ENV['S3_BUCKET_NAME'].to_s

  has_attached_file :attachment,
                    default_url: '/images/:style/missing.png',
                    styles: { thumb: '48x48>', small: '100x100>', medium: '200x200>' },
                    default_style: :small,
                    storage: :s3,
                    s3_credentials: { bucket: bucket_name_env,
                                      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
                                    },
                    s3_region: 'us-east-1',
                    s3_protocol: 'https',
                    path:  '/:id/:style/:basename.:extension'

  do_not_validate_attachment_file_type :attachment

  before_post_process :for_convert

  def for_convert
    !attachment_content_type.match(%r{\Aimage\/.*\Z}).nil?
  end

  attr_accessible :id, :attachable_id, :attachment_type,
                  :name, :reception_date, :attachment_file_name,
                  :attachment_content_type, :attachment_file_size,
                  :attachment_file, :created_at, :updated_at, :attachment,
                  :company_id

  # Belongs to
  belongs_to :attachable, polymorphic: true

  # Validations
  validates_presence_of :name, case_sensitive: false, message: 'es un dato requerido.'
  validates_attachment_presence :attachment
  validates_attachment_size :attachment, less_than: 5.megabytes

  def to_s
    "fecha: #{reception_date} file: #{attachment_file_name}"
  end
end
