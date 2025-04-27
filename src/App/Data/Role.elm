module App.Data.Role exposing (..)


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
