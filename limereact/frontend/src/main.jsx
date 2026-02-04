import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './assets/css/sb-admin-2.min.css'
import App from './App.jsx'
import axios from 'axios'


axios.defaults.baseURL = 'http://localhost:8080'
axios.defaults.withCredentials = true

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
)