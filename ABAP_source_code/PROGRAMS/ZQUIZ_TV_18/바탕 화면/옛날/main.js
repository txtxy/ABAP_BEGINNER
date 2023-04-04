'use strict';

let a = 12;
let b = 1.2;
var x = [1,2,5,8,10];
var y = x[0]+x[4];
console.log(y);
console.log(a);
console.log(b);

console.log(`Value : ${a}, type : ${typeof b}`);
console.log(`Value : ${b}, type : ${typeof b}`);

const infinity = 1 / 0 ;
const negativeinfinity = -1 / 0;
const nAn = "str" / a;
console.log(infinity);
console.log(negativeinfinity);
console.log(nAn);

const bigint = 1351654984981651651651984984n; // over -2**53 ~ 2**53

console.log(`value : ${bigint} , type : ${typeof bigint}`)

// 중요 !!
// symbol 은 객체에 unique identify 하는 것
const symbol1 = Symbol('id');
const symbol2 = Symbol('id');
console.log(symbol1 === symbol2);

