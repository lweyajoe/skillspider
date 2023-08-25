CREATE TABLE business_stream (
    id int  NOT NULL,
    business_stream_name varchar(100)  NOT NULL,
    CONSTRAINT business_stream_pk PRIMARY KEY (id)
);


CREATE TABLE company (
    id int  NOT NULL,
    company_name varchar(100)  NOT NULL,
    profile_description varchar(1000)  NOT NULL,
    business_stream_id int  NOT NULL,
    establishment_date date  NOT NULL,
    company_website_url varchar(500)  NOT NULL,
    CONSTRAINT company_pk PRIMARY KEY (id)
);


CREATE TABLE company_image (
    id int  NOT NULL,
    company_id int  NOT NULL,
    company_image blob  NOT NULL,
    CONSTRAINT company_image_pk PRIMARY KEY (id)
);


CREATE TABLE education_detail (
    user_account_id int  NOT NULL,
    certificate_degree_name varchar(50)  NOT NULL,
    major varchar(50)  NOT NULL,
    Institute_university_name varchar(50)  NOT NULL,
    starting_date date  NOT NULL,
    completion_date date  NULL,
    percentage int  NULL,
    cgpa int  NULL,
    CONSTRAINT education_detail_pk PRIMARY KEY (user_account_id,certificate_degree_name,major)
);


CREATE TABLE experience_detail (
    user_account_id int  NOT NULL,
    is_current_job char(1)  NOT NULL,
    start_date date  NOT NULL,
    end_date date  NOT NULL,
    job_title varchar(50)  NOT NULL,
    company_name varchar(100)  NOT NULL,
    job_location_city varchar(50)  NOT NULL,
    job_location_state varchar(50)  NOT NULL,
    job_location_country varchar(50)  NOT NULL,
    description varchar(4000)  NOT NULL,
    CONSTRAINT experience_detail_pk PRIMARY KEY (user_account_id,start_date,end_date)
);


CREATE TABLE job_location (
    id int  NOT NULL,
    street_address varchar(100)  NOT NULL,
    city varchar(50)  NOT NULL,
    state varchar(50)  NOT NULL,
    country varchar(50)  NOT NULL,
    zip varchar(50)  NOT NULL,
    CONSTRAINT job_location_pk PRIMARY KEY (id)
);


CREATE TABLE job_post (
    id int  NOT NULL,
    posted_by_id int  NOT NULL,
    job_type_id int  NOT NULL,
    company_id int  NOT NULL,
    is_company_name_hidden char(1)  NOT NULL,
    created_date date  NOT NULL,
    job_description varchar(500)  NOT NULL,
    job_location_id int  NOT NULL,
    is_active char(1)  NOT NULL,
    CONSTRAINT job_post_pk PRIMARY KEY (id)
);


CREATE TABLE job_post_activity (
    user_account_id int  NOT NULL,
    job_post_id int  NOT NULL,
    apply_date date  NOT NULL,
    CONSTRAINT job_post_activity_pk PRIMARY KEY (user_account_id,job_post_id)
);


CREATE TABLE job_post_skill_set (
    skill_set_id int  NOT NULL,
    job_post_id int  NOT NULL,
    skill_level int  NOT NULL,
    CONSTRAINT job_post_skill_set_pk PRIMARY KEY (skill_set_id,job_post_id)
);


CREATE TABLE job_type (
    id int  NOT NULL,
    job_type varchar(20)  NOT NULL,
    CONSTRAINT job_type_pk PRIMARY KEY (id)
);


CREATE TABLE seeker_profile (
    user_account_id int  NOT NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    current_salary bigint  NULL,
    is_annually_monthly varchar(1)  NULL,
    currency varchar(50)  NULL,
    CONSTRAINT seeker_profile_pk PRIMARY KEY (user_account_id)
);


CREATE TABLE seeker_skill_set (
    user_account_id int  NOT NULL,
    skill_set_id int  NOT NULL,
    skill_level int  NOT NULL,
    CONSTRAINT seeker_skill_set_pk PRIMARY KEY (user_account_id,skill_set_id)
);


CREATE TABLE skill_set (
    id int  NOT NULL,
    skill_set_name varchar(50)  NOT NULL,
    CONSTRAINT skill_set_pk PRIMARY KEY (id)
);


