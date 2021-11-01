<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
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
                  @click="selectMember = 1"
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
                  @click="selectMember = 2"
                >
                  New member
                </q-btn>
                <div class="row"></div>
              </div>
            </div>
            <div class="row items-center">
              <div class="col" align="right">Total member</div>
              <div class="col-3" align="center" style="font-size:36px;">
                {{ 26540 }}
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
                />
              </div>
              <div class="col" align="right">New member in this week</div>
              <div class="col-3 row" style="font-size:24px;">
                <div class="col" align="right">{{ 540 }}</div>
                <div class="col-7" align="left">&nbsp;(+{{ 1.42 }}%)</div>
              </div>
            </div>
            <div id="container1" style="height: 600px; min-width: 800px"></div>
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
                {{ 26640 }}
              </div>
            </div>
            <div class="row items-end">
              <div class="col-3">
                <q-select
                  v-model="durationAds"
                  :options="durationOptions"
                  label="Campaign"
                  emit-value
                  map-options
                  style="width:220px;"
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
                />
              </div>
              <div class="col" align="right">Click in this week</div>
              <div class="col-3 row" style="font-size:24px;">
                <div class="col" align="right">{{ 1200 }}</div>
                <div class="col-7" align="left">&nbsp;(+{{ 1.82 }}%)</div>
              </div>
            </div>
            <div class="chartArea"></div>
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
                {{ 12547 }}
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
                <div class="col" align="right">{{ 300 }}</div>
                <div class="col-7" align="left">&nbsp;(+{{ 10.72 }}%)</div>
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
                  v-model="durationMovie"
                  :options="durationOptions"
                  label="Duration"
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
          value: 0
        }
      ],
      durationMember: "The last 4 weeks", // ตัวเลือกแสดงผลของ Member
      durationAds: "The last 4 weeks", // ตัวเลือกแสดงผลของ Ads
      durationStreaming: "The last 4 weeks", // ตัวเลือกแสดงผลของ Streaming
      durationMovie: "The last 4 weeks", // ตัวเลือกแสดงผลของ Movie/Series
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
      totalMember: [],
      currentWeek: 0
    };
  },
  methods: {
    async loadTotalMember() {
      let url = this.serverpath + "bo_loadviewtotalmember.php";
      let res = await axios.get(url);
      this.totalMember = res.data;
      console.log(this.totalMember);
    },
    calCurrentWeek() {
      let currentTime = new Date().getTime();
      let startTime = new Date(this.startDate).getTime();
      this.currentWeek = Math.floor(
        (currentTime - startTime) / (1000 * 60 * 60 * 24 * 7)
      );
    }
  },
  mounted() {
    this.loadTotalMember();
    this.calCurrentWeek();
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
</style>
