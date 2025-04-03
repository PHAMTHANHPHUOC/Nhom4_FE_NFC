// import axios from 'axios'

// const instance = axios.create({
//   baseURL: 'http://localhost/Nhom4_BE_NFC/api',
//   timeout: 10000,
//   headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json'
//   }
// })

// // Thêm interceptor để xử lý token nếu cần
// instance.interceptors.request.use(
//   config => {
//     const token = localStorage.getItem('token')
//     if (token) {
//       config.headers.Authorization = `Bearer ${token}`
//     }
//     return config
//   },
//   error => Promise.reject(error)
// )

// export default instance