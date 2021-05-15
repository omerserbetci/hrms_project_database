-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.users
(
    id integer NOT NULL generated by default as identity (increment by 1 start 1),
    email character varying(100) NOT NULL,
    password character varying NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidates
(
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    surname character varying(80) NOT NULL,
    identity_number character varying(11) NOT NULL,
    date_of_birth date NOT NULL,
    PRIMARY KEY (user_id)
);

COMMENT ON TABLE public.candidates
    IS 'İş arayanların tutulduğu tablo';

CREATE TABLE public.employers
(
    user_id integer NOT NULL,
    company_name character varying(200) NOT NULL,
    web_site character varying(100) NOT NULL,
    PRIMARY KEY (user_id)
);

COMMENT ON TABLE public.employers
    IS 'İş verenlerin tutulduğu tablo';

CREATE TABLE public.personnels
(
    user_id integer NOT NULL,
    isim character varying(100) NOT NULL,
    soyisim character varying NOT NULL,
    PRIMARY KEY (user_id)
);

COMMENT ON TABLE public.personnels
    IS 'Sistem çalışanlarının tutulduğu tablo';

CREATE TABLE public.phone_numbers
(
    id integer NOT NULL generated by default as identity (increment by 1 start 1),
    phone_number character varying NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employer_phone_numbers
(
    phone_number_id integer NOT NULL,
    employer_id integer NOT NULL,
    PRIMARY KEY (phone_number_id)
);

CREATE TABLE public.verification_codes
(
    id integer NOT NULL generated by default as identity (increment by 1 start 1),
    verification_code character varying(100) NOT NULL,
    is_confirmed boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_verification_codes
(
    verification_code_id integer NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (verification_code_id)
);

CREATE TABLE public.employer_verification_codes
(
    verification_code_id integer NOT NULL,
    employer_id integer NOT NULL,
    PRIMARY KEY (verification_code_id)
);

CREATE TABLE public.personnel_verifications
(
    id integer NOT NULL generated by default as identity (increment by 1 start 1),
    personnel_id integer NOT NULL,
    is_confirmed boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers_personnel_verifications
(
    personnel_verification_id integer NOT NULL,
    employer_id integer NOT NULL,
    PRIMARY KEY (personnel_verification_id)
);

CREATE TABLE public.job_positions
(
    id integer NOT NULL  generated by default as identity (increment by 1 start 1),
    job_position character varying(100) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE public.candidates
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.personnels
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employer_phone_numbers
    ADD FOREIGN KEY (phone_number_id)
    REFERENCES public.phone_numbers (id)
    NOT VALID;


ALTER TABLE public.employer_phone_numbers
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (user_id)
    NOT VALID;


ALTER TABLE public.candidate_verification_codes
    ADD FOREIGN KEY (verification_code_id)
    REFERENCES public.verification_codes (id)
    NOT VALID;


ALTER TABLE public.candidate_verification_codes
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (user_id)
    NOT VALID;


ALTER TABLE public.employer_verification_codes
    ADD FOREIGN KEY (verification_code_id)
    REFERENCES public.verification_codes (id)
    NOT VALID;


ALTER TABLE public.employer_verification_codes
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (user_id)
    NOT VALID;


ALTER TABLE public.personnel_verifications
    ADD FOREIGN KEY (personnel_id)
    REFERENCES public.personnels (user_id)
    NOT VALID;


ALTER TABLE public.employers_personnel_verifications
    ADD FOREIGN KEY (personnel_verification_id)
    REFERENCES public.personnel_verifications (id)
    NOT VALID;


ALTER TABLE public.employers_personnel_verifications
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (user_id)
    NOT VALID;

END;