const routes = [
  {
    path: "/category",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/category.vue") },
      { path: "/movie", component: () => import("pages/movie.vue") },
      { path: "/series", component: () => import("pages/series.vue") },
      { path: "/stat", component: () => import("pages/stat.vue") },
      { path: "/user", component: () => import("pages/user.vue") },
      { path: "/usersystem", component: () => import("pages/usersystem.vue") }
    ]
  },

  {
    path: "/",
    component: () => import("pages/loading.vue")
  },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: "*",
    component: () => import("pages/Error404.vue")
  }
];

export default routes;
