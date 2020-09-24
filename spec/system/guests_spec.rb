require 'rails_helper'

RSpec.describe '利用者の新規登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @guestdata = FactoryBot.build(:guest_data)
  end
  context '利用者の新規登録ができるとき' do
    it 'ログインしたユーザーは利用者の新規登録ができる' do
      # ログインする
      sign_in(@user)
      # 利用者新規登録ページへのリンクがあることを確認する
      expect(page).to have_content('利用者を登録する')
      # 利用者登録ページに移動する
      visit new_guest_path
      # フォームに情報を入力する
      fill_in 'guest_data[first_name]', with: @guestdata.first_name
      fill_in 'guest_data[last_name]', with: @guestdata.last_name
      fill_in 'guest_data[first_name_kana]', with: @guestdata.first_name_kana
      fill_in 'guest_data[last_name_kana]', with: @guestdata.last_name_kana
      select '独歩', from: '利用者の歩行状態'
      choose '性別:男'
      select '月曜日', from: '利用日１'
      select '火曜日', from: '利用日２'
      fill_in 'guest_data[description]', with: @guestdata.description
      select '一般浴', from: '入浴形態'
      select '感染症なし', from: '感染症の有無'
      select '最初', from: '入浴の順番'
      fill_in 'guest_data[remark_bath]', with: @guestdata.remark_bath
      select '牛乳', from: '飲み物の種類'
      select 'とろみなし', from: 'とろみの量'
      check 'guest_data[warm]'
      check 'guest_data[diabetes]'
      fill_in 'guest_data[remark_drink]', with: @guestdata.remark_drink
      # 送信するとGuestモデル/Bathモデル/Drinkモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Guest.count }.by(1).and change { Bath.count }.by(1).and change { Drink.count }.by(1)
      # トップページに戻ることを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど登録した内容の利用者が存在することを確認する
      expect(page).to have_content(@guestdata.first_name)
    end
  end
  context '利用者の新規登録ができないとき' do
    it 'ログインしていないと利用者の新規登録ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('利用者を登録する')
    end
  end
end

RSpec.describe '利用者情報の編集', type: :system do
  before do
    @guest1 = FactoryBot.create(:guest)
    @bath1 = FactoryBot.create(:bath, guest_id: @guest1.id)
    @drink1 = FactoryBot.create(:drink, guest_id: @guest1.id)
    @guest2 = FactoryBot.create(:guest)
    @bath2 = FactoryBot.create(:bath, guest_id: @guest2.id)
    @drink2 = FactoryBot.create(:drink, guest_id: @guest2.id)
  end

  context '利用者情報の編集ができるとき' do
    it 'ログインしたユーザーは自分が登録した利用者情報の編集ができる' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「編集」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '編集', href: edit_guest_path(@guest1.id)
      # 編集ページへ遷移する
      visit edit_guest_path(@guest1.id)
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
      expect  do
        find('input[name="commit"]').click
      end.to change { Guest.count }.by(0).and change { Bath.count }.by(0).and change { Drink.count }.by(0)
      # 詳細ページに戻ることを確認する
      expect(current_path).to eq guest_path(@guest1.id)
      # 詳細ページには先ほど変更した内容の利用者情報が存在することを確認する
      expect(page).to have_content("#{@guest1.first_name}編集済み")
      expect(page).to have_content("#{@guest1.last_name}編集済み")
      # 詳細ページの更新履歴には先ほど変更した内容の履歴が存在することを確認する
      expect(page).to have_content("入浴形態:独歩→歩行器//飲み物の種類:牛乳→コーヒー牛乳")
    end
  end
  context '利用者情報の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が登録した利用者の情報編集画面には遷移できない' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者２の「編集」ボタンが表示されていないことを確認する
      expect(page).to have_no_link '編集', href: edit_guest_path(@guest2.id)
    end
    it 'ログインしていないと利用者情報の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 利用者１の「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_guest_path(@guest1.id)
      # 利用者２の「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_guest_path(@guest2.id)
    end
  end
