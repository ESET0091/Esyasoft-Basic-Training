import React, { useState, useEffect } from 'react';
import './MouseTracker.css';

const MouseTracker = () => {
  const [position, setPosition] = useState({ x: 0, y: 0 });

  useEffect(() => {
    const handleMouseMove = (event) => {
      setPosition({ x: event.clientX, y: event.clientY });
    };

    // Add event listener when component mounts
    window.addEventListener('mousemove', handleMouseMove);
    console.log('Mouse move event listener added');

    // Clean up event listener when component unmounts
    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      console.log('Mouse move event listener removed');
    };
  }, []); // Empty dependency array means this runs once on mount

  return (
    <div className="mouse-tracker">
      <h2>Mouse Position Tracker</h2>
      <div className="position-display">
        <p>X: {position.x}px</p>
        <p>Y: {position.y}px</p>
      </div>
      <div className="visual-tracker" style={{ left: position.x, top: position.y }}>
        <div className="tracker-dot"></div>
      </div>
      <div className="instructions">
        <p>Move your mouse around the screen to see coordinates update</p>
        <p>Check browser console for mount/unmount messages</p>
      </div>
    </div>
  );
};

export default MouseTracker;