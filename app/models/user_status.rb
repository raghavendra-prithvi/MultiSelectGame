class UserStatus < ActiveRecord::Base
  attr_accessible :buyed, :invited, :right_answers, :shared_on_fb, :wrong_answers
  belongs_to :user
end
