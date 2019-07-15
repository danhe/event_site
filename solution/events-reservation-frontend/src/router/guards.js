function redirectIfNotLoggedIn(to, from, next, store) {
  const { isLoggedIn } = store.getters

  const isPrivate = to.matched.some(route => !!route.meta.private)

  // If the route is not private, not redirect to login
  // Everyone has access to the route
  if(!isPrivate) {
    return false
  }

  // If the route is private and the user has logged in
  // Not redirect to login and continue to the demande route
  if(isLoggedIn) {
    return false
  }

  // At last, if the route is private and the user has not logged in
  // Redirect to login page
  next({ path: '/login', replace: true })
  return true
}

function redirectIfNotAdmin(to, from, next, store) {
  const { isAdmin } = store.getters

  const isOnlyAdmin = to.matched.some(route => !!route.meta.only_admin)

  // If the route is not private, not redirect to login
  // Everyone has access to the route
  if(!isOnlyAdmin) {
    return false
  }

  // If the route is private and the user has logged in
  // Not redirect to login and continue to the demande route
  if(isAdmin) {
    return false
  }

  // At last, if the route is private and the user has not logged in
  // Redirect to login page
  next({ path: '/events', replace: true })
  return true
}

function useRouterGuards(router, store) {
  router.beforeEach(
    (to, from, next) => {
      if(redirectIfNotLoggedIn(to, from, next, store)) {
        return
      }

      if(redirectIfNotAdmin(to, from, next, store)){
        return 
      }

      next()
    }
  )
}

export default useRouterGuards

