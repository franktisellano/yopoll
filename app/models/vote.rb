class Vote < ActiveRecord::Base
  belongs_to :demo
  validates_uniqueness_of :from, scope: :demo_id
end
