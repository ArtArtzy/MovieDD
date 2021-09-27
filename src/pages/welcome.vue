<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite">
        <div class="row items-center welcomeText" align="center">
          <div class="col"></div>
          <div class="col-1 items-center">
            <q-icon class="fas fa-arrow-left" size="30px" />
          </div>
          <div class=" col-6 q-pl-md">
            please select menu on the left size
          </div>
          <div class="col"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: cover;
  background-position: center;
  padding: 10px;
}
.welcomeText {
  height: 95vh;
  font-size: 36px;
}
</style>
