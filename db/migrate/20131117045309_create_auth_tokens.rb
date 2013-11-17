class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string   :value
      t.datetime :expires_at
      t.string   :type

      t.integer  :user_id
      t.timestamps
    end

    add_index :auth_tokens, :value, unique: true
    add_index :auth_tokens, :user_id
  end
end
