<template>
  <div class="event-cards-list">
    <EventCard 
      v-for="event in events"
      :key="event.id"
      :event="event"
    />
  </div> 
</template>

<script>
import EventCard from '@/components/EventCard.vue'

export default {
  name: 'EventCardsList',
  components: {
    EventCard,
  },
  props: {
    events: {
      type: Array,
      required: true,
    },
  },
}
</script>