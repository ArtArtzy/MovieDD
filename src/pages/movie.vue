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
            <div class="picMovie q-ma-md q-mt-lg shadow-2">
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
              <div class="row q-py-sm" style="font-size:14px;">
                <div class="col-4 row">
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
                @click="previewMovie(item)"
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
                v-show="item.trailerCode"
                class="btnMovie bg-primary"
                align="center"
                @click="previewtrailer(item)"
              >
                <q-icon class="fas fa-play" />
                trailer
              </div>
              <div
                v-show="!item.trailerCode"
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
                @click="promotionBTN(item.id)"
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
      <!---------------------------------------------------dialog box  ------------------------------------->
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
              <div class="col row items-end q-py-sm">
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
              <div class="col row items-center" style="padding-top:20px;">
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
                  v-model="mmovieCodeEng"
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
      <!-- promotion -->
      <q-dialog class="" v-model="promotionMovie" persistent>
        <q-card class="promotionBox" style="font-size:24px;" align="center">
          <q-card-section class="row items-center q-pb-none">
            <q-space />
            <q-btn icon="far fa-times-circle" flat round dense v-close-popup />
          </q-card-section>
          <div class="row">
            <div class="col-2">
              Promotion
            </div>
            <div class="col" align="center" style="font-size:36px;">
              A man who defies The World of BL
            </div>
            <div class="col-2"></div>
          </div>
          <div class="row">
            <div class="col-2">
              <q-toggle
                v-model="promotionOn"
                color="green"
                size="xl"
                checked-icon="check"
                unchecked-icon="clear"
                style="margin-top:-40px;"
              />
            </div>
            <div class="col" align="center">
              เรื่องรักวายๆ ผมขอบายได้ไหมครับ
            </div>
            <div class="col-2"></div>
          </div>
          <div class="row items-center" aling="center" style="font-size:14px;">
            <div class="col"></div>
            <div
              v-show="indexPoster == 1"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="indexPoster = 1"
              style="background:#ffc24c;"
            >
              Mobile
            </div>
            <div
              v-show="indexPoster != 1"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="indexPoster = 1"
            >
              Mobile
            </div>
            <div
              v-show="indexPoster == 2"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="indexPoster = 2"
              style="background:#ffc24c;"
            >
              Tablet
            </div>
            <div
              v-show="indexPoster != 2"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="indexPoster = 2"
            >
              Tablet
            </div>
            <div
              v-show="indexPoster == 3"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="indexPoster = 3"
              style="background:#ffc24c;"
            >
              PC
            </div>
            <div
              v-show="indexPoster != 3"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="indexPoster = 3"
            >
              PC
            </div>
            <div class="col"></div>
          </div>
          <!-- รูป  -->
          <div class="">
            <div
              v-show="indexPoster == 1 && posterM == null"
              class="q-pa-md col"
              style="width:360px;height:445px;border-style:dashed;margin-top:100px;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:120px;">
                jpg - 360x445 px
              </div>
              <q-input
                class="q-pl-md"
                style="margin-left:50px;"
                @input="
                  val => {
                    posterM = val[0];
                  }
                "
                borderless
                type="file"
                dense
              />
            </div>
            <div
              v-show="indexPoster == 1 && posterM != null"
              class="q-pa-md col"
              style="margin-top:80px;"
              align="center"
            >
              <img :src="posterM" alt="" />
              <div><u>delete poster</u></div>
            </div>
            <div
              v-show="indexPoster == 2 && posterT == null"
              class="q-pa-md col"
              style="width:770px;height:430px;border-style:dashed;margin-top:80px;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:120px;">
                jpg - 770x430 px
              </div>
              <q-input
                @input="
                  val => {
                    posterT = val[0];
                  }
                "
                style="width:300px;margin-left:100px;"
                borderless
                align="center"
                type="file"
                dense
              />
            </div>
            <div
              v-show="indexPoster == 2 && posterT != null"
              class="q-pa-md col"
              style="margin-top:100px;"
              align="center"
            >
              <img :src="posterT" alt="" />
              <div><u>delete poster</u></div>
            </div>
            <div
              v-show="indexPoster == 3 && posterP == null"
              class="q-pa-md col"
              style="width:1200px;height:670px;border-style:dashed;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:180px;">
                jpg - 1200x670 px
              </div>
              <q-input
                @input="
                  val => {
                    posterP = val[0];
                  }
                "
                style="width:300px;margin-left:100px;"
                borderless
                align="center"
                type="file"
                dense
              />
            </div>
            <div
              v-show="indexPoster == 3 && posterP != null"
              class="col"
              style=""
              align="center"
            >
              <img :src="posterP" alt="" />
              <div><u>delete poster</u></div>
            </div>
            <div class="col"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- movie preview  -->
      <q-dialog v-model="previewMovieBtn" persistent>
        <q-card class="preview">
          <div class="row q-pa-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;margin-top:30px;">
              "{{ mnameEng }}"
            </div>

            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="xl"
                dense
                v-close-popup
                @click="clrmem()"
              />
            </div>
          </div>
          <div class="row" align="center">
            <div class="col"></div>
            <div class="noMovieCode q-mx-lg" v-show="mmovieCodeTh == ''">
              TH sound
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="mmovieCodeTh != '' && indexPoster == 1"
              style="background-color:#ffc24c"
            >
              TH sound
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="mmovieCodeTh != '' && indexPoster != 1"
              @click="indexPoster = 1"
            >
              TH sound
            </div>
            <div class="noMovieCode q-mx-lg" v-show="mmovieCodeEng == ''">
              TH sub
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="mmovieCodeEng != '' && indexPoster == 2"
              style="background-color:#ffc24c"
            >
              TH sub
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="mmovieCodeEng != '' && indexPoster != 2"
              @click="indexPoster = 2"
            >
              TH sub
            </div>
            <div class="col"></div>
          </div>
          <div class="q-mt-md">
            <div
              class="brx "
              style="width:920px;height:443px;margin:auto;"
              v-show="indexPoster == 1"
            >
              TH sound {{ mmovieCodeTh }}
            </div>
            <div
              class="brx "
              style="width:920px;height:443px;margin:auto;"
              v-show="indexPoster == 2"
            >
              TH sub {{ mmovieCodeEng }}
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- trailer preview  -->
      <q-dialog v-model="previewtrailerBtn" persistent>
        <q-card class="preview">
          <div class="row q-pa-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;margin-top:30px;">
              "{{ mnameEng }}"
            </div>

            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="xl"
                dense
                v-close-popup
                @click="clrmem()"
              />
            </div>
          </div>
          <div class="q-mt-md">
            <div class="brx" style="width:920px;height:443px;margin:auto;">
              trailer code : {{ mtrailerCode }}
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- bg drop  -->
      <div
        class="bgDrop fullscreen"
        v-show="
          addMovie ||
            editMovie ||
            promotionMovie ||
            previewMovieBtn ||
            previewtrailerBtn
        "
      ></div>
      <!-- end bgDrop  -->
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
          movieCodeEng: "kbfhda",
          movieCodeTh: "agssaga",
          trailerCode: "NDAywf",
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
      mmovieCodeEng: "",
      mtrailerCode: "",
      mNetflix: false,
      mDisney: false,
      mAmazon: false,
      mHBO: false,
      mnew: false,
      mtype: null,
      addMovie: false,
      editMovie: false,
      previewMovieBtn: false,
      previewtrailerBtn: false,
      promotionMovie: false,
      promotionOn: false,
      indexPoster: 1,
      posterM: null,
      posterT: null,
      posterP: null
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
      this.mmovieCodeEng = "";
      this.mtrailerCode = "";
      this.mtype = null;
      this.mNetflix = false;
      this.mDisney = false;
      this.mAmazon = false;
      this.mHBO = false;
      this.mpromotion = false;
      this.mnew = false;
      this.mposter = null;
      this.promotionMovie = false;
      this.promotionOn = false;
      this.indexPoster = 1;
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
    previewMovie(item) {
      this.mnameEng = item.nameEng;
      //      this.mnameTh=item.nameTh;
      this.mmovieCodeEng = item.movieCodeEng;
      this.mmovieCodeTh = item.movieCodeTh;
      this.previewMovieBtn = true;
      if (this.mmovieCodeTh == "") {
        this.indexPoster = 2;
      }
    },
    previewtrailer(item) {
      this.mnameEng = item.nameEng;
      this.mtrailerCode = item.trailerCode;
      this.previewtrailerBtn = true;
    },
    editMovieBtn(item) {
      this.editMovie = true;
    },
    promotionBTN(posterId) {
      this.promotionMovie = true;
      this.checkPoster(posterId);
    },
    checkPoster(posterId) {
      //     this.posterM = "http://localhost/moviedd/promotion/" + posterId + "m.jpg";
      this.posterT = "http://localhost/moviedd/promotion/" + posterId + "t.jpg";
      this.posterP = "http://localhost/moviedd/promotion/" + posterId + "p.jpg";
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
  height: 200px;
}
.btnMovie {
  line-height: 30px;
  cursor: pointer;
  color: white;
  font-size: 14px;
  margin-top: 5px;
  height: 30px;
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
.promotionBox {
  max-width: 1400px;
  width: 1315px;
  height: 950px;
  border-radius: 30px;
  background-color: #edf2fe;
}
.picPosterBTN {
  width: 100px;
  height: 30px;
  line-height: 30px;
  border-radius: 5px;
  border: 1px solid black;
}
.noMovieCode {
  width: 100px;
  height: 30px;
  line-height: 30px;
  border-radius: 5px;
  color: #c4c4c4;
  border: 1px solid #c4c4c4;
}
.preview {
  max-width: 1000px;
  width: 975px;
  height: 600px;
  border-radius: 30px;
}
</style>
