module JsonPath exposing
    ( Path, Selector(..)
    , Error(..), Cursor, CursorOp(..)
    , Segment(..)
    )

{-|


# Type and Constructors

@docs Path, Segment, Selector


# Error Reporting

@docs Error, Cursor, CursorOp

-}

import Parser


{-| A JSON `Path` is made up of a list of `Segment`s.
-}
type alias Path =
    List Segment


{-| A `Segment` selects `Children` or `Descendants` using a `Selector`.
-}
type Segment
    = Children Selector
    | Descendants Selector


{-| A JSON path `Selector`, as described in the [JSONPath specification](https://www.rfc-editor.org/rfc/rfc9535#name-selectors).
-}
type Selector
    = Wildcard
    | Slice { start : Int, maybeEnd : Maybe Int, step : Int }
    | Indices Int (List Int)
    | Keys String (List String)


{-| Describes an error encountered while attempting to extract the JSON at a given path.
-}
type Error
    = PathParsingError (List Parser.DeadEnd)
    | IndexNotFound Cursor Int
    | KeyNotFound Cursor String
    | NotAJsonArray Cursor
    | NotAJsonArrayNorAnObject Cursor


{-| A `Cursor` is used to facilitate debugging by keeping track of the location an `Error` was encountered.
It is made up of a list of operations (see `CursorOp`).
-}
type alias Cursor =
    List CursorOp


{-| A `Cursor` operation.
-}
type CursorOp
    = DownIndex Int
    | DownKey String
