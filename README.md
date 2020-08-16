## Prequisities
- Ruby 2.7.1
- Rails 6.0.3

## Unit Test (Rspec)
There is 38 examples in this application. Run the test with `rspec spec/`.

## Application
I deployed this assignment application to heroku server. You can find it at https://mini-sehatq.herokuapp.com. 
Opps, I didn't set a root path yet. So you will see an error page there. I will explain about available API endpoint in section below.

## Endpoint
### Register
You can register as a user with this endpoint: `{{host}}/api/v1/register`.

Available params: 
| params  | type |required/optional|
|---------|------|-----------------|
|full_name|string|required         |
|email    |string|required         |
|password |string|required         |
|gender   |string|optional         |
|birthday |string|optional         |
|is_doctor|string|optional         |


Example request:
```bash
curl --request POST \
  --url https://mini-sehatq.herokuapp.com/api/v1/register \
  --form 'full_name=Nicky Valentino' \
  --form email=nickyv.valentino@gmail.com \
  --form password=sehatq \
  --form gender=male \
  --form birthday=1994-06-26 \
  --form is_doctor=false
```

Example response:
```json
{
  "user": {
    "id": 1,
    "full_name": "Nicky Valentino",
    "email": "nickyv.valentino@gmail.com",
    "birthday": "1994-06-26",
    "age": 26,
    "gender": "male",
    "is_doctor": false,
    "token": "bbd52f7b4177870ab3012d9adcd1935ec56042319a1ccfc8"
  }
}
```

### Login
Endpoint: `{{host}}/api/v1/login`.

Params:
|params   |type  |required/optional|
|---------|------|-----------------|
|email    |string|required         |
|password |string|required         |

Example request:
```bash
curl --request POST \
  --url https://mini-sehatq.herokuapp.com/api/v1/login \
  --form 'email=nickyv.valentino+6@gmail.com' \
  --form password=sehatq
```

Example response:
```json
{
  "user": {
    "id": 1,
    "full_name": "Nicky Valentino",
    "email": "nickyv.valentino@gmail.com",
    "birthday": "1994-06-26",
    "age": 26,
    "gender": "male",
    "is_doctor": false,
    "token": "508621f35dad8a7ebdc34cdd02e709d0ddd4d406ccbaaa20"
  }
}
```

Register and Login endpoint have same response. And you will see `token` there. Some endpoint is restricted, you can access it if you login first. You will need this `token` to access restricted endpoint.


### Logout
Endpoint: `{{host}}/api/v1/logout`
You don't need params, but you need to put `token` at the headers.
|headers          |type  |
|-----------------|------|
|User-Access-Token|string|

Example request:
```bash
curl --request POST \
  --url https://mini-sehatq.herokuapp.com/api/v1/logout \
  --header 'user-access-token: 17de192c63e7c27ab7824e39d4dba910db98d103c11838a5'
```
Example response:
```json
{
  "message": "You have successfully logged out."
}
```

### Get Hospital List
Endpoint: `{{host}}/api/v1/hospitals`
You don't need params and headers (token), because all user can access this page (even you're not log in).
Example request:
```bash
curl --request GET \
  --url https://mini-sehatq.herokuapp.com/api/v1/hospitals
```
Example response:
```json
{
  "hospitals": [
    {
      "id": 1,
      "name": "Youth Beauty Clinic",
      "district": "Mampang Prapatan, Jakarta Selatan",
      "open_hours": "Senin - Sabtu 10:00 - 17:00",
      "support_emergency": false,
      "hospital_type": "Klinik Kulit & Kecantikan"
    },
    {
      "id": 2,
      "name": "RS Yadika Kebayoran Lama",
      "district": "Kebayoran Lama, Jakarta Selatan",
      "open_hours": "Senin - Minggu 00:00 - 23:59",
      "support_emergency": true,
      "hospital_type": "Rumah Sakit"
    }
  ]
}
```

### Get Doctor List
Endpoint: `{{host}}/api/v1/doctors`
You don't need params and headers (token), because all user can access this page (even you're not log in).
Example request:
```bash
curl --request GET \
  --url https://mini-sehatq.herokuapp.com/api/v1/doctors
```
Example response:
```json
{
  "doctors": [
    {
      "id": 2,
      "name": "drg. Andrian Nova Fitri, Sp.PM",
      "speciality": "Dokter Gigi",
      "district": "Kebayoran Baru, Jakarta Selatan",
      "hospitals": [
        {
          "id": 8,
          "name": "RS Pusat Pertamina",
          "district": "Kebayoran Baru, Jakarta Selatan",
          "open_hours": "Senin - Minggu 00:00 - 23:59",
          "support_emergency": true,
          "hospital_type": "Rumah Sakit"
        }
      ]
    },
    {
      "id": 3,
      "name": "dr. Tri Wahyu Setyaningsih, Sp.M",
      "speciality": "Dokter Spesialis Mata",
      "district": "Tebet, Jakarta Selatan",
      "hospitals": [
        {
          "id": 4,
          "name": "RS Tebet",
          "district": "Tebet, Jakarta Selatan",
          "open_hours": "Senin - Minggu 00:00 - 23:59",
          "support_emergency": true,
          "hospital_type": "Rumah Sakit"
        }
      ]
    }
  ]
}
```

