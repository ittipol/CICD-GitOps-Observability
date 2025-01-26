// เพื่อประเมินความเสถียรและประสิทธิภาพของระบบเมื่อใช้งานในระยะยาว
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '5m', target: 100 }, // เพิ่มปริมาณการรับส่งข้อมูลจาก 1 เป็น 100 ผู้ใช้ภายใน 5 นาที
    { duration: '8h', target: 100 }, // คงอยู่ที่ผู้ใช้ 100 คนเป็นเวลา 8 ชั่วโมง
    { duration: '5m', target: 0 }, // ลดจำนวนผู้ใช้ลงเหลือ 0 คน
  ],
};

export default () => {
  const url = 'http://host.docker.internal:5055/login';
  const payload = JSON.stringify({
    email: 'test@mail.com',
    password: '1234',
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  
  const response = http.post(url, payload, params);
  check(response, {
    'status = 200': (r) => r.status === 200
  });
  sleep(1);
};