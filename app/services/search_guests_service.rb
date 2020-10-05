class SearchGuestsService
  # 入浴形態表
  def self.search_bath(user, gender, bathing)
    Guest.joins(:user, :bath).where(users: { id: user }).where(gender_id: gender).where(baths: { bathing_id: bathing }).order('timing_id  ASC')
  end

  # 入浴形態表 曜日別
  def self.search_bath_day(user, gender, bathing, day)
    Guest.joins(:user, :bath).where(visit1_id: day).or(Guest.joins(:user, :bath).where(visit2_id: day)).where(users: { id: user }).where(gender_id: gender).where(baths: { bathing_id: bathing }).where(gender_id: gender).order('timing_id  ASC')
  end

  # 水分提供表
  def self.search_drink(user, drink_type)
    Guest.joins(:user, :drink).where(users: { id: user }).where(drinks: { drink_type_id: drink_type })
  end

  # 水分提供表曜日別
  def self.search_drink_day(user, drink_type, day)
    Guest.joins(:user, :drink).where(visit1_id: day).or(Guest.joins(:user, :drink).where(visit2_id: day)).where(users: { id: user }).where(drinks: { drink_type_id: drink_type })
  end

  # 食事提供表利用者
  def self.search_food_day(user, day)
    Guest.joins(:user, :food).where(visit1_id: day).or(Guest.joins(:user, :food).where(visit2_id: day)).where(users: { id: user })
  end
end
