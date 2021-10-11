defmodule Mix.Tasks.Gogls.Movies.Get do
  alias Gogls.Media.Movie

  defp to_map(movie) do
    %{
      studio: movie["developer"],
      title: movie["title"],
      category: movie["category"],
      available: movie["buyable"],
      original_category: movie["originalCategory"],
      image: movie["image"],
      slug: movie["slug"],
      rating: movie["rating"],
      gog_id: movie["id"],
      genres: movie["genres"],
      price: price(movie),
      is_coming_soon: movie["isComingSoon"],
      is_price_visible: movie["isPriceVisible"],
      age_requirement: movie["ageLimit"],
      release_date: release_date(movie),
      support_url: movie["supportUrl"],
      forum_url: movie["forumUrl"],
      global_release_date: global_release_date(movie),
      video_url: movie["video"]["id"],
      video_provider: movie["video"]["provider"],
      gallery: movie["gallery"],
      publisher: movie["publisher"],
      is_discounted: movie["isDiscounted"],
      is_wishlistable: movie["isWishlistable"]
    }
  end

  defp price(movie) do
    movie["price"]["amount"]
    |> Float.parse()
    |> case do
      {float, _} -> float
      :error -> :error
    end
  end

  defp release_date(movie) do
    movie["releaseDate"]
    |> case do
      nil ->
        nil

      unix ->
        unix
        |> DateTime.from_unix!()
        |> DateTime.to_date()
    end
  end

  defp global_release_date(movie) do
    movie["globalReleaseDate"]
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
