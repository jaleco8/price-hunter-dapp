import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import vuetify from './plugins/vuetify'

import routes from './routes'

Vue.use(VueRouter)
Vue.config.productionTip = false

const router = new VueRouter({
  mode: 'history', 
  routes
});

new Vue({
  vuetify,
  render: h => h(App),
  router
}).$mount('#app')
