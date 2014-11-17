def go_home
  unless tired?
    jog
  end
  if adult?
    drink_a_beer
  end

  sleep
end

# 後置表記を使うとこうなる
def go_home
  jog unless tired?
  drink_a_beer if adult?

  sleep
end
