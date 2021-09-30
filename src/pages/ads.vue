<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="row q-pt-lg">
          <div class="col-3 q-pl-xl" style="font-size:24px;">Status</div>
          <div class="col" style="font-size:24px;">Page</div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer "
              style="background-color:#FFC24C;font-size:18px;width:160px;"
              label="+ ads"
              no-caps=""
            />
          </div>
        </div>
        <div class="q-mt-md" align="center">
          <q-scroll-area class="" style="height:88vh; max-width: 90vw;">
            <div
              class="inBox shadow-3 q-mt-md"
              v-for="(item, index) in data"
              :key="index"
            ></div>
            <div class="q-pb-sm"></div>
          </q-scroll-area>
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
          at_id: 1,
          at_title: "หวยเปลี่ยนโลก",
          at_folder: "a001",
          statview: 0,
          at_weight: 100,
          at_target: "www.finnbet.com",
          status: 1,
          at_timestamp: "2147483647"
        },
        {
          at_id: 2,
          at_title: "สล็อตเปลี่ยนชีวิต",
          at_folder: "a002",
          statview: 0,
          at_weight: 25,
          at_target: "www.google.com",
          status: 1,
          at_timestamp: "2147483647"
        }
      ],
      option: [online, offline]
    };
  }
};
</script>

<style lang="scss" scoped>
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: cover;
  background-position: center;
  padding: 10px;
}
.inBox {
  width: 98%;
  height: 646px;
  background-color: #ffffff;
  border-radius: 10px;
}
</style>
