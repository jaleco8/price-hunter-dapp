import axios from "axios";
export const URL_API = process.env.VUE_APP_URL_API;

/* Api axios  */
export const apiAxios = axios.create({
  baseURL: URL_API,
  headers: {
    'Content-Type': 'application/json',
    'X-Consumer-Key': process.env.VUE_APP_CONSUMER_KEY,
    'X-Consumer-Secret': process.env.VUE_APP_CONSUMER_SECRET,
    'X-Token': process.env.VUE_APP_TOKEN
  }
})