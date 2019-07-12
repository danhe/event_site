<script>
  import axios from 'axios'
  import { mapActions } from 'vuex'
  import _get from 'lodash/get'

  export default {
    data() {
      return {
        /**
         * Loading indicator
         */
        isLoading: false,
        /**
         * Priavte variable:
         *  axios instance
         */
        $_eventMixin_instance: null,
      }
      
    },
    created() {
      // Create private instance of axios with specific configurations
      this.$_eventMixin_instance = axios.create({
        baseURL: process.env.VUE_APP_API_ENDPOINT,
        timeout: 10000,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      })
    },
    methods: {
      ...mapActions([
        'addEvents',
        'addErrors',
        'addMessages',
        'resetMsgsAndErrs',
      ]),
      /**
       * Sending request to server to get the events
       *  - if success, return the events list
       *  - if error, toggle error indicator to true
       */
      getEvents(searchParams) {
        const { 
          $_eventMixin_instance, 
          $_eventMixin_success, 
          $_eventMixin_error,
          resetMsgsAndErrs,
        } = this

        resetMsgsAndErrs()
        this.isLoading = true

        return $_eventMixin_instance.get('/events', {
          params: searchParams,
        })
        .then($_eventMixin_success)
        .catch($_eventMixin_error)
      },

      /**
       * Sending request to server to get the events
       *  - if success, return the events list
       *  - if error, toggle error indicator to true
       */
      createEvent(eventParam) {
        const { 
          $_eventMixin_instance, 
          $_eventMixin_success, 
          $_eventMixin_error,
          resetMsgsAndErrs,
        } = this

        resetMsgsAndErrs()
        this.isLoading = true

        return $_eventMixin_instance.post('/events', eventParam)
        .then($_eventMixin_success)
        .catch($_eventMixin_error)
      },
      /**
       * Private method
       * Return posts list when success
       * @param {Object} response of the query sent in getEvents
       */
      $_eventMixin_success(response) {
        const { addEvents, addMessages } = this

        this.isLoading = false

        const message = _get(response, 'data.message')
        // add in store
        if(message !== undefined) {
          addMessages(message)
        }

        const events = _get(response, 'data.events')
        // add in store
        if(events !== undefined) {
          addEvents(events)
        }


        this.$router.push('/events')
      },
      /**
       * Private method
       * Update the errors liste
       */
      $_eventMixin_error(error) {
        const { addErrors } = this
        this.isLoading = false

        const errors = _get(error, 'response.data.errors')
        addErrors(errors)
      },
    },
  }
</script>
