<template>
  <div class="invitation">
    <h2 class="invitation-title important-text">
      Invite your friends
    </h2>
    
    <form @submit="onSubmit">
      <div class="form-group">
        <BaseInput 
          v-model="email"
          label="Email"
          type="email"
          placeholder="Email"
          :hasError="hasError"
          :errorMessage="errorMessage"
        />
      </div>

      <BaseButton 
        class="invitation-button"
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

const ERR_MSG = 'The email has been already invited or is alreay an user of application'

export default {
  name: "Invitation",
  components: {
    BaseButton,
    BaseInput,
  },
  data() {
    return {
      /**
       * email to invite
       */
      email: '',
      hasError: false
    }
  },
  computed: {
    errorMessage() {
      const { hasError } = this 

      return hasError ? ERR_MSG : null
    }
  },
  methods: {
    async onSubmit($event) {
      $event.preventDefault()

      const { email } = this
      const axiosInstance = axios.create()

      axiosInstance.post('/invitations', {
        email: email,
      })
        .then((response) =>{
          this.hasError = response.data.email_warning
        })
        .catch(() => {
        })
    },
  },
}
</script>

<style lang="stylus" scoped>
  .invitation {
    margin: 20px 30%

    .invitation-title {
      text-align: center
      margin-bottom: 30px
    }

    .form-group {
      margin-bottom: 10px
    }

    .invitation-button {
      float: right
      margin-top: 30px
    }
  }
</style>
