module View exposing (..)

import Html exposing (Html, div)
import Material.Scheme
import Model exposing (Model)
import Update exposing (Msg)
import Material.Tabs as Tabs
import Material.Color as Color
import Views.GroupTab as GroupTab
import Views.UsersTab as UsersTab


tabContent : Model -> Html Msg
tabContent model =
    case model.tab of
        0 ->
            UsersTab.usersTab model

        _ ->
            GroupTab.groupsTab model


tabMenu : Model -> Html Msg
tabMenu model =
    Tabs.render Update.Mdl
        [ 0 ]
        model.mdl
        [ Tabs.ripple
        , Tabs.onSelectTab Update.SelectTab
        , Tabs.activeTab model.tab
        ]
        [ UsersTab.label model
        , GroupTab.label model
        ]
        [ tabContent model ]


view : Model -> Html Msg
view model =
    div []
        [ tabMenu model ]
        |> Material.Scheme.topWithScheme Color.Teal Color.Red
