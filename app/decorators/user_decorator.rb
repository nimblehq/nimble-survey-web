# frozen_string_literal: true

class UserDecorator < SimpleDelegator
  def avatar_url
    gravatar_id = Digest::MD5.hexdigest(email)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
