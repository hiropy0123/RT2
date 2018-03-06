module UsersHelper

  # prop: user / return: Gravatar image
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def last_update_time
    # 最終更新が何日前かを表示
    time_now = Time.now
    sec = time_now - @user.updated_at
    last_update_time = (Time.parse("1/1") + sec - (day = sec.to_i / 86400) * 86400).strftime("#{day}日%H時間%M分%S秒")
    "#{last_update_time}前"
  end
end
