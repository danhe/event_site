<template>
  <span :class="`base-tag tag-${theme}`">
    {{ text }}
  </span>
</template>

<script>
export default {
  name: 'BaseTag',
  props: {
    text: {
      type: String,
      default: null,
    },
    theme: {
      type: String,
      default: 'normal',
    },
  },
}
</script>

<style lang="stylus" scoped>
  .base-tag {
    display: inline-block
    padding: .8em 1em
    font-size: 60%
    line-height: 1px
    text-align: center
    white-space: nowrap
    vertical-align: baseline
    border-radius: .25rem
    text-transform: uppercase
    font-weight: 600

    &.tag-normal {
      color: var(--color-white)
      background-color: var(--color-black)
    }

    &.tag-important {
      color: var(--color-white)
      background-color: var(--color-action)
    }

    &.tag-positive {
      color: var(--color-positive)
      background-color: var(--color-positive-transparent)
    }

    &.tag-accent {
      color: var(--color-accent)
      background-color: var(--color-accent-transparent)
    }

    &.tag-negative {
      color: var(--color-white)
      background-color: var(--color-negative)
    }
  }
</style>


