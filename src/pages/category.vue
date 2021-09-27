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
              @click="addBtn = true"
            />
          </div>
        </div>
        <div class="inBox q-pt-md">
          <div class="row q-pa-sm" style="font-size:20px;" align="center">
            <div class="col-2 q-px-md" align="left">Order id</div>
            <div class="col" align="left">Category</div>
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
            <div class="col-2 q-px-md" align="left">{{ item.orderid }}</div>
            <div class="col" align="left">{{ item.catname }}</div>
            <div class="col">{{ item.movie }}</div>
            <div class="col">{{ item.series }}</div>
            <div class="col">
              <div class="onlineBtn" v-show="item.status">online</div>
              <div class="offlineBtn" v-show="!item.status">offline</div>
            </div>
            <div class="col-1">
              <img
                class="cursor-pointer"
                src="../../public/images/delBin.svg"
                alt=""
                @click="deleteBtn(item.orderid)"
              />
            </div>
            <div
              class="col-1 underLine cursor-pointer"
              @click="editCategory(item.orderid)"
            >
              <u>Edit</u>
            </div>
          </div>
        </div>
      </div>
      <!-- dialog Box -->
      <!-- delete  -->
      <q-dialog v-model="delBtn" persistent>
        <q-card>
          <div class="delBox" align="center">
            <q-icon
              class="fas fa-exclamation-circle q-pa-md"
              size="64px"
              color="red"
            />
            <div style="font-size:24px;">Are you sure?</div>
            <div style="font-size:14px;">
              You want to delete this category !
            </div>
            <div class="row q-pt-md" style="width:280px;margin:auto;">
              <div class="ynBtn q-ma-sm" @click="delBtn = false">Cancel</div>
              <div class="ynBtn q-ma-sm" style="background-color:#ffc24c">
                Yes
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>

      <!-- Add  -->
      <q-dialog v-model="addBtn" persistent>
        <q-card class="editBox">
          <div class="">
            <div
              class="q-pa-md"
              style="font-size:24px;color:#797575;"
              align="center"
            >
              Add new category
            </div>
            <div class="row">
              <div class="typeEdit">
                Order id
              </div>
              <div style="width:300px;margin:auto;">
                <q-input v-model="editId" label="000" />
              </div>
            </div>
            <div class="row ">
              <div class="typeEdit">
                Category name
              </div>
              <div class="" style="width:300px;margin:auto;">
                <q-input v-model="editId" label="category" />
              </div>
            </div>
            <div class="row q-pt-md" style="width:350px;margin:auto;">
              <div class="ynBtn q-ma-sm" @click="addBtn = false" align="center">
                Cancel
              </div>
              <div class="q-pa-md"></div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c;"
                align="center"
              >
                Yes
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>

      <!-- edit  -->
      <q-dialog v-model="editBtn" persistent>
        <q-card class="editBox">
          <div class="">
            <div
              class="q-pa-md"
              style="font-size:24px;color:#797575;"
              align="center"
            >
              Edit category
            </div>
            <div class="row">
              <div class="typeEdit">
                Order id
              </div>
              <div style="width:300px;margin:auto;">
                <q-input v-model="editId" label="000" />
              </div>
            </div>
            <div class="row ">
              <div class="typeEdit">
                Category name
              </div>
              <div class="" style="width:300px;margin:auto;">
                <q-input v-model="editId" label="category" />
              </div>
            </div>
            <div class="row q-pt-md" style="width:350px;margin:auto;">
              <div
                class="ynBtn q-ma-sm"
                @click="editBtn = false"
                align="center"
              >
                Cancel
              </div>
              <div class="q-pa-md"></div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c;"
                align="center"
              >
                Yes
              </div>
            </div>
          </div>
        </q-card>
      </q-dialog>
      <!-- bg drop  -->
      <div class="bgDrop fullscreen" v-show="addBtn || editBtn || delBtn"></div>

      <!-- end bgDrop  -->
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
      editId: "",
      editCat: "",
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
    deleteBtn(item) {
      this.delBtn = true;
    },
    editCategory(item) {
      this.editBtn = true;
    }
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
.bgDrop {
  background-color: rgba($color: #0f2c78, $alpha: 0.6);
}
.delBox {
  width: 400px;
  height: 250px;
  background-color: #edf2fe;
  border-radius: 10px;
}
.ynBtn {
  width: 120px;
  height: 45px;
  border-radius: 5px;
  border: 1px solid #ffc24c;
  cursor: pointer;
  line-height: 45px;
}
.editBox {
  width: 600px;
  height: 300px;
  border-radius: 20px;
  background-color: #edf2fe;
}
.typeEdit {
  margin-left: 20px;
  padding-top: 16px;
  width: 150px;
  font-size: 18px;
  color: #797575;
  line-height: 30px;
}
</style>
