<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <div class="q-pt-lg row">
          <div class="col-10"></div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer q-pa-xs"
              style="background-color:#FFC24C;font-size:18px;"
              label="+ Category"
              no-caps=""
              @click="addBtn = true"
            />
          </div>
        </div>
        <div class="inBox q-pt-md">
          <div class="row q-pa-sm" style="font-size:20px;" align="center">
            <div class="col-2 q-px-md" align="left">Username</div>
            <div class="col-2">Password</div>
            <div class="col">cat</div>
            <div class="col">mov</div>
            <div class="col">ser</div>
            <div class="col">ana</div>
            <div class="col">user</div>
            <div class="col">userana</div>
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
            <div class="col">{{ item.us_category }}</div>
            <div class="col">{{ item.us_category }}</div>
            <div class="col">{{ item.us_category }}</div>
            <div class="col">{{ item.us_category }}</div>
            <div class="col">{{ item.us_category }}</div>
            <div class="col">{{ item.us_category }}</div>
            <div class="col brx">
              <img
                class="cursor-pointer"
                src="../../public/images/delBin.svg"
                alt=""
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
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      editBtn: false,
      addBtn: false,
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
      ]
    };
  },
  methods: {
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
</style>
