<template>
  <div class="bg-red">
    <div class="boxWhite brx">1223<br />4567</div>
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
  position: relative;
  left: 500px;
  width: calc(100vw - 300px);
  height: calc(100vh - 20px);
  background-color: rgba($color: #ffffff, $alpha: 0.5);
  border-radius: 30px;
  border: 2px solid white;
}
.brx {
  border: solid 1px red;
}
</style>
