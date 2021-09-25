<template>
  <q-layout view="lHh Lpr lFf">
    <div class="" style="background-color:#E0EFFF">
      <div
        style="max-width:1600px; margin:auto; width:100%"
        class="fullscreen shadow-10"
      >
        <div class="leftdrawer shadow-4 ">
          <!-- //****Menu */ -->
          <div class="" style="height:calc(100vh - 50px);">
            <div class="row fontEdit items-center">
              <img
                src="../../public/images/logo.png"
                style="width:88px;"
                alt=""
              />
              <div class="q-pl-sm">
                <div>{{ userName }}</div>
                <div>{{ userType }}</div>
              </div>
            </div>
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
            <div class="setMenu exitBtn" @click="exitBtn">
              <img
                src="../../public/images/exit.png"
                alt=""
                class="cursor-pointer"
              />
            </div>
          </div>
          <!-- End of menu -->
        </div>
      </div>

      <q-page-container>
        <router-view />
      </q-page-container>
    </div>
  </q-layout>
</template>

<script>
export default {
  data() {
    return {
      menu: 1,
      userName: "once",
      userType: "ผู้ดูแลระบบ",
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
    exitBtn() {
      this.$router.push("/");
    },
    menuBtn(id) {
      this.menu = id;
      this.$router.push(this.menuList[id]);
    }
  }
};
</script>
<style lang="scss" scoped>
.leftdrawer {
  margin: 10px;
  margin-left: 30px;
  width: 300px;
  height: calc(100vh - 20px);
  background-color: rgba($color: #ffffff, $alpha: 0.5);
  border-radius: 30px;
  border: 2px solid white;
}
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: cover;
  background-position: center;
}
.bgmainpage {
  background-color: rgba(12, 6, 44, 0.85);
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
  left: 12px;
  bottom: 50px;
}
</style>
