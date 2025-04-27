module Pico.Components exposing (..)

import Html exposing (details, summary)
import Html.Attributes as Attributes


accordion : String -> Html.Html msg -> Html.Html msg
accordion header form =
    details []
        [ summary [ Attributes.attribute "role" "button", Attributes.class "outline" ] [ Html.text header ]
        , form
        ]
