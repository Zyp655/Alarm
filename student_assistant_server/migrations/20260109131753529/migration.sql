BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subject" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "teacherName" text,
    "credits" bigint NOT NULL,
    "requiredAttendance" bigint NOT NULL,
    "absentCount" bigint NOT NULL,
    "targetScore" double precision
);


--
-- MIGRATION VERSION FOR student_assistant
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('student_assistant', '20260109131753529', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109131753529', "timestamp" = now();

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
