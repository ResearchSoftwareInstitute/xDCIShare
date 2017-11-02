--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION;






--
-- Database creation
--

REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: blog_blogcategory; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE blog_blogcategory (
    id integer NOT NULL,
    site_id integer NOT NULL,
    title character varying(500) NOT NULL,
    slug character varying(2000)
);


ALTER TABLE blog_blogcategory OWNER TO postgres;

--
-- Name: blog_blogcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE blog_blogcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blog_blogcategory_id_seq OWNER TO postgres;

--
-- Name: blog_blogcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE blog_blogcategory_id_seq OWNED BY blog_blogcategory.id;


--
-- Name: blog_blogpost; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE blog_blogpost (
    id integer NOT NULL,
    comments_count integer NOT NULL,
    keywords_string character varying(500) NOT NULL,
    rating_count integer NOT NULL,
    rating_sum integer NOT NULL,
    rating_average double precision NOT NULL,
    site_id integer NOT NULL,
    title character varying(500) NOT NULL,
    slug character varying(2000),
    _meta_title character varying(500),
    description text NOT NULL,
    gen_description boolean NOT NULL,
    created timestamp with time zone,
    updated timestamp with time zone,
    status integer NOT NULL,
    publish_date timestamp with time zone,
    expiry_date timestamp with time zone,
    short_url character varying(200),
    in_sitemap boolean NOT NULL,
    content text NOT NULL,
    user_id integer NOT NULL,
    allow_comments boolean NOT NULL,
    featured_image character varying(255)
);


ALTER TABLE blog_blogpost OWNER TO postgres;

--
-- Name: blog_blogpost_categories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE blog_blogpost_categories (
    id integer NOT NULL,
    blogpost_id integer NOT NULL,
    blogcategory_id integer NOT NULL
);


ALTER TABLE blog_blogpost_categories OWNER TO postgres;

--
-- Name: blog_blogpost_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE blog_blogpost_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blog_blogpost_categories_id_seq OWNER TO postgres;

--
-- Name: blog_blogpost_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE blog_blogpost_categories_id_seq OWNED BY blog_blogpost_categories.id;


--
-- Name: blog_blogpost_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE blog_blogpost_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blog_blogpost_id_seq OWNER TO postgres;

--
-- Name: blog_blogpost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE blog_blogpost_id_seq OWNED BY blog_blogpost.id;


--
-- Name: blog_blogpost_related_posts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE blog_blogpost_related_posts (
    id integer NOT NULL,
    from_blogpost_id integer NOT NULL,
    to_blogpost_id integer NOT NULL
);


ALTER TABLE blog_blogpost_related_posts OWNER TO postgres;

--
-- Name: blog_blogpost_related_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE blog_blogpost_related_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blog_blogpost_related_posts_id_seq OWNER TO postgres;

--
-- Name: blog_blogpost_related_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE blog_blogpost_related_posts_id_seq OWNED BY blog_blogpost_related_posts.id;


--
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE celery_taskmeta (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    hidden boolean NOT NULL,
    meta text
);


ALTER TABLE celery_taskmeta OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE celery_taskmeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE celery_taskmeta_id_seq OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE celery_taskmeta_id_seq OWNED BY celery_taskmeta.id;


--
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE celery_tasksetmeta (
    id integer NOT NULL,
    taskset_id character varying(255) NOT NULL,
    result text NOT NULL,
    date_done timestamp with time zone NOT NULL,
    hidden boolean NOT NULL
);


ALTER TABLE celery_tasksetmeta OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE celery_tasksetmeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE celery_tasksetmeta_id_seq OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE celery_tasksetmeta_id_seq OWNED BY celery_tasksetmeta.id;


--
-- Name: conf_setting; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conf_setting (
    id integer NOT NULL,
    site_id integer NOT NULL,
    name character varying(50) NOT NULL,
    value character varying(2000) NOT NULL
);


ALTER TABLE conf_setting OWNER TO postgres;

--
-- Name: conf_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE conf_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conf_setting_id_seq OWNER TO postgres;

--
-- Name: conf_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE conf_setting_id_seq OWNED BY conf_setting.id;


--
-- Name: core_sitepermission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE core_sitepermission (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE core_sitepermission OWNER TO postgres;

--
-- Name: core_sitepermission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE core_sitepermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE core_sitepermission_id_seq OWNER TO postgres;

--
-- Name: core_sitepermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE core_sitepermission_id_seq OWNED BY core_sitepermission.id;


--
-- Name: core_sitepermission_sites; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE core_sitepermission_sites (
    id integer NOT NULL,
    sitepermission_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE core_sitepermission_sites OWNER TO postgres;

--
-- Name: core_sitepermission_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE core_sitepermission_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE core_sitepermission_sites_id_seq OWNER TO postgres;

--
-- Name: core_sitepermission_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE core_sitepermission_sites_id_seq OWNED BY core_sitepermission_sites.id;


--
-- Name: corsheaders_corsmodel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE corsheaders_corsmodel (
    id integer NOT NULL,
    cors character varying(255) NOT NULL
);


ALTER TABLE corsheaders_corsmodel OWNER TO postgres;

--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE corsheaders_corsmodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE corsheaders_corsmodel_id_seq OWNER TO postgres;

--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE corsheaders_corsmodel_id_seq OWNED BY corsheaders_corsmodel.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_comment_flags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_comment_flags (
    id integer NOT NULL,
    user_id integer NOT NULL,
    comment_id integer NOT NULL,
    flag character varying(30) NOT NULL,
    flag_date timestamp with time zone NOT NULL
);


ALTER TABLE django_comment_flags OWNER TO postgres;

--
-- Name: django_comment_flags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_comment_flags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_comment_flags_id_seq OWNER TO postgres;

--
-- Name: django_comment_flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_comment_flags_id_seq OWNED BY django_comment_flags.id;


--
-- Name: django_comments; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_comments (
    id integer NOT NULL,
    content_type_id integer NOT NULL,
    object_pk text NOT NULL,
    site_id integer NOT NULL,
    user_id integer,
    user_name character varying(50) NOT NULL,
    user_email character varying(254) NOT NULL,
    user_url character varying(200) NOT NULL,
    comment text NOT NULL,
    submit_date timestamp with time zone NOT NULL,
    ip_address inet,
    is_public boolean NOT NULL,
    is_removed boolean NOT NULL
);


ALTER TABLE django_comments OWNER TO postgres;

--
-- Name: django_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_comments_id_seq OWNER TO postgres;

--
-- Name: django_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_comments_id_seq OWNED BY django_comments.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_docker_processes_containeroverrides; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_containeroverrides (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    command text,
    working_dir character varying(65536),
    "user" character varying(65536),
    entrypoint character varying(65536),
    privileged boolean NOT NULL,
    lxc_conf character varying(65536),
    memory_limit integer NOT NULL,
    cpu_shares integer,
    dns text,
    net character varying(8),
    docker_profile_id integer NOT NULL
);


ALTER TABLE django_docker_processes_containeroverrides OWNER TO postgres;

--
-- Name: django_docker_processes_containeroverrides_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_containeroverrides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_containeroverrides_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_containeroverrides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_containeroverrides_id_seq OWNED BY django_docker_processes_containeroverrides.id;


--
-- Name: django_docker_processes_dockerenvvar; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_dockerenvvar (
    id integer NOT NULL,
    name character varying(1024) NOT NULL,
    value text NOT NULL,
    docker_profile_id integer NOT NULL
);


ALTER TABLE django_docker_processes_dockerenvvar OWNER TO postgres;

--
-- Name: django_docker_processes_dockerenvvar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_dockerenvvar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_dockerenvvar_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_dockerenvvar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_dockerenvvar_id_seq OWNED BY django_docker_processes_dockerenvvar.id;


--
-- Name: django_docker_processes_dockerlink; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_dockerlink (
    id integer NOT NULL,
    link_name character varying(256) NOT NULL,
    docker_overrides_id integer,
    docker_profile_id integer NOT NULL,
    docker_profile_from_id integer NOT NULL
);


ALTER TABLE django_docker_processes_dockerlink OWNER TO postgres;

--
-- Name: django_docker_processes_dockerlink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_dockerlink_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_dockerlink_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_dockerlink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_dockerlink_id_seq OWNED BY django_docker_processes_dockerlink.id;


--
-- Name: django_docker_processes_dockerport; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_dockerport (
    id integer NOT NULL,
    host character varying(65536) NOT NULL,
    container character varying(65536) NOT NULL,
    docker_profile_id integer NOT NULL
);


ALTER TABLE django_docker_processes_dockerport OWNER TO postgres;

--
-- Name: django_docker_processes_dockerport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_dockerport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_dockerport_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_dockerport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_dockerport_id_seq OWNED BY django_docker_processes_dockerport.id;


--
-- Name: django_docker_processes_dockerprocess; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_dockerprocess (
    id integer NOT NULL,
    container_id character varying(128),
    token character varying(128) NOT NULL,
    logs text,
    finished boolean NOT NULL,
    error boolean NOT NULL,
    profile_id integer NOT NULL,
    user_id integer
);


ALTER TABLE django_docker_processes_dockerprocess OWNER TO postgres;

--
-- Name: django_docker_processes_dockerprocess_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_dockerprocess_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_dockerprocess_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_dockerprocess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_dockerprocess_id_seq OWNED BY django_docker_processes_dockerprocess.id;


--
-- Name: django_docker_processes_dockerprofile; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_dockerprofile (
    id integer NOT NULL,
    name character varying(1024) NOT NULL,
    git_repository character varying(16384) NOT NULL,
    git_use_submodules boolean NOT NULL,
    git_username character varying(256),
    git_password character varying(64),
    commit_id character varying(64),
    branch character varying(1024)
);


ALTER TABLE django_docker_processes_dockerprofile OWNER TO postgres;

--
-- Name: django_docker_processes_dockerprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_dockerprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_dockerprofile_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_dockerprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_dockerprofile_id_seq OWNED BY django_docker_processes_dockerprofile.id;


--
-- Name: django_docker_processes_dockervolume; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_dockervolume (
    id integer NOT NULL,
    host character varying(65536),
    container character varying(65536) NOT NULL,
    readonly boolean NOT NULL,
    docker_profile_id integer NOT NULL
);


ALTER TABLE django_docker_processes_dockervolume OWNER TO postgres;

--
-- Name: django_docker_processes_dockervolume_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_dockervolume_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_dockervolume_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_dockervolume_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_dockervolume_id_seq OWNED BY django_docker_processes_dockervolume.id;


--
-- Name: django_docker_processes_overrideenvvar; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_overrideenvvar (
    id integer NOT NULL,
    name character varying(1024) NOT NULL,
    value text NOT NULL,
    container_overrides_id integer NOT NULL
);


ALTER TABLE django_docker_processes_overrideenvvar OWNER TO postgres;

--
-- Name: django_docker_processes_overrideenvvar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_overrideenvvar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_overrideenvvar_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_overrideenvvar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_overrideenvvar_id_seq OWNED BY django_docker_processes_overrideenvvar.id;


--
-- Name: django_docker_processes_overridelink; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_overridelink (
    id integer NOT NULL,
    link_name character varying(256) NOT NULL,
    container_overrides_id integer NOT NULL,
    docker_profile_from_id integer NOT NULL
);


ALTER TABLE django_docker_processes_overridelink OWNER TO postgres;

--
-- Name: django_docker_processes_overridelink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_overridelink_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_overridelink_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_overridelink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_overridelink_id_seq OWNED BY django_docker_processes_overridelink.id;


--
-- Name: django_docker_processes_overrideport; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_overrideport (
    id integer NOT NULL,
    host character varying(65536) NOT NULL,
    container character varying(65536) NOT NULL,
    container_overrides_id integer NOT NULL
);


ALTER TABLE django_docker_processes_overrideport OWNER TO postgres;

--
-- Name: django_docker_processes_overrideport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_overrideport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_overrideport_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_overrideport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_overrideport_id_seq OWNED BY django_docker_processes_overrideport.id;


--
-- Name: django_docker_processes_overridevolume; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_docker_processes_overridevolume (
    id integer NOT NULL,
    host character varying(65536) NOT NULL,
    container character varying(65536) NOT NULL,
    container_overrides_id integer NOT NULL
);


ALTER TABLE django_docker_processes_overridevolume OWNER TO postgres;

--
-- Name: django_docker_processes_overridevolume_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_docker_processes_overridevolume_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_docker_processes_overridevolume_id_seq OWNER TO postgres;

--
-- Name: django_docker_processes_overridevolume_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_docker_processes_overridevolume_id_seq OWNED BY django_docker_processes_overridevolume.id;


--
-- Name: django_irods_rodsenvironment; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_irods_rodsenvironment (
    id integer NOT NULL,
    host character varying(255) NOT NULL,
    port integer NOT NULL,
    def_res character varying(255) NOT NULL,
    home_coll character varying(255) NOT NULL,
    cwd text NOT NULL,
    username character varying(255) NOT NULL,
    zone text NOT NULL,
    auth text NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE django_irods_rodsenvironment OWNER TO postgres;

--
-- Name: django_irods_rodsenvironment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_irods_rodsenvironment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_irods_rodsenvironment_id_seq OWNER TO postgres;

--
-- Name: django_irods_rodsenvironment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_irods_rodsenvironment_id_seq OWNED BY django_irods_rodsenvironment.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_redirect; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_redirect (
    id integer NOT NULL,
    site_id integer NOT NULL,
    old_path character varying(200) NOT NULL,
    new_path character varying(200) NOT NULL
);


ALTER TABLE django_redirect OWNER TO postgres;

--
-- Name: django_redirect_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_redirect_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_redirect_id_seq OWNER TO postgres;

--
-- Name: django_redirect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_redirect_id_seq OWNED BY django_redirect.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: djcelery_crontabschedule; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE djcelery_crontabschedule (
    id integer NOT NULL,
    minute character varying(64) NOT NULL,
    hour character varying(64) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(64) NOT NULL,
    month_of_year character varying(64) NOT NULL
);


ALTER TABLE djcelery_crontabschedule OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_crontabschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_crontabschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_crontabschedule_id_seq OWNED BY djcelery_crontabschedule.id;


--
-- Name: djcelery_intervalschedule; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE djcelery_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE djcelery_intervalschedule OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_intervalschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_intervalschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_intervalschedule_id_seq OWNED BY djcelery_intervalschedule.id;


--
-- Name: djcelery_periodictask; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE djcelery_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    interval_id integer,
    crontab_id integer,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    CONSTRAINT djcelery_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE djcelery_periodictask OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_periodictask_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_periodictask_id_seq OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_periodictask_id_seq OWNED BY djcelery_periodictask.id;


--
-- Name: djcelery_periodictasks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE djcelery_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE djcelery_periodictasks OWNER TO postgres;

--
-- Name: djcelery_taskstate; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE djcelery_taskstate (
    id integer NOT NULL,
    state character varying(64) NOT NULL,
    task_id character varying(36) NOT NULL,
    name character varying(200),
    tstamp timestamp with time zone NOT NULL,
    args text,
    kwargs text,
    eta timestamp with time zone,
    expires timestamp with time zone,
    result text,
    traceback text,
    runtime double precision,
    retries integer NOT NULL,
    worker_id integer,
    hidden boolean NOT NULL
);


ALTER TABLE djcelery_taskstate OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_taskstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_taskstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_taskstate_id_seq OWNED BY djcelery_taskstate.id;


--
-- Name: djcelery_workerstate; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE djcelery_workerstate (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    last_heartbeat timestamp with time zone
);


ALTER TABLE djcelery_workerstate OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE djcelery_workerstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE djcelery_workerstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE djcelery_workerstate_id_seq OWNED BY djcelery_workerstate.id;


--
-- Name: forms_field; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE forms_field (
    id integer NOT NULL,
    _order integer,
    form_id integer NOT NULL,
    label character varying(200) NOT NULL,
    field_type integer NOT NULL,
    required boolean NOT NULL,
    visible boolean NOT NULL,
    choices character varying(1000) NOT NULL,
    "default" character varying(2000) NOT NULL,
    placeholder_text character varying(100) NOT NULL,
    help_text character varying(100) NOT NULL
);


ALTER TABLE forms_field OWNER TO postgres;

--
-- Name: forms_field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE forms_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forms_field_id_seq OWNER TO postgres;

--
-- Name: forms_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE forms_field_id_seq OWNED BY forms_field.id;


--
-- Name: forms_fieldentry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE forms_fieldentry (
    id integer NOT NULL,
    entry_id integer NOT NULL,
    field_id integer NOT NULL,
    value character varying(2000)
);


ALTER TABLE forms_fieldentry OWNER TO postgres;

--
-- Name: forms_fieldentry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE forms_fieldentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forms_fieldentry_id_seq OWNER TO postgres;

--
-- Name: forms_fieldentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE forms_fieldentry_id_seq OWNED BY forms_fieldentry.id;


--
-- Name: forms_form; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE forms_form (
    page_ptr_id integer NOT NULL,
    content text NOT NULL,
    button_text character varying(50) NOT NULL,
    response text NOT NULL,
    send_email boolean NOT NULL,
    email_from character varying(254) NOT NULL,
    email_copies character varying(200) NOT NULL,
    email_subject character varying(200) NOT NULL,
    email_message text NOT NULL
);


ALTER TABLE forms_form OWNER TO postgres;

--
-- Name: forms_formentry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE forms_formentry (
    id integer NOT NULL,
    form_id integer NOT NULL,
    entry_time timestamp with time zone NOT NULL
);


ALTER TABLE forms_formentry OWNER TO postgres;

--
-- Name: forms_formentry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE forms_formentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forms_formentry_id_seq OWNER TO postgres;

--
-- Name: forms_formentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE forms_formentry_id_seq OWNED BY forms_formentry.id;


--
-- Name: ga_ows_ogrdataset; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_ows_ogrdataset (
    id integer NOT NULL,
    location text NOT NULL,
    checksum character varying(32) NOT NULL,
    name character varying(255) NOT NULL,
    human_name text,
    extent geometry(Polygon,4326) NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE ga_ows_ogrdataset OWNER TO postgres;

--
-- Name: ga_ows_ogrdataset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ga_ows_ogrdataset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ga_ows_ogrdataset_id_seq OWNER TO postgres;

--
-- Name: ga_ows_ogrdataset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ga_ows_ogrdataset_id_seq OWNED BY ga_ows_ogrdataset.id;


--
-- Name: ga_ows_ogrdatasetcollection; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_ows_ogrdatasetcollection (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE ga_ows_ogrdatasetcollection OWNER TO postgres;

--
-- Name: ga_ows_ogrdatasetcollection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ga_ows_ogrdatasetcollection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ga_ows_ogrdatasetcollection_id_seq OWNER TO postgres;

--
-- Name: ga_ows_ogrdatasetcollection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ga_ows_ogrdatasetcollection_id_seq OWNED BY ga_ows_ogrdatasetcollection.id;


--
-- Name: ga_ows_ogrlayer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_ows_ogrlayer (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    human_name text,
    extent geometry(Polygon,4326) NOT NULL,
    dataset_id integer NOT NULL
);


ALTER TABLE ga_ows_ogrlayer OWNER TO postgres;

--
-- Name: ga_ows_ogrlayer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ga_ows_ogrlayer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ga_ows_ogrlayer_id_seq OWNER TO postgres;

--
-- Name: ga_ows_ogrlayer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ga_ows_ogrlayer_id_seq OWNED BY ga_ows_ogrlayer.id;


--
-- Name: ga_resources_catalogpage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_catalogpage (
    page_ptr_id integer NOT NULL,
    public boolean NOT NULL,
    owner_id integer
);


ALTER TABLE ga_resources_catalogpage OWNER TO postgres;

--
-- Name: ga_resources_dataresource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_dataresource (
    page_ptr_id integer NOT NULL,
    content text NOT NULL,
    resource_file character varying(100),
    resource_url character varying(200),
    resource_config text,
    last_change timestamp with time zone,
    last_refresh timestamp with time zone,
    next_refresh timestamp with time zone,
    refresh_every interval,
    md5sum character varying(64),
    metadata_url character varying(200),
    metadata_xml text,
    native_bounding_box geometry(Polygon,4326),
    bounding_box geometry(Polygon,4326),
    three_d boolean NOT NULL,
    native_srs text,
    public boolean NOT NULL,
    driver character varying(255) NOT NULL,
    big boolean NOT NULL,
    owner_id integer
);


ALTER TABLE ga_resources_dataresource OWNER TO postgres;

--
-- Name: ga_resources_orderedresource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_orderedresource (
    id integer NOT NULL,
    ordering integer NOT NULL,
    data_resource_id integer NOT NULL,
    resource_group_id integer NOT NULL
);


ALTER TABLE ga_resources_orderedresource OWNER TO postgres;

--
-- Name: ga_resources_orderedresource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ga_resources_orderedresource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ga_resources_orderedresource_id_seq OWNER TO postgres;

--
-- Name: ga_resources_orderedresource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ga_resources_orderedresource_id_seq OWNED BY ga_resources_orderedresource.id;


--
-- Name: ga_resources_relatedresource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_relatedresource (
    page_ptr_id integer NOT NULL,
    content text NOT NULL,
    resource_file character varying(100) NOT NULL,
    foreign_key character varying(64),
    local_key character varying(64),
    left_index boolean NOT NULL,
    right_index boolean NOT NULL,
    how character varying(8) NOT NULL,
    driver character varying(255) NOT NULL,
    key_transform integer,
    foreign_resource_id integer NOT NULL
);


ALTER TABLE ga_resources_relatedresource OWNER TO postgres;

--
-- Name: ga_resources_renderedlayer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_renderedlayer (
    page_ptr_id integer NOT NULL,
    content text NOT NULL,
    default_class character varying(255) NOT NULL,
    public boolean NOT NULL,
    data_resource_id integer NOT NULL,
    default_style_id integer NOT NULL,
    owner_id integer
);


ALTER TABLE ga_resources_renderedlayer OWNER TO postgres;

--
-- Name: ga_resources_renderedlayer_styles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_renderedlayer_styles (
    id integer NOT NULL,
    renderedlayer_id integer NOT NULL,
    style_id integer NOT NULL
);


ALTER TABLE ga_resources_renderedlayer_styles OWNER TO postgres;

--
-- Name: ga_resources_renderedlayer_styles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ga_resources_renderedlayer_styles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ga_resources_renderedlayer_styles_id_seq OWNER TO postgres;

--
-- Name: ga_resources_renderedlayer_styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ga_resources_renderedlayer_styles_id_seq OWNED BY ga_resources_renderedlayer_styles.id;


--
-- Name: ga_resources_resourcegroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_resourcegroup (
    page_ptr_id integer NOT NULL,
    is_timeseries boolean NOT NULL,
    min_time timestamp with time zone,
    max_time timestamp with time zone
);


ALTER TABLE ga_resources_resourcegroup OWNER TO postgres;

--
-- Name: ga_resources_style; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ga_resources_style (
    page_ptr_id integer NOT NULL,
    legend character varying(100),
    legend_width integer,
    legend_height integer,
    stylesheet text NOT NULL,
    public boolean NOT NULL,
    owner_id integer
);


ALTER TABLE ga_resources_style OWNER TO postgres;

--
-- Name: galleries_gallery; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE galleries_gallery (
    page_ptr_id integer NOT NULL,
    content text NOT NULL,
    zip_import character varying(100) NOT NULL
);


ALTER TABLE galleries_gallery OWNER TO postgres;

--
-- Name: galleries_galleryimage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE galleries_galleryimage (
    id integer NOT NULL,
    _order integer,
    gallery_id integer NOT NULL,
    file character varying(200) NOT NULL,
    description character varying(1000) NOT NULL
);


ALTER TABLE galleries_galleryimage OWNER TO postgres;

--
-- Name: galleries_galleryimage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE galleries_galleryimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE galleries_galleryimage_id_seq OWNER TO postgres;

--
-- Name: galleries_galleryimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE galleries_galleryimage_id_seq OWNED BY galleries_galleryimage.id;


--
-- Name: generic_assignedkeyword; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE generic_assignedkeyword (
    id integer NOT NULL,
    _order integer,
    keyword_id integer NOT NULL,
    content_type_id integer NOT NULL,
    object_pk integer NOT NULL
);


ALTER TABLE generic_assignedkeyword OWNER TO postgres;

--
-- Name: generic_assignedkeyword_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE generic_assignedkeyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generic_assignedkeyword_id_seq OWNER TO postgres;

--
-- Name: generic_assignedkeyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE generic_assignedkeyword_id_seq OWNED BY generic_assignedkeyword.id;


--
-- Name: generic_keyword; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE generic_keyword (
    id integer NOT NULL,
    site_id integer NOT NULL,
    title character varying(500) NOT NULL,
    slug character varying(2000)
);


ALTER TABLE generic_keyword OWNER TO postgres;

--
-- Name: generic_keyword_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE generic_keyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generic_keyword_id_seq OWNER TO postgres;

--
-- Name: generic_keyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE generic_keyword_id_seq OWNED BY generic_keyword.id;


--
-- Name: generic_rating; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE generic_rating (
    id integer NOT NULL,
    value integer NOT NULL,
    rating_date timestamp with time zone,
    content_type_id integer NOT NULL,
    object_pk integer NOT NULL,
    user_id integer
);


ALTER TABLE generic_rating OWNER TO postgres;

--
-- Name: generic_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE generic_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generic_rating_id_seq OWNER TO postgres;

--
-- Name: generic_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE generic_rating_id_seq OWNED BY generic_rating.id;


--
-- Name: generic_threadedcomment; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE generic_threadedcomment (
    comment_ptr_id integer NOT NULL,
    rating_count integer NOT NULL,
    rating_sum integer NOT NULL,
    rating_average double precision NOT NULL,
    by_author boolean NOT NULL,
    replied_to_id integer
);


ALTER TABLE generic_threadedcomment OWNER TO postgres;

--
-- Name: hs_access_control_groupaccess; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_groupaccess (
    id integer NOT NULL,
    active boolean NOT NULL,
    discoverable boolean NOT NULL,
    public boolean NOT NULL,
    shareable boolean NOT NULL,
    group_id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    description text NOT NULL,
    picture character varying(100),
    purpose text,
    auto_approve boolean NOT NULL
);


ALTER TABLE hs_access_control_groupaccess OWNER TO postgres;

--
-- Name: hs_access_control_groupaccess_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_groupaccess_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_groupaccess_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_groupaccess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_groupaccess_id_seq OWNED BY hs_access_control_groupaccess.id;


--
-- Name: hs_access_control_groupmembershiprequest; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_groupmembershiprequest (
    id integer NOT NULL,
    date_requested timestamp with time zone NOT NULL,
    group_to_join_id integer NOT NULL,
    invitation_to_id integer,
    request_from_id integer NOT NULL
);


ALTER TABLE hs_access_control_groupmembershiprequest OWNER TO postgres;

--
-- Name: hs_access_control_groupmembershiprequest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_groupmembershiprequest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_groupmembershiprequest_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_groupmembershiprequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_groupmembershiprequest_id_seq OWNED BY hs_access_control_groupmembershiprequest.id;


--
-- Name: hs_access_control_groupresourceprivilege; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_groupresourceprivilege (
    id integer NOT NULL,
    privilege integer NOT NULL,
    start timestamp with time zone NOT NULL,
    grantor_id integer NOT NULL,
    group_id integer NOT NULL,
    resource_id integer NOT NULL
);


ALTER TABLE hs_access_control_groupresourceprivilege OWNER TO postgres;

--
-- Name: hs_access_control_groupresourceprivilege_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_groupresourceprivilege_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_groupresourceprivilege_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_groupresourceprivilege_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_groupresourceprivilege_id_seq OWNED BY hs_access_control_groupresourceprivilege.id;


--
-- Name: hs_access_control_groupresourceprovenance; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_groupresourceprovenance (
    id integer NOT NULL,
    privilege integer NOT NULL,
    start timestamp with time zone NOT NULL,
    grantor_id integer,
    group_id integer NOT NULL,
    resource_id integer NOT NULL,
    undone boolean NOT NULL
);


ALTER TABLE hs_access_control_groupresourceprovenance OWNER TO postgres;

--
-- Name: hs_access_control_groupresourceprovenance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_groupresourceprovenance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_groupresourceprovenance_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_groupresourceprovenance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_groupresourceprovenance_id_seq OWNED BY hs_access_control_groupresourceprovenance.id;


--
-- Name: hs_access_control_resourceaccess; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_resourceaccess (
    id integer NOT NULL,
    active boolean NOT NULL,
    discoverable boolean NOT NULL,
    public boolean NOT NULL,
    shareable boolean NOT NULL,
    published boolean NOT NULL,
    immutable boolean NOT NULL,
    resource_id integer NOT NULL
);


ALTER TABLE hs_access_control_resourceaccess OWNER TO postgres;

--
-- Name: hs_access_control_resourceaccess_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_resourceaccess_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_resourceaccess_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_resourceaccess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_resourceaccess_id_seq OWNED BY hs_access_control_resourceaccess.id;


--
-- Name: hs_access_control_useraccess; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_useraccess (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE hs_access_control_useraccess OWNER TO postgres;

--
-- Name: hs_access_control_useraccess_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_useraccess_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_useraccess_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_useraccess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_useraccess_id_seq OWNED BY hs_access_control_useraccess.id;


--
-- Name: hs_access_control_usergroupprivilege; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_usergroupprivilege (
    id integer NOT NULL,
    privilege integer NOT NULL,
    start timestamp with time zone NOT NULL,
    grantor_id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE hs_access_control_usergroupprivilege OWNER TO postgres;

--
-- Name: hs_access_control_usergroupprivilege_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_usergroupprivilege_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_usergroupprivilege_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_usergroupprivilege_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_usergroupprivilege_id_seq OWNED BY hs_access_control_usergroupprivilege.id;


--
-- Name: hs_access_control_usergroupprovenance; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_usergroupprovenance (
    id integer NOT NULL,
    privilege integer NOT NULL,
    start timestamp with time zone NOT NULL,
    grantor_id integer,
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    undone boolean NOT NULL
);


ALTER TABLE hs_access_control_usergroupprovenance OWNER TO postgres;

--
-- Name: hs_access_control_usergroupprovenance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_usergroupprovenance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_usergroupprovenance_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_usergroupprovenance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_usergroupprovenance_id_seq OWNED BY hs_access_control_usergroupprovenance.id;


--
-- Name: hs_access_control_userresourceprivilege; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_userresourceprivilege (
    id integer NOT NULL,
    privilege integer NOT NULL,
    start timestamp with time zone NOT NULL,
    grantor_id integer NOT NULL,
    resource_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE hs_access_control_userresourceprivilege OWNER TO postgres;

--
-- Name: hs_access_control_userresourceprivilege_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_userresourceprivilege_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_userresourceprivilege_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_userresourceprivilege_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_userresourceprivilege_id_seq OWNED BY hs_access_control_userresourceprivilege.id;


--
-- Name: hs_access_control_userresourceprovenance; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_access_control_userresourceprovenance (
    id integer NOT NULL,
    privilege integer NOT NULL,
    start timestamp with time zone NOT NULL,
    grantor_id integer,
    resource_id integer NOT NULL,
    user_id integer NOT NULL,
    undone boolean NOT NULL
);


ALTER TABLE hs_access_control_userresourceprovenance OWNER TO postgres;

--
-- Name: hs_access_control_userresourceprovenance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_access_control_userresourceprovenance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_access_control_userresourceprovenance_id_seq OWNER TO postgres;

--
-- Name: hs_access_control_userresourceprovenance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_access_control_userresourceprovenance_id_seq OWNED BY hs_access_control_userresourceprovenance.id;


--
-- Name: hs_app_netCDF_netcdfmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "hs_app_netCDF_netcdfmetadata" (
    coremetadata_ptr_id integer NOT NULL,
    is_dirty boolean NOT NULL
);


ALTER TABLE "hs_app_netCDF_netcdfmetadata" OWNER TO postgres;

--
-- Name: hs_app_netCDF_originalcoverage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "hs_app_netCDF_originalcoverage" (
    id integer NOT NULL,
    object_id integer NOT NULL,
    _value character varying(1024),
    projection_string_type character varying(20),
    projection_string_text text,
    content_type_id integer NOT NULL,
    datum character varying(300) NOT NULL,
    CONSTRAINT "hs_app_netCDF_originalcoverage_object_id_check" CHECK ((object_id >= 0))
);


ALTER TABLE "hs_app_netCDF_originalcoverage" OWNER TO postgres;

--
-- Name: hs_app_netCDF_originalcoverage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "hs_app_netCDF_originalcoverage_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "hs_app_netCDF_originalcoverage_id_seq" OWNER TO postgres;

--
-- Name: hs_app_netCDF_originalcoverage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "hs_app_netCDF_originalcoverage_id_seq" OWNED BY "hs_app_netCDF_originalcoverage".id;


--
-- Name: hs_app_netCDF_variable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "hs_app_netCDF_variable" (
    id integer NOT NULL,
    object_id integer NOT NULL,
    name character varying(1000) NOT NULL,
    unit character varying(1000) NOT NULL,
    type character varying(1000) NOT NULL,
    shape character varying(1000) NOT NULL,
    descriptive_name character varying(1000),
    method text,
    missing_value character varying(1000),
    content_type_id integer NOT NULL,
    CONSTRAINT "hs_app_netCDF_variable_object_id_check" CHECK ((object_id >= 0))
);


ALTER TABLE "hs_app_netCDF_variable" OWNER TO postgres;

--
-- Name: hs_app_netCDF_variable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "hs_app_netCDF_variable_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "hs_app_netCDF_variable_id_seq" OWNER TO postgres;

--
-- Name: hs_app_netCDF_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "hs_app_netCDF_variable_id_seq" OWNED BY "hs_app_netCDF_variable".id;


--
-- Name: hs_app_timeseries_cvaggregationstatistic; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvaggregationstatistic (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvaggregationstatistic OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvaggregationstatistic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvaggregationstatistic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvaggregationstatistic_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvaggregationstatistic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvaggregationstatistic_id_seq OWNED BY hs_app_timeseries_cvaggregationstatistic.id;


--
-- Name: hs_app_timeseries_cvelevationdatum; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvelevationdatum (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvelevationdatum OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvelevationdatum_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvelevationdatum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvelevationdatum_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvelevationdatum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvelevationdatum_id_seq OWNED BY hs_app_timeseries_cvelevationdatum.id;


--
-- Name: hs_app_timeseries_cvmedium; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvmedium (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvmedium OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvmedium_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvmedium_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvmedium_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvmedium_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvmedium_id_seq OWNED BY hs_app_timeseries_cvmedium.id;


--
-- Name: hs_app_timeseries_cvmethodtype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvmethodtype (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvmethodtype OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvmethodtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvmethodtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvmethodtype_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvmethodtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvmethodtype_id_seq OWNED BY hs_app_timeseries_cvmethodtype.id;


--
-- Name: hs_app_timeseries_cvsitetype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvsitetype (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvsitetype OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvsitetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvsitetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvsitetype_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvsitetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvsitetype_id_seq OWNED BY hs_app_timeseries_cvsitetype.id;


--
-- Name: hs_app_timeseries_cvspeciation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvspeciation (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvspeciation OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvspeciation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvspeciation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvspeciation_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvspeciation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvspeciation_id_seq OWNED BY hs_app_timeseries_cvspeciation.id;


--
-- Name: hs_app_timeseries_cvstatus; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvstatus (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvstatus OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvstatus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvstatus_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvstatus_id_seq OWNED BY hs_app_timeseries_cvstatus.id;


--
-- Name: hs_app_timeseries_cvunitstype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvunitstype (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvunitstype OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvunitstype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvunitstype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvunitstype_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvunitstype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvunitstype_id_seq OWNED BY hs_app_timeseries_cvunitstype.id;


--
-- Name: hs_app_timeseries_cvvariablename; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvvariablename (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvvariablename OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvvariablename_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvvariablename_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvvariablename_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvvariablename_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvvariablename_id_seq OWNED BY hs_app_timeseries_cvvariablename.id;


--
-- Name: hs_app_timeseries_cvvariabletype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_cvvariabletype (
    id integer NOT NULL,
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_dirty boolean NOT NULL,
    metadata_id integer NOT NULL
);


ALTER TABLE hs_app_timeseries_cvvariabletype OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvvariabletype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_cvvariabletype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_cvvariabletype_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_cvvariabletype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_cvvariabletype_id_seq OWNED BY hs_app_timeseries_cvvariabletype.id;


--
-- Name: hs_app_timeseries_method; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_method (
    id integer NOT NULL,
    object_id integer NOT NULL,
    method_code character varying(50) NOT NULL,
    method_name character varying(200) NOT NULL,
    method_type character varying(200) NOT NULL,
    method_description text,
    method_link character varying(200),
    content_type_id integer NOT NULL,
    is_dirty boolean NOT NULL,
    series_ids character varying(36)[] NOT NULL,
    CONSTRAINT hs_app_timeseries_method_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_app_timeseries_method OWNER TO postgres;

--
-- Name: hs_app_timeseries_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_method_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_method_id_seq OWNED BY hs_app_timeseries_method.id;


--
-- Name: hs_app_timeseries_processinglevel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_processinglevel (
    id integer NOT NULL,
    object_id integer NOT NULL,
    processing_level_code integer NOT NULL,
    definition character varying(200),
    explanation text,
    content_type_id integer NOT NULL,
    is_dirty boolean NOT NULL,
    series_ids character varying(36)[] NOT NULL,
    CONSTRAINT hs_app_timeseries_processinglevel_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_app_timeseries_processinglevel OWNER TO postgres;

--
-- Name: hs_app_timeseries_processinglevel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_processinglevel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_processinglevel_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_processinglevel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_processinglevel_id_seq OWNED BY hs_app_timeseries_processinglevel.id;


--
-- Name: hs_app_timeseries_site; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_site (
    id integer NOT NULL,
    object_id integer NOT NULL,
    site_code character varying(200) NOT NULL,
    site_name character varying(255) NOT NULL,
    elevation_m integer,
    elevation_datum character varying(50),
    site_type character varying(100),
    content_type_id integer NOT NULL,
    is_dirty boolean NOT NULL,
    series_ids character varying(36)[] NOT NULL,
    latitude double precision,
    longitude double precision,
    CONSTRAINT hs_app_timeseries_site_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_app_timeseries_site OWNER TO postgres;

--
-- Name: hs_app_timeseries_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_site_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_site_id_seq OWNED BY hs_app_timeseries_site.id;


--
-- Name: hs_app_timeseries_timeseriesmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_timeseriesmetadata (
    coremetadata_ptr_id integer NOT NULL,
    is_dirty boolean NOT NULL,
    value_counts hstore NOT NULL
);


ALTER TABLE hs_app_timeseries_timeseriesmetadata OWNER TO postgres;

--
-- Name: hs_app_timeseries_timeseriesresult; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_timeseriesresult (
    id integer NOT NULL,
    object_id integer NOT NULL,
    units_type character varying(255) NOT NULL,
    units_name character varying(255) NOT NULL,
    units_abbreviation character varying(20) NOT NULL,
    status character varying(255) NOT NULL,
    sample_medium character varying(255) NOT NULL,
    value_count integer NOT NULL,
    aggregation_statistics character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    is_dirty boolean NOT NULL,
    series_ids character varying(36)[] NOT NULL,
    series_label character varying(255),
    CONSTRAINT hs_app_timeseries_timeseriesresult_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_app_timeseries_timeseriesresult OWNER TO postgres;

--
-- Name: hs_app_timeseries_timeseriesresult_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_timeseriesresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_timeseriesresult_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_timeseriesresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_timeseriesresult_id_seq OWNED BY hs_app_timeseries_timeseriesresult.id;


--
-- Name: hs_app_timeseries_utcoffset; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_utcoffset (
    id integer NOT NULL,
    object_id integer NOT NULL,
    series_ids character varying(36)[] NOT NULL,
    is_dirty boolean NOT NULL,
    value double precision NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_app_timeseries_utcoffset_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_app_timeseries_utcoffset OWNER TO postgres;

--
-- Name: hs_app_timeseries_utcoffset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_utcoffset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_utcoffset_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_utcoffset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_utcoffset_id_seq OWNED BY hs_app_timeseries_utcoffset.id;


--
-- Name: hs_app_timeseries_variable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_app_timeseries_variable (
    id integer NOT NULL,
    object_id integer NOT NULL,
    variable_code character varying(20) NOT NULL,
    variable_name character varying(100) NOT NULL,
    variable_type character varying(100) NOT NULL,
    no_data_value integer NOT NULL,
    variable_definition character varying(255),
    speciation character varying(255),
    content_type_id integer NOT NULL,
    is_dirty boolean NOT NULL,
    series_ids character varying(36)[] NOT NULL,
    CONSTRAINT hs_app_timeseries_variable_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_app_timeseries_variable OWNER TO postgres;

--
-- Name: hs_app_timeseries_variable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_app_timeseries_variable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_app_timeseries_variable_id_seq OWNER TO postgres;

--
-- Name: hs_app_timeseries_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_app_timeseries_variable_id_seq OWNED BY hs_app_timeseries_variable.id;


--
-- Name: hs_collection_resource_collectiondeletedresource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_collection_resource_collectiondeletedresource (
    id integer NOT NULL,
    resource_title text NOT NULL,
    date_deleted timestamp with time zone NOT NULL,
    resource_id character varying(32) NOT NULL,
    resource_type character varying(50) NOT NULL,
    collection_id integer NOT NULL,
    deleted_by_id integer NOT NULL
);


ALTER TABLE hs_collection_resource_collectiondeletedresource OWNER TO postgres;

--
-- Name: hs_collection_resource_collectiondeletedresource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_collection_resource_collectiondeletedresource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_collection_resource_collectiondeletedresource_id_seq OWNER TO postgres;

--
-- Name: hs_collection_resource_collectiondeletedresource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_collection_resource_collectiondeletedresource_id_seq OWNED BY hs_collection_resource_collectiondeletedresource.id;


--
-- Name: hs_collection_resource_collectiondeletedresource_resource_od9f5; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_collection_resource_collectiondeletedresource_resource_od9f5 (
    id integer NOT NULL,
    collectiondeletedresource_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE hs_collection_resource_collectiondeletedresource_resource_od9f5 OWNER TO postgres;

--
-- Name: hs_collection_resource_collectiondeletedresource_resourc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_collection_resource_collectiondeletedresource_resourc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_collection_resource_collectiondeletedresource_resourc_id_seq OWNER TO postgres;

--
-- Name: hs_collection_resource_collectiondeletedresource_resourc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_collection_resource_collectiondeletedresource_resourc_id_seq OWNED BY hs_collection_resource_collectiondeletedresource_resource_od9f5.id;


--
-- Name: hs_core_bags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_bags (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_bags_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_bags OWNER TO postgres;

--
-- Name: hs_core_bags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_bags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_bags_id_seq OWNER TO postgres;

--
-- Name: hs_core_bags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_bags_id_seq OWNED BY hs_core_bags.id;


--
-- Name: hs_core_contributor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_contributor (
    id integer NOT NULL,
    object_id integer NOT NULL,
    description character varying(200),
    name character varying(100),
    organization character varying(200),
    email character varying(254),
    address character varying(250),
    phone character varying(25),
    homepage character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_contributor_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_contributor OWNER TO postgres;

--
-- Name: hs_core_contributor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_contributor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_contributor_id_seq OWNER TO postgres;

--
-- Name: hs_core_contributor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_contributor_id_seq OWNED BY hs_core_contributor.id;


--
-- Name: hs_core_coremetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_coremetadata (
    id integer NOT NULL
);


ALTER TABLE hs_core_coremetadata OWNER TO postgres;

--
-- Name: hs_core_coremetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_coremetadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_coremetadata_id_seq OWNER TO postgres;

--
-- Name: hs_core_coremetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_coremetadata_id_seq OWNED BY hs_core_coremetadata.id;


--
-- Name: hs_core_coverage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_coverage (
    id integer NOT NULL,
    object_id integer NOT NULL,
    type character varying(20) NOT NULL,
    _value character varying(1024) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_coverage_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_coverage OWNER TO postgres;

--
-- Name: hs_core_coverage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_coverage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_coverage_id_seq OWNER TO postgres;

--
-- Name: hs_core_coverage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_coverage_id_seq OWNED BY hs_core_coverage.id;


--
-- Name: hs_core_creator; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_creator (
    id integer NOT NULL,
    object_id integer NOT NULL,
    description character varying(200),
    name character varying(100),
    organization character varying(200),
    email character varying(254),
    address character varying(250),
    phone character varying(25),
    homepage character varying(200),
    "order" integer NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_creator_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT hs_core_creator_order_check CHECK (("order" >= 0))
);


ALTER TABLE hs_core_creator OWNER TO postgres;

--
-- Name: hs_core_creator_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_creator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_creator_id_seq OWNER TO postgres;

--
-- Name: hs_core_creator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_creator_id_seq OWNED BY hs_core_creator.id;


--
-- Name: hs_core_date; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_date (
    id integer NOT NULL,
    object_id integer NOT NULL,
    type character varying(20) NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_date_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_date OWNER TO postgres;

--
-- Name: hs_core_date_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_date_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_date_id_seq OWNER TO postgres;

--
-- Name: hs_core_date_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_date_id_seq OWNED BY hs_core_date.id;


--
-- Name: hs_core_description; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_description (
    id integer NOT NULL,
    object_id integer NOT NULL,
    abstract text NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_description_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_description OWNER TO postgres;

--
-- Name: hs_core_description_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_description_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_description_id_seq OWNER TO postgres;

--
-- Name: hs_core_description_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_description_id_seq OWNED BY hs_core_description.id;


--
-- Name: hs_core_externalprofilelink; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_externalprofilelink (
    id integer NOT NULL,
    type character varying(50) NOT NULL,
    url character varying(200) NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_externalprofilelink_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_externalprofilelink OWNER TO postgres;

--
-- Name: hs_core_externalprofilelink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_externalprofilelink_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_externalprofilelink_id_seq OWNER TO postgres;

--
-- Name: hs_core_externalprofilelink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_externalprofilelink_id_seq OWNED BY hs_core_externalprofilelink.id;


--
-- Name: hs_core_format; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_format (
    id integer NOT NULL,
    object_id integer NOT NULL,
    value character varying(150) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_format_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_format OWNER TO postgres;

--
-- Name: hs_core_format_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_format_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_format_id_seq OWNER TO postgres;

--
-- Name: hs_core_format_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_format_id_seq OWNED BY hs_core_format.id;


--
-- Name: hs_core_fundingagency; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_fundingagency (
    id integer NOT NULL,
    object_id integer NOT NULL,
    agency_name text NOT NULL,
    award_title text,
    award_number text,
    agency_url character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_fundingagency_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_fundingagency OWNER TO postgres;

--
-- Name: hs_core_fundingagency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_fundingagency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_fundingagency_id_seq OWNER TO postgres;

--
-- Name: hs_core_fundingagency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_fundingagency_id_seq OWNED BY hs_core_fundingagency.id;


--
-- Name: hs_core_genericresource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_genericresource (
    page_ptr_id integer NOT NULL,
    rating_count integer NOT NULL,
    rating_sum integer NOT NULL,
    rating_average double precision NOT NULL,
    content text NOT NULL,
    short_id character varying(32) NOT NULL,
    doi character varying(1024),
    object_id integer,
    content_type_id integer,
    creator_id integer NOT NULL,
    last_changed_by_id integer,
    user_id integer NOT NULL,
    resource_type character varying(50) NOT NULL,
    file_unpack_message text,
    file_unpack_status character varying(7),
    locked_time timestamp with time zone,
    extra_metadata hstore NOT NULL,
    resource_federation_path character varying(100) NOT NULL,
    extra_data hstore NOT NULL,
    CONSTRAINT hs_core_genericresource_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_genericresource OWNER TO postgres;

--
-- Name: hs_core_genericresource_collections; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_genericresource_collections (
    id integer NOT NULL,
    from_baseresource_id integer NOT NULL,
    to_baseresource_id integer NOT NULL
);


ALTER TABLE hs_core_genericresource_collections OWNER TO postgres;

--
-- Name: hs_core_genericresource_collections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_genericresource_collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_genericresource_collections_id_seq OWNER TO postgres;

--
-- Name: hs_core_genericresource_collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_genericresource_collections_id_seq OWNED BY hs_core_genericresource_collections.id;


--
-- Name: hs_core_groupownership; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_groupownership (
    id integer NOT NULL,
    group_id integer NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE hs_core_groupownership OWNER TO postgres;

--
-- Name: hs_core_groupownership_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_groupownership_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_groupownership_id_seq OWNER TO postgres;

--
-- Name: hs_core_groupownership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_groupownership_id_seq OWNED BY hs_core_groupownership.id;


--
-- Name: hs_core_identifier; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_identifier (
    id integer NOT NULL,
    object_id integer NOT NULL,
    name character varying(100) NOT NULL,
    url character varying(200) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_identifier_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_identifier OWNER TO postgres;

--
-- Name: hs_core_identifier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_identifier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_identifier_id_seq OWNER TO postgres;

--
-- Name: hs_core_identifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_identifier_id_seq OWNED BY hs_core_identifier.id;


--
-- Name: hs_core_language; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_language (
    id integer NOT NULL,
    object_id integer NOT NULL,
    code character varying(3) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_language_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_language OWNER TO postgres;

--
-- Name: hs_core_language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_language_id_seq OWNER TO postgres;

--
-- Name: hs_core_language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_language_id_seq OWNED BY hs_core_language.id;


--
-- Name: hs_core_publisher; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_publisher (
    id integer NOT NULL,
    object_id integer NOT NULL,
    name character varying(200) NOT NULL,
    url character varying(200) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_publisher_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_publisher OWNER TO postgres;

--
-- Name: hs_core_publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_publisher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_publisher_id_seq OWNER TO postgres;

--
-- Name: hs_core_publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_publisher_id_seq OWNED BY hs_core_publisher.id;


--
-- Name: hs_core_relation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_relation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    type character varying(100) NOT NULL,
    value character varying(500) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_relation_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_relation OWNER TO postgres;

--
-- Name: hs_core_relation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_relation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_relation_id_seq OWNER TO postgres;

--
-- Name: hs_core_relation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_relation_id_seq OWNED BY hs_core_relation.id;


--
-- Name: hs_core_resourcefile; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_resourcefile (
    id integer NOT NULL,
    object_id integer NOT NULL,
    resource_file character varying(4096),
    content_type_id integer NOT NULL,
    fed_resource_file character varying(4096),
    file_folder character varying(4096),
    logical_file_content_type_id integer,
    logical_file_object_id integer,
    CONSTRAINT hs_core_resourcefile_logical_file_object_id_check CHECK ((logical_file_object_id >= 0)),
    CONSTRAINT hs_core_resourcefile_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_resourcefile OWNER TO postgres;

--
-- Name: hs_core_resourcefile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_resourcefile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_resourcefile_id_seq OWNER TO postgres;

--
-- Name: hs_core_resourcefile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_resourcefile_id_seq OWNED BY hs_core_resourcefile.id;


--
-- Name: hs_core_rights; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_rights (
    id integer NOT NULL,
    object_id integer NOT NULL,
    statement text,
    url character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_rights_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_rights OWNER TO postgres;

--
-- Name: hs_core_rights_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_rights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_rights_id_seq OWNER TO postgres;

--
-- Name: hs_core_rights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_rights_id_seq OWNED BY hs_core_rights.id;


--
-- Name: hs_core_source; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_source (
    id integer NOT NULL,
    object_id integer NOT NULL,
    derived_from character varying(300) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_source_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_source OWNER TO postgres;

--
-- Name: hs_core_source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_source_id_seq OWNER TO postgres;

--
-- Name: hs_core_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_source_id_seq OWNED BY hs_core_source.id;


--
-- Name: hs_core_subject; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_subject (
    id integer NOT NULL,
    object_id integer NOT NULL,
    value character varying(100) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_subject_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_subject OWNER TO postgres;

--
-- Name: hs_core_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_subject_id_seq OWNER TO postgres;

--
-- Name: hs_core_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_subject_id_seq OWNED BY hs_core_subject.id;


--
-- Name: hs_core_title; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_title (
    id integer NOT NULL,
    object_id integer NOT NULL,
    value character varying(300) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_title_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_title OWNER TO postgres;

--
-- Name: hs_core_title_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_title_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_title_id_seq OWNER TO postgres;

--
-- Name: hs_core_title_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_title_id_seq OWNED BY hs_core_title.id;


--
-- Name: hs_core_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_core_type (
    id integer NOT NULL,
    object_id integer NOT NULL,
    url character varying(200) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_core_type_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_core_type OWNER TO postgres;

--
-- Name: hs_core_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_core_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_core_type_id_seq OWNER TO postgres;

--
-- Name: hs_core_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_core_type_id_seq OWNED BY hs_core_type.id;


--
-- Name: hs_file_types_genericfilemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_file_types_genericfilemetadata (
    id integer NOT NULL,
    extra_metadata hstore NOT NULL,
    keywords character varying(100)[] NOT NULL,
    is_dirty boolean NOT NULL
);


ALTER TABLE hs_file_types_genericfilemetadata OWNER TO postgres;

--
-- Name: hs_file_types_genericfilemetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_file_types_genericfilemetadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_file_types_genericfilemetadata_id_seq OWNER TO postgres;

--
-- Name: hs_file_types_genericfilemetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_file_types_genericfilemetadata_id_seq OWNED BY hs_file_types_genericfilemetadata.id;


--
-- Name: hs_file_types_genericlogicalfile; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_file_types_genericlogicalfile (
    id integer NOT NULL,
    dataset_name character varying(255),
    metadata_id integer NOT NULL
);


ALTER TABLE hs_file_types_genericlogicalfile OWNER TO postgres;

--
-- Name: hs_file_types_genericlogicalfile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_file_types_genericlogicalfile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_file_types_genericlogicalfile_id_seq OWNER TO postgres;

--
-- Name: hs_file_types_genericlogicalfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_file_types_genericlogicalfile_id_seq OWNED BY hs_file_types_genericlogicalfile.id;


--
-- Name: hs_file_types_georasterfilemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_file_types_georasterfilemetadata (
    id integer NOT NULL,
    extra_metadata hstore NOT NULL,
    keywords character varying(100)[] NOT NULL,
    is_dirty boolean NOT NULL
);


ALTER TABLE hs_file_types_georasterfilemetadata OWNER TO postgres;

--
-- Name: hs_file_types_georasterfilemetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_file_types_georasterfilemetadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_file_types_georasterfilemetadata_id_seq OWNER TO postgres;

--
-- Name: hs_file_types_georasterfilemetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_file_types_georasterfilemetadata_id_seq OWNED BY hs_file_types_georasterfilemetadata.id;


--
-- Name: hs_file_types_georasterlogicalfile; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_file_types_georasterlogicalfile (
    id integer NOT NULL,
    dataset_name character varying(255),
    metadata_id integer NOT NULL
);


ALTER TABLE hs_file_types_georasterlogicalfile OWNER TO postgres;

--
-- Name: hs_file_types_georasterlogicalfile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_file_types_georasterlogicalfile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_file_types_georasterlogicalfile_id_seq OWNER TO postgres;

--
-- Name: hs_file_types_georasterlogicalfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_file_types_georasterlogicalfile_id_seq OWNED BY hs_file_types_georasterlogicalfile.id;


--
-- Name: hs_file_types_netcdffilemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_file_types_netcdffilemetadata (
    id integer NOT NULL,
    extra_metadata hstore NOT NULL,
    keywords character varying(100)[] NOT NULL,
    is_dirty boolean NOT NULL
);


ALTER TABLE hs_file_types_netcdffilemetadata OWNER TO postgres;

--
-- Name: hs_file_types_netcdffilemetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_file_types_netcdffilemetadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_file_types_netcdffilemetadata_id_seq OWNER TO postgres;

--
-- Name: hs_file_types_netcdffilemetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_file_types_netcdffilemetadata_id_seq OWNED BY hs_file_types_netcdffilemetadata.id;


--
-- Name: hs_file_types_netcdflogicalfile; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_file_types_netcdflogicalfile (
    id integer NOT NULL,
    dataset_name character varying(255),
    metadata_id integer NOT NULL
);


ALTER TABLE hs_file_types_netcdflogicalfile OWNER TO postgres;

--
-- Name: hs_file_types_netcdflogicalfile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_file_types_netcdflogicalfile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_file_types_netcdflogicalfile_id_seq OWNER TO postgres;

--
-- Name: hs_file_types_netcdflogicalfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_file_types_netcdflogicalfile_id_seq OWNED BY hs_file_types_netcdflogicalfile.id;


--
-- Name: hs_geo_raster_resource_bandinformation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geo_raster_resource_bandinformation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    name character varying(500),
    "variableName" text,
    "variableUnit" character varying(50),
    method text,
    comment text,
    content_type_id integer NOT NULL,
    "maximumValue" text,
    "minimumValue" text,
    "noDataValue" text,
    CONSTRAINT hs_geo_raster_resource_bandinformation_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_geo_raster_resource_bandinformation OWNER TO postgres;

--
-- Name: hs_geo_raster_resource_bandinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_geo_raster_resource_bandinformation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_geo_raster_resource_bandinformation_id_seq OWNER TO postgres;

--
-- Name: hs_geo_raster_resource_bandinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_geo_raster_resource_bandinformation_id_seq OWNED BY hs_geo_raster_resource_bandinformation.id;


--
-- Name: hs_geo_raster_resource_cellinformation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geo_raster_resource_cellinformation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    name character varying(500),
    rows integer,
    columns integer,
    "cellSizeXValue" double precision,
    "cellSizeYValue" double precision,
    "cellDataType" character varying(50),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_geo_raster_resource_cellinformation_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_geo_raster_resource_cellinformation OWNER TO postgres;

--
-- Name: hs_geo_raster_resource_cellinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_geo_raster_resource_cellinformation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_geo_raster_resource_cellinformation_id_seq OWNER TO postgres;

--
-- Name: hs_geo_raster_resource_cellinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_geo_raster_resource_cellinformation_id_seq OWNED BY hs_geo_raster_resource_cellinformation.id;


--
-- Name: hs_geo_raster_resource_originalcoverage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geo_raster_resource_originalcoverage (
    id integer NOT NULL,
    object_id integer NOT NULL,
    _value character varying(10000),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_geo_raster_resource_originalcoverage_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_geo_raster_resource_originalcoverage OWNER TO postgres;

--
-- Name: hs_geo_raster_resource_originalcoverage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_geo_raster_resource_originalcoverage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_geo_raster_resource_originalcoverage_id_seq OWNER TO postgres;

--
-- Name: hs_geo_raster_resource_originalcoverage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_geo_raster_resource_originalcoverage_id_seq OWNED BY hs_geo_raster_resource_originalcoverage.id;


--
-- Name: hs_geo_raster_resource_rastermetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geo_raster_resource_rastermetadata (
    coremetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_geo_raster_resource_rastermetadata OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_fieldinformation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geographic_feature_resource_fieldinformation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "fieldName" character varying(128) NOT NULL,
    "fieldType" character varying(128) NOT NULL,
    "fieldTypeCode" character varying(50),
    "fieldWidth" integer,
    "fieldPrecision" integer,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_geographic_feature_resource_fieldinformation_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_geographic_feature_resource_fieldinformation OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_fieldinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_geographic_feature_resource_fieldinformation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_geographic_feature_resource_fieldinformation_id_seq OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_fieldinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_geographic_feature_resource_fieldinformation_id_seq OWNED BY hs_geographic_feature_resource_fieldinformation.id;


--
-- Name: hs_geographic_feature_resource_geographicfeaturemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geographic_feature_resource_geographicfeaturemetadata (
    coremetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_geographic_feature_resource_geographicfeaturemetadata OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_geometryinformation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geographic_feature_resource_geometryinformation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "featureCount" integer NOT NULL,
    "geometryType" character varying(128) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_geographic_feature_resource_geometryinformat_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_geographic_feature_resource_geometryinformation OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_geometryinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_geographic_feature_resource_geometryinformation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_geographic_feature_resource_geometryinformation_id_seq OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_geometryinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_geographic_feature_resource_geometryinformation_id_seq OWNED BY hs_geographic_feature_resource_geometryinformation.id;


--
-- Name: hs_geographic_feature_resource_originalcoverage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geographic_feature_resource_originalcoverage (
    id integer NOT NULL,
    object_id integer NOT NULL,
    northlimit double precision NOT NULL,
    southlimit double precision NOT NULL,
    westlimit double precision NOT NULL,
    eastlimit double precision NOT NULL,
    projection_string text,
    projection_name text,
    datum text,
    unit text,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_geographic_feature_resource_originalcoverage_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_geographic_feature_resource_originalcoverage OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_originalcoverage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_geographic_feature_resource_originalcoverage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_geographic_feature_resource_originalcoverage_id_seq OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_originalcoverage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_geographic_feature_resource_originalcoverage_id_seq OWNED BY hs_geographic_feature_resource_originalcoverage.id;


--
-- Name: hs_geographic_feature_resource_originalfileinfo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_geographic_feature_resource_originalfileinfo (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "fileType" text NOT NULL,
    "baseFilename" text NOT NULL,
    "fileCount" integer NOT NULL,
    "filenameString" text,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_geographic_feature_resource_originalfileinfo_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_geographic_feature_resource_originalfileinfo OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_originalfileinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_geographic_feature_resource_originalfileinfo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_geographic_feature_resource_originalfileinfo_id_seq OWNER TO postgres;

--
-- Name: hs_geographic_feature_resource_originalfileinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_geographic_feature_resource_originalfileinfo_id_seq OWNED BY hs_geographic_feature_resource_originalfileinfo.id;


--
-- Name: hs_labels_resourcelabels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_labels_resourcelabels (
    id integer NOT NULL,
    resource_id integer
);


ALTER TABLE hs_labels_resourcelabels OWNER TO postgres;

--
-- Name: hs_labels_resourcelabels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_labels_resourcelabels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_labels_resourcelabels_id_seq OWNER TO postgres;

--
-- Name: hs_labels_resourcelabels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_labels_resourcelabels_id_seq OWNED BY hs_labels_resourcelabels.id;


--
-- Name: hs_labels_userlabels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_labels_userlabels (
    id integer NOT NULL,
    user_id integer
);


ALTER TABLE hs_labels_userlabels OWNER TO postgres;

--
-- Name: hs_labels_userlabels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_labels_userlabels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_labels_userlabels_id_seq OWNER TO postgres;

--
-- Name: hs_labels_userlabels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_labels_userlabels_id_seq OWNED BY hs_labels_userlabels.id;


--
-- Name: hs_labels_userresourceflags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_labels_userresourceflags (
    id integer NOT NULL,
    kind integer NOT NULL,
    start timestamp with time zone NOT NULL,
    resource_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE hs_labels_userresourceflags OWNER TO postgres;

--
-- Name: hs_labels_userresourceflags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_labels_userresourceflags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_labels_userresourceflags_id_seq OWNER TO postgres;

--
-- Name: hs_labels_userresourceflags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_labels_userresourceflags_id_seq OWNED BY hs_labels_userresourceflags.id;


--
-- Name: hs_labels_userresourcelabels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_labels_userresourcelabels (
    id integer NOT NULL,
    start timestamp with time zone NOT NULL,
    label text NOT NULL,
    resource_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE hs_labels_userresourcelabels OWNER TO postgres;

--
-- Name: hs_labels_userresourcelabels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_labels_userresourcelabels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_labels_userresourcelabels_id_seq OWNER TO postgres;

--
-- Name: hs_labels_userresourcelabels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_labels_userresourcelabels_id_seq OWNED BY hs_labels_userresourcelabels.id;


--
-- Name: hs_labels_userstoredlabels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_labels_userstoredlabels (
    id integer NOT NULL,
    label text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE hs_labels_userstoredlabels OWNER TO postgres;

--
-- Name: hs_labels_userstoredlabels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_labels_userstoredlabels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_labels_userstoredlabels_id_seq OWNER TO postgres;

--
-- Name: hs_labels_userstoredlabels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_labels_userstoredlabels_id_seq OWNED BY hs_labels_userstoredlabels.id;


--
-- Name: hs_model_program_modelprogrammetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_model_program_modelprogrammetadata (
    coremetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_model_program_modelprogrammetadata OWNER TO postgres;

--
-- Name: hs_model_program_mpmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_model_program_mpmetadata (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    "modelCodeRepository" character varying(255),
    "modelDocumentation" character varying(400),
    "modelOperatingSystem" character varying(255),
    "modelProgramLanguage" character varying(100),
    "modelReleaseDate" timestamp with time zone,
    "modelReleaseNotes" character varying(400),
    "modelSoftware" character varying(400),
    "modelVersion" character varying(255),
    "modelWebsite" character varying(255),
    "modelEngine" character varying(400),
    CONSTRAINT hs_model_program_mpmetadata_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_model_program_mpmetadata OWNER TO postgres;

--
-- Name: hs_model_program_mpmetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_model_program_mpmetadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_model_program_mpmetadata_id_seq OWNER TO postgres;

--
-- Name: hs_model_program_mpmetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_model_program_mpmetadata_id_seq OWNED BY hs_model_program_mpmetadata.id;


--
-- Name: hs_modelinstance_executedby; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modelinstance_executedby (
    id integer NOT NULL,
    object_id integer NOT NULL,
    model_name character varying(500) NOT NULL,
    content_type_id integer NOT NULL,
    model_program_fk_id integer,
    CONSTRAINT hs_modelinstance_executedby_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modelinstance_executedby OWNER TO postgres;

--
-- Name: hs_modelinstance_executedby_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modelinstance_executedby_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modelinstance_executedby_id_seq OWNER TO postgres;

--
-- Name: hs_modelinstance_executedby_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modelinstance_executedby_id_seq OWNED BY hs_modelinstance_executedby.id;


--
-- Name: hs_modelinstance_modelinstancemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modelinstance_modelinstancemetadata (
    coremetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_modelinstance_modelinstancemetadata OWNER TO postgres;

--
-- Name: hs_modelinstance_modeloutput; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modelinstance_modeloutput (
    id integer NOT NULL,
    object_id integer NOT NULL,
    includes_output boolean NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modelinstance_modeloutput_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modelinstance_modeloutput OWNER TO postgres;

--
-- Name: hs_modelinstance_modeloutput_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modelinstance_modeloutput_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modelinstance_modeloutput_id_seq OWNER TO postgres;

--
-- Name: hs_modelinstance_modeloutput_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modelinstance_modeloutput_id_seq OWNED BY hs_modelinstance_modeloutput.id;


--
-- Name: hs_modflow_modelinstance_boundarycondition; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_boundarycondition (
    id integer NOT NULL,
    object_id integer NOT NULL,
    other_specified_head_boundary_packages character varying(200),
    other_specified_flux_boundary_packages character varying(200),
    other_head_dependent_flux_boundary_packages character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_boundarycondition_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_boundarycondition OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14 (
    id integer NOT NULL,
    boundarycondition_id integer NOT NULL,
    headdependentfluxboundarypackagechoices_id integer NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14 OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq OWNED BY hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14.id;


--
-- Name: hs_modflow_modelinstance_boundarycondition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_boundarycondition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_boundarycondition_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_boundarycondition_id_seq OWNED BY hs_modflow_modelinstance_boundarycondition.id;


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3 (
    id integer NOT NULL,
    boundarycondition_id integer NOT NULL,
    specifiedfluxboundarypackagechoices_id integer NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3 OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq OWNED BY hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3.id;


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_head_b132e; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_boundarycondition_specified_head_b132e (
    id integer NOT NULL,
    boundarycondition_id integer NOT NULL,
    specifiedheadboundarypackagechoices_id integer NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_boundarycondition_specified_head_b132e OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq OWNED BY hs_modflow_modelinstance_boundarycondition_specified_head_b132e.id;


--
-- Name: hs_modflow_modelinstance_generalelements; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_generalelements (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "modelParameter" character varying(200),
    "modelSolver" character varying(100),
    "subsidencePackage" character varying(100),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_generalelements_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_generalelements OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_generalelements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_generalelements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_generalelements_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_generalelements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_generalelements_id_seq OWNED BY hs_modflow_modelinstance_generalelements.id;


--
-- Name: hs_modflow_modelinstance_generalelements_output_control_package; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_generalelements_output_control_package (
    id integer NOT NULL,
    generalelements_id integer NOT NULL,
    outputcontrolpackagechoices_id integer NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_generalelements_output_control_package OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_generalelements_output_control__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_generalelements_output_control__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_generalelements_output_control__id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_generalelements_output_control__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_generalelements_output_control__id_seq OWNED BY hs_modflow_modelinstance_generalelements_output_control_package.id;


--
-- Name: hs_modflow_modelinstance_griddimensions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_griddimensions (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "numberOfLayers" character varying(100),
    "typeOfRows" character varying(100),
    "numberOfRows" character varying(100),
    "typeOfColumns" character varying(100),
    "numberOfColumns" character varying(100),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_griddimensions_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_griddimensions OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_griddimensions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_griddimensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_griddimensions_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_griddimensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_griddimensions_id_seq OWNED BY hs_modflow_modelinstance_griddimensions.id;


--
-- Name: hs_modflow_modelinstance_groundwaterflow; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_groundwaterflow (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "flowPackage" character varying(100),
    "flowParameter" character varying(100),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_groundwaterflow_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_groundwaterflow OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_groundwaterflow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_groundwaterflow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_groundwaterflow_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_groundwaterflow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_groundwaterflow_id_seq OWNED BY hs_modflow_modelinstance_groundwaterflow.id;


--
-- Name: hs_modflow_modelinstance_headdependentfluxboundarypackagechf906; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_headdependentfluxboundarypackagechf906 (
    id integer NOT NULL,
    description character varying(300) NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_headdependentfluxboundarypackagechf906 OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq OWNED BY hs_modflow_modelinstance_headdependentfluxboundarypackagechf906.id;


--
-- Name: hs_modflow_modelinstance_modelcalibration; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_modelcalibration (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "calibratedParameter" character varying(200),
    "observationType" character varying(200),
    "observationProcessPackage" character varying(100),
    "calibrationMethod" character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_modelcalibration_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_modelcalibration OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_modelcalibration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_modelcalibration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_modelcalibration_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_modelcalibration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_modelcalibration_id_seq OWNED BY hs_modflow_modelinstance_modelcalibration.id;


--
-- Name: hs_modflow_modelinstance_modelinput; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_modelinput (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "inputType" character varying(200),
    "inputSourceName" character varying(200),
    "inputSourceURL" character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_modelinput_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_modelinput OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_modelinput_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_modelinput_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_modelinput_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_modelinput_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_modelinput_id_seq OWNED BY hs_modflow_modelinstance_modelinput.id;


--
-- Name: hs_modflow_modelinstance_modflowmodelinstancemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_modflowmodelinstancemetadata (
    modelinstancemetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_modflowmodelinstancemetadata OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_outputcontrolpackagechoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_outputcontrolpackagechoices (
    id integer NOT NULL,
    description character varying(300) NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_outputcontrolpackagechoices OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq OWNED BY hs_modflow_modelinstance_outputcontrolpackagechoices.id;


--
-- Name: hs_modflow_modelinstance_specifiedfluxboundarypackagechoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_specifiedfluxboundarypackagechoices (
    id integer NOT NULL,
    description character varying(300) NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_specifiedfluxboundarypackagechoices OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq OWNED BY hs_modflow_modelinstance_specifiedfluxboundarypackagechoices.id;


--
-- Name: hs_modflow_modelinstance_specifiedheadboundarypackagechoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_specifiedheadboundarypackagechoices (
    id integer NOT NULL,
    description character varying(300) NOT NULL
);


ALTER TABLE hs_modflow_modelinstance_specifiedheadboundarypackagechoices OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq OWNED BY hs_modflow_modelinstance_specifiedheadboundarypackagechoices.id;


--
-- Name: hs_modflow_modelinstance_stressperiod; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_stressperiod (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "stressPeriodType" character varying(100),
    "steadyStateValue" character varying(100),
    "transientStateValueType" character varying(100),
    "transientStateValue" character varying(100),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_stressperiod_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_stressperiod OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_stressperiod_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_stressperiod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_stressperiod_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_stressperiod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_stressperiod_id_seq OWNED BY hs_modflow_modelinstance_stressperiod.id;


--
-- Name: hs_modflow_modelinstance_studyarea; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_modflow_modelinstance_studyarea (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "totalLength" character varying(100),
    "totalWidth" character varying(100),
    "maximumElevation" character varying(100),
    "minimumElevation" character varying(100),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_modflow_modelinstance_studyarea_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_modflow_modelinstance_studyarea OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_studyarea_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_modflow_modelinstance_studyarea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_modflow_modelinstance_studyarea_id_seq OWNER TO postgres;

--
-- Name: hs_modflow_modelinstance_studyarea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_modflow_modelinstance_studyarea_id_seq OWNED BY hs_modflow_modelinstance_studyarea.id;


--
-- Name: hs_script_resource_scriptmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_script_resource_scriptmetadata (
    coremetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_script_resource_scriptmetadata OWNER TO postgres;

--
-- Name: hs_script_resource_scriptspecificmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_script_resource_scriptspecificmetadata (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "scriptLanguage" character varying(100) NOT NULL,
    "languageVersion" character varying(255) NOT NULL,
    "scriptVersion" character varying(255) NOT NULL,
    "scriptDependencies" character varying(400) NOT NULL,
    "scriptReleaseDate" timestamp with time zone,
    "scriptCodeRepository" character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_script_resource_scriptspecificmetadata_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_script_resource_scriptspecificmetadata OWNER TO postgres;

--
-- Name: hs_script_resource_scriptspecificmetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_script_resource_scriptspecificmetadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_script_resource_scriptspecificmetadata_id_seq OWNER TO postgres;

--
-- Name: hs_script_resource_scriptspecificmetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_script_resource_scriptspecificmetadata_id_seq OWNED BY hs_script_resource_scriptspecificmetadata.id;


--
-- Name: hs_swat_modelinstance_modelinput; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelinput (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "warmupPeriodValue" character varying(100),
    "rainfallTimeStepType" character varying(100),
    "rainfallTimeStepValue" character varying(100),
    "routingTimeStepType" character varying(100),
    "routingTimeStepValue" character varying(100),
    "simulationTimeStepType" character varying(100),
    "simulationTimeStepValue" character varying(100),
    "watershedArea" character varying(100),
    "numberOfSubbasins" character varying(100),
    "numberOfHRUs" character varying(100),
    "demResolution" character varying(100),
    "demSourceName" character varying(200),
    "demSourceURL" character varying(200),
    "landUseDataSourceName" character varying(200),
    "landUseDataSourceURL" character varying(200),
    "soilDataSourceName" character varying(200),
    "soilDataSourceURL" character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_swat_modelinstance_modelinput_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_swat_modelinstance_modelinput OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelinput_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelinput_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelinput_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelinput_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelinput_id_seq OWNED BY hs_swat_modelinstance_modelinput.id;


--
-- Name: hs_swat_modelinstance_modelmethod; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelmethod (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "runoffCalculationMethod" character varying(200),
    "petEstimationMethod" character varying(200),
    "flowRoutingMethod" character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_swat_modelinstance_modelmethod_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_swat_modelinstance_modelmethod OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelmethod_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelmethod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelmethod_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelmethod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelmethod_id_seq OWNED BY hs_swat_modelinstance_modelmethod.id;


--
-- Name: hs_swat_modelinstance_modelobjective; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelobjective (
    id integer NOT NULL,
    object_id integer NOT NULL,
    other_objectives character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_swat_modelinstance_modelobjective_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_swat_modelinstance_modelobjective OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelobjective_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelobjective_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelobjective_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelobjective_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelobjective_id_seq OWNED BY hs_swat_modelinstance_modelobjective.id;


--
-- Name: hs_swat_modelinstance_modelobjective_swat_model_objectives; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelobjective_swat_model_objectives (
    id integer NOT NULL,
    modelobjective_id integer NOT NULL,
    modelobjectivechoices_id integer NOT NULL
);


ALTER TABLE hs_swat_modelinstance_modelobjective_swat_model_objectives OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq OWNED BY hs_swat_modelinstance_modelobjective_swat_model_objectives.id;


--
-- Name: hs_swat_modelinstance_modelobjectivechoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelobjectivechoices (
    id integer NOT NULL,
    description character varying(300) NOT NULL
);


ALTER TABLE hs_swat_modelinstance_modelobjectivechoices OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelobjectivechoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelobjectivechoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelobjectivechoices_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelobjectivechoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelobjectivechoices_id_seq OWNED BY hs_swat_modelinstance_modelobjectivechoices.id;


--
-- Name: hs_swat_modelinstance_modelparameter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelparameter (
    id integer NOT NULL,
    object_id integer NOT NULL,
    other_parameters character varying(200),
    content_type_id integer NOT NULL,
    CONSTRAINT hs_swat_modelinstance_modelparameter_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_swat_modelinstance_modelparameter OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelparameter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelparameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelparameter_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelparameter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelparameter_id_seq OWNED BY hs_swat_modelinstance_modelparameter.id;


--
-- Name: hs_swat_modelinstance_modelparameter_model_parameters; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelparameter_model_parameters (
    id integer NOT NULL,
    modelparameter_id integer NOT NULL,
    modelparameterschoices_id integer NOT NULL
);


ALTER TABLE hs_swat_modelinstance_modelparameter_model_parameters OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelparameter_model_parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelparameter_model_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelparameter_model_parameters_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelparameter_model_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelparameter_model_parameters_id_seq OWNED BY hs_swat_modelinstance_modelparameter_model_parameters.id;


--
-- Name: hs_swat_modelinstance_modelparameterschoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_modelparameterschoices (
    id integer NOT NULL,
    description character varying(300) NOT NULL
);


ALTER TABLE hs_swat_modelinstance_modelparameterschoices OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelparameterschoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_modelparameterschoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_modelparameterschoices_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_modelparameterschoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_modelparameterschoices_id_seq OWNED BY hs_swat_modelinstance_modelparameterschoices.id;


--
-- Name: hs_swat_modelinstance_simulationtype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_simulationtype (
    id integer NOT NULL,
    object_id integer NOT NULL,
    simulation_type_name character varying(100) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_swat_modelinstance_simulationtype_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_swat_modelinstance_simulationtype OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_simulationtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_swat_modelinstance_simulationtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_swat_modelinstance_simulationtype_id_seq OWNER TO postgres;

--
-- Name: hs_swat_modelinstance_simulationtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_swat_modelinstance_simulationtype_id_seq OWNED BY hs_swat_modelinstance_simulationtype.id;


--
-- Name: hs_swat_modelinstance_swatmodelinstancemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_swat_modelinstance_swatmodelinstancemetadata (
    modelinstancemetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_swat_modelinstance_swatmodelinstancemetadata OWNER TO postgres;

--
-- Name: hs_tools_resource_apphomepageurl; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_apphomepageurl (
    id integer NOT NULL,
    object_id integer NOT NULL,
    value character varying(1024) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_tools_resource_apphomepageurl_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_tools_resource_apphomepageurl OWNER TO postgres;

--
-- Name: hs_tools_resource_apphomepageurl_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_apphomepageurl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_apphomepageurl_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_apphomepageurl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_apphomepageurl_id_seq OWNED BY hs_tools_resource_apphomepageurl.id;


--
-- Name: hs_tools_resource_requesturlbase; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_requesturlbase (
    id integer NOT NULL,
    object_id integer NOT NULL,
    value character varying(1024) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_tools_resource_requesturlbase_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_tools_resource_requesturlbase OWNER TO postgres;

--
-- Name: hs_tools_resource_requesturlbase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_requesturlbase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_requesturlbase_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_requesturlbase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_requesturlbase_id_seq OWNED BY hs_tools_resource_requesturlbase.id;


--
-- Name: hs_tools_resource_supportedrestypechoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_supportedrestypechoices (
    id integer NOT NULL,
    description character varying(128) NOT NULL
);


ALTER TABLE hs_tools_resource_supportedrestypechoices OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedrestypechoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_supportedrestypechoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_supportedrestypechoices_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedrestypechoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_supportedrestypechoices_id_seq OWNED BY hs_tools_resource_supportedrestypechoices.id;


--
-- Name: hs_tools_resource_supportedrestypes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_supportedrestypes (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_tools_resource_supportedrestypes_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_tools_resource_supportedrestypes OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedrestypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_supportedrestypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_supportedrestypes_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedrestypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_supportedrestypes_id_seq OWNED BY hs_tools_resource_supportedrestypes.id;


--
-- Name: hs_tools_resource_supportedrestypes_supported_res_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_supportedrestypes_supported_res_types (
    id integer NOT NULL,
    supportedrestypes_id integer NOT NULL,
    supportedrestypechoices_id integer NOT NULL
);


ALTER TABLE hs_tools_resource_supportedrestypes_supported_res_types OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedrestypes_supported_res_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_supportedrestypes_supported_res_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_supportedrestypes_supported_res_types_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedrestypes_supported_res_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_supportedrestypes_supported_res_types_id_seq OWNED BY hs_tools_resource_supportedrestypes_supported_res_types.id;


--
-- Name: hs_tools_resource_supportedsharingstatus; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_supportedsharingstatus (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_tools_resource_supportedsharingstatus_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_tools_resource_supportedsharingstatus OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedsharingstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_supportedsharingstatus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_supportedsharingstatus_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedsharingstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_supportedsharingstatus_id_seq OWNED BY hs_tools_resource_supportedsharingstatus.id;


--
-- Name: hs_tools_resource_supportedsharingstatus_sharing_status; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_supportedsharingstatus_sharing_status (
    id integer NOT NULL,
    supportedsharingstatus_id integer NOT NULL,
    supportedsharingstatuschoices_id integer NOT NULL
);


ALTER TABLE hs_tools_resource_supportedsharingstatus_sharing_status OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedsharingstatus_sharing_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_supportedsharingstatus_sharing_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_supportedsharingstatus_sharing_status_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedsharingstatus_sharing_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_supportedsharingstatus_sharing_status_id_seq OWNED BY hs_tools_resource_supportedsharingstatus_sharing_status.id;


--
-- Name: hs_tools_resource_supportedsharingstatuschoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_supportedsharingstatuschoices (
    id integer NOT NULL,
    description character varying(128) NOT NULL
);


ALTER TABLE hs_tools_resource_supportedsharingstatuschoices OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedsharingstatuschoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_supportedsharingstatuschoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_supportedsharingstatuschoices_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_supportedsharingstatuschoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_supportedsharingstatuschoices_id_seq OWNED BY hs_tools_resource_supportedsharingstatuschoices.id;


--
-- Name: hs_tools_resource_toolicon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_toolicon (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    value character varying(1024) NOT NULL,
    data_url text NOT NULL,
    CONSTRAINT hs_tools_resource_toolicon_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_tools_resource_toolicon OWNER TO postgres;

--
-- Name: hs_tools_resource_toolicon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_toolicon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_toolicon_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_toolicon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_toolicon_id_seq OWNED BY hs_tools_resource_toolicon.id;


--
-- Name: hs_tools_resource_toolmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_toolmetadata (
    coremetadata_ptr_id integer NOT NULL
);


ALTER TABLE hs_tools_resource_toolmetadata OWNER TO postgres;

--
-- Name: hs_tools_resource_toolversion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tools_resource_toolversion (
    id integer NOT NULL,
    object_id integer NOT NULL,
    value character varying(128) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT hs_tools_resource_toolversion_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE hs_tools_resource_toolversion OWNER TO postgres;

--
-- Name: hs_tools_resource_toolversion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tools_resource_toolversion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tools_resource_toolversion_id_seq OWNER TO postgres;

--
-- Name: hs_tools_resource_toolversion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tools_resource_toolversion_id_seq OWNED BY hs_tools_resource_toolversion.id;


--
-- Name: hs_tracking_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tracking_session (
    id integer NOT NULL,
    begin timestamp with time zone NOT NULL,
    visitor_id integer NOT NULL
);


ALTER TABLE hs_tracking_session OWNER TO postgres;

--
-- Name: hs_tracking_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tracking_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tracking_session_id_seq OWNER TO postgres;

--
-- Name: hs_tracking_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tracking_session_id_seq OWNED BY hs_tracking_session.id;


--
-- Name: hs_tracking_variable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tracking_variable (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    name character varying(32) NOT NULL,
    type integer NOT NULL,
    value text NOT NULL,
    session_id integer NOT NULL
);


ALTER TABLE hs_tracking_variable OWNER TO postgres;

--
-- Name: hs_tracking_variable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tracking_variable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tracking_variable_id_seq OWNER TO postgres;

--
-- Name: hs_tracking_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tracking_variable_id_seq OWNED BY hs_tracking_variable.id;


--
-- Name: hs_tracking_visitor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hs_tracking_visitor (
    id integer NOT NULL,
    first_seen timestamp with time zone NOT NULL,
    user_id integer
);


ALTER TABLE hs_tracking_visitor OWNER TO postgres;

--
-- Name: hs_tracking_visitor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hs_tracking_visitor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hs_tracking_visitor_id_seq OWNER TO postgres;

--
-- Name: hs_tracking_visitor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hs_tracking_visitor_id_seq OWNED BY hs_tracking_visitor.id;


--
-- Name: oauth2_provider_accesstoken; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oauth2_provider_accesstoken (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires timestamp with time zone NOT NULL,
    scope text NOT NULL,
    application_id integer NOT NULL,
    user_id integer
);


ALTER TABLE oauth2_provider_accesstoken OWNER TO postgres;

--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oauth2_provider_accesstoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oauth2_provider_accesstoken_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oauth2_provider_accesstoken_id_seq OWNED BY oauth2_provider_accesstoken.id;


--
-- Name: oauth2_provider_application; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oauth2_provider_application (
    id integer NOT NULL,
    client_id character varying(100) NOT NULL,
    redirect_uris text NOT NULL,
    client_type character varying(32) NOT NULL,
    authorization_grant_type character varying(32) NOT NULL,
    client_secret character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    user_id integer NOT NULL,
    skip_authorization boolean NOT NULL
);


ALTER TABLE oauth2_provider_application OWNER TO postgres;

--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oauth2_provider_application_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oauth2_provider_application_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oauth2_provider_application_id_seq OWNED BY oauth2_provider_application.id;


--
-- Name: oauth2_provider_grant; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oauth2_provider_grant (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    expires timestamp with time zone NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    scope text NOT NULL,
    application_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE oauth2_provider_grant OWNER TO postgres;

--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oauth2_provider_grant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oauth2_provider_grant_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oauth2_provider_grant_id_seq OWNED BY oauth2_provider_grant.id;


--
-- Name: oauth2_provider_refreshtoken; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oauth2_provider_refreshtoken (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    access_token_id integer NOT NULL,
    application_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE oauth2_provider_refreshtoken OWNER TO postgres;

--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oauth2_provider_refreshtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oauth2_provider_refreshtoken_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oauth2_provider_refreshtoken_id_seq OWNED BY oauth2_provider_refreshtoken.id;


--
-- Name: pages_link; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pages_link (
    page_ptr_id integer NOT NULL
);


ALTER TABLE pages_link OWNER TO postgres;

--
-- Name: pages_page; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pages_page (
    id integer NOT NULL,
    keywords_string character varying(500) NOT NULL,
    site_id integer NOT NULL,
    title character varying(500) NOT NULL,
    slug character varying(2000),
    _meta_title character varying(500),
    description text NOT NULL,
    gen_description boolean NOT NULL,
    created timestamp with time zone,
    updated timestamp with time zone,
    status integer NOT NULL,
    publish_date timestamp with time zone,
    expiry_date timestamp with time zone,
    short_url character varying(200),
    in_sitemap boolean NOT NULL,
    _order integer,
    parent_id integer,
    in_menus character varying(100),
    titles character varying(1000),
    content_model character varying(50),
    login_required boolean NOT NULL
);


ALTER TABLE pages_page OWNER TO postgres;

--
-- Name: pages_page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pages_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pages_page_id_seq OWNER TO postgres;

--
-- Name: pages_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pages_page_id_seq OWNED BY pages_page.id;


--
-- Name: pages_richtextpage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pages_richtextpage (
    page_ptr_id integer NOT NULL,
    content text NOT NULL
);


ALTER TABLE pages_richtextpage OWNER TO postgres;

--
-- Name: ref_ts_datasource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_ts_datasource (
    id integer NOT NULL,
    object_id integer NOT NULL,
    code character varying(500) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT ref_ts_datasource_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE ref_ts_datasource OWNER TO postgres;

--
-- Name: ref_ts_datasource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ref_ts_datasource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_ts_datasource_id_seq OWNER TO postgres;

--
-- Name: ref_ts_datasource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ref_ts_datasource_id_seq OWNED BY ref_ts_datasource.id;


--
-- Name: ref_ts_method; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_ts_method (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    code character varying(500) NOT NULL,
    description text NOT NULL,
    CONSTRAINT ref_ts_method_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE ref_ts_method OWNER TO postgres;

--
-- Name: ref_ts_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ref_ts_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_ts_method_id_seq OWNER TO postgres;

--
-- Name: ref_ts_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ref_ts_method_id_seq OWNED BY ref_ts_method.id;


--
-- Name: ref_ts_qualitycontrollevel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_ts_qualitycontrollevel (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    code character varying(500) NOT NULL,
    definition character varying(500) NOT NULL,
    CONSTRAINT ref_ts_qualitycontrollevel_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE ref_ts_qualitycontrollevel OWNER TO postgres;

--
-- Name: ref_ts_qualitycontrollevel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ref_ts_qualitycontrollevel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_ts_qualitycontrollevel_id_seq OWNER TO postgres;

--
-- Name: ref_ts_qualitycontrollevel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ref_ts_qualitycontrollevel_id_seq OWNED BY ref_ts_qualitycontrollevel.id;


--
-- Name: ref_ts_referenceurl; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_ts_referenceurl (
    id integer NOT NULL,
    object_id integer NOT NULL,
    value character varying(500) NOT NULL,
    type character varying(4) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT ref_ts_referenceurl_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE ref_ts_referenceurl OWNER TO postgres;

--
-- Name: ref_ts_referenceurl_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ref_ts_referenceurl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_ts_referenceurl_id_seq OWNER TO postgres;

--
-- Name: ref_ts_referenceurl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ref_ts_referenceurl_id_seq OWNED BY ref_ts_referenceurl.id;


--
-- Name: ref_ts_reftsmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_ts_reftsmetadata (
    coremetadata_ptr_id integer NOT NULL
);


ALTER TABLE ref_ts_reftsmetadata OWNER TO postgres;

--
-- Name: ref_ts_site; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_ts_site (
    id integer NOT NULL,
    object_id integer NOT NULL,
    name character varying(500) NOT NULL,
    code character varying(500) NOT NULL,
    latitude numeric(9,6),
    longitude numeric(9,6),
    content_type_id integer NOT NULL,
    net_work character varying(500) NOT NULL,
    CONSTRAINT ref_ts_site_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE ref_ts_site OWNER TO postgres;

--
-- Name: ref_ts_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ref_ts_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_ts_site_id_seq OWNER TO postgres;

--
-- Name: ref_ts_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ref_ts_site_id_seq OWNED BY ref_ts_site.id;


--
-- Name: ref_ts_variable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_ts_variable (
    id integer NOT NULL,
    object_id integer NOT NULL,
    name character varying(500) NOT NULL,
    code character varying(500) NOT NULL,
    data_type character varying(500) NOT NULL,
    sample_medium character varying(500) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT ref_ts_variable_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE ref_ts_variable OWNER TO postgres;

--
-- Name: ref_ts_variable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ref_ts_variable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_ts_variable_id_seq OWNER TO postgres;

--
-- Name: ref_ts_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ref_ts_variable_id_seq OWNED BY ref_ts_variable.id;


--
-- Name: robots_rule; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE robots_rule (
    id integer NOT NULL,
    robot character varying(255) NOT NULL,
    crawl_delay numeric(3,1)
);


ALTER TABLE robots_rule OWNER TO postgres;

--
-- Name: robots_rule_allowed; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE robots_rule_allowed (
    id integer NOT NULL,
    rule_id integer NOT NULL,
    url_id integer NOT NULL
);


ALTER TABLE robots_rule_allowed OWNER TO postgres;

--
-- Name: robots_rule_allowed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE robots_rule_allowed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE robots_rule_allowed_id_seq OWNER TO postgres;

--
-- Name: robots_rule_allowed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE robots_rule_allowed_id_seq OWNED BY robots_rule_allowed.id;


--
-- Name: robots_rule_disallowed; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE robots_rule_disallowed (
    id integer NOT NULL,
    rule_id integer NOT NULL,
    url_id integer NOT NULL
);


ALTER TABLE robots_rule_disallowed OWNER TO postgres;

--
-- Name: robots_rule_disallowed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE robots_rule_disallowed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE robots_rule_disallowed_id_seq OWNER TO postgres;

--
-- Name: robots_rule_disallowed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE robots_rule_disallowed_id_seq OWNED BY robots_rule_disallowed.id;


--
-- Name: robots_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE robots_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE robots_rule_id_seq OWNER TO postgres;

--
-- Name: robots_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE robots_rule_id_seq OWNED BY robots_rule.id;


--
-- Name: robots_rule_sites; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE robots_rule_sites (
    id integer NOT NULL,
    rule_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE robots_rule_sites OWNER TO postgres;

--
-- Name: robots_rule_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE robots_rule_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE robots_rule_sites_id_seq OWNER TO postgres;

--
-- Name: robots_rule_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE robots_rule_sites_id_seq OWNED BY robots_rule_sites.id;


--
-- Name: robots_url; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE robots_url (
    id integer NOT NULL,
    pattern character varying(255) NOT NULL
);


ALTER TABLE robots_url OWNER TO postgres;

--
-- Name: robots_url_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE robots_url_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE robots_url_id_seq OWNER TO postgres;

--
-- Name: robots_url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE robots_url_id_seq OWNED BY robots_url.id;


--
-- Name: security_cspreport; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE security_cspreport (
    id integer NOT NULL,
    document_uri character varying(1000) NOT NULL,
    referrer character varying(1000) NOT NULL,
    blocked_uri character varying(1000) NOT NULL,
    violated_directive character varying(1000) NOT NULL,
    original_policy text,
    date_received timestamp with time zone NOT NULL,
    sender_ip inet NOT NULL,
    user_agent character varying(1000) NOT NULL
);


ALTER TABLE security_cspreport OWNER TO postgres;

--
-- Name: security_cspreport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE security_cspreport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE security_cspreport_id_seq OWNER TO postgres;

--
-- Name: security_cspreport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE security_cspreport_id_seq OWNED BY security_cspreport.id;


--
-- Name: security_passwordexpiry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE security_passwordexpiry (
    id integer NOT NULL,
    password_expiry_date timestamp with time zone,
    user_id integer NOT NULL
);


ALTER TABLE security_passwordexpiry OWNER TO postgres;

--
-- Name: security_passwordexpiry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE security_passwordexpiry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE security_passwordexpiry_id_seq OWNER TO postgres;

--
-- Name: security_passwordexpiry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE security_passwordexpiry_id_seq OWNED BY security_passwordexpiry.id;


--
-- Name: theme_homepage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE theme_homepage (
    page_ptr_id integer NOT NULL,
    heading character varying(100) NOT NULL,
    slide_in_one_icon character varying(50) NOT NULL,
    slide_in_one character varying(200) NOT NULL,
    slide_in_two_icon character varying(50) NOT NULL,
    slide_in_two character varying(200) NOT NULL,
    slide_in_three_icon character varying(50) NOT NULL,
    slide_in_three character varying(200) NOT NULL,
    header_background character varying(255) NOT NULL,
    header_image character varying(255),
    welcome_heading character varying(100) NOT NULL,
    content text NOT NULL,
    recent_blog_heading character varying(100) NOT NULL,
    number_recent_posts integer NOT NULL,
    message_end_date date,
    message_start_date date,
    message_type character varying(100) NOT NULL,
    show_message boolean NOT NULL,
    CONSTRAINT theme_homepage_number_recent_posts_check CHECK ((number_recent_posts >= 0))
);


ALTER TABLE theme_homepage OWNER TO postgres;

--
-- Name: theme_iconbox; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE theme_iconbox (
    id integer NOT NULL,
    _order integer,
    icon character varying(50) NOT NULL,
    title character varying(200) NOT NULL,
    link_text character varying(100) NOT NULL,
    link character varying(2000) NOT NULL,
    homepage_id integer NOT NULL
);


ALTER TABLE theme_iconbox OWNER TO postgres;

--
-- Name: theme_iconbox_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE theme_iconbox_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE theme_iconbox_id_seq OWNER TO postgres;

--
-- Name: theme_iconbox_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE theme_iconbox_id_seq OWNED BY theme_iconbox.id;


--
-- Name: theme_quotamessage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE theme_quotamessage (
    id integer NOT NULL,
    warning_content_prepend text NOT NULL,
    grace_period_content_prepend text NOT NULL,
    enforce_content_prepend text NOT NULL,
    content text NOT NULL,
    soft_limit_percent integer NOT NULL,
    hard_limit_percent integer NOT NULL,
    grace_period integer NOT NULL
);


ALTER TABLE theme_quotamessage OWNER TO postgres;

--
-- Name: theme_quotamessage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE theme_quotamessage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE theme_quotamessage_id_seq OWNER TO postgres;

--
-- Name: theme_quotamessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE theme_quotamessage_id_seq OWNED BY theme_quotamessage.id;


--
-- Name: theme_siteconfiguration; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE theme_siteconfiguration (
    id integer NOT NULL,
    col1_heading character varying(200) NOT NULL,
    col1_content text NOT NULL,
    col2_heading character varying(200) NOT NULL,
    col2_content text NOT NULL,
    col3_heading character varying(200) NOT NULL,
    col3_content text NOT NULL,
    twitter_link character varying(2000) NOT NULL,
    facebook_link character varying(2000) NOT NULL,
    pinterest_link character varying(2000) NOT NULL,
    youtube_link character varying(2000) NOT NULL,
    github_link character varying(2000) NOT NULL,
    linkedin_link character varying(2000) NOT NULL,
    vk_link character varying(2000) NOT NULL,
    gplus_link character varying(2000) NOT NULL,
    has_social_network_links boolean NOT NULL,
    copyright text NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE theme_siteconfiguration OWNER TO postgres;

--
-- Name: theme_siteconfiguration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE theme_siteconfiguration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE theme_siteconfiguration_id_seq OWNER TO postgres;

--
-- Name: theme_siteconfiguration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE theme_siteconfiguration_id_seq OWNED BY theme_siteconfiguration.id;


--
-- Name: theme_userprofile; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE theme_userprofile (
    id integer NOT NULL,
    picture character varying(100),
    title character varying(1024),
    subject_areas character varying(1024),
    organization character varying(1024),
    phone_1 character varying(1024),
    phone_1_type character varying(1024),
    phone_2 character varying(1024),
    phone_2_type character varying(1024),
    public boolean NOT NULL,
    cv character varying(100),
    details text,
    user_id integer NOT NULL,
    country character varying(1024),
    middle_name character varying(1024),
    state character varying(1024),
    user_type character varying(1024),
    website character varying(200),
    create_irods_user_account boolean NOT NULL,
    ssn_last_four character varying(4),
    create_irods_user_account boolean NOT NULL
);


ALTER TABLE theme_userprofile OWNER TO postgres;

--
-- Name: theme_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE theme_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE theme_userprofile_id_seq OWNER TO postgres;

--
-- Name: theme_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE theme_userprofile_id_seq OWNED BY theme_userprofile.id;


--
-- Name: theme_userquota; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE theme_userquota (
    id integer NOT NULL,
    allocated_value bigint NOT NULL,
    used_value bigint NOT NULL,
    unit character varying(10) NOT NULL,
    zone character varying(100) NOT NULL,
    remaining_grace_period integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE theme_userquota OWNER TO postgres;

--
-- Name: theme_userquota_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE theme_userquota_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE theme_userquota_id_seq OWNER TO postgres;

--
-- Name: theme_userquota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE theme_userquota_id_seq OWNED BY theme_userquota.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogcategory ALTER COLUMN id SET DEFAULT nextval('blog_blogcategory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogpost ALTER COLUMN id SET DEFAULT nextval('blog_blogpost_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogpost_categories ALTER COLUMN id SET DEFAULT nextval('blog_blogpost_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogpost_related_posts ALTER COLUMN id SET DEFAULT nextval('blog_blogpost_related_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_taskmeta ALTER COLUMN id SET DEFAULT nextval('celery_taskmeta_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY celery_tasksetmeta ALTER COLUMN id SET DEFAULT nextval('celery_tasksetmeta_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conf_setting ALTER COLUMN id SET DEFAULT nextval('conf_setting_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_sitepermission ALTER COLUMN id SET DEFAULT nextval('core_sitepermission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_sitepermission_sites ALTER COLUMN id SET DEFAULT nextval('core_sitepermission_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY corsheaders_corsmodel ALTER COLUMN id SET DEFAULT nextval('corsheaders_corsmodel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_comment_flags ALTER COLUMN id SET DEFAULT nextval('django_comment_flags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_comments ALTER COLUMN id SET DEFAULT nextval('django_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_containeroverrides ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_containeroverrides_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerenvvar ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_dockerenvvar_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerlink ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_dockerlink_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerport ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_dockerport_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerprocess ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_dockerprocess_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerprofile ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_dockerprofile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockervolume ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_dockervolume_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overrideenvvar ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_overrideenvvar_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overridelink ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_overridelink_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overrideport ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_overrideport_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overridevolume ALTER COLUMN id SET DEFAULT nextval('django_docker_processes_overridevolume_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_irods_rodsenvironment ALTER COLUMN id SET DEFAULT nextval('django_irods_rodsenvironment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_redirect ALTER COLUMN id SET DEFAULT nextval('django_redirect_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_crontabschedule ALTER COLUMN id SET DEFAULT nextval('djcelery_crontabschedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_intervalschedule ALTER COLUMN id SET DEFAULT nextval('djcelery_intervalschedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask ALTER COLUMN id SET DEFAULT nextval('djcelery_periodictask_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_taskstate ALTER COLUMN id SET DEFAULT nextval('djcelery_taskstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_workerstate ALTER COLUMN id SET DEFAULT nextval('djcelery_workerstate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forms_field ALTER COLUMN id SET DEFAULT nextval('forms_field_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forms_fieldentry ALTER COLUMN id SET DEFAULT nextval('forms_fieldentry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forms_formentry ALTER COLUMN id SET DEFAULT nextval('forms_formentry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_ows_ogrdataset ALTER COLUMN id SET DEFAULT nextval('ga_ows_ogrdataset_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_ows_ogrdatasetcollection ALTER COLUMN id SET DEFAULT nextval('ga_ows_ogrdatasetcollection_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_ows_ogrlayer ALTER COLUMN id SET DEFAULT nextval('ga_ows_ogrlayer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_orderedresource ALTER COLUMN id SET DEFAULT nextval('ga_resources_orderedresource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_renderedlayer_styles ALTER COLUMN id SET DEFAULT nextval('ga_resources_renderedlayer_styles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY galleries_galleryimage ALTER COLUMN id SET DEFAULT nextval('galleries_galleryimage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_assignedkeyword ALTER COLUMN id SET DEFAULT nextval('generic_assignedkeyword_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_keyword ALTER COLUMN id SET DEFAULT nextval('generic_keyword_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_rating ALTER COLUMN id SET DEFAULT nextval('generic_rating_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupaccess ALTER COLUMN id SET DEFAULT nextval('hs_access_control_groupaccess_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupmembershiprequest ALTER COLUMN id SET DEFAULT nextval('hs_access_control_groupmembershiprequest_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprivilege ALTER COLUMN id SET DEFAULT nextval('hs_access_control_groupresourceprivilege_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprovenance ALTER COLUMN id SET DEFAULT nextval('hs_access_control_groupresourceprovenance_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_resourceaccess ALTER COLUMN id SET DEFAULT nextval('hs_access_control_resourceaccess_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_useraccess ALTER COLUMN id SET DEFAULT nextval('hs_access_control_useraccess_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprivilege ALTER COLUMN id SET DEFAULT nextval('hs_access_control_usergroupprivilege_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprovenance ALTER COLUMN id SET DEFAULT nextval('hs_access_control_usergroupprovenance_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprivilege ALTER COLUMN id SET DEFAULT nextval('hs_access_control_userresourceprivilege_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprovenance ALTER COLUMN id SET DEFAULT nextval('hs_access_control_userresourceprovenance_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "hs_app_netCDF_originalcoverage" ALTER COLUMN id SET DEFAULT nextval('"hs_app_netCDF_originalcoverage_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "hs_app_netCDF_variable" ALTER COLUMN id SET DEFAULT nextval('"hs_app_netCDF_variable_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvaggregationstatistic ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvaggregationstatistic_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvelevationdatum ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvelevationdatum_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvmedium ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvmedium_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvmethodtype ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvmethodtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvsitetype ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvsitetype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvspeciation ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvspeciation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvstatus ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvstatus_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvunitstype ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvunitstype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvvariablename ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvvariablename_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvvariabletype ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_cvvariabletype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_method ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_method_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_processinglevel ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_processinglevel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_site ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_timeseriesresult ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_timeseriesresult_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_utcoffset ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_utcoffset_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_variable ALTER COLUMN id SET DEFAULT nextval('hs_app_timeseries_variable_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource ALTER COLUMN id SET DEFAULT nextval('hs_collection_resource_collectiondeletedresource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource_resource_od9f5 ALTER COLUMN id SET DEFAULT nextval('hs_collection_resource_collectiondeletedresource_resourc_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_bags ALTER COLUMN id SET DEFAULT nextval('hs_core_bags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_contributor ALTER COLUMN id SET DEFAULT nextval('hs_core_contributor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_coremetadata ALTER COLUMN id SET DEFAULT nextval('hs_core_coremetadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_coverage ALTER COLUMN id SET DEFAULT nextval('hs_core_coverage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_creator ALTER COLUMN id SET DEFAULT nextval('hs_core_creator_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_date ALTER COLUMN id SET DEFAULT nextval('hs_core_date_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_description ALTER COLUMN id SET DEFAULT nextval('hs_core_description_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_externalprofilelink ALTER COLUMN id SET DEFAULT nextval('hs_core_externalprofilelink_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_format ALTER COLUMN id SET DEFAULT nextval('hs_core_format_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_fundingagency ALTER COLUMN id SET DEFAULT nextval('hs_core_fundingagency_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource_collections ALTER COLUMN id SET DEFAULT nextval('hs_core_genericresource_collections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_groupownership ALTER COLUMN id SET DEFAULT nextval('hs_core_groupownership_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_identifier ALTER COLUMN id SET DEFAULT nextval('hs_core_identifier_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_language ALTER COLUMN id SET DEFAULT nextval('hs_core_language_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_publisher ALTER COLUMN id SET DEFAULT nextval('hs_core_publisher_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_relation ALTER COLUMN id SET DEFAULT nextval('hs_core_relation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_resourcefile ALTER COLUMN id SET DEFAULT nextval('hs_core_resourcefile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_rights ALTER COLUMN id SET DEFAULT nextval('hs_core_rights_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_source ALTER COLUMN id SET DEFAULT nextval('hs_core_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_subject ALTER COLUMN id SET DEFAULT nextval('hs_core_subject_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_title ALTER COLUMN id SET DEFAULT nextval('hs_core_title_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_type ALTER COLUMN id SET DEFAULT nextval('hs_core_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_genericfilemetadata ALTER COLUMN id SET DEFAULT nextval('hs_file_types_genericfilemetadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_genericlogicalfile ALTER COLUMN id SET DEFAULT nextval('hs_file_types_genericlogicalfile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_georasterfilemetadata ALTER COLUMN id SET DEFAULT nextval('hs_file_types_georasterfilemetadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_georasterlogicalfile ALTER COLUMN id SET DEFAULT nextval('hs_file_types_georasterlogicalfile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_netcdffilemetadata ALTER COLUMN id SET DEFAULT nextval('hs_file_types_netcdffilemetadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_netcdflogicalfile ALTER COLUMN id SET DEFAULT nextval('hs_file_types_netcdflogicalfile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geo_raster_resource_bandinformation ALTER COLUMN id SET DEFAULT nextval('hs_geo_raster_resource_bandinformation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geo_raster_resource_cellinformation ALTER COLUMN id SET DEFAULT nextval('hs_geo_raster_resource_cellinformation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geo_raster_resource_originalcoverage ALTER COLUMN id SET DEFAULT nextval('hs_geo_raster_resource_originalcoverage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_fieldinformation ALTER COLUMN id SET DEFAULT nextval('hs_geographic_feature_resource_fieldinformation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_geometryinformation ALTER COLUMN id SET DEFAULT nextval('hs_geographic_feature_resource_geometryinformation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalcoverage ALTER COLUMN id SET DEFAULT nextval('hs_geographic_feature_resource_originalcoverage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalfileinfo ALTER COLUMN id SET DEFAULT nextval('hs_geographic_feature_resource_originalfileinfo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_resourcelabels ALTER COLUMN id SET DEFAULT nextval('hs_labels_resourcelabels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userlabels ALTER COLUMN id SET DEFAULT nextval('hs_labels_userlabels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userresourceflags ALTER COLUMN id SET DEFAULT nextval('hs_labels_userresourceflags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userresourcelabels ALTER COLUMN id SET DEFAULT nextval('hs_labels_userresourcelabels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userstoredlabels ALTER COLUMN id SET DEFAULT nextval('hs_labels_userstoredlabels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_model_program_mpmetadata ALTER COLUMN id SET DEFAULT nextval('hs_model_program_mpmetadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modelinstance_executedby ALTER COLUMN id SET DEFAULT nextval('hs_modelinstance_executedby_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modelinstance_modeloutput ALTER COLUMN id SET DEFAULT nextval('hs_modelinstance_modeloutput_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_boundarycondition_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14 ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3 ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_head_b132e ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_generalelements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements_output_control_package ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_generalelements_output_control__id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_griddimensions ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_griddimensions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_groundwaterflow ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_groundwaterflow_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_headdependentfluxboundarypackagechf906 ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_modelcalibration ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_modelcalibration_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_modelinput ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_modelinput_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_outputcontrolpackagechoices ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_specifiedfluxboundarypackagechoices ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_specifiedheadboundarypackagechoices ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_stressperiod ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_stressperiod_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_studyarea ALTER COLUMN id SET DEFAULT nextval('hs_modflow_modelinstance_studyarea_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_script_resource_scriptspecificmetadata ALTER COLUMN id SET DEFAULT nextval('hs_script_resource_scriptspecificmetadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelinput ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelinput_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelmethod ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelmethod_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelobjective_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective_swat_model_objectives ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjectivechoices ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelobjectivechoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelparameter_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter_model_parameters ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelparameter_model_parameters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameterschoices ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_modelparameterschoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_simulationtype ALTER COLUMN id SET DEFAULT nextval('hs_swat_modelinstance_simulationtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_apphomepageurl ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_apphomepageurl_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_requesturlbase ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_requesturlbase_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypechoices ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_supportedrestypechoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_supportedrestypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes_supported_res_types ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_supportedrestypes_supported_res_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_supportedsharingstatus_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus_sharing_status ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_supportedsharingstatus_sharing_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatuschoices ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_supportedsharingstatuschoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_toolicon ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_toolicon_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_toolversion ALTER COLUMN id SET DEFAULT nextval('hs_tools_resource_toolversion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tracking_session ALTER COLUMN id SET DEFAULT nextval('hs_tracking_session_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tracking_variable ALTER COLUMN id SET DEFAULT nextval('hs_tracking_variable_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tracking_visitor ALTER COLUMN id SET DEFAULT nextval('hs_tracking_visitor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_accesstoken ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_accesstoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_application ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_application_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_grant ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_grant_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_refreshtoken ALTER COLUMN id SET DEFAULT nextval('oauth2_provider_refreshtoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pages_page ALTER COLUMN id SET DEFAULT nextval('pages_page_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_datasource ALTER COLUMN id SET DEFAULT nextval('ref_ts_datasource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_method ALTER COLUMN id SET DEFAULT nextval('ref_ts_method_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_qualitycontrollevel ALTER COLUMN id SET DEFAULT nextval('ref_ts_qualitycontrollevel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_referenceurl ALTER COLUMN id SET DEFAULT nextval('ref_ts_referenceurl_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_site ALTER COLUMN id SET DEFAULT nextval('ref_ts_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_variable ALTER COLUMN id SET DEFAULT nextval('ref_ts_variable_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule ALTER COLUMN id SET DEFAULT nextval('robots_rule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_allowed ALTER COLUMN id SET DEFAULT nextval('robots_rule_allowed_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_disallowed ALTER COLUMN id SET DEFAULT nextval('robots_rule_disallowed_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_sites ALTER COLUMN id SET DEFAULT nextval('robots_rule_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_url ALTER COLUMN id SET DEFAULT nextval('robots_url_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY security_cspreport ALTER COLUMN id SET DEFAULT nextval('security_cspreport_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY security_passwordexpiry ALTER COLUMN id SET DEFAULT nextval('security_passwordexpiry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_iconbox ALTER COLUMN id SET DEFAULT nextval('theme_iconbox_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_quotamessage ALTER COLUMN id SET DEFAULT nextval('theme_quotamessage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_siteconfiguration ALTER COLUMN id SET DEFAULT nextval('theme_siteconfiguration_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_userprofile ALTER COLUMN id SET DEFAULT nextval('theme_userprofile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_userquota ALTER COLUMN id SET DEFAULT nextval('theme_userquota_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_group (id, name) FROM stdin;
1	Resource Author
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
2749	1	139
2750	1	140
2751	1	141
2752	1	142
2753	1	143
2754	1	144
2755	1	145
2756	1	146
2757	1	147
2758	1	148
2759	1	149
2760	1	150
2761	1	151
2762	1	152
2763	1	153
2764	1	154
2765	1	155
2766	1	156
2767	1	157
2768	1	158
2769	1	159
2770	1	160
2771	1	161
2772	1	162
2773	1	163
2774	1	164
2775	1	165
2776	1	166
2777	1	167
2778	1	168
2779	1	169
2780	1	170
2781	1	171
2782	1	172
2783	1	173
2784	1	174
2785	1	175
2786	1	176
2787	1	177
2788	1	178
2789	1	179
2790	1	180
2791	1	181
2792	1	182
2793	1	183
2794	1	184
2795	1	185
2796	1	186
2797	1	187
2798	1	188
2799	1	189
2800	1	190
2801	1	191
2802	1	192
2803	1	193
2804	1	194
2805	1	195
2806	1	196
2807	1	197
2808	1	198
2809	1	199
2810	1	200
2811	1	201
2812	1	202
2813	1	203
2814	1	204
2815	1	271
2816	1	272
2817	1	273
2818	1	274
2819	1	275
2820	1	276
2821	1	277
2822	1	278
2823	1	279
2824	1	280
2825	1	281
2826	1	282
2827	1	283
2828	1	284
2829	1	285
2830	1	313
2831	1	314
2832	1	315
2833	1	316
2834	1	317
2835	1	318
2836	1	319
2837	1	320
2838	1	321
2839	1	322
2840	1	323
2841	1	324
2842	1	325
2843	1	326
2844	1	327
2845	1	328
2846	1	329
2847	1	330
2848	1	331
2849	1	332
2850	1	333
2851	1	334
2852	1	335
2853	1	336
2854	1	337
2855	1	338
2856	1	339
2857	1	340
2858	1	341
2859	1	342
2860	1	343
2861	1	344
2862	1	345
2863	1	346
2864	1	347
2865	1	348
2866	1	349
2867	1	350
2868	1	351
2869	1	352
2870	1	353
2871	1	354
2872	1	355
2873	1	356
2874	1	357
2875	1	358
2876	1	359
2877	1	360
2878	1	361
2879	1	362
2880	1	363
2881	1	364
2882	1	365
2883	1	366
2884	1	367
2885	1	368
2886	1	369
2887	1	370
2888	1	371
2889	1	372
2890	1	373
2891	1	374
2892	1	375
2893	1	376
2894	1	377
2895	1	378
2896	1	379
2897	1	380
2898	1	381
2899	1	382
2900	1	383
2901	1	384
2902	1	385
2903	1	386
2904	1	387
2905	1	388
2906	1	389
2907	1	390
2908	1	391
2909	1	392
2910	1	393
2911	1	394
2912	1	395
2913	1	396
2914	1	397
2915	1	398
2916	1	399
2917	1	400
2918	1	401
2919	1	402
2920	1	403
2921	1	404
2922	1	405
2923	1	406
2924	1	407
2925	1	408
2926	1	409
2927	1	410
2928	1	411
2929	1	412
2930	1	413
2931	1	414
2932	1	415
2933	1	416
2934	1	417
2935	1	418
2936	1	419
2937	1	420
2938	1	421
2939	1	422
2940	1	423
2941	1	424
2942	1	425
2943	1	426
2944	1	427
2945	1	428
2946	1	429
2947	1	430
2948	1	431
2949	1	432
2950	1	433
2951	1	434
2952	1	435
2953	1	436
2954	1	437
2955	1	438
2956	1	439
2957	1	440
2958	1	441
2959	1	442
2960	1	443
2961	1	444
2962	1	445
2963	1	446
2964	1	447
2965	1	448
2966	1	449
2967	1	450
2968	1	451
2969	1	452
2970	1	453
2971	1	454
2972	1	455
2973	1	456
2974	1	457
2975	1	458
2976	1	459
2977	1	460
2978	1	461
2979	1	462
2980	1	463
2981	1	464
2982	1	465
2983	1	476
2984	1	477
2985	1	478
2986	1	479
2987	1	480
2988	1	481
2989	1	482
2990	1	483
2991	1	484
2992	1	485
2993	1	486
2994	1	487
2995	1	488
2996	1	489
2997	1	490
2998	1	491
2999	1	492
3000	1	493
3001	1	494
3002	1	495
3003	1	496
3004	1	497
3005	1	498
3006	1	499
3007	1	500
3008	1	501
3009	1	502
3010	1	503
3011	1	504
3012	1	505
3013	1	506
3014	1	507
3015	1	508
3016	1	509
3017	1	510
3018	1	511
3019	1	512
3020	1	513
3021	1	514
3022	1	522
3023	1	523
3024	1	524
3025	1	528
3026	1	529
3027	1	530
3028	1	531
3029	1	532
3030	1	533
3031	1	543
3032	1	544
3033	1	545
3034	1	552
3035	1	553
3036	1	554
3037	1	555
3038	1	556
3039	1	557
3040	1	558
3041	1	559
3042	1	560
3043	1	561
3044	1	562
3045	1	563
3046	1	564
3047	1	565
3048	1	566
3049	1	567
3050	1	568
3051	1	569
3052	1	570
3053	1	571
3054	1	572
3055	1	573
3056	1	574
3057	1	575
3058	1	576
3059	1	577
3060	1	578
3061	1	579
3062	1	580
3063	1	581
3064	1	582
3065	1	583
3066	1	584
3067	1	585
3068	1	586
3069	1	587
3070	1	588
3071	1	589
3072	1	590
3073	1	591
3074	1	592
3075	1	593
3076	1	594
3077	1	595
3078	1	596
3079	1	597
3080	1	598
3081	1	599
3082	1	600
3083	1	601
3084	1	602
3085	1	603
3086	1	604
3087	1	605
3088	1	606
3089	1	607
3090	1	608
3091	1	609
3092	1	610
3093	1	611
3094	1	612
3095	1	613
3096	1	614
3097	1	615
3098	1	616
3099	1	617
3100	1	618
3101	1	619
3102	1	620
3103	1	621
3104	1	622
3105	1	623
3106	1	624
3107	1	625
3108	1	626
3109	1	627
3110	1	628
3111	1	629
3112	1	630
3113	1	631
3114	1	632
3115	1	633
3116	1	634
3117	1	635
3118	1	636
3119	1	637
3120	1	638
3121	1	639
3122	1	640
3123	1	641
3124	1	642
3125	1	643
3126	1	644
3127	1	645
3128	1	646
3129	1	647
3130	1	648
3131	1	649
3132	1	650
3133	1	651
3134	1	652
3135	1	653
3136	1	654
3137	1	655
3138	1	656
3139	1	657
3140	1	658
3141	1	659
3142	1	660
3143	1	661
3144	1	662
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 3144, true);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add application	4	add_application
11	Can change application	4	change_application
12	Can delete application	4	delete_application
13	Can add grant	5	add_grant
14	Can change grant	5	change_grant
15	Can delete grant	5	delete_grant
16	Can add access token	6	add_accesstoken
17	Can change access token	6	change_accesstoken
18	Can delete access token	6	delete_accesstoken
19	Can add refresh token	7	add_refreshtoken
20	Can change refresh token	7	change_refreshtoken
21	Can delete refresh token	7	delete_refreshtoken
22	Can add cors model	8	add_corsmodel
23	Can change cors model	8	change_corsmodel
24	Can delete cors model	8	delete_corsmodel
25	Can add content type	9	add_contenttype
26	Can change content type	9	change_contenttype
27	Can delete content type	9	delete_contenttype
28	Can add redirect	10	add_redirect
29	Can change redirect	10	change_redirect
30	Can delete redirect	10	delete_redirect
31	Can add session	11	add_session
32	Can change session	11	change_session
33	Can delete session	11	delete_session
34	Can add site	12	add_site
35	Can change site	12	change_site
36	Can delete site	12	delete_site
37	Can add post gis geometry columns	13	add_postgisgeometrycolumns
38	Can change post gis geometry columns	13	change_postgisgeometrycolumns
39	Can delete post gis geometry columns	13	delete_postgisgeometrycolumns
40	Can add post gis spatial ref sys	14	add_postgisspatialrefsys
41	Can change post gis spatial ref sys	14	change_postgisspatialrefsys
42	Can delete post gis spatial ref sys	14	delete_postgisspatialrefsys
43	Can add iRODS Environment	15	add_rodsenvironment
44	Can change iRODS Environment	15	change_rodsenvironment
45	Can delete iRODS Environment	15	delete_rodsenvironment
46	Can add Site Configuration	16	add_siteconfiguration
47	Can change Site Configuration	16	change_siteconfiguration
48	Can delete Site Configuration	16	delete_siteconfiguration
49	Can add Home page	17	add_homepage
50	Can change Home page	17	change_homepage
51	Can delete Home page	17	delete_homepage
52	Can add icon box	18	add_iconbox
53	Can change icon box	18	change_iconbox
54	Can delete icon box	18	delete_iconbox
55	Can add user profile	19	add_userprofile
56	Can change user profile	19	change_userprofile
57	Can delete user profile	19	delete_userprofile
58	Can add Setting	20	add_setting
59	Can change Setting	20	change_setting
60	Can delete Setting	20	delete_setting
61	Can add Site permission	21	add_sitepermission
62	Can change Site permission	21	change_sitepermission
63	Can delete Site permission	21	delete_sitepermission
64	Can add Comment	22	add_threadedcomment
65	Can change Comment	22	change_threadedcomment
66	Can delete Comment	22	delete_threadedcomment
67	Can add Keyword	23	add_keyword
68	Can change Keyword	23	change_keyword
69	Can delete Keyword	23	delete_keyword
70	Can add assigned keyword	24	add_assignedkeyword
71	Can change assigned keyword	24	change_assignedkeyword
72	Can delete assigned keyword	24	delete_assignedkeyword
73	Can add Rating	25	add_rating
74	Can change Rating	25	change_rating
75	Can delete Rating	25	delete_rating
76	Can add Blog post	26	add_blogpost
77	Can change Blog post	26	change_blogpost
78	Can delete Blog post	26	delete_blogpost
79	Can add Blog Category	27	add_blogcategory
80	Can change Blog Category	27	change_blogcategory
81	Can delete Blog Category	27	delete_blogcategory
82	Can add Form	28	add_form
83	Can change Form	28	change_form
84	Can delete Form	28	delete_form
85	Can add Field	29	add_field
86	Can change Field	29	change_field
87	Can delete Field	29	delete_field
88	Can add Form entry	30	add_formentry
89	Can change Form entry	30	change_formentry
90	Can delete Form entry	30	delete_formentry
91	Can add Form field entry	31	add_fieldentry
92	Can change Form field entry	31	change_fieldentry
93	Can delete Form field entry	31	delete_fieldentry
94	Can add Page	32	add_page
95	Can change Page	32	change_page
96	Can delete Page	32	delete_page
97	Can add Rich text page	33	add_richtextpage
98	Can change Rich text page	33	change_richtextpage
99	Can delete Rich text page	33	delete_richtextpage
100	Can add Link	34	add_link
101	Can change Link	34	change_link
102	Can delete Link	34	delete_link
103	Can add Gallery	35	add_gallery
104	Can change Gallery	35	change_gallery
105	Can delete Gallery	35	delete_gallery
106	Can add Image	36	add_galleryimage
107	Can change Image	36	change_galleryimage
108	Can delete Image	36	delete_galleryimage
109	Can add ogr dataset collection	37	add_ogrdatasetcollection
110	Can change ogr dataset collection	37	change_ogrdatasetcollection
111	Can delete ogr dataset collection	37	delete_ogrdatasetcollection
112	Can add ogr dataset	38	add_ogrdataset
113	Can change ogr dataset	38	change_ogrdataset
114	Can delete ogr dataset	38	delete_ogrdataset
115	Can add ogr layer	39	add_ogrlayer
116	Can change ogr layer	39	change_ogrlayer
117	Can delete ogr layer	39	delete_ogrlayer
118	Can add catalog page	40	add_catalogpage
119	Can change catalog page	40	change_catalogpage
120	Can delete catalog page	40	delete_catalogpage
121	Can add data resource	41	add_dataresource
122	Can change data resource	41	change_dataresource
123	Can delete data resource	41	delete_dataresource
124	Can add ordered resource	42	add_orderedresource
125	Can change ordered resource	42	change_orderedresource
126	Can delete ordered resource	42	delete_orderedresource
127	Can add resource group	43	add_resourcegroup
128	Can change resource group	43	change_resourcegroup
129	Can delete resource group	43	delete_resourcegroup
130	Can add related resource	44	add_relatedresource
131	Can change related resource	44	change_relatedresource
132	Can delete related resource	44	delete_relatedresource
133	Can add style	45	add_style
134	Can change style	45	change_style
135	Can delete style	45	delete_style
136	Can add rendered layer	46	add_renderedlayer
137	Can change rendered layer	46	change_renderedlayer
138	Can delete rendered layer	46	delete_renderedlayer
139	Can add group ownership	47	add_groupownership
140	Can change group ownership	47	change_groupownership
141	Can delete group ownership	47	delete_groupownership
142	Can add external profile link	48	add_externalprofilelink
143	Can change external profile link	48	change_externalprofilelink
144	Can delete external profile link	48	delete_externalprofilelink
145	Can add contributor	49	add_contributor
146	Can change contributor	49	change_contributor
147	Can delete contributor	49	delete_contributor
148	Can add creator	50	add_creator
149	Can change creator	50	change_creator
150	Can delete creator	50	delete_creator
151	Can add description	51	add_description
152	Can change description	51	change_description
153	Can delete description	51	delete_description
154	Can add title	52	add_title
155	Can change title	52	change_title
156	Can delete title	52	delete_title
157	Can add type	53	add_type
158	Can change type	53	change_type
159	Can delete type	53	delete_type
160	Can add date	54	add_date
161	Can change date	54	change_date
162	Can delete date	54	delete_date
163	Can add relation	55	add_relation
164	Can change relation	55	change_relation
165	Can delete relation	55	delete_relation
166	Can add identifier	56	add_identifier
167	Can change identifier	56	change_identifier
168	Can delete identifier	56	delete_identifier
169	Can add publisher	57	add_publisher
170	Can change publisher	57	change_publisher
171	Can delete publisher	57	delete_publisher
172	Can add language	58	add_language
173	Can change language	58	change_language
174	Can delete language	58	delete_language
175	Can add coverage	59	add_coverage
176	Can change coverage	59	change_coverage
177	Can delete coverage	59	delete_coverage
178	Can add format	60	add_format
179	Can change format	60	change_format
180	Can delete format	60	delete_format
181	Can add subject	61	add_subject
182	Can change subject	61	change_subject
183	Can delete subject	61	delete_subject
184	Can add source	62	add_source
185	Can change source	62	change_source
186	Can delete source	62	delete_source
187	Can add rights	63	add_rights
188	Can change rights	63	change_rights
189	Can delete rights	63	delete_rights
190	Can add resource file	64	add_resourcefile
191	Can change resource file	64	change_resourcefile
192	Can delete resource file	64	delete_resourcefile
193	Can add bags	65	add_bags
194	Can change bags	65	change_bags
195	Can delete bags	65	delete_bags
196	Can add Generic	66	add_baseresource
197	Can change Generic	66	change_baseresource
198	Can delete Generic	66	delete_baseresource
199	Can add Generic	67	add_genericresource
200	Can change Generic	67	change_genericresource
201	Can delete Generic	67	delete_genericresource
202	Can add core meta data	68	add_coremetadata
203	Can change core meta data	68	change_coremetadata
204	Can delete core meta data	68	delete_coremetadata
205	Can add user group privilege	69	add_usergroupprivilege
206	Can change user group privilege	69	change_usergroupprivilege
207	Can delete user group privilege	69	delete_usergroupprivilege
208	Can add user resource privilege	70	add_userresourceprivilege
209	Can change user resource privilege	70	change_userresourceprivilege
210	Can delete user resource privilege	70	delete_userresourceprivilege
211	Can add group resource privilege	71	add_groupresourceprivilege
212	Can change group resource privilege	71	change_groupresourceprivilege
213	Can delete group resource privilege	71	delete_groupresourceprivilege
214	Can add user access	72	add_useraccess
215	Can change user access	72	change_useraccess
216	Can delete user access	72	delete_useraccess
217	Can add group access	73	add_groupaccess
218	Can change group access	73	change_groupaccess
219	Can delete group access	73	delete_groupaccess
220	Can add resource access	74	add_resourceaccess
221	Can change resource access	74	change_resourceaccess
222	Can delete resource access	74	delete_resourceaccess
223	Can add user resource labels	75	add_userresourcelabels
224	Can change user resource labels	75	change_userresourcelabels
225	Can delete user resource labels	75	delete_userresourcelabels
226	Can add user resource flags	76	add_userresourceflags
227	Can change user resource flags	76	change_userresourceflags
228	Can delete user resource flags	76	delete_userresourceflags
229	Can add user stored labels	77	add_userstoredlabels
230	Can change user stored labels	77	change_userstoredlabels
231	Can delete user stored labels	77	delete_userstoredlabels
232	Can add user labels	78	add_userlabels
233	Can change user labels	78	change_userlabels
234	Can delete user labels	78	delete_userlabels
235	Can add resource labels	79	add_resourcelabels
236	Can change resource labels	79	change_resourcelabels
237	Can delete resource labels	79	delete_resourcelabels
238	Can add docker profile	80	add_dockerprofile
239	Can change docker profile	80	change_dockerprofile
240	Can delete docker profile	80	delete_dockerprofile
241	Can add container overrides	81	add_containeroverrides
242	Can change container overrides	81	change_containeroverrides
243	Can delete container overrides	81	delete_containeroverrides
244	Can add override env var	82	add_overrideenvvar
245	Can change override env var	82	change_overrideenvvar
246	Can delete override env var	82	delete_overrideenvvar
247	Can add override volume	83	add_overridevolume
248	Can change override volume	83	change_overridevolume
249	Can delete override volume	83	delete_overridevolume
250	Can add override link	84	add_overridelink
251	Can change override link	84	change_overridelink
252	Can delete override link	84	delete_overridelink
253	Can add override port	85	add_overrideport
254	Can change override port	85	change_overrideport
255	Can delete override port	85	delete_overrideport
256	Can add docker link	86	add_dockerlink
257	Can change docker link	86	change_dockerlink
258	Can delete docker link	86	delete_dockerlink
259	Can add docker env var	87	add_dockerenvvar
260	Can change docker env var	87	change_dockerenvvar
261	Can delete docker env var	87	delete_dockerenvvar
262	Can add docker volume	88	add_dockervolume
263	Can change docker volume	88	change_dockervolume
264	Can delete docker volume	88	delete_dockervolume
265	Can add docker port	89	add_dockerport
266	Can change docker port	89	change_dockerport
267	Can delete docker port	89	delete_dockerport
268	Can add docker process	90	add_dockerprocess
269	Can change docker process	90	change_dockerprocess
270	Can delete docker process	90	delete_dockerprocess
271	Can add original coverage	91	add_originalcoverage
272	Can change original coverage	91	change_originalcoverage
273	Can delete original coverage	91	delete_originalcoverage
274	Can add band information	92	add_bandinformation
275	Can change band information	92	change_bandinformation
276	Can delete band information	92	delete_bandinformation
277	Can add cell information	93	add_cellinformation
278	Can change cell information	93	change_cellinformation
279	Can delete cell information	93	delete_cellinformation
280	Can add Geographic Raster	94	add_rasterresource
281	Can change Geographic Raster	94	change_rasterresource
282	Can delete Geographic Raster	94	delete_rasterresource
283	Can add raster meta data	95	add_rastermetadata
284	Can change raster meta data	95	change_rastermetadata
285	Can delete raster meta data	95	delete_rastermetadata
286	Can add task state	96	add_taskmeta
287	Can change task state	96	change_taskmeta
288	Can delete task state	96	delete_taskmeta
289	Can add saved group result	97	add_tasksetmeta
290	Can change saved group result	97	change_tasksetmeta
291	Can delete saved group result	97	delete_tasksetmeta
292	Can add interval	98	add_intervalschedule
293	Can change interval	98	change_intervalschedule
294	Can delete interval	98	delete_intervalschedule
295	Can add crontab	99	add_crontabschedule
296	Can change crontab	99	change_crontabschedule
297	Can delete crontab	99	delete_crontabschedule
298	Can add periodic tasks	100	add_periodictasks
299	Can change periodic tasks	100	change_periodictasks
300	Can delete periodic tasks	100	delete_periodictasks
301	Can add periodic task	101	add_periodictask
302	Can change periodic task	101	change_periodictask
303	Can delete periodic task	101	delete_periodictask
304	Can add worker	102	add_workerstate
305	Can change worker	102	change_workerstate
306	Can delete worker	102	delete_workerstate
307	Can add task	103	add_taskstate
308	Can change task	103	change_taskstate
309	Can delete task	103	delete_taskstate
313	Can add reference url	105	add_referenceurl
314	Can change reference url	105	change_referenceurl
315	Can delete reference url	105	delete_referenceurl
316	Can add method	106	add_method
317	Can change method	106	change_method
318	Can delete method	106	delete_method
319	Can add quality control level	107	add_qualitycontrollevel
320	Can change quality control level	107	change_qualitycontrollevel
321	Can delete quality control level	107	delete_qualitycontrollevel
322	Can add variable	108	add_variable
323	Can change variable	108	change_variable
324	Can delete variable	108	delete_variable
325	Can add site	109	add_site
326	Can change site	109	change_site
327	Can delete site	109	delete_site
328	Can add ref ts metadata	110	add_reftsmetadata
329	Can change ref ts metadata	110	change_reftsmetadata
330	Can delete ref ts metadata	110	delete_reftsmetadata
331	Can add site	111	add_site
332	Can change site	111	change_site
333	Can delete site	111	delete_site
334	Can add variable	112	add_variable
335	Can change variable	112	change_variable
336	Can delete variable	112	delete_variable
337	Can add method	113	add_method
338	Can change method	113	change_method
339	Can delete method	113	delete_method
340	Can add processing level	114	add_processinglevel
341	Can change processing level	114	change_processinglevel
342	Can delete processing level	114	delete_processinglevel
343	Can add time series result	115	add_timeseriesresult
344	Can change time series result	115	change_timeseriesresult
345	Can delete time series result	115	delete_timeseriesresult
346	Can add Time Series	116	add_timeseriesresource
347	Can change Time Series	116	change_timeseriesresource
348	Can delete Time Series	116	delete_timeseriesresource
349	Can add time series meta data	117	add_timeseriesmetadata
350	Can change time series meta data	117	change_timeseriesmetadata
351	Can delete time series meta data	117	delete_timeseriesmetadata
352	Can add original coverage	118	add_originalcoverage
353	Can change original coverage	118	change_originalcoverage
354	Can delete original coverage	118	delete_originalcoverage
355	Can add variable	119	add_variable
356	Can change variable	119	change_variable
357	Can delete variable	119	delete_variable
358	Can add Multidimensional (NetCDF)	120	add_netcdfresource
359	Can change Multidimensional (NetCDF)	120	change_netcdfresource
360	Can delete Multidimensional (NetCDF)	120	delete_netcdfresource
361	Can add netcdf meta data	121	add_netcdfmetadata
362	Can change netcdf meta data	121	change_netcdfmetadata
363	Can delete netcdf meta data	121	delete_netcdfmetadata
364	Can add mp metadata	122	add_mpmetadata
365	Can change mp metadata	122	change_mpmetadata
366	Can delete mp metadata	122	delete_mpmetadata
367	Can add Model Program Resource	123	add_modelprogramresource
368	Can change Model Program Resource	123	change_modelprogramresource
369	Can delete Model Program Resource	123	delete_modelprogramresource
370	Can add model program meta data	124	add_modelprogrammetadata
371	Can change model program meta data	124	change_modelprogrammetadata
372	Can delete model program meta data	124	delete_modelprogrammetadata
373	Can add model output	125	add_modeloutput
374	Can change model output	125	change_modeloutput
375	Can delete model output	125	delete_modeloutput
376	Can add executed by	126	add_executedby
377	Can change executed by	126	change_executedby
378	Can delete executed by	126	delete_executedby
379	Can add Model Instance Resource	127	add_modelinstanceresource
380	Can change Model Instance Resource	127	change_modelinstanceresource
381	Can delete Model Instance Resource	127	delete_modelinstanceresource
382	Can add model instance meta data	128	add_modelinstancemetadata
383	Can change model instance meta data	128	change_modelinstancemetadata
384	Can delete model instance meta data	128	delete_modelinstancemetadata
385	Can add Web App Resource	129	add_toolresource
386	Can change Web App Resource	129	change_toolresource
387	Can delete Web App Resource	129	delete_toolresource
388	Can add request url base	130	add_requesturlbase
389	Can change request url base	130	change_requesturlbase
390	Can delete request url base	130	delete_requesturlbase
391	Can add tool version	131	add_toolversion
392	Can change tool version	131	change_toolversion
393	Can delete tool version	131	delete_toolversion
394	Can add supported res type choices	132	add_supportedrestypechoices
395	Can change supported res type choices	132	change_supportedrestypechoices
396	Can delete supported res type choices	132	delete_supportedrestypechoices
397	Can add supported res types	133	add_supportedrestypes
398	Can change supported res types	133	change_supportedrestypes
399	Can delete supported res types	133	delete_supportedrestypes
400	Can add tool icon	134	add_toolicon
401	Can change tool icon	134	change_toolicon
402	Can delete tool icon	134	delete_toolicon
403	Can add tool meta data	135	add_toolmetadata
404	Can change tool meta data	135	change_toolmetadata
405	Can delete tool meta data	135	delete_toolmetadata
406	Can add model output	136	add_modeloutput
407	Can change model output	136	change_modeloutput
408	Can delete model output	136	delete_modeloutput
409	Can add executed by	137	add_executedby
410	Can change executed by	137	change_executedby
411	Can delete executed by	137	delete_executedby
412	Can add model objective choices	138	add_modelobjectivechoices
413	Can change model objective choices	138	change_modelobjectivechoices
414	Can delete model objective choices	138	delete_modelobjectivechoices
415	Can add model objective	139	add_modelobjective
416	Can change model objective	139	change_modelobjective
417	Can delete model objective	139	delete_modelobjective
418	Can add simulation type	140	add_simulationtype
419	Can change simulation type	140	change_simulationtype
420	Can delete simulation type	140	delete_simulationtype
421	Can add model method	141	add_modelmethod
422	Can change model method	141	change_modelmethod
423	Can delete model method	141	delete_modelmethod
424	Can add model parameters choices	142	add_modelparameterschoices
425	Can change model parameters choices	142	change_modelparameterschoices
426	Can delete model parameters choices	142	delete_modelparameterschoices
427	Can add model parameter	143	add_modelparameter
428	Can change model parameter	143	change_modelparameter
429	Can delete model parameter	143	delete_modelparameter
430	Can add model input	144	add_modelinput
431	Can change model input	144	change_modelinput
432	Can delete model input	144	delete_modelinput
433	Can add SWAT Model Instance Resource	145	add_swatmodelinstanceresource
434	Can change SWAT Model Instance Resource	145	change_swatmodelinstanceresource
435	Can delete SWAT Model Instance Resource	145	delete_swatmodelinstanceresource
436	Can add swat model instance meta data	146	add_swatmodelinstancemetadata
437	Can change swat model instance meta data	146	change_swatmodelinstancemetadata
438	Can delete swat model instance meta data	146	delete_swatmodelinstancemetadata
439	Can add original file info	147	add_originalfileinfo
440	Can change original file info	147	change_originalfileinfo
441	Can delete original file info	147	delete_originalfileinfo
442	Can add original coverage	148	add_originalcoverage
443	Can change original coverage	148	change_originalcoverage
444	Can delete original coverage	148	delete_originalcoverage
445	Can add field information	149	add_fieldinformation
446	Can change field information	149	change_fieldinformation
447	Can delete field information	149	delete_fieldinformation
448	Can add geometry information	150	add_geometryinformation
449	Can change geometry information	150	change_geometryinformation
450	Can delete geometry information	150	delete_geometryinformation
451	Can add Geographic Feature (ESRI Shapefiles)	151	add_geographicfeatureresource
452	Can change Geographic Feature (ESRI Shapefiles)	151	change_geographicfeatureresource
453	Can delete Geographic Feature (ESRI Shapefiles)	151	delete_geographicfeatureresource
454	Can add geographic feature meta data	152	add_geographicfeaturemetadata
455	Can change geographic feature meta data	152	change_geographicfeaturemetadata
456	Can delete geographic feature meta data	152	delete_geographicfeaturemetadata
457	Can add Script Resource	153	add_scriptresource
458	Can change Script Resource	153	change_scriptresource
459	Can delete Script Resource	153	delete_scriptresource
460	Can add script specific metadata	154	add_scriptspecificmetadata
461	Can change script specific metadata	154	change_scriptspecificmetadata
462	Can delete script specific metadata	154	delete_scriptspecificmetadata
463	Can add script meta data	155	add_scriptmetadata
464	Can change script meta data	155	change_scriptmetadata
465	Can delete script meta data	155	delete_scriptmetadata
466	Can add log entry	156	add_logentry
467	Can change log entry	156	change_logentry
468	Can delete log entry	156	delete_logentry
469	Can add comment	157	add_comment
470	Can change comment	157	change_comment
471	Can delete comment	157	delete_comment
472	Can moderate comments	157	can_moderate
473	Can add comment flag	158	add_commentflag
474	Can change comment flag	158	change_commentflag
475	Can delete comment flag	158	delete_commentflag
476	Can add Generic	66	add_genericresource
477	Can change Generic	66	change_genericresource
478	Can delete Generic	66	delete_genericresource
479	Can add Geographic Raster	66	add_rasterresource
480	Can change Geographic Raster	66	change_rasterresource
481	Can delete Geographic Raster	66	delete_rasterresource
482	Can add HIS Referenced Time Series	66	add_reftimeseriesresource
483	Can change HIS Referenced Time Series	66	change_reftimeseriesresource
484	Can delete HIS Referenced Time Series	66	delete_reftimeseriesresource
485	Can add data source	159	add_datasource
486	Can change data source	159	change_datasource
487	Can delete data source	159	delete_datasource
488	Can add Time Series	66	add_timeseriesresource
489	Can change Time Series	66	change_timeseriesresource
490	Can delete Time Series	66	delete_timeseriesresource
491	Can add Multidimensional (NetCDF)	66	add_netcdfresource
492	Can change Multidimensional (NetCDF)	66	change_netcdfresource
493	Can delete Multidimensional (NetCDF)	66	delete_netcdfresource
494	Can add Model Program Resource	66	add_modelprogramresource
495	Can change Model Program Resource	66	change_modelprogramresource
496	Can delete Model Program Resource	66	delete_modelprogramresource
497	Can add Model Instance Resource	66	add_modelinstanceresource
498	Can change Model Instance Resource	66	change_modelinstanceresource
499	Can delete Model Instance Resource	66	delete_modelinstanceresource
500	Can add Web App Resource	66	add_toolresource
501	Can change Web App Resource	66	change_toolresource
502	Can delete Web App Resource	66	delete_toolresource
503	Can add SWAT Model Instance Resource	66	add_swatmodelinstanceresource
504	Can change SWAT Model Instance Resource	66	change_swatmodelinstanceresource
505	Can delete SWAT Model Instance Resource	66	delete_swatmodelinstanceresource
506	Can add Geographic Feature (ESRI Shapefiles)	66	add_geographicfeatureresource
507	Can change Geographic Feature (ESRI Shapefiles)	66	change_geographicfeatureresource
508	Can delete Geographic Feature (ESRI Shapefiles)	66	delete_geographicfeatureresource
509	Can add Script Resource	66	add_scriptresource
510	Can change Script Resource	66	change_scriptresource
511	Can delete Script Resource	66	delete_scriptresource
512	Can add HIS Referenced Time Series	160	add_reftimeseriesresource
513	Can change HIS Referenced Time Series	160	change_reftimeseriesresource
514	Can delete HIS Referenced Time Series	160	delete_reftimeseriesresource
515	Can add comment	161	add_comment
516	Can change comment	161	change_comment
517	Can delete comment	161	delete_comment
518	Can moderate comments	161	can_moderate
519	Can add comment flag	162	add_commentflag
520	Can change comment flag	162	change_commentflag
521	Can delete comment flag	162	delete_commentflag
522	Can add funding agency	163	add_fundingagency
523	Can change funding agency	163	change_fundingagency
524	Can delete funding agency	163	delete_fundingagency
525	Can add group membership request	164	add_groupmembershiprequest
526	Can change group membership request	164	change_groupmembershiprequest
527	Can delete group membership request	164	delete_groupmembershiprequest
528	Can add Collection Resource	66	add_collectionresource
529	Can change Collection Resource	66	change_collectionresource
530	Can delete Collection Resource	66	delete_collectionresource
531	Can add collection deleted resource	165	add_collectiondeletedresource
532	Can change collection deleted resource	165	change_collectiondeletedresource
533	Can delete collection deleted resource	165	delete_collectiondeletedresource
534	Can add visitor	167	add_visitor
535	Can change visitor	167	change_visitor
536	Can delete visitor	167	delete_visitor
537	Can add session	168	add_session
538	Can change session	168	change_session
539	Can delete session	168	delete_session
540	Can add variable	169	add_variable
541	Can change variable	169	change_variable
542	Can delete variable	169	delete_variable
543	Can add Collection Resource	166	add_collectionresource
544	Can change Collection Resource	166	change_collectionresource
545	Can delete Collection Resource	166	delete_collectionresource
546	Can add url	170	add_url
547	Can change url	170	change_url
548	Can delete url	170	delete_url
549	Can add rule	171	add_rule
550	Can change rule	171	change_rule
551	Can delete rule	171	delete_rule
552	Can add utc off set	172	add_utcoffset
553	Can change utc off set	172	change_utcoffset
554	Can delete utc off set	172	delete_utcoffset
555	Can add cv variable type	173	add_cvvariabletype
556	Can change cv variable type	173	change_cvvariabletype
557	Can delete cv variable type	173	delete_cvvariabletype
558	Can add cv variable name	174	add_cvvariablename
559	Can change cv variable name	174	change_cvvariablename
560	Can delete cv variable name	174	delete_cvvariablename
561	Can add cv speciation	175	add_cvspeciation
562	Can change cv speciation	175	change_cvspeciation
563	Can delete cv speciation	175	delete_cvspeciation
564	Can add cv elevation datum	176	add_cvelevationdatum
565	Can change cv elevation datum	176	change_cvelevationdatum
566	Can delete cv elevation datum	176	delete_cvelevationdatum
567	Can add cv site type	177	add_cvsitetype
568	Can change cv site type	177	change_cvsitetype
569	Can delete cv site type	177	delete_cvsitetype
570	Can add cv method type	178	add_cvmethodtype
571	Can change cv method type	178	change_cvmethodtype
572	Can delete cv method type	178	delete_cvmethodtype
573	Can add cv units type	179	add_cvunitstype
574	Can change cv units type	179	change_cvunitstype
575	Can delete cv units type	179	delete_cvunitstype
576	Can add cv status	180	add_cvstatus
577	Can change cv status	180	change_cvstatus
578	Can delete cv status	180	delete_cvstatus
579	Can add cv medium	181	add_cvmedium
580	Can change cv medium	181	change_cvmedium
581	Can delete cv medium	181	delete_cvmedium
582	Can add cv aggregation statistic	182	add_cvaggregationstatistic
583	Can change cv aggregation statistic	182	change_cvaggregationstatistic
584	Can delete cv aggregation statistic	182	delete_cvaggregationstatistic
585	Can add app home page url	183	add_apphomepageurl
586	Can change app home page url	183	change_apphomepageurl
587	Can delete app home page url	183	delete_apphomepageurl
588	Can add supported sharing status choices	184	add_supportedsharingstatuschoices
589	Can change supported sharing status choices	184	change_supportedsharingstatuschoices
590	Can delete supported sharing status choices	184	delete_supportedsharingstatuschoices
591	Can add supported sharing status	185	add_supportedsharingstatus
592	Can change supported sharing status	185	change_supportedsharingstatus
593	Can delete supported sharing status	185	delete_supportedsharingstatus
594	Can add study area	186	add_studyarea
595	Can change study area	186	change_studyarea
596	Can delete study area	186	delete_studyarea
597	Can add grid dimensions	187	add_griddimensions
598	Can change grid dimensions	187	change_griddimensions
599	Can delete grid dimensions	187	delete_griddimensions
600	Can add stress period	188	add_stressperiod
601	Can change stress period	188	change_stressperiod
602	Can delete stress period	188	delete_stressperiod
603	Can add ground water flow	189	add_groundwaterflow
604	Can change ground water flow	189	change_groundwaterflow
605	Can delete ground water flow	189	delete_groundwaterflow
606	Can add specified head boundary package choices	190	add_specifiedheadboundarypackagechoices
607	Can change specified head boundary package choices	190	change_specifiedheadboundarypackagechoices
608	Can delete specified head boundary package choices	190	delete_specifiedheadboundarypackagechoices
609	Can add specified flux boundary package choices	191	add_specifiedfluxboundarypackagechoices
610	Can change specified flux boundary package choices	191	change_specifiedfluxboundarypackagechoices
611	Can delete specified flux boundary package choices	191	delete_specifiedfluxboundarypackagechoices
612	Can add head dependent flux boundary package choices	192	add_headdependentfluxboundarypackagechoices
613	Can change head dependent flux boundary package choices	192	change_headdependentfluxboundarypackagechoices
614	Can delete head dependent flux boundary package choices	192	delete_headdependentfluxboundarypackagechoices
615	Can add boundary condition	193	add_boundarycondition
616	Can change boundary condition	193	change_boundarycondition
617	Can delete boundary condition	193	delete_boundarycondition
618	Can add model calibration	194	add_modelcalibration
619	Can change model calibration	194	change_modelcalibration
620	Can delete model calibration	194	delete_modelcalibration
621	Can add model input	195	add_modelinput
622	Can change model input	195	change_modelinput
623	Can delete model input	195	delete_modelinput
624	Can add output control package choices	196	add_outputcontrolpackagechoices
625	Can change output control package choices	196	change_outputcontrolpackagechoices
626	Can delete output control package choices	196	delete_outputcontrolpackagechoices
627	Can add general elements	197	add_generalelements
628	Can change general elements	197	change_generalelements
629	Can delete general elements	197	delete_generalelements
630	Can add MODFLOW Model Instance Resource	66	add_modflowmodelinstanceresource
631	Can change MODFLOW Model Instance Resource	66	change_modflowmodelinstanceresource
632	Can delete MODFLOW Model Instance Resource	66	delete_modflowmodelinstanceresource
633	Can add modflow model instance meta data	198	add_modflowmodelinstancemetadata
634	Can change modflow model instance meta data	198	change_modflowmodelinstancemetadata
635	Can delete modflow model instance meta data	198	delete_modflowmodelinstancemetadata
636	Can add generic file meta data	202	add_genericfilemetadata
637	Can change generic file meta data	202	change_genericfilemetadata
638	Can delete generic file meta data	202	delete_genericfilemetadata
639	Can add generic logical file	203	add_genericlogicalfile
640	Can change generic logical file	203	change_genericlogicalfile
641	Can delete generic logical file	203	delete_genericlogicalfile
642	Can add geo raster file meta data	204	add_georasterfilemetadata
643	Can change geo raster file meta data	204	change_georasterfilemetadata
644	Can delete geo raster file meta data	204	delete_georasterfilemetadata
645	Can add geo raster logical file	205	add_georasterlogicalfile
646	Can change geo raster logical file	205	change_georasterlogicalfile
647	Can delete geo raster logical file	205	delete_georasterlogicalfile
648	Can add Composite Resource	66	add_compositeresource
649	Can change Composite Resource	66	change_compositeresource
650	Can delete Composite Resource	66	delete_compositeresource
651	Can add model output	201	add_modeloutput
652	Can change model output	201	change_modeloutput
653	Can delete model output	201	delete_modeloutput
654	Can add executed by	200	add_executedby
655	Can change executed by	200	change_executedby
656	Can delete executed by	200	delete_executedby
657	Can add MODFLOW Model Instance Resource	199	add_modflowmodelinstanceresource
658	Can change MODFLOW Model Instance Resource	199	change_modflowmodelinstanceresource
659	Can delete MODFLOW Model Instance Resource	199	delete_modflowmodelinstanceresource
660	Can add Composite Resource	206	add_compositeresource
661	Can change Composite Resource	206	change_compositeresource
662	Can delete Composite Resource	206	delete_compositeresource
663	Can add quota message	207	add_quotamessage
664	Can change quota message	207	change_quotamessage
665	Can delete quota message	207	delete_quotamessage
666	Can add User quota	208	add_userquota
667	Can change User quota	208	change_userquota
668	Can delete User quota	208	delete_userquota
669	Can add user group provenance	209	add_usergroupprovenance
670	Can change user group provenance	209	change_usergroupprovenance
671	Can delete user group provenance	209	delete_usergroupprovenance
672	Can add user resource provenance	210	add_userresourceprovenance
673	Can change user resource provenance	210	change_userresourceprovenance
674	Can delete user resource provenance	210	delete_userresourceprovenance
675	Can add group resource provenance	211	add_groupresourceprovenance
676	Can change group resource provenance	211	change_groupresourceprovenance
677	Can delete group resource provenance	211	delete_groupresourceprovenance
678	Can add net cdf file meta data	212	add_netcdffilemetadata
679	Can change net cdf file meta data	212	change_netcdffilemetadata
680	Can delete net cdf file meta data	212	delete_netcdffilemetadata
681	Can add net cdf logical file	213	add_netcdflogicalfile
682	Can change net cdf logical file	213	change_netcdflogicalfile
683	Can delete net cdf logical file	213	delete_netcdflogicalfile
684	Can add password expiry	214	add_passwordexpiry
685	Can change password expiry	214	change_passwordexpiry
686	Can delete password expiry	214	delete_passwordexpiry
687	Can add csp report	215	add_cspreport
688	Can change csp report	215	change_cspreport
689	Can delete csp report	215	delete_cspreport
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_permission_id_seq', 689, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
4	pbkdf2_sha256$20000$9vh7DIUwZx5T$ErXP+7DbA+ywH3LDzQnaWBx09lgKh+7LJTMs/xcark8=	2017-09-07 20:02:36.12563+00	t	admin	MyHPOM	Administrator	xdci-support@renci.org	t	t	2016-01-25 19:47:54+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
5	4	1
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 7, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_id_seq', 6, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: blog_blogcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY blog_blogcategory (id, site_id, title, slug) FROM stdin;
\.


--
-- Name: blog_blogcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('blog_blogcategory_id_seq', 1, false);


--
-- Data for Name: blog_blogpost; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY blog_blogpost (id, comments_count, keywords_string, rating_count, rating_sum, rating_average, site_id, title, slug, _meta_title, description, gen_description, created, updated, status, publish_date, expiry_date, short_url, in_sitemap, content, user_id, allow_comments, featured_image) FROM stdin;
\.


--
-- Data for Name: blog_blogpost_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY blog_blogpost_categories (id, blogpost_id, blogcategory_id) FROM stdin;
\.


--
-- Name: blog_blogpost_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('blog_blogpost_categories_id_seq', 1, false);


--
-- Name: blog_blogpost_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('blog_blogpost_id_seq', 1, false);


--
-- Data for Name: blog_blogpost_related_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY blog_blogpost_related_posts (id, from_blogpost_id, to_blogpost_id) FROM stdin;
\.


--
-- Name: blog_blogpost_related_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('blog_blogpost_related_posts_id_seq', 1, false);


--
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY celery_taskmeta (id, task_id, status, result, date_done, traceback, hidden, meta) FROM stdin;
\.


--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('celery_taskmeta_id_seq', 1, false);


--
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY celery_tasksetmeta (id, taskset_id, result, date_done, hidden) FROM stdin;
\.


--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('celery_tasksetmeta_id_seq', 1, false);


--
-- Data for Name: conf_setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY conf_setting (id, site_id, name, value) FROM stdin;
\.


--
-- Name: conf_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('conf_setting_id_seq', 1, false);


--
-- Data for Name: core_sitepermission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY core_sitepermission (id, user_id) FROM stdin;
\.


--
-- Name: core_sitepermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('core_sitepermission_id_seq', 1, false);


--
-- Data for Name: core_sitepermission_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY core_sitepermission_sites (id, sitepermission_id, site_id) FROM stdin;
\.


--
-- Name: core_sitepermission_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('core_sitepermission_sites_id_seq', 1, false);


--
-- Data for Name: corsheaders_corsmodel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY corsheaders_corsmodel (id, cors) FROM stdin;
\.


--
-- Name: corsheaders_corsmodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('corsheaders_corsmodel_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
31	2016-01-25 19:51:43.038754+00	4	Discover	2	Changed _meta_title and keywords.	33	4
32	2016-01-25 19:52:16.941687+00	4	Discover	2	Changed slug and keywords.	33	4
33	2016-01-25 19:52:37.395438+00	4	Discover	2	Changed _meta_title and keywords.	33	4
34	2016-01-25 19:54:21.104577+00	2	root	3		3	4
35	2016-02-24 17:41:41.504891+00	1	Resource Author	2	Changed permissions.	2	4
36	2016-06-23 17:07:04.049586+00	13	Collaborate	1		33	4
37	2017-02-02 17:25:53.744625+00	1	Resource Author	2	Changed permissions.	2	4
38	2017-02-02 17:26:10.173151+00	1	Resource Author	2	Changed permissions.	2	4
39	2017-02-02 17:26:32.707066+00	1	Resource Author	2	Changed permissions.	2	4
40	2017-02-02 17:26:47.958444+00	1	Resource Author	2	Changed permissions.	2	4
41	2017-05-05 13:47:22.842788+00	2	Home	2	Changed heading, content, message_start_date, message_end_date, message_type, in_menus and keywords.	17	4
42	2017-05-05 13:49:03.819452+00	2	Home	2	Changed content, message_start_date, in_menus and keywords.	17	4
43	2017-05-05 13:52:11.658026+00	6	Apps	2	Changed slug.	34	4
44	2017-05-05 13:54:23.851527+00	7	Verify Account	2	Changed content, in_menus and keywords.	33	4
45	2017-05-05 14:08:48.392883+00	9	Terms of Use	2	Changed content, in_menus, description and keywords.	33	4
46	2017-05-05 14:13:10.186432+00	10	Statement of Privacy	2	Changed content, in_menus, description and keywords.	33	4
47	2017-05-05 14:16:27.533827+00	4	admin	2	Changed first_name.	3	4
48	2017-05-05 14:16:51.48684+00	1	xDCIshare Author	2	Changed name.	2	4
49	2017-05-05 14:17:42.985039+00	1	Resource Author	2	Changed name.	2	4
50	2017-05-05 14:20:45.489007+00	1	QuotaMessage object	1		207	4
51	2017-05-05 14:24:29.244065+00	1	SiteConfiguration object	2	Changed col1_content, col3_heading, col3_content, twitter_link, facebook_link, youtube_link, github_link, linkedin_link and copyright.	16	4
52	2017-07-26 18:02:34.737492+00	1	SiteConfiguration object	2	Changed col3_content and copyright.	16	4
53	2017-08-01 15:08:19.974747+00	6	Apps	2	Changed status.	34	4
54	2017-08-01 22:54:57.422561+00	2	Home	2	Changed heading, content, in_menus and keywords.	17	4
55	2017-08-01 23:06:15.683441+00	2	Home	2	Changed content, in_menus and keywords.	17	4
56	2017-08-01 23:07:32.016563+00	6	Apps	2	Changed slug.	34	4
57	2017-08-01 23:13:58.786225+00	7	Verify Account	2	Changed content, in_menus and keywords.	33	4
58	2017-08-01 23:14:46.70497+00	8	Resend Verification Email	2	Changed content, in_menus and keywords.	28	4
59	2017-08-01 23:30:15.111474+00	9	Terms of Use	2	Changed content, in_menus, description and keywords.	33	4
60	2017-08-01 23:33:15.587452+00	10	Statement of Privacy	2	Changed content, in_menus, description and keywords.	33	4
61	2017-08-07 19:42:20.402438+00	1	SiteConfiguration object	2	Changed col1_content and col3_content.	16	4
62	2017-08-07 19:55:17.665242+00	1	SiteConfiguration object	2	Changed col1_content and col3_content.	16	4
63	2017-08-08 21:53:36.19698+00	4	admin	2	Changed first_name.	3	4
64	2017-08-08 21:55:05.452327+00	4	admin	2	Changed email.	3	4
65	2017-08-24 20:29:22.397193+00	2	Home	2	Changed welcome_heading, content, in_menus and keywords.	17	4
66	2017-08-30 16:55:07.622683+00	4	Discover	2	Changed status and keywords.	33	4
67	2017-08-30 17:48:26.017984+00	5	cbc	3		3	4
68	2017-08-30 17:57:47.767334+00	3	My Documents	2	Changed title and keywords.	33	4
69	2017-08-30 17:58:51.501946+00	3	My Documents	2	Changed content, _meta_title, slug, description and keywords.	33	4
70	2017-08-30 17:59:25.298493+00	3	My Documents	2	Changed slug and keywords.	33	4
71	2017-08-30 19:05:23.017664+00	3	My Documents	2	Changed slug and keywords.	33	4
72	2017-08-30 19:09:08.611103+00	13	My Connections	2	Changed title, content, _meta_title, slug, description and keywords.	33	4
73	2017-08-30 20:30:44.844909+00	6	cbc	3		3	4
74	2017-08-31 14:16:35.794187+00	5	FAQs	2	Changed title, content, _meta_title, slug, description and keywords.	33	4
75	2017-09-01 21:03:48.626645+00	5	FAQS	2	Changed title and keywords.	33	4
76	2017-09-01 21:05:38.116161+00	14	About	1		33	4
77	2017-09-07 20:04:36.990963+00	14	About	2	Changed content, slug, gen_description and keywords.	33	4
78	2017-09-07 20:06:08.187958+00	14	About	2	Changed content and keywords.	33	4
79	2017-09-07 20:07:32.486976+00	14	About	2	Changed content and keywords.	33	4
80	2017-09-07 20:12:12.056248+00	14	About	2	Changed content and keywords.	33	4
81	2017-09-11 05:23:37.961927+00	4	Discover	2	Changed status, content, slug, description and keywords.	33	4
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 81, true);


--
-- Data for Name: django_comment_flags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_comment_flags (id, user_id, comment_id, flag, flag_date) FROM stdin;
\.


--
-- Name: django_comment_flags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_comment_flags_id_seq', 1, false);


--
-- Data for Name: django_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_comments (id, content_type_id, object_pk, site_id, user_id, user_name, user_email, user_url, comment, submit_date, ip_address, is_public, is_removed) FROM stdin;
\.


--
-- Name: django_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_comments_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	auth	user
4	oauth2_provider	application
5	oauth2_provider	grant
6	oauth2_provider	accesstoken
7	oauth2_provider	refreshtoken
8	corsheaders	corsmodel
9	contenttypes	contenttype
10	redirects	redirect
11	sessions	session
12	sites	site
13	gis	postgisgeometrycolumns
14	gis	postgisspatialrefsys
15	django_irods	rodsenvironment
16	theme	siteconfiguration
17	theme	homepage
18	theme	iconbox
19	theme	userprofile
20	conf	setting
21	core	sitepermission
22	generic	threadedcomment
23	generic	keyword
24	generic	assignedkeyword
25	generic	rating
26	blog	blogpost
27	blog	blogcategory
28	forms	form
29	forms	field
30	forms	formentry
31	forms	fieldentry
32	pages	page
33	pages	richtextpage
34	pages	link
35	galleries	gallery
36	galleries	galleryimage
37	ga_ows	ogrdatasetcollection
38	ga_ows	ogrdataset
39	ga_ows	ogrlayer
40	ga_resources	catalogpage
41	ga_resources	dataresource
42	ga_resources	orderedresource
43	ga_resources	resourcegroup
44	ga_resources	relatedresource
45	ga_resources	style
46	ga_resources	renderedlayer
47	hs_core	groupownership
48	hs_core	externalprofilelink
49	hs_core	contributor
50	hs_core	creator
51	hs_core	description
52	hs_core	title
53	hs_core	type
54	hs_core	date
55	hs_core	relation
56	hs_core	identifier
57	hs_core	publisher
58	hs_core	language
59	hs_core	coverage
60	hs_core	format
61	hs_core	subject
62	hs_core	source
63	hs_core	rights
64	hs_core	resourcefile
65	hs_core	bags
66	hs_core	baseresource
67	hs_core	genericresource
68	hs_core	coremetadata
69	hs_access_control	usergroupprivilege
70	hs_access_control	userresourceprivilege
71	hs_access_control	groupresourceprivilege
72	hs_access_control	useraccess
73	hs_access_control	groupaccess
74	hs_access_control	resourceaccess
75	hs_labels	userresourcelabels
76	hs_labels	userresourceflags
77	hs_labels	userstoredlabels
78	hs_labels	userlabels
79	hs_labels	resourcelabels
80	django_docker_processes	dockerprofile
81	django_docker_processes	containeroverrides
82	django_docker_processes	overrideenvvar
83	django_docker_processes	overridevolume
84	django_docker_processes	overridelink
85	django_docker_processes	overrideport
86	django_docker_processes	dockerlink
87	django_docker_processes	dockerenvvar
88	django_docker_processes	dockervolume
89	django_docker_processes	dockerport
90	django_docker_processes	dockerprocess
91	hs_geo_raster_resource	originalcoverage
92	hs_geo_raster_resource	bandinformation
93	hs_geo_raster_resource	cellinformation
94	hs_geo_raster_resource	rasterresource
95	hs_geo_raster_resource	rastermetadata
96	djcelery	taskmeta
97	djcelery	tasksetmeta
98	djcelery	intervalschedule
99	djcelery	crontabschedule
100	djcelery	periodictasks
101	djcelery	periodictask
102	djcelery	workerstate
103	djcelery	taskstate
105	ref_ts	referenceurl
106	ref_ts	method
107	ref_ts	qualitycontrollevel
108	ref_ts	variable
109	ref_ts	site
110	ref_ts	reftsmetadata
111	hs_app_timeseries	site
112	hs_app_timeseries	variable
113	hs_app_timeseries	method
114	hs_app_timeseries	processinglevel
115	hs_app_timeseries	timeseriesresult
116	hs_app_timeseries	timeseriesresource
117	hs_app_timeseries	timeseriesmetadata
118	hs_app_netCDF	originalcoverage
119	hs_app_netCDF	variable
120	hs_app_netCDF	netcdfresource
121	hs_app_netCDF	netcdfmetadata
122	hs_model_program	mpmetadata
123	hs_model_program	modelprogramresource
124	hs_model_program	modelprogrammetadata
125	hs_modelinstance	modeloutput
126	hs_modelinstance	executedby
127	hs_modelinstance	modelinstanceresource
128	hs_modelinstance	modelinstancemetadata
129	hs_tools_resource	toolresource
130	hs_tools_resource	requesturlbase
131	hs_tools_resource	toolversion
132	hs_tools_resource	supportedrestypechoices
133	hs_tools_resource	supportedrestypes
134	hs_tools_resource	toolicon
135	hs_tools_resource	toolmetadata
136	hs_swat_modelinstance	modeloutput
137	hs_swat_modelinstance	executedby
138	hs_swat_modelinstance	modelobjectivechoices
139	hs_swat_modelinstance	modelobjective
140	hs_swat_modelinstance	simulationtype
141	hs_swat_modelinstance	modelmethod
142	hs_swat_modelinstance	modelparameterschoices
143	hs_swat_modelinstance	modelparameter
144	hs_swat_modelinstance	modelinput
145	hs_swat_modelinstance	swatmodelinstanceresource
146	hs_swat_modelinstance	swatmodelinstancemetadata
147	hs_geographic_feature_resource	originalfileinfo
148	hs_geographic_feature_resource	originalcoverage
149	hs_geographic_feature_resource	fieldinformation
150	hs_geographic_feature_resource	geometryinformation
151	hs_geographic_feature_resource	geographicfeatureresource
152	hs_geographic_feature_resource	geographicfeaturemetadata
153	hs_script_resource	scriptresource
154	hs_script_resource	scriptspecificmetadata
155	hs_script_resource	scriptmetadata
156	admin	logentry
157	comments	comment
158	comments	commentflag
159	ref_ts	datasource
160	ref_ts	reftimeseriesresource
161	django_comments	comment
162	django_comments	commentflag
163	hs_core	fundingagency
164	hs_access_control	groupmembershiprequest
165	hs_collection_resource	collectiondeletedresource
166	hs_collection_resource	collectionresource
167	hs_tracking	visitor
168	hs_tracking	session
169	hs_tracking	variable
170	robots	url
171	robots	rule
172	hs_app_timeseries	utcoffset
173	hs_app_timeseries	cvvariabletype
174	hs_app_timeseries	cvvariablename
175	hs_app_timeseries	cvspeciation
176	hs_app_timeseries	cvelevationdatum
177	hs_app_timeseries	cvsitetype
178	hs_app_timeseries	cvmethodtype
179	hs_app_timeseries	cvunitstype
180	hs_app_timeseries	cvstatus
181	hs_app_timeseries	cvmedium
182	hs_app_timeseries	cvaggregationstatistic
183	hs_tools_resource	apphomepageurl
184	hs_tools_resource	supportedsharingstatuschoices
185	hs_tools_resource	supportedsharingstatus
186	hs_modflow_modelinstance	studyarea
187	hs_modflow_modelinstance	griddimensions
188	hs_modflow_modelinstance	stressperiod
189	hs_modflow_modelinstance	groundwaterflow
190	hs_modflow_modelinstance	specifiedheadboundarypackagechoices
191	hs_modflow_modelinstance	specifiedfluxboundarypackagechoices
192	hs_modflow_modelinstance	headdependentfluxboundarypackagechoices
193	hs_modflow_modelinstance	boundarycondition
194	hs_modflow_modelinstance	modelcalibration
195	hs_modflow_modelinstance	modelinput
196	hs_modflow_modelinstance	outputcontrolpackagechoices
197	hs_modflow_modelinstance	generalelements
198	hs_modflow_modelinstance	modflowmodelinstancemetadata
199	hs_modflow_modelinstance	modflowmodelinstanceresource
200	hs_modflow_modelinstance	executedby
201	hs_modflow_modelinstance	modeloutput
202	hs_file_types	genericfilemetadata
203	hs_file_types	genericlogicalfile
204	hs_file_types	georasterfilemetadata
205	hs_file_types	georasterlogicalfile
206	hs_composite_resource	compositeresource
207	theme	quotamessage
208	theme	userquota
209	hs_access_control	usergroupprovenance
210	hs_access_control	userresourceprovenance
211	hs_access_control	groupresourceprovenance
212	hs_file_types	netcdffilemetadata
213	hs_file_types	netcdflogicalfile
214	security	passwordexpiry
215	security	cspreport
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_content_type_id_seq', 215, true);


--
-- Data for Name: django_docker_processes_containeroverrides; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_containeroverrides (id, name, command, working_dir, "user", entrypoint, privileged, lxc_conf, memory_limit, cpu_shares, dns, net, docker_profile_id) FROM stdin;
\.


--
-- Name: django_docker_processes_containeroverrides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_containeroverrides_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_dockerenvvar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_dockerenvvar (id, name, value, docker_profile_id) FROM stdin;
\.


--
-- Name: django_docker_processes_dockerenvvar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_dockerenvvar_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_dockerlink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_dockerlink (id, link_name, docker_overrides_id, docker_profile_id, docker_profile_from_id) FROM stdin;
\.


--
-- Name: django_docker_processes_dockerlink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_dockerlink_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_dockerport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_dockerport (id, host, container, docker_profile_id) FROM stdin;
\.


--
-- Name: django_docker_processes_dockerport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_dockerport_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_dockerprocess; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_dockerprocess (id, container_id, token, logs, finished, error, profile_id, user_id) FROM stdin;
\.


--
-- Name: django_docker_processes_dockerprocess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_dockerprocess_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_dockerprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_dockerprofile (id, name, git_repository, git_use_submodules, git_username, git_password, commit_id, branch) FROM stdin;
\.


--
-- Name: django_docker_processes_dockerprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_dockerprofile_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_dockervolume; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_dockervolume (id, host, container, readonly, docker_profile_id) FROM stdin;
\.


--
-- Name: django_docker_processes_dockervolume_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_dockervolume_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_overrideenvvar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_overrideenvvar (id, name, value, container_overrides_id) FROM stdin;
\.


--
-- Name: django_docker_processes_overrideenvvar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_overrideenvvar_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_overridelink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_overridelink (id, link_name, container_overrides_id, docker_profile_from_id) FROM stdin;
\.


--
-- Name: django_docker_processes_overridelink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_overridelink_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_overrideport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_overrideport (id, host, container, container_overrides_id) FROM stdin;
\.


--
-- Name: django_docker_processes_overrideport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_overrideport_id_seq', 1, false);


--
-- Data for Name: django_docker_processes_overridevolume; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_docker_processes_overridevolume (id, host, container, container_overrides_id) FROM stdin;
\.


--
-- Name: django_docker_processes_overridevolume_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_docker_processes_overridevolume_id_seq', 1, false);


--
-- Data for Name: django_irods_rodsenvironment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_irods_rodsenvironment (id, host, port, def_res, home_coll, cwd, username, zone, auth, owner_id) FROM stdin;
\.


--
-- Name: django_irods_rodsenvironment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_irods_rodsenvironment_id_seq', 1, false);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-01-25 19:11:56.863948+00
2	auth	0001_initial	2016-01-25 19:11:57.121386+00
3	admin	0001_initial	2016-01-25 19:11:57.247222+00
4	django_docker_processes	0001_initial	2016-01-25 19:11:58.730572+00
5	django_irods	0001_initial	2016-01-25 19:11:58.841429+00
6	ga_ows	0001_initial	2016-01-25 19:11:59.076346+00
7	ga_resources	0001_initial	2016-01-25 19:11:59.934826+00
8	hs_core	0001_initial	2016-01-25 19:12:02.460395+00
9	hs_core	0002_genericresource_resource_type	2016-01-25 19:12:02.728512+00
10	hs_core	0003_auto_20150721_1122	2016-01-25 19:12:03.719141+00
11	hs_core	0004_auto_20150721_1125	2016-01-25 19:12:06.140491+00
12	hs_access_control	0001_initial	2016-01-25 19:12:08.794606+00
13	hs_access_control	0002_auto_20150817_1150	2016-01-25 19:12:09.31385+00
14	hs_access_control	0003_auto_20150824_2215	2016-01-25 19:12:11.708885+00
15	hs_access_control	0004_remove_useraccess_admin	2016-01-25 19:12:12.265732+00
16	hs_access_control	0005_remove_useraccess_active	2016-01-25 19:12:13.040689+00
17	hs_app_netCDF	0001_initial	2016-01-25 19:12:13.857061+00
18	hs_app_netCDF	0002_auto_20150813_1215	2016-01-25 19:12:14.103772+00
19	hs_app_netCDF	0003_netcdfresource	2016-01-25 19:12:14.661719+00
20	hs_app_timeseries	0001_initial	2016-01-25 19:12:16.317675+00
21	hs_app_timeseries	0002_auto_20150813_1247	2016-01-25 19:12:16.691335+00
22	hs_app_timeseries	0003_timeseriesresource	2016-01-25 19:12:17.197022+00
23	hs_core	0005_auto_20150910_0233	2016-01-25 19:12:18.452997+00
24	hs_core	0006_auto_20150917_1515	2016-01-25 19:12:18.931433+00
25	hs_core	0007_auto_20151114_1618	2016-01-25 19:12:19.812616+00
26	hs_core	0008_auto_20151114_2024	2016-01-25 19:12:20.502906+00
27	hs_core	0009_auto_20151114_2105	2016-01-25 19:12:21.100168+00
28	hs_core	0010_auto_20151114_2205	2016-01-25 19:12:21.824277+00
29	hs_core	0011_auto_20151114_2231	2016-01-25 19:12:22.505024+00
30	hs_core	0012_auto_20151114_2243	2016-01-25 19:12:23.188598+00
31	hs_core	0013_auto_20151114_2314	2016-01-25 19:12:23.976933+00
32	hs_core	0014_auto_20151123_1451	2016-01-25 19:12:24.680615+00
33	hs_geo_raster_resource	0001_initial	2016-01-25 19:12:25.732457+00
34	hs_geo_raster_resource	0002_auto_20150813_1313	2016-01-25 19:12:25.870148+00
35	hs_geo_raster_resource	0003_auto_20150813_1315	2016-01-25 19:12:27.812284+00
36	hs_geo_raster_resource	0004_auto_20151116_2257	2016-01-25 19:12:28.582408+00
37	hs_geographic_feature_resource	0001_initial	2016-01-25 19:12:29.947073+00
38	hs_labels	0001_initial	2016-01-25 19:12:31.044383+00
39	hs_labels	0002_custom_migration	2016-01-25 19:12:31.760094+00
40	hs_labels	0003_manual_delete_duplicates	2016-01-25 19:12:32.577078+00
41	hs_labels	0004_auto_add_constraints	2016-01-25 19:12:33.85641+00
42	hs_model_program	0001_initial	2016-01-25 19:12:34.545962+00
43	hs_modelinstance	0001_initial	2016-01-25 19:12:35.220586+00
44	hs_modelinstance	0002_auto_20150813_1345	2016-01-25 19:12:37.414321+00
45	hs_model_program	0002_auto_20150813_1729	2016-01-25 19:12:37.561396+00
46	hs_model_program	0003_auto_20150813_1730	2016-01-25 19:12:39.677772+00
47	hs_model_program	0004_auto_20151012_1656	2016-01-25 19:12:42.639648+00
48	hs_model_program	0005_auto_20151104_1604	2016-01-25 19:12:44.21169+00
49	hs_model_program	0006_auto_20151216_1511	2016-01-25 19:12:45.172674+00
50	hs_modelinstance	0002_auto_20150914_1902	2016-01-25 19:12:45.807549+00
51	hs_modelinstance	0003_merge	2016-01-25 19:12:46.401464+00
52	hs_modelinstance	0004_auto_20151110_1920	2016-01-25 19:12:47.492696+00
53	hs_modelinstance	0005_auto_20151111_2129	2016-01-25 19:12:48.432108+00
54	hs_modelinstance	0006_auto_20151216_1511	2016-01-25 19:12:49.41211+00
55	hs_script_resource	0001_initial	2016-01-25 19:12:50.367661+00
56	hs_swat_modelinstance	0001_initial	2016-01-25 19:12:52.143662+00
57	hs_swat_modelinstance	0002_auto_20150813_1726	2016-01-25 19:12:52.435242+00
58	hs_swat_modelinstance	0003_auto_20151013_1955	2016-01-25 19:12:54.130572+00
59	hs_swat_modelinstance	0004_auto_20151106_1932	2016-01-25 19:12:57.702306+00
60	hs_swat_modelinstance	0005_auto_20151110_1945	2016-01-25 19:13:02.692517+00
61	hs_swat_modelinstance	0006_auto_20160114_1508	2016-01-25 19:13:04.238265+00
62	sites	0001_initial	2016-01-25 19:13:04.325634+00
63	hs_tools_resource	0001_initial	2016-01-25 19:13:05.12026+00
64	hs_tools_resource	0002_auto_20150724_1422	2016-01-25 19:13:05.543658+00
65	hs_tools_resource	0003_auto_20150724_1501	2016-01-25 19:13:06.249824+00
66	hs_tools_resource	0004_auto_20151204_2301	2016-01-25 19:13:08.134296+00
67	hs_tools_resource	0005_remove_requesturlbase_resshortid	2016-01-25 19:13:08.852496+00
68	hs_tools_resource	0006_auto_20160113_2003	2016-01-25 19:13:09.597931+00
69	oauth2_provider	0001_initial	2016-01-25 19:13:10.030944+00
70	oauth2_provider	0002_08_updates	2016-01-25 19:13:10.364442+00
71	redirects	0001_initial	2016-01-25 19:13:10.46622+00
72	ref_ts	0001_initial	2016-01-25 19:13:11.526706+00
73	ref_ts	0002_auto_20150813_1336	2016-01-25 19:13:11.788654+00
74	ref_ts	0003_reftimeseries	2016-01-25 19:13:12.394768+00
75	sessions	0001_initial	2016-01-25 19:13:12.483043+00
76	theme	0001_initial	2016-01-25 19:13:12.791757+00
77	hs_access_control	0006_auto_add_new_fields	2016-02-10 17:25:26.82944+00
78	hs_access_control	0007_manual_populate_new_fields	2016-02-10 17:25:27.760025+00
79	hs_access_control	0008_auto_remove_many2many_relationships	2016-02-10 17:25:29.190215+00
80	hs_access_control	0009_auto_remove_original_fields	2016-02-10 17:25:31.50817+00
81	hs_access_control	0010_auto_rename_related_names	2016-02-10 17:25:33.418051+00
82	hs_access_control	0011_auto_rename_new_fields_to_original_names	2016-02-10 17:25:35.520652+00
83	hs_access_control	0012_auto_disallow_nulls	2016-02-10 17:25:37.776682+00
84	hs_access_control	0013_auto_add_uniqueness_constraints	2016-02-10 17:25:39.232351+00
85	hs_core	0015_auto_20160210_1725	2016-02-10 17:25:39.984521+00
86	hs_tools_resource	0007_auto_20160122_2240	2016-02-10 17:25:40.949761+00
87	ref_ts	0004_auto_20160114_0252	2016-02-10 17:25:44.189374+00
88	hs_core	0015_auto_20160122_1939	2016-02-24 16:49:13.981508+00
89	hs_core	0016_merge	2016-02-24 16:49:14.629004+00
90	contenttypes	0002_remove_content_type_name	2016-04-05 15:52:48.840448+00
91	auth	0002_alter_permission_name_max_length	2016-04-05 15:52:48.861207+00
92	auth	0003_alter_user_email_max_length	2016-04-05 15:52:48.882309+00
93	auth	0004_alter_user_username_opts	2016-04-05 15:52:48.902771+00
94	auth	0005_alter_user_last_login_null	2016-04-05 15:52:48.924684+00
95	auth	0006_require_contenttypes_0002	2016-04-05 15:52:48.928046+00
96	blog	0001_initial	2016-04-05 15:52:48.96178+00
97	blog	0002_auto_20150527_1555	2016-04-05 15:52:48.995833+00
98	conf	0001_initial	2016-04-05 15:52:49.030144+00
99	core	0001_initial	2016-04-05 15:52:49.069188+00
100	core	0002_auto_20150414_2140	2016-04-05 15:52:49.123848+00
101	django_comments	0001_initial	2016-04-05 15:52:49.232336+00
102	django_comments	0002_update_user_email_field_length	2016-04-05 15:52:49.274936+00
103	pages	0001_initial	2016-04-05 15:52:49.381683+00
104	forms	0001_initial	2016-04-05 15:52:49.704962+00
105	forms	0002_auto_20141227_0224	2016-04-05 15:52:49.791646+00
106	forms	0003_emailfield	2016-04-05 15:52:49.882541+00
107	forms	0004_auto_20150517_0510	2016-04-05 15:52:50.202042+00
108	forms	0005_auto_20151026_1600	2016-04-05 15:52:50.279381+00
109	galleries	0001_initial	2016-04-05 15:52:50.490778+00
110	galleries	0002_auto_20141227_0224	2016-04-05 15:52:50.601395+00
111	generic	0001_initial	2016-04-05 15:52:51.13465+00
112	generic	0002_auto_20141227_0224	2016-04-05 15:52:51.2577+00
113	hs_core	0017_auto_20160219_2039	2016-04-05 15:52:51.697456+00
114	hs_core	0017_auto_20160217_1629	2016-04-05 15:52:52.108399+00
115	hs_core	0018_merge	2016-04-05 15:52:52.111171+00
116	hs_core	0019_baseresource_locked_time	2016-04-05 15:52:52.318958+00
117	hs_geo_raster_resource	custom_migration_for_tif_to_vrt_20160223	2016-04-05 15:52:52.337656+00
118	pages	0002_auto_20141227_0224	2016-04-05 15:52:53.062688+00
119	pages	0003_auto_20150527_1555	2016-04-05 15:52:53.439151+00
120	theme	0002_auto_20160219_2039	2016-04-05 15:52:53.861018+00
121	theme	0003_auto_20160302_0453	2016-04-05 15:52:57.426205+00
122	hs_access_control	0014_auto_20160424_1628	2016-06-23 17:05:42.044535+00
123	hs_app_timeseries	0004_auto_20160526_2026	2016-06-23 17:05:42.29096+00
124	hs_core	0020_baseresource_collections	2016-06-23 17:05:42.53999+00
125	hs_collection_resource	0001_initial	2016-06-23 17:05:43.761938+00
126	hs_core	0021_auto_20160427_1807	2016-06-23 17:05:44.237364+00
127	hs_core	0022_resourcefile_resource_file_size	2016-06-23 17:05:44.493421+00
128	hs_core	0021_hstore_extension	2016-06-23 17:05:44.529228+00
129	hs_core	0022_baseresource_extra_metadata	2016-06-23 17:05:44.825073+00
130	hs_core	0021_fundingagency	2016-06-23 17:05:45.254751+00
131	hs_core	0023_merge	2016-06-23 17:05:45.259316+00
132	hs_core	0024_baseresource_resource_federation_path	2016-06-23 17:05:45.599503+00
133	hs_core	0025_resourcefile_fed_resource_file	2016-06-23 17:05:46.122748+00
134	hs_core	0024_custom_migration_metadata_namespace_20160527	2016-06-23 17:05:46.14658+00
135	hs_core	0026_merge	2016-06-23 17:05:46.150181+00
136	hs_geo_raster_resource	0005_auto_20160509_2116	2016-06-23 17:05:47.213331+00
137	hs_geo_raster_resource	custom_migration_for_raster_meta_update_20160512	2016-06-23 17:05:47.239339+00
138	hs_swat_modelinstance	0007_auto_20160428_1843	2016-06-23 17:05:48.065251+00
139	hs_tracking	0001_initial	2016-06-23 17:05:50.044085+00
140	hs_tracking	0002_auto_20160406_1244	2016-06-23 17:05:50.486671+00
141	theme	0004_userprofile_create_irods_user_account	2016-06-23 17:05:51.001845+00
142	hs_tracking	0003_auto_20160623_1718	2016-06-23 17:23:54.498282+00
143	hs_access_control	0015_manual_remove_redundant_privileges	2017-02-02 16:15:22.054515+00
144	hs_access_control	0016_auto_enforce_constraints	2017-02-02 16:15:22.98605+00
145	hs_app_netCDF	0004_auto_20160921_2320	2017-02-02 16:15:24.056952+00
146	hs_app_netCDF	0005_auto_20161111_2322	2017-02-02 16:15:24.452244+00
147	hs_app_netCDF	0006_auto_20170120_1445	2017-02-02 16:15:24.660859+00
148	hs_app_timeseries	0005_auto_20160713_1905	2017-02-02 16:15:29.521167+00
149	hs_app_timeseries	custom_data_migration_20160718	2017-02-02 16:15:29.545735+00
150	hs_app_timeseries	0001_auto_20160829_2156	2017-02-02 16:15:30.482925+00
151	hs_collection_resource	0002_collectiondeletedresource_resource_owners	2017-02-02 16:15:30.743707+00
152	hs_core	0027_auto_20160818_2308	2017-02-02 16:15:31.282057+00
153	hs_core	0028_baseresource_extra_data	2017-02-02 16:15:31.860804+00
154	hs_core	0029_auto_20161123_1858	2017-02-02 16:15:32.30716+00
155	hs_core	0030_resourcefile_file_folder	2017-02-02 16:15:32.540543+00
156	hs_core	0031_auto_20170112_2202	2017-02-02 16:15:33.085424+00
157	hs_composite_resource	0001_initial	2017-02-02 16:15:33.111575+00
158	hs_core	0032_auto_20170120_1445	2017-02-02 16:15:33.378996+00
159	hs_file_types	0001_initial	2017-02-02 16:15:33.540703+00
160	hs_geo_raster_resource	0006_auto_20161129_0121	2017-02-02 16:15:33.815668+00
161	hs_modflow_modelinstance	0001_initial	2017-02-02 16:15:48.455375+00
162	hs_modflow_modelinstance	0002_executedby_modeloutput_modflowmodelinstancemetadata_modflowmodelinstanceresource	2017-02-02 16:15:48.614609+00
163	hs_tools_resource	0008_auto_20160729_1811	2017-02-02 16:15:49.637362+00
164	hs_tools_resource	0009_auto_20160929_1543	2017-02-02 16:15:50.902935+00
165	hs_tools_resource	0010_auto_20161203_1913	2017-02-02 16:15:54.219542+00
166	hs_tracking	0004_auto_20161010_1402	2017-02-02 16:15:54.69361+00
167	robots	0001_initial	2017-02-02 16:15:58.401584+00
168	hs_access_control	0017_auto_add_provenance	2017-05-05 13:41:49.70712+00
169	hs_access_control	0018_auto_tune_provenance	2017-05-05 13:41:50.912473+00
170	hs_access_control	0019_manual_populate_provenance	2017-05-05 13:41:50.933487+00
171	hs_access_control	0017_groupaccess_auto_approve	2017-05-05 13:41:51.095253+00
172	hs_access_control	0020_merge	2017-05-05 13:41:51.098691+00
173	hs_app_netCDF	0007_netcdfmetadata_is_dirty	2017-05-05 13:41:51.129644+00
174	hs_core	0033_resourcefile_attributes	2017-05-05 13:41:51.717935+00
175	hs_core	0034_manual_migrate_file_paths	2017-05-05 13:41:51.736427+00
176	hs_core	0035_remove_deprecated_fields	2017-05-05 13:41:52.095568+00
177	hs_file_types	0002_auto_20170216_1904	2017-05-05 13:41:52.203428+00
178	hs_file_types	0003_auto_20170302_2257	2017-05-05 13:41:52.285303+00
179	hs_tools_resource	0011_toolicon_data_url	2017-05-05 13:41:52.958208+00
180	security	0001_initial	2017-05-05 13:41:53.970416+00
181	theme	0005_userquota	2017-05-05 13:41:55.396172+00
182	theme	0006_auto_20170309_1516	2017-05-05 13:41:55.432509+00
183	theme	0007_auto_20170427_1553	2017-05-05 13:41:57.537779+00
184	hs_access_control	0021_auto_20170613_1925	2017-07-26 17:17:57.382159+00
185	hs_tracking	0005_auto_20170613_1925	2017-07-26 17:17:57.757155+00
186	theme	0008_auto_20170613_1925	2017-07-26 17:17:59.818007+00
187	hs_core	0036_remove_baseresource_comments_count	2017-08-23 17:55:22.715575+00
188	theme	0009_auto_20171102_0508	2017-11-02 05:14:34.032178+00
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_migrations_id_seq', 187, true);


--
-- Data for Name: django_redirect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_redirect (id, site_id, old_path, new_path) FROM stdin;
\.


--
-- Name: django_redirect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_redirect_id_seq', 1, false);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
iuq13wh2xtsrestc3ixty7cy7pcutc3b	ZTIwZWRiZTQzZjI5ODhkYTE0NDQxYzFmZmQzMTRjZDc3MWUxNGUzYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjBkNTY4M2MyYWVkNjA4OWNhMDc5YTE4ZmFlZTNjNjdlMjExNTRmZDciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJtZXp6YW5pbmUuY29yZS5hdXRoX2JhY2tlbmRzLk1lenphbmluZUJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjo0fQ==	2016-02-08 19:50:52.911919+00
r95gvslruo55bqar11kco2o9ynh41mrq	NmM0MTZkOGYzNTBkNDEwMTBiZTc3NTFmODg5ZDU4N2VkNmVkZDJlZTp7fQ==	2016-02-08 19:55:45.734662+00
yq96gavkvlu0skywfwgvdock65xnq3tc	ZTIwZWRiZTQzZjI5ODhkYTE0NDQxYzFmZmQzMTRjZDc3MWUxNGUzYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjBkNTY4M2MyYWVkNjA4OWNhMDc5YTE4ZmFlZTNjNjdlMjExNTRmZDciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJtZXp6YW5pbmUuY29yZS5hdXRoX2JhY2tlbmRzLk1lenphbmluZUJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjo0fQ==	2016-03-09 17:40:31.568514+00
5eflr6q0pn7qgkuu6mbo84kuqoxk5plt	ZjZmMTlkMThkOGJmNWIzY2IxODNjODM5ZTA2MmFjNTRmNTlmYTRkOTp7InF1ZXJ5X2NoYW5nZWQiOmZhbHNlLCJoc190cmFja2luZ19pZCI6ImV5SnBaQ0k2TW4wOjFiRzg2ZDpGNWs4M3pGcnQ2Mzg5WWMyZUhRc3BNRGVBR2siLCJmYWNldHNfaXRlbXMiOnsiZmllbGRzIjp7ImF1dGhvciI6W10sIm93bmVyc19uYW1lcyI6W10sInN1YmplY3RzIjpbXSwiZGlzY292ZXJhYmxlIjpbXSwicHVibGljIjpbXSwicmVzb3VyY2VfdHlwZSI6W119LCJkYXRlcyI6e30sInF1ZXJpZXMiOnt9fSwidG90YWxfcmVzdWx0cyI6MH0=	2016-07-07 17:17:57.67608+00
yg9nko1xsebjvcc6wk4ynygw4m8l3ofk	ZTg1M2RhMWVmMzk3YTcwYTFlMWE5MDhlNWRiYjAyZGU0Yzk2YmVmYzp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZObjA6MWNaTEJZOnhCdHhZT3oxQ3RXb0lBVFR2aFVqcW5UaDBwOCJ9	2017-02-16 17:28:40.816975+00
sbfc9qcoi728qf2c38jscng5q7ccra4a	ZWI2ZjgwZmQ3NmRhYTA3NDAyYzI4MzEyMzgwMjNmMGExODU3ZjNhMzp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZOMzA6MWQ2ZFdIOmx4S0hCN1NrVWgwS3NaT2tqSHVEVndhMGcxbyIsIl9hdXRoX3VzZXJfaGFzaCI6IjBjZGYxNDBkN2Q1NDRhMGUyMWMwM2EyMTdjMDJlNGQyMjFhZjhiYTUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJtZXp6YW5pbmUuY29yZS5hdXRoX2JhY2tlbmRzLk1lenphbmluZUJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNCJ9	2017-05-19 13:43:51.032176+00
k7nt7rugdkbcm58fglbsdrepdqaytp43	M2Q0Y2ZiM2Q0MDdhMjA5MWNmZTc4MDM0NjA0YzY1MjYxM2U4YjY5NTp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVEY5OjFkYVJVNDpPU1Z0SWNpeXBBcE96OWpJQmpPLXI0QmZwQ3ciLCJfYXV0aF91c2VyX2hhc2giOiIyYTc3ODVjMTg5ZDRjY2EwY2RhZjM1NDMyYmJiZjA3ZWIxMTU4ZDVmIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoibWV6emFuaW5lLmNvcmUuYXV0aF9iYWNrZW5kcy5NZXp6YW5pbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjQifQ==	2017-08-09 18:56:46.438769+00
luvbqixlnqnwf4v4nqn65qwgv92967lw	YWEzNzgyMzcyYWViZjkyNjk1MDM4YTg5Yjk1ZGEzM2E5N2M2ZWQ4ZTp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVFI5OjFkY1luMjpKZkNBWWhZR09EMjFmUElTa3NIV3JvYXhURHMifQ==	2017-08-15 15:08:56.554221+00
3z0mta463zqe77671d0010wwf6ajcqfb	MTI0ZTI5MmQ5ZDI5MmIzOGU1MmY0ZGYzOTI1MDU0ZGNjNjc0OWY3Mjp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVFo5OjFkY2ZVZTpJaGYzaF96Nk0xRl9mMUYtZGVVNEk4a2p2QzAifQ==	2017-08-15 22:18:24.267526+00
qs0wmt2hhfwgs2rrgoj9mi3nb38m58w6	M2ZhNzJiMTU3ZGZjOGI4OWYzZTBjNDE5MWM0Nzc5MmUwMzg3ZDFkMDp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVFY5OjFkY2ZVZTpwYXFxRHhEMDJ2N2NsMXJSdl9aNUxLek5rYncifQ==	2017-08-15 22:18:24.265935+00
xf4aeiwe7r8w5xl1ydmcvao2oe4ol8il	N2Y5MjgzMmEwYmVkYTVmMmZlOTYwMzE4MDBlYmE2Yjg5NDI3NDdiZjp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVGg5OjFkY2ZVZTo1VjF4LXJMQTZ1T202YlR4bWxfWDZXc2h5M0EifQ==	2017-08-15 22:18:24.268437+00
qedhulc3wzvi4gn5mmwjh5np4s0fyg3u	NmFkOThkYjdkMWIyMzJkMTZlODliZTJhZGZjZTFhOWIwMTMwNjk3Njp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVGQ5OjFkY2ZVZTo2SXJXRGllNm1EOHJLeEJnRHhhZmxoM2hKZE0ifQ==	2017-08-15 22:18:24.269221+00
zwindgwlw28qi61vyjrylxughw5atboo	OGE4YTU3ZTg2ODlmYjhmZDkzZThlNzY3MzE0N2Q0OGM5YmRjNTQ3MTp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNakI5OjFkY2ZVZTo5WmgzZTE1ZURnNmNQYWFpalFwUDIyM1g1QkUifQ==	2017-08-15 22:18:24.270985+00
dfxmb9mkyqw5z5oiuleab73wt5ol2lv4	ZWQ0YzQ5N2IxOTg4ODhiN2NmNDMwOWRhN2NmZGViNDM5NmZiY2FhZTp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVGw5OjFkY2ZVZTp5QlVGbHFtSHM2WEs4ZXhxaGQ0RG14c1Q3UGMifQ==	2017-08-15 22:18:24.272427+00
cuducc3knjsurzsyfa8hmqajo2yp68dk	MzU4ODFlYjc2YjBiYTYyYmY0MzAyZjVmMzRjZDhkNDRkYjMxNDQ0Yzp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNakY5OjFkY2ZVZTpyb1ZVZXR0T0o4RHljUWhodTBEOHdfQi1OZjAifQ==	2017-08-15 22:18:24.277934+00
mump2bmxwo4o62rbupqf7ua1wwlhlwwb	Yzc1MzUzZjhiNjM3YTJjMjMwMGNlMGExMWE5YWU3NGU1MTlmMmEzNzp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNak45OjFkY2ZXRDoyeGIzbEZ2VXF1WUF3NzQ2MGU1WDhYb05oQ3MifQ==	2017-08-15 22:20:01.643984+00
6r3baagyizvtlde110yxr6du1bxmywyt	MjE5Yjg4MTgyNDViYzgwMmY1NDk1NmY3OTQ3OGZkOGEyZDcxODUzNDp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNako5OjFkY2ZXRDpPOEFKYUhxN1hXSzZIWHM4bTd5cFczazBWVVkifQ==	2017-08-15 22:20:01.645092+00
79ysdjrb5b2w8n343nj6kk1ymyj7bx9q	NGU0N2U1OWU1N2QyMDE4MGU3MTQ1NTkyYjc3ZDdmMDNjODY4NjU2Mzp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNalI5OjFkY2ZXRDpNb1BrRWY4bURUODNvZnlVUEVNNkRBU1g0YzQifQ==	2017-08-15 22:20:01.654342+00
fpedybt603wx21khfno3s32e1mhxfmxu	NmE3YmQzODExMmFmMjg1OWJhN2UzYTY2MTI4ZTUyZmY0MGVhMzE4Yjp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNalY5OjFkY2ZXRDpfaER6bmlxdDNHeE14bEktbUhPZV9EUUZoWTAifQ==	2017-08-15 22:20:01.691202+00
ye5dioumcc3dz0wr20tpgiab5u98mhm8	NDY1ZTAyZTg0ZWEwMTgzYzE0OTc0NThiZWI2ZTEyNzgwZmMzNDEzNzp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNalo5OjFkY2ZXRDpueWR3NTJPQVRrVEh0WTliRmNLVTFqMVc1TDgifQ==	2017-08-15 22:20:01.696598+00
2njepouf4cjctadhmh401npz6ek4enaq	YWJjN2FkMzk3ZDczZWUwMzRmOTY1NDFiODhjOWEwNTc4MjNjZWRjMDp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNamQ5OjFkY2ZXRDpGMVJ4bFFiX2xQY0Z6cFVlSi13MnJmRUdZancifQ==	2017-08-15 22:20:01.716808+00
tl7y6jil057tardxqvf3lx9e9oabuul2	MzhlNTUxNDAxNjg5M2ZjMjhmOTNmZGU2MTlmYTdmNmE1YmNiMWVmMjp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNamg5OjFkY2ZXRDpPRUFnM0ZjUWI4R1B1aWpJVnBSaEFsVS1jRHMifQ==	2017-08-15 22:20:01.723966+00
1ko304inunuk18wr1lpau36pnyj3ozo2	OWYwMDk5YWY0YmI5OGNkM2U1MjhkMzQ0NDUyMmYxNjlmZGU5NmJjYTp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNamw5OjFkY2ZXRDo1SXMxTEdMOV81VklNVTZFUjVMbUlDRTBCckkifQ==	2017-08-15 22:20:01.731257+00
nc13v2z0rr9mec6oihfyf8m2jm8jqeao	MzRiNzU2M2I2ZDNkNzRkZWExYmM4Y2MzMTA3N2Y1NDY3MGJmNGNiNDp7InF1ZXJ5X2NoYW5nZWQiOmZhbHNlLCJoc190cmFja2luZ19pZCI6ImV5SnBaQ0k2TlROOToxZGNoVzI6bmQ0ZlV6ck14ZEF3NGdRQWFKMTZIa3pwT3NnIiwiZmFjZXRzX2l0ZW1zIjp7ImZpZWxkcyI6eyJ2YXJpYWJsZV9uYW1lcyI6W10sInVuaXRzX25hbWVzIjpbXSwib3duZXJzX25hbWVzIjpbXSwic3ViamVjdHMiOltdLCJkaXNjb3ZlcmFibGUiOltdLCJwdWJsaXNoZWQiOltdLCJjcmVhdG9ycyI6W10sInB1YmxpYyI6W10sInJlc291cmNlX3R5cGUiOltdLCJzYW1wbGVfbWVkaXVtcyI6W119LCJkYXRlcyI6e30sInF1ZXJpZXMiOnt9fSwidG90YWxfcmVzdWx0cyI6MH0=	2017-08-16 00:28:14.424858+00
51hgn45x1h20o6vmd5uzotfg3w9mmin1	NTg5MzJmMTUxM2Y1NmU2NzNhZWVmMzljNzI3ZjUzNTVjMGM1ZDEzYzp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZOalY5OjFkZW84MDp1WUNwTWhsOFZCdGZpOWtmbE1SWXBQSTJ6c1EifQ==	2017-08-21 19:55:52.42598+00
775mdt99zlg18d6t30ny60ek8b5m1acy	ZDVhYmYwMDk0Y2FmMmVjNzY3NzhlNjEyZDU3NTM0ZjRkODllYjc1Zjp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZOamw5OjFkZkNQUTpsaUNBUXFvYkZhMUM4M3dZbjFjTzFoWUxOLWsiLCJfYXV0aF91c2VyX2hhc2giOiIyYTc3ODVjMTg5ZDRjY2EwY2RhZjM1NDMyYmJiZjA3ZWIxMTU4ZDVmIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoibWV6emFuaW5lLmNvcmUuYXV0aF9iYWNrZW5kcy5NZXp6YW5pbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjQifQ==	2017-08-22 21:51:55.536041+00
hrp7ct4vtkcxjumiflobfvzlmsia52mf	ZjExNTBiZDNjYmJkOTY2OWNhMDkwMmYzNzU5ZTMzMzZiNjVmNmUyODp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZOekI5OjFka1p2UDpmQ2dNYi0tM2ZKem1VZmlXSU1Zekt5R0hpdlEifQ==	2017-09-06 17:58:43.867889+00
0asnfuacpsne490hule5mwo1zt3djqol	YTkzMjE5MGZmNzk1NDI5MWZhMmVlMmMzODNkYjVlMGIyMjk1Y2M4NTp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZOelY5OjFkbUxUdjplYUVTZEVtTEVZYUMxbHdfWjZXUWc1T3RkRkUifQ==	2017-09-11 14:57:39.409137+00
t5vfpg0e972kq0ttvwugrp0vc7pkf89f	Y2Q2ZDg1ZjIxMGMwN2I2NTkyMjhmN2ExYjExMmM5NWJlMGVlMGIyYTp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZPVGg5OjFkbnRCUTpUeVUxaFprcUhuUzVEMEhCRTF0WHdUaVFvakEifQ==	2017-09-15 21:08:56.030892+00
ypi9fizq5ba3w56r6b09q8vissf2k5mn	YjQ0MWI5OWI3NzNkYWVlODZmOGM4ZmZjMzc4MDEyMTdkY2E3NzM2Zjp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVEF3ZlE6MWRwRWdPOnZseFgwaVdpbDA5eVdkOVVlTllGN2REbXBvcyJ9	2017-09-19 14:18:28.421124+00
0ez7kji9ii9hdwd6wbzfz9jkciwf8oyk	NzM0ZmUwZDUwMzU3MGJhMTMyM2E0OTJmNWIxMjgxNjk3NzNmZGM0MDp7ImhzX3RyYWNraW5nX2lkIjoiZXlKcFpDSTZNVEEwZlE6MWRySENEOkdnRU5oNUtpNjJyRm9lMXl1anM3ZjBLZTRxcyJ9	2017-09-25 05:23:45.100701+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY django_site (id, domain, name) FROM stdin;
1	localhost:8000	Default
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: djcelery_crontabschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year) FROM stdin;
\.


--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_crontabschedule_id_seq', 1, false);


--
-- Data for Name: djcelery_intervalschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_intervalschedule_id_seq', 1, false);


--
-- Data for Name: djcelery_periodictask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_periodictask (id, name, task, interval_id, crontab_id, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description) FROM stdin;
\.


--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_periodictask_id_seq', 1, false);


--
-- Data for Name: djcelery_periodictasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: djcelery_taskstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_taskstate (id, state, task_id, name, tstamp, args, kwargs, eta, expires, result, traceback, runtime, retries, worker_id, hidden) FROM stdin;
\.


--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_taskstate_id_seq', 1, false);


--
-- Data for Name: djcelery_workerstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY djcelery_workerstate (id, hostname, last_heartbeat) FROM stdin;
\.


--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('djcelery_workerstate_id_seq', 1, false);


--
-- Data for Name: forms_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY forms_field (id, _order, form_id, label, field_type, required, visible, choices, "default", placeholder_text, help_text) FROM stdin;
\.


--
-- Name: forms_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('forms_field_id_seq', 1, false);


--
-- Data for Name: forms_fieldentry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY forms_fieldentry (id, entry_id, field_id, value) FROM stdin;
\.


--
-- Name: forms_fieldentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('forms_fieldentry_id_seq', 1, false);


--
-- Data for Name: forms_form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY forms_form (page_ptr_id, content, button_text, response, send_email, email_from, email_copies, email_subject, email_message) FROM stdin;
8	<p class="p1">Please give us your email address and we will resend the confirmation.</p>	Resend Verification	<p class="p1">Verification email sent!</p>	f				
\.


--
-- Data for Name: forms_formentry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY forms_formentry (id, form_id, entry_time) FROM stdin;
\.


--
-- Name: forms_formentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('forms_formentry_id_seq', 1, false);


--
-- Data for Name: ga_ows_ogrdataset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_ows_ogrdataset (id, location, checksum, name, human_name, extent, collection_id) FROM stdin;
\.


--
-- Name: ga_ows_ogrdataset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ga_ows_ogrdataset_id_seq', 1, false);


--
-- Data for Name: ga_ows_ogrdatasetcollection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_ows_ogrdatasetcollection (id, name) FROM stdin;
\.


--
-- Name: ga_ows_ogrdatasetcollection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ga_ows_ogrdatasetcollection_id_seq', 1, false);


--
-- Data for Name: ga_ows_ogrlayer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_ows_ogrlayer (id, name, human_name, extent, dataset_id) FROM stdin;
\.


--
-- Name: ga_ows_ogrlayer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ga_ows_ogrlayer_id_seq', 1, false);


--
-- Data for Name: ga_resources_catalogpage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_catalogpage (page_ptr_id, public, owner_id) FROM stdin;
\.


--
-- Data for Name: ga_resources_dataresource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_dataresource (page_ptr_id, content, resource_file, resource_url, resource_config, last_change, last_refresh, next_refresh, refresh_every, md5sum, metadata_url, metadata_xml, native_bounding_box, bounding_box, three_d, native_srs, public, driver, big, owner_id) FROM stdin;
\.


--
-- Data for Name: ga_resources_orderedresource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_orderedresource (id, ordering, data_resource_id, resource_group_id) FROM stdin;
\.


--
-- Name: ga_resources_orderedresource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ga_resources_orderedresource_id_seq', 1, false);


--
-- Data for Name: ga_resources_relatedresource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_relatedresource (page_ptr_id, content, resource_file, foreign_key, local_key, left_index, right_index, how, driver, key_transform, foreign_resource_id) FROM stdin;
\.


--
-- Data for Name: ga_resources_renderedlayer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_renderedlayer (page_ptr_id, content, default_class, public, data_resource_id, default_style_id, owner_id) FROM stdin;
\.


--
-- Data for Name: ga_resources_renderedlayer_styles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_renderedlayer_styles (id, renderedlayer_id, style_id) FROM stdin;
\.


--
-- Name: ga_resources_renderedlayer_styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ga_resources_renderedlayer_styles_id_seq', 1, false);


--
-- Data for Name: ga_resources_resourcegroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_resourcegroup (page_ptr_id, is_timeseries, min_time, max_time) FROM stdin;
\.


--
-- Data for Name: ga_resources_style; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ga_resources_style (page_ptr_id, legend, legend_width, legend_height, stylesheet, public, owner_id) FROM stdin;
\.


--
-- Data for Name: galleries_gallery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY galleries_gallery (page_ptr_id, content, zip_import) FROM stdin;
\.


--
-- Data for Name: galleries_galleryimage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY galleries_galleryimage (id, _order, gallery_id, file, description) FROM stdin;
\.


--
-- Name: galleries_galleryimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('galleries_galleryimage_id_seq', 1, false);


--
-- Data for Name: generic_assignedkeyword; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY generic_assignedkeyword (id, _order, keyword_id, content_type_id, object_pk) FROM stdin;
\.


--
-- Name: generic_assignedkeyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('generic_assignedkeyword_id_seq', 1, false);


--
-- Data for Name: generic_keyword; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY generic_keyword (id, site_id, title, slug) FROM stdin;
\.


--
-- Name: generic_keyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('generic_keyword_id_seq', 1, false);


--
-- Data for Name: generic_rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY generic_rating (id, value, rating_date, content_type_id, object_pk, user_id) FROM stdin;
\.


--
-- Name: generic_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('generic_rating_id_seq', 1, false);


--
-- Data for Name: generic_threadedcomment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY generic_threadedcomment (comment_ptr_id, rating_count, rating_sum, rating_average, by_author, replied_to_id) FROM stdin;
\.


--
-- Data for Name: hs_access_control_groupaccess; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_groupaccess (id, active, discoverable, public, shareable, group_id, date_created, description, picture, purpose, auto_approve) FROM stdin;
\.


--
-- Name: hs_access_control_groupaccess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_groupaccess_id_seq', 1, false);


--
-- Data for Name: hs_access_control_groupmembershiprequest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_groupmembershiprequest (id, date_requested, group_to_join_id, invitation_to_id, request_from_id) FROM stdin;
\.


--
-- Name: hs_access_control_groupmembershiprequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_groupmembershiprequest_id_seq', 1, false);


--
-- Data for Name: hs_access_control_groupresourceprivilege; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_groupresourceprivilege (id, privilege, start, grantor_id, group_id, resource_id) FROM stdin;
\.


--
-- Name: hs_access_control_groupresourceprivilege_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_groupresourceprivilege_id_seq', 1, false);


--
-- Data for Name: hs_access_control_groupresourceprovenance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_groupresourceprovenance (id, privilege, start, grantor_id, group_id, resource_id, undone) FROM stdin;
\.


--
-- Name: hs_access_control_groupresourceprovenance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_groupresourceprovenance_id_seq', 1, false);


--
-- Data for Name: hs_access_control_resourceaccess; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_resourceaccess (id, active, discoverable, public, shareable, published, immutable, resource_id) FROM stdin;
\.


--
-- Name: hs_access_control_resourceaccess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_resourceaccess_id_seq', 1, false);


--
-- Data for Name: hs_access_control_useraccess; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_useraccess (id, user_id) FROM stdin;
1	4
\.


--
-- Name: hs_access_control_useraccess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_useraccess_id_seq', 3, true);


--
-- Data for Name: hs_access_control_usergroupprivilege; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_usergroupprivilege (id, privilege, start, grantor_id, group_id, user_id) FROM stdin;
\.


--
-- Name: hs_access_control_usergroupprivilege_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_usergroupprivilege_id_seq', 1, false);


--
-- Data for Name: hs_access_control_usergroupprovenance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_usergroupprovenance (id, privilege, start, grantor_id, group_id, user_id, undone) FROM stdin;
\.


--
-- Name: hs_access_control_usergroupprovenance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_usergroupprovenance_id_seq', 1, false);


--
-- Data for Name: hs_access_control_userresourceprivilege; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_userresourceprivilege (id, privilege, start, grantor_id, resource_id, user_id) FROM stdin;
\.


--
-- Name: hs_access_control_userresourceprivilege_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_userresourceprivilege_id_seq', 1, false);


--
-- Data for Name: hs_access_control_userresourceprovenance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_access_control_userresourceprovenance (id, privilege, start, grantor_id, resource_id, user_id, undone) FROM stdin;
\.


--
-- Name: hs_access_control_userresourceprovenance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_access_control_userresourceprovenance_id_seq', 1, false);


--
-- Data for Name: hs_app_netCDF_netcdfmetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "hs_app_netCDF_netcdfmetadata" (coremetadata_ptr_id, is_dirty) FROM stdin;
\.


--
-- Data for Name: hs_app_netCDF_originalcoverage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "hs_app_netCDF_originalcoverage" (id, object_id, _value, projection_string_type, projection_string_text, content_type_id, datum) FROM stdin;
\.


--
-- Name: hs_app_netCDF_originalcoverage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"hs_app_netCDF_originalcoverage_id_seq"', 1, false);


--
-- Data for Name: hs_app_netCDF_variable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "hs_app_netCDF_variable" (id, object_id, name, unit, type, shape, descriptive_name, method, missing_value, content_type_id) FROM stdin;
\.


--
-- Name: hs_app_netCDF_variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"hs_app_netCDF_variable_id_seq"', 1, false);


--
-- Data for Name: hs_app_timeseries_cvaggregationstatistic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvaggregationstatistic (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvaggregationstatistic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvaggregationstatistic_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvelevationdatum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvelevationdatum (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvelevationdatum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvelevationdatum_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvmedium; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvmedium (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvmedium_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvmedium_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvmethodtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvmethodtype (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvmethodtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvmethodtype_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvsitetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvsitetype (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvsitetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvsitetype_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvspeciation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvspeciation (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvspeciation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvspeciation_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvstatus (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvstatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvstatus_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvunitstype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvunitstype (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvunitstype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvunitstype_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvvariablename; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvvariablename (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvvariablename_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvvariablename_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_cvvariabletype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_cvvariabletype (id, term, name, is_dirty, metadata_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_cvvariabletype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_cvvariabletype_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_method (id, object_id, method_code, method_name, method_type, method_description, method_link, content_type_id, is_dirty, series_ids) FROM stdin;
\.


--
-- Name: hs_app_timeseries_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_method_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_processinglevel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_processinglevel (id, object_id, processing_level_code, definition, explanation, content_type_id, is_dirty, series_ids) FROM stdin;
\.


--
-- Name: hs_app_timeseries_processinglevel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_processinglevel_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_site (id, object_id, site_code, site_name, elevation_m, elevation_datum, site_type, content_type_id, is_dirty, series_ids, latitude, longitude) FROM stdin;
\.


--
-- Name: hs_app_timeseries_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_site_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_timeseriesmetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_timeseriesmetadata (coremetadata_ptr_id, is_dirty, value_counts) FROM stdin;
\.


--
-- Data for Name: hs_app_timeseries_timeseriesresult; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_timeseriesresult (id, object_id, units_type, units_name, units_abbreviation, status, sample_medium, value_count, aggregation_statistics, content_type_id, is_dirty, series_ids, series_label) FROM stdin;
\.


--
-- Name: hs_app_timeseries_timeseriesresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_timeseriesresult_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_utcoffset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_utcoffset (id, object_id, series_ids, is_dirty, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_app_timeseries_utcoffset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_utcoffset_id_seq', 1, false);


--
-- Data for Name: hs_app_timeseries_variable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_app_timeseries_variable (id, object_id, variable_code, variable_name, variable_type, no_data_value, variable_definition, speciation, content_type_id, is_dirty, series_ids) FROM stdin;
\.


--
-- Name: hs_app_timeseries_variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_app_timeseries_variable_id_seq', 1, false);


--
-- Data for Name: hs_collection_resource_collectiondeletedresource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_collection_resource_collectiondeletedresource (id, resource_title, date_deleted, resource_id, resource_type, collection_id, deleted_by_id) FROM stdin;
\.


--
-- Name: hs_collection_resource_collectiondeletedresource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_collection_resource_collectiondeletedresource_id_seq', 1, false);


--
-- Name: hs_collection_resource_collectiondeletedresource_resourc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_collection_resource_collectiondeletedresource_resourc_id_seq', 1, false);


--
-- Data for Name: hs_collection_resource_collectiondeletedresource_resource_od9f5; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_collection_resource_collectiondeletedresource_resource_od9f5 (id, collectiondeletedresource_id, user_id) FROM stdin;
\.


--
-- Data for Name: hs_core_bags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_bags (id, object_id, "timestamp", content_type_id) FROM stdin;
\.


--
-- Name: hs_core_bags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_bags_id_seq', 1, false);


--
-- Data for Name: hs_core_contributor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_contributor (id, object_id, description, name, organization, email, address, phone, homepage, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_contributor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_contributor_id_seq', 1, false);


--
-- Data for Name: hs_core_coremetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_coremetadata (id) FROM stdin;
\.


--
-- Name: hs_core_coremetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_coremetadata_id_seq', 1, false);


--
-- Data for Name: hs_core_coverage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_coverage (id, object_id, type, _value, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_coverage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_coverage_id_seq', 1, false);


--
-- Data for Name: hs_core_creator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_creator (id, object_id, description, name, organization, email, address, phone, homepage, "order", content_type_id) FROM stdin;
\.


--
-- Name: hs_core_creator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_creator_id_seq', 1, false);


--
-- Data for Name: hs_core_date; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_date (id, object_id, type, start_date, end_date, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_date_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_date_id_seq', 1, false);


--
-- Data for Name: hs_core_description; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_description (id, object_id, abstract, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_description_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_description_id_seq', 1, false);


--
-- Data for Name: hs_core_externalprofilelink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_externalprofilelink (id, type, url, object_id, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_externalprofilelink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_externalprofilelink_id_seq', 1, false);


--
-- Data for Name: hs_core_format; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_format (id, object_id, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_format_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_format_id_seq', 1, false);


--
-- Data for Name: hs_core_fundingagency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_fundingagency (id, object_id, agency_name, award_title, award_number, agency_url, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_fundingagency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_fundingagency_id_seq', 1, false);


--
-- Data for Name: hs_core_genericresource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_genericresource (page_ptr_id, rating_count, rating_sum, rating_average, content, short_id, doi, object_id, content_type_id, creator_id, last_changed_by_id, user_id, resource_type, file_unpack_message, file_unpack_status, locked_time, extra_metadata, resource_federation_path, extra_data) FROM stdin;
\.


--
-- Data for Name: hs_core_genericresource_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_genericresource_collections (id, from_baseresource_id, to_baseresource_id) FROM stdin;
\.


--
-- Name: hs_core_genericresource_collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_genericresource_collections_id_seq', 1, false);


--
-- Data for Name: hs_core_groupownership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_groupownership (id, group_id, owner_id) FROM stdin;
\.


--
-- Name: hs_core_groupownership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_groupownership_id_seq', 1, false);


--
-- Data for Name: hs_core_identifier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_identifier (id, object_id, name, url, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_identifier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_identifier_id_seq', 1, false);


--
-- Data for Name: hs_core_language; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_language (id, object_id, code, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_language_id_seq', 1, false);


--
-- Data for Name: hs_core_publisher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_publisher (id, object_id, name, url, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_publisher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_publisher_id_seq', 1, false);


--
-- Data for Name: hs_core_relation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_relation (id, object_id, type, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_relation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_relation_id_seq', 1, false);


--
-- Data for Name: hs_core_resourcefile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_resourcefile (id, object_id, resource_file, content_type_id, fed_resource_file, file_folder, logical_file_content_type_id, logical_file_object_id) FROM stdin;
\.


--
-- Name: hs_core_resourcefile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_resourcefile_id_seq', 1, false);


--
-- Data for Name: hs_core_rights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_rights (id, object_id, statement, url, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_rights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_rights_id_seq', 1, false);


--
-- Data for Name: hs_core_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_source (id, object_id, derived_from, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_source_id_seq', 1, false);


--
-- Data for Name: hs_core_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_subject (id, object_id, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_subject_id_seq', 1, false);


--
-- Data for Name: hs_core_title; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_title (id, object_id, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_title_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_title_id_seq', 1, false);


--
-- Data for Name: hs_core_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_core_type (id, object_id, url, content_type_id) FROM stdin;
\.


--
-- Name: hs_core_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_core_type_id_seq', 1, false);


--
-- Data for Name: hs_file_types_genericfilemetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_file_types_genericfilemetadata (id, extra_metadata, keywords, is_dirty) FROM stdin;
\.


--
-- Name: hs_file_types_genericfilemetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_file_types_genericfilemetadata_id_seq', 1, false);


--
-- Data for Name: hs_file_types_genericlogicalfile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_file_types_genericlogicalfile (id, dataset_name, metadata_id) FROM stdin;
\.


--
-- Name: hs_file_types_genericlogicalfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_file_types_genericlogicalfile_id_seq', 1, false);


--
-- Data for Name: hs_file_types_georasterfilemetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_file_types_georasterfilemetadata (id, extra_metadata, keywords, is_dirty) FROM stdin;
\.


--
-- Name: hs_file_types_georasterfilemetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_file_types_georasterfilemetadata_id_seq', 1, false);


--
-- Data for Name: hs_file_types_georasterlogicalfile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_file_types_georasterlogicalfile (id, dataset_name, metadata_id) FROM stdin;
\.


--
-- Name: hs_file_types_georasterlogicalfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_file_types_georasterlogicalfile_id_seq', 1, false);


--
-- Data for Name: hs_file_types_netcdffilemetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_file_types_netcdffilemetadata (id, extra_metadata, keywords, is_dirty) FROM stdin;
\.


--
-- Name: hs_file_types_netcdffilemetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_file_types_netcdffilemetadata_id_seq', 1, false);


--
-- Data for Name: hs_file_types_netcdflogicalfile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_file_types_netcdflogicalfile (id, dataset_name, metadata_id) FROM stdin;
\.


--
-- Name: hs_file_types_netcdflogicalfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_file_types_netcdflogicalfile_id_seq', 1, false);


--
-- Data for Name: hs_geo_raster_resource_bandinformation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geo_raster_resource_bandinformation (id, object_id, name, "variableName", "variableUnit", method, comment, content_type_id, "maximumValue", "minimumValue", "noDataValue") FROM stdin;
\.


--
-- Name: hs_geo_raster_resource_bandinformation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_geo_raster_resource_bandinformation_id_seq', 1, false);


--
-- Data for Name: hs_geo_raster_resource_cellinformation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geo_raster_resource_cellinformation (id, object_id, name, rows, columns, "cellSizeXValue", "cellSizeYValue", "cellDataType", content_type_id) FROM stdin;
\.


--
-- Name: hs_geo_raster_resource_cellinformation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_geo_raster_resource_cellinformation_id_seq', 1, false);


--
-- Data for Name: hs_geo_raster_resource_originalcoverage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geo_raster_resource_originalcoverage (id, object_id, _value, content_type_id) FROM stdin;
\.


--
-- Name: hs_geo_raster_resource_originalcoverage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_geo_raster_resource_originalcoverage_id_seq', 1, false);


--
-- Data for Name: hs_geo_raster_resource_rastermetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geo_raster_resource_rastermetadata (coremetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_geographic_feature_resource_fieldinformation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geographic_feature_resource_fieldinformation (id, object_id, "fieldName", "fieldType", "fieldTypeCode", "fieldWidth", "fieldPrecision", content_type_id) FROM stdin;
\.


--
-- Name: hs_geographic_feature_resource_fieldinformation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_geographic_feature_resource_fieldinformation_id_seq', 1, false);


--
-- Data for Name: hs_geographic_feature_resource_geographicfeaturemetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geographic_feature_resource_geographicfeaturemetadata (coremetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_geographic_feature_resource_geometryinformation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geographic_feature_resource_geometryinformation (id, object_id, "featureCount", "geometryType", content_type_id) FROM stdin;
\.


--
-- Name: hs_geographic_feature_resource_geometryinformation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_geographic_feature_resource_geometryinformation_id_seq', 1, false);


--
-- Data for Name: hs_geographic_feature_resource_originalcoverage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geographic_feature_resource_originalcoverage (id, object_id, northlimit, southlimit, westlimit, eastlimit, projection_string, projection_name, datum, unit, content_type_id) FROM stdin;
\.


--
-- Name: hs_geographic_feature_resource_originalcoverage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_geographic_feature_resource_originalcoverage_id_seq', 1, false);


--
-- Data for Name: hs_geographic_feature_resource_originalfileinfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_geographic_feature_resource_originalfileinfo (id, object_id, "fileType", "baseFilename", "fileCount", "filenameString", content_type_id) FROM stdin;
\.


--
-- Name: hs_geographic_feature_resource_originalfileinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_geographic_feature_resource_originalfileinfo_id_seq', 1, false);


--
-- Data for Name: hs_labels_resourcelabels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_labels_resourcelabels (id, resource_id) FROM stdin;
\.


--
-- Name: hs_labels_resourcelabels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_labels_resourcelabels_id_seq', 1, false);


--
-- Data for Name: hs_labels_userlabels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_labels_userlabels (id, user_id) FROM stdin;
1	4
\.


--
-- Name: hs_labels_userlabels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_labels_userlabels_id_seq', 3, true);


--
-- Data for Name: hs_labels_userresourceflags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_labels_userresourceflags (id, kind, start, resource_id, user_id) FROM stdin;
\.


--
-- Name: hs_labels_userresourceflags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_labels_userresourceflags_id_seq', 1, false);


--
-- Data for Name: hs_labels_userresourcelabels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_labels_userresourcelabels (id, start, label, resource_id, user_id) FROM stdin;
\.


--
-- Name: hs_labels_userresourcelabels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_labels_userresourcelabels_id_seq', 1, false);


--
-- Data for Name: hs_labels_userstoredlabels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_labels_userstoredlabels (id, label, user_id) FROM stdin;
\.


--
-- Name: hs_labels_userstoredlabels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_labels_userstoredlabels_id_seq', 1, false);


--
-- Data for Name: hs_model_program_modelprogrammetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_model_program_modelprogrammetadata (coremetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_model_program_mpmetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_model_program_mpmetadata (id, object_id, content_type_id, "modelCodeRepository", "modelDocumentation", "modelOperatingSystem", "modelProgramLanguage", "modelReleaseDate", "modelReleaseNotes", "modelSoftware", "modelVersion", "modelWebsite", "modelEngine") FROM stdin;
\.


--
-- Name: hs_model_program_mpmetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_model_program_mpmetadata_id_seq', 1, false);


--
-- Data for Name: hs_modelinstance_executedby; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modelinstance_executedby (id, object_id, model_name, content_type_id, model_program_fk_id) FROM stdin;
\.


--
-- Name: hs_modelinstance_executedby_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modelinstance_executedby_id_seq', 1, false);


--
-- Data for Name: hs_modelinstance_modelinstancemetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modelinstance_modelinstancemetadata (coremetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_modelinstance_modeloutput; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modelinstance_modeloutput (id, object_id, includes_output, content_type_id) FROM stdin;
\.


--
-- Name: hs_modelinstance_modeloutput_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modelinstance_modeloutput_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_boundarycondition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_boundarycondition (id, object_id, other_specified_head_boundary_packages, other_specified_flux_boundary_packages, other_head_dependent_flux_boundary_packages, content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_boundarycondition_head_dependen_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14 (id, boundarycondition_id, headdependentfluxboundarypackagechoices_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_boundarycondition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_boundarycondition_id_seq', 1, false);


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_boundarycondition_specified_flu_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3 (id, boundarycondition_id, specifiedfluxboundarypackagechoices_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_boundarycondition_specified_hea_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_boundarycondition_specified_head_b132e; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_boundarycondition_specified_head_b132e (id, boundarycondition_id, specifiedheadboundarypackagechoices_id) FROM stdin;
\.


--
-- Data for Name: hs_modflow_modelinstance_generalelements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_generalelements (id, object_id, "modelParameter", "modelSolver", "subsidencePackage", content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_generalelements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_generalelements_id_seq', 1, false);


--
-- Name: hs_modflow_modelinstance_generalelements_output_control__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_generalelements_output_control__id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_generalelements_output_control_package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_generalelements_output_control_package (id, generalelements_id, outputcontrolpackagechoices_id) FROM stdin;
\.


--
-- Data for Name: hs_modflow_modelinstance_griddimensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_griddimensions (id, object_id, "numberOfLayers", "typeOfRows", "numberOfRows", "typeOfColumns", "numberOfColumns", content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_griddimensions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_griddimensions_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_groundwaterflow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_groundwaterflow (id, object_id, "flowPackage", "flowParameter", content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_groundwaterflow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_groundwaterflow_id_seq', 1, false);


--
-- Name: hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_headdependentfluxboundarypackag_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_headdependentfluxboundarypackagechf906; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_headdependentfluxboundarypackagechf906 (id, description) FROM stdin;
\.


--
-- Data for Name: hs_modflow_modelinstance_modelcalibration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_modelcalibration (id, object_id, "calibratedParameter", "observationType", "observationProcessPackage", "calibrationMethod", content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_modelcalibration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_modelcalibration_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_modelinput; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_modelinput (id, object_id, "inputType", "inputSourceName", "inputSourceURL", content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_modelinput_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_modelinput_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_modflowmodelinstancemetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_modflowmodelinstancemetadata (modelinstancemetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_modflow_modelinstance_outputcontrolpackagechoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_outputcontrolpackagechoices (id, description) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_outputcontrolpackagechoices_id_seq', 1, false);


--
-- Name: hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_specifiedfluxboundarypackagecho_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_specifiedfluxboundarypackagechoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_specifiedfluxboundarypackagechoices (id, description) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_specifiedheadboundarypackagecho_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_specifiedheadboundarypackagechoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_specifiedheadboundarypackagechoices (id, description) FROM stdin;
\.


--
-- Data for Name: hs_modflow_modelinstance_stressperiod; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_stressperiod (id, object_id, "stressPeriodType", "steadyStateValue", "transientStateValueType", "transientStateValue", content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_stressperiod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_stressperiod_id_seq', 1, false);


--
-- Data for Name: hs_modflow_modelinstance_studyarea; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_modflow_modelinstance_studyarea (id, object_id, "totalLength", "totalWidth", "maximumElevation", "minimumElevation", content_type_id) FROM stdin;
\.


--
-- Name: hs_modflow_modelinstance_studyarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_modflow_modelinstance_studyarea_id_seq', 1, false);


--
-- Data for Name: hs_script_resource_scriptmetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_script_resource_scriptmetadata (coremetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_script_resource_scriptspecificmetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_script_resource_scriptspecificmetadata (id, object_id, "scriptLanguage", "languageVersion", "scriptVersion", "scriptDependencies", "scriptReleaseDate", "scriptCodeRepository", content_type_id) FROM stdin;
\.


--
-- Name: hs_script_resource_scriptspecificmetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_script_resource_scriptspecificmetadata_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_modelinput; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelinput (id, object_id, "warmupPeriodValue", "rainfallTimeStepType", "rainfallTimeStepValue", "routingTimeStepType", "routingTimeStepValue", "simulationTimeStepType", "simulationTimeStepValue", "watershedArea", "numberOfSubbasins", "numberOfHRUs", "demResolution", "demSourceName", "demSourceURL", "landUseDataSourceName", "landUseDataSourceURL", "soilDataSourceName", "soilDataSourceURL", content_type_id) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_modelinput_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelinput_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_modelmethod; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelmethod (id, object_id, "runoffCalculationMethod", "petEstimationMethod", "flowRoutingMethod", content_type_id) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_modelmethod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelmethod_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_modelobjective; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelobjective (id, object_id, other_objectives, content_type_id) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_modelobjective_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelobjective_id_seq', 1, false);


--
-- Name: hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelobjective_swat_model_objectiv_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_modelobjective_swat_model_objectives; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelobjective_swat_model_objectives (id, modelobjective_id, modelobjectivechoices_id) FROM stdin;
\.


--
-- Data for Name: hs_swat_modelinstance_modelobjectivechoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelobjectivechoices (id, description) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_modelobjectivechoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelobjectivechoices_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_modelparameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelparameter (id, object_id, other_parameters, content_type_id) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_modelparameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelparameter_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_modelparameter_model_parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelparameter_model_parameters (id, modelparameter_id, modelparameterschoices_id) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_modelparameter_model_parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelparameter_model_parameters_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_modelparameterschoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_modelparameterschoices (id, description) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_modelparameterschoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_modelparameterschoices_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_simulationtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_simulationtype (id, object_id, simulation_type_name, content_type_id) FROM stdin;
\.


--
-- Name: hs_swat_modelinstance_simulationtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_swat_modelinstance_simulationtype_id_seq', 1, false);


--
-- Data for Name: hs_swat_modelinstance_swatmodelinstancemetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_swat_modelinstance_swatmodelinstancemetadata (modelinstancemetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_tools_resource_apphomepageurl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_apphomepageurl (id, object_id, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_tools_resource_apphomepageurl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_apphomepageurl_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_requesturlbase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_requesturlbase (id, object_id, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_tools_resource_requesturlbase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_requesturlbase_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_supportedrestypechoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_supportedrestypechoices (id, description) FROM stdin;
\.


--
-- Name: hs_tools_resource_supportedrestypechoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_supportedrestypechoices_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_supportedrestypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_supportedrestypes (id, object_id, content_type_id) FROM stdin;
\.


--
-- Name: hs_tools_resource_supportedrestypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_supportedrestypes_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_supportedrestypes_supported_res_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_supportedrestypes_supported_res_types (id, supportedrestypes_id, supportedrestypechoices_id) FROM stdin;
\.


--
-- Name: hs_tools_resource_supportedrestypes_supported_res_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_supportedrestypes_supported_res_types_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_supportedsharingstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_supportedsharingstatus (id, object_id, content_type_id) FROM stdin;
\.


--
-- Name: hs_tools_resource_supportedsharingstatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_supportedsharingstatus_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_supportedsharingstatus_sharing_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_supportedsharingstatus_sharing_status (id, supportedsharingstatus_id, supportedsharingstatuschoices_id) FROM stdin;
\.


--
-- Name: hs_tools_resource_supportedsharingstatus_sharing_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_supportedsharingstatus_sharing_status_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_supportedsharingstatuschoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_supportedsharingstatuschoices (id, description) FROM stdin;
\.


--
-- Name: hs_tools_resource_supportedsharingstatuschoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_supportedsharingstatuschoices_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_toolicon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_toolicon (id, object_id, content_type_id, value, data_url) FROM stdin;
\.


--
-- Name: hs_tools_resource_toolicon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_toolicon_id_seq', 1, false);


--
-- Data for Name: hs_tools_resource_toolmetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_toolmetadata (coremetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: hs_tools_resource_toolversion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tools_resource_toolversion (id, object_id, value, content_type_id) FROM stdin;
\.


--
-- Name: hs_tools_resource_toolversion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tools_resource_toolversion_id_seq', 1, false);


--
-- Data for Name: hs_tracking_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tracking_session (id, begin, visitor_id) FROM stdin;
1	2016-06-23 17:06:32.174288+00	1
2	2016-06-23 17:07:55.65815+00	2
3	2017-02-02 16:16:56.853803+00	3
4	2017-02-02 17:23:27.983199+00	1
5	2017-02-02 17:27:56.526549+00	1
6	2017-02-02 17:28:40.81141+00	6
7	2017-05-05 13:43:41.852248+00	1
8	2017-07-26 17:31:09.012614+00	1
9	2017-07-26 18:24:36.55158+00	1
10	2017-07-26 18:24:36.603147+00	9
11	2017-07-26 18:56:36.900837+00	1
12	2017-08-01 15:06:57.040757+00	1
13	2017-08-01 15:08:28.330869+00	1
14	2017-08-01 15:08:56.548879+00	13
15	2017-08-01 22:18:24.229911+00	15
16	2017-08-01 22:18:24.228747+00	14
17	2017-08-01 22:18:24.232636+00	16
18	2017-08-01 22:18:24.235496+00	20
19	2017-08-01 22:18:24.23657+00	17
20	2017-08-01 22:18:24.236907+00	18
21	2017-08-01 22:18:24.250344+00	19
22	2017-08-01 22:20:01.609491+00	23
23	2017-08-01 22:20:01.612442+00	21
24	2017-08-01 22:20:01.619534+00	22
25	2017-08-01 22:20:01.660503+00	24
26	2017-08-01 22:20:01.678845+00	25
27	2017-08-01 22:20:01.692337+00	26
28	2017-08-01 22:20:01.699771+00	27
29	2017-08-01 22:20:01.715426+00	28
48	2017-08-01 22:35:21.632924+00	1
49	2017-08-01 22:55:09.249235+00	1
50	2017-08-01 22:57:27.716217+00	1
51	2017-08-01 23:30:15.036533+00	1
52	2017-08-02 00:27:49.302082+00	1
53	2017-08-02 00:27:58.570031+00	50
54	2017-08-02 16:03:16.519147+00	51
55	2017-08-02 17:48:37.957021+00	52
56	2017-08-02 18:13:16.609735+00	1
57	2017-08-02 18:57:12.998277+00	54
58	2017-08-02 19:21:07.085876+00	55
59	2017-08-03 19:56:41.5116+00	56
60	2017-08-03 20:56:42.607734+00	57
61	2017-08-07 15:09:29.572321+00	1
62	2017-08-07 16:49:37.574983+00	1
63	2017-08-07 19:42:20.503814+00	1
64	2017-08-07 19:44:04.909751+00	1
65	2017-08-07 19:55:52.421045+00	60
66	2017-08-08 15:32:15.476393+00	1
67	2017-08-08 19:16:58.745314+00	1
68	2017-08-08 19:16:58.811246+00	61
69	2017-08-08 21:51:28.647112+00	1
70	2017-08-23 17:58:43.861718+00	63
71	2017-08-24 20:14:44.788983+00	1
72	2017-08-24 20:59:02.287428+00	1
73	2017-08-24 21:00:42.829495+00	65
74	2017-08-25 17:35:32.623047+00	66
75	2017-08-28 14:57:39.403937+00	67
76	2017-08-28 15:02:25.10912+00	68
77	2017-08-30 16:44:29.723119+00	1
78	2017-08-30 16:55:27.838407+00	1
79	2017-08-30 17:00:10.427984+00	1
80	2017-08-30 17:10:02.684951+00	72
81	2017-08-30 17:47:16.754368+00	1
83	2017-08-30 17:50:00.314598+00	1
84	2017-08-30 19:04:12.325776+00	1
85	2017-08-30 19:04:22.919634+00	1
87	2017-08-30 19:06:23.510376+00	1
88	2017-08-30 20:29:05.109684+00	1
89	2017-08-30 20:31:55.864746+00	79
90	2017-08-31 14:06:20.469848+00	1
91	2017-08-31 19:14:35.651705+00	1
92	2017-08-31 20:14:22.55008+00	1
93	2017-08-31 20:41:35.525356+00	1
94	2017-09-01 18:13:18.421745+00	1
95	2017-09-01 19:47:49.092434+00	1
96	2017-09-01 20:57:41.655194+00	1
97	2017-09-01 21:07:14.535131+00	1
98	2017-09-01 21:08:56.02578+00	82
99	2017-09-01 22:04:20.536635+00	83
100	2017-09-05 14:18:28.416177+00	84
101	2017-09-07 20:02:16.951462+00	1
102	2017-09-11 04:07:40.002769+00	1
103	2017-09-11 05:23:10.352444+00	1
104	2017-09-11 05:23:45.095113+00	86
\.


--
-- Name: hs_tracking_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tracking_session_id_seq', 104, true);


--
-- Data for Name: hs_tracking_variable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tracking_variable (id, "timestamp", name, type, value, session_id) FROM stdin;
1	2016-06-23 17:06:32.176345+00	begin_session	4	none	1
2	2016-06-23 17:06:32.178545+00	visit	2	/admin/login/	1
3	2016-06-23 17:06:35.724699+00	visit	2	/admin/	1
4	2016-06-23 17:06:39.943401+00	visit	2	/admin/pages/page/	1
5	2016-06-23 17:06:40.044229+00	visit	2	/admin/jsi18n/	1
6	2016-06-23 17:06:42.609026+00	visit	2	/admin/pages/richtextpage/add/	1
7	2016-06-23 17:06:42.678194+00	visit	2	/admin/jsi18n/	1
8	2016-06-23 17:07:03.948786+00	visit	2	/admin_keywords_submit/	1
9	2016-06-23 17:07:04.469555+00	visit	2	/admin/pages/page/	1
10	2016-06-23 17:07:04.503762+00	visit	2	/admin/jsi18n/	1
11	2016-06-23 17:07:12.764509+00	visit	2	/admin_page_ordering/	1
12	2016-06-23 17:07:31.574614+00	visit	2	/admin_page_ordering/	1
13	2016-06-23 17:07:40.236028+00	visit	2	/	1
14	2016-06-23 17:07:55.65976+00	begin_session	4	none	2
15	2016-06-23 17:07:55.661515+00	visit	2	/	2
16	2016-06-23 17:17:35.201336+00	visit	2	/	2
17	2016-06-23 17:17:37.904373+00	visit	2	/accounts/login/	2
18	2016-06-23 17:17:48.822462+00	visit	2	/help/	2
19	2016-06-23 17:17:53.399003+00	visit	2	/accounts/login/	2
20	2016-06-23 17:17:57.673472+00	visit	2	/search/	2
21	2016-06-23 17:17:59.819554+00	visit	2	/	2
22	2017-02-02 16:16:56.855351+00	begin_session	4	none	3
23	2017-02-02 16:16:56.856808+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	3
24	2017-02-02 16:17:02.82735+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/robots.txt	3
25	2017-02-02 17:23:27.986851+00	begin_session	4	none	4
26	2017-02-02 17:23:27.990782+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/robots.txt	4
27	2017-02-02 17:23:31.342204+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	4
28	2017-02-02 17:24:38.198471+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/login/	4
29	2017-02-02 17:24:42.204342+00	login	4	none	4
30	2017-02-02 17:24:42.340796+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	4
31	2017-02-02 17:24:54.087076+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	4
32	2017-02-02 17:24:54.160685+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
33	2017-02-02 17:24:55.856132+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/1/	4
34	2017-02-02 17:24:55.901448+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
35	2017-02-02 17:25:53.90589+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	4
36	2017-02-02 17:25:53.937875+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
37	2017-02-02 17:25:56.282825+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	4
38	2017-02-02 17:25:56.311809+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
39	2017-02-02 17:25:57.523103+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/1/	4
40	2017-02-02 17:25:57.555392+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
41	2017-02-02 17:26:10.302942+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	4
42	2017-02-02 17:26:10.334185+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
43	2017-02-02 17:26:11.566495+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/1/	4
44	2017-02-02 17:26:11.598047+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
45	2017-02-02 17:26:32.836314+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	4
46	2017-02-02 17:26:32.867675+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
47	2017-02-02 17:26:34.341114+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/1/	4
48	2017-02-02 17:26:34.37208+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
49	2017-02-02 17:26:48.146126+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	4
50	2017-02-02 17:26:48.189508+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
51	2017-02-02 17:26:50.025204+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/1/	4
52	2017-02-02 17:26:50.056122+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
53	2017-02-02 17:27:30.617921+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	4
54	2017-02-02 17:27:30.663401+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	4
55	2017-02-02 17:27:38.952301+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	4
56	2017-02-02 17:27:40.825451+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/help/	4
57	2017-02-02 17:27:43.346591+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	4
58	2017-02-02 17:27:44.583727+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	4
59	2017-02-02 17:27:46.165948+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/search/	4
60	2017-02-02 17:27:47.261057+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/collaborate/	4
61	2017-02-02 17:27:51.150329+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	4
62	2017-02-02 17:27:52.430797+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	4
63	2017-02-02 17:27:56.42667+00	logout	4	none	4
64	2017-02-02 17:27:56.528123+00	begin_session	4	none	5
65	2017-02-02 17:27:56.529615+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	5
66	2017-02-02 17:28:07.807214+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/login/	5
67	2017-02-02 17:28:12.325126+00	login	4	none	5
68	2017-02-02 17:28:12.448623+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	5
69	2017-02-02 17:28:28.298125+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/robots/rule/	5
70	2017-02-02 17:28:28.332412+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	5
71	2017-02-02 17:28:30.150827+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/robots/url/	5
72	2017-02-02 17:28:30.180193+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	5
73	2017-02-02 17:28:38.218862+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	5
74	2017-02-02 17:28:40.710661+00	logout	4	none	5
75	2017-02-02 17:28:40.81281+00	begin_session	4	none	6
76	2017-02-02 17:28:40.814548+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	6
77	2017-05-05 13:43:41.853727+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	7
78	2017-05-05 13:43:41.855266+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	7
79	2017-05-05 13:43:45.585703+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	7
80	2017-05-05 13:43:51.029905+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	7
81	2017-05-05 13:43:51.133028+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	7
82	2017-05-05 13:44:00.211724+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	7
83	2017-05-05 13:44:05.248595+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
84	2017-05-05 13:44:05.303099+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
85	2017-05-05 13:44:08.980437+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	7
86	2017-05-05 13:44:09.03879+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
87	2017-05-05 13:44:48.768412+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	7
88	2017-05-05 13:44:49.032345+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	7
89	2017-05-05 13:44:49.080507+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
90	2017-05-05 13:47:22.753596+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	7
91	2017-05-05 13:47:23.105793+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
92	2017-05-05 13:47:23.168256+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
93	2017-05-05 13:47:27.280254+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/3/	7
94	2017-05-05 13:47:27.34037+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
95	2017-05-05 13:47:48.585224+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
96	2017-05-05 13:47:59.344877+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/4/	7
97	2017-05-05 13:47:59.405058+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
98	2017-05-05 13:48:13.538811+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
99	2017-05-05 13:48:13.586145+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
100	2017-05-05 13:48:18.744687+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/4/	7
101	2017-05-05 13:48:18.798374+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
102	2017-05-05 13:48:29.287553+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
103	2017-05-05 13:48:29.34512+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
104	2017-05-05 13:48:32.489829+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	7
105	2017-05-05 13:48:32.543173+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
106	2017-05-05 13:49:03.739814+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	7
107	2017-05-05 13:49:04.092741+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
108	2017-05-05 13:49:04.147509+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
109	2017-05-05 13:49:08.788916+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	7
110	2017-05-05 13:49:15.98142+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
111	2017-05-05 13:49:16.663399+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/4/	7
112	2017-05-05 13:49:17.547584+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
113	2017-05-05 13:49:18.242485+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/4/	7
114	2017-05-05 13:49:19.187231+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
115	2017-05-05 13:49:30.619389+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
116	2017-05-05 13:49:35.672673+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
117	2017-05-05 13:49:35.711799+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
118	2017-05-05 13:49:38.329731+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	7
119	2017-05-05 13:49:58.739124+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
120	2017-05-05 13:49:58.790091+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
121	2017-05-05 13:50:02.460983+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	7
122	2017-05-05 13:50:02.509291+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
123	2017-05-05 13:50:18.132463+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
124	2017-05-05 13:50:22.057313+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/3/	7
125	2017-05-05 13:50:22.114237+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
126	2017-05-05 13:50:25.083021+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/3/	7
127	2017-05-05 13:50:25.130216+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
128	2017-05-05 13:50:51.812696+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
129	2017-05-05 13:50:51.869842+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
130	2017-05-05 13:50:55.913616+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/4/	7
131	2017-05-05 13:50:55.961863+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
132	2017-05-05 13:51:00.778112+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
133	2017-05-05 13:51:00.824155+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
134	2017-05-05 13:51:03.244391+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/13/	7
135	2017-05-05 13:51:03.291892+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
136	2017-05-05 13:51:10.798729+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
137	2017-05-05 13:51:10.853857+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
138	2017-05-05 13:51:13.171674+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/link/6/	7
139	2017-05-05 13:51:13.224516+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
140	2017-05-05 13:52:11.917576+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
141	2017-05-05 13:52:11.963161+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
142	2017-05-05 13:52:15.156689+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/13/	7
143	2017-05-05 13:52:15.20073+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
144	2017-05-05 13:52:18.172027+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
145	2017-05-05 13:52:18.228086+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
146	2017-05-05 13:52:23.716799+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/link/6/	7
147	2017-05-05 13:52:23.763331+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
148	2017-05-05 13:52:27.949419+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
149	2017-05-05 13:52:27.998948+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
150	2017-05-05 13:52:32.584181+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/5/	7
151	2017-05-05 13:52:32.632268+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
152	2017-05-05 13:52:35.036808+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
153	2017-05-05 13:52:35.086548+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
154	2017-05-05 13:52:36.773666+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/link/6/	7
155	2017-05-05 13:52:36.817275+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
156	2017-05-05 13:52:42.024719+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
157	2017-05-05 13:52:42.076119+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
158	2017-05-05 13:52:44.527298+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/5/	7
159	2017-05-05 13:52:44.585026+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
160	2017-05-05 13:52:48.292251+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
161	2017-05-05 13:52:48.343992+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
162	2017-05-05 13:52:50.890654+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/7/	7
163	2017-05-05 13:52:50.94915+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
164	2017-05-05 13:54:23.795211+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	7
165	2017-05-05 13:54:24.1916+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
166	2017-05-05 13:54:24.243408+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
167	2017-05-05 13:54:27.799159+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/7/	7
168	2017-05-05 13:54:27.847815+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
169	2017-05-05 13:54:30.966698+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
170	2017-05-05 13:54:31.020196+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
171	2017-05-05 13:54:33.427147+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/forms/form/8/	7
172	2017-05-05 13:54:33.482389+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
173	2017-05-05 13:54:53.681968+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
174	2017-05-05 13:54:53.737525+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
175	2017-05-05 13:55:06.963533+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/forms/form/8/	7
176	2017-05-05 13:55:07.019789+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
177	2017-05-05 13:55:10.738828+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
178	2017-05-05 13:55:21.129216+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/forms/form/8/	7
179	2017-05-05 13:55:21.191685+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
180	2017-05-05 13:55:27.456913+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
181	2017-05-05 13:55:27.509513+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
182	2017-05-05 13:55:30.011032+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/9/	7
183	2017-05-05 13:55:30.076627+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
184	2017-05-05 14:08:48.323384+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	7
185	2017-05-05 14:08:48.670997+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
186	2017-05-05 14:08:48.722271+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
187	2017-05-05 14:08:51.394672+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/10/	7
188	2017-05-05 14:08:51.445102+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
189	2017-05-05 14:13:10.126391+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	7
190	2017-05-05 14:13:10.456163+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
191	2017-05-05 14:13:10.522541+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
192	2017-05-05 14:13:15.837257+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/9/	7
193	2017-05-05 14:13:15.893944+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
194	2017-05-05 14:13:32.111637+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
195	2017-05-05 14:13:32.170547+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
196	2017-05-05 14:13:35.372859+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/11/	7
197	2017-05-05 14:13:35.430437+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
198	2017-05-05 14:13:40.72414+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	7
199	2017-05-05 14:13:40.788503+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
200	2017-05-05 14:13:42.511068+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/12/	7
201	2017-05-05 14:13:42.568646+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
202	2017-05-05 14:13:49.049127+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/sites/site/	7
203	2017-05-05 14:13:49.098894+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
204	2017-05-05 14:13:51.688423+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/blog/blogpost/	7
205	2017-05-05 14:13:51.731554+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
206	2017-05-05 14:13:53.299156+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/generic/threadedcomment/	7
207	2017-05-05 14:13:53.343254+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
208	2017-05-05 14:13:54.951611+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/media-library/browse/	7
209	2017-05-05 14:13:59.88942+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/media-library/rename/	7
210	2017-05-05 14:14:03.117046+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/media-library/browse/	7
211	2017-05-05 14:14:05.10835+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/media-library/browse/	7
212	2017-05-05 14:14:07.920611+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/media-library/browse/	7
213	2017-05-05 14:14:10.368129+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/sites/site/	7
214	2017-05-05 14:14:10.417396+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
215	2017-05-05 14:14:15.042297+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/sites/site/1/	7
216	2017-05-05 14:14:15.092063+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
217	2017-05-05 14:14:17.103009+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/sites/site/	7
218	2017-05-05 14:14:18.451576+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/redirects/redirect/	7
219	2017-05-05 14:14:18.493951+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
220	2017-05-05 14:14:20.809895+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/conf/setting/	7
221	2017-05-05 14:14:20.854303+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
222	2017-05-05 14:15:16.638573+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/sites/site/	7
223	2017-05-05 14:15:16.692813+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
224	2017-05-05 14:15:18.204349+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/redirects/redirect/	7
225	2017-05-05 14:15:18.248944+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
226	2017-05-05 14:15:19.556301+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/conf/setting/	7
227	2017-05-05 14:15:19.608698+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
228	2017-05-05 14:15:35.362452+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	7
229	2017-05-05 14:15:35.417085+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
230	2017-05-05 14:15:42.01467+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/4/	7
231	2017-05-05 14:15:42.061876+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
232	2017-05-05 14:16:27.717945+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	7
233	2017-05-05 14:16:27.766535+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
234	2017-05-05 14:16:29.228224+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	7
235	2017-05-05 14:16:29.269878+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
236	2017-05-05 14:16:32.621664+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/1/	7
237	2017-05-05 14:16:32.668351+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
238	2017-05-05 14:16:51.613413+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	7
239	2017-05-05 14:16:51.660561+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
240	2017-05-05 14:16:56.094141+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	7
241	2017-05-05 14:16:56.136741+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
242	2017-05-05 14:17:00.824456+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	7
243	2017-05-05 14:17:00.867035+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
244	2017-05-05 14:17:04.155813+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	7
245	2017-05-05 14:17:04.205097+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
246	2017-05-05 14:17:07.493521+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/4/	7
247	2017-05-05 14:17:07.541823+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
248	2017-05-05 14:17:20.892518+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	7
249	2017-05-05 14:17:20.94119+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
250	2017-05-05 14:17:23.582906+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/1/	7
251	2017-05-05 14:17:23.631642+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
252	2017-05-05 14:17:43.110817+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/group/	7
253	2017-05-05 14:17:43.157939+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
254	2017-05-05 14:17:45.500007+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	7
255	2017-05-05 14:17:45.549392+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
256	2017-05-05 14:17:47.193115+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/4/	7
257	2017-05-05 14:17:47.244933+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
258	2017-05-05 14:18:01.971924+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/conf/setting/	7
259	2017-05-05 14:18:02.022821+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
260	2017-05-05 14:18:13.815811+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/oauth2_provider/accesstoken/	7
261	2017-05-05 14:18:13.864719+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
262	2017-05-05 14:18:16.504769+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/oauth2_provider/accesstoken/	7
263	2017-05-05 14:18:16.542874+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
264	2017-05-05 14:18:19.346291+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/oauth2_provider/application/	7
265	2017-05-05 14:18:19.393083+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
266	2017-05-05 14:18:20.854127+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/oauth2_provider/grant/	7
267	2017-05-05 14:18:20.907772+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
268	2017-05-05 14:18:22.509487+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/oauth2_provider/refreshtoken/	7
269	2017-05-05 14:18:22.55106+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
270	2017-05-05 14:18:25.098663+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/robots/rule/	7
271	2017-05-05 14:18:25.141839+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
272	2017-05-05 14:18:27.347767+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/robots/rule/	7
273	2017-05-05 14:18:27.386195+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
274	2017-05-05 14:18:29.161546+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/robots/url/	7
275	2017-05-05 14:18:29.209823+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
276	2017-05-05 14:18:34.440133+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/security/cspreport/	7
277	2017-05-05 14:18:34.481606+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
278	2017-05-05 14:18:38.079256+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/security/cspreport/	7
279	2017-05-05 14:18:38.120411+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
280	2017-05-05 14:18:42.512666+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/security/passwordexpiry/	7
281	2017-05-05 14:18:42.555206+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
282	2017-05-05 14:18:46.848188+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/quotamessage/add/	7
283	2017-05-05 14:18:46.896695+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
284	2017-05-05 14:20:45.609969+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	7
285	2017-05-05 14:20:51.229753+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/quotamessage/1/	7
286	2017-05-05 14:20:51.279809+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
287	2017-05-05 14:20:58.00192+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	7
288	2017-05-05 14:20:58.045984+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
289	2017-05-05 14:21:04.996446+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/userquota/	7
290	2017-05-05 14:21:05.045538+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
291	2017-05-05 14:21:09.837984+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	7
292	2017-05-05 14:21:09.893575+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	7
293	2017-05-05 14:24:29.356625+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	7
294	2017-07-26 17:31:09.014263+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	8
295	2017-07-26 17:31:09.016239+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	8
296	2017-07-26 17:41:54.794559+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/help/	8
297	2017-07-26 17:41:57.657977+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	8
298	2017-07-26 17:56:08.285256+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	8
299	2017-07-26 18:01:12.792136+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	8
300	2017-07-26 18:01:25.300191+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	8
301	2017-07-26 18:01:25.411202+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	8
302	2017-07-26 18:01:37.625382+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	8
303	2017-07-26 18:01:47.745036+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	8
304	2017-07-26 18:01:47.842586+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	8
305	2017-07-26 18:02:34.851896+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	8
306	2017-07-26 18:24:36.555432+00	begin_session	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	9
307	2017-07-26 18:24:36.557306+00	logout	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	9
308	2017-07-26 18:24:36.60436+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	10
309	2017-07-26 18:24:36.606287+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/logout/	10
310	2017-07-26 18:24:45.267249+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	10
311	2017-07-26 18:56:36.902457+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	11
312	2017-07-26 18:56:36.904584+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	11
313	2017-07-26 18:56:46.437019+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	11
314	2017-07-26 18:56:46.544814+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	11
315	2017-08-01 15:06:57.042512+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	12
316	2017-08-01 15:06:57.045161+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	12
317	2017-08-01 15:07:10.995866+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	12
318	2017-08-01 15:07:21.431805+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	12
319	2017-08-01 15:07:21.530151+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	12
320	2017-08-01 15:07:34.796952+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	12
321	2017-08-01 15:07:55.427995+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	12
322	2017-08-01 15:07:55.50393+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	12
323	2017-08-01 15:08:02.458851+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/link/6/	12
324	2017-08-01 15:08:02.514143+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	12
325	2017-08-01 15:08:20.247512+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	12
326	2017-08-01 15:08:20.295012+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	12
327	2017-08-01 15:08:28.287897+00	logout	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	12
328	2017-08-01 15:08:28.332899+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	13
329	2017-08-01 15:08:28.334584+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/logout/	13
330	2017-08-01 15:08:34.318152+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	13
331	2017-08-01 15:08:38.813627+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	13
332	2017-08-01 15:08:48.84354+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	13
333	2017-08-01 15:08:48.942074+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	13
334	2017-08-01 15:08:56.48372+00	logout	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	13
335	2017-08-01 15:08:56.550391+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	14
336	2017-08-01 15:08:56.552012+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	14
337	2017-08-01 15:15:25.287042+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	14
338	2017-08-01 22:18:24.23733+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	16
339	2017-08-01 22:18:24.235139+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	15
340	2017-08-01 22:18:24.239329+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	17
341	2017-08-01 22:18:24.243123+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	18
342	2017-08-01 22:18:24.243639+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	19
343	2017-08-01 22:18:24.245248+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	20
344	2017-08-01 22:18:24.246066+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	16
345	2017-08-01 22:18:24.248001+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	15
346	2017-08-01 22:18:24.24987+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	17
347	2017-08-01 22:18:24.253365+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	19
348	2017-08-01 22:18:24.252822+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	18
349	2017-08-01 22:18:24.257348+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	21
350	2017-08-01 22:18:24.255527+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	20
351	2017-08-01 22:18:24.265128+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	21
352	2017-08-01 22:20:01.623224+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	22
353	2017-08-01 22:20:01.622707+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	23
354	2017-08-01 22:20:01.629949+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	24
355	2017-08-01 22:20:01.628425+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	22
356	2017-08-01 22:20:01.631241+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	23
357	2017-08-01 22:20:01.635856+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	24
358	2017-08-01 22:20:01.670409+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	25
359	2017-08-01 22:20:01.681181+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	25
360	2017-08-01 22:20:01.684792+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	26
361	2017-08-01 22:20:01.689399+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	26
362	2017-08-01 22:20:01.695726+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	27
363	2017-08-01 22:20:01.702692+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	27
364	2017-08-01 22:20:01.707246+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	28
365	2017-08-01 22:20:01.713668+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	28
366	2017-08-01 22:20:01.720212+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	29
367	2017-08-01 22:20:01.722415+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	29
371	2017-08-01 22:35:21.636716+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	48
372	2017-08-01 22:35:21.640805+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	48
373	2017-08-01 22:35:37.332594+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	48
374	2017-08-01 22:35:44.319513+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	48
375	2017-08-01 22:35:44.4354+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	48
376	2017-08-01 22:37:54.526408+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	48
377	2017-08-01 22:37:54.538691+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	48
378	2017-08-01 22:38:42.777678+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	48
379	2017-08-01 22:38:42.781881+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	48
380	2017-08-01 22:38:42.799615+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	48
381	2017-08-01 22:38:42.817189+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	48
382	2017-08-01 22:38:42.834828+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	48
383	2017-08-01 22:38:42.838506+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/my-resources/	48
406	2017-08-01 22:45:06.204508+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	48
407	2017-08-01 22:45:20.884586+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	48
408	2017-08-01 22:45:31.125237+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	48
409	2017-08-01 22:45:31.264602+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	48
410	2017-08-01 22:45:41.089773+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	48
411	2017-08-01 22:45:41.207049+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	48
412	2017-08-01 22:54:57.294521+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	48
413	2017-08-01 22:54:57.730922+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	48
414	2017-08-01 22:54:57.802149+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	48
415	2017-08-01 22:55:03.323065+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	48
416	2017-08-01 22:55:09.15231+00	logout	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	48
417	2017-08-01 22:55:09.251591+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	49
418	2017-08-01 22:55:09.253215+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	49
419	2017-08-01 22:55:24.160406+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	49
420	2017-08-01 22:55:57.671379+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	49
421	2017-08-01 22:56:08.528873+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	49
422	2017-08-01 22:56:08.649233+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	49
423	2017-08-01 22:56:19.688568+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	49
424	2017-08-01 22:56:22.68591+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	49
425	2017-08-01 22:56:22.735664+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	49
426	2017-08-01 22:56:25.046554+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	49
427	2017-08-01 22:56:25.109669+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	49
428	2017-08-01 22:57:10.504173+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	49
429	2017-08-01 22:57:27.603357+00	logout	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	49
430	2017-08-01 22:57:27.71788+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	50
431	2017-08-01 22:57:27.719769+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	50
432	2017-08-01 22:57:32.605879+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	50
433	2017-08-01 22:57:38.768067+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	50
434	2017-08-01 22:57:47.654099+00	login	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	50
435	2017-08-01 22:57:47.766636+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	50
436	2017-08-01 22:57:53.270434+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	50
437	2017-08-01 22:58:12.966643+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
438	2017-08-01 22:58:13.028974+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
439	2017-08-01 22:58:14.519524+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	50
440	2017-08-01 22:58:14.596249+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
441	2017-08-01 23:06:15.585313+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	50
442	2017-08-01 23:06:15.989181+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
443	2017-08-01 23:06:16.046282+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
444	2017-08-01 23:06:30.167577+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/3/	50
445	2017-08-01 23:06:30.260508+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
446	2017-08-01 23:06:39.044094+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
447	2017-08-01 23:06:39.114596+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
448	2017-08-01 23:06:40.89484+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/4/	50
449	2017-08-01 23:06:40.95411+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
450	2017-08-01 23:06:51.535193+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
451	2017-08-01 23:06:51.59154+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
452	2017-08-01 23:06:53.727356+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/13/	50
453	2017-08-01 23:06:53.774325+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
454	2017-08-01 23:07:09.040125+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
455	2017-08-01 23:07:09.09804+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
456	2017-08-01 23:07:10.883455+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/link/6/	50
457	2017-08-01 23:07:10.927635+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
458	2017-08-01 23:07:32.304911+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
459	2017-08-01 23:07:32.354655+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
460	2017-08-01 23:07:34.767555+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/5/	50
461	2017-08-01 23:07:34.825703+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
462	2017-08-01 23:09:37.979946+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
463	2017-08-01 23:09:38.049104+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
464	2017-08-01 23:09:40.446105+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/5/	50
465	2017-08-01 23:09:40.503198+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
466	2017-08-01 23:09:43.270898+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
467	2017-08-01 23:09:43.327533+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
468	2017-08-01 23:09:46.413689+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/7/	50
469	2017-08-01 23:09:46.471554+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
470	2017-08-01 23:13:58.721014+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	50
471	2017-08-01 23:13:59.078575+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
472	2017-08-01 23:13:59.138227+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
473	2017-08-01 23:14:02.53053+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/forms/form/8/	50
474	2017-08-01 23:14:02.58675+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
475	2017-08-01 23:14:46.538678+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	50
476	2017-08-01 23:14:47.045791+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	50
477	2017-08-01 23:14:47.102445+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
478	2017-08-01 23:14:56.588074+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/9/	50
479	2017-08-01 23:14:56.65402+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	50
480	2017-08-01 23:30:15.040598+00	begin_session	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	51
481	2017-08-01 23:30:15.042088+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	51
482	2017-08-01 23:30:15.430713+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	51
483	2017-08-01 23:30:15.505634+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	51
484	2017-08-01 23:30:18.142471+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/10/	51
485	2017-08-01 23:30:18.195262+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	51
486	2017-08-01 23:33:15.51789+00	visit	2	user_ip=192.168.56.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin_keywords_submit/	51
487	2017-08-01 23:33:16.009887+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	51
488	2017-08-01 23:33:16.089665+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	51
489	2017-08-01 23:33:19.882454+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/11/	51
490	2017-08-01 23:33:19.946434+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	51
491	2017-08-01 23:33:24.251241+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	51
492	2017-08-01 23:33:24.328496+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	51
493	2017-08-01 23:33:26.337419+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/richtextpage/12/	51
494	2017-08-01 23:33:26.403437+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	51
495	2017-08-01 23:33:32.746886+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	51
496	2017-08-01 23:33:32.805428+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	51
497	2017-08-01 23:33:37.752056+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	51
498	2017-08-01 23:33:58.102647+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/terms-of-use/	51
499	2017-08-01 23:34:06.512784+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/privacy/	51
500	2017-08-01 23:34:19.81499+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/sitemap/	51
501	2017-08-02 00:27:49.306102+00	begin_session	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	52
502	2017-08-02 00:27:49.308321+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	52
503	2017-08-02 00:27:58.487021+00	logout	2	user_ip=192.168.56.1 user_type=Unspecified user_email_domain=com	52
504	2017-08-02 00:27:58.573143+00	begin_session	2	user_ip=192.168.56.1 user_type=None user_email_domain=None	53
505	2017-08-02 00:27:58.575546+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	53
506	2017-08-02 00:28:09.609802+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	53
507	2017-08-02 00:28:12.648245+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	53
508	2017-08-02 00:28:14.42111+00	visit	2	user_ip=192.168.56.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/search/	53
509	2017-08-02 16:03:16.522414+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	54
510	2017-08-02 16:03:16.528931+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	54
511	2017-08-02 17:48:37.958461+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	55
512	2017-08-02 17:48:37.9598+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	55
513	2017-08-02 17:50:00.951258+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	55
514	2017-08-02 17:50:36.800951+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	55
515	2017-08-02 17:50:47.010521+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	55
516	2017-08-02 18:13:16.61212+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	56
517	2017-08-02 18:13:16.614515+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	56
518	2017-08-02 18:20:05.942519+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	56
519	2017-08-02 18:24:32.625172+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	56
520	2017-08-02 18:31:23.027296+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	56
521	2017-08-02 18:39:47.318002+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	56
522	2017-08-02 18:42:40.306435+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	56
523	2017-08-02 18:54:35.202332+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	56
524	2017-08-02 18:55:27.719564+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	56
525	2017-08-02 18:55:36.227243+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	56
526	2017-08-02 18:55:36.342423+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	56
527	2017-08-02 18:55:52.409221+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/user/4/	56
528	2017-08-02 18:56:16.469985+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	56
529	2017-08-02 18:56:22.452756+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	56
530	2017-08-02 18:56:22.578226+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	56
531	2017-08-02 18:56:26.47921+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/blog/blogpost/	56
532	2017-08-02 18:56:26.518063+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	56
533	2017-08-02 18:56:27.735138+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/sites/site/	56
534	2017-08-02 18:56:27.775894+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	56
535	2017-08-02 18:56:28.84137+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/redirects/redirect/	56
536	2017-08-02 18:56:28.883258+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	56
537	2017-08-02 18:56:29.925927+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/conf/setting/	56
538	2017-08-02 18:56:29.971833+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	56
539	2017-08-02 18:56:43.31549+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	56
540	2017-08-02 18:56:43.377737+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	56
541	2017-08-02 18:57:04.819083+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	56
542	2017-08-02 18:57:12.927412+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	56
543	2017-08-02 18:57:12.999655+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	57
544	2017-08-02 18:57:13.001212+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	57
545	2017-08-02 18:57:28.931701+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	57
546	2017-08-02 19:01:35.423857+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	57
547	2017-08-02 19:01:40.38484+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	57
548	2017-08-02 19:02:43.143091+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	57
549	2017-08-02 19:02:44.943449+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	57
550	2017-08-02 19:21:07.088874+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	58
551	2017-08-02 19:21:07.09267+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	58
552	2017-08-02 19:25:39.271477+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	58
553	2017-08-02 19:31:02.394971+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	58
554	2017-08-02 19:32:23.649438+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	58
555	2017-08-02 19:32:59.787441+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	58
556	2017-08-02 19:40:47.358697+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	58
557	2017-08-03 19:56:41.514215+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	59
558	2017-08-03 19:56:41.515775+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	59
559	2017-08-03 20:56:42.610314+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	60
560	2017-08-03 20:56:42.612566+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	60
561	2017-08-07 15:09:29.573605+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	61
562	2017-08-07 15:09:29.575418+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	61
563	2017-08-07 15:15:40.446326+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	61
564	2017-08-07 15:28:08.3826+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	61
565	2017-08-07 15:28:16.060616+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	61
566	2017-08-07 15:28:26.690058+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	61
567	2017-08-07 15:28:26.804412+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	61
568	2017-08-07 15:28:39.264187+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	61
569	2017-08-07 16:49:37.578861+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	62
570	2017-08-07 16:49:37.580794+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	62
571	2017-08-07 16:49:37.644064+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	62
572	2017-08-07 16:49:41.64872+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	62
573	2017-08-07 16:49:41.731359+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	62
574	2017-08-07 16:50:36.398175+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/sites/site/	62
575	2017-08-07 16:50:36.449592+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	62
576	2017-08-07 16:50:39.007815+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/redirects/redirect/	62
577	2017-08-07 16:50:39.056776+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	62
578	2017-08-07 16:50:40.511384+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/conf/setting/	62
579	2017-08-07 16:50:40.566591+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	62
580	2017-08-07 17:05:17.773164+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	62
581	2017-08-07 17:05:17.816878+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	62
582	2017-08-07 19:42:20.507362+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	63
583	2017-08-07 19:42:20.508616+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	63
584	2017-08-07 19:44:04.873469+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	63
585	2017-08-07 19:44:04.911467+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	64
586	2017-08-07 19:44:04.91318+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/logout/	64
587	2017-08-07 19:44:18.117243+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	64
588	2017-08-07 19:53:11.47326+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	64
589	2017-08-07 19:53:21.680552+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	64
590	2017-08-07 19:53:21.787395+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	64
591	2017-08-07 19:53:31.663204+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	64
592	2017-08-07 19:53:39.207977+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	64
593	2017-08-07 19:53:39.278827+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	64
594	2017-08-07 19:55:17.783668+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	64
595	2017-08-07 19:55:25.245372+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	64
596	2017-08-07 19:55:52.422882+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	65
597	2017-08-07 19:55:52.424202+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/login/	65
598	2017-08-07 19:56:17.800198+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	64
599	2017-08-07 19:56:24.210381+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	64
600	2017-08-07 19:56:24.278293+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	64
601	2017-08-07 19:56:42.961668+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	64
602	2017-08-07 19:56:43.94559+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/siteconfiguration/1/	64
603	2017-08-07 19:56:45.847957+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	64
604	2017-08-07 19:56:48.84885+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	64
605	2017-08-07 19:58:17.496574+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	64
606	2017-08-08 15:32:15.487439+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	66
607	2017-08-08 15:32:15.489352+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	66
608	2017-08-08 19:16:58.748914+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	67
609	2017-08-08 19:16:58.750984+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	67
610	2017-08-08 19:16:58.813115+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	68
611	2017-08-08 19:16:58.815205+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	68
612	2017-08-08 19:18:44.818887+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	68
613	2017-08-08 21:51:28.649276+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	69
614	2017-08-08 21:51:28.651451+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	69
615	2017-08-08 21:51:46.696492+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	69
616	2017-08-08 21:51:55.533663+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=com	69
617	2017-08-08 21:51:55.639875+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/	69
618	2017-08-08 21:52:02.974279+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/	69
619	2017-08-08 21:52:05.838764+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	69
620	2017-08-08 21:52:05.915056+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
621	2017-08-08 21:52:25.849707+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	69
622	2017-08-08 21:52:25.911279+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
623	2017-08-08 21:52:27.869997+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/theme/homepage/2/	69
624	2017-08-08 21:52:27.932657+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
625	2017-08-08 21:52:33.592875+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/pages/page/	69
626	2017-08-08 21:52:33.636448+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
627	2017-08-08 21:52:35.01235+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/blog/blogpost/	69
628	2017-08-08 21:52:35.070515+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
629	2017-08-08 21:52:36.021604+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/generic/threadedcomment/	69
630	2017-08-08 21:52:36.073373+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
631	2017-08-08 21:52:37.074571+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/media-library/browse/	69
632	2017-08-08 21:52:38.47991+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	69
633	2017-08-08 21:52:38.519471+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
634	2017-08-08 21:52:41.105692+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/4/	69
635	2017-08-08 21:52:41.169581+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
636	2017-08-08 21:53:36.32926+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/	69
637	2017-08-08 21:53:36.398752+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
638	2017-08-08 21:54:45.387853+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/auth/user/4/	69
639	2017-08-08 21:54:45.44289+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=com request_url=/admin/jsi18n/	69
640	2017-08-08 21:55:05.590516+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	69
641	2017-08-08 21:55:05.641602+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	69
642	2017-08-23 17:58:43.863768+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	70
643	2017-08-23 17:58:43.865797+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	70
644	2017-08-24 20:14:44.792539+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	71
645	2017-08-24 20:14:44.797586+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	71
646	2017-08-24 20:17:22.870827+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	71
647	2017-08-24 20:21:03.365654+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	71
648	2017-08-24 20:24:08.408362+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	71
649	2017-08-24 20:24:15.122715+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	71
650	2017-08-24 20:24:15.220288+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	71
651	2017-08-24 20:24:24.428711+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-resources/	71
652	2017-08-24 20:24:26.163427+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/collaborate/	71
653	2017-08-24 20:24:28.540782+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/search/	71
654	2017-08-24 20:24:31.54473+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-resources/	71
655	2017-08-24 20:28:16.222139+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	71
656	2017-08-24 20:28:19.900113+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	71
657	2017-08-24 20:28:20.002357+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	71
658	2017-08-24 20:28:25.445392+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/homepage/2/	71
659	2017-08-24 20:28:25.540608+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	71
660	2017-08-24 20:28:38.606718+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	71
661	2017-08-24 20:28:56.882423+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/homepage/2/	71
662	2017-08-24 20:28:56.925666+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	71
663	2017-08-24 20:29:22.285023+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	71
664	2017-08-24 20:29:22.649123+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	71
665	2017-08-24 20:29:22.700107+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	71
666	2017-08-24 20:29:25.522365+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/homepage/2/	71
667	2017-08-24 20:29:25.587367+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	71
668	2017-08-24 20:59:02.301501+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	72
669	2017-08-24 20:59:02.303237+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	72
670	2017-08-24 20:59:20.068573+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	72
671	2017-08-24 21:00:11.882976+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	72
672	2017-08-24 21:00:11.933419+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	72
673	2017-08-24 21:00:14.528989+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/homepage/2/	72
674	2017-08-24 21:00:14.577676+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	72
675	2017-08-24 21:00:19.22208+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	72
676	2017-08-24 21:00:38.756243+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	72
677	2017-08-24 21:00:42.729352+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	72
678	2017-08-24 21:00:42.831248+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	73
679	2017-08-24 21:00:42.832715+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	73
680	2017-08-25 17:35:32.624616+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	74
681	2017-08-25 17:35:32.626322+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	74
682	2017-08-28 14:57:39.405651+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	75
683	2017-08-28 14:57:39.408165+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	75
684	2017-08-28 14:57:48.195674+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	75
685	2017-08-28 14:58:13.691695+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	75
686	2017-08-28 15:02:25.11158+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	76
687	2017-08-28 15:02:25.114282+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	76
688	2017-08-30 16:44:29.725107+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	77
689	2017-08-30 16:44:29.728089+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	77
690	2017-08-30 16:45:26.642945+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	77
691	2017-08-30 16:45:35.601334+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	77
692	2017-08-30 16:45:41.241651+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	77
693	2017-08-30 16:45:41.364807+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/collaborate/	77
694	2017-08-30 16:45:49.797049+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/search/	77
695	2017-08-30 16:45:54.826785+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-resources/	77
696	2017-08-30 16:54:30.359204+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	77
697	2017-08-30 16:54:46.606446+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	77
698	2017-08-30 16:54:46.720222+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	77
699	2017-08-30 16:54:50.671034+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/link/6/	77
700	2017-08-30 16:54:50.731141+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	77
701	2017-08-30 16:54:57.637218+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	77
702	2017-08-30 16:54:59.531851+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/4/	77
703	2017-08-30 16:54:59.608329+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	77
704	2017-08-30 16:55:07.539664+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	77
705	2017-08-30 16:55:07.925052+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	77
706	2017-08-30 16:55:07.97759+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	77
707	2017-08-30 16:55:27.793496+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	77
708	2017-08-30 16:55:27.839737+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	78
709	2017-08-30 16:55:27.841025+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/logout/	78
710	2017-08-30 16:58:57.996938+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	78
711	2017-08-30 16:59:01.538434+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	78
712	2017-08-30 16:59:10.73676+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	78
713	2017-08-30 16:59:28.313218+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	78
714	2017-08-30 16:59:36.8981+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	78
715	2017-08-30 16:59:36.999166+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	78
716	2017-08-30 16:59:45.934296+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	78
717	2017-08-30 16:59:49.892597+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	78
718	2017-08-30 16:59:49.957508+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	78
719	2017-08-30 17:00:10.385774+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	78
720	2017-08-30 17:00:10.429346+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	79
721	2017-08-30 17:00:10.430599+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/logout/	79
722	2017-08-30 17:00:18.979939+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	79
723	2017-08-30 17:00:22.527481+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/sign-up/	79
724	2017-08-30 17:01:10.711608+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	79
725	2017-08-30 17:09:32.978019+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	79
726	2017-08-30 17:09:40.820461+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	79
727	2017-08-30 17:09:40.951982+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	79
728	2017-08-30 17:09:49.191993+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	79
729	2017-08-30 17:09:52.566163+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	79
730	2017-08-30 17:09:52.640928+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	79
731	2017-08-30 17:10:02.643401+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	79
732	2017-08-30 17:10:02.68651+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	80
733	2017-08-30 17:10:02.687857+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/logout/	80
734	2017-08-30 17:10:08.617752+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	80
735	2017-08-30 17:47:16.756096+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	81
736	2017-08-30 17:47:16.758525+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	81
737	2017-08-30 17:48:05.908625+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	81
738	2017-08-30 17:48:06.053497+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	81
739	2017-08-30 17:48:12.947563+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	81
740	2017-08-30 17:48:16.326318+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	81
741	2017-08-30 17:48:16.396917+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	81
742	2017-08-30 17:48:21.956492+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	81
743	2017-08-30 17:48:26.25075+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	81
744	2017-08-30 17:48:26.317086+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	81
745	2017-08-30 17:48:29.102398+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	81
754	2017-08-30 17:50:00.316004+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	83
755	2017-08-30 17:50:00.317603+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	83
756	2017-08-30 17:55:35.099724+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	83
757	2017-08-30 17:55:45.071017+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	83
758	2017-08-30 17:55:45.191249+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	83
759	2017-08-30 17:56:49.365144+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	83
760	2017-08-30 17:56:56.600674+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
761	2017-08-30 17:56:56.678027+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
762	2017-08-30 17:57:00.511298+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/3/	83
763	2017-08-30 17:57:00.583918+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
764	2017-08-30 17:57:47.689261+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	83
765	2017-08-30 17:57:48.085241+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
766	2017-08-30 17:57:48.165709+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
767	2017-08-30 17:57:51.88869+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	83
768	2017-08-30 17:57:54.689937+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-resources/	83
769	2017-08-30 17:58:13.57184+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
770	2017-08-30 17:58:16.394946+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/3/	83
771	2017-08-30 17:58:16.470111+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
772	2017-08-30 17:58:51.43613+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	83
773	2017-08-30 17:58:51.791275+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
774	2017-08-30 17:58:51.84413+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
775	2017-08-30 17:58:54.161667+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	83
776	2017-08-30 17:58:56.25213+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-documents/	83
777	2017-08-30 17:59:04.985826+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
778	2017-08-30 17:59:07.983131+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/3/	83
779	2017-08-30 17:59:08.039414+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
780	2017-08-30 17:59:25.235222+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	83
781	2017-08-30 17:59:25.588754+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
782	2017-08-30 17:59:25.646398+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
783	2017-08-30 17:59:29.700874+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	83
784	2017-08-30 17:59:31.72541+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-resources/	83
785	2017-08-30 18:02:24.207827+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
786	2017-08-30 18:02:28.207221+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/3/	83
787	2017-08-30 18:02:28.269382+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
788	2017-08-30 18:02:38.396899+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
789	2017-08-30 18:02:40.603394+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/3/	83
790	2017-08-30 18:02:40.677598+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	83
791	2017-08-30 18:02:54.643503+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	83
792	2017-08-30 19:04:12.336408+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	84
793	2017-08-30 19:04:12.338582+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	84
794	2017-08-30 19:04:22.717003+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	84
795	2017-08-30 19:04:22.921192+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	85
796	2017-08-30 19:04:22.922825+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	85
797	2017-08-30 19:04:25.914672+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/my-resources/	85
798	2017-08-30 19:04:28.305393+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	85
799	2017-08-30 19:04:33.86451+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	85
800	2017-08-30 19:04:46.494059+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	85
801	2017-08-30 19:04:46.690539+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	85
802	2017-08-30 19:04:56.596165+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	85
803	2017-08-30 19:05:03.838931+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	85
804	2017-08-30 19:05:03.909048+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	85
805	2017-08-30 19:05:07.381553+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/3/	85
806	2017-08-30 19:05:07.453019+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	85
807	2017-08-30 19:05:22.921714+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	85
808	2017-08-30 19:05:23.37506+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	85
809	2017-08-30 19:05:23.435428+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	85
810	2017-08-30 19:05:26.501566+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	85
820	2017-08-30 19:06:23.512649+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	87
821	2017-08-30 19:06:23.514033+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	87
822	2017-08-30 19:06:27.569637+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	87
823	2017-08-30 19:06:35.426316+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	87
824	2017-08-30 19:06:35.52102+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	87
825	2017-08-30 19:06:47.96715+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	87
826	2017-08-30 19:07:39.976762+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	87
827	2017-08-30 19:07:40.049126+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	87
828	2017-08-30 19:07:42.629058+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/13/	87
829	2017-08-30 19:07:42.675939+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	87
830	2017-08-30 19:09:08.54446+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	87
831	2017-08-30 19:09:08.891601+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	87
832	2017-08-30 19:09:08.948243+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	87
833	2017-08-30 19:09:14.146247+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	87
834	2017-08-30 19:09:17.527568+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-connections/	87
835	2017-08-30 20:29:05.11996+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	88
836	2017-08-30 20:29:05.121879+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	88
837	2017-08-30 20:29:07.470273+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-connections/	88
838	2017-08-30 20:29:16.437511+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-connections/	88
839	2017-08-30 20:29:19.215636+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-documents/	88
840	2017-08-30 20:29:23.795149+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-connections/	88
841	2017-08-30 20:29:54.45579+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/my-connections/	88
842	2017-08-30 20:30:27.587816+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	88
843	2017-08-30 20:30:31.083253+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	88
844	2017-08-30 20:30:31.139751+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
845	2017-08-30 20:30:36.500835+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	88
846	2017-08-30 20:30:45.02627+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	88
847	2017-08-30 20:30:45.07643+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
848	2017-08-30 20:30:51.69802+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/quotamessage/1/	88
849	2017-08-30 20:30:51.744074+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
850	2017-08-30 20:30:58.576492+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/siteconfiguration/1/	88
851	2017-08-30 20:30:58.621775+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
852	2017-08-30 20:31:02.01816+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/userquota/	88
853	2017-08-30 20:31:02.094093+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
854	2017-08-30 20:31:04.841517+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/robots/url/	88
855	2017-08-30 20:31:04.88471+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
856	2017-08-30 20:31:06.755064+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/robots/rule/	88
857	2017-08-30 20:31:06.825412+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
858	2017-08-30 20:31:11.04589+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/django_comments/comment/	88
859	2017-08-30 20:31:11.096243+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
860	2017-08-30 20:31:16.76357+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/oauth2_provider/refreshtoken/	88
861	2017-08-30 20:31:16.837156+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
862	2017-08-30 20:31:18.454642+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/oauth2_provider/grant/	88
863	2017-08-30 20:31:18.497159+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
864	2017-08-30 20:31:20.170449+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/oauth2_provider/application/	88
865	2017-08-30 20:31:20.217261+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
866	2017-08-30 20:31:21.91706+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/oauth2_provider/accesstoken/	88
867	2017-08-30 20:31:21.964478+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
868	2017-08-30 20:31:23.657661+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/group/	88
869	2017-08-30 20:31:23.717459+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
870	2017-08-30 20:31:25.237834+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	88
871	2017-08-30 20:31:25.274569+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
872	2017-08-30 20:31:28.239162+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/group/	88
873	2017-08-30 20:31:28.279094+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
874	2017-08-30 20:31:37.962509+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	88
875	2017-08-30 20:31:38.035932+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
876	2017-08-30 20:31:41.74573+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/conf/setting/	88
877	2017-08-30 20:31:41.80109+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
878	2017-08-30 20:31:44.72749+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/redirects/redirect/	88
879	2017-08-30 20:31:44.772311+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
880	2017-08-30 20:31:46.691299+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/sites/site/	88
881	2017-08-30 20:31:46.750245+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
882	2017-08-30 20:31:49.213026+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/media-library/browse/	88
883	2017-08-30 20:31:50.190187+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/blog/blogpost/	88
884	2017-08-30 20:31:50.248588+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
885	2017-08-30 20:31:52.829349+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	88
886	2017-08-30 20:31:52.871994+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	88
887	2017-08-30 20:31:55.83076+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	88
888	2017-08-30 20:31:55.866043+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	89
889	2017-08-30 20:31:55.867386+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/logout/	89
890	2017-08-31 14:06:20.471858+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	90
891	2017-08-31 14:06:20.473813+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	90
892	2017-08-31 14:06:24.563906+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	90
893	2017-08-31 14:06:29.534069+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	90
894	2017-08-31 14:10:04.361356+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	90
895	2017-08-31 14:10:04.48122+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	90
896	2017-08-31 14:12:51.583104+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	90
897	2017-08-31 14:12:55.260606+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	90
898	2017-08-31 14:12:55.353377+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	90
899	2017-08-31 14:12:59.33431+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/5/	90
900	2017-08-31 14:12:59.429706+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	90
901	2017-08-31 14:16:35.717236+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	90
902	2017-08-31 14:16:36.043992+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	90
903	2017-08-31 14:16:36.096761+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	90
904	2017-08-31 14:16:41.017138+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	90
905	2017-08-31 14:16:44.894239+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	90
906	2017-08-31 14:19:39.437375+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	90
907	2017-08-31 19:14:35.655717+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	91
908	2017-08-31 19:14:35.65773+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	91
909	2017-08-31 20:14:22.553899+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	92
910	2017-08-31 20:14:22.556152+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	92
911	2017-08-31 20:16:08.187211+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	92
912	2017-08-31 20:18:34.613753+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	92
913	2017-08-31 20:19:29.902528+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	92
914	2017-08-31 20:21:01.337305+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	92
915	2017-08-31 20:21:59.867551+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	92
916	2017-08-31 20:41:35.529825+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	93
917	2017-08-31 20:41:35.532219+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	93
918	2017-08-31 20:41:45.967326+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	93
919	2017-08-31 20:54:24.060798+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	93
920	2017-08-31 20:55:47.801745+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	93
921	2017-09-01 18:13:18.425538+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	94
922	2017-09-01 18:13:18.427601+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	94
923	2017-09-01 18:13:32.664924+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	94
924	2017-09-01 19:47:49.096902+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	95
925	2017-09-01 19:47:49.098918+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	95
926	2017-09-01 19:49:33.400053+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	95
927	2017-09-01 20:57:41.665487+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	96
928	2017-09-01 20:57:41.667473+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	96
929	2017-09-01 20:57:47.164533+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	96
930	2017-09-01 20:57:47.235064+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	96
931	2017-09-01 20:57:53.505713+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/5/	96
932	2017-09-01 20:57:53.574263+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	96
933	2017-09-01 21:03:48.536523+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	96
934	2017-09-01 21:03:48.878912+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	96
935	2017-09-01 21:03:48.949088+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	96
936	2017-09-01 21:03:58.232312+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/5/	96
937	2017-09-01 21:03:58.284798+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	96
938	2017-09-01 21:04:14.290598+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	96
939	2017-09-01 21:04:14.345687+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	96
940	2017-09-01 21:04:41.2197+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/add/	96
941	2017-09-01 21:04:41.274162+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	96
942	2017-09-01 21:05:38.061063+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	96
943	2017-09-01 21:05:38.402222+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	96
944	2017-09-01 21:05:38.455317+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	96
945	2017-09-01 21:05:45.06857+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_page_ordering/	96
946	2017-09-01 21:06:03.516318+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	96
947	2017-09-01 21:06:05.910959+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	96
948	2017-09-01 21:06:14.367624+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	96
949	2017-09-01 21:07:14.445995+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	96
950	2017-09-01 21:07:14.536724+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	97
951	2017-09-01 21:07:14.538228+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	97
952	2017-09-01 21:07:19.029818+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	97
953	2017-09-01 21:07:26.618271+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	97
954	2017-09-01 21:07:26.793731+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	97
955	2017-09-01 21:07:34.351731+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	97
956	2017-09-01 21:07:46.051369+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/auth/user/	97
957	2017-09-01 21:07:46.131978+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	97
958	2017-09-01 21:07:51.049712+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	97
959	2017-09-01 21:07:51.099998+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	97
960	2017-09-01 21:07:52.057375+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/sites/site/	97
961	2017-09-01 21:07:52.126851+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	97
962	2017-09-01 21:08:03.541235+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/theme/siteconfiguration/1/	97
963	2017-09-01 21:08:03.588852+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	97
964	2017-09-01 21:08:44.416093+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	97
965	2017-09-01 21:08:55.95384+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	97
966	2017-09-01 21:08:56.027272+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	98
967	2017-09-01 21:08:56.028747+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	98
968	2017-09-01 22:04:20.541774+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	99
969	2017-09-01 22:04:20.543701+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	99
970	2017-09-01 22:04:23.664986+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/faqs/	99
971	2017-09-01 22:04:31.997588+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	99
972	2017-09-01 22:04:34.387601+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/faqs/	99
973	2017-09-01 22:04:49.399505+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/faqs/	99
974	2017-09-01 22:04:52.081037+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/faqs/	99
975	2017-09-01 22:04:56.21644+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/faqs/	99
976	2017-09-01 22:09:12.89172+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/faqs/	99
977	2017-09-05 14:18:28.417985+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	100
978	2017-09-05 14:18:28.419351+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/admin/login/	100
979	2017-09-07 20:02:16.953358+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	101
980	2017-09-07 20:02:16.956089+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/faqs/	101
981	2017-09-07 20:02:20.399675+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	101
982	2017-09-07 20:02:29.3206+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=None user_email_domain=None request_url=/accounts/login/	101
983	2017-09-07 20:02:36.152599+00	login	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	101
984	2017-09-07 20:02:36.262892+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	101
985	2017-09-07 20:02:46.576693+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	101
986	2017-09-07 20:02:51.55073+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	101
987	2017-09-07 20:02:54.124493+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
988	2017-09-07 20:02:54.226029+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	101
989	2017-09-07 20:02:58.302748+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/14/	101
990	2017-09-07 20:02:58.376274+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	101
991	2017-09-07 20:04:36.900209+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	101
992	2017-09-07 20:04:37.246855+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
993	2017-09-07 20:04:37.308308+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	101
994	2017-09-07 20:04:41.207879+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	101
995	2017-09-07 20:04:45.52282+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	101
996	2017-09-07 20:05:00.041303+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
997	2017-09-07 20:05:04.604975+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/14/	101
998	2017-09-07 20:06:08.127461+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	101
999	2017-09-07 20:06:08.526849+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
1000	2017-09-07 20:06:08.579242+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	101
1001	2017-09-07 20:06:12.678641+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	101
1002	2017-09-07 20:06:16.861616+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	101
1003	2017-09-07 20:06:22.404814+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
1004	2017-09-07 20:06:23.397567+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/14/	101
1005	2017-09-07 20:07:32.430229+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	101
1006	2017-09-07 20:07:32.745816+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
1007	2017-09-07 20:07:32.798591+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	101
1008	2017-09-07 20:07:42.556548+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/14/	101
1009	2017-09-07 20:12:11.999231+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	101
1010	2017-09-07 20:12:12.321545+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
1011	2017-09-07 20:12:12.393978+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	101
1012	2017-09-07 20:12:17.899844+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	101
1013	2017-09-07 20:12:20.661282+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	101
1014	2017-09-07 20:12:52.400738+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	101
1015	2017-09-07 20:13:16.942007+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	101
1016	2017-09-07 20:13:18.249223+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/14/	101
1017	2017-09-07 20:24:21.550856+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/14/	101
1018	2017-09-07 20:24:21.610903+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	101
1019	2017-09-07 20:24:29.929669+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	101
1020	2017-09-07 20:24:32.142364+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	101
1021	2017-09-07 20:24:46.058797+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	101
1022	2017-09-11 04:07:40.006798+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	102
1023	2017-09-11 04:07:40.00871+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1024	2017-09-11 04:08:12.081064+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1025	2017-09-11 04:08:22.133134+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1026	2017-09-11 04:11:11.912145+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1027	2017-09-11 04:11:42.593429+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1028	2017-09-11 04:11:44.794431+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1029	2017-09-11 04:11:50.965961+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1030	2017-09-11 04:12:00.708397+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1031	2017-09-11 04:14:16.313893+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1032	2017-09-11 04:17:16.830227+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1033	2017-09-11 04:17:18.598054+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1034	2017-09-11 04:17:20.580663+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1035	2017-09-11 04:17:51.922963+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1036	2017-09-11 04:17:55.318455+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1037	2017-09-11 04:17:58.422654+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1038	2017-09-11 04:18:37.069563+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1039	2017-09-11 04:18:40.259509+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1040	2017-09-11 04:27:24.573122+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1041	2017-09-11 04:38:42.613176+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/about/	102
1042	2017-09-11 04:39:51.408062+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	102
1043	2017-09-11 04:39:56.189797+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	102
1044	2017-09-11 04:39:56.257555+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	102
1045	2017-09-11 04:39:58.489966+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/14/	102
1046	2017-09-11 04:39:58.545444+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	102
1047	2017-09-11 04:40:29.738779+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	102
1048	2017-09-11 04:40:31.020249+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	102
1049	2017-09-11 04:41:46.919304+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/faqs/	102
1050	2017-09-11 05:23:10.36291+00	begin_session	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	103
1051	2017-09-11 05:23:10.365485+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/	103
1052	2017-09-11 05:23:17.439116+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	103
1053	2017-09-11 05:23:17.5012+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	103
1054	2017-09-11 05:23:19.389693+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/richtextpage/4/	103
1055	2017-09-11 05:23:19.442622+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	103
1056	2017-09-11 05:23:37.903696+00	visit	2	user_ip=192.168.59.1 http_method=POST http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin_keywords_submit/	103
1057	2017-09-11 05:23:38.227156+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/pages/page/	103
1058	2017-09-11 05:23:38.288998+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/admin/jsi18n/	103
1059	2017-09-11 05:23:41.465477+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=Unspecified user_email_domain=org request_url=/	103
1060	2017-09-11 05:23:45.018678+00	logout	2	user_ip=192.168.59.1 user_type=Unspecified user_email_domain=org	103
1061	2017-09-11 05:23:45.096954+00	begin_session	2	user_ip=192.168.59.1 user_type=None user_email_domain=None	104
1062	2017-09-11 05:23:45.098433+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	104
1063	2017-09-11 05:23:46.604048+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/discover/	104
1064	2017-09-11 05:23:49.257671+00	visit	2	user_ip=192.168.59.1 http_method=GET http_code=200 user_type=None user_email_domain=None request_url=/	104
\.


--
-- Name: hs_tracking_variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tracking_variable_id_seq', 1064, true);


--
-- Data for Name: hs_tracking_visitor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hs_tracking_visitor (id, first_seen, user_id) FROM stdin;
1	2016-06-23 17:06:32.171224+00	4
2	2016-06-23 17:07:55.656084+00	\N
3	2017-02-02 16:16:56.851102+00	\N
4	2017-02-02 17:23:27.980519+00	\N
5	2017-02-02 17:27:56.524908+00	\N
6	2017-02-02 17:28:40.809782+00	\N
7	2017-05-05 13:43:41.849519+00	\N
8	2017-07-26 17:31:09.010077+00	\N
9	2017-07-26 18:24:36.601826+00	\N
10	2017-07-26 18:56:36.899178+00	\N
11	2017-08-01 15:06:57.035709+00	\N
12	2017-08-01 15:08:28.329029+00	\N
13	2017-08-01 15:08:56.547244+00	\N
14	2017-08-01 22:18:24.22288+00	\N
15	2017-08-01 22:18:24.224557+00	\N
16	2017-08-01 22:18:24.223955+00	\N
17	2017-08-01 22:18:24.214823+00	\N
18	2017-08-01 22:18:24.220167+00	\N
19	2017-08-01 22:18:24.206294+00	\N
20	2017-08-01 22:18:24.229602+00	\N
21	2017-08-01 22:20:01.588685+00	\N
22	2017-08-01 22:20:01.593072+00	\N
23	2017-08-01 22:20:01.596219+00	\N
24	2017-08-01 22:20:01.64746+00	\N
25	2017-08-01 22:20:01.652554+00	\N
26	2017-08-01 22:20:01.682909+00	\N
27	2017-08-01 22:20:01.688808+00	\N
28	2017-08-01 22:20:01.675957+00	\N
47	2017-08-01 22:35:21.622649+00	\N
48	2017-08-01 22:55:09.243969+00	\N
49	2017-08-01 22:57:27.713769+00	\N
50	2017-08-02 00:27:58.56457+00	\N
51	2017-08-02 16:03:16.510392+00	\N
52	2017-08-02 17:48:37.954587+00	\N
53	2017-08-02 18:13:16.606756+00	\N
54	2017-08-02 18:57:12.996637+00	\N
55	2017-08-02 19:21:07.083463+00	\N
56	2017-08-03 19:56:41.506686+00	\N
57	2017-08-03 20:56:42.598966+00	\N
58	2017-08-07 15:09:29.570075+00	\N
59	2017-08-07 19:44:04.908119+00	\N
60	2017-08-07 19:55:52.419235+00	\N
61	2017-08-08 19:16:58.809098+00	\N
62	2017-08-08 21:51:28.642048+00	\N
63	2017-08-23 17:58:43.858516+00	\N
64	2017-08-24 20:14:44.780006+00	\N
65	2017-08-24 21:00:42.825437+00	\N
66	2017-08-25 17:35:32.621567+00	\N
67	2017-08-28 14:57:39.396217+00	\N
68	2017-08-28 15:02:25.106428+00	\N
69	2017-08-30 16:44:29.71542+00	\N
70	2017-08-30 16:55:27.836404+00	\N
71	2017-08-30 17:00:10.426588+00	\N
72	2017-08-30 17:10:02.683636+00	\N
73	2017-08-30 17:47:16.751539+00	\N
75	2017-08-30 17:50:00.312954+00	\N
76	2017-08-30 19:04:22.917832+00	\N
77	2017-08-30 19:05:26.542084+00	\N
78	2017-08-30 19:06:23.50663+00	\N
79	2017-08-30 20:31:55.863278+00	\N
80	2017-08-31 14:06:20.46831+00	\N
81	2017-09-01 21:07:14.531209+00	\N
82	2017-09-01 21:08:56.023885+00	\N
83	2017-09-01 22:04:20.533395+00	\N
84	2017-09-05 14:18:28.414119+00	\N
85	2017-09-07 20:02:16.943233+00	\N
86	2017-09-11 05:23:45.091084+00	\N
\.


--
-- Name: hs_tracking_visitor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hs_tracking_visitor_id_seq', 86, true);


--
-- Data for Name: oauth2_provider_accesstoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oauth2_provider_accesstoken (id, token, expires, scope, application_id, user_id) FROM stdin;
\.


--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oauth2_provider_accesstoken_id_seq', 1, false);


--
-- Data for Name: oauth2_provider_application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oauth2_provider_application (id, client_id, redirect_uris, client_type, authorization_grant_type, client_secret, name, user_id, skip_authorization) FROM stdin;
\.


--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oauth2_provider_application_id_seq', 1, false);


--
-- Data for Name: oauth2_provider_grant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oauth2_provider_grant (id, code, expires, redirect_uri, scope, application_id, user_id) FROM stdin;
\.


--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oauth2_provider_grant_id_seq', 1, false);


--
-- Data for Name: oauth2_provider_refreshtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oauth2_provider_refreshtoken (id, token, access_token_id, application_id, user_id) FROM stdin;
\.


--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oauth2_provider_refreshtoken_id_seq', 1, false);


--
-- Data for Name: pages_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pages_link (page_ptr_id) FROM stdin;
6
\.


--
-- Data for Name: pages_page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pages_page (id, keywords_string, site_id, title, slug, _meta_title, description, gen_description, created, updated, status, publish_date, expiry_date, short_url, in_sitemap, _order, parent_id, in_menus, titles, content_model, login_required) FROM stdin;
10		1	Statement of Privacy	privacy	Statement of Privacy	MyHPOM Statement of Privacy\nLast modified August 1, 2017	t	2016-01-25 19:34:22.084583+00	2017-08-01 23:33:15.574459+00	2	2016-01-25 19:34:22+00	\N	\N	t	10	\N		Statement of Privacy	richtextpage	f
11		1	Create Document	create-resource	Create Document	create resource	t	2016-01-25 19:35:15.10115+00	2016-01-25 19:35:15.10115+00	2	2016-01-25 19:35:15.100153+00	\N	\N	t	11	\N		Create Document	richtextpage	f
12		1	Sign Up	sign-up	Sign Up	sign up	t	2016-01-25 19:40:35.894321+00	2016-01-25 19:40:35.894321+00	2	2016-01-25 19:40:35.893206+00	\N	\N	t	12	\N		Sign Up	richtextpage	f
2		1	Home	/		My Health Peace of Mind gives you a place to plan and communicate important information about your future healthcare wishes to those closest to you and those who provide medical care to you. Join today to express you wishes.	t	2016-01-25 19:17:47.144396+00	2017-08-24 20:29:22.387597+00	2	2016-01-25 19:17:47+00	\N	\N	t	0	\N		Home	homepage	f
3		1	My Documents	my-documents	My Documents	my-documents	t	2016-01-25 19:22:48.667099+00	2017-08-30 19:05:23.007931+00	2	2016-01-25 19:22:48+00	\N	\N	t	2	\N	1,2,3	My Documents	richtextpage	f
13		1	My Connections	my-connections	My Connections	my-connections	t	2016-06-23 17:07:04.042277+00	2017-08-30 19:09:08.603166+00	2	2016-06-23 17:07:04+00	\N	\N	t	3	\N	1	My Connections	richtextpage	f
6		1	Apps	https://appsdev.myhpom.renci.org/apps	\N	Apps	t	2016-01-25 19:26:44.887463+00	2017-08-01 23:07:32.01117+00	1	2016-01-25 19:26:44+00	\N	\N	f	5	\N	1,2,3	Apps	link	f
5		1	FAQS	faqs	FAQs	Frequently Asked Questions	t	2016-01-25 19:25:35.644671+00	2017-09-01 21:03:48.619822+00	2	2016-01-25 19:25:35+00	\N	\N	t	6	\N	1,2,3	FAQS	richtextpage	f
7		1	Verify Account	verify-account	Verify Account	Thank you for signing up for MyHPOM! We have sent you an email from myhpom.org to verify your account.  Please click on the link within the email and verify your account with us and you can get started expressing your wishes with MyHPOM.	t	2016-01-25 19:28:12.867432+00	2017-08-01 23:13:58.772728+00	2	2016-01-25 19:28:12+00	\N	\N	t	7	\N		Verify Account	richtextpage	f
8		1	Resend Verification Email	resend-verification-email	Resend Email Verification	Please give us your email address and we will resend the confirmation.	t	2016-01-25 19:32:20.248488+00	2017-08-01 23:14:46.696705+00	2	2016-01-25 19:32:20+00	\N	\N	t	8	\N		Resend Verification Email	form	f
9		1	Terms of Use	terms-of-use	Terms of Use	MyHPOM Terms of Use\nLast modified May 5, 2017	t	2016-01-25 19:33:24.439209+00	2017-08-01 23:30:15.102304+00	2	2016-01-25 19:33:24+00	\N	\N	t	9	\N		Terms of Use	richtextpage	f
14		1	About	about	About	About My Health Peace of Mind	f	2017-09-01 21:05:38.108141+00	2017-09-07 20:12:12.049697+00	2	2017-09-01 21:05:38+00	\N	\N	t	1	\N	1,2,3	About	richtextpage	f
4		1	Discover	discover	Discover	**"In a future development phase for My Health Peace of Mind, the ability to search and discover new resources relevant to your health care planning will be added.	t	2016-01-25 19:23:52.174668+00	2017-09-11 05:23:37.953318+00	2	2016-01-25 19:23:52+00	\N	\N	t	4	\N	1,2,3	Discover	richtextpage	f
\.


--
-- Name: pages_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pages_page_id_seq', 14, true);


--
-- Data for Name: pages_richtextpage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pages_richtextpage (page_ptr_id, content) FROM stdin;
11	<p>create resource</p>
12	<p>sign up</p>
7	<p class="p1">Thank you for signing up for MyHPOM! We have sent you an email from myhpom.org to verify your account.  Please click on the link within the email and verify your account with us and you can get started expressing your wishes with MyHPOM.</p>\n<p class="p2"><a href="http://myhpom.org/hsapi/_internal/resend_verification_email/">Please click here if you do not receive a verification email within 1 hour.</a></p>
9	<h2 class="p1"><b>MyHPOM Terms of Use</b></h2>\n<p class="p2"><i>Last modified May 5, 2017<br></i></p>\n<p class="p2">Thank you for using the MyHPOM system hosted at MYHPOM.org.  MyHPOM services are provided by a team of researchers associated with the Renaissance Computing Institue of the University of North Carolina at Chapel Hill.  The services are hosted at participating institutions including the Renaissance Computing Institute at University of the University of North Carolina at Chapel Hil. Your access to myhpom.org is subject to your agreement to these Terms of Use. By using our services at myhpom.renci.org, you are agreeing to these terms.  Please read them carefully.</p>\n<h2 class="p3"><b>Modification of the Agreement</b></h2>\n<p class="p2">We maintain the right to modify these Terms of Use and may do so by posting modifications on this page. Any modification is effective immediately upon posting the modification unless otherwise stated. Your continued use of myhpom.renci.org following the posting of any modification signifies your acceptance of that modification. You should regularly visit this page to review the current Terms of Use.</p>\n<h2 class="p3"><b>Conduct Using our Services</b></h2>\n<p class="p2">The myhpom.org site is intended to support your health information and future healthcare wishes. You are responsible at all times for using myhpom.org in a manner that is legal, ethical, not to the detriment of others, and for purposes related to your health information and future healthcare wishes.. You agree that you will not in your use of myhpom.org:</p>\n<ul class="ul1">\n<li class="li2">Violate any applicable law, commit a criminal offense or perform actions that might encourage others to commit a criminal offense or give rise to a civil liability;</li>\n<li class="li2">Post or transmit any unlawful, threatening, libelous, harassing, defamatory, vulgar, obscene, pornographic, profane, or otherwise objectionable content;</li>\n<li class="li2">Use myhpom.org to impersonate other parties or entities;</li>\n<li class="li2">Use myhpom.org to upload any content that contains a software virus, "Trojan Horse" or any other computer code, files, or programs that may alter, damage, or interrupt the functionality of myhpom.org or the hardware or software of any other person who accesses myhpom.org;</li>\n<li class="li2">Upload, post, email, or otherwise transmit any materials that you do not have a right to transmit under any law or under a contractual relationship;</li>\n<li class="li2">Alter, damage, or delete any content posted on myhpom.org, except where such alterations or deletions are consistent with the access control settings of that content in myhpom.org;</li>\n<li class="li2">Disrupt the normal flow of communication in any way;</li>\n<li class="li2">Claim a relationship with or speak for any business, association, or other organization for which you are not authorized to claim such a relationship;</li>\n<li class="li2">Post or transmit any unsolicited advertising, promotional materials, or other forms of solicitation;</li>\n<li class="li2">Post any material that infringes or violates the intellectual property rights of another.</li>\n</ul>\n<p class="p2">Certain portions of myhpom.org are limited to registered users and/or allow a user to participate in online services by entering personal information. You agree that any information provided to myhpomorg in these areas will be accurate, and that you will neither register under the name of another person or entity of nor attempt to enter myhpom.org under the name of another person or entity.</p>\n<p class="p2">You are responsible for maintaining the confidentiality of your user ID and password, if any, and for restricting access to your computer, and you agree to accept responsibility for all activities that occur under your account or password. Myhpom.org does not authorize use of your User ID by third-parties.</p>\n<p class="p2">We may, in our sole discretion, terminate or suspend your access to and use of myhpom.org without notice and for any reason, including for violation of these Terms of Use or for other conduct that we, in our sole discretion, believe to be unlawful or harmful to others. In the event of termination, you are no longer authorized to access myhpom.org.</p>\n<h2 class="p3"><b>Disclaimers</b></h2>\n<p class="p2">MYHPOM.ORG AND ANY INFORMATION, PRODUCTS OR SERVICES ON IT ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Myhpom.org and its participating institutions do not warrant, and hereby disclaim any warranties, either express or implied, with respect to the accuracy, adequacy or completeness of any good, service, or information obtained from myhpom.org. M Myhpom.org and its participating institutions do not warrant that myhpom.org will operate in an uninterrupted or error-free manner or that myhpom.org is free of viruses or other harmful components. Use of myhpom.renci.org is at your own risk.</p>\n<p class="p2">You agree that myhpom.org and its participating institutions shall have no liability for any consequential, indirect, punitive, special or incidental damages, whether foreseeable or unforeseeable (including, but not limited to, claims for defamation, errors, loss of data, or interruption in availability of data), arising out of or relating to your use of any resource that you access through myhpom.org.</p>\n<p class="p2">The myhpom.org site hosts content from a number of authors. The statements and views of these authors are theirs alone, and do not reflect the stances or policies of the MyHPOM team or their sponsors, nor does their posting imply the endorsement of MyHPOM or their sponsors.</p>\n<h2 class="p3"><b>Choice of Law/Forum Selection/Attorney Fees</b></h2>\n<p class="p2">You agree that any dispute arising out of or relating to myhpom.org, whether based in contract, tort, statutory or other law, will be governed by federal law and by the laws of North Carolina, excluding its conflicts of law provisions. You further consent to the personal jurisdiction of and exclusive venue in the federal and state courts located in and serving the United States of America, North Carolina as the exclusive legal forums for any such dispute.</p>
10	<h2 class="p1"><b>MyHPOM Statement of Privacy</b></h2>\n<p class="p2"><i>Last modified August 1, 2017<br></i></p>\n<p class="p2">MyHPOM is operated by a team of researchers associated with the Renaissance Computing Institute of the University of North Carolina at Chapel Hill.  The services are hosted at participating institutions including the Renaissance Computing Institute of the University of North Carolina at Chapel Hill.  In the following these are referred to as participating institutions.</p>\n<p class="p2">We respect your privacy. We will only use your personal identification information to support and manage your use of xdcioshare.org, including the use of tracking cookies to facilitate myhpom.renci.org security procedures. The MyHPOM participating institutions regularly request myhpom.org usages statistics and other information. Usage of myhpom.org is monitored and usage statistics are collected and reported on a regular basis. Myhpom.org also reserves the right to contact you to request additional information or to keep you updated on changes to myhpom.org. You may opt out of receiving newsletters and other non-essential communications. No information that would identify you personally will be provided to sponsors or third parties without your permission.</p>\n<p class="p2">While MyHPOM uses policies and procedures to manage the access to content according to the access control settings set by users all information posted or stored on myhpom.org is potentially available to other users of myhpom.org and the public. The MyHPOM participating institutions and myhpom.org disclaim any responsibility for the preservation of confidentiality of such information. <i>Do not post or store information on myhpom.org if you expect to or are obligated to protect the confidentiality of that information.</i></p>
3	<p>my-documents</p>
13	<p>my-connections</p>
5	<p>Frequently Asked Questions</p>
14	<div style="margin: 10px 20px 10px 20px;">\n<p><em>My Health Peace of Mind</em> offers you a chance to connect the dots between the health care you want and to the people who might be called on to make those decisions on your behalf. In a way, we see <em>My Health Peace of Mind</em> as helping you to own your own health.</p>\n<p><em>My Health Peace of Mind</em> is a free tool for you, funded by a generous grant from The Duke Endowment.</p>\n<p><em>My Health Peace of Mind</em> encourages people to have important conversations about the healthcare they would like to receive in the future if they were facing a life limiting condition. By encouraging these conversations with those closest to you, you can formalize your wishes into legal documents called <strong>Advance Directives</strong>. Advance Directives include a <strong>Living Will</strong> (a document that states your healthcare preferences) and a <strong>Healthcare Power of Attorney</strong> (a document that lets you name a trusted person to make healthcare decisions on your behalf if you are unable to make the decisions yourself).</p>\n<p><em>My Health Peace of Mind</em> allows you to upload your documents online where they can be shared with the people who might be called on to make decisions one day. This can include anyone you name – members of your family, a friend, your physician or some other trusted person. Uploading and sharing your documents increases the chance that your healthcare wishes will be honored. And through a secure partnership with hospitals or Vynca, <em>My Health Peace of Mind</em> will allow your <strong>Advance Directives</strong> to be accessed if you need emergency care.</p>\n<p><em>My Health Peace of Mind</em> will provide you with the ability to explore and discover information about health conditions, aging in general and how to have conversations about your future healthcare preferences, no matter what you choose. What’s important to us is that your voice is heard, documented and shared with the people closest to you.</p>\n<p>By joining <em>My Health Peace of Mind</em>, you begin a journey of making important personal decisions that are a gift to your loved ones.</p>\n<p><em>My Health Peace of Mind</em> is a collaborative project of <a href="http://cchospice.org/">The Carolinas Center</a>, a member organization that has led the way for patient-centered care at the end of life in the Carolinas. Together with our members and project partners (need page with project partners named), we want you to receive the care you desire when it is needed. Without planning in advance, your healthcare preferences might not be known or honored.</p>\n</div>
4	<p>**"In a future development phase for My Health Peace of Mind, the ability to search and discover new resources relevant to your health care planning will be added.</p>\n<p>Once you identify new information the goal is to enable the ability to add the new information to your personal set of resources and/or to share within your network."**</p>
\.


--
-- Data for Name: ref_ts_datasource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_ts_datasource (id, object_id, code, content_type_id) FROM stdin;
\.


--
-- Name: ref_ts_datasource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ref_ts_datasource_id_seq', 1, false);


--
-- Data for Name: ref_ts_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_ts_method (id, object_id, content_type_id, code, description) FROM stdin;
\.


--
-- Name: ref_ts_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ref_ts_method_id_seq', 1, false);


--
-- Data for Name: ref_ts_qualitycontrollevel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_ts_qualitycontrollevel (id, object_id, content_type_id, code, definition) FROM stdin;
\.


--
-- Name: ref_ts_qualitycontrollevel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ref_ts_qualitycontrollevel_id_seq', 1, false);


--
-- Data for Name: ref_ts_referenceurl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_ts_referenceurl (id, object_id, value, type, content_type_id) FROM stdin;
\.


--
-- Name: ref_ts_referenceurl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ref_ts_referenceurl_id_seq', 1, false);


--
-- Data for Name: ref_ts_reftsmetadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_ts_reftsmetadata (coremetadata_ptr_id) FROM stdin;
\.


--
-- Data for Name: ref_ts_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_ts_site (id, object_id, name, code, latitude, longitude, content_type_id, net_work) FROM stdin;
\.


--
-- Name: ref_ts_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ref_ts_site_id_seq', 1, false);


--
-- Data for Name: ref_ts_variable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_ts_variable (id, object_id, name, code, data_type, sample_medium, content_type_id) FROM stdin;
\.


--
-- Name: ref_ts_variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ref_ts_variable_id_seq', 1, false);


--
-- Data for Name: robots_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY robots_rule (id, robot, crawl_delay) FROM stdin;
\.


--
-- Data for Name: robots_rule_allowed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY robots_rule_allowed (id, rule_id, url_id) FROM stdin;
\.


--
-- Name: robots_rule_allowed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('robots_rule_allowed_id_seq', 1, false);


--
-- Data for Name: robots_rule_disallowed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY robots_rule_disallowed (id, rule_id, url_id) FROM stdin;
\.


--
-- Name: robots_rule_disallowed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('robots_rule_disallowed_id_seq', 1, false);


--
-- Name: robots_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('robots_rule_id_seq', 1, false);


--
-- Data for Name: robots_rule_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY robots_rule_sites (id, rule_id, site_id) FROM stdin;
\.


--
-- Name: robots_rule_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('robots_rule_sites_id_seq', 1, false);


--
-- Data for Name: robots_url; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY robots_url (id, pattern) FROM stdin;
\.


--
-- Name: robots_url_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('robots_url_id_seq', 1, false);


--
-- Data for Name: security_cspreport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY security_cspreport (id, document_uri, referrer, blocked_uri, violated_directive, original_policy, date_received, sender_ip, user_agent) FROM stdin;
\.


--
-- Name: security_cspreport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('security_cspreport_id_seq', 1, false);


--
-- Data for Name: security_passwordexpiry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY security_passwordexpiry (id, password_expiry_date, user_id) FROM stdin;
\.


--
-- Name: security_passwordexpiry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('security_passwordexpiry_id_seq', 1, false);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys  FROM stdin;
\.


--
-- Data for Name: theme_homepage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY theme_homepage (page_ptr_id, heading, slide_in_one_icon, slide_in_one, slide_in_two_icon, slide_in_two, slide_in_three_icon, slide_in_three, header_background, header_image, welcome_heading, content, recent_blog_heading, number_recent_posts, message_end_date, message_start_date, message_type, show_message) FROM stdin;
2	MyHPOM									Express Your WIshes	<p class="p1">My Health Peace of Mind gives you a place to plan and communicate important information about your future healthcare wishes to those closest to you and those who provide medical care to you. Join today to express you wishes.<strong><br></strong></p>	Latest blog posts	3	2047-05-05	2016-01-25	warning	f
\.


--
-- Data for Name: theme_iconbox; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY theme_iconbox (id, _order, icon, title, link_text, link, homepage_id) FROM stdin;
\.


--
-- Name: theme_iconbox_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('theme_iconbox_id_seq', 1, false);


--
-- Data for Name: theme_quotamessage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY theme_quotamessage (id, warning_content_prepend, grace_period_content_prepend, enforce_content_prepend, content, soft_limit_percent, hard_limit_percent, grace_period) FROM stdin;
1	Your quota for MyHPOM resources is {allocated}{unit} in {zone} zone. You currently have resources that consume {used}{unit}, {percent}% of your quota. Once your quota reaches 100% you will no longer be able to create new resources in MyHPOM. 	You have exceeded your MyHPOM quota. Your quota for MyHPOM resources is {allocated}{unit} in {zone} zone. You currently have resources that consume {used}{unit}, {percent}% of your quota. You have a grace period until {cut_off_date} to reduce your use to below your quota, or to acquire additional quota, after which you will no longer be able to create new resources in MyHPOM. 	Your action to add content to MyHPOM was refused because you have exceeded your quota. Your quota for MyHPOM resources is {allocated}{unit} in {zone} zone. You currently have resources that consume {used}{unit}, {percent}% of your quota. 	To request additional quota, please contact support@myhpom.renci.org. We will try to accommodate reasonable requests for additional quota. If you have a large quota request you may need to contribute toward the costs of providing the additional space you need. See https://pages.myhpom.renci.org/ for more information about the quota policy.	80	125	7
\.


--
-- Name: theme_quotamessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('theme_quotamessage_id_seq', 1, true);


--
-- Data for Name: theme_siteconfiguration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY theme_siteconfiguration (id, col1_heading, col1_content, col2_heading, col2_content, col3_heading, col3_content, twitter_link, facebook_link, pinterest_link, youtube_link, github_link, linkedin_link, vk_link, gplus_link, has_social_network_links, copyright, site_id) FROM stdin;
1	Contact us	<p class="p1">Email us at <a href="mailto:support@myhpom.org">support@myhpom.org</a></p>	Follow		Version	<p>This is MyHPOM Version<b> DEVELOPMENT</b></p>									f	&copy 2017-{% now "Y" %} University of North Carolina at Chapel Hill. &copy 2012-2016 CUAHSI. This material is based upon work supported by the National Science Foundation (NSF) under awards 1148453 and 1148090.  Any opinions, findings, conclusions, or recommendations expressed in this material are those of the authors and do not necessarily reflect the views of the NSF.	1
\.


--
-- Name: theme_siteconfiguration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('theme_siteconfiguration_id_seq', 1, true);


--
-- Data for Name: theme_userprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY theme_userprofile (id, picture, title, subject_areas, organization, phone_1, phone_1_type, phone_2, phone_2_type, public, cv, details, user_id, country, middle_name, state, user_type, website, create_irods_user_account) FROM stdin;
4		\N	\N	\N	\N	\N	\N	\N	t		\N	4	\N	\N	\N	Unspecified	\N	f
\.


--
-- Name: theme_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('theme_userprofile_id_seq', 6, true);


--
-- Data for Name: theme_userquota; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY theme_userquota (id, allocated_value, used_value, unit, zone, remaining_grace_period, user_id) FROM stdin;
\.


--
-- Name: theme_userquota_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('theme_userquota_id_seq', 2, true);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: blog_blogcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY blog_blogcategory
    ADD CONSTRAINT blog_blogcategory_pkey PRIMARY KEY (id);


--
-- Name: blog_blogpost_categories_blogpost_id_blogcategory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY blog_blogpost_categories
    ADD CONSTRAINT blog_blogpost_categories_blogpost_id_blogcategory_id_key UNIQUE (blogpost_id, blogcategory_id);


--
-- Name: blog_blogpost_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY blog_blogpost_categories
    ADD CONSTRAINT blog_blogpost_categories_pkey PRIMARY KEY (id);


--
-- Name: blog_blogpost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY blog_blogpost
    ADD CONSTRAINT blog_blogpost_pkey PRIMARY KEY (id);


--
-- Name: blog_blogpost_related_posts_from_blogpost_id_to_blogpost_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY blog_blogpost_related_posts
    ADD CONSTRAINT blog_blogpost_related_posts_from_blogpost_id_to_blogpost_id_key UNIQUE (from_blogpost_id, to_blogpost_id);


--
-- Name: blog_blogpost_related_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY blog_blogpost_related_posts
    ADD CONSTRAINT blog_blogpost_related_posts_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- Name: celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- Name: conf_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conf_setting
    ADD CONSTRAINT conf_setting_pkey PRIMARY KEY (id);


--
-- Name: core_sitepermission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY core_sitepermission
    ADD CONSTRAINT core_sitepermission_pkey PRIMARY KEY (id);


--
-- Name: core_sitepermission_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY core_sitepermission_sites
    ADD CONSTRAINT core_sitepermission_sites_pkey PRIMARY KEY (id);


--
-- Name: core_sitepermission_sites_sitepermission_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY core_sitepermission_sites
    ADD CONSTRAINT core_sitepermission_sites_sitepermission_id_site_id_key UNIQUE (sitepermission_id, site_id);


--
-- Name: core_sitepermission_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY core_sitepermission
    ADD CONSTRAINT core_sitepermission_user_id_key UNIQUE (user_id);


--
-- Name: corsheaders_corsmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY corsheaders_corsmodel
    ADD CONSTRAINT corsheaders_corsmodel_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_comment_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_comment_flags
    ADD CONSTRAINT django_comment_flags_pkey PRIMARY KEY (id);


--
-- Name: django_comment_flags_user_id_comment_id_flag_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_comment_flags
    ADD CONSTRAINT django_comment_flags_user_id_comment_id_flag_key UNIQUE (user_id, comment_id, flag);


--
-- Name: django_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_comments
    ADD CONSTRAINT django_comments_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_45f3b1d93ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_containeroverrides_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_containeroverrides
    ADD CONSTRAINT django_docker_processes_containeroverrides_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_dockerenvvar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockerenvvar
    ADD CONSTRAINT django_docker_processes_dockerenvvar_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_dockerlink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockerlink
    ADD CONSTRAINT django_docker_processes_dockerlink_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_dockerport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockerport
    ADD CONSTRAINT django_docker_processes_dockerport_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_dockerprocess_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockerprocess
    ADD CONSTRAINT django_docker_processes_dockerprocess_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_dockerprocess_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockerprocess
    ADD CONSTRAINT django_docker_processes_dockerprocess_token_key UNIQUE (token);


--
-- Name: django_docker_processes_dockerprofile_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockerprofile
    ADD CONSTRAINT django_docker_processes_dockerprofile_name_key UNIQUE (name);


--
-- Name: django_docker_processes_dockerprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockerprofile
    ADD CONSTRAINT django_docker_processes_dockerprofile_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_dockervolume_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_dockervolume
    ADD CONSTRAINT django_docker_processes_dockervolume_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_overrideenvvar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_overrideenvvar
    ADD CONSTRAINT django_docker_processes_overrideenvvar_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_overridelink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_overridelink
    ADD CONSTRAINT django_docker_processes_overridelink_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_overrideport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_overrideport
    ADD CONSTRAINT django_docker_processes_overrideport_pkey PRIMARY KEY (id);


--
-- Name: django_docker_processes_overridevolume_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_docker_processes_overridevolume
    ADD CONSTRAINT django_docker_processes_overridevolume_pkey PRIMARY KEY (id);


--
-- Name: django_irods_rodsenvironment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_irods_rodsenvironment
    ADD CONSTRAINT django_irods_rodsenvironment_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_redirect_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_redirect
    ADD CONSTRAINT django_redirect_pkey PRIMARY KEY (id);


--
-- Name: django_redirect_site_id_old_path_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_redirect
    ADD CONSTRAINT django_redirect_site_id_old_path_key UNIQUE (site_id, old_path);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: djcelery_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_crontabschedule
    ADD CONSTRAINT djcelery_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_intervalschedule
    ADD CONSTRAINT djcelery_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_name_key UNIQUE (name);


--
-- Name: djcelery_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_periodictasks
    ADD CONSTRAINT djcelery_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: djcelery_taskstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_pkey PRIMARY KEY (id);


--
-- Name: djcelery_taskstate_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_task_id_key UNIQUE (task_id);


--
-- Name: djcelery_workerstate_hostname_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_hostname_key UNIQUE (hostname);


--
-- Name: djcelery_workerstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_pkey PRIMARY KEY (id);


--
-- Name: forms_field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forms_field
    ADD CONSTRAINT forms_field_pkey PRIMARY KEY (id);


--
-- Name: forms_fieldentry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forms_fieldentry
    ADD CONSTRAINT forms_fieldentry_pkey PRIMARY KEY (id);


--
-- Name: forms_form_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forms_form
    ADD CONSTRAINT forms_form_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: forms_formentry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forms_formentry
    ADD CONSTRAINT forms_formentry_pkey PRIMARY KEY (id);


--
-- Name: ga_ows_ogrdataset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_ows_ogrdataset
    ADD CONSTRAINT ga_ows_ogrdataset_pkey PRIMARY KEY (id);


--
-- Name: ga_ows_ogrdatasetcollection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_ows_ogrdatasetcollection
    ADD CONSTRAINT ga_ows_ogrdatasetcollection_pkey PRIMARY KEY (id);


--
-- Name: ga_ows_ogrlayer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_ows_ogrlayer
    ADD CONSTRAINT ga_ows_ogrlayer_pkey PRIMARY KEY (id);


--
-- Name: ga_resources_catalogpage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_catalogpage
    ADD CONSTRAINT ga_resources_catalogpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: ga_resources_dataresource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_dataresource
    ADD CONSTRAINT ga_resources_dataresource_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: ga_resources_orderedresource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_orderedresource
    ADD CONSTRAINT ga_resources_orderedresource_pkey PRIMARY KEY (id);


--
-- Name: ga_resources_relatedresource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_relatedresource
    ADD CONSTRAINT ga_resources_relatedresource_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: ga_resources_renderedlayer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_renderedlayer
    ADD CONSTRAINT ga_resources_renderedlayer_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: ga_resources_renderedlayer_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_renderedlayer_styles
    ADD CONSTRAINT ga_resources_renderedlayer_styles_pkey PRIMARY KEY (id);


--
-- Name: ga_resources_renderedlayer_styles_renderedlayer_id_style_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_renderedlayer_styles
    ADD CONSTRAINT ga_resources_renderedlayer_styles_renderedlayer_id_style_id_key UNIQUE (renderedlayer_id, style_id);


--
-- Name: ga_resources_resourcegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_resourcegroup
    ADD CONSTRAINT ga_resources_resourcegroup_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: ga_resources_style_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ga_resources_style
    ADD CONSTRAINT ga_resources_style_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: galleries_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY galleries_gallery
    ADD CONSTRAINT galleries_gallery_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: galleries_galleryimage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY galleries_galleryimage
    ADD CONSTRAINT galleries_galleryimage_pkey PRIMARY KEY (id);


--
-- Name: generic_assignedkeyword_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY generic_assignedkeyword
    ADD CONSTRAINT generic_assignedkeyword_pkey PRIMARY KEY (id);


--
-- Name: generic_keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY generic_keyword
    ADD CONSTRAINT generic_keyword_pkey PRIMARY KEY (id);


--
-- Name: generic_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY generic_rating
    ADD CONSTRAINT generic_rating_pkey PRIMARY KEY (id);


--
-- Name: generic_threadedcomment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY generic_threadedcomment
    ADD CONSTRAINT generic_threadedcomment_pkey PRIMARY KEY (comment_ptr_id);


--
-- Name: hs_access_control_groupaccess_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_groupaccess
    ADD CONSTRAINT hs_access_control_groupaccess_group_id_key UNIQUE (group_id);


--
-- Name: hs_access_control_groupaccess_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_groupaccess
    ADD CONSTRAINT hs_access_control_groupaccess_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_groupmembershiprequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_groupmembershiprequest
    ADD CONSTRAINT hs_access_control_groupmembershiprequest_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_groupresourcep_group_id_157babc573be246e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_groupresourceprovenance
    ADD CONSTRAINT hs_access_control_groupresourcep_group_id_157babc573be246e_uniq UNIQUE (group_id, resource_id, start);


--
-- Name: hs_access_control_groupresourcepr_group_id_51ccf8b056500a7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_groupresourceprivilege
    ADD CONSTRAINT hs_access_control_groupresourcepr_group_id_51ccf8b056500a7_uniq UNIQUE (group_id, resource_id);


--
-- Name: hs_access_control_groupresourceprivilege_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_groupresourceprivilege
    ADD CONSTRAINT hs_access_control_groupresourceprivilege_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_groupresourceprovenance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_groupresourceprovenance
    ADD CONSTRAINT hs_access_control_groupresourceprovenance_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_resourceaccess_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_resourceaccess
    ADD CONSTRAINT hs_access_control_resourceaccess_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_resourceaccess_resource_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_resourceaccess
    ADD CONSTRAINT hs_access_control_resourceaccess_resource_id_key UNIQUE (resource_id);


--
-- Name: hs_access_control_useraccess_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_useraccess
    ADD CONSTRAINT hs_access_control_useraccess_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_useraccess_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_useraccess
    ADD CONSTRAINT hs_access_control_useraccess_user_id_key UNIQUE (user_id);


--
-- Name: hs_access_control_usergroupprivil_user_id_48a0f7a1b974b91b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_usergroupprivilege
    ADD CONSTRAINT hs_access_control_usergroupprivil_user_id_48a0f7a1b974b91b_uniq UNIQUE (user_id, group_id);


--
-- Name: hs_access_control_usergroupprivilege_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_usergroupprivilege
    ADD CONSTRAINT hs_access_control_usergroupprivilege_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_usergroupproven_user_id_548c10e220120a3e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_usergroupprovenance
    ADD CONSTRAINT hs_access_control_usergroupproven_user_id_548c10e220120a3e_uniq UNIQUE (user_id, group_id, start);


--
-- Name: hs_access_control_usergroupprovenance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_usergroupprovenance
    ADD CONSTRAINT hs_access_control_usergroupprovenance_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_userresourcepri_user_id_424814b34310c9d3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_userresourceprivilege
    ADD CONSTRAINT hs_access_control_userresourcepri_user_id_424814b34310c9d3_uniq UNIQUE (user_id, resource_id);


--
-- Name: hs_access_control_userresourceprivilege_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_userresourceprivilege
    ADD CONSTRAINT hs_access_control_userresourceprivilege_pkey PRIMARY KEY (id);


--
-- Name: hs_access_control_userresourcepro_user_id_52195a50359334ec_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_userresourceprovenance
    ADD CONSTRAINT hs_access_control_userresourcepro_user_id_52195a50359334ec_uniq UNIQUE (user_id, resource_id, start);


--
-- Name: hs_access_control_userresourceprovenance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_access_control_userresourceprovenance
    ADD CONSTRAINT hs_access_control_userresourceprovenance_pkey PRIMARY KEY (id);


--
-- Name: hs_app_netCDF_netcdfmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "hs_app_netCDF_netcdfmetadata"
    ADD CONSTRAINT "hs_app_netCDF_netcdfmetadata_pkey" PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_app_netCDF_originalcov_content_type_id_6aeae6195249cfcf_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "hs_app_netCDF_originalcoverage"
    ADD CONSTRAINT "hs_app_netCDF_originalcov_content_type_id_6aeae6195249cfcf_uniq" UNIQUE (content_type_id, object_id);


--
-- Name: hs_app_netCDF_originalcoverage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "hs_app_netCDF_originalcoverage"
    ADD CONSTRAINT "hs_app_netCDF_originalcoverage_pkey" PRIMARY KEY (id);


--
-- Name: hs_app_netCDF_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "hs_app_netCDF_variable"
    ADD CONSTRAINT "hs_app_netCDF_variable_pkey" PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvaggregationstatistic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvaggregationstatistic
    ADD CONSTRAINT hs_app_timeseries_cvaggregationstatistic_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvelevationdatum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvelevationdatum
    ADD CONSTRAINT hs_app_timeseries_cvelevationdatum_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvmedium_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvmedium
    ADD CONSTRAINT hs_app_timeseries_cvmedium_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvmethodtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvmethodtype
    ADD CONSTRAINT hs_app_timeseries_cvmethodtype_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvsitetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvsitetype
    ADD CONSTRAINT hs_app_timeseries_cvsitetype_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvspeciation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvspeciation
    ADD CONSTRAINT hs_app_timeseries_cvspeciation_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvstatus
    ADD CONSTRAINT hs_app_timeseries_cvstatus_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvunitstype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvunitstype
    ADD CONSTRAINT hs_app_timeseries_cvunitstype_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvvariablename_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvvariablename
    ADD CONSTRAINT hs_app_timeseries_cvvariablename_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_cvvariabletype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_cvvariabletype
    ADD CONSTRAINT hs_app_timeseries_cvvariabletype_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_method
    ADD CONSTRAINT hs_app_timeseries_method_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_processinglevel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_processinglevel
    ADD CONSTRAINT hs_app_timeseries_processinglevel_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_site
    ADD CONSTRAINT hs_app_timeseries_site_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_timeseriesmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_timeseriesmetadata
    ADD CONSTRAINT hs_app_timeseries_timeseriesmetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_app_timeseries_timeseriesresult_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_timeseriesresult
    ADD CONSTRAINT hs_app_timeseries_timeseriesresult_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_utcoffset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_utcoffset
    ADD CONSTRAINT hs_app_timeseries_utcoffset_pkey PRIMARY KEY (id);


--
-- Name: hs_app_timeseries_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_app_timeseries_variable
    ADD CONSTRAINT hs_app_timeseries_variable_pkey PRIMARY KEY (id);


--
-- Name: hs_collection_resource_collec_collectiondeletedresource_id__key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource_resource_od9f5
    ADD CONSTRAINT hs_collection_resource_collec_collectiondeletedresource_id__key UNIQUE (collectiondeletedresource_id, user_id);


--
-- Name: hs_collection_resource_collectiondeletedresource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource
    ADD CONSTRAINT hs_collection_resource_collectiondeletedresource_pkey PRIMARY KEY (id);


--
-- Name: hs_collection_resource_collectiondeletedresource_resource__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource_resource_od9f5
    ADD CONSTRAINT hs_collection_resource_collectiondeletedresource_resource__pkey PRIMARY KEY (id);


--
-- Name: hs_core_bags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_bags
    ADD CONSTRAINT hs_core_bags_pkey PRIMARY KEY (id);


--
-- Name: hs_core_contributor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_contributor
    ADD CONSTRAINT hs_core_contributor_pkey PRIMARY KEY (id);


--
-- Name: hs_core_coremetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_coremetadata
    ADD CONSTRAINT hs_core_coremetadata_pkey PRIMARY KEY (id);


--
-- Name: hs_core_coverage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_coverage
    ADD CONSTRAINT hs_core_coverage_pkey PRIMARY KEY (id);


--
-- Name: hs_core_coverage_type_5e44b8195dffb14e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_coverage
    ADD CONSTRAINT hs_core_coverage_type_5e44b8195dffb14e_uniq UNIQUE (type, content_type_id, object_id);


--
-- Name: hs_core_creator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_creator
    ADD CONSTRAINT hs_core_creator_pkey PRIMARY KEY (id);


--
-- Name: hs_core_date_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_date
    ADD CONSTRAINT hs_core_date_pkey PRIMARY KEY (id);


--
-- Name: hs_core_date_type_51dc7e471f315ec_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_date
    ADD CONSTRAINT hs_core_date_type_51dc7e471f315ec_uniq UNIQUE (type, content_type_id, object_id);


--
-- Name: hs_core_description_content_type_id_101f8a6db2013e88_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_description
    ADD CONSTRAINT hs_core_description_content_type_id_101f8a6db2013e88_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_core_description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_description
    ADD CONSTRAINT hs_core_description_pkey PRIMARY KEY (id);


--
-- Name: hs_core_externalprofilelink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_externalprofilelink
    ADD CONSTRAINT hs_core_externalprofilelink_pkey PRIMARY KEY (id);


--
-- Name: hs_core_externalprofilelink_type_46054d89a4834f60_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_externalprofilelink
    ADD CONSTRAINT hs_core_externalprofilelink_type_46054d89a4834f60_uniq UNIQUE (type, url, object_id);


--
-- Name: hs_core_format_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_format
    ADD CONSTRAINT hs_core_format_pkey PRIMARY KEY (id);


--
-- Name: hs_core_format_value_8b10e84db4524d5_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_format
    ADD CONSTRAINT hs_core_format_value_8b10e84db4524d5_uniq UNIQUE (value, content_type_id, object_id);


--
-- Name: hs_core_fundingagency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_fundingagency
    ADD CONSTRAINT hs_core_fundingagency_pkey PRIMARY KEY (id);


--
-- Name: hs_core_genericresource_colle_from_baseresource_id_to_baser_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_genericresource_collections
    ADD CONSTRAINT hs_core_genericresource_colle_from_baseresource_id_to_baser_key UNIQUE (from_baseresource_id, to_baseresource_id);


--
-- Name: hs_core_genericresource_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_genericresource_collections
    ADD CONSTRAINT hs_core_genericresource_collections_pkey PRIMARY KEY (id);


--
-- Name: hs_core_genericresource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_genericresource
    ADD CONSTRAINT hs_core_genericresource_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: hs_core_groupownership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_groupownership
    ADD CONSTRAINT hs_core_groupownership_pkey PRIMARY KEY (id);


--
-- Name: hs_core_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_identifier
    ADD CONSTRAINT hs_core_identifier_pkey PRIMARY KEY (id);


--
-- Name: hs_core_identifier_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_identifier
    ADD CONSTRAINT hs_core_identifier_url_key UNIQUE (url);


--
-- Name: hs_core_language_content_type_id_3effcbe0af54718f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_language
    ADD CONSTRAINT hs_core_language_content_type_id_3effcbe0af54718f_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_core_language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_language
    ADD CONSTRAINT hs_core_language_pkey PRIMARY KEY (id);


--
-- Name: hs_core_publisher_content_type_id_1d402c032dd55330_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_publisher
    ADD CONSTRAINT hs_core_publisher_content_type_id_1d402c032dd55330_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_core_publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_publisher
    ADD CONSTRAINT hs_core_publisher_pkey PRIMARY KEY (id);


--
-- Name: hs_core_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_relation
    ADD CONSTRAINT hs_core_relation_pkey PRIMARY KEY (id);


--
-- Name: hs_core_resourcefile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_resourcefile
    ADD CONSTRAINT hs_core_resourcefile_pkey PRIMARY KEY (id);


--
-- Name: hs_core_rights_content_type_id_ef5b26c774a3f32_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_rights
    ADD CONSTRAINT hs_core_rights_content_type_id_ef5b26c774a3f32_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_core_rights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_rights
    ADD CONSTRAINT hs_core_rights_pkey PRIMARY KEY (id);


--
-- Name: hs_core_source_derived_from_76cd74fc0518456b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_source
    ADD CONSTRAINT hs_core_source_derived_from_76cd74fc0518456b_uniq UNIQUE (derived_from, content_type_id, object_id);


--
-- Name: hs_core_source_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_source
    ADD CONSTRAINT hs_core_source_pkey PRIMARY KEY (id);


--
-- Name: hs_core_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_subject
    ADD CONSTRAINT hs_core_subject_pkey PRIMARY KEY (id);


--
-- Name: hs_core_subject_value_4ec0e8f3e12395cd_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_subject
    ADD CONSTRAINT hs_core_subject_value_4ec0e8f3e12395cd_uniq UNIQUE (value, content_type_id, object_id);


--
-- Name: hs_core_title_content_type_id_558a1cad4b729d8a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_title
    ADD CONSTRAINT hs_core_title_content_type_id_558a1cad4b729d8a_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_core_title_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_title
    ADD CONSTRAINT hs_core_title_pkey PRIMARY KEY (id);


--
-- Name: hs_core_type_content_type_id_18ed89604613f1ed_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_type
    ADD CONSTRAINT hs_core_type_content_type_id_18ed89604613f1ed_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_core_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_core_type
    ADD CONSTRAINT hs_core_type_pkey PRIMARY KEY (id);


--
-- Name: hs_file_types_genericfilemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_genericfilemetadata
    ADD CONSTRAINT hs_file_types_genericfilemetadata_pkey PRIMARY KEY (id);


--
-- Name: hs_file_types_genericlogicalfile_metadata_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_genericlogicalfile
    ADD CONSTRAINT hs_file_types_genericlogicalfile_metadata_id_key UNIQUE (metadata_id);


--
-- Name: hs_file_types_genericlogicalfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_genericlogicalfile
    ADD CONSTRAINT hs_file_types_genericlogicalfile_pkey PRIMARY KEY (id);


--
-- Name: hs_file_types_georasterfilemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_georasterfilemetadata
    ADD CONSTRAINT hs_file_types_georasterfilemetadata_pkey PRIMARY KEY (id);


--
-- Name: hs_file_types_georasterlogicalfile_metadata_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_georasterlogicalfile
    ADD CONSTRAINT hs_file_types_georasterlogicalfile_metadata_id_key UNIQUE (metadata_id);


--
-- Name: hs_file_types_georasterlogicalfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_georasterlogicalfile
    ADD CONSTRAINT hs_file_types_georasterlogicalfile_pkey PRIMARY KEY (id);


--
-- Name: hs_file_types_netcdffilemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_netcdffilemetadata
    ADD CONSTRAINT hs_file_types_netcdffilemetadata_pkey PRIMARY KEY (id);


--
-- Name: hs_file_types_netcdflogicalfile_metadata_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_netcdflogicalfile
    ADD CONSTRAINT hs_file_types_netcdflogicalfile_metadata_id_key UNIQUE (metadata_id);


--
-- Name: hs_file_types_netcdflogicalfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_file_types_netcdflogicalfile
    ADD CONSTRAINT hs_file_types_netcdflogicalfile_pkey PRIMARY KEY (id);


--
-- Name: hs_geo_raster_resource_bandinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geo_raster_resource_bandinformation
    ADD CONSTRAINT hs_geo_raster_resource_bandinformation_pkey PRIMARY KEY (id);


--
-- Name: hs_geo_raster_resource_ce_content_type_id_2a5663531ffdbfc0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geo_raster_resource_cellinformation
    ADD CONSTRAINT hs_geo_raster_resource_ce_content_type_id_2a5663531ffdbfc0_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_geo_raster_resource_cellinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geo_raster_resource_cellinformation
    ADD CONSTRAINT hs_geo_raster_resource_cellinformation_pkey PRIMARY KEY (id);


--
-- Name: hs_geo_raster_resource_or_content_type_id_721e66b15ced348a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geo_raster_resource_originalcoverage
    ADD CONSTRAINT hs_geo_raster_resource_or_content_type_id_721e66b15ced348a_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_geo_raster_resource_originalcoverage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geo_raster_resource_originalcoverage
    ADD CONSTRAINT hs_geo_raster_resource_originalcoverage_pkey PRIMARY KEY (id);


--
-- Name: hs_geo_raster_resource_rastermetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geo_raster_resource_rastermetadata
    ADD CONSTRAINT hs_geo_raster_resource_rastermetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_geographic_feature_res_content_type_id_28e85abff23b5f53_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalfileinfo
    ADD CONSTRAINT hs_geographic_feature_res_content_type_id_28e85abff23b5f53_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_geographic_feature_res_content_type_id_304dc81d9f5c66f1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalcoverage
    ADD CONSTRAINT hs_geographic_feature_res_content_type_id_304dc81d9f5c66f1_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_geographic_feature_res_content_type_id_580ebce926dd9f27_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_geometryinformation
    ADD CONSTRAINT hs_geographic_feature_res_content_type_id_580ebce926dd9f27_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_geographic_feature_resource_fieldinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_fieldinformation
    ADD CONSTRAINT hs_geographic_feature_resource_fieldinformation_pkey PRIMARY KEY (id);


--
-- Name: hs_geographic_feature_resource_geographicfeaturemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_geographicfeaturemetadata
    ADD CONSTRAINT hs_geographic_feature_resource_geographicfeaturemetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_geographic_feature_resource_geometryinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_geometryinformation
    ADD CONSTRAINT hs_geographic_feature_resource_geometryinformation_pkey PRIMARY KEY (id);


--
-- Name: hs_geographic_feature_resource_originalcoverage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalcoverage
    ADD CONSTRAINT hs_geographic_feature_resource_originalcoverage_pkey PRIMARY KEY (id);


--
-- Name: hs_geographic_feature_resource_originalfileinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalfileinfo
    ADD CONSTRAINT hs_geographic_feature_resource_originalfileinfo_pkey PRIMARY KEY (id);


--
-- Name: hs_labels_resourcelabels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_resourcelabels
    ADD CONSTRAINT hs_labels_resourcelabels_pkey PRIMARY KEY (id);


--
-- Name: hs_labels_resourcelabels_resource_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_resourcelabels
    ADD CONSTRAINT hs_labels_resourcelabels_resource_id_key UNIQUE (resource_id);


--
-- Name: hs_labels_userlabels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userlabels
    ADD CONSTRAINT hs_labels_userlabels_pkey PRIMARY KEY (id);


--
-- Name: hs_labels_userlabels_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userlabels
    ADD CONSTRAINT hs_labels_userlabels_user_id_key UNIQUE (user_id);


--
-- Name: hs_labels_userresourceflags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userresourceflags
    ADD CONSTRAINT hs_labels_userresourceflags_pkey PRIMARY KEY (id);


--
-- Name: hs_labels_userresourceflags_user_id_69a243739138a875_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userresourceflags
    ADD CONSTRAINT hs_labels_userresourceflags_user_id_69a243739138a875_uniq UNIQUE (user_id, resource_id, kind);


--
-- Name: hs_labels_userresourcelabels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userresourcelabels
    ADD CONSTRAINT hs_labels_userresourcelabels_pkey PRIMARY KEY (id);


--
-- Name: hs_labels_userresourcelabels_user_id_b650ac9425073db_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userresourcelabels
    ADD CONSTRAINT hs_labels_userresourcelabels_user_id_b650ac9425073db_uniq UNIQUE (user_id, resource_id, label);


--
-- Name: hs_labels_userstoredlabels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userstoredlabels
    ADD CONSTRAINT hs_labels_userstoredlabels_pkey PRIMARY KEY (id);


--
-- Name: hs_labels_userstoredlabels_user_id_7fcfa0bbb19f026e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_labels_userstoredlabels
    ADD CONSTRAINT hs_labels_userstoredlabels_user_id_7fcfa0bbb19f026e_uniq UNIQUE (user_id, label);


--
-- Name: hs_model_program_modelprogrammetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_model_program_modelprogrammetadata
    ADD CONSTRAINT hs_model_program_modelprogrammetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_model_program_mpmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_model_program_mpmetadata
    ADD CONSTRAINT hs_model_program_mpmetadata_pkey PRIMARY KEY (id);


--
-- Name: hs_modelinstance_executed_content_type_id_4f66b59ecd8e1887_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modelinstance_executedby
    ADD CONSTRAINT hs_modelinstance_executed_content_type_id_4f66b59ecd8e1887_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modelinstance_executedby_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modelinstance_executedby
    ADD CONSTRAINT hs_modelinstance_executedby_pkey PRIMARY KEY (id);


--
-- Name: hs_modelinstance_modelinstancemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modelinstance_modelinstancemetadata
    ADD CONSTRAINT hs_modelinstance_modelinstancemetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_modelinstance_modeloutp_content_type_id_34b90c2dff9368a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modelinstance_modeloutput
    ADD CONSTRAINT hs_modelinstance_modeloutp_content_type_id_34b90c2dff9368a_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modelinstance_modeloutput_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modelinstance_modeloutput
    ADD CONSTRAINT hs_modelinstance_modeloutput_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance__content_type_id_1235bba5c69ae010_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements
    ADD CONSTRAINT hs_modflow_modelinstance__content_type_id_1235bba5c69ae010_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modflow_modelinstance__content_type_id_330fffdaa6ec9f8f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_stressperiod
    ADD CONSTRAINT hs_modflow_modelinstance__content_type_id_330fffdaa6ec9f8f_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modflow_modelinstance__content_type_id_344bb0e87cdd32d3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_studyarea
    ADD CONSTRAINT hs_modflow_modelinstance__content_type_id_344bb0e87cdd32d3_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modflow_modelinstance__content_type_id_3fcd86bc064509f7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_modelcalibration
    ADD CONSTRAINT hs_modflow_modelinstance__content_type_id_3fcd86bc064509f7_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modflow_modelinstance__content_type_id_58d77ad55e7ef3d9_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_groundwaterflow
    ADD CONSTRAINT hs_modflow_modelinstance__content_type_id_58d77ad55e7ef3d9_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modflow_modelinstance__content_type_id_5a19787953936775_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_griddimensions
    ADD CONSTRAINT hs_modflow_modelinstance__content_type_id_5a19787953936775_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modflow_modelinstance_b_content_type_id_d48fc936a5851d0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition
    ADD CONSTRAINT hs_modflow_modelinstance_b_content_type_id_d48fc936a5851d0_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_modflow_modelinstance_boun_boundarycondition_id_headdepe_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14
    ADD CONSTRAINT hs_modflow_modelinstance_boun_boundarycondition_id_headdepe_key UNIQUE (boundarycondition_id, headdependentfluxboundarypackagechoices_id);


--
-- Name: hs_modflow_modelinstance_boun_boundarycondition_id_specifi_key1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_head_b132e
    ADD CONSTRAINT hs_modflow_modelinstance_boun_boundarycondition_id_specifi_key1 UNIQUE (boundarycondition_id, specifiedheadboundarypackagechoices_id);


--
-- Name: hs_modflow_modelinstance_boun_boundarycondition_id_specifie_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3
    ADD CONSTRAINT hs_modflow_modelinstance_boun_boundarycondition_id_specifie_key UNIQUE (boundarycondition_id, specifiedfluxboundarypackagechoices_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_head_dependent__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14
    ADD CONSTRAINT hs_modflow_modelinstance_boundarycondition_head_dependent__pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition
    ADD CONSTRAINT hs_modflow_modelinstance_boundarycondition_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_flux__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3
    ADD CONSTRAINT hs_modflow_modelinstance_boundarycondition_specified_flux__pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_head__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_head_b132e
    ADD CONSTRAINT hs_modflow_modelinstance_boundarycondition_specified_head__pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_gene_generalelements_id_outputcont_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements_output_control_package
    ADD CONSTRAINT hs_modflow_modelinstance_gene_generalelements_id_outputcont_key UNIQUE (generalelements_id, outputcontrolpackagechoices_id);


--
-- Name: hs_modflow_modelinstance_generalelements_output_control_pa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements_output_control_package
    ADD CONSTRAINT hs_modflow_modelinstance_generalelements_output_control_pa_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_generalelements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements
    ADD CONSTRAINT hs_modflow_modelinstance_generalelements_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_griddimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_griddimensions
    ADD CONSTRAINT hs_modflow_modelinstance_griddimensions_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_groundwaterflow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_groundwaterflow
    ADD CONSTRAINT hs_modflow_modelinstance_groundwaterflow_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_headdependentfluxboundarypackagec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_headdependentfluxboundarypackagechf906
    ADD CONSTRAINT hs_modflow_modelinstance_headdependentfluxboundarypackagec_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_modelcalibration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_modelcalibration
    ADD CONSTRAINT hs_modflow_modelinstance_modelcalibration_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_modelinput_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_modelinput
    ADD CONSTRAINT hs_modflow_modelinstance_modelinput_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_modflowmodelinstancemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_modflowmodelinstancemetadata
    ADD CONSTRAINT hs_modflow_modelinstance_modflowmodelinstancemetadata_pkey PRIMARY KEY (modelinstancemetadata_ptr_id);


--
-- Name: hs_modflow_modelinstance_outputcontrolpackagechoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_outputcontrolpackagechoices
    ADD CONSTRAINT hs_modflow_modelinstance_outputcontrolpackagechoices_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_specifiedfluxboundarypackagechoic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_specifiedfluxboundarypackagechoices
    ADD CONSTRAINT hs_modflow_modelinstance_specifiedfluxboundarypackagechoic_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_specifiedheadboundarypackagechoic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_specifiedheadboundarypackagechoices
    ADD CONSTRAINT hs_modflow_modelinstance_specifiedheadboundarypackagechoic_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_stressperiod_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_stressperiod
    ADD CONSTRAINT hs_modflow_modelinstance_stressperiod_pkey PRIMARY KEY (id);


--
-- Name: hs_modflow_modelinstance_studyarea_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_modflow_modelinstance_studyarea
    ADD CONSTRAINT hs_modflow_modelinstance_studyarea_pkey PRIMARY KEY (id);


--
-- Name: hs_script_resource_script_content_type_id_5eae48b373d35aeb_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_script_resource_scriptspecificmetadata
    ADD CONSTRAINT hs_script_resource_script_content_type_id_5eae48b373d35aeb_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_script_resource_scriptmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_script_resource_scriptmetadata
    ADD CONSTRAINT hs_script_resource_scriptmetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_script_resource_scriptspecificmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_script_resource_scriptspecificmetadata
    ADD CONSTRAINT hs_script_resource_scriptspecificmetadata_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_mod_content_type_id_12914098fd213943_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelmethod
    ADD CONSTRAINT hs_swat_modelinstance_mod_content_type_id_12914098fd213943_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_swat_modelinstance_mod_content_type_id_2589e0316a36326c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter
    ADD CONSTRAINT hs_swat_modelinstance_mod_content_type_id_2589e0316a36326c_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_swat_modelinstance_mod_content_type_id_25b988ceed439ad3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelinput
    ADD CONSTRAINT hs_swat_modelinstance_mod_content_type_id_25b988ceed439ad3_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_swat_modelinstance_mod_content_type_id_42514385fa10eab4_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective
    ADD CONSTRAINT hs_swat_modelinstance_mod_content_type_id_42514385fa10eab4_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_swat_modelinstance_modelinput_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelinput
    ADD CONSTRAINT hs_swat_modelinstance_modelinput_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_modelmethod_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelmethod
    ADD CONSTRAINT hs_swat_modelinstance_modelmethod_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_modelob_modelobjective_id_modelobject_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective_swat_model_objectives
    ADD CONSTRAINT hs_swat_modelinstance_modelob_modelobjective_id_modelobject_key UNIQUE (modelobjective_id, modelobjectivechoices_id);


--
-- Name: hs_swat_modelinstance_modelobjective_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective
    ADD CONSTRAINT hs_swat_modelinstance_modelobjective_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_modelobjective_swat_model_objectives_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective_swat_model_objectives
    ADD CONSTRAINT hs_swat_modelinstance_modelobjective_swat_model_objectives_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_modelobjectivechoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjectivechoices
    ADD CONSTRAINT hs_swat_modelinstance_modelobjectivechoices_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_modelpa_modelparameter_id_modelparame_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter_model_parameters
    ADD CONSTRAINT hs_swat_modelinstance_modelpa_modelparameter_id_modelparame_key UNIQUE (modelparameter_id, modelparameterschoices_id);


--
-- Name: hs_swat_modelinstance_modelparameter_model_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter_model_parameters
    ADD CONSTRAINT hs_swat_modelinstance_modelparameter_model_parameters_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_modelparameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter
    ADD CONSTRAINT hs_swat_modelinstance_modelparameter_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_modelparameterschoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameterschoices
    ADD CONSTRAINT hs_swat_modelinstance_modelparameterschoices_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_sim_content_type_id_2fdb321047680e89_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_simulationtype
    ADD CONSTRAINT hs_swat_modelinstance_sim_content_type_id_2fdb321047680e89_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_swat_modelinstance_simulationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_simulationtype
    ADD CONSTRAINT hs_swat_modelinstance_simulationtype_pkey PRIMARY KEY (id);


--
-- Name: hs_swat_modelinstance_swatmodelinstancemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_swat_modelinstance_swatmodelinstancemetadata
    ADD CONSTRAINT hs_swat_modelinstance_swatmodelinstancemetadata_pkey PRIMARY KEY (modelinstancemetadata_ptr_id);


--
-- Name: hs_tools_resource_apphome_content_type_id_41aff373ca64806a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_apphomepageurl
    ADD CONSTRAINT hs_tools_resource_apphome_content_type_id_41aff373ca64806a_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_tools_resource_apphomepageurl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_apphomepageurl
    ADD CONSTRAINT hs_tools_resource_apphomepageurl_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_request_content_type_id_4247c7cfc01d751b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_requesturlbase
    ADD CONSTRAINT hs_tools_resource_request_content_type_id_4247c7cfc01d751b_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_tools_resource_requesturlbase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_requesturlbase
    ADD CONSTRAINT hs_tools_resource_requesturlbase_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_supportedre_supportedrestypes_id_supporte_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes_supported_res_types
    ADD CONSTRAINT hs_tools_resource_supportedre_supportedrestypes_id_supporte_key UNIQUE (supportedrestypes_id, supportedrestypechoices_id);


--
-- Name: hs_tools_resource_supportedrestypechoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypechoices
    ADD CONSTRAINT hs_tools_resource_supportedrestypechoices_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_supportedrestypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes
    ADD CONSTRAINT hs_tools_resource_supportedrestypes_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_supportedrestypes_supported_res_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes_supported_res_types
    ADD CONSTRAINT hs_tools_resource_supportedrestypes_supported_res_types_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_supportedsh_supportedsharingstatus_id_sup_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus_sharing_status
    ADD CONSTRAINT hs_tools_resource_supportedsh_supportedsharingstatus_id_sup_key UNIQUE (supportedsharingstatus_id, supportedsharingstatuschoices_id);


--
-- Name: hs_tools_resource_supportedsharingstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus
    ADD CONSTRAINT hs_tools_resource_supportedsharingstatus_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_supportedsharingstatus_sharing_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus_sharing_status
    ADD CONSTRAINT hs_tools_resource_supportedsharingstatus_sharing_status_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_supportedsharingstatuschoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatuschoices
    ADD CONSTRAINT hs_tools_resource_supportedsharingstatuschoices_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_toolico_content_type_id_2eb114df398af35f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_toolicon
    ADD CONSTRAINT hs_tools_resource_toolico_content_type_id_2eb114df398af35f_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_tools_resource_toolicon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_toolicon
    ADD CONSTRAINT hs_tools_resource_toolicon_pkey PRIMARY KEY (id);


--
-- Name: hs_tools_resource_toolmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_toolmetadata
    ADD CONSTRAINT hs_tools_resource_toolmetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: hs_tools_resource_toolver_content_type_id_2a1bdb955c1a5eb5_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_toolversion
    ADD CONSTRAINT hs_tools_resource_toolver_content_type_id_2a1bdb955c1a5eb5_uniq UNIQUE (content_type_id, object_id);


--
-- Name: hs_tools_resource_toolversion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tools_resource_toolversion
    ADD CONSTRAINT hs_tools_resource_toolversion_pkey PRIMARY KEY (id);


--
-- Name: hs_tracking_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tracking_session
    ADD CONSTRAINT hs_tracking_session_pkey PRIMARY KEY (id);


--
-- Name: hs_tracking_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tracking_variable
    ADD CONSTRAINT hs_tracking_variable_pkey PRIMARY KEY (id);


--
-- Name: hs_tracking_visitor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tracking_visitor
    ADD CONSTRAINT hs_tracking_visitor_pkey PRIMARY KEY (id);


--
-- Name: hs_tracking_visitor_user_id_e219697e1ed13ee_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hs_tracking_visitor
    ADD CONSTRAINT hs_tracking_visitor_user_id_e219697e1ed13ee_uniq UNIQUE (user_id);


--
-- Name: oauth2_provider_accesstoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_application_client_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_application_client_id_key UNIQUE (client_id);


--
-- Name: oauth2_provider_application_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_application_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_grant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_grant_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_refreshtoken_access_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_access_token_id_key UNIQUE (access_token_id);


--
-- Name: oauth2_provider_refreshtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_pkey PRIMARY KEY (id);


--
-- Name: pages_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pages_link
    ADD CONSTRAINT pages_link_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: pages_page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pages_page
    ADD CONSTRAINT pages_page_pkey PRIMARY KEY (id);


--
-- Name: pages_richtextpage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pages_richtextpage
    ADD CONSTRAINT pages_richtextpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: ref_ts_datasource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_ts_datasource
    ADD CONSTRAINT ref_ts_datasource_pkey PRIMARY KEY (id);


--
-- Name: ref_ts_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_ts_method
    ADD CONSTRAINT ref_ts_method_pkey PRIMARY KEY (id);


--
-- Name: ref_ts_qualitycontrollevel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_ts_qualitycontrollevel
    ADD CONSTRAINT ref_ts_qualitycontrollevel_pkey PRIMARY KEY (id);


--
-- Name: ref_ts_referenceurl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_ts_referenceurl
    ADD CONSTRAINT ref_ts_referenceurl_pkey PRIMARY KEY (id);


--
-- Name: ref_ts_reftsmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_ts_reftsmetadata
    ADD CONSTRAINT ref_ts_reftsmetadata_pkey PRIMARY KEY (coremetadata_ptr_id);


--
-- Name: ref_ts_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_ts_site
    ADD CONSTRAINT ref_ts_site_pkey PRIMARY KEY (id);


--
-- Name: ref_ts_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_ts_variable
    ADD CONSTRAINT ref_ts_variable_pkey PRIMARY KEY (id);


--
-- Name: robots_rule_allowed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_rule_allowed
    ADD CONSTRAINT robots_rule_allowed_pkey PRIMARY KEY (id);


--
-- Name: robots_rule_allowed_rule_id_url_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_rule_allowed
    ADD CONSTRAINT robots_rule_allowed_rule_id_url_id_key UNIQUE (rule_id, url_id);


--
-- Name: robots_rule_disallowed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_rule_disallowed
    ADD CONSTRAINT robots_rule_disallowed_pkey PRIMARY KEY (id);


--
-- Name: robots_rule_disallowed_rule_id_url_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_rule_disallowed
    ADD CONSTRAINT robots_rule_disallowed_rule_id_url_id_key UNIQUE (rule_id, url_id);


--
-- Name: robots_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_rule
    ADD CONSTRAINT robots_rule_pkey PRIMARY KEY (id);


--
-- Name: robots_rule_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_rule_sites
    ADD CONSTRAINT robots_rule_sites_pkey PRIMARY KEY (id);


--
-- Name: robots_rule_sites_rule_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_rule_sites
    ADD CONSTRAINT robots_rule_sites_rule_id_site_id_key UNIQUE (rule_id, site_id);


--
-- Name: robots_url_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY robots_url
    ADD CONSTRAINT robots_url_pkey PRIMARY KEY (id);


--
-- Name: security_cspreport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY security_cspreport
    ADD CONSTRAINT security_cspreport_pkey PRIMARY KEY (id);


--
-- Name: security_passwordexpiry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY security_passwordexpiry
    ADD CONSTRAINT security_passwordexpiry_pkey PRIMARY KEY (id);


--
-- Name: security_passwordexpiry_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY security_passwordexpiry
    ADD CONSTRAINT security_passwordexpiry_user_id_key UNIQUE (user_id);


--
-- Name: theme_homepage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_homepage
    ADD CONSTRAINT theme_homepage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: theme_iconbox_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_iconbox
    ADD CONSTRAINT theme_iconbox_pkey PRIMARY KEY (id);


--
-- Name: theme_quotamessage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_quotamessage
    ADD CONSTRAINT theme_quotamessage_pkey PRIMARY KEY (id);


--
-- Name: theme_siteconfiguration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_siteconfiguration
    ADD CONSTRAINT theme_siteconfiguration_pkey PRIMARY KEY (id);


--
-- Name: theme_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_userprofile
    ADD CONSTRAINT theme_userprofile_pkey PRIMARY KEY (id);


--
-- Name: theme_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_userprofile
    ADD CONSTRAINT theme_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: theme_userquota_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_userquota
    ADD CONSTRAINT theme_userquota_pkey PRIMARY KEY (id);


--
-- Name: theme_userquota_user_id_329a4f07aa9f15a4_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY theme_userquota
    ADD CONSTRAINT theme_userquota_user_id_329a4f07aa9f15a4_uniq UNIQUE (user_id, zone);


--
-- Name: auth_group_name_253ae2a6331666e8_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_name_253ae2a6331666e8_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_51b3b110094b8aae_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX auth_user_username_51b3b110094b8aae_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: blog_blogcategory_site_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogcategory_site_id ON blog_blogcategory USING btree (site_id);


--
-- Name: blog_blogpost_categories_blogcategory_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogpost_categories_blogcategory_id ON blog_blogpost_categories USING btree (blogcategory_id);


--
-- Name: blog_blogpost_categories_blogpost_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogpost_categories_blogpost_id ON blog_blogpost_categories USING btree (blogpost_id);


--
-- Name: blog_blogpost_publish_date_1015da2554a8e97f_uniq; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogpost_publish_date_1015da2554a8e97f_uniq ON blog_blogpost USING btree (publish_date);


--
-- Name: blog_blogpost_related_posts_from_blogpost_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogpost_related_posts_from_blogpost_id ON blog_blogpost_related_posts USING btree (from_blogpost_id);


--
-- Name: blog_blogpost_related_posts_to_blogpost_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogpost_related_posts_to_blogpost_id ON blog_blogpost_related_posts USING btree (to_blogpost_id);


--
-- Name: blog_blogpost_site_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogpost_site_id ON blog_blogpost USING btree (site_id);


--
-- Name: blog_blogpost_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blog_blogpost_user_id ON blog_blogpost USING btree (user_id);


--
-- Name: celery_taskmeta_hidden; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX celery_taskmeta_hidden ON celery_taskmeta USING btree (hidden);


--
-- Name: celery_taskmeta_task_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX celery_taskmeta_task_id_like ON celery_taskmeta USING btree (task_id varchar_pattern_ops);


--
-- Name: celery_tasksetmeta_hidden; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX celery_tasksetmeta_hidden ON celery_tasksetmeta USING btree (hidden);


--
-- Name: celery_tasksetmeta_taskset_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX celery_tasksetmeta_taskset_id_like ON celery_tasksetmeta USING btree (taskset_id varchar_pattern_ops);


--
-- Name: conf_setting_site_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conf_setting_site_id ON conf_setting USING btree (site_id);


--
-- Name: core_sitepermission_sites_site_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX core_sitepermission_sites_site_id ON core_sitepermission_sites USING btree (site_id);


--
-- Name: core_sitepermission_sites_sitepermission_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX core_sitepermission_sites_sitepermission_id ON core_sitepermission_sites USING btree (sitepermission_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_comment_flags_comment_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_comment_flags_comment_id ON django_comment_flags USING btree (comment_id);


--
-- Name: django_comment_flags_flag; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_comment_flags_flag ON django_comment_flags USING btree (flag);


--
-- Name: django_comment_flags_flag_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_comment_flags_flag_like ON django_comment_flags USING btree (flag varchar_pattern_ops);


--
-- Name: django_comment_flags_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_comment_flags_user_id ON django_comment_flags USING btree (user_id);


--
-- Name: django_comments_content_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_comments_content_type_id ON django_comments USING btree (content_type_id);


--
-- Name: django_comments_site_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_comments_site_id ON django_comments USING btree (site_id);


--
-- Name: django_comments_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_comments_user_id ON django_comments USING btree (user_id);


--
-- Name: django_docker_processes_containeroverrides_3885db4e; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_containeroverrides_3885db4e ON django_docker_processes_containeroverrides USING btree (docker_profile_id);


--
-- Name: django_docker_processes_dockerenvvar_3885db4e; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerenvvar_3885db4e ON django_docker_processes_dockerenvvar USING btree (docker_profile_id);


--
-- Name: django_docker_processes_dockerlink_3885db4e; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerlink_3885db4e ON django_docker_processes_dockerlink USING btree (docker_profile_id);


--
-- Name: django_docker_processes_dockerlink_621534b3; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerlink_621534b3 ON django_docker_processes_dockerlink USING btree (docker_overrides_id);


--
-- Name: django_docker_processes_dockerlink_f4faa4b8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerlink_f4faa4b8 ON django_docker_processes_dockerlink USING btree (docker_profile_from_id);


--
-- Name: django_docker_processes_dockerport_3885db4e; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerport_3885db4e ON django_docker_processes_dockerport USING btree (docker_profile_id);


--
-- Name: django_docker_processes_dockerproce_token_1211961caacdde18_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerproce_token_1211961caacdde18_like ON django_docker_processes_dockerprocess USING btree (token varchar_pattern_ops);


--
-- Name: django_docker_processes_dockerprocess_83a0eb3f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerprocess_83a0eb3f ON django_docker_processes_dockerprocess USING btree (profile_id);


--
-- Name: django_docker_processes_dockerprocess_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerprocess_e8701ad4 ON django_docker_processes_dockerprocess USING btree (user_id);


--
-- Name: django_docker_processes_dockerprofil_name_75d7d5a2a3b969e3_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockerprofil_name_75d7d5a2a3b969e3_like ON django_docker_processes_dockerprofile USING btree (name varchar_pattern_ops);


--
-- Name: django_docker_processes_dockervolume_3885db4e; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_dockervolume_3885db4e ON django_docker_processes_dockervolume USING btree (docker_profile_id);


--
-- Name: django_docker_processes_overrideenvvar_064a291d; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_overrideenvvar_064a291d ON django_docker_processes_overrideenvvar USING btree (container_overrides_id);


--
-- Name: django_docker_processes_overridelink_064a291d; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_overridelink_064a291d ON django_docker_processes_overridelink USING btree (container_overrides_id);


--
-- Name: django_docker_processes_overridelink_f4faa4b8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_overridelink_f4faa4b8 ON django_docker_processes_overridelink USING btree (docker_profile_from_id);


--
-- Name: django_docker_processes_overrideport_064a291d; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_overrideport_064a291d ON django_docker_processes_overrideport USING btree (container_overrides_id);


--
-- Name: django_docker_processes_overridevolume_064a291d; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_docker_processes_overridevolume_064a291d ON django_docker_processes_overridevolume USING btree (container_overrides_id);


--
-- Name: django_irods_rodsenvironment_5e7b1936; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_irods_rodsenvironment_5e7b1936 ON django_irods_rodsenvironment USING btree (owner_id);


--
-- Name: django_redirect_91a0b591; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_redirect_91a0b591 ON django_redirect USING btree (old_path);


--
-- Name: django_redirect_9365d6e7; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_redirect_9365d6e7 ON django_redirect USING btree (site_id);


--
-- Name: django_redirect_old_path_9db3e423470cdaf_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_redirect_old_path_9db3e423470cdaf_like ON django_redirect USING btree (old_path varchar_pattern_ops);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_461cfeaa630ca218_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX django_session_session_key_461cfeaa630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: djcelery_periodictask_crontab_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_periodictask_crontab_id ON djcelery_periodictask USING btree (crontab_id);


--
-- Name: djcelery_periodictask_interval_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_periodictask_interval_id ON djcelery_periodictask USING btree (interval_id);


--
-- Name: djcelery_periodictask_name_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_periodictask_name_like ON djcelery_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_hidden; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_hidden ON djcelery_taskstate USING btree (hidden);


--
-- Name: djcelery_taskstate_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_name ON djcelery_taskstate USING btree (name);


--
-- Name: djcelery_taskstate_name_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_name_like ON djcelery_taskstate USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_state; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_state ON djcelery_taskstate USING btree (state);


--
-- Name: djcelery_taskstate_state_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_state_like ON djcelery_taskstate USING btree (state varchar_pattern_ops);


--
-- Name: djcelery_taskstate_task_id_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_task_id_like ON djcelery_taskstate USING btree (task_id varchar_pattern_ops);


--
-- Name: djcelery_taskstate_tstamp; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_tstamp ON djcelery_taskstate USING btree (tstamp);


--
-- Name: djcelery_taskstate_worker_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_taskstate_worker_id ON djcelery_taskstate USING btree (worker_id);


--
-- Name: djcelery_workerstate_hostname_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_workerstate_hostname_like ON djcelery_workerstate USING btree (hostname varchar_pattern_ops);


--
-- Name: djcelery_workerstate_last_heartbeat; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX djcelery_workerstate_last_heartbeat ON djcelery_workerstate USING btree (last_heartbeat);


--
-- Name: forms_field_form_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX forms_field_form_id ON forms_field USING btree (form_id);


--
-- Name: forms_fieldentry_entry_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX forms_fieldentry_entry_id ON forms_fieldentry USING btree (entry_id);


--
-- Name: forms_formentry_form_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX forms_formentry_form_id ON forms_formentry USING btree (form_id);


--
-- Name: ga_ows_ogrdataset_0a1a4dd8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrdataset_0a1a4dd8 ON ga_ows_ogrdataset USING btree (collection_id);


--
-- Name: ga_ows_ogrdataset_81aebe41; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrdataset_81aebe41 ON ga_ows_ogrdataset USING btree (human_name);


--
-- Name: ga_ows_ogrdataset_b068931c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrdataset_b068931c ON ga_ows_ogrdataset USING btree (name);


--
-- Name: ga_ows_ogrdataset_extent_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrdataset_extent_id ON ga_ows_ogrdataset USING gist (extent);


--
-- Name: ga_ows_ogrdataset_human_name_2718979caa46bdd6_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrdataset_human_name_2718979caa46bdd6_like ON ga_ows_ogrdataset USING btree (human_name text_pattern_ops);


--
-- Name: ga_ows_ogrdataset_name_5ef251b0d7fbd366_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrdataset_name_5ef251b0d7fbd366_like ON ga_ows_ogrdataset USING btree (name varchar_pattern_ops);


--
-- Name: ga_ows_ogrlayer_81aebe41; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrlayer_81aebe41 ON ga_ows_ogrlayer USING btree (human_name);


--
-- Name: ga_ows_ogrlayer_b068931c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrlayer_b068931c ON ga_ows_ogrlayer USING btree (name);


--
-- Name: ga_ows_ogrlayer_d366d308; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrlayer_d366d308 ON ga_ows_ogrlayer USING btree (dataset_id);


--
-- Name: ga_ows_ogrlayer_extent_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrlayer_extent_id ON ga_ows_ogrlayer USING gist (extent);


--
-- Name: ga_ows_ogrlayer_human_name_517fb130c5bed6d7_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrlayer_human_name_517fb130c5bed6d7_like ON ga_ows_ogrlayer USING btree (human_name text_pattern_ops);


--
-- Name: ga_ows_ogrlayer_name_440515aa32d1fbcb_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_ows_ogrlayer_name_440515aa32d1fbcb_like ON ga_ows_ogrlayer USING btree (name varchar_pattern_ops);


--
-- Name: ga_resources_catalogpage_5e7b1936; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_catalogpage_5e7b1936 ON ga_resources_catalogpage USING btree (owner_id);


--
-- Name: ga_resources_dataresource_5e7b1936; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_dataresource_5e7b1936 ON ga_resources_dataresource USING btree (owner_id);


--
-- Name: ga_resources_dataresource_bounding_box_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_dataresource_bounding_box_id ON ga_resources_dataresource USING gist (bounding_box);


--
-- Name: ga_resources_dataresource_c17888f6; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_dataresource_c17888f6 ON ga_resources_dataresource USING btree (next_refresh);


--
-- Name: ga_resources_dataresource_native_bounding_box_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_dataresource_native_bounding_box_id ON ga_resources_dataresource USING gist (native_bounding_box);


--
-- Name: ga_resources_orderedresource_6cfffab0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_orderedresource_6cfffab0 ON ga_resources_orderedresource USING btree (data_resource_id);


--
-- Name: ga_resources_orderedresource_e46a33dd; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_orderedresource_e46a33dd ON ga_resources_orderedresource USING btree (resource_group_id);


--
-- Name: ga_resources_relatedresource_51211265; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_relatedresource_51211265 ON ga_resources_relatedresource USING btree (foreign_resource_id);


--
-- Name: ga_resources_renderedlayer_5e7b1936; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_renderedlayer_5e7b1936 ON ga_resources_renderedlayer USING btree (owner_id);


--
-- Name: ga_resources_renderedlayer_6cfffab0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_renderedlayer_6cfffab0 ON ga_resources_renderedlayer USING btree (data_resource_id);


--
-- Name: ga_resources_renderedlayer_d3785984; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_renderedlayer_d3785984 ON ga_resources_renderedlayer USING btree (default_style_id);


--
-- Name: ga_resources_renderedlayer_styles_066f4da0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_renderedlayer_styles_066f4da0 ON ga_resources_renderedlayer_styles USING btree (renderedlayer_id);


--
-- Name: ga_resources_renderedlayer_styles_528292b4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_renderedlayer_styles_528292b4 ON ga_resources_renderedlayer_styles USING btree (style_id);


--
-- Name: ga_resources_style_5e7b1936; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ga_resources_style_5e7b1936 ON ga_resources_style USING btree (owner_id);


--
-- Name: galleries_galleryimage_gallery_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX galleries_galleryimage_gallery_id ON galleries_galleryimage USING btree (gallery_id);


--
-- Name: generic_assignedkeyword_content_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX generic_assignedkeyword_content_type_id ON generic_assignedkeyword USING btree (content_type_id);


--
-- Name: generic_assignedkeyword_keyword_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX generic_assignedkeyword_keyword_id ON generic_assignedkeyword USING btree (keyword_id);


--
-- Name: generic_keyword_site_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX generic_keyword_site_id ON generic_keyword USING btree (site_id);


--
-- Name: generic_rating_content_type_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX generic_rating_content_type_id ON generic_rating USING btree (content_type_id);


--
-- Name: generic_rating_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX generic_rating_user_id ON generic_rating USING btree (user_id);


--
-- Name: generic_threadedcomment_replied_to_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX generic_threadedcomment_replied_to_id ON generic_threadedcomment USING btree (replied_to_id);


--
-- Name: hs_access_control_groupmembershiprequest_0c4f5cd1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupmembershiprequest_0c4f5cd1 ON hs_access_control_groupmembershiprequest USING btree (request_from_id);


--
-- Name: hs_access_control_groupmembershiprequest_4561f31b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupmembershiprequest_4561f31b ON hs_access_control_groupmembershiprequest USING btree (group_to_join_id);


--
-- Name: hs_access_control_groupmembershiprequest_a3f20815; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupmembershiprequest_a3f20815 ON hs_access_control_groupmembershiprequest USING btree (invitation_to_id);


--
-- Name: hs_access_control_groupresourceprivilege_82c60f9f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupresourceprivilege_82c60f9f ON hs_access_control_groupresourceprivilege USING btree (resource_id);


--
-- Name: hs_access_control_groupresourceprivilege_9e767b7c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupresourceprivilege_9e767b7c ON hs_access_control_groupresourceprivilege USING btree (grantor_id);


--
-- Name: hs_access_control_groupresourceprivilege_dc2a4728; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupresourceprivilege_dc2a4728 ON hs_access_control_groupresourceprivilege USING btree (group_id);


--
-- Name: hs_access_control_groupresourceprovenance_0e939a4f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupresourceprovenance_0e939a4f ON hs_access_control_groupresourceprovenance USING btree (group_id);


--
-- Name: hs_access_control_groupresourceprovenance_7e847bf8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupresourceprovenance_7e847bf8 ON hs_access_control_groupresourceprovenance USING btree (grantor_id);


--
-- Name: hs_access_control_groupresourceprovenance_e2f3ef5b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_groupresourceprovenance_e2f3ef5b ON hs_access_control_groupresourceprovenance USING btree (resource_id);


--
-- Name: hs_access_control_usergroupprivilege_80b9f3ef; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_usergroupprivilege_80b9f3ef ON hs_access_control_usergroupprivilege USING btree (user_id);


--
-- Name: hs_access_control_usergroupprivilege_9e767b7c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_usergroupprivilege_9e767b7c ON hs_access_control_usergroupprivilege USING btree (grantor_id);


--
-- Name: hs_access_control_usergroupprivilege_dc2a4728; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_usergroupprivilege_dc2a4728 ON hs_access_control_usergroupprivilege USING btree (group_id);


--
-- Name: hs_access_control_usergroupprovenance_0e939a4f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_usergroupprovenance_0e939a4f ON hs_access_control_usergroupprovenance USING btree (group_id);


--
-- Name: hs_access_control_usergroupprovenance_7e847bf8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_usergroupprovenance_7e847bf8 ON hs_access_control_usergroupprovenance USING btree (grantor_id);


--
-- Name: hs_access_control_usergroupprovenance_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_usergroupprovenance_e8701ad4 ON hs_access_control_usergroupprovenance USING btree (user_id);


--
-- Name: hs_access_control_userresourceprivilege_80b9f3ef; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_userresourceprivilege_80b9f3ef ON hs_access_control_userresourceprivilege USING btree (user_id);


--
-- Name: hs_access_control_userresourceprivilege_82c60f9f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_userresourceprivilege_82c60f9f ON hs_access_control_userresourceprivilege USING btree (resource_id);


--
-- Name: hs_access_control_userresourceprivilege_9e767b7c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_userresourceprivilege_9e767b7c ON hs_access_control_userresourceprivilege USING btree (grantor_id);


--
-- Name: hs_access_control_userresourceprovenance_7e847bf8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_userresourceprovenance_7e847bf8 ON hs_access_control_userresourceprovenance USING btree (grantor_id);


--
-- Name: hs_access_control_userresourceprovenance_e2f3ef5b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_userresourceprovenance_e2f3ef5b ON hs_access_control_userresourceprovenance USING btree (resource_id);


--
-- Name: hs_access_control_userresourceprovenance_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_access_control_userresourceprovenance_e8701ad4 ON hs_access_control_userresourceprovenance USING btree (user_id);


--
-- Name: hs_app_netCDF_originalcoverage_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "hs_app_netCDF_originalcoverage_417f1b1c" ON "hs_app_netCDF_originalcoverage" USING btree (content_type_id);


--
-- Name: hs_app_netCDF_variable_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "hs_app_netCDF_variable_417f1b1c" ON "hs_app_netCDF_variable" USING btree (content_type_id);


--
-- Name: hs_app_timeseries_cvaggregationstatistic_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvaggregationstatistic_ffe73c23 ON hs_app_timeseries_cvaggregationstatistic USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvelevationdatum_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvelevationdatum_ffe73c23 ON hs_app_timeseries_cvelevationdatum USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvmedium_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvmedium_ffe73c23 ON hs_app_timeseries_cvmedium USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvmethodtype_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvmethodtype_ffe73c23 ON hs_app_timeseries_cvmethodtype USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvsitetype_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvsitetype_ffe73c23 ON hs_app_timeseries_cvsitetype USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvspeciation_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvspeciation_ffe73c23 ON hs_app_timeseries_cvspeciation USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvstatus_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvstatus_ffe73c23 ON hs_app_timeseries_cvstatus USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvunitstype_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvunitstype_ffe73c23 ON hs_app_timeseries_cvunitstype USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvvariablename_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvvariablename_ffe73c23 ON hs_app_timeseries_cvvariablename USING btree (metadata_id);


--
-- Name: hs_app_timeseries_cvvariabletype_ffe73c23; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_cvvariabletype_ffe73c23 ON hs_app_timeseries_cvvariabletype USING btree (metadata_id);


--
-- Name: hs_app_timeseries_method_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_method_417f1b1c ON hs_app_timeseries_method USING btree (content_type_id);


--
-- Name: hs_app_timeseries_processinglevel_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_processinglevel_417f1b1c ON hs_app_timeseries_processinglevel USING btree (content_type_id);


--
-- Name: hs_app_timeseries_site_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_site_417f1b1c ON hs_app_timeseries_site USING btree (content_type_id);


--
-- Name: hs_app_timeseries_timeseriesresult_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_timeseriesresult_417f1b1c ON hs_app_timeseries_timeseriesresult USING btree (content_type_id);


--
-- Name: hs_app_timeseries_utcoffset_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_utcoffset_417f1b1c ON hs_app_timeseries_utcoffset USING btree (content_type_id);


--
-- Name: hs_app_timeseries_variable_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_app_timeseries_variable_417f1b1c ON hs_app_timeseries_variable USING btree (content_type_id);


--
-- Name: hs_collection_resource_collectiondeletedresource_0a1a4dd8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_collection_resource_collectiondeletedresource_0a1a4dd8 ON hs_collection_resource_collectiondeletedresource USING btree (collection_id);


--
-- Name: hs_collection_resource_collectiondeletedresource_d19ec81d; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_collection_resource_collectiondeletedresource_d19ec81d ON hs_collection_resource_collectiondeletedresource USING btree (deleted_by_id);


--
-- Name: hs_collection_resource_collectiondeletedresource_resource_o2660; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_collection_resource_collectiondeletedresource_resource_o2660 ON hs_collection_resource_collectiondeletedresource_resource_od9f5 USING btree (collectiondeletedresource_id);


--
-- Name: hs_collection_resource_collectiondeletedresource_resource_ocd4f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_collection_resource_collectiondeletedresource_resource_ocd4f ON hs_collection_resource_collectiondeletedresource_resource_od9f5 USING btree (user_id);


--
-- Name: hs_core_bags_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_bags_417f1b1c ON hs_core_bags USING btree (content_type_id);


--
-- Name: hs_core_bags_d7e6d55b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_bags_d7e6d55b ON hs_core_bags USING btree ("timestamp");


--
-- Name: hs_core_contributor_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_contributor_417f1b1c ON hs_core_contributor USING btree (content_type_id);


--
-- Name: hs_core_coverage_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_coverage_417f1b1c ON hs_core_coverage USING btree (content_type_id);


--
-- Name: hs_core_creator_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_creator_417f1b1c ON hs_core_creator USING btree (content_type_id);


--
-- Name: hs_core_date_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_date_417f1b1c ON hs_core_date USING btree (content_type_id);


--
-- Name: hs_core_description_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_description_417f1b1c ON hs_core_description USING btree (content_type_id);


--
-- Name: hs_core_externalprofilelink_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_externalprofilelink_417f1b1c ON hs_core_externalprofilelink USING btree (content_type_id);


--
-- Name: hs_core_format_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_format_417f1b1c ON hs_core_format USING btree (content_type_id);


--
-- Name: hs_core_fundingagency_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_fundingagency_417f1b1c ON hs_core_fundingagency USING btree (content_type_id);


--
-- Name: hs_core_genericresource_3700153c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_3700153c ON hs_core_genericresource USING btree (creator_id);


--
-- Name: hs_core_genericresource_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_417f1b1c ON hs_core_genericresource USING btree (content_type_id);


--
-- Name: hs_core_genericresource_44cc026e; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_44cc026e ON hs_core_genericresource USING btree (doi);


--
-- Name: hs_core_genericresource_6e3c2cc2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_6e3c2cc2 ON hs_core_genericresource USING btree (last_changed_by_id);


--
-- Name: hs_core_genericresource_7258c37c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_7258c37c ON hs_core_genericresource USING btree (short_id);


--
-- Name: hs_core_genericresource_collections_169f7fce; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_collections_169f7fce ON hs_core_genericresource_collections USING btree (from_baseresource_id);


--
-- Name: hs_core_genericresource_collections_91410dc4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_collections_91410dc4 ON hs_core_genericresource_collections USING btree (to_baseresource_id);


--
-- Name: hs_core_genericresource_doi_1fd041a54c9b75f0_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_doi_1fd041a54c9b75f0_like ON hs_core_genericresource USING btree (doi varchar_pattern_ops);


--
-- Name: hs_core_genericresource_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_e8701ad4 ON hs_core_genericresource USING btree (user_id);


--
-- Name: hs_core_genericresource_short_id_1ccf03b27239c9d9_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_genericresource_short_id_1ccf03b27239c9d9_like ON hs_core_genericresource USING btree (short_id varchar_pattern_ops);


--
-- Name: hs_core_groupownership_0e939a4f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_groupownership_0e939a4f ON hs_core_groupownership USING btree (group_id);


--
-- Name: hs_core_groupownership_5e7b1936; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_groupownership_5e7b1936 ON hs_core_groupownership USING btree (owner_id);


--
-- Name: hs_core_identifier_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_identifier_417f1b1c ON hs_core_identifier USING btree (content_type_id);


--
-- Name: hs_core_identifier_url_5612dd61d821222e_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_identifier_url_5612dd61d821222e_like ON hs_core_identifier USING btree (url varchar_pattern_ops);


--
-- Name: hs_core_language_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_language_417f1b1c ON hs_core_language USING btree (content_type_id);


--
-- Name: hs_core_publisher_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_publisher_417f1b1c ON hs_core_publisher USING btree (content_type_id);


--
-- Name: hs_core_relation_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_relation_417f1b1c ON hs_core_relation USING btree (content_type_id);


--
-- Name: hs_core_resourcefile_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_resourcefile_417f1b1c ON hs_core_resourcefile USING btree (content_type_id);


--
-- Name: hs_core_resourcefile_af839760; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_resourcefile_af839760 ON hs_core_resourcefile USING btree (logical_file_content_type_id);


--
-- Name: hs_core_rights_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_rights_417f1b1c ON hs_core_rights USING btree (content_type_id);


--
-- Name: hs_core_source_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_source_417f1b1c ON hs_core_source USING btree (content_type_id);


--
-- Name: hs_core_subject_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_subject_417f1b1c ON hs_core_subject USING btree (content_type_id);


--
-- Name: hs_core_title_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_title_417f1b1c ON hs_core_title USING btree (content_type_id);


--
-- Name: hs_core_type_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_core_type_417f1b1c ON hs_core_type USING btree (content_type_id);


--
-- Name: hs_geo_raster_resource_bandinformation_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_geo_raster_resource_bandinformation_417f1b1c ON hs_geo_raster_resource_bandinformation USING btree (content_type_id);


--
-- Name: hs_geo_raster_resource_cellinformation_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_geo_raster_resource_cellinformation_417f1b1c ON hs_geo_raster_resource_cellinformation USING btree (content_type_id);


--
-- Name: hs_geo_raster_resource_originalcoverage_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_geo_raster_resource_originalcoverage_417f1b1c ON hs_geo_raster_resource_originalcoverage USING btree (content_type_id);


--
-- Name: hs_geographic_feature_resource_fieldinformation_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_geographic_feature_resource_fieldinformation_417f1b1c ON hs_geographic_feature_resource_fieldinformation USING btree (content_type_id);


--
-- Name: hs_geographic_feature_resource_geometryinformation_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_geographic_feature_resource_geometryinformation_417f1b1c ON hs_geographic_feature_resource_geometryinformation USING btree (content_type_id);


--
-- Name: hs_geographic_feature_resource_originalcoverage_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_geographic_feature_resource_originalcoverage_417f1b1c ON hs_geographic_feature_resource_originalcoverage USING btree (content_type_id);


--
-- Name: hs_geographic_feature_resource_originalfileinfo_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_geographic_feature_resource_originalfileinfo_417f1b1c ON hs_geographic_feature_resource_originalfileinfo USING btree (content_type_id);


--
-- Name: hs_labels_userresourceflags_e2f3ef5b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_labels_userresourceflags_e2f3ef5b ON hs_labels_userresourceflags USING btree (resource_id);


--
-- Name: hs_labels_userresourceflags_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_labels_userresourceflags_e8701ad4 ON hs_labels_userresourceflags USING btree (user_id);


--
-- Name: hs_labels_userresourcelabels_e2f3ef5b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_labels_userresourcelabels_e2f3ef5b ON hs_labels_userresourcelabels USING btree (resource_id);


--
-- Name: hs_labels_userresourcelabels_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_labels_userresourcelabels_e8701ad4 ON hs_labels_userresourcelabels USING btree (user_id);


--
-- Name: hs_labels_userstoredlabels_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_labels_userstoredlabels_e8701ad4 ON hs_labels_userstoredlabels USING btree (user_id);


--
-- Name: hs_model_program_mpmetadata_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_model_program_mpmetadata_417f1b1c ON hs_model_program_mpmetadata USING btree (content_type_id);


--
-- Name: hs_modelinstance_executedby_13081cb2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modelinstance_executedby_13081cb2 ON hs_modelinstance_executedby USING btree (model_program_fk_id);


--
-- Name: hs_modelinstance_executedby_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modelinstance_executedby_417f1b1c ON hs_modelinstance_executedby USING btree (content_type_id);


--
-- Name: hs_modelinstance_modeloutput_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modelinstance_modeloutput_417f1b1c ON hs_modelinstance_modeloutput USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_boundarycondition_417f1b1c ON hs_modflow_modelinstance_boundarycondition USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_head_dependent_f217f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_boundarycondition_head_dependent_f217f ON hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14 USING btree (boundarycondition_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_head_dependent_f45e4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_boundarycondition_head_dependent_f45e4 ON hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14 USING btree (headdependentfluxboundarypackagechoices_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_flux_b4479; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_boundarycondition_specified_flux_b4479 ON hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3 USING btree (specifiedfluxboundarypackagechoices_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_flux_b5fb8; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_boundarycondition_specified_flux_b5fb8 ON hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3 USING btree (boundarycondition_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_head_b08d9; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_boundarycondition_specified_head_b08d9 ON hs_modflow_modelinstance_boundarycondition_specified_head_b132e USING btree (specifiedheadboundarypackagechoices_id);


--
-- Name: hs_modflow_modelinstance_boundarycondition_specified_head_bb816; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_boundarycondition_specified_head_bb816 ON hs_modflow_modelinstance_boundarycondition_specified_head_b132e USING btree (boundarycondition_id);


--
-- Name: hs_modflow_modelinstance_generalelements_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_generalelements_417f1b1c ON hs_modflow_modelinstance_generalelements USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_generalelements_output_control_pac7b3f; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_generalelements_output_control_pac7b3f ON hs_modflow_modelinstance_generalelements_output_control_package USING btree (outputcontrolpackagechoices_id);


--
-- Name: hs_modflow_modelinstance_generalelements_output_control_pacf0f0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_generalelements_output_control_pacf0f0 ON hs_modflow_modelinstance_generalelements_output_control_package USING btree (generalelements_id);


--
-- Name: hs_modflow_modelinstance_griddimensions_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_griddimensions_417f1b1c ON hs_modflow_modelinstance_griddimensions USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_groundwaterflow_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_groundwaterflow_417f1b1c ON hs_modflow_modelinstance_groundwaterflow USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_modelcalibration_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_modelcalibration_417f1b1c ON hs_modflow_modelinstance_modelcalibration USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_modelinput_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_modelinput_417f1b1c ON hs_modflow_modelinstance_modelinput USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_stressperiod_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_stressperiod_417f1b1c ON hs_modflow_modelinstance_stressperiod USING btree (content_type_id);


--
-- Name: hs_modflow_modelinstance_studyarea_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_modflow_modelinstance_studyarea_417f1b1c ON hs_modflow_modelinstance_studyarea USING btree (content_type_id);


--
-- Name: hs_script_resource_scriptspecificmetadata_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_script_resource_scriptspecificmetadata_417f1b1c ON hs_script_resource_scriptspecificmetadata USING btree (content_type_id);


--
-- Name: hs_swat_modelinstance_modelinput_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelinput_417f1b1c ON hs_swat_modelinstance_modelinput USING btree (content_type_id);


--
-- Name: hs_swat_modelinstance_modelmethod_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelmethod_417f1b1c ON hs_swat_modelinstance_modelmethod USING btree (content_type_id);


--
-- Name: hs_swat_modelinstance_modelobjective_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelobjective_417f1b1c ON hs_swat_modelinstance_modelobjective USING btree (content_type_id);


--
-- Name: hs_swat_modelinstance_modelobjective_swat_model_objectives_402b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelobjective_swat_model_objectives_402b ON hs_swat_modelinstance_modelobjective_swat_model_objectives USING btree (modelobjective_id);


--
-- Name: hs_swat_modelinstance_modelobjective_swat_model_objectives_5316; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelobjective_swat_model_objectives_5316 ON hs_swat_modelinstance_modelobjective_swat_model_objectives USING btree (modelobjectivechoices_id);


--
-- Name: hs_swat_modelinstance_modelparameter_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelparameter_417f1b1c ON hs_swat_modelinstance_modelparameter USING btree (content_type_id);


--
-- Name: hs_swat_modelinstance_modelparameter_model_parameters_614dbbb6; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelparameter_model_parameters_614dbbb6 ON hs_swat_modelinstance_modelparameter_model_parameters USING btree (modelparameter_id);


--
-- Name: hs_swat_modelinstance_modelparameter_model_parameters_d6566261; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_modelparameter_model_parameters_d6566261 ON hs_swat_modelinstance_modelparameter_model_parameters USING btree (modelparameterschoices_id);


--
-- Name: hs_swat_modelinstance_simulationtype_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_swat_modelinstance_simulationtype_417f1b1c ON hs_swat_modelinstance_simulationtype USING btree (content_type_id);


--
-- Name: hs_tools_resource_apphomepageurl_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_apphomepageurl_417f1b1c ON hs_tools_resource_apphomepageurl USING btree (content_type_id);


--
-- Name: hs_tools_resource_requesturlbase_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_requesturlbase_417f1b1c ON hs_tools_resource_requesturlbase USING btree (content_type_id);


--
-- Name: hs_tools_resource_supportedrestypes_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_supportedrestypes_417f1b1c ON hs_tools_resource_supportedrestypes USING btree (content_type_id);


--
-- Name: hs_tools_resource_supportedrestypes_supported_res_types_a538657; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_supportedrestypes_supported_res_types_a538657 ON hs_tools_resource_supportedrestypes_supported_res_types USING btree (supportedrestypechoices_id);


--
-- Name: hs_tools_resource_supportedrestypes_supported_res_types_ae94a0b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_supportedrestypes_supported_res_types_ae94a0b ON hs_tools_resource_supportedrestypes_supported_res_types USING btree (supportedrestypes_id);


--
-- Name: hs_tools_resource_supportedsharingstatus_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_supportedsharingstatus_417f1b1c ON hs_tools_resource_supportedsharingstatus USING btree (content_type_id);


--
-- Name: hs_tools_resource_supportedsharingstatus_sharing_status_ba95e5d; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_supportedsharingstatus_sharing_status_ba95e5d ON hs_tools_resource_supportedsharingstatus_sharing_status USING btree (supportedsharingstatuschoices_id);


--
-- Name: hs_tools_resource_supportedsharingstatus_sharing_status_c4e90cb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_supportedsharingstatus_sharing_status_c4e90cb ON hs_tools_resource_supportedsharingstatus_sharing_status USING btree (supportedsharingstatus_id);


--
-- Name: hs_tools_resource_toolicon_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_toolicon_417f1b1c ON hs_tools_resource_toolicon USING btree (content_type_id);


--
-- Name: hs_tools_resource_toolversion_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tools_resource_toolversion_417f1b1c ON hs_tools_resource_toolversion USING btree (content_type_id);


--
-- Name: hs_tracking_session_bfc2f125; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tracking_session_bfc2f125 ON hs_tracking_session USING btree (visitor_id);


--
-- Name: hs_tracking_variable_7fc8ef54; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tracking_variable_7fc8ef54 ON hs_tracking_variable USING btree (session_id);


--
-- Name: hs_tracking_visitor_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hs_tracking_visitor_e8701ad4 ON hs_tracking_visitor USING btree (user_id);


--
-- Name: oauth2_provider_accesstoken_6bc0a4eb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_accesstoken_6bc0a4eb ON oauth2_provider_accesstoken USING btree (application_id);


--
-- Name: oauth2_provider_accesstoken_94a08da1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_accesstoken_94a08da1 ON oauth2_provider_accesstoken USING btree (token);


--
-- Name: oauth2_provider_accesstoken_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_accesstoken_e8701ad4 ON oauth2_provider_accesstoken USING btree (user_id);


--
-- Name: oauth2_provider_accesstoken_token_3f77f86fb4ecbe0f_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_accesstoken_token_3f77f86fb4ecbe0f_like ON oauth2_provider_accesstoken USING btree (token varchar_pattern_ops);


--
-- Name: oauth2_provider_application_9d667c2b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_application_9d667c2b ON oauth2_provider_application USING btree (client_secret);


--
-- Name: oauth2_provider_application_client_id_58c909672dac14b2_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_application_client_id_58c909672dac14b2_like ON oauth2_provider_application USING btree (client_id varchar_pattern_ops);


--
-- Name: oauth2_provider_application_client_secret_7a03c41cdcace5e9_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_application_client_secret_7a03c41cdcace5e9_like ON oauth2_provider_application USING btree (client_secret varchar_pattern_ops);


--
-- Name: oauth2_provider_application_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_application_e8701ad4 ON oauth2_provider_application USING btree (user_id);


--
-- Name: oauth2_provider_grant_6bc0a4eb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_grant_6bc0a4eb ON oauth2_provider_grant USING btree (application_id);


--
-- Name: oauth2_provider_grant_c1336794; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_grant_c1336794 ON oauth2_provider_grant USING btree (code);


--
-- Name: oauth2_provider_grant_code_a5c88732687483b_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_grant_code_a5c88732687483b_like ON oauth2_provider_grant USING btree (code varchar_pattern_ops);


--
-- Name: oauth2_provider_grant_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_grant_e8701ad4 ON oauth2_provider_grant USING btree (user_id);


--
-- Name: oauth2_provider_refreshtoken_6bc0a4eb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_refreshtoken_6bc0a4eb ON oauth2_provider_refreshtoken USING btree (application_id);


--
-- Name: oauth2_provider_refreshtoken_94a08da1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_refreshtoken_94a08da1 ON oauth2_provider_refreshtoken USING btree (token);


--
-- Name: oauth2_provider_refreshtoken_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_refreshtoken_e8701ad4 ON oauth2_provider_refreshtoken USING btree (user_id);


--
-- Name: oauth2_provider_refreshtoken_token_1e4e9388e6a22527_like; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX oauth2_provider_refreshtoken_token_1e4e9388e6a22527_like ON oauth2_provider_refreshtoken USING btree (token varchar_pattern_ops);


--
-- Name: pages_page_parent_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX pages_page_parent_id ON pages_page USING btree (parent_id);


--
-- Name: pages_page_publish_date_4b581dded15f4cdf_uniq; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX pages_page_publish_date_4b581dded15f4cdf_uniq ON pages_page USING btree (publish_date);


--
-- Name: pages_page_site_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX pages_page_site_id ON pages_page USING btree (site_id);


--
-- Name: ref_ts_datasource_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ref_ts_datasource_417f1b1c ON ref_ts_datasource USING btree (content_type_id);


--
-- Name: ref_ts_method_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ref_ts_method_417f1b1c ON ref_ts_method USING btree (content_type_id);


--
-- Name: ref_ts_qualitycontrollevel_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ref_ts_qualitycontrollevel_417f1b1c ON ref_ts_qualitycontrollevel USING btree (content_type_id);


--
-- Name: ref_ts_referenceurl_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ref_ts_referenceurl_417f1b1c ON ref_ts_referenceurl USING btree (content_type_id);


--
-- Name: ref_ts_site_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ref_ts_site_417f1b1c ON ref_ts_site USING btree (content_type_id);


--
-- Name: ref_ts_variable_417f1b1c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ref_ts_variable_417f1b1c ON ref_ts_variable USING btree (content_type_id);


--
-- Name: robots_rule_allowed_29608e0a; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX robots_rule_allowed_29608e0a ON robots_rule_allowed USING btree (url_id);


--
-- Name: robots_rule_allowed_e1150e65; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX robots_rule_allowed_e1150e65 ON robots_rule_allowed USING btree (rule_id);


--
-- Name: robots_rule_disallowed_29608e0a; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX robots_rule_disallowed_29608e0a ON robots_rule_disallowed USING btree (url_id);


--
-- Name: robots_rule_disallowed_e1150e65; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX robots_rule_disallowed_e1150e65 ON robots_rule_disallowed USING btree (rule_id);


--
-- Name: robots_rule_sites_9365d6e7; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX robots_rule_sites_9365d6e7 ON robots_rule_sites USING btree (site_id);


--
-- Name: robots_rule_sites_e1150e65; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX robots_rule_sites_e1150e65 ON robots_rule_sites USING btree (rule_id);


--
-- Name: theme_iconbox_a6c7fe0b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX theme_iconbox_a6c7fe0b ON theme_iconbox USING btree (homepage_id);


--
-- Name: theme_siteconfiguration_9365d6e7; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX theme_siteconfiguration_9365d6e7 ON theme_siteconfiguration USING btree (site_id);


--
-- Name: theme_userquota_e8701ad4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX theme_userquota_e8701ad4 ON theme_userquota USING btree (user_id);


--
-- Name: D06f823643368bccb48b891b95ec0ad8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvaggregationstatistic
    ADD CONSTRAINT "D06f823643368bccb48b891b95ec0ad8" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D08b32ecb2a1f6c60231933ce1770ca8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overridelink
    ADD CONSTRAINT "D08b32ecb2a1f6c60231933ce1770ca8" FOREIGN KEY (container_overrides_id) REFERENCES django_docker_processes_containeroverrides(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D09565e6cc06d29a0ce80066a7186d73; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "hs_app_netCDF_netcdfmetadata"
    ADD CONSTRAINT "D09565e6cc06d29a0ce80066a7186d73" FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D0d41531a62e8a1740c2e8b57a4309ae; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_orderedresource
    ADD CONSTRAINT "D0d41531a62e8a1740c2e8b57a4309ae" FOREIGN KEY (data_resource_id) REFERENCES ga_resources_dataresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D122fb62e9df31f5bd8fb766773e4bd8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_reftsmetadata
    ADD CONSTRAINT "D122fb62e9df31f5bd8fb766773e4bd8" FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D160961fcba05fdd989826403bd5f914; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective_swat_model_objectives
    ADD CONSTRAINT "D160961fcba05fdd989826403bd5f914" FOREIGN KEY (modelobjectivechoices_id) REFERENCES hs_swat_modelinstance_modelobjectivechoices(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D16cd563c928a22ccbdb7c425a399b3c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerlink
    ADD CONSTRAINT "D16cd563c928a22ccbdb7c425a399b3c" FOREIGN KEY (docker_profile_from_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D1aa88a4e8e7c50866281523397c0b8e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective_swat_model_objectives
    ADD CONSTRAINT "D1aa88a4e8e7c50866281523397c0b8e" FOREIGN KEY (modelobjective_id) REFERENCES hs_swat_modelinstance_modelobjective(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D1c0b5309109a103589fe605907962d9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerprocess
    ADD CONSTRAINT "D1c0b5309109a103589fe605907962d9" FOREIGN KEY (profile_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D1cd11468aed7088c8176baf1733f0a9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockervolume
    ADD CONSTRAINT "D1cd11468aed7088c8176baf1733f0a9" FOREIGN KEY (docker_profile_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D1e7195e758b0263af0eacc76c6209cb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvmedium
    ADD CONSTRAINT "D1e7195e758b0263af0eacc76c6209cb" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D2006077d53969adf4c3976e6901d05f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvspeciation
    ADD CONSTRAINT "D2006077d53969adf4c3976e6901d05f" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D20f1d2ac7f207505c3256f2450e5ccf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3
    ADD CONSTRAINT "D20f1d2ac7f207505c3256f2450e5ccf" FOREIGN KEY (boundarycondition_id) REFERENCES hs_modflow_modelinstance_boundarycondition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D22dcb573d00d765370a2f5986bb9bec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprivilege
    ADD CONSTRAINT "D22dcb573d00d765370a2f5986bb9bec" FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D2339626414192982538d20c2f5e41c1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userresourcelabels
    ADD CONSTRAINT "D2339626414192982538d20c2f5e41c1" FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D28d4ec87c18a4f707acafb3b265fe0b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_model_program_modelprogrammetadata
    ADD CONSTRAINT "D28d4ec87c18a4f707acafb3b265fe0b" FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D298685713846fce4c3b8f825f6971fc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter_model_parameters
    ADD CONSTRAINT "D298685713846fce4c3b8f825f6971fc" FOREIGN KEY (modelparameterschoices_id) REFERENCES hs_swat_modelinstance_modelparameterschoices(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D2ae4d7294972946c7fb21a189d8db4f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvunitstype
    ADD CONSTRAINT "D2ae4d7294972946c7fb21a189d8db4f" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D31151cd560fcd8a9d7eac2bbb5b84c9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource_collections
    ADD CONSTRAINT "D31151cd560fcd8a9d7eac2bbb5b84c9" FOREIGN KEY (to_baseresource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D31c29d49b8f7ec3acaeadd6d03d4a4f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerlink
    ADD CONSTRAINT "D31c29d49b8f7ec3acaeadd6d03d4a4f" FOREIGN KEY (docker_profile_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D32ba2c486744129466dda799ab814ef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_head_b132e
    ADD CONSTRAINT "D32ba2c486744129466dda799ab814ef" FOREIGN KEY (specifiedheadboundarypackagechoices_id) REFERENCES hs_modflow_modelinstance_specifiedheadboundarypackagechoices(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D33ece86ac4d6b9f723a21fc5ee52956; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerport
    ADD CONSTRAINT "D33ece86ac4d6b9f723a21fc5ee52956" FOREIGN KEY (docker_profile_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D3774497fc72c82be6a35a3e9797e2da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_orderedresource
    ADD CONSTRAINT "D3774497fc72c82be6a35a3e9797e2da" FOREIGN KEY (resource_group_id) REFERENCES ga_resources_resourcegroup(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D3835981fd9005eab8e0e525f4347b65; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements_output_control_package
    ADD CONSTRAINT "D3835981fd9005eab8e0e525f4347b65" FOREIGN KEY (generalelements_id) REFERENCES hs_modflow_modelinstance_generalelements(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D3b8f216add6cac2db16e651d8cfd7eb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvstatus
    ADD CONSTRAINT "D3b8f216add6cac2db16e651d8cfd7eb" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D3ddf29327dcf888bd232c7b0fc88c25; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_relatedresource
    ADD CONSTRAINT "D3ddf29327dcf888bd232c7b0fc88c25" FOREIGN KEY (foreign_resource_id) REFERENCES ga_resources_dataresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D4174b69c892f2b9a3bd164e041c7307; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_toolmetadata
    ADD CONSTRAINT "D4174b69c892f2b9a3bd164e041c7307" FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D4494202da9df682a8acda71be9628f3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_renderedlayer
    ADD CONSTRAINT "D4494202da9df682a8acda71be9628f3" FOREIGN KEY (default_style_id) REFERENCES ga_resources_style(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D45bbb0995f328a0a002d8f6df90b6c5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes_supported_res_types
    ADD CONSTRAINT "D45bbb0995f328a0a002d8f6df90b6c5" FOREIGN KEY (supportedrestypechoices_id) REFERENCES hs_tools_resource_supportedrestypechoices(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D467aacf426b069679ea1cdc7ff9cc2a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_script_resource_scriptmetadata
    ADD CONSTRAINT "D467aacf426b069679ea1cdc7ff9cc2a" FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D48a411256da170b9875a1b73187bdaf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvvariablename
    ADD CONSTRAINT "D48a411256da170b9875a1b73187bdaf" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D4c1ff7947a4fbf604d9103f57d33cc8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvvariabletype
    ADD CONSTRAINT "D4c1ff7947a4fbf604d9103f57d33cc8" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D59977fad305f0130e8e94d0cf611f50; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_timeseriesmetadata
    ADD CONSTRAINT "D59977fad305f0130e8e94d0cf611f50" FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D5b97bbd43dc74b22e279a355699342b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overridelink
    ADD CONSTRAINT "D5b97bbd43dc74b22e279a355699342b" FOREIGN KEY (docker_profile_from_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D6034a35ca71ed016b70a82b4ccb56ae; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvsitetype
    ADD CONSTRAINT "D6034a35ca71ed016b70a82b4ccb56ae" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D608e8d602265386bd6d7afacb14cc09; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_containeroverrides
    ADD CONSTRAINT "D608e8d602265386bd6d7afacb14cc09" FOREIGN KEY (docker_profile_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D61444138ccc9b7ca512515523d0160b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_resourcefile
    ADD CONSTRAINT "D61444138ccc9b7ca512515523d0160b" FOREIGN KEY (logical_file_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D66495776709e8754037f4f18d4258ac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource_collections
    ADD CONSTRAINT "D66495776709e8754037f4f18d4258ac" FOREIGN KEY (from_baseresource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D66abd734664aa960007027384fa6de8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_ows_ogrdataset
    ADD CONSTRAINT "D66abd734664aa960007027384fa6de8" FOREIGN KEY (collection_id) REFERENCES ga_ows_ogrdatasetcollection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D6b8a9e44c81b6ef0edc08ba3acdf181; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_renderedlayer_styles
    ADD CONSTRAINT "D6b8a9e44c81b6ef0edc08ba3acdf181" FOREIGN KEY (renderedlayer_id) REFERENCES ga_resources_renderedlayer(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D6f5f0817512c0e51eb157b953080433; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerenvvar
    ADD CONSTRAINT "D6f5f0817512c0e51eb157b953080433" FOREIGN KEY (docker_profile_id) REFERENCES django_docker_processes_dockerprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D763f5ed6fe4d4d08ecfcae173cbca3d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprovenance
    ADD CONSTRAINT "D763f5ed6fe4d4d08ecfcae173cbca3d" FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D77a94435500366d22adf10c6c1c223f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements_output_control_package
    ADD CONSTRAINT "D77a94435500366d22adf10c6c1c223f" FOREIGN KEY (outputcontrolpackagechoices_id) REFERENCES hs_modflow_modelinstance_outputcontrolpackagechoices(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D792bbec64dddad2dfcdc3c0be032f83; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes_supported_res_types
    ADD CONSTRAINT "D792bbec64dddad2dfcdc3c0be032f83" FOREIGN KEY (supportedrestypes_id) REFERENCES hs_tools_resource_supportedrestypes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D7debcf7f242d3a5f0641c098590a0a5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvmethodtype
    ADD CONSTRAINT "D7debcf7f242d3a5f0641c098590a0a5" FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D7e7cede746315ab9e08ce902995fd0e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_renderedlayer
    ADD CONSTRAINT "D7e7cede746315ab9e08ce902995fd0e" FOREIGN KEY (data_resource_id) REFERENCES ga_resources_dataresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D8938581c83cc6c124d95b521cad33bd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus_sharing_status
    ADD CONSTRAINT "D8938581c83cc6c124d95b521cad33bd" FOREIGN KEY (supportedsharingstatuschoices_id) REFERENCES hs_tools_resource_supportedsharingstatuschoices(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D92d4a32581cfe2707bdff092fcf5882; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus_sharing_status
    ADD CONSTRAINT "D92d4a32581cfe2707bdff092fcf5882" FOREIGN KEY (supportedsharingstatus_id) REFERENCES hs_tools_resource_supportedsharingstatus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D939acd71ef4c768cad03ae2dffa0298; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource
    ADD CONSTRAINT "D939acd71ef4c768cad03ae2dffa0298" FOREIGN KEY (collection_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D974d2716a41941895f984ef6808618c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_modflowmodelinstancemetadata
    ADD CONSTRAINT "D974d2716a41941895f984ef6808618c" FOREIGN KEY (modelinstancemetadata_ptr_id) REFERENCES hs_modelinstance_modelinstancemetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D9aead397b25d8154e554023da34d33b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT "D9aead397b25d8154e554023da34d33b" FOREIGN KEY (access_token_id) REFERENCES oauth2_provider_accesstoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: a17250f96ea449de36002be9c6c6acfb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_accesstoken
    ADD CONSTRAINT a17250f96ea449de36002be9c6c6acfb FOREIGN KEY (application_id) REFERENCES oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: a7a04a83e3272ec48b241a40cc3fe88d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprivilege
    ADD CONSTRAINT a7a04a83e3272ec48b241a40cc3fe88d FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ad127dae388d348e8d57f9ed18647c59; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter_model_parameters
    ADD CONSTRAINT ad127dae388d348e8d57f9ed18647c59 FOREIGN KEY (modelparameter_id) REFERENCES hs_swat_modelinstance_modelparameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ad357fc5c051674a76b5a40bea60bd66; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_flux_b87d3
    ADD CONSTRAINT ad357fc5c051674a76b5a40bea60bd66 FOREIGN KEY (specifiedfluxboundarypackagechoices_id) REFERENCES hs_modflow_modelinstance_specifiedfluxboundarypackagechoices(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ad492224ba8c27b74282fb2c6035021e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modelinstance_modelinstancemetadata
    ADD CONSTRAINT ad492224ba8c27b74282fb2c6035021e FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: af02e022ea42188a60afa88f28aef2b9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_cvelevationdatum
    ADD CONSTRAINT af02e022ea42188a60afa88f28aef2b9 FOREIGN KEY (metadata_id) REFERENCES hs_app_timeseries_timeseriesmetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_508cf46651277a81_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b47420973174e99d60b21c97419b7e7d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_swatmodelinstancemetadata
    ADD CONSTRAINT b47420973174e99d60b21c97419b7e7d FOREIGN KEY (modelinstancemetadata_ptr_id) REFERENCES hs_modelinstance_modelinstancemetadata(coremetadata_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b517e4a4254c99705d2ef3b2b833cff4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_netcdflogicalfile
    ADD CONSTRAINT b517e4a4254c99705d2ef3b2b833cff4 FOREIGN KEY (metadata_id) REFERENCES hs_file_types_netcdffilemetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b63b96a572d7b3efb2f8fb476540a554; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_resourceaccess
    ADD CONSTRAINT b63b96a572d7b3efb2f8fb476540a554 FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b880a3861b1b4ee955080e12d158b7e7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userresourceflags
    ADD CONSTRAINT b880a3861b1b4ee955080e12d158b7e7 FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blogcategory_id_refs_id_91693b1c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogpost_categories
    ADD CONSTRAINT blogcategory_id_refs_id_91693b1c FOREIGN KEY (blogcategory_id) REFERENCES blog_blogcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blogpost_id_refs_id_6a2ad936; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogpost_categories
    ADD CONSTRAINT blogpost_id_refs_id_6a2ad936 FOREIGN KEY (blogpost_id) REFERENCES blog_blogpost(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ca4a9cd99a95a85ce7365a740304c84e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerlink
    ADD CONSTRAINT ca4a9cd99a95a85ce7365a740304c84e FOREIGN KEY (docker_overrides_id) REFERENCES django_docker_processes_containeroverrides(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cf0442e99cc22aab4bc90b95654d14ab; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_georasterlogicalfile
    ADD CONSTRAINT cf0442e99cc22aab4bc90b95654d14ab FOREIGN KEY (metadata_id) REFERENCES hs_file_types_georasterfilemetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cf79e6373a5ffeee73541ef57e96090d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_file_types_genericlogicalfile
    ADD CONSTRAINT cf79e6373a5ffeee73541ef57e96090d FOREIGN KEY (metadata_id) REFERENCES hs_file_types_genericfilemetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: comment_ptr_id_refs_id_d4c241e5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_threadedcomment
    ADD CONSTRAINT comment_ptr_id_refs_id_d4c241e5 FOREIGN KEY (comment_ptr_id) REFERENCES django_comments(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: coremetadata_ptr_id_94bd0d87da46011_fk_hs_core_coremetadata_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_geographicfeaturemetadata
    ADD CONSTRAINT coremetadata_ptr_id_94bd0d87da46011_fk_hs_core_coremetadata_id FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: d4e9b3137507001988ea891be22e9789; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_resourcelabels
    ADD CONSTRAINT d4e9b3137507001988ea891be22e9789 FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: da2196e2988877260c8db8e9bb03265e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT da2196e2988877260c8db8e9bb03265e FOREIGN KEY (application_id) REFERENCES oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_697914295151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_comment_flags_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_comment_flags
    ADD CONSTRAINT django_comment_flags_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES django_comments(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_docker_processe_user_id_4bc3352b630db9d6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_dockerprocess
    ADD CONSTRAINT django_docker_processe_user_id_4bc3352b630db9d6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_irods_rodsenvi_owner_id_390560bddc5c0167_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_irods_rodsenvironment
    ADD CONSTRAINT django_irods_rodsenvi_owner_id_390560bddc5c0167_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_redirect_site_id_121a4403f653e524_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_redirect
    ADD CONSTRAINT django_redirect_site_id_121a4403f653e524_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_periodictask_crontab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_crontab_id_fkey FOREIGN KEY (crontab_id) REFERENCES djcelery_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_periodictask_interval_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_interval_id_fkey FOREIGN KEY (interval_id) REFERENCES djcelery_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_taskstate_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES djcelery_workerstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: e19cf6cec3169736eacf85ac0d3461fb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprovenance
    ADD CONSTRAINT e19cf6cec3169736eacf85ac0d3461fb FOREIGN KEY (resource_id) REFERENCES hs_core_genericresource(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: e5fed3f499b0200346f7d75572f21043; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overrideenvvar
    ADD CONSTRAINT e5fed3f499b0200346f7d75572f21043 FOREIGN KEY (container_overrides_id) REFERENCES django_docker_processes_containeroverrides(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: e7d5a402acda6620ac469b1ae31931b0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14
    ADD CONSTRAINT e7d5a402acda6620ac469b1ae31931b0 FOREIGN KEY (headdependentfluxboundarypackagechoices_id) REFERENCES hs_modflow_modelinstance_headdependentfluxboundarypackagechf906(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ed07907c5bbff48aa33f866d15220f0a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overrideport
    ADD CONSTRAINT ed07907c5bbff48aa33f866d15220f0a FOREIGN KEY (container_overrides_id) REFERENCES django_docker_processes_containeroverrides(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ed9fd5eb4f62c9b049823c4a9799fadb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_grant
    ADD CONSTRAINT ed9fd5eb4f62c9b049823c4a9799fadb FOREIGN KEY (application_id) REFERENCES oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eec8b8cce3e3215770baaf54196deb87; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_head_dependent_f1e14
    ADD CONSTRAINT eec8b8cce3e3215770baaf54196deb87 FOREIGN KEY (boundarycondition_id) REFERENCES hs_modflow_modelinstance_boundarycondition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: efd23ef67e432910030e9dce3658b101; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition_specified_head_b132e
    ADD CONSTRAINT efd23ef67e432910030e9dce3658b101 FOREIGN KEY (boundarycondition_id) REFERENCES hs_modflow_modelinstance_boundarycondition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fa281325d2f3328932b8c7c7f4606aee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geo_raster_resource_rastermetadata
    ADD CONSTRAINT fa281325d2f3328932b8c7c7f4606aee FOREIGN KEY (coremetadata_ptr_id) REFERENCES hs_core_coremetadata(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fdb8bb299277d4067f76710058feb68c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource_resource_od9f5
    ADD CONSTRAINT fdb8bb299277d4067f76710058feb68c FOREIGN KEY (collectiondeletedresource_id) REFERENCES hs_collection_resource_collectiondeletedresource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fffc21cda66b01603a10a01bdad6da7a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_docker_processes_overridevolume
    ADD CONSTRAINT fffc21cda66b01603a10a01bdad6da7a FOREIGN KEY (container_overrides_id) REFERENCES django_docker_processes_containeroverrides(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forms_field_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forms_field
    ADD CONSTRAINT forms_field_form_id_fkey FOREIGN KEY (form_id) REFERENCES forms_form(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forms_fieldentry_entry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forms_fieldentry
    ADD CONSTRAINT forms_fieldentry_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES forms_formentry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forms_formentry_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forms_formentry
    ADD CONSTRAINT forms_formentry_form_id_fkey FOREIGN KEY (form_id) REFERENCES forms_form(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: from_blogpost_id_refs_id_6404941b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogpost_related_posts
    ADD CONSTRAINT from_blogpost_id_refs_id_6404941b FOREIGN KEY (from_blogpost_id) REFERENCES blog_blogpost(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga__style_id_5936d77d79781cb3_fk_ga_resources_style_page_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_renderedlayer_styles
    ADD CONSTRAINT ga__style_id_5936d77d79781cb3_fk_ga_resources_style_page_ptr_id FOREIGN KEY (style_id) REFERENCES ga_resources_style(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_ows_ogrl_dataset_id_6e73ed83065ab28e_fk_ga_ows_ogrdataset_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_ows_ogrlayer
    ADD CONSTRAINT ga_ows_ogrl_dataset_id_6e73ed83065ab28e_fk_ga_ows_ogrdataset_id FOREIGN KEY (dataset_id) REFERENCES ga_ows_ogrdataset(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_cata_page_ptr_id_3a34c22b98e9c9d9_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_catalogpage
    ADD CONSTRAINT ga_resources_cata_page_ptr_id_3a34c22b98e9c9d9_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_catalogp_owner_id_1f14a105abf0305d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_catalogpage
    ADD CONSTRAINT ga_resources_catalogp_owner_id_1f14a105abf0305d_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_data_page_ptr_id_4f03f820364cc814_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_dataresource
    ADD CONSTRAINT ga_resources_data_page_ptr_id_4f03f820364cc814_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_datareso_owner_id_73f783a9e0765a16_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_dataresource
    ADD CONSTRAINT ga_resources_datareso_owner_id_73f783a9e0765a16_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_rela_page_ptr_id_5b6dd4b2b1bc4396_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_relatedresource
    ADD CONSTRAINT ga_resources_rela_page_ptr_id_5b6dd4b2b1bc4396_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_rend_page_ptr_id_79d7ddc1ebb5949d_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_renderedlayer
    ADD CONSTRAINT ga_resources_rend_page_ptr_id_79d7ddc1ebb5949d_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_renderedl_owner_id_b1ea62c22422ddf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_renderedlayer
    ADD CONSTRAINT ga_resources_renderedl_owner_id_b1ea62c22422ddf_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_reso_page_ptr_id_4a4164112cf8cc60_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_resourcegroup
    ADD CONSTRAINT ga_resources_reso_page_ptr_id_4a4164112cf8cc60_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_styl_page_ptr_id_1c486a7554041e16_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_style
    ADD CONSTRAINT ga_resources_styl_page_ptr_id_1c486a7554041e16_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ga_resources_style_owner_id_25e12844a4baec14_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ga_resources_style
    ADD CONSTRAINT ga_resources_style_owner_id_25e12844a4baec14_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: galleries_gallery_page_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY galleries_gallery
    ADD CONSTRAINT galleries_gallery_page_ptr_id_fkey FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: galleries_galleryimage_gallery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY galleries_galleryimage
    ADD CONSTRAINT galleries_galleryimage_gallery_id_fkey FOREIGN KEY (gallery_id) REFERENCES galleries_gallery(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: generic_assignedkeyword_keyword_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_assignedkeyword
    ADD CONSTRAINT generic_assignedkeyword_keyword_id_fkey FOREIGN KEY (keyword_id) REFERENCES generic_keyword(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: generic_threadedcomment_replied_to_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY generic_threadedcomment
    ADD CONSTRAINT generic_threadedcomment_replied_to_id_fkey FOREIGN KEY (replied_to_id) REFERENCES generic_threadedcomment(comment_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_a_content_type_id_1c8d1eac05f91712_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "hs_app_netCDF_originalcoverage"
    ADD CONSTRAINT hs_a_content_type_id_1c8d1eac05f91712_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_a_content_type_id_1f7b7e7568a47f65_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_utcoffset
    ADD CONSTRAINT hs_a_content_type_id_1f7b7e7568a47f65_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_a_content_type_id_20e32c2b2e7f28d2_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_method
    ADD CONSTRAINT hs_a_content_type_id_20e32c2b2e7f28d2_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_a_content_type_id_451721750e25a0b3_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_processinglevel
    ADD CONSTRAINT hs_a_content_type_id_451721750e25a0b3_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_a_content_type_id_5883e361b4531c3c_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_timeseriesresult
    ADD CONSTRAINT hs_a_content_type_id_5883e361b4531c3c_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_a_content_type_id_6bea7582e11ffdc9_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_variable
    ADD CONSTRAINT hs_a_content_type_id_6bea7582e11ffdc9_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_a_content_type_id_6c3a0d31ca8f2ee2_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_app_timeseries_site
    ADD CONSTRAINT hs_a_content_type_id_6c3a0d31ca8f2ee2_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_co_group_to_join_id_5cf445aa01ee1f48_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupmembershiprequest
    ADD CONSTRAINT hs_access_co_group_to_join_id_5cf445aa01ee1f48_fk_auth_group_id FOREIGN KEY (group_to_join_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_con_invitation_to_id_5cdd6acd6d11df75_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupmembershiprequest
    ADD CONSTRAINT hs_access_con_invitation_to_id_5cdd6acd6d11df75_fk_auth_user_id FOREIGN KEY (invitation_to_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_cont_request_from_id_3447b6ef4a91ce7d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupmembershiprequest
    ADD CONSTRAINT hs_access_cont_request_from_id_3447b6ef4a91ce7d_fk_auth_user_id FOREIGN KEY (request_from_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_g_grantor_id_1e68e0395847f2b3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprivilege
    ADD CONSTRAINT hs_access_control_g_grantor_id_1e68e0395847f2b3_fk_auth_user_id FOREIGN KEY (grantor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_g_grantor_id_3e5d815f5ca90e8a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprovenance
    ADD CONSTRAINT hs_access_control_g_grantor_id_3e5d815f5ca90e8a_fk_auth_user_id FOREIGN KEY (grantor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_gr_group_id_1bd0754af26faaf7_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupaccess
    ADD CONSTRAINT hs_access_control_gr_group_id_1bd0754af26faaf7_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_gr_group_id_3d9dbfade29a5ab5_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprivilege
    ADD CONSTRAINT hs_access_control_gr_group_id_3d9dbfade29a5ab5_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_gro_group_id_71a5c4d23eb742c_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_groupresourceprovenance
    ADD CONSTRAINT hs_access_control_gro_group_id_71a5c4d23eb742c_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_u_grantor_id_2b562b352020c1dd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprovenance
    ADD CONSTRAINT hs_access_control_u_grantor_id_2b562b352020c1dd_fk_auth_user_id FOREIGN KEY (grantor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_u_grantor_id_4701883fe2eecd92_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprivilege
    ADD CONSTRAINT hs_access_control_u_grantor_id_4701883fe2eecd92_fk_auth_user_id FOREIGN KEY (grantor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_u_grantor_id_4f35ffdf779659db_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprovenance
    ADD CONSTRAINT hs_access_control_u_grantor_id_4f35ffdf779659db_fk_auth_user_id FOREIGN KEY (grantor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_u_grantor_id_742a65bf460606de_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprivilege
    ADD CONSTRAINT hs_access_control_u_grantor_id_742a65bf460606de_fk_auth_user_id FOREIGN KEY (grantor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_us_group_id_7a23b411f5887d80_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprivilege
    ADD CONSTRAINT hs_access_control_us_group_id_7a23b411f5887d80_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_user_group_id_e4144ab68f857d_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprovenance
    ADD CONSTRAINT hs_access_control_user_group_id_e4144ab68f857d_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_user_user_id_243e1d62fa0c4421_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_useraccess
    ADD CONSTRAINT hs_access_control_user_user_id_243e1d62fa0c4421_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_user_user_id_2f4a1c58f99f6ed2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprovenance
    ADD CONSTRAINT hs_access_control_user_user_id_2f4a1c58f99f6ed2_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_user_user_id_4569a2ddb14e3c0a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprovenance
    ADD CONSTRAINT hs_access_control_user_user_id_4569a2ddb14e3c0a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_user_user_id_5009f3b148778457_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_userresourceprivilege
    ADD CONSTRAINT hs_access_control_user_user_id_5009f3b148778457_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_access_control_userg_user_id_d8086f326b13647_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_access_control_usergroupprivilege
    ADD CONSTRAINT hs_access_control_userg_user_id_d8086f326b13647_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_ap_content_type_id_321744f4b1f2b5d_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "hs_app_netCDF_variable"
    ADD CONSTRAINT hs_ap_content_type_id_321744f4b1f2b5d_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_15a9d2f60f693357_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_description
    ADD CONSTRAINT hs_c_content_type_id_15a9d2f60f693357_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_1958c85a8a2ac493_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_title
    ADD CONSTRAINT hs_c_content_type_id_1958c85a8a2ac493_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_26443469fd65abd2_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_contributor
    ADD CONSTRAINT hs_c_content_type_id_26443469fd65abd2_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_296a972a9ca195a8_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_coverage
    ADD CONSTRAINT hs_c_content_type_id_296a972a9ca195a8_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_2c6549c3389e1640_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_language
    ADD CONSTRAINT hs_c_content_type_id_2c6549c3389e1640_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_2e3e6f5f1647294b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_identifier
    ADD CONSTRAINT hs_c_content_type_id_2e3e6f5f1647294b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_2ebca0f0d370a961_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_publisher
    ADD CONSTRAINT hs_c_content_type_id_2ebca0f0d370a961_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_387c72dac133e70a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_type
    ADD CONSTRAINT hs_c_content_type_id_387c72dac133e70a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_393df80b6039f971_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_fundingagency
    ADD CONSTRAINT hs_c_content_type_id_393df80b6039f971_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_425582f505cae13e_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource
    ADD CONSTRAINT hs_c_content_type_id_425582f505cae13e_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_52f2f9c2122dcd99_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_format
    ADD CONSTRAINT hs_c_content_type_id_52f2f9c2122dcd99_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_5a61162ae031c50f_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_subject
    ADD CONSTRAINT hs_c_content_type_id_5a61162ae031c50f_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_6b579f99df9842ef_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_rights
    ADD CONSTRAINT hs_c_content_type_id_6b579f99df9842ef_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_70ad608f2be0cb50_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_resourcefile
    ADD CONSTRAINT hs_c_content_type_id_70ad608f2be0cb50_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_764ef711d5895dcb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_bags
    ADD CONSTRAINT hs_c_content_type_id_764ef711d5895dcb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_77574a4e7e85b859_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_creator
    ADD CONSTRAINT hs_c_content_type_id_77574a4e7e85b859_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_c_content_type_id_775b5304ceb81cfe_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_relation
    ADD CONSTRAINT hs_c_content_type_id_775b5304ceb81cfe_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_co_content_type_id_47f60695a5eda03_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_source
    ADD CONSTRAINT hs_co_content_type_id_47f60695a5eda03_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_co_content_type_id_9c7365e54949ce2_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_date
    ADD CONSTRAINT hs_co_content_type_id_9c7365e54949ce2_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_collection_re_deleted_by_id_14f506bd7f16121a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource
    ADD CONSTRAINT hs_collection_re_deleted_by_id_14f506bd7f16121a_fk_auth_user_id FOREIGN KEY (deleted_by_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_collection_resource__user_id_e3a8b375cc0cf7a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_collection_resource_collectiondeletedresource_resource_od9f5
    ADD CONSTRAINT hs_collection_resource__user_id_e3a8b375cc0cf7a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_cor_content_type_id_8887e3729580c7_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_externalprofilelink
    ADD CONSTRAINT hs_cor_content_type_id_8887e3729580c7_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_core_bas_last_changed_by_id_55b9ad9c3719f949_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource
    ADD CONSTRAINT hs_core_bas_last_changed_by_id_55b9ad9c3719f949_fk_auth_user_id FOREIGN KEY (last_changed_by_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_core_baseresourc_creator_id_306123f66b8ed448_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource
    ADD CONSTRAINT hs_core_baseresourc_creator_id_306123f66b8ed448_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_core_baseresource_user_id_38abc1be206c7b0a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource
    ADD CONSTRAINT hs_core_baseresource_user_id_38abc1be206c7b0a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_core_genericre_page_ptr_id_61d7ef1ac505649e_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_genericresource
    ADD CONSTRAINT hs_core_genericre_page_ptr_id_61d7ef1ac505649e_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_core_groupownersh_group_id_73ab445f0d3ce28a_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_groupownership
    ADD CONSTRAINT hs_core_groupownersh_group_id_73ab445f0d3ce28a_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_core_groupownershi_owner_id_1c73b09f1651e342_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_core_groupownership
    ADD CONSTRAINT hs_core_groupownershi_owner_id_1c73b09f1651e342_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_g_content_type_id_2f01db94cd029b0f_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geo_raster_resource_cellinformation
    ADD CONSTRAINT hs_g_content_type_id_2f01db94cd029b0f_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_g_content_type_id_322c34901bfae5cb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_fieldinformation
    ADD CONSTRAINT hs_g_content_type_id_322c34901bfae5cb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_g_content_type_id_3a67e16436568536_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalfileinfo
    ADD CONSTRAINT hs_g_content_type_id_3a67e16436568536_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_g_content_type_id_3c68392c27f3db93_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geo_raster_resource_originalcoverage
    ADD CONSTRAINT hs_g_content_type_id_3c68392c27f3db93_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_g_content_type_id_4dbd862ddd6248f6_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_geometryinformation
    ADD CONSTRAINT hs_g_content_type_id_4dbd862ddd6248f6_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_g_content_type_id_63f5acc301191318_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geo_raster_resource_bandinformation
    ADD CONSTRAINT hs_g_content_type_id_63f5acc301191318_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_g_content_type_id_66d126c2b3cf7352_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_geographic_feature_resource_originalcoverage
    ADD CONSTRAINT hs_g_content_type_id_66d126c2b3cf7352_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_labels_userlabels_user_id_67d4ad8ba6073785_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userlabels
    ADD CONSTRAINT hs_labels_userlabels_user_id_67d4ad8ba6073785_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_labels_userresource_user_id_17c2ac15d94c26f8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userresourceflags
    ADD CONSTRAINT hs_labels_userresource_user_id_17c2ac15d94c26f8_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_labels_userresourcel_user_id_ca1355f4a3868e3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userresourcelabels
    ADD CONSTRAINT hs_labels_userresourcel_user_id_ca1355f4a3868e3_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_labels_userstoredla_user_id_534d602d9683725a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_labels_userstoredlabels
    ADD CONSTRAINT hs_labels_userstoredla_user_id_534d602d9683725a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_28b5acd8b013f0d8_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_modelcalibration
    ADD CONSTRAINT hs_m_content_type_id_28b5acd8b013f0d8_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_3bd8e2abaa5d3b5f_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_generalelements
    ADD CONSTRAINT hs_m_content_type_id_3bd8e2abaa5d3b5f_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_3e48e7e701d2c51c_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_griddimensions
    ADD CONSTRAINT hs_m_content_type_id_3e48e7e701d2c51c_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_43012b554b266cd2_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_stressperiod
    ADD CONSTRAINT hs_m_content_type_id_43012b554b266cd2_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_495bac403aded459_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modelinstance_modeloutput
    ADD CONSTRAINT hs_m_content_type_id_495bac403aded459_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_4a5aea7c91a836fc_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_model_program_mpmetadata
    ADD CONSTRAINT hs_m_content_type_id_4a5aea7c91a836fc_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_5cd8cd13b6689dc1_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_boundarycondition
    ADD CONSTRAINT hs_m_content_type_id_5cd8cd13b6689dc1_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_5cdc512aa3264a0a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_groundwaterflow
    ADD CONSTRAINT hs_m_content_type_id_5cdc512aa3264a0a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_5e722b4c4e52db18_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modelinstance_executedby
    ADD CONSTRAINT hs_m_content_type_id_5e722b4c4e52db18_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_m_content_type_id_7a565134ac21db92_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_modelinput
    ADD CONSTRAINT hs_m_content_type_id_7a565134ac21db92_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_mo_content_type_id_429ccc5d624da4a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_modflow_modelinstance_studyarea
    ADD CONSTRAINT hs_mo_content_type_id_429ccc5d624da4a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_s_content_type_id_2525bc5c55d4bdb6_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelinput
    ADD CONSTRAINT hs_s_content_type_id_2525bc5c55d4bdb6_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_s_content_type_id_36a685eb8e70f0ba_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_simulationtype
    ADD CONSTRAINT hs_s_content_type_id_36a685eb8e70f0ba_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_s_content_type_id_60bff7e50d58202e_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_script_resource_scriptspecificmetadata
    ADD CONSTRAINT hs_s_content_type_id_60bff7e50d58202e_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_s_content_type_id_62f727efbef81583_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelobjective
    ADD CONSTRAINT hs_s_content_type_id_62f727efbef81583_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_s_content_type_id_67e73462ac6a1f3b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelparameter
    ADD CONSTRAINT hs_s_content_type_id_67e73462ac6a1f3b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_s_content_type_id_7a0e6caa7ea88974_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_swat_modelinstance_modelmethod
    ADD CONSTRAINT hs_s_content_type_id_7a0e6caa7ea88974_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_t_content_type_id_4054d4b11537b3be_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_toolicon
    ADD CONSTRAINT hs_t_content_type_id_4054d4b11537b3be_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_t_content_type_id_51e17884abf9eddc_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_toolversion
    ADD CONSTRAINT hs_t_content_type_id_51e17884abf9eddc_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_t_content_type_id_62b8f4790407354c_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_requesturlbase
    ADD CONSTRAINT hs_t_content_type_id_62b8f4790407354c_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_t_content_type_id_767d162d9152deeb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedrestypes
    ADD CONSTRAINT hs_t_content_type_id_767d162d9152deeb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_t_content_type_id_7b1338cffe685cdf_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_supportedsharingstatus
    ADD CONSTRAINT hs_t_content_type_id_7b1338cffe685cdf_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_t_content_type_id_7ded22f42d3aa879_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tools_resource_apphomepageurl
    ADD CONSTRAINT hs_t_content_type_id_7ded22f42d3aa879_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_tracki_visitor_id_23a186d92be70070_fk_hs_tracking_visitor_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tracking_session
    ADD CONSTRAINT hs_tracki_visitor_id_23a186d92be70070_fk_hs_tracking_visitor_id FOREIGN KEY (visitor_id) REFERENCES hs_tracking_visitor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_trackin_session_id_5e9600c451e08ab_fk_hs_tracking_session_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tracking_variable
    ADD CONSTRAINT hs_trackin_session_id_5e9600c451e08ab_fk_hs_tracking_session_id FOREIGN KEY (session_id) REFERENCES hs_tracking_session(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hs_tracking_visitor_user_id_e219697e1ed13ee_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hs_tracking_visitor
    ADD CONSTRAINT hs_tracking_visitor_user_id_e219697e1ed13ee_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_access_user_id_5e2f004fdebea22d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_access_user_id_5e2f004fdebea22d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_applic_user_id_7fa13387c260b798_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_applic_user_id_7fa13387c260b798_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_grant_user_id_3111344894d452da_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_grant_user_id_3111344894d452da_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_refres_user_id_3f695b639cfbc9a3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refres_user_id_3f695b639cfbc9a3_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: page_ptr_id_refs_id_fe19b67b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forms_form
    ADD CONSTRAINT page_ptr_id_refs_id_fe19b67b FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pages_link_page_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pages_link
    ADD CONSTRAINT pages_link_page_ptr_id_fkey FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pages_page_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pages_page
    ADD CONSTRAINT pages_page_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pages_richtextpage_page_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pages_richtextpage
    ADD CONSTRAINT pages_richtextpage_page_ptr_id_fkey FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ref__content_type_id_1596bb7967529f8a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_site
    ADD CONSTRAINT ref__content_type_id_1596bb7967529f8a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ref__content_type_id_402960584e79c89b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_variable
    ADD CONSTRAINT ref__content_type_id_402960584e79c89b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ref__content_type_id_5012cd72a5c50d2a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_datasource
    ADD CONSTRAINT ref__content_type_id_5012cd72a5c50d2a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ref__content_type_id_630cce4d99ae4b3a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_qualitycontrollevel
    ADD CONSTRAINT ref__content_type_id_630cce4d99ae4b3a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ref_t_content_type_id_df404ee3c93c31e_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_method
    ADD CONSTRAINT ref_t_content_type_id_df404ee3c93c31e_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ref_ts__content_type_id_9883d7b40a491_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ref_ts_referenceurl
    ADD CONSTRAINT ref_ts__content_type_id_9883d7b40a491_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: robots_rule_allowed_rule_id_b79a8840929e6aa_fk_robots_rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_allowed
    ADD CONSTRAINT robots_rule_allowed_rule_id_b79a8840929e6aa_fk_robots_rule_id FOREIGN KEY (rule_id) REFERENCES robots_rule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: robots_rule_allowed_url_id_24e75e80d27a928_fk_robots_url_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_allowed
    ADD CONSTRAINT robots_rule_allowed_url_id_24e75e80d27a928_fk_robots_url_id FOREIGN KEY (url_id) REFERENCES robots_url(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: robots_rule_disallow_rule_id_50048ff97fa79eef_fk_robots_rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_disallowed
    ADD CONSTRAINT robots_rule_disallow_rule_id_50048ff97fa79eef_fk_robots_rule_id FOREIGN KEY (rule_id) REFERENCES robots_rule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: robots_rule_disallowed_url_id_2f1c369bbebea01d_fk_robots_url_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_disallowed
    ADD CONSTRAINT robots_rule_disallowed_url_id_2f1c369bbebea01d_fk_robots_url_id FOREIGN KEY (url_id) REFERENCES robots_url(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: robots_rule_sites_rule_id_55fc54e5f62b7264_fk_robots_rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_sites
    ADD CONSTRAINT robots_rule_sites_rule_id_55fc54e5f62b7264_fk_robots_rule_id FOREIGN KEY (rule_id) REFERENCES robots_rule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: robots_rule_sites_site_id_3274a4d8ebfc398f_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY robots_rule_sites
    ADD CONSTRAINT robots_rule_sites_site_id_3274a4d8ebfc398f_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: security_passwordexpiry_user_id_64321ff9e3cc9b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY security_passwordexpiry
    ADD CONSTRAINT security_passwordexpiry_user_id_64321ff9e3cc9b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sitepermission_id_refs_id_7dccdcbd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_sitepermission_sites
    ADD CONSTRAINT sitepermission_id_refs_id_7dccdcbd FOREIGN KEY (sitepermission_id) REFERENCES core_sitepermission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: theme_homepage_id_7a358283d1fd2d7_fk_theme_homepage_page_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_iconbox
    ADD CONSTRAINT theme_homepage_id_7a358283d1fd2d7_fk_theme_homepage_page_ptr_id FOREIGN KEY (homepage_id) REFERENCES theme_homepage(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: theme_homepage_page_ptr_id_10fe08bd3bddde20_fk_pages_page_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_homepage
    ADD CONSTRAINT theme_homepage_page_ptr_id_10fe08bd3bddde20_fk_pages_page_id FOREIGN KEY (page_ptr_id) REFERENCES pages_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: theme_siteconfigurat_site_id_71aa83f18a4be0eb_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_siteconfiguration
    ADD CONSTRAINT theme_siteconfigurat_site_id_71aa83f18a4be0eb_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: theme_userprofile_user_id_4e02d2b427b5e510_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_userprofile
    ADD CONSTRAINT theme_userprofile_user_id_4e02d2b427b5e510_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: theme_userquota_user_id_4ef704d14e5a5ddd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY theme_userquota
    ADD CONSTRAINT theme_userquota_user_id_4ef704d14e5a5ddd_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: to_blogpost_id_refs_id_6404941b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blog_blogpost_related_posts
    ADD CONSTRAINT to_blogpost_id_refs_id_6404941b FOREIGN KEY (to_blogpost_id) REFERENCES blog_blogpost(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys  FROM stdin;
\.


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

