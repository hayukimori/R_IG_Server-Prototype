-- SQLite Template for playground.py

-- User table (login) id: UUID4 (str)
CREATE TABLE IF NOT EXISTS user(
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User profile table (frontend info only)
CREATE TABLE IF NOT EXISTS user_profile(
    user_id INT REFERENCES user(id) ON DELETE CASCADE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    bio TEXT,
    profile_picture VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);

-- Cube table (UUID and cube world position)
CREATE TABLE IF NOT EXISTS cube(
    id SERIAL PRIMARY KEY,
    owner_id INT REFERENCES user_profile(user_id) ON DELETE CASCADE,
    position_x INT NOT NULL,
    position_y INT NOT NULL,
    position_z INT NOT NULL,
    size INT NOT NULL
);

-- Profile following table (not implemented)
CREATE TABLE IF NOT EXISTS follow(
    follower_id INT REFERENCES user(id) ON DELETE CASCADE,
    followed_id INT REFERENCES user(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, followed_id)
);

-- Salt to encrypt/decrypt user passwords
CREATE TABLE IF NOT EXISTS salt(
    user_id INT REFERENCES user(id) ON DELETE CASCADE,
    salt VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id)
);