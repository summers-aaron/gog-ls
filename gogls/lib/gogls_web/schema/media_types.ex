defmodule GoglsWeb.Schema.MediaTypes do
  use Absinthe.Schema.Notation

  object :game do
    field :id, non_null(:id)
    field :slug, non_null(:string)
    field :title, non_null(:string)
    field :image, :string
    field :price, non_null(:float)
  end
end
