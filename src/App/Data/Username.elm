module App.Data.Username exposing (Username, codec, fromString, toString)

import Codec exposing (Codec)
import Codec.Extra
import String.Nonempty exposing (NonemptyString)


type Username
    = Username NonemptyString


fromString : NonemptyString -> Result String Username
fromString string =
    if string |> String.Nonempty.contains "@" then
        Err "Must not contain @"

    else
        Username string |> Ok


toNonemptyString : Username -> NonemptyString
toNonemptyString (Username username) =
    username


toString : Username -> String
toString =
    toNonemptyString >> String.Nonempty.toString


codec : Codec Username
codec =
    Codec.Extra.nonEmptyString |> Codec.andThen (fromString >> Codec.Extra.fromResult) toNonemptyString
