class AddReadingCacheToProduct < ActiveRecord::Migration
  def change
    add_column :products, :reading_cache, :jsonb, null: false, default: '{}'
  end
end
