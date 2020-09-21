class GuestData
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :first_name_kana, :last_name_kana, :gender_id, :visit1_id, :visit2_id,
                :description, :user_id, :id, :adl_id,
                :bathing_id, :infection_id, :timing_id, :remark_bath,
                :drink_type_id, :warm, :thickness_id, :diabetes, :remark_drink, :guest_id,
                :log, :log_type_id

  # # boolean型のチェックはpresence:trueが使えない
  validates :warm, inclusion: { in: [true, false] }
  validates :diabetes, inclusion: { in: [true, false] }
  # 文字数の制限
  validates :description, length: { maximum: 1000 }
  validates :remark_bath, length: { maximum: 20 }
  validates :remark_drink, length: { maximum: 20 }

  with_options presence: true do
    # guestテーブル
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください' }
    validates :gender_id
    validates :visit1_id
    validates :visit2_id
    validates :adl_id
    # drinkテーブル
    validates :drink_type_id
    validates :thickness_id
    # bathテーブル
    validates :bathing_id
    validates :infection_id
    validates :timing_id
    #historiesテーブル
    validates :log
    validates :log_type_id
    with_options numericality: { other_than: 0, message: 'の選択肢を選んでください' } do
      # guestテーブル
      validates :gender_id
      validates :visit1_id
      validates :adl_id
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
      gender_id: gender_id, visit1_id: visit1_id, visit2_id: visit2_id, description: description, user_id: user_id, adl_id: adl_id
    )
    # 利用日が被っていたら利用日２を0（未選択）にする
    if guest.visit1_id == guest.visit2_id
      guest.update(visit2_id: 0)
    # 利用日の選択順によっては両者を入れ替える
    elsif guest.visit1_id > guest.visit2_id && guest.visit2_id != 0
      guest.visit1_id, guest.visit2_id = guest.visit2_id, guest.visit1_id
      guest.update(visit1_id: guest.visit1_id, visit2_id: guest.visit2_id)
    end

    # 入浴の情報を保存
    bath = Bath.create(bathing_id: bathing_id, infection_id: infection_id, timing_id: timing_id, remark_bath: remark_bath, guest_id: guest.id)

    # 水分の情報を保存
    drink = Drink.create(drink_type_id: drink_type_id, thickness_id: thickness_id, warm: warm, diabetes: diabetes, remark_drink: remark_drink, guest_id: guest.id)
    # 更新履歴の情報を保存
    new_log = History.create(log: log, log_type_id: log_type_id, guest_id: guest.id)
  end

  def update
    guest = Guest.find(id)

    # 比較用データ古い方作成
    comparison_old = GuestData.new(
      first_name: guest.first_name,
      last_name: guest.last_name,
      first_name_kana: guest.first_name_kana,
      last_name_kana: guest.last_name_kana,
      gender_id: guest.gender_id,
      visit1_id: guest.visit1_id,
      visit2_id: guest.visit2_id,
      adl_id: guest.adl_id,
      description: guest.description,
      bathing_id: guest.bath.bathing_id,
      infection_id: guest.bath.infection_id,
      timing_id: guest.bath.timing_id,
      remark_bath: guest.bath.remark_bath,
      drink_type_id: guest.drink.drink_type_id,
      warm: guest.drink.warm,
      thickness_id: guest.drink.thickness_id,
      diabetes: guest.drink.diabetes,
      remark_drink: guest.drink.remark_drink
    )

    guest.update(
      first_name: first_name, last_name: last_name, first_name_kana: first_name_kana, last_name_kana: last_name_kana,
      gender_id: gender_id, visit1_id: visit1_id, visit2_id: visit2_id, description: description, user_id: user_id, adl_id: adl_id
    )

    # 利用日が被っていたら利用日２を0（未選択）にする
    if guest.visit1_id == guest.visit2_id
      guest.update(visit2_id: 0)
    # 利用日の選択順によっては両者を入れ替える
    elsif guest.visit1_id > guest.visit2_id && guest.visit2_id != 0
      guest.visit1_id, guest.visit2_id = guest.visit2_id, guest.visit1_id
      guest.update(visit1_id: guest.visit1_id, visit2_id: guest.visit2_id)
    end

    # 比較用データ新しい方作成
    comparison_new = GuestData.new(
      first_name: first_name,
      last_name: last_name,
      first_name_kana: first_name_kana,
      last_name_kana: last_name_kana,
      gender_id: gender_id.to_i,
      visit1_id: guest.visit1_id,
      visit2_id: guest.visit2_id,
      adl_id: adl_id.to_i,
      description: description,
      bathing_id: bathing_id.to_i,
      infection_id: infection_id.to_i,
      timing_id: timing_id.to_i,
      remark_bath: remark_bath,
      drink_type_id: drink_type_id.to_i,
      warm: warm,
      thickness_id: thickness_id.to_i,
      diabetes: diabetes,
      remark_drink: remark_drink
    )

    # 入浴の情報を保存
    bath = Bath.find_by(guest_id: guest.id)
    bath.update(bathing_id: bathing_id, infection_id: infection_id, timing_id: timing_id, remark_bath: remark_bath)

    # 水分の情報を保存
    drink = Drink.find_by(guest_id: guest.id)
    drink.update(drink_type_id: drink_type_id, thickness_id: thickness_id, warm: warm, diabetes: diabetes, remark_drink: remark_drink)

    # アクティブハッシュとの繋がりが途切れているため改めて記述
    change_logs = []
    genders = ["", "男性", "女性"]
    visits = ["利用なし", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"]
    adls = ["", "独歩", "杖歩行", "歩行器", "車椅子"]
    bath_types = ["", "独歩", "杖歩行", "歩行器", "車椅子"]
    infections = ["", "感染症なし", "B型肝炎", "C型肝炎", "疥癬"]
    timings = ["", "最初", "早め", "普通", "遅め", "最後"]
    drink_types = ["", "牛乳", "コーヒー牛乳", "ヤクルト", "ジュース", "プリン", "ヨーグルト", "牛乳ゼリー", "お茶"]
    thicknesses = ["", "とろみなし", "小匙半分", "小匙一杯",]

    # 変更履歴を比較して記入
    if (comparison_old.first_name != comparison_new.first_name) || (comparison_old.last_name != comparison_new.last_name) || (comparison_old.first_name_kana != comparison_new.first_name_kana) || (comparison_old.last_name_kana != comparison_new.last_name_kana)
      change_logs << "名前:#{comparison_old.first_name}#{comparison_old.last_name}(#{comparison_old.first_name_kana}#{comparison_old.last_name_kana})→#{comparison_new.first_name}#{comparison_new.last_name}(#{comparison_new.first_name_kana}#{comparison_new.last_name_kana})"
    end
    if comparison_old.gender_id != comparison_new.gender_id
      old_id = comparison_old.gender_id.to_i
      new_id = comparison_new.gender_id.to_i
      change_logs << "性別:#{genders[old_id]}→#{genders[new_id]}"
    end
    if comparison_old.visit1_id != comparison_new.visit1_id
      change_logs << "利用日１:#{visits[comparison_old.visit1_id]}→#{visits[comparison_new.visit1_id]}"
    end
    if comparison_old.visit2_id != comparison_new.visit2_id
      change_logs << "利用日２:#{visits[comparison_old.visit2_id]}→#{visits[comparison_new.visit2_id]}"
    end
    if comparison_old.description != comparison_new.description
      change_logs << "利用者の備考:#{comparison_old.description}→#{comparison_new.description}"
    end
    if comparison_old.adl_id != comparison_new.adl_id
      change_logs << "歩行状態:#{adls[comparison_old.adl_id]}→#{adls[comparison_new.adl_id]}"
    end
    if comparison_old.bathing_id != comparison_new.bathing_id
      change_logs << "入浴形態:#{bath_types[comparison_old.bathing_id]}→#{bath_types[comparison_new.bathing_id]}"
    end
    if comparison_old.infection_id != comparison_new.infection_id
      change_logs << "感染症:#{infections[comparison_old.infection_id]}→#{infections[comparison_new.infection_id]}"
    end
    if comparison_old.timing_id != comparison_new.timing_id
      change_logs << "入浴の順番:#{timings[comparison_old.timing_id]}→#{timings[comparison_new.timing_id]}"
    end
    if comparison_old.remark_bath != comparison_new.remark_bath
      change_logs << "入浴の備考:#{comparison_old.remark_bath}→#{comparison_new.remark_bath}"
    end
    if comparison_old.drink_type_id != comparison_new.drink_type_id
      change_logs << "飲み物の種類:#{drink_types[comparison_old.drink_type_id]}→#{drink_types[comparison_new.drink_type_id]}"
    end
    if comparison_old.thickness_id != comparison_new.thickness_id
      change_logs << "とろみの量:#{thicknesses[comparison_old.thickness_id]}→#{thicknesses[comparison_new.thickness_id]}"
    end
    if comparison_old.warm != comparison_new.warm
      change_logs << "温めの有無:#{comparison_old.warm ? "温める" : "温めない" }→#{comparison_new.warm ? "温める" : "温めない" }"
    end
    if comparison_old.diabetes != comparison_new.diabetes
      change_logs << "糖尿病の有無:#{comparison_old.diabetes ? "糖尿病あり" : "糖尿病なし" }→#{comparison_new.diabetes ? "糖尿病あり" : "糖尿病なし" }"
    end
    if comparison_old.remark_drink != comparison_new.remark_drink
      change_logs << "水分の備考:#{comparison_old.remark_drink}→#{comparison_new.remark_drink}"
    end
    #変更内容を変数へ入力
    change_log = change_logs.join("//")     
    # 更新履歴の情報を保存
    update_log = History.create(log: change_log, log_type_id: log_type_id, guest_id: guest.id)
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
