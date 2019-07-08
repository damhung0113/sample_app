class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.references :micropost, foreign_key: true
      t.string :photos
      t.timestamps
    end
  end
end
