import React, { useState } from "react";

function LoginComponent() {
  const [username, setUserName] = useState("");
  const [password, setPassword] = useState("");

  const onLoginHandler = () => {
    if (username !== "gopal") {
      alert("Invalid user");
      return;
    }
    if (password !== "password") {
      alert("Invalid Password");
      return;
    }
    alert("Login button clicked!");
  };
  return (
    <form onSubmit={onLoginHandler}>
      <input
        type="text"
        value={username}
        onChange={(e) => {
          setUserName(e.target.value);
        }}
        placeholder="Enter your username"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => {
          setPassword(e.target.value);
        }}
        placeholder="Enter your password"
      />
      {/* <button onClick ={onLoginHandler}>login</button> */}
      <button type="submit">Login</button>
      <button type="reset">Reset</button>
    </form>
  );
}

export default LoginComponent;
