<template>
  <div style="max-width:1600px; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite shadow-4" style="z-index:1;">
        <div>
          <img src="" alt="" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: [
        {
          orderid: 100,
          catname: "ดราม่า",
          movie: 14,
          series: 6,
          status: 1
        },
        {
          orderid: 200,
          catname: "แอคชั่น",
          movie: 24,
          series: 4,
          status: 1
        },
        {
          orderid: 300,
          catname: "ไซไฟ",
          movie: 20,
          series: 8,
          status: 1
        },
        {
          orderid: 400,
          catname: "สารคดี",
          movie: 20,
          series: 8,
          status: 0
        }
      ]
    };
  }
};
</script>

<style lang="scss" scoped>
.boxWhite {
  width: 1200px;
  height: calc(100vh - 20px);
  background-color: rgba($color: #ffffff, $alpha: 0.5);
  border-radius: 30px;
  border: 2px solid white;
}
.brx {
  border: solid 1px red;
}
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: cover;
  background-position: center;
  padding: 10px;
}
.editBtn {
  padding-top: 30px;
  position: relative;
  right: 0px;
}
</style>