end

RSpec.describe '利用者情報の削除', type: :system do
  before do
    @guest1 = FactoryBot.create(:guest)
    @bath1 = FactoryBot.create(:bath, guest_id: @guest1.id)
    @drink1 = FactoryBot.create(:drink, guest_id: @guest1.id)
    @guest2 = FactoryBot.create(:guest)
    @bath2 = FactoryBot.create(:bath, guest_id: @guest2.id)
    @drink2 = FactoryBot.create(:drink, guest_id: @guest2.id)
  end

  context '利用者情報の削除ができるとき' do
    it 'ログインしたユーザーは自分が登録した利用者情報の削除ができる' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「削除」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '削除', href: guest_path(@guest1.id)
      # 削除ボタンを一回押して確認ウィンドウを開く
      find_link('削除', href: guest_path(@guest1)).click
      # 削除するとGuestテーブル・Bathテーブル・Drinkテーブルのレコードの数が1減ることを確認する
      expect {
        page.accept_confirm "本当に削除しますか？"
        expect(page).to have_content "利用者情報を削除しました"
      }.to change { Guest.count }.by(-1).and change { Bath.count }.by(-1).and change { Drink.count }.by(-1)
      # トップページに戻ることを確認する
      expect(current_path).to eq root_path
      # トップページには利用者１の内容が存在しないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s)
    end
  end
  context '利用者情報の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が登録した利用者情報の削除を行うことはできない' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者２の「削除」ボタンが表示されていないことを確認する
      expect(page).to have_no_link '削除', href: guest_path(@guest2.id)
    end
    it 'ログインしていないと利用者情報の削除ボタンは表示されない' do
      # トップページにいる
      visit root_path
      # 利用者１の「削除」ボタンがないことを確認する
      expect(page).to have_no_link '削除', href: guest_path(@guest1.id)
      # 利用者２の「削除」ボタンがないことを確認する
      expect(page).to have_no_link '削除', href: guest_path(@guest2.id)
    end
  end
end

