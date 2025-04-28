module App.Data.Role exposing (..)

import Codec
import Codec.Extra


type Role
    = SuperAdmin
    | Admin
    | Regular


allRoles : List Role
allRoles =
    [ Admin, SuperAdmin, Regular ]


toString : Role -> String
toString role =
    case role of
        SuperAdmin ->
            "SuperAdmin"

        Admin ->
            "Admin"

        Regular ->
            "Regular"


codec : Codec.Codec Role
codec =
    Codec.Extra.stringEnum toString allRoles
