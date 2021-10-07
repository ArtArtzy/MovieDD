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
              @click="addMovie = true"
            />
          </div>
        </div>
        <!-- end header  -->
        <div class="q-pt-lg"></div>
        <!-- movie box  -->
        <div v-for="(item, index) in data" :key="index">
          <div class="movieBox row">
            <div class="picMovie q-ma-md shadow-2">
              <img
                :src="'http://localhost/moviedd/poster/' + item.id + '.jpg'"
                alt=""
              />
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
                <div class="col-1">{{ item.year }}</div>
                <div class="col-1">{{ item.mpaRate }}</div>
                <div class="col-2">
                  {{ item.hour }} ชั่วโมง {{ item.min }} นาที
                </div>
                <div v-show="item.movieCodeTh" class="testMovie" align="center">
                  TH Sound
                </div>
                <div
                  v-show="item.movieCodeEng"
                  class="testMovie"
                  align="center"
                >
                  TH Sub
                </div>
              </div>
              <div class="q-pt-sm-" style="max-width:860px;font-size:14px;">
                {{ item.synopsis }}
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
                    <q-badge floating color="red">{{
                      item.alert
                    }}</q-badge></q-btn
                  >
                </div>
                <div class="col cursor-pointer" @click="editMovieBtn(item)">
                  <u>Edit</u>
                </div>
              </div>
              <div
                v-show="item.movieCodeTh || item.movieCodeEng"
                class="btnMovie bg-primary"
                align="center"
              >
                <q-icon class="fas fa-play" />
                movie
              </div>
              <div
                v-show="!(item.movieCodeTh || item.movieCodeEng)"
                class="btnMovie bg-grey"
                align="center"
              >
                <q-icon class="fas fa-play" />
                movie
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
      <!-- dialog box  -->
      <!-- add box  -->
      <q-dialog class="" v-model="addMovie" persistent>
        <q-card class="diaBox">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Add movie
          </div>
          <div class="q-pa-sm q-ml-lg" style="font-size:18px;">
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Title name(En)</div>
                <q-input
                  class=""
                  style="width:260px;"
                  v-model="mnameEng"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-4 ">Title name(Th)</div>
                <q-input
                  class=""
                  style="width:260px;"
                  v-model="mnameTh"
                  dense
                />
              </div>
            </div>
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Year</div>
                <q-input class="" style="width:160px;" v-model="myear" dense />
              </div>
              <div class="col row items-end">
                <div class="col-4">Mpa Rating</div>
                <q-select
                  class=""
                  color="blue"
                  v-model="mmpaRate"
                  :options="mpaOpt"
                  dense
                  style="width:80px;font-size:16px;"
                >
                </q-select>
              </div>
            </div>
            <div class="row">
              <div class="col row items-end q-pt-sm">
                <div class="col-4">Duration</div>
                <div class="">
                  <q-input
                    class="q-pl-sm"
                    style="width:70px;"
                    v-model="mhour"
                    dense
                  />
                </div>
                <div>h:</div>
                <div class="">
                  <q-input
                    class="q-pl-sm"
                    style="width:74px;"
                    v-model="mmin"
                    dense
                  />
                </div>
                <div>m</div>
              </div>
              <div class="col row items-end">
                <div class="">
                  Poster file
                </div>
                <q-input
                  class="q-pl-md"
                  @input="
                    val => {
                      mposter = val[0];
                    }
                  "
                  borderless
                  type="file"
                  dense
                />
              </div>
            </div>
            <div class="q-pt-md">Synopsis</div>
            <div class="q-pt-sm">
              <q-input
                class="synBox"
                borderless
                type="textarea"
                style="max-height:450px;"
                v-model="msynopsis"
                dense
              />
            </div>
            <div class="row ">
              <div class="col row items-end">
                <div class="col-6">Movie code(Thai sound)</div>
                <q-input
                  class=""
                  style="width:200px;"
                  v-model="mmovieCodeTh"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-6 ">Movie code(Thai sub)</div>
                <q-input
                  class=""
                  style="width:200px;"
                  v-model="mmovieCodeEn"
                  dense
                />
              </div>
            </div>
            <div class=" row items-end">
              <div class="col-3">Trailer code</div>
              <q-input
                class=""
                style="width:200px;"
                v-model="mtrailerCode"
                dense
              />
            </div>
            <div class="row items-center q-pt-sm">
              Category
              <q-select
                class="q-pl-lg"
                color="teal"
                v-model="mtype"
                :options="movieCatOpt"
                multiple
                counter
                max-values="6"
                hint="max 6 category"
                dense
                emit-value
                map-options
                style="width:600px;font-size:16px;"
              >
              </q-select>
            </div>
            <div class="row q-pt-lg">
              <q-checkbox
                class="col-2"
                dense
                v-model="mNetflix"
                label="Netflix"
                color="positive"
              />
              <q-checkbox
                class="col-2"
                dense
                v-model="mDisney"
                label="Disney"
                color="positive"
              />
              <q-checkbox
                class="col-2"
                dense
                v-model="mAmazon"
                label="Amazon"
                color="positive"
              /><q-checkbox
                class="col-2"
                dense
                v-model="mHBO"
                label="HBO"
                color="positive"
              />
            </div>
            <q-checkbox
              class="q-pt-md"
              dense
              v-model="mnew"
              label="New arraival (expired date 20/10/2021)"
              color="positive"
            />
            <!-- expired date  -->
            <div class="row ynDia">
              <div class="ynBtn q-ma-sm" @click="cancelAdd()" align="center">
                Cancel
              </div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="addOk()"
                align="center"
              >
                Ok
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- end add box  -->
    </div>
  </div>
