// ทดสอบพฤติกรรมของระบบ เมื่อต้องรับมือกับการเพิ่มขึ้นของปริมาณการใช้งานอย่างรวดเร็ว
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 2000 }, // เพิ่มปริมาณการรับส่งข้อมูลอย่างรวมดเร็วจาก 1 เป็นสูงสุดในระยะเวลา 2 นาที
    { duration: '1m', target: 0 }, // ลดจำนวนผู้ใช้ลงเหลือ 0 คน
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