<template>
  <div class="login">
    <h2 class="login-title important-text">
      Login
    </h2>
    
    <form @submit="onSubmit">
      <div class="form-group">
        <BaseInput 
          v-model="login.email"
          label="Email"
          type="email"
          placeholder="Email"
          :requiredOption="true"
          :hasError="hasErrorInput('email', errors)"
          :errorMessage="errorsOfInput('email', errors)"
        />
      </div>

      <div class="form-group">
        <BaseInput 
          v-model="login.password"
          label="Password"
          placeholder="Password"
          type='password'
          :requiredOption="true"
          :hasError="hasErrorInput('password', errors)"
          :errorMessage="errorsOfInput('password', errors)"
        />
      </div>

      <BaseButton 
        class="login-button"
        type="submit"
      >
        Login
      </BaseButton>
    </form>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

import BaseButton from '@/components/core/BaseButton.vue'
import BaseInput from '@/components/core/BaseInput.vue'
import LoginMixin from '@/mixins/LoginMixin.vue'
import {
  hasErrorInput,
  errorsOfInput,
} from '@/utils/errors.js'

export default {
  name: "Login",
  components: {
    BaseButton,
    BaseInput,
  },
  data() {
    return {
      /**
       * login obejct
       */
      login: {},
    }
  },
  mixins: [
    LoginMixin,
  ],
  methods: {
    hasErrorInput,
    errorsOfInput,
    ...mapActions([
      'setUser',
    ]),
    async onSubmit($event) {
      const { authenticate, login, setUser } = this

      $event.preventDefault()

      const response = await authenticate(login)
      if (response) {
        setUser(response.data)

        this.$router.push('/events')
      }
    },
  },
}
</script>

<style lang="stylus" scoped>
  .login {
    margin: 20px 30%

    .login-title {
      text-align: center
      margin-bottom: 30px
    }

    .form-group {
      margin-bottom: 10px
    }

    .login-button {
      float: right
      margin-top: 30px
    }
  }
</style>
