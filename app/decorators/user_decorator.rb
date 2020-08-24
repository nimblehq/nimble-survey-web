# frozen_string_literal: true

class UserDecorator < SimpleDelegator
  AVATAR_URL_FORMAT = 'https://api.adorable.io/avatar/%{email}'

  def avatar_url
    format(AVATAR_URL_FORMAT, email: email)
  end
end
