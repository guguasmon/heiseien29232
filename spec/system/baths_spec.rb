require 'rails_helper'

RSpec.describe '入浴形態表機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @guest1 = FactoryBot.create(:guest, user_id: @user.id, gender_id: 1, visit1_id: 1, visit2_id: 0) # 一般浴男子 月曜
    @bath1 = FactoryBot.create(:bath, guest_id: @guest1.id, bathing_id: 1)
    @drink1 = FactoryBot.create(:drink, guest_id: @guest1.id)
    @guest2 = FactoryBot.create(:guest, user_id: @user.id, gender_id: 2, visit1_id: 2, visit2_id: 0) # 一般浴女子 火曜
    @bath2 = FactoryBot.create(:bath, guest_id: @guest2.id, bathing_id: 1)
    @drink2 = FactoryBot.create(:drink, guest_id: @guest2.id)
    @guest3 = FactoryBot.create(:guest, user_id: @user.id, gender_id: 1, visit1_id: 3, visit2_id: 0) # 一般チェアー浴男子 水曜
    @bath3 = FactoryBot.create(:bath, guest_id: @guest3.id, bathing_id: 2)
    @drink3 = FactoryBot.create(:drink, guest_id: @guest3.id)
    @guest4 = FactoryBot.create(:guest, user_id: @user.id, gender_id: 2, visit1_id: 4, visit2_id: 0) # 一般チェアー浴女子 木曜
    @bath4 = FactoryBot.create(:bath, guest_id: @guest4.id, bathing_id: 2)
    @drink4 = FactoryBot.create(:drink, guest_id: @guest4.id)
    @guest5 = FactoryBot.create(:guest, user_id: @user.id, gender_id: 1, visit1_id: 5, visit2_id: 0) # チェアー浴男子 金曜
    @bath5 = FactoryBot.create(:bath, guest_id: @guest5.id, bathing_id: 3)
    @drink5 = FactoryBot.create(:drink, guest_id: @guest5.id)
    @guest6 = FactoryBot.create(:guest, user_id: @user.id, gender_id: 2, visit1_id: 6, visit2_id: 0) # チェアー浴女子 土曜
    @bath6 = FactoryBot.create(:bath, guest_id: @guest6.id, bathing_id: 3)
    @drink6 = FactoryBot.create(:drink, guest_id: @guest6.id)
    @guest7 = FactoryBot.create(:guest, user_id: @user.id, gender_id: 2, visit1_id: 7, visit2_id: 0) # チェアー浴女子 日曜
    @bath7 = FactoryBot.create(:bath, guest_id: @guest7.id, bathing_id: 3)
    @drink7 = FactoryBot.create(:drink, guest_id: @guest7.id)
    @guest8 = FactoryBot.create(:guest) # 別ユーザーが登録した利用者
    @bath8 = FactoryBot.create(:bath, guest_id: @guest8.id)
    @drink8 = FactoryBot.create(:drink, guest_id: @guest8.id)
  end
  context '入浴形態表の閲覧ができるとき' do
    it 'ログインしたユーザーは自分が登録した利用者の入浴形態表ページが閲覧できる' do
      # 利用者1を投稿したユーザーでログインする
      sign_in(@user)
      # 「入浴形態表」のリンクがあることを確認する
      expect(page).to have_link '入浴形態表'
      # 入浴形態表ページへ遷移する
      visit baths_path
      # テーブル要素を取得する
      bath_list = all('table')
      # 一般浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[0]).to have_content(@guest1.first_name)
      # 一般浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[1]).to have_content(@guest2.first_name)
      # 一般チェアー浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[2]).to have_content(@guest3.first_name)
      # 一般チェアー浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[3]).to have_content(@guest4.first_name)
      # チェアー浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[4]).to have_content(@guest5.first_name)
      # チェアー浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[5]).to have_content(@guest6.first_name)
      expect(bath_list[5]).to have_content(@guest7.first_name)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
    end
    it 'ログインしたユーザーは入浴形態表ページから自分が登録した利用者の情報を編集できる', js: true do
      # 利用者1を投稿したユーザーでログインする
      sign_in(@user)
      # 「入浴形態表」のリンクがあることを確認する
      expect(page).to have_link '入浴形態表'
      # 入浴形態表ページへ遷移する
      visit baths_path
      # テーブル要素を取得する
      bath_list = all('table')
      # 一般浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[0]).to have_content(@guest1.first_name)
      # 一般浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[1]).to have_content(@guest2.first_name)
      # 一般チェアー浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[2]).to have_content(@guest3.first_name)
      # 一般チェアー浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[3]).to have_content(@guest4.first_name)
      # チェアー浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[4]).to have_content(@guest5.first_name)
      # チェアー浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[5]).to have_content(@guest6.first_name)
      expect(bath_list[5]).to have_content(@guest7.first_name)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # テーブルの行をクリックし利用者１の編集ページへ遷移する
      find(".guest-no-#{@guest1.id}").click
      # すでに登録済みの内容がフォームに入っていることを確認する
      expect(
        find('#first-name').value
      ).to eq @guest1.first_name
      expect(
        find('#last-name').value
      ).to eq @guest1.last_name
      # 登録内容を編集する
      fill_in 'guest_data[first_name]', with: "#{@guest1.first_name}編集済み"
      fill_in 'guest_data[last_name]', with: "#{@guest1.last_name}編集済み"
      select 'チェアー浴', from: '入浴形態'
      select 'コーヒー牛乳', from: '飲み物の種類'
      select '本人の希望', from: '更新の理由'
      # 編集してもGuestモデル/Bathモデル/Drinkモデルのカウントは変わらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Guest.count }.by(0).and change { Bath.count }.by(0).and change { Drink.count }.by(0)
      # 入浴形態表ページに戻ることを確認する
      expect(current_path).to eq baths_path
      # テーブル要素を取得する
      bath_list = all('table')
      expect(page).to have_content(@guest1.first_name)
      # チェアー浴男子テーブルに先ほど変更した内容の利用者が表示されているかを確認する
      expect(bath_list[4]).to have_content("#{@guest1.first_name}編集済み")
    end
    it 'ログインしたユーザーは入浴形態表ページで自分が登録した利用者情報を曜日別に表示できる' do
      # 利用者を登録したユーザーでログインする
      sign_in(@user)
      # 「入浴形態表」のリンクがあることを確認する
      expect(page).to have_link '入浴形態表'
      # 入浴形態表ページへ遷移する
      visit baths_path
      # テーブル要素を取得する
      bath_list = all('table')
      # 一般浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[0]).to have_content(@guest1.first_name)
      # 一般浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[1]).to have_content(@guest2.first_name)
      # 一般チェアー浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[2]).to have_content(@guest3.first_name)
      # 一般チェアー浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[3]).to have_content(@guest4.first_name)
      # チェアー浴男子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[4]).to have_content(@guest5.first_name)
      # チェアー浴女子テーブルに該当利用者が表示されているかを確認する
      expect(bath_list[5]).to have_content(@guest6.first_name)
      expect(bath_list[5]).to have_content(@guest7.first_name)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # 「月曜日」ボタンをクリックする
      click_on '月曜日'
      # 入浴形態表の月曜日ページにいることを確認する
      expect(current_path).to eq search_bath_path(1)
      # 月曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest1.first_name)
      # テーブル要素を取得する
      bath_list = all('table')
      # 月曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(bath_list[0]).to have_content(@guest1.first_name)
      # 月曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # 「火曜日」ボタンをクリックする
      click_on '火曜日'
      # 入浴形態表の火曜日ページにいることを確認する
      expect(current_path).to eq search_bath_path(2)
      # 火曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest2.first_name)
      # テーブル要素を取得する
      bath_list = all('table')
      # 火曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(bath_list[1]).to have_content(@guest2.first_name)
      # 火曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # 「水曜日」ボタンをクリックする
      click_on '水曜日'
      # 入浴形態表の水曜日ページにいることを確認する
      expect(current_path).to eq search_bath_path(3)
      # 水曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest3.first_name)
      # テーブル要素を取得する
      bath_list = all('table')
      # 水曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(bath_list[2]).to have_content(@guest3.first_name)
      # 水曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # 「木曜日」ボタンをクリックする
      click_on '木曜日'
      # 入浴形態表の木曜日ページにいることを確認する
      expect(current_path).to eq search_bath_path(4)
      # 木曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest4.first_name)
      # テーブル要素を取得する
      bath_list = all('table')
      # 木曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(bath_list[3]).to have_content(@guest4.first_name)
      # 木曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # 「金曜日」ボタンをクリックする
      click_on '金曜日'
      # 入浴形態表の金曜日ページにいることを確認する
      expect(current_path).to eq search_bath_path(5)
      # 金曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest5.first_name)
      # テーブル要素を取得する
      bath_list = all('table')
      # 金曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(bath_list[4]).to have_content(@guest5.first_name)
      # 金曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # 「土曜日」ボタンをクリックする
      click_on '土曜日'
      # 入浴形態表の土曜日ページにいることを確認する
      expect(current_path).to eq search_bath_path(6)
      # 土曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest6.first_name)
      # テーブル要素を取得する
      bath_list = all('table')
      # 土曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(bath_list[5]).to have_content(@guest6.first_name)
      # 土曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
      # 「日曜日」ボタンをクリックする
      click_on '日曜日'
      # 入浴形態表の日曜日ページにいることを確認する
      expect(current_path).to eq search_bath_path(7)
      # 日曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest7.first_name)
      # テーブル要素を取得する
      bath_list = all('table')
      # 日曜日利用の利用者の名前が該当欄に表示されていることを確認する
      expect(bath_list[5]).to have_content(@guest7.first_name)
      # 日曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s)
      # ログインしたユーザーが登録していない利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest8.first_name)
    end
  end
  context '入浴形態表の閲覧ができないとき' do
    it 'ログインしていないユーザーは入浴形態表が閲覧できない' do
      # トップページに遷移する
      visit root_path
      # 「入浴形態表」のリンクがないことを確認する
      expect(page).to have_no_link '入浴形態表'
    end
  end
end
