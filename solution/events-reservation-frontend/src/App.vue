<template>
  <div id="app">
    <MainLayout>
      <router-view/>
    </MainLayout>
  </div>
</template>

<script>
import MainLayout from '@/components/layout/MainLayout'
export default {
  name: 'App',
  components: {
    MainLayout,
  },
}
</script>

<style src="./assets/style/index.styl" lang="stylus" />