</template>

<script>
import axios from "axios";
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
          poster: null,
          year: "2021",
          dayUpload: 10,
          view: 321,
          mpaRate: "PG",
          hour: "1",
          min: "27",
          type: ["แอคชัน", "ดราม่า", "ตลก", ""],
          synopsis:
            "เมื่อ Luke Hobbs ถูกส่งจากอังกฤษเพื่อไป หยุด ผู้ก่อการร้าย ที่มุ่งหวังจะทำลายโลก เขาต้องร่วมมือกับ Shaw นักปราบมือดีจาก USA แต่ทุกอย่างไม่ได้ง่ายอย่างที่คิด",

          alert: 5,
          movieCodeEng: "",
          movieCodeTh: "",
          trailerCode: "",
          promotion: 1,
          new: 1,
          status: 0
        }
      ],
      mnameEng: "",
      mnameTh: "",
      mposter: null,
      myear: "",
      mmpaRate: "",
      mpaOpt: ["G", "PG", "PG-13", "R", "NC-17"],
      mhour: "",
      mmin: "",
      msynopsis: "",
      mmovieCodeTh: "",
      mmovieCodeEn: "",
      mtrailerCode: "",
      mNetflix: false,
      mDisney: false,
      mAmazon: false,
      mHBO: false,
      mnew: false,
      mpromotion: false,
      mtype: null,
      addMovie: false,
      editMovie: false
    };
  },
  methods: {
    addOk() {},
    cancelAdd() {
      this.clrmem();
      this.addMovie = false;
    },
    clrmem() {
      this.mnameEng = "";
      this.mnameTh = "";
      this.myear = "";
      this.mmpaRate = "";
      this.mhour = "";
      this.mmin = "";
      this.msynopsis = "";
      this.mmovieCodeTh = "";
      this.mmovieCodeEn = "";
      this.mtrailerCode = "";
      this.mtype = null;
      this.mNetflix = false;
      this.mDisney = false;
      this.mAmazon = false;
      this.mHBO = false;
      this.mpromotion = false;
      this.mnew = false;
      this.mposter = null;
    },
    async loadcatatmovie() {
      this.movieCatOpt = [];
      let url = this.serverpath + "bo_loadcategory.php";
      let res = await axios.get(url);
      res.data.forEach(x => {
        let temp = {
          label: x.catname,
          value: x.id
        };
        this.movieCatOpt.push(temp);
      });
    },
    editMovieBtn(item) {
      this.editMovie = true;
    }
  },
  mounted() {
    this.loadcatatmovie();
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
  max-width: 1220px;
  width: calc(100vw - 380px);
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
.picMovie {
  width: 98px;
  height: 151px;
}
.testMovie {
  margin-right: 10px;
  width: 77px;
  height: 26 px;
  border: 1px solid black;
  border-radius: 5px;
  font-size: 14px;
}
.bgDrop {
  background-color: rgba($color: #000000, $alpha: 0.6);
}
.diaBox {
  height: 756px;
  max-width: 1200px;
  width: 920px;
  border-radius: 30px;
  background-color: #edf2fe;
  border: 2px solid white;
}
.synBox {
  background-color: white;
  height: 149px;
  width: 840px;
  border: 1px solid black;
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
.ynDia {
  margin: auto;
  position: absolute;
  bottom: 30px;
  margin-left: 200px;
  width: 400px;
  height: 45px;
}
</style>
