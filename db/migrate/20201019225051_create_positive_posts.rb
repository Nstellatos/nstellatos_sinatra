class CreatePositivePosts < ActiveRecord::Migration
  def change
    create_table :positive_posts do |t|
      t.string :content 
      t.integer :user_id 


      t.timestamps null: false    #gives timestamps when we create or update model
    end
  end
end
