import { createRouter, createWebHistory } from "vue-router"; // cài vue-router: npm install vue-router@next --save
import checkLogin from "./checkLogin";

const routes = [];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

export default router;
