module App.Form.Username exposing (field)

import App.Data.Username as Username
import Form
import Form.Field as Field
import Form.Field.App exposing (requiredText, withInitialValue_)
import Form.FieldView exposing (Input)
import Form.Validation exposing (Field)


field :
    Form.Form String (Field String Username.Username Input -> combineAndView) parsedCombined (Maybe { a | username : Username.Username })
    -> Form.Form String combineAndView parsedCombined (Maybe { a | username : Username.Username })
field =
    Form.field "username"
        (requiredText
            |> Field.validateMap Username.fromString
            |> withInitialValue_ "" (Username.toString << .username)
        )
