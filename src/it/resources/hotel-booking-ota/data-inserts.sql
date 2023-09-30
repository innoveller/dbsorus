

--
-- Data for Name: agent; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agent (id, name, domain, description, creator_id, modifier_id, created_date, modified_date, api_key, tax_percentage) VALUES (1, 'Shwe Booking', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2.00);


--
-- Data for Name: agent_balance; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: agent_hotel; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agent_hotel (id, agent_id, hotel_id, commission_version_id, contract_expiration_date) VALUES (2, 1, 2, 2, NULL);
INSERT INTO public.agent_hotel (id, agent_id, hotel_id, commission_version_id, contract_expiration_date) VALUES (3, 1, 3, 3, NULL);


--
-- Data for Name: agent_hotel_commission_version; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agent_hotel_commission_version (id, commission_type, commission_percentage, commission_flat_amount, created_at, created_by, commissions_by_room_types, group_id) VALUES (1, 'PERCENTAGE', 10, NULL, '2023-09-15 14:39:10.246', 1, NULL, 'ef491ef6-6da4-4fc4-8eb0-ee9937a65ccc');
INSERT INTO public.agent_hotel_commission_version (id, commission_type, commission_percentage, commission_flat_amount, created_at, created_by, commissions_by_room_types, group_id) VALUES (2, 'PERCENTAGE', 15, NULL, '2023-09-19 12:11:01.815', 1, '', 'ef491ef6-6da4-4fc4-8eb0-ee9937a65ccc');
INSERT INTO public.agent_hotel_commission_version (id, commission_type, commission_percentage, commission_flat_amount, created_at, created_by, commissions_by_room_types, group_id) VALUES (3, 'PERCENTAGE', 7, NULL, '2023-09-19 12:56:46.647', 1, NULL, 'dc3f2aac-38f9-471b-95b9-e9161f3b173e');


--
-- Data for Name: agent_promotion; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agent_promotion (id, title, description, agent_id, hotel_id, minimum_check_in_date, maximum_check_out_date, discount_percentage, created_by, created_at, updated_by, updated_at, is_active, is_reviewed, title_my, description_my, group_id, is_updated) VALUES (1, 'September Promotion', '', 1, 2, '2023-09-01', '2023-09-30', 10, 1, '2023-09-15 15:14:27.719', 1, '2023-09-15 15:14:30.943', true, true, '', '', '07c9730e-f12c-4440-8d34-f5b4168170bd', false);


--
-- Data for Name: agent_transaction; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.api_key (id, agent_id, description, access_key, secret_key, is_active, generated_by_id, generated_at) VALUES (1, 1, 'Integration Testing', '59A5A0DF02365C98C52DD612A8B85D55A2F80174785E6726B4851001A154A873', 'B32D07210A72AEFC15071CE6CFCB893BF6562138A6C14FD8FBF7B3F699E7910A', true, 1, '2023-09-19 17:14:43.052');


--
-- Data for Name: array_testing; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: attraction; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: bank; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.bank (id, full_name, short_name) VALUES (1, 'Co-operative Bank', 'CB Bank');
INSERT INTO public.bank (id, full_name, short_name) VALUES (2, 'Yoma Bank', 'Yoma Bank');
INSERT INTO public.bank (id, full_name, short_name) VALUES (3, 'Central Bank of Myanmar', 'CBM Bank');
INSERT INTO public.bank (id, full_name, short_name) VALUES (4, 'Kanbawza Bank', 'KBZ Bank');
INSERT INTO public.bank (id, full_name, short_name) VALUES (5, 'Myanma Apex Bank', 'MAB Bank');


--
-- Data for Name: bed_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.bed_type (id, bed_type) VALUES (1, 'Single');
INSERT INTO public.bed_type (id, bed_type) VALUES (2, 'Twin');


