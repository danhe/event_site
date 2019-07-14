import axios from 'axios'

function create() {
  return axios.create({
    baseURL: process.env.VUE_APP_API_ENDPOINT,
    timeout: 10000,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  })
}

export default {
  create,
}