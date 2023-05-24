TRUNCATE TABLE users, spaces, reservations RESTART IDENTITY;

INSERT INTO users ("name", "email", "username", "password") VALUES
('Pepito Callicott', 'pcallicott0@opensource.org', 'pcallicott0', '$2a$12$xvAuYORc90Q/B4FZ0eFWP.uWnlfJquXxAEaBjf32MaQKHf1i8I.sS'), --lasvegas
('Drugi Leverson', 'dleverson1@cbsnews.com', 'dleverson1', '$2a$12$WiEPw6ZTKxsDaGDwse1m1es8cCDPxe9lQuO5aRZeWCFl0ZXem0tp.'), --bootcamp
('La verne Berk', 'lverne2@ucoz.com', 'lverne2', '$2a$12$OGxCTuwon7jt8oJN5RTyXOdM8unFBHu3dJbKkINm8FhZ2s8kjnh/O'), --calumclarke
('Bartel McKue', 'bmckue3@hostgator.com', 'bmckue3', '$2a$12$QYNA86gvZ3V53OKLaOhSA.QBhc.tRg0FVcUnMY0BtrtXRRFdQAhiO'), --jamespates
('Horacio Dunkley', 'hdunkley4@gravatar.com', 'hdunkley4', '$2a$12$c4P9w6iTawRY6HwGi6A0WuRR51Xcwgq6s5ihVQyjqfO7DoUJfdoOa'), --makers
('Ikey Mackinder', 'imackinder5@mtv.com', 'imackinder5', '$2a$12$vjZpA/5xyoZ.DsiFFjxvSuJtOVBoMl6R1tYSR8nehnKz8pILph/UW'), --wordpass
('Alia Freeth', 'afreeth6@tinyurl.com', 'afreeth6', '$2a$12$FlTl0ei1YTDqOWhHgfuXeeLmY2oQzRoNbFA28iecvQWHOxkDtm2ld'); -- password

INSERT INTO spaces ("title", "description", "price", "address", "available_dates", "user_id") VALUES
('Title1', 'description1', 12.00, 'Address1', '[2010-01-13 14:30:01, 2010-01-14 15:30:01]', 1),
('Title2', 'description2', 12.00, 'Address2', '[2010-01-14 14:30:01, 2010-01-15 15:30:01]', 2),
('Title3', 'description3', 12.00, 'Address3', '[2010-01-15 14:30:01, 2010-01-16 15:30:01]', 3),
('Title4', 'description4', 12.00, 'Address4', '[2010-01-16 14:30:01, 2010-01-17 15:30:01]', 1);

INSERT INTO reservations ("start_date", "end_date", "space_id", "user_id") VALUES -- no overlapping dates
('2023-03-13 00:00:01', '2023-03-17 23:59:59', 1, 3),
('2023-03-18 00:00:01', '2023-03-19 23:59:59', 1, 4),
('2023-04-05 00:00:01', '2023-04-10 23:59:59', 1, 2),
('2023-03-20 00:00:01', '2023-03-23 23:59:59', 1, 1),
('2023-04-01 00:00:01', '2023-04-02 23:59:59', 1, 6);





