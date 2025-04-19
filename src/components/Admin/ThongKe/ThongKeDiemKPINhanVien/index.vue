<template>
  <div class="row">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <div class="row">
              <div class="col-lg-5">
                <div class="input-group">
                  <span class="input-group-text">Từ ngày</span>
                  <input
                    v-model="day.tu_ngay"
                    type="date"
                    class="form-control"
                  />
                </div>
              </div>
              <div class="col-lg-5">
                <div class="input-group">
                  <span class="input-group-text">Đến ngày</span>
                  <input
                    v-model="day.den_ngay"
                    type="date"
                    class="form-control"
                  />
                </div>
              </div>
              <div class="col-lg-2">
                <button v-on:click="thongKe()" class="btn btn-primary w-100">
                  Thống Kê
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-4">
        <div class="card">
          <div class="card-header">
            <h5 class="mt-2">THÔNG TIN ĐÃ THỐNG KÊ</h5>
          </div>
          <div class="card-body">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th class="text-center">#</th>
                  <th class="text-center">Tên Nhân Viên</th>
                  <th class="text-center">Số Điểm</th>
                </tr>
              </thead>
              <tbody>
                <template
                  v-for="(value, index) in list_kpi_nhan_vien"
                  :key="index"
                >
                  <tr>
                    <th class="text-center">{{ index + 1 }}</th>
                    <td>{{ value.ho_va_ten }}</td>
                    <td class="text-center">{{ value.so_luong_cham }}</td>
                  </tr>
                </template>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="col-md-8">
        <div class="card">
          <div class="card-header">
            <h5 class="mt-2">Thống Kê Số Điểm KPI Của Từng Nhân Viên</h5>
          </div>
          <div class="card-body">
            <Bar
              v-if="is_load == true"
              id="my-chart-id"
              :options="chartOptions"
              :data="chartData"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import { Bar } from "vue-chartjs";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);
export default {
  name: "BarChart",
  components: { Bar },
  data() {
    return {
      day: {},
      list_kpi_nhan_vien: [],
      chartData: {
        labels: [],
        datasets: [
          {
            data: [],
            backgroundColor: [
              "#C0392B",
              "#1ABC9C",
              "#F1C40F",
              "#E67E22",
              "#8E44AD",
              "#2980B9",
              "#27AE60",
            ],
          },
        ],
      },
      chartOptions: {
        responsive: true,
      },
      is_load: false,
    };
  },
  mounted() {},
  methods: {
    thongKe() {
      this.is_load = false;
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/kpi-nhan-vien/thong-ke",
          this.day,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          this.list_kpi_nhan_vien = res.data.data;
          this.chartData.labels = res.data.ten_nhan_vien;
          this.chartData.datasets[0].data = res.data.tong_so_luong_kpi;
          this.is_load = true;
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
        });
    },
  },
};
</script>
<style scoped>
.card {
  border: none;
  box-shadow: 0 2px 15px rgba(108, 43, 217, 0.1);
  border-radius: 10px;
  margin-bottom: 1.5rem;
}

.card-header {
  background-color: #f8f5ff;
  border-bottom: 1px solid rgba(108, 43, 217, 0.1);
  padding: 1rem 1.5rem;
}

.card-header h5 {
  color: #333;
  font-size: 1.1rem;
  margin: 0;
  font-weight: 600;
}

.card-body {
  padding: 1.5rem;
}

/* Input group styling */
.input-group {
  border-radius: 8px;
  overflow: hidden;
}

.input-group-text {
  background-color: #f8f5ff;
  border: 1px solid #e2d9f3;
  border-right: none;
  color: #333;
  font-weight: 500;
}

.form-control {
  border: 1px solid #e2d9f3;
  padding: 0.6rem 1rem;
  transition: all 0.3s ease;
}

.form-control:focus {
  border-color: #6c2bd9;
  box-shadow: 0 0 0 0.2rem rgba(108, 43, 217, 0.15);
}

input[type="date"].form-control {
  background-color: #fff;
  cursor: pointer;
}

/* Button styling */
.btn {
  padding: 0.6rem 1.2rem;
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.btn-primary {
  color: #6c2bd9;
  background-color: transparent;
  border: 2px solid #6c2bd9;
}

.btn-primary:hover {
  color: #fff;
  background-color: #6c2bd9;
  border-color: #6c2bd9;
}

/* Table styling */
.table {
  margin-bottom: 0;
}

.table thead th {
  background-color: #f8f5ff;
  color: #333;
  font-weight: 600;
  border-bottom: 2px solid #e2d9f3;
  padding: 1rem;
}

.table tbody td,
.table tbody th {
  color: #333;
  padding: 1rem;
  border-color: #e2d9f3;
  vertical-align: middle;
}

.table-hover tbody tr:hover {
  background-color: #f8f5ff;
}

/* Chart styling */
#my-chart-id {
  background-color: #fff;
  border-radius: 8px;
  padding: 1rem;
  min-height: 300px;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #f8f5ff;
}

::-webkit-scrollbar-thumb {
  background: #6c2bd9;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #5a23b5;
}

/* Utility classes */
.w-100 {
  width: 100% !important;
}

.text-center {
  text-align: center !important;
}

.mt-2 {
  margin-top: 0.5rem !important;
}

/* Chart colors override */
.chartjs-render-monitor {
  background-color: transparent !important;
}
</style>
