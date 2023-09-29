ALTER TABLE IF EXISTS hotel_amenity
RENAME COLUMN amenity TO label_en;

ALTER TABLE IF EXISTS hotel_amenity
ADD COLUMN IF NOT EXISTS label_my TEXT;

ALTER TABLE IF EXISTS room_type_facility
RENAME COLUMN facility TO label_en;

ALTER TABLE IF EXISTS room_type_facility
ADD COLUMN IF NOT EXISTS label_my TEXT;

-- Update Hotel Amenities Labels for Myanmar Language
UPDATE hotel_amenity SET label_my = 'ရှေ့စားပွဲ' WHERE code = 'front-desk';
UPDATE hotel_amenity SET label_my = 'စီးပွားရေးစင်တာ' WHERE code = 'business-center';
UPDATE hotel_amenity SET label_my = 'Wifi အခမဲ့' WHERE code = 'wifi';
UPDATE hotel_amenity SET label_my = 'ဥရောပ မနက်စာ' WHERE code = 'continental breakfast';
UPDATE hotel_amenity SET label_my = 'ဘား' WHERE code = 'bar';
UPDATE hotel_amenity SET label_my = 'ဓာတ်လှေကား' WHERE code = 'elevator';
UPDATE hotel_amenity SET label_my = 'မနက်စာ ဘူဖေး' WHERE code = 'buffet breakfast';
UPDATE hotel_amenity SET label_my = 'ATM စက်' WHERE code = 'atm';
UPDATE hotel_amenity SET label_my = 'အဝတ်လျှော်ဝန်ဆောင်မှု' WHERE code = 'laundry';
UPDATE hotel_amenity SET label_my = 'ကားပါကင်' WHERE code = 'parking';
UPDATE hotel_amenity SET label_my = 'စုံစမ်းရေးဌာန' WHERE code = 'concierge';
UPDATE hotel_amenity SET label_my = 'အားကစားခန်းမ' WHERE code = 'fitness';
UPDATE hotel_amenity SET label_my = 'ရေကူးကန်' WHERE code = 'pool';
UPDATE hotel_amenity SET label_my = 'လုံခြုံရေး' WHERE code = 'security';
UPDATE hotel_amenity SET label_my = 'Spa' WHERE code = 'spa';
UPDATE hotel_amenity SET label_my = 'လက်မှတ်ရောင်းဝန်ဆောင်မှု' WHERE code = 'ticketing';
UPDATE hotel_amenity SET label_my = 'လေဆိပ်အကြိုအပို့' WHERE code = 'airport-shuttle';
UPDATE hotel_amenity SET label_my = 'အခမဲ့စက်ဘီးအသုံးပြုမှု' WHERE code = 'free-bicycle';
UPDATE hotel_amenity SET label_my = 'ကလေးကုတင်' WHERE code = 'baby-cot';

