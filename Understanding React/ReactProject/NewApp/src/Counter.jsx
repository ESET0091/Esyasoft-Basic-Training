import React from 'react';
function counter() {

  // // Variable Declarations
  // console.log(x); // Hoisting
  // var x=5;
  // console.log(x);
  // if(true){
  //   var a=1;
  //   let b=2;
  //   const c=3;
  // }
  // console.log(a);
  // console.log(b);
  // console.log(c);  


  // // consise body (implicit return)
  // const add =(a,b)=>a+b;
  // console.log(add(5,3));

  // // Block body (explicit return)
  // const addMore =(a,b)=>{
  //   const sum=a+b;
  //   return sum;
  // }
  // console.log(addMore(5,3));

  // //React functional component (Arrow function)
  // const Hello =({name})=><h1>Hello, {name}</h1>
  // console.log(Hello({name:"John"}));

  // // Lexical this
  // const obj ={
  //   value:10,
  //   regularFn: function(){
  //     console.log(this.value);
  //   },
  //   arrowFn: ()=>{
  //     console.log(this.value);
  //   }
  // };
  // obj.regularFn(); //10
  // obj.arrowFn(); //undefined


  // // Object destructuring - Extracting props
  // // const user ={name : "Gopal", info : {city : "Ballia"}};
  // const user ={ info : {city : "Ballia"}};  // Now userName will take default value John
  // const {name: userName = 'John', info:{city} = {} } = user;
  // console.log(userName); //Gopal
  // console.log(city); //Ballia
  // console.log(user.info.city); //Ballia


  // // Array destructuring - useState

  // // Swapping variables
  // let a =1, b =2;
  // [a,b] = [b,a];
  // console.log(a); //2
  // console.log(b); //1


  // Spread and Rest Operators - update state immutably
  const prev = {name : "Gopal", age : 24};
  const updated = {...prev, age : 25, city : "Ballia"};
  console.log(updated); //{name: "Gopal", age: 25}

  // Rest operator
  const {name, ...rest} = updated;
  console.log(name); //Gopal
  console.log(rest); //{age: 25, city: "Ballia"}



  let count = 0;
  const increment = () => {
    count++;
    document.getElementById("c1").innerText = count;
  }
  const decrement = () => {
    count--;
    document.getElementById("c1").innerText = count;
  }
 return(
    <>
    <h1 id="c1">0</h1>
    <button onClick={increment}>INC</button>
     <button onClick={decrement}>DEC</button>
    </>
 )
}
export default counter;