module Types exposing (..)


type alias Game =
    { id : String
    , slug : String
    , title : String
    , price : Float
    , image : Maybe String
    }
