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
                                    <input v-model="day.tu_ngay" type="date" class="form-control">
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="input-group">
                                    <span class="input-group-text">Đến ngày</span>
                                    <input v-model="day.den_ngay" type="date" class="form-control">
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <button v-on:click="thongKe()" class="btn btn-primary w-100">Thống Kê</button>
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
                                    <th class="text-center">Số Ca Làm</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="(value, index) in list_cham_cong" :key="index">
                                    <tr>
                                        <th class="text-center">{{ index + 1 }}</th>
                                        <td>{{ value.ho_va_ten }}</td>
                                        <td class="text-center">{{ value.so_luong_ca }}</td>
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
                        <h5 class="mt-2">Thống Kê Số Ca Chấm Công Của Từng Nhân Viên</h5>
                    </div>
                    <div class="card-body">
                        <Bar v-if="is_load == true" id="my-chart-id" :options="chartOptions" :data="chartData" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
export default {
    name: 'BarChart',
    components: { Bar },
    data() {
        return {
            day: {},
            list_cham_cong: [],
            chartData: {
                labels: [],
                datasets: [
                    {
                        data: [],
                        backgroundColor: ["#C0392B", "#1ABC9C", "#F1C40F", "#E67E22", "#8E44AD", "#2980B9", "#27AE60"]
                    }
                ]
            },
            chartOptions: {
                responsive: true
            },
            is_load: false
        }
    },
    mounted() {

    },
    methods: {
        thongKe() {
            this.is_load = false
            axios
                .post('http://127.0.0.1:8000/api/admin/cham-cong/thong-ke', this.day, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_cham_cong = res.data.data;
                    this.chartData.labels = res.data.ten_nhan_vien;
                    this.chartData.datasets[0].data = res.data.tong_so_luong_ca;
                    this.is_load = true;
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        }
    },
}
</script>
<style></style>
