<template>
    <div class="bang-cong">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Lịch Làm Việc</h2>
        <div class="d-flex gap-2">
          <button class="btn btn-outline-primary" @click="previousWeek">
            <i class="fas fa-chevron-left"></i>
          </button>
          <span class="fw-bold mx-3">Tuần {{ weekNumber }}</span>
          <button class="btn btn-outline-primary" @click="nextWeek">
            <i class="fas fa-chevron-right"></i>
          </button>
          <button class="btn btn-primary" @click="showAddModal">
            <i class="fas fa-plus"></i> Thêm Ca Làm
          </button>
        </div>
      </div>
  
      <!-- Calendar View -->
      <div class="card">
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead>
                <tr class="text-center">
                  <th style="width: 100px">Giờ</th>
                  <th v-for="day in weekDays" :key="day.date" :class="{ 'current-day': isToday(day.date) }">
                    {{ day.name }}<br>
                    <small class="text-muted">{{ formatDateShort(day.date) }}</small>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="hour in workHours" :key="hour">
                  <td class="text-center align-middle">{{ formatHour(hour) }}</td>
                  <td 
                    v-for="day in weekDays" 
                    :key="day.date"
                    class="schedule-cell"
                    :class="getCellClass(day.date)"
                  >
                    <div v-for="shift in getMockShifts(hour, day.date)" :key="shift.id" 
                      class="shift-item"
                      :class="getShiftClass(shift.type)">
                      <div class="shift-content">
                        <strong>{{ shift.employee }}</strong><br>
                        <small>{{ shift.time }}</small>
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
  
      <!-- Rest of your modal code remains the same -->
    </div>
  </template>
  
  <script>
  import { ref, computed } from 'vue'
  import axios from 'axios'
  import { Modal } from 'bootstrap'
  
  export default {
    name: 'BangCong',
    setup() {
      const currentDate = ref(new Date())
      const workHours = ref([...Array(14)].map((_, i) => i + 7)) // 7:00 - 20:00
  
      // Mock data for demonstration
      const mockEmployees = [
        'Nguyễn Văn A',
        'Trần Thị B',
        'Lê Văn C',
        'Phạm Thị D'
      ]
  
      const weekDays = computed(() => {
        const days = []
        const startOfWeek = new Date(currentDate.value)
        startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay() + 1)
        
        for (let i = 0; i < 7; i++) {
          const day = new Date(startOfWeek)
          day.setDate(day.getDate() + i)
          days.push({
            date: day.toISOString().split('T')[0],
            name: day.toLocaleDateString('vi-VN', { weekday: 'long' })
          })
        }
        return days
      })
  
      const weekNumber = computed(() => {
        const startOfYear = new Date(currentDate.value.getFullYear(), 0, 1)
        const days = Math.floor((currentDate.value - startOfYear) / (24 * 60 * 60 * 1000))
        return Math.ceil((days + startOfYear.getDay() + 1) / 7)
      })
  
      const getMockShifts = (hour, date) => {
        // Generate some mock shifts for demonstration
        const shifts = []
        if (hour === 8) {
          shifts.push({
            id: `${date}-${hour}-1`,
            employee: mockEmployees[0],
            time: '8:00 - 12:00',
            type: 'morning'
          })
        }
        if (hour === 13) {
          shifts.push({
            id: `${date}-${hour}-2`,
            employee: mockEmployees[1],
            time: '13:00 - 17:00',
            type: 'afternoon'
          })
        }
        if (hour === 18 && new Date(date).getDay() !== 0) {
          shifts.push({
            id: `${date}-${hour}-3`,
            employee: mockEmployees[2],
            time: '18:00 - 22:00',
            type: 'evening'
          })
        }
        return shifts
      }
  
      const isToday = (date) => {
        const today = new Date().toISOString().split('T')[0]
        return date === today
      }
  
      const getCellClass = (date) => {
        return {
          'current-day': isToday(date),
          'weekend': new Date(date).getDay() === 0 || new Date(date).getDay() === 6
        }
      }
  
      const getShiftClass = (type) => {
        return {
          'shift-morning': type === 'morning',
          'shift-afternoon': type === 'afternoon',
          'shift-evening': type === 'evening'
        }
      }
  
      const formatHour = (hour) => {
        return `${hour}:00`
      }
  
      const formatDateShort = (date) => {
        return new Date(date).toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit' })
      }
  
      const previousWeek = () => {
        const newDate = new Date(currentDate.value)
        newDate.setDate(newDate.getDate() - 7)
        currentDate.value = newDate
      }
  
      const nextWeek = () => {
        const newDate = new Date(currentDate.value)
        newDate.setDate(newDate.getDate() + 7)
        currentDate.value = newDate
      }
  
      return {
        weekDays,
        workHours,
        weekNumber,
        getMockShifts,
        isToday,
        getCellClass,
        getShiftClass,
        formatHour,
        formatDateShort,
        previousWeek,
        nextWeek
      }
    }
  }
  </script>
  
  <style scoped>
  .schedule-cell {
    height: 100px;
    padding: 0.25rem;
    vertical-align: top;
  }
  
  .current-day {
    background-color: #e3f2fd;
  }
  
  .weekend {
    background-color: #f8f9fa;
  }
  
  .shift-item {
    padding: 0.5rem;
    margin-bottom: 0.25rem;
    border-radius: 4px;
    font-size: 0.875rem;
  }
  
  .shift-morning {
    background-color: #e3f2fd;
    border: 1px solid #90caf9;
  }
  
  .shift-afternoon {
    background-color: #f3e5f5;
    border: 1px solid #ce93d8;
  }
  
  .shift-evening {
    background-color: #fce4ec;
    border: 1px solid #f48fb1;
  }
  
  .shift-content {
    margin-right: 2rem;
  }
  </style>