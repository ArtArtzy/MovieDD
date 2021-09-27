<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="q-pt-lg row">
          <div class="col-10 q-pl-xl">
            <q-btn
              rounded
              class="cursor-pointer q-pa-xs"
              style="background-color:#FFC24C;font-size:16px;width:200px;"
            >
              <q-icon class="fas fa-key" size="21px" />
              <div class="q-pl-sm">security code</div>
            </q-btn>
          </div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer q-pa-xs"
              style="background-color:#FFC24C;font-size:18px;width:130px;"
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
                class="cursor-pointer"
                src="../../public/images/delBin.svg"
                alt=""
                @click="deleteUser(item.username)"
              />
            </div>
            <div
              class="col-1 underLine cursor-pointer"
              @click="editUser(item.orderid)"
            >
              <u>Edit</u>
            </div>
          </div>
        </div>
      </div>
      <!-- edit  -->
      <q-dialog v-model="addAdmin" persistent>
        <q-card class="editBox" align="center">
          <div class="q-pt-lg" style="font-size:24px;">Add new admin user</div>
          <div class="row">
            <div class="typeEdit">
              Username
            </div>
            <div style="width:250px;">
              <q-input v-model="userStr" />
            </div>
          </div>
          <div class="row ">
            <div class="typeEdit">
              Password
            </div>
            <div class="" style="width:250px;">
              <q-input v-model="passwordStr" />
            </div>
          </div>
          <!-- checkbox  -->
          <div class="checkBox" align="left">
            <div class="row q-pt-sm">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[0]">
                  <div class="row items-center">
                    <img src="../../public/images/iconCategory.svg" style= />
                    <div class="q-pl-xs">Category</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[4]">
                  <div class="row items-center">
                    <img src="../../public/images/iconAnalytic.svg" style= />
                    <div class="q-pl-xs">Analytic</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row q-pt-sm">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[1]">
                  <div class="row items-center">
                    <img src="../../public/images/iconMovie.svg" style= />
                    <div class="q-pl-xs">Movie</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5">
                <q-checkbox color="green" v-model="check[5]">
                  <div class="row items-center">
                    <img src="../../public/images/iconUser.svg" style= />
                    <div class="q-pl-xs">User</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="row q-pt-sm">
              <div class="col-5">
                <q-checkbox color="green" v-model="check[2]">
                  <div class="row items-center">
                    <img src="../../public/images/iconSeries.svg" style= />
                    <div class="q-pl-xs">Series</div>
                  </div>
                </q-checkbox>
              </div>
              <div class="col-5 q-pt-sm">
                <q-checkbox color="green" v-model="check[6]">
                  <div class="row items-center">
                    <img src="../../public/images/iconAdmin.svg" style= />
                    <div class="q-pl-xs">Admin</div>
                  </div>
                </q-checkbox>
              </div>
            </div>
            <div class="col-5">
              <q-checkbox color="green" v-model="check[3]">
                <div class="row items-center">
                  <img src="../../public/images/iconAds.svg" style= />
                  <div class="q-pl-xs">Ads</div>
                </div>
              </q-checkbox>
            </div>
          </div>
          <!-- end checkbox  -->
          <div class="">
            <div class="row q-pt-md" style="width:350px;margin:auto;">
              <div class="ynBtn q-ma-sm" align="center" @click="cancelAdmin()">
                Cancel
              </div>
              <div class="q-pa-md"></div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c;"
                align="center"
                @click="addAdminOk()"
              >
                Ok
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- add new admin  -->

      <!-- bg drop  -->
      <div
        class="bgDrop fullscreen"
        v-show="editBtn || addAdmin || delBtn"
      ></div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      userStr: "",
      passwordStr: "",
      editBtn: false,
      addAdmin: false,
      delBtn: false,
      data: [
        {
          us_id: 1,
          username: "art",
          password: "1234",
          us_category: 1,
          us_movie: 1,
          us_series: 1,
          us_ads: 1,
          us_analytic: 1,
          us_user: 1,
          us_admin: 1
        },
        {
          us_id: 2,
          username: "ohm",
          password: "12345",
          us_category: 0,
          us_movie: 1,
          us_series: 1,
          us_ads: 1,
          us_analytic: 1,
          us_user: 1,
          us_admin: 1
        }
      ],
      check: [false, false, false, false, false, false, false]
    };
  },
  methods: {
    cancelAdmin() {
      this.check = [false, false, false, false, false, false, false];
      this.addAdmin = false;
    },
    addAdminOk() {
      this.addAdmin = false;
      this.$q.notify({
        progress: true,
        message: "Add new admin complete",
        color: "positive",
        position: "top",
        icon: "fas fa-check"
      });
    },
    deleteUser(item) {},
    editUser(item) {}
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
.onlineBtn {
  background-color: #00a642;
  color: white;
  border-radius: 10px;
  width: 90px;
}
.offlineBtn {
  background-color: #e83939;
  color: white;
  border-radius: 10px;
  width: 90px;
}
.otplineBtn {
  background-color: #eda10f;
  color: white;
  border-radius: 10px;
  width: 90px;
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
  height: 500px;
  border-radius: 30px;
}
.typeEdit {
  margin-left: 20px;
  padding-top: 16px;
  width: 150px;
  font-size: 18px;
  color: black;
  line-height: 30px;
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
.checkBox {
  padding-top: 20px;
  padding-left: 20%;
}
</style>
