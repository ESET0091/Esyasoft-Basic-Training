import React, { useState } from "react";

export default function ParentComponent() {
  const [count, setCount] = useState(0);
  const increament = () => {
    setCount((prev) => prev + 1);
  };
  const decreament = () => {
    setCount((prev) => prev - 1);
  };

  return (
    <div>
      Welcome to the parent component
      <Sibling1 count={count} />
      <Sibling2 increament={increament} decreament={decreament} />
    </div>
  );
}

function Sibling1({ count }) {
  return <div>{count}</div>;
}

function Sibling2({ increament, decreament }) {
  return (
    <>
      <button onClick={increament}>Increament</button>
      <button onClick={decreament}>Decreament</button>
    </>
  );
}
