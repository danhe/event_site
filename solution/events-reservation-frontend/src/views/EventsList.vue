<template>
  <div class="events">
    <h2 class="title">
      Reserve your events now
      <br />
      Here we go
    </h2>

    <div>
      <BaseButton>
        <router-link to="/events/new">
          Create an event
        </router-link>
      </BaseButton>
    </div>
  </div>
</template>

<script>
import BaseButton from '@/components/core/BaseButton.vue'

export default {
  name: 'EventsList',
  components: {
    BaseButton,
  },
}
</script>

<style lang="stylus" scoped>
  .events {
    text-align: center
    font-weight: 500
    font-size: 1.3em

    .title {
      line-height: 1.5294117647em
      margin: 0.5em 0.5em 0.95em 0.5em
    }
  }
</style>
