open Jest

describe(`1만 이하 표시`, () => {
  open Expect

  test(`KoreanNumeral.fromInt`, () => {
    let result = KoreanNumeral.fromInt(1234)
    expect(result)->toBe(`1,234`)
  })
  test(`KoreanNumeral.fromFloat`, () => {
    let result = KoreanNumeral.fromFloat(152212525110.0)
    expect(result)->toBe(`1,522억 1,252만 5,110`)
  })
  test(`KoreanNumeral.fromBigInt`, () => {
    let result = KoreanNumeral.fromBigInt(1234567890987654321n)
    expect(result)->toBe(`123경 4,567조 8,909억 8,765만 4,321`)
  })
})

describe(`1만 이하는 절삭`, () => {
  open Expect

  test(`1234 => ""`, () => {
    let result = KoreanNumeral.fromInt(1234, ~drop=1)
    expect(result)->toBe(``)
  })
  test(`1234567 => "123만"`, () => {
    let result = KoreanNumeral.fromInt(1234567, ~drop=1)
    expect(result)->toBe(`123만`)
  })
  test(`1234567890 => "12억 3,456만"`, () => {
    let result = KoreanNumeral.fromInt(1234567890, ~drop=1)
    expect(result)->toBe(`12억 3,456만`)
  })
  test(`1234567890.1 => "12억 3,456만"`, () => {
    let result = KoreanNumeral.fromFloat(1234567890.1, ~drop=1)
    expect(result)->toBe(`12억 3,456만`)
  })
  test(`152212525110 => "1,522억 1,252만"`, () => {
    let result = KoreanNumeral.fromFloat(152212525110.0, ~drop=1)
    expect(result)->toBe(`1,522억 1,252만`)
  })
  test(`152212525110 => "1,522억"`, () => {
    let result = KoreanNumeral.fromFloat(152200005110.0, ~drop=1)
    expect(result)->toBe(`1,522억`)
  })
  test(`220000152212525110.0 => "22경 1,522억 1,252만"`, () => {
    let result = KoreanNumeral.fromFloat(220000152212525110.0, ~drop=1)
    expect(result)->toBe(`22경 1,522억 1,252만`)
  })
  test(`1234567890987654321 => "123경 4,567조 8,909억 8,765만"`, () => {
    let result = KoreanNumeral.fromString("1234567890987654321a", ~drop=1)
    expect(result)->toBe(None)
  })
  test(`152212525110n => "1,522억 1,252만"`, () => {
    let result = KoreanNumeral.fromBigInt(152212525110n, ~drop=1)
    expect(result)->toBe(`1,522억 1,252만`)
  })
  test(`152212525110n => "1,522억"`, () => {
    let result = KoreanNumeral.fromBigInt(152200005110n, ~drop=1)
    expect(result)->toBe(`1,522억`)
  })
  test(`220000152212525110n => "22경 1,522억 1,252만"`, () => {
    let result = KoreanNumeral.fromBigInt(220000152212525110n, ~drop=1)
    expect(result)->toBe(`22경 1,522억 1,252만`)
  })
  test(`1234567890987654321n => "123경 4,567조 8,909억 8,765만"`, () => {
    let result = KoreanNumeral.fromBigInt(1234567890987654321n, ~drop=1)
    expect(result)->toBe(`123경 4,567조 8,909억 8,765만`)
  })
  test(`무량대수 => "3,456무량대수..."`, () => {
    let result = KoreanNumeral.fromBigInt(
      345678909876543212345678909876543212345678909876543211234567890987654321n,
      ~drop=1,
    )
    expect(
      result,
    )->toBe(`3,456무량대수 7,890불가사의 9,876나유타 5,432아승기 1,234항하사 5,678극 9,098재 7,654정 3,212간 3,456구 7,890양 9,876자 5,432해 1,123경 4,567조 8,909억 8,765만`)
  })
})
