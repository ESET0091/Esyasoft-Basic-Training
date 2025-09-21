import React, { useState } from 'react';
import MouseTracker from './components/MouseTracker';
import './App.css';

function App() {
  const [showTracker, setShowTracker] = useState(true);

  const toggleTracker = () => {
    setShowTracker(prev => !prev);
  };

  return (
    <div className="App">
      <div className="container">
        <h1>Mouse Tracker Assignment</h1>
        <button className="toggle-button" onClick={toggleTracker}>
          {showTracker ? 'Hide' : 'Show'} Mouse Tracker
        </button>
        
        {showTracker && <MouseTracker />}
        
        <div className="explanation">
          <h3>How it works:</h3>
          <ul>
            <li>Component uses useState to track mouse coordinates</li>
            <li>useEffect adds mousemove listener on mount</li>
            <li>Cleanup function removes listener on unmount</li>
            <li>Click the button above to toggle component and see cleanup in action</li>
          </ul>
          <p>Check the browser console for mount/unmount messages!</p>
        </div>
      </div>
    </div>
  );
}

export default App;