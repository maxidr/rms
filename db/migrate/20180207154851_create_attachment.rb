class CreateAttachment < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.string :name
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.binary :attachment_file
      t.integer :attachment_file_size
      t.integer :attachment_type_id
      t.date :reception_date
      t.integer :company_id

      t.timestamps
    end
  end
end
