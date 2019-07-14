<template>
  <div class="event-detail">
    <h1 class="title important-text">
      Event detail
    </h1>

    <EventForm 
      :event="event"
      :disabled="true"
    />
  </div>
</template>

<script>
import _get from 'lodash/get'

import EventForm from '@/components/EventForm.vue'
import EventMixin from '@/mixins/EventMixin.vue'

export default {
  name: 'EventDetail',
  components: {
    EventForm,
  },
  data() {
    return {
      /**
       * Event object to display
       */
      event: {},
    }
  },
  mixins: [
    EventMixin,
  ],
  /**
   * Get event by its id when creating the component
   */
  async created(){
    const { getEventById } = this

    const response = await getEventById(this.$route.params.id)
    this.event = _get(response, 'data.events')
  },
}
</script>

<style lang="stylus" scoped>
  .event-detail {
    .title {
      text-align: center
      margin-bottom: 20px
      font-weight: 500
      font-size: 1.3em
    }

    .form {
      max-width: 420px
      margin: auto

      .form-group {
        margin-bottom: 1em

        .datetime-picker {
          >>> input {
            border-radius: 0.25rem
          }
        }
      }
    }
  }
</style>
