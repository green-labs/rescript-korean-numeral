# rescript-korean-numeral

[![npm version](https://img.shields.io/npm/v/@greenlabs/rescript-korean-numeral.svg)](https://www.npmjs.com/package/@greenlabs/rescript-korean-numeral)

> `@greenlabs/re-korean-numeral`은 deprecated 되었습니다.
> 새로운 패키지명 `@greenlabs/rescript-korean-numeral`을 이용해서 설치해주세요.

`rescript-korean-numeral`은 숫자를 한글 숫자로 변환해주는 리스트립트(ReScript) 모듈 입니다.

### 예

```
1234 -> 1,234
1234567890 -> 12억 3,456만 7,890
1234567890 -> 12억 3,456만  // 만 이하 절삭
```

### ReScript 버전 별 호환성

| ReScript | korean-numeral |
| -------- | -------------- |
| >= v11.1 | >= v0.4.0      |
| ~< v11.1 | ~< v0.4.0      |

## 설치하기

1. 모듈 설치

```shell
npm i @greenlabs/rescript-korean-numeral
or
yarn add @greenlabs/rescript-korean-numeral
```

2. `rescript.json` 의존성 추가하기

```json
"bs-dependencies": [
  "@greenlabs/rescript-korean-numeral"
]
```

## 사용방법

1. `fromInt`

```rescript
KoreanNumeric.fromInt(1234, ())
// 1,234
```

2. `fromFloat`

```rescript
KoreanNumeric.fromFloat(1234567890.1, ~drop=1, ())
// 12억 3,456만
```

3. `fromString`

```rescript
KoreanNumeric.fromString("1234567890987654321", ~drop=1, ())
// 123경 4,567조 8,909억 8,765만
```

4. `fromBigInt`

> ReScript v11.1.0-rc.6 부터 지원 가능

```rescript
KoreanNumeric.fromBigInt(1234567890987654321n, ~drop=1, ())
// 123경 4,567조 8,909억 8,765만
```

## 테스트

```shell
pnpm test
```
