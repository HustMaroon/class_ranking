class ScoringRecord < ApplicationRecord
  belongs_to :user
  belongs_to :klass
  enum criteria: [:attendees, :cleaness, :clothing, :outdoor_act]
end
