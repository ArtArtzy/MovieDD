<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
      <div class="boxWhite ">
        <!-- เพิ่มหมวด -->
        <div class="row items-center q-pt-lg">
          <div class="col"></div>
          <div class="col-2" align="center">
            <q-btn
              rounded
              class="cursor-pointer"
              style="background-color:#FFC24C;font-size:18px;width:160px"
              label="+ Category"
              no-caps=""
              @click="addBtn = true"
            />
          </div>
        </div>
        <div class="inBox q-pt-md">
          <div class="row q-pa-sm" style="font-size:20px;" align="center">
            <div class="col-1" align="left">No.</div>
            <div class="col-2" align="left">Order id</div>
            <div class="col-2" align="left">Category</div>
            <div class="col">Movie</div>
            <div class="col">Series</div>
            <div class="col">Status</div>
            <div class="col">Delete</div>
            <div class="col">Edit</div>
          </div>
          <hr />
          <q-scroll-area class="" style="height:80vh; max-width: 90vw;">
            <div
              class="row q-pa-sm"
              v-for="(item, index) in data"
              :key="index"
              :style="index % 2 == 1 ? 'background-color:#cedff2' : ''"
              align="center"
            >
              <div class="col-1 q-pl-sm" align="left">{{ index + 1 }}</div>
              <div class="col-2 q-pl-sm" align="left">{{ item.orderid }}</div>
              <div class="col-2 q-pl-sm" align="left">{{ item.catname }}</div>
              <div class="col ">{{ item.movie }}</div>
              <div class="col">{{ item.series }}</div>
              <div class="col">
                <div
                  class="onlineBtn cursor-pointer"
                  v-show="item.status == 1"
                  @click="changeSta(item)"
                >
                  online
                </div>
                <div
                  class="offlineBtn cursor-pointer"
                  v-show="item.status == 0"
                  @click="changeSta(item)"
                >
                  offline
                </div>
              </div>
              <div class="col">
                <img
                  class="cursor-pointer "
                  src="../../public/images/delBin.svg"
                  alt=""
                  @click="deleteBtn(item)"
                />
              </div>
              <div
                class="col underLine cursor-pointer"
                @click="editCategory(item)"
              >
                <u>Edit</u>
              </div>
            </div>
          </q-scroll-area>
        </div>
      </div>
      <!-- dialog Box -->
      <!-- delete  -->
      <q-dialog v-model="delBtn" persistent>
        <q-card class="delBox">
          <div align="center">
            <q-icon
              class="fas fa-exclamation-triangle q-mt-lg"
              size="80px"
              style="color:#ffc24c;"
            />
            <div class="q-pt-md" style="font-size:24px;">
              You want to delete
              <span class="text-red"> {{ editCat }}</span
              >.
            </div>
            <div style="font-size:14px;">This item cannot be restore</div>
            <div class="row q-pt-md" style="width:370px;margin:auto;">
              <div class="ynBtn q-ma-sm" @click="clrmem()">Cancel</div>
              <div class="col"></div>
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
              <div class="col-1"></div>
              <div class="typeEdit">
                Order id
              </div>
              <div style="width:280px;">
                <q-input v-model="editId" />
              </div>
            </div>
            <div class="row ">
              <div class="col-1"></div>
              <div class="typeEdit">
                Category name
              </div>
              <div class="" style="width:280px;">
                <q-input v-model="editCat" />
              </div>
            </div>
            <div class="row q-pt-lg" style="width:370px;margin:auto;">
              <div class="ynBtn q-ma-sm" @click="clrmem()" align="center">
                Cancel
              </div>
              <div class="col"></div>
              <div
                class="ynBtn q-ma-sm"
                style="background-color:#ffc24c;"
                align="center"
                @click="addCat()"
              >
                OK
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
              <div class="col-1"></div>
              <div class="typeEdit">
                Order id
              </div>
              <div style="width:280px;">
                <q-input v-model="editId" />
              </div>
            </div>
            <div class="row ">
              <div class="col-1"></div>
              <div class="typeEdit">
                Category name
              </div>
              <div class="" style="width:280px;">
                <q-input v-model="editCat" />
              </div>
            </div>
            <div class="row q-pt-lg" style="width:370px;margin:auto;">
              <div class="ynBtn q-ma-sm" @click="clrmem()" align="center">
                Cancel
              </div>
              <div class="col"></div>
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
      <!-- bg drop  -->
      <div class="bgDrop fullscreen" v-show="addBtn || editBtn || delBtn"></div>
      <!-- end bgDrop  -->
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      editBtn: false,
      addBtn: false,
      delBtn: false,
      editId: "",
      editCat: "",
      indexId: 0,
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
        }
      ]
    };
  },
  methods: {
    // เคลียร์ค่าในตัว จำค่า
    clrmem() {
      this.editId = "";
      this.editCat = "";
      this.indexId = 0;
      this.editBtn = this.addBtn = this.delBtn = false;
    },
    // กด save ของ dialog  add
    async addCat() {
      // ไม่ได้ใส่ order id กับ categry
      if (this.editId == "" || this.editCat == "") {
        this.redNotify("Plese input Order and Category");
        return;
      } else {
        let data = {
          orderid: this.editId,
          catname: this.editCat
        };
        let url = this.serverpath + "bo_addcategory.php";
        let res = await axios.post(url, JSON.stringify(data));
        //  order id ซ้ำ
        if (res.data == "NR") {
          this.redNotify("This Order id  exist");
          this.editId = "";
        } else if (res.data == "NRC") {
          //  category ซ้ำ
          this.redNotify("This Category exist");
          this.editCat = "";
        } else if (res.data == "OK") {
          this.greenNotify("Add new category complete");
          this.clrmem();
          this.loadData();
        }
      }
    },
    // เปลี่ยน status offline/online
    async changeSta(item) {
      let sta = 0;
      if (item.status == 0) sta = 1;
      let data = {
        id: item.id,
        status: sta
      };
      let url = this.serverpath + "bo_changestatuscategory.php";
      let res = await axios.post(url, JSON.stringify(data));
      // if (sta == 1) this.greenNotify(item.catname + " Online");
      // else this.redNotify(item.catname + " Offline");
      this.loadData();
    },
    // กดปุ่ม delete หมวดหนัง
    deleteBtn(item) {
      if (item.movie > 0 || item.series > 0) {
        // มี หนังหรือซีรี่อยู่ลบไม่ได้
        this.redNotify("This category have a movie/series");
        return;
      }
      this.delBtn = true;
      this.editId = item.orderid;
      this.indexId = item.id;
      this.editCat = item.catname;
    },
    // กดปุ่ม ok ใน dialog delete
    async deleteOk() {
      let data = {
        id: this.indexId
      };
      let url = this.serverpath + "bo_delcategory.php";
      let res = await axios.post(url, JSON.stringify(data));
      this.greenNotify("Delete category complete");
      this.clrmem();
      this.loadData();
    },
    // กดปุ่ม Edit
    editCategory(item) {
      this.editBtn = true;
      this.editId = item.orderid;
      this.editCat = item.catname;
      this.indexId = item.id;
    },
    // กดปุ่ม save ใน dialog edit หมวดหนัง
    async editOk() {
      if (this.editId == "" || this.editCat == "") {
        // ไม่ได้ใส่ order id กับ categry
        this.redNotify("Plese input order id and category");
        return;
      }
      let data = {
        id: this.indexId,
        orderid: this.editId,
        catname: this.editCat
      };
      let url = this.serverpath + "bo_editcategory.php";
      let res = await axios.post(url, JSON.stringify(data));
      if (res.data == "OK") {
        this.greenNotify("Edit category complete");
        this.clrmem();
        this.loadData();
      } else if (res.data == "notchange") {
        this.clrmem();
        this.loadData();
      } else {
        this.redNotify(res.data);
      }
    },
    async loadData() {
      let url = this.serverpath + "bo_loadcategory.php";
      let res = await axios.get(url);
      this.data = res.data;
      this.data.sort((a, b) => a.orderid - b.orderid);
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
  width: 500px;
  height: 275px;
  background-color: #edf2fe;
  border-radius: 30px;
}
.ynBtn {
  width: 160px;
  height: 50px;
  border-radius: 5px;
  border: 1px solid #ffc24c;
  cursor: pointer;
  line-height: 50px;
  font-size: 18px;
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
  line-height: 40px;
}
</style>
