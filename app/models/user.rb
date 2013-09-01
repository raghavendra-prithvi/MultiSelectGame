class User < ActiveRecord::Base
  has_merit

  attr_accessible :email, :img, :name, :uid
  has_many :scores
  has_one :user_status
  def self.create_login(auth)
    @user = User.new
    @user.img = auth["info"]["image"]
    @user.uid = auth["uid"]
    @user.name = auth["info"]["name"]
    @user.email = auth["info"]["email"]
    @user.save!
  end
end
