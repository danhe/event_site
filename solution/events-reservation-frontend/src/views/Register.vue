<template>
  <div class="register">
    <h2 class="register-title important-text">
      Invite your friends
    </h2>
    
    <form @submit="onSubmit">
      <div class="form-group">
        <BaseInput 
          v-model="register.password"
          label="Password"
          type="password"
          placeholder="Password"
        />
      </div>

      <div class="form-group">
        <BaseInput 
          v-model="register.password_confirmation"
          label="Password confirmation"
          type="password"
          placeholder="Password confirmation"
        />
      </div>

      <BaseButton 
        class="register-button"
        type="submit"
      >
        invite
      </BaseButton>
    </form>
  </div>
</template>

<script>
import BaseButton from '@/components/core/BaseButton.vue'
import BaseInput from '@/components/core/BaseInput.vue'
import axios from '@/utils/axios.js'

export default {
  name: "Register",
  components: {
    BaseButton,
    BaseInput,
  },
  data() {
    return {
      /**
       * register password object
       */
      register: {},
    }
  },
  props: {
    token: {
      type: String,
      required: true,
    },
  },
  methods: {
    async onSubmit($event) {
      $event.preventDefault()

      const { register, token } = this
      const axiosInstance = axios.create()

      axiosInstance.post('/register', {
        register: register,
        token: token,
      })
        .then((response) =>{
          if (response) {
            this.$router.push('/events')
          }
        })
        .catch((response) => {
          console.error(response)
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
