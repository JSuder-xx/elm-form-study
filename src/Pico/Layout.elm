module Pico.Layout exposing (..)

import Html
import Html.Attributes exposing (class)


{-| For the main body of a HTML document.
-}
simpleBody : List (Html.Html msg) -> List (Html.Html msg)
simpleBody x =
    [ Html.main_ [ class "container " ]
        x
    ]
