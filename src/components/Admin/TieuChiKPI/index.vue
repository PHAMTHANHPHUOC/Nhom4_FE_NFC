<template>
    <div class="row">
        <div class="col-lg-4 col-md-12">
            <div class="card">
                <div class="card-header mt-2">
                    <h5>Thêm Tiêu Chí KPI</h5>
                </div>
                <div class="card-body">
                    <div class="mb-2">
                        <label class="mb-1">Tên Tiêu Chí</label>
                        <input v-model="create_tieu_chi_kpi.ten_tieu_chi" type="text" class="form-control">
                    </div>
                    <div class="mb-2">
                        <label class="mb-1">Điểm</label>
                        <input v-model="create_tieu_chi_kpi.diem" type="number" class="form-control">
                    </div>
                    <div class="mb-2">
                        <label class="mb-1">Mô Tả</label>
                        <textarea v-model="create_tieu_chi_kpi.mo_ta" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="mb-2">
                        <label class="mb-1">Tình Trạng</label>
                        <select v-model="create_tieu_chi_kpi.tinh_trang" class="form-select">
                            <option value="1">Hiển Thị</option>
                            <option value="0">Tạm Dừng</option>
                        </select>
                    </div>
                </div>
                <div class="card-footer text-end">
                    <button @click="createTieuChiKPI()" type="button" class="btn btn-primary">Thêm Mới</button>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-md-12">
            <div class="card">
                <div class="card-header mt-2 d-flex justify-content-between align-items-center">
                    <h5>Danh Sách Tiêu Chí KPI</h5>
                    <button @click="xuatExcel()" type="button" class="btn btn-success me-2">
                        <i class="fa-regular fa-file-excel"></i> Xuất Excel
                    </button>
                </div>
                <div class="card-body">
                    <div class='table-responsive'>
                        <table class='table table-bordered table-hover'>
                            <thead>
                                <tr>
                                    <th class='align-middle text-center text-nowrap'>#</th>
                                    <th class='align-middle text-center text-nowrap'>Tên Tiêu Chí</th>
                                    <th class='align-middle text-center text-nowrap'>Điểm</th>
                                    <th class='align-middle text-center text-nowrap'>Mô Tả</th>
                                    <th class='align-middle text-center text-nowrap'>Tình Trạng</th>
                                    <th class='align-middle text-center text-nowrap'>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="(v, k) in list_tieu_chi_kpi" :key="k">
                                    <tr>
                                        <th class='align-middle text-nowrap text-center'>{{ k + 1 }}</th>
                                        <td class='align-middle text-nowrap'>{{ v.ten_tieu_chi }}</td>
                                        <td class='align-middle text-nowrap text-center'>{{ v.diem }}</td>
                                        <td class='align-middle text-nowrap'>{{ v.mo_ta }}</td>
                                        <td class="align-middle text-nowrap text-center">
                                            <template v-if="v.tinh_trang == 1">
                                                <button v-on:click="changeStatus(v)" class="btn btn-success w-100">Hiển
                                                    Thị</button>
                                            </template>
                                            <template v-else>
                                                <button v-on:click="changeStatus(v)" class="btn btn-danger w-100">Tạm
                                                    Tắt</button>
                                            </template>
                                        </td>
                                        <td class='align-middle text-nowrap text-center'>
                                            <button class="btn btn-primary me-2" data-bs-toggle='modal'
                                                v-on:click="Object.assign(edit_tieu_chi_kpi, v)"
                                                data-bs-target='#updateModal'>Cập Nhật</button>
                                            <button class="btn btn-danger" data-bs-toggle='modal'
                                                v-on:click="Object.assign(delete_tieu_chi_kpi, v)"
                                                data-bs-target='#deleteModal'>Xóa</button>
                                        </td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal update -->
        <div class='modal fade' id='updateModal' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>
            <div class='modal-dialog'>
                <div class='modal-content'>
                    <div class='modal-header'>
                        <h1 class='modal-title fs-5' id='exampleModalLabel'>Cập Nhật Tiêu Chí KPI</h1>
                        <button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>
                    </div>
                    <div class='modal-body'>
                        <div class="mb-2">
                            <label class="mb-1">Tên Tiêu Chí</label>
                            <input v-model="edit_tieu_chi_kpi.ten_tieu_chi" type="text" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="mb-1">Điểm</label>
                            <input v-model="edit_tieu_chi_kpi.diem" type="number" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="mb-1">Mô Tả</label>
                            <textarea v-model="edit_tieu_chi_kpi.mo_ta" class="form-control" rows="3"></textarea>
                        </div>
                        <div class="mb-2">
                            <label class="mb-1">Tình Trạng</label>
                            <select v-model="edit_tieu_chi_kpi.tinh_trang" class="form-select">
                                <option value="1">Hiển Thị</option>
                                <option value="0">Tạm Dừng</option>
                            </select>
                        </div>
                    </div>
                    <div class='modal-footer'>
                        <button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Đóng</button>
                        <button @click="capNhatTieuChiKPI()" type='button' class='btn btn-primary'
                            data-bs-dismiss='modal'>Xác
                            Nhận</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal delete -->
        <div class='modal fade' id='deleteModal' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>
            <div class='modal-dialog'>
                <div class='modal-content'>
                    <div class='modal-header'>
                        <h1 class='modal-title fs-5' id='exampleModalLabel'>Xóa Tiêu Chí KPI</h1>
                        <button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>
                    </div>
                    <div class='modal-body'>
                        <div class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2">
                            <div class="d-flex align-items-center">
                                <div class="font-35 text-white"><i class="bx bxs-message-square-x"></i>
                                </div>
                                <div class="ms-1">
                                    <h6 class="mb-1 text-white">Bạn chắc chắc xóa tiêu chí <b>{{
                                        delete_tieu_chi_kpi.ten_tieu_chi }}</b> này chứ
                                        !!!</h6>
                                    <div class="text-white text-nowrap"><b>LƯU Ý !!!</b> Điều này không thể khôi phục
                                        khi ấn xác nhận
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class='modal-footer'>
                        <button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Đóng</button>
                        <button @click="xoaTieuChiKPI()" type='button' class='btn btn-danger'
                            data-bs-dismiss='modal'>Xác
                            Nhận</button>
                    </div>
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
            create_tieu_chi_kpi: {},
            edit_tieu_chi_kpi: {},
            delete_tieu_chi_kpi: {},
            list_tieu_chi_kpi: [],
        }

    },
    mounted() {
        this.loadTieuChiKPI();
    },
    methods: {
        xuatExcel() {
            axios
                .get('http://127.0.0.1:8000/api/admin/tieu-chi-kpi/xuat-excel', {
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
                    link.setAttribute('download', 'tieu_chi_kpi.xlsx');
                    document.body.appendChild(link);
                    link.click();
                });
        },
        loadTieuChiKPI() {
            axios
                .get('http://127.0.0.1:8000/api/admin/tieu-chi-kpi/data', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_tieu_chi_kpi = res.data.data;
                    if(res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        createTieuChiKPI() {
            axios
                .post('http://127.0.0.1:8000/api/admin/tieu-chi-kpi/create', this.create_tieu_chi_kpi, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadTieuChiKPI();
                        this.create_tieu_chi_kpi = {};
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        },
        capNhatTieuChiKPI() {
            axios
                .post('http://127.0.0.1:8000/api/admin/tieu-chi-kpi/update', this.edit_tieu_chi_kpi, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadTieuChiKPI();
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });

        },
        xoaTieuChiKPI() {
            axios
                .post('http://127.0.0.1:8000/api/admin/tieu-chi-kpi/delete', this.delete_tieu_chi_kpi, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadTieuChiKPI();
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });

        },
        changeStatus(value) {
            axios
                .post('http://127.0.0.1:8000/api/admin/tieu-chi-kpi/change-status', value, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadTieuChiKPI();
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        }
    }
}
</script>
<style></style>