--
-- Data for Name: booker; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booker (id, name, msisdn, email) VALUES (1, 'May Thu Win', '95944412210', NULL);
INSERT INTO public.booker (id, name, msisdn, email) VALUES (2, 'Michael', '959786541236', NULL);
INSERT INTO public.booker (id, name, msisdn, email) VALUES (3, 'John', '959254781369', NULL);


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking (id, reference, hotel_id, agent_id, checkin_date, checkout_date, number_of_rooms, number_of_guests, primary_guest_id, booker_id, special_request, commission_rate, tax_rate, commissionable_amount, net_amount, tax_amount, total_amount, payment_id, is_fully_paid, created_at, commission_version_id, tentative_booking_id, guest_type, number_of_adults, number_of_children, hotel_special_offer_id, group_id, booking_revision_id, status, updated_at, updated_by, agent_hotel_id) VALUES ('db42f6ea-9ce1-440b-8a9d-097d61c439a9', '1000d-d0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, '2023-09-15 15:23:35.316', NULL, '82361e0b-d061-431f-ae2f-5db0791c6db6', 'LOCAL', 1, 0, NULL, 'df9c2bcc-5727-4d1c-9e37-e3ae21f1d861', '82865eb9-d547-447d-b757-1c78fc70028d', 'CONFIRMED', '2023-09-15 15:23:35.324', NULL, 2);
INSERT INTO public.booking (id, reference, hotel_id, agent_id, checkin_date, checkout_date, number_of_rooms, number_of_guests, primary_guest_id, booker_id, special_request, commission_rate, tax_rate, commissionable_amount, net_amount, tax_amount, total_amount, payment_id, is_fully_paid, created_at, commission_version_id, tentative_booking_id, guest_type, number_of_adults, number_of_children, hotel_special_offer_id, group_id, booking_revision_id, status, updated_at, updated_by, agent_hotel_id) VALUES ('4e411aa6-b9ea-4d95-a537-348db323891a', '1000a-20050', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, '2023-09-20 11:02:44.174', NULL, 'baabcb53-5c8e-47e9-9c48-4aa071db319b', 'LOCAL', 1, 0, NULL, 'caffb456-75f0-4db9-8191-02e1ce6edfdf', '1c95d015-62b9-47f7-ba23-4a35fe0e4a55', 'CONFIRMED', '2023-09-20 11:02:44.176', NULL, 2);


--
-- Data for Name: booking_cancellation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: booking_payment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking_payment (id, booking_id, payment_id) VALUES (1, 'db42f6ea-9ce1-440b-8a9d-097d61c439a9', 1);
INSERT INTO public.booking_payment (id, booking_id, payment_id) VALUES (2, '4e411aa6-b9ea-4d95-a537-348db323891a', 2);


--
-- Data for Name: booking_revision; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking_revision (id, group_id, check_in_date, check_out_date, guest_type, number_of_rooms, number_of_guests, number_of_adults, number_of_children, primary_guest_id, booker_id, special_request, total_amount, tax_rate, tax_amount, commissionable_amount, net_amount, commission_rate, commission_version_id, value_added_promotion_id, created_at) VALUES ('81fc0a23-e816-4eaf-a3c1-db509c5259a4', 'd8543bc1-6bc1-4724-b7c7-a9dc582d0e9a', '2023-09-15', '2023-09-16', 'LOCAL', 1, 3, 2, 1, 1, 1, '', 1942, 2, 42, 1900, 1710, 190, 1, NULL, '2023-09-15 15:20:47.859');
INSERT INTO public.booking_revision (id, group_id, check_in_date, check_out_date, guest_type, number_of_rooms, number_of_guests, number_of_adults, number_of_children, primary_guest_id, booker_id, special_request, total_amount, tax_rate, tax_amount, commissionable_amount, net_amount, commission_rate, commission_version_id, value_added_promotion_id, created_at) VALUES ('82865eb9-d547-447d-b757-1c78fc70028d', 'df9c2bcc-5727-4d1c-9e37-e3ae21f1d861', '2023-09-15', '2023-09-16', 'LOCAL', 1, 3, 2, 1, 1, 1, '', 1942, 2, 42, 1900, 1710, 190, 1, NULL, '2023-09-15 15:23:35.297');
INSERT INTO public.booking_revision (id, group_id, check_in_date, check_out_date, guest_type, number_of_rooms, number_of_guests, number_of_adults, number_of_children, primary_guest_id, booker_id, special_request, total_amount, tax_rate, tax_amount, commissionable_amount, net_amount, commission_rate, commission_version_id, value_added_promotion_id, created_at) VALUES ('1c95d015-62b9-47f7-ba23-4a35fe0e4a55', 'caffb456-75f0-4db9-8191-02e1ce6edfdf', '2023-09-22', '2023-09-23', 'LOCAL', 1, 2, 2, 0, 3, 3, '', 1942, 2, 42, 1900, 1615, 285, 2, NULL, '2023-09-20 11:02:44.151');


--
-- Data for Name: booking_revision_room; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking_revision_room (id, booking_id, room_type_id, rate_group_id, number_of_adults, number_of_children, number_of_extra_beds, booking_revision_id) VALUES ('103950a5-45c5-40dc-a004-2970a06eb08a', NULL, 1, 1, 2, 0, 0, '81fc0a23-e816-4eaf-a3c1-db509c5259a4');
INSERT INTO public.booking_revision_room (id, booking_id, room_type_id, rate_group_id, number_of_adults, number_of_children, number_of_extra_beds, booking_revision_id) VALUES ('cd5cb4c4-9da3-4195-89b7-f8387890e97a', NULL, 1, 1, 2, 0, 0, '82865eb9-d547-447d-b757-1c78fc70028d');
INSERT INTO public.booking_revision_room (id, booking_id, room_type_id, rate_group_id, number_of_adults, number_of_children, number_of_extra_beds, booking_revision_id) VALUES ('12e79584-80a8-438c-a69c-dc20b65da5e2', NULL, 1, 1, 2, 0, 0, '1c95d015-62b9-47f7-ba23-4a35fe0e4a55');


--
-- Data for Name: booking_revision_room_rate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking_revision_room_rate (id, booking_revision_room_id, date, sell_rate, sell_rate_room_charge, sell_rate_extra_beds_charge, net_rate, promotion_type, promotion_id, applied_discount_amount, commissionable_amount, commission_rate) VALUES (1, '103950a5-45c5-40dc-a004-2970a06eb08a', '2023-09-15', 1900.00, 2000.00, 0.00, 1710.00, 'HOTEL_PROMOTION', 1, 100, 1900.00, 190.00);
INSERT INTO public.booking_revision_room_rate (id, booking_revision_room_id, date, sell_rate, sell_rate_room_charge, sell_rate_extra_beds_charge, net_rate, promotion_type, promotion_id, applied_discount_amount, commissionable_amount, commission_rate) VALUES (2, 'cd5cb4c4-9da3-4195-89b7-f8387890e97a', '2023-09-15', 1900.00, 2000.00, 0.00, 1710.00, 'HOTEL_PROMOTION', 1, 100, 1900.00, 190.00);
INSERT INTO public.booking_revision_room_rate (id, booking_revision_room_id, date, sell_rate, sell_rate_room_charge, sell_rate_extra_beds_charge, net_rate, promotion_type, promotion_id, applied_discount_amount, commissionable_amount, commission_rate) VALUES (3, '12e79584-80a8-438c-a69c-dc20b65da5e2', '2023-09-22', 1900.00, 2000.00, 0.00, 1615.00, 'HOTEL_PROMOTION', 1, 100, 1900.00, 285.00);


--
-- Data for Name: booking_session; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking_session (id, hotel_id, agent_id, check_in_date, check_out_date, number_of_rooms, number_of_guests, room_selections, created_at, updated_at, guest_type, value_added_promotion_id, agent_hotel_id) VALUES ('24e688dd-ef61-40ec-9e44-eacabdfa65c2', NULL, NULL, '2023-09-15', '2023-09-16', 1, 1, '[{"id": "3dba6175-9383-42dd-852c-b1fac4821fa6", "rates": [{"date": "2023-09-15", "netRate": 1710.0, "sellRate": 1900.0, "commissionRate": 190.0, "discountApplied": {"id": 1, "amount": 100.0, "promotionType": "HOTEL_PROMOTION"}, "sellRateRoomCharge": 2000.0, "commissionableAmount": 1900.0, "sellRateExtraBedsCharge": 0.0}], "roomTypeId": 1, "rateGroupId": 1, "numberOfAdults": 2, "numberOfChildren": 0, "numberOfExtraBeds": 0}]', '2023-09-15 15:16:05.273', '2023-09-15 15:19:29.378', 'LOCAL', NULL, 2);
INSERT INTO public.booking_session (id, hotel_id, agent_id, check_in_date, check_out_date, number_of_rooms, number_of_guests, room_selections, created_at, updated_at, guest_type, value_added_promotion_id, agent_hotel_id) VALUES ('c58ca2e2-9cd3-4c99-9bfc-6f2f4a9df337', NULL, NULL, '2023-09-21', '2023-09-22', 1, 1, '[{"id": "df2d42b9-c5a4-40e2-88be-dba0b7316903", "rates": [{"date": "2023-09-21", "netRate": 1615.0, "sellRate": 1900.0, "commissionRate": 285.0, "discountApplied": {"id": 1, "amount": 100.0, "promotionType": "HOTEL_PROMOTION"}, "sellRateRoomCharge": 2000.0, "commissionableAmount": 1900.0, "sellRateExtraBedsCharge": 0.0}], "roomTypeId": 1, "rateGroupId": 1, "numberOfAdults": 2, "numberOfChildren": 0, "numberOfExtraBeds": 0}]', '2023-09-19 17:17:55.211', '2023-09-19 17:17:56.632', 'LOCAL', NULL, 2);
INSERT INTO public.booking_session (id, hotel_id, agent_id, check_in_date, check_out_date, number_of_rooms, number_of_guests, room_selections, created_at, updated_at, guest_type, value_added_promotion_id, agent_hotel_id) VALUES ('38628a4f-972b-4b90-bdd2-fb8996490cc0', NULL, NULL, '2023-09-24', '2023-09-25', 1, 1, '[{"id": "dfb385b6-1d50-496a-909e-af717ab56533", "rates": [{"date": "2023-09-24", "netRate": 1615.0, "sellRate": 1900.0, "commissionRate": 285.0, "discountApplied": {"id": 1, "amount": 100.0, "promotionType": "HOTEL_PROMOTION"}, "sellRateRoomCharge": 2000.0, "commissionableAmount": 1900.0, "sellRateExtraBedsCharge": 0.0}], "roomTypeId": 1, "rateGroupId": 1, "numberOfAdults": 2, "numberOfChildren": 0, "numberOfExtraBeds": 0}]', '2023-09-20 10:01:14.29', '2023-09-20 10:01:16.164', 'LOCAL', NULL, 2);
INSERT INTO public.booking_session (id, hotel_id, agent_id, check_in_date, check_out_date, number_of_rooms, number_of_guests, room_selections, created_at, updated_at, guest_type, value_added_promotion_id, agent_hotel_id) VALUES ('bccd5bce-cbef-4030-a871-155cfaf6d8c2', NULL, NULL, '2023-09-22', '2023-09-23', 1, 1, '[{"id": "28210538-69a6-4667-9c9c-a1f8ea4a4a62", "rates": [{"date": "2023-09-22", "netRate": 1615.0, "sellRate": 1900.0, "commissionRate": 285.0, "discountApplied": {"id": 1, "amount": 100.0, "promotionType": "HOTEL_PROMOTION"}, "sellRateRoomCharge": 2000.0, "commissionableAmount": 1900.0, "sellRateExtraBedsCharge": 0.0}], "roomTypeId": 1, "rateGroupId": 1, "numberOfAdults": 2, "numberOfChildren": 0, "numberOfExtraBeds": 0}]', '2023-09-20 11:02:08.897', '2023-09-20 11:02:10.382', 'LOCAL', NULL, 2);


--
-- Data for Name: date_rate_statistics; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-24', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-22', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-13', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-17', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-16', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-15', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-30', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-29', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-28', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-27', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-26', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-25', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-23', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-21', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-20', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-19', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-09-18', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-12', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-11', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-10', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-09', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-08', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-07', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-06', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-05', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-04', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-03', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-02', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);
INSERT INTO public.date_rate_statistics (hotel_id, date, minimum_amount_for_local, maximum_amount_for_local, total_amount_for_local, minimum_amount_for_foreigner, maximum_amount_for_foreigner, total_amount_for_foreigner, minimum_local_rate_group_id, minimum_foreigner_rate_group_id) VALUES (2, '2023-10-01', 2000, 2000, 2000, 2000, 2000, 2000, 1, 1);


