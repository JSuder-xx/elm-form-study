module Main exposing (main)

import App.Data.Stay as Stay exposing (Stay)
import App.Data.User as User exposing (User)
import App.Form.Signup as Signup
import App.Form.Stay as Stay
import Browser
import Form
import Html
import Pico.Components
import Pico.Layout
import Process
import Task


type Msg
    = FormMsg (Form.Msg Msg)
    | OnSubmitSignup (Form.Validated String User)
    | OnSubmitCheckin (Form.Validated String Stay)
    | SimulatedSubmitComplete String


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { formState : Form.Model
    , signingUp : Bool
    , checkingIn : Bool
    , received : List String
    }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { formState = Form.init
      , signingUp = False
      , checkingIn = False
      , received = []
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnSubmitSignup parsed ->
            case parsed of
                Form.Valid data ->
                    ( { model | signingUp = True }
                    , Process.sleep 600
                        |> Task.perform
                            (\() -> SimulatedSubmitComplete <| User.toString data)
                    )

                Form.Invalid _ _ ->
                    ( model, Cmd.none )

        OnSubmitCheckin parsed ->
            case parsed of
                Form.Valid data ->
                    ( { model | checkingIn = True }
                    , Process.sleep 600
                        |> Task.perform
                            (\() -> SimulatedSubmitComplete <| Stay.toString data)
                    )

                Form.Invalid _ _ ->
                    ( model, Cmd.none )

        SimulatedSubmitComplete data ->
            ( { model
                | signingUp = False
                , checkingIn = False
                , received = data :: model.received
              }
            , Cmd.none
            )

        FormMsg formMsg ->
            let
                ( updatedFormModel, cmd ) =
                    Form.update formMsg model.formState
            in
            ( { model | formState = updatedFormModel }, cmd )


view : Model -> Browser.Document Msg
view model =
    { title = "Elm Form Study"
    , body =
        Pico.Layout.simpleBody
            [ Pico.Components.accordion "Sign Up"
                (Signup.form
                    |> Form.renderHtml
                        { submitting = model.signingUp
                        , state = model.formState
                        , toMsg = FormMsg
                        }
                        (Form.options "signUp"
                            |> Form.withOnSubmit (\{ parsed } -> OnSubmitSignup parsed)
                            |> Form.withInput Nothing
                        )
                        []
                )
            , Pico.Components.accordion "Check In"
                (Stay.form
                    |> Form.renderHtml
                        { submitting = model.checkingIn
                        , state = model.formState
                        , toMsg = FormMsg
                        }
                        (Form.options "checkin"
                            |> Form.withOnSubmit (\{ parsed } -> OnSubmitCheckin parsed)
                        )
                        []
                )
            , model.received
                |> List.map
                    (\data ->
                        Html.li []
                            [ Html.pre [] [ Html.text data ] ]
                    )
                |> Html.ul []
            ]
    }
