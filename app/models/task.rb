class Task < ApplicationRecord

  before_validation :set_nameless_name

  validates :name, presence: true
  validate  :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }
  # SQLを利用した絞り込みなどの条件を多用する場合にはscopeメソッドが使える。条件を変数に入れれば使える。今回はrecentという変数にorderを使った形

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
    # &.でnilを返してエラーを回避するような役目
  end

  def set_nameless_name
    self.name = '名前なし' if name.blank?
    # これはbefore_validationコールバックとして呼ぶことを定義した上で、selfつまりTaskのインスタンスを検証する前にTask.nameがなかったら’名前なし’を入れてねということ。
  end
end
