module Form.Extra exposing (..)

import Form
import Html exposing (Html)
import Html.Attributes


submitButton : Form.Context error input -> { action : String, inProgress : String } -> Html msg
submitButton { submitting } { action, inProgress } =
    if submitting then
        Html.button
            [ Html.Attributes.disabled True ]
            [ Html.text inProgress ]

    else
        Html.button [] [ Html.text action ]
