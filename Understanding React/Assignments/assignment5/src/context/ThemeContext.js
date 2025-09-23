import React, { createContext, useContext, useState } from 'react';

// Create Theme Context
const ThemeContext = createContext();

// Theme Provider Component
export const ThemeProvider = ({ children }) => {
  const [theme, setTheme] = useState('light');

  const toggleTheme = () => {
    setTheme(prevTheme => prevTheme === 'light' ? 'dark' : 'light');
  };

  const themeStyles = {
    light: {
      background: '#ffffff',
      text: '#000000',
      primary: '#667eea',
      secondary: '#f8f9fa',
      border: '#dee2e6'
    },
    dark: {
      background: '#1a1a1a',
      text: '#ffffff',
      primary: '#764ba2',
      secondary: '#2d3748',
      border: '#4a5568'
    }
  };

  const value = {
    theme,
    toggleTheme,
    styles: themeStyles[theme],
    isDark: theme === 'dark'
  };

  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
};

// Custom hook to use theme context
export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
};

export default ThemeContext;