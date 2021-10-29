<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <!-- header  -->
        <div class="row items-center q-pt-lg">
          <div class="col-5 q-pl-xl">
            <q-input
              outlined
              rounded
              clearable
              clear-icon="close"
              v-model="searchUser"
              placeholder="Search : username"
              dense
              style="width:400px;"
            >
              <template v-slot:prepend>
                <q-icon class="fas fa-search" />
              </template>
            </q-input>
          </div>
          <div class="col"></div>
          <div class="col-1" align="right">
            Page
          </div>
          <div class="q-pl-sm">
            <q-select
              color="orange-13"
              v-model="userCurrentPage"
              :options="pageList"
              dense
              style="width:50px;font-size:16px;"
            >
            </q-select>
          </div>
          <div class="col-1" align="left">of {{ pageList.length }}</div>
        </div>

        <div class="inBox q-pt-xl">
          <div class="row q-pa-sm" style=" font-weight:bold;" align="center">
            <div class="col-1">No.</div>
            <div class="col" align="left">Username</div>
            <div class="col-2" align="center">Password</div>
            <div class="col-1" style="width:180px;">Telephone</div>
            <div class="col-2" style="width:300px;">Register Date</div>
            <div class="col-1">Status</div>
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
            <div class="col-1">{{ index * userCurrentPage + 1 }}</div>
            <div class="col" align="left">{{ item.username }}</div>
            <div class="col-2" align="center">{{ item.password }}</div>
            <div class="col-1" style="width:180px;">
              {{ changeFormatTel(item.telephone) }}
            </div>
            <div class="col-2" style="width:300px;">{{ item.timestamp }}</div>
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
      <q-dialog v-model="dialogDetail" persistent>
        <q-card class="detailBox q-pa-sm">
          <div class="row" style="height:50px;">
            <div style="width:50px;"></div>
            <div class="col q-pt-lg font24" align="center">
              {{ detail.name }} - {{ detail.phone }}
            </div>
            <div style="width:50px;">
              <q-btn
                icon="far fa-times-circle"
                round
                flat
                size="18px"
                @click="dialogDetail = false"
              />
            </div>
          </div>

          <div class="font18 q-pt-md" align="center">
            Register date : {{ this.detail.regDate }}
          </div>

          <div class=" row items-center justify-center">
            <div class="q-pa-md">Register date : {{ this.detail.regDate }}</div>
          </div>
          <div class="row items-center q-pl-lg">
            <div
              v-for="(item, index) in detail.fav"
              :key="index"
              align="center"
            >
              <div class="favBox q-ma-sm font14" style="line-height:34px;">
                {{ catname(item) }}
              </div>
            </div>
          </div>
          <div id="container1" style="height: 400px; min-width: 600px"></div>
        </q-card>
      </q-dialog>
      <!-- bg Drop  -->
      <div class="bgDrop fullscreen" v-show="otpBtn || dialogDetail"></div>
    </div>
  </div>
</template>

<script>
import { type } from "os";
import axios from "axios";
export default {
  data() {
    return {
      searchUser: "", //ช่องค้นหา user
      userCurrentPage: 1, //หน้าของ user ปัจจุบัน
      pageList: [1], //List หน้าทั้งหมด
      userPerPage: 50, //จำนวน user ต่อ 1 หน้า
      dialogDetail: false, //หน้าต่าง detail ของ user
      detail: {
        name: "",
        phone: "",
        regDate: "",
        fav: "",
        id: ""
      }, //ข้อมูลที่แสดงใน หน้ารายละเอียด
      data: [], //ข้อมูลในหน้าแรก
      catData: [], //ข้อมูลของ category
      monthName: [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "July",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ],
      yValueChart: [],
      xValueChart: [],

      otpBtn: false,

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
    //แปลงเบอร์โทรศัพท์ให้อยู่ในรูป xxx-xxxx-xx
    changeFormatTel(phone) {
      return (
        phone.substring(0, 3) +
        "-" +
        phone.substring(3, 7) +
        "-" +
        phone.substring(7, 10)
      );
    },

    //เปิดหน้า Detail
    detailShow(item) {
      this.$router.push("userdetail/" + item.id);
    },
    //โหลข้อมูลหน้าหลัก
    async loadData() {
      let url = this.serverpath + "bo_loaduser.php";
      let res = await axios.get(url);
      this.data = res.data;
    },
    //เปลี่ยน status online - offline
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
    },

    clrmem() {
      this.otpBtn = false;
      this.detailBtn = false;
      this.memid = 0;
      this.staOtp = 2;
      this.loadData();
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
  width: 1020px;
  max-width: 1020px;
  height: 820px;
  border-radius: 10px;
}
.favBox {
  width: 140px;
  height: 34px;
  border-radius: 30px;
  border: 1px solid #797575;
}
.barbox {
  height: 80px;
  width: 100%;
  border: 1px solid red;
}
</style>
