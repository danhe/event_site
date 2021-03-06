<template>
  <router-link 
    class="event-card"
    :to="`/events/${event.id}`"
  >
    <div class="body">
      <article class="content">
        <h4 class="important-text">
          {{ event.name }}

          <BaseTag 
            class="event-type-tag"
            :text="event.type"
            :theme="isWorkShop ? 'positive' : 'accent'"
          />
        </h4>

        <div v-if="event.description">
          {{ event.description }}
        </div>

        <div v-if="event.speaker">
          🗣{{ event.speaker }}
        </div>

        <div>
          <span class="event-span">
            👨‍👧‍👦 {{ event.max_participants }}
          </span>

          <span 
            class="event-span"
            v-if="event.location"
          >
            🗺{{ event.location }}
          </span>
          
          <span class="event-span">
            📅 {{ displayDurantion }}
          </span>
        </div>
      </article>
    </div>
  </router-link> 
</template>

<script>
import BaseTag from '@/components/core/BaseTag.vue'

export default {
  name: 'EventCard',
  components: {
    BaseTag,
  },
  props: {
    /**
     * Event object to display
     */
    event: {
      type: Object,
      required: true,
    },
  },
  computed: {
    /**
     * Display the duration of event: comosite with start-time and end_time
     */
    displayDurantion() {
      const { event } = this

      return new Date(event.start_time).toLocaleString() + ' -- ' + new Date(event.end_time).toLocaleString()
    },
    /**
     * Indicator to check if an event is a workshop
     */
    isWorkShop(){
      const { event } = this

      return event.type === 'WorkShop'
    },
  },
}
</script>

<style lang="stylus" scoped>
.event-card {
  color: var(--color-black)
  text-align: left
  margin: 10px 0
  position: relative
  display: -ms-flexbox
  display: flex
  -ms-flex-direction: column
  flex-direction: column
  min-width: 0
  word-wrap: break-word
  background-clip: border-box
  border: 1px solid rgba(0,0,0,.125)
  border-radius: .25rem
  background-color: var(--color-grey)
  font-size: .9rem

  .event-type-tag {
    float: right
  }
  
  .body {
    flex: 1 1 auto
    padding: 1.25rem

    .event-span {
      margin-right: 5px
    }
  }
}
</style>
