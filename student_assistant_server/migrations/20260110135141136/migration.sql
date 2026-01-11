BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "schedule" (
    "id" bigserial PRIMARY KEY,
    "subjectId" bigint NOT NULL,
    "startTime" timestamp without time zone NOT NULL,
    "endTime" timestamp without time zone NOT NULL,
    "room" text,
    "description" text,
    "isExam" boolean NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subject" ADD COLUMN "color" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "schedule"
    ADD CONSTRAINT "schedule_fk_0"
    FOREIGN KEY("subjectId")
    REFERENCES "subject"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR student_assistant
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('student_assistant', '20260110135141136', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260110135141136', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
