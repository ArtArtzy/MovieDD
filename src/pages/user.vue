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
              v-model="searchUser"
              placeholder="Search : username"
              dense
              style="width:400px;"
              @keyup.enter="searchData()"
            >
              <template v-slot:prepend>
                <q-icon class="fas fa-search" />
              </template>
              <template v-slot:append>
                <q-icon
                  name="close"
                  @click="clearSearch()"
                  class="cursor-pointer"
                />
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
              @input="loadData()"
            >
            </q-select>
          </div>
          <div class="col-1" align="left">of {{ pageList.length }}</div>
        </div>

        <div class="inBox q-pt-xl">
          <div class="row q-pa-sm" style=" font-weight:500;" align="center">
            <div class="col-1">No.</div>
            <div class="col" align="left">Username</div>
            <div class="col-2" align="center">Password</div>
            <div class="col-1" style="width:180px;">Telephone</div>
            <div class="col-2" style="width:300px;">Register Date</div>
            <div class="col-1">Status</div>
            <div class="col-1">Detail</div>
          </div>
          <hr />
          <div class="contentuser">
            <div
              class="row q-pa-sm "
              v-for="(item, index) in data"
              :key="index"
              :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
              align="center"
            >
              <div class="col-1">
                {{ (userCurrentPage - 1) * userPerPage + index + 1 }}
              </div>
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
      </div>
      <!-- end table  -->
      <!-- otp select  -->
      <q-dialog v-model="dialogOTP" persistent>
        <q-card>
          <div class="otpBox" align="center">
            <div class="q-pt-md font24">OTP Solver</div>
            <div class="q-pl-xl q-pt-sm">
              <q-option-group
                v-model="staOtp"
                :options="options"
                color="primary"
                align="left"
              />
            </div>
            <div class="row q-pt-md" style="width:280px;margin:auto;">
              <div class="ynBtn q-ma-sm" @click="dialogOTP = false">Cancel</div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="otpSelected()"
              >
                OK
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>

      <!-- bg Drop  -->
      <div class="bgDrop fullscreen" v-show="dialogOTP"></div>
      <!-- Detail -->
      <div class="bgDrop fullscreen" v-show="dialogDetail">
        <div class="detailBox absolute-center">
          <div align="right">
            <q-btn
              icon="far fa-times-circle"
              flat
              round
              size="18px"
              dense
              @click="closeDialogDetail()"
            />
          </div>
          <div class="q-pt-sm font24" align="center">
            {{ detail.name }} - {{ changeFormatTel(detail.phone) }}
          </div>
          <div class="q-pa-md" align="center">
            Register date : {{ this.detail.regDate }}
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
          <div align="center" class="q-pt-md">
            <div id="container1" style="height: 600px; min-width: 800px"></div>
          </div>
        </div>
      </div>
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
      data: [], //ข้อมูลในหน้าแรก

      dialogOTP: false, //หน้าต่าง OTP
      memid: 0, //id ของ user สำหรับ OTP
      staOtp: 2, //ค่าเริ่มต้นของหน้าต่าง OTP
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
      ],
      dialogDetail: false, //หน้าต่าง Detail
      detail: {
        name: "",
        phone: "",
        regDate: "",
        fav: ""
      }, //ข้อมูลที่แสดงใน หน้ารายละเอียด
      xValueChart: [],
      yValueChart: [],
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
      ]
    };
  },
  methods: {
    //หาชื่อ category
    catname(id) {
      let temp = this.catData.filter(x => x.id == id);
      return temp[0].catname;
    },
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
    //ปิดหน้าต่าง graph
    closeDialogDetail() {
      this.dialogDetail = false;
    },
    //ล้างข้อมูลค้นหา
    clearSearch() {
      this.searchUser = "";
      this.loadData();
      this.loadNoPage();
    },

    //ค้นหา user
    async searchData() {
      if (this.searchUser.length >= 3) {
        this.data = [];
        let data2 = {
          searchText: this.searchUser
        };
        let url = this.serverpath + "bo_loadusersearch.php";
        let res = await axios.post(url, JSON.stringify(data2));
        this.data = res.data;
        this.userCurrentPage = 1;
        this.pageList = [1];
      } else {
        this.redNotify("Search text must be at least 3 characters.");
      }
    },
    //loadnumberofpage
    async loadNoPage() {
      this.pageList = [];
      let data = {
        userPerPage: this.userPerPage
      };
      let url = this.serverpath + "bo_loadusertotalpage.php";
      let res = await axios.post(url, JSON.stringify(data));

      let pageTotal = res.data;
      for (let i = 1; i <= pageTotal; i++) {
        this.pageList.push(i);
      }
    },
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
      this.detail.name = item.username;
      this.detail.phone = item.telephone;
      this.detail.regDate = item.timestamp;
      this.detail.fav = item.fav.split(",");
      this.loaduserstat(item.id);
      this.dialogDetail = true;
      // this.$router.push("userdetail/" + item.id);
    },
    //โหลข้อมูลหน้าหลัก
    async loadData() {
      this.data = [];
      let data = {
        page: this.userCurrentPage,
        userPerPage: this.userPerPage
      };

      let url = this.serverpath + "bo_loaduser.php";
      let res = await axios.post(url, JSON.stringify(data));
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
    //เปิดหน้าต่าง OTP
    otpSelect(item) {
      this.memid = item.id;
      this.staOtp = 2;
      this.dialogOTP = true;
    },
    //เลือก OTP
    async otpSelected() {
      let data = {
        id: this.memid,
        status: this.staOtp
      };
      if (this.staOtp == 3) {
        let url = this.serverpath + "bo_deluser.php";
        let res = await axios.post(url, JSON.stringify(data));
        this.greenNotify("Delete user completely");
      } else if (this.staOtp == 1) {
        let url = this.serverpath + "bo_changestatususer.php";
        let res = await axios.post(url, JSON.stringify(data));
        this.greenNotify("Update user status completely");
      } else {
        alert("Don't worry I didn't code it!!");
      }
      this.dialogOTP = false;
      this.loadData();
    },
    //load category มาเก็บไว้
    async loadCategory() {
      let url = this.serverpath + "bo_loadcategory.php";
      let res = await axios.get(url);
      this.catData = res.data;
    },
    //load ข้อมูลการดูหนังของ user
    async loaduserstat(id) {
      this.yValueChart = [];
      this.xValueChart = [];
      let data = {
        id: id
      };
      let url = this.serverpath + "bo_userstatview.php";
      let res = await axios.post(url, JSON.stringify(data));
      let userStat = res.data;
      let today = new Date();
      let cYear = today.getFullYear();
      let cMonth = today.getMonth() + 1;
      let counter = 0;
      for (let i = cYear; i >= cYear - 2; i--) {
        if (counter == 13) {
          break;
        }
        let startMonth = 12;
        if (counter == 0) {
          startMonth = cMonth;
        }
        for (let j = startMonth; j >= 1; j--) {
          counter++;
          if (counter == 13) {
            break;
          }
          //
          let statview = userStat.filter(x => x.year == i && x.month == j);
          let view = 0;
          if (statview.length != 0) {
            view = statview[0].view;
          }
          this.yValueChart.push(Number(view));
          this.xValueChart.push(this.monthName[j - 1] + " " + i);
        }
      }
      this.xValueChart.reverse();
      this.yValueChart.reverse();
      Highcharts.chart("container1", {
        chart: {
          type: "areaspline",
          width: 800,
          height: 420,
          backgroundColor: "#E1EBFE"
        },
        title: {
          text: "Movie/Series watching"
        },
        exporting: { enabled: false },
        xAxis: {
          categories: this.xValueChart,
          lineColor: "#00CEFA",
          lineWidth: 2,
          labels: {
            rotation: -90
          }
        },

        yAxis: {
          title: {
            text: "Movie/Series watching"
          },
          lineColor: "#00CEFA",
          lineWidth: 2,
          min: 0,
          softMax: 100
        },
        tooltip: {
          shared: true,
          valueSuffix: "times"
        },
        credits: {
          enabled: false
        },
        plotOptions: {
          areaspline: {
            fillOpacity: 0.5
          },
          line: {
            softThreshold: false
          }
        },
        series: [
          {
            name: "Movie/Series watching",
            data: this.yValueChart
          }
        ]
      });
    }
  },
  mounted() {
    this.loadCategory();
    this.loadData();
    this.loadNoPage();
    this.checkMenuAccess(6);
  }
};
</script>

<style lang="scss" scoped>
.contentuser {
  height: calc(100vh - 220px);
  overflow-y: auto;
}
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
  border: 1px solid black;
  cursor: pointer;
  line-height: 45px;
}
.detailBox {
  width: 900px;
  max-width: 900px;
  height: 720px;
  border-radius: 20px;
  background-color: #edf2fe;
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
