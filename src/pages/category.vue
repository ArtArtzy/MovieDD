<template>
  <div style="max-width:1600px; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite shadow-4">
        <!-- เพิ่มหมวด -->
        <div class="q-pt-lg row">
          <div class="col-10"></div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer q-pa-xs"
              style="background-color:#FFC24C;font-size:18px;"
              label="+ Category"
              no-caps=""
              @click="addBtn == 1"
            />
          </div>
        </div>
        <div class="inBox q-pt-md">
          <div class="row q-pa-sm" style="font-size:20px;" align="center">
            <div class="col">Order id</div>
            <div class="col">Category</div>
            <div class="col">Movie</div>
            <div class="col">Series</div>
            <div class="col">Status</div>
            <div class="col">Delete</div>
            <div class="col">Edit</div>
          </div>
          <hr />
          <div
            class="row q-pa-sm"
            v-for="(item, index) in data"
            :key="index"
            :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
            align="center"
          >
            <div class="col">{{ item.orderid }}</div>
            <div class="col">{{ item.catname }}</div>
            <div class="col">{{ item.movie }}</div>
            <div class="col">{{ item.series }}</div>
            <div class="col">
              <div class="onlineBtn" v-show="item.status">online</div>
              <div class="offlineBtn" v-show="!item.status">offline</div>
            </div>
            <div class="col">
              <img
                class="cursor-pointer"
                src="../../public/images/delBin.svg"
                alt=""
              />
            </div>
            <div class="col underLine cursor-pointer"><u>Edit</u></div>
          </div>
        </div>
      </div>
      <!-- bg Drop  -->
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      editBtn: 0,
      addBtn: 0,
      data: [
        {
          orderid: 100,
          catname: "ดราม่า",
          movie: 14,
          series: 6,
          status: 1
        },
        {
          orderid: 200,
          catname: "แอคชั่น",
          movie: 24,
          series: 4,
          status: 1
        },
        {
          orderid: 300,
          catname: "ไซไฟ",
          movie: 20,
          series: 8,
          status: 1
        },
        {
          orderid: 400,
          catname: "สารคดี",
          movie: 20,
          series: 8,
          status: 0
        }
      ]
    };
  },
  methods: {
    deleteBtn() {},
    editCategory() {},
    addCategory() {}
  }
};
</script>

<style lang="scss" scoped>
.boxWhite {
  width: 1200px;
  height: calc(100vh - 20px);
  background-color: rgba($color: #ffffff, $alpha: 0.5);
  border-radius: 30px;
  border: 2px solid white;
}
.brx {
  border: solid 1px red;
}
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: cover;
  background-position: center;
  padding: 10px;
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
.inBox {
  width: 95%;
  margin: auto;
}
</style>
