import React from 'react';
import NumberListAnalyzer from './components/NumberListAnalyzer';
import './App.css';

function App() {
  return (
    <div className="App">
      <div className="container">
        <h1>Number List Analyzer</h1>
        <p className="subtitle">Using useMemo and useCallback</p>
        <NumberListAnalyzer />
        
        <div className="explanation">
          <h3>How it works:</h3>
          <ul>
            <li><strong>useMemo</strong>: Calculates sum and largest number only when the list changes</li>
            <li><strong>useCallback</strong>: Creates a stable remove function that doesn't change unnecessarily</li>
            <li><strong>React.memo</strong>: Optimizes list item rendering to prevent unnecessary re-renders</li>
            <li>Add numbers using the input field and see statistics update in real-time</li>
          </ul>
        </div>
      </div>
    </div>
  );
}

export default App;