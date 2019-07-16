<template>
  <div class="invitation">
    <h2 class="invitation-title important-text">
      Invite your friends
    </h2>

    <div 
      v-if="emailSent" 
    >
      You'll receive an email which contains un magic link in your email box.
      <div class="accent-text">
        (In production, the email will be sent to mailtrap. And in development it will be opened by browser)
      </div>
    </div>
    
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
import { mapGetters } from 'vuex'

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
      /**
       * Invitation email input error indicator
       */
      hasError: false,
      emailSent: false,
    }
  },
  computed: {
    ...mapGetters([
      'storedUser',
    ]),
    /**
     * Error display message
     */
    errorMessage() {
      const { hasError } = this 

      return hasError ? ERR_MSG : null
    },
  },
  methods: {
    /**
     * When clicking on button to invite friend
     * @param {Object} event of clicking
     */
    async onSubmit($event) {
      $event.preventDefault()

      const { email, storedUser } = this
      const axiosInstance = axios.create(storedUser)

      axiosInstance.post('/invitations', {
        email: email,
      })
        .then((response) =>{
          this.hasError = response.data.email_warning
          this.emailSent = response.data.email_sent
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
