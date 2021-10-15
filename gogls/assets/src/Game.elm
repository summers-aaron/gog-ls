module Game exposing (..)

import Types exposing (Game)


imageUrl : Game -> String
imageUrl game =
    -- GOG doesn't supply the file extension. It seems to always be a .jpg
    "https:" ++ (game.image |> Maybe.withDefault "") ++ ".jpg"


slug : Game -> String
slug game =
    "https://www.gog.com/game/" ++ game.slug
