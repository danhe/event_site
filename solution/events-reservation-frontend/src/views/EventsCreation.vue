<template>
  <div class="events-creation">
    <h1 class="title important-text">
      Reserve your events
    </h1>

    <div class="form">
      <form>
        <div class="form-group">
          <BaseRadioBoxes
            v-model="type"
            label="Event type"
            name="type"
            :requiredOption="true"
            :options="eventTypeOptions"
            @update="changeEventType"
          />
        </div>

        <div class="form-group">
          <BaseInput 
            v-model="event.name"
            label="Event Name"
            placeholder="Event name"
            :requiredOption="true"
          />
        </div>

        <div class="form-group">
          <BaseInput
            v-model="start_time"
            id="start_time_picker"
            label="Event's start time"
            placeholder="Event's start time"
            type="datetime-local"
            :requiredOption="true"
            :not-before="start_time"
            @update="updateStartTime"
          />
        </div>

        <div class="form-group">
          <BaseInput
            v-model="end_time"
            id="end_time_picker"
            label="Event's end time"
            placeholder="Event's end time"
            type="datetime-local"
            :requiredOption="true"
            :not-before="start_time"
            :not-after="end_time_not_after"
          />
        </div>

        <div class="form-group">
          <BaseInput 
            v-model="event.speaker"
            label="Speaker"
            placeholder="Speaker"
          />
        </div>

        <div class="form-group">
          <BaseInput 
            v-model="event.location"
            label="Location"
            placeholder="Location"
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
          />
        </div>

        <div class="form-button">
          <BaseButton>
            Create
          </BaseButton>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import BaseButton from '@/components/core/BaseButton.vue'
import BaseInput from '@/components/core/BaseInput.vue'
import BaseRadioBoxes from '@/components/core/BaseRadioBoxes.vue'

const WORK_SHOP = 'WorkShop'
const OFFICE_HOUR = 'OfficeHour'
const MAX_NUMBER = 9999999

export default {
  name: 'events-creation',
  components: {
    BaseButton,
    BaseInput,
    BaseRadioBoxes,
  },
  data() {
    const NOW = new Date()

    return {
      //Event type options
      eventTypeOptions: [
        {
          value: WORK_SHOP,
          checked: true,
        }, {
          value: OFFICE_HOUR,
        },
      ],
      // Event creation params
      event: {
        name: '',
        speaker: '',
        location: '',
        description: '',
        max_participants: 1,
      },
      type: 'WorkShop',
      start_time: NOW,
      end_time: NOW,
      end_time_not_after: NOW,
      /**
       * Max possible participants when workshop
       */
      max_max_participants: MAX_NUMBER,
    }
  },
  methods: {
    /**
     * Update start time and update the min end time
     */
    updateStartTime(selected_time) {
      const { getEndOfDate } = this

      this.start_time = selected_time

      // When start time is later than current end time
      if(selected_time > this.end_time) {
        this.end_time = this.start_time
      }

      // this.end_time_not_after = getEndOfDate(selected_time)
    },
    /**
     * Get endday of a date 
     */
    getEndOfDate(date) {
      return new Date(date.setHours(23, 59, 59, 999))
    },
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
  },
}
</script>

<style lang="stylus" scoped>
  .events-creation {
    .title {
      text-align: center
      margin-bottom: 20px
      font-weight: 500
      font-size: 1.3em
    }

    .form {
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
  }
</style>
