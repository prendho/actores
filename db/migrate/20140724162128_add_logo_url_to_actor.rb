class AddLogoUrlToActor < ActiveRecord::Migration
  def change
    add_column :actores, :default_logo_url, :string
    Actor.reset_column_information
    Actor.find_each do |actor|
      actor.update! default_logo_url: "/images/actores/#{actor.slug}.png"
    end
  end
end
