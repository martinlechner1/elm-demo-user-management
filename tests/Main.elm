port module Main exposing (..)

import UpdateTest
import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)


main : Test.Runner.Node.TestProgram
main =
    run emit UpdateTest.all


port emit : ( String, Value ) -> Cmd msg
