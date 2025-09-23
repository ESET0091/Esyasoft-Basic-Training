import React from 'react';
import { useTheme } from '../context/ThemeContext';
import ThemeSwitcher from './ThemeSwitcher';
import './Navbar.css';

const Navbar = () => {
  const { styles } = useTheme();

  return (
    <nav className="navbar" style={{ backgroundColor: styles.secondary, borderBottomColor: styles.border }}>
      <div className="navbar-content">
        <h1 className="navbar-title" style={{ color: styles.text }}>
          Theme Switcher App
        </h1>
        <ThemeSwitcher />
      </div>
    </nav>
  );
};

export default Navbar;