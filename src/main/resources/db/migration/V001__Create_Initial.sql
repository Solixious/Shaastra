CREATE SEQUENCE IF NOT EXISTS primary_sequence START WITH 10000 INCREMENT BY 1;

CREATE TABLE languages
(
    id          BIGINT                      NOT NULL,
    code        VARCHAR(2)                  NOT NULL,
    name        VARCHAR(32)                 NOT NULL,
    is_rtl      BOOLEAN                     NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT languages_pkey PRIMARY KEY (id)
);

CREATE TABLE users
(
    id                    BIGINT                      NOT NULL,
    name                  VARCHAR(255)                NOT NULL,
    email                 VARCHAR(255)                NOT NULL,
    password              VARCHAR(255)                NOT NULL,
    reset_uuid            UUID,
    refresh_token         TEXT,
    reset_start           TIMESTAMP WITHOUT TIME ZONE,
    preferred_language_id BIGINT,
    create_date           TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date           TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id)
);

CREATE TABLE roles
(
    id          BIGINT                      NOT NULL,
    name        VARCHAR(16)                 NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT roles_pkey PRIMARY KEY (id)
);

CREATE TABLE text_references
(
    id          BIGINT                      NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT text_references_pkey PRIMARY KEY (id)
);

CREATE TABLE text_values
(
    id                BIGINT                      NOT NULL,
    value             TEXT                        NOT NULL,
    version           INTEGER                     NOT NULL,
    language_id       BIGINT                      NOT NULL,
    text_reference_id BIGINT                      NOT NULL,
    create_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT text_values_pkey PRIMARY KEY (id)
);

CREATE TABLE artworks
(
    id          BIGINT                      NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT artworks_pkey PRIMARY KEY (id)
);

CREATE TABLE images
(
    id          BIGINT                      NOT NULL,
    path        VARCHAR(255)                NOT NULL,
    type        INTEGER                     NOT NULL,
    artwork_id  BIGINT                      NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT images_pkey PRIMARY KEY (id)
);

CREATE TABLE books
(
    id                   BIGINT                      NOT NULL,
    title_id             BIGINT                      NOT NULL,
    original_language_id BIGINT                      NOT NULL,
    cover_artwork_id     BIGINT,
    create_date          TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date          TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT books_pkey PRIMARY KEY (id)
);

CREATE TABLE chapters
(
    id                 BIGINT                      NOT NULL,
    "order"            INTEGER                     NOT NULL,
    book_id            BIGINT                      NOT NULL,
    title_id           BIGINT                      NOT NULL,
    chapter_artwork_id BIGINT,
    create_date        TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date        TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT chapters_pkey PRIMARY KEY (id)
);

CREATE TABLE verses
(
    id               BIGINT                      NOT NULL,
    "order"          INTEGER                     NOT NULL,
    chapter_id       BIGINT,
    book_id          BIGINT                      NOT NULL,
    content_id       BIGINT                      NOT NULL,
    verse_artwork_id BIGINT,
    create_date      TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date      TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT verses_pkey PRIMARY KEY (id)
);

CREATE TABLE text_transliterations
(
    id                BIGINT                      NOT NULL,
    verse_id          BIGINT                      NOT NULL,
    text_reference_id BIGINT,
    create_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT text_transliterations_pkey PRIMARY KEY (id)
);

CREATE TABLE interpreters
(
    id          BIGINT                      NOT NULL,
    name        VARCHAR(255)                NOT NULL,
    bio         VARCHAR(255),
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT interpreters_pkey PRIMARY KEY (id)
);

CREATE TABLE interpretations
(
    id                     BIGINT                      NOT NULL,
    interpreter_id         BIGINT,
    verse_id               BIGINT                      NOT NULL,
    interpretation_text_id BIGINT                      NOT NULL,
    create_date            TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date            TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT interpretations_pkey PRIMARY KEY (id)
);

CREATE TABLE reading_progresses
(
    id          BIGINT                      NOT NULL,
    user_id     BIGINT                      NOT NULL,
    book_id     BIGINT                      NOT NULL,
    chapter_id  BIGINT,
    verse_id    BIGINT,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT reading_progresses_pkey PRIMARY KEY (id)
);

CREATE TABLE favourite_verses
(
    id          BIGINT                      NOT NULL,
    user_id     BIGINT                      NOT NULL,
    verse_id    BIGINT                      NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT favourite_verses_pkey PRIMARY KEY (id)
);

CREATE TABLE favourite_books
(
    id          BIGINT                      NOT NULL,
    user_id     BIGINT                      NOT NULL,
    book_id     BIGINT                      NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT favourite_books_pkey PRIMARY KEY (id)
);

CREATE TABLE comments
(
    id          BIGINT                      NOT NULL,
    comment     TEXT                        NOT NULL,
    user_id     BIGINT                      NOT NULL,
    verse_id    BIGINT                      NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT comments_pkey PRIMARY KEY (id)
);

CREATE TABLE audio_values
(
    id                BIGINT                      NOT NULL,
    path              VARCHAR(255)                NOT NULL,
    text_reference_id BIGINT                      NOT NULL,
    language_id       BIGINT                      NOT NULL,
    narrator_id       BIGINT                      NOT NULL,
    create_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT audio_values_pkey PRIMARY KEY (id)
);

CREATE TABLE narrators
(
    id          BIGINT                      NOT NULL,
    name        VARCHAR(255)                NOT NULL,
    create_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT narrators_pkey PRIMARY KEY (id)
);

