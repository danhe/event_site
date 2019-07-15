<template>
  <button
    class="base-button"
    :class="classes"
    :disabled="disabled"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </button>
</template>

<script>
export default {
  name: 'BaseButton',
  inheritAttrs: false,
  props: {
    /**
     * Theme to apply to the button
     */
    theme: {
      type: String,
      default: 'primary',
    },
    /**
     * Used to disable the button and apply a specific style
     */
    disabled: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    /**
     * Compute the classes to apply at the root according to the given props
     * @return {Object}
     */
    classes() {
      const { theme, disabled } = this

      return {
        [`btn--${theme}`]: true,
        'btn--disabled': disabled,
      }
    },
  },
}
</script>

<style lang="stylus" scoped>
  .base-button {
    border-radius: 6px
    border: 0.0777777778em solid var(--color-white)
    font-weight: 600
    font-size: 0.8888888889em
    line-height: 2.525em
    transition: all .5s ease
    display: inline-flex
    padding: 0 1.9375em
    cursor: pointer

    &.btn--primary {
      background-color: var(--color-action)
      color: var(--color-white)

      > * {
        color: var(--color-white)
      }
    }

    &.btn--secondary {
      background-color: var(--color-white)
      color: var(--color-action)
      border: 1px solid var(--color-action)
    }

    &.btn--positive {
      background-color: var(--color-white)
      color: var(--color-positive)
    }
    
    &.btn--disabled {
      opacity: 0.5
      cursor: not-allowed
    }
  }
</style>
