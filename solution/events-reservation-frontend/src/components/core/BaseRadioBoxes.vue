<template>
  <div 
    class="base-radio-boxes"
    :class="{'disabled-radios-boxes' : $attrs.disabled}"
  >
    <BaseLabel 
      :label="label"
      theme="important"
    />

    <div
      class="base-radio"
      v-for="(option, index) in options"
      :key="index"
    >
      <input
        id="`radio_${index}`"
        type="radio"
        :name="name"
        :value="option.value"
        :checked="option.checked"
        :disabled="$attrs.disabled"
        @change="handleRadioChange"
      />

      <BaseLabel 
        :label="option.value"
        display="inline-block"
      />
    </div>
  </div>
</template>

<script>
import BaseLabel from '@/components/core/BaseLabel.vue'

export default {
  name: 'BaseRadioBoxes',
  model: {
    event: 'update',
  },
  components: {
    BaseLabel,
  },
  props: {
    value: {
      type: String,
      default: null,
    },
    label: {
      type: String,
      default: null,
    },
    options: {
      type: Array,
      default: () => [],
    },
    name: {
      type: String,
      required: true,
    },
  },
  methods: {
    handleRadioChange($event) {
      this.$emit('update', $event.target.value)
    },
  },
}
</script>

<style lang="stylus" scoped>
.base-radio-boxes {
  &.disabled-radios-boxes {
    opacity: .7

    input,
    label {
      cursor: not-allowed
    }
  }

  .base-radio {
    display: inline-block
    margin-right: 10px
  }
}
</style>

