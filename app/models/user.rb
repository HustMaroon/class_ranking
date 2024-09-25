class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:assessor, :mod, :admin]
  has_many :scoring_records

  validates_uniqueness_of :email

  def role_to_s
    case role
    when 'assessor'
      "Cờ đỏ"
    when 'mod'
      "Liên đội trưởng"
    else
      "Admin"
    end
  end
end
