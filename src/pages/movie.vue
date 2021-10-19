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
              emit-value
              map-options
              @input="refreshCat()"
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
              @input="loadMovieData()"
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
              @click="showAddMovieBtn()"
            />
          </div>
        </div>
        <div class="q-pt-md"></div>
        <!-- end header  -->
        <q-scroll-area class="" style="height:88vh; max-width: 90vw;">
          <!-- movie box  -->

          <div v-for="(item, index) in data" :key="index">
            <div class="movieBox row">
              <div
                class="picMovie q-ma-md q-mt-lg shadow-2"
                v-if="item.poster == 1"
              >
                <img
                  :src="serverpath + 'poster/movie/' + item.id + '.jpg'"
                  style="width:100px;"
                />
              </div>
              <div
                class="picMovie q-ma-md q-mt-lg shadow-2"
                v-if="item.poster == 0"
              >
                <img :src="serverpath + 'poster/movie/nophoto.jpg'" />
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
                <div class="row q-py-sm" style="font-size:14px;">
                  <div class="col-1">{{ item.year }}</div>
                  <div class="col-1">{{ item.mparate }}</div>
                  <div class="col-2">
                    {{ item.durationHour }} ชั่วโมง {{ item.durationMin }} นาที
                  </div>
                  <div class="col-4 row">
                    <div>{{ catName(item.type[0]) }}&nbsp;</div>
                    <div
                      v-for="i in item.type.length - 1"
                      :key="i"
                      v-show="item.type[i]"
                    >
                      | {{ catName(item.type[i]) }}&nbsp;
                    </div>
                  </div>
                  <div
                    v-show="item.movieCodeTh"
                    class="testMovie"
                    align="center"
                  >
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
                      <q-badge v-show="item.alert != 0" floating color="red">{{
                        item.alert
                      }}</q-badge>
                    </q-btn>
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
                  @click="
                    promotionBTN(
                      item.id,
                      item.nameEng,
                      item.nameTh,
                      item.promotionMobilePic,
                      item.promotionTabletPic,
                      item.promotionPCPic
                    )
                  "
                >
                  Promotion
                </div>
                <div
                  v-show="item.status == 1"
                  class="btnMovie bg-positive"
                  align="center"
                  @click="changeStatus(item, index)"
                >
                  online
                </div>
                <div
                  v-show="item.status == 0"
                  class="btnMovie bg-negative"
                  align="center"
                  @click="changeStatus(item, index)"
                >
                  offline
                </div>
              </div>
            </div>
            <div style="height:15px;"></div>
          </div>
          <!-- end moviebox  -->
        </q-scroll-area>
      </div>
      <!------------------ dialog  ---------------->
      <!-- add movie box  -->
      <q-dialog class="" v-model="dialogAddMovie" persistent>
        <q-card class="diaBox">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Add movie
          </div>
          <div class="q-pa-sm q-ml-lg">
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
            <div class="row">
              <div class="col row items-end q-py-sm">
                <div class="col-4">Duration</div>
                <div class="">
                  <q-input
                    class="q-pl-sm"
                    style="width:70px;"
                    v-model="addmovie.durationHour"
                    dense
                  />
                </div>
                <div>h:</div>
                <div class="">
                  <q-input
                    class="q-pl-sm"
                    style="width:74px;"
                    v-model="addmovie.durationMin"
                    dense
                  />
                </div>
                <div>m</div>
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
            <div class="row ">
              <div class="col row items-end">
                <div class="col-6">Movie code(Thai sound)</div>
                <q-input
                  class=""
                  style="width:200px;"
                  v-model="addmovie.movieCodeThaiSound"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-6 ">Movie code(Thai sub)</div>
                <q-input
                  class=""
                  style="width:200px;"
                  v-model="addmovie.movieCodeThaiSub"
                  dense
                />
              </div>
            </div>
            <div class=" row items-end">
              <div class="col-3">Trailer code</div>
              <q-input
                class=""
                style="width:200px;"
                v-model="addmovie.trailerCode"
                dense
              />
            </div>
            <div class="row items-center q-pt-sm">
              Category
              <q-select
                class="q-pl-lg"
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
                @click="closeAddMovieBtn()"
                align="center"
              >
                Cancel
              </div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="addMovieBtn()"
                align="center"
              >
                Ok
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- edit movie box -->
      <q-dialog class="" v-model="dialogEditMovie" persistent>
        <q-card class="diaBox">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Add movie
          </div>
          <div class="q-pa-sm q-ml-lg">
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
            <div class="row">
              <div class="col row items-end q-py-sm">
                <div class="col-4">Duration</div>
                <div class="">
                  <q-input
                    class="q-pl-sm"
                    style="width:70px;"
                    v-model="addmovie.durationHour"
                    dense
                  />
                </div>
                <div>h:</div>
                <div class="">
                  <q-input
                    class="q-pl-sm"
                    style="width:74px;"
                    v-model="addmovie.durationMin"
                    dense
                  />
                </div>
                <div>m</div>
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
            <div class="row ">
              <div class="col row items-end">
                <div class="col-6">Movie code(Thai sound)</div>
                <q-input
                  class=""
                  style="width:200px;"
                  v-model="addmovie.movieCodeThaiSound"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-6 ">Movie code(Thai sub)</div>
                <q-input
                  class=""
                  style="width:200px;"
                  v-model="addmovie.movieCodeThaiSub"
                  dense
                />
              </div>
            </div>
            <div class=" row items-end">
              <div class="col-3">Trailer code</div>
              <q-input
                class=""
                style="width:200px;"
                v-model="addmovie.trailerCode"
                dense
              />
            </div>
            <div class="row items-center q-pt-sm">
              Category
              <q-select
                class="q-pl-lg"
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
                @click="closeEditMovieBtn()"
                align="center"
              >
                Cancel
              </div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="saveEditMovieBtn()"
                align="center"
              >
                OK
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- promotion -->
      <!-- <q-dialog class="" v-model="promotionMovie" persistent>
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
              {{ promotionMovieNameEng }}
            </div>
            <div class="col-2"></div>
          </div>
          <div class="row">
            <div class="col-2">
              <q-toggle
                v-show="
                  promotionMobilePic == 1 &&
                    promotionTabletPic == 1 &&
                    promotionPCPic == 1
                "
                v-model="promotionOn"
                color="green"
                size="xl"
                checked-icon="check"
                unchecked-icon="clear"
                style="margin-top:-40px;"
              /><q-toggle
                v-show="
                  promotionMobilePic == null ||
                    promotionTabletPic == null ||
                    promotionPCPic == null
                "
                v-model="promotionOn"
                color="green"
                size="xl"
                disable
                checked-icon="check"
                unchecked-icon="clear"
                style="margin-top:-40px;"
              />
            </div>
            <div class="col" align="center">
              {{ promotionMovieNameThai }}
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
              <div>


                <q-file
                  v-model="posterMobileFile"
                  dense
                  style="width:200px;overflow:hidden;border:2px solid black;border-radius:5px;"
                  borderless
                  accept=".jpg"
                  class="bg-white q-mt-lg"
                  @input="uploadFilePosterMobile()"
                >
                  <template v-slot:prepend>
                    <div class="absolute-center fit" align="center">
                      <span class="text-black" style="font-size:12px;"
                        >upload poster file</span
                      >
                    </div>
                  </template>

                  <template v-slot:file></template>
                </q-file>
              </div>
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
      </q-dialog> -->
      <!-- movie preview  -->
      <!-- <q-dialog v-model="previewMovieBtn" persistent>
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
      </q-dialog> -->
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
              />
            </div>
          </div>
          <div class="q-mt-md">
            <div class="brx" style="width:920px;height:443px;margin:auto;">
              trailer code :
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- bg drop  -->
      <div
        class="bgDrop fullscreen"
        v-show="
          dialogAddMovie ||
            dialogEditMovie ||
            promotionMovie ||
            previewMovieBtn ||
            previewtrailerBtn
        "
      ></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      searchMovie: "",
      movieCat: 0, //ประเภทหนังที่ filter
      movieCatOpt: [], //รายชื่อประเภทของหนัง
      movieCatOptWithoutAll: [], //รายชื่อประเภทของหนังที่ไม่รวมทั้งหมด
      movieP: 1, //หน้าปัจจุบัน
      moviePage: [], // Array ลำดับเลข 1 ถึงหน้าสุดท้าย
      data: [], //ข้อมูลที่โชว์

      mnameEng: "", // type m ตัวจำ ชือ ไว้ใช้ใน dialog
      mnameTh: "", // จำชื่อ eng
      mposter: null, // ตัว choosen ไฟล์รูป poster ในช่อง add
      // Add movie
      dialogAddMovie: false,
      dialogEditMovie: false,
      addmovie: {
        titleTh: "",
        titleEn: "",
        year: "",
        mpaRating: "G",
        durationHour: "",
        durationMin: "",
        posterFile: null,
        synopsis: "",
        movieCodeThaiSound: "",
        movieCodeThaiSub: "",
        trailerCode: "",
        category: null,
        netflix: false,
        disney: false,
        amazon: false,
        hbo: false,
        newArraival: false,
        expiredDate: ""
      },
      labelExpired: "", // คำอธิบาย label สำหรับ New arraival
      mpaOpt: ["G", "PG", "PG-13", "R", "NC-17"],
      editMovieId: "", //id ข้อมูลหนังที่ต้องการแก้ไข
      editMovie: false,
      previewMovieBtn: false,
      previewtrailerBtn: false,
      promotionMovie: false, //เปิดหน้าต่าง Promotion
      promotionMovieNameEng: "", //ชื่อหนังภาษาอังกฤษ
      promotionMovieNameThai: "", //ชื่อหนังภาษาไทย
      promotionMovieId: "", //รหัสโปรโมชั่นหนัง
      promotionOn: false,
      indexPoster: 1, //ประเภทพของรูป Promotion 1 = mobile / 2 = tablet / 3= PC
      posterM: null, //รูปภาพของ Promotion สำหรับ Mobile
      posterT: null, //รูปภาพของ Promotion สำหรับ Tablet
      posterP: null, //รูปภาพของ Promotion สำหรับ PC
      posterMobileFile: "" //
    };
  },
  methods: {
    //ปุ่มเพิ่ม Movie
    showAddMovieBtn() {
      // expired date
      let today = new Date();
      let mi = today.getTime() + 1296000000;
      let a = new Date(mi);
      this.addmovie.expiredDate =
        a.getDate() + "/" + (a.getMonth() + 1) + "/" + a.getFullYear();
      this.labelExpired =
        "New arrival (expired date " + this.addmovie.expiredDate + ")";
      this.addmovie.titleTh = "";
      this.dialogAddMovie = true;
    },
    // ปิดปุ่ม add movie
    closeAddMovieBtn() {
      this.dialogAddMovie = false;
    },
    // ปิดปุ่ม edit movie
    closeEditMovieBtn() {
      this.addmovie.titleTh = "";
      this.addmovie.titleEn = "";
      this.addmovie.year = "";
      this.addmovie.mpaRating = "";
      this.addmovie.durationHour = "";
      this.addmovie.durationMin = "";
      this.addmovie.posterFile = null;
      this.addmovie.synopsis = "";
      this.addmovie.movieCodeThaiSound = "";
      this.addmovie.movieCodeThaiSub = "";
      this.addmovie.trailerCode = "";
      this.addmovie.category = null;
      this.addmovie.netflix = false;
      this.addmovie.disney = false;
      this.addmovie.amazon = false;
      this.addmovie.hbo = false;
      this.addmovie.newArraival = false;

      this.dialogEditMovie = false;
    },
    //ปุ่ม saves หนัง ใน add movie
    async addMovieBtn() {
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
        this.addmovie.durationHour.length == 0 &&
        this.addmovie.durationMin.length == 0
      ) {
        this.redNotify("Please input duration");
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
        durationHour: this.addmovie.durationHour,
        durationMin: this.addmovie.durationMin,
        type: categoryData,
        synopsis: this.addmovie.synopsis,
        movieCodeEng: this.addmovie.movieCodeThaiSub,
        movieCodeTh: this.addmovie.movieCodeThaiSound,
        trailerCode: this.addmovie.trailerCode,
        netflix: this.addmovie.netflix ? 1 : 0,
        disney: this.addmovie.disney ? 1 : 0,
        amazon: this.addmovie.amazon ? 1 : 0,
        hbo: this.addmovie.hbo ? 1 : 0,
        new: this.addmovie.newArraival ? 1 : 0,
        expiredDate: this.addmovie.newArraival ? this.addmovie.expiredDate : 0
      };
      let url = this.serverpath + "bo_movieadddata.php";
      let res = await axios.post(url, JSON.stringify(data));
      let movieid = res.data;
      //ทำการ upload  รูปภาพ
      let formData = new FormData();
      formData.append("file", this.addmovie.posterFile);
      formData.append("id", movieid);
      url = this.serverpath + "bo_uploadmovieposter.php";
      let data2 = await axios.post(url, formData);
      //update cat ในตาราง category
      for (let catid of this.addmovie.category) {
        let data3 = {
          catid: catid
        };
        url = this.serverpath + "bo_movieaddcat.php";
        let res = await axios.post(url, JSON.stringify(data3));
      }
      this.dialogAddMovie = false;
    },
    //เปลี่ยน Category
    refreshCat() {
      this.movieP = 1;
      this.loadMovieData();
    },
    //หาจำนวนหน้าทั้งหมดและใส่หน้าใน List
    async loadpagenumber() {
      let data = {
        cat: this.movieCat
      };
      let url = this.serverpath + "bo_moviepagenumber.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.moviePage = [];
      for (let i = 1; i <= res.data; i++) {
        this.moviePage.push(i);
      }
    },
    //โหลดประเภทหนัง
    async loadcatatmovie() {
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
    },
    //แสดงข้อมูลหนังในหน้าหลัก
    async loadMovieData() {
      this.loadpagenumber();
      //โหลดข้อมูลหนัง
      this.data = [];
      let data = {
        catName: this.movieCat,
        pagedata: this.movieP
      };

      let url = this.serverpath + "bo_movieshowdata.php";
      let res = await axios.post(url, JSON.stringify(data));
      res.data.forEach(x => {
        //หาวันที่ upload ไป
        let dateUploadMovie = new Date(x.timestamp);
        let dateUploadTime = dateUploadMovie.getTime();
        let dateCurrent = new Date();
        let dateCurrentTime = dateCurrent.getTime();
        let dateDiff = dateCurrentTime - dateUploadTime;
        x.dateUpload = Math.floor(dateDiff / 1000 / 60 / 60 / 24);

        let movieType = x.type.split(",");
        movieType = movieType.map(x => {
          return x.replace("[", "").replace("]", "");
        });
        x.type = movieType;

        this.data.push(x);
      });
    },
    //เปิดหน้าแก้ไขหนัง
    editMovieBtn(item) {
      this.addmovie.titleTh = item.nameTh;
      this.addmovie.titleEn = item.nameEng;
      this.addmovie.year = item.year;
      this.addmovie.mpaRating = item.mparate;
      this.addmovie.durationHour = item.durationHour;
      this.addmovie.durationMin = item.durationMin;
      this.addmovie.posterFile = item.poster;
      this.addmovie.synopsis = item.synopsis;
      this.addmovie.movieCodeThaiSound = item.movieCodeTh;
      this.addmovie.movieCodeThaiSub = item.movieCodeEng;
      this.addmovie.trailerCode = item.trailerCode;
      this.addmovie.category = item.type;
      this.addmovie.netflix = item.netflix == 1 ? true : false;
      this.addmovie.disney = item.disney == 1 ? true : false;
      this.addmovie.amazon = item.amazon == 1 ? true : false;
      this.addmovie.hbo = item.hbo == 1 ? true : false;
      this.addmovie.newArraival = item.new == 1 ? true : false;
      this.addmovie.expiredDate = item.expireddate;
      this.editMovieId = item.id;
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

      this.dialogEditMovie = true;
    },
    //บันทึกแก้ไขหนัง
    saveEditMovieBtn() {
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
        this.addmovie.durationHour.length == 0 &&
        this.addmovie.durationMin.length == 0
      ) {
        this.redNotify("Please input duration");
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
    },
    //เปลี่ยน status online/offline ของหนัง
    async changeStatus(item, index) {
      let sta = 0;
      if (item.status == 0) sta = 1;
      else sta = 0;
      let data = {
        id: item.id,
        status: sta
      };
      let url = this.serverpath + "bo_changestatusmovie.php";
      let res = await axios.post(url, JSON.stringify(data));

      if (sta == 0) {
        this.$q.notify({
          progress: true,
          message: item.nameEng + " status change to offline",
          color: "positive",
          position: "top",
          icon: "fas fa-check"
        });
      } else {
        this.$q.notify({
          progress: true,
          message: item.nameEng + " status change to online",
          color: "positive",
          position: "top",
          icon: "fas fa-check"
        });
      }
      this.data[index].status = sta;
      //this.loadMovieData();
    },
    async uploadFilePosterMobile() {
      let formData = new FormData();
      formData.append("file", this.posterMobileFile);
      formData.append("id", this.promotionMovieId);
      const url = this.serverpath + "bo_uploadPromotionMobile.php";
      let data = await axios.post(url, formData);
    },

    clrmem() {
      this.promotionMovie = false;
      this.promotionOn = false;
      this.indexPoster = 1;
      this.editMovie = false;
      this.promotionMovie = false;
      this.previewMovieBtn = false;
      this.previewtrailerBtn = false;
      this.posterM = null;
      this.posterT = null;
      this.posterP = null;
    },

    // previewMovie(item) {
    //   this.mnameEng = item.nameEng;
    //   //      this.mnameTh=item.nameTh;
    //   this.mmovieCodeEng = item.movieCodeEng;
    //   this.mmovieCodeTh = item.movieCodeTh;
    //   this.previewMovieBtn = true;
    //   if (this.mmovieCodeTh == "") {
    //     this.indexPoster = 2;
    //   }
    // },
    previewtrailer(item) {
      this.mnameEng = item.nameEng;
      this.mtrailerCode = item.trailerCode;
      this.previewtrailerBtn = true;
    },

    promotionBTN(
      posterId,
      posterEng,
      posterThai,
      promotionMobilePic,
      promotionTabletPic,
      promotionPCPic
    ) {
      //กดปุ่ม Promotion จากหน้าหลัก ส่ง id, MovieEng, MovieThai
      this.promotionMovieNameEng = posterEng;
      this.promotionMovieNameThai = posterThai;
      this.promotionMovieId = posterId;
      promotionPCPic == 1 ? (this.posterP = 1) : (this.posterP = null);
      promotionTabletPic == 1 ? (this.posterT = 1) : (this.posterT = null);
      promotionMobilePic == 1 ? (this.posterM = 1) : (this.posterM = null);
      this.promotionMovie = true;
      // this.checkPoster(posterId);
    },
    checkPoster(posterId) {
      //     this.posterM = "http://localhost/moviedd/promotion/" + posterId + "m.jpg";
      this.posterT = "http://localhost/moviedd/promotion/" + posterId + "t.jpg";
      this.posterP = "http://localhost/moviedd/promotion/" + posterId + "p.jpg";
    }
  },

  mounted() {
    this.loadcatatmovie();
    this.loadpagenumber();
    this.loadMovieData();
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
.posterFilePos {
  position: relative;
  top: -10px;
}
</style>
