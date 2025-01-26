// ตรวจสอบว่าระบบทำงานได้ดีภายใต้ภาระงานขั้นต่ำ และเพื่อรวบรวมค่าประสิทธิภาพพื้นฐาน
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 3, // จำนวน user ในการทดสอบควรอยู่ที่ 1 - 5 VUs
  duration: '1m', // ระยะการทดสอบ 1 นาที สามารถปรับให้น้อยลงได้
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