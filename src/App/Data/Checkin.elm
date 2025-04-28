module App.Data.Checkin exposing (..)

import Codec exposing (Codec)
import Date exposing (Date)
import Date.Extra
import Form.Field exposing (TimeOfDay)
import Form.Field.App


type alias Checkin =
    { date : Date
    , nights : Int
    , time : TimeOfDay
    }


codec : Codec Checkin
codec =
    Codec.object Checkin
        |> Codec.field "date" .date Date.Extra.codec
        |> Codec.field "nights" .nights Codec.int
        |> Codec.field "time" .time Form.Field.App.timeOfDayCodec
        |> Codec.buildObject
