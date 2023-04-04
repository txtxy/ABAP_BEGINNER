const Func = function Func(a){
    for(i=1;i<10;i++)
    document.write(`${a} * ${i} : `+i*a+"<br/>")
};
function repeat(a){
    for(j=2;j<=a;j++)
    document.write(Func(j)+"<br/>")
};
repeat(9);
