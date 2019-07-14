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
        />
      </div>

      <div class="form-group">
        <BaseInput 
          v-model="login.password"
          label="Password"
          placeholder="Password"
          type='password'
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
import BaseButton from '@/components/core/BaseButton.vue'
import BaseInput from '@/components/core/BaseInput.vue'
import LoginMixin from '@/mixins/LoginMixin.vue'

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
    async onSubmit($event) {
      const { authenticate, login } = this

      $event.preventDefault()

      const response = await authenticate(login)
      if (response) {
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
