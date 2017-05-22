module UpdateTest exposing (..)

import Test exposing (..)
import Fuzz exposing (string)
import Expect
import Update


all : Test
all =
    describe "Update"
        [ fuzz string "nameEquals - True" <|
            \generatedString ->
                Expect.true "Fuzzed object always name equals" (Update.nameEquals generatedString { name = generatedString })
        , fuzz string "nameEquals - False" <|
            \generatedString ->
                Expect.false "Fuzzed object always not name equals" (Update.nameEquals generatedString { name = "a" ++ generatedString })
        , test "removeByName" <|
            \() ->
                Expect.equal (Update.removeByName "Martin" [ { name = "Thomas" }, { name = "Philip" }, { name = "Martin" } ])
                    [ { name = "Thomas" }, { name = "Philip" } ]
        , test "removeByName - empty array" <|
            \() ->
                Expect.equal (Update.removeByName "Martin" [])
                    []
        , test "removeByName - duplicate entry" <|
            \() ->
                Expect.equal (Update.removeByName "Martin" [ { name = "Martin" }, { name = "Martin" } ])
                    []
        , test "removeUserFromGroup" <|
            \() ->
                Expect.equal (Update.removeUserFromGroup "Martin" { name = "MunichJS", users = [ "Thomas", "Philip", "Martin" ] })
                    { name = "MunichJS", users = [ "Thomas", "Philip" ] }
        , test "removeUserFromGroup - empty list" <|
            \() ->
                Expect.equal (Update.removeUserFromGroup "Martin" { name = "MunichJS", users = [] })
                    { name = "MunichJS", users = [] }
        , test "removeUserFromGroups - remove user in all groups" <|
            \() ->
                Expect.equal
                    (Update.removeUserFromGroups "Martin"
                        [ { name = "MunichJS", users = [ "Thomas", "Philip", "Martin" ] }
                        , { name = "MunichLambda", users = [ "Thomas", "Philip", "Martin" ] }
                        ]
                    )
                    [ { name = "MunichJS", users = [ "Thomas", "Philip" ] }
                    , { name = "MunichLambda", users = [ "Thomas", "Philip" ] }
                    ]
        , test "removeUserFromGroups - remove user only present in single group" <|
            \() ->
                Expect.equal
                    (Update.removeUserFromGroups "Martin"
                        [ { name = "MunichJS", users = [ "Thomas", "Philip", "Martin" ] }
                        , { name = "MunichLambda", users = [ "Thomas", "Philip", "Stefan" ] }
                        ]
                    )
                    [ { name = "MunichJS", users = [ "Thomas", "Philip" ] }
                    , { name = "MunichLambda", users = [ "Thomas", "Philip", "Stefan" ] }
                    ]
        , fuzz string "toggleGroupInUser - Add Group" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleGroupInUser generatedValue { name = "Martin", groups = [ "MunichLamda" ] })
                    { name = "Martin", groups = [ generatedValue, "MunichLamda" ] }
        , fuzz string "toggleGroupInUser - Remove Group" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleGroupInUser generatedValue { name = "Martin", groups = [ generatedValue, "MunichLamda" ] })
                    { name = "Martin", groups = [ "MunichLamda" ] }
        , fuzz string "toggleUserInGroup - Add User" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleUserInGroup generatedValue { name = "MunichLamda", users = [ "Martin" ] })
                    { name = "MunichLamda", users = [ generatedValue, "Martin" ] }
        , fuzz string "toggleUserInGroup - Remove User" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleUserInGroup generatedValue { name = "MunichLamda", users = [ generatedValue, "Martin" ] })
                    { name = "MunichLamda", users = [ "Martin" ] }
        , fuzz string "toggleGroupInUsers - Remove Group" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleGroupInUsers generatedValue "MunichLamda" [ { name = "Martin", groups = [ "MunichLamda" ] }, { name = generatedValue, groups = [ "MunichLamda" ] } ])
                    [ { name = "Martin", groups = [ "MunichLamda" ] }, { name = generatedValue, groups = [] } ]
        , fuzz string "toggleGroupInUsers - Add Group" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleGroupInUsers generatedValue "MunichLamda" [ { name = "Martin", groups = [] }, { name = generatedValue, groups = [] } ])
                    [ { name = "Martin", groups = [] }, { name = generatedValue, groups = [ "MunichLamda" ] } ]
        , fuzz string "toggleUserInGroups - Remove Group" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleGroupInUsers "Martin" generatedValue [ { name = "Martin", groups = [ generatedValue ] }, { name = "Stefan", groups = [ generatedValue ] } ])
                    [ { name = "Martin", groups = [] }, { name = "Stefan", groups = [ generatedValue ] } ]
        , fuzz string "toggleUserInGroups - Remove Group" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleGroupInUsers generatedValue "MunichJS" [ { name = "Martin", groups = [ "MunichJS" ] }, { name = generatedValue, groups = [ "MunichJS" ] } ])
                    [ { name = "Martin", groups = [ "MunichJS" ] }, { name = generatedValue, groups = [] } ]
        , fuzz string "toggleUserInGroups - Add Group" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleGroupInUsers generatedValue "MunichJS" [ { name = "Martin", groups = [ "MunichJS" ] }, { name = generatedValue, groups = [] } ])
                    [ { name = "Martin", groups = [ "MunichJS" ] }, { name = generatedValue, groups = [ "MunichJS" ] } ]
        , fuzz string "toggleUserInGroups - Add User" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleUserInGroups generatedValue "MunichJS" [ { name = "MunichJS", users = [ "Martin" ] }, { name = "FE Devs", users = [] } ])
                    [ { name = "MunichJS", users = [ generatedValue, "Martin" ] }, { name = "FE Devs", users = [] } ]
        , fuzz string "toggleUserInGroups - Remove User" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleUserInGroups generatedValue "MunichJS" [ { name = "MunichJS", users = [ generatedValue, "Martin" ] }, { name = "FE Devs", users = [] } ])
                    [ { name = "MunichJS", users = [ "Martin" ] }, { name = "FE Devs", users = [] } ]
        , fuzz string "toggleUserInGroups - Add User" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleUserInGroups "Martin" generatedValue [ { name = "MunichJS", users = [ "Martin" ] }, { name = generatedValue, users = [] } ])
                    [ { name = "MunichJS", users = [ "Martin" ] }, { name = generatedValue, users = [ "Martin" ] } ]
        , fuzz string "toggleUserInGroups - Remove User" <|
            \generatedValue ->
                Expect.equal
                    (Update.toggleUserInGroups "Martin" generatedValue [ { name = "MunichJS", users = [ "Martin" ] }, { name = generatedValue, users = [ "Martin" ] } ])
                    [ { name = "MunichJS", users = [ "Martin" ] }, { name = generatedValue, users = [] } ]
        ]