### Get Doctor Schedules
Endpoint: `{{host}}/api/v1/doctors/{doctor_id}/schedules`
You don't need params and headers (token), because all user can access this page (even you're not log in). You need `doctor_id`. This endpoint is showing a doctor's schedules.
Example request:
```bash
curl --request GET \
  --url https://mini-sehatq.herokuapp.com/api/v1/doctors/2/schedules
```

Example response:
```json
{
  "id": 2,
  "name": "drg. Andrian Nova Fitri, Sp.PM",
  "speciality": "Dokter Gigi",
  "district": "Kebayoran Baru, Jakarta Selatan",
  "hospitals": [
    {
      "id": 8,
      "name": "RS Pusat Pertamina",
      "district": "Kebayoran Baru, Jakarta Selatan",
      "open_hours": "Senin - Minggu 00:00 - 23:59",
      "support_emergency": true,
      "hospital_type": "Rumah Sakit",
      "schedules": [
        {
          "id": 1,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "09:00 - 09:20",
          "booked": true
        },
        {
          "id": 2,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "09:30 - 09:50",
          "booked": false
        },
        {
          "id": 3,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "10:00 - 10:20",
          "booked": false
        },
        {
          "id": 4,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "10:30 - 10:50",
          "booked": false
        },
        {
          "id": 5,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "11:00 - 11:20",
          "booked": false
        },
        {
          "id": 6,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "11:30 - 11:50",
          "booked": false
        },
        {
          "id": 7,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "13:00 - 13:20",
          "booked": false
        },
        {
          "id": 8,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "13:30 - 13:50",
          "booked": false
        },
        {
          "id": 9,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "14:00 - 14:20",
          "booked": false
        },
        {
          "id": 10,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "14:30 - 14:50",
          "booked": false
        },
        {
          "id": 11,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "15:00 - 15:20",
          "booked": false
        }
      ]
    }
  ]
}
```

### Create an Order
Endpoint: `{{host}}/api/v1/orders`
You must login if you want to make an order.
Header:
|headers          |type  |
|-----------------|------|
|User-Access-Token|string|

Params:
|params      |type    |required/optional|
|------------|--------|-----------------|
|user_id     |integer |required         |
|doctor_id   |integer |required         |
|schedule_id |integer |required         |
|payment_type|string  |optional         |
|notes       |string  |optional         |

You can get `doctor_id` and `schedule_id` from `{{host}}/api/v1/doctors/{doctor_id}/schedules`.
Example request:
```bash
curl --request POST \
  --url https://mini-sehatq.herokuapp.com/api/v1/orders \
  --header 'user-access-token: bbd52f7b4177870ab3012d9adcd1935ec56042319a1ccfc8' \
  --form user_id=1 \
  --form doctor_id=2 \
  --form schedule_id=1 \
  --form payment_type=personal \
  --form 'notes=Gusi bengkak'
```
Example response:
```json
{
  "id": 1,
  "code": "T8ZOUH",
  "status": "pending",
  "payment_type": "personal",
  "notes": "Gusi bengkak",
  "district": "Kebayoran Baru, Jakarta Selatan",
  "schedule_date": "Sunday, 23 August 2020",
  "schedule_hour": "09:00 - 09:20",
  "hospital": {
    "id": 8,
    "name": "RS Pusat Pertamina",
    "support_emergency": true,
    "hospital_type": "Rumah Sakit"
  },
  "doctor": {
    "id": 2,
    "name": "drg. Andrian Nova Fitri, Sp.PM",
    "speciality": "Dokter Gigi"
  }
}
```

### Make your order status to paid
By default, when you make order, your order status is `pending`. This order status will change to `paid` if you proccess your order to payment. But I don't have payment gateway yet, so I make an endpoint to change order status. Endpoint: `{{host}}/api/v1/orders/{order_id}/checkout`. You need to define `order_id`, you can get it after create an order.

Example request:
```bash
curl --request POST \
  --url https://mini-sehatq.herokuapp.com/api/v1/orders/1/checkout \
  --header 'user-access-token: 0756134bc7860f173844edbedc602858d4a05b613ff2b7da'
```

Example response:
```json
{
  "id": 1,
  "code": "T8ZOUH",
  "status": "paid",
  "payment_type": "personal",
  "notes": "Gusi bengkak",
  "district": "Kebayoran Baru, Jakarta Selatan",
  "schedule_date": "Sunday, 23 August 2020",
  "schedule_hour": "09:00 - 09:20",
  "hospital": {
    "id": 8,
    "name": "RS Pusat Pertamina",
    "support_emergency": true,
    "hospital_type": "Rumah Sakit"
  },
  "doctor": {
    "id": 2,
    "name": "drg. Andrian Nova Fitri, Sp.PM",
    "speciality": "Dokter Gigi"
  }
}
```

### List Appointments (for doctor)
Doctor can see appointments with his patient through this endpoint. Endpoint: `{{host}}/api/v1/doctors/{doctor_id}/appointments`.

Params:
|params      |type    |required/optional|
|------------|--------|-----------------|
|date        |string  |required         |

Example request:
```bash
curl --request GET \
  --url https://mini-sehatq.herokuapp.com/api/v1/doctors/2/appointments \
  --form date=2020-08-23
```

Example response:
```json
{
  "appointments": [
    {
      "hospital": "RS Pusat Pertamina",
      "district": "Kebayoran Baru, Jakarta Selatan",
      "date": "Sunday, 23 August 2020",
      "time": "09:00 - 09:20",
      "patient": "Nicky Valentino",
      "gender": "male",
      "age": 26
    }
  ]
}
```
