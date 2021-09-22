<template>
  <q-layout view="lHh Lpr lFf">
    <div class="fullscreen bgmain ">
      <div
        style="max-width:1600px; margin:auto;"
        class=" bgmainpage shadow-10 "
      ></div>
      <div class="leftdrawer shadow-3 ">
        <!-- //****Menu */ -->
        <div>
          <div>123</div>
          <div>456</div>
        </div>
        <!-- End of menu -->
      </div>
    </div>
    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
export default {
  data() {
    return {};
  }
};
</script>
<style lang="scss" scoped>
.leftdrawer {
  margin: 10px;
  width: 300px;
  height: calc(100vh - 20px);
  background-color: rgba($color: #ffffff, $alpha: 0.5);
  border-radius: 30px;
}
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: cover;
  background-position: center;
}
.bgmainpage {
  background-color: rgba(12, 6, 44, 0.85);
}
</style>