CREATE TABLE refresh_tokens
(
    id             BIGINT                      NOT NULL,
    refresh_token  UUID                        NOT NULL,
    refresh_expiry TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    user_id        BIGINT,
    create_date    TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    update_date    TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id)
);

CREATE TABLE user_roles
(
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL
);

ALTER TABLE languages
    ADD CONSTRAINT unique_languages_code UNIQUE (code);

ALTER TABLE users
    ADD CONSTRAINT fk_users_preferred_language_id FOREIGN KEY (preferred_language_id) REFERENCES languages (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE users
    ADD CONSTRAINT unique_users_email UNIQUE (email);

ALTER TABLE roles
    ADD CONSTRAINT unique_roles_name UNIQUE (name);

ALTER TABLE text_values
    ADD CONSTRAINT fk_text_values_language_id FOREIGN KEY (language_id) REFERENCES languages (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE text_values
    ADD CONSTRAINT fk_text_values_text_reference_id FOREIGN KEY (text_reference_id) REFERENCES text_references (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE images
    ADD CONSTRAINT fk_images_artwork_id FOREIGN KEY (artwork_id) REFERENCES artworks (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE books
    ADD CONSTRAINT fk_books_title_id FOREIGN KEY (title_id) REFERENCES text_references (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE books
    ADD CONSTRAINT fk_books_original_language_id FOREIGN KEY (original_language_id) REFERENCES languages (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE books
    ADD CONSTRAINT fk_books_cover_artwork_id FOREIGN KEY (cover_artwork_id) REFERENCES artworks (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE chapters
    ADD CONSTRAINT fk_chapters_book_id FOREIGN KEY (book_id) REFERENCES books (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE chapters
    ADD CONSTRAINT fk_chapters_title_id FOREIGN KEY (title_id) REFERENCES text_references (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE chapters
    ADD CONSTRAINT fk_chapters_chapter_artwork_id FOREIGN KEY (chapter_artwork_id) REFERENCES artworks (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE verses
    ADD CONSTRAINT fk_verses_chapter_id FOREIGN KEY (chapter_id) REFERENCES chapters (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE verses
    ADD CONSTRAINT fk_verses_book_id FOREIGN KEY (book_id) REFERENCES books (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE verses
    ADD CONSTRAINT fk_verses_content_id FOREIGN KEY (content_id) REFERENCES text_references (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE verses
    ADD CONSTRAINT fk_verses_verse_artwork_id FOREIGN KEY (verse_artwork_id) REFERENCES artworks (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE text_transliterations
    ADD CONSTRAINT fk_text_transliterations_verse_id FOREIGN KEY (verse_id) REFERENCES verses (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE text_transliterations
    ADD CONSTRAINT fk_text_transliterations_text_reference_id FOREIGN KEY (text_reference_id) REFERENCES text_references (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE interpretations
    ADD CONSTRAINT fk_interpretations_interpreter_id FOREIGN KEY (interpreter_id) REFERENCES interpreters (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE interpretations
    ADD CONSTRAINT fk_interpretations_verse_id FOREIGN KEY (verse_id) REFERENCES verses (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE interpretations
    ADD CONSTRAINT fk_interpretations_interpretation_text_id FOREIGN KEY (interpretation_text_id) REFERENCES text_references (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE reading_progresses
    ADD CONSTRAINT fk_reading_progresses_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE reading_progresses
    ADD CONSTRAINT fk_reading_progresses_book_id FOREIGN KEY (book_id) REFERENCES books (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE reading_progresses
    ADD CONSTRAINT fk_reading_progresses_chapter_id FOREIGN KEY (chapter_id) REFERENCES chapters (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE reading_progresses
    ADD CONSTRAINT fk_reading_progresses_verse_id FOREIGN KEY (verse_id) REFERENCES verses (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE favourite_verses
    ADD CONSTRAINT fk_favourite_verses_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE favourite_verses
    ADD CONSTRAINT fk_favourite_verses_verse_id FOREIGN KEY (verse_id) REFERENCES verses (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE favourite_books
    ADD CONSTRAINT fk_favourite_books_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE favourite_books
    ADD CONSTRAINT fk_favourite_books_book_id FOREIGN KEY (book_id) REFERENCES books (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE comments
    ADD CONSTRAINT fk_comments_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE comments
    ADD CONSTRAINT fk_comments_verse_id FOREIGN KEY (verse_id) REFERENCES verses (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE audio_values
    ADD CONSTRAINT fk_audio_values_text_reference_id FOREIGN KEY (text_reference_id) REFERENCES text_references (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE audio_values
    ADD CONSTRAINT fk_audio_values_language_id FOREIGN KEY (language_id) REFERENCES languages (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE audio_values
    ADD CONSTRAINT fk_audio_values_narrator_id FOREIGN KEY (narrator_id) REFERENCES narrators (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE refresh_tokens
    ADD CONSTRAINT fk_refresh_tokens_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE user_roles
    ADD CONSTRAINT pk_user_roles PRIMARY KEY (user_id, role_id);

ALTER TABLE user_roles
    ADD CONSTRAINT fk_user_roles_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE user_roles
    ADD CONSTRAINT fk_user_roles_role_id FOREIGN KEY (role_id) REFERENCES roles (id) ON UPDATE NO ACTION ON DELETE NO ACTION;
