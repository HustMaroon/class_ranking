class ScoringRecord < ApplicationRecord
  belongs_to :user
  belongs_to :klass
  validates :attendees, :cleaness, :clothing, :outdoor_act, numericality: { greater_than_or_equal_to: 0, less_than: 25 }
  validate :user_must_be_assessor
  validates_uniqueness_of :klass_id, scope: :assessment_date, message: 'Lớp đã được chấm điểm'
  validate :not_allow_weekend_scoring

  private
  def user_must_be_assessor
    errors.add(:base, 'Chỉ cờ đỏ được chấm điểm') unless user.assessor?
  end

  def not_allow_weekend_scoring
    errors.add(:base, 'Không thể chấm điểm cho Chủ Nhật') if assessment_date.wday == 0
  end
end
