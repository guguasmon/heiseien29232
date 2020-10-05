require 'rails_helper'

RSpec.describe '水分提供表機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @guest1 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 1, visit2_id: 0) # 牛乳 月曜
    @bath1 = FactoryBot.create(:bath, guest_id: @guest1.id)
    @drink1 = FactoryBot.create(:drink, guest_id: @guest1.id, drink_type_id: 1)
    @food1 = FactoryBot.create(:food, guest_id: @guest1.id)
    @guest2 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 2, visit2_id: 0) # コーヒー牛乳 火曜
    @bath2 = FactoryBot.create(:bath, guest_id: @guest2.id)
    @drink2 = FactoryBot.create(:drink, guest_id: @guest2.id, drink_type_id: 2)
    @food2 = FactoryBot.create(:food, guest_id: @guest2.id)
    @guest3 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 3, visit2_id: 0) # ヤクルト 水曜
    @bath3 = FactoryBot.create(:bath, guest_id: @guest3.id)
    @drink3 = FactoryBot.create(:drink, guest_id: @guest3.id, drink_type_id: 3)
    @food3 = FactoryBot.create(:food, guest_id: @guest3.id)
    @guest4 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 4, visit2_id: 0) # ジュース 木曜
    @bath4 = FactoryBot.create(:bath, guest_id: @guest4.id)
    @drink4 = FactoryBot.create(:drink, guest_id: @guest4.id, drink_type_id: 4)
    @food4 = FactoryBot.create(:food, guest_id: @guest4.id)
    @guest5 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 5, visit2_id: 0) # プリン 金曜
    @bath5 = FactoryBot.create(:bath, guest_id: @guest5.id)
    @drink5 = FactoryBot.create(:drink, guest_id: @guest5.id, drink_type_id: 5)
    @food5 = FactoryBot.create(:food, guest_id: @guest5.id)
    @guest6 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 6, visit2_id: 0) # ヨーグルト 土曜
    @bath6 = FactoryBot.create(:bath, guest_id: @guest6.id)
    @drink6 = FactoryBot.create(:drink, guest_id: @guest6.id, drink_type_id: 6)
    @food6 = FactoryBot.create(:food, guest_id: @guest6.id)
    @guest7 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 7, visit2_id: 0) # 牛乳ゼリー 日曜
    @bath7 = FactoryBot.create(:bath, guest_id: @guest7.id)
    @drink7 = FactoryBot.create(:drink, guest_id: @guest7.id, drink_type_id: 7)
    @food7 = FactoryBot.create(:food, guest_id: @guest7.id)
    @guest8 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 7, visit2_id: 0) # お茶 日曜
    @bath8 = FactoryBot.create(:bath, guest_id: @guest8.id)
    @drink8 = FactoryBot.create(:drink, guest_id: @guest8.id, drink_type_id: 8)
    @food8 = FactoryBot.create(:food, guest_id: @guest8.id)
    @guest9 = FactoryBot.create(:guest) # 別ユーザーが登録した利用者
    @bath9 = FactoryBot.create(:bath, guest_id: @guest9.id)
    @drink9 = FactoryBot.create(:drink, guest_id: @guest9.id)
    @food9 = FactoryBot.create(:food, guest_id: @guest9.id)
  end
  context '水分提供表の閲覧ができるとき' do
    it 'ログインしたユーザーは自分が登録した利用者の水分提供表ページが閲覧できる' do
      # 利用者1を投稿したユーザーでログインする
      sign_in(@user)
      # 「水分提供表」のリンクがあることを確認する
      expect(page).to have_link '水分提供表'
      # 水分提供表ページへ遷移する
      visit drinks_path
      # テーブル要素を取得する
      drink_list = all('table')
      # 牛乳テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[0]).to have_content(@guest1.first_name)
      # コーヒー牛乳テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[1]).to have_content(@guest2.first_name)
      # ヤクルトテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[2]).to have_content(@guest3.first_name)
      # ジューステーブルに該当利用者が表示されているかを確認する
      expect(drink_list[3]).to have_content(@guest4.first_name)
      # プリンテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[4]).to have_content(@guest5.first_name)
      # ヨーグルトテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[5]).to have_content(@guest6.first_name)
      # 牛乳ゼリーテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[6]).to have_content(@guest7.first_name)
      # お茶テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[7]).to have_content(@guest8.first_name)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
    end
    it 'ログインしたユーザーは水分提供表ページから自分が登録した利用者の情報を編集できる', js: true do
      # 利用者1を投稿したユーザーでログインする
      sign_in(@user)
      # 「水分提供表」のリンクがあることを確認する
      expect(page).to have_link '水分提供表'
      # 水分提供表ページへ遷移する
      visit drinks_path
      # テーブル要素を取得する
      drink_list = all('table')
      # 牛乳テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[0]).to have_content(@guest1.first_name)
      # コーヒー牛乳テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[1]).to have_content(@guest2.first_name)
      # ヤクルトテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[2]).to have_content(@guest3.first_name)
      # ジューステーブルに該当利用者が表示されているかを確認する
      expect(drink_list[3]).to have_content(@guest4.first_name)
      # プリンテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[4]).to have_content(@guest5.first_name)
      # ヨーグルトテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[5]).to have_content(@guest6.first_name)
      # 牛乳ゼリーテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[6]).to have_content(@guest7.first_name)
      # お茶テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[7]).to have_content(@guest8.first_name)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # テーブルの行をクリックし利用者１の編集ページへ遷移する
      find(".guest-no-#{@guest1.id}").click
      # すでに登録済みの画像が表示されていることを確認する
      expect(page).to have_selector "img[src$='test_man.jpg']"
      # すでに登録済みの内容がフォームに入っていることを確認する
      expect(
        find('#first-name').value
      ).to eq @guest1.first_name
      expect(
        find('#last-name').value
      ).to eq @guest1.last_name
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_woman.jpg')
      # 画像選択フォームに画像を添付する
      attach_file('guest_data[image]', image_path)
      # 選択した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
      # 登録済みの画像が表示されていないことを確認する
      expect(page).to have_no_selector "img[src$='test_man.jpg']"
      # 登録内容を編集する
      fill_in 'guest_data[first_name]', with: "#{@guest1.first_name}編集済み"
      fill_in 'guest_data[last_name]', with: "#{@guest1.last_name}編集済み"
      select 'チェアー浴', from: '入浴形態'
      select 'コーヒー牛乳', from: '飲み物の種類'
      select 'ペースト', from: '主食の形態'
      select '本人の希望', from: '更新の理由'
      # 編集してもGuestモデル/Bathモデル/Drinkモデル/Foodモデルのカウントは変わらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Guest.count }.by(0).and change { Bath.count }.by(0).and change { Drink.count }.by(0).and change { Food.count }.by(0)
      # 水分提供表ページに戻ることを確認する
      expect(current_path).to eq drinks_path
      # テーブル要素を取得する
      drink_list = all('table')
      expect(page).to have_content(@guest1.first_name)
      # コーヒー牛乳テーブルに先ほど変更した内容の利用者が表示されているかを確認する
      expect(drink_list[1]).to have_content("#{@guest1.first_name}編集済み")
    end
    it 'ログインしたユーザーは水分提供表ページで自分が登録した利用者情報を曜日別に表示できる' do
      # 利用者を登録したユーザーでログインする
      sign_in(@user)
      # 「水分提供表」のリンクがあることを確認する
      expect(page).to have_link '水分提供表'
      # 水分提供表ページへ遷移する
      visit drinks_path
      # テーブル要素を取得する
      drink_list = all('table')
      # 牛乳テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[0]).to have_content(@guest1.first_name)
      # コーヒー牛乳テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[1]).to have_content(@guest2.first_name)
      # ヤクルトテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[2]).to have_content(@guest3.first_name)
      # ジューステーブルに該当利用者が表示されているかを確認する
      expect(drink_list[3]).to have_content(@guest4.first_name)
      # プリンテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[4]).to have_content(@guest5.first_name)
      # ヨーグルトテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[5]).to have_content(@guest6.first_name)
      # 牛乳ゼリーテーブルに該当利用者が表示されているかを確認する
      expect(drink_list[6]).to have_content(@guest7.first_name)
      # お茶テーブルに該当利用者が表示されているかを確認する
      expect(drink_list[7]).to have_content(@guest8.first_name)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # 「月曜日」ボタンをクリックする
      click_on '月曜日'
      # 水分提供表の月曜日ページにいることを確認する
      expect(current_path).to eq search_drink_path(1)
      # 月曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest1.first_name)
      expect(page).to have_content(@guest1.last_name)
      # テーブル要素を取得する
      drink_list = all('table')
      # 月曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(drink_list[0]).to have_content(@guest1.first_name)
      # 月曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s).and have_no_content(@guest8.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # 「火曜日」ボタンをクリックする
      click_on '火曜日'
      # 水分提供表の火曜日ページにいることを確認する
      expect(current_path).to eq search_drink_path(2)
      # 火曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest2.first_name)
      # テーブル要素を取得する
      drink_list = all('table')
      # 火曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(drink_list[1]).to have_content(@guest2.first_name)
      # 火曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s).and have_no_content(@guest8.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # 「水曜日」ボタンをクリックする
      click_on '水曜日'
      # 水分提供表の水曜日ページにいることを確認する
      expect(current_path).to eq search_drink_path(3)
      # 水曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest3.first_name)
      # テーブル要素を取得する
      drink_list = all('table')
      # 水曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(drink_list[2]).to have_content(@guest3.first_name)
      # 水曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s).and have_no_content(@guest8.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # 「木曜日」ボタンをクリックする
      click_on '木曜日'
      # 水分提供表の木曜日ページにいることを確認する
      expect(current_path).to eq search_drink_path(4)
      # 木曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest4.first_name)
      # テーブル要素を取得する
      drink_list = all('table')
      # 木曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(drink_list[3]).to have_content(@guest4.first_name)
      # 木曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s).and have_no_content(@guest8.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # 「金曜日」ボタンをクリックする
      click_on '金曜日'
      # 水分提供表の金曜日ページにいることを確認する
      expect(current_path).to eq search_drink_path(5)
      # 金曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest5.first_name)
      # テーブル要素を取得する
      drink_list = all('table')
      # 金曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(drink_list[4]).to have_content(@guest5.first_name)
      # 金曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s).and have_no_content(@guest8.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # 「土曜日」ボタンをクリックする
      click_on '土曜日'
      # 水分提供表の土曜日ページにいることを確認する
      expect(current_path).to eq search_drink_path(6)
      # 土曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest6.first_name)
      # テーブル要素を取得する
      drink_list = all('table')
      # 土曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(drink_list[5]).to have_content(@guest6.first_name)
      # 土曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest7.first_name.to_s).and have_no_content(@guest8.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
      # 「日曜日」ボタンをクリックする
      click_on '日曜日'
      # 水分提供表の日曜日ページにいることを確認する
      expect(current_path).to eq search_drink_path(7)
      # 日曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest7.first_name)
      expect(page).to have_content(@guest8.first_name)
      # テーブル要素を取得する
      drink_list = all('table')
      # 日曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(drink_list[6]).to have_content(@guest7.first_name)
      expect(drink_list[7]).to have_content(@guest8.first_name)
      # 日曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest9.first_name)
    end
  end
  context '水分提供表の閲覧ができないとき' do
    it 'ログインしていないユーザーは水分提供表が閲覧できない' do
      # トップページに遷移する
      visit root_path
      # 「入浴形態表」のリンクがないことを確認する
      expect(page).to have_no_link '水分提供表'
    end
  end
end
