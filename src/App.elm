module App exposing (..)

import Html
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Material


init : String -> ( Model, Cmd Msg )
init path =
    ( { users = [ { name = "Andy", groups = [ "MunichJS" ] }, { name = "Martin", groups = [] } ]
      , groups = [ { name = "Frontend Devs Munich", users = [] }, { name = "MunichJS", users = [ "Andy" ] } ]
      , mdl = Material.model
      , newUsername = ""
      , newGroupname = ""
      , selectedUser = ""
      , selectedGroup = ""
      , tab = 0
      }
    , Cmd.none
    )


main : Program String Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
