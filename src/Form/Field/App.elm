module Form.Field.App exposing (..)

import Codec exposing (Codec)
import Date exposing (Date)
import Form.Field as Field exposing (Field, No, TimeOfDay, withInitialValue)
import Form.Field.Options as Options
import Form.Field.Options.Optional as Optional exposing (Optional)
import Form.FieldView exposing (Input, Options)
import Maybe.Extra
import String.Nonempty


withInitialValue_ :
    initial
    -> (input -> initial)
    -> Field error value (Maybe input) initial kind constraints
    -> Field error value (Maybe input) initial kind constraints
withInitialValue_ default accessor =
    withInitialValue <| Maybe.Extra.unwrap default accessor


required :
    Field
        String
        (Maybe parsed)
        kind
        input
        initial
        { constraints
            | required : ()
            , wasMapped : No
        }
    -> Field String parsed kind input initial { constraints | wasMapped : No }
required =
    Field.required "Required"


requiredText : Field String String.Nonempty.NonemptyString input String Input { maxlength : (), plainText : (), wasMapped : Field.Yes }
requiredText =
    Field.text
        |> required
        |> Field.withMinLength 1 "Required"
        |> Field.validateMap (String.Nonempty.fromString >> Result.fromMaybe "Ah!!!")


select : List ( String, input ) -> Field String input kind input (Options input) { wasMapped : No }
select options =
    Field.select
        options
        (\_ -> "Invalid")
        |> required


selectWithBlank : (a -> String) -> List a -> Field String (Optional a) kind (Optional a) (Options (Optional a)) { wasMapped : No }
selectWithBlank toString options =
    select (Options.toOptionalMapping "" <| Options.mappingFromList toString options)


requireOption : Field String (Optional a) input initial kind constraints -> Field String a input initial kind { constraints | wasMapped : Field.Yes }
requireOption =
    Field.validateMap <|
        \optionalOption ->
            case optionalOption of
                Optional.BlankSelected _ ->
                    Err "Required"

                Optional.ValueSelected x ->
                    Ok x


date : Field String (Maybe Date) input Date Input { min : Date, max : Date, required : (), wasMapped : No, step : Int }
date =
    Field.date { invalid = \_ -> "Invalid date" }


time : Field String (Maybe Field.TimeOfDay) input Field.TimeOfDay Input { min : Field.TimeOfDay, max : Field.TimeOfDay, required : (), wasMapped : No, step : Int }
time =
    Field.time { invalid = \_ -> "Invalid time" }


timeOfDayCodec : Codec TimeOfDay
timeOfDayCodec =
    Codec.object TimeOfDay
        |> Codec.field "hours" .hours Codec.int
        |> Codec.field "minutes" .minutes Codec.int
        |> Codec.field "seconds" .seconds (Codec.nullable Codec.int)
        |> Codec.buildObject
