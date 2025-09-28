-- base table
CREATE TABLE events (
	id SERIAL,
	title VARCHAR(255) NOT NULL,
	event_date DATE NOT NULL,
	PRIMARY KEY(id, event_date)
) PARTITION BY RANGE(event_date);

-- partition table
CREATE TABLE events_2024_01 
PARTITION OF events
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE events_2024_02 
PARTITION OF events
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

CREATE TABLE events_2024_03 
PARTITION OF events
FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');

CREATE TABLE events_2024_04 
PARTITION OF events
FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');


INSERT INTO events (title, event_date)
VALUES
-- January 2024 (40 rows)
('New Year Celebration', '2024-01-01'),
('Winter Coding Bootcamp', '2024-01-02'),
('Startup Pitch Day', '2024-01-03'),
('AI Conference', '2024-01-04'),
('Hackathon Alpha', '2024-01-05'),
('Marketing Webinar', '2024-01-06'),
('Product Launch X1', '2024-01-07'),
('Investor Meetup', '2024-01-08'),
('HR Training', '2024-01-09'),
('Wellness Workshop', '2024-01-10'),
('Blockchain Meetup', '2024-01-11'),
('Data Science Talk', '2024-01-12'),
('UI/UX Workshop', '2024-01-13'),
('Cloud Computing Summit', '2024-01-14'),
('Cybersecurity Awareness', '2024-01-15'),
('Mobile App Demo', '2024-01-16'),
('Leadership Seminar', '2024-01-17'),
('Finance Training', '2024-01-18'),
('Networking Night', '2024-01-19'),
('Startup Mixer', '2024-01-20'),
('Java Workshop', '2024-01-21'),
('Python Bootcamp', '2024-01-22'),
('Postgres Training', '2024-01-23'),
('Team Building', '2024-01-24'),
('Cloud Native Workshop', '2024-01-25'),
('Kubernetes Seminar', '2024-01-26'),
('GitHub Actions Talk', '2024-01-27'),
('CI/CD Training', '2024-01-28'),
('DevOps Meetup', '2024-01-29'),
('Final January Wrap-up', '2024-01-30'),
('Open Source Festival', '2024-01-31'),

-- February 2024 (35 rows)
('Black History Month Kickoff', '2024-02-01'),
('AI Hackathon', '2024-02-02'),
('Startup Weekend', '2024-02-03'),
('Tech for Good Conference', '2024-02-04'),
('Remote Work Seminar', '2024-02-05'),
('Mobile World Congress', '2024-02-06'),
('Leadership Bootcamp', '2024-02-07'),
('SaaS Product Launch', '2024-02-08'),
('Women in Tech Meetup', '2024-02-09'),
('DevRel Workshop', '2024-02-10'),
('SQL Optimization Training', '2024-02-11'),
('React Conference', '2024-02-12'),
('Startup Legal Workshop', '2024-02-13'),
('Valentine Special Event', '2024-02-14'),
('AI in Healthcare', '2024-02-15'),
('Gaming Convention', '2024-02-16'),
('Big Data Conference', '2024-02-17'),
('IoT Summit', '2024-02-18'),
('Career Fair', '2024-02-19'),
('Women Leadership Talk', '2024-02-20'),
('JavaScript Meetup', '2024-02-21'),
('Product Design Workshop', '2024-02-22'),
('Agile Workshop', '2024-02-23'),
('Scrum Training', '2024-02-24'),
('Robotics Expo', '2024-02-25'),
('AI Startups Pitch', '2024-02-26'),
('Cloud Migration Workshop', '2024-02-27'),
('Open Source Day', '2024-02-28'),
('Leap Year Awareness', '2024-02-29'),

