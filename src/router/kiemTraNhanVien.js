import axios from "axios";
import { createToaster } from "@meforma/vue-toaster";
const toaster = createToaster({ position: "top-right" });
export default function (to, from, next) {
  axios
    .post(
      "http://127.0.0.1:8000/api/kiem-tra-chia-khoa",
      {},
      {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("chia_khoa"),
        },
      }
    )
    .then((res) => {
      if (res.data.status == 200) {
        next(); // Được phép đi qua
      } else {
        next("/quan-ly/dang-nhap");
        toaster.error("Thông báo<br>" + res.data.message);
      }
    })
    .catch(() => {
      next("/quan-ly/dang-nhap");
      toaster.error("Bạn phải đăng nhập nhé!");
    });
}
