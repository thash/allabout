within("#login-form") do
  fill_in 'email',    with: 'user@example.com'
  fill_in 'password', with: 'password'
end
click_button 'ログイン'
