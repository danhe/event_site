<template>
  <label 
    class="base-label"
    :class="`label-${theme} label-${display}`"
  >
    {{ label }}
    <span 
      class="required-text"
      v-if="requiredOption"
    >
      *
    </span>
  </label>
</template>

<script>
export default {
  name: 'BaseLabel',

  props: {
    label: {
      type: String,
      default: null,
    },
    requiredOption: {
      type: Boolean,
      default: false,
    },
    theme: {
      type: String,
      default: 'normal',
    },
    display: {
      type: String,
      default: 'block',
    },
  },
}
</script>

<style lang="stylus" scoped>
  .base-label {
    font-size: .8em

    &.label-normal {
      color: var(--color-black)
    }

    &.label-important {
      color: var(--color-action)
    }

    &.label-negative {
      color: var(--color-negative)
    }

    &.label-block {
      display: block
    }

    &.label-inline-block {
      display: inline-block
    }

    .required-text {
      display: inline-block
      color: var(--color-negative)
    }
  }
</style>


