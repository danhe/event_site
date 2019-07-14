<template>
  <div class="event-form">
    <form @submit="onCreateEvent">
      <div class="form-group">
        <BaseRadioBoxes
          v-model="event.type"
          label="Event type"
          name="type"
          :requiredOption="true"
          :options="eventTypeOptions"
          :hasError="hasErrorInput('type')"
          :errorMessage="errorsOfInput('type')"
          :disabled="disabled"
          @update="changeEventType"
        />
      </div>

      <div class="form-group">
        <BaseInput 
          v-model="event.name"
          label="Event Name"
          placeholder="Event name"
          :requiredOption="true"
          :hasError="hasErrorInput('name')"
          :errorMessage="errorsOfInput('name')"
          :disabled="disabled"
        />
      </div>

      <div class="form-group">
        <BaseInput
          v-model="event.start_time"
          id="start_time_picker"
          label="Event's start time"
          placeholder="Event's start time"
          type="datetime-local"
          :requiredOption="true"
          :not-before="time_now"
          :hasError="hasErrorInput('start_time')"
          :errorMessage="errorsOfInput('start_time')"
          :disabled="disabled"
          @update="updateStartTime"
        />
      </div>

      <div class="form-group">
        <BaseInput
          v-model="event.end_time"
          id="end_time_picker"
          label="Event's end time"
          placeholder="Event's end time"
          type="datetime-local"
          :requiredOption="true"
          :not-before="event.start_time"
          :not-after="end_time_not_after"
          :hasError="hasErrorInput('end_time')"
          :errorMessage="errorsOfInput('end_time')"
          :disabled="disabled"
        />
      </div>

      <div class="form-group">
        <BaseInput 
          v-model="event.speaker"
          label="Speaker"
          placeholder="Speaker"
          :hasError="hasErrorInput('speaker')"
          :errorMessage="errorsOfInput('speaker')"
          :disabled="disabled"
        />
      </div>

      <div class="form-group">
        <BaseInput 
          v-model="event.location"
          label="Location"
          placeholder="Location"
          :hasError="hasErrorInput('location')"
          :errorMessage="errorsOfInput('location')"
          :disabled="disabled"
        />
      </div>

      <div class="form-group">
        <BaseInput 
          v-model="event.max_participants"
          type="number"
          label="Maxium participants"
          placeholder="Maxium participants"
          min="1"
          :max="max_max_participants"
          :hasError="hasErrorInput('max_participants')"
          :errorMessage="errorsOfInput('max_participants')"
          :disabled="disabled"
        />
      </div>

      <div class="form-group">
        <BaseInput
          v-model="event.description"
          input-component='textarea'
          label="Description"
          placeholder="Description"
          :hasError="hasErrorInput('description')"
          :errorMessage="errorsOfInput('description')"
          :disabled="disabled"
        />
      </div>

      <div 
        class="form-button"
        v-if="!disabled"
      >
        <BaseButton theme="secondary">
            <router-link to="/events">
            Cancel
          </router-link>
        </BaseButton>

        <BaseButton type="submit">
          Create
        </BaseButton>
      </div>
    </form>
  </div>
</template>

<script>
import _filter from 'lodash/filter'

import BaseButton from '@/components/core/BaseButton.vue'
import BaseInput from '@/components/core/BaseInput.vue'
import BaseRadioBoxes from '@/components/core/BaseRadioBoxes.vue'
import EventMixin from '@/mixins/EventMixin.vue'

const WORK_SHOP = 'WorkShop'
const OFFICE_HOUR = 'OfficeHour'
const MAX_NUMBER = 9999999

export default {
  name: 'EventForm',
  components: {
    BaseButton,
    BaseInput,
    BaseRadioBoxes,
  },
  mixins: [
    EventMixin,
  ],
  data() {
    const NOW = new Date()

    return {
      /**
       * Event type radio options
       */
      eventTypeOptions: [
        {
          value: WORK_SHOP,
          checked: true,
        }, {
          value: OFFICE_HOUR,
        },
      ],
      /**
       * End time not after date indicator
       */
      end_time_not_after: NOW,
      /**
       * Max possible participants when workshop
       */
      max_max_participants: MAX_NUMBER,
      time_now: NOW,
    }
  },
  props: {
    /**
     * Event object
     */
    event: {
      type: Object,
      required: true,
    },
    /**
     * If is editable
     */
    disabled: {
      type: Boolean,
      default: false, 
    },
  },
  methods: {
    /**
     * Update start time and update the min end time
     * @param {Date} selected_time of datetime picker
     */
    updateStartTime(selected_time) {
      // const { getEndOfDate } = this

      this.start_time = selected_time

      // When start time is later than current end time
      if(selected_time > this.end_time) {
        this.end_time = this.start_time
      }

      // todo
      // this.end_time_not_after = getEndOfDate(selected_time)
    },
    /**
     * Get end day of a date 
     * @param {Date} date to calculate
     */
    getEndOfDate(date) {
      return new Date(date.setHours(23, 59, 59, 999))
    },
    /**
     * When changing event type, update the max partipant number
     * @param {String} type of event
     */
    changeEventType(type) {
      this.type = type

      if(type === OFFICE_HOUR){
        this.event.max_participants = 1
        this.max_max_participants = 1
      }
      else{
        this.max_max_participants = MAX_NUMBER
      }
    },
    /**
     * When clicking on create button
     *  create a new event
     * @param {Event} $event submit of form
     */
    async onCreateEvent($event) {
      $event.preventDefault()
      this.errors = []

      const { event, createEvent } = this

      const response = await createEvent(event)
      if (response) {
        this.$router.push('/events')
      }
    },
    /**
     * Check if the input with key has an error
     * @param {String} key of input
     */
    hasErrorInput(key) {
      const { errors } = this

      return errors.map(error => error.pointer).includes(key)
    },
    /**
     * Error messages for input
     * @param {String} key of input
     */
    errorsOfInput(key) {
      const { errors } = this

      const errorsObject = _filter(errors, (error) => { 
        return error.pointer === key
      })

      return errorsObject.map(error => error.detail).join('<br/>')
    },
  },
}
</script>

<style lang="stylus" scoped>
  .event-form {
    max-width: 420px
    margin: auto

    .form-group {
      margin-bottom: 1em

      .datetime-picker {
        >>> input {
          border-radius: 0.25rem
        }
      }
    }
  }
</style>
