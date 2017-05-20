module Tests exposing (..)

import Test exposing (..)
import Expect


all : Test
all =
    describe "A Test Suite"
        [ test "Addition" <|
            \() ->
                Expect.equal (3 + 7) 10
        ]