-- Update Room Type Facility Labels for Myanmar Language
UPDATE room_type_facility SET label_my = 'ဆံပင်အခြောက်ခံစက်' WHERE code = 'hairdryer';
UPDATE room_type_facility SET label_my = 'တီဗီ' WHERE code = 'tv';
UPDATE room_type_facility SET label_my = 'အများသုံးရေချိုးခန်း' WHERE code = 'shared-bathroom';
UPDATE room_type_facility SET label_my = 'အထပ်မြင့်' WHERE code = 'high-floor';
UPDATE room_type_facility SET label_my = 'မီးခိုးဖမ်းကိရိယာ' WHERE code = 'smoke-detector';
UPDATE room_type_facility SET label_my = 'မသန်မစွမ်းသူများနေနိုင်' WHERE code = 'handicapped-accessible';
UPDATE room_type_facility SET label_my = 'သီးခြားဧည့်ခန်း' WHERE code = 'separate-living-room';
UPDATE room_type_facility SET label_my = 'အပ်ချုပ်ကိရိယာအစုံ' WHERE code = 'sewing-kit';
UPDATE room_type_facility SET label_my = 'ကော်ဇောခင်း' WHERE code = 'carpeting';
UPDATE room_type_facility SET label_my = 'အပြန်အလှန်ချိတ်ဆက်ထားသောအခန်းများ' WHERE code = 'interconnecting-room';
UPDATE room_type_facility SET label_my = 'ကလေးထိုင်ခုံအမြင့်' WHERE code = 'high-chair';
UPDATE room_type_facility SET label_my = 'ဖိနပ်တိုက်ကိရိယာအစုံ' WHERE code = 'shoeshine-kit';
UPDATE room_type_facility SET label_my = 'သီးသန့်ရေချိုးခန်းအိမ်သာ' WHERE code = 'private-bathroom';
UPDATE room_type_facility SET label_my = 'အမောပြေသောက်စရာ' WHERE code = 'welcome-drink';
UPDATE room_type_facility SET label_my = 'ဂြိုလ်တုတီဗီ' WHERE code = 'satellite-tv';
UPDATE room_type_facility SET label_my = 'လသာဆောင်' WHERE code = 'balcony';
UPDATE room_type_facility SET label_my = 'Flat တီဗီ' WHERE code = 'flat-screen-tv';
UPDATE room_type_facility SET label_my = 'ရေဒီယို' WHERE code = 'radio';
UPDATE room_type_facility SET label_my = 'စားပွဲခုံ' WHERE code = 'deskchair';
UPDATE room_type_facility SET label_my = 'ရေချိုးကန်' WHERE code = 'bathtub';
UPDATE room_type_facility SET label_my = 'ပန်းခြံမြင်ကွင်း' WHERE code = 'gardenview';
UPDATE room_type_facility SET label_my = 'တယ်လီဖုန်း' WHERE code = 'telephone';
UPDATE room_type_facility SET label_my = 'မနက်စာ' WHERE code = 'breakfast';
UPDATE room_type_facility SET label_my = 'အဲကွန်း' WHERE code = 'ac';
UPDATE room_type_facility SET label_my = 'ရေပန်း' WHERE code = 'shower';
UPDATE room_type_facility SET label_my = 'နှိုးစက်နာရီ' WHERE code = 'alarm-clock';
UPDATE room_type_facility SET label_my = 'ရေချိုးဝတ်လုံ' WHERE code = 'bath-robe';
UPDATE room_type_facility SET label_my = 'ရေဘူး' WHERE code = 'water-bottle';
UPDATE room_type_facility SET label_my = 'ဗီရို' WHERE code = 'closet';
UPDATE room_type_facility SET label_my = 'ကော်ဖီ' WHERE code = 'coffee';
UPDATE room_type_facility SET label_my = 'ပန်ကာ' WHERE code = 'fan';
UPDATE room_type_facility SET label_my = 'ခြင်ထောင်' WHERE code = 'mosquito-net';
UPDATE room_type_facility SET label_my = 'မီးခံသေတ္တာ' WHERE code = 'safebox';
UPDATE room_type_facility SET label_my = 'မျက်နှာသုတ်ပုဝါ' WHERE code = 'towel';
UPDATE room_type_facility SET label_my = 'မြေညီထပ်' WHERE code = 'ground-floor';
UPDATE room_type_facility SET label_my = 'အမိုးပွင့်နေရာလွတ်' WHERE code = 'terrace';
UPDATE room_type_facility SET label_my = 'ဖိနပ်' WHERE code = 'slippers';
UPDATE room_type_facility SET label_my = 'ရေချိုးခန်းဖုန်း' WHERE code = 'bathroom-phone';
UPDATE room_type_facility SET label_my = 'Wifi အခမဲ့မဟုတ်' WHERE code = 'not-free-wifi';
UPDATE room_type_facility SET label_my = 'Wifi အခမဲ့' WHERE code = 'free-wifi';
UPDATE room_type_facility SET label_my = 'အသံလုံအခန်း' WHERE code = 'soundproofing';
UPDATE room_type_facility SET label_my = 'အဝတ်စင်' WHERE code = 'clothes-rack';
UPDATE room_type_facility SET label_my = 'မီးပူတိုက်ကိရိယာအစုံ' WHERE code = 'ironing-facilities';
UPDATE room_type_facility SET label_my = 'ကော်ဖီ/လက်ဖက်ရည်ဖျော်စက်' WHERE code = 'coffee-maker';
UPDATE room_type_facility SET label_my = 'မီးဖိုချောင်ငယ်' WHERE code = 'kitchenette';
UPDATE room_type_facility SET label_my = 'လက်ပ်တော့သေတ္တာ' WHERE code = 'laptop-safe-box';
UPDATE room_type_facility SET label_my = 'ရေချိုးခန်းအတွင်းတီဗီ' WHERE code = 'bathroom-tv';
UPDATE room_type_facility SET label_my = 'အခမဲ့အသင့်သောက်ကော်ဖီ/လက်ဖက်ရည်' WHERE code = 'instant-coffee';
UPDATE room_type_facility SET label_my = 'ကန့်သတ်ဝင်ရောက်ခွင့်' WHERE code = 'limited-access-floor';
UPDATE room_type_facility SET label_my = 'ရေချိုးခန်းသုံးပစ္စည်းများ' WHERE code = 'toiletries';
UPDATE room_type_facility SET label_my = 'နေ့စဉ်သတင်းစာ' WHERE code = 'newspaper';
UPDATE room_type_facility SET label_my = 'ပိတ်ချောအိပ်ရာခင်း' WHERE code = 'linens';
UPDATE room_type_facility SET label_my = 'အပေါ်ထပ်' WHERE code = 'top-floor';
UPDATE room_type_facility SET label_my = 'နေ့စဉ်အခန်းသန့်ရှင်းရေး' WHERE code = 'housekeeping';
UPDATE room_type_facility SET label_my = 'သော့ခတ်ဗီရိုငယ်' WHERE code = 'locker';
UPDATE room_type_facility SET label_my = 'အထပ်နိမ့်' WHERE code = 'low-floor';
UPDATE room_type_facility SET label_my = 'ထီး' WHERE code = 'umbrella';
UPDATE room_type_facility SET label_my = 'ဧည့်ခန်း' WHERE code = 'lounge';
UPDATE room_type_facility SET label_my = 'ခရီးဆောင်အိတ်စင်' WHERE code = 'luggage-rack';
UPDATE room_type_facility SET label_my = 'ပေါင်ချိန်စက်' WHERE code = 'weight-scale';
UPDATE room_type_facility SET label_my = 'ကုတင်အရှည်' WHERE code = 'extra-long-bed';
UPDATE room_type_facility SET label_my = 'ရေခဲသေတ္တာငယ်' WHERE code = 'mini-bar';
UPDATE room_type_facility SET label_my = 'အိပ်ရာနှိုးဝန်ဆောင်မှု' WHERE code = 'wake-up-service';
UPDATE room_type_facility SET label_my = 'မှန်' WHERE code = 'mirror';
UPDATE room_type_facility SET label_my = 'အဝတ်လျှော်စက်' WHERE code = 'washing-machine';
UPDATE room_type_facility SET label_my = 'ဆေးသေတ္တာ' WHERE code = 'first-aid-kit';
UPDATE room_type_facility SET label_my = 'ဆေးလိပ်မသောက်နိုင်' WHERE code = 'non-smoking';