-- March 2024 (40 rows)
('Women in Science Day', '2024-03-01'),
('Spring Hackathon', '2024-03-02'),
('Tech Conference Europe', '2024-03-03'),
('AgriTech Meetup', '2024-03-04'),
('Startup Accelerator Demo', '2024-03-05'),
('AI Ethics Talk', '2024-03-06'),
('Kubernetes Deep Dive', '2024-03-07'),
('Machine Learning Bootcamp', '2024-03-08'),
('International Women’s Day Event', '2024-03-08'),
('Remote Engineering Meetup', '2024-03-09'),
('Career Growth Seminar', '2024-03-10'),
('Climate Tech Workshop', '2024-03-11'),
('Data Engineering Talk', '2024-03-12'),
('Finance Tech Forum', '2024-03-13'),
('Metaverse Conference', '2024-03-14'),
('Tech for Kids Event', '2024-03-15'),
('Science Fair', '2024-03-16'),
('Quantum Computing Talk', '2024-03-17'),
('AI Robotics Workshop', '2024-03-18'),
('Cloud Security Seminar', '2024-03-19'),
('Business Pitch Night', '2024-03-20'),
('Web3 Startup Meetup', '2024-03-21'),
('Full-Stack Bootcamp', '2024-03-22'),
('Open Source Hackfest', '2024-03-23'),
('Cybersecurity Drill', '2024-03-24'),
('Investor Roadshow', '2024-03-25'),
('Engineering Leadership Panel', '2024-03-26'),
('Healthcare Innovation Day', '2024-03-27'),
('Spring Networking Gala', '2024-03-28'),
('March End Review', '2024-03-29'),
('Startup Grind Meetup', '2024-03-30'),
('International Data Day', '2024-03-31'),

-- April 2024 (35 rows)
('April Fools Tech Pranks', '2024-04-01'),
('AI in Education Summit', '2024-04-02'),
('Remote Work Expo', '2024-04-03'),
('Startup Fundraising Day', '2024-04-04'),
('Product Launch - April Series', '2024-04-05'),
('Design Thinking Workshop', '2024-04-06'),
('AI Chatbot Conference', '2024-04-07'),
('Healthcare Summit', '2024-04-08'),
('Tech Law Workshop', '2024-04-09'),
('Future of Work Conference', '2024-04-10'),
('Climate Innovation Forum', '2024-04-11'),
('Investor Pitch Workshop', '2024-04-12'),
('AI in Retail', '2024-04-13'),
('Gaming Hackathon', '2024-04-14'),
('Robotics for Kids', '2024-04-15'),
('Open Source Community Day', '2024-04-16'),
('Tech Hiring Fair', '2024-04-17'),
('Data Visualization Workshop', '2024-04-18'),
('April Tech Fest', '2024-04-19'),
('Women in AI', '2024-04-20'),
('Spring Boot Workshop', '2024-04-21'),
('DevOps in Practice', '2024-04-22'),
('SaaS Scaling Summit', '2024-04-23'),
('April Cloud Expo', '2024-04-24'),
('UI/UX Hackathon', '2024-04-25'),
('Entrepreneurship Seminar', '2024-04-26'),
('Cybersecurity Trends Talk', '2024-04-27'),
('Blockchain Conference', '2024-04-28'),
('AI Spring Camp', '2024-04-29'),
('Final April Wrap-Up', '2024-04-30');

INSERT INTO events (title, event_date)
VALUES
-- January 2024 (25 rows)
('AI & Robotics Demo', '2024-01-01'),
('Winter Coding Night', '2024-01-02'),
('Investor Coffee Chat', '2024-01-03'),
('Remote Teams Meetup', '2024-01-04'),
('Data Visualization Hackathon', '2024-01-05'),
('Product Roadmap Reveal', '2024-01-06'),
('January Strategy Session', '2024-01-07'),
('Entrepreneur Talk', '2024-01-08'),
('Tech Hiring Sprint', '2024-01-09'),
('Cybersecurity Masterclass', '2024-01-10'),
('Women in Startups', '2024-01-11'),
('Innovation Roundtable', '2024-01-12'),
('VR/AR Showcase', '2024-01-13'),
('Database Optimization Talk', '2024-01-14'),
('Engineering Career Day', '2024-01-15'),
('Startup Mentoring Workshop', '2024-01-16'),
('Mobile Tech Launch', '2024-01-17'),
('Climate Tech Meetup', '2024-01-18'),
('AI Research Panel', '2024-01-19'),
('Open Source Contributors Meet', '2024-01-20'),
('Tech Community Night', '2024-01-21'),
('January Career Fair', '2024-01-22'),
('Deep Learning Bootcamp', '2024-01-23'),
('Software Engineering Talk', '2024-01-24'),
('Cloud Startups Expo', '2024-01-25'),

