module App.Data.User exposing (..)

import App.Data.Role as Role exposing (Role)
import App.Data.Username as Username exposing (Username)
import String.Nonempty exposing (NonemptyString)


type alias User =
    { username : Username
    , password : NonemptyString
    , role : Role
    }


toString : User -> String
toString data =
    Username.toString data.username ++ " (" ++ Role.toString data.role ++ ")"
