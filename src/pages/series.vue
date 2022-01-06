<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <!-- Main page -->
      <div class="boxWhite ">
        <!-- header  -->
        <div class="row items-center q-pt-lg q-pb-md font14">
          <div class="q-pl-xl">
            <q-input
              outlined
              rounded
              clearable
              clear-icon="close"
              v-model="searchMovie"
              placeholder="Search : film title"
              dense
              style="width:250px;"
              @keyup.enter="searchFunction()"
              @clear="clearSearch()"
            >
            </q-input>
          </div>
          <div style="width:90px;" class="q-px-md">
            <q-btn
              outline
              rounded
              icon="fas fa-search"
              style="font-size:12px;height:39px"
              @click="searchFunction()"
            />
          </div>
          <div class="">
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
              @input="loadseriesdata()"
            >
            </q-select>
          </div>
          <div class="">
            Page
          </div>
          <div class="q-pl-sm">
            <q-select
              color="orange-13"
              v-model="movieP"
              :options="moviePage"
              dense
              style="width:50px;font-size:16px;"
              @input="loadseriesdata()"
            >
            </q-select>
          </div>
          <!-- item -->
          <div class="col q-pl-md">
            <div class="">item in this page: {{ data.length }}</div>
            <div class="">total item: {{ totalData }}</div>
          </div>
          <div class="col-2" align="right">
            <q-btn
              outline
              rounded
              class="cursor-pointer "
              style="font-size:18px;width:160px;"
              label="Deleted series"
              no-caps
              @click="showDeletedMovie()"
            />
          </div>
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
                  <div class="q-pl-md">
                    <q-icon name="far fa-bell" size="24px">
                      <q-badge
                        v-show="item.alert != 0"
                        color="red"
                        floating
                        rounded
                      ></q-badge>
                    </q-icon>
                  </div>
                </div>
                <div class="row">
                  <div style="font-size:18px;">{{ item.nameTh }}</div>
                  <div class="q-pl-md" style="font-size:14px;color:blue">
                    <u>{{ item.dateUpload }} days | {{ item.view }} views</u>
                  </div>
                </div>
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
                  {{ item.synopsis }}{{ item.trailer }}
                </div>
                <div v-show="item.episode != null">
                  <div class="row">
                    <div v-for="(item2, index2) in item.episode" :key="index2">
                      <div class="epBox q-mt-sm">
                        SS {{ index2 + 1 }} : {{ item2 }} Ep.
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-1">
                <div class="row q-pt-md">
                  <div
                    class="btnMovie bg-primary  cursor-pointer"
                    @click="editSeriesBtn(item)"
                    align="center"
                  >
                    <q-icon class="fas fa-cog" />
                    edit
                  </div>
                </div>
                <div
                  class="btnMovie bg-primary"
                  align="center"
                  @click="gotoEpisode(item.id)"
                >
                  episode
                </div>

                <div
                  v-show="item.trailerCode.length > 0"
                  class="btnMovie bg-primary"
                  align="center"
                  @click="showTrailer(item.trailerCode, item.nameEng)"
                >
                  <q-icon class="fas fa-play" />
                  trailer
                </div>
                <!-- <div
                  v-show="item.trailerCode.length == 0"
                  class="btnMovie bg-grey"
                  align="center"
                >
                  <q-icon class="fas fa-play" />
                  trailer
                </div> -->
                <div
                  v-show="item.promotion == 1"
                  class="btnMovie bg-positive"
                  align="center"
                  @click="
                    showPromote(
                      item.id,
                      item.nameEng,
                      item.nameTh,
                      item.promotionMobilePic,
                      item.promotionTabletPic,
                      item.promotionPCPic,
                      item.promotion
                    )
                  "
                >
                  promote
                </div>
                <div
                  v-show="item.promotion == 0"
                  class="btnMovie bg-grey"
                  align="center"
                  @click="
                    showPromote(
                      item.id,
                      item.nameEng,
                      item.nameTh,
                      item.promotionMobilePic,
                      item.promotionTabletPic,
                      item.promotionPCPic,
                      item.promotion
                    )
                  "
                >
                  promote
                </div>
                <div
                  v-show="item.status == '1'"
                  class="btnMovie bg-positive"
                  align="center"
                  @click="updateStatus(0, item.id)"
                >
                  online
                </div>
                <div
                  v-show="item.status == '0'"
                  class="btnMovie bg-negative"
                  align="center"
                  @click="updateStatus(1, item.id)"
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
      <q-dialog v-model="dialogAddSeries" persistent>
        <q-card class="diaBox font14">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Add Series
          </div>
          <div class="q-pa-sm q-ml-lg q-pl-md">
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Title name(En)</div>
                <q-input
                  style="width:260px;"
                  v-model="addmovie.titleEn"
                  dense
                />
              </div>
              <div class="col row items-end">
                <div class="col-4 ">Title name(Th)</div>
                <q-input
                  style="width:260px;"
                  v-model="addmovie.titleTh"
                  dense
                />
              </div>
            </div>
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Year</div>
                <q-input style="width:160px;" v-model="addmovie.year" dense />
              </div>
              <div class="col row items-end">
                <div class="col-4">Mpa Rating</div>
                <q-select
                  color="blue"
                  v-model="addmovie.mpaRating"
                  :options="mpaOpt"
                  dense
                  style="width:80px;font-size:16px;"
                >
                </q-select>
              </div>
            </div>
            <div class="col row " style="padding-top:20px;">
              <div class="row " style="width: 400px;">
                <div style="width:140px">Poster file</div>
                <div
                  class="col posterFilePos"
                  style="position:relative;top:-10px"
                >
                  <q-file
                    v-model="addmovie.posterFile"
                    dense
                    accept=".jpg"
                    label="Pick one file"
                  >
                  </q-file>

                  <div>Image size: 225 x 300 px</div>
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
      <q-dialog v-model="dialogEditSeries" persistent>
        <q-card class="diaBox font14">
          <div class="row" align="center">
            <div class="col-1"></div>
            <div class="col q-pt-md" style="font-size:24px;">
              Edit Series
            </div>
            <div class="col-1 q-ma-sm">
              <q-btn
                dense
                rounded
                flat
                icon="fas fa-trash-alt"
                @click="deleteMainSeries()"
              />
            </div>
          </div>
          <div class="q-pa-sm q-ml-lg q-pl-md">
            <div class="row ">
              <div class="col row items-end">
                <div class="col-4">Title name(En)</div>
                <q-input
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
                <div class="col-4 ">Poster file</div>
                <div class="col " align="left">
                  <div
                    v-if="addmovie.posterFile == 1"
                    class="cursor-pointer q-pl-sm"
                    @click="deletePosterFileBtn()"
                  >
                    <u>delete poster file</u>
                  </div>
                  <div v-else style="position:relative; top:-10px">
                    <q-file
                      v-model="addmovie.posterFile"
                      dense
                      accept=".jpg"
                      label="Pick one file"
                    >
                    </q-file>
                    <div>Image size: 225 x 300 px</div>
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
      <!-- delete series alert  -->
      <q-dialog v-model="deleteSeries.dialog" persistent>
        <q-card class="alertDialog" align="center">
          <q-icon
            class="fas fa-exclamation-triangle q-pt-lg"
            style="font-size:100px;color:#FFC24C"
          />
          <div class="q-py-lg">Do you want to delete this series?</div>
          <div class="row q-pt-md">
            <div class="col"></div>
            <div
              class="ynBtn q-ma-sm"
              @click="cancelDeleteSeriesBtn()"
              align="center"
            >
              Cancel
            </div>
            <div class="col-1"></div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="OKDeleteSeriesBtn()"
              align="center"
            >
              Ok
            </div>
            <div class="col"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- trailer -->
      <q-dialog v-model="trailer.dialog" persistent>
        <q-card class="trailerBox">
          <div class="row q-pa-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;margin-top:30px;">
              {{ trailer.movieName }}
            </div>

            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="18px"
                dense
                v-close-popup
              />
            </div>
          </div>
          <div class="q-mt-md">
            <div style="width:790px;height:443px;margin:auto;">
              <iframe
                :src="trailer.movieLink"
                frameborder="0"
                scrolling="auto"
                allowfullscreen
                style="position:absolute;width:790px;height:443px;"
              ></iframe>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- promotion -->
      <q-dialog v-model="promote.dialog" persistent>
        <q-card class="promotionBox" style="font-size:24px;" align="center">
          <!-- Line 1 Header , close btn, Eng name -->
          <div class="row q-pt-md">
            <div class="col-2">
              Promotion
            </div>
            <div class="col" align="center" style="font-size:36px;">
              {{ promote.nameEng }}
            </div>
            <div class="col-2 q-pr-md" align="right">
              <q-icon
                name="far fa-times-circle"
                @click="closePromote()"
                size="36px"
                class="cursor-pointer"
              />
            </div>
          </div>
          <!-- toggle promote, Thai name -->
          <div class="row">
            <div class="col-2">
              <q-toggle
                v-model="promote.active"
                color="green"
                size="xl"
                checked-icon="check"
                unchecked-icon="clear"
                style="margin-top:-40px;"
                :disable="
                  promote.posterMobile == null ||
                    promote.posterTablet == null ||
                    promote.posterPC == null
                "
                @input="setPromote()"
              />
            </div>
            <div class="col" align="center">
              {{ promote.nameThai }}
            </div>
            <div class="col-2"></div>
          </div>
          <!-- Device selector -->
          <div class="row items-center" aling="center" style="font-size:14px;">
            <div class="col" align="center">
              <div class="q-pl-xl">
                Turn on promotion must input 3 size posters.
              </div>
              <div class="row justify-evenly">
                <div class="col-1"></div>
                <div class="col-2 row">
                  <div
                    class="checkTypePoster"
                    v-show="promote.posterMobile == null"
                  ></div>
                  <div
                    class="checkTypePoster"
                    v-show="promote.posterMobile != null"
                    style="background-color:#00A642;"
                  ></div>
                  <div class="q-pl-sm">Mobile</div>
                </div>
                <div class="col-2 row">
                  <div
                    class="checkTypePoster"
                    v-show="promote.posterTablet == null"
                  ></div>
                  <div
                    class="checkTypePoster"
                    v-show="promote.posterTablet != null"
                    style="background-color:#00A642;"
                  ></div>
                  <div class="q-pl-sm">Tablet</div>
                </div>
                <div class="col-2 row">
                  <div
                    class="checkTypePoster"
                    v-show="promote.posterPC == null"
                  ></div>
                  <div
                    class="checkTypePoster"
                    v-show="promote.posterPC != null"
                    style="background-color:#00A642;"
                  ></div>
                  <div class="q-pl-sm">PC</div>
                </div>
              </div>
            </div>

            <div
              v-show="promote.posterShow == 1"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="promote.posterShow = 1"
              style="background:#ffc24c;"
            >
              Mobile
            </div>
            <div
              v-show="promote.posterShow != 1"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="promote.posterShow = 1"
            >
              Mobile
            </div>
            <div
              v-show="promote.posterShow == 2"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="promote.posterShow = 2"
              style="background:#ffc24c;"
            >
              Tablet
            </div>
            <div
              v-show="promote.posterShow != 2"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="promote.posterShow = 2"
            >
              Tablet
            </div>
            <div
              v-show="promote.posterShow == 3"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="promote.posterShow = 3"
              style="background:#ffc24c;"
            >
              PC
            </div>
            <div
              v-show="promote.posterShow != 3"
              class="picPosterBTN q-ma-md cursor-pointer"
              @click="promote.posterShow = 3"
            >
              PC
            </div>
            <div class="col"></div>
          </div>
          <!-- Preview pane -->
          <div class="">
            <div
              v-show="promote.posterShow == 1 && promote.posterMobile == null"
              class="q-pa-md col"
              style="width:360px;height:445px;border-style:dashed;margin-top:40px;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:120px;">
                jpg - 360x445 px
              </div>
              <div>
                <q-file
                  v-model="promote.fileMobile"
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
              v-show="promote.posterShow == 1 && promote.posterMobile != null"
              class=" col"
              style="margin-top:40px;"
              align="center"
            >
              <img :src="promote.posterMobile" alt="" style="width:360px" />
              <div @click="deletePosterMobile()" class="cursor-pointer">
                <u>delete poster</u>
              </div>
            </div>
            <div
              v-show="promote.posterShow == 2 && promote.posterTablet == null"
              class="q-pa-md col"
              style="width:770px;height:430px;border-style:dashed;margin-top:60px;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:120px;">
                jpg - 770x430 px
              </div>
              <q-file
                v-model="promote.fileTablet"
                dense
                style="width:200px;overflow:hidden;border:2px solid black;border-radius:5px;"
                borderless
                accept=".jpg"
                class="bg-white q-mt-lg"
                @input="uploadFilePosterTablet()"
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
            <div
              v-show="promote.posterShow == 2 && promote.posterTablet != null"
              class="col"
              style="margin-top:60px;"
              align="center"
            >
              <img :src="promote.posterTablet" alt="" style="width:770px;" />
              <div @click="deletePosterTablet()" class="cursor-pointer">
                <u>delete poster</u>
              </div>
            </div>
            <div
              v-show="promote.posterShow == 3 && promote.posterPC == null"
              class="q-pa-md col"
              style="width:1200px;height:670px;border-style:dashed;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:180px;">
                jpg - 1200x670 px
              </div>
              <q-file
                v-model="promote.filePC"
                dense
                style="width:200px;overflow:hidden;border:2px solid black;border-radius:5px;"
                borderless
                accept=".jpg"
                class="bg-white q-mt-lg"
                @input="uploadFilePosterPC()"
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
            <div
              v-show="promote.posterShow == 3 && promote.posterPC != null"
              class="col"
              style=""
              align="center"
            >
              <img :src="promote.posterPC" alt="" style="width:1200px;" />
              <div @click="deletePosterPC()" class="cursor-pointer">
                <u>delete poster</u>
              </div>
            </div>
            <div class="col"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- deleted series list -->
      <q-dialog v-model="deleteList.dialog" persistent>
        <q-card class="deletedListBox q-pa-md">
          <div class="row">
            <div class="col-1"></div>
            <div class="col font24" align="center">Deleted Series</div>
            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="18px"
                dense
                @click="deleteList.dialog = false"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-4 q-px-lg">
              <q-select
                v-model="deleteList.monthSelected"
                :options="deleteList.monthOption"
                emit-value
                map-options
                label="month"
                @input="loadDeletedData()"
              />
            </div>
            <div class="col-4 q-px-lg">
              <q-select
                v-model="deleteList.yearSelected"
                :options="deleteList.yearOption"
                label="year"
                @input="loadDeletedData()"
              />
            </div>
            <div class="col-4 q-px-md">
              <q-select
                v-model="deleteList.typeSelected"
                :options="deleteList.typeOption"
                label="type"
                @input="loadDeletedData()"
              />
            </div>
          </div>
          <div class="contentDelDiv">
            <div class="row font18 q-pt-md">
              <div class="" style="width:140px" align="center">Code</div>
              <div class="col" align="center">Title</div>
              <div class="" style="width:120px" align="center">Type</div>
              <div class="" style="width:120px" align="center">
                JW deleted
              </div>
            </div>
            <div
              v-for="(item, index) in deleteList.deletedListShow"
              :key="index"
              class="row font14 q-pt-md"
              :style="index % 2 == 0 ? 'background-color:#cedff2' : ''"
            >
              <div class="" style="width:140px" align="center">
                {{ item.movieCode }}
              </div>
              <div class="col" align="left">
                {{ item.seriesName }} : {{ item.seasonName }} :
                {{ item.episodeName }}
              </div>
              <div class="" style="width:120px" align="center">
                {{
                  item.type == 1
                    ? "Thai sound"
                    : item.type == 2
                    ? "Thai sub"
                    : "Trailer"
                }}
              </div>
              <div
                class=" q-pt-xs"
                align="center"
                style="width:120px"
                v-show="item.status == 0"
              >
                <span
                  @click="updateDeletedMovie(1, item.id)"
                  class="cursor-pointer"
                  ><img src="../../public/images/block.svg" alt=""
                /></span>
              </div>
              <div
                class="  q-pt-xs"
                align="center"
                style="width:120px"
                v-show="item.status == 1"
              >
                <span
                  @click="updateDeletedMovie(0, item.id)"
                  class="cursor-pointer"
                >
                  <img src="../../public/images/blockwithcheck.svg" alt=""
                /></span>
              </div>
            </div>
          </div> </q-card
      ></q-dialog>
      <!-- bg drop  -->
      <div
        class="bgDrop fullscreen"
        v-show="dialogAddSeries || trailer.dialog"
      ></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      //หน้าหลัก
      totalData: 0, //จำนวน series ทั้งหมด
      searchMovie: "",
      movieCat: 0, //ประเภทหนังที่ filter
      movieCatOpt: [], //รายชื่อประเภทของหนัง
      movieCatOptWithoutAll: [], //รายชื่อประเภทของหนังที่ไม่รวมทั้งหมด
      movieP: 1, //หน้าปัจจุบันของข้อมูล
      moviePage: [], //หน้าทั้งหมดที่มี
      data: [], //ข้อมูลหนังทั้งหมด
      //เพิ่มและแก้ไขหนังซีรีย์
      labelExpired: "", // คำอธิบาย label สำหรับ New arraival
      mpaOpt: ["G", "PG", "PG-13", "R", "NC-17"], //ประเภทหนัง
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
      }, //input สำหรับ เพิ่มและแก้ไขหนังซีรีย์
      editMovieId: "", //รหัสหน้งที่ทำการแก้ไข
      dialogAddSeries: false,
      dialogEditSeries: false,
      //trailer
      trailer: {
        movieCode: "", //รหัส trailer
        movieName: "", //ชื่อหนัง
        dialog: false, //เปิดหน้าต่าง trailer
        movieLink: "" //หนังที่เข้ารหัสแล้ว
      },

      //Promotion
      promote: {
        dialog: false, //เปิดปิดหน้าต่าง Dialog
        nameEng: "", //ชื่อหนังภาษาอังกฤษ
        nameThai: "", //ชื่อหนังภาษาไทย
        movieId: "", //รหัสหน้งที่ทำการ promote
        posterPC: "", //ภาพ poster ของ PC
        posterTablet: "", //ภาพ poster ของ Tablet
        posterMobile: "", //ภาพ poster ของ Mobile
        active: false, //เปิดปิดการใช้งาน Promote
        posterShow: 1, //แสดงประเภทที่แสดงหน้าง Poster 1=Mobile,2=tablet,3=PC
        fileMobile: [], //ไฟล์ของ mobile
        fileTablet: [], //ไฟล์ของ tablet
        filePC: [] //ไฟล์ของ PC
      },
      //Delete Series
      deleteSeries: {
        dialog: false // เปิดหน้าต่าง Dialog
      },
      deleteList: {
        dialog: false,
        monthOption: [
          { value: 1, label: "Jan" },
          { value: 2, label: "Feb" },
          { value: 3, label: "Mar" },
          { value: 4, label: "Apr" },
          { value: 5, label: "May" },
          { value: 6, label: "Jun" },
          { value: 7, label: "Jul" },
          { value: 8, label: "Aug" },
          { value: 9, label: "Sep" },
          { value: 10, label: "Oct" },
          { value: 11, label: "Nov" },
          { value: 12, label: "Dec" }
        ], //ข้อมูลเดือนสำหรับ Deleted movie
        yearOption: [
          2021,
          2022,
          2023,
          2024,
          2025,
          2026,
          2027,
          2028,
          2029,
          2030
        ], //ข้อมูลปีสำหรับ Deleted movie
        typeOption: ["All movie", "Deleted movie", "Undeleted movie"], //ประเภทสำหรับ Deleted movie
        monthSelected: "", //เดือนที่ถูกเลือกใน deleted movie
        yearSelected: "", //ปีที่ถูกเลือกใน deleted movie
        typeSelected: "All movie", //ประเภทที่ถูกเลือกใน deleted movie
        deletedListRaw: [], //List ของ Deleted movie
        deletedListShow: [] //List ของ Deleted movie ที่แสดง
      }
    };
  },
  methods: {
    //******Lib กลาง *****
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
    //*********ลบ Series *********/
    //ปุ่ม Cancel
    cancelDeleteSeriesBtn() {
      this.deleteSeries.dialog = false;
    },
    async OKDeleteSeriesBtn() {
      let dataSend = {
        id: this.editMovieId
      };
      let url = this.serverpath + "bo_deletemainseries.php";
      let res = await axios.post(url, JSON.stringify(dataSend));
      this.deleteSeries.dialog = false;
      this.dialogEditSeries = false;
      this.loadseriesdata();
      this.greenNotify("Delete complete");
    },
    //******หน้าหลัก******
    //เปลี่ยนค่า online / offline
    async updateStatus(status, seriesid) {
      let temp = {
        status: Number(status),
        id: seriesid
      };
      let url = this.serverpath + "bo_seriesmainonline.php";
      let res = await axios.post(url, JSON.stringify(temp));
      this.loadseriesdata();
    },

    //ปุ่มเพิ่ม Series
    addSeriesBtn() {
      let today = new Date();
      let mi = today.getTime() + 1296000000;
      let a = new Date(mi);
      this.addmovie.expiredDate =
        a.getDate() + "/" + (a.getMonth() + 1) + "/" + a.getFullYear();
      this.labelExpired =
        "New arrival (expireed date " + this.addmovie.expiredDate + ")";
      this.clraddmovie();
      this.dialogAddSeries = true;
    },
    //ปุ่มแก้ไข Series
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
      let url2 = this.serverpath + "bo_seriestotal.php";
      let res2 = await axios.post(url2, JSON.stringify(data));
      this.totalData = res2.data;
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
    //ปุ่ม Episode
    gotoEpisode(id) {
      this.$router.push("episode/" + id);
    },
    //แสดงรูปภาพหนัง
    urlPoster(id) {
      return (
        this.serverpath +
        "poster/series/" +
        id +
        ".jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100)
      );
    },
    // กด search หนัง
    async searchMovieData() {
      this.moviePage = [];
      this.moviePage.push(1);
      this.movieP = 1;

      //โหลดข้อมูลหนัง
      this.data = [];
      let data = {
        catid: this.movieCat,
        searchtext: this.searchMovie
      };

      let url = this.serverpath + "bo_series_search.php";
      let res = await axios.post(url, JSON.stringify(data));

      res.data.forEach(x => {
        //หาวันที่ upload ไป

        let dateCurrent = new Date();
        let dateCurrentTime = dateCurrent.getTime();
        let dateDiff = dateCurrentTime - x.timestamp;
        x.dateUpload = Math.floor(dateDiff / 1000 / 60 / 60 / 24);

        let movieType = x.type.split(",");
        movieType = movieType.map(x => {
          return x.replace("[", "").replace("]", "");
        });
        x.type = movieType;

        this.data.push(x);
      });
    },
    // ดูรูปแบบของ search
    searchFunction() {
      if (this.searchMovie.length == 0) {
        this.loadseriesdata();
      } else {
        this.searchMovieData();
      }
    },
    // กด clear search
    clearSearch() {
      this.loadseriesdata();
    },
    //******เพิ่มข้อมูล******

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

      this.greenNotify("Add new series completely");
      this.dialogAddSeries = false;
      this.loadseriesdata();
    },
    //ปิดหน้าต่างเพิ่ม Series
    closeAddSeriesBtn() {
      this.clraddmovie();
      this.dialogAddSeries = false;
    },

    //******แก้ไขข้อมูล******
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
    //ปิดหน้าต่างแก้ไข Series
    closeEditSeriesBtn() {
      this.clraddmovie();
      this.dialogEditSeries = false;
    },
    //ปุ่มลบในหน้า edit
    deleteMainSeries() {
      this.deleteSeries.dialog = true;
    },
    //ลบ poster ใน edit mode
    async deletePosterFileBtn() {
      let data = {
        id: this.editMovieId
      };

      let url = this.serverpath + "bo_deleteposterseriesfile.php";
      let res = await axios.post(url, JSON.stringify(data));

      this.addmovie.posterFile = 0;
      this.greenNotify("deleted poster complete");
    },

    //******trailer******
    //กดเปิด trailer หน้าหลัก
    async showTrailer(id, movieName) {
      this.trailer.movieCode = id;
      this.trailer.movieName = movieName;
      let data = {
        movieCode: this.trailer.movieCode
      };
      let url = this.serverpath + "bo_encodemovie.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.trailer.movieLink = res.data;
      this.trailer.dialog = true;
    },
    //******Promotion******
    //ปิดหน้าต่างโปรโมชั่น
    showPromote(
      posterId,
      posterEng,
      posterThai,
      promotionMobilePic,
      promotionTabletPic,
      promotionPCPic,
      promotion
    ) {
      this.promote.nameEng = posterEng;
      this.promote.nameThai = posterThai;
      this.promote.movieId = posterId;
      this.promote.active = promotion == 1 ? true : false;
      promotionPCPic == 1
        ? (this.promote.posterPC =
            this.serverpath +
            "/promotion/series/" +
            this.promote.movieId +
            "p.jpg?" +
            Math.floor(Math.random() * (999 - 100 + 1) + 100))
        : (this.promote.posterPC = null);
      promotionTabletPic == 1
        ? (this.promote.posterTablet =
            this.serverpath +
            "/promotion/series/" +
            this.promote.movieId +
            "t.jpg?" +
            Math.floor(Math.random() * (999 - 100 + 1) + 100))
        : (this.promote.posterTablet = null);
      promotionMobilePic == 1
        ? (this.promote.posterMobile =
            this.serverpath +
            "/promotion/series/" +
            this.promote.movieId +
            "m.jpg?" +
            Math.floor(Math.random() * (999 - 100 + 1) + 100))
        : (this.promote.posterMobile = null);
      this.promote.dialog = true;
    },
    //ปิดหน้าต่าง Promote
    closePromote() {
      this.promote.dialog = false;
      this.loadseriesdata();
    },
    //เปิดปิดหน้าต่าง Promote
    async setPromote() {
      let temp = {
        movieid: Number(this.promote.movieId),
        value: this.promote.active ? 1 : 0
      };
      const url = this.serverpath + "bo_updatePromotionSeries.php";
      let res = await axios.post(url, temp);
    },

    //upload mobile file
    async uploadFilePosterMobile() {
      let formData = new FormData();
      formData.append("file", this.promote.fileMobile);
      formData.append("id", this.promote.movieId);
      const url = this.serverpath + "bo_uploadPromotionMobileSeries.php";
      let data = await axios.post(url, formData);
      this.promote.posterMobile =
        this.serverpath +
        "/promotion/series/" +
        this.promote.movieId +
        "m.jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100);
    },
    //ลบ mobile file
    async deletePosterMobile() {
      let data = {
        id: this.promote.movieId,
        type: "m"
      };
      const url = this.serverpath + "bo_deletePromotionFileSeries.php";
      let res = await axios.post(url, data);
      this.greenNotify("Delete completely");
      this.promote.posterMobile = null;
      this.promote.active = false;
      this.setPromote();
    },
    //upload tabltet file
    async uploadFilePosterTablet() {
      let formData = new FormData();
      formData.append("file", this.promote.fileTablet);
      formData.append("id", this.promote.movieId);
      const url = this.serverpath + "bo_uploadPromotionTabletSeries.php";
      let data = await axios.post(url, formData);
      this.promote.posterTablet =
        this.serverpath +
        "/promotion/series/" +
        this.promote.movieId +
        "t.jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100);
    },
    //ลบ tabltet file
    async deletePosterTablet() {
      let data = {
        id: this.promote.movieId,
        type: "t"
      };
      const url = this.serverpath + "bo_deletePromotionFileSeries.php";
      let res = await axios.post(url, data);
      this.greenNotify("Delete completely");
      this.promote.posterTablet = null;
      this.promote.active = false;
      this.setPromote();
    },
    //upload PC file
    async uploadFilePosterPC() {
      let formData = new FormData();
      formData.append("file", this.promote.filePC);
      formData.append("id", this.promote.movieId);
      const url = this.serverpath + "bo_uploadPromotionPCSeries.php";
      let data = await axios.post(url, formData);
      this.promote.posterPC =
        this.serverpath +
        "/promotion/series/" +
        this.promote.movieId +
        "p.jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100);
    },
    // ลบ PC file
    async deletePosterPC() {
      let data = {
        id: this.promote.movieId,
        type: "p"
      };
      const url = this.serverpath + "bo_deletePromotionFileSeries.php";
      let res = await axios.post(url, data);
      this.greenNotify("Delete completely");
      this.promote.posterPC = null;
      this.promote.active = false;
      this.setPromote();
    },
    //********* deleted list series  ********/
    // show deleted list
    showDeletedMovie() {
      let today = new Date();
      this.deleteList.yearSelected = today.getFullYear();
      this.deleteList.monthSelected = Number(today.getMonth()) + 1;
      this.loadDeletedData();
      this.deleteList.dialog = true;
    },
    // load ข้อมูล deleted data
    async loadDeletedData() {
      this.deleteList.deletedListRaw = [];
      let data = {
        month: this.deleteList.monthSelected,
        year: this.deleteList.yearSelected
      };
      let url = this.serverpath + "bo_seriesdeleted.php";
      let res = await axios.post(url, JSON.stringify(data));
      console.log(res.data);
      this.deleteList.deletedListRaw = res.data;
      this.filterDeletedMovie();
    },
    // filter Type of Deleted Movie
    filterDeletedMovie() {
      if (this.deleteList.typeSelected == "Deleted movie") {
        this.deleteList.deletedListShow = this.deleteList.deletedListRaw.filter(
          x => x.status == 1
        );
      } else if (this.deleteList.typeSelected == "All movie") {
        this.deleteList.deletedListShow = this.deleteList.deletedListRaw;
      } else {
        this.deleteList.deletedListShow = this.deleteList.deletedListRaw.filter(
          x => x.status == 0
        );
      }
    }
  },
  mounted() {
    this.loadcatatmovie();
    this.loadpagenumber();
    this.loadseriesdata();
    this.checkMenuAccess(3);
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
.promotionBox {
  max-width: 1400px;
  width: 1315px;
  height: 950px;
  border-radius: 30px;
  background-color: #edf2fe;
}
.trailerBox {
  max-width: 1000px;
  width: 975px;
  height: 600px;
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
.checkTypePoster {
  width: 21px;
  height: 21px;
  border-radius: 5px;
  background: #e83939;
}
.alertDialog {
  border-radius: 30px;
  width: 455px;
  height: 288px;
}
.deletedListBox {
  background: #edf2fe;
  max-width: 1000px;
  width: 830px;
  height: 500px;
  border-radius: 30px;
}
.contentDelDiv {
  height: 350px;
  overflow-y: auto;
}
</style>
