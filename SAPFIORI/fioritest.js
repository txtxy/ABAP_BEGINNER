// 한 줄 주석

/*
내용
*/
// console.log(1*3);
// alert('Hi')


// var name = 'moon';
// if (true){
//   var name = 'hong';
  
// }
// console.log(name);
/*
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
console.log(F['name']);
*/

// const list = {'커피': `3000원`, '주스' : '1500원', '탄산수' : '1000원'};

// var drink = prompt();

// switch (drink) {
//   case value:
    
//     break;

//   default:
//     break;
// }

// console.log(list.drink);

var count = Number(prompt("숫자를 입력하세요"));
for (let i = 1; i < (count/2); i++) {
  let j =  count - i;
    console.log("*".repeat(j)," ".repeat(i),"*".repeat(j) );
}

for (let i = (count/2); i > 0; i--) {
  let j =  count - i;
console.log("*".repeat(j)," ".repeat(i),"*".repeat(j) );
}
