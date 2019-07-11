<template>
  <div class="base-radio-boxes">
    <BaseInput
      v-for="(option, index) in options"
      :key="index"
      type="radio"
      name="event_type"
      :label="index== 0 ? label : null"
      :requiredOption="true"
      :value="option.value"
      :label-text="option.text"
      :checked="option.checked"
    />
  </div>
</template>

<script>
import BaseInput from '@/components/core/BaseInput.vue'

export default {
  name: 'BaseRadioBoxes',
  inheritAttrs: false,
  components: {
    BaseInput,
  },
  props: {
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
    requiredOption: {
      type: Boolean,
      default: false,
    },
  },
}
</script>
