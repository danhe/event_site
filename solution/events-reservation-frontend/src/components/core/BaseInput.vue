<template>
  <div :class="classObj">
    <BaseLabel
      v-if="label"
      :label="label"
      theme="important"
      :requiredOption="requiredOption"
    />

    <DatePicker
      v-if="isADateInput"
      :value="value"
      lang="en" 
      :type="datepickerType" 
      :required="requiredOption"
      :format="datepickerFormat"
      :not-before="notBefore"
      :disabled="$attrs.disabled"
      @input="handleDatepickerInput"
    />

    <component
      v-else
      class="base-input"
      :is="inputComponent"
      v-bind="$attrs"
      v-on="$listeners"
      :value.prop="value"
      :required="requiredOption"
      @input="handleInput"
    >
      {{ inputComponent == 'input' ? '' : value }}
    </component>

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
import _get from 'lodash/get'
import DatePicker from 'vue2-datepicker'

import BaseLabel from '@/components/core/BaseLabel.vue'

const FORMATS = {
  datetime: 'MM-DD-YYYY [at] HH:mm',
  date: 'MM-DD-YYYY',
}

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
      type: [String, Number, Date, Object],
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
      type: [Date, String],
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
      default: 'input',
    },
    inline: {
      type: Boolean,
      default: false,
    },
    datepickerType: {
      type: String,
      default: 'datetime',
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
    classObj() {
      const { $attrs, hasError, inline } = this
      
      return [
        'base-input',
        `base-input-${$attrs.type}`,
        hasError ? 'error-input' : 'normal-input',
        inline ? 'display-inline' : 'display-block',
        { 'disabled-input': $attrs.disabled },
      ]
    },
    /**
     * Get datepicker format according to its type
     */
    datepickerFormat() {
      const { datepickerType } = this

      return _get(FORMATS, datepickerType)
    },
  },
  methods: {
    _get,
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

    &.disabled-input {
      opacity: .7

      textarea, 
      input, 
      label {
        cursor: not-allowed
      }
    }

    &.display-block {
      display: block
    }

    &.display-inline {
      display: inline-block
    }

    &.error-input{

      textarea, input, >>> .mx-input {
        border: 1px solid var(--color-negative)
      }
    }

    &.normal-input input,  &.normal-input textarea{
      border: 1px solid var(--color-grey)
    }

    input, textarea {
      width: calc(100% - 1.5em)
      padding: .375rem .75rem
      font-size: 1rem
      line-height: 1.5
      color: var(--color-black)
      background-color: var(--color-white)
      background-clip: padding-box
      border-radius: .25rem
      transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out
      white-space: inherit

      &[type="radio"], &[type="checkbox"] {
        display: inline-block
        width: auto
      }
    }
  }
</style>