--
-- Data for Name: financial_institution; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.financial_institution (financial_institution_id, institution_type, name, abbreviation) VALUES (1, 'BANK', 'Co-operative Bank', 'CB Bank');
INSERT INTO public.financial_institution (financial_institution_id, institution_type, name, abbreviation) VALUES (2, 'BANK', 'Yoma Bank', 'Yoma Bank');
INSERT INTO public.financial_institution (financial_institution_id, institution_type, name, abbreviation) VALUES (3, 'BANK', 'Central Bank of Myanmar', 'CBM Bank');
INSERT INTO public.financial_institution (financial_institution_id, institution_type, name, abbreviation) VALUES (4, 'BANK', 'Kanbawza Bank', 'KBZ Bank');
INSERT INTO public.financial_institution (financial_institution_id, institution_type, name, abbreviation) VALUES (5, 'BANK', 'Myanma Apex Bank', 'MAB Bank');


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (1, '1', '<< Flyway Baseline >>', 'BASELINE', '<< Flyway Baseline >>', NULL, 'null', '2021-01-14 12:46:18.668305', 0, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (2, '002', 'login record', 'SQL', 'V002__login_record.sql', -1044822782, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.022957', 15, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (3, '003', 'session id uuid', 'SQL', 'V003__session_id_uuid.sql', -2045118629, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.079558', 60, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (4, '004', 'agent api key', 'SQL', 'V004__agent_api_key.sql', -906629503, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.181422', 6, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (5, '005', 'rename banks', 'SQL', 'V005__rename_banks.sql', 1476931775, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.219429', 18, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (6, '006', 'agent id in booking attempt', 'SQL', 'V006__agent_id_in_booking_attempt.sql', 775742274, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.256637', 7, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (7, '007', 'date rate statistics', 'SQL', 'V007__date_rate_statistics.sql', 1693273316, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.288177', 43, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (8, '008', 'drop table', 'SQL', 'V008__drop_table.sql', -972467851, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.349903', 13, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (9, '009', 'reference block', 'SQL', 'V009__reference_block.sql', 1087110047, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.395352', 47, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (10, '010', 'reference block starter integer', 'SQL', 'V010__reference_block_starter_integer.sql', -25279461, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.470145', 18, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (11, '011', 'help content', 'SQL', 'V011__help_content.sql', -1542357215, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.516125', 17, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (12, '012', 'more amenities', 'SQL', 'V012__more_amenities.sql', 1686323393, 'eoltfatiwpmhhb', '2022-04-27 10:45:27.592835', 40, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (13, '013', 'booking session', 'SQL', 'V013__booking_session.sql', 776949981, 'u5hiei1ooelech', '2022-07-08 07:44:16.013382', 17, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (14, '014', 'api key', 'SQL', 'V014__api_key.sql', -357561569, 'u5hiei1ooelech', '2022-07-08 07:44:16.05563', 22, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (15, '015', 'tentative booking', 'SQL', 'V015__tentative_booking.sql', 1260343018, 'u5hiei1ooelech', '2022-07-08 07:44:16.105348', 41, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (16, '016', 'booking', 'SQL', 'V016__booking.sql', -1160841314, 'u5hiei1ooelech', '2022-07-08 07:44:16.172327', 12, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (17, '017', 'guest email', 'SQL', 'V017__guest_email.sql', 2066126676, 'u5hiei1ooelech', '2022-07-08 07:44:16.203706', 4, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (18, '018', 'agent tax rate', 'SQL', 'V018__agent_tax_rate.sql', -383779748, 'u5hiei1ooelech', '2022-07-08 07:44:16.257622', 5, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (19, '019', 'tentative booking expiration', 'SQL', 'V019__tentative_booking_expiration.sql', -749265166, 'u5hiei1ooelech', '2022-07-08 07:44:16.282452', 3, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (20, '20', 'vw room type availability', 'SQL', 'V20__vw_room_type_availability.sql', 1462658935, 'u5hiei1ooelech', '2022-07-08 07:44:16.326807', 7, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (21, '21', 'settlement booking id uuid', 'SQL', 'V21__settlement_booking_id_uuid.sql', 1388214324, 'u5hiei1ooelech', '2022-07-08 07:57:29.935549', 201, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (22, '22', 'booking session in tentative booking', 'SQL', 'V22__booking_session_in_tentative_booking.sql', -1083447836, 'u5hiei1ooelech', '2022-07-08 07:57:30.171605', 4, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (23, '23', 'tentative booking in booking', 'SQL', 'V23__tentative_booking_in_booking.sql', -613146852, 'u5hiei1ooelech', '2022-07-08 08:06:35.62375', 7, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (24, '24', 'room type activation', 'SQL', 'V24__room_type_activation.sql', 472937401, 'u5hiei1ooelech', '2022-07-08 08:06:35.661624', 5, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (25, '025', 'amenities label my', 'SQL', 'V025__amenities_label_my.sql', 799586075, 'u5hiei1ooelech', '2022-07-08 08:06:35.69895', 88, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (26, '026', 'agent hotel commission version', 'SQL', 'V026__agent_hotel_commission_version.sql', 341935028, 'u5hiei1ooelech', '2022-07-08 08:06:35.810234', 77, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (27, '027', 'user account oidc version', 'SQL', 'V027__user_account_oidc_version.sql', -1615930256, 'u5hiei1ooelech', '2022-09-06 04:05:04.951284', 8, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (28, '028', 'support team phone address', 'SQL', 'V028__support_team_phone_address.sql', 1036552543, 'u5hiei1ooelech', '2022-09-08 09:13:36.099185', 9, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (29, '029', 'hotel search history', 'SQL', 'V029__hotel_search_history.sql', 85668386, 'u5hiei1ooelech', '2022-09-08 09:13:36.123202', 11, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (30, '030', 'checkin checkout policy', 'SQL', 'V030__checkin_checkout_policy.sql', 1334786157, 'u5hiei1ooelech', '2022-09-09 14:13:53.681566', 7, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (31, '031', 'checkin checkout details', 'SQL', 'V031__checkin_checkout_details.sql', 1772707786, 'u5hiei1ooelech', '2022-09-09 14:13:53.717953', 3, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (32, '032', 'location hint', 'SQL', 'V032__location_hint.sql', -84359642, 'u5hiei1ooelech', '2022-09-14 10:57:11.839188', 42, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (33, '033', 'geohash', 'SQL', 'V033__geohash.sql', 1486077193, 'u5hiei1ooelech', '2022-09-15 13:39:22.790563', 44, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (34, '034', 'room type archive', 'SQL', 'V034__room_type_archive.sql', -274784459, 'u5hiei1ooelech', '2022-09-15 13:39:22.857792', 3, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (35, '035', 'hotel status details', 'SQL', 'V035__hotel_status_details.sql', 715099926, 'u5hiei1ooelech', '2022-09-21 14:35:51.77846', 9, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (36, '036', 'hotel payment account', 'SQL', 'V036__hotel_payment_account.sql', -2016589679, 'u5hiei1ooelech', '2022-09-23 09:42:15.760438', 37, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (37, '037', 'tentative booking confirm attempt', 'SQL', 'V037__tentative_booking_confirm_attempt.sql', -20303030, 'u5hiei1ooelech', '2022-09-23 09:42:15.818799', 15, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (38, '038', 'booking cancellation', 'SQL', 'V038__booking_cancellation.sql', -341670780, 'u5hiei1ooelech', '2022-09-23 16:06:20.663825', 24, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (39, '039', 'room type availability with booking cancellation', 'SQL', 'V039__room_type_availability_with_booking_cancellation.sql', -922561223, 'u5hiei1ooelech', '2022-09-27 06:11:02.833924', 18, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (40, '040', 'vw rate allotment statistics', 'SQL', 'V040__vw_rate_allotment_statistics.sql', 1341562103, 'u5hiei1ooelech', '2022-09-29 08:50:00.801179', 16, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (41, '041', 'rate group template type', 'SQL', 'V041__rate_group_template_type.sql', 253688141, 'u5hiei1ooelech', '2022-09-29 08:50:00.859749', 26, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (42, '042', 'guest type in booking flow', 'SQL', 'V042__guest_type_in_booking_flow.sql', 1184695124, 'u5hiei1ooelech', '2022-09-29 08:50:00.932391', 6, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (43, '043', 'hotel payment account id', 'SQL', 'V043__hotel_payment_account_id.sql', -372489331, 'u5hiei1ooelech', '2022-10-14 14:00:59.111835', 9, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (44, '044', 'contract expiration date', 'SQL', 'V044__contract_expiration_date.sql', -781087061, 'u5hiei1ooelech', '2022-10-14 14:00:59.163449', 7, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (45, '045', 'refactored tables', 'SQL', 'V045__refactored_tables.sql', 279568008, 'u5hiei1ooelech', '2022-10-14 14:00:59.185826', 31, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (46, '046', 'vw room type availability', 'SQL', 'V046__vw_room_type_availability.sql', -2054741130, 'u5hiei1ooelech', '2022-10-14 14:00:59.245004', 11, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (47, '047', 'booking tentative booking index', 'SQL', 'V047__booking_tentative_booking_index.sql', 933649975, 'u5hiei1ooelech', '2022-10-14 16:14:28.90448', 18, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (48, '048', 'specials day', 'SQL', 'V048__specials_day.sql', -2070878749, 'u5hiei1ooelech', '2022-11-09 10:02:01.35708', 19, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (49, '049', 'settlement doc', 'SQL', 'V049__settlement_doc.sql', 1074957151, 'u5hiei1ooelech', '2022-11-09 10:02:01.393659', 13, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (50, '050', 'hotel blackout dates', 'SQL', 'V050__hotel_blackout_dates.sql', 1547888504, 'u5hiei1ooelech', '2022-11-09 10:02:01.423333', 13, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (51, '051', 'user email text', 'SQL', 'V051__user_email_text.sql', -325188075, 'u5hiei1ooelech', '2022-11-09 10:02:01.45272', 5, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (52, '052', 'archive hotel', 'SQL', 'V052__archive_hotel.sql', 1979051917, 'u5hiei1ooelech', '2022-11-09 10:02:01.470806', 4, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (53, '053', 'user get notified flag', 'SQL', 'V053__user_get_notified_flag.sql', -620229877, 'u5hiei1ooelech', '2022-11-15 04:57:02.276469', 13, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (54, '054', 'signed in event', 'SQL', 'V054__signed_in_event.sql', 184970634, 'u5hiei1ooelech', '2022-11-15 04:57:02.330177', 29, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (55, '055', 'rate group in statistics', 'SQL', 'V055__rate_group_in_statistics.sql', 1816126669, 'u5hiei1ooelech', '2022-11-29 12:00:59.64584', 9, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (56, '056', 'promotions', 'SQL', 'V056__promotions.sql', 410959057, 'u5hiei1ooelech', '2022-11-29 12:00:59.675243', 39, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (57, '057', 'agent promotion review status', 'SQL', 'V057__agent_promotion_review_status.sql', 119076671, 'u5hiei1ooelech', '2022-11-29 12:00:59.736405', 12, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (58, '058', 'promotions in booking flow', 'SQL', 'V058__promotions_in_booking_flow.sql', 1267721209, 'u5hiei1ooelech', '2022-11-29 12:00:59.7642', 6, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (59, '059', 'hotel promotion review status', 'SQL', 'V059__hotel_promotion_review_status.sql', 905885890, 'u5hiei1ooelech', '2022-11-29 12:00:59.78573', 7, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (60, '060', 'payment account holder contact', 'SQL', 'V060__payment_account_holder_contact.sql', 412575211, 'u5hiei1ooelech', '2022-11-29 12:00:59.805983', 4, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (61, '061', 'hotel notification subscriber', 'SQL', 'V061__hotel_notification_subscriber.sql', 1307367632, 'u5hiei1ooelech', '2023-01-16 13:15:55.390023', 18, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (62, '062', 'adults children count', 'SQL', 'V062__adults_children_count.sql', 2138182966, 'u5hiei1ooelech', '2023-01-23 09:28:25.715813', 12, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (63, '063', 'vw room type availability', 'SQL', 'V063__vw_room_type_availability.sql', -1754094334, 'postgres', '2023-02-27 14:42:18.520773', 42, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (64, '064', 'hotel amenity electricity', 'SQL', 'V064__hotel_amenity_electricity.sql', 1050574380, 'postgres', '2023-06-06 14:30:19.329916', 12, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (65, '065', 'room type priority', 'SQL', 'V065__room_type_priority.sql', 1566023469, 'postgres', '2023-06-07 15:32:10.155079', 28, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (66, '066', 'commissions by room types', 'SQL', 'V066__commissions_by_room_types.sql', -1192965848, 'postgres', '2023-06-14 11:37:24.739768', 21, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (67, '067', 'hotel rate limit', 'SQL', 'V067__hotel_rate_limit.sql', -1508025047, 'postgres', '2023-06-14 15:12:05.256895', 17, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (68, '068', 'force logout', 'SQL', 'V068__force_logout.sql', -301515918, 'postgres', '2023-06-20 14:33:17.859904', 30, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (69, '069', 'update foreigner rate statistics', 'SQL', 'V069__update_foreigner_rate_statistics.sql', -1216240573, 'postgres', '2023-07-25 12:56:39.436929', 282, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (70, '070', 'hotel special offer', 'SQL', 'V070__hotel_special_offer.sql', 494546312, 'postgres', '2023-07-27 16:37:22.504334', 32, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (71, '071', 'special offer in booking flow', 'SQL', 'V071__special_offer_in_booking_flow.sql', -1285325925, 'postgres', '2023-07-28 14:54:41.63603', 25, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (72, '072', 'special offer by room type', 'SQL', 'V072__special_offer_by_room_type.sql', 741247268, 'postgres', '2023-07-31 11:00:34.6315', 15, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (73, '073', 'booking amendment', 'SQL', 'V073__booking_amendment.sql', -1536245223, 'postgres', '2023-08-07 16:25:30.91997', 115, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (74, '074', 'booking nullable columns', 'SQL', 'V074__booking_nullable_columns.sql', -142540191, 'postgres', '2023-08-08 12:51:15.951697', 7, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (75, '075', 'special offer by group id', 'SQL', 'V075__special_offer_by_group_id.sql', 584367678, 'postgres', '2023-08-11 17:03:13.670375', 105, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (77, '077', 'hotel promotion by group id', 'SQL', 'V077__hotel_promotion_by_group_id.sql', 1266528849, 'postgres', '2023-08-18 17:09:59.120941', 67, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (78, '078', 'booking flow value added promotion', 'SQL', 'V078__booking_flow_value_added_promotion.sql', 1393898948, 'postgres', '2023-08-18 17:10:37.379199', 0, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (79, '079', 'agent promotion by group id', 'SQL', 'V079__agent_promotion_by_group_id.sql', -2069626697, 'postgres', '2023-08-18 17:10:37.394948', 82, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (80, '080', 'booking updated by', 'SQL', 'V080__booking_updated_by.sql', 2097286573, 'postgres', '2023-08-18 17:10:37.490545', 2, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (81, '081', 'modify date rate statistics', 'SQL', 'V081__modify_date_rate_statistics.sql', 1173378241, 'postgres', '2023-08-23 10:18:13.738169', 15, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (82, '082', 'booking flow agent hotel id', 'SQL', 'V082__booking_flow_agent_hotel_id.sql', -1721124125, 'postgres', '2023-08-30 16:06:34.065574', 259, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (83, '083', 'hotel mv images with priority', 'SQL', 'V083__hotel_mv_images_with_priority.sql', -109477423, 'postgres', '2023-09-01 15:16:48.583595', 76, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (76, '076', 'rename special offer', 'SQL', 'V076__rename_special_offer.sql', -1730537049, 'postgres', '2023-08-11 17:03:13.791582', 2, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (84, '084', 'agent hotel commission group', 'SQL', 'V084__agent_hotel_commission_group.sql', 2096921727, 'postgres', '2023-09-19 12:56:03.504834', 3, true);
INSERT INTO public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (85, '085', 'room type availability view', 'SQL', 'V085__room_type_availability_view.sql', -684308137, 'postgres', '2023-09-20 11:30:13.619677', 23, true);


--
-- Data for Name: force_logout; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: gateway_type; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: guest; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.guest (id, name, gender, nationality, msisdn, email) VALUES (1, 'May Thu Win', 'FEMALE', 'MM', '95944412210', NULL);
INSERT INTO public.guest (id, name, gender, nationality, msisdn, email) VALUES (2, 'Michael', 'MALE', 'MM', '959786541236', NULL);
INSERT INTO public.guest (id, name, gender, nationality, msisdn, email) VALUES (3, 'John', 'MALE', 'MM', '959254781369', NULL);


--
-- Data for Name: help_content; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel (id, code, name, description, logo_url, address, email, fax, primary_phone_number, banner_url, theme, photo_url, main_website, town_id, is_active, amenity_codes, latitude, longitude, township_id, max_child_age, name_mm, description_mm, address_mm, featured_amenity_codes, created_by, created_on, secondary_phone_numbers, property_type, is_tax_excluded, is_partial_payment_allowed, oidc_org_id, location_hint, location_hint_my, geohash, status_details, is_archived) VALUES (2, 'hotel-sidney-100-8252', 'Hotel Sidney', 'Hotel Sidney is approximately 10 minutes by road to the hotel from Yangon International Airport. Located on the prime areas of Mayangone Township where Myanmar Convention Center exists.Each room is fitted with teak wood panel, teak-parquet floor and rattan furnishings.Mayangone township is a great choice for travellers who interested in ancient landmarks, architecture Whether Your visit to Yangon is for business, pleasure or any purpose, there is Hotel Sidney.Stay with us and feel like at home.', 'https://res.cloudinary.com/innoveller/image/upload/v1694765562/shwebooking/c4nowwjb7sjdth5grjc5.png', 'No.8L, Mindhama Road (Between Parami Road & Kyaik Waing Pagoda Rd) Mayangone Tsp, Yangon, Myanmar.', '', '', '09785214638', NULL, NULL, 'https://res.cloudinary.com/innoveller/image/upload/v1694765582/shwebooking/sr0mn3ihaxdt1n6b5d3h.jpg', '', 1, true, '{atm,"buffet breakfast","continental breakfast",wifi,laundry}', 16.8616504, 96.12876120000001, 1, 10, '', '', '', '{"buffet breakfast",wifi}', 1, '2023-09-15 14:39:10.229', '', 'hotel', false, false, 'f7f0e142-e1cc-48bb-a92f-c04bf3dec307', '', '', 'w4urgm', '', false);
INSERT INTO public.hotel (id, code, name, description, logo_url, address, email, fax, primary_phone_number, banner_url, theme, photo_url, main_website, town_id, is_active, amenity_codes, latitude, longitude, township_id, max_child_age, name_mm, description_mm, address_mm, featured_amenity_codes, created_by, created_on, secondary_phone_numbers, property_type, is_tax_excluded, is_partial_payment_allowed, oidc_org_id, location_hint, location_hint_my, geohash, status_details, is_archived) VALUES (3, 'novotel-70-1226', 'Novotel', NULL, NULL, 'Yangon', '', NULL, '09258963147', NULL, NULL, NULL, NULL, 1, false, NULL, NULL, NULL, 1, NULL, '', NULL, '', NULL, 1, '2023-09-19 12:56:46.512', NULL, 'hotel', false, false, 'f6480ba1-916a-4a76-a40c-dacd4d3f878e', NULL, NULL, NULL, NULL, false);


--
-- Data for Name: hotel_amenity; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_amenity (id, code, label_en, icon, label_my) VALUES (1, 'wifi', 'Free Wifi', ' data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCxkFCSjkeTvQAAABZElEQVQ4y83Sv0vVYRTH8ZeWpIWIYKQ5JYKRFLpYKuailN+LpX+CS466VeDuLEE4OknYplIN5b2DP1oquxdyUXEofzRkmw7X5zZ0u+KPGwkKvbfzOec85/Oc5+G/o+BQfM4tN11Tgh2rUlL28jW3G7MtY8eaefPW7Mr4YUz70eI27wWzHrtxQK/3xJxgQeu+WGJUMKMpr/Hb4oLniqHSR1u6s6kag6YlbdmUNGVATTbzwHcfVBZICbqso9Gweza9smIdV9WKXPHGU4uo9hoiZSjyTDCjTeEBM4Xuitsz4jzKRL/lcu9se5gtqhDp0ydSkVV6/PRW+f453RbVgU4JacGGDUFaXAe47lPunjkumRBMuO8CKNblpeCFi8cvL+GrliNqq28Sxzf0qgIx45I+GxcDVXrz/61S09ImDRkyKW1Kqb8S80VDLmq09GeRp8xlK5Zzr/APNMvIuHOSGf0enYn3s+AXIJNhmkQ+6kIAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMTEtMjVUMDU6MDk6NDArMDA6MDCtgn3jAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTExLTI1VDA1OjA5OjQwKzAwOjAw3N/FXwAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII=', 'Wifi အခမဲ့');
INSERT INTO public.hotel_amenity (id, code, label_en, icon, label_my) VALUES (2, 'laundry', 'Laundry Service', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfkAQ0HJRhw21xtAAABw0lEQVQ4y43UTUjUURQF8N+MExWW1PSNUpuohLSUIKyxCAla2coWWVEg0TYoiMpduGzTTlpIqyAyi6lFKFFgjpFDNBDWQikIF5VajGloMy2c0f+oqWf1ePecd8+57/FC4IQWGYujSLM4IdCn0ZFcIeO+UuUe26ROh/Hc/lqvVBEBWYcc9RKckXLXgJDzRuzV45hbWrT6I2IqktOnxewGZca8t99HPZpckTDgp1afponTlj44a2m0qcp3iLq4DMHm2eXbZdBJiORDF6JOg3L0e+j53OJcwQb3/DBo0qS00y4751uQEC6grxH3QqWMuA4T9ukSVzLfRD7Dbc16bQ3E7HXDnWCGoKBYn2cqCo7ao9ObXI+ESKGlGt2KpQoE/Yp0iy2cYYu0z/PsDvht28JTGrVSqYMO2y6tXRI7VRo2MksK5TIcwEbtVvuiw6CoRrtkZYSNajSEhNjs44Pvvko67oEJPMEqj3SpMfS/sZZJuq7XSVFR9V67KWlHcKxBS1ChzVPrVAhJGVbvgnczgpip8JxeKbV+qVaiRLUxsRn6gpYWR+C1rnBpyU8grNjf/MWdclV4CcE1DbL50HRaL7uoYFwt/APOXn14tiVA+QAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wMS0xM1QwNzozNzoyNCswMDowMMU3wVUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDEtMTNUMDc6Mzc6MjQrMDA6MDC0annpAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg==', 'အဝတ်လျှော်ဝန်ဆောင်မှု');
INSERT INTO public.hotel_amenity (id, code, label_en, icon, label_my) VALUES (3, 'atm', 'ATM machine', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAPYAAAD2ABenhFjQAAABl0RVh0U29mdHdhcmUAcGFpbnQubmV0IDQuMC4yMfEgaZUAAAHjSURBVEhLxVa/S8NAFE4b+jM/21LaLQjFYKFZXKTg1tVFKC7OBWdx7+Lm4iK4uAgOBRf7Hzj7b+jiUlwc4/ediaQ16Z0k4AeP9/LevffdvbvkoiXhum4AtZ9HWGOxWOiw12Ga5jVUWITU63XWWkepVHqBeoSkzuwPwhqs9Qt03n6bmtbv9z3DMNgyrd1uH0DNKJVKZdZqtRzYum3bJ9R8tizrCDbBGnIC07aXtVrtlTaInqDE8svlcgjy42azydmGjuPMGaefYwE5ATcJxVcwwyAIdukDuIK4CCEIdF3/6T2dgJxgNBqJZApmyMJEKgH2bgWSD9rCq0LQ6XTOkcjTsEIrHugDUglwLA/RnjPawqtCgCO7hBIrqFarYh+AVIJIJ2NyAs680Wjc4WRc4DEcDocD6OIIUHjued6e7/sWWnQ1mUycbrc7QOsuGSf88TgrJifIia0EXGYRkknwDGE/8whrZBKIFvV6vR0obp6yRDmEfA/w4nxCpS09U/AuMIeQEwBM4qk4jWzqzVknYxxLm1AmuIfEiSy4CfoY4xiOVSfAJ/kNigmxbCMQgpfznU5AaQUx4iLbCDZj/0SQcWWqbnLSn35lRhc1E3IJP/O4Q25gr4O3mFHAbwtrTKfT6LdF074Au8r5e8ALznwAAAAASUVORK5CYII=', 'ATM စက်');
INSERT INTO public.hotel_amenity (id, code, label_en, icon, label_my) VALUES (4, 'continental breakfast', 'Continental Breakfast', ' data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjDAsJMBn6CQwwAAAB5UlEQVQ4y43TSUgVUBQA0KNIhmQpSdFAlIGQEmVKExlEWX9TFNFA5BBp5LKCaNoIBVG7zJKIFhLRhA0QRSamtpAkSLNPZhs1EGpRxpcW6v8tRNQ/QG93effw3n33viSXHDUsQ8SQ+CtLka6JIMVsxz111rBrCcB96ZNBctyUfCkJcFxQotHdRCQWrHVGrpAL/wsOu+SHE0rjg6kHH7PNX3k6kWqu6+YZUokN5mg0Eg12eGbAEdVaXdGvSb8XklApJEt9NPirT4sW3brNkCeIERHU2aI3toY2JZKEBR3yXRA7fcZ8b+XriK3hto06fbHOZWMeypRlrzTZZvlgNBaMKbPAQhGdis0W0issoNVWb+K9EgwahIkbY6smFSoSAZLkyrdctgxpWG2zWrss0yYUC/a7aNB7v7T4JCTsniXeCTvgpmanp4M5bin0zSqPsUeOarXalRtEshrnpoOINK+81OGgfiF5yhVKNlPASgH56qaDPwZsUqTAPpkypGPUcb8N6HJSqZ7oGl7brt6jBHO32+Xoaa1xXmr8OXVUi5/JyJkyIEENauKmr3Zq/I+s0CCo2VUFChRY66M70qLSi321frxNsFSVNdOat8QNT/QhVZEqi5TpmQSxa7FKAYuFjWj3wHOR8Y1/G6WIiiL+uwcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMTItMTFUMDk6NDg6MjUrMDA6MDDYiWsuAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTEyLTExVDA5OjQ4OjI1KzAwOjAwqdTTkgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII=', 'ဥရောပ မနက်စာ');
INSERT INTO public.hotel_amenity (id, code, label_en, icon, label_my) VALUES (5, 'buffet breakfast', 'Buffet Breakfast', ' data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjDAsJMgyl4opZAAABjElEQVQ4y53PTUiUURjF8d87vZgaU05iQuEgiQYRQwqFLSJmVS0nChLbtgxaB31tq1WLWhi6iqRgNn3QIpQW1UREMWKbpJiFUUwlKDj0aYt3lJlZ6Gtn9dx7/+c8526wupKuajHj7/JFYhV4qzEPLDmq4KxgjWhtCo5X52bX3IjGAN3a69CPvuO6l27X3I675UlkuCJnwnLACcMeSXhusC5mlwuGCfFT2nYVsMNvTZLGdLnbUDLrosshJuSMWARdznlmAUN+aarBF7xTijYc0+rUykOng/IWfXKpzvDWN5XIMGubHysbKtXpT01IpDMQCk0puVfF0vrMSNloi1SDocUmYeCmTBVeW62KjOqNidNrNBEbrio07U4Mbs6Q+9o9DOzxRTlm/GH7E3IG1lPpP/4QV1mf12PoN4l0/ErNjZV69Jk1ZQls1o835kEgo81OH6LDeZ16zCvqttu4sn0GTSKr4JUOJ00ryUh672tgrwGnHQApR3QoemoJgUMyyh6bAy+MeB0Vysf6Rx7+ARIWXxEFNSdzAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTEyLTExVDA5OjUwOjEyKzAwOjAwQfjNdwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0xMi0xMVQwOTo1MDoxMiswMDowMDCldcsAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC', 'မနက်စာ ဘူဖေး');


--
-- Data for Name: hotel_blackout_dates_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: hotel_contact_person; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: hotel_content; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_content (hotel_id, language, terms, policy, cancellation, child_policy, check_in, check_out, check_in_details, check_out_details) VALUES (2, 'my', '', '', '', '', '02:00 PM', '12:00 PM', '02:00 PM', '12:00 PM');
INSERT INTO public.hotel_content (hotel_id, language, terms, policy, cancellation, child_policy, check_in, check_out, check_in_details, check_out_details) VALUES (2, 'en', 'Terms and Conditions', 'Rules and Regulations', 'Cancellation Policy', '', '02:00 PM', '12:00 PM', '02:00 PM', '12:00 PM');


--
-- Data for Name: hotel_image; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_image (id, hotel_id, priority, image_url) VALUES (1, 2, 0, 'https://res.cloudinary.com/innoveller/image/upload/v1694765582/shwebooking/sr0mn3ihaxdt1n6b5d3h.jpg');
INSERT INTO public.hotel_image (id, hotel_id, priority, image_url) VALUES (2, 2, 1, 'https://res.cloudinary.com/innoveller/image/upload/v1694765598/shwebooking/w2ztivf3ddyr1c3pvh4t.jpg');


--
-- Data for Name: hotel_initial_approval; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: hotel_notification_subscriber; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: hotel_payment_account; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_payment_account (hotel_payment_account_id, hotel_id, account_type, account_holder_name, account_number, financial_institution_id, branch_name, created_by, created_on, updated_by, updated_on, account_holder_contact) VALUES (1, 2, 'BANK_ACCOUNT', 'Sidney', '0101255126552', 4, 'Yangon', 1, '2023-09-15 15:12:09.371', NULL, '2023-09-15 15:12:09.371', '097521222');


--
-- Data for Name: hotel_payment_account_approval; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_payment_account_approval (hotel_payment_account_id, approved_by, approved_on) VALUES (1, 1, '2023-09-15 15:12:45.465');


--
-- Data for Name: hotel_payment_account_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_payment_account_doc (hotel_payment_account_doc_id, hotel_payment_account_id, file_name, s3_key, created_by, created_on) VALUES (1, 1, 'Untitled.jpg', 'bank-account-docs/2-f2b17a18-29aa-4744-80e8-3de2dd5e92cd', 1, '2023-09-15 15:12:29.721');


--
-- Data for Name: hotel_promotion; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_promotion (id, title, description, hotel_id, rate_group_ids, minimum_check_in_date, maximum_check_out_date, start_booking_date, end_booking_date, discount_percentage, minimum_advance_days, minimum_number_of_nights, maximum_number_of_nights, created_by, created_at, updated_by, updated_at, is_active, is_reviewed, title_my, description_my, group_id, is_updated) VALUES (1, 'September Promotion', 'September Promotion', 2, '{1}', '2023-09-15', '2023-09-30', NULL, NULL, 5, NULL, NULL, NULL, 1, '2023-09-15 15:15:07.063', 1, '2023-09-15 15:15:10.705', true, true, '', '', '34a656f1-c9d6-4f25-9a18-9affb797dd00', false);


--
-- Data for Name: hotel_rate_limit; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotel_rate_limit (hotel_id, minimum_rate_limit, rate_limit_type) VALUES (2, 200.00, 'DEFAULT');
INSERT INTO public.hotel_rate_limit (hotel_id, minimum_rate_limit, rate_limit_type) VALUES (3, 200.00, 'DEFAULT');


--
-- Data for Name: hotel_search_history; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: hotel_to_attraction; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: hotel_user_role; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: message_read; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payment (id, payment_method_code, currency, amount, transaction_reference, memo, created_at) VALUES (1, 'kbz_transfer', 'MMK', 1900.00, '122452222', 'hj', '2023-09-15 15:20:47.85');
INSERT INTO public.payment (id, payment_method_code, currency, amount, transaction_reference, memo, created_at) VALUES (2, 'kbz_transfer', 'MMK', 1942.00, '1458963', 'No memo.', '2023-09-20 11:02:44.145');


--
-- Data for Name: payment_migs_gateway; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: public_holiday; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: rate_group; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rate_group (id, guest_type, room_type_id, minimum_advance_days, maximum_advance_days, title, currency, is_active, based_on_plan_id, additional_percentage, description, dependent_rate_type, additional_flat_amount, template_type) VALUES (1, 'any', 1, NULL, NULL, 'Standard Rate', 'MMK', true, NULL, NULL, 'Default Rate Plan', NULL, NULL, 'DEFAULT');


--
-- Data for Name: rate_group_date_rate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-15', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-16', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-17', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-18', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-19', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-20', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-21', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-22', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-23', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-24', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-25', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-26', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-27', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-28', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-29', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-09-30', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-01', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-02', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-03', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-04', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-05', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-06', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-07', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-08', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-09', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-10', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-11', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-12', 2000.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-18', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-19', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-20', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-21', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-22', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-23', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-24', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-25', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-26', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-27', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-28', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-29', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-09-30', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-01', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-02', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-03', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-04', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-05', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-06', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-07', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-08', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-09', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-10', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-11', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-12', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-13', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-14', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (2, '2023-10-15', 1800.00);
INSERT INTO public.rate_group_date_rate (rate_group_id, date, rate) VALUES (1, '2023-10-13', 2000.00);


--
-- Data for Name: rate_message; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: reference_block_starter; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.reference_block_starter (id, next_block_first_value, updated_at) VALUES (1, 10000100, '2022-04-27 10:45:27.395352');


--
-- Data for Name: room_bed_count; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.room_bed_count (room_type_id, bed_type_id, number_of_bed) VALUES (1, 2, 1);


--
-- Data for Name: room_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.room_type (id, hotel_id, name, description, max_adults_without_extra_bed, max_guests_without_extra_bed, max_adults_with_extra_bed, max_guests_with_extra_bed, number_of_extra_bed, facility_codes, name_mm, description_mm, number_of_room, is_active, is_archived, priority) VALUES (1, 2, 'Superior', 'Superior Description', 2, 2, 3, 3, 1, '{ac,deskchair,hairdryer,radio,telephone}', '', '', 10, true, false, -1);


--
-- Data for Name: room_type_date_allotment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-15', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-16', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-17', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-18', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-19', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-20', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-21', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-22', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-23', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-24', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-25', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-26', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-27', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-28', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-29', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-09-30', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-01', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-02', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-03', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-04', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-05', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-06', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-07', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-08', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-09', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-10', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-11', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-12', 10);
INSERT INTO public.room_type_date_allotment (room_type_id, date, allotment) VALUES (1, '2023-10-13', 1);


--
-- Data for Name: room_type_extra_bed_rate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.room_type_extra_bed_rate (room_type_id, rate, rate_group_id) VALUES (1, 1300.00, 1);


--
-- Data for Name: room_type_facility; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.room_type_facility (id, code, label_en, icon_url, icon, label_my) VALUES (1, 'radio', 'Radio', NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCQIOOwDNMatEAAABs0lEQVQ4y43TT0iUURQF8N/3zTQyTBkFVogVpUUFRdEq+ofI4CKoIMxNUYtylVSItGkR0WK2boKMqIhsIbUIAsESoQk3FQYKLRRrUVghOkLJMCotHGZCar7e6jzOOffed9+9RJ0GN9WWr2EFaUKrl7KqzEaGtU3GpKw2yShpQot+X2XUR8fdLmNSvxYr/iUJQMpWe1x0SL97Jv6qzBs3RyB0wyWfLURkj9mky624aw7b4Xt0vdbp9TMw5qQRHHemgvihF9irJ1CQNI8uK/Utkz1yQR7HTOlAlZm4mPkiPax3meG+Z36hTh0oiMdL5LxO55YZkrIWsV5Pua2LxfFYraHCG8bkEMqzGNmdVGniQoUoQ9qInGndqv/HcMAXjVjljj5BtGFQaxHFfNAkVCjvwxHd2gRodtdZsNObIrtgyK4luJRhgylXjTqt3g+XjWvGW+lSwNdO/FnSfmPibruuyTuhx9pxyqjNCHQYlhAoMG0tQs/lTNgoYcCMj2pAuylDPsnaghrfeOpKMWmteAnFSqWscdTu4t50ehKo98qgAXMR35eUdlBjgJTz9qmOMOS898DcbwX8cqbha0JgAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTA5LTAyVDEyOjU5OjAwKzAyOjAwV+m+jwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0wOS0wMlQxMjo1OTowMCswMjowMCa0BjMAAAAZdEVYdFNvZnR3YXJlAHd3dy5pbmtzY2FwZS5vcmeb7jwaAAAAAElFTkSuQmCC', 'ရေဒီယို');
INSERT INTO public.room_type_facility (id, code, label_en, icon_url, icon, label_my) VALUES (2, 'telephone', 'Telephone', NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAACmklEQVRIS71VzYtSURQ30ZTnx3s+ny8/UBu/Bg3UaeOMmhY2KLYqaBEEIypRES1mETGV0rawTRS4KGhltKiE1iExEBgxi4mZolkUtKj/ot/x+erBjNa1jws/zj3vnnd+9/7Oue/p/stIpVI+q9Xas9lsAy3w7AaW9ylRfzAo+fz8oSymlOwHBEHocBbLwGKx9Nlg7UuSdAI5lEG7hdm1U1EUTyFwrVKp2FlQLBYlEFFOZUwj4HnHKqaXcZo3Tqdz/VfgeeF9t9s1shK0MpnMsvJ0+rDb7S/b7fb+XQSowxEsduDWCEj+hJFAlGV5cSJBMBg8GAgEmirC4XBTS+D3+2+SPwmoVRMxt3ie39yTAGaiRA6HY4ns78Dr9a7OUoMi0CJghwv5fD6k+pDkDCxpf418SN2aqcjpdPqqz+frgKCeKxSWkeARLuhJ+C8oFvpvU53wzgazRJi2KDla9aFKYDQan2P9kkqAFt0RRakOf5uZAC8tUGICNI7hIrlVH4UddRdsbbxeZ5bIbDavYYdbvCB8dLvdK7lc7ii0/oT1ty6X6ynFejyer/CHiPs280UbSzCSiJ5hLgAjiSSXa0h24j2AmUZwBa26gbh3qMPZbDZ7DKf6gGevQfCYYrHzz8qngv/CTIBLd3huLtwkJJPJWLlc9qh+PB4/TrGJRGJl7NfPzSIRdn4bu36gkeiZXq+/qEqE2B2YGnJtzdSm6JLzKGxbQ3DfYDDkVQLIswmTQq7hngT4lhQkWV5XgW55pRJgXpXlA/cIkGupVCrFVD8SiVygHKFQ6A75+KbdZeoi3NDrjUZDZEG1eto9zqkMjrP2sJNFHM2gBQg6JpNpAPRZgFr1UbOfv8xoNOrjOK5Hx9ICmv+dn/6/Gzrdd1KzHNBawrydAAAAAElFTkSuQmCC', 'တယ်လီဖုန်း');
INSERT INTO public.room_type_facility (id, code, label_en, icon_url, icon, label_my) VALUES (3, 'ac', 'Air-condition', NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMjHxIGmVAAABaUlEQVRIS+1Uu2qEQBQVxUKjY9TV8YUakKAEAioEO7cJqUJgf0GwyR9stU3qNGEhkDpsL6nzDf5R7h00TTashnS7Bw5z78xwzuXOgzvhSKAoypoQ0ikK6XRd79I0vRzzv1DTzj9kWV4z8SiKMhB9Y8k/4kxVt47jZBiXum5u2OwB+L6/0jQNKvzJJEkq0zQ3nuc9417LslCzxHiywRycDA5irwGl9H3fAc6hbTs71Po2EEURDHRmYFm0h1vwOodQ1BZ4Ydv2C+YWpT1qmaNBVVUGPIpPSZJWhGi42PI834LpFcZTKAjCwxjDA+0xR826rhcwx3HwIKIwDFu454yu6zbAxZjPZRAEDWoy8d8ABreGYVRDzFqY5/m1qqr3GENb2BzsuXGD4A7jWYD/aRfHMasCDw9HaCeKYytgnbC5LMsiaAc72MmA6pbU8x6HlBsvQVEUJZwV9hv3POGIgAIa+CaWQ3rCcYHjvgAVIXQKbTzfiQAAAABJRU5ErkJggg==', 'အဲကွန်း');
INSERT INTO public.room_type_facility (id, code, label_en, icon_url, icon, label_my) VALUES (4, 'deskchair', 'Desk and chair', NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCQYKCCyD6Z0cAAAA10lEQVQ4y+XRMUtCURyG8Z92w1pyaC0H3foGLk06Cy4t9RXa6zO4SFODi5FjJQQ2JDTUVNBShG4tCdEHEBxquHq5kHq5s+9ZzvPnfQ6cc1jBZFK1TxXTCIE342wKYV/GQ6Avv7Cy5s5JRDV0A1uqC4W8Vox2ZT0Grp2ruP9X3lbwqhmbbKiZhNuXOaeXnaGgOF17nsObL8uxuu+I1pOFTSOfEZWShYZbPe/gQDtZyNlx4ReMdDRZ/nF1V9M6X8ZKScKhyxi1Hc2EpznlHwMfhrHJTfhOK5g/xREnDYTc4ZcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDktMDZUMTA6MDg6NDQrMDA6MDCnHWJdAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA5LTA2VDEwOjA4OjQ0KzAwOjAw1kDa4QAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII=', 'စားပွဲခုံ');
INSERT INTO public.room_type_facility (id, code, label_en, icon_url, icon, label_my) VALUES (5, 'hairdryer', 'Hairdryer', NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfjCxkFCCoTbGu9AAABTklEQVQ4y+XSMUjUYRjH8Y//S4iQGuKSDsXS4/KuXI4gl7bLW7JNnBMyKJGGhoio5dYGB4dwMAJJKgQbagnaQm1pCMK/dtcpUYIFKhkkdzicIJxpV+DUb3qf9+H7PL/3fR72W3V/yEc0i4kqe+PbbsBBSaed0S6hDXlxnzUadtuvaiDmlYQfpoVCoTmflIwpGPXIim6OGjIgY8RZpC26YaKqTJf3OOSD64EpUVc9te61FDas7nhnq6Q7ym66wgFQr3JKy+ur6nDeuiFfXHPcz0CTx3J6PZfZ5afeeWFQ0UtNlgOTvjrnnikPpH4LrMlZ0qnglvHqZNKGebMGZJ0U2bq9a0xETtGRnXOI69AuJemUeh+FQpdNO6HkkoW9t6BFVsEzDy26L6hted66gCf6K2GN1Lb+D2BVFMes1Fqyx3cz5hyu3UXCRQ1/a/3ftQlW8FIL1iX1iwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxOS0xMS0yNVQwNTowODo0MiswMDowMNXfB/QAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTktMTEtMjVUMDU6MDg6NDIrMDA6MDCkgr9IAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg==', 'ဆံပင်အခြောက်ခံစက်');


--
-- Data for Name: room_type_image; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.room_type_image (id, room_type_id, priority, image_url) VALUES (1, 1, 0, 'https://res.cloudinary.com/innoveller/image/upload/v1694766309/shwebooking/cqkurlbwah2xuojb7x2u.jpg');
INSERT INTO public.room_type_image (id, room_type_id, priority, image_url) VALUES (2, 1, 1, 'https://res.cloudinary.com/innoveller/image/upload/v1694766323/shwebooking/krkfibe8ifj9wda4mntv.jpg');


--
-- Data for Name: room_type_promotion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: settlement_booking; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: settlement_confirmation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: settlement_doc; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: settlement_request; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: signed_in_event; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.signed_in_event (id, user_account_id, created_at) VALUES (1, 1, '2023-09-15 14:27:14.544');
INSERT INTO public.signed_in_event (id, user_account_id, created_at) VALUES (2, 1, '2023-09-18 10:13:31.765');
INSERT INTO public.signed_in_event (id, user_account_id, created_at) VALUES (3, 1, '2023-09-18 10:41:26.053');
INSERT INTO public.signed_in_event (id, user_account_id, created_at) VALUES (4, 1, '2023-09-19 12:10:38.321');
INSERT INTO public.signed_in_event (id, user_account_id, created_at) VALUES (5, 1, '2023-09-19 17:14:29.429');
INSERT INTO public.signed_in_event (id, user_account_id, created_at) VALUES (6, 1, '2023-09-20 10:00:55.589');


--
-- Data for Name: support_team; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.support_team (id, address, phone_number) VALUES (1, 'Pyay Rd 270, 1B Sanchaung Yangon MM 11111, Pyay Rd, Yangon', '09 42197 3663');


--
-- Data for Name: system_user_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.system_user_role (user_account_id, role) VALUES (1, 'super_admin');


--
-- Data for Name: tentative_booking; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tentative_booking (id, hotel_id, agent_id, checkin_date, checkout_date, number_of_rooms, number_of_guests, primary_guest_id, booker_id, special_request, commission_rate, tax_rate, commissionable_amount, net_amount, tax_amount, total_amount, created_at, expiration_time, booking_session_id, commission_version_id, guest_type, number_of_adults, number_of_children, value_added_promotion_id, agent_hotel_id) VALUES ('82361e0b-d061-431f-ae2f-5db0791c6db6', NULL, NULL, '2023-09-15', '2023-09-16', 1, 3, 1, 1, '', 190.00, 2.00, 1900.00, 1710.00, 42.00, 1942.00, '2023-09-15 15:20:09.281', '2023-09-15 15:30:09.281', '24e688dd-ef61-40ec-9e44-eacabdfa65c2', 1, 'LOCAL', 2, 1, NULL, 2);
INSERT INTO public.tentative_booking (id, hotel_id, agent_id, checkin_date, checkout_date, number_of_rooms, number_of_guests, primary_guest_id, booker_id, special_request, commission_rate, tax_rate, commissionable_amount, net_amount, tax_amount, total_amount, created_at, expiration_time, booking_session_id, commission_version_id, guest_type, number_of_adults, number_of_children, value_added_promotion_id, agent_hotel_id) VALUES ('bdc48cb4-c0ec-4b59-8416-fbfdbc4ab04d', NULL, NULL, '2023-09-24', '2023-09-25', 1, 2, 2, 2, '', 285.00, 2.00, 1900.00, 1615.00, 42.00, 1942.00, '2023-09-20 10:01:43.319', '2023-09-20 10:11:43.319', '38628a4f-972b-4b90-bdd2-fb8996490cc0', 2, 'LOCAL', 2, 0, NULL, 2);
INSERT INTO public.tentative_booking (id, hotel_id, agent_id, checkin_date, checkout_date, number_of_rooms, number_of_guests, primary_guest_id, booker_id, special_request, commission_rate, tax_rate, commissionable_amount, net_amount, tax_amount, total_amount, created_at, expiration_time, booking_session_id, commission_version_id, guest_type, number_of_adults, number_of_children, value_added_promotion_id, agent_hotel_id) VALUES ('baabcb53-5c8e-47e9-9c48-4aa071db319b', NULL, NULL, '2023-09-22', '2023-09-23', 1, 2, 3, 3, '', 285.00, 2.00, 1900.00, 1615.00, 42.00, 1942.00, '2023-09-20 11:02:27.587', '2023-09-20 11:12:27.587', 'bccd5bce-cbef-4030-a871-155cfaf6d8c2', 2, 'LOCAL', 2, 0, NULL, 2);


--
-- Data for Name: tentative_booking_confirm_attempt; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tentative_booking_confirm_attempt (id, tentative_booking_id, payment_id, is_fully_paid, created_at) VALUES (1, '82361e0b-d061-431f-ae2f-5db0791c6db6', 1, true, '2023-09-15 15:20:47.854');
INSERT INTO public.tentative_booking_confirm_attempt (id, tentative_booking_id, payment_id, is_fully_paid, created_at) VALUES (2, 'baabcb53-5c8e-47e9-9c48-4aa071db319b', 2, true, '2023-09-20 11:02:44.147');


--
-- Data for Name: tentative_booking_room; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tentative_booking_room (id, tentative_booking_id, room_type_id, rate_group_id, number_of_adults, number_of_children, number_of_extra_beds) VALUES ('4e0cd9e5-5acf-49df-a2a1-43a6ab5de576', '82361e0b-d061-431f-ae2f-5db0791c6db6', 1, 1, 2, 0, 0);
INSERT INTO public.tentative_booking_room (id, tentative_booking_id, room_type_id, rate_group_id, number_of_adults, number_of_children, number_of_extra_beds) VALUES ('fefb424b-726f-4daa-a3f0-47652b352db3', 'bdc48cb4-c0ec-4b59-8416-fbfdbc4ab04d', 1, 1, 2, 0, 0);
INSERT INTO public.tentative_booking_room (id, tentative_booking_id, room_type_id, rate_group_id, number_of_adults, number_of_children, number_of_extra_beds) VALUES ('877740be-7f4d-4cc0-8c2f-155d1a8e4f1a', 'baabcb53-5c8e-47e9-9c48-4aa071db319b', 1, 1, 2, 0, 0);


--
-- Data for Name: tentative_booking_room_rate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tentative_booking_room_rate (id, tentative_booking_room_id, date, sell_rate, sell_rate_room_charge, sell_rate_extra_beds_charge, net_rate, promotion_type, promotion_id, applied_discount_amount, commissionable_amount, commission_rate) VALUES (1, '4e0cd9e5-5acf-49df-a2a1-43a6ab5de576', '2023-09-15', 1900.00, 2000.00, 0.00, 1710.00, 'HOTEL_PROMOTION', 1, 100, 1900.00, 190.00);
INSERT INTO public.tentative_booking_room_rate (id, tentative_booking_room_id, date, sell_rate, sell_rate_room_charge, sell_rate_extra_beds_charge, net_rate, promotion_type, promotion_id, applied_discount_amount, commissionable_amount, commission_rate) VALUES (2, 'fefb424b-726f-4daa-a3f0-47652b352db3', '2023-09-24', 1900.00, 2000.00, 0.00, 1615.00, 'HOTEL_PROMOTION', 1, 100, 1900.00, 285.00);
INSERT INTO public.tentative_booking_room_rate (id, tentative_booking_room_id, date, sell_rate, sell_rate_room_charge, sell_rate_extra_beds_charge, net_rate, promotion_type, promotion_id, applied_discount_amount, commissionable_amount, commission_rate) VALUES (3, '877740be-7f4d-4cc0-8c2f-155d1a8e4f1a', '2023-09-22', 1900.00, 2000.00, 0.00, 1615.00, 'HOTEL_PROMOTION', 1, 100, 1900.00, 285.00);


--
-- Data for Name: town; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.town (id, name_en, name_mm, description_en, description_mm, image_url, latitude, longitude, name_mm_soundex) VALUES (1, 'Yangon', 'ရန်ကုန်', NULL, NULL, NULL, 16.840939, 96.173526, 'Y_AN K_OME');


--
-- Data for Name: township; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.township (id, name_en, name_mm, description_en, description_mm, image_url, town_id, latitude, longitude, name_mm_soundex) VALUES (1, 'Mayangone', 'မရမ်းကုန်း', NULL, NULL, NULL, 1, 16.8616276, 96.1473964, 'M_A Y_AN K_OME');


--
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_account (id, email, display_name, is_system_user, is_active, preferred_language, oidc_id, oidc_version, get_notified) VALUES (1, 'maythuwin.nesreen@gmail.com', 'May Thu Win', true, true, 'en', 'dbe69b6a-e058-4cff-ade0-da90d32525d6', '2d50596ed5221940330bcd6471676b9d', false);


--
-- Data for Name: user_activity_log; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (1, 2, 1, 'Updated amenities.', '2023-09-15 14:41:19.093');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (2, 2, 1, 'Updated logo image.', '2023-09-15 14:42:45.187');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (3, 2, 1, 'Updated rules and regulations.', '2023-09-15 14:44:31.568');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (4, 2, 1, 'Updated terms and conditions.', '2023-09-15 14:44:38.894');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (5, 2, 1, 'Updated cancellation policy.', '2023-09-15 14:44:47.583');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (6, 2, 1, ' Added new room type Superior.', '2023-09-15 14:46:18.221');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (7, 2, 1, 'Updated facilities of Superior.', '2023-09-15 14:47:08.257');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (8, 2, 1, 'Updated facilities of Superior.', '2023-09-15 14:49:38.778');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (9, 2, 1, 'Updated images of Superior.', '2023-09-15 14:55:24.851');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (10, 2, 1, 'Assigned extra bed rate MMK 15000.0 for Standard Rate plan of Superior.', '2023-09-15 14:55:44.236');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (11, 2, 1, 'Activated Standard Rate plan of Superior.', '2023-09-15 14:55:48.773');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (12, 2, 1, 'Updated allotments from 2023-09-15 to 2023-10-12 as ( 10 ) for Superior.', '2023-09-15 15:08:23.223');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (13, 2, 1, 'Updated rates from 2023-09-15 to 2023-10-12 as ( MMK 2000.00 ) for Superior.', '2023-09-15 15:08:32.387');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (14, 2, 1, 'activated Superior.', '2023-09-15 15:08:45.075');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (15, 2, 1, 'Added new BANK_ACCOUNT.', '2023-09-15 15:12:09.379');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (16, 2, 1, 'Activated property.', '2023-09-15 15:13:37.655');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (17, 2, 1, 'Created Early Bird Rate plan of Superior.', '2023-09-18 10:50:15.697');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (18, 2, 1, 'Activated Early Bird Rate plan of Superior.', '2023-09-18 10:50:21.073');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (19, 2, 1, 'Edited  Early Bird Rate plan of Superior.', '2023-09-18 10:52:07.031');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (20, 2, 1, 'Updated rates from 2023-09-18 to 2023-10-15 as ( MMK 1800.00 ) for Superior.', '2023-09-18 10:52:21.854');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (21, 2, 1, 'Created Custom plan of Superior.', '2023-09-18 10:53:42.934');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (22, 2, 1, 'Assigned extra bed rate MMK 1200.0 for Early Bird Rate plan of Superior.', '2023-09-18 10:58:39.499');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (23, 2, 1, 'Assigned extra bed rate MMK 1500.0 for Standard Rate plan of Superior.', '2023-09-18 10:58:55.418');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (24, 2, 1, 'Assigned extra bed rate MMK 1300.0 for Standard Rate plan of Superior.', '2023-09-18 16:23:51.383');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (25, 2, 1, 'Updated commission.', '2023-09-19 12:11:01.832');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (26, 2, 1, 'Updated allotment of 2023-10-13 as ( 1 ) for Superior.', '2023-09-20 13:25:49.955');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (27, 2, 1, 'Updated allotment of 2023-10-13 as ( 1 ) for Superior.', '2023-09-20 13:25:49.956');
INSERT INTO public.user_activity_log (id, hotel_id, user_id, message, date) VALUES (28, 2, 1, 'Updated rate of 2023-10-13 as ( MMK 2000.00 ) for Superior.', '2023-09-20 13:25:56.95');

