class Poll < ActiveRecord::Base
  has_many :demos
  default_scope order('date ASC')
end
