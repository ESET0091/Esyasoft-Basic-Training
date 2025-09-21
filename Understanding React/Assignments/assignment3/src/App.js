import React from 'react';
import ColorBoxHighlighter from './components/ColorBoxHighlighter';
import './App.css';

function App() {
  return (
    <div className="App">
      <div className="container">
        <h1>Color Box Highlighter with useRef</h1>
        <ColorBoxHighlighter />
        
        <div className="explanation">
          <h3>How it works:</h3>
          <ul>
            <li>Uses <code>useRef</code> to store references to the colored boxes</li>
            <li>Applies styles directly to DOM elements using refs</li>
            <li>Highlights boxes in sequence on button click</li>
            <li>Includes a reset button to clear all highlights</li>
            <li>Demonstrates direct DOM manipulation with React refs</li>
          </ul>
        </div>
      </div>
    </div>
  );
}

export default App;