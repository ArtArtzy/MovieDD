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
          <div class="col-2" align="right">
            <q-select
              color="orange-13"
              v-model="selectSeason"
              :options="allSeason"
              dense
              style="width:180px;font-size:16px;"
              @input="loadMovieData()"
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
        <div>
          {{ id }}
        </div>
      </div>
      <!-- Season management -->
      <q-dialog class="" v-model="dialogSeries" persistent>
        <q-card class="diaBox">
          <div class="q-pt-md" style="font-size:24px;" align="center">
            Season management
          </div>
          <div class="row q-pt-md">
            <div class="col-6 q-pl-md" align="left">Name</div>
            <div class="col-3" align="center">Edit</div>
            <div class="col-3" align="center">Delete</div>
          </div>
          <div class="q-px-md"><hr /></div>
          <div class="row" v-for="(item, index) in managementSeason">
            <div class="col-6 q-pl-md">{{ item.name }}</div>
            <div class="col-3" align="center"><u>Edit</u></div>
            <div class="col-3" align="center"><u>Delete</u></div>
          </div>
          <div class="addNewSeasonDiv cursor-pointer" @click="addNewSeason(id)">
            <u>+New Season</u>
          </div>
        </q-card>
      </q-dialog>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      id: this.$route.params.id,
      allSeason: ["season 1", "season 2", "season 3"],
      selectSeason: "season 1",
      dialogSeries: false,
      managementSeason: []
    };
  },
  methods: {
    async addSeasonBtn() {
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
      }
      this.dialogSeries = true;
    },
    async addNewSeason(id){
      
    }
  },
  mounted() {
    this.id = this.$route.params.id;
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
.bgDrop {
  background-color: rgba($color: #000000, $alpha: 0.6);
}
.diaBox {
  max-width: 900px;
  width: 450px;
  height: 250px;
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
.addNewSeasonDiv {
  background-color: #dce6ff;
  border-radius: 0px !important;
  text-align: center;
  margin-top: 10px;
  height: 40px;
  line-height: 40px;
}
</style>
