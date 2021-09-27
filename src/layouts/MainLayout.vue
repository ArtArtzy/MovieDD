<template>
  <q-layout view="lHh Lpr lFf">
    <div class="fullscreen bgmain ">
      <div
        style="max-width:1600px; margin:auto;"
        class=" bgmainpage shadow-10 "
      >
        <div style="height:10px"></div>
        <div class="leftdrawer ">
          <div style="height:calc(100vh - 50px); position:absolute;">
            <!-- Header -->
            <div class="row fontEdit items-center">
              <img
                src="../../public/images/logo.png"
                style="width:88px;"
                alt=""
              />
              <div class="q-pl-sm">
                <div>{{ userName }}</div>
              </div>
            </div>
            <!-- Category -->
            <div v-show="accessMenu.category == 1">
              <div class="setMenu" v-show="menu == 1">
                <img src="../../public/images/menu1red.png" alt="" />
              </div>
              <div class="setMenu" v-show="menu != 1" @click="menuBtn(1)">
                <img
                  src="../../public/images/menu1blue.png"
                  alt=""
                  class="cursor-pointer"
                />
              </div>
            </div>
            <!-- Movie -->
            <div v-show="accessMenu.movie == 1">
              <div class="setMenu" v-show="menu == 2">
                <img src="../../public/images/menu2red.png" alt="" />
              </div>
              <div class="setMenu" v-show="menu != 2" @click="menuBtn(2)">
                <img
                  src="../../public/images/menu2blue.png"
                  alt=""
                  class="cursor-pointer"
                />
              </div>
            </div>
            <!-- Series -->
            <div v-show="accessMenu.series == 1">
              <div class="setMenu" v-show="menu == 3">
                <img src="../../public/images/menu3red.png" alt="" />
              </div>
              <div class="setMenu" v-show="menu != 3" @click="menuBtn(3)">
                <img
                  src="../../public/images/menu3blue.png"
                  alt=""
                  class="cursor-pointer"
                />
              </div>
            </div>
            <!-- Ads -->
            <div v-show="accessMenu.ads == 1">
              <div class="setMenu" v-show="menu == 4">
                <img src="../../public/images/menu4red.png" alt="" />
              </div>
              <div class="setMenu" v-show="menu != 4" @click="menuBtn(4)">
                <img
                  src="../../public/images/menu4blue.png"
                  alt=""
                  class="cursor-pointer"
                />
              </div>
            </div>
            <!-- Analytic -->
            <div v-show="accessMenu.stat == 1">
              <div class="setMenu" v-show="menu == 5">
                <img src="../../public/images/menu5red.png" alt="" />
              </div>
              <div class="setMenu" v-show="menu != 5" @click="menuBtn(5)">
                <img
                  src="../../public/images/menu5blue.png"
                  alt=""
                  class="cursor-pointer"
                />
              </div>
            </div>
            <!-- user -->
            <div v-show="accessMenu.user == 1">
              <div class="setMenu" v-show="menu == 6">
                <img src="../../public/images/menu6red.png" alt="" />
              </div>
              <div class="setMenu" v-show="menu != 6" @click="menuBtn(6)">
                <img
                  src="../../public/images/menu6blue.png"
                  alt=""
                  class="cursor-pointer"
                />
              </div>
            </div>
            <!-- admin -->
            <div v-show="accessMenu.usersystem == 1">
              <div class="setMenu" v-show="menu == 7">
                <img src="../../public/images/menu7red.png" alt="" />
              </div>
              <div class="setMenu" v-show="menu != 7" @click="menuBtn(7)">
                <img
                  src="../../public/images/menu7blue.png"
                  alt=""
                  class="cursor-pointer"
                />
              </div>
            </div>

            <!-- exit btn  -->
            <div class="setMenu exitBtn" @click="exitCheck = true">
              <img
                src="../../public/images/exit.png"
                alt=""
                class="cursor-pointer"
              />
            </div>
          </div>
        </div>
        <q-page-container>
          <router-view />
        </q-page-container>
      </div>
    </div>
    <!-- exit check  -->
    <q-dialog v-model="exitCheck" persistent>
      <q-card>
        <div class="delBox" align="center">
          <q-icon
            class="fas fa-exclamation-circle q-pa-md"
            size="64px"
            color="red"
          />
          <div style="font-size:24px;">Are you sure?</div>
          <div style="font-size:14px;">
            You want to log out from this system!
          </div>
          <div class="row q-pt-md" style="width:280px;margin:auto;">
            <div class="ynBtn q-ma-sm" @click="exitCheck = false">Cancel</div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="exitPage()"
            >
              Yes
            </div>
          </div>
        </div>
      </q-card>
    </q-dialog>
  </q-layout>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      menu: 1,
      userName: "once",
      exitCheck: false,
      menuList: [
        "/",
        "/category",
        "/movie",
        "/series",
        "/ads",
        "/stat",
        "/user",
        "/usersystem"
      ],
      accessMenu: {
        category: 1,
        movie: 1,
        series: 1,
        ads: 1,
        stat: 1,
        user: 1,
        usersystem: 1
      }
    };
  },
  methods: {
    exitPage() {
      this.$router.push("/");
    },
    menuBtn(id) {
      this.menu = id;
      this.$router.push(this.menuList[id]);
    },
    setMenu() {
      if (this.$route.name == "welcome") {
        this.menu = 0;
      } else if (this.$route.name == "category") {
        this.menu = 1;
      } else if (this.$route.name == "movie") {
        this.menu = 2;
      } else if (this.$route.name == "series") {
        this.menu = 3;
      } else if (this.$route.name == "ads") {
        this.menu = 4;
      } else if (this.$route.name == "stat") {
        this.menu = 5;
      } else if (this.$router.name == "user") {
        this.menu = 6;
      } else if (this.$router.name == "usersytem") {
        this.menu = 7;
      }
    },
    async loadData() {
      let token = this.$q.localStorage.getItem("token");
      let data = {
        token: token
      };
      let url = this.serverpath + "bo_checktoken.php";
      let res = await axios.post(url, JSON.stringify(data));
      if (res.data.length > 0) {
        this.userName = res.data[0].username;
        this.accessMenu.category = Number(res.data[0].us_category);
        this.accessMenu.movie = Number(res.data[0].us_movie);
        this.accessMenu.series = Number(res.data[0].us_series);
        this.accessMenu.ads = Number(res.data[0].us_ads);
        this.accessMenu.stat = Number(res.data[0].us_stat);
        this.accessMenu.user = Number(res.data[0].us_user);
        this.accessMenu.usersystem = Number(res.data[0].us_admin);
      }
    }
  },
  mounted() {
    this.setMenu();
    this.loadData();
  }
};
</script>
<style lang="scss" scoped>
.leftdrawer {
  padding-top: 10px;
  margin-left: 30px;
  width: 270px;
  height: calc(100vh - 20px);
  background-color: rgba($color: #ffffff, $alpha: 0.5);
  border-radius: 30px;
  border: 2px solid white;
}
.bgmainpage {
  background-color: #c2ddfd;
  width: 100%;
}
.fontEdit {
  padding-bottom: 20px;
  font-size: 22px;
  padding-top: 20px;
}
.setMenu {
  position: relative;
  left: -21px;
}
.exitBtn {
  position: absolute;
  bottom: 0px;
}
.delBox {
  width: 400px;
  height: 250px;
  background-color: #edf2fe;
  border-radius: 10px;
}
.ynBtn {
  width: 120px;
  height: 45px;
  border-radius: 5px;
  border: 1px solid #ffc24c;
  cursor: pointer;
  line-height: 45px;
}
</style>
