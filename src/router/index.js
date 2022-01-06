import Vue from "vue";
import VueRouter from "vue-router";
import HighchartsVue from "highcharts-vue";
import routes from "./routes";

Vue.use(VueRouter);
Vue.use(HighchartsVue);
/*
 * If not building with SSR mode, you can
 * directly export the Router instantiation;
 *
 * The function below can be async too; either use
 * async/await or return a Promise which resolves
 * with the Router instance.
 */

export default function(/* { store, ssrContext } */) {
  const Router = new VueRouter({
    scrollBehavior: () => ({ x: 0, y: 0 }),
    routes,

    // Leave these as they are and change in quasar.conf.js instead!
    // quasar.conf.js -> build -> vueRouterMode
    // quasar.conf.js -> build -> publicPath
    mode: process.env.VUE_ROUTER_MODE,
    base: process.env.VUE_ROUTER_BASE
  });

  return Router;
}
import axios from "axios";
Vue.mixin({
  data() {
    return {
      // serverpath: "https://www.yaksaconcept.com/netgigapi/",
      serverpath: "http://localhost/moviedd/",
      // serverpath: "http://192.168.2.147/moviedd/",
      startDate: "09-06-2021"
    };
  },
  methods: {
    //Notification สีแดง
    redNotify(text) {
      this.$q.notify({
        message: text,
        icon: "fas fa-exclamation",
        color: "negative",
        position: "top",
        icon: "fas fa-exclamation-circle"
      });
    },
    //Notification สีเขียว
    greenNotify(text) {
      this.$q.notify({
        message: text,

        color: "secondary",
        position: "top",
        icon: "fas fa-check-circle"
      });
    },

    //ตรวจสอบสิทธิในการเข้า menu
    //menuid = 1=>Category
    //menuid = 2=>Movie
    //menuid = 3=>Series
    //Menuid = 4=>Ads
    //Menuid = 5=>Analytic
    //Menuid = 6=>User
    //Menuid = 7=>Admin

    async checkMenuAccess(menuid) {
      let temp = {
        menuid: menuid,
        token: this.$q.localStorage.getItem("token")
      };
      let url = this.serverpath + "bo_checkmenuaccess.php";
      let res = await axios.post(url, JSON.stringify(temp));
      if (res.data == "logout" || res.data == "not pass") {
        this.$q.localStorage.clear();
        this.$router.push("/");
      }
    }
  }
});
