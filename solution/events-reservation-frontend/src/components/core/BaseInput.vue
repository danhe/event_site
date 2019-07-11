<template>
  <div 
    class="base-input"
    :class="`base-input-${$attrs.type}`"
  >
    <label 
      class="label-title"
      v-if="label"
    >
      {{ label }}
      <span 
        class="required-text"
        v-if="requiredOption"
      >
        *
      </span>
    </label>

    <input 
      class="base-input"
      v-bind="$attrs"
      v-on="$listeners"
      @input="$emit('input', $event.target.value)"
    />

    <label v-if="labelText">
      {{ labelText }}
    </label>
  </div>
</template>

<script>
export default {
  name: 'BaseInput',
  inheritAttrs: false,
  props: {
    label: {
      type: String,
      default: null,
    },
    labelText: {
      type: String,
      default: null,
    },
    requiredOption: {
      type: Boolean,
      default: false,
    },
  },
}
</script>

<style lang="stylus" scoped>
  .base-input {

    &.base-input-radio {
      display: inline-block
      margin-right: 10px
    }

    label {
      font-size: .8em
      color: var(--color-black)
  
      &.label-title {
        color: var(--color-action)
        display: block    
      }

      .required-text {
        display: inline-block
        color: var(--color-negative)
      }
    }

    input {
      display: block
      width: 100%
      padding: .375rem .75rem
      font-size: 1rem
      line-height: 1.5
      color: #495057
      background-color: #fff
      background-clip: padding-box
      border: 1px solid #ced4da
      border-radius: .25rem
      transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out

      &[type="radio"], &[type="checkbox"] {
        display: inline-block
        width: auto
      }
    }
  }
</style>


