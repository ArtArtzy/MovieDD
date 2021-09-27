<template>
  <div class="bgmain fullscreen">
    <div class="bigBox shadow-4 fixed-center" align="center">
      <div class="q-pt-md">
        <img src="../../public/images/logo.png" alt="" />
      </div>
      <div class="inputText q-mt-sm">
        <q-input
          outlined
          v-model="userName"
          label="Username"
          ref="usernameBlock"
        />
      </div>
      <div class="inputText q-ma-md">
        <q-input
          v-model="password"
          outlined
          label="Password"
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
      <div class="q-px-md q-pt-sm">
        <q-btn
          style="background: #FFc24c;width:120px;height:45px;"
          label="Sign in"
          no-caps=""
          @click="loginBtn"
        />
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      password: "",
      isPwd: true,
      userName: ""
    };
  },
  methods: {
    async loginBtn() {
      if (this.password.length > 0 && this.userName.length > 0) {
        let data = {
          username: this.userName,
          password: this.password
        };
        let url = this.serverpath + "bo_checkusername.php";
        let res = await axios.post(url, JSON.stringify(data));
        if (res.data == "NR") {
          this.$q.notify({
            message: "Username / password incorrect",
            color: "negative",
            position: "top",
            icon: "far fa-times-circle"
          });
        } else {
          let token = res.data[0].token;
          this.$q.localStorage.set("token", token);
          this.$router.push("welcome");
        }
      } else {
        this.$q.notify({
          message: "Username / password incorrect",
          color: "negative",
          position: "top",
          icon: "far fa-times-circle"
        });
      }
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
}
</style>
