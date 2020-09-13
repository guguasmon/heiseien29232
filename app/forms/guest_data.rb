class GuestData

  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :first_name_kana, :last_name_kana, :gender_id, :visit1_id, :visit2_id, :description, :user_id,
                :bathing_id, :infection_id, :timing_id, :remark_bath, :guest_id,
                :drink_type_id, :warm, :thickness_id, :diabetes, :remark_drink, :guest_id

  # # boolean型のチェックはpresence:trueが使えない
   validates :warm, inclusion: { in: [true, false] }
   validates :diabetes, inclusion: { in: [true, false] }

  with_options presence: true do
    # guestテーブル
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください' }
    validates :gender_id
    validates :visit1_id
    validates :visit2_id
    # drinkテーブル
    validates :drink_type_id
    validates :thickness_id
    # bathテーブル
    validates :bathing_id
    validates :infection_id
    validates :timing_id
    with_options numericality: { other_than: 0, message: "の選択肢を選んでください" } do
    # guestテーブル
      validates :gender_id
      validates :visit1_id
    # drinkテーブル
      validates :drink_type_id
      validates :thickness_id
    # bathテーブル
      validates :bathing_id
      validates :infection_id
    end
  end

  def save
    # 利用者の情報を保存し、「guest」という変数に入れている
    guest = Guest.create(
      first_name: first_name, last_name: last_name, first_name_kana: first_name_kana, last_name_kana: last_name_kana,
      gender_id: gender_id, visit1_id: visit1_id, visit2_id: visit2_id, description: description, user_id: user_id
    )
    # 利用日が被っていたら利用日２を0にする
    if guest.visit1_id == guest.visit2_id
      guest.update(visit2_id: 0)
    end    
    
    # 入浴の情報を保存
    bath = Bath.create(bathing_id: bathing_id, infection_id: infection_id, timing_id: timing_id, remark_bath: remark_bath, guest_id: guest.id)
    
    # 水分の情報を保存
    drink = Drink.create(drink_type_id: drink_type_id, thickness_id: thickness_id, warm: warm, diabetes: diabetes, remark_drink: remark_drink, guest_id: guest.id)
  end

  def warm
    ActiveRecord::Type::Boolean.new.cast(@warm)
  end
  def diabetes
    ActiveRecord::Type::Boolean.new.cast(@diabetes)
  end
end

guestdata = GuestData.new(warm: '1')
guestdata.warm #=> true
gusetdata = GuestData.new(warm: '0')
gusetdata.warm #=> false

guestdata = GuestData.new(diabetes: '1')
guestdata.diabetes #=> true
gusetdata = GuestData.new(diabetes: '0')
gusetdata.diabetes #=> false