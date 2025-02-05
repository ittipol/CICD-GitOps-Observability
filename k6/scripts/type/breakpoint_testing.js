// เพื่อระบุขีดความสามารถสูงสุดของระบบในการรองรับภาระการใช้งาน
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  executor: 'ramping-arrival-rate', // การเพิ่มจำนวนของผู้ใช้เข้ามาในระบบอย่างค่อยเป็นค่อยไปในช่วงเวลาที่กำหนด 
  stages: [
    { duration: '2h', target: 20000 }, // ค่อยๆเพิ่มโหลดจนถึงจุดสูงสุด
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