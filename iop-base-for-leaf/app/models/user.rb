class User < ApplicationRecord
  rolify

  enum site_role: [:user, :superuser, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.site_role ||= :user
  end

  has_many :owned_groups, class_name: "Group", foreign_key: :owner_id
  has_many :group_members
  has_many :groups, through: :group_members


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :access_grants,
            class_name: 'Doorkeeper::AccessGrant',
            foreign_key: :resource_owner_id,
            dependent: :delete_all # or :destroy if you need callbacks

   has_many :access_tokens,
            class_name: 'Doorkeeper::AccessToken',
            foreign_key: :resource_owner_id,
            dependent: :delete_all # or :destroy if you need callbacks

    has_many :matches,
              class_name: "Match",
              foreign_key: :user_id
end
