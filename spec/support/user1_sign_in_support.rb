module User1SignInSupport
  def user1_sign_in(guest)
    visit new_user_session_path
    fill_in 'email', with: guest.user.email
    fill_in 'password', with: guest.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end
end