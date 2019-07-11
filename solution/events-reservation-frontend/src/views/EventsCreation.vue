<template>
  <div class="events-creation">
    <h1 class="important-text">
      Reserve your events
    </h1>
  </div>
</template>

<script>
import BaseButton from '@/components/core/BaseButton.vue'

export default {
  name: 'events-creation',
  components: {
    BaseButton,
  },
}
</script>

<style lang="stylus" scoped>
  .events-creation {
    text-align: center
    font-weight: 500
    font-size: 1.3em

    .title {
      line-height: 1.5294117647em
      margin: 0.5em 0.5em 0.95em 0.5em
    }
  }
</style>
