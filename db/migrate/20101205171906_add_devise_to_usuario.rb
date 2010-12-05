class AddDeviseToUsuario < ActiveRecord::Migration
  def self.up
  	change_table :usuarios do |t|
			t.database_authenticatable :null => false
			# t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

  	end
  end

  def self.down
  	drop_column :usuarios, :database_authenticatable
  	drop_column :usuarios, :recoverable
  	drop_column :usuarios, :rememberable
  	drop_column :usuarios, :trackable
  end
end

