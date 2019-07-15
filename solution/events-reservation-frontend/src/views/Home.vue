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
        <h4>Level 1: event creation.</h4>
        <ul>
          <li>
            API: For event model, it has a type attribute as signle-table attribute which make the event object different 
            by its type: WorkShop and OfficeHour. 
          </li>
          <li>
            API: In base_controller, I created also all error handler to make the errors better catch and display.
          </li>
          <li>
            Frontend: I created a EventMixin to control the axios call and make the gestion of reponse centralized 
            in the mixin.
          </li>
          <li>
            Frontend: I created also the base components like BaseInput, BaseButton etc on the client side.
          </li>
        </ul>
      </li>
      <li>
        <h4>Level 2: events search.</h4>
        <ul>
          <li>
            We can now search by type, date, speaker and location.
          </li>
          <li>
            Frontend: For event detail page, I re-use the same component with the event creation, and just make it not-editable.
          </li>
        </ul>
      </li>
      <li>
        <h4>Level 3: authentification with token and password, invitation.</h4>
        <ul>
          <li>
            <b class="important-text">Important</b>
            <br/>
            There is one admin in the application: 
            <br/>
            email: admin@events.com 
            <br/>
            password: admin
            <br/><br/>
            You can login as admin and invit yourself in local and click on the magic link to set the password. But in production the emails are to mailtrap, you'll not receive the email.

            <br/><br/>
            Here is an example email as user:
            <br/>
            email: dan@events.com 
            <br/>
            password: test
            <br/>
          </li>
          <li>
            API: Admin can now invite someone by email, and he'll receive a magic link by email.
            And with this magic link, user can set his password to login to the application.
            <br/>
            All features are now reserved for registered/loggedIn user.
          </li>
          <li>
            Frontend: we store the user in vuex and it's persited in localStorage.
            We use alse vuex and guards to protect different routes.
          </li>
        </ul>
      </li>
      <li>
        Coming soon...
      </li>
    </ul>
    <p class="">
      I'm sorry, I didn't have the time to finish the last steps. But I did my best to finish the first three levels.
      If you have some questions I'll be happy to anwser.
    </p>

    <p>
      Here is my <a href="https://github.com/danhe/event_site/">github repository</a>, 
      you can also see branches such as "features/level1" which correspondant to the different steps of project.
    </p>

    <p>
      I deployed the API project to heroku, and you can see the <a href="https://events-reservation-api.herokuapp.com/docs/index.html#introduction">API docs</a> here.
      And the <a href="https://events-reservation-frontend.danhe.now.sh/">frontend app</a> is deployed on zeit here.
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
