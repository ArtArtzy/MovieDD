<template>
  <q-layout view="lHh Lpr lFf">
    <div class="fullscreen" style="background-color:#E0EFFF">
      <div
        style="max-width:1600px; margin:auto; width:100%"
        class="fullscreen shadow-10"
      >
        <div class="leftdrawer shadow-4 ">
          <!-- //****Menu */ -->
          <div>
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
            <div class="setMenu" v-show="menu == 1">
              <img src="../../public/images/menu1red.png" alt="" />
            </div>
            <div class="setMenu" v-show="menu != 1" @click="menu = 1">
              <img
                src="../../public/images/menu1blue.png"
                alt=""
                class="cursor-pointer"
              />
            </div>

            <div class="setMenu" v-show="menu == 2">
              <img src="../../public/images/menu2red.png" alt="" />
            </div>
            <div class="setMenu" v-show="menu != 2" @click="menu = 2">
              <img
                src="../../public/images/menu2blue.png"
                alt=""
                class="cursor-pointer"
              />
            </div>
            <div class="setMenu" v-show="menu == 3">
              <img src="../../public/images/menu3red.png" alt="" />
            </div>
            <div class="setMenu" v-show="menu != 3" @click="menu = 3">
              <img
                src="../../public/images/menu3blue.png"
                alt=""
                class="cursor-pointer"
              />
            </div>
            <div class="setMenu" v-show="menu == 4">
              <img src="../../public/images/menu4red.png" alt="" />
            </div>
            <div class="setMenu" v-show="menu != 4" @click="menu = 4">
              <img
                src="../../public/images/menu4blue.png"
                alt=""
                class="cursor-pointer"
              />
            </div>
            <div class="setMenu" v-show="menu == 5">
              <img src="../../public/images/menu5red.png" alt="" />
            </div>
            <div class="setMenu" v-show="menu != 5" @click="menu = 5">
              <img
                src="../../public/images/menu5blue.png"
                alt=""
                class="cursor-pointer"
              />
            </div>
            <div class="setMenu" v-show="menu == 6">
              <img src="../../public/images/menu6red.png" alt="" />
            </div>
            <div class="setMenu" v-show="menu != 6" @click="menu = 6">
              <img
                src="../../public/images/menu6blue.png"
                alt=""
                class="cursor-pointer"
              />
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
      userType: "ผู้ดูแลระบบ"
    };
  },
  methods: {
    exitBtn() {
      this.$router.push("/");
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
  padding-top: 150px;
}
</style>
