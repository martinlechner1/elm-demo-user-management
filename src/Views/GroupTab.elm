module Views.GroupTab exposing (groupsTab, label)

import Html exposing (Html, text, div, img, ul, li, span, button, h2)
import Material
import Model exposing (..)
import Update exposing (..)
import Material.Tabs as Tabs
import List.Extra exposing (find)
import Views.NewGroupForm as NewGroupForm
import Views.Shared exposing (tab, tabLabel, itemList, detailsItemlist, detailsListItem, listItem)


groupListItem : Material.Model -> Group -> Html Msg
groupListItem mdl group =
    listItem mdl
        (SelectGroup group.name)
        (String.concat [ group.name, "(", (toString (List.length group.users)), ")" ])
        (DeleteGroup group.name)
        (not (List.isEmpty group.users))


selectableUser : Model -> Group -> String -> Html Msg
selectableUser model group username =
    detailsListItem model username (ToggleUserGroup username group.name) (List.member username group.users)


groupList : Model -> Html Msg
groupList model =
    itemList "Groups" (List.map (groupListItem model.mdl) model.groups)


groupUsers : Model -> Group -> List (Html Msg)
groupUsers model group =
    (List.map (selectableUser model group) (List.map .name model.users))


groupDetails : Model -> Group -> Html Msg
groupDetails model group =
    detailsItemlist model group.name (groupUsers model group)


selectedGroup : Model -> Html Msg
selectedGroup model =
    model.groups
        |> find (nameEquals model.selectedGroup)
        |> Maybe.map (groupDetails model)
        |> Maybe.withDefault (text "")


groupsTab : Model -> Html Msg
groupsTab model =
    tab (NewGroupForm.render model) (groupList model) (selectedGroup model)


label : Model -> Tabs.Label Msg
label model =
    tabLabel model "group_work" "Groups"
