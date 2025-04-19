<template>
    <div class="row" id="app">
        <div class="col-md-3">
            <div class="card ">
                <div class="card-header mt-2">
                    <h5><b> Thêm Mới Loại Hợp Đồng </b></h5>
                </div>
                <div class="card-body">
                    <label class="form-lable">Tên Hợp Đồng</label>
                    <input v-model="create_loai_hop_dong.ten_hop_dong" class="form-control mt-1" type="text">
                    <label class="form-lable mt-2">Nội Dung</label>
                    <!-- <textarea v-model="create_loai_hop_dong.noi_dung" class="form-control" cols="30"
                        rows="10"></textarea> -->
                    <ckeditor v-model="create_loai_hop_dong.noi_dung" :editor="editor" :config="editorConfig" />
                    <label class="form-lable mt-2"> Tình Trạng</label>
                    <select v-model="create_loai_hop_dong.tinh_trang" class="form-control">
                        <option value="1">Hiển Thị</option>
                        <option value="0">Tạm Dừng</option>
                    </select>
                </div>
                <div class="card-footer text-end">
                    <button @click="createLoaiHopDong()" class="btn btn-primary">Thêm Mới Hợp Đồng</button>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="card">
                <div class="card-header mt-2 d-flex justify-content-between align-items-center">
                    <h5><b>Danh Sách Loại Hợp Đồng</b></h5>
                    <button @click="xuatExcel()" type="button" class="btn btn-success me-2">
                        <i class="fa-regular fa-file-excel"></i> Xuất Excel
                    </button>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th class="text-center align-middle text-nowrap">#</th>
                                    <th class="text-center align-middle text-nowrap">Tên Hợp Đồng</th>
                                    <th class="text-center align-middle text-nowrap">Nội Dung</th>
                                    <th class="text-center align-middle text-nowrap">Tình Trạng</th>
                                    <th class="text-center align-middle text-nowrap">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="(v, k) in list_loai_hop_dong" :key="k">
                                    <tr>
                                        <th class="text-center align-middle text-nowrap">{{ k + 1 }}</th>
                                        <td class="align-middle text-nowrap">{{ v.ten_hop_dong }}</td>
                                        <td class="align-middle text-nowrap text-center" data-bs-toggle="modal"
                                            data-bs-target="#noi_dung">
                                            <i v-on:click="noi_dung_hop_dong = v.noi_dung"
                                                class="fa-solid fa-file-contract fa-xl"></i>
                                        </td>
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
                                                v-on:click="Object.assign(edit_loai_hop_dong, v)"
                                                data-bs-target="#editModal">Cập Nhật</button>
                                            <button class="btn btn-danger" data-bs-toggle="modal"
                                                v-on:click="Object.assign(delete_loai_hop_dong, v)"
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
                                <h5 class="modal-title" id="exampleModalLabel">Xóa Loại Hợp Đồng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2">
                                    <div class="d-flex align-items-center">
                                        <div class="font-35 text-white"><i class="bx bxs-message-square-x"></i>
                                        </div>
                                        <div class="ms-1">
                                            <h6 class="mb-1 text-white">Bạn chắc chắc xóa Loại Hợp Đồng <b>{{
                                                delete_loai_hop_dong.ten_hop_dong }}</b> này chứ
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
                                <button @click="xoaLoaiHopDong()" type="button" class="btn btn-danger"
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
                                <h5 class="modal-title" id="exampleModalLabel">Chỉnh Sửa Loại Hợp Đồng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <label class="form-lable">Tên Hợp Đồng</label>
                                <input v-model="edit_loai_hop_dong.ten_hop_dong" class="form-control mt-1" type="text">
                                <label class="form-lable mt-2">Nội Dung</label>
                                <!-- <textarea v-model="edit_loai_hop_dong.noi_dung" class="form-control" cols="30"
                                    rows="10"></textarea> -->
                                <ckeditor v-model="edit_loai_hop_dong.noi_dung" :editor="editor"
                                    :config="editorConfig" />
                                <label class="form-lable mt-2"> Tình Trạng</label>
                                <select v-model="edit_loai_hop_dong.tinh_trang" class="form-control">
                                    <option value="1">Hiển Thị</option>
                                    <option value="0">Tạm Dừng</option>
                                </select>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button @click="capNhatLoaiHopDong()" type="button" class="btn btn-primary"
                                    data-bs-dismiss="modal">Xác
                                    Nhận</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="noi_dung" tabindex="-1" aria-labelledby="exampleModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-dialog-scrollable">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Nội Dung Hợp Đồng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <span v-html="noi_dung_hop_dong"></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
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
import { ClassicEditor, Bold, Essentials, Italic, Mention, Paragraph, Undo, Heading, BlockQuote, Font, Link, List, Alignment } from 'ckeditor5';
import { Ckeditor } from '@ckeditor/ckeditor5-vue';
import 'ckeditor5/ckeditor5.css';
export default {
    components: {
        Ckeditor
    },
    data() {
        return {
            create_loai_hop_dong: {},
            edit_loai_hop_dong: {},
            delete_loai_hop_dong: {},
            list_loai_hop_dong: [],
            noi_dung_hop_dong: '',
            editor: ClassicEditor,
            editorConfig: {
                plugins: [Bold, Essentials, Italic, Mention, Paragraph, Undo, Heading, BlockQuote, Font, Link, List, Alignment],
                toolbar: ['heading',
                    '|', 'undo', 'redo', '|', 'bold', 'italic',
                    'fontSize',
                    'fontFamily',
                    'fontColor',
                    '|',
                    'link',
                    'bulletedList',
                    'numberedList',
                    'blockQuote',
                    '|',
                    'Alignment'
                ],
            }
        }

    },
    mounted() {
        this.loadLoaiHopDong();
    },
    methods: {
        xuatExcel() {
            axios
                .get('http://127.0.0.1:8000/api/admin/loai-hop-dong/xuat-excel', {
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
                    link.setAttribute('download', 'loai_hop_dong.xlsx');
                    document.body.appendChild(link);
                    link.click();
                });
        },
        loadLoaiHopDong() {
            axios
                .get('http://127.0.0.1:8000/api/admin/loai-hop-dong/data', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_loai_hop_dong = res.data.data;
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        createLoaiHopDong() {
            axios
                .post('http://127.0.0.1:8000/api/admin/loai-hop-dong/create', this.create_loai_hop_dong, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadLoaiHopDong();
                        this.create_loai_hop_dong = {};
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
        capNhatLoaiHopDong() {
            axios
                .post('http://127.0.0.1:8000/api/admin/loai-hop-dong/update', this.edit_loai_hop_dong, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadLoaiHopDong();
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
        xoaLoaiHopDong() {
            axios
                .post('http://127.0.0.1:8000/api/admin/loai-hop-dong/delete', this.delete_loai_hop_dong, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadLoaiHopDong();
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
                .post('http://127.0.0.1:8000/api/admin/loai-hop-dong/change-status', value, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadLoaiHopDong();
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
<style>
.ck-editor__editable {
    min-height: 300px;
}
</style>