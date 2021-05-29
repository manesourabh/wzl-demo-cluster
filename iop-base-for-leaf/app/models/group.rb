class Group < ApplicationRecord
  resourcify
  belongs_to :owner, class_name: "User"
  has_many :group_member, dependent: :destroy
  has_many :users, through: :group_member
  has_many :tables, class_name: "DataOwner"
  validates :owner_id, presence: true
  validates :name, presence: true
  has_many :group_roles
end
