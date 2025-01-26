// สามารถกำหนดลักษณะการทดสอบหลายรูปแบบ เช่น การจำลองพฤติกรรมของผู้ใช้หลายคนที่เข้ามาใช้งานระบบพร้อมกัน หรือการทดสอบการทำงานในสถานการณ์ที่แตกต่างกันในเวลาเดียวกัน ซึ่งจะช่วยให้สามารถวิเคราะห์ประสิทธิภาพของระบบเมื่อเผชิญกับโหลดที่แตกต่างกันได้
import http from "k6/http";
import { check, sleep } from 'k6';

export const options = {
  scenarios: {    
    scenario1: {    // จำนวนผู้ใช้คงที่ (constant-vus) 50 คน ใช้เวลา 30 วินาที
      executor: 'constant-vus',
      vus: 50,
      duration: '30s',
    },
    scenario2: {    // เพิ่มจำนวนผู้ใช้แบบขั้นบันได (ramping-vus) โดยเริ่มจาก 0 ไปถึง 100 และเพิ่มเป็น 200 ก่อนจะลดลงไปยัง 0
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '10s', target: 100 },
        { duration: '10s', target: 200 },
        { duration: '10s', target: 0 },
      ],
      gracefulRampDown: '10s',
    },
  },
};

export default function () {
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
}