module App.Data.User exposing (..)

import App.Data.Role as Role exposing (Role)
import App.Data.Username as Username exposing (Username)
import Codec exposing (Codec)
import Codec.Extra
import String.Nonempty exposing (NonemptyString)


type alias User =
    { username : Username
    , password : NonemptyString
    , role : Role
    }


toString : User -> String
toString data =
    Username.toString data.username ++ " (" ++ Role.toString data.role ++ ")"


codec : Codec User
codec =
    Codec.object User
        |> Codec.field "username" .username Username.codec
        |> Codec.field "password" .password Codec.Extra.nonEmptyString
        |> Codec.field "role" .role Role.codec
        |> Codec.buildObject
