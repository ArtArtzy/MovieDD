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
              v-model="searchMovie"
              placeholder="Search : film title"
              dense
              style="width:400px;"
            >
              <template v-slot:prepend>
                <q-icon class="fas fa-search" />
              </template>
            </q-input>
          </div>
          <div class="col-1" align="right">
            Category
          </div>
          <div class="q-pl-sm">
            <q-select
              color="orange-13"
              v-model="movieCat"
              :options="movieCatOpt"
              dense
              style="width:120px;font-size:16px;"
            >
            </q-select>
          </div>
          <div class="col-1" align="right">
            Page
          </div>
          <div class="q-pl-sm">
            <q-select
              color="orange-13"
              v-model="movieP"
              :options="moviePage"
              dense
              style="width:50px;font-size:16px;"
            >
            </q-select>
          </div>
          <div class="col" align="left">of {{ moviePage.length }}</div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer "
              style="background-color:#FFC24C;font-size:18px;width:160px;"
              label="+ Movie"
              no-caps
              @click=""
            />
          </div>
        </div>
        <!-- end header  -->
        <div class="q-pt-lg"></div>
        <!-- movie box  -->
        <div v-for="(item, index) in data" :key="index">
          <div class="movieBox row " style="margin:10px;">
            <div class="q-ma-md">
              <img class="shadow-4" :src="urlPoster(item.id)" alt="" />
            </div>
            <div class="col q-pt-md">
              <div class="row" style="line-height:30px;">
                <div style="font-size:24px;">
                  {{ item.nameEng }}
                </div>
                <div class="q-pl-md" style="font-size:14px;color:blue">
                  <u>{{ item.dayUpload }} days | {{ item.view }} views</u>
                </div>
              </div>
              <div style="font-size:18px;">{{ item.nameTh }}</div>
              <div class="row" style="font-size:14px;">
                <div class="col-1">{{ item.year }}</div>
                <div class="col-1">{{ item.mpaRate }}</div>
                <div class="col-2">
                  {{ item.hour }} ชั่วโมง {{ item.min }} นาที
                </div>
                <div class="col-3 row">
                  <div>{{ item.type[0] }}&nbsp;</div>
                  <div
                    v-for="i in item.type.length - 1"
                    :key="i"
                    v-show="item.type[i]"
                  >
                    | {{ item.type[i] }}&nbsp;
                  </div>
                </div>
              </div>
              <div class="q-pt-sm-" style="max-width:860px;font-size:14px;">
                {{ item.synopsis }}
              </div>
              <div v-show="item.episode.length > 0">
                <div class="row">
                  <div v-for="(item2, index2) in item.episode" :key="index2">
                    <div class="epBox">
                      ซีซั่น {{ index2 + 1 }} - {{ item2 }} ตอน
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-1">
              <div class="row q-pt-md">
                <div class="col">
                  <q-btn
                    flat
                    class="far fa-bell"
                    size="20px"
                    style="max-height:30px;"
                  >
                    <q-badge v-show="item.alert != 0" floating color="red">{{
                      item.alert
                    }}</q-badge></q-btn
                  >
                </div>
                <div class="col cursor-pointer" @click="">
                  <u>Edit</u>
                </div>
              </div>
              <div class="btnMovie bg-primary" align="center">
                Episode
              </div>

              <div
                v-show="item.trilerCode"
                class="btnMovie bg-primary"
                align="center"
              >
                <q-icon class="fas fa-play" />
                trailer
              </div>
              <div
                v-show="!item.trilerCode"
                class="btnMovie bg-grey"
                align="center"
              >
                <q-icon class="fas fa-play" />
                trailer
              </div>
              <div
                v-show="item.promotion"
                class="btnMovie bg-positive"
                align="center"
                @click="item.promotion = 0"
              >
                Promotion
              </div>
              <div
                v-show="!item.promotion"
                class="btnMovie bg-grey"
                align="center"
                @click="item.promotion = 1"
              >
                Promotion
              </div>
              <div
                v-show="item.status"
                class="btnMovie bg-positive"
                align="center"
                @click="item.status = 0"
              >
                online
              </div>
              <div
                v-show="!item.status"
                class="btnMovie bg-negative"
                align="center"
                @click="item.status = 1"
              >
                offline
              </div>
            </div>
          </div>
        </div>
        <!-- end moviebox  -->
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchMovie: "",
      movieCat: "แอคชัน",
      movieCatOpt: [],
      movieP: 1,
      moviePage: [1, 2, 3, 4],
      data: [
        {
          id: 1,
          nameEng: "A man who defies The World of BL",
          nameTh: "เรื่องรักวายๆ ผมขอบายได้ไหมครับ",
          year: "2021",
          dayUpload: 10,
          view: 321,
          mpaRate: "PG",
          hour: "1",
          min: "27",
          type: ["แอคชัน", "ดราม่า", "ตลก"],
          synopsis:
            "เมื่อ Luke Hobbs ถูกส่งจากอังกฤษเพื่อไป หยุด ผู้ก่อการร้าย ที่มุ่งหวังจะทำลายโลก เขาต้องร่วมมือกับ Shaw นักปราบมือดีจาก USA แต่ทุกอย่างไม่ได้ง่ายอย่างที่คิด",

          alert: 5,

          trailerCode: "",
          promotion: 1,
          new: 1,
          status: 0,
          episode: [12, 12, 4]
        },
        {
          id: 2,
          nameEng: "The hill",
          nameTh: "เนินมรณะ สังหารโหด",
          year: "2017",
          dayUpload: 8,
          view: 450,
          mpaRate: "13+",
          hour: "1",
          min: "27",
          type: ["แอคชัน", "ดราม่า", "ผจญภัย"],
          synopsis:
            "เนินเขามรณะที่ใครๆ เดินผ่านก็ตาย นักปราบมือดีจาก USA แต่ทุกอย่างไม่ได้ง่ายอย่างที่คิด",

          alert: 0,
          trailerCode: "",
          promotion: 1,
          new: 1,
          status: 1,
          episode: []
        }
      ]
    };
  },
  methods: {
    urlPoster(id) {
      return this.serverpath + "/poster/series/" + id + ".jpg";
    }
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
.movieBox {
  margin: auto;
  background-color: #c6d6ff;
  border-radius: 5px;
  max-width: 1230px;
  // width: calc(100vw - 390px);
  height: 180px;
}
.btnMovie {
  cursor: pointer;
  color: white;
  font-size: 14px;
  margin-top: 5px;
  height: 25px;
  width: 87px;
  border-radius: 5px;
}
.epBox {
  text-align: center;
  width: 130px;
  border: 1px solid black;
  margin-right: 15px;
}
</style>
