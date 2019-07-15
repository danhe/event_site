<template>
  <div class="event">
    <h2 class="title">
      All events
    </h2>

    <div class="events-list">
      <BaseSelect
        v-model="search.by"
        label="Search by"
        :options="searchByOptions"
        @update="onUpdateSearchBy"
      />

      <BaseInput 
        v-model="search.text"
        placeholder="search..."
        :inline="true"
        :type="dateSelected ? 'datetime-local' : 'text'"
        datepickerType="date"
        @input="filterEvents"
        @update="filterEvents"
      />

      <BaseSpinner v-if="isLoading" />

      <div 
        class="empty-list"
        v-else-if="emptyList"
      >
        No available events
      </div>

      <EventCardsList
        v-else
        :events="events" 
      />
    </div>
  </div>
</template>

<script>
import _isEmpty from 'lodash/isEmpty'
import _get from 'lodash/get'

import BaseInput from '@/components/core/BaseInput.vue'
import BaseSpinner from '@/components/core/BaseSpinner.vue'
import BaseSelect from '@/components/core/BaseSelect.vue'
import EventCardsList from '@/components/EventCardsList.vue'
import EventMixin from '@/mixins/EventMixin.vue'

const SEARCH_BY_OPTIONS = [
  { value: 'type' },
  { value: 'date' },
  { value: 'speaker' },
  { value: 'location' },
]

export default {
  name: 'Event',
  components: {
    BaseInput,
    BaseSelect,
    BaseSpinner,
    EventCardsList,
  },
  data() {
    return {
      /**
       * Serach object, by and search text
       */
      search: {
        by: SEARCH_BY_OPTIONS[0].value,
        text: '',
      },
      /**
       * Search by select options
       */
      searchByOptions: SEARCH_BY_OPTIONS,
      /**
       * debounce the input to delay the search after stopping input
       */
      debounce: null,
      events: [],
    }
  },
  computed: {
    /**
     * If date is selected, indicator to display the datepicker
     */
    dateSelected() {
      const { search } = this

      return search.by === 'date'
    },
    /**
     * Is is an empty events list
     */
    emptyList() {
      const { events } = this

      return _isEmpty(events)
    },
  },
  mixins: [
    EventMixin,
  ],
  /**
   * Get events when creating the component
   */
  async created(){
    const { getEvents } = this

    const response = await getEvents()
    this.events = _get(response, 'data.events')
  },
  methods: {
    /**
     * Filter events by search text
     * With a debounce to delay the search after stopped input
     */
    async filterEvents() {
      const { getEvents, search, debounce } = this

      // By default, on send "search" to server as params
      let searchParams = search

      // When search by date, we need add a new params
      //  end_of_day of filter date
      // This permits to have a correct result with diffrent timezones
      if(search.by === 'date') {
        const end_of_day = new Date(new Date(search.text).setHours(23,59,59,999))
        searchParams = Object.assign(searchParams, {
          end_of_day: end_of_day,
        })
      }

      clearTimeout(debounce)

      this.debounce = setTimeout(async () => {
        const response = await getEvents(searchParams)
        this.events = _get(response, 'data.events')
      }, 600)
    },
    /**
     * When updating search by select
     * @param {String} value of selected searchBy
     */
    async onUpdateSearchBy(value) {
      const { getEvents, search } = this
      const old_search_text = search.text

      // Update the dqte
      this.search = {
        by: value,
        text: '',
      }

      // When old input is not empty, we need to update the events list
      if(old_search_text !== '') {
        const response = await getEvents(this.search)
        this.events = _get(response, 'data.events')
      }
    },
  },
}
</script>

<style lang="stylus" scoped>
  .event {
    text-align: center
    font-weight: 500
    font-size: 1.3em

    .title {
      line-height: 1.5294117647em
      margin: 0.5em 0.5em 0.95em 0.5em
    }

    .events-list {
      margin: 20px 20%

      .empty-list {
        margin-top: 20px
      }
    }
  }
</style>
