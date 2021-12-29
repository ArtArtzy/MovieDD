<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <!-- Season -->
      <div class="boxWhite ">
        <!-- header  -->
        <div class="row items-center q-pt-lg">
          <q-btn
            class="q-ml-md"
            dense
            rounded
            flat
            to="/series"
            icon="fas fa-long-arrow-alt-left"
            style="width:100px;"
          />
          <div class="col"></div>
          <div class="col-2" align="right" v-show="managementSeason != 0">
            <q-select
              color="orange-13"
              v-model="selectSeason"
              :options="allSeason"
              emit-value
              map-options
              dense
              style="width:180px;font-size:16px;"
              @input="loadEpisodeList()"
            >
            </q-select>
          </div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer "
              style="background-color:#FFC24C;font-size:18px;width:160px;"
              label="Season"
              no-caps
              @click="addSeasonBtn()"
            />
          </div>
        </div>
        <div style="padding-left:50px; font-size:24px;">{{ seriesName }}</div>

        <div v-show="managementSeason != 0"></div>
        <div class="q-pt-md" style="width:96%;margin:auto;" align="center">
          <div class="row ">
            <div class="" style="width:30px;">No.</div>
            <div class="col-1" style="width:150px;">Order ID</div>
            <div class="col " align="left">Episode</div>
            <div class="col-2">Duration</div>
            <div class="col-1" style="width:120px;">TH Sound</div>
            <div class="col-1" style="width:120px;">TH Sub</div>
            <div class="col-1">Delete</div>
            <div class="col-1">Edit</div>
          </div>
          <hr />
          <div
            class="row epList items-center"
            v-for="(item, index) in episodeList"
            :key="index"
            :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
            align="center"
            style="height:50px;line-height: 50px;font-size:16px;"
          >
            <div class="" style="width:30px;">{{ index + 1 }}</div>
            <div class="col-1" style="width:150px;">{{ item.orderid }}</div>
            <div class="col " align="left">{{ item.name }}</div>
            <div class="col-2 " align="center">
              <span v-show="item.durationHour != 0">
                {{ item.durationHour }} h
              </span>
              {{ item.durationMin }} min
            </div>

            <!-- TH Sound -->
            <div class="col-1 " style="width:120px;">
              <div class="row q-px-md">
                <div class="col-6" align="center">
                  <q-icon
                    name="fas fa-play"
                    size="20px"
                    class="cursor-pointer"
                    :color="item.movieCodeTh.length == 0 ? 'grey' : ''"
                    @click="
                      previewVDO(item.id, item.name, item.movieCodeTh, type)
                    "
                    :disabled="item.movieCodeTh.length == 0"
                  />
                </div>
                <div class="col-6" align="center">
                  <q-icon
                    name="far fa-bell"
                    size="24px"
                    class="cursor-pointer"
                    v-show="item.alertThaiSound != 0"
                    :disabled="item.movieCodeTh.length == 0"
                    @click="alertThaiSound(item.id, item.name)"
                  >
                    <q-badge color="red" floating rounded></q-badge>
                  </q-icon>
                  <q-icon
                    name="far fa-bell"
                    size="24px"
                    :color="
                      item.movieCodeTh.length == 0 || item.alertThaiSound == 0
                        ? 'grey'
                        : ''
                    "
                    :disabled="item.movieCodeTh.length == 0"
                    v-show="item.alertThaiSound == 0"
                  >
                  </q-icon>
                </div>
              </div>
            </div>
            <!-- TH Sub -->
            <div class="col-1 " style="width:120px;">
              <div class="row q-px-md">
                <div class="col-6" align="center">
                  <q-icon
                    name="fas fa-play"
                    size="20px"
                    class="cursor-pointer"
                    @click="
                      previewVDO(item.id, item.name, item.movieCodeEng, 2)
                    "
                    :color="item.movieCodeEng.length == 0 ? 'grey' : ''"
                    :disabled="item.movieCodeEng.length == 0"
                  />
                </div>
                <div class="col-6" align="center">
                  <q-icon
                    name="far fa-bell"
                    size="24px"
                    class="cursor-pointer"
                    v-show="item.alertThaiSub != 0"
                    :disabled="item.movieCodeEng.length == 0"
                    @click="alertThaiSub(item.id, item.name)"
                  >
                    <q-badge color="red" floating rounded></q-badge>
                  </q-icon>
                  <q-icon
                    name="far fa-bell"
                    size="24px"
                    :disabled="item.movieCodeEng.length == 0"
                    v-show="item.alertThaiSub == 0"
                    :color="
                      item.movieCodeEng.length == 0 || item.alertThaiSub == 0
                        ? 'grey'
                        : ''
                    "
                  >
                  </q-icon>
                </div>
              </div>
            </div>

            <div class="col-1 cursor-pointer" @click="deleteEpisodeBtn(item)">
              <u>Delete</u>
            </div>
            <div class="col-1 cursor-pointer" @click="editEpisodeBtn(item)">
              <u>Edit</u>
            </div>
          </div>
          <div
            class="newepdiv cursor-pointer q-mt-md"
            v-show="managementSeason != 0"
          >
            <u><span @click="addNewEpisodeBtn()">+New episode</span></u>
          </div>
          <div class="newepdiv q-mt-md" v-show="managementSeason == 0">
            Please add season first
          </div>
        </div>
      </div>
      <!-- Season management -->
      <q-dialog class="" v-model="dialogMainSeason" persistent>
        <q-card class="diaBox">
          <div class="row">
            <div class="col-1"></div>
            <div class="q-pt-md col" style="font-size:24px;" align="center">
              Season management
            </div>
            <div
              class="col-1 q-pt-md cursor-pointer"
              @click="closeSeasonMainDialog()"
            >
              <q-icon name="far fa-times-circle" size="24px" />
            </div>
          </div>
          <div v-show="managementSeason != 0" class="seasonDiv">
            <div class="row q-pt-md">
              <div class="col-2 q-pl-md" align="left">Order ID</div>
              <div class="col q-pl-md" align="left">Name</div>
              <div class="col-2" align="center">Edit</div>
              <div class="col-2" align="center">Delete</div>
            </div>
            <div class="q-px-md"><hr /></div>
            <div
              class="row"
              v-for="(item, index) in managementSeason"
              :style="
                index % 2 == 0 ? 'background-color:rgba(114,148,255,0.09);' : ''
              "
            >
              <div class="col-2  q-pl-md" align="left">
                {{ item.orderid }}
              </div>
              <div class="col q-pl-md">{{ item.name }}</div>
              <div class="col-2" align="center">
                <span class="cursor-pointer" @click="editSeason(item)"
                  ><u>Edit</u></span
                >
              </div>
              <div class="col-2" align="center">
                <span class="cursor-pointer" @click="delSeason(item)"
                  ><u>Delete</u></span
                >
              </div>
            </div>
          </div>
          <div class="addNewSeasonDiv cursor-pointer" @click="addNewSeason()">
            <u>+New Season</u>
          </div>
        </q-card>
      </q-dialog>
      <!-- Add new season dialog -->
      <q-dialog class="" v-model="dialogAddSeason" persistent>
        <q-card class="diaBox2">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Add season
          </div>
          <div class="row q-px-md q-pt-md">
            <div class="col-3 q-pt-sm" align="left">Order ID</div>
            <div class="col">
              <q-input v-model="addSeason.orderid" type="number" dense />
            </div>
          </div>
          <div class="row q-px-md q-pt-sm">
            <div class="col-3 q-pt-sm" align="left">Name</div>
            <div class="col">
              <q-input v-model="addSeason.name" dense />
            </div>
          </div>
          <div class="row q-pt-md">
            <div style="width:80px;"></div>
            <div class="ynBtn q-ma-sm" @click="closeAddSeason()" align="center">
              Cancel
            </div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="addNewSeasonBtn()"
              align="center"
            >
              Ok
            </div>
            <div style="width:80px;"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Edit season dialog -->
      <q-dialog class="" v-model="dialogEditSeason" persistent>
        <q-card class="diaBox2">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Edit season
          </div>
          <div class="row q-px-md q-pt-md">
            <div class="col-3 q-pt-sm" align="left">Order ID</div>
            <div class="col">
              <q-input v-model="addSeason.orderid" type="number" dense />
            </div>
          </div>
          <div class="row q-px-md q-pt-sm">
            <div class="col-3 q-pt-sm" align="left">Name</div>
            <div class="col">
              <q-input v-model="addSeason.name" dense />
            </div>
          </div>
          <div class="row q-pt-md">
            <div style="width:80px;"></div>
            <div
              class="ynBtn q-ma-sm"
              @click="closeEditSeason()"
              align="center"
            >
              Cancel
            </div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="editNewSeasonBtn()"
              align="center"
            >
              Ok
            </div>
            <div style="width:80px;"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Delete season confirm -->
      <q-dialog class="" v-model="dialogConfirmDelSeason" persistent>
        <q-card class="diaBox3">
          <div class="q-pt-md" align="center">
            <q-icon
              name="fas fa-exclamation-circle"
              size="48px"
              style="color:#ffc24c"
            />
          </div>
          <div class="q-px-md q-pt-md" align="center">
            คุณต้องการลบ season นี้หรือไม่
          </div>

          <div class="row q-pt-md">
            <div style="width:30px;"></div>
            <div class="ynBtn q-ma-sm" @click="closeDelSeason()" align="center">
              Cancel
            </div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="delSeasonBtn()"
              align="center"
            >
              Ok
            </div>
            <div style="width:30px;"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Add New Episode  -->
      <q-dialog class="" v-model="dialogAddEpisode" persistent>
        <q-card class="newEpisode">
          <div class="q-pt-md" style="font-size:24px" align="center">
            New episode - {{ seasonName }}
          </div>
          <div class="row textInput">
            <div class="col-1"></div>
            <div class="col-2">Order ID</div>
            <div class="col q-pl-md" style="">
              <q-input dense v-model="addEpisode.orderid" />
            </div>
            <div class="col-1"></div>
          </div>
          <div class="row textInput">
            <div class="col-1"></div>
            <div class="col-2">Title name</div>
            <div class="col q-pl-md" style="">
              <q-input dense v-model="addEpisode.name" />
            </div>
            <div class="col-1"></div>
          </div>

          <div class="row  textInput">
            <div class="col-1"></div>
            <div class="col-2">Duration</div>
            <div class="col-3 q-pl-md">
              <q-input dense v-model="addEpisode.durationHour" />
            </div>
            <div>hour</div>
            <div class="col-3 q-pl-md">
              <q-input dense v-model="addEpisode.durationMin" />
            </div>
            <div>minute</div>
            <div class="col-1"></div>
          </div>
          <div class="row  textInput">
            <div class="col-1"></div>
            <div class="col-5">Movie code (Thai sound)</div>
            <div class="col" style="">
              <q-input dense v-model="addEpisode.movieCodeTh" />
            </div>
            <div class="col-1"></div>
          </div>
          <div class="row  textInput">
            <div class="col-1"></div>
            <div class="col-5">Movie code (Thai sub)</div>
            <div class="col" style="">
              <q-input dense v-model="addEpisode.movieCodeEng" />
            </div>
            <div class="col-1"></div>
          </div>
          <div class="row ynDia">
            <div
              class="ynBtn q-ma-sm"
              @click="cancelAddEpisodeBtn()"
              align="center"
            >
              Cancel
            </div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="addNewEpisodeSave()"
              align="center"
            >
              Ok
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Edit Episode  -->
      <q-dialog class="" v-model="dialogEditEpisode" persistent>
        <q-card class="newEpisode">
          <div class="q-pt-md" style="font-size:24px" align="center">
            Edit episode
          </div>
          <div class="row textInput">
            <div class="col-1"></div>
            <div class="col-2">Title name</div>
            <div class="col q-pl-md" style="">
              <q-input dense v-model="addEpisode.name" />
            </div>
            <div class="col-1"></div>
          </div>
          <div class="row textInput">
            <div class="col-1"></div>
            <div class="col-2">Order ID</div>
            <div class="col q-pl-md" style="">
              <q-input dense v-model="addEpisode.orderid" />
            </div>
            <div class="col-1"></div>
          </div>
          <div class="row  textInput">
            <div class="col-1"></div>
            <div class="col-2">Duration</div>
            <div class="col-3 q-pl-md">
              <q-input dense v-model="addEpisode.durationHour" />
            </div>
            <div>hour</div>
            <div class="col-3 q-pl-md">
              <q-input dense v-model="addEpisode.durationMin" />
            </div>
            <div>minute</div>
            <div class="col-1"></div>
          </div>
          <div class="row  textInput">
            <div class="col-1"></div>
            <div class="col-5">Movie code (Thai sound)</div>
            <div class="col" style="">
              <q-input dense v-model="addEpisode.movieCodeTh" />
            </div>
            <div class="col-1"></div>
          </div>
          <div class="row  textInput">
            <div class="col-1"></div>
            <div class="col-5">Movie code (Thai sub)</div>
            <div class="col" style="">
              <q-input dense v-model="addEpisode.movieCodeEng" />
            </div>
            <div class="col-1"></div>
          </div>
          <div class="row ynDia">
            <div
              class="ynBtn q-ma-sm"
              @click="cancelEditEpisodeBtn()"
              align="center"
            >
              Cancel
            </div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="saveEditEpisodeBtn()"
              align="center"
            >
              Ok
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- delete series alert  -->
      <q-dialog v-model="dialogdeleteSeries" persistent>
        <q-card class="confirmDiv" align="center">
          <q-icon
            class="fas fa-exclamation-triangle q-pt-lg"
            style="font-size:80px;color:#FFC24C"
          />
          <div class="q-py-lg">
            Do you want to delete "{{ episodeDeleteName }}"?
          </div>
          <div class="row q-pt-md">
            <div class="col"></div>
            <div
              class="ynBtn q-ma-sm"
              @click="cancelDeleteBtn()"
              align="center"
            >
              Cancel
            </div>
            <div class="col-1"></div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              @click="OKDeleteBtn()"
              align="center"
            >
              Ok
            </div>
            <div class="col"></div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Alert problem dialog -->
      <q-dialog v-model="dialogAlert" persistent>
        <q-card class="alertProblemDialog">
          <div class="row q-pt-md">
            <div class="col-2"></div>
            <div class="col font24" align="center">
              {{ alertTitlePage }}
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
          <div class="row q-px-lg ">
            <div class="col-9 text-h6">Movie quality</div>
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
          <div v-if="!alertQualityShow" align="center" class="text-h6 q-py-md">
            No qualitiy problem
          </div>
          <div v-else v-for="(item, index) in alertQualityData" :key="index">
            <div class="row q-px-lg ">
              <div class="col-9">{{ item.problem }}</div>
              <div class="col-3" align="center">{{ item.noproblem }}</div>
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
          <div
            v-else
            v-for="(item, index) in alertOtherProblemData"
            :key="index"
          >
            <div class="row q-px-lg">
              <div class="col-9">{{ item.topic }}</div>
              <div class="col-3" align="center">
                <span @click="solveOtherProblem(item.id)" class="cursor-pointer"
                  ><u>solved</u></span
                >
              </div>
            </div>
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
      <!-- Preview  -->
      <q-dialog v-model="dialogPreview" persistent>
        <q-card class="preview">
          <div class="row q-pa-md" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;margin-top:30px;">
              {{ previewTitle }}
            </div>

            <div class="col-1">
              <q-btn
                icon="far fa-times-circle"
                flat
                round
                size="lg"
                dense
                v-close-popup
              />
            </div>
          </div>

          <div class="q-mt-md">
            <div style="width:790px;height:443px;margin:auto;">
              <iframe
                :src="previewSource"
                frameborder="0"
                scrolling="auto"
                allowfullscreen
                style="position:absolute;width:790px;height:443px;"
              ></iframe>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- bg drop  -->
      <div
        class="bgDrop fullscreen"
        v-show="
          dialogMainSeason ||
            dialogAddSeason ||
            dialogEditSeason ||
            dialogAddEpisode ||
            dialogEditEpisode ||
            dialogPreview
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
      id: this.$route.params.id,
      allSeason: [], //ตัวเลือก Season
      selectSeason: 0, //Season ที่เลือกอยู่
      dialogMainSeason: false, //หน้าต่าง season
      dialogAddSeason: false, //หน้าต่างเพิ่ม season ใหม่
      dialogEditSeason: false, //หน้าต่างแก้ไข season
      dialogAddEpisode: false, // หน้าต่างเพิ่ม Episode ใหม่่
      dialogEditEpisode: false, // หน้าต่างแก้ไข Episode
      dialogConfirmDelSeason: false, //หน้าต่าง confirm delete
      dialogPreview: false, // หน้าต่าง preview
      managementSeason: [], //ข้อมูล season
      addSeason: {
        orderid: "",
        name: ""
      }, //เพิ่มและแก้ไข season ใหม่
      episodeList: [], // ข้อมูล episode ย่อยใน season
      addEpisode: {
        name: "",
        seriesid: "",
        sersonid: "",
        orderid: "",
        durationHour: "",
        durationMin: "",
        movieCodeEng: "",
        movieCodeTh: ""
      },

      editSeasonId: "", //แก้ไข Season
      delSeasonId: "", //ลบ Season
      seriesName: "", //ชื่อ Series
      seasonName: "",
      editEpisodeId: "", // สำหรับเก็บ id ตัวแก้ไข Episode
      dialogdeleteSeries: false, // เปิดหน้าต่าง confirm การลบ
      episodeDeleteName: "", //ชื่อตอน
      episodeDeleteId: "", //รหัสตอนที่จะลบ

      dialogAlert: false, //หน้าต่างแสดง Alert
      alertTitlePage: "", //หัวข้อหน้า Alert
      alertTitleMovie: "", //ชื่อ episode
      alertPageId: "", //รหัสหน้า Alert
      alertProblemType: 1, //ประเภทของปัญหา 1 = th sound , 2 =th sub
      alertQualityData: [], //ข้อมูลสำหรับแสดงผลในส่วน quality
      alertQualityShow: false, //แสดงส่วน movie quality
      alertOtherProblemShow: false, //แสดงส่วน other problem
      alertOtherProblemData: [], //ข้อมูลสำหรับแสดงผลในส่วน other problem
      confirmSolveOtherProblem: false, //หน้าต่างยืนยันการ solve other problem
      alertOtherProblemId: "", //รหัสปัญหาอื่นๆที่จะทำการ solve
      confirmSolveProblem: false, //หน้าต่างยืนยันการ solve quality problem

      dialogPreview: false, //เปิดปิดหน้าต่าง Preview
      previewSource: "", //Link VDO
      previewTitle: "" // Preview Title
    };
  },
  methods: {
    //**************Preview Dialog **************/
    //ปุ่ม Preview  จาก Main list
    async previewVDO(id, title, code, type) {
      this.dialogPreview = true;
      if (type == 1) {
        this.previewTitle = title + " - Thai Sound";
      } else {
        this.previewTitle = title + " - Thai Sub";
      }

      let data = {
        movieCode: code
      };
      let url = this.serverpath + "bo_encodemovie.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.previewSource = res.data;
    },
    //************End of Preview Dialog *********/

    //************Alert Problem Dialog **********/
    //ปุ่มตกลงแก้ปัญหา Quality
    async btnAlertProblemQualityYes() {
      this.confirmSolveProblem = false;
      let temp = {
        episodeid: Number(this.alertPageId),
        type: this.alertProblemType
      };
      let url = this.serverpath + "bo_seriesproblemqualitysolved.php";
      let res = await axios.post(url, JSON.stringify(temp));
      this.greenNotify("Save completely");
      if (this.alertProblemType == 1) {
        this.alertThaiSound(this.alertPageId, this.alertTitleMovie);
      } else {
        this.alertThaiSub(this.alertPageId, this.alertTitleMovie);
      }
    },
    //แก้ปัญหา movie quality
    solveProblemQuality() {
      this.confirmSolveProblem = true;
      this.dialogAlert = false;
    },
    //ปุ่ม yes ในการ solve problem ของ other problem
    async btnAlertProblemOtherYes() {
      let temp = {
        problemid: Number(this.alertOtherProblemId)
      };

      let url = this.serverpath + "bo_seriesproblemothersolved.php";
      let res = await axios.post(url, JSON.stringify(temp));
      this.greenNotify("Save completely");
      this.confirmSolveOtherProblem = false;
      if (this.alertProblemType == 1) {
        this.alertThaiSound(this.alertPageId, this.alertTitleMovie);
      } else {
        this.alertThaiSub(this.alertPageId, this.alertTitleMovie);
      }
    },
    //ปุ่มยกเลิกการ solve problem ของ other problem
    btnAlertProblemNo() {
      this.confirmSolveProblem = false;
      this.confirmSolveOtherProblem = false;
      this.dialogAlert = true;
    },
    //ปุ่ม solve other problem
    solveOtherProblem(id) {
      this.alertOtherProblemId = id;
      this.dialogAlert = false;
      this.confirmSolveOtherProblem = true;
    },
    //ปิดหน้าต่าง alert
    closeAlertProblemDialog() {
      this.loadEpisodeList();
      this.dialogAlert = false;
    },
    //กดปุ่ม alert ThaiSub ใน episode
    async alertThaiSub(movieId, titleMovie) {
      this.alertProblemType = 2;
      this.alertTitleMovie = titleMovie;
      this.alertQualityShow = false;
      this.alertTitlePage = titleMovie + "-Thai sub";
      //สำหรับ Movie quality
      this.alertPageId = movieId;
      let temp = {
        episodeid: movieId,
        type: 2 //สำหรับ Thaisound
      };
      let url = this.serverpath + "bo_seriesproblemqualitylist.php";
      let res = await axios.post(url, JSON.stringify(temp));
      if (res.data != "no problem") {
        this.alertQualityShow = true;
        this.alertQualityData = res.data;
      }

      //สำหรับ Other problem,
      this.alertOtherProblemShow = false;
      let dataSend = {
        episodeid: movieId,
        type: 2
      };
      let url2 = this.serverpath + "bo_seriesreportproblemetc.php";
      let res2 = await axios.post(url2, JSON.stringify(dataSend));
      if (res2.data != "no data") {
        this.alertOtherProblemShow = true;
        this.alertOtherProblemData = res2.data;
      }
      if (
        this.alertQualityShow == false &&
        this.alertOtherProblemShow == false
      ) {
        let url3 = this.serverpath + "bo_seriesalertclear.php";
        let res3 = await axios.post(url3, JSON.stringify(dataSend));
      }
      this.dialogAlert = true;
    },

    //กดปุ่ม alert ThaiSound ใน episode
    async alertThaiSound(movieId, titleMovie) {
      this.alertProblemType = 1;
      this.alertTitleMovie = titleMovie;
      this.alertQualityShow = false;
      this.alertTitlePage = titleMovie + "-Thai sound";

      //สำหรับ Movie quality
      this.alertPageId = movieId;
      let temp = {
        episodeid: movieId,
        type: 1 //สำหรับ Thaisound
      };
      let url = this.serverpath + "bo_seriesproblemqualitylist.php";
      let res = await axios.post(url, JSON.stringify(temp));
      if (res.data != "no problem") {
        this.alertQualityShow = true;
        this.alertQualityData = res.data;
      }

      //สำหรับ Other problem,
      this.alertOtherProblemShow = false;
      let dataSend = {
        episodeid: movieId,
        type: 1
      };
      let url2 = this.serverpath + "bo_seriesreportproblemetc.php";
      let res2 = await axios.post(url2, JSON.stringify(dataSend));
      if (res2.data != "no data") {
        this.alertOtherProblemShow = true;
        this.alertOtherProblemData = res2.data;
      }
      if (
        this.alertQualityShow == false &&
        this.alertOtherProblemShow == false
      ) {
        let url3 = this.serverpath + "bo_seriesalertclear.php";
        let res3 = await axios.post(url3, JSON.stringify(dataSend));
      }
      this.dialogAlert = true;
    },
    //*****************End of Problem Dialog ************/

    //*****************Delete episode ******************/
    //ปุ่มตกลงในหน้า Dialog ลบ
    async OKDeleteBtn() {
      let data = {
        id: this.episodeDeleteId
      };
      let url = this.serverpath + "bo_deleteepisode.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.loadEpisodeList();
      this.dialogdeleteSeries = false;
      this.greenNotify("Delete complete");
    },
    //ปุ่มยกเลิกในหน้า Dialog ลบ
    cancelDeleteBtn() {
      this.dialogdeleteSeries = false;
    },
    //ปุ่มลบ Edpisode
    deleteEpisodeBtn(item) {
      this.episodeDeleteName = item.name;
      this.episodeDeleteId = item.id;
      this.dialogdeleteSeries = true;
    },
    //*****************End of Delete episode *************/

    //*****************Add new episode ******************/

    // ล้างค่าตัวแปร temp เก็บข้อมูล addEpisode
    clraddEpisode() {
      this.addEpisode.name = "";
      this.addEpisode.seriesid = "";
      this.addEpisode.sersonid = "";
      this.addEpisode.orderid = "";
      this.addEpisode.durationHour = "";
      this.addEpisode.durationMin = "";
      this.addEpisode.movieCodeEng = "";
      this.addEpisode.movieCodeTh = "";
    },
    // กด cancel ใน dialog Aad new Ep
    cancelAddEpisodeBtn() {
      this.clraddEpisode();
      this.dialogAddEpisode = false;
    },
    // กด OK ใน dailog Add new Ep
    async addNewEpisodeSave() {
      if (this.addEpisode.orderid == "") {
        this.redNotify("Please input order ID");
        return;
      }
      if (this.addEpisode.name == "") {
        this.redNotify("Please input title name");
        return;
      }
      if (this.addEpisode.durationMin == "") {
        this.redNotify("Please input duration");
        return;
      }
      let data = {
        seriesid: this.id,
        seasonid: this.selectSeason,
        orderid: this.addEpisode.orderid,
        name: this.addEpisode.name,
        durationHour: this.addEpisode.durationHour,
        durationMin: this.addEpisode.durationMin,
        movieCodeEng: this.addEpisode.movieCodeEng,
        movieCodeTh: this.addEpisode.movieCodeTh
      };
      let url = this.serverpath + "bo_addseriessub.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.greenNotify("Add " + this.addEpisode.name + " Complete");

      this.loadEpisodeList();
      this.dialogAddEpisode = false;
    },
    //Add new ep
    addNewEpisodeBtn() {
      this.clraddEpisode();
      let temp = this.managementSeason.filter(x => x.id == this.selectSeason);
      this.seasonName = temp[0].name;
      this.dialogAddEpisode = true;
    },
    //******************End of add new episode *************/

    //*****************Edit episode **********************/
    // กดปุ่ม Edit ของ Episode
    editEpisodeBtn(item) {
      this.editEpisodeId = item.id;
      this.addEpisode.name = item.name;
      this.addEpisode.orderid = item.orderid;
      this.addEpisode.durationHour = item.durationHour;
      this.addEpisode.durationMin = item.durationMin;
      this.addEpisode.movieCodeEng = item.movieCodeEng;
      this.addEpisode.movieCodeTh = item.movieCodeTh;

      this.dialogEditEpisode = true;
    },
    // save การแก้ไขค่าของ Edit Episode
    async saveEditEpisodeBtn() {
      let data = {
        orderid: this.addEpisode.orderid,
        name: this.addEpisode.name,
        durationHour: this.addEpisode.durationHour,
        durationMin: this.addEpisode.durationMin,
        movieCodeEng: this.addEpisode.movieCodeEng,
        movieCodeTh: this.addEpisode.movieCodeTh,
        id: this.editEpisodeId
      };
      let url = this.serverpath + "bo_editepisode.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.loadEpisodeList();
      this.greenNotify("Edit " + data.name + " complete");
      this.dialogEditEpisode = false;
    },
    // กด cancel ใน dialog Edit Episode
    cancelEditEpisodeBtn() {
      this.dialogEditEpisode = false;
    },
    //*********************End of edit episode *************/

    // โหลดรายละเอียด Episode ย่อยของ series>season
    async loadEpisodeList() {
      this.episodeList = [];
      let data = {
        seriesid: this.id,
        seasonid: this.selectSeason
      };
      let url = this.serverpath + "bo_loadseriessub.php";
      let res = await axios.post(url, JSON.stringify(data));
      if (res.data != 0) {
        res.data.forEach(x => {
          this.episodeList.push(x);
        });

        this.episodeList.sort((a, b) => a.orderid - b.orderid);
      } else {
        this.episodeList = [];
      }
    },
    //ดึงข้อมูลชื่อหนัง series
    async loadSeriesName() {
      let data = {
        id: this.id
      };
      let url = this.serverpath + "bo_loadseriesname.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.seriesName = res.data[0].nameEng;
    },
    //ปุ่มลบ Season
    async delSeasonBtn() {
      let data = {
        id: this.delSeasonId
      };
      let url = this.serverpath + "bo_deleteseason.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.greenNotify("Delete completely");
      this.loadSeason();
      this.closeDelSeason();
    },
    //ปิดหน้าต่าง ลบ Season
    closeDelSeason() {
      this.dialogConfirmDelSeason = false;
      this.dialogMainSeason = true;
    },
    //เปิดหน้าต่างลบ season
    delSeason(item) {
      this.delSeasonId = item.id;
      this.dialogMainSeason = false;
      this.dialogConfirmDelSeason = true;
    },
    //บันทึกแก้ไข season
    async editNewSeasonBtn() {
      //Check input
      if (this.addSeason.orderid.length == 0) {
        this.redNotify("Please input orderid");
        return;
      }
      if (this.addSeason.name.length == 0) {
        this.redNotify("Please input name");
        return;
      }

      let data = {
        id: this.editSeasonId,
        orderid: this.addSeason.orderid,
        seriesid: this.id,
        name: this.addSeason.name
      };

      let url = this.serverpath + "bo_seriesmaineditseason.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.greenNotify("Save completely");
      this.dialogEditSeason = false;
      this.loadSeason();
      this.dialogMainSeason = true;
    },
    //ปิด season
    closeEditSeason() {
      this.dialogEditSeason = false;
      this.dialogMainSeason = true;
    },
    //แก้ไข season
    editSeason(item) {
      this.editSeasonId = item.id;
      this.addSeason.orderid = item.orderid;
      this.addSeason.name = item.name;
      this.dialogMainSeason = false;
      this.dialogEditSeason = true;
    },
    //ปิด Dialog main season
    closeSeasonMainDialog() {
      this.dialogMainSeason = false;
    },
    //เปิดหน้าต่าง Season
    async addSeasonBtn() {
      await this.loadSeason();
      this.dialogMainSeason = true;
    },
    //โหลด Season เพื่อใช้แสดงผล
    async loadSeason() {
      this.managementSeason = [];
      this.allSeason = [];
      let data = {
        id: this.id
      };

      let url = this.serverpath + "bo_load_season.php";
      let res = await axios.post(url, JSON.stringify(data));
      if (res.data != 0) {
        res.data.forEach(x => {
          this.managementSeason.push(x);
        });

        this.managementSeason.sort((a, b) => a.orderid - b.orderid);
        this.managementSeason.forEach(x => {
          let data = {
            value: x.id,
            label: x.name
          };
          this.allSeason.push(data);
        });
        this.selectSeason = this.allSeason[0].value;
      } else {
        this.managementSeason = 0;
      }
    },
    //เปิดสร้าง season
    async addNewSeason() {
      this.dialogMainSeason = false;
      this.addSeason.orderid = "";
      this.addSeason.name = "";
      this.dialogAddSeason = true;
    },
    //ปิดหน้าต่าง add new season
    closeAddSeason() {
      this.loadSeason();
      this.dialogAddSeason = false;
      this.dialogMainSeason = true;
    },
    //บันทึก การเพิ่ม season ใหม่
    async addNewSeasonBtn() {
      //Check input
      if (this.addSeason.orderid.length == 0) {
        this.redNotify("Please input orderid");
        return;
      }
      if (this.addSeason.name.length == 0) {
        this.redNotify("Please input name");
        return;
      }

      let data = {
        orderid: this.addSeason.orderid,
        seriesid: this.id,
        name: this.addSeason.name
      };
      let url = this.serverpath + "bo_seriesmainaddseason.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.greenNotify("save completely");
      this.loadSeason();
      this.dialogAddSeason = false;
      this.dialogMainSeason = true;
    }
  },
  async mounted() {
    await this.loadSeason();
    this.id = this.$route.params.id;
    this.loadSeriesName();
    this.loadEpisodeList();
    this.checkMenuAccess(3);
  }
};
</script>

