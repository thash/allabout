s.fill_in :guess_3, with: 6857
s.fill_in :captcha, with: 71355
s.click_button 'Check'

s.save_screenshot 'check.png'
