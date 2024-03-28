open Belt

let unitsInKorean = list{
  "",
  "만",
  "억",
  "조",
  "경",
  "해",
  "자",
  "양",
  "구",
  "간",
  "정",
  "재",
  "극",
  "항하사",
  "아승기",
  "나유타",
  "불가사의",
  "무량대수",
}
let mann = 10000n

let rec split = divided => {
  open! Js.BigInt
  if divided == 0n {
    list{}
  } else {
    list{Js.BigInt.mod(divided, mann), ...split(divided / mann)}
  }
}

let fromBigInt = (num, ~drop=0) => {
  split(num)
  ->List.zipBy(unitsInKorean, (num, unit) => {
    num == 0n ? "" : num->Js.BigInt.toLocaleString ++ unit
  })
  ->List.drop(drop)
  ->Option.getWithDefault(list{})
  ->List.keep(i => i != "")
  ->List.reverse
  ->List.toArray
  ->(Js.Array.joinWith(" ", _))
}

let fromInt = (num, ~drop=0) => {
  num->Int.toString->Js.BigInt.fromStringExn->fromBigInt(~drop)
}

let fromFloat = (num, ~drop=0) => {
  num->ceil->Float.toString->Js.BigInt.fromStringExn->fromBigInt(~drop)
}

let fromString = (num, ~drop=0) => {
  try {
    num->Js.BigInt.fromStringExn->fromBigInt(~drop)->Some
  } catch {
  | _ => None
  }
}