<style lang="scss" scoped>
.bgDrop {
  background-color: rgba($color: #000000, $alpha: 0.6);
}
.newepdiv {
  background-color: rgba($color: #7291ff, $alpha: 0.5);
  border-radius: 10px;
  height: 72px;
  font-size: 24px;
  text-align: center;
  line-height: 72px;
}
.seasonDiv {
  height: 347px;
  overflow-y: scroll;
  font-size: 18px;
  line-height: 45px;
}
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: cover;
  background-position: center;
  padding: 10px;
}
.bgDrop {
  background-color: rgba($color: #000000, $alpha: 0.6);
}
.diaBox {
  max-width: 900px;
  width: 600px;
  height: 450px;
  border-radius: 30px;
}
.diaBox2 {
  font-size: 16px;
  max-width: 900px;
  width: 450px;
  height: 250px;
  border-radius: 30px;
}
.diaBox3 {
  max-width: 900px;
  width: 350px;
  height: 200px;
  border-radius: 30px;
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
  margin-inline: 120px;
  bottom: 30px;
  width: 300px;
  height: 45px;
}
.addNewSeasonDiv {
  background-color: #dce6ff;
  border-radius: 0px !important;
  text-align: center;
  margin-top: 10px;
  height: 40px;
  line-height: 40px;
}
.newEpisode {
  border-radius: 30px;
  width: 700px;
  height: 400px;
}
.textInput {
  // margin-top: 10px;
  font-size: 16px;
  height: 50px;
  line-height: 50px;
}
.movieCodeBorder {
  font-size: 16px;
  height: 35px;
  line-height: 35px;
  width: 110px;
  border-radius: 5px;
  border: 1px solid #313131;
}
.borderMovieCodePreview {
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
  height: 620px;
  border-radius: 30px;
}
.epList {
  border-radius: 10px;
}
.alertProblemDialog {
  width: 580px;
  height: 400px;
  background-color: #e1eefe;
  border-radius: 30px;
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
</style>
