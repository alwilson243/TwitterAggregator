class AddNameToTweets < ActiveRecord::Migration
  def change
    change_table :tweets do |t|
      t.string :name
      t.string :text
    end
  end
end
