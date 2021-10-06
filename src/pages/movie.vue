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
              :dense="true"
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
              :dense="true"
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
              :dense="true"
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
            <div class="picMovie q-ma-md shadow-2">pic</div>
            <div class="col q-pt-md">
              <div class="row" style="line-height:30px;">
                <div style="font-size:24px;">
                  {{ item.nameEn }}
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
                  {{ item.durationH }} ชั่วโมง {{ item.durationM }} นาที
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
                <div class="col cursor-pointer">
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
      <q-dialog v-model="addMovie" persistent>
        <q-card class="diaBox">
          <div class="q-pt-md" align="center" style="font-size:24px;">
            Add movie
          </div>
          <div class="row">
            <div class="col-1"></div>
            <div class="col" style="font-size:18px;">
              <div class="row items-end">
                <div class="col-3">Title name(En)</div>
                <q-input
                  class="q-pl-sm"
                  style="width:260px;"
                  v-model="mnameEn"
                  dense="true"
                />
              </div>
              <div class="row items-end">
                <div class="col-3">Title name(Th)</div>

                <q-input
                  class="q-pl-sm"
                  style="width:260px;"
                  v-model="mnameTh"
                  dense="true"
                />
              </div>
              <div class="row items-end">
                <div class="col-3">Year</div>
                <q-input
                  class="q-pl-sm"
                  style="width:260px;"
                  v-model="myear"
                  dense="true"
                />
              </div>
              <div class="row items-end">
                <div class="col-3">MPA Rating</div>
                <q-select
                  class="q-pl-sm"
                  color="blue"
                  v-model="mmpaRate"
                  :options="mpaOpt"
                  :dense="true"
                  style="width:100px;font-size:16px;"
                >
                </q-select>
              </div>
              <div class="row items-end">
                <div class="col-3">Duration</div>
                <div class="">
                  <q-input
                    class="q-pl-sm"
                    style="width:70px;"
                    v-model="mdurationH"
                    dense="true"
                  />
                </div>
                h:
                <div class="col-2">
                  <q-input
                    class="q-pl-sm"
                    style="width:74px;"
                    v-model="mdurationM"
                    dense="true"
                  />
                </div>
                m
              </div>
              <div class="q-pt-sm">Synopsis</div>
              <div class="q-pt-sm">
                <q-input
                  class="synBox"
                  borderless
                  autogrow
                  type="textarea"
                  style="max-height:450px;"
                  v-model="msynopsis"
                  dense="true"
                />
              </div>
              <div class="row q-pt-md">
                <div class=" col-3">Poster file</div>
                <div>
                  <q-input
                    @input="
                      val => {
                        mposter = val[0];
                      }
                    "
                    borderless
                    type="file"
                    dense="true"
                  />
                </div>
              </div>
              <div class="row items-end">
                <div class="col-3">Movie code (Thai sound)</div>
                <div>
                  <q-input
                    class="q-pl-sm"
                    style="width:260px;"
                    v-model="mmovieCode"
                    dense="true"
                  />
                </div>
              </div>
              <div class="row items-end">
                <div class="col-3">Movie code (Thai sub)</div>
                <div>
                  <q-input
                    class="q-pl-sm"
                    style="width:260px;"
                    v-model="mmovieCode"
                    dense="true"
                  />
                </div>
              </div>
              <div class="row items-end">
                <div class="col-3">Trailer code</div>
                <div>
                  <q-input
                    class="q-pl-sm"
                    style="width:260px;"
                    v-model="mtrailerCode"
                    dense="true"
                  />
                </div>
              </div>
              <div class="q-pt-sm">Type</div>
              <div class="row">
                <q-select
                  class="col"
                  color="blue"
                  v-model="mtype[0]"
                  :options="typeOpt"
                  :dense="true"
                  style="width:150px;font-size:16px;"
                >
                </q-select>
                <div class="col-1"></div>
                <q-select
                  class="col"
                  color="blue"
                  v-model="mtype[1]"
                  :options="typeOpt"
                  :dense="true"
                  style="font-size:16px;"
                >
                </q-select>
                <div class="col-1"></div>
              </div>
              <div class="row q-pt-md">
                <q-select
                  class="col"
                  color="blue"
                  v-model="mtype[2]"
                  :options="typeOpt"
                  :dense="true"
                  style="width:150px;font-size:16px;"
                >
                </q-select>
                <div class="col-1"></div>
                <q-select
                  class="col"
                  color="blue"
                  v-model="mtype[3]"
                  :options="typeOpt"
                  :dense="true"
                  style="font-size:16px;"
                >
                </q-select>
                <div class="col-1"></div>
              </div>
              <div class="row q-pt-lg">
                <q-checkbox
                  class="col-4"
                  dense
                  v-model="mpromotion"
                  label="Promotion"
                  color="positive"
                />
                <q-checkbox
                  dense
                  v-model="mnew"
                  label="New arrival"
                  color="positive"
                />
              </div>
            </div>
          </div>
          <div class="row q-pt-sm" align="center">
            <div class="col">
              Mobile 360x445
              <div>
                <q-input
                  @input="
                    val => {
                      mposproM = val[0];
                    }
                  "
                  borderless
                  type="file"
                  dense="true"
                />
              </div>
            </div>
            <div class="col">
              Tablet 768x431
              <div>
                <q-input
                  @input="
                    val => {
                      mposproT = val[0];
                    }
                  "
                  borderless
                  type="file"
                  dense="true"
                />
              </div>
            </div>
            <div class="col">
              Pc 1196x672
              <div>
                <q-input
                  @input="
                    val => {
                      mposproP = val[0];
                    }
                  "
                  borderless
                  type="file"
                  dense="true"
                />
              </div>
            </div>
          </div>
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
        </q-card>
      </q-dialog>
      <!-- end add box  -->
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchMovie: "",
      movieCat: "แอคชัน",
      movieCatOpt: ["แอคชัน", "ดราม่า", "ไซไฟ"],
      movieP: 1,
      moviePage: [1, 2, 3, 4],
      data: [
        {
          id: 1,
          nameEn: "A man who defies The World of BL",
          nameTh: "เรื่องรักวายๆ ผมขอบายได้ไหมครับ",
          poster: null,
          year: "2021",
          dayUpload: 10,
          view: 321,
          mpaRate: "PG",
          durationH: "1",
          durationM: "27",
          type: ["แอคชัน", "ดราม่า", "ตลก", ""],
          synopsis:
            "เมื่อ Luke Hobbs ถูกส่งจากอังกฤษเพื่อไป หยุด ผู้ก่อการร้าย ที่มุ่งหวังจะทำลายโลก เขาต้องร่วมมือกับ Shaw นักปราบมือดีจาก USA แต่ทุกอย่างไม่ได้ง่ายอย่างที่คิด",
          forder: "a001",
          alert: 5,
          movieCodeEng: "",
          movieCodeTh: "",
          trailerCode: "",
          promotion: 1,
          newarrival: 1,
          status: 0
        }
      ],
      mnameEn: "",
      mnameTh: "",
      mposter: null,
      mposproM: null,
      mposproT: null,
      mposproP: null,
      myear: "",
      mmpaRate: "",
      mpaOpt: ["G", "PG", "PG-13", "R", "NC-17"],
      mdurationH: "",
      mdurationM: "",
      msynopsis: "",
      mmovieCode: "",
      mtrailerCode: "",
      mpromotion: false,
      mnew: false,
      mtype: ["", "", "", ""],
      typeOpt: [
        "Amezon",
        "Disney",
        "Netflix",
        "การ์ตูน",
        "เกาหลี",
        "จีน",
        "ญี่ปุ่น",
        "ไทย",
        "ไซไฟ",
        "แอคชัน",
        "ตลก",
        "โรแมนติก"
      ],
      addMovie: true,
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
      this.mnameEn = "";
      this.mnameTh = "";
      this.myear = "";
      this.mmpaRate = "";
      this.mpaOpt = ["G", "PG", "PG-13", "R", "NC-17"];
      this.mdurationH = "";
      this.mdurationM = "";
      this.msynopsis = "";
      this.mmovieCode = "";
      this.mtrailerCode = "";
      this.mtype = ["", "", "", ""];
      this.mpromotion = false;
      this.mnew = false;
      this.mposter = null;
      this.mposproT = null;
      this.mposproP = null;
      this.mposproM = null;
    }
  },
  mounted() {}
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
  height: 930px;
  width: 565px;
  border-radius: 30px;
  background-color: #edf2fe;
  border: 2px solid white;
}
.synBox {
  background-color: white;
  height: 149px;
  width: 457px;
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
  position: absolute;
  bottom: 30px;
  padding-left: 100px;
  width: 500px;
  height: 45px;
}
</style>
