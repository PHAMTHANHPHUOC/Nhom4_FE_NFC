import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import Client from "./layout/wrapper/ClientMaster.vue";
const app = createApp(App);

app.use(router);
app.component("client-layout", Client);

app.mount("#app");
