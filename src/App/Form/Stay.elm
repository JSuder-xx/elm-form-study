module App.Form.Stay exposing (form)

import App.Data.Stay exposing (Stay)
import Date exposing (Date)
import Form
import Form.Extra
import Form.Field as Field
import Form.Field.App exposing (required, requiredText)
import Form.FieldView.App as FieldView
import Form.Validation as Validation
import Form.Validation.Extra as Validation
import Html
import Html.Attributes


form : Form.HtmlForm String Stay input msg
form =
    (\name checkIn checkOut checkInTime emailUpdates ->
        { combine =
            Validation.succeed Stay
                |> Validation.andMap name
                |> Validation.andMap
                    (Validation.map3
                        (\checkinValue checkoutValue checkInTimeValue ->
                            Validation.succeed
                                { date = checkinValue
                                , nights = Date.toRataDie checkoutValue - Date.toRataDie checkinValue
                                , time = checkInTimeValue
                                }
                                |> Validation.withErrorIf (Date.toRataDie checkinValue >= Date.toRataDie checkoutValue) checkIn "Must be before checkout"
                        )
                        checkIn
                        checkOut
                        checkInTime
                        |> Validation.join
                    )
                |> Validation.andMap emailUpdates
        , view =
            \formState ->
                let
                    inputView =
                        FieldView.nonCheckboxInput formState

                    checkboxView =
                        FieldView.checkboxInput formState
                in
                [ inputView "Name" name
                , inputView "Check-In" checkIn
                , inputView "Check-Out" checkOut
                , inputView "Check-In Time" checkInTime
                , checkboxView "Sign Up For Email Updates" emailUpdates
                , Form.Extra.submitButton formState { action = "Check In", inProgress = "Checking In..." }
                ]
        }
    )
        |> Form.form
        |> Form.field "name" requiredText
        |> Form.field "checkin"
            (Field.date
                { invalid = \_ -> "Invalid" }
                |> required
                |> Field.withMin today ("Must be after " ++ Date.toIsoString today)
            )
        |> Form.field "checkout"
            (Field.date
                { invalid = \_ -> "Invalid" }
                |> required
            )
        |> Form.field "checkinTime"
            (Field.time
                { invalid = \_ -> "Invalid" }
                |> required
                |> Field.withMin { hours = 10, minutes = 0, seconds = Nothing } "Must be after today"
            )
        |> Form.field "emailUpdates" Field.checkbox


today : Date
today =
    Date.fromRataDie 738624
