<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <!-- stat and chart  -->
      <div class="boxWhite " v-if="false">
        <div class="q-mt-lg q-ml-lg">
          <div
            class="q-pb-md"
            align="center"
            style="font-size:24px;font-weight:500;"
          >
            Currerent week : {{ currentWeek }}
          </div>
          <div class="scrollArea">
            <!-- Member  -->
            <div class="row items-center">
              <div class="" style="font-size:24px;font-weight:500;">
                Member
              </div>
              <div class="q-ml-md">
                <q-btn
                  rounded
                  dense
                  flat
                  style="height:40px;width:130px;"
                  :style="
                    selectMember == 1
                      ? 'background-color:#ffc24c'
                      : 'border:1px solid black;'
                  "
                  @click="totalMemberBtn()"
                >
                  Total member
                </q-btn>
              </div>
              <div class="q-ml-md">
                <q-btn
                  rounded
                  dense
                  flat
                  style="height:40px;width:130px;"
                  :style="
                    selectMember == 2
                      ? 'background-color:#ffc24c'
                      : 'border:1px solid black;'
                  "
                  @click="newMemberBtn()"
                >
                  New member
                </q-btn>
                <div class="row"></div>
              </div>
            </div>
            <div class="row items-center">
              <div class="col" align="right">Total member</div>
              <div class="col-3" align="center" style="font-size:36px;">
                {{ totalMemberNumber }}
              </div>
            </div>
            <div class="row items-end">
              <div class="col-3">
                <q-select
                  v-model="durationMember"
                  :options="durationOptions"
                  label="Duration"
                  emit-value
                  map-options
                  style="width:220px;"
                  @input="loadChartMember()"
                />
              </div>
              <div class="col" align="right">New member in this week</div>
              <div class="col-3 row" style="font-size:24px;">
                <div class="col" align="right">{{ newMemberNumber }}</div>
                <div class="col-7" align="left">
                  &nbsp;(+{{
                    ((newMemberNumber / totalMemberNumber) * 100).toFixed(2)
                  }}%)
                </div>
              </div>
            </div>
            <div align="center" class="q-pt-md">
              <div
                id="container1"
                style="height: 500px; min-width: 800px"
              ></div>
            </div>
            <hr style="width:98%;" align="left" />
            <!-- Ads  -->
            <div class="row items-center q-mt-lg">
              <div
                class=""
                style="font-size:24px;font-weight:500;margin-top:-40px;"
              >
                Ads
              </div>
              <div class="col" align="right">Total click</div>
              <div class="col-3" align="center" style="font-size:36px;">
                {{ totalAdsClick }}
              </div>
            </div>
            <div class="row items-end">
              <div class="col-3">
                <q-select
                  v-model="adsCampaign"
                  :options="adsOptions"
                  label="Campaign"
                  emit-value
                  map-options
                  style="width:220px;"
                  @input="loadChartAds()"
                />
              </div>
              <div class="col-3">
                <q-select
                  v-model="durationAds"
                  :options="durationOptions"
                  label="Duration"
                  emit-value
                  map-options
                  style="width:220px;"
                  @input="loadChartAds()"
                />
              </div>
              <div class="col" align="right">Click in this week</div>
              <div class="col-3 row" style="font-size:24px;">
                <div class="col" align="right">{{ lastAdsClick }}</div>
                <div class="col-7" align="left">
                  &nbsp;(+{{
                    ((lastAdsClick / totalAdsClick) * 100).toFixed(2)
                  }}%)
                </div>
              </div>
            </div>
            <div align="center" class="q-pt-md">
              <div
                id="container2"
                style="height: 500px; min-width: 800px"
              ></div>
            </div>
            <hr style="width:98%;" align="left" />
            <!-- Steaming  -->
            <div class="row items-center q-mt-lg">
              <div
                class=""
                style="font-size:24px;font-weight:500;margin-top:-40px;"
              >
                Streaming
              </div>
              <div class="col" align="right">Total streaming</div>
              <div class="col-3" align="center" style="font-size:36px;">
                {{ totalStreaming }}
              </div>
            </div>
            <div class="row items-end">
              <div class="col-3">
                <q-select
                  v-model="durationStreaming"
                  :options="durationOptions"
                  label="Duration"
                  emit-value
                  map-options
                  style="width:200px;"
                />
              </div>
              <div class="col" align="right">Streaming in this week</div>
              <div class="col-3 row" style="font-size:24px;">
                <div class="col" align="right">{{ thisWeekStreaming }}</div>
                <div class="col-7" align="left">
                  &nbsp;(+{{
                    ((thisWeekStreaming / totalStreaming) * 100).toFixed(2)
                  }}%)
                </div>
              </div>
            </div>
            <div class="chartArea"></div>
            <hr style="width:98%;" align="left" />
            <!-- movie/series  -->
            <div class="row items-center q-mt-lg">
              <div
                class=""
                style="font-size:24px;font-weight:500;margin-top:-40px;"
              >
                Movie / Series
              </div>
              <div class="col" align="right">Total streaming</div>
              <div class="col-3" align="center" style="font-size:36px;">
                {{ 26640 }}
              </div>
            </div>
            <div class="row items-end">
              <div class="row">
                <q-select
                  class="q-px-md"
                  v-model="weekMovie"
                  :options="weekOptions"
                  label="Week"
                  emit-value
                  map-options
                  style="width:200px;"
                />
                <q-select
                  class="q-px-md"
                  v-model="selectMovie"
                  :options="selectMovieOptions"
                  label="Movie/series"
                  emit-value
                  map-options
                  style="width:160px;"
                />
                <q-select
                  v-model="typeMovie"
                  :options="typeMovieOptions"
                  label="Type"
                  emit-value
                  map-options
                  style="width:160px;"
                />
              </div>
              <div class="col" align="right">Streaming in this week</div>
              <div class="col-3 row" style="font-size:24px;">
                <div class="col" align="right">{{ 87510 }}</div>
                <div class="col-7" align="left">&nbsp;(+{{ 33.31 }}%)</div>
              </div>
            </div>
            <div class="q-mt-lg">
              <div
                class="row q-pa-sm "
                v-for="index in 10"
                style="border-radius: 15px;"
                :key="index"
                :style="index % 2 == 0 ? 'background-color:#cedff2' : ''"
                align="left"
              >
                <div class="col q-pl-md row">
                  <div class="col-1">{{ index }}.</div>
                  <div class="col">
                    {{ listTopMovie[index - 1].view }}&nbsp;-&nbsp;{{
                      listTopMovie[index - 1].name
                    }}
                  </div>
                </div>
                <div class="col q-pl-md row">
                  <div class="col-1">{{ index + 10 }}.</div>
                  <div class="col">
                    {{ listTopMovie[index + 9].view }}&nbsp;-&nbsp;{{
                      listTopMovie[index + 9].name
                    }}
                  </div>
                </div>
              </div>
            </div>
            <div class="q-py-md"></div>
          </div>
        </div>
      </div>
      <!-- underconstruction -->
      <div v-else>
        <div class="bigCow">
          <img src="../../public/images/bigcow.png" alt="" />
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
      selectMember: 1, // ตัวเลือกการแสดงผล Member 1=total member, 2=new member
      durationOptions: [
        {
          label: "The last 4 weeks",
          value: 4
        },
        {
          label: "The last 12 weeks",
          value: 12
        },
        {
          label: "The last 24 weeks",
          value: 24
        },
        {
          label: "The last 52 weeks",
          value: 52
        },
        {
          label: "All time",
          value: 999
        }
      ],
      durationMember: 4, // ตัวเลือกแสดงผลของ Member
      durationAds: 4, // ตัวเลือกแสดงผลของ Ads
      durationStreaming: 4, // ตัวเลือกแสดงผลของ Streaming
      weekMovie: 0, // ตัวเลือกแสดงผลเป็น week ของ Movie/Series
      weekOptions: [], // ตัวเลือก week
      selectMovie: "Movie",
      selectMovieOptions: ["Movie", "Series"],
      typeMovie: "Top 20",
      typeMovieOptions: ["Top 20", "Topless 20"],
      listTopMovie: [
        { view: 1240, name: "Xmen 1" },
        { view: 1240, name: "Xmen 2" },
        { view: 1240, name: "Xmen 3" },
        { view: 1240, name: "Xmen 4" },
        { view: 1240, name: "Xmen 5" },
        { view: 1240, name: "Xmen 6" },
        { view: 1240, name: "Xmen 7" },
        { view: 1240, name: "Xmen 8" },
        { view: 1240, name: "Xmen 9" },
        { view: 1240, name: "Xmen 10" },
        { view: 1240, name: "Xmen 11" },
        { view: 1240, name: "Xmen 12" },
        { view: 1240, name: "Xmen 13" },
        { view: 1240, name: "Xmen 14" },
        { view: 1240, name: "Xmen 15" },
        { view: 1240, name: "Xmen 16" },
        { view: 1240, name: "Xmen 17" },
        { view: 1240, name: "Xmen 18" },
        { view: 1240, name: "Xmen 19" },
        { view: 1240, name: "Xmen 20" }
      ],
      memberData: [], // โหลดค่าจาก [viewuser] มาเก็บไว้
      adsData: [], // โหลดค่าจาก [ads] มาเก็บไว้
      currentWeek: 0, // บอกเวลาปัจจุบัน
      xValueMember: [], //ค่าแกน x ของ Member
      yValueMember: [], //ค่าแกน y ของ Member
      xValueAds: [], //ค่าแกน x ของ Ads
      yValueAds: [], //ค่าแกน y ของ Ads
      totalMemberNumber: 0, // ค่าแสดงขอบซ้ายบนกรอป  member
      newMemberNumber: 0, // ค่าที่เพิ่มขึ้นเป็น %
      adsCampaign: 0, // ตัวเลือกแสดงกราฟ ads
      adsOptions: [], //
      totalAdsClick: 0, // ค่าแสดงขอบซ้ายบนกรอป  Ads ผลรวม view ของ ads
      lastAdsClick: 0, // ค่าที่เพิ่มขึ้นเป็น %
      totalStreaming: 0,
      thisWeekStreaming: 0
    };
  },
  methods: {
    // โหลด id และ ชื่อ ads มาเก็บไว้ใน adsOptions ในรูปแบบ label:ชื่อ value:id
    async loadAdsCampaign() {
      this.adsOptions = [];
      let url = this.serverpath + "bo_loadads.php";
      let res = await axios.get(url);
      let dataTemp = res.data;

      dataTemp.forEach(x => {
        let temp = {
          label: x.at_title,
          value: x.at_id
        };
        this.adsOptions.push(temp);
      });
      this.adsCampaign = this.adsOptions[0].value;
    },
    // กดเลือก Total member ของ member
    totalMemberBtn() {
      this.selectMember = 1;
      this.loadChartMember();
    },
    // กดเลือก New member ของ member
    newMemberBtn() {
      this.selectMember = 2;
      this.loadChartMember();
    },
    // หาเวลาปัจจุบันว่าเป็น week ที่เท่าไร พร้อมทั้งเพิ่มตัวเลือก weekOptions
    async calCurrentWeek() {
      let currentTime = new Date().getTime();
      let startTime = new Date(this.startDate).getTime();
      this.currentWeek = Math.floor(
        (currentTime - startTime) / (1000 * 60 * 60 * 24 * 7)
      );
      this.weekOptions = [];
      this.weekMovie = this.currentWeek - 1;
      for (let i = this.weekMovie; i > 0; i--) {
        this.weekOptions.push(i);
      }
      let url = this.serverpath + "bo_totalstreaming.php";
      let res = await axios.get(url);
      this.totalStreaming = res.data;
      let currentW = this.currentWeek;
      url = this.serverpath + "bo_streamingthisweek.php";
      res = await axios.post(url, JSON.stringify(currentW));
      this.thisWeekStreaming = res.data;
    },
    // ดึงค่าในตาราง [viewads]
    async loadAdsData() {
      let url = this.serverpath + "bo_loadviewads.php";
      let res = await axios.get(url);
      this.adsData = res.data;
    },
    // สร้างกราฟ Ads
    async loadChartAds() {
      this.xValueAds = [];
      this.yValueAds = [];
      let weekOnProcess = 0;
      if (this.durationAds >= this.currentWeek) {
        weekOnProcess = this.currentWeek - 1;
      } else {
        weekOnProcess = this.durationAds;
      }
      for (let i = 1; i <= weekOnProcess; i++) {
        let weekx = this.currentWeek - i;
        this.xValueAds.push(weekx);
      }
      this.xValueAds.reverse();
      let adsTemp = this.adsData.filter(y => y.adsid == this.adsCampaign);

      this.xValueAds.forEach(x => {
        let yRawData = adsTemp.filter(y => y.week == x);
        if (yRawData.length == 0) {
          this.yValueAds.push(0);
        } else {
          this.yValueAds.push(Number(yRawData[0].view));
        }
      });
      this.totalAdsClick = 0;
      this.lastAdsClick = 0;
      adsTemp = adsTemp.sort((a, b) => a.week - b.week);

      for (let i = 0; i < adsTemp.length; i++) {
        let j = parseInt(adsTemp[i].view);

        this.totalAdsClick += j;
        this.lastAdsClick;
      }
      this.lastAdsClick = parseInt(adsTemp[adsTemp.length - 1].view);

      let OptionAds = this.adsOptions.filter(x => x.value == this.adsCampaign);
      let titleChart = OptionAds[0].label;
      Highcharts.chart("container2", {
        chart: {
          type: "line",
          width: 800,
          height: 420,
          backgroundColor: "#E1EBFE"
        },
        title: {
          text: titleChart
        },
        exporting: { enabled: false },
        xAxis: {
          categories: this.xValueAds,
          lineColor: "#00CEFA",
          lineWidth: 2
        },

        yAxis: {
          title: {
            text: "Total of click"
          },
          lineColor: "#00CEFA",
          lineWidth: 2,
          min: 0,
          softMax: 100
        },
        tooltip: {
          useHTML: true,
          headerFormat: "",
          pointFormat: "{point.y:,.f} click"
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
            showInLegend: false,
            name: "Movie/Series watching",
            data: this.yValueAds
          }
        ]
      });
    },
    // สร้างกราฟ Member
    async loadChartMember() {
      this.xValueMember = [];
      this.yValueMember = [];
      let weekOnProcess = 0;
      if (this.durationMember >= this.currentWeek) {
        weekOnProcess = this.currentWeek - 1;
      } else {
        weekOnProcess = this.durationMember;
      }
      for (let i = 1; i <= weekOnProcess; i++) {
        let weekx = this.currentWeek - i;
        this.xValueMember.push(weekx);
      }

      this.xValueMember.reverse();
      this.xValueMember.forEach(x => {
        let yRawData = this.memberData.filter(y => y.week == x);
        if (this.selectMember == 1) {
          if (yRawData.length == 0) {
            this.yValueMember.push(0);
          } else {
            this.yValueMember.push(Number(yRawData[0].totalmember));
          }
        } else {
          if (yRawData.length == 0) {
            this.yValueMember.push(0);
          } else {
            this.yValueMember.push(Number(yRawData[0].member));
          }
        }
      });
      let titleChart = "New member";
      if (this.selectMember == 1) {
        titleChart = "Total member";
        for (let i = 1; i < this.yValueMember.length; i++) {
          if (this.yValueMember[i] == 0) {
            this.yValueMember[i] = this.yValueMember[i - 1];
          }
        }
      }
      Highcharts.chart("container1", {
        chart: {
          type: "line",
          width: 800,
          height: 420,
          backgroundColor: "#E1EBFE"
        },
        title: {
          text: titleChart
        },
        exporting: { enabled: false },
        xAxis: {
          categories: this.xValueMember,
          lineColor: "#00CEFA",
          lineWidth: 2
        },

        yAxis: {
          title: {
            text: titleChart
          },
          lineColor: "#00CEFA",
          lineWidth: 2,
          min: 0,
          softMax: 100
        },
        tooltip: {
          useHTML: true,
          headerFormat: "",
          pointFormat: "{point.y:,.f} members"
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
            showInLegend: false,
            name: "Movie/Series watching",
            data: this.yValueMember
          }
        ]
      });
    },
    // ดึงต่า ในตาราง [viewuser]
    async loadMember() {
      let url = this.serverpath + "bo_loadviewtotalmember.php";
      let res = await axios.get(url);
      this.memberData = res.data;
    },
    // หาค่า total member กับ new member ไปแสดง
    checkTotal() {
      let temp = this.memberData.filter(
        y => y.week == this.xValueMember[this.xValueMember.length - 1]
      );
      this.totalMemberNumber = temp[0].totalmember;
      this.newMemberNumber = temp[0].member;
    }
  },
  async mounted() {
    await this.calCurrentWeek(); // หา week ปัจจุบัน
    await this.loadMember(); // โหลด database [viewuser]
    await this.loadChartMember(); // สร้างกราฟ
    await this.loadAdsCampaign(); // โหลด database [ads] พร้อมทั้งสร้าง ตัวเลือกชื่อ ads
    await this.loadAdsData(); // ดึงค่าในตาราง [viewads]
    await this.loadChartAds(); // สร้างกราฟ
    this.checkTotal();
    this.checkMenuAccess(5);
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
.chartArea {
  height: 400px;
}
.scrollArea {
  height: calc(100vh - 220px);
  overflow-y: auto;
}
.bigCow {
  position: absolute;
  bottom: 0px;
  left: -60px;
}
</style>
