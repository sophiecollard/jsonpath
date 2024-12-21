module JsonPath.ExtractorSpec exposing (..)

import Expect exposing (equal)
import Json.Decode exposing (Value)
import Json.Encode
import JsonPath.Extractor
import Test exposing (..)


suite : Test
suite =
    describe "The Extractor module's"
        [ describe "run method"
            [ test "should extract the root element" <|
                \_ ->
                    equal (JsonPath.Extractor.run "$" sampleJson) (Just sampleJson)
            , test "should extract the element at a single key" <|
                \_ ->
                    equal (JsonPath.Extractor.run "$.store.book[0]" sampleJson)
                        (Just
                            (Json.Encode.object
                                [ ( "category", Json.Encode.string "reference" )
                                , ( "author", Json.Encode.string "Nigel Rees" )
                                , ( "title", Json.Encode.string "Sayings of the Century" )
                                , ( "price", Json.Encode.float 8.95 )
                                ]
                            )
                        )
            ]
        ]


sampleJson : Value
sampleJson =
    Json.Encode.object
        [ ( "store"
          , Json.Encode.object
                [ ( "book"
                  , Json.Encode.list identity
                        [ Json.Encode.object
                            [ ( "category", Json.Encode.string "reference" )
                            , ( "author", Json.Encode.string "Nigel Rees" )
                            , ( "title", Json.Encode.string "Sayings of the Century" )
                            , ( "price", Json.Encode.float 8.95 )
                            ]
                        , Json.Encode.object
                            [ ( "category", Json.Encode.string "fiction" )
                            , ( "author", Json.Encode.string "Evelyn Waugh" )
                            , ( "title", Json.Encode.string "Sword of Honour" )
                            , ( "price", Json.Encode.float 12.99 )
                            ]
                        , Json.Encode.object
                            [ ( "category", Json.Encode.string "fiction" )
                            , ( "author", Json.Encode.string "Herman Melville" )
                            , ( "title", Json.Encode.string "Moby Dick" )
                            , ( "isbn", Json.Encode.string "0-553-21311-3" )
                            , ( "price", Json.Encode.float 8.99 )
                            ]
                        , Json.Encode.object
                            [ ( "category", Json.Encode.string "fiction" )
                            , ( "author", Json.Encode.string "J. R. R. Tolkien" )
                            , ( "title", Json.Encode.string "The Lord of the Rings" )
                            , ( "isbn", Json.Encode.string "0-395-19395-8" )
                            , ( "price", Json.Encode.float 22.99 )
                            ]
                        ]
                  )
                , ( "bicycle"
                  , Json.Encode.object
                        [ ( "color", Json.Encode.string "red" )
                        , ( "price", Json.Encode.float 19.95 )
                        ]
                  )
                ]
          )
        ]
