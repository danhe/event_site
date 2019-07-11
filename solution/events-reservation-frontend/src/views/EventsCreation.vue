<template>
  <div class="events-creation">
    <h1 class="title important-text">
      Reserve your events
    </h1>

    <div class="form">
      <form>
        <div class="form-group">
          <BaseRadioBoxes
            label="Event type"
            name="event_type"
            :requiredOption="true"
            :options="eventTypeOptions"
          />
        </div>

        <div class="form-group">
          <BaseInput 
            label="Event Name"
            placeholder="Event name"
            :requiredOption="true"
          />
        </div>

        <div class="form-group">
          <BaseInput 
            label="Event's start time"
            placeholder="Event's start time"
            type="datetime-local"
            :requiredOption="true"
          />
        </div>

        <div class="form-group">
          <BaseInput 
            label="Event's end time"
            placeholder="Event's end time"
            type="datetime-local"
            :requiredOption="true"
          />
        </div>

        <div class="form-check">
          <BaseInput 
            labelAfter="Check me out"
            type="checkbox"
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

export default {
  name: 'events-creation',
  components: {
    BaseButton,
    BaseInput,
    BaseRadioBoxes,
  },
  data() {
    return {
      eventTypeOptions: [
        {
          value: 'WorkShop',
          text: 'WorkShop',
          checked: true,
        }, {
          value: 'OfficeHour',
          text: 'Office Hour',
        },
      ],
    }
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
      }
    }
  }
</style>
