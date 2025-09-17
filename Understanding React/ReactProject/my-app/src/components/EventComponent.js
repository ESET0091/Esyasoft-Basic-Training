// const dummyJson = {
//     "firstName":"Gopal",
//     "lastName":"Singh",
//     "target":{
//         "value":"ddd"
//     }
// };

function EventComponent() {
  //console.log(dummyJson.target.value);
  const onChangeHandler = (e) => {
    //console.log(e.target.value);
    if(e.target.value==="Gopal")
        console.log("Yes");
    
  };

  return (
    <>
      Welcome to Events
      <button
        onClick={() => {
          console.log("Button clicked");
        }}
      >
        Click me
      </button>
      <div
        style={{ background: "#00ff61", padding: "50px" }}
        onMouseEnter={() => {
          console.log("Mouse entered the div");
        }}
        onMouseLeave={() => {
          console.log("Mouse leaved");
        }}
      >
        This is div
      </div>
      {/* <input type="number" min={1} max={10}/> */}
      <input type="text" onChange={onChangeHandler} />
    </>
  );
}

export default EventComponent;
