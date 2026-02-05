import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import "bootstrap/dist/css/bootstrap.min.css";
import './assets/css/sb-admin-2.min.css'
import App from './App.jsx'
import axios from 'axios'
import '@fortawesome/fontawesome-free/css/all.min.css'


axios.defaults.baseURL = 'http://localhost:8080'
axios.defaults.withCredentials = true

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
)