import { useState } from "react";
import EventComponent from "./components/EventComponent";
import LoginComponent from "./components/LoginComponent";
import LoginFormComponent from "./components/LoginFormComponent";
import Loginform from "./components1/Loginform";
import UseEffectComponent from "./components1/UseEffectComponent";
import UseRefComponent from "./components/UseRefComponent";
import ParentComponent from "./components/ParentComponent"
function App() {

  // const  [counter, setCounter] = useState(0);

  // const incButtonHandeler = ()=>{
  //   console.log("Increament button clicked");
  //   setCounter(counter+1);
  // }
  // const decButtonHandeler = ()=>{
  //   console.log("Decreament button clicked");
  //   setCounter(counter-1);
  // }
  return (
    <div>
    {/* <div style={{color: 'red', fontSize:'50px'}}>{counter}</div>
    <button onClick={incButtonHandeler} style={{color: 'green', fontSize:'50px'}}> Don't increase me 😁😁</button>
    <button onClick={decButtonHandeler}style={{color: 'blue', fontSize:'50px'}} > Don't decrease me 😒😒 </button> */}


    {/* <EventComponent/> */}
    {/* <LoginComponent/> */}
    {/* <LoginFormComponent/> */}
    {/* <Loginform/> */}
    {/* <UseEffectComponent/> */}
    {/* <UseRefComponent/> */}
    <ParentComponent/>
    </div>
  );
}

export default App;
