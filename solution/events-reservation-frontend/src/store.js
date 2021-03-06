import Vue from 'vue'
import Vuex from 'vuex'
import _get from 'lodash/get'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

const SET_USER = 'SET_USER'

export default new Vuex.Store({
  state: {
    /**
     * Logged user
     */
    user: {},
  },
  plugins: [createPersistedState()],
  getters: {
    /**
     * Check if user is logged in
     * @param {Object} state of the application
     * @return {Boolean} 
     */
    isLoggedIn(state) {
      return !!_get(state, 'user.email')
    },
    /**
     * Check if user is an admin
     * @param {Object} state of the application
     * @return {Boolean} 
     */
    isAdmin(state) {
      return _get(state, 'user.role') === 'admin'
    },
     /**
     * Get current user
     * @param {Object} state of the application
     * @return {String} name of user
     */
    userName(state) {
      return _get(state, 'user.name') || _get(state, 'user.email')
    },
      /**
     * Get current user
     * @param {Object} state of the application
     * @return {String} name of user
     */
    storedUser(state) {
      return _get(state, 'user', {})
    },
  },
  mutations: {
    /**
     * Add user to the store
     */
    [SET_USER](state, user) {
      Vue.set(state, 'user', user)
    },
  },
  actions: {
    /**
     * Set user in store
     * @param {Object} context 
     * @param {Object} payload 
     */
    setUser({ commit }, payload) {
      commit(SET_USER, payload)
    },
  },
})
