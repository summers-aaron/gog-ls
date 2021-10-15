module Page.Index.Query exposing (..)

import Decode
import GraphQl as GraphQl exposing (Operation, Query, Variables)
import GraphQl.Http
import Http exposing (Error)
import Json.Decode as D exposing (Decoder, field)
import Types exposing (Game)


type alias GamesResult =
    Result Error GamesResponse


type alias GamesResponse =
    { games : List Game }


decodeGames : Decoder GamesResponse
decodeGames =
    D.map GamesResponse
        (field "games" (D.list Decode.game))


gamesRequest : Operation Query Variables
gamesRequest =
    GraphQl.named "GetGames"
        [ GraphQl.field "games"
            |> GraphQl.withSelectors
                [ GraphQl.field "id"
                , GraphQl.field "slug"
                , GraphQl.field "title"
                , GraphQl.field "image"
                , GraphQl.field "price"
                ]
        ]
        |> GraphQl.withVariables []


listGames : (GamesResult -> msg) -> Cmd msg
listGames msg =
    GraphQl.query gamesRequest
        |> GraphQl.Http.send
            { url = "http://localhost:4000/api/graphiql", headers = [] }
            msg
            decodeGames
