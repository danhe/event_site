import Vue from 'vue'
import Vuex from 'vuex'
import _get from 'lodash/get'

Vue.use(Vuex)

const ADD_EVENTS = 'ADD_EVENTS'
const ADD_ERRORS = 'ADD_ERRORS'
const ADD_MSGS = 'ADD_MSGS'
const RESET_NOTIF = 'RESET_NOTIF'

export default new Vuex.Store({
  state: {
    events: [],
    errors: [],
    messages: [],
  },
  getters: {
    /**
     * Get the stored events
     * @param {Object} state of the application
     * @return {Array} list of events
     */
    storedEvents(state) {
      return _get(state, 'events', [])
    },
    /**
     * Get the stored errors
     * @param {Object} state of the application
     * @return {Array} list of errors
     */
    storedErrors(state) {
      return _get(state, 'errors', [])
    },
    /**
     * Get the stored messages
     * @param {Object} state of the application
     * @return {Array} list of messages
     */
    storedMessages(state) {
      return _get(state, 'messages', [])
    },
  },
  mutations: {
    /**
     * Add events to the store
     */
    [ADD_EVENTS](state, events) {
      state.events = events
    },
    /**
     * Add errors to the store
     */
    [ADD_ERRORS](state, errors) {
      state.errors = errors
    },
    /**
     * Add messages to the store
     */
    [ADD_MSGS](state, messages) {
      state.messages = messages
    },
    /**
     * Reset errors and messages
     */
    [RESET_NOTIF](state) {
      state.messages = []
      state.errors = []
    },
  },
  actions: {
    /**
     * Add events to the store
     * @param {Object} context 
     * @param {Object} payload 
     */
    addEvents({ commit }, payload) {
      commit(ADD_EVENTS, payload)
    },
    /**
     * Add errors to the store
     * @param {Object} context 
     * @param {Object} payload 
     */
    addErrors({ commit }, payload) {
      commit(ADD_ERRORS, payload)
    },
    /**
     * Add messages to the store
     * @param {Object} context 
     * @param {Object} payload 
     */
    addMessages({ commit }, payload) {
      commit(ADD_MSGS, payload)
    },
    /**
     * Reset messages and errors in the store
     * @param {Object} context 
     * @param {Object} payload 
     */
    resetMsgsAndErrs({ commit }, payload) {
      commit(RESET_NOTIF, payload)
    },
  },
})
