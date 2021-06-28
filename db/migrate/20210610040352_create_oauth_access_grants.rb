class CreateOauthAccessGrants < ActiveRecord::Migration[6.0]
  def change
    create_table :oauth_access_grants do |t|
      t.references :resource_owner,  null: false
      t.references :application,     null: false
      t.text     :token,             null: false
      t.integer  :expires_in,        null: false
      t.text     :redirect_uri,      null: false
      t.datetime :created_at,        null: false
      t.datetime :revoked_at
      t.string   :scopes,            null: false, default: ''
    end

    add_index :oauth_access_grants, :token, unique: true

    add_foreign_key :oauth_access_grants, :oauth_applications, column: :application_id
    add_foreign_key :oauth_access_grants, :users, column: :resource_owner_id
  end
end
