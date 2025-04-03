import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import Auth from "./layout/wrapper/AuthMaster.vue";
import Client from "./layout/wrapper/ClientMaster.vue";
import Toaster from "@meforma/vue-toaster";
const app = createApp(App);

app.use(router, Toaster);
app.component("client-layout", Client);
app.component("auth-layout", Auth);

app.mount("#app");
