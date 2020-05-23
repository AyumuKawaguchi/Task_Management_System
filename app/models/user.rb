class User < ApplicationRecord
  has_secure_password
  # パスワードをdigest生成するためのGEMである'bcrypt'を導入した際に書く

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :tasks
end
