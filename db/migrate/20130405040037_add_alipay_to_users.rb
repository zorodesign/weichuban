class AddAlipayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :alipay, :string
  end
end
