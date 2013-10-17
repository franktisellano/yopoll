class Poll < ActiveRecord::Base
  has_many :demos
  accepts_nested_attributes_for :demos
  default_scope { order('date ASC') }
end
