<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
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
            <div class="col-2 q-px-md" align="left">Order id</div>
            <div class="col" align="left">Category</div>
            <div class="col-1">Movie</div>
            <div class="col-1">Series</div>
            <div class="col-1">Status</div>
            <div class="col-1">Delete</div>
            <div class="col-1">Edit</div>
          </div>
          <hr />
          <div
            class="row q-pa-sm"
            v-for="(item, index) in data"
            :key="index"
            :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
            align="center"
          >
            <div class="col-1 q-px-md" align="left">{{ item.orderid }}</div>
            <div class="col" align="left">{{ item.catname }}</div>
            <div class="col-1">{{ item.movie }}</div>
            <div class="col-1">{{ item.series }}</div>
            <div class="col-1">
              <div class="onlineBtn" v-show="item.status">online</div>
              <div class="offlineBtn" v-show="!item.status">offline</div>
            </div>
            <div class="col-1">
              <img
                class="cursor-pointer"
                src="../../public/images/delBin.svg"
                alt=""
              />
            </div>
            <div class="col-1 underLine cursor-pointer"><u>Edit</u></div>
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
