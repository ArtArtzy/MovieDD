<template>
  <div style="max-width:1600px; width:100%; margin:auto;" class="bgmain">
    <div class="contentDiv">
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
              @click="addSeriesBtn()"
            />
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
      allSeason: ["season 1", "season 2", "season 3"],
      selectSeason: "season 1"
    };
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
