class User < ApplicationRecord
  enum role: {user: 0, admin: 1}, _default: :user

  before_validation :set_user_role
  validates :name, :cpf , presence: true
  validates :cpf, uniqueness: true

  validate :cpf_must_be_valid
  #Ex:- :default =>''
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def set_user_role
    if email.match(/^[a-zA-Z0-9._%+-]+@leilaodogalpao\.com\.br$/)
      self.role = :admin
    end
  end

  def cpf_must_be_valid
    if self.cpf.present? && !cpf_valid?
      errors.add(:cpf, I18n.t("errors.messages.invalid") )
    end
  end

  def cpf_valid?
    if self.cpf.size != 11 || self.cpf.chars.uniq.size == 1
      return false
    end

    identifiers = self.cpf[-2..]
    calculated_identifiers = ''
    calculated_identifiers[0] = calculate_identifier(digits: self.cpf[0..-3]).to_s
    calculated_identifiers[1] = calculate_identifier(digits: self.cpf[0..-2]).to_s
    calculated_identifiers == identifiers
  end

  def calculate_identifier(digits:)
    array = (digits.size + 1).downto(2).to_a
    sum = digits.chars.each_with_index.map { |l, index| l.to_i * array[index] }.reduce(:+)
    return 0 if (11 - (sum % 11)) >= 10

    11 - (sum % 11)
  end
  
end
