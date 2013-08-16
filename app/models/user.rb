class User < ActiveRecord::Base
  attr_accessible :email, :img, :name, :uid
  def self.create_login(auth)
    @user = User.new
    @user.img = auth["info"]["image"]
    @user.uid = auth["uid"]
    @user.name = auth["info"]["name"]
    @user.email = auth["info"]["email"]
    @user.save!
  end
end
