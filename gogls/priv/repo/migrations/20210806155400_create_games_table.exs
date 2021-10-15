defmodule Repo.Migrations.CreateGamesTable do
use Ecto.Migration

    def up do
        create table("games") do
            add :age_requirement, :integer
            add :available, :boolean, null: false
            add :category, :string, null: false
            add :developer, :string, null: false
            add :forum_url, :string
            add :gallery, {:array, :string}, null: false
            add :genres, {:array, :string}, null: false
            add :global_release_date, :date
            add :gog_id, :integer, null: false
            add :image, :string
            add :is_coming_soon, :boolean, null: false
            add :is_discounted, :boolean, null: false
            add :is_in_development, :boolean, null: false
            add :is_price_visible, :boolean, null: false
            add :is_wishlistable, :boolean, null: false
            add :original_category, :string
            add :price, :float, null: false
            add :publisher, :string, null: false
            add :rating, :float
            add :release_date, :date
            add :slug, :string, null: false
            add :support_url, :string
            add :supported_operating_systems, {:array, :string}, null: false
            add :title, :string, null: false
            add :video_provider, :string
            add :video_url, :string

            timestamps()
        end
    end

    def down do
        drop table("games")
    end
end
