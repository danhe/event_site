<template>
  <div class="register">
    <div 
      v-if="isValidToken"
      class="valid-token"
    >
      <h2 class="register-title important-text">
        Init your password
      </h2>
      
      <form @submit="onSubmit">
        <div class="form-group">
          <BaseInput 
            v-model="register.password"
            label="Password"
            type="password"
            placeholder="Password"
            :requiredOption="true"
            :hasError="hasErrorInput('password', errors)"
            :errorMessage="errorsOfInput('password', errors)"
          />
        </div>

        <div class="form-group">
          <BaseInput 
            v-model="register.password_confirmation"
            label="Password confirmation"
            type="password"
            placeholder="Password confirmation"
            :requiredOption="true"
            :hasError="hasErrorInput('password_confirmation', errors)"
            :errorMessage="errorsOfInput('password_confirmation', errors)"
          />
        </div>

        <BaseButton 
          class="register-button"
          type="submit"
        >
          Confirm
        </BaseButton>
      </form>

    </div>

    <div
      v-else
      class="invalid-token"
    >
      <h2>
        This invitation link is no longer active.
      </h2>
      <p>
        Please contact the person who shared it with you, and check if there is a new link available.
      </p>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import _get from 'lodash/get'

import BaseButton from '@/components/core/BaseButton.vue'
import BaseInput from '@/components/core/BaseInput.vue'
import LoginMixin from '@/mixins/LoginMixin.vue'
import axios from '@/utils/axios.js'
import {
  hasErrorInput,
  errorsOfInput,
} from '@/utils/errors.js'

export default {
  name: "Register",
  components: {
    BaseButton,
    BaseInput,
  },
  mixins: [
    LoginMixin,
  ],
  data() {
    return {
      /**
       * register password object
       */
      register: {},
      /**
       * Indicator for valid token
       */
      isValidToken: true,
      /**
       * Formulair errors list
       */
      errors: [],
    }
  },
  props: {
    /**
     * Url params token
     */
    token: {
      type: String,
      required: true,
    },
  },
    /**
   * Check if the token is valid
   */
  async created(){
    const { getUserByToken, token } = this

    const response = await getUserByToken(token)
    this.isValidToken = !!_get(response, 'data.is_valid_token')
  },
  computed: {
    ...mapGetters([
      'storedUser',
    ]),
  },
  methods: {
    hasErrorInput,
    errorsOfInput,
    ...mapActions([
      'setUser',
    ]),
    /**
     * When clicking on button to set password
     * @param {Object} event of clicking 
     */
    async onSubmit($event) {
      $event.preventDefault()

      const { register, token, setUser, storedUser } = this
      const axiosInstance = axios.create(storedUser)

      axiosInstance.post(`/register/${token}`, {
        register: register,
      })
        .then((response) =>{
          if (response) {
            // When update password successfully, login automatically
            setUser(response.data)
            this.$router.push('/events')
          }
        })
        .catch((response) => {
          this.errors = response.response.data.errors
        })
    },
  },
}
</script>

<style lang="stylus" scoped>
  .register {
    margin: 20px 30%

    .register-title {
      text-align: center
      margin-bottom: 30px
    }

    .form-group {
      margin-bottom: 10px
    }

    .register-button {
      float: right
      margin-top: 30px
    }
  }
</style>
