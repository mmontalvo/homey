class Project < ApplicationRecord
  enum status: { active: 0, closed: 1, archived: 2 }

  has_many :messages
  has_many :audits

  validates :title, presence: true
end