RSpec.describe '利用者情報の詳細表示', type: :system do
  before do
    @guest1 = FactoryBot.create(:guest)
    @bath1 = FactoryBot.create(:bath, guest_id: @guest1.id)
    @drink1 = FactoryBot.create(:drink, guest_id: @guest1.id)
    @comment1 = FactoryBot.create(:comment, guest_id: @guest1.id)
    @guest2 = FactoryBot.create(:guest)
    @bath2 = FactoryBot.create(:bath, guest_id: @guest2.id)
    @drink2 = FactoryBot.create(:drink, guest_id: @guest2.id)
    @comment2 = FactoryBot.create(:comment, guest_id: @guest2.id)
  end

  context '利用者の詳細情報が表示される時' do
    it 'ログインしたユーザーは自分が登録した利用者情報の詳細が確認できる' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「詳細」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '詳細', href: guest_path(@guest1.id)
      # 詳細ページへ遷移する
      visit guest_path(@guest1.id)
      # 詳細ページに登録した内容が表示されていることを確認する
      expect(page).to have_content(@guest1.first_name.to_s).and have_content(@guest1.bath.bathing.name.to_s).and have_content(@guest1.drink.drink_type.name.to_s)
      # 利用者１の「編集」ボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_guest_path(@guest1.id)
      # 利用者１の「削除」ボタンがあることを確認する
      expect(page).to have_link '削除', href: guest_path(@guest1.id)
    end
    it 'ログインしたユーザーは詳細画面からでも自分が登録した利用者情報の編集ができる' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「詳細」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '詳細', href: guest_path(@guest1.id)
      # 詳細ページへ遷移する
      visit guest_path(@guest1.id)
      # 詳細ページに登録した内容が表示されていることを確認する
      expect(page).to have_content(@guest1.first_name.to_s).and have_content(@guest1.last_name.to_s).and have_content(@guest1.first_name_kana.to_s).and have_content(@guest1.last_name_kana.to_s).and have_content(@guest1.visit1.name.to_s).and have_content(@guest1.visit2.name.to_s).and have_content(@guest1.adl.name.to_s).and have_content(@guest1.description.to_s).and have_content(@guest1.bath.bathing.name.to_s).and have_content(@guest1.bath.infection.name.to_s).and have_content(@guest1.bath.timing.name.to_s)
        .and have_content(@guest1.bath.remark_bath.to_s).and have_content(@guest1.drink.drink_type.name.to_s).and have_content(@guest1.drink.thickness.name.to_s).and have_content(@guest1.drink.warm ? '温める' : '温めない').and have_content(@guest1.drink.diabetes ? '有り' : '無し').and have_content(@guest1.drink.remark_drink.to_s)
      # 利用者１の「編集」ボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_guest_path(@guest1.id)
      # 編集ページへ遷移する
      visit edit_guest_path(@guest1.id)
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
      expect  do
        find('input[name="commit"]').click
      end.to change { Guest.count }.by(0).and change { Bath.count }.by(0).and change { Drink.count }.by(0)
      # 詳細ページに戻ることを確認する
      expect(current_path).to eq guest_path(@guest1.id)
      # 詳細ページには先ほど変更した内容の利用者情報が存在することを確認する
      expect(page).to have_content("#{@guest1.first_name}編集済み")
      expect(page).to have_content("#{@guest1.last_name}編集済み")
      # 詳細ページの更新履歴に先ほど変更した内容の履歴が存在することを確認する
      expect(page).to have_content("入浴形態:独歩→歩行器//飲み物の種類:牛乳→コーヒー牛乳")
    end
    it 'ログインしたユーザーは詳細画面からでも自分が登録した利用者情報の削除ができる' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「詳細」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '詳細', href: guest_path(@guest1.id)
      # 詳細ページへ遷移する
      visit guest_path(@guest1.id)
      # 詳細ページに登録した内容が表示されていることを確認する
      expect(page).to have_content(@guest1.first_name.to_s).and have_content(@guest1.bath.bathing.name.to_s).and have_content(@guest1.drink.drink_type.name.to_s)
      # 利用者１の「削除」ボタンがあることを確認する
      expect(page).to have_link '削除', href: guest_path(@guest1.id)
      # 削除ボタンを一回押して確認ウィンドウを開く
      find_link('削除', href: guest_path(@guest1)).click
      # 削除するとGuestテーブル・Bathテーブル・Drinkテーブルのレコードの数が1減ることを確認する
      expect {
        page.accept_confirm "本当に削除しますか？"
        expect(page).to have_content "利用者情報を削除しました"
      }.to change { Guest.count }.by(-1).and change { Bath.count }.by(-1).and change { Drink.count }.by(-1)
      # トップページに戻ることを確認する
      expect(current_path).to eq root_path
      # トップページには利用者１の内容が存在しないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s)
    end
    it 'ログインしたユーザーは詳細画面から自分が登録した利用者へのコメントができる', js: true do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「詳細」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '詳細', href: guest_path(@guest1.id)
      # 詳細ページへ遷移する
      visit guest_path(@guest1.id)
      # 詳細ページに登録した内容が表示されていることを確認する
      expect(page).to have_content(@guest1.first_name.to_s).and have_content(@guest1.last_name.to_s).and have_content(@guest1.first_name_kana.to_s).and have_content(@guest1.last_name_kana.to_s).and have_content(@guest1.visit1.name.to_s).and have_content(@guest1.visit2.name.to_s).and have_content(@guest1.adl.name.to_s).and have_content(@guest1.description.to_s).and have_content(@guest1.bath.bathing.name.to_s).and have_content(@guest1.bath.infection.name.to_s).and have_content(@guest1.bath.timing.name.to_s)
        .and have_content(@guest1.bath.remark_bath.to_s).and have_content(@guest1.drink.drink_type.name.to_s).and have_content(@guest1.drink.thickness.name.to_s).and have_content(@guest1.drink.warm ? '温める' : '温めない').and have_content(@guest1.drink.diabetes ? '有り' : '無し').and have_content(@guest1.drink.remark_drink.to_s)
      # 利用者１の「コメント」ボタンがあることを確認する
      expect(page).to have_content ('コメントをする')
      # コメントボタンをクリックする
      click_button 'コメントをする'
      # コメントフォームが表示されることを確認する
      expect(page).to have_content ('コメントフォーム')
      # コメント本文を記入する
      fill_in '本文', with: "テスト"
      # 投稿するとcommentモデルのカウントが１増えることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(1)
      # 詳細ページに戻ることを確認する
      expect(current_path).to eq guest_path(@guest1.id)
      # 詳細ページには先ほど投稿した内容のコメントが存在することを確認する
      expect(page).to have_content("テスト")
    end
    it 'ログインしたユーザーは詳細画面から自分が登録した利用者のコメントの編集ができる', js: true  do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「詳細」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '詳細', href: guest_path(@guest1.id)
      # 詳細ページへ遷移する
      visit guest_path(@guest1.id)
      # 詳細ページに登録したコメントが表示されていることを確認する
      expect(page).to have_content(@comment1.text)
      # 利用者１のコメントの編集ボタンがあることを確認する
      expect(page).to have_button ("編集")
      # 利用者１のコメントの編集ボタンをクリックする
      find("#edit-start-#{@comment1.id}").click
      # コメントフォームが表示されることを確認する
      expect(page).to have_content ('コメント編集フォーム')
      # 登録したコメントが表示されていることを確認する
      expect(
        find('#edit-text').value
      ).to eq @comment1.text
      # コメント本文を編集する
      fill_in '本文', with: "ヘンシュウ"
      # 投稿してもcommentモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(0)
      # 詳細ページに戻ることを確認する
      expect(current_path).to eq guest_path(@guest1.id)
      #フラッシュメッセージが表示されていることを確認する
      expect(page).to have_content ('コメントの編集をしました')
      # 詳細ページには先ほど編集した内容のコメントが存在することを確認する
      expect(page).to have_content("ヘンシュウ")
    end
    it 'ログインしたユーザーは詳細画面から自分が登録した利用者のコメントの削除ができる', js: true  do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者１の「詳細」ボタンがあることを確認する
      expect(
        find(".guest-no-#{@guest1.id}")
      ).to have_link '詳細', href: guest_path(@guest1.id)
      # 詳細ページへ遷移する
      visit guest_path(@guest1.id)
      # 詳細ページに登録したコメントが表示されていることを確認する
      expect(page).to have_content(@comment1.text)
      # 利用者１のコメントの削除ボタンがあることを確認する
      expect(page).to have_link '削除', href: guest_comment_path(@comment1.guest.id, @comment1.id)
      # 利用者１のコメントの削除ボタンを一回押して確認ウィンドウを開く
      find_link('削除', href: guest_comment_path(@comment1.guest.id, @comment1.id)).click
      # 削除するとCommentテーブルのレコードの数が1減ることを確認する
      expect {
        page.accept_confirm "本当に削除しますか？"
        expect(page).to have_content "コメントの削除をしました"
      }.to change { Comment.count }.by(-1)
      # 詳細ページに戻ることを確認する
      expect(current_path).to eq guest_path(@guest1.id)
      # 詳細ページには利用者１のコメントが存在しないことを確認する
      expect(page).to have_no_content(@comment1.text)
    end
  end
  context '利用者の詳細情報が表示されない時' do
    it 'ログインしていても自分が登録していない利用者情報は表示されない' do
      # 利用者1を投稿したユーザーでログインする
      user1_sign_in(@guest1)
      # 利用者２の表示がないことを確認する
      expect(page).to have_no_content(@guest2.first_name.to_s)
    end
    it 'ログインしていない状態では利用者情報が表示されない' do
      # トップページに遷移する
      visit root_path
      # 利用者１の表示がないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s)
      # 利用者２の表示がないことを確認する
      expect(page).to have_no_content(@guest2.first_name.to_s)
    end
  end
