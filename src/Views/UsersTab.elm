module Views.UsersTab exposing (usersTab, label)

import Html exposing (Html, text, div, img, ul, li, span, button, h2)
import Material
import Model exposing (..)
import Update exposing (..)
import Material.Tabs as Tabs
import List.Extra exposing (find)
import Views.NewUserForm as NewUserForm
import Views.Shared exposing (tab, tabLabel, itemList, detailsItemlist, detailsListItem, listItem)


userListItem : Material.Model -> User -> Html Msg
userListItem mdl { name } =
    listItem mdl (SelectUser name) (name) (DeleteUser name) False


userList : Model -> Html Msg
userList { users, mdl } =
    itemList "Users" (List.map (userListItem mdl) users)


userGroups : Model -> User -> List (Html Msg)
userGroups model user =
    List.map (selectableGroup model user) (List.map .name model.groups)


userDetails : Model -> User -> Html Msg
userDetails model user =
    detailsItemlist model user.name (userGroups model user)


selectedUser : Model -> Html Msg
selectedUser model =
    model.users
        |> find (nameEquals model.selectedUser)
        |> Maybe.map (userDetails model)
        |> Maybe.withDefault (text "")


selectableGroup : Model -> User -> String -> Html Msg
selectableGroup model user groupname =
    detailsListItem model
        groupname
        (ToggleUserGroup user.name groupname)
        (List.member groupname user.groups)


usersTab : Model -> Html Msg
usersTab model =
    tab (NewUserForm.render model) (userList model) (selectedUser model)


label : Model -> Tabs.Label Msg
label model =
    tabLabel model "person_pin_circle" "Users"
