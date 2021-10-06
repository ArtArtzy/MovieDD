<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="inBox q-pt-xl">
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
              <div
                class="onlineBtn cursor-pointer"
                v-show="item.status == 1"
                @click="changeSta(item)"
              >
                Enable
              </div>
              <div
                class="offlineBtn cursor-pointer"
                v-show="item.status == 0"
                @click="changeSta(item)"
              >
                Disable
              </div>
              <div
                class="otplineBtn cursor-pointer"
                v-show="item.status == 2"
                @click="otpSelect(item)"
              >
                OTP
              </div>
            </div>
            <div class="col">{{ item.timestamp }}</div>
            <div class="col-1 cursor-pointer" @click="detailShow(item)">
              <u>Detail</u>
            </div>
          </div>
        </div>
      </div>
      <!-- end table  -->
      <!-- otp select  -->
      <q-dialog v-model="otpBtn" persistent>
        <q-card>
          <div class="otpBox" align="center">
            <div class="q-pt-md" style="font-size:24px;">OTP Solver</div>
            <div class="q-pl-xl q-pt-sm">
              <q-option-group
                v-model="staOtp"
                :options="options"
                color="primary"
                align="left"
              />
            </div>
            <div class="row q-pt-md" style="width:280px;margin:auto;">
              <div class="ynBtn q-ma-sm" @click="otpBtn = false">Cancel</div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="otpSelected()"
              >
                Yes
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- detail -->
      <q-dialog v-model="detailBtn" persistent>
        <q-card class="detailBox" style="color:#797575">
          <div class=" row items-center">
            <div class="col"></div>
            <div class="text-h6 col-9 q-pt-lg" align="center">{{ mname }}</div>
            <div class="col">
              <q-btn
                icon="fas fa-times"
                round
                flat
                size="md"
                @click="detailBtn = false"
              />
            </div>
          </div>
          <div class=" row items-center justify-center">
            <div class="q-pa-md">Register date : {{ mdate }}</div>
          </div>
          <div class="row items-center q-pl-lg">
            <div v-for="index in 3" :key="mfav[index - 1]" align="center">
              <div class="favBox q-ma-sm" v-if="mfav[index - 1] != ''">
                {{ mfav[index - 1] }}
              </div>
            </div>
          </div>
          <div class="row items-center q-pl-lg">
            <div v-for="index in 3" :key="mfav[index + 2]" align="center">
              <div class="favBox q-ma-sm" v-if="mfav[index + 2] != ''">
                {{ mfav[index + 2] }}
              </div>
            </div>
          </div>
          <div class="row items-center q-pl-lg">
            <div v-for="index in 2" :key="mfav[index + 5]" align="center">
              <div class="favBox q-ma-sm" v-if="mfav[index + 5] != ''">
                {{ mfav[index + 5] }}
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- bg Drop  -->
      <div class="bgDrop fullscreen" v-show="otpBtn || detailBtn"></div>
    </div>
  </div>
</template>

<script>
import { type } from "os";
import axios from "axios";
export default {
  data() {
    return {
      mname: "",
      mdate: "",
      mfav: ["", "", "", "", "", "", "", ""],
      otpBtn: false,
      detailBtn: false,
      data: [
        {
          username: "Artzy",
          password: "123456",
          telephone: "085-749-9812",
          status: 1,
          timestamp: "13/75/278"
        },
        {
          username: "Artzy",
          password: "57841",
          telephone: "085-749-9812",
          status: 0,
          timestamp: "156125"
        }
      ],
      memid: 0,
      staOtp: 2,
      options: [
        {
          label: "Resend OTP",
          value: 2
        },
        {
          label: "Enable this account",
          value: 1
        },
        {
          label: "Delete this account",
          value: 3
        }
      ]
    };
  },
  methods: {
    clrmem() {
      this.otpBtn = false;
      this.detailBtn = false;
      this.memid = 0;
      this.staOtp = 2;
      this.loadData();
    },
    async detailShow(item) {
      this.mname = item.username + " : " + item.telephone;
      this.mdate = item.timestamp;
      this.mfav[0] = await this.catname(item.fav1id);
      this.mfav[1] = await this.catname(item.fav2id);
      this.mfav[2] = await this.catname(item.fav3id);
      this.mfav[3] = await this.catname(item.fav4id);
      this.mfav[4] = await this.catname(item.fav5id);
      this.mfav[5] = await this.catname(item.fav6id);
      this.mfav[6] = await this.catname(item.fav7id);
      this.mfav[7] = await this.catname(item.fav8id);
      this.detailBtn = true;

      this.loadData();
    },
    async catname(id) {
      let data = {
        catid: id
      };
      let url = this.serverpath + "bo_loadfavuser.php";
      let res = await axios.post(url, JSON.stringify(data));
      return res.data;
    },
    otpSelect(item) {
      this.memid = item.id;
      this.otpBtn = true;
      this.loadData();
    },
    async otpSelected() {
      let data = {
        id: this.memid,
        status: this.staOtp
      };
      if (this.staOtp == 3) {
        let url = this.serverpath + "bo_deluser.php";
        let res = await axios.post(url, JSON.stringify(data));
        this.$q.notify({
          progress: true,
          message: "Delete user complete",
          color: "negative",
          position: "top"
        });
      } else {
        let url = this.serverpath + "bo_changestatususer.php";
        let res = await axios.post(url, JSON.stringify(data));
        this.$q.notify({
          progress: true,
          message: "Update user status complete",
          color: "positive",
          position: "top",
          icon: "fas fa-check"
        });
      }
      this.clrmem();
      this.loadData();
    },
    async loadData() {
      let url = this.serverpath + "bo_loaduser.php";
      let res = await axios.get(url);
      this.data = res.data;
      //  this.data.sort((a, b) => a.orderid - b.orderid);
    },
    async changeSta(item) {
      let sta = 0;
      if (item.status == 0) sta = 1;
      let data = {
        id: item.id,
        status: sta
      };
      let url = this.serverpath + "bo_changestatususer.php";
      let res = await axios.post(url, JSON.stringify(data));

      this.loadData();
    }
  },
  mounted() {
    this.loadData();
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
.otpBox {
  width: 460px;
  height: 260px;
}
.ynBtn {
  margin: auto;
  width: 120px;
  height: 45px;
  border-radius: 5px;
  border: 1px solid #ffc24c;
  cursor: pointer;
  line-height: 45px;
}
.detailBox {
  width: 520px;
  height: 320px;
  border-radius: 10px;
}
.favBox {
  width: 140px;
  height: 34px;
  border-radius: 30px;
  border: 1px solid #797575;
}
</style>
