-- Create user type enum
CREATE TYPE user_type AS ENUM ('freelancer', 'client');

-- Create account status enum
CREATE TYPE account_status AS ENUM ('active', 'inactive', 'suspended');

-- Create users table
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	fullname TEXT NOT NULL,
	email TEXT UNIQUE NOT NULL, -- indexed
	password TEXT NOT NULL,
	type user_type NOT NULL DEFAULT 'freelancer', -- indexed
	account_status account_status NOT NULL DEFAULT 'active', -- indexed
	rating DECIMAL(3,2) DEFAULT 0.00,
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)


CREATE INDEX idx_users_email ON users(email); -- for login
CREATE INDEX idx_users_account_status ON users(account_status); -- for account management and filtering
CREATE INDEX idx_users_user_type ON users(type); -- for user type filtering

-- for user type and account status filtering
-- WHERE user_type = 'freelancer' AND account_status = 'active'
-- Could be important in our scenarios
CREATE INDEX idx_users_type_status ON users(type, account_status); 


-- RESET  token
CREATE TABLE reset_tokens(
	id SERIAL NOT NULL PRIMARY KEY,
	user_id SERIAL NOT NULL REFERENCES users(id),
	token VARCHAR(100) NOT NULL,
	expires_in TIMESTAMPTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP + INTERVAL '5 minutes'),
	used BOOLEAN NOT NULL DEFAULT FALSE
)

CREATE INDEX idx_reset_tokens_user_id ON reset_tokens(user_id);

-- Freelancer Profiles
CREATE TABLE freelancer_profiles (
	id SERIAL PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE, -- PK, FK to users
	name VARCHAR(100) DEFAULT '',
	location TEXT DEFAULT '', -- indexed
	hourly_rate DECIMAL(5,2) DEFAULT 0.00, -- indexed
	is_available BOOLEAN NOT NULL DEFAULT TRUE, -- indexed
	skills JSONB, -- array of skill: Denormalized for fast lookup, indexed
	experience JSONB,
	education JSONB,
	portfolio_items JSONB
)

-- find freelancers on dhaka
CREATE INDEX idx_freelancer_profiles_location ON freelancer_profiles(location);
-- Find freelancers under $50
CREATE INDEX idx_freelancer_profiles_hourly_rate ON freelancer_profiles(hourly_rate);
-- Find available freelancers
CREATE INDEX idx_freelancer_profiles_availability ON freelancer_profiles(is_available);
-- Find freelancers with specific skills
CREATE INDEX idx_freelancer_profiles_skills ON freelancer_profiles USING GIN(skills);

-- Clients Profiles
CREATE TABLE client_profiles (
	id SERIAL PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE, -- PK, FK to users
	name VARCHAR(100) DEFAULT '',
	company_name TEXT DEFAULT '',
	description TEXT DEFAULT '',
	location TEXT DEFAULT '', -- indexed
	contact_information JSONB -- email, phone, website
);

-- Find clients in Dhaka
CREATE INDEX idx_client_profiles_location ON client_profiles(location);

-- Categories
CREATE TABLE categories (
	id SERIAL PRIMARY KEY,
	name VARCHAR(1000) NOT NULL,
	description TEXT NOT NULL
);

-- Skills
CREATE TABLE skills (
	id SERIAL PRIMARY KEY,
	name VARCHAR(1000) NOT NULL,
	description TEXT NOT NULL
);

-- Jobs 

-- Budget type enum
CREATE TYPE budget_type AS ENUM ('fixed', 'hourly');

-- Job status enum
CREATE TYPE job_status AS ENUM ('open', 'in_progress', 'completed', 'closed');

