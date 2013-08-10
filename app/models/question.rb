class Question < ActiveRecord::Base
  attr_accessible :ans, :img_url
  has_many :answers

  def previous(offset = 0)
    self.class.first(:conditions => ['id < ?', self.id], :limit => 1, :offset => offset, :order => "id DESC")
  end

  def next(offset = 0)
    self.class.first(:conditions => ['id > ?', self.id], :limit => 1, :offset => offset, :order => "id ASC")
  end

end
