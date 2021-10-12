module Page.Index.Main exposing (main)

import Browser
import Game
import Html exposing (..)
import Html.Attributes as Attributes exposing (class, for, href, id, placeholder, src, step, type_, value)
import Html.Events exposing (onInput)
import List
import Page.Index.Query as Query
import Types exposing (Game)



-- MODEL


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Flags =
    { title : String }


type alias Model =
    { pageTitle : String
    , maxPrice : Int
    , minPrice : Int
    , search : String
    , games : List Game
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { search = ""
      , maxPrice = 1000
      , minPrice = 0
      , pageTitle = flags.title
      , games = []
      }
    , Query.listGames GamesLoaded
    )



-- UPDATE


type Msg
    = SearchInput String
    | MaxPriceInput String
    | MinPriceInput String
    | GamesLoaded Query.GamesResult


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchInput string ->
            ( { model | search = string }, Cmd.none )

        MaxPriceInput price ->
            ( { model | maxPrice = String.toInt price |> Maybe.withDefault 0 }, Cmd.none )

        MinPriceInput price ->
            ( { model | minPrice = String.toInt price |> Maybe.withDefault 0 }, Cmd.none )

        GamesLoaded result ->
            case result of
                Ok games ->
                    ( { model | games = games.games }, Cmd.none )

                -- TODO impletment error toast
                Err e ->
                    let
                        _ =
                            Debug.log "Error" e
                    in
                    ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Gogls | " ++ model.pageTitle
    , body = body model
    }


body : Model -> List (Html Msg)
body model =
    [ header
        [ class "nav" ]
        [ div
            []
            [ div
                [ class "container" ]
                [ text "GOGLS" ]
            ]
        ]
    , main_
        [ class "container" ]
        [ div
            [ class "search container" ]
            [ select
                [ class "select-filter" ]
                searchOptions
            , input
                [ id "search"
                , type_ "text"
                , onInput SearchInput
                , value model.search
                , placeholder "Searching for..."
                ]
                [ label
                    []
                    [ text "games" ]
                ]
            ]
        , div
            [ class "container is-fluid index" ]
            [ div
                [ class "filters" ]
                [ div
                    []
                    [ rangeInput model
                    , filterSet "Features" featureFilters
                    , filterSet "System" systemFilters
                    , filterSet "Language" languageFilters
                    ]
                ]
            , div
                [ class "games" ]
                (List.map gameCard model.games)
            ]
        ]
    , footer [] []
    ]


searchOptions : List (Html msg)
searchOptions =
    let
        option_ value =
            option [] [ text value ]
    in
    List.map option_ [ "All Games", "Movies", "DLC" ]


filterSet : String -> List String -> Html Msg
filterSet groupName filters =
    fieldset
        []
        (legend
            []
            [ text groupName ]
            :: List.map filterCheckbox filters
        )



-- TODO make range input dynamic


rangeInput : Model -> Html Msg
rangeInput model =
    p
        []
        [ label
            [ for "range" ]
            [ text "Price" ]
        , text "min"
        , input
            [ id "range"
            , type_ "range"
            , Attributes.max "1000"
            , Attributes.min "0"
            , step "1"
            , value (String.fromInt model.minPrice)
            , onInput MinPriceInput
            ]
            []
        , text "max"
        , input
            [ id "range"
            , type_ "range"
            , Attributes.max "1000"
            , Attributes.min "0"
            , step "1"
            , value (String.fromInt model.maxPrice)
            , onInput MaxPriceInput
            ]
            []
        ]


filterCheckbox : String -> Html Msg
filterCheckbox filterName =
    let
        id_ =
            "option-" ++ filterName
    in
    div
        [ class "checkbox" ]
        [ input
            [ id id_
            , type_ "checkbox"
            , value filterName
            ]
            []
        , label
            [ for id_
            ]
            [ text filterName ]
        ]


featureFilters : List String
featureFilters =
    [ "Single-player"
    , "Multi-player"
    , "Co-op"
    , "Achievements"
    , "Leaderboards"
    , "Controller Support"
    , "In Development"
    , "Cloud Saves"
    , "Overlay"
    ]


systemFilters : List String
systemFilters =
    [ "Windows"
    , "OSX"
    , "Linux"
    ]


languageFilters : List String
languageFilters =
    [ "English"
    , "Deutsch"
    , "Français"
    , "Español"
    , "Italiano"
    ]


gameCard : Game -> Html Msg
gameCard game =
    div
        [ class "card" ]
        [ img
            -- Use a static image from GOG for testing
            [ src <| Game.imageUrl game ]
            []
        , div
            [ class "card-description" ]
            [ a
                [ href <| Game.slug game ]
                [ text game.title ]
            , div
                [ class "price" ]
                [ text ("$" ++ String.fromFloat game.price) ]
            ]
        ]
