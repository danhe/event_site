<template>
  <div 
    class="base-input"
    :class="`base-input-${$attrs.type}`"
  >
    <BaseLabel 
      :label="label"
      theme="important"
      :requiredOption="requiredOption"
    />

    <DatePicker
      v-if="isADateInput"
      :value="value"
      lang="en" 
      type="datetime" 
      :required="requiredOption"
      format="MM-DD-YYYY [at] HH:mm"
      :not-before="notBefore"
      @input="handleDatepickerInput"
    />

    <input
      v-else
      class="base-input"
      v-bind="$attrs"
      v-on="$listeners"
      :value="value"
      :required="requiredOption"
      @input="handleInput"
    />

    <BaseLabel 
      v-if="labelText"
      :label="option.value"
    />
  </div>
</template>

<script>
import DatePicker from 'vue2-datepicker'

import BaseLabel from '@/components/core/BaseLabel.vue'

export default {
  name: 'BaseInput',
  inheritAttrs: false,
  model: {
    event: 'update',
  },
  components: {
    BaseLabel,
    DatePicker,
  },
  props: {
    value: {
      type: [String, Number, Date, Object] ,
      default: '',
    },
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
    notBefore: {
      type: Date,
      default: null,
    },
  },
  computed: {
    /**
     * If is an input with datetime type
     */
    isADateInput() {
      const { type } = this.$attrs
      return type === 'datetime-local'
    },
  },
  methods: {
    /**
     * Callback method for input event
     */
    handleInput($event) {
      this.$emit('update', $event.target.value)
    },
    /**
     * Callback method of input event for datetimepicker
     */
    handleDatepickerInput(currentValue){
      this.$emit('update', currentValue)
    },
  },
}
</script>

<style lang="stylus" scoped>
  .base-input {
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


