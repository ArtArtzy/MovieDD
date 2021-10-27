<template>
  <div class="bgmain fullscreen">
    <div class="bigBox shadow-4 fixed-center" align="center">
      <q-icon
        class="fas fa-info-circle q-mt-lg"
        style="font-size:90px;color:#ffc24c;"
      />
      <div class="q-py-lg" style="font-size:16px;">
        Please contact Admin to ask your password/username
      </div>
      <div class="closeBtn q-mt-md cursor-pointer" @click="goBack()">Close</div>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    goBack() {
      this.$router.push("/");
    }
  }
};
</script>

<style lang="scss" scoped>
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: 100%;
  background-attachment: fixed;
}
.bigBox {
  background-color: white;
  border-radius: 30px;
  max-width: 600px;
  width: 500px;
  height: 275px;
}
.closeBtn {
  width: 160px;
  height: 50px;
  line-height: 50px;
  border-radius: 5px;
  background-color: #ffc24c;
}
</style>
