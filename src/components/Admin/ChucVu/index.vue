<template>
    <div class="row" id="app">
        <div class="col-md-3">
            <div class="card ">
                <div class="card-header mt-2">
                    <h5><b> Thêm Mới Chức Vụ </b></h5>

                </div>
                <div class="card-body">
                    <label class="form-lable">Tên Chức Vụ</label>
                    <input v-model="create_chuc_vu.ten_chuc_vu" class="form-control mt-1" type="text">
                    <label class="form-lable mt-2"> Tình Trạng</label>
                    <select v-model="create_chuc_vu.tinh_trang" class="form-control">
                        <option value="1">Hiển Thị</option>
                        <option value="0">Tạm Dừng</option>
                    </select>
                </div>
                <div class="card-footer text-end">
                    <button @click="createChucVu()" class="btn btn-primary">Thêm Mới Chức Vụ</button>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="card">
                <div class="card-header mt-2 d-flex justify-content-between align-items-center">
                    <h5><b>Danh Sách Chức Vụ</b></h5>
                    <button @click="xuatExcel()" class="btn btn-success"><i class="fa-regular fa-file-excel"></i> Xuất
                        Excel</button>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th class="text-center align-middle text-nowrap">#</th>
                                    <th class="text-center align-middle text-nowrap">Tên Chức Vụ</th>
                                    <th class="text-center align-middle text-nowrap">Tình Trạng</th>
                                    <th class="text-center align-middle text-nowrap">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="(v, k) in list_chuc_vu" :key="k">
                                    <tr>
                                        <th class="text-center align-middle text-nowrap">{{ k + 1 }}</th>
                                        <td class="align-middle text-nowrap">{{ v.ten_chuc_vu }}</td>
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
                                        <td class="text-center align-middle text-nowrap">
                                            <button class="btn btn-info me-2" data-bs-toggle="modal"
                                                v-on:click="Object.assign(edit_chuc_vu, v)"
                                                data-bs-target="#editModal">Cập Nhật</button>
                                            <button class="btn btn-danger" data-bs-toggle="modal"
                                                v-on:click="Object.assign(delete_chuc_vu, v)"
                                                data-bs-target="#deleteModal">Xóa Bỏ</button>
                                        </td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Xóa Chức Vụ</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2">
                                    <div class="d-flex align-items-center">
                                        <div class="font-35 text-white"><i class="bx bxs-message-square-x"></i>
                                        </div>
                                        <div class="ms-1">
                                            <h6 class="mb-1 text-white">Bạn chắc chắc xóa chức vụ <b>{{
                                                delete_chuc_vu.ten_chuc_vu
                                            }}</b> này chứ
                                                !!!</h6>
                                            <div class="text-white text-nowrap"><b>LƯU Ý !!!</b> Điều này không thể khôi
                                                phục
                                                khi ấn xác nhận
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button @click="xoaChucVu()" type="button" class="btn btn-danger"
                                    data-bs-dismiss="modal">Xác
                                    Nhận</button>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Chỉnh Sửa Chức Vụ</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <label class="form-lable">Tên Chức Vụ</label>
                                <input v-model="edit_chuc_vu.ten_chuc_vu" class="form-control mt-1" type="text">
                                <label class="form-lable mt-2"> Tình Trạng</label>
                                <select v-model="edit_chuc_vu.tinh_trang" class="form-control">
                                    <option value="1">Hiển Thị</option>
                                    <option value="0">Tạm Dừng</option>
                                </select>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button @click="capNhatChucVu()" type="button" class="btn btn-primary"
                                    data-bs-dismiss="modal">Xác
                                    Nhận</button>
                            </div>
                        </div>
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
            create_chuc_vu: {},
            edit_chuc_vu: {},
            delete_chuc_vu: {},
            list_chuc_vu: [],
        }

    },
    mounted() {
        this.loadChucVu();
    },
    methods: {
        xuatExcel() {
            axios
                .get('http://127.0.0.1:8000/api/admin/chuc-vu/xuat-excel', {
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
                    link.setAttribute('download', 'chuc_vu.xlsx');
                    document.body.appendChild(link);
                    link.click();
                });
        },
        loadChucVu() {
            axios
                .get('http://127.0.0.1:8000/api/admin/chuc-vu/data', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_chuc_vu = res.data.data;
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        createChucVu() {
            axios
                .post('http://127.0.0.1:8000/api/admin/chuc-vu/create', this.create_chuc_vu, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadChucVu();
                        this.create_chuc_vu = {};
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
        capNhatChucVu() {
            axios
                .post('http://127.0.0.1:8000/api/admin/chuc-vu/update', this.edit_chuc_vu, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadChucVu();
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
        xoaChucVu() {
            axios
                .post('http://127.0.0.1:8000/api/admin/chuc-vu/delete', this.delete_chuc_vu, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadChucVu();
                    }  else {
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
                .post('http://127.0.0.1:8000/api/admin/chuc-vu/change-status', value, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadChucVu();
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
