<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <!-- Main page -->
      <div class="boxWhite ">
        <!-- header  -->
        <div class="row items-center q-pt-lg q-pb-md">
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
              emit-value
              map-options
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
              label="+ Series"
              no-caps
              @click="addSeriesBtn()"
            />
          </div>
        </div>
        <!-- end header  -->
        <!-- series Box  -->
        <q-scroll-area class="" style="height:88vh; max-width: 90vw;">
          <div v-for="(item, index) in data" :key="index">
            <div class="seriesBox row ">
              <div class="q-ma-md" v-if="item.poster == 1">
                <img
                  class="shadow-4"
                  :src="urlPoster(item.id)"
                  alt=""
                  style="width:100px;"
                />
              </div>
              <div v-else class="q-ma-md">
                <img
                  class="shadow-4"
                  :src="serverpath + 'poster/movie/nophoto.jpg'"
                  alt=""
                  style="width:100px;"
                />
              </div>
              <div class="col q-pt-md">
                <div class="row" style="line-height:30px;">
                  <div style="font-size:24px;">
                    {{ item.nameEng }}
                  </div>
                  <div class="q-pl-md" style="font-size:14px;color:blue">
                    <u>{{ item.dateUpload }} days | {{ item.view }} views</u>
                  </div>
                </div>
                <div style="font-size:18px;">{{ item.nameTh }}</div>
                <div class="row" style="font-size:14px;">
                  <div class="col-1">{{ item.year }}</div>
                  <div class="col-1">{{ item.mparate }}</div>

                  <div class="col row">
                    <div>{{ catName(item.type[0]) }}&nbsp;</div>
                    <div
                      v-for="i in item.type.length - 1"
                      :key="i"
                      v-show="item.type[i]"
                    >
                      | {{ catName(item.type[i]) }}&nbsp;
                    </div>
                  </div>
                </div>
                <div class="q-pt-sm-" style="max-width:860px;font-size:14px;">
                  {{ item.synopsis }}
                </div>
                <div v-show="item.episode != null">
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
                  <div class="col" align="left">
                    <q-btn
                      dense
                      round
                      flat
                      icon="far fa-bell"
                      @click="reportBtn(item.id)"
                    >
                      <q-badge v-show="item.alert != 0" color="red" floating>{{
                        item.alert
                      }}</q-badge>
                    </q-btn>
                  </div>

                  <div class="col cursor-pointer" @click="editSeriesBtn(item)">
                    <u>Edit</u>
                  </div>
                </div>
                <div
                  class="btnMovie bg-primary"
                  align="center"
                  @click="gotoEpisode(item.id)"
                >
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
            <div class="q-pt-md"></div>
          </div>
        </q-scroll-area>
        <!-- end series Box  -->
      </div>
      <!-- add series  -->
      <q-dialog class="" v-model="dialogAddSeries" persistent>
        <q-card class="diaBox">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Add Series
          </div>
          <div class="q-pa-sm q-ml-lg q-pl-md">
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Title name(En)</div>
                <q-input
                  class=""
                  style="width:260px;"
                  v-model="addmovie.titleEn"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-4 ">Title name(Th)</div>
                <q-input
                  class=""
                  style="width:260px;"
                  v-model="addmovie.titleTh"
                  dense
                />
              </div>
            </div>
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Year</div>
                <q-input
                  class=""
                  style="width:160px;"
                  v-model="addmovie.year"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-4">Mpa Rating</div>
                <q-select
                  class=""
                  color="blue"
                  v-model="addmovie.mpaRating"
                  :options="mpaOpt"
                  dense
                  style="width:80px;font-size:16px;"
                >
                </q-select>
              </div>
            </div>
            <div class="col row items-center" style="padding-top:20px;">
              <div class="row " style="width: 300px;">
                <div class="col">Poster file</div>
                <div class="col posterFilePos">
                  <q-file
                    v-model="addmovie.posterFile"
                    dense
                    accept=".jpg"
                    label="Pick one file"
                  >
                  </q-file>
                </div>
              </div>
            </div>
            <div class="q-pt-md">Synopsis</div>
            <div class="q-pt-sm">
              <q-input
                class="synBox"
                borderless
                type="textarea"
                style="max-height:450px;"
                v-model="addmovie.synopsis"
                dense
              />
            </div>
            <div class=" row items-end">
              <div class="col-2">Trailer code</div>
              <q-input
                class=""
                style="width:200px;"
                v-model="addmovie.trailerCode"
                dense
              />
            </div>
            <div class="row items-center q-pt-sm">
              <div class="col-2">
                Category
              </div>
              <q-select
                class=""
                color="teal"
                v-model="addmovie.category"
                :options="movieCatOptWithoutAll"
                multiple
                counter
                max-values="6"
                hint="3-6 categories"
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
                v-model="addmovie.netflix"
                label="Netflix"
                color="positive"
              />
              <q-checkbox
                class="col-2"
                dense
                v-model="addmovie.disney"
                label="Disney"
                color="positive"
              />
              <q-checkbox
                class="col-2"
                dense
                v-model="addmovie.amazon"
                label="Amazon"
                color="positive"
              /><q-checkbox
                class="col-2"
                dense
                v-model="addmovie.hbo"
                label="HBO"
                color="positive"
              />
            </div>
            <q-checkbox
              :label="labelExpired"
              class="q-pt-md"
              dense
              v-model="addmovie.newArraival"
              color="positive"
            />

            <div class="row ynDia">
              <div
                class="ynBtn q-ma-sm"
                @click="closeAddSeriesBtn()"
                align="center"
              >
                Cancel
              </div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="addMainSeriesBtn()"
                align="center"
              >
                Ok
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- edit series  -->
      <q-dialog class="" v-model="dialogEditSeries" persistent>
        <q-card class="diaBox">
          <div class="row" align="center">
            <div class="col-1"></div>
            <div class="col q-pt-md" style="font-size:24px;">
              Edit Series
            </div>
            <div class="col-1 q-ma-sm">
              <q-btn dense rounded flat icon="fas fa-trash-alt" />
            </div>
          </div>
          <div class="q-pa-sm q-ml-lg q-pl-md">
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Title name(En)</div>
                <q-input
                  class=""
                  style="width:260px;"
                  v-model="addmovie.titleEn"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-4 ">Title name(Th)</div>
                <q-input
                  class=""
                  style="width:260px;"
                  v-model="addmovie.titleTh"
                  dense
                />
              </div>
            </div>
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Year</div>
                <q-input
                  class=""
                  style="width:160px;"
                  v-model="addmovie.year"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-4">Mpa Rating</div>
                <q-select
                  class=""
                  color="blue"
                  v-model="addmovie.mpaRating"
                  :options="mpaOpt"
                  dense
                  style="width:80px;font-size:16px;"
                >
                </q-select>
              </div>
            </div>
            <div class="col row items-center" style="padding-top:20px;">
              <div class="row " style="width: 400px;">
                <div class="col-4">Poster file</div>
                <div class="col " align="left">
                  <div
                    v-if="addmovie.posterFile == 1"
                    class="cursor-pointer q-pl-sm"
                    @click="deletePosterFileBtn()"
                  >
                    <u>delete poster file</u>
                  </div>
                  <div v-else>
                    <q-file
                      v-model="addmovie.posterFile"
                      dense
                      accept=".jpg"
                      label="Pick one file"
                    >
                    </q-file>
                  </div>
                </div>
              </div>
            </div>
            <div class="q-pt-md">Synopsis</div>
            <div class="q-pt-sm">
              <q-input
                class="synBox"
                borderless
                type="textarea"
                style="max-height:450px;"
                v-model="addmovie.synopsis"
                dense
              />
            </div>
            <div class=" row items-end">
              <div class="col-2">Trailer code</div>
              <q-input
                class=""
                style="width:200px;"
                v-model="addmovie.trailerCode"
                dense
              />
            </div>
            <div class="row items-center q-pt-sm">
              <div class="col-2">
                Category
              </div>
              <q-select
                class=""
                color="teal"
                v-model="addmovie.category"
                :options="movieCatOptWithoutAll"
                multiple
                counter
                max-values="6"
                hint="3-6 categories"
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
                v-model="addmovie.netflix"
                label="Netflix"
                color="positive"
              />
              <q-checkbox
                class="col-2"
                dense
                v-model="addmovie.disney"
                label="Disney"
                color="positive"
              />
              <q-checkbox
                class="col-2"
                dense
                v-model="addmovie.amazon"
                label="Amazon"
                color="positive"
              /><q-checkbox
                class="col-2"
                dense
                v-model="addmovie.hbo"
                label="HBO"
                color="positive"
              />
            </div>
            <q-checkbox
              :label="labelExpired"
              class="q-pt-md"
              dense
              v-model="addmovie.newArraival"
              color="positive"
            />

            <div class="row ynDia">
              <div
                class="ynBtn q-ma-sm"
                @click="closeEditSeriesBtn()"
                align="center"
              >
                Cancel
              </div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="editMainSeriesBtn()"
                align="center"
              >
                Ok
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Report  -->
      <q-dialog v-model="dialogReport" persistent>
        <q-card class="reportDialog">
          <div class="row q-pa-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;">Report</div>
            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="md"
                dense
                v-close-popup
              />
            </div>
          </div>
          <div class="row">
            <div class="col-1"></div>
            <div class="col">
              <div class="row items-end">
                <div class="col" style="font-size:20px;">Movie qualitiy</div>
                <div class="cursor-pointer">
                  <u>solved</u>
                </div>
              </div>
              <div class="row">
                <div class="col">หนังดูไม่ได้</div>
                <div class="col-3" align="right">x คน</div>
              </div>
              <div class="row">
                <div class="col">ไม่มีเสียง / เสียงไม่ตรง</div>
                <div class="col-3" align="right">x คน</div>
              </div>
              <div class="row">
                <div class="col">ภาพกระตุก</div>
                <div class="col-3" align="right">x คน</div>
              </div>
              <hr />
              <div style="font-size:20px;">Etc</div>
            </div>
            <div class="col-1"></div>
          </div>
          <q-scroll-area style="height:240px;">
            <div
              class="row"
              style="height:40px;"
              v-for="(item, index) in testReport"
              :key="index"
            >
              <div class="col-1"></div>
              <div
                class="col q-pl-sm"
                :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
                style="height:40px;line-height: 40px;"
              >
                {{ item }}
              </div>
              <div
                class="cursor-pointer q-pr-sm"
                :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
                style="height:40px;line-height: 40px;"
              >
                <u>solved</u>
              </div>
              <div class="col-1"></div>
            </div>
          </q-scroll-area>
        </q-card>
      </q-dialog>
      <!-- bg drop  -->
      <div class="bgDrop fullscreen" v-show="dialogAddSeries"></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      testReport: [
        "ชื่อเรื่องสะกดผิด",
        "เรื่องย่อไม่ตรงกับเรื่องจริง",
        "ภาพปกคนละภาพ",
        "เสียงเบา",
        "s",
        "sdsa",
        "dsag",
        "dsgg",
        "ghsd",
        "ชื่อเรื่องสะกดผิด",
        "เรื่องย่อไม่ตรงกับเรื่องจริง",
        "ภาพปกคนละภาพ",
        "เสียงเบา",
        "s",
        "sdsa",
        "dsag",
        "dsgg",
        "ghsd",
        "ชื่อเรื่องสะกดผิด",
        "เรื่องย่อไม่ตรงกับเรื่องจริง",
        "ภาพปกคนละภาพ",
        "เสียงเบา",
        "s",
        "sdsa",
        "dsag",
        "dsgg",
        "ghsd"
      ],
      searchMovie: "",
      movieCat: 0, //ประเภทหนังที่ filter
      movieCatOpt: [], //รายชื่อประเภทของหนัง
      movieCatOptWithoutAll: [], //รายชื่อประเภทของหนังที่ไม่รวมทั้งหมด
      mpaOpt: ["G", "PG", "PG-13", "R", "NC-17"],
      movieP: 1,
      moviePage: [1, 2, 3, 4],
      labelExpired: "", // คำอธิบาย label สำหรับ New arraival
      data: [],
      addmovie: {
        titleTh: "",
        titleEn: "",
        year: "",
        mpaRating: "G",
        posterFile: null,
        synopsis: "",
        trailerCode: "",
        category: null,
        netflix: false,
        disney: false,
        amazon: false,
        hbo: false,
        newArraival: false,
        expiredDate: ""
      },
      editMovieId: "",
      dialogAddSeries: false,
      dialogEditSeries: false,
      dialogReport: false
    };
  },
  methods: {
    //ล้างข้อมูล
    clearData() {
      this.addmovie.titleTh = "";
      this.addmovie.titleEn = "";
      this.addmovie.year = "";
      this.addmovie.mpaRating = "G";
      this.addmovie.posterFile = null;
      this.addmovie.synopsis = "";
      this.addmovie.trailerCode = "";
      this.addmovie.category = null;
      this.addmovie.netflix = false;
      this.addmovie.disney = false;
      this.addmovie.amazon = false;
      this.addmovie.hbo = false;
      this.addmovie.newArraival = false;
    },
    // ปุ่ม Report
    reportBtn(id) {
      this.dialogReport = true;
    },
    //ปุ่ม ok ใน add series
    async addMainSeriesBtn() {
      //Check input
      if (this.addmovie.titleEn.length == 0) {
        this.redNotify("Please input Title name (En)");
        return;
      }
      if (this.addmovie.year.length == 0) {
        this.redNotify("Please input year");
        return;
      }

      if (
        this.addmovie.movieCodeThaiSub == 0 &&
        this.addmovie.movieCodeThaiSound == 0
      ) {
        this.redNotify("Please input Movie Code");
        return;
      }
      if (this.addmovie.category == null) {
        this.redNotify("Please pick category at least 3");
        return;
      } else if (this.addmovie.category.length < 3) {
        this.redNotify("Please pick category at least 3");
        return;
      }

      if (this.addmovie.posterFile == null) {
        this.redNotify("Please pick poster file");
        return;
      }
      //ปรับรูปแบบของ category
      let categoryData = "";
      this.addmovie.category.forEach(x => {
        categoryData += "[" + x + "],";
      });
      categoryData = categoryData.slice(0, -1);
      let data = {
        nameEng: this.addmovie.titleEn,
        nameTh: this.addmovie.titleTh,
        year: this.addmovie.year,
        mparate: this.addmovie.mpaRating,
        type: categoryData,
        synopsis: this.addmovie.synopsis,
        trailerCode: this.addmovie.trailerCode,
        netflix: this.addmovie.netflix ? 1 : 0,
        disney: this.addmovie.disney ? 1 : 0,
        amazon: this.addmovie.amazon ? 1 : 0,
        hbo: this.addmovie.hbo ? 1 : 0,
        new: this.addmovie.newArraival ? 1 : 0,
        expiredDate: this.addmovie.newArraival
          ? this.addmovie.expiredDate
          : null
      };
      let url = this.serverpath + "bo_seriesmainadddata.php";
      let res = await axios.post(url, JSON.stringify(data));
      let movieid = res.data;
      //ทำการ upload  รูปภาพ
      let formData = new FormData();
      formData.append("file", this.addmovie.posterFile);
      formData.append("id", movieid);
      url = this.serverpath + "bo_uploadseriesmainposter.php";
      let data2 = await axios.post(url, formData);
      //update cat ในตาราง category
      for (let catid of this.addmovie.category) {
        let data3 = {
          catid: catid
        };
        url = this.serverpath + "bo_movieaddcat.php";
        let res = await axios.post(url, JSON.stringify(data3));
      }
      this.greenNotify("Add new series completely");
      this.dialogAddSeries = false;
      this.loadseriesdata();
    },
    //หาจำนวนหน้า
    async loadpagenumber() {
      let data = {
        cat: this.movieCat
      };
      let url = this.serverpath + "bo_seriespagenumber.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.moviePage = [];
      for (let i = 1; i <= res.data; i++) {
        this.moviePage.push(i);
      }
    },
    //ข้อมูลโชว์หน้าแรก
    async loadseriesdata() {
      this.loadpagenumber();
      //โหลดข้อมูลหนัง
      this.data = [];
      let data = {
        catName: this.movieCat,
        pagedata: this.movieP
      };

      let url = this.serverpath + "bo_seriesshowdata.php";
      let res = await axios.post(url, JSON.stringify(data));
      res.data.forEach(x => {
        //หาวันที่ upload ไป

        let dateUploadTime = x.timestamp * 1000;
        let dateCurrent = new Date();
        let dateCurrentTime = dateCurrent.getTime();
        let dateDiff = dateCurrentTime - dateUploadTime;
        x.dateUpload = Math.floor(dateDiff / 1000 / 60 / 60 / 24);

        //จัดการเรื่อง episode
        if (x.episode != null) {
          x.episode = x.episode.split(",");
        }

        let movieType = x.type.split(",");
        movieType = movieType.map(x => {
          return x.replace("[", "").replace("]", "");
        });
        x.type = movieType;

        this.data.push(x);
      });
    },
    //ปุ่ม ok ใน edit series
    async editMainSeriesBtn() {
      //Check input
      if (this.addmovie.titleEn.length == 0) {
        this.redNotify("Please input Title name (En)");
        return;
      }
      if (this.addmovie.year.length == 0) {
        this.redNotify("Please input year");
        return;
      }

      if (
        this.addmovie.movieCodeThaiSub == 0 &&
        this.addmovie.movieCodeThaiSound == 0
      ) {
        this.redNotify("Please input Movie Code");
        return;
      }
      if (this.addmovie.category == null) {
        this.redNotify("Please pick category at least 3");
        return;
      } else if (this.addmovie.category.length < 3) {
        this.redNotify("Please pick category at least 3");
        return;
      }

      if (this.addmovie.posterFile == null) {
        this.redNotify("Please pick poster file");
        return;
      }
      //ปรับรูปแบบของ category
      let categoryData = "";
      this.addmovie.category.forEach(x => {
        categoryData += "[" + x + "],";
      });
      categoryData = categoryData.slice(0, -1);
      let data = {
        nameEng: this.addmovie.titleEn,
        nameTh: this.addmovie.titleTh,
        year: this.addmovie.year,
        mparate: this.addmovie.mpaRating,
        type: categoryData,
        synopsis: this.addmovie.synopsis,
        trailerCode: this.addmovie.trailerCode,
        netflix: this.addmovie.netflix ? 1 : 0,
        disney: this.addmovie.disney ? 1 : 0,
        amazon: this.addmovie.amazon ? 1 : 0,
        hbo: this.addmovie.hbo ? 1 : 0,
        new: this.addmovie.newArraival ? 1 : 0,
        expiredDate: this.addmovie.newArraival
          ? this.addmovie.expiredDate
          : null,
        id: this.editMovieId
      };
      let url = this.serverpath + "bo_serieseditdata.php";
      let res = await axios.post(url, JSON.stringify(data));
      //Check file delete
      if (this.addmovie.posterFile != 1) {
        //ทำการ upload  รูปภาพ
        let formData = new FormData();
        formData.append("file", this.addmovie.posterFile);
        formData.append("id", this.editMovieId);
        url = this.serverpath + "bo_uploadseriesmainposter.php";
        let data2 = await axios.post(url, formData);
      }
      this.greenNotify("update movie completely");
      this.dialogEditSeries = false;
      this.loadseriesdata();
    },
    //Delete poster edit mode
    async deletePosterFileBtn() {
      let data = {
        id: this.editMovieId
      };

      let url = this.serverpath + "bo_deleteposterseriesfile.php";
      let res = await axios.post(url, JSON.stringify(data));

      this.addmovie.posterFile = 0;
      this.greenNotify("deleted poster complete");
    },
    urlPoster(id) {
      return (
        this.serverpath +
        "/poster/series/" +
        id +
        ".jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100)
      );
    },
    addSeriesBtn() {
      let today = new Date();
      let mi = today.getTime() + 1296000000;
      let a = new Date(mi);
      this.addmovie.expiredDate =
        a.getDate() + "/" + (a.getMonth() + 1) + "/" + a.getFullYear();
      this.labelExpired =
        "New arrival (expireed date " + this.addmovie.expiredDate + ")";
      this.clearData();
      this.dialogAddSeries = true;
    },
    editSeriesBtn(item) {
      this.addmovie.titleTh = item.nameTh;
      this.addmovie.titleEn = item.nameEng;
      this.addmovie.year = item.year;
      this.addmovie.posterFile = item.poster;
      this.addmovie.mpaRating = item.mparate;
      this.addmovie.synopsis = item.synopsis;
      this.addmovie.trailerCode = item.trailerCode;
      this.addmovie.category = item.type;
      this.addmovie.netflix = item.netflix == 1 ? true : false;
      this.addmovie.disney = item.disney == 1 ? true : false;
      this.addmovie.amazon = item.amazon == 1 ? true : false;
      this.addmovie.hbo = item.hbo == 1 ? true : false;
      this.addmovie.newArraival = item.new == 1 ? true : false;
      this.addmovie.expiredDate = item.expireddate;
      if (this.addmovie.expiredDate == null) {
        let today = new Date();
        let mi = today.getTime() + 1296000000;
        let a = new Date(mi);
        this.addmovie.expiredDate =
          a.getDate() + "/" + (a.getMonth() + 1) + "/" + a.getFullYear();
        this.labelExpired =
          "New arrival (expired date " + this.addmovie.expiredDate + ")";
      } else {
        this.labelExpired =
          "New arrival (expired date " + this.addmovie.expiredDate + ")";
      }
      this.editMovieId = item.id;

      this.dialogEditSeries = true;
    },
    closeEditSeriesBtn() {
      this.clraddmovie();
      this.dialogEditSeries = false;
    },
    closeAddSeriesBtn() {
      this.clraddmovie();
      this.dialogAddSeries = false;
    },
    clraddmovie() {
      this.addmovie.titleTh = "";
      this.addmovie.titleEn = "";
      this.addmovie.year = "";
      this.addmovie.mpaRating = "G";
      this.addmovie.posterFile = null;
      this.addmovie.synopsis = "";
      this.addmovie.trailerCode = "";
      this.addmovie.category = null;
      this.addmovie.netflix = false;
      this.addmovie.disney = false;
      this.addmovie.amazon = false;
      this.addmovie.hbo = false;
      this.addmovie.newArraival = false;
      this.addmovie.expiredDate = "";
    },
    gotoEpisode(id) {
      this.$router.push("episode/" + id);
    },
    async loadcatatmovie() {
      //โหลดประเภทหนัง
      this.movieCatOpt = [];
      this.movieCatOptWithoutAll = [];
      let url = this.serverpath + "bo_loadcategory.php";
      let res = await axios.get(url);
      let temp2 = {
        label: "ทั้งหมด",
        value: 0
      };
      this.movieCatOpt.push(temp2);
      let dataTemp = res.data;
      dataTemp = dataTemp.sort((a, b) => a.orderid - b.orderid);
      dataTemp.forEach(x => {
        let temp = {
          label: x.catname,
          value: x.id
        };
        this.movieCatOpt.push(temp);
        this.movieCatOptWithoutAll.push(temp);
      });
      this.movieCat = this.movieCatOpt[0].value;
    },
    //แสดงชื่อ Category
    catName(id) {
      let temp = this.movieCatOpt.filter(x => x.value == id);
      return temp[0].label;
    }
  },
  mounted() {
    this.loadcatatmovie();
    this.loadpagenumber();
    this.loadseriesdata();
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
.bgDrop {
  background-color: rgba($color: #000000, $alpha: 0.6);
}
.seriesBox {
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
.epBox {
  text-align: center;
  width: 130px;
  border: 1px solid black;
  margin-right: 15px;
}
.diaBox {
  height: 720px;
  max-width: 1200px;
  width: 900px;
  border-radius: 30px;
  background-color: #edf2fe;
  border: 2px solid white;
}
.synBox {
  margin-left: 10px;
  background-color: white;
  height: 149px;
  width: 800px;
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
.reportDialog {
  border-radius: 30px;
  width: 530px;
  height: 500px;
}
</style>
