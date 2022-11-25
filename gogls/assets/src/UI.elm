module UI exposing (layout)

import Gen.Route as Route exposing (Route)
import Html exposing (Html, a, div, header, input, li, main_, text, ul)
import Html.Attributes exposing (class, classList, href)
import Shared


layout : Route -> List (Html msg) -> List (Html msg)
layout route children =
    [ header
        []
        [ div [ class "navbar" ]
            [ div [ class "logo" ] [ text "" ]
            , div
                [ class "nav-tabs" ]
                [ navTab "Home" Route.Home_ route
                , navTab "Dashboard" Route.Dashboard route
                , navTab "Schedule" Route.Schedule route
                , navTab "Clients" Route.Clients route
                , navTab "Financials" Route.Financials route
                ]
            , div [] [ input [ class "search" ] [] ]
            ]
        ]
    , main_
        [ class "main" ]
        [ div
            [ class "sidebar" ]
            [ ul
                [ class "is-unstyled" ]
                [ li
                    []
                    [ text "Testing" ]
                ]
            ]
        , div
            [ class "container" ]
            children
        ]
    ]


navTab : String -> Route -> Route -> Html msg
navTab label route currentRoute =
    let
        classes =
            classList [ ( "tab", True ), ( "enabled", route == currentRoute ) ]
    in
    div [ classes ] [ viewLink label route ]


viewLink : String -> Route -> Html msg
viewLink label route =
    a [ href (Route.toHref route) ] [ Html.text label ]
