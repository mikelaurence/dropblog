class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.references :user
      t.string :blog

      t.string :title, :permalink
      t.text :body, :excerpt
      t.datetime :published_at

      t.boolean :published, :allow_comments

      t.timestamps
    end

    add_index :articles, [:blog, :published, :published_at]
    add_index :articles, :permalink
  end

  def self.down
    drop_table :articles
  end
end
