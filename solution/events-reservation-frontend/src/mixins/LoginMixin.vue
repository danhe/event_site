<script>
  import _get from 'lodash/get'
  import { mapGetters } from 'vuex'

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
    computed: {
      ...mapGetters([
        'storedUser',
      ]),
    },
    created() {
      const { storedUser } = this

      // Create private instance of axios with specific configurations
      this.$_eventMixin_instance = axios.create(storedUser)
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
       * Logout, make the store state user empty
       * And make sure server side to empty the user
       */
      logout() {
        const { 
          $_eventMixin_instance, 
          $_eventMixin_error,
        } = this

        return $_eventMixin_instance.delete('/sessions/user')
        .then((response) =>{
          return response
        })
        .catch($_eventMixin_error)
      },
      /**
       * Get user by token to verify the token is always valid
       * @param {String} token of user
       */
      getUserByToken(token) {
        const { 
          $_eventMixin_instance, 
          $_eventMixin_error,
        } = this

        return $_eventMixin_instance.get(`/users/${token}`)
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
