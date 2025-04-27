module App.Data.Stay exposing (..)

import Date exposing (Date)
import Form.Field exposing (TimeOfDay)
import String.Nonempty exposing (NonemptyString)


type alias Stay =
    { name : NonemptyString
    , checkIn : Checkin
    , emailUpdates : Bool
    }


type alias Checkin =
    { date : Date
    , nights : Int
    , time : TimeOfDay
    }


toString : Stay -> String
toString { name } =
    String.Nonempty.toString name
