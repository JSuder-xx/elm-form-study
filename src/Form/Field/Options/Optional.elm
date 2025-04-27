module Form.Field.Options.Optional exposing (..)


type Optional a
    = BlankSelected { display : String }
    | ValueSelected a


toString : (a -> String) -> Optional a -> String
toString f optional =
    case optional of
        BlankSelected { display } ->
            display

        ValueSelected v ->
            f v


toResult : Optional a -> Result String a
toResult optional =
    case optional of
        BlankSelected _ ->
            Err "Required"

        ValueSelected x ->
            Ok x
