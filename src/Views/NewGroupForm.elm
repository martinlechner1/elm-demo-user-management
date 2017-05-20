module Views.NewGroupForm exposing (render)

import Html exposing (Html, text, div, img, ul, li, span, button, h2)
import Model exposing (..)
import Update exposing (..)
import Material.Button as Button
import Material.Options as Options
import Material.Textfield as Textfield


groupExists : Model -> Bool
groupExists model =
    (List.member model.newGroupname (List.map .name model.groups))


newGroupTextInput : Model -> Html Msg
newGroupTextInput model =
    Textfield.render Mdl
        [ 2 ]
        model.mdl
        [ Options.css "margin-right" "10px"
        , Options.onInput NewGroupname
        , Textfield.label "Groupname"
        , Textfield.text_
        , Textfield.floatingLabel
        , Textfield.value model.newGroupname
        , Textfield.error ("Group already exists")
            |> Options.when (groupExists model)
        ]
        []


newGroupSubmitButton : Model -> Html Msg
newGroupSubmitButton model =
    Button.render Mdl
        [ 0 ]
        model.mdl
        [ Button.raised
        , Button.colored
        , Options.onClick CreateGroup
        , Options.disabled (groupExists model)
        ]
        [ text "Add Group" ]


render : Model -> List (Html Msg)
render model =
    [ newGroupTextInput model
    , newGroupSubmitButton model
    ]
