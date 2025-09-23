import React from 'react'
import { Link } from 'react-router-dom'

export default function NavBar() {
  return (
    <div>
     {/* <ul>
        <li>Home</li>
        <li>About</li>
        <li>Contact</li>
     </ul> */}
     Navbar &nbsp; &rarr;
     <Link to='/'>Home</Link>&nbsp;
     <Link to='/about'>About</Link>&nbsp;
     <Link to='/api'>API</Link>&nbsp;
    </div>
  )
}
