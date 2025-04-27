module App.Form.Signup exposing (form)

import App.Data.Role as Role
import App.Data.User exposing (User)
import App.Form.Username
import Form
import Form.Extra
import Form.Field as Field
import Form.Field.App as FieldApp
import Form.FieldView.App as FieldView
import Form.Validation as Validation
import Form.Validation.Extra as Validation


form : Form.HtmlForm String User (Maybe User) msg
form =
    (\username password passwordConfirmation role ->
        { combine =
            Validation.succeed User
                |> Validation.andMap username
                |> Validation.andMap
                    (Validation.map2
                        (\passwordValue passwordConfirmationValue ->
                            Validation.succeed passwordValue
                                |> Validation.withErrorIf (passwordValue /= passwordConfirmationValue) passwordConfirmation "Must match password"
                        )
                        password
                        passwordConfirmation
                        |> Validation.join
                    )
                |> Validation.andMap role
        , view =
            \formState ->
                let
                    inputView =
                        FieldView.nonCheckboxInput formState

                    selectView =
                        FieldView.selectWithBlank formState
                in
                [ inputView "Username" username
                , inputView "Password" password
                , inputView "Password Confirmation" passwordConfirmation
                , selectView Role.toString "Role" role
                , Form.Extra.submitButton formState { action = "Sign Up", inProgress = "Signing Up..." }
                ]
        }
    )
        |> Form.form
        |> App.Form.Username.field
        |> Form.field "password" (Field.password FieldApp.requiredText)
        |> Form.field "password-confirmation" (Field.password FieldApp.requiredText)
        |> Form.field "role" (FieldApp.selectWithBlank Role.toString Role.allRoles |> FieldApp.requireOption)