-- Jobs table
CREATE TABLE jobs (
  id SERIAL,
  client_id INT REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  budget_type budget_type NOT NULL DEFAULT 'fixed',
  budget_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  deadline DATE,
  status job_status NOT NULL DEFAULT 'open',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE(created_at);

-- Partitioned by month
CREATE TABLE jobs_2025_01 PARTITION OF jobs
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE jobs_2025_02 PARTITION OF jobs
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE jobs_2025_03 PARTITION OF jobs
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

CREATE TABLE jobs_2025_04 PARTITION OF jobs
    FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');

-- Find jobs with a specific budget
CREATE INDEX idx_jobs_budget_amount ON jobs(budget_amount);
-- Find jobs with a specific status
CREATE INDEX idx_jobs_status ON jobs(status);
-- Find jobs with a specific client
CREATE INDEX idx_jobs_client_id ON jobs(client_id);

-- For advanced queries
CREATE INDEX idx_jobs_status_created_at ON jobs(status, created_at);
CREATE INDEX idx_jobs_client_id_status ON jobs(client_id, status);
CREATE INDEX idx_jobs_status_budget_type_amount ON jobs(status, budget_type, budget_amount);

-- Job Skills
CREATE TABLE job_skills (
  job_id INT,
  skill_id INT REFERENCES skills(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE,
  PRIMARY KEY (job_id, created_at, skill_id),
  FOREIGN KEY (job_id, created_at) REFERENCES jobs(id, created_at) ON DELETE CASCADE
);

-- Job Categories
CREATE TABLE job_categories(
	job_id INT NOT NULL ,
	category_id INT NOT NULL REFERENCES categories(id),
	created_at TIMESTAMP WITH TIME ZONE NOT NULL,
	PRIMARY KEY (job_id, category_id, created_at),
	FOREIGN KEY (job_id, created_at) REFERENCES jobs(id, created_at)
)


-- Application status enum
CREATE TYPE application_status AS ENUM ('pending', 'accepted', 'rejected');

-- Applications Table
CREATE TABLE applications (
  id SERIAL PRIMARY KEY,
  job_id INT NOT NULL,
  job_created_at TIMESTAMP WITH TIME ZONE NOT NULL,
  client_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  freelancer_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  cover_letter TEXT,
  proposed_rate DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  status application_status NOT NULL DEFAULT 'pending',
  attachments JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (job_id, job_created_at) REFERENCES jobs(id, created_at) ON DELETE CASCADE
);

CREATE INDEX idx_applications_job_id ON applications(job_id);
CREATE INDEX idx_applications_freelancer_id ON applications(freelancer_id);


-- Application Count Table
CREATE TABLE application_counts (
	id SERIAL PRIMARY KEY REFERENCES applications(id),
	count INT NOT NULL DEFAULT 0
)

CREATE INDEX idx_application_counts ON application_counts(id);

-- Project status enum
CREATE TYPE project_status AS ENUM ('pending', 'in_progress', 'completed', 'cancelled');

-- Projects Table
CREATE TABLE projects (
  id SERIAL PRIMARY KEY,
  job_id INT,
  freelancer_id INT REFERENCES users(id) ON DELETE CASCADE,
  status project_status NOT NULL DEFAULT 'pending',
  start_date DATE,
  end_date DATE,
  total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (job_id, created_at) REFERENCES jobs(id, created_at) ON DELETE CASCADE
);

CREATE INDEX idx_projects_job_id ON projects(job_id);
CREATE INDEX idx_projects_freelancer_id ON projects(freelancer_id);
CREATE INDEX idx_projects_status ON projects(status);

-- Milestones status enum
CREATE TYPE milestone_status AS ENUM ('pending', 'completed', 'paid');

-- Milestones Table
CREATE TABLE milestones (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES projects(id) ON DELETE CASCADE,
  description TEXT,
  due_date DATE,
  amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  status milestone_status NOT NULL DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_milestones_project_id ON milestones(project_id);

-- Messages Table
CREATE TABLE messages (
  id BIGSERIAL,
  sender_id INT REFERENCES users(id) ON DELETE CASCADE, -- indexed
  receiver_id INT REFERENCES users(id) ON DELETE CASCADE, -- indexed
  job_id INT REFERENCES jobs(id) ON DELETE CASCADE, -- indexed (optional)
  project_id INT REFERENCES projects(id) ON DELETE CASCADE, -- indexed (optional)
  content TEXT NOT NULL,
  sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, -- partitioned monthly
  PRIMARY KEY (id, sent_at)
) PARTITION BY RANGE(sent_at);

-- Partitioned by month
CREATE TABLE messages_partitioned_2025_01
PARTITION OF messages
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE messages_partitioned_2025_02
PARTITION OF messages
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE messages_partitioned_2025_03
PARTITION OF messages
FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_receiver_id ON messages(receiver_id);

-- Notification table
CREATE TABLE notifications (
  id BIGSERIAL,
  user_id INT REFERENCES users(id) ON DELETE CASCADE, -- indexed
  type TEXT,
  content TEXT,
  is_read BOOLEAN NOT NULL DEFAULT FALSE, -- indexed
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, -- partitioned monthly / weekly / daily
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE(created_at);

-- Partitioned by month
CREATE TABLE notifications_partitioned_2025_01
PARTITION OF notifications
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE notifications_partitioned_2025_02
PARTITION OF notifications
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE notifications_partitioned_2025_03
PARTITION OF notifications
FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);

-- Reviews Table
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES projects(id) ON DELETE CASCADE,
  reviewer_id INT REFERENCES users(id) ON DELETE CASCADE,
  reviewee_id INT REFERENCES users(id) ON DELETE CASCADE, -- indexed for average rating
  rating DECIMAL(3, 2) NOT NULL DEFAULT 0.00,
  comment TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_reviews_reviewee_id ON reviews(reviewee_id);

-- Freelancer skills table
CREATE TABLE freelancer_skills (
  freelancer_id INT REFERENCES users(id) ON DELETE CASCADE,
  skill_id INT REFERENCES skills(id) ON DELETE CASCADE,
  PRIMARY KEY (freelancer_id, skill_id)
);