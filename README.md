# re-korean-numeral

`re-korean-numeral`은 숫자를 한글 숫자로 변환해주는 리스트립트(ReScript) 모듈 입니다.

### 예
```
1234 -> 1,234
1234567890 -> 12억 3,456만 7,890
1234567890 -> 12억 3,456만  // 만 이하 절삭
```

## 설치하기

1. 모듈 설치

```shell
npm i re-korean-numeral
or
yarn add re-korean-numeral
```

2. `bsconfig.json` 의존성 추가하기

```json
"bs-dependencies": [
  "re-korean-numeral"
]
```

## 사용방법

1. `fromInt`

```reason
NumToKorean.fromInt(1234, ())
// 1,234
```

2. `fromFloat`

```reason
NumToKorean.fromFloat(1234567890.1, ~drop=1, ())
// 12억 3,456만
```

3. `fromString`

```reason
NumToKorean.fromString("1234567890987654321", ~drop=1, ())
// 123경 4,567조 8,909억 8,765만
```

## 테스트

```shell
npm run test
or
yarn test
```