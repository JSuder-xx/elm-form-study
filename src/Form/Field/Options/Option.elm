module Form.Field.Options.Option exposing (..)


type alias Option a =
    ( String, a )


mkOption : (a -> String) -> a -> Option a
mkOption f a =
    ( f a, a )


map : (b -> y) -> ( a, b ) -> ( a, y )
map =
    Tuple.mapSecond
