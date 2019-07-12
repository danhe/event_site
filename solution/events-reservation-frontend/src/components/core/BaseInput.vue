<template>
  <div 
    :class="[hasError ? 'error-input' : 'normal-input', 'base-input', `base-input-${$attrs.type}`]"
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

    <component
      v-else
      class="base-input"
      :is="inputComponent"
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

    <BaseLabel 
      v-if="errorMessage"
      theme="negative"
      :label="errorMessage"
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
    /**
     * Default value of input/textarea
     */
    value: {
      type: [String, Number, Date, Object] ,
      default: '',
    },
    /**
     * Display label of input
     */
    label: {
      type: String,
      default: null,
    },
    /**
     * Checkbox/Radio label
     */
    labelText: {
      type: String,
      default: null,
    },
    /**
     * If is a required input
     */
    requiredOption: {
      type: Boolean,
      default: false,
    },
    /**
     * Specifical attribute for datetime-local
     */
    notBefore: {
      type: Date,
      default: null,
    },
    /**
     * If having an error in input
     */
    hasError: {
      type: Boolean,
      default: false,
    },
    /**
     * Error messages for the input
     */
    errorMessage: {
      type: String,
      default: null,
    },
    /**
     * Component name: input or textarea
     */
    inputComponent: {
      type: String,
      default: 'input'
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
    &.error-input{

      textarea, input, >>> .mx-input {
        border: 1px solid var(--color-negative)
      }
    }

    &.normal-input input,  &.normal-input textarea{
      border: 1px solid var(--color-grey)
    }

    input, textarea {
      display: block
      width: 100%
      padding: .375rem .75rem
      font-size: 1rem
      line-height: 1.5
      color: var(--color-black)
      background-color: var(--color-white)
      background-clip: padding-box
      border-radius: .25rem
      transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out

      &[type="radio"], &[type="checkbox"] {
        display: inline-block
        width: auto
      }
    }
  }
</style>


