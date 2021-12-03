<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <!-- header  -->
        <div class="row items-center q-pt-lg">
          <div class="col-4 q-pl-xl">
            <q-input
              outlined
              rounded
              clearable
              clear-icon="close"
              v-model="searchMovie"
              placeholder="Search : film title"
              dense
              style="width:350px;"
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
          <div class="col-2" align="right">
            <q-btn
              outline
              rounded
              class="cursor-pointer "
              style="font-size:18px;width:160px;"
              label="Deleted movie"
              no-caps
              @click="showDeletedMovie()"
            />
          </div>
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
        <div class="contextdiv">
          <!-- movie box  -->

          <div v-for="(item, index) in data" :key="index">
            <div class="boxdiv row">
              <div v-show="item.new == 1" class="newarrivaldiv">
                <img
                  src="../../public/images/new.svg"
                  style="width:88px; height:75px"
                  alt=""
                />
              </div>
              <div class=" q-ma-md q-mt-lg pospic" v-if="item.poster == 1">
                <img
                  class="picMovie shadow-2"
                  :src="serverpath + 'poster/movie/' + item.id + '.jpg'"
                />
              </div>
              <div class="q-ma-md q-mt-lg pospic" v-if="item.poster == 0">
                <img
                  class="picMovie shadow-2"
                  :src="serverpath + 'poster/movie/nophoto.jpg'"
                />
              </div>
              <div class="col q-pt-md contentdiv">
                <div class="row" style="line-height:30px;">
                  <div class="font24">
                    {{ item.nameEng }}
                  </div>
                  <div
                    v-show="
                      item.movieCodeTh != '' && item.alertThaiSound == '0'
                    "
                    class="testMovie q-ml-md"
                    align="center"
                  >
                    TH Sound
                    <img
                      src="../../public/images/bell.svg"
                      style="height:15px;"
                      alt=""
                    />
                  </div>
                  <div
                    v-show="
                      item.movieCodeTh != '' && item.alertThaiSound != '0'
                    "
                    class="testMovie q-ml-md cursor-pointer"
                    align="center"
                    @click="alertThSound(item.id, item.nameEng)"
                  >
                    TH Sound
                    <img
                      src="../../public/images/bellwithreddot.svg"
                      style="height:17px;"
                      alt=""
                    />
                  </div>
                  <div
                    v-show="item.movieCodeEng != '' && item.alertThaiSub == '0'"
                    class="testMovie q-ml-md "
                    align="center"
                  >
                    TH Sub
                    <img
                      src="../../public/images/bell.svg"
                      style="height:15px;"
                      alt=""
                    />
                  </div>
                  <div
                    v-show="item.movieCodeEng != '' && item.alertThaiSub != '0'"
                    class="testMovie q-ml-md cursor-pointer"
                    align="center"
                    @click="alertEngSound(item.id, item.nameEng)"
                  >
                    TH Sub
                    <img
                      src="../../public/images/bellwithreddot.svg"
                      style="height:17px;"
                      alt=""
                    />
                  </div>
                </div>
                <div class="row">
                  <div class="q-pr-md" v-show="item.nameTh">
                    {{ item.nameTh }}
                  </div>
                  <div
                    style="font-size:14px;color:#2F7EF5"
                    class="cursor-pointer"
                    @click="showChart(item)"
                  >
                    <u>{{ item.dateUpload }} days | {{ item.view }} views</u>
                  </div>
                </div>

                <div class="row q-py-sm" style="font-size:14px;">
                  <div class="col-1">{{ item.year }}</div>
                  <div class="col-1">{{ item.mparate }}</div>
                  <div class="col-2">
                    {{ item.durationHour }} ชั่วโมง {{ item.durationMin }} นาที
                  </div>
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
              </div>
              <div class="col-1 btndiv">
                <div class="row q-pt-md">
                  <div
                    class="btnMovie bg-primary"
                    align="center"
                    @click="editMovieBtn(item)"
                  >
                    <q-icon class="fas fa-cog" />
                    edit
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
                  v-show="item.promotion == 1"
                  class="btnMovie bg-positive"
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
                  promote
                </div>
                <div
                  v-show="item.promotion == 0"
                  class="btnMovie bggrey"
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
                  promote
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
            <div class="tempdiv"></div>

            <div style="height:15px;"></div>
          </div>
          <!-- end moviebox  -->
        </div>
      </div>
      <!------------------ dialog  ---------------->
      <!-- add movie box  -->
      <q-dialog v-model="dialogAddMovie" persistent>
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
                counter
                hint="Max 300 characters"
                class="synBox"
                borderless
                type="textarea"
                style="max-height:450px;"
                v-model="addmovie.synopsis"
                dense
                error-message="Please use maximum 300 characters"
                :error="!isValid"
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
                OK
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- edit movie box -->
      <q-dialog v-model="dialogEditMovie" persistent>
        <q-card class="diaBox">
          <div class="row q-pt-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;">
              Edit movie
            </div>
            <div class="col-1">
              <q-icon
                class="fas fa-trash-alt cursor-pointer"
                size="sm"
                @click="deleteMovieAlert = true"
              />
            </div>
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
                counter
                hint="Max 300 characters"
                class="synBox"
                borderless
                type="textarea"
                style="max-height:450px;"
                v-model="addmovie.synopsis"
                dense
                error-message="Please use maximum 300 characters"
                :error="!isValid"
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
      <!-- delete movie alert  -->
      <q-dialog v-model="deleteMovieAlert" persistent>
        <q-card class="alertDialog" align="center">
          <q-icon
            class="fas fa-exclamation-triangle q-pt-lg"
            style="font-size:100px;color:#FFC24C"
          />
          <div class="q-py-lg">Do you want to delete this movie?</div>
          <div class="row q-pt-md">
            <div class="col"></div>
            <div class="ynBtn q-ma-sm" @click="closeAlertBtn()" align="center">
              Cancel
            </div>
            <div class="col-1"></div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="delMovieBtn()"
              align="center"
            >
              Ok
            </div>
            <div class="col"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- promotion -->
      <q-dialog v-model="dialogPromotion" persistent>
        <q-card class="promotionBox" style="font-size:24px;" align="center">
          <div class="row q-pt-md">
            <div class="col-2">
              Promote
            </div>
            <div class="col" align="center" style="font-size:36px;">
              {{ promotionMovieNameEng }}
            </div>
            <div class="col-2" align="right">
              <q-btn
                class="q-pr-md"
                icon="far fa-times-circle"
                flat
                round
                size="18px"
                dense
                @click="closePromotion()"
              />
            </div>
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
                :disable="posterM == null || posterP == null || posterT == null"
                @input="setPromotion()"
              />
            </div>
            <div class="col" align="center">
              {{ promotionMovieNameThai }}
            </div>
            <div class="col-2"></div>
          </div>
          <div class="row items-center" aling="center" style="font-size:14px;">
            <div class="col" align="center">
              <div>Turn on promotion must input 3 size poster</div>
              <div class="row justify-evenly">
                <div class="col-2"></div>
                <div class="col-3 row">
                  <div class="checkTypePoster" v-show="posterM == null"></div>
                  <div
                    class="checkTypePoster"
                    v-show="posterM != null"
                    style="background-color:#00A642;"
                  ></div>
                  <div class="q-pl-sm">Mobile</div>
                </div>
                <div class="col-3 row">
                  <div class="checkTypePoster" v-show="posterT == null"></div>
                  <div
                    class="checkTypePoster"
                    v-show="posterT != null"
                    style="background-color:#00A642;"
                  ></div>
                  <div class="q-pl-sm">Tablet</div>
                </div>
                <div class="col-3 row">
                  <div class="checkTypePoster" v-show="posterP == null"></div>
                  <div
                    class="checkTypePoster"
                    v-show="posterP != null"
                    style="background-color:#00A642;"
                  ></div>
                  <div class="q-pl-sm">PC</div>
                </div>
              </div>
            </div>
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
              style="width:360px;height:445px;border-style:dashed;margin-top:40px;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:120px;">
                jpg - 360x445 px
              </div>
              <div>
                <q-file
                  v-model="promotionMobileFile"
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
              class=" col"
              style="margin-top:40px;"
              align="center"
            >
              <img :src="posterM" alt="" style="width:360px" />
              <div @click="deletePosterMobile()" class="cursor-pointer">
                <u>delete poster</u>
              </div>
            </div>
            <div
              v-show="indexPoster == 2 && posterT == null"
              class="q-pa-md col"
              style="width:770px;height:430px;border-style:dashed;margin-top:60px;"
              align="center"
            >
              <div class="q-py-xl col" style="padding-top:120px;">
                jpg - 770x430 px
              </div>
              <q-file
                v-model="promotionTabletFile"
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
              v-show="indexPoster == 2 && posterT != null"
              class="col"
              style="margin-top:60px;"
              align="center"
            >
              <img :src="posterT" alt="" style="width:770px;" />
              <div @click="deletePosterTablet()" class="cursor-pointer">
                <u>delete poster</u>
              </div>
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
              <q-file
                v-model="promotionPCFile"
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
              v-show="indexPoster == 3 && posterP != null"
              class="col"
              style=""
              align="center"
            >
              <img :src="posterP" alt="" style="width:1200px;" />
              <div @click="deletePosterPC()" class="cursor-pointer">
                <u>delete poster</u>
              </div>
            </div>
            <div class="col"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- movie preview  -->
      <q-dialog v-model="dialogPreview" persistent>
        <q-card class="preview">
          <div class="row q-pa-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;margin-top:30px;">
              {{ previewTitleEn }}
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

          <div class="row" align="center">
            <div class="col"></div>
            <div
              class="noMovieCode q-mx-lg"
              v-show="previewMovieThaiSoundCode == ''"
            >
              TH sound
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="previewMovieThaiSoundCode != '' && indexPoster == 1"
              style="background-color:#ffc24c"
            >
              TH sound
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="previewMovieThaiSoundCode != '' && indexPoster != 1"
              @click="indexPoster = 1"
            >
              TH sound
            </div>
            <div
              class="noMovieCode q-mx-lg"
              v-show="previewMovieThaiSubCode == ''"
            >
              TH sub
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="previewMovieThaiSubCode != '' && indexPoster == 2"
              style="background-color:#ffc24c"
            >
              TH sub
            </div>
            <div
              class="picPosterBTN cursor-pointer q-mx-lg"
              v-show="previewMovieThaiSubCode != '' && indexPoster != 2"
              @click="indexPoster = 2"
            >
              TH sub
            </div>
            <div class="col"></div>
          </div>
          <div class="q-mt-md">
            <div
              style="width:790px;height:443px;margin:auto;"
              v-show="indexPoster == 1"
            >
              <iframe
                :src="previewThaiSoundLink"
                frameborder="0"
                scrolling="auto"
                allowfullscreen
                style="position:absolute;width:790px;height:443px;"
              ></iframe>
            </div>
            <div
              style="width:790px;height:443px;margin:auto;"
              v-show="indexPoster == 2"
            >
              <iframe
                :src="previewThaiSubLink"
                frameborder="0"
                scrolling="auto"
                allowfullscreen
                style="position:absolute;width:790px;height:443px;"
              ></iframe>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- trailer preview  -->
      <q-dialog v-model="dialogtrailer" persistent>
        <q-card class="preview">
          <div class="row q-pa-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;margin-top:30px;">
              {{ trailerTitle }}
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
                :src="trailerLink"
                frameborder="0"
                scrolling="auto"
                allowfullscreen
                style="position:absolute;width:790px;height:443px;"
              ></iframe>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Report  -->
      <q-dialog v-model="dialogReport" persistent>
        <q-card class="reportDialog">
          <div class="row q-pa-md items-center" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;">Report</div>
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
          <div class="row">
            <div class="col-1"></div>
            <div class="col">
              <div class="row items-end">
                <div class="col" style="font-size:20px;">Movie qualitiy</div>
                <div class="cursor-pointer">
                  <u>solved</u>
                </div>
              </div>
              <div
                class="row"
                v-for="(item, index) in problemList"
                :key="index"
              >
                <div class="col">{{ item.problem }}</div>
                <div class="col-3" align="right">{{ item.noproblem }} คน</div>
              </div>

              <hr />
              <div style="font-size:20px;">Other problems</div>
            </div>
            <div class="col-1"></div>
          </div>
          <q-scroll-area style="height:240px;">
            <div
              class="row"
              style="height:40px;"
              v-for="(item, index) in problemListetc"
              :key="index"
            >
              <div class="col-1"></div>
              <div
                class="col q-pl-sm"
                :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
                style="height:40px;line-height: 40px;"
              >
                {{ item.topic }}
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
      <!-- Deleted Movies -->
      <q-dialog v-model="dialogDeletedMovie" persistent>
        <q-card class="deletedDialog">
          <div class="row q-px-md q-pt-md items-center" align="center">
            <div class="col-1"></div>
            <div class="col font24">Deleted Movie</div>
            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="18px"
                dense
                @click="dialogDeletedMovie = false"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-4 q-px-lg">
              <q-select
                v-model="monthSelected"
                :options="monthOption"
                emit-value
                map-options
                label="month"
                @input="loadDeletedData()"
              />
            </div>
            <div class="col-4 q-px-lg">
              <q-select
                v-model="yearSelected"
                :options="yearOption"
                label="year"
                @input="loadDeletedData()"
              />
            </div>
            <div class="col-4 q-px-md">
              <q-select
                v-model="typeSelected"
                :options="typeOption"
                label="type"
                @input="loadDeletedData()"
              />
            </div>
          </div>
          <div class="contentDelDiv">
            <div class="row font18 q-pt-md">
              <div class="col-3" align="center">Code</div>
              <div class="col-3" align="center">Title</div>
              <div class="col-3" align="center">Type</div>
              <div class="col-3" align="center">JW deleted</div>
            </div>
            <div
              v-for="(item, index) in deletedListShow"
              :key="index"
              class="row font14"
              :style="index % 2 == 0 ? 'background-color:#cedff2' : ''"
              style="height:40px; line-height:40px;"
            >
              <div class="col-3" align="center">{{ item.movieCode }}</div>
              <div class="col-3" align="center">{{ item.title }}</div>
              <div class="col-3" align="center">
                {{ item.type == 1 ? "Thai sound" : "Thai sub" }}
              </div>
              <div
                class="col-3 q-pt-xs"
                align="center"
                v-show="item.status == 0"
              >
                <span
                  @click="updateDeletedMovie(1, item.id)"
                  class="cursor-pointer"
                  ><img src="../../public/images/block.svg" alt=""
                /></span>
              </div>
              <div
                class="col-3  q-pt-xs"
                align="center"
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
          </div>
        </q-card>
      </q-dialog>
      <!-- bg drop  -->
      <div
        class="bgDrop fullscreen"
        v-show="
          dialogAddMovie ||
            dialogEditMovie ||
            dialogPromotion ||
            dialogPreview ||
            dialogtrailer ||
            dialogReport
        "
      ></div>
      <!-- Alert Problem -->
      <q-dialog v-model="dialogAlertProblem" persistent>
        <q-card class="alertProblemDialog">
          <div class="row q-pt-md">
            <div class="col-2"></div>
            <div class="col font24" align="center">
              {{ alertProblemTitle }}
            </div>
            <div class="col-2" align="right">
              <q-btn
                class="q-pr-md"
                icon="far fa-times-circle"
                flat
                round
                size="18px"
                dense
                @click="closeAlertProblemDialog()"
              />
            </div>
          </div>
          <div align="center">{{ alertProblemType }}</div>
          <div class="problemInside">
            <div class="row q-px-lg">
              <div class="col-9">Movie quality</div>
              <div class="col-3" align="center">
                <span
                  class="cursor-pointer"
                  v-show="alertQualityShow"
                  @click="solveProblemQuality()"
                >
                  <u>solved</u></span
                >
              </div>
            </div>
            <div
              v-if="!alertQualityShow"
              align="center"
              class="text-h6 q-py-md"
            >
              No qualitiy problem
            </div>
            <div v-else v-for="(item, index) in alertQualityData">
              <div class="row q-px-lg ">
                <div class="col-9">{{ item.problem }}</div>
                <div class="col-3" align="center">{{ item.nopro }}</div>
              </div>
            </div>
            <div class="q-px-md">
              <hr />
            </div>
            <div class="text-h6 q-px-md">
              Other problem
            </div>
            <div
              v-if="!alertOtherProblemShow"
              align="center"
              class="text-h6 q-py-md"
            >
              No other problem
            </div>
            <div v-else v-for="(item, index) in alertOtherProblemData">
              <div class="row q-px-lg">
                <div class="col-9">{{ item.problem }}</div>
                <div class="col-3" align="center">
                  <span
                    @click="solveOtherProblem(item.problemid)"
                    class="cursor-pointer"
                    ><u>solved</u></span
                  >
                </div>
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- comfirm Dialog Quality problem  -->
      <q-dialog v-model="confirmSolveProblem" persistent>
        <q-card class="confirmDiv">
          <div class="q-pt-lg" align="center">
            <q-icon
              name="fas fa-question-circle"
              size="80px"
              style="color:#FFC24C"
              class="q-pt-md"
            />
          </div>
          <div class="q-pt-md" align="center">
            Did you upload the new movie file?
          </div>
          <div class="row justify-center q-pt-md">
            <div>
              <div
                class="btncommon cursor-pointer"
                @click="btnAlertProblemNo()"
              >
                No
              </div>
            </div>
            <div style="width:20px;"></div>
            <div>
              <div
                class="btnyellow cursor-pointer"
                @click="btnAlertProblemQualityYes()"
              >
                Yes
              </div>
            </div>
            <div></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- comfirm Dialog Other problem  -->
      <q-dialog v-model="confirmSolveOtherProblem" persistent>
        <q-card class="confirmDiv">
          <div class="q-pt-lg" align="center">
            <q-icon
              name="fas fa-question-circle"
              size="80px"
              style="color:#FFC24C"
              class="q-pt-md"
            />
          </div>
          <div class="q-pt-md" align="center">
            Did you solved this problem?
          </div>
          <div class="row justify-center q-pt-md">
            <div>
              <div
                class="btncommon cursor-pointer"
                @click="btnAlertProblemNo()"
              >
                No
              </div>
            </div>
            <div style="width:20px;"></div>
            <div>
              <div
                class="btnyellow cursor-pointer"
                @click="btnAlertProblemOtherYes()"
              >
                Yes
              </div>
            </div>
            <div></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Chart view -->
      <div class="bgDrop fullscreen" v-show="dialogChart">
        <div class="chartdiv absolute-center">
          <div class="row q-px-md q-pt-md items-center" align="center">
            <div class="col-1"></div>
            <div class="col font24">{{ titleView }}</div>
            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="18px"
                dense
                @click="dialogChart = false"
              />
            </div>
          </div>
          <div align="center">Current week : {{ currentWeek }}</div>
          <div id="container1"></div>
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
      searchMovie: "",
      movieCat: 0, //ประเภทหนังที่ filter
      movieCatOpt: [], //รายชื่อประเภทของหนัง
      movieCatOptWithoutAll: [], //รายชื่อประเภทของหนังที่ไม่รวมทั้งหมด
      movieP: 1, //หน้าปัจจุบัน
      moviePage: [], // Array ลำดับเลข 1 ถึงหน้าสุดท้าย
      data: [], //ข้อมูลที่โชว์
      // Add movie
      dialogChart: false,
      dialogAddMovie: false,
      dialogEditMovie: false,
      deleteMovieAlert: false, //เปิดหน้าต่างยืนยันการลบ Movie
      dialogReport: false,
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
      timestamp: "",
      labelExpired: "", // คำอธิบาย label สำหรับ New arraival
      mpaOpt: ["G", "PG", "PG-13", "R", "NC-17"],
      // แก้ไขข้อมูล
      editMovieId: "", //id ข้อมูลหนังที่ต้องการแก้ไข
      // สำหรับ Preview movie
      dialogPreview: false, //เปิดหน้าต่าง preview
      previewTitleEn: "", //ชื่อภาษาอังกฤษ
      previewMovieThaiSoundCode: "", //Code สำหรับ movie thai sound
      previewMovieThaiSubCode: "", //Code สำหรับ movie thai sub
      indexPoster: 1, //1 Preview Thai sound, 2 Preview Thai sub
      previewThaiSoundLink: "", //Link สำหรับ Thaisound
      previewThaiSubLink: "", //Link สำหรับ ThaiSub

      dialogtrailer: false, // เปิดหน้าต่าง trailer
      trailerTitle: "", //ชื่อเรื่อง trailer
      trailerLink: "", //Link trailer

      dialogPromotion: false, //เปิดหน้าต่าง Promotion
      promotionMovieNameEng: "", //ชื่อหนังภาษาอังกฤษ
      promotionMovieNameThai: "", //ชื่อหนังภาษาไทย
      promotionMovieId: "", //รหัสโปรโมชั่นหนัง
      promotionMobileFile: [], //ไฟล์รูป promotion Mobile
      promotionTabletFile: [], //ไฟล์รูป promotion Tablet
      promotionPCFile: [], //ไฟล์รูป promotion PC
      promotionOn: false, //ตัวเปิดปิด Promotion
      posterM: null, //รูปภาพของ Promotion สำหรับ Mobile
      posterT: null, //รูปภาพของ Promotion สำหรับ Tablet
      posterP: null, //รูปภาพของ Promotion สำหรับ PC

      problemList: [], //List ของปัญหา
      problemListetc: [], //List ของปัญหา etc

      titleView: "", //ชื่อหนังในหน้า View
      currentWeek: "", //สัปดาห์ปัจจุบัน
      xValueView: [], //ค่าแกน x ของ View
      yValueView: [], //ค่าแกน y ของ View
      viewData: [], //ค่า view ของ movie

      dialogDeletedMovie: false, //เปิดปิดหน้าต่าง deleted movie
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
      yearOption: [2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030], //ข้อมูลปีสำหรับ Deleted movie
      typeOption: ["All movie", "Deleted movie", "Undeleted movie"], //ประเภทสำหรับ Deleted movie
      monthSelected: "", //เดือนที่ถูกเลือกใน deleted movie
      yearSelected: "", //ปีที่ถูกเลือกใน deleted movie
      typeSelected: "All movie", //ประเภทที่ถูกเลือกใน deleted movie
      deletedListRaw: [], //List ของ Deleted movie
      deletedListShow: [], //List ของ Deleted movie ที่แสดง
      //หน้าต่างแจ้งเตือน
      dialogAlertProblem: false, //หน้าต่างแสดงปัญหา
      alertProblemTitle: "", //ชื่อเรื่อง
      alertProblemType: "", //ประเภทของหนัง
      alertProblemId: "", //movie id
      alertQualityShow: false, //มีปัญหา movie quality หรือเปล่าว
      alertQualityData: [], //ปัญหา movie quality ที่มี
      alertOtherProblemShow: false, // มีปัญหา Other problem หรือเปล่าว
      alertOtherProblemData: [], //ปัญหาอื่นที่มี
      confirmSolveProblem: false, //ยืนยันQualityปัญหาว่าแก้แล้ว
      confirmSolveOtherProblem: false, //ยืนยัน Other problem
      alertProblemOtherId: "" //รหัส other problem
    };
  },
  methods: {
    //ปิดหน้า Alert Problem
    closeAlertProblemDialog() {
      this.dialogAlertProblem = false;
      this.loadMovieData();
    },
    //ตอบ Yes ในหน้า alert other problem
    async btnAlertProblemOtherYes() {
      this.confirmSolveOtherProblem = false;
      let temp = {
        movieid: Number(this.alertProblemId),
        id: Number(this.alertProblemOtherId),
        type: this.alertProblemType == "Th sound" ? 1 : 2
      };

      let url = this.serverpath + "bo_movieproblemothersolved.php";
      let res = await axios.post(url, JSON.stringify(temp));
      if (res.data == "complete") {
        this.greenNotify("Save completely");
        this.dialogAlertProblem = false;
        if (this.alertProblemType == "Th sound") {
          this.alertThSound(this.alertProblemId, this.alertProblemTitle);
        } else {
          this.alertEngSound(this.alertProblemId, this.alertProblemTitle);
        }
      } else {
        this.redNotify("There are something wrong");
      }
    },
    //ตอบ Yes ในหน้า alert Confirm Movie quality
    async btnAlertProblemQualityYes() {
      this.confirmSolveProblem = false;
      let temp = {
        id: Number(this.alertProblemId),
        type: this.alertProblemType == "Th sound" ? 1 : 2
      };
      let url = this.serverpath + "bo_movieproblemqualitysolved.php";
      let res = await axios.post(url, JSON.stringify(temp));
      if (res.data == "complete") {
        this.greenNotify("Save completely");
        this.dialogAlertProblem = false;
        if (this.alertProblemType == "Th sound") {
          this.alertThSound(this.alertProblemId, this.alertProblemTitle);
        } else {
          this.alertEngSound(this.alertProblemId, this.alertProblemTitle);
        }
      } else {
        this.redNotify("There are something wrong");
      }
    },
    //ตอบ No ในหน้า alert Confirm
    btnAlertProblemNo() {
      this.confirmSolveProblem = false;
      this.dialogAlertProblem = true;
    },
    //แก้ปัญหาอื่นๆๆ
    solveOtherProblem(id) {
      this.alertProblemOtherId = id;
      this.confirmSolveOtherProblem = true;
      this.dialogAlertProblem = false;
    },
    //แก้ปัญหาคุณภาพของ Movie
    solveProblemQuality() {
      this.dialogAlertProblem = false;
      this.confirmSolveProblem = true;
    },
    //เปิดหน้าต่าง Alert ของ Eng sound
    async alertEngSound(id, title) {
      this.alertOtherProblemData = [];
      this.alertQualityShow = false;
      this.alertOtherProblemShow = false;
      this.alertProblemId = id;
      this.alertProblemTitle = title;
      this.alertProblemType = "Th Sub";
      let temp = {
        movieid: id,
        type: 2
      };
      let url = this.serverpath + "bo_movieproblemqualitylist.php";
      let res = await axios.post(url, JSON.stringify(temp));
      if (res.data != "no problem") {
        this.alertQualityShow = true;
        this.alertQualityData = [];
        for (let i = 0; i < res.data.length; i++) {
          let temp = {
            problem: res.data[i].problem,
            nopro: res.data[i].noproblem
          };
          this.alertQualityData.push(temp);
        }
      } else {
        this.alertQualityShow = false;
      }
      let url2 = this.serverpath + "bo_moviereportproblemetc.php";
      let res2 = await axios.post(url2, JSON.stringify(temp));
      if (res2.data == "no data") {
        this.alertOtherProblemShow = false;
      } else {
        this.alertOtherProblemShow = true;
        for (let i = 0; i < res2.data.length; i++) {
          let temp = {
            problemid: res2.data[i].id,
            problem: res2.data[i].topic
          };
          this.alertOtherProblemData.push(temp);
        }
      }
      //update alert in movie table

      if (!this.alertOtherProblemShow && !this.alertQualityShow) {
        temp = {
          movieid: id,
          type: 2
        };
        let url3 = this.serverpath + "bo_moviereportproblemclear.php";
        let res3 = await axios.post(url3, JSON.stringify(temp));
      }

      this.dialogAlertProblem = true;
    },
    //เปิดหน้าต่าง Alert ของ TH sound
    async alertThSound(id, title) {
      this.alertOtherProblemData = [];
      this.alertQualityShow = false;
      this.alertOtherProblemShow = false;
      this.alertProblemId = id;
      this.alertProblemTitle = title;
      this.alertProblemType = "Th sound";
      let temp = {
        movieid: id,
        type: 1
      };
      let url = this.serverpath + "bo_movieproblemqualitylist.php";
      let res = await axios.post(url, JSON.stringify(temp));

      if (res.data != "no problem") {
        this.alertQualityShow = true;
        this.alertQualityData = [];
        for (let i = 0; i < res.data.length; i++) {
          let temp = {
            problem: res.data[i].problem,
            nopro: res.data[i].noproblem
          };
          this.alertQualityData.push(temp);
        }
      } else {
        this.alertQualityShow = false;
      }
      let url2 = this.serverpath + "bo_moviereportproblemetc.php";
      let res2 = await axios.post(url2, JSON.stringify(temp));
      if (res2.data == "no data") {
        this.alertOtherProblemShow = false;
      } else {
        this.alertOtherProblemShow = true;
        for (let i = 0; i < res2.data.length; i++) {
          let temp = {
            problemid: res2.data[i].id,
            problem: res2.data[i].topic
          };
          this.alertOtherProblemData.push(temp);
        }
      }

      //update alert in movie table

      if (!this.alertOtherProblemShow && !this.alertQualityShow) {
        temp = {
          movieid: id,
          type: 1
        };
        let url3 = this.serverpath + "bo_moviereportproblemclear.php";
        let res3 = await axios.post(url3, JSON.stringify(temp));
      }
      this.dialogAlertProblem = true;
    },
    //updated deleted movie status
    async updateDeletedMovie(value, id) {
      let data = {
        value: value,
        id: id
      };
      let url = this.serverpath + "bo_updatedeletedmovie.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.loadDeletedData();
    },
    //load ข้อมูล Deleted data
    async loadDeletedData() {
      this.deletedListRaw = [];
      let data = {
        month: this.monthSelected,
        year: this.yearSelected
      };
      let url = this.serverpath + "bo_moviedeleted.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.deletedListRaw = res.data;
      this.filterDeletedMovie();
    },
    //filter Type of Deleted Movie
    filterDeletedMovie() {
      if (this.typeSelected == "Deleted movie") {
        this.deletedListShow = this.deletedListRaw.filter(x => x.status == 1);
      } else if (this.typeSelected == "All movie") {
        this.deletedListShow = this.deletedListRaw;
      } else {
        this.deletedListShow = this.deletedListRaw.filter(x => x.status == 0);
      }
    },
    //เปิดหน้าต่าง Deleted movie
    showDeletedMovie() {
      let today = new Date();
      this.yearSelected = today.getFullYear();
      this.monthSelected = Number(today.getMonth()) + 1;
      this.loadDeletedData();
      this.dialogDeletedMovie = true;
    },
    calCurrentWeek() {
      let currentTime = new Date().getTime();
      let startTime = new Date(this.startDate).getTime();
      this.currentWeek = Math.floor(
        (currentTime - startTime) / (1000 * 60 * 60 * 24 * 7)
      );
    },
    //แสดง chart ของหนังเรื่องนั้น
    async showChart(item) {
      this.calCurrentWeek();
      this.xValueView = [];
      this.yValueView = [];
      let weekOnProcess = 0;
      if (20 >= this.currentWeek) {
        weekOnProcess = this.currentWeek - 1;
      } else {
        weekOnProcess = 20;
      }
      for (let i = 1; i <= weekOnProcess; i++) {
        let weekx = this.currentWeek - i;
        this.xValueView.push(weekx);
      }
      this.xValueView.reverse();

      let data = {
        id: item.id
      };
      let url = this.serverpath + "bo_loadmovieview.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.viewData = res.data;
      this.xValueView.forEach(x => {
        let yRawData = this.viewData.filter(y => y.week == x);

        if (yRawData.length == 0) {
          this.yValueView.push(0);
        } else {
          this.yValueView.push(Number(yRawData[0].view));
        }
      });
      let titleChart = "Movie view per week";
      Highcharts.chart("container1", {
        chart: {
          type: "line",
          width: 600,
          height: 320,
          backgroundColor: "#edf2fe"
        },
        title: {
          text: titleChart
        },
        exporting: { enabled: false },
        xAxis: {
          categories: this.xValueView,
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
          pointFormat: "{point.y:,.f} views"
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
            data: this.yValueView
          }
        ]
      });
      this.titleView = item.nameEng;
      this.dialogChart = true;
    },
    //ปุ่ม OK ยืนยันการลบ
    async delMovieBtn() {
      //ลบข้อมูลออกจาก category
      let data = {
        cat: this.addmovie.category
      };
      let url = this.serverpath + "bo_moviedelcat.php";
      let res = await axios.post(url, JSON.stringify(data));

      //ลบข้อมูลออกจาก movie และทำการลบรูป
      data = {
        id: this.editMovieId
      };
      url = this.serverpath + "bo_moviedeldata.php";
      res = await axios.post(url, JSON.stringify(data));
      this.movieP = 1;
      this.loadMovieData();
      this.deleteMovieAlert = false;
      this.dialogEditMovie = false;
    },
    // ปุ่ม Report
    async reportBtn(id) {
      this.problemList = [];
      this.problemListetc = [];
      let data = {
        id: id
      };
      let url = this.serverpath + "bo_moviereportproblem.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.problemList = res.data;
      url = this.serverpath + "bo_moviereportproblemetc.php";
      res = await axios.post(url, JSON.stringify(data));
      this.problemListetc = res.data;
      this.dialogReport = true;
    },
    //ปุ่มเพิ่ม Movie
    showAddMovieBtn() {
      // expired date    this.addmovie.titleTh = "";
      this.addmovie.titleEn = "";
      this.addmovie.year = "";
      this.addmovie.mpaRating = "G";
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
      if (this.addmovie.synopsis.length >= 300) {
        this.redNotify("Maximum synopsis 300 characters");
        return;
      }
      //ปรับรูปแบบของ category
      let categoryData = "";
      this.addmovie.category.forEach(x => {
        categoryData += "[" + x + "],";
      });
      categoryData = categoryData.slice(0, -1);

      //Convert expirteddate เป็น microtime
      if (this.addmovie.newArraival) {
        let today = new Date();
        this.timestamp = today.getTime() + 1296000000;
        // this.timestamp = this.addmovie.expiredDate;
        // this.timestamp = this.timestamp.split("/");
        // this.timestamp =
        //   this.timestamp[3] + "-" + this.timestamp[2] + "-" + this.timestamp[1];
        // this.timestamp = new Date(this.timestamp).getTime();
      }

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
        expiredDate: this.addmovie.newArraival ? this.timestamp : 0
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
      this.greenNotify("Add new movie completely");
      this.dialogAddMovie = false;
      this.loadMovieData();
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
      if (this.addmovie.expiredDate == null || this.addmovie.expiredDate == 0) {
        let today = new Date();
        let mi = today.getTime() + 1296000000;
        this.timestamp = mi;
        let a = new Date(mi);
        this.addmovie.expiredDate =
          a.getDate() + "/" + (a.getMonth() + 1) + "/" + a.getFullYear();
        this.labelExpired =
          "New arrival (expired date " + this.addmovie.expiredDate + ")";
      } else {
        let temp = new Date(this.addmovie.expiredDate * 1);
        let temp2 =
          temp.getDate() +
          "/" +
          (temp.getMonth() + 1) +
          "/" +
          temp.getFullYear();
        this.labelExpired = "New arrival (expired date " + temp2 + ")";
      }

      this.dialogEditMovie = true;
    },
    //บันทึกแก้ไขหนัง
    async saveEditMovieBtn() {
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
      if (this.addmovie.synopsis.length >= 300) {
        this.redNotify("Maximum synopsis 300 characters");
        return;
      }
      //ปรับรูปแบบของ category
      let categoryData = "";
      this.addmovie.category.forEach(x => {
        categoryData += "[" + x + "],";
      });
      categoryData = categoryData.slice(0, -1);
      // Convert ExpiredDate to timestamp
      if (this.addmovie.newArraival == 1) {
        this.timestamp = this.addmovie.expiredDate + 1296000000;
        this.timestamp = this.timestamp.split("/");
        this.timestamp =
          this.timestamp[3] + "-" + this.timestamp[2] + "-" + this.timestamp[1];
        this.timestamp = new Date(this.timestamp).getTime();
      }
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
        expiredDate: this.addmovie.newArraival ? this.timestamp : 0,
        id: this.editMovieId
      };

      let url = this.serverpath + "bo_movieeditdata.php";
      let res = await axios.post(url, JSON.stringify(data));
      //Check file delete
      if (this.addmovie.posterFile != 1) {
        //ทำการ upload  รูปภาพ
        let formData = new FormData();
        formData.append("file", this.addmovie.posterFile);
        formData.append("id", this.editMovieId);
        url = this.serverpath + "bo_uploadmovieposter.php";
        let data2 = await axios.post(url, formData);
      }
      this.greenNotify("update movie completely");
      this.dialogEditMovie = false;
      this.loadMovieData();
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
        this.redNotify(item.nameEng + " status change to offline");
      } else {
        this.greenNotify(item.nameEng + " status change to online");
      }
      this.data[index].status = sta;
      //this.loadMovieData();
    },
    //ลบ poster file
    async deletePosterFileBtn() {
      let data = {
        id: this.editMovieId
      };
      let url = this.serverpath + "bo_deleteposterfile.php";
      let res = await axios.post(url, JSON.stringify(data));

      this.addmovie.posterFile = 0;
      this.greenNotify("deleted poster complete");
    },

    //เปิดหน้า preview movie
    async previewMovie(item) {
      this.previewTitleEn = item.nameEng;
      this.previewMovieThaiSoundCode = item.movieCodeTh;
      if (item.movieCodeTh != "") {
        let data = {
          movieCode: item.movieCodeTh
        };
        let url = this.serverpath + "bo_encodemovie.php";
        let res = await axios.post(url, JSON.stringify(data));
        this.previewThaiSoundLink = res.data;
      } else {
        this.indexPoster = 2;
      }
      this.previewMovieThaiSubCode = item.movieCodeEng;
      if (item.movieCodeEng != "") {
        let data = {
          movieCode: item.movieCodeEng
        };
        let url = this.serverpath + "bo_encodemovie.php";
        let res = await axios.post(url, JSON.stringify(data));
        this.previewThaiSubLink = res.data;
      } else {
        this.indexPoster = 1;
      }
      this.dialogPreview = true;
    },
    // เปิด dialog trailer
    async previewtrailer(item) {
      this.dialogtrailer = true;
      this.trailerTitle = item.nameEng;
      let data = {
        movieCode: item.trailerCode
      };
      let url = this.serverpath + "bo_encodemovie.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.trailerLink = res.data;
    },
    //เปิด promotion
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
      promotionPCPic == 1
        ? (this.posterP =
            this.serverpath +
            "/promotion/movie/" +
            this.promotionMovieId +
            "p.jpg?" +
            Math.floor(Math.random() * (999 - 100 + 1) + 100))
        : (this.posterP = null);
      promotionTabletPic == 1
        ? (this.posterT =
            this.serverpath +
            "/promotion/movie/" +
            this.promotionMovieId +
            "t.jpg?" +
            Math.floor(Math.random() * (999 - 100 + 1) + 100))
        : (this.posterT = null);
      promotionMobilePic == 1
        ? (this.posterM =
            this.serverpath +
            "/promotion/movie/" +
            this.promotionMovieId +
            "m.jpg?" +
            Math.floor(Math.random() * (999 - 100 + 1) + 100))
        : (this.posterM = null);
      this.dialogPromotion = true;
    },
    //อัพโหลด  promotion poster mobile file
    async uploadFilePosterMobile() {
      let formData = new FormData();
      formData.append("file", this.promotionMobileFile);
      formData.append("id", this.promotionMovieId);
      const url = this.serverpath + "bo_uploadPromotionMobile.php";
      let data = await axios.post(url, formData);
      this.posterM =
        this.serverpath +
        "/promotion/movie/" +
        this.promotionMovieId +
        "m.jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100);
    },
    //อัพโหลด  promotion poster Tablet file
    async uploadFilePosterTablet() {
      let formData = new FormData();
      formData.append("file", this.promotionTabletFile);
      formData.append("id", this.promotionMovieId);
      const url = this.serverpath + "bo_uploadPromotionTablet.php";
      let data = await axios.post(url, formData);
      this.posterT =
        this.serverpath +
        "/promotion/movie/" +
        this.promotionMovieId +
        "t.jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100);
    },
    //อัพโหลด  promotion poster PC file
    async uploadFilePosterPC() {
      let formData = new FormData();
      formData.append("file", this.promotionPCFile);
      formData.append("id", this.promotionMovieId);
      const url = this.serverpath + "bo_uploadPromotionPC.php";
      let data = await axios.post(url, formData);
      this.posterP =
        this.serverpath +
        "/promotion/movie/" +
        this.promotionMovieId +
        "p.jpg?" +
        Math.floor(Math.random() * (999 - 100 + 1) + 100);
    },
    //ลบไฟล์ promotion poster mobile file
    async deletePosterMobile() {
      let data = {
        id: this.promotionMovieId,
        type: "m"
      };
      const url = this.serverpath + "bo_deletePromotionFile.php";
      let res = await axios.post(url, data);
      this.greenNotify("Delete completely");
      this.posterM = null;
      this.promotionOn = false;
      this.setPromotion();
    },
    //ลบไฟล์ promotion poster tablet file
    async deletePosterTablet() {
      let data = {
        id: this.promotionMovieId,
        type: "t"
      };
      const url = this.serverpath + "bo_deletePromotionFile.php";
      let res = await axios.post(url, data);
      this.greenNotify("Delete completely");
      this.posterT = null;
      this.promotionOn = false;
      this.setPromotion();
    },
    //ลบไฟล์ promotion poster tablet file
    async deletePosterPC() {
      let data = {
        id: this.promotionMovieId,
        type: "p"
      };
      const url = this.serverpath + "bo_deletePromotionFile.php";
      let res = await axios.post(url, data);
      this.greenNotify("Delete completely");
      this.posterP = null;
      this.promotionOn = false;
      this.setPromotion();
    },
    //ปิดหน้า Promotion
    closePromotion() {
      this.loadMovieData();
      this.indexPoster = 1;
      this.dialogPromotion = false;
    },
    //เปิดปิดระบบโปรโมชั่น
    async setPromotion() {
      let temp = {
        movieid: Number(this.promotionMovieId),
        value: this.promotionOn ? 1 : 0
      };
      const url = this.serverpath + "bo_updatePromotion.php";
      let res = await axios.post(url, temp);
    },
    //ปิด alert ลบหนัง
    closeAlertBtn() {
      this.deleteMovieAlert = false;
    }
  },
  computed: {
    isValid() {
      return this.addmovie.synopsis.length <= 300;
    }
  },

  mounted() {
    this.loadcatatmovie();
    this.loadpagenumber();
    this.loadMovieData();
    this.checkMenuAccess(2);
  }
};
</script>