CREATE TABLE user_account (
    id int  NOT NULL,
    user_type_id int  NOT NULL,
    email varchar(255)  NOT NULL,
    password nvarchar(100)  NOT NULL,
    date_of_birth date  NOT NULL,
    gender char(1)  NOT NULL,
    is_active char(1)  NOT NULL,
    contact_number int  NOT NULL,
    sms_notification_active char(1)  NOT NULL,
    email_notification_active char(1)  NOT NULL,
    user_image blob  NULL,
    registration_date date  NOT NULL,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);


CREATE TABLE user_log (
    user_account_id int  NOT NULL,
    last_login_date date  NOT NULL,
    last_job_apply_date date  NULL,
    CONSTRAINT user_log_pk PRIMARY KEY (user_account_id)
);


CREATE TABLE user_type (
    id int  NOT NULL,
    user_type_name varchar(20)  NOT NULL,
    CONSTRAINT user_type_pk PRIMARY KEY (id)
);


ALTER TABLE company ADD CONSTRAINT company_business_stream FOREIGN KEY company_business_stream (business_stream_id)
    REFERENCES business_stream (id);


ALTER TABLE company_image ADD CONSTRAINT company_image_company FOREIGN KEY company_image_company (company_id)
    REFERENCES company (id);


ALTER TABLE education_detail ADD CONSTRAINT educ_dtl_seeker_profile FOREIGN KEY educ_dtl_seeker_profile (user_account_id)
    REFERENCES seeker_profile (user_account_id);


ALTER TABLE experience_detail ADD CONSTRAINT exp_dtl_seeker_profile FOREIGN KEY exp_dtl_seeker_profile (user_account_id)
    REFERENCES seeker_profile (user_account_id);


ALTER TABLE job_post_activity ADD CONSTRAINT job_post_act_user_register FOREIGN KEY job_post_act_user_register (user_account_id)
    REFERENCES user_account (id);


ALTER TABLE job_post_activity ADD CONSTRAINT job_post_activity_job_post FOREIGN KEY job_post_activity_job_post (job_post_id)
    REFERENCES job_post (id);


ALTER TABLE job_post ADD CONSTRAINT job_post_company FOREIGN KEY job_post_company (company_id)
    REFERENCES company (id);


ALTER TABLE job_post ADD CONSTRAINT job_post_job_location FOREIGN KEY job_post_job_location (job_location_id)
    REFERENCES job_location (id);


ALTER TABLE job_post ADD CONSTRAINT job_post_job_type FOREIGN KEY job_post_job_type (job_type_id)
    REFERENCES job_type (id);


ALTER TABLE job_post_skill_set ADD CONSTRAINT job_post_skill_set_job_post FOREIGN KEY job_post_skill_set_job_post (job_post_id)
    REFERENCES job_post (id);


ALTER TABLE job_post_skill_set ADD CONSTRAINT job_post_skill_set_skill_set FOREIGN KEY job_post_skill_set_skill_set (skill_set_id)
    REFERENCES skill_set (id);


ALTER TABLE job_post ADD CONSTRAINT job_post_user_register FOREIGN KEY job_post_user_register (posted_by_id)
    REFERENCES user_account (id);


ALTER TABLE seeker_profile ADD CONSTRAINT seeker_profile_user_register FOREIGN KEY seeker_profile_user_register (user_account_id)
    REFERENCES user_account (id);


ALTER TABLE seeker_skill_set ADD CONSTRAINT seeker_skill_set_skill_set FOREIGN KEY seeker_skill_set_skill_set (skill_set_id)
    REFERENCES skill_set (id);


ALTER TABLE seeker_skill_set ADD CONSTRAINT skill_set_seeker_profile FOREIGN KEY skill_set_seeker_profile (user_account_id)
    REFERENCES seeker_profile (user_account_id);


ALTER TABLE user_log ADD CONSTRAINT use_log_user_register FOREIGN KEY use_log_user_register (user_account_id)
    REFERENCES user_account (id);


ALTER TABLE user_account ADD CONSTRAINT user_register_user_type FOREIGN KEY user_register_user_type (user_type_id)
    REFERENCES user_type (id);



