module Views.Shared exposing (..)

import Html exposing (Html, text, div, h2, span)
import Update exposing (Msg)
import Material.Grid exposing (grid, cell, size, Device(..))
import Html.Events exposing (onClick)
import Html.Attributes exposing (disabled)
import Material
import Model exposing (..)
import Update exposing (..)
import Material.Button as Button
import Material.Options as Options
import Material.Tabs as Tabs
import Material.Icon as Icon
import Material.Toggles as Toggles
import Material.List


tab : List (Html Msg) -> Html Msg -> Html Msg -> Html Msg
tab newForm list selectedItem =
    grid
        []
        [ cell [ size All 12 ] newForm
        , cell [ size Desktop 5, size Tablet 12, size Phone 12 ] [ list ]
        , cell [ size Desktop 7, size Tablet 12, size Phone 12 ] [ selectedItem ]
        ]


tabLabel : Model -> String -> String -> Tabs.Label Msg
tabLabel model icon caption =
    Tabs.label
        [ Options.center ]
        [ Icon.i icon
        , Options.span [ Options.css "width" "4px" ] []
        , text caption
        ]


itemList : String -> List (Html Msg) -> Html Msg
itemList heading items =
    div []
        [ h2
            [ Html.Attributes.style [ ( "text-align", "left" ) ] ]
            [ text heading ]
        , if (not (List.isEmpty items)) then
            Material.List.ul [ Options.css "background-color" "#bdbdbd" ] items
          else
            text ""
        ]


detailsItemlist : Model -> String -> List (Html Msg) -> Html Msg
detailsItemlist model title items =
    div []
        [ Html.h2 []
            [ text title ]
        , Material.List.ul []
            items
        ]


detailsListItem : Model -> String -> Msg -> Bool -> Html Msg
detailsListItem model itemname onToggle checked =
    Material.List.li []
        [ Material.List.content [] [ text itemname ]
        , Material.List.content2 []
            [ Toggles.checkbox Mdl
                [ 4 ]
                model.mdl
                [ Options.onToggle onToggle
                , Toggles.value checked
                ]
                []
            ]
        ]


listItem : Material.Model -> Msg -> String -> Msg -> Bool -> Html Msg
listItem mdl onClickSelect label onClickDelete disabled =
    Material.List.li
        [ Options.attribute <| onClick onClickSelect ]
        [ span [ Html.Attributes.style [ ( "margin-right", "10px" ) ] ] [ text label ]
        , Button.render Mdl
            [ 0 ]
            mdl
            [ Button.icon
            , Button.colored
            , Options.onClick onClickDelete
            , Options.disabled disabled
            ]
            [ Icon.i "delete" ]
        ]
