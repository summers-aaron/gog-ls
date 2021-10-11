module Page.Index exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as Attributes exposing (class, for, id, placeholder, src, step, type_, value)
import Html.Events exposing (onInput)
import List



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
    , search : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { search = ""
      , pageTitle = flags.title
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = SearchInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchInput string ->
            ( { model | search = string }, Cmd.none )



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
                    [ rangeInput
                    , filterSet "Features" featureFilters
                    , filterSet "System" systemFilters
                    , filterSet "Language" languageFilters
                    ]
                ]
            , div
                [ class "games" ]
                testGamesList
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


rangeInput : Html Msg
rangeInput =
    p
        []
        [ label
            [ for "range" ]
            [ text "Price" ]
        , text "min"
        , input
            [ id "range"
            , type_ "range"
            , Attributes.max "0"
            , Attributes.min "1000"
            , step "1"
            ]
            []
        , text "max"
        , input
            [ id "range"
            , type_ "range"
            , Attributes.max "0"
            , Attributes.min "1000"
            , step "1"
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


testGamesList : List (Html Msg)
testGamesList =
    [ gameCard
    , gameCard
    , gameCard
    , gameCard
    , gameCard
    , gameCard
    , gameCard
    , gameCard
    , gameCard
    , gameCard
    , gameCard
    ]


gameCard : Html Msg
gameCard =
    div
        [ class "card" ]
        [ img
            -- Use a static image from GOG for testing
            [ src "" ]
            []
        , div
            [ class "card-description" ]
            [ div
                []
                [ text "The Elder Scrolls III: Morrowind GOTY Edition" ]
            , div
                [ class "price" ]
                [ text "$19.99" ]
            ]
        ]
