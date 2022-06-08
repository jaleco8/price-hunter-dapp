// Define route components
import Dashboard from './components/Dashboard.vue'
import PriceList from './components/PriceList.vue'

// Define some routes
const routes = [
  { path: '/', component: Dashboard },
  { path: '/price-list', component: PriceList }
]

export default routes;
