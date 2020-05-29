module Main exposing (Msg, Model)
import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)

-- MAIN
main : Program () Model Msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = 0
        }

-- MODEL
type alias Model = Int

-- UNION
type Msg = Increment | Increment5 | Decrement | Decrement5 | Reset


-- UPDATE
update : Msg -> Model -> Model
update actions model =
  case actions of
    Increment ->
      model + 1

    Increment5 ->
      model + 5

    Decrement ->
      if model > 0
        then model - 1
      else
        model

    Decrement5 ->
      if model >= 5
        then model - 5
      else if model < 5
        then 0
      else model

    Reset ->
      0

-- Theme variables
theme : { primary : Color, green : Color, orange : Color }
theme =
    { primary = rgb 85 88 91
    , green = hex "109c10"
    , orange = hex "ffa500" }

-- VIEW
view : Model -> Html Msg
view model =

  div [
      style "font-family" "sans-serif"
    , style "width" "200px"
    , style "padding" "1rem"
    , style "margin" "2rem auto"
    , style "font-size" "16px"
    , style "background" "rgb(85 88 91)"
    , style "border-radius" "1rem"
    ] [

      div [
        style "background" "#e0e0e0"
      , style "padding" "1rem"
      , style "border-radius" "3px"
      , style "margin-bottom" "1rem"
      ] [
        text "Sum: "
      , text (String.fromInt model)
      ]

    , div [
       style "border-radius" "3px"
      , style "margin-bottom" "1rem"
    ] [
      viewIncrementButtons model
    , viewDecrementButtons model
    , viewResetButton model
    ]
    ,  viewValidation model
    ]

styledBtn : List (Attribute msg) -> List (Html msg) -> Html msg
styledBtn =
    styled button
        [
      Css.width (pct 50)
    , border3 (px 1) solid (theme.primary)
    , padding (rem 1)
    , fontSize (rem 1)
    , backgroundColor (hex "7e8083")
    , color (hex "ffffff")
        ]


-- PARTIAL VIEWS
viewIncrementButtons : Model -> Html Msg
viewIncrementButtons model =
  div []
    [
      styledBtn [ onClick Increment ] [ text "+1" ]
    , styledBtn [ onClick Increment5 ] [ text "+5"]
    ]

viewDecrementButtons : Model -> Html Msg
viewDecrementButtons model =
  if model == 0 then
    div []
    [
      styledBtn [ style "opacity" "0.5", Html.Styled.Attributes.disabled True ] [ text "-1"  ]
    , styledBtn [ style "opacity" "0.5", Html.Styled.Attributes.disabled True ] [ text "-5"  ]
    ]
  else div []
    [
      styledBtn [
       onClick Decrement ] [ text "-1"  ]
    , styledBtn [
      onClick Decrement5 ] [ text "-5"  ]
    ]

viewResetButton : Model -> Html Msg
viewResetButton model =
  if model == 0 then
    styledBtn [ style "opacity" "0.5", style "width" "100%", Html.Styled.Attributes.disabled True ] [ text "Reset"  ]
  else
    styledBtn [ style "width" "100%", onClick Reset ] [ text "Reset"  ]

viewValidation : Model -> Html Msg
viewValidation model =
  if model == 0 then
      div [
        style "background" "orange"
      , style "padding" "1rem 1rem"
      , style "border-radius" "3px"
      ]
    [h4 [ style "color" "#ffffff", style "margin" "0px" ] [ text "Please increment" ]]
  else
       div [
        style "background" "green"
      , style "padding" "1rem 1rem"
      , style "border-radius" "3px"
      ]
    [h4 [ style "color" "#ffffff", style "margin" "0px" ] [ text "Nice!" ]]
