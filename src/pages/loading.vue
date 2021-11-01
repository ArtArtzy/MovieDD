<template>
  <div class="bgmain fullscreen">
    <div class="bigBox shadow-4 fixed-center" align="center" v-show="loginTime">
      <div class="q-pt-sm">
        <img src="../../public/images/logo.png" alt="" />
      </div>
      <!-- กรณี login ครั้งแรก -->
      <div>
        <div class="inputText">
          <q-input
            outlined
            v-model="userName"
            label="Username"
            ref="usernameBlock"
          />
        </div>
        <div class="inputText q-ma-sm">
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

        <div
          class=" q-my-md cursor-pointer"
          style="text-decoration-line: underline;"
          @click="goToForget()"
        >
          Forget username / password
        </div>

        <div class="q-px-md">
          <q-btn
            style="background: #FFc24c;width:120px;height:45px;"
            label="Sign in"
            no-caps
            @click="loginBtn"
          />
        </div>
      </div>
    </div>
    <div class="row" v-show="!loginTime">
      <div>
        <img class="bigCow" src="../../public/images/bigcow2.png" alt="" />
      </div>
      <div class="logInAgain" align="center">
        <div class="text-black q-pt-xl" style="font-size:32px;">Moooo...</div>
        <div class="text-black" style="font-size:32px;">
          Welcome back .... {{ userNameBack }}
        </div>
        <div class="q-px-md q-pt-md">
          <q-btn
            style="background: #FFc24c;width:120px;height:45px;"
            label="Sign in"
            no-caps=""
            @click="loginBtnPass"
          />
        </div>
        <div class="cursor-pointer q-pt-md" @click="backToSigIn">
          <u>sign in as different user</u>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      loginTime: true, //เป็นการ login ครั้งแรก
      isPwd: true, //ใช้ในรูปตาในการเปิดปิด password
      password: "", //ช่องใส่ password
      userName: "", // ช่องใส่ username
      userNameBack: "" //ชื่อ username เมื่อ login ต้างไว้
    };
  },
  methods: {
    //เมื่อ user กด ข้อความ sign in as different user
    backToSigIn() {
      this.loginTime = true;
      localStorage.clear();
    },
    // ไปหน้า forget password
    goToForget() {
      this.$router.push("forgetpass");
    },
    //เมื่อกด login ในหน้า welcome back
    loginBtnPass() {
      this.$router.push("welcome");
    },
    //ทำการ login ปกติก
    async loginBtn() {
      if (this.password.length > 0 && this.userName.length > 0) {
        let data = {
          username: this.userName,
          password: this.password
        };
        let url = this.serverpath + "bo_checkusername.php";
        let res = await axios.post(url, JSON.stringify(data));
        if (res.data == "NR") {
          this.redNotify("Username / password incorrect");
        } else {
          let token = res.data[0].token;
          this.$q.localStorage.set("token", token);
          this.$q.localStorage.set("username", res.data[0].username);
          this.$router.push("welcome");
        }
      } else {
        this.redNotify("Username / password incorrect");
      }
    },
    //เมื่อ login ค้า่งไว้แล้วกลับมาอีกครั้ง
    async checkToken() {
      this.tokenData = this.$q.localStorage.getItem("token");
      if (this.tokenData !== null) {
        let data = { token: this.tokenData };
        let url = this.serverpath + "bo_checktoken.php";
        let res = await axios.post(url, JSON.stringify(data));
        if (res.data[0].us_id === null) {
          localStorage.clear();
        } else {
          this.loginTime = false;

          this.userNameBack = res.data[0].username;
        }
      }
    }
  },
  mounted() {
    this.$refs.usernameBlock.$el.focus();
    this.checkToken();
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
  height: 464px;
}

.inputText {
  width: 330px;
  height: 55px;
}
.logInAgain {
  position: absolute;
  left: 550px;
  bottom: 421px;
  background-image: url("../../public/images/ballon.png");
  width: 550px;
  height: 354px;
  border-radius: 30px;
}
.bigCow {
  position: absolute;
  bottom: 0px;
}
</style>
