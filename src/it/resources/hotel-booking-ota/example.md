@table: user_account

| id      | email               | display_name     | is_system_user | is_active | get_notified |
|---------|---------------------|------------------|----------------|-----------|--------------|
| @int:u1 | user@innoveller.com | Innoveller Admin | true           | true      | false        |



@json:selection-1
```json
[
   {
      "id":"@int:rt-1",
      "rates":[],
      "date": "@date:today",
      "roomTypeId":200,
      "rateGroupId":100,
      "numberOfAdults":2,
      "numberOfChildren":0,
      "numberOfExtraBeds":0
   }
]
```


@table: town

| id   | name_en | description_en     |
|------|---------|--------------------|
| 1200 | Yangon  | @json:selection-1  |

@table: township

| id   | name_en   | town_id |
|------|-----------|---------|
| 1500 | Mayangone | 1200    |
| 1600 | Sanchaung | 1200    |


@table: bed_type

| id           | bed_type |
|--------------|----------|
| @int:bed-sgl | Single   |
| @int:bed-twn | Twin     |

@table: agent

| id  | name         | tax_percentage | creator_id | modifier_id |
|-----|--------------|----------------|------------|-------------|
| 100 | Shwe Booking | 2.00           | @int:u1    | @int:u1     |


@table: hotel

| id           | code         | name         | town_id | is_active | township_id | max_child_age | created_by | property_type | is_tax_excluded | is_partial_payment_allowed | is_archived | created_by |
|--------------|--------------|--------------|---------|-----------|-------------|---------------|------------|---------------|-----------------|----------------------------|-------------|------------|
| @int:sidney  | hotel-sidney | Hotel Sidney | 1200    | true      | 1500        | 10            | 1          | hotel         | false           | false                      | false       | @int:u1    |
| @int:novotel | novotel      | Novotel      | 1200    | true      | 1600        | 10            | 1          | hotel         | false           | false                      | false       | @int:u1    |


@table: room_type

| id               | hotel_id     | name     | description          | max_adults_without_extra_bed | max_guests_without_extra_bed | max_adults_with_extra_bed | max_guests_with_extra_bed | number_of_extra_bed | name_mm | number_of_room | is_active | is_archived | priority |
|------------------|--------------|----------|----------------------|------------------------------|------------------------------|---------------------------|---------------------------|---------------------|---------|----------------|-----------|-------------|----------|
| @int:novotel-std | @int:novotel | Superior | Superior Description | 2                            | 2                            | 3                         | 3                         | 1                   |         | 10             | true      | false       | -1       |

@table: room_bed_count

| room_type_id           | bed_type_id  | number_of_bed |
|------------------------|--------------|---------------|
| @int:novotel-std       | @int:bed-sgl | 1             |

@table: rate_group

| id | guest_type | room_type_id      | minimum_advance_days | maximum_advance_days | title         | currency | is_active | based_on_plan_id | additional_percentage | dependent_rate_type | additional_flat_amount | template_type |
|----|------------|-------------------|----------------------|----------------------|---------------|----------|-----------|------------------|-----------------------|---------------------|------------------------|---------------|
| 1  | any        | @int:novotel-std  | NULL                 | NULL                 | Standard Rate | MMK      | true      | NULL             | NULL                  | NULL                | NULL                   | DEFAULT       |

@table: rate_group_date_rate

| rate_group_id | date       | rate    |
|---------------|------------|---------|
| 1             | 2023-09-15 | 2000.00 |

@table: room_type_extra_bed_rate

| room_type_id      | rate    | rate_group_id |
|-------------------|---------|---------------|
| @int:novotel-std  | 1300.00 | 1             |

@table: room_type_date_allotment

| room_type_id      | date                           | allotment |
|-------------------|--------------------------------|-----------|
| @int:novotel-std  | @series:2023-09-10..2023-09-15 | 10        |
| @int:novotel-std  | @series:today-P1D..today+P1M   | 10        |

@table: agent_hotel_commission_version

| id | commission_type | commission_percentage | commission_flat_amount | created_by | commissions_by_room_types | group_id |
|----|-----------------|-----------------------|------------------------|------------|---------------------------|----------|
| 1  | PERCENTAGE      | 10                    | NULL                   | 1          | NULL                      | @uuid:g1 |
| 2  | PERCENTAGE      | 15                    | NULL                   | 1          |                           | @uuid:g1 |
| 3  | PERCENTAGE      | 7                     | NULL                   | 1          | NULL                      | @uuid:g2 |

@table: agent_hotel

| id | agent_id | hotel_id     | commission_version_id | contract_expiration_date |
|----|----------|--------------|-----------------------|--------------------------|
| 2  | 100      | @int:novotel | 2                     | NULL                     |
| 3  | 100      | @int:sidney  | 3                     | NULL                     |




