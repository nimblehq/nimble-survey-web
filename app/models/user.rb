# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :rememberable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  delegate :avatar_url, to: :user_decorator

  def valid_attribute?(attribute_name)
    valid?
    errors[attribute_name].blank?
  end

  def name
    self[:name].presence || Mail::Address.new(email).local.humanize
  end

  private

  def user_decorator
    @user_decorator ||= UserDecorator.new(self)
  end
end
