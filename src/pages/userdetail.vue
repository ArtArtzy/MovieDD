<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="row items-center q-pt-lg">
          <q-btn
            class="q-ml-md"
            dense
            rounded
            flat
            @click="goToUser()"
            icon="fas fa-long-arrow-alt-left"
            style="width:100px;"
          />
        </div>
        <div class="col q-pt-lg font24" align="center">
          {{ detail.name }} - {{ changeFormatTel(detail.phone) }}
        </div>
        <div class="q-pa-md" align="center">
          Register date : {{ this.detail.regDate }}
        </div>
        <div class="row items-center q-pl-lg">
          <div v-for="(item, index) in detail.fav" :key="index" align="center">
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
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      id: this.$route.params.id,
      yValueChart: [],
      xValueChart: [],
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
      catData: [],
      detail: {
        name: "",
        phone: "",
        regDate: "",
        fav: ""
      } //ข้อมูลที่แสดงใน หน้ารายละเอียด
    };
  },
  methods: {
    //หาชื่อ category
    catname(id) {
      let temp = this.catData.filter(x => x.id == id);
      return temp[0].catname;
    },
    goToUser() {
      this.$router.push("/user");
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
    //load category มาเก็บไว้
    async loadCategory() {
      let url = this.serverpath + "bo_loadcategory.php";
      let res = await axios.get(url);
      this.catData = res.data;
    },
    //load ข้อมูลทั่วไปของ user
    async loadUserData() {
      let data = {
        id: this.id
      };
      let url = this.serverpath + "bo_loaduserbyid.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.detail.name = res.data[0].username;
      this.detail.phone = res.data[0].telephone;
      this.detail.regDate = res.data[0].timestamp;
      this.detail.fav = res.data[0].fav.split(",");
    },
    //load ข้อมูลการดูหนังของ user
    async loaduserstat() {
      let yValueChart = [];
      let xValueChart = [];
      let data = {
        id: this.id
      };
      let url = this.serverpath + "bo_userstatview.php";
      let res = await axios.post(url, JSON.stringify(data));
      let userStat = res.data;
      console.log(userStat);
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
          this.xValueChart.push(this.monthName[j - 1]);
        }
      }
      this.xValueChart.reverse();
      this.yValueChart.reverse();
      console.log(this.xValueChart);
      Highcharts.chart("container1", {
        chart: {
          type: "areaspline",
          width: 800,
          backgroundColor: "#E1EBFE"
        },
        title: {
          text: "Movie/Series watching"
        },
        exporting: { enabled: false },
        xAxis: {
          categories: this.xValueChart,
          lineColor: "#00CEFA",
          lineWidth: 2
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
    this.loaduserstat();
    this.loadCategory();
    this.loadUserData();
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
.favBox {
  width: 140px;
  height: 34px;
  border-radius: 30px;
  border: 1px solid #797575;
}
</style>
