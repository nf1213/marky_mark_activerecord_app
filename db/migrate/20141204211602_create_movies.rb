class CreateMovies < ActiveRecord::Migration
  def change
    create_table 'movies', force: true do |t|
      t.string :title
      t.integer :year
      t.text :synopsis
      t.timestamps
      t.integer :genre_id
      t.integer :studio_id
    end

    create_table 'actors', force: true do |t|
      t.string :name
      t.timestamps
      t.integer :previous
      t.integer :distance
      t.boolean :visited
    end

    create_table 'cast_member', force: true do |t|
      t.integer :movie_id
      t.integer :actor_id
      t.timestamps
      t.string :character
    end
  end
end