<style lang="scss" scoped>
.contextdiv {
  height: calc(100vh - 100px);
  overflow-y: auto;
}
.bggrey {
  background-color: #6c6c6c;
}
.btndiv {
  position: absolute;
  left: calc(100% - 100px);
}
.contentdiv {
  position: absolute;
  left: 150px;
  width: calc(100% - 300px);
}
.pospic {
  position: absolute;
  left: 10px;
}
.boxdiv {
  position: relative;
  overflow: hidden;
  width: 95%;
  margin-left: 2.5%;
  height: 200px !important;
  background-color: #c6d6ff;
  border-radius: 5px;
}
.tempdiv {
  position: relative;
  height: 1px;
  width: 100%;
  background-color: white;
}
.newarrivaldiv {
  position: relative;
  z-index: 100;
}
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
  max-width: 98px;
  width: 98px;
  max-height: 151px;
  height: 151px;
}
.testMovie {
  margin-right: 10px;
  width: 100px;

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
  border: 1px solid black;
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
.alertDialog {
  border-radius: 30px;
  width: 455px;
  height: 288px;
}
.reportDialog {
  border-radius: 30px;
  width: 530px;
  height: 500px;
}
.chartdiv {
  width: 600px;
  height: 450px;
  background-color: #edf2fe;
  border-radius: 20px;
}
.deletedDialog {
  width: 600px;
  height: 450px;
  background-color: #edf2fe;
  border-radius: 20px;
}
.contentDelDiv {
  height: 300px;
  overflow-y: auto;
}
.alertProblemDialog {
  width: 580px;
  height: 400px;
  background-color: #e1eefe;
  border-radius: 30px;
}
.problemInside {
  height: 300px;
  overflow-y: auto;
}
.confirmDiv {
  width: 500px;
  height: 275px;
  background-color: #e1eefe;
  border-radius: 30px;
}
.btncommon {
  width: 160px;
  height: 50px;
  border: 1px solid black;
  line-height: 50px;
  text-align: center;
  border-radius: 5px;
}
.btnyellow {
  width: 160px;
  height: 50px;
  line-height: 50px;
  text-align: center;
  background-color: #ffc24c;
  border-radius: 5px;
}
.checkTypePoster {
  width: 21px;
  height: 21px;
  border-radius: 5px;
  background: #e83939;
}
</style>
