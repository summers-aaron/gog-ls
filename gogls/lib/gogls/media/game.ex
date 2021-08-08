defmodule Gogls.Media.Game do
    use Ecto.Schema
    alias Gogls.Media.Expansion

    schema "games" do
        field :developer, :string
        field :title, :string
        field :category, :string
        field :available, :boolean
        field :original_category, :string
        field :image, :string
        field :slug, :string
        field :rating, :integer
        field :gog_id, :integer
        field :genres, {:array, :string}
        field :price, :float
        field :is_coming_soon, :boolean
        field :is_price_visible, :boolean
        field :supported_operating_systems, {:array, :string}
        field :is_in_development, :boolean
        field :age_requirement, :integer
        field :release_date, :date
        field :support_url, :string
        field :forum_url, :string
        field :global_release_date, :date
        field :video_url, :string
        field :video_provider, :string
        field :gallery, {:array, :string}
        field :publisher, :string
        field :is_discounted, :boolean
        field :is_wishlistable,:boolean
        has_many :expansions, Expansion

        timestamps()
    end
end