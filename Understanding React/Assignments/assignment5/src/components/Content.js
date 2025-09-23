import React from 'react';
import { useTheme } from '../context/ThemeContext';
import './Content.css';

const Content = () => {
  const { styles, theme, isDark } = useTheme();

  return (
    <div className="content-container" style={{ color: styles.text }}>
      <div className="content">
        <h2 className="greeting">Hello Students!</h2>
        <p className="description">
          Welcome to the Theme Switcher application built with React Context API.
        </p>
        
        <div className="theme-info">
          <div className="info-card" style={{ backgroundColor: styles.secondary, borderColor: styles.border }}>
            <h3>Current Theme: <span style={{ color: styles.primary }}>{theme}</span></h3>
            <p>This text and background change based on the active theme.</p>
          </div>
        </div>

        <div className="features">
          <h3>Features:</h3>
          <ul>
            <li>Toggle between Light and Dark themes</li>
            <li>Uses React Context for state management</li>
            <li>Responsive design</li>
            <li>Smooth transitions</li>
          </ul>
        </div>

        <div className="theme-colors">
          <h3>Theme Colors:</h3>
          <div className="color-grid">
            <div className="color-item" style={{ backgroundColor: styles.background }}>
              <span>Background</span>
            </div>
            <div className="color-item" style={{ backgroundColor: styles.text, color: styles.background }}>
              <span>Text</span>
            </div>
            <div className="color-item" style={{ backgroundColor: styles.primary, color: 'white' }}>
              <span>Primary</span>
            </div>
            <div className="color-item" style={{ backgroundColor: styles.secondary, color: styles.text }}>
              <span>Secondary</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Content;