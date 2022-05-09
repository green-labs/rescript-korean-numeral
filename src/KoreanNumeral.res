@send external toLocaleString: (int, string) => string = "toLocaleString"

open Belt

let unitsInKorean = list{``, `만`, `억`, `조`, `경`}
let mann = Int64.of_int(10000)

let rec split = divided =>
  Int64.equal(divided, Int64.zero)
    ? list{}
    : list{Int64.rem(divided, mann), ...split(Int64.div(divided, mann))}

let fromInt64 = (num, ~drop=0, ()) => {
  split(num)
  ->List.zipBy(unitsInKorean, (num, unit) => {
    Int64.equal(num, Int64.zero) ? "" : num->Int64.to_int->toLocaleString("ko-KR") ++ unit
  })
  ->List.drop(drop)
  ->Option.getWithDefault(list{})
  ->List.keep(i => i != "")
  ->List.reverse
  ->List.toArray
  ->Js.Array.joinWith(" ", _)
}

let fromInt = (num, ~drop=0, ()) => {
  fromInt64(Int64.of_int(num), ~drop, ())
}

let fromFloat = (num, ~drop=0, ()) => {
  fromInt64(Int64.of_float(ceil(num)), ~drop, ())
}

let fromString = (num, ~drop=0, ()) => {
  fromInt64(Int64.of_string(num), ~drop, ())
}

module AllUnitsInKorean = {
  let smallUnitsInKorean = list{``, `십`, `백`, `천`}

  let fourDigitNumberToKorean = num =>
    num
    ->Int64.to_string
    ->Js.String2.split("")
    ->List.fromArray
    ->List.reverse
    ->List.zipBy(smallUnitsInKorean, (num', unit) => {
      num' != "0" ? num' ++ unit : ""
    })
    ->List.reduceReverse("", (a, b) => a ++ b)

  let fromInt64 = (num, ~drop=0, ()) => {
    num
    ->split
    ->List.map(x => x->fourDigitNumberToKorean)
    ->List.zipBy(unitsInKorean, (num', unit) => num' == "" ? "" : num' ++ unit)
    ->List.drop(drop)
    ->Option.getWithDefault(list{})
    ->List.reduceReverse("", (a, b) => a == "" ? a ++ b : a ++ " " ++ b)
  }

  let fromInt = (num, ~drop=0, ()) => {
    fromInt64(Int64.of_int(num), ~drop, ())
  }

  let fromFloat = (num, ~drop=0, ()) => {
    fromInt64(Int64.of_float(ceil(num)), ~drop, ())
  }

  let fromString = (num, ~drop=0, ()) => {
    fromInt64(Int64.of_string(num), ~drop, ())
  }
}
