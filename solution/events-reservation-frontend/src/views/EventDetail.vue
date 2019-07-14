<template>
  <div class="event-detail">
    <h1 class="title important-text">
      Event detail
    </h1>

    <EventForm 
      :event="event"
      :readonly="true"
    />
  </div>
</template>

<script>
import EventForm from '@/components/EventForm.vue'

export default {
  name: 'EventDetail',
  components: {
    EventForm,
  },
  computed: {
    event() {
      return []
    },
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
