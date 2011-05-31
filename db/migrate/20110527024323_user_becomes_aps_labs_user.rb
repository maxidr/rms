class UserBecomesApsLabsUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :memberships

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

