<template>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-5">
                            <label class="form-label fw-bold">Từ Ngày</label>
                            <input v-model="tinh_luong.begin" type="date" class="form-control">
                        </div>
                        <div class="col-lg-5">
                            <label class="form-label fw-bold">Đến Ngày</label>
                            <input v-model="tinh_luong.end" type="date" class="form-control">
                        </div>
                        <div class="col-lg-2 d-flex align-items-end">
                            <button v-on:click="tinhLuong()" class="btn btn-primary w-100">Tìm Kiếm</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center mt-2">
                    <h5 class="fw-bold">Bảng Lương</h5>
                    <button @click="xuatExcel()" type="button" class="btn btn-success me-2">
                        <i class="fa-regular fa-file-excel"></i> Xuất Excel
                    </button>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr class="align-middle">
                                <th class="text-center">#</th>
                                <th class="text-center">Tên Nhân Viên</th>
                                <th class="text-center">Số Ca Sáng</th>
                                <th class="text-center">Số Ca Chiều</th>
                                <th class="text-center">Số Ca Tối</th>
                                <th class="text-center">Tổng Số Buổi</th>
                                <th class="text-center">Thưởng/Phạt</th>
                                <th class="text-center">KPI</th>
                                <th class="text-center">Tiền Thực Nhận</th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-for="(value, index) in list" :key="index">
                                <tr class="align-middle">
                                    <th class="text-center">{{ index + 1 }}</th>
                                    <th class="text-center">{{ value.ho_va_ten }}</th>
                                    <td class="text-center">{{ value.ca_sang }}</td>
                                    <td class="text-center">{{ value.ca_chieu }}</td>
                                    <td class="text-center">{{ value.ca_toi }}</td>
                                    <td class="text-center">{{ value.ca_sang + value.ca_chieu + value.ca_toi }}</td>
                                    <td class="">{{ value.thuong - value.phat }} điểm = {{ formatDiem((value.thuong -
                                        value.phat) * 10000) }}</td>
                                    <td class="">{{ value.diem_KPI }} điểm = {{ formatDiem((value.diem_KPI) * 20000) }}
                                    </td>
                                    <td class="text-end">{{ formatVND(value) }}</td>
                                </tr>
                            </template>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios';
export default {
    data() {
        return {
            tinh_luong: {},
            list: []

        }

    },
    mounted() {

    },
    methods: {
        formatVND(value) {
            var tinh_tien = (value.ca_sang + value.ca_chieu + value.ca_toi) / 24 + ((value.thuong -
                value.phat) * 10000) + (value.diem_KPI * 20000);
            return new Intl.NumberFormat('vi-VI', { style: 'currency', currency: 'VND' }).format(tinh_tien,
            )
        },
        formatDiem(value) {
            return new Intl.NumberFormat('vi-VI', { style: 'currency', currency: 'VND' }).format(value,
            )
        },
        tinhLuong() {
            axios
                .post('http://127.0.0.1:8000/api/admin/tinh-luong', this.tinh_luong, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list = res.data.data;
                    if(res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        xuatExcel() {
            axios
                .post('http://127.0.0.1:8000/api/admin/luong/xuat-excel', this.tinh_luong, {
                    responseType: 'blob',
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status == false) {
                        this.$toast.error(res.data.message);
                    }
                    const url = window.URL.createObjectURL(new Blob([res.data]));
                    const link = document.createElement('a');
                    link.href = url;
                    link.setAttribute('download', 'luong.xlsx');
                    document.body.appendChild(link);
                    link.click();
                });
        },

    },
}
</script>
<style></style>
