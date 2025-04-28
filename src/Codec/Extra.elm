module Codec.Extra exposing (..)

import Codec
import Result.Extra
import String.Nonempty exposing (NonemptyString)
import Tuple.Extra


stringEnum : (a -> String) -> List a -> Codec.Codec a
stringEnum toString =
    Codec.enum Codec.string << List.map (Tuple.mapFirst toString << Tuple.Extra.from)


fromResult : Result String a -> Codec.Codec a
fromResult =
    Result.Extra.unpack Codec.fail Codec.succeed


nonEmptyString : Codec.Codec NonemptyString
nonEmptyString =
    Codec.string
        |> Codec.andThen
            (String.Nonempty.fromString >> Result.fromMaybe "Must be non-empty" >> fromResult)
            String.Nonempty.toString
