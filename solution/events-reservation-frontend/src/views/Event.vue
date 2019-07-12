<template>
  <div class="event">
    <h2 class="title">
      All events
    </h2>

    <EventCardsList 
      class="events-list"
      :events="events"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import EventCardsList from '@/components/EventCardsList.vue'
import EventMixin from '@/mixins/EventMixin.vue'

export default {
  name: 'Event',
  components: {
    EventCardsList,
  },
  computed: {
    ...mapGetters({
      events: 'storedEvents',
    }),
  },
  mixins: [
    EventMixin,
  ],
  async created(){
    const { getEvents } = this

    await getEvents()
  },
}
</script>

<style lang="stylus" scoped>
  .event {
    text-align: center
    font-weight: 500
    font-size: 1.3em

    .title {
      line-height: 1.5294117647em
      margin: 0.5em 0.5em 0.95em 0.5em
    }

    .events-list {
      margin: 20px 20%
    }
  }
</style>
