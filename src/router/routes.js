const routes = [
  {
    path: "/category",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      {
        path: "/welcome",
        component: () => import("pages/welcome.vue"),
        name: "welcome"
      },
      {
        path: "",
        component: () => import("pages/category.vue"),
        name: "category"
      },
      {
        path: "/movie",
        component: () => import("pages/movie.vue"),
        mame: "movie"
      },
      {
        path: "/series",
        component: () => import("pages/series.vue"),
        name: "series"
      },
      {
        path: "/episode/:id",
        component: () => import("pages/episode.vue"),
        name: "episode"
      },
      {
        path: "/stat",
        component: () => import("pages/stat.vue"),
        name: "stat"
      },
      {
        path: "/forgetpass",
        component: () => import("pages/forgetpassword.vue"),
        name: "user"
      },
      {
        path: "/user",
        component: () => import("pages/user.vue"),
        name: "user"
      },
      {
        path: "/usersystem",
        component: () => import("pages/usersystem.vue"),
        name: "usersystem"
      },
      { path: "/ads", component: () => import("pages/ads.vue"), name: "ads" }
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
