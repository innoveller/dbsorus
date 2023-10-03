@table: booking_session

| id         | hotel_id     | agent_id | check_in_date | check_out_date | number_of_rooms | number_of_guests | room_selections   | created_at      | updated_at       | guest_type | value_added_promotion_id | agent_hotel_id |
|------------|--------------|----------|---------------|----------------|-----------------|------------------|-------------------|-----------------|------------------|------------|--------------------------|----------------|
| @uuid:bs_1 | @int:aureum  | @int:a1  | 2023-10-01    | 2023-10-03     | 1               | 1                | @json:selection-1 | @date:today+P1D | @date:today+P1D  | LOCAL      | NULL                     | @int:ah1       |

@json: selection-1
```json
[
   {
      "id":"@int:rt-1",
      "rates":[         
         {
            "date":"@date:now+P1D",
            "netRate":18900.0,
            "sellRate":21000.0,
            "commissionRate":2100.0,
            "discountApplied":null,
            "sellRateRoomCharge":21000.0,
            "commissionableAmount":21000.0,
            "sellRateExtraBedsCharge":0.0
         }
      ]
   }
]
```

@json: selection-2
```json
[
   {
      "id":"@int:rt-1",
      "rates":[],
      "roomTypeId":200,
      "rateGroupId":100,
      "numberOfAdults":2,
      "numberOfChildren":0,
      "numberOfExtraBeds":0
   }
]
```