end

RSpec.describe '利用者情報の曜日別簡易表示', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @guest1 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 1, visit2_id: 0) #月曜日利用者
    @bath1 = FactoryBot.create(:bath, guest_id: @guest1.id) 
    @drink1 = FactoryBot.create(:drink, guest_id: @guest1.id)
    @guest2 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 2, visit2_id: 0) #火曜日利用者
    @bath2 = FactoryBot.create(:bath, guest_id: @guest2.id)
    @drink2 = FactoryBot.create(:drink, guest_id: @guest2.id)
    @guest3 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 3, visit2_id: 0) #水曜日利用者
    @bath3 = FactoryBot.create(:bath, guest_id: @guest3.id)
    @drink3 = FactoryBot.create(:drink, guest_id: @guest3.id)
    @guest4 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 4, visit2_id: 0) #木曜日利用者
    @bath4 = FactoryBot.create(:bath, guest_id: @guest4.id)
    @drink4 = FactoryBot.create(:drink, guest_id: @guest4.id)
    @guest5 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 5, visit2_id: 0) #金曜日利用者
    @bath5 = FactoryBot.create(:bath, guest_id: @guest5.id)
    @drink5 = FactoryBot.create(:drink, guest_id: @guest5.id)
    @guest6 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 6, visit2_id: 0) #土曜日利用者
    @bath6 = FactoryBot.create(:bath, guest_id: @guest6.id)
    @drink6 = FactoryBot.create(:drink, guest_id: @guest6.id)
    @guest7 = FactoryBot.create(:guest, user_id: @user.id, visit1_id: 7, visit2_id: 0) #日曜日利用者
    @bath7 = FactoryBot.create(:bath, guest_id: @guest7.id)
    @drink7 = FactoryBot.create(:drink, guest_id: @guest7.id)
  end

  context '利用者が曜日別に表示される時' do
    it 'ログインしたユーザーはトップページで自分が登録した利用者情報を曜日別に表示できる' do
      # 利用者を登録したユーザーでログインする
      sign_in(@user)
      # 登録した利用者の名前が全て表示されていることを確認する
      expect(page).to have_content(@guest1.first_name)
      expect(page).to have_content(@guest2.first_name)
      expect(page).to have_content(@guest3.first_name)
      expect(page).to have_content(@guest4.first_name)
      expect(page).to have_content(@guest5.first_name)
      expect(page).to have_content(@guest6.first_name)
      expect(page).to have_content(@guest7.first_name)
      # 「月曜日」ボタンをクリックする
      click_on '月曜日'
      # 月曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest1.first_name.to_s)
      # 月曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # 「火曜日」ボタンをクリックする
      click_on '火曜日'
      # 火曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest2.first_name.to_s)
      # 火曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # 「水曜日」ボタンをクリックする
      click_on '水曜日'
      # 水曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest3.first_name.to_s)
      # 水曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # 「木曜日」ボタンをクリックする
      click_on '木曜日'
      # 木曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest4.first_name.to_s)
      # 木曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # 「金曜日」ボタンをクリックする
      click_on '金曜日'
      # 金曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest5.first_name.to_s)
      # 金曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest6.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # 「土曜日」ボタンをクリックする
      click_on '土曜日'
      # 土曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest6.first_name.to_s)
      # 土曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest7.first_name.to_s)
      # 「日曜日」ボタンをクリックする
      click_on '日曜日'
      # 日曜日利用の利用者の名前が表示されていることを確認する
      expect(page).to have_content(@guest7.first_name.to_s)
      # 日曜日以外の利用者の名前が表示されていないことを確認する
      expect(page).to have_no_content(@guest1.first_name.to_s).and have_no_content(@guest2.first_name.to_s).and have_no_content(@guest3.first_name.to_s).and have_no_content(@guest4.first_name.to_s).and have_no_content(@guest5.first_name.to_s).and have_no_content(@guest6.first_name.to_s)
    end
  end
end