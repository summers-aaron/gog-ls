module UI exposing (layout)

import Effect exposing (fromShared)
import Gen.Route as Route exposing (Route)
import Html exposing (Html, a, button, div, header, main_, text)
import Html.Attributes exposing (class, href)


layout : List (Html msg) -> List (Html msg)
layout children =
    let
        viewLink : String -> Route -> Html msg
        viewLink label route =
            a [ class "is-initial tab button enabled", href (Route.toHref route) ] [ Html.text label ]
    in
    [ header
        []
        [ div [ class "nav" ]
            [ div
                [ class "nav-tabs" ]
                [ viewLink "Home" Route.Home_
                , viewLink "Dashboard" Route.Clients
                , viewLink "Schedule" Route.Clients
                , viewLink "Flow" Route.Clients
                , viewLink "Clients" Route.Clients
                , viewLink "Financials" Route.Clients
                ]
            ]
        ]

    -- [ viewLink "Home" Route.Home_
    -- , viewLink "Clients" Route.Clients
    -- ]
    , main_ [ class "main" ] children
    ]
