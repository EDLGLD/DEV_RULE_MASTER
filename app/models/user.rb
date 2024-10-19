class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { general: 0, admin: 1, leader: 2 }

  has_many :rule_requests, dependent: :destroy
  has_many :team_names_users
  has_many :team_names, through: :team_names_users

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :role, presence: true, inclusion: { in: roles.keys }

  scope :admins, -> { where(role: :admin) }
end
