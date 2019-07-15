<template>
  <div class="main-layout">
    <nav>
      <div class="nav-line">
        <aside class="nav-left">
          <router-link 
            class="nav-link"
            to="/events"
          >
            <h1>
              ፸ <span>Events Reservation</span>
            </h1>
          </router-link>

          <router-link 
            class="nav-link"
            to="/"
          >
            About?
          </router-link>
        </aside>

        <aside class="nav-right">
          <BaseButton
            v-if="isAdmin && isLoggedIn"
            theme="secondary"
          >
            <router-link to="/invitation">
              Invite
            </router-link>
          </BaseButton>

          <BaseButton v-if="isLoggedIn">
            <router-link to="/events/new">
              Create an event
            </router-link>
          </BaseButton>

          <BaseButton 
            v-if="isLoggedIn"
            @click="onLogout"
            theme="positive"
          >
            🔓{{ userName }}
          </BaseButton>
        </aside>
      </div>
    </nav>

    <main class="content">
      <slot />
    </main>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

import BaseButton from '@/components/core/BaseButton.vue'
import LoginMixin from '@/mixins/LoginMixin.vue'

export default {
  name: 'MainLayout',
  components: {
    BaseButton,
  },
  computed: {
    ...mapGetters([
      'isLoggedIn',
      'isAdmin',
      'userName',
    ]),
  },
  mixins: [
    LoginMixin,
  ],
  methods: {
    ...mapActions([
      'setUser',
    ]),
    async onLogout() {
      const { logout, setUser } = this

      const response = await logout()
      if (response) {
        setUser({})

        this.$router.push('/login')
      }
    },
  },
}
</script>

<style lang="stylus" scoped>
  .main-layout {
    nav {
      z-index: 20
      border-bottom: 1px solid var(--color-grey)
      max-height: 72px
      overflow-y: auto
      position: fixed
      width: 100%
      background: var(--color-white)

      .nav-line {
        width: 80%
        margin: auto

        aside {
          display: inline-block

          &.nav-left {
            padding: 10px

            .nav-link {
              display: inline-block
              margin-right: 10px
            }
          }

          &.nav-right {
            padding-top: 12px
            float: right
          }
        }
      }
    }

    main.content {
      padding: 72px 10%
    }
  }
</style>
