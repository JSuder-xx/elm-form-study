module App.Data.Stay exposing (..)

import App.Data.Checkin as Checkin exposing (Checkin)
import Codec exposing (Codec)
import Codec.Extra
import String.Nonempty exposing (NonemptyString)


type alias Stay =
    { name : NonemptyString
    , checkIn : Checkin
    , emailUpdates : Bool
    }


toString : Stay -> String
toString { name } =
    String.Nonempty.toString name


codec : Codec Stay
codec =
    Codec.object Stay
        |> Codec.field "name" .name Codec.Extra.nonEmptyString
        |> Codec.field "checkIn" .checkIn Checkin.codec
        |> Codec.field "emailUpdates" .emailUpdates Codec.bool
        |> Codec.buildObject
