<script>
  import _get from 'lodash/get'

  import axios from '@/utils/axios.js'

  export default {
    data() {
      return {
        errors: [],
        /**
         * Priavte variable:
         *  axios instance
         */
        $_eventMixin_instance: null,
      }
    },
    created() {
      // Create private instance of axios with specific configurations
      this.$_eventMixin_instance = axios.create()
    },
    methods: {
      /**
       * Sending request to server to get the events
       *  - if success, return the events list
       *  - if error, toggle error indicator to true
       */
      authenticate(loginParams) {
        const { 
          $_eventMixin_instance, 
          $_eventMixin_error,
        } = this

        return $_eventMixin_instance.post('/sessions', loginParams)
        .then((response) =>{
          return response
        })
        .catch($_eventMixin_error)
      },
      /**
       * Private method
       * Update the errors liste
       */
      $_eventMixin_error(error) {
        this.errors = _get(error, 'response.data.errors')
      },
    },
  }
</script>
