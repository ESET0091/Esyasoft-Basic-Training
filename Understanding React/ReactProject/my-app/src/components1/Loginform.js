import React, { useState } from "react";

export default function Loginform() {
  const [loginState, setLoginState] = useState({
    username: "",
    password: "",
  });

  const onUsernameChangeHandler = (event) => {
    setLoginState({
      ...loginState,
      username: event.target.value,
    });
  };
  const onPasswordChangeHandler = (event) => {
    setLoginState({
      ...loginState,
      password: event.target.value,
    });
  };

  const loginHandler = (event) => {
    event.preventDefault();
    //console.log(event);
    console.log(loginState);
  };

  return (
    <div>
      Welcome to login page
      <form onSubmit={loginHandler}>
        <br />
        <input
          type="text"
          value={loginState.username}
          onChange={onUsernameChangeHandler}
        />
        <br />
        <input
          type="password"
          value={loginState.password}
          onChange={onPasswordChangeHandler}
        />
        <br />
        <button type="submit">Login</button>
        <button type="reset">Reset</button>
      </form>
    </div>
  );
}
