class User < ActiveRecord::Base 
    has_secure_password         #allows us to use AR authenticate method/makes sure it is a correct password
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    
    
    has_many :positive_posts
end 