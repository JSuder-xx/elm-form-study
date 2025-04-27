module Form.FieldView.App exposing (checkboxInput, nonCheckboxInput, select, selectWithBlank)

import Form
import Form.Field.Options as Options
import Form.Field.Options.Optional as Optional exposing (Optional)
import Form.FieldView as FieldView
import Form.Validation as Validation
import Html exposing (Html)
import Pico.Form
import String.Nonempty exposing (NonemptyString)


nonCheckboxInput : Form.Context String input -> String -> Validation.Field String parsed FieldView.Input -> Html.Html msg
nonCheckboxInput =
    labelBeforeView FieldView.input


checkboxInput : Form.Context String input -> String -> Validation.Field String parsed FieldView.Input -> Html.Html msg
checkboxInput =
    labelAfterView FieldView.input


select : Form.Context String input -> (parsed -> String) -> String -> Validation.Field String parsed2 (FieldView.Options parsed) -> Html msg
select context f =
    labelBeforeView (\attrs -> FieldView.select attrs <| Options.renderOption [] f) context


selectWithBlank : Form.Context String input -> (a -> String) -> String -> Validation.Field String parsed2 (FieldView.Options (Optional a)) -> Html msg
selectWithBlank context f =
    select context (Optional.toString f)



-- INTERNAL


errorSummaryIdentifier : Validation.Field error parsed kind -> String
errorSummaryIdentifier =
    String.append "error-" << Validation.fieldName


toError : Form.Context String input -> Validation.Field String parsed kind -> Maybe NonemptyString
toError context field =
    if context.submitAttempted || Validation.statusAtLeast Validation.Blurred field then
        Form.errorsForField field context.errors |> String.join ", " |> String.Nonempty.fromString

    else
        Nothing


labelView :
    (String -> Validation.Field String parsed kind -> List (Html.Attribute msg) -> List (Html msg))
    -> Form.Context String input
    -> String
    -> Validation.Field String parsed kind
    -> Html msg
labelView renderField context label field =
    Html.label [] <|
        Pico.Form.fieldWithError
            { errorIdentifier = errorSummaryIdentifier field
            , error = toError context field
            , field = renderField label field
            }


labelBeforeView : (List (Html.Attribute msg) -> Validation.Field String parsed kind -> Html msg) -> Form.Context String input -> String -> Validation.Field String parsed kind -> Html msg
labelBeforeView renderField =
    labelView <| \label field attrs -> [ Html.text <| label ++ " ", renderField attrs field ]


labelAfterView : (List (Html.Attribute msg) -> Validation.Field String parsed kind -> Html msg) -> Form.Context String input -> String -> Validation.Field String parsed kind -> Html msg
labelAfterView renderField =
    labelView <| \label field attrs -> [ renderField attrs field, Html.text label ]
