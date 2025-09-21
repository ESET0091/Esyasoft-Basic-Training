import React, { useState } from 'react';
import Button from './components/Button';
import './App.css';

function App() {
  const [count, setCount] = useState(0);

  const handleIncrement = () => {
    setCount(prevCount => prevCount + 1);
    console.log('Increment clicked');
  };

  const handleDecrement = () => {
    setCount(prevCount => prevCount - 1);
    console.log('Decrement clicked');
  };

  return (
    <div className="App">
      <div className="counter-container">
        <h1>Simple Counter</h1>
        <div className="counter-value">{count}</div>
        <div className="buttons-container">
          <Button label="Increment" onClick={handleIncrement} />
          <Button label="Decrement" onClick={handleDecrement} />
        </div>
        <div className="console-info">
          <p>Open Browser DevTools (F12) to see the console logs.</p>
        </div>
      </div>
    </div>
  );
}

export default App;