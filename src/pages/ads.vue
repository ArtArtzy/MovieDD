<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="row q-pt-lg">
          <div class="row items-center col-3 q-pl-xl" style="font-size:16px;">
            Status
            <div class="q-pl-md">
              <q-select
                color="orange-13"
                v-model="adsOpt"
                :options="optads"
                :dense="true"
                style="width:120px;font-size:16px;"
                @input="loadAds()"
              >
              </q-select>
            </div>
          </div>
          <div class="col row items-center" style="font-size:16px;">
            Page
            <div class="q-pl-md">
              <q-select
                color="orange-13"
                v-model.number="adsPage"
                :options="pageAds"
                :dense="true"
                style="width:60px;font-size:16px;"
                @input="showPage()"
              >
              </q-select>
            </div>
            <div class="q-pl-sm" style="font-size:16px;">
              of {{ Math.ceil(this.dataShow.length / 3) }}
            </div>
          </div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer "
              style="background-color:#FFC24C;font-size:18px;width:160px"
              label="+ ads"
              no-caps=""
              @click="addAds()"
            />
          </div>
        </div>
        <div class="q-mt-md" align="center">
          <q-scroll-area class="" style="height:88vh; max-width: 90vw;">
            <div
              class="inBox shadow-3 q-mt-md"
              v-for="(item, index) in dataShowPage"
              :key="index"
            >
              <div class="row q-pt-md items-center">
                <div class="col-5 q-pl-xl" align="left">
                  <div style="font-size:24px;">
                    {{ item.at_title }}
                    <div style="font-size:18px;">
                      Target URL : <u>{{ item.at_target }}</u>
                    </div>
                  </div>
                </div>
                <div class="col-4" align="center">
                  <div class="editBox row q-ma-sm q-pa-sm items-center">
                    <div class="col">
                      <div style="font-size:14px;">Duration</div>
                      <div style="font-size:20px;">xx Day</div>
                    </div>
                    <div class="leditBox"></div>
                    <div class="col">
                      <div style="font-size:14px;">Weight</div>
                      <div style="font-size:20px;">{{ item.at_weight }}%</div>
                    </div>
                    <div class="leditBox"></div>
                    <div class="col-5">
                      <div style="font-size:24px;">
                        <u>{{ item.statview }} Clicks</u>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col q-pl-lg">
                  <div class="cursor-pointer" @click="editAds(item)">
                    <u>Edit</u>
                  </div>
                </div>
                <div class="col q-pr-xl">
                  <div
                    v-show="item.status == 1"
                    class="onBox cursor-pointer"
                    @click="changeStatus(item, index)"
                  >
                    online
                  </div>
                  <div
                    v-show="item.status == 0"
                    class="offBox cursor-pointer"
                    @click="changeStatus(item, index)"
                  >
                    offline
                  </div>
                </div>
              </div>
              <hr style="width:95%;" />
              <div class="row items-center q-pa-md">
                <div class="col-2">Mobile</div>
                <div class="shadow-3" style="width:350px;height:90px;"></div>
              </div>
              <div class="row items-center q-pa-md">
                <div class="col-2">Tablet</div>
                <div class="shadow-3" style="width:750px;height:200px;"></div>
              </div>
              <div class="row items-center q-pa-md">
                <div class="col-2">Tablet</div>
                <div class="shadow-3" style="width:800px;height:130px;"></div>
              </div>
            </div>
            <div class="q-pb-sm"></div>
          </q-scroll-area>
        </div>
      </div>
      <!----------------------------------------- dialog  ------------------>
      <!-- add Ads  -->
      <q-dialog v-model="addBtn" persistent>
        <q-card class="diaBox" style="font-size:18px;">
          <div class="row items-center" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;">Add</div>
            <div class="col-1">
              <q-btn
                class="q-pa-sm"
                icon="far fa-times-circle"
                flat
                rounded
                size="lg"
                dense
                v-close-popup
                @click="clrmem()"
              />
            </div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">ชื่อแคมเปญ</div>
            <div class="col">
              <q-input class="" style="width:350px;" v-model="mname" dense />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">Weight</div>
            <div class="col">
              <q-input class="" style="width:350px;" v-model="mweight" dense />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">URL destination</div>
            <div class="col">
              <q-input class="" style="width:350px;" v-model="murl" dense />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">folder</div>
            <div class="col">
              <q-input class="" style="width:350px;" v-model="mfolder" dense />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row ynDia">
            <div class="ynBtn q-ma-sm" @click="clrmem()" align="center">
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
      <!-- edit Ads  -->
      <q-dialog v-model="editBtn" persistent>
        <q-card class="diaBox" style="font-size:18px;">
          <div class="row items-center" align="center">
            <div class="col-1"></div>
            <div class="col" style="font-size:24px;">Edit</div>
            <div class="col-1">
              <q-btn
                class="q-pa-sm"
                icon="far fa-times-circle"
                flat
                rounded
                size="lg"
                dense
                v-close-popup
                @click="clrmem()"
              />
            </div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">ชื่อแคมเปญ</div>
            <div class="col">
              <q-input class="" style="width:350px;" v-model="mname" dense />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">Weight</div>
            <div class="col">
              <q-input class="" style="width:350px;" v-model="mweight" dense />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">URL destination</div>
            <div class="col">
              <q-input
                class=""
                style="width:350px;"
                v-model="murl"
                disable=""
                dense
              />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row items-center q-py-sm" align="center">
            <div class="col-4">folder</div>
            <div class="col">
              <q-input
                class=""
                style="width:350px;"
                v-model="mfolder"
                disable=""
                dense
              />
            </div>
            <div class="col-3"></div>
          </div>
          <div class="row ynDia">
            <div class="ynBtn q-ma-sm" @click="clrmem()" align="center">
              Cancel
            </div>
            <div
              class="ynBtn q-ma-sm"
              style="background-color:#ffc24c"
              align="center"
              @click="editOk()"
            >
              Ok
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- bg drop  -->
      <div class="bgDrop fullscreen" v-show="addBtn || editBtn"></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      adsOpt: "all",
      optads: ["all", "online", "offline"],
      adsPage: 1,
      pageAds: [],
      stAd: 1,
      endAd: 3,
      dataShow: [],
      dataShowPage: [],
      data: [
        {
          at_id: 1,
          at_title: "หวยเปลี่ยนโลก",
          at_folder: "a001",
          statview: 0,
          at_weight: 100,
          at_target: "www.finnbet.com",
          status: 1,
          at_timestamp: "2147483647"
        },
        {
          at_id: 2,
          at_title: "สล็อตเปลี่ยนชีวิต",
          at_folder: "a002",
          statview: 0,
          at_weight: 25,
          at_target: "www.google.com",
          status: 1,
          at_timestamp: "2147483647"
        }
      ],
      addBtn: false,
      editBtn: false,
      mname: "",
      mweight: "",
      murl: "",
      mfolder: ""
    };
  },
  methods: {
    clrmem() {
      this.addBtn = false;
      this.editBtn = false;
      this.mid = "";
      this.mname = "";
      this.mweight = "";
      this.murl = "";
      this.mfolder = "";
    },
    addAds() {
      this.addBtn = true;
    },
    editAds(item) {
      this.mid = item.at_id;
      this.mname = item.at_title;
      this.mweight = item.at_weight;
      this.murl = item.at_target;
      this.mfolder = item.at_folder;
      this.editBtn = true;
    },
    async editOk() {
      let data = {
        at_id: this.mid,
        at_title: this.mname,
        at_folder: this.mfolder,
        at_weight: this.mweight,
        at_target: this.murl
      };
      let url = this.serverpath + "bo_editads.php";
      let res = await axios.post(url, JSON.stringify(data));
      if (res.data == "OK") {
        this.$q.notify({
          progress: true,
          message: "Edit ads complete",
          color: "positive",
          position: "top",
          icon: "fas fa-check"
        });
        this.clrmem();
        this.loadData();
      } else if (res.data == "notchange") {
        this.clrmem();
        this.loadData();
      } else {
        this.$q.notify({
          progress: true,
          message: res.data,
          color: "negative",
          position: "top",
          icon: "fas fa-times"
        });
      }
    },
    loadAds() {
      this.adsPage = 1;
      if (this.adsOpt == "all") {
        this.dataShow = this.data;
      } else if (this.adsOpt == "online") {
        this.dataShow = this.data.filter(x => x.status == 1);
      } else {
        this.dataShow = this.data.filter(x => x.status == 0);
      }
      this.calPage();
    },
    calPage() {
      this.pageAds = [];

      let pageMax = Math.ceil(this.dataShow.length / 3);
      this.stAd = 1;
      if (pageMax > 1) {
        this.endAd = 3;
      } else {
        this.endAd = this.dataShow.length;
      }
      for (let i = 1; i <= pageMax; i++) {
        this.pageAds.push(i);
      }
      this.showPage();
    },
    showPage() {
      this.stAd = (this.adsPage - 1) * 3 + 1;
      this.endAd = this.stAd + 2;
      if (this.endAd > this.dataShow.length) {
        this.endAd = this.dataShow.length;
      }

      this.dataShowPage = [];

      for (let i = this.stAd - 1; i < this.endAd; i++) {
        this.dataShowPage.push(this.dataShow[i]);
      }
    },
    async changeStatus(item, index) {
      let sta = 0;
      if (item.status == 0) sta = 1;
      else sta = 0;
      let data = {
        at_id: item.at_id,
        status: sta
      };
      let url = this.serverpath + "bo_changestatusads.php";
      let res = await axios.post(url, JSON.stringify(data));

      if (sta == 0) {
        this.$q.notify({
          progress: true,
          message: item.at_title + " status change to offline",
          color: "positive",
          position: "top",
          icon: "fas fa-check"
        });
      } else {
        this.$q.notify({
          progress: true,
          message: item.at_title + " status change to online",
          color: "positive",
          position: "top",
          icon: "fas fa-check"
        });
      }
      this.dataShowPage[index].status = sta;
    },
    async addOk() {
      if (
        this.mname == "" ||
        this.mweight == "" ||
        this.mweight == "" ||
        this.mfolder == ""
      ) {
        this.$q.notify({
          progress: true,
          message: "Plese input all fields",
          color: "negative",
          position: "top",
          icon: "fas fa-times"
        }); // ใส่ข้อมูลไม่ครบ
        return;
      } else {
        let data = {
          at_title: this.mname,
          at_folder: this.mfolder,
          at_weight: this.mweight,
          at_target: this.murl
        };
        let url = this.serverpath + "bo_addads.php";
        let res = await axios.post(url, JSON.stringify(data));
        if (res.data == "NR") {
          this.$q.notify({
            progress: true,
            message: "This campaign exist",
            color: "negative",
            position: "top",
            icon: "fas fa-times"
          });
          // ชื่อแคมเปญซ้ำ
        } else if (res.data == "NRF") {
          this.$q.notify({
            progress: true,
            message: "This folder exist",
            color: "negative",
            position: "top",
            icon: "fas fa-times"
          });
          // ชื่อแคมเปญซ้ำ
        } else if (res.data == "OK") {
          this.$q.notify({
            progress: true,
            message: "Add new ads complete",
            color: "positive",
            position: "top",
            icon: "fas fa-check"
          });
          this.loadData();
          this.clrmem();
        }
      } // เพิ่ม category
    },
    async loadData() {
      let url = this.serverpath + "bo_loadads.php";
      let res = await axios.get(url);
      this.data = res.data;
      //  this.data.sort((a, b) => a.orderid - b.orderid);
      this.dataShow = res.data;
      this.adsPage = 1;
      this.calPage();
    }
  },
  mounted() {
    this.loadData();
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
.inBox {
  width: 98%;
  height: 646px;
  background-color: #ffffff;
  border-radius: 10px;
}
.editBox {
  border: 1px solid black;
}
.leditBox {
  height: 45px;
  width: 1px;
  background-color: black;
}
.onBox {
  border-radius: 50px;
  width: 82px;
  height: 25px;
  color: white;
  background-color: $positive;
}
.offBox {
  border-radius: 50px;
  width: 82px;
  height: 25px;
  color: white;
  background-color: $negative;
}
.bgDrop {
  background-color: rgba($color: #000000, $alpha: 0.6);
}
.diaBox {
  max-width: 900px;
  width: 750px;
  height: 400px;
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
  margin: auto;
  position: absolute;
  bottom: 30px;
  margin-left: 200px;
  width: 400px;
  height: 45px;
}
</style>
