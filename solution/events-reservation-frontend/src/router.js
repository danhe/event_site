import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/events',
      name: 'Liste all events',
      component: () => import(/* webpackChunkName: "about" */ './views/Event.vue'),
    },
    {
      path: '/events/new',
      name: 'Create your events',
      component: () => import(/* webpackChunkName: "about" */ './views/EventCreation.vue'),
    },
    {
      path: '/events/:id',
      name: 'Event detail',
      component: () => import(/* webpackChunkName: "about" */ './views/EventDetail.vue'),
    },
    {
      path: '/login',
      name: 'Login',
      component: () => import(/* webpackChunkName: "about" */ './views/Login.vue'),
    },
    {
      path: '/invitation',
      name: 'Invitation',
      component: () => import(/* webpackChunkName: "about" */ './views/Invitation.vue'),
    },
    {
      path: '/register/:token',
      name: 'Register',
      component: () => import(/* webpackChunkName: "about" */ './views/Register.vue'),
      props: true,
    }
  ],
})
