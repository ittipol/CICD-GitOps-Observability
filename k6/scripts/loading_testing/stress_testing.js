// เพื่อประเมินความสามารถของระบบ ในการจัดการกับภาระการใช้งานที่เกินกว่าที่คาดหวัง หรือในสถานการณ์วิกฤติ
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '10m', target: 200 }, // เพิ่มปริมาณการรับส่งข้อมูลจาก 1 เป็น 200 ผู้ใช้ภายใน 5 นาที
    { duration: '30m', target: 200 }, // คงอยู่ที่ผู้ใช้ 200 คนเป็นเวลา 30 นาที
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