-- February 2024 (25 rows)
('AI in Finance Panel', '2024-02-01'),
('Black History Tech Forum', '2024-02-02'),
('Startup Growth Workshop', '2024-02-03'),
('VR Development Bootcamp', '2024-02-04'),
('Gaming Tech Summit', '2024-02-05'),
('Mobile Innovation Pitch', '2024-02-06'),
('AI Health Roundtable', '2024-02-07'),
('Robotics Programming Workshop', '2024-02-08'),
('Startup Finance Training', '2024-02-09'),
('Entrepreneur Networking Night', '2024-02-10'),
('Marketing Tech Meetup', '2024-02-11'),
('Software Testing Workshop', '2024-02-12'),
('DevOps in Practice Talk', '2024-02-13'),
('Valentine’s Innovation Gala', '2024-02-14'),
('AI in Agriculture Summit', '2024-02-15'),
('Open Source Contributors Day', '2024-02-16'),
('Postgres Performance Talk', '2024-02-17'),
('Mobile UX Hackathon', '2024-02-18'),
('Tech Education Forum', '2024-02-19'),
('February Career Fair', '2024-02-20'),
('AI Chatbot Bootcamp', '2024-02-21'),
('Software Architecture Meetup', '2024-02-22'),
('Women in Data Science', '2024-02-23'),
('Scrum Masters Workshop', '2024-02-24'),
('Final February Event', '2024-02-25'),

-- March 2024 (25 rows)
('Spring Tech Day', '2024-03-01'),
('Quantum Innovation Forum', '2024-03-02'),
('AI Startups Demo', '2024-03-03'),
('Software Security Summit', '2024-03-04'),
('Startup Weekend March', '2024-03-05'),
('Healthcare AI Talk', '2024-03-06'),
('Robotics Engineering Day', '2024-03-07'),
('Women Engineers Meetup', '2024-03-08'),
('Spring Data Hackathon', '2024-03-09'),
('Cloud Infrastructure Talk', '2024-03-10'),
('AgriTech Hackfest', '2024-03-11'),
('DevOps Cloud Training', '2024-03-12'),
('Machine Learning Jam', '2024-03-13'),
('International Pi Day Event', '2024-03-14'),
('Engineering Leadership Meet', '2024-03-15'),
('Science Awareness Fair', '2024-03-16'),
('Career Night March', '2024-03-17'),
('Open Innovation Panel', '2024-03-18'),
('AI for Startups', '2024-03-19'),
('Digital Product Design Fair', '2024-03-20'),
('Green Energy Tech Day', '2024-03-21'),
('Investor Meetup March', '2024-03-22'),
('Startup Roadshow', '2024-03-23'),
('Spring Networking Mixer', '2024-03-24'),
('March Wrap-up Talk', '2024-03-25'),

-- April 2024 (25 rows)
('April Startup Forum', '2024-04-01'),
('AI for Education Meetup', '2024-04-02'),
('Tech Spring Innovation', '2024-04-03'),
('April Career Fair', '2024-04-04'),
('Robotics Hackathon', '2024-04-05'),
('AI Research Fair', '2024-04-06'),
('Software Dev Meetup', '2024-04-07'),
('Healthcare Startups Talk', '2024-04-08'),
('Remote Work Innovation', '2024-04-09'),
('April Cloud Expo', '2024-04-10'),
('Climate Solutions Forum', '2024-04-11'),
('Open Source Day', '2024-04-12'),
('AI Hardware Showcase', '2024-04-13'),
('Startup Leadership Summit', '2024-04-14'),
('Career Networking April', '2024-04-15'),
('Mobile App Innovation', '2024-04-16'),
('Cybersecurity Training', '2024-04-17'),
('Engineering Workshop', '2024-04-18'),
('Women Founders Forum', '2024-04-19'),
('AI in Law Seminar', '2024-04-20'),
('Spring Dev Jam', '2024-04-21'),
('SaaS Founders Meetup', '2024-04-22'),
('April Tech Gala', '2024-04-23'),
('Gaming Night April', '2024-04-24'),
('Final April Summit', '2024-04-25');


SELECT * FROM EVENTS;


SELECT 
	DATE_TRUNC('month', event_date) as month,
	COUNT(*) AS event_count
FROM events
GROUP BY month
ORDER BY month


-- function to extract month name
CREATE OR REPLACE FUNCTION month_name_from_int(m integer)
	RETURNS text
	LANGUAGE sql
AS $$
	SELECT to_char(make_date(2000, m, 1), 'FMMonth');
$$;


SELECT 
	EXTRACT(MONTH FROM event_date) AS month_no,
	month_name_from_int(EXTRACT(MONTH FROM event_date)::INT)AS month,
	count(*) as event_count
	FROM events
GROUP BY month_no
ORDER BY month_no;



























