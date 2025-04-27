module Pico.Form exposing (..)

import Accessibility.Aria as Aria
import Html exposing (Attribute, Html, small)
import Html.Attributes as Attributes
import Maybe.Extra
import String.Nonempty exposing (NonemptyString)


fieldWithError : { errorIdentifier : String, error : Maybe NonemptyString, field : List (Attribute msg) -> List (Html msg) } -> List (Html msg)
fieldWithError config =
    config.error
        |> Maybe.Extra.unpack
            (\_ -> config.field [])
            (\error ->
                config.field
                    [ Aria.invalid True
                    , Aria.describedBy [ config.errorIdentifier ]
                    ]
                    ++ [ small [ Attributes.id config.errorIdentifier ]
                            [ Html.text <| String.Nonempty.toString error ]
                       ]
            )
