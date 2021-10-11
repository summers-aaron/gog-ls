defmodule Gogls.Media.Game do
  use Ecto.Schema
  alias Ecto.Changeset

  alias Gogls.Media.Expansion

  schema "games" do
    field :age_requirement, :integer
    field :available, :boolean
    field :category, :string
    field :developer, :string
    field :forum_url, :string
    field :gallery, {:array, :string}
    field :genres, {:array, :string}
    field :global_release_date, :date
    field :gog_id, :integer
    field :image, :string
    field :is_coming_soon, :boolean
    field :is_discounted, :boolean
    field :is_in_development, :boolean
    field :is_price_visible, :boolean
    field :is_wishlistable, :boolean
    field :original_category, :string
    field :price, :float
    field :publisher, :string
    field :rating, :float
    field :release_date, :date
    field :slug, :string
    field :support_url, :string
    field :supported_operating_systems, {:array, :string}
    field :title, :string
    field :video_provider, :string
    field :video_url, :string

    has_many :expansions, Expansion

    timestamps()
  end

  def changeset(game, changes) do
    game
    |> Changeset.cast(changes, [
      :age_requirement,
      :available,
      :category,
      :developer,
      :forum_url,
      :gallery,
      :genres,
      :global_release_date,
      :gog_id,
      :image,
      :is_coming_soon,
      :is_discounted,
      :is_in_development,
      :is_price_visible,
      :is_wishlistable,
      :original_category,
      :price,
      :publisher,
      :rating,
      :release_date,
      :slug,
      :support_url,
      :supported_operating_systems,
      :title,
      :video_provider,
      :video_url
    ])
    |> validate_required()
  end

  defp validate_required(changes) do
    Changeset.validate_required(changes, [
      :available,
      :category,
      :developer,
      :gallery,
      :genres,
      :gog_id,
      :is_coming_soon,
      :is_discounted,
      :is_in_development,
      :is_price_visible,
      :is_wishlistable,
      :price,
      :publisher,
      :slug,
      :supported_operating_systems,
      :title
    ])
  end
end
