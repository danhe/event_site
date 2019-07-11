<template>
  <div class="home">
    <h1 class="important-text">Hello</h1>
    <p>
      I'm Dan, here is my project on VueJS with a RubyOnRails API which permit to reserve an event.
      Here is some things that I want to explain to you:
    </p>
    <ul>
      <li>
        I separated the project as Frontend part and Backend API part.
        So Frontend part is a VueJS based project and API part is a RubyOnRails based project.
      </li>
      <li>
        Coming soon...
      </li>
    </ul>
    <p>
      Here is my <a href="https://github.com/danhe/event_site">github repository</a>, 
      you can also see branches such as "features/level1" which correspondant to the different steps of project.
    </p>

    <p class="home-button">
      <BaseButton>
        <router-link to="/events">
          Get started
        </router-link>
      </BaseButton>
    </p>
  </div>
</template>

<script>
import BaseButton from '@/components/core/BaseButton.vue'

export default {
  name: "Home",
  components: {
    BaseButton,
  },
}
</script>

<style lang="stylus" scoped>
  .home {
    margin: 0 5%

    .home-button {
      text-align: center
      margin-top: 40px
    }
  }
</style>
