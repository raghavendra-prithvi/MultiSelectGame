class Score < ActiveRecord::Base
  attr_accessible :points, :remarks, :user_id
  belongs_to :user
end
