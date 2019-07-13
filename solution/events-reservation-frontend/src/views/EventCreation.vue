<template>
  <div class="event-creation">
    <h1 class="title important-text">
      Reserve your events
    </h1>

    <EventForm :event="event" />
  </div>
</template>

<script>
import EventForm from '@/components/EventForm.vue'

export default {
  name: 'EventCreation',
  components: {
    EventForm,
  },
  data() {
    const NOW = new Date()

    return {
      /**
       * Event creation params
       */
      event: {
        name: '',
        speaker: '',
        location: '',
        description: '',
        max_participants: 1,
        type: 'WorkShop',
        start_time: NOW,
        end_time: NOW,
      },
    }
  },
}
</script>

<style lang="stylus" scoped>
  .event-creation {
    .title {
      text-align: center
      margin-bottom: 20px
      font-weight: 500
      font-size: 1.3em
    }
  }
</style>
