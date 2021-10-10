module Page.Index exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onInput)



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
    , div
        [ class "container is-fluid" ]
        [ input
            [ type_ "text"
            , onInput SearchInput
            , value model.search
            ]
            []
        ]
    ]
