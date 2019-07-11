<template>
  <div class="main-layout">
    <nav>
      <div class="nav-line">
        <aside class="nav-left">
          <router-link to="/">
            <h1>
              ፸ <span>Events Reservation</span>
            </h1>
          </router-link>
        </aside>
      </div>
    </nav>

    <main class="content">
      <slot />
    </main>
  </div>
</template>

<script>
export default {
  name: 'MainLayout',
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
          }
        }
      }
    }

    main.content {
      padding: 72px 10%
    }
  }
</style>
