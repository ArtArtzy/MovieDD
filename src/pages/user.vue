<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="inBox q-pt-md">
          <div class="row q-pa-sm" style="font-size:20px;" align="center">
            <div class="col-2" align="left">Username</div>
            <div class="col-2" align="left">Password</div>
            <div class="col-2">Telephone</div>
            <div class="col-1">Status</div>
            <div class="col">Register Date</div>
            <div class="col-1">Detail</div>
          </div>
          <hr />
          <div
            class="row q-pa-sm"
            v-for="(item, index) in data"
            :key="index"
            :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
            align="center"
          >
            <div class="col-2" align="left">{{ item.username }}</div>
            <div class="col-2" align="left">{{ item.password }}</div>
            <div class="col-2">{{ item.telephone }}</div>

            <div class="col-1">
              <div class="onlineBtn" v-show="item.status == 1">Enable</div>
              <div class="offlineBtn" v-show="item.status == 0">Disable</div>
              <div class="otplineBtn" v-show="item.status == 2">OTP</div>
            </div>
            <div class="col">{{ item.series }}</div>
            <div class="col-1"><u>Detail</u></div>
          </div>
        </div>
      </div>
      <!-- bg Drop  -->
      <div class="bgDrop fullscreen" v-show="statusBtn"></div>
    </div>
  </div>
</template>

<script>
import { type } from "os";
export default {
  data() {
    return {
      statusBtn: false,
      data: [
        {
          username: "Artzy",
          password: "123456",
          telephone: "085-749-9812",
          status: 1,
          registerDate: ""
        },
        {
          username: "Artzy",
          password: "57841",
          telephone: "085-749-9812",
          status: 0,
          registerDate: ""
        },
        {
          username: "Artzy",
          password: "57841",
          telephone: "085-749-9812",
          status: 2,
          registerDate: ""
        }
      ]
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
  width: 95%;
  margin: auto;
}
.onlineBtn {
  background-color: #00a642;
  color: white;
  border-radius: 10px;
  width: 90px;
}
.offlineBtn {
  background-color: #e83939;
  color: white;
  border-radius: 10px;
  width: 90px;
}
.otplineBtn {
  background-color: #eda10f;
  color: white;
  border-radius: 10px;
  width: 90px;
}
.bgDrop {
  background-color: rgba($color: #0f2c78, $alpha: 0.6);
}
</style>
