// const { evaluate,parser,compile } = require('mathjs')
const myparser = math.parser();
function calc(f,v) {
  myparser.set("a",v)
myparser.set("b",v)
myparser.set("c",v)
myparser.set("d",v)
myparser.set("e",v)
myparser.set("f",v)
  myparser.set("t",v)
  return myparser.evaluate(f)
  // console.log(f.replaceAll("t",v))
  // return eval(f.replaceAll("t",v));
}
function parse(f,a,b,eps) {
  let raw_a = a;
  let raw_b = b;
  eps = 1.0e-6;
  let l = a + 0.382*(b-a);
  let u = a + 0.618*(b-a);

  console.log(l,u)
  let k=1;
  let tol = b-a;
  while(tol>eps && k<100000) {
    fl = calc(f,l)
    fu = calc(f ,u);
    if (fl > fu) {
        a = l;
        l = u;
        u = a + 0.618*(b - a);
    }
    else {
        b = u;
        u = l;
        l = a + 0.382*(b-a);
    }
    k = k+1;
    tol = Math.abs(b - a);
}
if (k == 100000) {
    console.log('找不到最小值！');
    // x = NaN;
    // minf = NaN;
    return;
}
let x = (a+b)/2;
let minf = calc(f,x)
console.log("x和minf")
console.log(x,minf)
// raw_a = -5;
// raw_b = 5;
let drawdata = []
for(let i =raw_a;i<raw_b;i+=0.1) {
    console.log(i,calc(f,i))
    drawdata.push([i,calc(f,i)])
}
return {
    drawdata:drawdata,
    x:x,
    minf:minf
}

}

// parse("t^4-t^2-2*t+5",-10,10)

// myparser.set("t",1)
// console.log(myparser.evaluate("t^4-t^2-2*t+5"))
