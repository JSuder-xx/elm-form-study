module Form.Field.Options exposing (..)

import Form.Field.Options.Option as Option exposing (mkOption)
import Form.Field.Options.Optional exposing (Optional(..))
import Html


type alias OptionsMapping a =
    List ( String, a )


mappingFromList : (a -> String) -> List a -> OptionsMapping a
mappingFromList =
    List.map << mkOption


map : (a -> b) -> OptionsMapping a -> OptionsMapping b
map =
    List.map << Option.map


toOptionalMapping : String -> OptionsMapping a -> OptionsMapping (Optional a)
toOptionalMapping blank =
    map ValueSelected >> List.append [ ( blank, BlankSelected { display = blank } ) ]


type alias RenderOption parsed msg =
    parsed -> ( List (Html.Attribute msg), String )


renderOption :
    List (Html.Attribute msg)
    -> (parsed -> String)
    -> RenderOption parsed msg
renderOption attributes toString parsed =
    ( attributes, toString parsed )
