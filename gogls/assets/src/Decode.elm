module Decode exposing (..)

import Json.Decode as Decode exposing (Decoder, field, float, maybe, string)
import Types exposing (Game)


game : Decoder Game
game =
    Decode.map5 Game
        (field "id" string)
        (field "slug" string)
        (field "title" string)
        (field "price" float)
        (maybe (field "image" string))
