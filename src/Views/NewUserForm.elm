module Views.NewUserForm exposing (render)

import Html exposing (Html, text, div, img, ul, li, span, button, h2)
import Model exposing (..)
import Update exposing (..)
import Material.Button as Button
import Material.Options as Options
import Material.Textfield as Textfield


userExists : Model -> Bool
userExists model =
    (List.member model.newUsername (List.map .name model.users))


newUserTextInput : Model -> Html Msg
newUserTextInput model =
    Textfield.render Mdl
        [ 1 ]
        model.mdl
        [ Options.css "margin-right" "10px"
        , Options.onInput NewUsername
        , Textfield.label "Username"
        , Textfield.text_
        , Textfield.floatingLabel
        , Textfield.value model.newUsername
        , Textfield.error ("User already exists")
            |> Options.when (userExists model)
        ]
        []


newUserSubmitButton : Model -> Html Msg
newUserSubmitButton model =
    Button.render Mdl
        [ 0 ]
        model.mdl
        [ Button.raised
        , Button.colored
        , Options.onClick CreateUser
        , Options.disabled (userExists model)
        ]
        [ text "Add User" ]


render : Model -> List (Html Msg)
render model =
    [ newUserTextInput model
    , newUserSubmitButton model
    ]
