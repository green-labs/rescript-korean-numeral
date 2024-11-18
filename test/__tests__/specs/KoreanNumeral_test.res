open Zora

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, async t => {
    t->equal(lhs, rhs, name)
  })

zoraBlock("1만 이하 표시", t => {
  t->testEqual("KoreanNumeral.fromInt", KoreanNumeral.fromInt(1234), "1,234")

  t->testEqual(
    "KoreanNumeral.fromFloat",
    KoreanNumeral.fromFloat(152212525110.0),
    "1,522억 1,252만 5,110",
  )

  t->testEqual(
    "KoreanNumeral.fromBigInt",
    KoreanNumeral.fromBigInt(1234567890987654321n),
    "123경 4,567조 8,909억 8,765만 4,321",
  )
})

zoraBlock("1만 이하는 절삭", t => {
  t->testEqual("1234 => \"\"", KoreanNumeral.fromInt(1234, ~drop=1), "")

  t->testEqual("1234567 => \"123만\"", KoreanNumeral.fromInt(1234567, ~drop=1), "123만")

  t->testEqual(
    "1234567890 => \"12억 3,456만\"",
    KoreanNumeral.fromInt(1234567890, ~drop=1),
    "12억 3,456만",
  )

  t->testEqual(
    "1234567890.1 => \"12억 3,456만\"",
    KoreanNumeral.fromFloat(1234567890.1, ~drop=1),
    "12억 3,456만",
  )

  t->testEqual(
    "152212525110 => \"1,522억 1,252만\"",
    KoreanNumeral.fromFloat(152212525110.0, ~drop=1),
    "1,522억 1,252만",
  )

  t->testEqual(
    "152212525110 => \"1,522억\"",
    KoreanNumeral.fromFloat(152200005110.0, ~drop=1),
    "1,522억",
  )

  t->testEqual(
    "220000152212525110.0 => \"22경 1,522억 1,252만\"",
    KoreanNumeral.fromFloat(220000152212525110.0, ~drop=1),
    "22경 1,522억 1,252만",
  )

  t->testEqual(
    "1234567890987654321 => \"123경 4,567조 8,909억 8,765만\"",
    KoreanNumeral.fromString("1234567890987654321a", ~drop=1),
    None,
  )

  t->testEqual(
    "152212525110n => \"1,522억 1,252만\"",
    KoreanNumeral.fromBigInt(152212525110n, ~drop=1),
    "1,522억 1,252만",
  )

  t->testEqual(
    "152212525110n => \"1,522억\"",
    KoreanNumeral.fromBigInt(152200005110n, ~drop=1),
    "1,522억",
  )

  t->testEqual(
    "220000152212525110n => \"22경 1,522억 1,252만\"",
    KoreanNumeral.fromBigInt(220000152212525110n, ~drop=1),
    "22경 1,522억 1,252만",
  )

  t->testEqual(
    "1234567890987654321n => \"123경 4,567조 8,909억 8,765만\"",
    KoreanNumeral.fromBigInt(1234567890987654321n, ~drop=1),
    "123경 4,567조 8,909억 8,765만",
  )

  t->testEqual(
    "무량대수 => \"3,456무량대수...\"",
    KoreanNumeral.fromBigInt(
      345678909876543212345678909876543212345678909876543211234567890987654321n,
      ~drop=1,
    ),
    "3,456무량대수 7,890불가사의 9,876나유타 5,432아승기 1,234항하사 5,678극 9,098재 7,654정 3,212간 3,456구 7,890양 9,876자 5,432해 1,123경 4,567조 8,909억 8,765만",
  )
})
