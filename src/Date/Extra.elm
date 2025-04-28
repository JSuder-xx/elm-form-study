module Date.Extra exposing (..)

import Codec
import Codec.Extra
import Date


codec : Codec.Codec Date.Date
codec =
    Codec.string |> Codec.andThen (Date.fromIsoString >> Codec.Extra.fromResult) Date.toIsoString
