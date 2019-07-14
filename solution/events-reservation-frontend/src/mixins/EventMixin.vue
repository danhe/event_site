<script>
  import axios from 'axios'
  import _get from 'lodash/get'

  export default {
    data() {
      return {
        /**
         * Loading indicator
         */
        isLoading: false,
        errors: [],
        messages: [],
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
        } = this

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
      getEventById(id) {
        const { 
          $_eventMixin_instance, 
          $_eventMixin_success, 
          $_eventMixin_error,
        } = this

        this.isLoading = true

        return $_eventMixin_instance.get(`/events/${id}`)
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
        } = this

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
        this.isLoading = false
        return response
      },
      /**
       * Private method
       * Update the errors liste
       */
      $_eventMixin_error(error) {
        const { addErrors } = this
        this.isLoading = false

        this.errors = _get(error, 'response.data.errors')
      },
    },
  }
</script>
