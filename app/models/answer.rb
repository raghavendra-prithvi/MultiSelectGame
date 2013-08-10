class Answer < ActiveRecord::Base
  attr_accessible :ans, :question_id
  belongs_to :answers 
end
