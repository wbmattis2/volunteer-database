CREATE TABLE persons (
  id integer PRIMARY KEY,
  email varchar (30) CHECK (email LIKE '%@%.%') UNIQUE
);

INSERT INTO persons (id, email) VALUES 
  (0, 'bob@bob.com'),
  (1, 'charles@charles.com')
;

CREATE TABLE opp_types (
  id integer PRIMARY KEY,
  opportunity_type varchar(30) UNIQUE,
  max_vols integer CHECK (max_vols < 10)
);

INSERT INTO opp_types (id, opportunity_type, max_vols) VALUES 
(0, 'Activity', 2),
(1, 'kitchen', 4)
;

CREATE TABLE vol_opps (
  vol_shift_id integer PRIMARY KEY,
  opportunity_type_id integer REFERENCES opp_types (id),
  start_time timestamp,
  end_time timestamp CHECK (end_time > start_time)
);

INSERT INTO vol_opps (vol_shift_id, opportunity_type_id, start_time, end_time) VALUES 
  (0, 0, '2004-10-19 10:23:54', '2004-10-19 10:23:55'),
  (1, 1, '2004-10-19 09:23:54', '2004-10-19 09:24:54');

CREATE TABLE opps_persons (
  person_id integer REFERENCES persons(id),
  vol_shift integer REFERENCES vol_opps (vol_shift_id)
);
  
INSERT INTO opps_persons (person_id, vol_shift) VALUES 
  (0, 0),
  (1, 0),
  (1, 1)
;

SELECT * FROM opps_persons;

SELECT persons.email, opp_types.opportunity_type, vol_opps.start_time 
FROM persons, opp_types, vol_opps, opps_persons
WHERE vol_opps.start_time = '2004-10-19 09:23:54'
AND persons.id = opps_persons.person_id
AND vol_opps.vol_shift_id = opps_persons.vol_shift
AND opp_types.id = vol_opps.opportunity_type_id;

ALTER TABLE opps_persons
RENAME COLUMN vol_shift TO vol_opps_vol_shift_id;
