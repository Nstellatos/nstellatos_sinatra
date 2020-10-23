class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name 
      t.string :email 
      t.string :password_digest     #allows bcyrpt to recognize password column & encrypt it
      
      t.timestamps null: false
    end
  end
end
