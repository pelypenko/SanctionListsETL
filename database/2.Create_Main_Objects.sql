CREATE SEQUENCE IF NOT EXISTS public.watchlisttypes_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.watchlisttypes_id_seq
  OWNER TO postgres;

CREATE SEQUENCE IF NOT EXISTS public.watchlists_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.watchlists_id_seq
  OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.watchlisttypes
(
  id integer NOT NULL DEFAULT nextval('watchlisttypes_id_seq'::regclass),
  key text NOT NULL,
  name text,
  active boolean NOT NULL DEFAULT true,
  CONSTRAINT "PK_watchlisttypes" PRIMARY KEY (id),
  CONSTRAINT "UQ_WatchListTypes_Key" UNIQUE (key),
  CONSTRAINT ck_watchlisttypes_name_text CHECK (length(name::text) <= 512),
  CONSTRAINT key CHECK (length(key::text) <= 64)
)
WITH (OIDS=FALSE);

ALTER TABLE public.watchlisttypes OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.watchlists
(
  id integer NOT NULL DEFAULT nextval('watchlists_id_seq'::regclass),
  watchlisttype_id integer NOT NULL,
  remoteid text,
  name text NOT NULL,
  aliases text,
  addresses text,
  dateofbirths text,
  notes text,
  indexstatus integer NOT NULL DEFAULT (1)::numeric,
  deleted boolean NOT NULL DEFAULT false,
  createdon timestamp without time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  modifiedon timestamp without time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  indexeddata text,
  namechanged boolean NOT NULL DEFAULT true,
  CONSTRAINT "PK_watchlists" PRIMARY KEY (id),
  CONSTRAINT "FK_WatchLists_WatchListTypeId" FOREIGN KEY (watchlisttype_id)
      REFERENCES public.watchlisttypes (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ck_watchlists_name_text CHECK (length(name::text) <= 1024),
  CONSTRAINT ck_watchlists_remoteid_text CHECK (length(remoteid::text) <= 64)
)
WITH (OIDS=FALSE);

ALTER TABLE public.watchlists OWNER TO postgres;
