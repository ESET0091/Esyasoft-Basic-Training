import React, { useRef, useState } from 'react';
import './ColorBoxHighlighter.css';

const ColorBoxHighlighter = () => {
  const boxRefs = useRef([]);
  const [currentHighlight, setCurrentHighlight] = useState(-1);

  const colors = ['red', 'green', 'blue'];
  
  const highlightNextBox = () => {
    // Remove highlight from current box
    if (currentHighlight >= 0 && boxRefs.current[currentHighlight]) {
      boxRefs.current[currentHighlight].style.border = '2px solid #ccc';
      boxRefs.current[currentHighlight].style.transform = 'scale(1)';
    }
    
    // Calculate next box index
    const nextIndex = (currentHighlight + 1) % colors.length;
    
    // Apply highlight to next box
    if (boxRefs.current[nextIndex]) {
      boxRefs.current[nextIndex].style.border = '4px solid yellow';
      boxRefs.current[nextIndex].style.boxShadow = '0 0 15px rgba(255, 255, 0, 0.7)';
      boxRefs.current[nextIndex].style.transform = 'scale(1.05)';
    }
    
    setCurrentHighlight(nextIndex);
  };

  const resetHighlights = () => {
    // Remove all highlights
    boxRefs.current.forEach(box => {
      if (box) {
        box.style.border = '2px solid #ccc';
        box.style.boxShadow = 'none';
        box.style.transform = 'scale(1)';
      }
    });
    setCurrentHighlight(-1);
  };

  return (
    <div className="color-box-highlighter">
      <h2>Color Box Highlighter</h2>
      
      <div className="boxes-container">
        {colors.map((color, index) => (
          <div
            key={index}
            ref={el => boxRefs.current[index] = el}
            className="color-box"
            style={{ backgroundColor: color }}
          >
            {color.charAt(0).toUpperCase() + color.slice(1)}
          </div>
        ))}
      </div>
      
      <div className="controls">
        <button className="highlight-btn" onClick={highlightNextBox}>
          Highlight Next Box
        </button>
        <button className="reset-btn" onClick={resetHighlights}>
          Reset Highlights
        </button>
      </div>
      
      <div className="status">
        <p>Current highlight: {currentHighlight >= 0 ? colors[currentHighlight] : 'None'}</p>
      </div>
      
      <div className="instructions">
        <p>Click "Highlight Next Box" to cycle through the colored boxes</p>
        <p>Each click will highlight the next box with a yellow border</p>
      </div>
    </div>
  );
};

export default ColorBoxHighlighter;