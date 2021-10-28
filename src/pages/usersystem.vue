<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="q-pt-lg row">
          <div class="col-3 q-pl-xl">
            <q-btn
              rounded
              class=" q-pa-xs"
              style="background-color:#FFC24C;font-size:16px;width:200px;"
              @click="securityEdit()"
              no-caps
            >
              <q-icon class="fas fa-key" size="21px" />
              <div class="q-pl-sm">security code</div>
            </q-btn>
          </div>
          <div class="col"></div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer"
              style="background-color:#FFC24C;font-size:18px;width:160px;"
              label="+ admin"
              no-caps=""
              @click="addAdmin = true"
            />
          </div>
        </div>
        <div class="inBox q-pt-xl">
          <div class="row q-pa-sm" style="font-size:20px;" align="center">
            <div class="col-2 q-px-md" align="left">Username</div>
            <div class="col-2">Password</div>
            <div class="col">
              <img src="../../public/images/iconCategory.svg" alt="" />
            </div>
            <div class="col">
              <img src="../../public/images/iconMovie.svg" alt="" />
            </div>
            <div class="col">
              <img src="../../public/images/iconSeries.svg" alt="" />
            </div>

            <div class="col">
              <img src="../../public/images/iconAds.svg" alt="" />
            </div>
            <div class="col">
              <img src="../../public/images/iconAnalytic.svg" alt="" />
            </div>
            <div class="col">
              <img src="../../public/images/iconUser.svg" alt="" />
            </div>
            <div class="col">
              <img src="../../public/images/iconAdmin.svg" alt="" />
            </div>
            <div class="col">Delete</div>
            <div class="col">Edit</div>
          </div>
          <hr />
          <div
            class="row q-pa-sm"
            v-for="(item, index) in data"
            style="height:50px;"
            :key="index"
            :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
            align="center"
          >
            <div class="col-2 q-pl-lg" align="left">{{ item.username }}</div>
            <div class="col-2">{{ item.password }}</div>
            <div class="col">
              <div v-show="item.us_category == 1">
                <img src="../../public/images/true.svg" alt="" />
              </div>
              <div v-show="item.us_category == 0">
                <img src="../../public/images/false.svg" alt="" />
              </div>
            </div>
            <div class="col">
              <div v-show="item.us_movie == 1">
                <img src="../../public/images/true.svg" alt="" />
              </div>
              <div v-show="item.us_movie == 0">
                <img src="../../public/images/false.svg" alt="" />
              </div>
            </div>
            <div class="col">
              <div v-show="item.us_series == 1">
                <img src="../../public/images/true.svg" alt="" />
              </div>
              <div v-show="item.us_series == 0">
                <img src="../../public/images/false.svg" alt="" />
              </div>
            </div>
            <div class="col">
              <div v-show="item.us_ads == 1">
                <img src="../../public/images/true.svg" alt="" />
              </div>
              <div v-show="item.us_ads == 0">
                <img src="../../public/images/false.svg" alt="" />
              </div>
            </div>
            <div class="col">
              <div v-show="item.us_analytic == 1">
                <img src="../../public/images/true.svg" alt="" />
              </div>
              <div v-show="item.us_analytic == 0">
                <img src="../../public/images/false.svg" alt="" />
              </div>
            </div>
            <div class="col">
              <div v-show="item.us_user == 1">
                <img src="../../public/images/true.svg" alt="" />
              </div>
              <div v-show="item.us_user == 0">
                <img src="../../public/images/false.svg" alt="" />
              </div>
            </div>
            <div class="col">
              <div v-show="item.us_admin == 1">
                <img src="../../public/images/true.svg" alt="" />
              </div>
              <div v-show="item.us_admin == 0">
                <img src="../../public/images/false.svg" alt="" />
              </div>
            </div>
            <div class="col">
              <img
                v-show="item.username != 'admin'"
                class="cursor-pointer"
                src="../../public/images/delBin.svg"
                alt=""
                @click="deleteUser(item)"
              /><img
                v-show="item.username == 'admin'"
                src="../../public/images/delsBin.svg"
                alt=""
              />
            </div>
            <div class="col-1 underLine cursor-pointer" @click="editUser(item)">
              <u>Edit</u>
            </div>
          </div>
        </div>
      </div>
      <!---------------------------------------- end table  ---------------------------------------------------------->
      <!---------------------------------------- end table  ---------------------------------------------------------->
      <!---------------------------------------- end table  ---------------------------------------------------------->
      <!---------------------------------------- end table  ---------------------------------------------------------->
      <!-- security code -->
      <q-dialog v-model="securityBtn" persistent>
        <q-card class="securityBox">
          <div align="center">
            <div class="q-pt-sm" style="font-size:24px;font-weight:500;">
              Security key
            </div>
            <div class="row items-center">
              <div
                class="q-pa-sm"
                style="padding-left:50px;margin-top:10px;font-size:18px;"
              >
                Key
              </div>
              <div class="q-pa-xs" style="width:300px;">
                <q-input dense v-model="passwordStr" />
              </div>
            </div>
            <div class="row q-pt-sm">
              <div class="col"></div>
              <div class="col-11" style="font-size:14px;">
                This code used to prevent unauthorized use of the movie must be
                the same as the JW player backend system.
              </div>
              <div class="col"></div>
            </div>
            <div class="row q-pt-md" style="width:370px;margin:auto;">
              <div
                class="ynBtn"
                style="border-color:black"
                @click="cancelSec()"
              >
                Cancel
              </div>
              <div
                class="ynBtn"
                style="background-color:#ffc24c"
                @click="securitySave()"
              >
                OK
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- Add new admin  -->
      <q-dialog v-model="addAdmin" persistent>
        <q-card class="editBox">
          <div class="q-pt-lg q-my-md" style="font-size:24px;" align="center">
            Add new admin user
          </div>
          <div class="row q-pl-xl">
            <div class="typeEdit">
              Username
            </div>
            <div style="width:300px;">
              <q-input dense v-model="userStr" />
            </div>
          </div>
          <div class="row q-pl-xl">
            <div class="typeEdit">
              Password
            </div>
            <div class="" style="width:300px;">
              <q-input
                dense
                v-model="passwordStr"
                bottom-slots
                error-message="Please use 6-14 characters"
                :error="!isValid"
              />
            </div>
          </div>
          <div class="q-pl-xl q-ml-md q-pt-lg">
            Access menu
          </div>
          <!-- checkbox  -->
          <div class="checkBox" align="left">
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[0]">
                  <div class="row items-center">
                    <div class="q-pl-sm">
                      Category
                    </div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[4]">
                  <div class="row items-center">
                    <div class="q-pl-sm">
                      Analytic
                    </div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[1]">
                  <div class="row items-center">
                    <div class="q-pl-sm">Movie</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[5]">
                  <div class="row items-center">
                    <div class="q-pl-sm">User</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[2]">
                  <div class="row items-center">
                    <div class="q-pl-sm">Series</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[6]">
                  <div class="row items-center">
                    <div class="q-pl-sm">Admin</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="col-5">
              <q-checkbox color="green" v-model="check[3]">
                <div class="row items-center">
                  <div class="q-pl-sm">Ads</div>
                </div>
              </q-checkbox>
            </div>
          </div>
          <!-- end checkbox  -->
          <div class="">
            <div class="row q-pt-lg" style="width:370px;margin:auto;">
              <div
                class="ynBtn q-ma-sm"
                style="border-color:black"
                align="center"
                @click="cancelAdmin()"
              >
                Cancel
              </div>
              <div class="q-pa-md"></div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c;"
                align="center"
                @click="addAdminOk()"
              >
                OK
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- edit user  -->
      <q-dialog v-model="editBtn" persistent>
        <q-card class="editBox">
          <div class="q-pt-lg q-my-md" style="font-size:24px;" align="center">
            Edit admin user
          </div>
          <div class="row q-pl-xl">
            <div class="typeEdit">
              Username
            </div>
            <div style="width:300px;">
              <q-input dense v-model="userStr" disable />
            </div>
          </div>
          <div class="row q-pl-xl">
            <div class="typeEdit">
              Password
            </div>
            <div class="" style="width:300px;">
              <q-input
                dense
                v-model="passwordStr"
                bottom-slots
                error-message="Please use 6-14 characters"
                :error="!isValid"
              />
            </div>
          </div>
          <div class="q-pl-xl q-ml-md q-pt-lg">
            Access menu
          </div>
          <!-- checkbox  -->
          <div class="checkBox" align="left" v-show="userStr != 'admin'">
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[0]">
                  <div class="row items-center">
                    <div class="q-pl-sm">
                      Category
                    </div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[4]">
                  <div class="row items-center">
                    <div class="q-pl-sm">
                      Analytic
                    </div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[1]">
                  <div class="row items-center">
                    <div class="q-pl-sm">Movie</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[5]">
                  <div class="row items-center">
                    <div class="q-pl-sm">User</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[2]">
                  <div class="row items-center">
                    <div class="q-pl-sm">Series</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[6]">
                  <div class="row items-center">
                    <div class="q-pl-sm">Admin</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="col-5">
              <q-checkbox color="green" v-model="check[3]">
                <div class="row items-center">
                  <div class="q-pl-sm">Ads</div>
                </div>
              </q-checkbox>
            </div>
          </div>
          <div class="checkBox" align="left" v-show="userStr == 'admin'">
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[0]" disable>
                  <div class="row items-center">
                    <div class="q-pl-sm">
                      Category
                    </div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[4]" disable>
                  <div class="row items-center">
                    <div class="q-pl-sm">
                      Analytic
                    </div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[1]" disable>
                  <div class="row items-center">
                    <div class="q-pl-sm">Movie</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[5]" disable>
                  <div class="row items-center">
                    <div class="q-pl-sm">User</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[2]" disable>
                  <div class="row items-center">
                    <div class="q-pl-sm">Series</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[6]" disable>
                  <div class="row items-center">
                    <div class="q-pl-sm">Admin</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="col-5">
              <q-checkbox color="green" v-model="check[3]" disable>
                <div class="row items-center">
                  <div class="q-pl-sm">Ads</div>
                </div>
              </q-checkbox>
            </div>
          </div>
          <!-- end checkbox  -->
          <div class="">
            <div class="row q-pt-lg" style="width:370px;margin:auto;">
              <div
                class="ynBtn q-ma-sm"
                style="border-color:black"
                align="center"
                @click="cancelEdit()"
              >
                Cancel
              </div>
              <div class="q-pa-md"></div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c;"
                align="center"
                @click="editOk()"
              >
                OK
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- delete Btn  -->
      <q-dialog v-model="delBtn" persistent>
        <q-card class="delBox">
          <div align="center">
            <q-icon
              class="fas fa-exclamation-triangle q-mt-lg"
              size="80px"
              style="color:#ffc24c"
            />
            <div class="q-pt-md" style="font-size:24px;">
              You want to delete <span class="text-red">{{ userStr }}</span
              >.
            </div>
            <div style="font-size:14px;">This item cannot restore.</div>
            <div class="row q-pt-lg" style="width:370px;margin:auto;">
              <div
                class="ynBtn q-ma-sm"
                style="border-color:black"
                @click="cancelDelete()"
              >
                Cancel
              </div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c"
                @click="deleteOk()"
              >
                OK
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>

      <!-- bg drop  -->
      <div
        class="bgDrop fullscreen"
        v-show="editBtn || addAdmin || delBtn || securityBtn"
      ></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      userStr: "", // temp data
      passwordStr: "", // temp data
      memUs: 0, // temp data
      editBtn: false, // เปิด dialog Edit Admin
      addAdmin: false, // เปิด dialog เพิ่ม Admin
      delBtn: false, // เปิดเตือน ลบ y/n
      securityBtn: false, // เปิด dialog sercurity
      data: [],
      check: [false, false, false, false, false, false, false]
      //
    };
  },
  computed: {
    isValid() {
      return this.passwordStr.length >= 6 && this.passwordStr.length <= 14;
    }
  },
  methods: {
    // ปุ่ม cancel ใน security code
    cancelSec() {
      this.passwordStr = "";
      this.securityBtn = false;
    },
    //เปิด dialog security และเรียก security code
    async securityEdit() {
      let url = this.serverpath + "bo_loadsecuritycode.php";
      let res = await axios.get(url);
      this.passwordStr = res.data;
      this.securityBtn = true;
    },
    // update security code
    async securitySave() {
      let data = {
        code: this.passwordStr
      };
      let url = this.serverpath + "bo_editsecuritycode.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.greenNotify("Update security key.");
      this.passwordStr = "";
      this.securityBtn = false;
    },
    // ปุ่ม cancel ใน Add Admin
    cancelAdmin() {
      this.memUs = 0;
      this.userStr = "";
      this.passwordStr = "";
      this.check = [false, false, false, false, false, false, false];
      this.addAdmin = false;
    },
    // ปุ่ม save ใน Add Admin
    async addAdminOk() {
      if (this.userStr.length == 0 || this.passwordStr.length == 0) {
        this.redNotify("Please input User name & Password");
        return;
      }
      if (this.passwordStr.length < 6 || this.passwordStr.length > 14) {
        this.redNotify("Password must be 6-14 characters.");
        return;
      }
      if (
        !(
          this.check[0] ||
          this.check[1] ||
          this.check[2] ||
          this.check[3] ||
          this.check[4] ||
          this.check[5] ||
          this.check[6]
        )
      ) {
        this.redNotify("Please select page.");
        return;
      }

      let data = {
        username: this.userStr,
        password: this.passwordStr,
        us_category: this.check[0] ? 1 : 0,
        us_movie: this.check[1] ? 1 : 0,
        us_series: this.check[2] ? 1 : 0,
        us_ads: this.check[3] ? 1 : 0,
        us_analytic: this.check[4] ? 1 : 0,
        us_user: this.check[5] ? 1 : 0,
        us_admin: this.check[6] ? 1 : 0
      };
      let url = this.serverpath + "bo_addusersystem.php";
      let res = await axios.post(url, JSON.stringify(data));
      if (res.data == "NR") {
        this.redNotify("This User name exist");
      } else {
        this.loadData();
        this.addAdmin = false;
        this.greenNotify("Add new admin complete.");
        this.userStr = "";
        this.passwordStr = "";
        this.check = [false, false, false, false, false, false, false];
      }
    },
    // เปิด dailog ลบ Admin
    deleteUser(item) {
      this.delBtn = true;
      this.userStr = item.username;
      this.memUs = item.us_id;
    },
    // ปุ่ม cancel ใน dialog ลบ Admin
    cancelDelete() {
      this.memUs = 0;
      this.userStr = "";
      this.passwordStr = "";
      this.check = [false, false, false, false, false, false, false];
      this.delBtn = false;
    },
    // ปุ่ม save ใน ลบ Admin
    async deleteOk(item) {
      let data = {
        us_id: this.memUs
      };
      let url = this.serverpath + "bo_delusersystem.php";
      let res = await axios.post(url, JSON.stringify(data));

      this.delBtn = false;
      this.greenNotify("Delete " + this.userStr.toUpperCase() + " complete.");
      this.userStr = "";
      this.delUs = 0;
      this.loadData();
    },
    // เปิด dialog Edit Admin
    editUser(item) {
      this.editBtn = true;
      this.memUs = item.us_id;
      this.userStr = item.username;
      this.passwordStr = item.password;
      if (item.us_category == 1) this.check[0] = true;
      if (item.us_movie == 1) this.check[1] = true;
      if (item.us_series == 1) this.check[2] = true;
      if (item.us_ads == 1) this.check[3] = true;
      if (item.us_analytic == 1) this.check[4] = true;
      if (item.us_user == 1) this.check[5] = true;
      if (item.us_admin == 1) this.check[6] = true;
    },
    // ปุ่ม cancel ใน dialog Edit Admin
    cancelEdit() {
      this.memUs = 0;
      this.userStr = "";
      this.passwordStr = "";
      this.check = [false, false, false, false, false, false, false];
      this.editBtn = false;
    },
    // ปุ่ม save ใน Edit Admin
    async editOk() {
      if (this.passwordStr.length < 6 || this.passwordStr.length > 14) {
        this.redNotify("Password must be 6-14 characters.");
        return;
      }
      if (
        !(
          this.check[0] ||
          this.check[1] ||
          this.check[2] ||
          this.check[3] ||
          this.check[4] ||
          this.check[5] ||
          this.check[6]
        )
      ) {
        this.redNotify("Please select page.");
        return;
      }
      let data = {
        us_id: this.memUs,
        username: this.userStr,
        password: this.passwordStr,
        us_category: this.check[0] ? 1 : 0,
        us_movie: this.check[1] ? 1 : 0,
        us_series: this.check[2] ? 1 : 0,
        us_ads: this.check[3] ? 1 : 0,
        us_analytic: this.check[4] ? 1 : 0,
        us_user: this.check[5] ? 1 : 0,
        us_admin: this.check[6] ? 1 : 0
      };
      let url = this.serverpath + "bo_editusersystem.php";
      let res = await axios.post(url, JSON.stringify(data));

      this.greenNotify("Edit admin " + this.userStr + " complete.");
      this.memUs = 0;
      this.userStr = "";
      this.passwordStr = "";
      this.check = [false, false, false, false, false, false, false];
      this.editBtn = false;
      this.loadData();
    },
    async loadData() {
      let url = this.serverpath + "bo_loadusersystem.php";
      let res = await axios.get(url);
      this.data = res.data;
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
  width: 95%;
  margin: auto;
}
.bgDrop {
  background-color: rgba($color: #0f2c78, $alpha: 0.6);
}
.securityCode {
  background-color: #ffc24c;

  border-radius: 30px;
  font-size: 16px;
  width: 170px;
  height: 60px;
}
.editBox {
  width: 600px;
  height: 530px;
  border-radius: 30px;
}
.typeEdit {
  margin-left: 20px;
  padding-top: 16px;
  width: 100px;
  font-size: 18px;
  color: #313131;
  line-height: 30px;
}
.ynBtn {
  margin: auto;
  width: 160px;
  height: 50px;
  border-radius: 10px;
  border: 1px solid #ffc24c;
  cursor: pointer;
  font-size: 18px;
  line-height: 50px;
}
.checkBox {
  padding-top: 20px;
  padding-left: 20%;
}
.delBox {
  width: 500px;
  height: 275px;
  background-color: #edf2fe;
  border-radius: 30px;
}
.securityBox {
  border-radius: 20px;
  width: 460px;
  height: 235px;
}
</style>
