defmodule Mix.Tasks.Gogls.Expansions.Get do
  alias Gogls.Media.Expansion

  defp to_map(expansion) do
    %{
      developer: expansion["developer"],
      title: expansion["title"],
      available: expansion["buyable"],
      image: expansion["image"],
      slug: expansion["slug"],
      rating: expansion["rating"],
      gog_id: expansion["id"],
      price: price(expansion),
      is_coming_soon: expansion["isComingSoon"],
      is_price_visible: expansion["isPriceVisible"],
      is_in_development: expansion["isInDevelopment"],
      age_requirement: expansion["ageLimit"],
      release_date: release_date(expansion),
      support_url: expansion["supportUrl"],
      forum_url: expansion["forumUrl"],
      global_release_date: global_release_date(expansion),
      video_url: expansion["video"]["id"],
      video_provider: expansion["video"]["provider"],
      gallery: expansion["gallery"],
      publisher: expansion["publisher"],
      is_discounted: expansion["isDiscounted"],
      is_wishlistable: expansion["isWishlistable"]
    }
  end

  defp price(expansion) do
    expansion["price"]["amount"]
    |> Float.parse()
    |> case do
      {float, _} -> float
      :error -> :error
    end
  end

  defp release_date(expansion) do
    expansion["releaseDate"]
    |> case do
      nil ->
        nil

      unix ->
        unix
        |> DateTime.from_unix!()
        |> DateTime.to_date()
    end
  end

  defp global_release_date(expansion) do
    expansion["globalReleaseDate"]
    |> case do
      nil ->
        nil

      unix ->
        unix
        |> DateTime.from_unix!()
        |> DateTime.to_date()
    end
  end
end
