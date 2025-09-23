import { BrowserRouter, Routes, Route } from "react-router-dom";
// eslint-disable-next-line
import NavBar from "./components/NavBar";
import HomePage from "./pages/HomePage";
import AboutPage from "./pages/AboutPage";
import ApiPage from "./pages/ApiPage";
function App() {
  return (
    <>
      <BrowserRouter>
      <NavBar/>
        <Routes>
          <Route path="/" element={<HomePage/>} />
          <Route path="/about" element={<AboutPage/>} />
          <Route path="/api" element={<ApiPage/>} />
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
