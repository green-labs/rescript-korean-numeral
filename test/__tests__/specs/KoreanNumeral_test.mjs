// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Zora from "zora";
import * as KoreanNumeral from "../../../src/KoreanNumeral.mjs";

function testEqual(t, name, lhs, rhs) {
  t.test(name, async t => {
    t.equal(lhs, rhs, name);
  });
}

Zora.test("1만 이하 표시", t => {
  testEqual(t, "KoreanNumeral.fromInt", KoreanNumeral.fromInt(1234, undefined), "1,234");
  testEqual(t, "KoreanNumeral.fromFloat", KoreanNumeral.fromFloat(152212525110.0, undefined), "1,522억 1,252만 5,110");
  testEqual(t, "KoreanNumeral.fromBigInt", KoreanNumeral.fromBigInt(1234567890987654321n, undefined), "123경 4,567조 8,909억 8,765만 4,321");
});

Zora.test("1만 이하는 절삭", t => {
  testEqual(t, "1234 => \"\"", KoreanNumeral.fromInt(1234, 1), "");
  testEqual(t, "1234567 => \"123만\"", KoreanNumeral.fromInt(1234567, 1), "123만");
  testEqual(t, "1234567890 => \"12억 3,456만\"", KoreanNumeral.fromInt(1234567890, 1), "12억 3,456만");
  testEqual(t, "1234567890.1 => \"12억 3,456만\"", KoreanNumeral.fromFloat(1234567890.1, 1), "12억 3,456만");
  testEqual(t, "152212525110 => \"1,522억 1,252만\"", KoreanNumeral.fromFloat(152212525110.0, 1), "1,522억 1,252만");
  testEqual(t, "152212525110 => \"1,522억\"", KoreanNumeral.fromFloat(152200005110.0, 1), "1,522억");
  testEqual(t, "220000152212525110.0 => \"22경 1,522억 1,252만\"", KoreanNumeral.fromFloat(220000152212525110.0, 1), "22경 1,522억 1,252만");
  testEqual(t, "1234567890987654321 => \"123경 4,567조 8,909억 8,765만\"", KoreanNumeral.fromString("1234567890987654321a", 1), undefined);
  testEqual(t, "152212525110n => \"1,522억 1,252만\"", KoreanNumeral.fromBigInt(152212525110n, 1), "1,522억 1,252만");
  testEqual(t, "152212525110n => \"1,522억\"", KoreanNumeral.fromBigInt(152200005110n, 1), "1,522억");
  testEqual(t, "220000152212525110n => \"22경 1,522억 1,252만\"", KoreanNumeral.fromBigInt(220000152212525110n, 1), "22경 1,522억 1,252만");
  testEqual(t, "1234567890987654321n => \"123경 4,567조 8,909억 8,765만\"", KoreanNumeral.fromBigInt(1234567890987654321n, 1), "123경 4,567조 8,909억 8,765만");
  testEqual(t, "무량대수 => \"3,456무량대수...\"", KoreanNumeral.fromBigInt(345678909876543212345678909876543212345678909876543211234567890987654321n, 1), "3,456무량대수 7,890불가사의 9,876나유타 5,432아승기 1,234항하사 5,678극 9,098재 7,654정 3,212간 3,456구 7,890양 9,876자 5,432해 1,123경 4,567조 8,909억 8,765만");
});

export {
  testEqual,
}
/*  Not a pure module */
