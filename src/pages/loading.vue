<template>
  <div class="bgmain fullscreen">
    <div class="bigBox shadow-4 fixed-center" align="center">
      <div class="q-pt-md">
        <img src="../../public/images/logo.png" alt="" />
      </div>
      <div class="inputText q-mt-md">
        <q-input
          filled
          v-model="userName"
          label="ชื่อผู้ใช้งาน"
          ref="usernameBlock"
        />
      </div>
      <div class="inputText q-ma-md">
        <q-input
          v-model="password"
          filled
          label="รหัสผ่าน"
          :type="isPwd ? 'password' : 'text'"
          @keyup.enter="loginBtn"
        >
          <template v-slot:append>
            <q-icon
              :name="isPwd ? 'visibility_off' : 'visibility'"
              class="cursor-pointer"
              @click="isPwd = !isPwd"
            />
          </template>
        </q-input>
      </div>
      <div class="q-pa-md">
        <q-btn
          style="background: #FFc24c;width:120px;height45px;"
          label="เข้าสู่ระบบ"
          @click="loginBtn"
        />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      password: "",
      isPwd: true,
      userName: ""
    };
  },
  methods: {
    loginBtn() {
      this.$router.push("category");
    }
  },
  mounted() {
    this.$refs.usernameBlock.$el.focus();
  }
};
</script>

<style lang="scss" scoped>
.bgmain {
  background-image: url("../../public/images/bg.jpg");
  background-size: 100%;
  background-attachment: fixed;
}
.bigBox {
  background-color: white;
  border-radius: 30px;
  width: 600px;
  height: 450px;
}

.inputText {
  width: 330px;
  height: 55px;
  border: solid 1px #515151;
  border-radius: 5px;
}
</style>
