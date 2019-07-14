import Vue from 'vue'
import App from './App.vue'
import router from './router'
import useRouterGuards from './router/guards'
import store from './store'

Vue.config.productionTip = false

// Router verification
useRouterGuards(router, store)

new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')
