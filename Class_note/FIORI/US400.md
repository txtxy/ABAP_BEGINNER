# Fiori
[UI5 API 및 오큐먼트 사이트](https://ui5.sap.com/#/)


UI5 는 부트 스트랩이 가능하다.

[코딩 실습 사이트](https://codepen.io/)

해당 사이트에서 실습 진행 예정

## 주석 처리
```js
/*
여러 줄 주석
*/
// 한 줄 주석
```
## 변수 선언
- var :
    1.  변동적 변수 선언 ; 사용
    2. 사용범위 : 함수

- let : 변수 선언
    1. 일종의 지역변수 느낌(사실 아님)
    2. 사용범위 : {} 블럭
        블럭을 나오게 되면 해당 let은 사용할 수 없다.
    3. 변수명을 중복해서 사용 할 수 없다

var의 경우 변수 선언을 하기 전에 사용한다면 'undefied'로 사용할 수 있으나,
let의 경우 초기값을 미리 선언해주지 않으면 사용할 수 없다.(에러 발생) 
```js
let name = 'Moon';
name = 'Hong';
console.log(name);
```
let의 경우 값이 없다면 undefined로 설정 된다.
### 스코프에 관한 예시
```js
var name = 'moon';
if (true){
  let name = 'hong';
//   var name = 'hong';
}
console.log(name);
```
let으로 선언할 경우 함수안에서 효력 종료
var의 경우 함수 넘어서 효력 유지
## 변수명 네이밍 룰
1. 숫자로 시작하면안됨
2. 특수기호는 $와_만 가능
3. 영어를 사용할 것을 권장
4. 대소문자를 구분함(Camel Case 로 작성할 것을 권장)
5. 예약어를 사용하지 말라
6. 첫글자를 소문자로 Type 지정하고 그뒤로 대문자로 변수명 지정하는 것이 암묵적인 룰



## 상수 선언
const : 상수 선언
1. 항상 값을 설정해줘야한다.

## 자료형
- 원시 타입 
number : 숫자
string : 문자
boolean : 참/거짓
null : '없다' 값 할당
undefiened : 값이 아예 없음 

- 자료형 선언 방법
```js
    let  age = 30;
    let love = '23';
    console.log(type of love);
    
    let A ='Apple';
    let B = 123;
    let C = true;
```

## 배열 Array

Array 배열  : [30, 'A', true] 

let D = [100,'hello',false];

예시 

```js
let F = {name : 'hong',
        age : 20};
console.log(D[1]);
console.log(F.name);
console.let(F['age']);

D[1] = 'hello 2';
```
## 배열 메쏘드

- push() : 배열 끝에 값 추가

- pop() : 배열 끝애 값 삭제

- unshift() : 배열 앞에 값 추가

- concat() : 문자열 합치기
- reverse() : 배열 순서 반대로
- join() : 구분자 설정하기
- splice(startIndex,DeleteAmount,InsertData) : 위치를 기준으로 값 삭제
    - 예시
    ```js
    let fruits = ['FirstData', 'SecondData', 'ThirdData'];
    fruits.splice(1, 1);
    console.log(fruits);
    fruits.splice(1, 0, 'Insert1', 'Insert2');
    console.log(fruits);
    ```
- slice(시작위치,끝위치) : 배열을 자를 때 사용
    - 예시
    ```js
    var result2 = result.slice(0,2);
    ```
- filter()
- forEach()
- map()
- reduce()

## 딕셔너리 자료형 Object
Object 객체형: { Key : value }
자료 형을 미리 선언할 경우
`{ key(str) : ' '}`

```js
let F = { name : 'hong',
        age : 20,
        sleep : function(){
          console.log('zzz...');
        }
};

F.hobby = 'Sleep';
     F.sleep();
    console.log(f[hobby]());
```

## 함수 Function
선언 : 
    function 이름(선택적 변수) {
        로직
        };
호출 : 
    이름();


```js
function printHello() {
  console.log('Hello');
}
printHello();
```
## Class 를 이용한 선언
new String('');
new number(12);
new Boolean(true);
new Array([...]) => length() 배열 길이 확인 메쏘드 



## 실습 정리 
```js
    let A ='Apple';
    let B = 123;
    let C = true;
    let D = [100,'hello',false];
    let F = {name : 'hong',
            age : 20,
            sleep : function(){
              console.log('zzz...');
            }
            };

    console.log('A : ' + A);
    console.log('B : ' + B);
    console.log('C : ' + C);
    console.log('D : ' + D[1]);
    F.sleep();
    f['sleep']();
    console.log(F['name'])
```


## 문자열 실습 2
```js
'hello world'.split('ll');
console.log(test);
var test = 'hello world'.split('');
console.log(test);
```
replace('A','a')
substring(시작idx,끝idx)
substr(시작idx,개수)

## 형변환
### 묵시적 형변환
`2123`  ==> 2123 typeof Number
### 명시적 형변환
Number('1232') ==> 1232 typeof Number.
String(1111) ==> `1111` typeof String.

## 연산자

### 대입 연산자 파이썬과 동일
A += B 동일 A = A + B
A -= B A = A- B
*= , /=. %=

### 증감 연산자 
1. a++ : a에 값을 할당하고 증가 
2. ++a : a에 값이 증가하고 할당

3. a-- : a에 값을 할당하고 감소
4. --a : a에 값이 감소하고 할당

### 비교 연산자

a == b a와 b의 값이 같은지?

a === b a와 b의 값과 타입이 모두 같은지?

a != b a와 b의 값이 다른지?

a !== b a와 b의 값과 타입이 모두 다른지?

### 논리 연산자

and = &&
or =  ||
!a  = a의 Boolean 값을 반대로

## 내부적으로 False 값을 가지는 데이터
false
undefined
null
0
NaN
"" // 공백
''

- 사용례
    ```js
    var a = 10, b = false;
    var c = b || a;

    // c = 10
    ```
## 삼항 연산자
조건? True : False

```js
2 + 5 === 7 ? console.log("참")
            : console.log('거짓')
```
## 조건문

## 반복문
### For 문
for(초기화식; 조건식; 증감식  ) {

실행 로직..

};

for {}안에 let을 지역 변수로 활용 가능함.


### While 문
While() {
... 로직...

}
```js
var a = 1;
do{
    console.log(a);
} While(i<10){i++}
```

### 과제
```js
const list = {커피: 3000, 주스 : 1500, 탄산수 : 1000};
var drink = prompt(drink);

switch (drink) {
  case '커피':
console.log(list.커피 + '원');
    break;
  case '주스':
console.log(list.주스 + '원');
    break;  
  case '탄산수':
console.log(list.탄산수 + '원');
    break;
    
  default:
    break;
}
```

### 과제2 
```js

function sum() {
  
let result = 0;
  
while(true){
  
  let num = prompt('값을 입력해주세요');
  
    if (num==='0'){break;};
  result += Number(num); 
};
alert('합계 : ' + result)
};

sum();
```
### 구구단 과제

```js
function gugu(num) {
  num = prompt('몇 단을 외울까?');
  num = Number(num);
  let i = 0;
  for(i = 1;i<10;i++){
    console.log(`${num} * ${i} = ${num * i}`);
  }
}
gugu();
```

