<template>
  <div class="base-select">
    <BaseLabel
      v-if="label"
      :label="label"
      display="inline-block"
      theme="important"
    />
    <select @change="handleSelect">
      <option
        v-for="(option, index) in options"
        :key="index"
        :value="option.value"
        :selected="option.value === value"
      >
        {{ option.text || _capitalize(option.value) }}
      </option>
    </select>
  </div>
</template>

<script>
import _capitalize from 'lodash/capitalize'

import BaseLabel from '@/components/core/BaseLabel.vue'

export default {
  name: 'BaseSelect',
  model: {
    event: 'update',
  },
  components: {
    BaseLabel,
  },
  props: {
    /**
     * Default value of input/textarea
     */
    value: {
      type: [String, Number, Date] ,
      default: '',
    },
    /**
     * Display label of input
     */
    label: {
      type: String,
      default: null,
    },
    options: {
      type: Array,
      default: () => [],
    },
  },
  methods: {
    _capitalize,
    /**
     * Callback method for input event
     */
    handleSelect($event) {
      this.$emit('update', $event.target.value)
    },
  },
}
</script>

<style lang="stylus" scoped>
  .base-select {
    display: inline-block
    margin-right: 10px

    label {
      margin-right: 10px
    }

    select {
      font-size: 1rem
      line-height: 1.5
      color: var(--color-black)
      background-color: var(--color-white)
      background-clip: padding-box
      border-radius: .25rem
      border-color: var(--color-grey)
      height: calc(1.5em + .75rem + 2px)
      padding: .375rem 1.75rem .375rem .75rem
    }
  }
</style>


