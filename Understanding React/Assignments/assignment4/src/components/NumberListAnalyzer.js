import React, { useState, useMemo, useCallback } from 'react';
import './NumberListAnalyzer.css';

const NumberListAnalyzer = () => {
  const [numbers, setNumbers] = useState([]);
  const [inputValue, setInputValue] = useState('');

  // Add a number to the list
  const handleAddNumber = () => {
    if (inputValue.trim() === '' || isNaN(inputValue)) {
      alert('Please enter a valid number');
      return;
    }

    const num = parseFloat(inputValue);
    setNumbers(prevNumbers => [...prevNumbers, num]);
    setInputValue('');
  };

  // Remove a number from the list using useCallback
  const handleRemoveNumber = useCallback((index) => {
    setNumbers(prevNumbers => prevNumbers.filter((_, i) => i !== index));
  }, []);

  // Calculate statistics using useMemo
  const { sum, largest } = useMemo(() => {
    if (numbers.length === 0) {
      return { sum: 0, largest: null };
    }

    const calculatedSum = numbers.reduce((total, num) => total + num, 0);
    const calculatedLargest = Math.max(...numbers);
    
    return { sum: calculatedSum, largest: calculatedLargest };
  }, [numbers]);

  // Handle input key press
  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      handleAddNumber();
    }
  };

  return (
    <div className="number-list-analyzer">
      <h2>Number List Analyzer</h2>
      
      <div className="input-section">
        <input
          type="number"
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          onKeyPress={handleKeyPress}
          placeholder="Enter a number"
          className="number-input"
        />
        <button onClick={handleAddNumber} className="add-btn">
          Add Number
        </button>
      </div>
      
      <div className="stats-section">
        <h3>Statistics</h3>
        <div className="stats">
          <div className="stat">
            <span className="stat-label">Sum:</span>
            <span className="stat-value">{sum.toFixed(2)}</span>
          </div>
          <div className="stat">
            <span className="stat-label">Largest:</span>
            <span className="stat-value">
              {largest !== null ? largest.toFixed(2) : 'N/A'}
            </span>
          </div>
          <div className="stat">
            <span className="stat-label">Count:</span>
            <span className="stat-value">{numbers.length}</span>
          </div>
        </div>
      </div>
      
      <div className="list-section">
        <h3>Number List ({numbers.length} items)</h3>
        {numbers.length === 0 ? (
          <p className="empty-message">No numbers added yet</p>
        ) : (
          <ul className="number-list">
            {numbers.map((number, index) => (
              <NumberItem
                key={index}
                number={number}
                index={index}
                onRemove={handleRemoveNumber}
              />
            ))}
          </ul>
        )}
      </div>
    </div>
  );
};

// Separate component for list items to optimize rendering
const NumberItem = React.memo(({ number, index, onRemove }) => {
  return (
    <li className="number-item">
      <span className="number-value">{number}</span>
      <button 
        onClick={() => onRemove(index)} 
        className="remove-btn"
        aria-label={`Remove ${number}`}
      >
        ×
      </button>
    </li>
  );
});

export default NumberListAnalyzer;