class Demo < ActiveRecord::Base
  belongs_to :team
  belongs_to :poll
  has_many :votes
end
