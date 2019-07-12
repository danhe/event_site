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
        /**
         * Notifications list
         */
        notifications: {
          errors: [],
          success: [],
          infos: []
        },
        /**
         * Priavte variable:
         *  axios instance
         */
        $_eventMixin_instance: null,
      }
      
    },
    created() {
      console.log(process.env)
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
      getEvents() {        
        const { 
          $_eventMixin_instance, 
          $_eventMixin_success, 
          $_eventMixin_error,
        } = this

        this.isLoading = true

        return $_eventMixin_instance.get('/events')
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

        const message = _get(response, 'data.message')
        this.notifications.success = message

        this.$router.push('/events')
      },
      /**
       * Private method
       * Update the errors liste
       */
      $_eventMixin_error(error) {
        this.isLoading = false

        const errors = _get(error, 'response.data.errors')
        this.notifications.errors = errors
      },
    },
  }
</script>
