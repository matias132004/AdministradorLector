--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.25
-- Dumped by pg_dump version 9.3.25
-- Started on 2024-07-01 13:51:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2166 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 218 (class 1255 OID 28894)
-- Name: trigger_cambios_productos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_cambios_productos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        -- Actualiza el campo 'refrescar' a true en la tabla 'configuraciones' después de una inserción
        UPDATE configuraciones
        SET refrescar = TRUE;
    ELSIF TG_OP = 'UPDATE' THEN
        -- Actualiza el campo 'refrescar' a true en la tabla 'configuraciones' después de una actualización
        UPDATE configuraciones
        SET refrescar = TRUE;
    ELSIF TG_OP = 'DELETE' THEN
        -- Actualiza el campo 'refrescar' a true en la tabla 'configuraciones' después de una eliminación
        UPDATE configuraciones
        SET refrescar = TRUE;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_cambios_productos() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 194 (class 1259 OID 28780)
-- Name: configuraciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.configuraciones (
    id_configuracion integer NOT NULL,
    promocion_act boolean,
    venta_volumen boolean,
    dictado_precios boolean,
    id_datos_local integer,
    imagen_act boolean,
    scaner boolean,
    precio_old_act boolean,
    tiempoespera integer
);


ALTER TABLE public.configuraciones OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 28778)
-- Name: configuraciones_id_configuracion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.configuraciones_id_configuracion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configuraciones_id_configuracion_seq OWNER TO postgres;

--
-- TOC entry 2167 (class 0 OID 0)
-- Dependencies: 193
-- Name: configuraciones_id_configuracion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.configuraciones_id_configuracion_seq OWNED BY public.configuraciones.id_configuracion;


--
-- TOC entry 200 (class 1259 OID 42333)
-- Name: configuracionespromocion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.configuracionespromocion (
    id_configuracionespromocion integer NOT NULL,
    colorprincipal character varying(50),
    colorsecundario character varying(50),
    colorfuenteprincipal character varying(50),
    colorfuentesecundario character varying(50),
    id_fuente integer,
    id_datos_local integer,
    nombre character varying(50),
    id_destacado integer,
    tiempoespera integer
);


ALTER TABLE public.configuracionespromocion OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 42331)
-- Name: configuracionespromocion_id_configuracionespromocion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.configuracionespromocion_id_configuracionespromocion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configuracionespromocion_id_configuracionespromocion_seq OWNER TO postgres;

--
-- TOC entry 2168 (class 0 OID 0)
-- Dependencies: 199
-- Name: configuracionespromocion_id_configuracionespromocion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.configuracionespromocion_id_configuracionespromocion_seq OWNED BY public.configuracionespromocion.id_configuracionespromocion;


--
-- TOC entry 190 (class 1259 OID 28742)
-- Name: datos_local; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.datos_local (
    id_datos_local integer NOT NULL,
    nombre_local character varying(255),
    descripcion character varying(100),
    logo_act boolean,
    version character varying(100),
    pago boolean
);


ALTER TABLE public.datos_local OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 28740)
-- Name: datos_local_id_datos_local_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datos_local_id_datos_local_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datos_local_id_datos_local_seq OWNER TO postgres;

--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 189
-- Name: datos_local_id_datos_local_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datos_local_id_datos_local_seq OWNED BY public.datos_local.id_datos_local;


--
-- TOC entry 202 (class 1259 OID 42351)
-- Name: destacado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.destacado (
    id_destacado integer NOT NULL,
    nombre_destacado character varying(50)
);


ALTER TABLE public.destacado OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 42349)
-- Name: destacado_id_destacado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.destacado_id_destacado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.destacado_id_destacado_seq OWNER TO postgres;

--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 201
-- Name: destacado_id_destacado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.destacado_id_destacado_seq OWNED BY public.destacado.id_destacado;


--
-- TOC entry 204 (class 1259 OID 42399)
-- Name: escaneados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.escaneados (
    id_escaneados integer,
    id_producto integer,
    nombre_producto character varying(250),
    fecha_escaneado date,
    cbarra character varying(250)
);


ALTER TABLE public.escaneados OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 20198)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre_estado character varying(20) NOT NULL
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 20196)
-- Name: estado_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_id_estado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estado_id_estado_seq OWNER TO postgres;

--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 175
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_id_estado_seq OWNED BY public.estado.id_estado;


--
-- TOC entry 180 (class 1259 OID 20214)
-- Name: familia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.familia (
    id_familia integer NOT NULL,
    nombre_familia character varying(50) NOT NULL,
    id_estado integer
);


ALTER TABLE public.familia OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 20212)
-- Name: familia_id_familia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.familia_id_familia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.familia_id_familia_seq OWNER TO postgres;

--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 179
-- Name: familia_id_familia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.familia_id_familia_seq OWNED BY public.familia.id_familia;


--
-- TOC entry 198 (class 1259 OID 42325)
-- Name: fuente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.fuente (
    id_fuente integer NOT NULL,
    nombre_fuente character varying(50)
);


ALTER TABLE public.fuente OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 42323)
-- Name: fuente_id_fuente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fuente_id_fuente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fuente_id_fuente_seq OWNER TO postgres;

--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 197
-- Name: fuente_id_fuente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fuente_id_fuente_seq OWNED BY public.fuente.id_fuente;


--
-- TOC entry 172 (class 1259 OID 20182)
-- Name: genero; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.genero (
    id_genero integer NOT NULL,
    nombre_genero character varying(50) NOT NULL
);


ALTER TABLE public.genero OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 20180)
-- Name: genero_id_genero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genero_id_genero_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genero_id_genero_seq OWNER TO postgres;

--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 171
-- Name: genero_id_genero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genero_id_genero_seq OWNED BY public.genero.id_genero;


--
-- TOC entry 192 (class 1259 OID 28750)
-- Name: images; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.images (
    id integer NOT NULL,
    nombre character varying(255),
    image_data bytea,
    id_datos_local integer,
    tipo_img_id integer
);


ALTER TABLE public.images OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 28748)
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO postgres;

--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 191
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- TOC entry 188 (class 1259 OID 28715)
-- Name: images_promocion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.images_promocion (
    id integer NOT NULL,
    nombre character varying(255),
    image_data bytea,
    id_promocion integer
);


ALTER TABLE public.images_promocion OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 28713)
-- Name: images_promocion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_promocion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_promocion_id_seq OWNER TO postgres;

--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 187
-- Name: images_promocion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_promocion_id_seq OWNED BY public.images_promocion.id;


--
-- TOC entry 203 (class 1259 OID 42379)
-- Name: precio_volumen; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.precio_volumen (
    id_precio_volumen integer NOT NULL,
    id_producto integer NOT NULL,
    desde integer,
    hasta integer,
    precio integer,
    id_estado integer
);


ALTER TABLE public.precio_volumen OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 20253)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.producto (
    id_producto integer NOT NULL,
    nombre_producto character varying(250) NOT NULL,
    id_familia integer,
    cbarra character varying(100) NOT NULL,
    id_umedida integer,
    total numeric,
    id_estado integer,
    precio_old integer,
    descripcion character varying(250),
    descripcionvisible boolean
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 20251)
-- Name: producto_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_id_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.producto_id_producto_seq OWNER TO postgres;

--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 181
-- Name: producto_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_id_producto_seq OWNED BY public.producto.id_producto;


--
-- TOC entry 186 (class 1259 OID 28666)
-- Name: promocion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.promocion (
    id_promocion integer NOT NULL,
    id_producto integer,
    id_estado integer,
    lunes boolean,
    martes boolean,
    miercoles boolean,
    jueves boolean,
    sabado boolean,
    domingo boolean,
    fecha_inicio date DEFAULT ('now'::text)::date,
    fecha_fin date DEFAULT ('now'::text)::date,
    viernes boolean,
    descripcion character varying(250)
);


ALTER TABLE public.promocion OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 28664)
-- Name: promocion_id_promocion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promocion_id_promocion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promocion_id_promocion_seq OWNER TO postgres;

--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 185
-- Name: promocion_id_promocion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promocion_id_promocion_seq OWNED BY public.promocion.id_promocion;


--
-- TOC entry 205 (class 1259 OID 42472)
-- Name: promocion_por_imagen; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.promocion_por_imagen (
    id_promocion_imagen integer NOT NULL,
    nombre character varying(250),
    image_data bytea,
    id_datos_local integer,
    lunes boolean,
    martes boolean,
    miercoles boolean,
    jueves boolean,
    viernes boolean,
    sabado boolean,
    domingo boolean,
    fecha_inicio date,
    fecha_fin date,
    id_estado integer
);


ALTER TABLE public.promocion_por_imagen OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 28819)
-- Name: tipo_img; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.tipo_img (
    id integer NOT NULL,
    tipo_img character varying(50)
);


ALTER TABLE public.tipo_img OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 28817)
-- Name: tipo_img_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_img_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_img_id_seq OWNER TO postgres;

--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 195
-- Name: tipo_img_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_img_id_seq OWNED BY public.tipo_img.id;


--
-- TOC entry 174 (class 1259 OID 20190)
-- Name: tipo_usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.tipo_usuario (
    id_tipo_usuario integer NOT NULL,
    nombre_tipo_usuario character varying(50) NOT NULL
);


ALTER TABLE public.tipo_usuario OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 20188)
-- Name: tipo_usuario_id_tipo_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_usuario_id_tipo_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_usuario_id_tipo_usuario_seq OWNER TO postgres;

--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 173
-- Name: tipo_usuario_id_tipo_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_usuario_id_tipo_usuario_seq OWNED BY public.tipo_usuario.id_tipo_usuario;


--
-- TOC entry 178 (class 1259 OID 20206)
-- Name: umedida; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.umedida (
    id_umedida integer NOT NULL,
    nombre_umedida character varying(50) NOT NULL,
    nombre_corto character varying(20),
    id_estado integer
);


ALTER TABLE public.umedida OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 20204)
-- Name: umedida_id_umedida_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.umedida_id_umedida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.umedida_id_umedida_seq OWNER TO postgres;

--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 177
-- Name: umedida_id_umedida_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.umedida_id_umedida_seq OWNED BY public.umedida.id_umedida;


--
-- TOC entry 184 (class 1259 OID 20373)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    rut character varying(12) NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    apellido1 character varying(50) NOT NULL,
    apellido2 character varying(50) NOT NULL,
    correo character varying(50) NOT NULL,
    telefono integer NOT NULL,
    id_genero integer,
    contrasena character varying(255) NOT NULL,
    id_estado integer,
    id_tipo_usuario integer,
    id_datos_local integer,
    token character varying(255)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 20371)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 183
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 1945 (class 2604 OID 28783)
-- Name: id_configuracion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuraciones ALTER COLUMN id_configuracion SET DEFAULT nextval('public.configuraciones_id_configuracion_seq'::regclass);


--
-- TOC entry 1948 (class 2604 OID 42336)
-- Name: id_configuracionespromocion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracionespromocion ALTER COLUMN id_configuracionespromocion SET DEFAULT nextval('public.configuracionespromocion_id_configuracionespromocion_seq'::regclass);


--
-- TOC entry 1943 (class 2604 OID 28745)
-- Name: id_datos_local; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_local ALTER COLUMN id_datos_local SET DEFAULT nextval('public.datos_local_id_datos_local_seq'::regclass);


--
-- TOC entry 1949 (class 2604 OID 42354)
-- Name: id_destacado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destacado ALTER COLUMN id_destacado SET DEFAULT nextval('public.destacado_id_destacado_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 20201)
-- Name: id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado ALTER COLUMN id_estado SET DEFAULT nextval('public.estado_id_estado_seq'::regclass);


--
-- TOC entry 1936 (class 2604 OID 20217)
-- Name: id_familia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.familia ALTER COLUMN id_familia SET DEFAULT nextval('public.familia_id_familia_seq'::regclass);


--
-- TOC entry 1947 (class 2604 OID 42328)
-- Name: id_fuente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuente ALTER COLUMN id_fuente SET DEFAULT nextval('public.fuente_id_fuente_seq'::regclass);


--
-- TOC entry 1932 (class 2604 OID 20185)
-- Name: id_genero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero ALTER COLUMN id_genero SET DEFAULT nextval('public.genero_id_genero_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 28753)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- TOC entry 1942 (class 2604 OID 28718)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images_promocion ALTER COLUMN id SET DEFAULT nextval('public.images_promocion_id_seq'::regclass);


--
-- TOC entry 1937 (class 2604 OID 20256)
-- Name: id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN id_producto SET DEFAULT nextval('public.producto_id_producto_seq'::regclass);


--
-- TOC entry 1939 (class 2604 OID 28669)
-- Name: id_promocion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocion ALTER COLUMN id_promocion SET DEFAULT nextval('public.promocion_id_promocion_seq'::regclass);


--
-- TOC entry 1946 (class 2604 OID 28822)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_img ALTER COLUMN id SET DEFAULT nextval('public.tipo_img_id_seq'::regclass);


--
-- TOC entry 1933 (class 2604 OID 20193)
-- Name: id_tipo_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_usuario ALTER COLUMN id_tipo_usuario SET DEFAULT nextval('public.tipo_usuario_id_tipo_usuario_seq'::regclass);


--
-- TOC entry 1935 (class 2604 OID 20209)
-- Name: id_umedida; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.umedida ALTER COLUMN id_umedida SET DEFAULT nextval('public.umedida_id_umedida_seq'::regclass);


--
-- TOC entry 1938 (class 2604 OID 20376)
-- Name: id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 2146 (class 0 OID 28780)
-- Dependencies: 194
-- Data for Name: configuraciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuraciones (id_configuracion, promocion_act, venta_volumen, dictado_precios, id_datos_local, imagen_act, scaner, precio_old_act, tiempoespera) FROM stdin;
1	t	t	t	1	t	t	t	8000
\.


--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 193
-- Name: configuraciones_id_configuracion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configuraciones_id_configuracion_seq', 1, true);


--
-- TOC entry 2152 (class 0 OID 42333)
-- Dependencies: 200
-- Data for Name: configuracionespromocion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuracionespromocion (id_configuracionespromocion, colorprincipal, colorsecundario, colorfuenteprincipal, colorfuentesecundario, id_fuente, id_datos_local, nombre, id_destacado, tiempoespera) FROM stdin;
1	#ffffff	#ff0000	#000000	#ffffff	3	1	DEFECTO	2	30000
\.


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 199
-- Name: configuracionespromocion_id_configuracionespromocion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configuracionespromocion_id_configuracionespromocion_seq', 1, true);


--
-- TOC entry 2142 (class 0 OID 28742)
-- Dependencies: 190
-- Data for Name: datos_local; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datos_local (id_datos_local, nombre_local, descripcion, logo_act, version, pago) FROM stdin;
1	DEFECTO	DEFECTO	t	0.0.3	t
\.


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 189
-- Name: datos_local_id_datos_local_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datos_local_id_datos_local_seq', 1, true);


--
-- TOC entry 2154 (class 0 OID 42351)
-- Dependencies: 202
-- Data for Name: destacado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destacado (id_destacado, nombre_destacado) FROM stdin;
1	precio producto
2	nombre producto
\.


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 201
-- Name: destacado_id_destacado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.destacado_id_destacado_seq', 2, true);


--
-- TOC entry 2156 (class 0 OID 42399)
-- Dependencies: 204
-- Data for Name: escaneados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.escaneados (id_escaneados, id_producto, nombre_producto, fecha_escaneado, cbarra) FROM stdin;
1	1471	PERAS 	2024-06-04	105
2	1471	PERAS 	2024-06-04	105
3	1323	PAN AMASADO 	2024-06-04	7
4	1323	PAN AMASADO 	2024-06-04	7
5	3670	LIMPIA VIDRIOS SAPOLIO 650 ML	2024-06-04	7751851559300
6	3670	LIMPIA VIDRIOS SAPOLIO 650 ML	2024-06-04	7751851559300
7	3670	LIMPIA VIDRIOS SAPOLIO 650 ML	2024-06-04	7751851559300
8	1471	PERAS 	2024-06-05	105
9	1471	PERAS 	2024-06-05	105
10	1471	PERAS 	2024-06-05	105
11	1471	PERAS 	2024-06-05	105
12	1471	PERAS 	2024-06-05	105
13	1471	PERAS 	2024-06-05	105
14	1471	PERAS 	2024-06-05	105
15	1471	PERAS 	2024-06-05	105
16	1471	PERAS 	2024-06-05	105
\.


--
-- TOC entry 2128 (class 0 OID 20198)
-- Dependencies: 176
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado (id_estado, nombre_estado) FROM stdin;
1	Activo
2	Inactivo
\.


--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 175
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_id_estado_seq', 2, true);


--
-- TOC entry 2132 (class 0 OID 20214)
-- Dependencies: 180
-- Data for Name: familia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.familia (id_familia, nombre_familia, id_estado) FROM stdin;
2	UTILES DE ASEO	1
4	LACTEOS	1
5	BEBESTIBLES	1
7	CONGELADOS	1
57	PERFUMERIA DESODORANTES	1
9	ACEITES	1
10	PASTAS	1
8	PANADERIA	1
3	ROTISERIA	1
13	ARROZ	1
14	JUGO DE LIMON	1
15	VINAGRES	1
16	TOALLAS HIGIENICAS	1
17	CONSERVAS ACEITUNAS	1
18	ASEO ESCOBILLONES Y PALAS	1
19	MASA PIZZA	1
20	CONGELADOS-HAMBURGUESAS	1
21	QUESOS RALLADOS	1
22	ASEO-CLORO	1
23	TORTILLAS 	1
24	PAN	1
25	CHOCOLATES	1
26	GALLETAS	1
27	CEREALES	1
28	MERMELADA	1
29	MAYONESAS	1
30	QUEQUES	1
58	ENCENDEDORES	1
32	CONGELADOS HORTALIZAS	1
33	CECINAS-PATE	1
59	PANES INDUSTRIALES 	1
36	ARTICULO DE BELLEZA	1
37	ARTICULO DE DEPORTE	1
38	JUGOS CAJA 200ML	1
39	SALSAS LISTAS	1
40	SALSA DE TOMATE	1
41	ALIÑOS	1
42	COLADOS	1
43	SOPAS Y CREMAS	1
44	MILO	1
45	LECHE EN POLVO	1
6	CONFITES Y HELADOS 	1
46	CONFITES BARRAS DE CEREAL	1
47	CONFITES	1
48	BEBIDAS 1 LITRO	1
49	BEBIDAS 3 LITROS	1
50	BEBIDAS 2 LITROS	1
51	AGUAS 3 LT	1
52	AGUAS 1.5 LT	1
53	AGUAS 500 CC	1
69	BOLSAS DE BASURA	1
70	SNACK NATURALES	1
71	SALSAS POSTRES	1
72	SHAMPOO Y ACONDICIONADOR	1
54	ENERGETICAS	1
34	ARTICULOS DE FIESTA 	1
35	ARTICULOS ELECTRONICOS 	1
60	COMIDA ANIMAL	1
61	CHUCRUT	1
62	HELADOS	1
63	CAFES	1
64	YERBA MATTE	1
65	TOALLA NOVA	1
66	ASEO-CONFORT	1
67	JALEAS EN POLVO	1
68	PAÑALES	1
73	ASEO	1
74	VARIOS	1
55	CIGARROS	1
56	PILAS	1
1	ABARROTES	1
75	BEBIDAS	1
11	FRUTAS Y VERDURAS	1
77	ALIMENTO DE MASCOTAS	1
12	PASTELERIA	1
31	CARNICERIA 	1
76	JUGOS	1
78	OTROS PACK	1
\.


--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 179
-- Name: familia_id_familia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.familia_id_familia_seq', 15, true);


--
-- TOC entry 2150 (class 0 OID 42325)
-- Dependencies: 198
-- Data for Name: fuente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fuente (id_fuente, nombre_fuente) FROM stdin;
1	Arial
2	Helvetica
3	Times New Roman
4	Times
5	Courier New
6	Courier
7	Verdana
8	Georgia
9	Palatino
10	Garamond
11	Bookman
12	Comic Sans MS
13	Trebuchet MS
14	Arial Black
15	Impact
16	Lucida Sans Unicode
17	Tahoma
18	Geneva
19	Lucida Console
20	Monaco
\.


--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 197
-- Name: fuente_id_fuente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fuente_id_fuente_seq', 20, true);


--
-- TOC entry 2124 (class 0 OID 20182)
-- Dependencies: 172
-- Data for Name: genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genero (id_genero, nombre_genero) FROM stdin;
1	Masculino
2	Femenino
3	No binario
\.


--
-- TOC entry 2190 (class 0 OID 0)
-- Dependencies: 171
-- Name: genero_id_genero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genero_id_genero_seq', 3, true);


--
-- TOC entry 2144 (class 0 OID 28750)
-- Dependencies: 192
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, nombre, image_data, id_datos_local, tipo_img_id) FROM stdin;
\.


--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 191
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_id_seq', 63, true);


--
-- TOC entry 2140 (class 0 OID 28715)
-- Dependencies: 188
-- Data for Name: images_promocion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images_promocion (id, nombre, image_data, id_promocion) FROM stdin;
\.


--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 187
-- Name: images_promocion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_promocion_id_seq', 42, true);


--
-- TOC entry 2155 (class 0 OID 42379)
-- Dependencies: 203
-- Data for Name: precio_volumen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.precio_volumen (id_precio_volumen, id_producto, desde, hasta, precio, id_estado) FROM stdin;
2	1944	6	12	800	1
3	1944	13	100	750	1
4	902	6	12	200	1
6	902	13	24	150	1
\.


--
-- TOC entry 2134 (class 0 OID 20253)
-- Dependencies: 182
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (id_producto, nombre_producto, id_familia, cbarra, id_umedida, total, id_estado, precio_old, descripcion, descripcionvisible) FROM stdin;
3275	LUCCHETTINI LA SELVA 400G	1	7802500272573	1	800	1	0	\N	\N
988	COYAC YOGUETA CHOCOLATE UND	6	226	1	0	1	0	\N	\N
3366	COMODITY PREMIUM XG 8 UN. 	1	7806519000240	1	4990	1	0	\N	\N
2332	CHANDELLE MOUSSE DULCE DE LECHE 70G 	1	7613036454506	1	580	1	0	\N	\N
3464	COLACAO 250 G	1	7802635000188	1	1300	1	0	\N	\N
2721	LAVALOZAS SAPOLIO 500ML	1	7751851107488	1	950	1	0	\N	\N
1025	LAVALOZA MASTER 5LT	2	P010	1	2600	1	0	\N	\N
418	VANISH OXIAION 30 G 	2	7702626204208	1	400	1	0	\N	\N
744	TE SUPREMO CHAI 20UN.	1	7801875001597	1	1950	1	0	\N	\N
2553	JALEA REGIMEN 100G 	1	78018587	1	400	1	0	\N	\N
2140	LONGANIZA	31	305	2	4000	1	0	\N	\N
808	HUGGIES SOFT SKIN 56UN.	2	5029053550206	1	1300	1	0	\N	\N
1451	EMPANADA DE POLLO QUESO 	12	636	1	900	1	0	\N	\N
3805	MOSTAZA MIEL 240GR. MARCO POLO	1	7802420002052	1	1500	1	0	\N	\N
4583	JABON LUX 80 G 	1	8999999527693	1	500	1	0	\N	\N
4715	SALSA LISTA PIZZA ARCOR 200G	1	7790580408343	1	550	1	0	\N	\N
3841	MANJAR COLUN 1 KG 	1	7802920221458	1	3100	1	0	\N	\N
5923	YOGHURT PROTEIN MAS CON ZUCARITAS	1	7802900002619	1	800	1	0	\N	\N
6101	WHISKAS	1	7797453001472	1	650	1	0	\N	\N
5363	TRIPACK PEPSODENT 130G	1	7805000311353	1	3990	1	0	\N	\N
2584	ALUFOIL 4 METROS 	1	7801875150233	1	1300	1	0	\N	\N
5364	LECHE CAPPUCCINO COLUN 1 LT 	1	7802920008134	1	1600	1	0	\N	\N
5365	ESPONJA SAPOLIO 	1	7751851028127	1	250	1	0	\N	\N
1315	PAN INTEGRAL ARTESANAL  700 GRS IDEAL	24	7803403801020	1	2200	1	0	\N	\N
1425	ARVEJAS GRANO 500 GRS FRUTOS DEL MAIPO	32	7801300305047	1	1100	1	0	\N	\N
1897	GALLETA CREMONA COCO 160GR	26	7802408005310	1	450	1	0	\N	\N
833	BOLSA BASURA CLEAN 70 X 90 CM.	2	7801875001320	1	1100	1	0	\N	\N
307	MOSTAZA JB 100 GRAMOS 	1	7802640600076	1	550	1	0	\N	\N
362	SEMOLA LUCCHETTI 250 GRAMOS	4	7802500004013	1	600	1	0	\N	\N
816	JABON POPEYE CLASICO 170GR	2	7805045001134	1	900	1	850	\N	\N
834	BOLSA BASURA CLEAN 80 X 110 CM.	2	7801875001313	1	1690	1	0	\N	\N
1791	DOVE CREAM BAR 100G	36	8000700000005	1	850	1	0	\N	\N
1480	PIÑA	11	2000000000527	1	0	1	0	\N	\N
1540	BOLSAS PARA DULCES DE CUMPLEAÑOS DISNEY 	34	5201552519186	1	900	1	0	\N	\N
1547	VASOS DE PLASTICO ROJO FIESTA 10 UN 	34	6922332012800	1	1200	1	0	\N	\N
1548	VASOS DE CARTON DESECHABLE CUMPLEAÑOS 10 UN 	34	2000000000718	1	700	1	0	\N	\N
1539	GUIRNALDA BANDERIN FELIZ CUMPLEAÑOS 3MT 	34	5606858330907	1	1100	1	0	\N	\N
1492	SANDIA 	11	2000000000619	1	4000	1	0	\N	\N
293	MARUCHAN INSTANT LUNCH CALIFORNIA STYLE VEGETABLE 64 GRAMOS	1	041789001260	1	850	1	0	\N	\N
389	SHIP ZERO GINGE ALE 3 LITROS 	5	7804604720172	1	800	1	0	\N	\N
3982	CELEBRACIONES ELY 20 BOMBILLAS 	1	7898509285478	1	800	1	0	\N	\N
3983	BROCHETAS 50 UN 	1	7898509281272	1	900	1	0	\N	\N
2362	ADES NARANJA 200ML	1	7790895643750	1	400	1	0	\N	\N
2060	FACTURAS 	12	640	1	600	1	0	\N	\N
3940	EXCELL LIMPIADOR CREMA 250ML	1	7805020000787	1	1050	1	0	\N	\N
694	MANJAR COLUN POTE 400GR	1	7802920221328	1	1650	1	0	\N	\N
253	JUGO ZUKO DURAZNO 25 GRAMOS 	1	7802800578818	1	200	1	0	\N	\N
2747	PAP ZERO NAVIDAD 500ML 	1	7801620008178	1	600	1	0	\N	\N
3944	KETCHUP MARCO POLO 800KG	1	7802420001888	1	2800	1	0	\N	\N
2363	ADES CHOCOLATE 200ML	1	7790895643613	1	400	1	0	\N	\N
1447	MARGARINA DORINA 125 GR	21	7803200036359	4	450	1	0	\N	\N
3260	HUEVITOS MACIZOS 20 UN.	1	7802215110597	1	1250	1	0	\N	\N
2472	GUIRNALDAS HALLOWEEN 	1	6922332100026	1	890	1	0	\N	\N
3531	IANSA CERO K SUCRALOSA 180 ML	1	7801505001720	1	3000	1	0	\N	\N
2473	GUIRNALDAS HALLOWEEN 	1	6922332100064	1	890	1	0	\N	\N
2474	GUIRNALDAS HALLOWEEN 	1	6922332100019	1	890	1	0	\N	\N
1507	FRAMBUESA 	11	121	2	1000	1	0	\N	\N
1508	POROTOS VERDES 	11	122	2	1400	1	0	\N	\N
2317	CHEESECAKE GRANDE 	12	653	1	12000	1	6000	\N	\N
411	ABOLENGO 10 METROS 	2	7806500404620	1	550	1	0	\N	\N
1282	MERMELADA DAMASCO 250 GRS WATTS	28	7802810031013	1	1000	1	0	\N	\N
2475	SALSA TOMATE 200GR COLISEO	40	7804608221637	1	250	1	0	\N	\N
1088	PAPAS LAYS MAYONESA Y KETCHUP EVERCRISP 40GR	6	7802000011016	1	600	1	0	\N	\N
1219	KIT KAT41G  NESTLE 	1	7891000248768	1	750	1	0	\N	\N
1762	DURZANO TROZOS 2 CABALLOS 590GRS	1	7801380000191	1	1500	1	0	\N	\N
999	RINSO HORTENSIAS Y FLORES 400 G	2	7805000313821	1	990	1	0	\N	\N
1020	MAMMA MIA BOLOGNESA 200GR	1	7802500038025	1	550	1	0	\N	\N
1019	MAMMA MIA MEDITERRANEA 200GR	1	7802500038049	1	550	1	0	\N	\N
1022	MAMMA MIA NAPOLITANA 200GR	1	7802500038018	1	550	1	0	\N	\N
577	SOPA MARUCHAN POLLO 85GR	1	041789002212	1	700	1	0	\N	\N
1722	LUCCHETTI LASAÑA PRECOCIDA 200 GRS	1	7802500112923	1	900	1	0	\N	\N
1353	BRAZO DE REINA INDIVIDUAL 	12	621	1	1200	1	0	\N	\N
4009	BETUN NUGGET NEGRO 60 ML 	1	7501058743107	1	1550	1	0	\N	\N
4010	ESPONJA DORADA INOXIDABLE BILLASOL	1	7805054000074	1	700	1	0	\N	\N
4011	BOLSA BASURA CHACAO 80 X 110 	73	7801430400032	1	1300	1	0	\N	\N
4089	MOGUL	1	7802225000338	1	200	1	0	\N	\N
4379	CHOCOLATE COSTA 62% CACAO 80G	1	7802215101441	1	1990	1	0	\N	\N
4012	BOLSA BASURA CHACAO 50X70	1	7801430400049	1	500	1	0	\N	\N
1721	COLORANTES GOURMET	1	7802410010340	1	2200	1	0	\N	\N
817	JABON POPEYE BEBE 170 GRS	2	7805045001080	4	1000	1	0	\N	\N
3945	GELATINA LIMON LIVEAN 22G	1	7802800567041	1	700	1	0	\N	\N
1354	ROLLO DE CANELA  	12	622	1	1000	1	0	\N	\N
4014	BETUN NUGGET NEGRO 60ML	1	7501058743121	1	1550	1	0	\N	\N
3177	POROTO BONANZA TORTOLA G2 500G	1	7808743604560	1	1650	1	0	\N	\N
4016	WASIL ENSALADA DE VERDURAS 340	1	7801305003634	1	1300	1	0	\N	\N
2540	LIMONADA   MENTA ALBAHACA PRANZO 475CC	1	7804666920077	1	1290	1	0	\N	\N
1894	GALLETA CREMONA VAINILLA 160 GR	26	7802408005341	1	450	1	0	\N	\N
2187	SCOTH LAMP EMBALAJE 	34	56963535380	1	800	1	0	\N	\N
1473	ZANAHORIAS 	11	107	2	700	1	600	\N	\N
4015	PREPIZZA 1METRO	1	7803403232114	1	2200	1	2000	\N	\N
2511	VIENTETTA CAPPUCCINO 1LT 	1	7802705618411	1	3490	1	2990	\N	\N
2541	LIMONADA OCEAN BLUE PRANZO 475CC	1	7804666920022	1	1290	1	0	\N	\N
1874	RUCAS SELECT CREMA CEBOLLA 	1	6917554726352	1	1100	1	0	\N	\N
1870	RUCAS SELECT PIZZA PAPAS FRITAS	1	6917554726345	1	1100	1	0	\N	\N
2519	CHEF PEPITA DE UVA 500ML 	1	7802810002198	1	2990	1	0	\N	\N
2520	GALLETA DE ARROZ CHOC. CEREAL MIX	1	7802225688581	1	1750	1	0	\N	\N
2528	DESODORANTE FULL FRESH 	1	8692641039468	1	1900	1	0	\N	\N
2529	DESODORANTE FULL FRESH 	1	8692641039475	1	1900	1	0	\N	\N
2530	DESODORANTE FULL FRESH 	1	8692641039505	1	1900	1	0	\N	\N
2531	DESODORANTE FULL FRESH 	1	8692641039451	1	1900	1	0	\N	\N
2532	DESODORANTE FULL FRESH 	1	8692641039437	1	1900	1	0	\N	\N
2533	COLONIA PINK BABYLAND 210ML 	1	7804945076136	1	1790	1	0	\N	\N
2310	TORTA CHICA BIZCOCHO	12	651	2	7000	1	0	\N	\N
5366	CLORINDA LIMON  950G	1	7805080696630	1	1200	1	0	\N	\N
3819	QUIX 750 CC	73	7805000115913	1	2000	1	0	\N	\N
2536	COLONIA VERDE BABYLAND 210ML 	1	7804945076129	1	1790	1	0	\N	\N
2538	LIMONADA RASPBERRY 475CC	1	7804666920015	1	1290	1	0	\N	\N
2546	SASONADOR PARA TACOS 30G	1	7802095000193	1	1100	1	0	\N	\N
1021	CARACOLES AL QUESO LUCCHETTI 296GR	1	7802500220734	1	2000	1	1550	\N	\N
1719	HARINA S/P MONT BLANC 3KG	1	7802615005639	1	3350	1	0	\N	\N
2126	HOJALDRE 	12	645	1	850	1	0	\N	\N
2517	LEVADURA COLLICO 38G 	1	7803010000311	1	500	1	0	\N	\N
2534	COLONIA CELESTE BABYLAND 210ML 	1	7804945076167	1	1790	1	0	\N	\N
2547	DESORODANTE MAJIX	1	8696630126542	1	1490	1	0	\N	\N
2697	CARACOQUESOS 296G	1	7802575000552	1	2000	1	1600	\N	\N
3469	TE SUPREMO CEYLAN XPRESS 20 UN	1	7801875033017	1	1100	1	0	\N	\N
4039	LENTEJAS AGROSEP 1 KG 	1	7809568100068	1	2500	1	0	\N	\N
292	MAGNUM DULCE DE LECHE BRESLER 900 ML 	7	7805000318086	1	4490	1	0	\N	\N
3946	MARLBORO SANDIA 20 UNID	55	78024915	1	4000	1	3400	\N	\N
526	GATORADE COOL BLUE 1 LT	5	7801620005160	1	1300	1	1100	\N	\N
1220	CHOCOLATE CAPRI ALMENDRA 30G 	1	7613034279743	1	250	1	0	\N	\N
2521	GALLETA DE ARROZ 100G 	1	7802225688475	1	1200	1	0	\N	\N
736	YERBA MATE SERRANITA 500GR	1	7793670000069	1	2000	1	0	\N	\N
369	SHAMPOO FRUCTIS ALOE HIDRA BOMB 350 ML 	2	7509552830507	1	2500	1	0	\N	\N
1476	AJI CAPRI 	11	2000000000503	1	200	1	0	\N	\N
1536	GUIRNALDA BANDERIN FELIZ CUMPLEAÑOS 3MT 	34	5606858330952	1	1100	1	0	\N	\N
1551	PALOS DE BROCHETA BAMBOO 20 CM 	34	1003492280133	1	500	1	0	\N	\N
3979	COLUN SIN LACTOSA CHOCOLATE	1	7802920009643	1	400	1	0	\N	\N
3981	ANTICUCHOS LOYOLA 8 UN. 	1	7805693000022	1	1600	1	0	\N	\N
4041	GELATINA FRIT/STRAWBERRY  40 GRS TURBO	1	7801615771834	1	400	1	0	\N	\N
4042	PALMITOS HOMAR ENTEROS 400G 	1	7804610401133	1	1500	1	0	\N	\N
4038	JABON LUX AGUA 80G	1	8999999527709	1	500	1	0	\N	\N
3980	BOLSA REUTILIZABLE CHICA 	1	6940404040131	1	500	1	0	\N	\N
4046	CHORITOS EN ACEITE GHOSH 425G	1	7804610400723	1	2400	1	0	\N	\N
2548	DESODORANTE MAJIX	1	8696630126603	1	1490	1	0	\N	\N
73	CHER CEREZA AL LICOR UND. 	6	17802200050027	1	200	1	0	\N	\N
1546	INFLADOR DE GLOBOS 	34	1250190516143	1	1200	1	0	\N	\N
1872	RUCAS SELECT AROS DE CEBOLLA 	1	6917554956254	1	1100	1	0	\N	\N
4282	DUCREM	1	78917620	1	150	1	0	\N	\N
3952	GHOSH CHAMPIÑOES ENTEROS 400 ML	1	7804610400181	1	1350	1	0	\N	\N
233	JUGO LIVEAN FRUTILLA 8 GRAMOS 	1	7802800576517	1	200	1	0	\N	\N
1575	VELA CUMPLEAÑOS 	34	6935750011423	1	650	1	0	\N	\N
1570	CABLE USB UNIVERSAL QIHANG 	35	3325201534060	1	2300	1	0	\N	\N
83	CHOCOLATE ORLY NARANJA 115 G 	6	7802200894129	1	1100	1	1000	\N	\N
1423	PRIMAVERA 200 GRS FRUTOS DEL MAIPO	32	7801300012051	1	500	1	0	\N	\N
593	CREMA ESPARRAGOS MAGGI	1	7802950006735	1	450	1	0	\N	\N
511	PAP 500 CC	5	7801620016029	1	900	1	0	\N	\N
534	KEM XTREME DES.500 ML	5	7801620001711	1	1300	1	1000	\N	\N
527	KEM XTREME DES. 1,5 LTS	5	7801620001988	1	1750	1	1500	\N	\N
1440	MARGARINA PAN  125 GR SOPROLE	21	7802900600006	1	450	1	0	\N	\N
1881	GALLETA CHOCOLATE  200 GR FRUNA	26	7802408004702	1	650	1	500	\N	\N
2012	CHOCOLATE  160 GRS SAHNE NUSS	25	7613034721051	1	2600	1	2400	\N	\N
1457	LECHUGA MILANESA 	11	2000000000398	1	650	1	0	\N	\N
3845	BROWNIE NUTRA BIEN 62G	1	7803525000240	1	600	1	0	\N	\N
3846	GLADE HARMONY 900 ML 	1	7790520001054	1	1600	1	0	\N	\N
3848	BAYGON CASA Y JARDIN 450CM 	1	7790520991546	1	2600	1	0	\N	\N
2518	BOWL MARUCHAN POLLO 93G	1	041789003912	1	1390	1	0	\N	\N
3849	DETERGENTE FABULOSO 3 LTS 	1	199779	1	4200	1	0	\N	\N
4043	TOALLA PAPEL MAXI ROLLO 100 MTS	1	614143258121	1	3490	1	0	\N	\N
3847	GLADE FLORAL 900ML 	1	7790520001023	1	1400	1	0	\N	\N
1561	GLOBOS VIVA CHILE TRICOLOR 12 UN 	34	6901719980130	1	0	1	0	\N	\N
1515	SALCHICHON CERVECERO PF 	3	72	2	6000	1	0	\N	\N
1650	CREAM CHEESE TRADICIONAL 226G	20	030900111308	1	1850	1	0	\N	\N
1565	SERVILLETAS NUVES 	34	170190517227	1	600	1	0	\N	\N
237	JUGO SPRIM DAMASCO 35 GRAMOS 	1	7802575222909	1	190	1	0	\N	\N
1807	VIENESAS  5 UN TIL 	33	7801930005706	1	490	1	0	\N	\N
466	ACEITE DE OLIVA TALLIANI 250CC	1	7801320242209	1	3990	1	0	\N	\N
3851	COCKTAIL DE FRUTAS 590 GR 	1	7804608223587	1	1400	1	0	\N	\N
3239	DOÑAREPA 1KG 	1	7702020212052	1	2250	1	0	\N	\N
3852	COLISEO DURAZNOS EN CUBO 820GR	1	7804608223594	1	1700	1	0	\N	\N
1829	ACEITE MARAVILLA COLISEO 900 CC	1	7804608221651	1	1500	1	0	\N	\N
3475	MANJAR COLUN RECETA CAMPO 400G	1	7802920005911	1	1600	1	0	\N	\N
1463	APIO 	11	2000000000459	1	400	1	0	\N	\N
3088	ARROZ TUCAPEL BLUE BONNET G2 	1	7801420210139	1	1250	1	0	\N	\N
3858	SURLAT DESCREMADA	1	7804617470309	1	1000	1	0	\N	\N
3859	SALSA YOGURT CIBOULKETTE 200G GOURMET 	1	7802410452034	1	1200	1	0	\N	\N
4263	TRENTO	1	7896306617492	1	400	1	0	\N	\N
3500	ARROZ TUCAPEL G1 500G	1	7801420001843	1	900	1	800	\N	\N
3199	ACEITE VEGETAL BONANZA 900 CC	1	7808743600555	1	1550	1	0	\N	\N
3854	YERBA MATE FLOR PEPERINA 500G	1	7801840000389	1	2800	1	0	\N	\N
95	CLORINDA GEL ORIGINAL 250 G	2	7805080691529	1	700	1	600	\N	\N
3857	CHEETOS 230G	1	7802000014192	1	2100	1	1900	\N	\N
3863	FOSFOROS TALISMAN 	1	7806300021300	1	1000	1	0	\N	\N
4090	DISFRUTA 5 GRS 	1	7800004261512	1	250	1	0	\N	\N
3816	MAYONESA DON JUAN 950G 	1	7802351625016	1	2650	1	0	\N	\N
2088	LUCKY CRUSH 20 UN	55	78024397	1	4300	1	0	\N	\N
4091	DISFRUTA 5 GRS 	1	7800004261505	1	250	1	0	\N	\N
3862	BOLSA REUTILIZABLE GRANDE	1	6940404040117	1	1000	1	0	\N	\N
1729	LECHE NIDO BUEN DIA 130 GRS	45	7613032517748	1	1000	1	0	\N	\N
3873	SAL DOÑA EULALIA 1 KG 	1	7803600000318	1	400	1	0	\N	\N
3874	COTONITOS 200 UN	1	7805633018957	1	1200	1	0	\N	\N
1564	PARTY FIESTA 6 PCS 	34	3518826396018	1	1500	1	0	\N	\N
3765	COLUN CHEDDAR 8UN. 160GR.	1	7802920005829	1	1300	1	0	\N	\N
3885	SOPAIPILLAS C/ZAPALLO  20 U PRODUCTOS REVILLA	7	7604229132974	1	2100	1	0	\N	\N
3887	VELA ANTORCHA 	1	7805007139721	1	650	1	0	\N	\N
699	SUCRALOSA  270 ML DAILY	1	7809558100599	1	2650	1	0	\N	\N
3875	FRUCTIS CONTROL Y DEFINICION 350 ML 	1	7509552914641	1	2500	1	0	\N	\N
3876	FRUCTIS ANTICASPA 350 ML 	1	7509552901696	1	2500	1	0	\N	\N
3877	FRUCTIS NUTRICION VITAMINADA 300 ML 	1	7509552906516	1	2500	1	0	\N	\N
2172	TRAP. HUMEDO EXCELL PISO FLOT. 	1	7805020001838	1	2390	1	0	\N	\N
1720	HARINA S/P MERKAT 3KG	1	7802655000441	1	2500	1	0	\N	\N
2543	SALSA CESAR LIGHT 250GR 	1	7804655341296	1	1490	1	0	\N	\N
4044	TOALLAS HUMEDAS GOOD BABY 80PCS 	1	8690879819012	1	1200	1	0	\N	\N
2545	GUACAMOLE SEASONING CASA FIESTA 28G 	1	017600085542	1	1100	1	0	\N	\N
2215	CHIP ENTEL 	1	0003564A02480	1	1000	1	0	\N	\N
4261	CLORINDA CLORO GEL FLORES	1	7805080696616	1	1350	1	0	\N	\N
3937	LECHE EVAPORADA GHOSH 375 ML 	1	7804610400341	1	1200	1	0	\N	\N
4217	TE VERDE SUPREMO 20 BLS. 	1	7801875055170	1	1590	1	0	\N	\N
4003	ARROZ BONANZA 1 KG G2 	1	7808743600043	1	1200	1	0	\N	\N
3888	AEROSOL FRESH MUSK 	1	8696630133724	1	1200	1	0	\N	\N
3878	TE SUPREMO MENTA 20 UN	1	7801875058072	1	1200	1	1000	\N	\N
3886	REGIO 6 ROLLOS	1	7804670690096	1	2200	1	1600	\N	\N
23	ALKA MENTOL 29 G 	6	78012547	1	250	1	0	\N	\N
2598	ELITE DOBLE HOJA 50MT.	1	7806500509820	1	3490	1	0	\N	\N
2544	VELAS ALONDRA 4UN. 	1	7804605470113	1	1200	1	0	\N	\N
3879	TE SUPREMO BOLDO 20 UN.	1	7801875058027	1	1100	1	0	\N	\N
3865	ACEITE OLIVA TRATTORIA 250 ML 	1	7802575204004	1	3000	1	0	\N	\N
659	LOMITOS EN AGUA SAN JOSE 170GR	1	7801235001694	1	1500	1	0	\N	\N
3880	DORITOS 110 G 	1	7802000013867	1	1000	1	0	\N	\N
3881	GUALLARAUCO MANJAR	1	7803908006531	1	850	1	0	\N	\N
551	KEM PIÑA DESECHABLE  3 LTS	5	7801620001223	1	1950	1	0	\N	\N
1655	AMPOLLETA LED 5W  CHINA	35	7895623004947	1	1300	1	0	\N	\N
3890	AEROSOL FRESH PINK ROSE 	1	8696630133083	1	1200	1	0	\N	\N
3891	AEROSOL FRESH LILAC 	1	8696630135025	1	1200	1	0	\N	\N
3892	AEROSOL FRESH OCEAN 	1	8696630133021	1	1200	1	0	\N	\N
1458	LECHUGA ESCAROLA 	11	2000000000404	1	750	1	0	\N	\N
3893	CAFE ECCO 100 GRS	1	7802950002317	1	1400	1	0	\N	\N
3894	ACEITE SUAVIT 900 ML 	1	7897001010403	1	1250	1	0	\N	\N
3883	LECHE ENTERA COLUN 360G 	1	7802920005980	1	2600	1	0	\N	\N
3900	JABON LIQUIDO 1 LT 	1	7812091200381	1	1400	1	0	\N	\N
3901	JABON LIQUIDO 1 LT 	1	7812091300388	1	1400	1	0	\N	\N
4035	LENTEJAS PANTERA 500G	1	7591794090610	1	1990	1	0	\N	\N
3181	ORAL FRESH ENJUAGATORIO BUCAL 250	1	7800004000326	1	1890	1	0	\N	\N
3182	LECHE CONDENSADA BELLA HOLANDESA 397 GR	1	8716200458504	1	1050	1	0	\N	\N
4126	JABON BARRA DUC 110G	1	7790828104891	1	750	1	0	\N	\N
4127	JABON DE BARRA DUC 110 G 	1	7790828104907	1	750	1	0	\N	\N
4128	JABON DE BARRA DUC 110G	1	7790828104877	1	750	1	0	\N	\N
4130	TOALLA NOVA TREVOL 100 MTS 	1	7804670690522	1	1990	1	0	\N	\N
3363	CIF CREMA NARANJO 500ML	1	7791290008465	1	1990	1	0	\N	\N
3895	MAYONESA NATURA 760G	1	7791866000336	1	1750	1	0	\N	\N
3817	INFIERNO RED 250G	1	7802351001797	1	1500	1	0	\N	\N
688	POLVOS ROYAL 30 GR	1	7622300842444	1	350	1	300	\N	\N
820	SOFT CLASSIC  1 LT 	2	7805000141271	1	2500	1	2190	\N	\N
1882	GALLETA LIMON  200 GR FRUNA	26	7802408003477	1	650	1	500	\N	\N
2254	SHAMPOO SEDAL  RIZOS DEF. 190ML 	1	7791293030647	1	1200	1	0	\N	\N
1574	VELA CUMPLEAÑOS 1 	34	7806130004689	1	700	1	0	\N	\N
3897	NESCAFE OFERTA MUG 170G	1	7613034405418	1	5300	1	0	\N	\N
3898	JABON LIQUIDO 1 LT 	1	7812090200382	1	1400	1	0	\N	\N
1488	MORRON AMARILLO 	11	2000000000589	1	1300	1	0	\N	\N
3899	JABON LIQUIDO 1 LT	1	7812091600389	1	1400	1	0	\N	\N
3902	JABON LIQUIDO 1 LT 	1	7812090600380	1	1400	1	0	\N	\N
1567	PLATOS DE CARTON FELIZ CUMPLEAÑOS 10 UN 	34	2018123812323	1	600	1	0	\N	\N
3903	ISABELA BACON 	1	7896022075507	1	600	1	0	\N	\N
3904	ISABELA LAMEN GALLINA 	1	7896022055264	1	600	1	0	\N	\N
3905	PERROS DE ROPA	1	614143695254	1	700	1	0	\N	\N
4049	SHAMPOO FMILAND 750 ML 	1	7804945062504	1	2000	1	0	\N	\N
4050	SHAMPOO FAMILAND 750 ML 	1	7804945062696	1	2000	1	0	\N	\N
3914	QUESO RALLADO SOPROLE 40G	1	7802900001278	1	900	1	0	\N	\N
1039	ROCKLETS CHOCOLATE DOYPACK 150GR	6	7802225427586	1	1700	1	0	\N	\N
3919	LAYS 240	1	7802000014314	1	1900	1	0	\N	\N
3920	CEBOLLITAS EN VINAGRE DON JUAN 	1	7802351431204	1	1200	1	0	\N	\N
3921	ACEITUNAS RELLENAS 125G 	1	7802351000783	1	1400	1	0	\N	\N
3916	SURTIDO PARA CALDILLO CRUCERO 425G EN ACEITE	1	7804520019640	1	2100	1	0	\N	\N
3922	ACEITUNAS DESCORAZADAS 250G	1	7802351000820	1	1300	1	0	\N	\N
1300	KETCHUP DON JUAN 400G 	1	7802351615017	1	1300	1	0	\N	\N
3926	TRENCITO EN POLVO 350G 	1	7613039487105	1	2200	1	0	\N	\N
5	ACEITTE VEGETAL BELMONT 900ML	1	7802810012029	1	3490	1	2690	\N	\N
847	GALLETA SALVADO LIGHT SELZ 642GR	6	7802225317405	1	2000	1	0	\N	\N
1589	SALCHICHON CERVEZA SAN JORGE 	3	81	2	6000	1	5500	\N	\N
2030	PALLMALL ROJO 20	55	78012370	1	3300	1	3200	\N	\N
690	MANJAR  200 GRS NESTLE	1	7802950009408	1	800	1	0	\N	\N
92	CLORINDA CONCENTRADO 1 LITRO 	2	7805080100021	1	1350	1	1300	\N	\N
3882	TKCH 44G	1	7803473003102	1	400	1	300	\N	\N
845	GALLETA SALVADO LINAZA SELZ 519GR	6	7802225689847	1	2000	1	0	\N	\N
1768	SAPOLIO CREMA 750G 	1	7751851008594	1	1600	1	0	\N	\N
3918	MOROCHA BALLS 120 G 	1	7613037462456	1	1600	1	0	\N	\N
5367	CLORINDA LAVANDA 950G	1	7805080696654	1	1200	1	0	\N	\N
4169	DANKY QUEEN CONO	1	7613287171634	1	1590	1	0	\N	\N
4170	LUCUMA MANJAR110G	1	7803908005961	1	900	1	0	\N	\N
4168	LIMONADA  33G GUALLARAUCO	1	7803908004506	1	1950	1	0	\N	\N
4172	LONCO LECHE ZEROLACTO CHOC. 1 LT 	1	7802910005815	1	1400	1	0	\N	\N
4174	ROYAL 100G	1	7622300148119	1	1000	1	0	\N	\N
1764	KETCHUP DON JUAN 240GRS	1	7802351614607	1	1100	1	0	\N	\N
474	PREGRANEADO 500 GR MIRAFLORES	1	7800120719010	1	750	1	0	\N	\N
700	ENDULZANTE TRADICIONAL  270 ML DAILY	1	7809558101091	1	4300	1	1650	\N	\N
3932	SOPAIPACK TRAVERSO 	1	7802337930479	1	1500	1	0	\N	\N
3933	GELATINA LIVEAN 20G	1	7802800567065	1	700	1	0	\N	\N
3934	GELATINA PIÑA LIVEAN 20G	1	7802800567027	1	700	1	0	\N	\N
3936	FLAN CHOCOLATE LIVEAN 20G	1	7802800562510	1	700	1	0	\N	\N
3948	ALOE VERO VERA PIÑA 500 ML 	1	6971549920040	1	1000	1	0	\N	\N
3949	ALOE VERA COCO 500 ML 	1	6971549920088	1	1000	1	0	\N	\N
3950	ALOE VERA MANGO 500 ML 	1	6971549920033	1	1000	1	0	\N	\N
3951	ALOE VERA 500 ML 	1	6971549920026	1	1000	1	0	\N	\N
3953	ATUN DESMENUZADO MERKAT 170G	1	6955933002239	1	990	1	0	\N	\N
3927	JUREL LOMOS AHUMADO 170G 	1	7801235001618	1	1400	1	0	\N	\N
3928	JUREL LOMITOS ACEITE 170G	1	7801235001601	1	1400	1	0	\N	\N
3955	CHOCO CHOCO GOPLANA 16 G	1	59080466	1	300	1	0	\N	\N
3956	AUDIFONOS MLAB 	1	6927900077267	1	2500	1	0	\N	\N
3957	AUDIFONOS MLAB 	1	6927900077298	1	2500	1	0	\N	\N
3958	AUDIFONOS MLAB 	1	6927900077274	1	2500	1	0	\N	\N
478	ARROZ G1 BONANZA 1KG	1	7808743600203	1	950	1	0	\N	\N
3954	KYZPO CHORIPAN 130G	1	7802800533459	1	1600	1	0	\N	\N
3969	AZUCAR DE CAÑA KIÑEWEN	1	606110130479	1	2000	1	0	\N	\N
3959	KRYZPO CHORIPAN 	1	7802800533466	1	1000	1	0	\N	\N
3917	MOROCHA TREMENDA 95 G	1	7613039566220	1	1300	1	1100	\N	\N
3960	CARBONADA CASERA WASIL 380G	1	7801305004563	1	2490	1	1200	\N	\N
3961	POROTOS GRANADOS CASEROS WASIL 	1	7801305004143	1	2000	1	0	\N	\N
3970	TRAPEROS HUMEDOS IGENOL	1	712878404360	1	2100	1	0	\N	\N
3962	KANIKAMA 1 KG	31	2000000001586	1	4400	1	0	\N	\N
3974	VELAS BLANQUITA GRANDE 	1	8904206227945	1	1100	1	0	\N	\N
2660	KANIKAMA 200G 	1	7708192000015	1	1500	1	0	\N	\N
3964	SALSA DE TOMATE ARCOR 200G	1	7793360126840	1	550	1	0	\N	\N
3965	CONFORT 27 METROS 4 ROLLOS	1	7806500506966	1	1200	1	0	\N	\N
3719	AZUCAR FLOR DE REYES 500GR	1	7804609020994	1	900	1	0	\N	\N
3966	QUESILLO FRESCO COLUN 450G 	1	7802920008370	1	2250	1	0	\N	\N
3971	MANJAR CASERO IO 1 KG	1	7804628170014	1	2590	1	0	\N	\N
3972	LAVALOZAS EXCELL MAS CLORO 1 LT 	1	7805020002347	1	1400	1	0	\N	\N
453	RAVIOLI CARNE  400 GR CAROZZI	1	7802575040206	1	1800	1	0	\N	\N
4218	NESTUM FRUTILLA 250 CC 	1	7613036048101	1	1900	1	0	\N	\N
3976	CONFORT BRIGHT 250 HOJAS 	1	781159480607	1	1000	1	0	\N	\N
2524	ALCOHOL GEL COBRE 320G 	1	7804916670035	1	3200	1	0	\N	\N
2525	GEL DE PELO HAZARD 	1	7804916662016	1	1100	1	0	\N	\N
2526	QUESO LAMIN. GAUDA CALO 150G	1	7802910003637	1	1450	1	0	\N	\N
2527	DESODORANTE FULL FRESH 	1	8692641039444	1	1900	1	0	\N	\N
3978	CEREAL COLA CAO PILLOWS 440G	1	7802635000430	1	3400	1	0	\N	\N
2585	ALUPLAST 15 METROS 	1	7801875150455	1	1500	1	0	\N	\N
1495	CHAMPIÑON GRANEL 	11	114	2	9000	1	0	\N	\N
4001	PAÑALES ADULTO PLENITUD 16U	1	7896007547203	1	9800	1	0	\N	\N
1462	PEREJIL 	11	2000000000442	1	550	1	0	\N	\N
5323	AVELA BOMBON 55G	1	7896079823717	1	1200	1	0	\N	\N
3984	QUILLAYES QUESO CHANCO 6 LAMINAS	1	7802930005215	1	1100	1	0	\N	\N
3985	SAN REMO ATUN 170	1	8852084171273	1	1200	1	0	\N	\N
3986	DORASOL LOMITOS DE ATUN EN ACEITE 142	1	7804608223099	1	1200	1	0	\N	\N
3987	ESMERALDA ATUN LOMITO 170	1	7802420003882	1	1200	1	0	\N	\N
3988	GRANOLA QUAKER MIEL Y ALMENDRAS 380G	1	7802000011313	1	2200	1	0	\N	\N
4171	BARRA FRAMBUESA CUBIERTA CHOCOLATE	1	7803908003103	1	850	1	0	\N	\N
3989	AVENA MULTISEMILLA 650G	1	7802000013522	1	2600	1	0	\N	\N
4002	DURAZNO TROCITOS CENTAURO 570G	1	7801256005008	1	1400	1	0	\N	\N
2336	AVENA MULTISEMILLA MANZANA Y PASAS 700G	1	7802000011719	1	2600	1	0	\N	\N
3990	AVENA INSTANTANEA 830 G	1	7802000014376	1	2200	1	0	\N	\N
3991	NESCAFE TRADICIONAL 170 G 	1	7613035946323	1	5200	1	0	\N	\N
442	CUSCUS CAROZZI 250G	1	7802575031181	1	1590	1	1400	\N	\N
3994	RIGATI MIX CAROZZI 400G	1	7802575015297	1	1350	1	950	\N	\N
3996	TE CEYLAN  125 GR SUPERIOR	1	7801875023018	1	1800	1	0	\N	\N
337	PEPSODENT 90 G 	2	7805000311322	1	1100	1	0	\N	\N
4000	DURAZNO MITADES CEMTAURO 570G	1	7801256001000	1	1400	1	0	\N	\N
4005	LAVALOZAS VIRGINIA 500ML 	1	7805040001306	1	1200	1	0	\N	\N
661	ATUN DESMENUZADO AL AGUA  185 GR SAN JOSE	1	7801235266116	1	950	1	0	\N	\N
4006	LAVALOZAS SAPOLIO 300ML 	1	7751851010726	1	900	1	0	\N	\N
4007	VELAS ANTORCHA 4 UN. 	1	7804605470120	1	1700	1	0	\N	\N
4008	VELAS LUCERO GRANDES 	1	7801430800108	1	1500	1	0	\N	\N
2095	HIELO 2 KG	1	9999	1	1000	1	0	\N	\N
4034	MANJAR NESTLE SON LACTOSA 500 ML 	1	7613038464367	1	2400	1	0	\N	\N
4256	BOMBA LOLLIPOP	1	6920484020230	1	300	1	0	\N	\N
721	NESCAFE  50 GR DECAF	1	7613032836740	1	2000	1	0	\N	\N
2843	LAVALOZAS BAKO 750CC	1	7804655560215	1	900	1	0	\N	\N
4257	POPOTE DE DULCE	1	6925374504944	1	150	1	0	\N	\N
4258	TUCREMA 3 SABORES	1	6921078601927	1	100	1	0	\N	\N
4259	KIT KAT HELADO 85	1	7613287171696	1	1590	1	0	\N	\N
4260	CLORO GEL LAVANDA 900 ML	1	7805080696166	1	1650	1	0	\N	\N
3995	CORBATAS MIX CAROZZI 400G	1	7802575015303	1	1350	1	950	\N	\N
3998	RISOTO CHAMPIÑON 180G	1	7802575715050	1	1500	1	0	\N	\N
3997	MIRAFLORES 3 QUESOS 180G	1	7802575715081	1	1500	1	0	\N	\N
3853	COLISEO DURAZNOS MITADES 820G	1	7804608223600	1	1700	1	0	\N	\N
276	LAV. WYN CONCENTRADO 750 ML 	2	7804609730435	1	1700	1	0	\N	\N
65	CERA BRILLINA INCOLORA 360 CM3 	2	7805040001467	1	1550	1	1300	\N	\N
4017	CHURRASCO SAN JORGE 120 VACUNO	1	7801907011037	1	900	1	800	\N	\N
3850	AZUCAR  1 KG LA MESA	1	7801850000294	1	990	1	0	\N	\N
35	TUCAPEL GRAN SELECCION G2, 1 KG	1	7801420220138	1	1800	1	1300	\N	\N
130	DURAZNOS TROCITOS WASIL 590 GRAMOS 	1	7801305101453	1	1990	1	0	\N	\N
3855	ARROZ ARUBA G2 SELECCION 1 KG 	1	7801430830075	1	1250	1	0	\N	\N
3362	CIF CREMA ORIGINAL  750 GRS C IF	73	7791290008441	1	1990	1	0	\N	\N
4064	CABLE USB IRM 	1	7858816053375	1	2500	1	0	\N	\N
4065	CABLE USB IRM 	1	7858816053399	1	2500	1	0	\N	\N
4066	BOMBILLAS CUMPLEAÑOS 	1	5690166052781	1	1000	1	0	\N	\N
4067	BOMBILLAS CUMPLEAÑOS 	1	5690166052743	1	1000	1	0	\N	\N
4068	BOMBILLAS CUMPLEAÑOS 	1	5690166016608	1	1000	1	0	\N	\N
4069	BOMBILLAS CUMPLEAÑOS 	1	5690166052804	1	1000	1	0	\N	\N
4070	VELAS CUMPLEAÑOS 	1	7806130004702	1	700	1	0	\N	\N
4071	VELAS CUMPLEAÑOS 	1	7806130004719	1	700	1	0	\N	\N
4072	VELAS CUMPLEAÑOS 	1	7806130004764	1	700	1	0	\N	\N
4073	VELAS CUMPLEAÑOS 	1	7806130004740	1	700	1	0	\N	\N
4074	VELAS CUMPLEAÑOS 	1	7806130004733	1	700	1	0	\N	\N
4075	VELAS CUMPLEAÑOS 	1	7806130004771	1	700	1	0	\N	\N
4076	VELAS CUMPLEAÑOS 	1	7806130004726	1	700	1	0	\N	\N
4077	VELAS CUMPLEAÑOS 	1	7806130004696	1	700	1	0	\N	\N
1235	CEREALES ZUCOSOS  350 GRS NESTLE	27	7613035120297	1	2650	1	0	\N	\N
4078	VELA GRANDE CUMPLEAÑOS 	1	5690166003301	1	990	1	0	\N	\N
4079	VELAS CUMPLEAÑOS 	1	7806130003736	1	700	1	0	\N	\N
4080	SCOTT 250 HOJAS 4 ROLLOS	1	7751493005364	1	1300	1	0	\N	\N
3818	IGENIX DESINFECTANTE AEROSOL 360M 	1	7805040001016	1	2400	1	0	\N	\N
4081	BORWNIE CHIPS NUTRA BIEN 62G	1	7803525999544	1	600	1	0	\N	\N
4082	BROWNIE NUTRA BIEN SIN AZUCAR 50G	1	7803525999667	1	600	1	0	\N	\N
4083	QUEQUE MARMOL 70GR	1	7803525400446	1	600	1	0	\N	\N
4086	OBLEA DOS EN UNO 108	1	7896058258134	1	950	1	0	\N	\N
1633	VELAS DE CUMPLEAÑOS MAGIC RELIGHTING CANDLES 10UN	34	9328567890362	1	550	1	0	\N	\N
25	ALKA STRONG 29 G 	6	78012554	1	250	1	0	\N	\N
4087	MAMADERAS TOP KIDS 	1	765439876489	1	2500	1	0	\N	\N
4088	MAMADERAS XIAOXIM 150ML	1	6935242580123	1	1500	1	0	\N	\N
4113	SHAMPOO BALLERINA 750ML	1	7804920006929	1	2000	1	0	\N	\N
3702	CABLE USB 	1	6927900080045	1	2200	1	0	\N	\N
4114	SHAMPOO BALLERINA 750ML	1	7804920003188	1	2000	1	0	\N	\N
4115	SHAMPOO BALLERINA 750ML	1	7804920005632	1	2000	1	0	\N	\N
4093	CHORIZO PARRILLERO PREFERIDA 250	1	7801916038506	1	1300	1	0	\N	\N
4094	MASA EMPANADA L  20 UNDS PRODUCTOS REVILLA	7	7604229133803	1	3000	1	0	\N	\N
4116	FRESH ROOM	1	8696630133014	1	1200	1	0	\N	\N
4028	MASA  EMPANADAS XL PRODUCTOS REVILLA	7	7604229133810	1	3600	1	0	\N	\N
4095	TERRA VEGGIE 160G	1	7802420004520	1	1500	1	0	\N	\N
4098	CREMISSIMO BRESLER 1 LITRO	1	7805000307035	1	2390	1	0	\N	\N
4099	TRITON SAVORY 	1	7613039056974	1	990	1	0	\N	\N
4100	VIENNETTA 	1	7802705613652	1	2990	1	0	\N	\N
4101	SALCHICHA TRADICIONAL  20 UN PF	3	7801930000930	1	2490	1	0	\N	\N
4102	BALLERINA ACCION ANTIOXIDANTE 750 ML	1	7804920006158	1	2000	1	0	\N	\N
4118	DETERGENTE OSO 400G	1	7804520024941	1	650	1	0	\N	\N
101	CÓCTEL DE FRUTAS WASIL 560 GRAMOS 	1	7801305101354	1	2100	1	0	\N	\N
4104	SALSA TERIYAKI SANTE 250 ML 	1	7804610401348	1	1990	1	0	\N	\N
3820	LIPTON YELLOW LABEL 50BL	1	7801810712830	1	2800	1	0	\N	\N
4105	CONFORT QUALITE 12 ROLLOS 	1	7899853801413	1	3400	1	0	\N	\N
4106	CONFORT MAMA LOVE 	1	041604165061	1	5600	1	0	\N	\N
4107	ACONDICIONADOR BALLERINA 750ML	1	7804920002525	1	2000	1	0	\N	\N
4108	ACONDICIONADOR BALLERINA 750 ML	1	7804920006936	1	2000	1	0	\N	\N
4109	ACONDICIONADOR BALLERINA 750ML	1	7804920003027	1	2000	1	0	\N	\N
4110	ACONDICIONADOR BALLERINA 750ML	1	7804920002587	1	2000	1	0	\N	\N
4018	SAPOLIO ULTRA NARANJA 300ML	1	7751851010733	1	900	1	0	\N	\N
4117	DETERGENTE OSO 800G	1	7804520025375	1	1550	1	0	\N	\N
4092	SALCHICHA SUREÑA 5 UN PF	1	7801916005171	1	1100	1	0	\N	\N
4097	MOMS CASERAS 250	1	7802000013690	1	1700	1	1500	\N	\N
4111	ACONDICIONADOR BALLERINA 750ML	1	7804920005656	1	2000	1	0	\N	\N
4119	AEROSOL DOÑA GABY 300 ML 	1	8699009446951	1	2500	1	0	\N	\N
4120	AEROSOL DESINFECTANTE DOÑA GABY 300 ML 	1	8699009446920	1	2500	1	0	\N	\N
4121	AEROSOL DESINFECTANTE DOÑA GABY 300ML	1	8699009446944	1	2500	1	0	\N	\N
4122	 NESCAFE SELECCION 50G 	1	8801055709229	1	2790	1	0	\N	\N
4123	NESCAFE SELECCION  100G	1	8801055709212	1	5100	1	0	\N	\N
4145	MARINELLA MEGA ROLLO 50G	1	7803473003522	1	300	1	0	\N	\N
4146	BEBIDA DE MAQUI 500 ML 	1	7804651870127	1	1000	1	0	\N	\N
4147	BEBIDA DE MAQUI 1 LT 	1	7804651870196	1	1550	1	0	\N	\N
4158	SEMOLA VIVO 150G	1	7802200365650	1	900	1	0	\N	\N
4159	FLAN VIVO TRES LECHES 80G	1	7802200365698	1	900	1	0	\N	\N
3160	GOLD LUCUMA NUEZ SOPROLE 165G	1	7802900000370	1	600	1	0	\N	\N
4148	OIKOS COLCHON DE FRUTA 150G	1	7802955008703	1	550	1	0	\N	\N
4149	OIKOS YOGUR 110G	1	7802955004972	1	500	1	0	\N	\N
4150	BASE PARA TORTILLA GOURMET 42 G	1	7802410350835	1	700	1	0	\N	\N
4151	SALSA PESTO GOURMET 30 G	1	7802410350323	1	700	1	0	\N	\N
4152	BASE CARNE MONGOLIANA GOURMET 30G	1	7802410000976	1	700	1	0	\N	\N
4153	SALSA ALFREDO 41G 	1	7802410350118	1	700	1	0	\N	\N
4154	BASE PARA CEVICHE GOURMET 30G	1	7802410002901	1	700	1	0	\N	\N
3411	COLUN MANTECOSO 160G	1	7802920007915	1	1500	1	0	\N	\N
4029	NATURA SUCRALOSA 180 ML	1	7804918401811	1	1990	1	0	\N	\N
4155	SALSA CHAMPIÑONES GOURMET 30G	1	7802410350255	1	700	1	0	\N	\N
740	TE SUPREMO RENDIDORA 100UN.	1	7801875032034	1	2250	1	0	\N	\N
4156	CARBONADA NATUREZZA 110G	1	7803700612510	1	900	1	0	\N	\N
4160	FLAN CHOCOLATE 90G	1	7802200365803	1	900	1	0	\N	\N
4161	LECHE COLUN DESCREMADA 300G	1	7802920006000	1	2390	1	0	\N	\N
4162	LIMPIA VIDRIOS EXCELL 500CC	1	7805020000916	1	1350	1	0	\N	\N
4163	ANTIGRASA EXCELL 500CC	1	7805020000930	1	1250	1	0	\N	\N
4164	LEVADURA PAKMAYA 11G 	1	7804642160305	1	200	1	0	\N	\N
4175	DURACEL AA 2 UNIDADES	1	041333001005	1	1500	1	0	\N	\N
4176	NUCREM 43G	1	7790380016915	1	400	1	0	\N	\N
4178	PILAS MAXELL 3V	1	025215736469	1	1000	1	0	\N	\N
4208	SAZONADOR TACOS 	1	017600081223	1	1000	1	0	\N	\N
2849	REXONA STAY FRESH BAMBOO150ML	1	7791293036069	1	2500	1	0	\N	\N
4205	DESODORANTE REXONA 	1	7791293032436	1	2500	1	0	\N	\N
4206	LECHE EN POLVO COLUN 900ML 	1	7802920009803	1	5500	1	0	\N	\N
4177	PILAS GP 3V	1	4891199001130	1	1200	1	0	\N	\N
4180	MOGUL TORNADO 150G	1	7790580118051	1	990	1	0	\N	\N
4181	MOGUL MURCIELAGOS 150G	1	7790580410384	1	990	1	0	\N	\N
4183	JUGO SPRIM MANZANA 35G	1	7802575223470	1	190	1	0	\N	\N
4184	JUGO SPRIM NARANJA PLATANO 35G	1	7802575223548	1	190	1	0	\N	\N
4185	ROLLS CRISPY  130 GR COSTA	1	7802215121319	1	1700	1	0	\N	\N
4186	KIT KAT WHITE 41.5G	1	7891000249239	1	750	1	0	\N	\N
4187	KIT KAT DARK 41.5G	1	7891000248829	1	750	1	0	\N	\N
4188	JUGO LIVEAN MANGO 7G 	1	7802800576715	1	200	1	0	\N	\N
4189	JUGO LIVEAN PERA AL AGUA 7G	1	7802800576692	1	200	1	0	\N	\N
4190	JUGO LIVEAN LIMONADA 7G	1	7802800586318	1	200	1	0	\N	\N
4191	JUGO LIVEAN MELON TUNA 7G	1	7802800576746	1	200	1	0	\N	\N
4192	JUGO LIVEAN HUESILLO	1	7802800586608	1	200	1	0	\N	\N
4193	CEBOLLA BLANCA 	1	2000000001623	1	300	1	0	\N	\N
4194	INVITE WAFFLE CAKE 4X45G	1	8692806325719	1	1990	1	0	\N	\N
4195	INVITE 	1	8692806722693	1	1990	1	0	\N	\N
4196	INVITE STRAWBERRY	1	8692806325733	1	1990	1	0	\N	\N
4197	INVITE DONUT CAKE 	1	8692806625239	1	1990	1	0	\N	\N
413	NOVA CLÁSICA 12.5 METROS	2	7806500401414	1	550	1	0	\N	\N
1792	DOVE SHEA BUTTER 100G 	36	8690637647420	1	1100	1	0	\N	\N
4198	ACEITE BELMONT MARAVILLA 1 LT	1	7802810000477	1	2450	1	0	\N	\N
4199	LECHUGAS 	1	2000000001630	1	650	1	0	\N	\N
4201	SALSA DE AJO DON JUAN	1	7802351000868	1	1200	1	0	\N	\N
4202	DESODORANTE REXONA 	1	7791293032443	1	2500	1	0	\N	\N
4203	LUSTRA MUEBLES DOÑA GABY 400ML 	1	8699009436693	1	2100	1	0	\N	\N
4204	LUSTRA MUEBLES DOÑA GABY 400ML 	1	8699009436709	1	2100	1	0	\N	\N
4207	SUAVIZANTE SOFT 1 LT	1	7805000141301	1	2100	1	0	\N	\N
4209	NESCAFE BLACK ROAST 50G 	1	7613039184646	1	1690	1	0	\N	\N
4210	CREMA DE MANI CROCANTE 340G	1	6972102831247	1	2100	1	0	\N	\N
4211	TOALLAS HUMEDAS REGIO 48 UN. 	1	7804670690584	1	990	1	0	\N	\N
4212	TOALLAS HIGIENICAS PARATI 8 UN. 	1	7809536101051	1	990	1	0	\N	\N
4219	TRENCITO BALLS SAVORY	1	7613287036759	1	1100	1	0	\N	\N
4220	ALCACHOFA	1	2000000001647	1	400	1	0	\N	\N
4221	ESCOBILLON NORMAL	1	2000000001654	1	2000	1	0	\N	\N
5252	HOBBY MANI 35 G	1	7802225584081	1	400	1	0	\N	\N
4224	CHOCOLATE ZITRONE 100G	1	9002859044670	1	1500	1	0	\N	\N
4225	CHOCOLATE MINZ 100G	1	9002859044649	1	1500	1	0	\N	\N
4227	PALETA ZOO 75	1	7805000318178	1	690	1	0	\N	\N
4230	HUPPY BABY PLUS 	1	7896064455183	1	2390	1	0	\N	\N
4231	LECHE SOYA LONCO LECHE NATURAL 1L	1	7802910005150	1	2600	1	0	\N	\N
4223	CHOCOLATE  HIMBEER FRAMBUESA 100G	1	9002859044625	1	1500	1	0	\N	\N
4232	POROTO NEGRO AGROPRODEX 1KG	1	7803920010813	1	2500	1	0	\N	\N
4233	CEREALES SOBRE ESTRELLITA NESTLE	1	7613031763856	1	300	1	0	\N	\N
4236	TANAX MATA ARAÑAS Y BARATAS 440CC	1	7805300049697	1	3150	1	0	\N	\N
4237	TANAX PULGAS GARRAPATAS 440 CC	73	7805300049703	1	3790	1	0	\N	\N
4238	TE CANELA CEYLAN SUPREMO 40G	1	7801875047052	1	750	1	0	\N	\N
4239	MERKAT ACEITE OLIVA 250G 	1	7804632500180	1	2590	1	0	\N	\N
3822	ENCENDEDORES 	1	6970772670135	1	300	1	0	\N	\N
4240	CACAO AMARGO 150G GOURMET	1	7802410605027	1	1200	1	0	\N	\N
4241	MAYONESA JB 76 GR	1	7805000301279	1	550	1	0	\N	\N
4242	EXCELL CLORO GEL ANTISARRO 900CC	1	7805020000985	1	1350	1	0	\N	\N
4243	EXCELL CLOROGEL ANTISARRO LIMON 900CC	1	7805020001951	1	1350	1	0	\N	\N
4244	YOGHURT BATIDO NATURAL COLUN 120G	1	7802920009070	1	400	1	0	\N	\N
4245	HELADO CREMISSIMO VAINILLA 1LT	62	7805000305284	1	2390	1	0	\N	\N
4246	COLUM LIGHT 125G 	1	7802920000909	1	400	1	0	\N	\N
4234	CRIOLLITAS LIMON 100 G	1	7613287158840	1	1290	1	1000	\N	\N
4235	CRIOLLITAS CHOCOLATE 100G	1	7613287158734	1	1290	1	1000	\N	\N
4247	HALLOWEEN 80 UNIDADES	1	7802200107182	1	1500	1	0	\N	\N
4248	GOMITAS PASALO DE MIEDO 40 UNIDADES	1	7802215290114	1	2600	1	0	\N	\N
4249	CHOCMAN BLACK 33G	1	7802215303937	1	150	1	0	\N	\N
4250	PLATANO	1	2000000001661	1	600	1	0	\N	\N
4251	MAYONESA AGROSILVA 750 CC SABOR CASERO	1	7802354000308	4	1600	1	0	\N	\N
4252	BOLSA DE BASURA OSO 80X120	1	7804520989431	1	2150	1	0	\N	\N
4253	HIELO 1 KG	1	2000000001678	1	500	1	0	\N	\N
4226	HEIDI CORAZON 140GRS	1	5941021003845	1	6000	1	0	\N	\N
4229	NOVA EXTRA DISEÑO 3 ROLLOS 	1	7806500406501	1	1600	1	0	\N	\N
2780	CHOCLO GRANO MERKAT 500G 	1	7801222050896	1	1100	1	0	\N	\N
309	NIK OBLEA FRUTILLA 71G 	6	7802215504662	1	450	1	0	\N	\N
481	ACEITE MERKAT 5LT	1	7808743601965	1	6900	1	0	\N	\N
3565	INSECTICIDA ALFAKILL ARAÑAS Y BARATAS 360CC	1	7805300051140	1	1500	1	0	\N	\N
3733	CHANCACA DELICIOSA 450G 	1	7805040413154	1	2350	1	0	\N	\N
3	ACEITE MIRAFLORES MARAVILLA  1 LITRO 	1	7801320220061	1	2600	1	0	\N	\N
3735	KETCUHP JB 1KG	1	7802640600403	1	2300	1	0	\N	\N
3736	FLAN CARAMELO  120 GR SOPROLE	1	7802900257149	1	390	1	0	\N	\N
3737	FLAN VAINILLA  120 GR SOPROLE	1	7802900257057	1	390	1	0	\N	\N
3738	JALEA NARANJA  110 GR SOPROLE	1	7802900295066	1	350	1	0	\N	\N
3740	NOBLE 8 UN 28 MTS.	73	7806500504511	1	1850	1	0	\N	\N
3741	MOUSSE LECHE CONDENSADA 70GR.	1	7613038669649	1	700	1	0	\N	\N
3757	ATUN LOMITO EN ACEITE 160GR. SAN REMO 	1	8859209801121	1	1350	1	0	\N	\N
3480	LYSOL LIMON 900ML 	1	7791130008716	1	1990	1	0	\N	\N
3758	MOSTAZA 250 GR. DON JUAN 	1	7802351315009	1	800	1	0	\N	\N
4030	OCHO HIERBAS SUPREMO 20 UN.	1	7801875111012	1	1100	1	0	\N	\N
4019	ALFAJOR TATIN 33 G	1	7790040331204	1	200	1	0	\N	\N
3742	OPTIMO LIMON 750ML.	1	7804663190282	1	1300	1	0	\N	\N
3324	JABON LIQUIDO COCO 900ML	1	7804920003065	1	2000	1	1400	\N	\N
3739	JALEA PIÑA  110 GR SOPROLE	1	7802900295035	1	350	1	0	\N	\N
4020	LAYS CORTE AMERICANO 380 G	1	7802000014703	1	2900	1	0	\N	\N
3744	PROTEIN MILK CHOC. 1LT.	1	7802910007123	1	1500	1	0	\N	\N
3745	SAPOLIO WC 500ML 	1	7751851559102	1	1400	1	0	\N	\N
3734	CEREAL VIVO AVENA 4 SEMILLAS 700G	1	7800120170101	1	2500	1	0	\N	\N
3747	LUSTRA MUEBLES LAV 250ML	1	7805040313027	1	1400	1	0	\N	\N
3748	LUSTRA MUEBLE VAI. 250ML	1	7805040313034	1	1400	1	0	\N	\N
3749	LIMPIA VIDRIOS 250 ML VIRGINIA	73	7805040316004	1	950	1	0	\N	\N
3750	SAPOLIO WC PMAX 500ML.	1	7751851024006	1	1400	1	0	\N	\N
3752	MOGUL EXTREME GOMITAS 35GR.	1	7802225412193	1	300	1	250	\N	\N
3753	GOMITAS ALKA 25GR.	1	7802225409445	1	250	1	0	\N	\N
3746	SAPOLIO WC LIMON 500 ML.	1	7751851559119	1	1400	1	0	\N	\N
3755	JUGO LIMON  500 ML FRESCOLIM	1	7802337802035	1	750	1	0	\N	\N
3759	MAYONESA CLASICA 250 GR. DON JUAN 	1	7802351625023	1	800	1	0	\N	\N
3760	ORANGE CRUSH 237 CC XPRESS	75	7801620007638	1	300	1	0	\N	\N
3754	JUGO DE LIMON 250ML. FRESCOLIM	1	7802337802011	1	450	1	0	\N	\N
3756	ALKA GOMITA 25GR. 	1	7802225409391	1	300	1	250	\N	\N
3761	LIMON SODA XPRESS 237 ML 	75	7801620004293	6	300	1	0	\N	\N
3763	LIMON SODA  2000 ML CCU	75	7801620340193	1	1350	1	0	\N	\N
3766	HOME SWEET HOME 360ML 	1	7804947003550	1	4000	1	0	\N	\N
3681	PAÑO SACUDIR ARUBA 	1	7804645200039	1	450	1	0	\N	\N
3767	LONGANIZAS SOLER 500GR	1	7801927000080	1	3500	1	0	\N	\N
3768	JAMON CRUDO 100GR	1	7801927000066	1	2800	1	0	\N	\N
3706	QUINOA CAROZZI 250G	1	7800120749031	1	2650	1	2590	\N	\N
746	TE SUPREMO NARANJA 20UN.	1	7801875055118	1	1890	1	0	\N	\N
3783	ATUN LOMITOS AGUA 160GR ANGELMO 	1	2000000001555	1	1200	1	0	\N	\N
3777	WATTS FRUTILLA SIN AZUCAR 200GR.	1	7802810010193	1	1100	1	0	\N	\N
3751	BIOFRESH X3 ROLLOS 12MTS.	1	742832172363	1	1200	1	0	\N	\N
3770	TIC TAC COCA COLA 	1	77078841	1	400	1	0	\N	\N
3771	BATERIA 9V DURACELL	74	041333001043	1	3400	1	0	\N	\N
3727	ROCKLETS BLANCO 30G	1	7802225427906	1	450	1	0	\N	\N
3036	YERBA MATE FLOR DE YERBA 500G	1	7801840000396	1	2800	1	0	\N	\N
3784	ATUN LOMITOS AGUA 160GR. ANGELMO	1	7801268002040	1	1600	1	0	\N	\N
3785	ATUN LOMITOS ACEITE 160GR. ANGELMO 	1	7801268002033	1	1600	1	0	\N	\N
3786	SPRIM FRUTILLA 25GR 	1	7802575223456	1	190	1	0	\N	\N
3787	SPRIM NARANJA 25GR. 	1	7802575223524	1	190	1	0	\N	\N
3788	SPRIM PIÑA 25GR.	1	7802575223562	1	190	1	0	\N	\N
1145	VELAS ATACAMA 240 G 	1	7804603464916	1	900	1	0	\N	\N
1338	DELICIAS 	12	610	1	700	1	0	\N	\N
3680	DULCE DE MEMBRILLO MERKAT 250G	1	7804000000915	1	700	1	0	\N	\N
2436	HARINA MERKAT 1KG 	1	7802655000434	1	1000	1	0	\N	\N
1345	PAN DE HUEVO 	12	617	1	600	1	0	\N	\N
3697	CHOCOLATE CRUNCHY CHERRY 140G	1	5900352014517	1	2300	1	0	\N	\N
2114	TARTALETA INDIVIDUAL	12	642	1	1200	1	0	\N	\N
1337	COCADAS 	12	608	1	500	1	0	\N	\N
2841	CHORITOS ACEITE ROBINSON CRUSOE 190G	1	084773611519	1	1700	1	1500	\N	\N
3789	SPRIM FRAMBUESA 25GR. 	1	7802575223418	1	190	1	0	\N	\N
3790	SPRIM MANGO 25GR.	1	7802575223463	1	190	1	0	\N	\N
3791	SPRIM DURAZNO 25GR.	1	7802575223401	1	190	1	0	\N	\N
636	CHANDELLE MANJAR  130 GRS NESTLE	4	7802950572452	1	700	1	0	\N	\N
3769	MANI TOSTADO SALADO 180GR. NO FRITO SEMBRASOL	1	7804612220756	1	1400	1	1300	\N	\N
3792	SPRIM MULTIFRUT 25GR.	1	7802575223517	1	190	1	0	\N	\N
3698	CABLE ADAPTADOR IPHONE AIWA	1	7450078489444	1	9200	1	0	\N	\N
3793	SPRIM MELON TUNA 25GR.	1	7802575223500	1	190	1	0	\N	\N
3794	SPRIM MANZANA 25GR. 	1	2000000001562	1	190	1	0	\N	\N
1347	PAN DE ANIS 	12	624	1	1200	1	0	\N	\N
3683	EMPANADAS DE QUESO 48 UN. 	1	7809612901238	1	3990	1	0	\N	\N
3795	SPRIM MANZANA FUJI	1	7802575222992	1	190	1	0	\N	\N
3696	CHOCOLATE CRUNCHY CARAMEL 140G	1	5900352014494	1	2300	1	0	\N	\N
3703	PACK AMPOLLETAS 70W WESTINGHOUSE 4UN	1	3000721900068	1	2300	1	0	\N	\N
3690	BARRA FRUTILLA NARANJA CHOC. 	1	7803908003127	1	800	1	0	\N	\N
3779	MANJAR CALO 800 GR.	1	7802910006812	1	3450	1	3300	\N	\N
1330	BERLIN 	12	601	1	700	1	0	\N	\N
1335	ALMENDRADO 	12	606	1	600	1	0	\N	\N
3684	COLUN CHOCOLATE 1 LT 	1	7802920007120	1	1760	1	1300	\N	\N
3708	TE MANZANA CANELA SUPREMO 20BL	1	7801875055132	1	1890	1	0	\N	\N
3709	HARINA MAIZ BLANCO JUANA 2 KG 	1	7441000720551	1	4500	1	0	\N	\N
3711	BATIDO DE COCO CHOSH 400ML 	1	7804610400860	1	1700	1	0	\N	\N
3796	PAÑOS HUMEDOS 50 UN. PULLCRO	1	7804620534180	1	5600	1	0	\N	\N
3797	AZUCAR NOVEL 1KG	1	7801850000065	1	950	1	0	\N	\N
3682	VAINILLA MARCO POLO 155ML	1	7802420117381	1	1050	1	0	\N	\N
3693	CONO TROPICAL 106G 	1	7803908005923	1	1590	1	0	\N	\N
3688	BARRA FRUTA FRAMBUESA 66G	1	7803908000829	1	900	1	0	\N	\N
3686	BARRA FRUTA MANGO GUALLARAUCO 66G	1	7803908001314	1	900	1	0	\N	\N
3700	CABLE USB MLAB	1	6927900077748	1	2500	1	0	\N	\N
3701	CABLE USB MLAB 	1	6927900077762	1	2500	1	0	\N	\N
3699	CABLE USB MLAB 	1	6927900077755	1	2500	1	0	\N	\N
1934	NECTAR DURAZNO  1,5 LT ANDINA	38	7802820500035	1	1400	1	0	\N	\N
3691	PULPA FRAMBUESA 333G GUALLARAUCO 	1	7803908000652	1	1950	1	0	\N	\N
3798	JUREL NATURAL 425GR NAVEGANTE	1	7804626880397	1	1300	1	0	\N	\N
3800	KOTEX PROTECTORES SPORT 40UN. 	1	7441008171560	1	2200	1	0	\N	\N
3801	BETUN CAFE 88ML.SAPOLIO 	1	7751851122511	1	950	1	0	\N	\N
687	ESENCIA VAINILLA MARCO POLO 60ML	1	7802420119354	1	400	1	0	\N	\N
702	SAL SELECCION LOBOS 500GR	1	7803600981525	1	1290	1	0	\N	\N
3687	VASO FRUTILLA NARANJA GUALLARAUCO 130G 	1	7803908005954	1	900	1	0	\N	\N
3714	PULPA CHIRIMOYA GUALLARAUCO 333G	1	7803908000362	1	1950	1	0	\N	\N
1143	SURTIDO MARISCOS CALDILLO ARUBA 425G 	1	7801430430367	1	2300	1	0	\N	\N
2831	PILA EVEREADY  AA	1	2000000001333	1	250	1	0	\N	\N
2832	PILA EVEREADY  D	1	2000000001340	1	500	1	0	\N	\N
3704	SAL LOBOS FINA 850G	1	7803600000424	1	2100	1	1800	\N	\N
3799	KOTEX DIA Y NOCHE 15UN. 	1	7809604028266	1	3200	1	2800	\N	\N
3718	RAMITA ORIGINAL 250G	1	7802000014116	1	2000	1	1800	\N	\N
3692	BARRA CHEESECAKE MARACUYA 49G	1	7803908005787	1	850	1	0	\N	\N
3685	VASO CHIRIMOYA GUALLARAUCO 110G	1	7803908005947	1	1000	1	0	\N	\N
3694	CASATA CHEESECAKE MARACUYA 618G 	1	7803908005336	1	4300	1	0	\N	\N
2833	ALOE DRINK SABILA GRANADA 500G	1	857991002045	1	1000	1	0	\N	\N
2834	ALOE DRINK SABILA PIÑA 500ML 	1	857991002076	1	1000	1	0	\N	\N
2835	DELI CHIA SEED DRINK 280ML 	1	850005517092	1	1000	1	0	\N	\N
2836	CHOCOLATE PASCUERO 50G	1	7802215116445	1	1100	1	0	\N	\N
3720	FOSFORO COPIHUE 150UN 	1	7806300010113	1	600	1	0	\N	\N
3722	VELAS ALONDRA 	1	7805007132036	1	600	1	0	\N	\N
3723	ATUN LOMITOS AGUA HOMAR 160G	1	8857122882692	1	1200	1	0	\N	\N
3724	ATUN LOMITO ACEITE HOMAR 160G 	1	8857122882708	1	1700	1	1200	\N	\N
322	PAÑAL HUGGIES M 	2	7809604029409	1	4700	1	0	\N	\N
3726	PANALES HUGGIES M	1	7809604029102	1	4700	1	0	\N	\N
2830	PILAS EVEREADY  AAA	1	2000000001326	1	250	1	0	\N	\N
3713	PIE DE LIMON GUALLARAUCO 94G	1	780390800589	1	1590	1	0	\N	\N
3715	BARRA COCO GUALLARAUCO 57G	1	7803908003110	1	850	1	0	\N	\N
3725	MANTEQUILLA SURLAT 250G	1	7808709500035	1	2100	1	0	\N	\N
738	TE SUPREMO CEYLAN PREMIUM 50UN.	1	7801875001382	1	2400	1	0	\N	\N
3136	JUGO ARCOR NARANJA 20G	1	7790580409456	1	180	1	0	\N	\N
3137	JUGO ARCOR DURAZNO 20G	1	7790580120283	1	180	1	0	\N	\N
3138	JUGO ARCOR FRUTILLA 20G	1	7790580120047	1	180	1	0	\N	\N
3139	JUGO ARCOR PIÑA 20G	1	7790580120214	1	180	1	0	\N	\N
3140	JUGO ARCOR FRUTILLA ZERO 9G	1	7790580409463	1	180	1	0	\N	\N
3141	JUGO ARCOR DURAZNO ZERO 9G	1	7790580409432	1	180	1	0	\N	\N
3648	MILDRED TEA CEYLAN 100 UNDS	1	7801875052056	1	2790	1	0	\N	\N
3143	JUGO ARCOR PIÑA ZERO 9G	1	7790580409449	1	180	1	0	\N	\N
3270	ACEITE VEGETAL 900 ML CRISTAL	1	7802810009586	1	1460	1	0	\N	\N
2842	MAYODELI KRAFT 90G	1	7798146130981	1	750	1	0	\N	\N
1734	LECHE SOPROLE S/D 1L 	1	7802900001292	1	1250	1	1100	\N	\N
1183	BASE CARNE A LA CACEROLA GOURMET 36G 	1	7802410351108	1	730	1	0	\N	\N
715	CEREALES SOBRE CHOCAPIC NESTLE 30GR	6	7613031291441	1	300	1	0	\N	\N
2844	COLUN MANJAR 200ML 	1	7802920777276	1	400	1	0	\N	\N
3716	SUSPIRO LIMEÑO GUALLARAUCO 585G	1	7803908003943	1	4300	1	0	\N	\N
3717	PIE DE LIMON  GUALLARAUCO 584G	1	7803908005329	1	4300	1	0	\N	\N
3142	JUGO ARCOR NARANJA ZERO 9G	1	7790580409364	1	180	1	0	\N	\N
2845	COLUN PLATANO 200ML	1	7802920005782	1	400	1	0	\N	\N
2846	TORTELLINI QUESO 400G	1	7802575040213	1	1800	1	0	\N	\N
3147	HAMBURGUESA DE POLLO 100H	1	7801965000844	1	330	1	0	\N	\N
3271	SCORE ENERGY DRINK 500ML 	1	742832584111	1	1200	1	0	\N	\N
1011	KRYZPO ORIGINAL 260GR	1	7802800534111	1	2700	1	0	\N	\N
3274	LAVALOZAS 650 ML 	1	6971286010738	1	1100	1	0	\N	\N
3272	TANAX SIN OLOR TODO INSECTO 220CC	1	7805300052116	1	2590	1	0	\N	\N
2812	BELCAT ADULTO 1KG	1	7798098846558	1	1850	1	0	\N	\N
2847	VIRUTILLA GRUESA ARUBA 	1	7805027000360	1	600	1	0	\N	\N
1051	CEREAL KIDS ARROZ 20GR	6	7802225690126	1	300	1	0	\N	\N
2694	GUANTES PLASTICOS VIRUTEX 	1	7794321006102	1	990	1	0	\N	\N
3148	DANKY 21 SAVORY PASAS AL RON 125ML	1	7613035407145	1	1590	1	0	\N	\N
3149	MONSTER ULTRA SONRISE	54	070847029205	1	1500	1	0	\N	\N
3150	CHICLE ORBIT MENTA 14G	1	50173204	4	550	1	0	\N	\N
3273	ACEITE PROTAL 900ML 	1	7790070226167	1	1750	1	0	\N	\N
2848	REXONA STAY FRESH BAMBOO150ML 	1	791293036069	1	2100	1	0	\N	\N
30	ARROZ MIRAFLORES LARGO ANCHO GRADO 1,  1 KG. 	1	7802615006551	1	1800	1	1650	\N	\N
2851	COLUN CHOCOLATE 200ML 	1	7802920777214	1	400	1	0	\N	\N
3155	BENEDICTINO C/GAS 2 LTS	75	7802820441802	1	800	1	0	\N	\N
3292	LAYS TA    46 GR EVERCRISP	1	7802000010880	1	600	1	0	\N	\N
880	BEBIDA STARKE MANGO 500ML	5	742832852449	1	1000	1	0	\N	\N
886	LIMONADA LOVE LEMON NARANJADA 475CC	5	7804643820178	1	1200	1	0	\N	\N
2732	CARACOQUESOS CAROZZI 70G 	1	7802575015563	1	850	1	0	\N	\N
2731	CAROZZI ESPIRALES BOLOGNESA 70G	1	7802575015570	1	850	1	0	\N	\N
1312	LECHE ZEROLACTO DESC. 1 LT SOPROLE	21	7802900048013	1	1200	1	0	\N	\N
3146	HAMBURGUESA POLLO 50G	1	7801965000837	1	300	1	200	\N	\N
3145	PAPAS DUQUESAS 500G	1	7804115001715	1	1700	1	1500	\N	\N
3144	PAPAS PRE FRITAS 500G	1	7804115001692	1	1600	1	1300	\N	\N
423	VINAGRE BLANCO TRAVERSO 500 ML 	1	7802337101039	1	900	1	0	\N	\N
4021	YOGHURT LOS ALERCES 1KG	1	7802920001012	1	1200	1	0	\N	\N
1836	YOGHURT BATIDO DAMASCO  120 GR SOPROLE	21	7802900230241	1	250	1	0	\N	\N
2852	POP 500ML 	1	7801620008505	1	600	1	0	\N	\N
885	LIMONADA LOVE LEMON LIGHT 475CC	5	7804643820024	1	1200	1	0	\N	\N
1985	ADES MANZANA 200ML 	38	7790895643743	1	400	1	0	\N	\N
3156	MARUCHAN CAMARON 64 GRS	1	041789001956	1	850	1	0	\N	\N
3157	CANADA DRY LIGHT 2LT DESECHABLE	1	7801620007324	1	1000	1	0	\N	\N
906	TURRON ARCOR 25GR	6	77940131	1	200	1	0	\N	\N
3294	MOGUL ACIDA 	1	7802225406147	1	300	1	200	\N	\N
3295	LADY SOFT 16 UN	1	7790250096139	1	2690	1	1990	\N	\N
866	DULCES ARCOR BUTTER TOFFEES CHOCOLATE 350GR	6	7790580412791	1	2200	1	0	\N	\N
1986	NECTAR DURAZNO  200 ML ANDINA 	38	7802820550504	1	250	1	0	\N	\N
2604	ALWAYS NOCHE ULTRF. 7UN. 	1	7506309893471	1	1950	1	0	\N	\N
1845	MARAVILLAS PREMIUM 25G CAMILA 	1	7804623100146	1	300	1	0	\N	\N
3824	DETERGENTE HIPOALERGENICO GABY 2 LTS	1	7804655190313	1	5400	1	0	\N	\N
2059	PAN DE CEBOLLA 	8	15	2	1800	1	0	\N	\N
868	CHUPETES DOS EN UNO SURTIDO 432GR	6	7802225036672	1	1800	1	0	\N	\N
3158	CHICLE ORBIT EUCALIPTUS	1	50173617	5	550	1	0	\N	\N
1987	NECTAR PIÑA  200 ML ANDINA 	38	7802820700282	1	250	1	0	\N	\N
1988	NECTAR DURAZNO LIGHT ANDINA 200 ML	38	7802820685459	1	250	1	0	\N	\N
2855	MANA VAINILLA 393G	1	7790040720800	1	1500	1	0	\N	\N
2607	LADY SPEED STICK INVISIBLE FLORAL 	1	7509546071909	1	2400	1	0	\N	\N
2814	TRENCITO CRANBERRIES 115G	1	7613037322330	1	1650	1	0	\N	\N
2815	TRENCITO COOKIES 120G	1	7613037279450	1	1650	1	0	\N	\N
3634	MONO BALLS 400G	1	7802215168895	1	2600	1	0	\N	\N
1053	MANI TIPO JAPONES EVERCRISP 100GR	6	7802000010729	1	800	1	0	\N	\N
334	SCOTT DOBLE HOJA 4UN 21MT 	2	7809604028099	1	1100	1	0	\N	\N
2854	PAN HAMBURGUESA 520 GRS	24	7803473215253	4	2500	1	1800	\N	\N
3296	DANKY NOGATONGA 125ML 	1	7613035407176	1	1690	1	1590	\N	\N
1194	SOPA PARA UNO VERDURAS 15G GOURMET 	1	7802410002895	1	400	1	0	\N	\N
1782	RAID MATA ARAÑAS 198G	18	7790520002266	1	2000	1	0	\N	\N
1867	CHOCOLATE TRENCITO  80 GR NESTLE	25	7802230070012	1	1300	1	1100	\N	\N
3161	TEST DE EMBARAZO KINGDOM	74	7804659070017	1	990	1	0	\N	\N
3164	GLOBOS 50 PCS 	1	131300	1	1500	1	0	\N	\N
2737	GARNIER 5.0 	1	7899026462601	1	2000	1	0	\N	\N
2601	NATURELLA NOC. FIBRAS ORGANICAS	1	7506339394719	1	1500	1	0	\N	\N
1853	MANI JAPONES 70G CAMILA 	6	7804623100610	1	1000	1	0	\N	\N
1844	MARAVILLAS PREMIUM 120G CAMILA 	6	7804623100245	1	1000	1	0	\N	\N
2748	NORDIC ZERO 220ML	1	7801610001004	1	500	1	0	\N	\N
1304	MAYONESA HELLMANS SUPREME 372 GR	29	7805000312916	1	2390	1	0	\N	\N
2763	KIDS PAW PATROL 330ML 	1	7804604728499	1	600	1	0	\N	\N
2768	CRI CRI 13.5G	1	7802200124097	1	150	1	0	\N	\N
2856	CHOMP FRAMBUESA A LA CREMA 225G 	1	7613035490734	1	3190	1	0	\N	\N
351	ROCKLETS MANI 35 G 	6	7802225427197	1	450	1	0	\N	\N
3166	PALITO MANZANA 60 ML	62	7802408000537	1	150	1	0	\N	\N
3303	EXPRES COCA ZERO 	1	7801610880159	1	300	1	0	\N	\N
3306	LIMPIADOR PRIMAVERA  900 CC POETT	73	7793253025601	1	1950	1	0	\N	\N
3307	POETT PRIMAVERA 485ML 	1	7805025697524	1	800	1	0	\N	\N
316	COSTANUSS ALMENDRA 160G 	6	7802215121265	1	2100	1	0	\N	\N
2779	CHOCLO GRANO MERKAT 200G	1	7801222055884	1	500	1	0	\N	\N
2761	ARROZ CON LECHE SOPROLE 130 GR	1	7802900221010	1	700	1	0	\N	\N
2760	SEMOLA DAMASCO  140 GR SOPROLE	1	7802900220044	1	600	1	0	\N	\N
2750	BOLSAS IMPEKE 80X110	1	7806810032803	1	1600	1	0	\N	\N
2759	ARROZ CON LECHE Y SALSA DE CARAMELO 130G 	1	7802900001971	1	600	1	0	\N	\N
3597	MASA DE PIZZA 	31	313	1	1000	1	0	\N	\N
2767	BENEDICTINO MANZANA 1.500ML 	1	7802820452129	1	900	1	0	\N	\N
496	CACHANTUN MAS PERA 1600 CC	5	7801620006655	1	1100	1	1050	\N	\N
796	TAMPONES KOTEX SUPER 8UN.	2	7441008154600	1	2600	1	2250	\N	\N
2606	ALWAYS ULTRF. 	1	7501065922755	1	1000	1	1200	\N	\N
4022	GUALLARAUCO CHOCOLATE CONDENSADA 47 G	1	7803908006524	1	850	1	0	\N	\N
2769	MITI MITI FRUTA 100G	1	78022393	1	100	1	0	\N	\N
2781	E LONG DRINK 2000 CC	54	7804604727911	1	2000	1	0	\N	\N
2782	SHAMPOO IO  YOGHURT HUEVO 1000ML 	1	7808975788793	1	1100	1	0	\N	\N
2783	SHAMPOO BEBE IO 1000.ML 	1	7808975781282	1	1100	1	0	\N	\N
2784	SHAMPOO COCO IO 1000ML 	1	7808975785822	1	1100	1	0	\N	\N
2785	SHAMPOO MANZANILLA IO 1000ML 	1	7808975783972	1	1100	1	0	\N	\N
1163	PIZZA A LA PIEDRA VEGETARIANA  425 GR LA ESPAÑOLA	19	7801930012995	1	3100	1	0	\N	\N
2738	GARNIER 7.0 	1	7899026462670	1	2000	1	0	\N	\N
2739	GARNIER 7.1	1	7898587770699	1	2000	1	0	\N	\N
2740	GARNIER 8.0	1	7899026462687	1	2000	1	0	\N	\N
2786	SHAMPOO QUILLAY IO 1000ML 	1	7808975787581	1	1100	1	0	\N	\N
2787	PAÑO SACUDIR STANDAR ARUBA 	1	7804645200022	1	400	1	0	\N	\N
2789	DES.AMB.FRESQUITO ROSAS 360 CC	73	7805300050044	1	1250	1	0	\N	\N
2790	FRESKITO ALGODON DE AZUCAR 360ML 	1	7805300050976	1	1250	1	0	\N	\N
2858	HEIDI DARK SUPREME 95CACAO	1	5941021017101	1	2500	1	0	\N	\N
2788	FOSFOROS 250 UNDS DOÑA GABY	1	7804655190283	1	1200	1	0	\N	\N
2857	YOGETA CARAMELO 320G	1	7702174073165	1	1800	1	0	\N	\N
2134	VASOS POR UNIDAD GRANDES 	1	2000000000992	1	100	1	0	\N	\N
1201	PAÑIELOS NOBLE PACK 6 UN 	1	7806500174516	1	900	1	0	\N	\N
2859	VALOR SIN AZUCAR 70CACAO 100G	1	8410109050882	1	3200	1	0	\N	\N
2861	PILAS AUDIFONO RAYOVAC EXTRA 	1	783094031197	1	300	1	0	\N	\N
2862	PILA GP ALKALINE A76	1	4891199015496	1	150	1	0	\N	\N
2863	PILA CAMALION CR2025	1	873999002139	1	250	1	0	\N	\N
2865	DURAZNOS EN TROCITOS NOVAFRUTA 3050G 	1	7804611550076	1	3990	1	0	\N	\N
3171	MORF NUBES220G	1	7802225280945	1	1690	1	1490	\N	\N
111	AEROSOL FRESKITO LIMON 360 CC 	2	7805300050020	1	1250	1	0	\N	\N
2791	CORONADO 100G	1	7802800512225	1	1290	1	0	\N	\N
2796	 JUREL CHILENO UNICA 200G 	1	7801233000170	1	700	1	0	\N	\N
2797	ARROZ G2 GRANO LARGO 1KG	1	7804643510079	1	700	1	0	\N	\N
867	CHUPETES DOS EN UNO FRUTILLA 432GR	6	7802225036696	1	1800	1	0	\N	\N
3450	LECHUGA ESPAÑOLA	11	2000000001524	1	650	1	0	\N	\N
2019	MANDARINA 	11	136	2	830	1	0	\N	\N
879	BEBIDA STARKE COCO 500ML	5	742832926157	1	1000	1	0	\N	\N
2864	ALOE VERA HONSSY 500ML 	1	858752006890	1	1000	1	0	\N	\N
839	GALLETA GRAN CEREAL AVELLANA 115GR	6	7802225689052	1	650	1	0	\N	\N
936	TIFANYS MANI 22 GR ARCOR	6	7802225427289	1	150	1	0	\N	\N
2799	CHEETOS 120 GRS	1	7802000013676	1	1000	1	0	\N	\N
419	VELAS INVENA 29 GR. 	2	7801815041225	1	700	1	0	\N	\N
921	BIGTIME SEVEN STRAWBERRY 7UN	6	78024021	1	450	1	0	\N	\N
923	BIGTIME ULTRA CLEAN MINT 24GR	6	7794612413848	1	900	1	0	\N	\N
924	BIGTIME ULTRA GREEN MINT 24GR	6	7794612413855	1	900	1	0	\N	\N
62	CARTE DOR BRESLER 105 ML 	7	7805000311438	1	1250	1	0	\N	\N
2866	ATUN LOMITOS ROBINSON CRUSOE 170G	1	7804621471088	1	1450	1	0	\N	\N
2867	ATUN LOMITOS AHUMADO ROBINSON CROUSO 170G	1	7804621471095	1	1450	1	0	\N	\N
1206	CLORO TRADICIONAL MASTER CLORO 5 LITROS 	1	945127024	1	3000	1	0	\N	\N
1218	CHOCOLATE CAPRI FRUTILLA 30G 	1	7613034279309	1	250	1	0	\N	\N
2868	MAYONESA JB 380G	1	7803200804149	1	1500	1	0	\N	\N
2869	MAYONESA  670 GR HELLMANNS	1	7805000312329	1	2000	1	0	\N	\N
2870	HARINA TOSTADA 	11	138	2	1000	1	0	\N	\N
2076	KENT ONE 20	55	78021051	1	4000	1	0	\N	\N
2699	BASTONES CARAMELO FRUT. 144 GR	1	5024222042261	1	1590	1	0	\N	\N
850	MARSHMALLOW MOGUL MORF 120GR	6	7802225280655	1	750	1	0	\N	\N
985	CARAMELO ARBOLITO AMBROSOLI UND	6	223	1	100	1	0	\N	\N
899	GOMITA FRUGELE UNIDAD	6	203	1	100	1	0	\N	\N
940	LANGUETAZO ARCOR NARANJA 13GR	6	7802225212519	1	100	1	0	\N	\N
308	NIK OBLEA BOCADO 71 G 	6	7802215504655	1	450	1	0	\N	\N
734	TE HOJAS EMBLEM BLACK 230GR	1	7805000314774	1	1650	1	0	\N	\N
964	CEREAL KIDS HUESITOS 330GR	1	7802225690034	1	2000	1	0	\N	\N
353	ROLLS NUTS 170 G 	6	7802215121234	1	1700	1	0	\N	\N
2798	LOLLYPOP SAVORY ORIGINAL 	1	78006027	1	690	1	0	\N	\N
2613	BARRITA COSTANUSS 30GRS	1	78030206	1	400	1	0	\N	\N
221	ILICIT COLOR RUBIO OSCURO CENIZA 6.1	2	7804923031454	1	2000	1	0	\N	\N
2872	HEAD Y SHOULDERS 180ML 	1	7500435125161	1	1500	1	0	\N	\N
2873	HEAD Y SHOULDERS ALIVIO REFRESC. 180ML 	1	7500435020077	1	1500	1	0	\N	\N
2874	COSTILLAR AHUMADO RA 59KG 	1	C35468485	1	5031	1	0	\N	\N
2875	COSTILLAR AHUMADO RA 52KG 	1	C35468426	1	4429	1	0	\N	\N
2876	COSTILLAR AHUMADO 66KG 	1	C35468479	1	5719	1	0	\N	\N
2877	COSTILLAR AHUMADO 38KG 	1	C35468417	1	4558	1	0	\N	\N
2871	HEAD Y SHOULDER LIMPIEZA RENOVADORA 180 ML	1	7500435019958	1	1650	1	0	\N	\N
2698	CHOCOLATE PASCUERO AMBROSOLI	1	7802200848429	1	1500	1	0	\N	\N
2878	COSTILLAR AHUMADO 51KG 	1	C35468424	1	4429	1	0	\N	\N
2879	COSTILLAR AHUMADO 44KG	1	C35468490	1	3784	1	0	\N	\N
2259	ROCKLETS MANI 130G 	1	7802225590136	1	1100	1	0	\N	\N
2260	ARCOR LECHE 100G	1	7802225590143	1	1000	1	0	\N	\N
926	BON O BON 1 UNIDAD ARCOR	6	78023994	1	150	1	0	\N	\N
2610	CHICLE ORBIT ARANDANO 14G	1	42123880	5	550	1	0	\N	\N
2074	LUCKY DOBLE CLICK LIMON 20 UN	55	78021266	1	4300	1	0	\N	\N
1033	JUGO SPRIM NARANJA MIX CHIRIMOYA 35GR	1	P012	1	190	1	0	\N	\N
2089	CONO CHICO SOFT	6	2000000000978	1	700	1	0	\N	\N
2325	GELATINA FRAMBUESA 100 GR AMBROSOLI.	67	7802200361072	1	680	1	0	\N	\N
1459	LECHUGON 	11	2000000000411	1	650	1	0	\N	\N
2327	LIGHT STEVIA SOPROLE 155G	1	7802900002176	1	400	1	0	\N	\N
2328	LIGHT BATIDO STEVIA SOPROLE 155G 	1	7802900002190	1	400	1	0	\N	\N
2329	LONCO LECHE S/LAC. 200ML 	1	7802910000797	1	450	1	0	\N	\N
2331	CHOCOLATE RAMA  115 GR COSTA	25	7802215104855	1	1750	1	0	\N	\N
206	ILICIT COLOR CASTAÑO CLARO 5.0	2	7804923031287	1	2000	1	0	\N	\N
3329	NECTAR SPRIM PIÑA 190 ML	1	7802575220141	1	250	1	0	\N	\N
813	SCOTT DOBLE HOJA ESENCIAS 4 ROLLOS 	2	7809604029379	1	1650	1	0	\N	\N
2045	ACEITE TRAVERSO VEGETAL 900CC	1	7802337960018	1	1150	1	0	\N	\N
3188	MORF TRENZ 30G	1	7802225281003	1	250	1	0	\N	\N
2800	PAN DE PASCUA NUTRABIEN 500GR	1	7803525400422	1	2000	1	0	\N	\N
3321	JABON LIQUIDO MANZANA Y MIEL  1 LT BALLERINA	73	7804920002778	1	1400	1	0	\N	\N
3330	SPRIM MANZANA 190 ML	1	7802575220196	1	300	1	250	\N	\N
826	POETT PRIMAVERA 250 CC	2	7805025688362	1	620	1	0	\N	\N
1444	MANTEQUILLA SURLAT 125 GR	21	7808709500028	1	800	1	0	\N	\N
581	FLAN DAILY SABOR VAINILLA 20GR	1	7809558102500	1	600	1	0	\N	\N
2258	NIKOLO XL 100G	1	7802225538046	1	1100	1	0	\N	\N
2090	GRILL MERKEN MCKAY	1	7613036468299	1	300	1	0	\N	\N
883	COTONITOS CHIKOOL 200UN	2	6920180302111	1	990	1	0	\N	\N
2323	CHARLOT VAINILLA 1 LITRO	1	7802710566219	1	3000	1	0	\N	\N
2048	NUGGETS DE POLLO 400G	7	7801930008363	1	1700	1	0	\N	\N
2022	LECHUGA LANGOSTINA	11	137	1	650	1	0	\N	\N
2608	LADY SPEED STICK ACTIVE FRESH 	1	7509546063485	1	2500	1	0	\N	\N
2609	ENCEDEDOR CLIPPER	74	8412765508905	1	700	1	0	\N	\N
2883	TRENCITO COLORES 125G	1	7613037279290	1	1650	1	0	\N	\N
2884	CASATA PANDA TRISABOR 2.5 LT 	1	7801552000141	1	3500	1	0	\N	\N
3829	DESODORANTE BIOGARNIER 	1	7509552913743	1	2500	1	0	\N	\N
2886	CASATA PIÑA 2.5LT 	1	7801552000271	1	3500	1	0	\N	\N
2887	CREMA BRAVO 1 LT 	1	8003180003399	1	2550	1	0	\N	\N
3192	KEM RETORNABLE  2 LT CCU	75	7801620350192	1	1350	1	0	\N	\N
3194	VINAGRE MANZANA DON JUAN 500ML	1	7802351000585	1	1300	1	0	\N	\N
3331	FITCOCO PIÑA 500ML	1	857501005672	1	1100	1	0	\N	\N
3332	FITCOCO MANGO 500ML	1	857501005689	1	1100	1	0	\N	\N
3315	ATUN DESMENUZADO AL AGUA  120 GR COLISEO	1	7804608220074	1	900	1	0	\N	\N
3314	ATUN DESMENUZADO AL ACEITE COLISEO	1	7804608220067	1	900	1	0	\N	\N
2885	CASATA PANDA TRISABOR 2.5 LT 	1	7801552000356	1	3500	1	0	\N	\N
3335	CLORO GEL MENTA RELUXE 1 LT 	1	7812090001149	1	1100	1	0	\N	\N
3334	ELITE MAXIROLLO 2 ROLLOS	1	7806500403876	1	2500	1	0	\N	\N
2072	LUCKY STRIKE ROJO 20	55	78000124	1	4400	1	4200	\N	\N
2049	ARIEL 800G DOWNY	2	7500435111287	1	2300	1	2100	\N	\N
2330	GALLETA MINI LIMON MCKAY 40 GR	26	7613031650729	1	300	1	0	\N	\N
766	GALLETA ROCKLETS CHOCOLATE 165GR	6	7802225688765	1	990	1	0	\N	\N
4023	PIE DE LIMON GUALLARAUCO 94 G	1	7803908005893	1	1590	1	0	\N	\N
3193	HELADO BRESLER CREMISSIMO TRISABOR 1 LT	62	7805000305260	1	2990	1	2390	\N	\N
1162	PIZZA A LA PIEDRA CHORIZO  425 GR LA ESPAÑOLA	19	7801930012971	1	3100	1	0	\N	\N
1938	NECTAR NARANJA  1,5 LT ANDINA	38	7802820700053	1	1400	1	0	\N	\N
458	LENTEJA  1 KG BONANZA	1	7808743600500	1	2200	1	1450	\N	\N
106	CONFORT ALM. 40 METROS 1 UNIDAD 	2	7806500505440	1	360	1	0	\N	\N
968	NESCAFE SOBRE 1.8GR	1	214	1	100	1	0	\N	\N
643	YOGURTH NATURAL N. LIGHT 120GR	4	7613037035544	1	350	1	0	\N	\N
911	CEREAL KIDS CARITAS 25GR	6	7802225690096	1	300	1	0	\N	\N
1876	MARSHMALLOWS 600 GR FRUNA	46	7802408003972	1	1500	1	0	\N	\N
2888	IDEAL FRUTOS SECOS PAN DE PASCUA 700G	1	7803403295867	1	4000	1	0	\N	\N
3195	KENT CLICK 20 UNDS	55	78022126	1	4200	1	0	\N	\N
3429	MANJAR COLUN 500ML	1	7802920221366	1	1800	1	0	\N	\N
1066	RAMITAS ORIGINAL EVERCRISP 270GR	6	7802000002762	1	1700	1	0	\N	\N
752	TE AROMA CEYLAN 100UN.	1	7801875200334	1	1900	1	0	\N	\N
545	LIMON SODA DES.ZERO 2 LTS B	5	7801620007980	1	1300	1	0	\N	\N
1031	SEVEN UP DES.2 LTS	5	7801620016203	1	1000	1	0	\N	\N
141	FIDEO LUCCHETTI ESPIRALES 400 GRAMOS 	1	7802500001081	1	1300	1	800	\N	\N
760	GALLETA DOS EN UNO VINO 160GR	6	7802225632607	1	650	1	0	\N	\N
1118	MARRAQUETA	8	2	2	1890	1	1450	\N	\N
2238	ANDINA DEL VALLE KIWI 1.5L	1	7802820559002	1	1400	1	0	\N	\N
3191	CACHANTUN MAS UVA 1,6 LT	75	7801620006648	1	1100	1	1050	\N	\N
428	LIMPIADOR WYN CREMA 500 ML 	2	7804609730459	1	1650	1	1450	\N	\N
537	PEPSI DES.2 LTS	5	7801620014681	1	1200	1	1000	\N	\N
17	ANTIBAC DESINF. ORIGINAL 220 CC 	2	7805300052062	1	1850	1	1300	\N	\N
119	BIO FRESCURA BOSQUE NATIVO 400 GRAMOS 	2	7804609730114	1	1100	1	750	\N	\N
625	YOGURTH NESTLE DAMASCO 115GR	4	7613036466714	1	300	1	250	\N	\N
310	NIK OBLEA LIMON 71G 	6	7802215504679	1	500	1	450	\N	\N
1018	KRYZPO CEBOLLA 40GR	1	7802800535583	1	700	1	0	\N	\N
2612	CROCANTY 90ML	1	78006140	1	700	1	0	\N	\N
2611	MEGA FRAMBUESA 90ML 	1	7613035807464	1	1690	1	1590	\N	\N
627	YOGURTH NESTLE PIÑA 115GR	4	7613036467209	1	250	1	0	\N	\N
10	ACONDICIONADOR FRUCTIS OIL REPAIR LISO COCO 350 ML 	2	7509552816273	1	2500	1	0	\N	\N
651	NESCAFE VAINILLA 18,5 GR	1	7613033458538	1	500	1	400	\N	\N
342	POROTOS NEGROS WASIL 380 G 	1	7801305004099	1	1300	1	0	\N	\N
571	WATTS TUTTIPAPAYA  1,5 LTS WATTS	5	7801620167721	1	1350	1	0	\N	\N
2683	PASTA SABOR POLLO  85 GR MAGGI	1	7891000093016	1	650	1	0	\N	\N
400	SURTIDO DE MARISCOS EN AGUA ANGELMO 190 GRAMOS 	1	7801250000801	1	1200	1	0	\N	\N
247	SPRIM NARANJA PLATANO 25GR.	1	7802575223098	1	190	1	0	\N	\N
1868	SAHNENUSS  100 GR NESTLE	46	7613034721082	1	1500	1	0	\N	\N
2335	CHORIZO SUREÑO PREMIUM 250G 	1	7801907014298	1	1100	1	0	\N	\N
2338	NUTELLA 200G	1	80135463	1	3780	1	0	\N	\N
859	DULCES ARCOR RELLENOS FRUTALES 500GR	6	7757174006095	1	1990	1	0	\N	\N
29	AMPOLLETAS PHLIPS 70 W 	1	8718699591168	1	650	1	0	\N	\N
27	AMPOLLETA PHILIPS 42 W 	1	8718699591137	1	650	1	0	\N	\N
2131	VELAS CUMPLEAÑOS HAPPY BIRTHDAY	1	9328567891369	1	600	1	0	\N	\N
39	ARVERJAS EN CONSERVA WASIL 340 G 	1	7801305003658	1	1300	1	0	\N	\N
812	CONFORT 4 ROLLOS 50M.	2	7806500505815	1	1600	1	0	\N	\N
768	GALLETA CEREAL MIX CIRUELA 115GR	6	7802225689069	1	650	1	0	\N	\N
296	MARUCHAN QUESO 64 GRAMOS 	1	041789001833	1	850	1	0	\N	\N
295	MARUCHAN POLLO 64 GRAMOS 	1	041789001918	1	700	1	0	\N	\N
1098	GALLETAS ARROZ CON LENTEJAS SELZ 85	6	7802225682275	1	1300	1	0	\N	\N
1880	RUCAS SELECT CRUJIENTES QUESO	1	6917554956223	1	950	1	0	\N	\N
70	CHAMPIÑONES ENTEROS 184GR. ESMERALDA	1	7801315140008	1	1800	1	800	\N	\N
575	WATTS NARANJA 1,5 LTS	5	7801620011604	1	1500	1	1350	\N	\N
127	OMO MATIC SOFT ALOE VERA 400 G	2	7805000313616	1	1250	1	1200	\N	\N
121	BIO FRESCURA CAMPOS DE HIELO 800G	2	7804609730534	1	1900	1	1300	\N	\N
271	LADYSOFT N. SUAVE CON ALAS 8UN.	2	7790250096085	1	790	1	750	\N	\N
1241	GALLETA TRITON CHOCOLATE  126 GR MCKAY	26	7802230086969	1	700	1	0	\N	\N
2339	FERRERO ROCHER 37.5G 	1	78909434	1	1690	1	1590	\N	\N
555	KEM ZERO 3 LTS DESECHABLE	5	7801620005290	1	1950	1	0	\N	\N
2340	BARRAS COLACION QUAKER FRUTILLA 20G	1	7802000004018	1	250	1	0	\N	\N
2617	GILLETTE ULTRAGRIP2	1	7501009222729	1	850	1	0	\N	\N
2054	SCHICK XTREME 3 HAWAIIAN TROPIC	57	7591066711014	1	1000	1	0	\N	\N
1641	CONO GRANDE DOBLE 	6	2000000000886	1	2400	1	0	\N	\N
669	CHOCLITOS COCKTAIL MISTRAL 410GR	1	6901009484201	1	1560	1	0	\N	\N
191	GELATINA AMBROSOLI FRAMBUESA	1	7802200363991	1	400	1	0	\N	\N
1887	SUSTANCIA 38 GR FRUNA	46	7802408002722	1	150	1	0	\N	\N
1890	GALLETA VAINILLA BOLSA  850 GRS FRUNA	26	7802408019140	1	1650	1	0	\N	\N
1891	GALLETA PEPA COCO  1 KILO FRUNA	26	7802408000858	1	1650	1	0	\N	\N
15	ANTIBAC DESINF.BEBÉ 220 CC 	2	7805300052024	1	1300	1	0	\N	\N
732	CAFE GOLD TARRO PRIMERA SEL. 100GR	1	7802800500628	1	3300	1	3000	\N	\N
2890	PAPAS DUQUESA   500 GR FRUTOS DEL MAIPO	7	7801300101014	1	1100	1	0	\N	\N
1896	GALLETA CREMONA FRUTILLA 160GR	26	7802408005303	1	450	1	0	\N	\N
403	TE CLUB ORIGINAL 20 UN. 	1	7805000306533	1	700	1	0	\N	\N
3254	VELA GRANDE 4 UNDS GOÑA GABY	73	7804655190108	1	900	1	0	\N	\N
402	TE CLUB ETIQUETA ROJA 20 UN. 	1	7805000311629	1	700	1	0	\N	\N
2615	TORTA HOJA 20 P	12	658	2	22000	1	0	\N	\N
388	SHIP ZERO FRUTAL 3 LITROS 	5	7801608000330	1	800	1	0	\N	\N
390	SHIP ZERO LIMA LIMON 3 LITROS 	5	7804604725269	1	800	1	0	\N	\N
373	SHAMPOO FRUCTIS OIL REPAIR 3 350 ML 	2	7501839100877	1	2200	1	0	\N	\N
357	POMAROLA CAROZZI  200 GRAMOS 	1	7802575353047	1	450	1	0	\N	\N
1846	PISTACHOS SALADOS 40G CAMILA 	6	7804623100184	1	1350	1	0	\N	\N
1885	GALLETA CARIOCA  64 GR FRUNA	26	7802408015081	1	300	1	200	\N	\N
536	PEPSI DESECHABLE 3 LT	5	7801620017552	1	2000	1	1950	\N	\N
1883	GALLETA SERRANITA  64 GR FRUNA	26	7802408015241	1	300	1	200	\N	\N
2343	TORTAZO CHOC  70 GR FRUNA	46	7802408002401	1	380	1	0	\N	\N
2341	TORTA SELVA NEGRA  60 GR FRUNA	46	7802408002425	1	380	1	0	\N	\N
1888	GALLETA COCO  200 GR FRUNA	26	7802408003460	1	650	1	500	\N	\N
408	TE SUPREMO LA RENDIDORA 20 UN. 	1	7801875032010	1	500	1	0	\N	\N
406	TE SUPREMO GOLDEN CEYLON 20 UN. 	1	7801875047014	1	1100	1	0	\N	\N
1688	TOALLA REGIO MAXIMA 100MT	1	742832833615	1	3300	1	0	\N	\N
20	AJI DON JUAN 100 GRAMOS 	1	7802351221003	1	400	1	0	\N	\N
2616	GILLETTE ULTRAGRIP3	1	7500435011303	1	950	1	0	\N	\N
2619	BRAVO CREM 200ML 	1	8003180908403	1	900	1	0	\N	\N
2620	OREO FRESA 126G 	1	7622210828453	1	600	1	0	\N	\N
2621	OREO ORIGINAL 126G	1	7622210661982	1	600	1	0	\N	\N
1903	COCA COLA EXPRESS 237CC 	1	8002	1	300	1	0	\N	\N
1905	QUATRO LIGHT 237ML EXPRESS	1	8003	1	300	1	0	\N	\N
1914	NORDIC MIST ZERO 2 LT 	50	7801610271612	1	1000	1	0	\N	\N
1906	SPRITE RETORNABLE 2,5 LT	48	7801610355602	1	1750	1	0	\N	\N
1916	FANTA RETORNABLE 2,5 LT	48	7801610352502	1	1750	1	0	\N	\N
2622	GRANOLA QUAKER 380G	1	7802000011320	1	2200	1	0	\N	\N
3830	VELAS ECONOMICA  4 UNDS DOÑA GABY	73	7804655190115	1	600	1	0	\N	\N
1909	SPRITE RETORNABLE 2 LT	50	7801610005286	1	1000	1	0	\N	\N
21	ALFAJOR CLASSIC 35 G 	6	7802220176403	1	350	1	0	\N	\N
903	DULCE COSTA CAREZZA UNIDAD	6	207	1	0	1	0	\N	\N
2101	GRILL CLASICA 140G 	1	7613037042290	1	950	1	0	\N	\N
1859	TALLARINES 87  400 GRS DON VITTORIO	10	7750243286152	1	600	1	0	\N	\N
3211	POLLO CROCANTE 100 GRS	7	7809611706973	1	350	1	0	\N	\N
1921	COCA COLA VIDRIO 1 LT	48	7801610001042	1	900	1	0	\N	\N
1618	CHARLOT TRES LECHES 1 LITRO SAVORY 	6	7613031628964	1	3000	1	0	\N	\N
1911	COCA COLA RETORNABLE 2 LT	50	7801610001295	1	1300	1	1500	\N	\N
1907	COCA COLA RETORNABLE 2,5 LT	48	7801610250006	1	1800	1	1800	\N	\N
1922	COCA ZERO VIDRIO  1 LT	48	7801610350980	1	900	1	0	\N	\N
1910	FANTA RETORNABLE 2 LT	50	7801610002285	1	1300	1	1000	\N	\N
2345	PEPSI CERO 350 ML 	1	7801620006846	1	700	1	650	\N	\N
1898	CUBANITO 50 GR FRUNA	46	7802408084292	1	300	1	200	\N	\N
2618	GALLETA COCO CHIP  64 GR FRUNA	1	7802408017054	1	300	1	200	\N	\N
3641	MARCO POLO RUSTICA QUESO Y OREGANO 200G	1	7802420002380	1	2000	1	0	\N	\N
1857	CRAKER 321GRS 	1	7802225683296	1	1500	1	0	\N	\N
3365	TRAPERO EXCELL 12 UN. 	1	7805020001555	1	2300	1	0	\N	\N
1884	GALLETA COCO 750 GR FRUNA	26	7802408000810	1	1500	1	0	\N	\N
1889	RUN RUN VAINILLA  500 GR FRUNA	6	7802408002302	1	1450	1	0	\N	\N
1931	SUNY CALAF 	1	7802220721405	1	50	1	0	\N	\N
1744	YOGHURT GRIEGO TROZOS DURAZNO 110 GRS	21	7802900231835	4	400	1	0	\N	\N
2344	CARIOCA CHOCOLATE 	1	7802408005129	1	200	1	0	\N	\N
2347	LECHE CULTIVADA 180 ML 	1	7802920005164	1	450	1	0	\N	\N
1644	BOLITAS DE QUESO GAUDA 300G RECETA DEL ABUELO	20	7801930015125	1	2000	1	0	\N	\N
2897	PANTENE LISO EXTREMO 400ML 	1	7501001165253	1	2800	1	0	\N	\N
11	ACOND.PANTENE FZA. Y RECONS. 400 ML 	2	7500435020299	1	2800	1	0	\N	\N
13	ACOND. PANTENE HIDR. EXTREMA 400 ML 	2	7506309840581	1	2800	1	0	\N	\N
2899	HEAD SHOULDERS NUTRICION PROFUNDA 375ML 	1	7500435019620	1	3600	1	0	\N	\N
1899	GALLETA CREMONA LIMON 160 GR	26	7802408005327	1	450	1	0	\N	\N
1656	ADAPTADOR 3 ENCHUFES	35	7895623021623	1	1000	1	0	\N	\N
1912	SPRITE RETORNABLE 3 LT	49	7801610333525	1	2000	1	0	\N	\N
4335	LECHE CULTIVADA SOPROLE 1  LT 	1	7802900170134	1	1900	1	0	\N	\N
1850	MARAVILLAS JUMBO 230G 	6	7804623100344	1	1400	1	0	\N	\N
1877	RUCAS SELECT TIRANGULOS BBQ	1	6917554956247	1	1100	1	0	\N	\N
689	POLVOS DE HORNEAR ROYAL 100GR	1	7702054088401	1	700	1	0	\N	\N
1758	DURAZNO MITADES DOS CABALLOS 425GRS	1	7801380101324	1	1200	1	0	\N	\N
1917	NESQUIK 18GRS VAINILLA NESTLE	1	7613036838160	1	1400	1	0	\N	\N
37	TUCAPEL PREGRANEADO G1 500G	1	7801420000914	1	900	1	800	\N	\N
36	TUCAPEL GRAN SELECCION G2 500 G 	1	7801420220145	1	800	1	0	\N	\N
1693	SALSA BBQ 270G MARCO POLO	1	7802420003578	1	1300	1	0	\N	\N
5368	MUIBON LECHE 12 GRS	1	7802800556113	1	200	1	0	\N	\N
1694	AJI CREMA 240G DON JUAN	1	7802351234607	1	1100	1	0	\N	\N
1920	FANTA VIDRIO 1 LT	48	7801610002049	1	1000	1	900	\N	\N
2346	NORDIC MIST AGUA TONICA  1,5 L COCACOLA	48	7801610020265	3	1600	1	0	\N	\N
178	GALLETAS GRAN CEREAL MUESLI 135 G 	6	7802215302060	1	750	1	0	\N	\N
176	GALLETAS GRAN CEREAL CACAO 135 G 	6	7802215303241	1	750	1	0	\N	\N
177	GALLETAS GRAN CEREAL CLASICA 135 G 	6	7802215302053	1	750	1	0	\N	\N
1646	HAMB. DE SOYA MISTER VEGGIE 100G PF	20	7801930009254	1	600	1	0	\N	\N
1645	SUPREMA DE POLLO JAMON QUESO 120G  RECETA DEL ABUELO	20	7801930013985	1	700	1	0	\N	\N
1745	YOGHURT BATIDO VAINILLA  120 GR SOPROLE	21	7802900230258	1	250	1	0	\N	\N
1743	YOGHURT FRAMBUESA  120 GR SOPROLE	21	7802900230289	1	250	1	0	\N	\N
180	GALLETAS LIMON MINI 35 G 	6	7802215503863	1	250	1	0	\N	\N
181	GALLETAS MANTEQUILLA MINI 40 G 	6	7802215516191	1	250	1	0	\N	\N
185	GALLETAS OBSESIÓN CREMA CHOCOLATE MENTA 85 G 	6	7802215514326	1	1000	1	0	\N	\N
1146	LIMPIADOR PISO FLOTANTE FRUTOS DEL BOSQUE  900 CC EXCELL	18	7805020001289	1	1700	1	0	\N	\N
1149	LUSTRA MUEBLES LIMON 5X1 280ML INTRA PREMIO	1	7751851011129	1	990	1	0	\N	\N
1013	KRYZPO CEBOLLA 140GR	1	7802800533589	1	1700	1	0	\N	\N
1964	VITAL S/GAS 990ML 	53	7802820990102	1	1000	1	0	\N	\N
1283	MERMELADA 250G FRUTAS DEL SUR WATTS 	1	7802810005632	1	1000	1	0	\N	\N
586	SALSA CHAMPIÑON  45 GR MAGGI	1	7613031571529	1	690	1	0	\N	\N
4337	HARINA TOSTADA 1KG	1	2500138010004	1	1000	1	0	\N	\N
1975	SPRITE LATA 220 ML	48	7801610220078	1	600	1	0	\N	\N
1971	COCA COLA LATA LIGHT 220 ML	48	7801610220207	1	450	1	0	\N	\N
4381	LA CREMERIA LUCUMA MANJAR 1 LT 	1	7613036568869	1	3900	1	0	\N	\N
1152	LIMPIADOR PISO FLOTANTE LAVANDA  900 CC EXCELL	18	7805020010007	1	2990	1	0	\N	\N
3670	LIMPIA VIDRIOS SAPOLIO 650 ML	1	7751851559300	1	1600	1	0	\N	\N
3671	CHANCACA DELICIOSA 400G 	1	7805040004765	1	2790	1	2100	\N	\N
2829	DESODORANTE INVISIBLE BARRA  45 GR LADY SPEED STICK	73	7501035908925	1	2490	1	0	\N	\N
2828	SPEED STICK HIPOALERGENICO 50 GR	73	7501035907591	1	2690	1	0	\N	\N
1962	AQUARIUS PERA 500 CC	53	7801610481011	1	750	1	0	\N	\N
2804	YOGHURT PIÑA 125 GR ALERCES	1	7802920106052	4	200	1	0	\N	\N
1135	VINAGRE MANZANA 250 ML TRAVERSO 	1	7802356000009	1	700	1	0	\N	\N
1969	COCA COLA ZERO LATA 350 ML	48	7801610350355	1	700	1	0	\N	\N
1959	VITAL C/GAS 600 ML	53	7802820600100	1	500	1	600	\N	\N
173	GALLETAS DULCITAS MINI 40 G 	6	7802215516221	1	300	1	250	\N	\N
1731	CACAO DULCE MARCO POLO 200GRS	1	07802420119286	1	1200	1	0	\N	\N
1732	LECHE SURLAT SEMIDESCREMADA S/L 1L	1	7808709500790	1	1400	1	0	\N	\N
3123	PREPIZZA 2/3MTS 500G TOQUES CEBOLLA IDEAL	1	7803403002977	1	1000	1	0	\N	\N
1153	SAPOLIO MATA MOSCAS Y ZANCUDOS 360 ML 	1	7751851006620	1	2500	1	0	\N	\N
2805	YOGHURT DAMASCO 125 GR ALERCES	1	7802920106045	4	200	1	0	\N	\N
1147	LUSTRA MUEBLES LAVANDA 250CC EXCELL 	1	7805020000237	1	1200	1	0	\N	\N
2838	LENTEJAS DALMACEN 1KG	1	7804167002029	1	1250	1	0	\N	\N
3124	CEREJA 55G	1	7896079820518	1	1200	1	0	\N	\N
3125	TUBIN CHOCOLATE 48G	1	7896079846525	1	550	1	0	\N	\N
3126	BRIGADEIRO 55G	1	7896079828514	1	1200	1	0	\N	\N
3127	GLADE MANZANA CANELA 275CM3	1	7501032923990	1	1350	1	0	\N	\N
3128	GLADE CAMPOS DE LAVANDA 275CM3	1	7501032924003	1	1350	1	0	\N	\N
2916	LIMON Y NADA 500 CC 	75	7801610282014	1	900	1	0	\N	\N
2911	KEM PIÑA-MARACUYA 500ML 	1	7801620008451	1	800	1	0	\N	\N
1313	ACEITE VEGETAL MERKAT 900ML 	1	7808743601934	1	1400	1	0	\N	\N
3373	HUEVITOS BOLSA PRIVILEGIO 18U	1	7802225575065	1	2500	1	0	\N	\N
3129	TUBIN TRUFAS 48G	1	7896079846129	1	550	1	0	\N	\N
3130	TUBIN NAPOLITANO 48G	1	7896079846747	1	550	1	0	\N	\N
3131	CRUZEIRO CLASICO 100G	1	7896019206631	1	3000	1	0	\N	\N
3132	LYSOFORM ORIGINAL 285CM3	1	7790520990648	1	2790	1	0	\N	\N
3133	DESINFECTANTE ORIGINAL  235 CC LYSOFORM	73	7790520003270	1	2100	1	0	\N	\N
3134	YERBA MATE BRASIL 500G	1	7801875065025	1	3350	1	0	\N	\N
3268	CONO GRANDE SOFT 	1	2000000001470	1	1000	1	0	\N	\N
2693	PIMIENTA NEGRA MOLIDA 15G	1	7802420810176	1	450	1	0	\N	\N
1666	CHUCHOCA A GRANEL 	11	133	2	2000	1	0	\N	\N
3215	GUALLARAUCO FRAMBUESA 250L	1	7803908002083	1	1000	1	0	\N	\N
2910	QUESILLO ACHIBUENO CUADRADO 	12	1357	1	3950	1	3700	\N	\N
2692	PIMIENTA BLANCA MOLIDA 15G	1	7802420810152	1	550	1	0	\N	\N
4352	JABON BALLERINA 350 ML 	1	7804920230225	1	1200	1	900	\N	\N
1733	LECHE SOPROLE PROTEIN CON CACAO 1L	1	7802900001421	1	1900	1	1550	\N	\N
1005	JUGO LIVEAN BERRIES 7GR	1	P007	1	200	1	0	\N	\N
1176	QUESO MOZZARELLA LAMINADO COLUN 250G 	1	7802920007953	1	1750	1	0	\N	\N
633	SEMOLA BERRIES NESTLE 135GR	4	7613035953215	1	550	1	0	\N	\N
1050	ALFAJOR ARCOR BON O BON BLANCO 40GR	6	7790040613607	1	400	1	0	\N	\N
3153	CHANDELLE MARACUYA SIN LACTOSA 130G	1	7613038442112	1	700	1	0	\N	\N
3276	RAYITA MARINELA FRUTILLA 60G	1	7803473004277	1	300	1	0	\N	\N
4025	MARSH MALLOOWS250G	1	7802200130135	1	1550	1	0	\N	\N
3279	AQUARIUS LIMONADA 1.6 LTS	75	7801610461020	1	950	1	0	\N	\N
3280	VINAGRE MANZANA TRAVERSO 1LT 	1	7802337105617	1	3350	1	0	\N	\N
3284	ALFAKILL TODO INSECTO 360 CC	1	7805300051157	1	1500	1	0	\N	\N
3828	TOALLAS HUMEDAS HUGGIES 48 PCS	1	7702425800700	1	1400	1	0	\N	\N
3285	NIKOLO NARANJA 27G	1	7802225538077	1	300	1	0	\N	\N
3286	HEAD SHOULDERS 375 ML 	1	7500435019880	1	3600	1	0	\N	\N
3287	HEAD SHOULDERS MEN 375ML 	1	7500435019545	1	3600	1	0	\N	\N
2919	BABY LEE JABON NEUTRO 900ML 	1	7804920001221	1	1450	1	0	\N	\N
2924	PIÑAS RODAJAS DEYCO 565G 	1	7801534003177	1	1300	1	0	\N	\N
2925	CLOROGEL LIMON IMPEKE 500ML 	1	7806810056472	1	850	1	0	\N	\N
98	CLORO GEL IMPEKE TRADIC. 500 ML 	2	7806810056489	1	850	1	0	\N	\N
3217	AJI CHILENO CREMA DON JUAN 250G	1	7802351000059	1	680	1	0	\N	\N
3218	QUESO LAS PRADERAS DE OSORNO MANTECOSO 250G	1	7804647450289	1	2050	1	0	\N	\N
3216	AJI MERKEN DON JUAN 240G	1	7802351241032	1	1300	1	0	\N	\N
3220	PEPSI ZERO 500ML	1	7801620006853	1	900	1	0	\N	\N
2921	CERA CREMA CAOBA  340 CC NUGGET	73	7805010001510	1	1650	1	1400	\N	\N
209	ILICIT COLOR CIRUELA 5.20	2	7804923031379	1	2150	1	2000	\N	\N
3278	PAN PITA BLANCO  300 GR IDEAL	24	7803473000767	1	1350	1	1100	\N	\N
2923	SNACK MIX MARCOPOLO  320G	1	7802420001550	1	2500	1	0	\N	\N
4024	RUSTICAS ACETO SAL DE MAR MARCO POLO 185G	1	7802420005046	1	2000	1	0	\N	\N
488	KEM ZERO 2 LTS DES.	5	7801620008123	1	1100	1	1300	\N	\N
2918	MEGA ALMENDRAS 90ML 	1	7613036185318	1	1590	1	0	\N	\N
2704	FITNESS YOGHURT 380G	1	7613036422109	1	2500	1	0	\N	\N
3221	CREMA ESPESA  200 GR SOPROLE	1	7802900105013	1	850	1	0	\N	\N
3382	CLOROX WIPES DESINFECTANTE 75 WET WIPES	1	044600016566	1	5200	1	0	\N	\N
3383	CLOROX TOALLAS DESINFECTANTES 35 UN. 	1	7501071901690	1	2900	1	0	\N	\N
3384	LEVADURA LEFERSA 125G 	1	7803000202114	1	1850	1	0	\N	\N
884	LIMONADA LOVE LEMON ORIGINAL 475CC	5	7804643820000	1	1200	1	0	\N	\N
3385	YOGHURT SURLAT 1 LT 	1	7804617470408	1	1200	1	0	\N	\N
2920	JABON VIOLETAS SILVESTRES 1 LT BALLERINA	73	7804920350855	1	1390	1	0	\N	\N
2141	SAL DE MAR A GRANEL	1	2500132010000	1	850	1	0	\N	\N
1272	LECHE BLANCA ENTERA SURLAT 1LT	1	7804617470286	1	1000	1	0	\N	\N
3386	MARGARINA PAN 250 GR SOPROLE	1	7802900605001	1	650	1	0	\N	\N
4339	SILICONA DE AUTOS 450CM3	1	7808304316024	1	2100	1	0	\N	\N
1123	SOPA DE CARACOLITOS 74G GOURMET 	1	7802410002277	1	500	1	0	\N	\N
2746	BILZ ZERO 500 ML	75	7801620008161	1	600	1	0	\N	\N
2264	TODDY BLOCK 101G 	1	7500478002504	1	450	1	0	\N	\N
2741	GARNIER 4.0	1	7899026462571	1	2200	1	2000	\N	\N
2034	MR.BIG 330 CC	54	7804646000102	1	1100	1	0	\N	\N
2745	GARNIER 6.7	1	7899706120746	1	2000	1	0	\N	\N
2742	GARNIER 7.3	1	7898587770705	1	2000	1	0	\N	\N
2743	GARNIER 8.1 	1	7898587770668	1	2200	1	2000	\N	\N
2926	CASSATA PIÑA  1 LT FRUNA	62	7802408061040	1	1500	1	0	\N	\N
2927	CASATA FRUNA PIÑA 2.5LT . 	1	7802408001411	1	3000	1	0	\N	\N
2928	POWER ADE UVA 1LT 	1	7802820672145	1	1000	1	0	\N	\N
3222	JUREL NATURAL 425 GR DORASOL	1	7804608221583	1	1200	1	0	\N	\N
3223	REXONA MEN BARRA MOTIONSENSE 50G	1	75024956	1	2800	1	0	\N	\N
3224	DESODRANTE REXONA MEN INVISIBLE 50GR 	75	75028978	5	2800	1	0	\N	\N
3388	MAYONESA VEGANA HELLMANNS 670G	1	7805000318758	1	2500	1	0	\N	\N
203	HARINA S/P MONT BLANC 1 KG. 	1	7802615005615	1	1750	1	1200	\N	\N
2744	GARNIER 6.0	1	7899026462625	1	2200	1	2000	\N	\N
3389	PAN MOLDE INTEGRAL 400 GR IDEAL	24	7803403001901	4	1500	1	0	\N	\N
2705	CREAM CHEESE GREEN BAY 226G	1	7802285001160	1	1890	1	0	\N	\N
2766	VIVO SMOOTHIE BERRIES 330ML	1	7802575226846	1	1200	1	0	\N	\N
2764	VIVO SMOOTHIE MANZANA KIWI 330ML 	1	7802575226839	1	1200	1	0	\N	\N
2765	VIVO SMOOTHIE NARANJA PIÑA 330ML 	1	7802575226853	1	1200	1	0	\N	\N
2929	AQUARIUS LIMON 500 CC	75	7801610481035	1	750	1	0	\N	\N
2930	AQUARIUS POMELO 500 ML	75	7801610484104	1	750	1	0	\N	\N
2931	AQUARIUS UVA 500 CC	75	7801610481028	1	750	1	0	\N	\N
3390	ACEITE BONANZA 1 LT 	1	7808743600197	1	1750	1	0	\N	\N
4340	TRAPERO HUMEDO TIO JOTA LAVANDA 	1	8065050412137	1	2100	1	0	\N	\N
3392	JUREL MERKAT 425G	1	7804608223167	1	1100	1	0	\N	\N
3393	ARROZ TUCAPEL FOOD SERVICE 2 KG 	1	7801420001744	1	2600	1	0	\N	\N
3394	JABON BALLERINA 900ML	1	7804920012166	1	1400	1	0	\N	\N
3395	POROTO NEGRO DIAZ 1 KG 	1	7801350100517	1	2500	1	0	\N	\N
3396	POROTO BLANCO BONANZA1KG	1	7808743603716	1	2400	1	0	\N	\N
3398	QUEQUE MARMOL NUTRA BIEN 250GR	1	7803525999704	1	1800	1	1450	\N	\N
3399	QUEQUE BROWNIE 250G 	1	7803525001001	1	1800	1	1450	\N	\N
3596	DORINA 500G	1	8719200694149	1	1650	1	0	\N	\N
3400	QUEQUE BROWNIE NUTRA BIEN 250GR	1	7803525999681	1	1800	1	1450	\N	\N
3401	QUEQUE NARANJA CHIPS NUTRA BIEN 250GR	1	7803525999674	1	1800	1	1450	\N	\N
3402	QUEQUE ZANAHORIA 250G	1	7803525001018	1	1450	1	0	\N	\N
3403	ALCOHOL GEL VERDE 	1	2000000001494	1	2000	1	0	\N	\N
2772	GALLETAS NAVIDAD 220G	1	7802225680318	1	1000	1	0	\N	\N
2935	PAPEL HIGIENICO PILUCHO 4 UN. 	1	7804612610304	1	1000	1	0	\N	\N
3387	PAPEL HIGENICO ALMACENERO 1 ROLLO  50 MTS CONFORT	73	7806500505709	1	500	1	0	\N	\N
4026	GRAN CEREAL VAINILLA 110G	1	7802215503023	1	650	1	0	\N	\N
2932	NUEZ  50 GRS SEMBRASOL	1	7804612220206	1	1400	1	1300	\N	\N
2047	PILA PANASONIC AA UNIDAD 	1	7756726001816	1	300	1	250	\N	\N
2934	CRUNCHIS POPS 270 GRS	1	7802420001680	1	1700	1	1500	\N	\N
1168	HAMBURGUESA POLLO 100G RA	1	7801930012049	1	800	1	700	\N	\N
3225	JABON LIQUIDO ANTIBAC. BALLERINA 350ML	1	7804920002730	1	1200	1	0	\N	\N
3226	JABON LIQUIDO ANTIBAC. 350ML	1	7804920013934	1	1200	1	0	\N	\N
3227	SPEED STICK 150ML	1	7509546063706	1	2500	1	0	\N	\N
3228	SPEED STICK 150ML 	1	7509546063676	1	2500	1	0	\N	\N
3229	SPEED STICK 150ML 	1	7509546063690	1	2500	1	0	\N	\N
3232	BOLSAS BASURA 70X90 VIRUTEX	73	7806810800440	1	1150	1	0	\N	\N
3233	BOLSAS BASURA 80X110 VIRUTEX	73	7806810800457	1	1800	1	0	\N	\N
3234	VIRUTEX GRANDE 80X120CM 	1	7806810800471	1	2800	1	0	\N	\N
2936	FUCHS CENTENO AVENA 450G 	1	7803480001139	1	1000	1	0	\N	\N
3288	HEAD SHOULDERS CAFEINA 375ML 	1	7500435019712	1	3600	1	0	\N	\N
3289	HEAD SHOULDERS COMEZON 375ML 	1	7500435020671	1	3600	1	0	\N	\N
3290	BIGTIME BLUEBERRY	1	78024618	1	300	1	0	\N	\N
3291	BIGTIME FRAMBUESA 	1	78024809	1	300	1	0	\N	\N
3282	BAYGON CASA Y JARDIN 360 CC	73	7790520000989	1	3100	1	0	\N	\N
4341	PASTA DE ZAPATO NEGRA SAPOLIO 	1	7751851028684	1	990	1	0	\N	\N
2811	BELCAN ADULTO 1KG	1	7798098847173	1	1250	1	0	\N	\N
1052	PAPAS LAYS STAX ORIGINAL 40GR	6	7802000009273	1	600	1	0	\N	\N
1187	FIDEOS INSTANTANEOS CAMARON TRAVERSO 	1	7802337939038	1	700	1	0	\N	\N
1188	FIDEOS INSTANTANEOS CARNE TRAVERSO 	1	7802337939014	1	700	1	0	\N	\N
4027	GRAN CEREAL CHOCOLATE 110G	1	7802215503016	1	650	1	0	\N	\N
3298	PROBIOTICO CALAN 	1	7802955008796	1	350	1	0	\N	\N
1658	ENCHUFE HEMBRA	35	7895623021647	1	700	1	0	\N	\N
1186	VASO 16OZ 50 UND	34	7750078001890	1	0	1	0	\N	\N
1157	SAPOLIO BEBE 450 G 	1	7751851024136	1	990	1	0	\N	\N
710	NESTUM 5 CEREALES  250 GRS	1	7613035939110	1	1900	1	0	\N	\N
1177	MIEL NATIVE HONEY 1000G	1	7804643790037	1	3500	1	0	\N	\N
1735	SURLAT SEMIDESCREMADA 1L	1	7804617470293	1	950	1	0	\N	\N
569	WATTS TUTTIFRUTILLA 1,5 LTS	5	7801620001841	1	1500	1	1350	\N	\N
3604	TAPSIN CALIENTE DIA 5G	1	7800004399536	1	700	1	0	\N	\N
1362	HAMBURGUESA BRONTO 185G SAN JORGE 	20	7801907006897	1	1100	1	1000	\N	\N
872	MASTICABLES FRUTALES 800 GR ARCOR	6	7790580178208	1	4000	1	0	\N	\N
714	CEREALES SOBRE MILO NESTLE 30GR	6	7613031291489	1	300	1	0	\N	\N
792	ALGODON HIDROFILO AMERICANO 50GR	2	7806545010213	1	600	1	0	\N	\N
2696	TOALLA ABOLENGO PLUS  11MTS X3 ROLLOS	73	7806500404743	1	1100	1	0	\N	\N
2813	MCKAY GALLETAS NAVIDAD 210G 	1	7613030005483	1	1100	1	0	\N	\N
3165	GLOBOS 0 UN. BLANCO 	1	7806130000681	1	1500	1	0	\N	\N
3162	JUEGO NAIPE INGLES 	1	086201114296	1	1300	1	0	\N	\N
503	PAP RETORNABLE  2 LT CCU	5	7801620300197	1	1350	1	0	\N	\N
491	CACHANTUN MAS MANZANA 500 CC	5	7801620004873	1	800	1	0	\N	\N
512	ORANGE CRUSH 500 CC	5	7801620016005	1	900	1	0	\N	\N
505	GINGER ALE RETORNABLE  2 LT CCU	5	7801620360191	1	1350	1	0	\N	\N
344	RAID CASA Y JARDIN 360 CM3	2	7790520986153	1	3800	1	0	\N	\N
4342	AROM LAVANDA 225G 	1	7805040000576	1	1250	1	0	\N	\N
350	ROCKLETS MANI JAPONES 35 G 	6	7802225427432	1	450	1	0	\N	\N
336	PEPSODENT 40 G 	2	7805000311339	1	550	1	0	\N	\N
2942	PAPAS DUQEUSA 1.1 KG 	1	7801300000447	1	2200	1	0	\N	\N
3302	HUEVITOS MACIZOS FRUNA 120G	1	7802408005426	1	1100	1	0	\N	\N
2943	MANI CON MIEL MARCO POLO 180G	1	7802420127113	1	1000	1	0	\N	\N
2945	MANI CON PASAS MARCOPOLO 180G	1	7802420125430	1	1300	1	0	\N	\N
3163	JUEGO DE CARTA ESPAÑOL	1	7453038473064	1	600	1	0	\N	\N
2946	MANI SALADO MARCO POLO 200GR	1	7802420125423	1	1000	1	0	\N	\N
3410	SIMONDS 550ML	1	7804945010628	1	1100	1	0	\N	\N
3412	TOALLA NOVA OPTIMO 3 UN. 	1	7804653340666	1	1490	1	0	\N	\N
3414	CALDO MAGGI VERDURAS 80G	1	7613035722835	1	1000	1	0	\N	\N
3415	CALDO MAGGI CEBOLLA AJO 80G	1	7613035722774	1	1000	1	0	\N	\N
3416	SPAGHETTI 5  400 GR COLISEO	1	7798031153705	1	550	1	0	\N	\N
3417	JABON BARRA PROTEX 270G	1	7891024024249	1	2250	1	0	\N	\N
3413	CALDO MAGGI SABOR COSTILLA 80G	1	7613035722743	1	1000	1	0	\N	\N
2695	TRAPERO HUMEDO NOVA 10UN. 	1	7806500750000	1	3250	1	3190	\N	\N
3609	FUCHS INTEGRAL 650G	1	7803480020079	1	2200	1	0	\N	\N
3418	SUFLES QUESO  270 GR EVERCRISP	1	7802000011955	1	1900	1	0	\N	\N
2944	MANI MARCO POLO SIN SAL 180 GRS 	1	7802420125416	1	1000	1	0	\N	\N
3419	SNACK MIX  II 320G	1	7802000009068	1	2550	1	0	\N	\N
3420	GATOLATE MIX DULCE 320 GRS	1	7802000012556	1	2550	1	0	\N	\N
3421	COLGATE ULTRA BLANCO 90G	1	7793100111891	1	1000	1	0	\N	\N
3422	PIN POP 24 UN. 	1	7702174070270	1	1900	1	0	\N	\N
3426	CALDO CARNE 120GR MAGGI	1	7802950005974	1	1400	1	0	\N	\N
980	PAPELILLO OCB 	2	30052765	5	900	1	0	\N	\N
2951	NOT MAYO ORIGINAL 350G	1	7804659650035	1	2390	1	0	\N	\N
2948	YERBA MATE ARGENTINA 500G	1	7801875068033	1	2700	1	0	\N	\N
2950	DETERGENTE LIQUIDO MATIC PININA 5 LT 	1	2000000001371	1	2000	1	0	\N	\N
2952	PILA RAYOVAC AA	1	2000000001388	1	150	1	0	\N	\N
2953	PILA RAYOVAC AAA	1	2000000001395	1	150	1	0	\N	\N
3423	CLOROX CLOROGEL LAVANDA 900ML	1	7805025696176	1	1950	1	0	\N	\N
3342	AROM VIRGINIA CHIRIMOYA ALEGRE 225G	1	7805040004499	1	1250	1	0	\N	\N
3427	CALDO MAGGI POLLO CAMPO120G	1	7613032875497	1	1400	1	0	\N	\N
3430	YERBA MATE ARGENTINA SUPREMO 500G 	1	7801875001887	1	3650	1	0	\N	\N
2949	YERBA MATE BRASIL 250G	1	7801875065049	1	2100	1	0	\N	\N
3431	CERA ROJA ARUBA 300 CC	1	7805027000049	1	750	1	0	\N	\N
3432	VIVO NARANJA 190 ML	1	7802575220493	1	300	1	0	\N	\N
352	ROLLS NUTS 15 G 	6	78024311	1	150	1	0	\N	\N
354	ROLSS CROCANTE 13 G 	6	78024304	1	150	1	0	\N	\N
1200	SOPA PARA UNO ESPARRAGOS 15G GOURMET 	1	7802410371014	1	400	1	0	\N	\N
3172	MORF NAVIDEÑOS 120G	1	7802225281379	1	550	1	0	\N	\N
2623	FRUTILLAR QUESO CREMA 190G	1	7801930018058	1	1800	1	0	\N	\N
2706	MUSTANG PASAS AL RON FRUNA	62	7802408000513	1	300	1	0	\N	\N
2707	HELADO PIÑA FRU 60 ML	1	7802408000551	1	150	1	0	\N	\N
2708	HELADO NARANJA FRU 60 ML	62	7802408000568	1	150	1	0	\N	\N
2956	DETERGENTE POLVO BRIGHT 3 KG 	1	614143695179	1	4200	1	0	\N	\N
2955	SALCHICHA SUREÑAS  1 KILO PF	3	7801930005089	1	3490	1	2490	\N	\N
2046	PILA PANASONIC AAA UNIDAD	1	8887549091285	1	300	1	250	\N	\N
2957	CAFE DECAF  100 GR NESCAFE	1	7613032836641	1	3600	1	0	\N	\N
317	PALETA CHOCOLATE BIMBO ZOO 14 G 	7	7802200840690	1	150	1	0	\N	\N
2959	LECHE COLUN CAPPUCCINO 1 LT 	1	7802920008097	1	1750	1	0	\N	\N
3174	SENSORLUS COLORED 	1	7809604500502	1	1300	1	0	\N	\N
3173	PEPSODENT TRIPLE PROT.90 GR	73	6902088603828	1	1300	1	0	\N	\N
3168	SOFT CLASSIC 450CC	1	7791290788398	1	1400	1	0	\N	\N
3175	SENSOR PLUS TRES SABORES 	1	7809604500533	1	1300	1	0	\N	\N
2860	MAGISTRAL 215ML 	1	7500435139717	1	1400	1	0	\N	\N
3309	GATORADE LIMON 1LT	1	7801620005726	1	1100	1	0	\N	\N
3169	MORF XL 350G	1	7802225281133	1	1790	1	1690	\N	\N
341	POROTOS CONSERVA WASIL 380 GRAMOS 	1	7801305004150	1	1400	1	1300	\N	\N
1736	MATERNIDAD NOSOTRAS 10UN 	36	7702027042010	1	2150	1	0	\N	\N
1202	MAYONESA HELLMANNS LIGHT 95G 	1	7802640501069	1	750	1	0	\N	\N
4343	AROM LLUVIA DE FLORES 225G	1	7805040000613	1	1450	1	0	\N	\N
1204	ATUN LOMITOS ACEITE 184G VAN CAMPS 	1	7702367000015	1	1400	1	0	\N	\N
1234	CEREALES CHOCAPIC 400 GRS	27	7613034638243	1	2650	1	0	\N	\N
2817	MALLOA ACEITUNAS 245G 	1	7805000311476	1	1250	1	0	\N	\N
1278	ARROZ MIRAFLORES PREGRANEADO G1 1KG	1	7802615006568	1	1500	1	0	\N	\N
3308	TALIANI NIDOS DE FETTUCCINI 400G	1	7802500008103	1	1400	1	0	\N	\N
3311	MANJAR S/LACTOSA ECKART 380G	1	7804000001332	1	2990	1	0	\N	\N
1228	CHOCOLATE  14 GRS SAHNE NUSS	25	7802950072358	1	200	1	0	\N	\N
1215	RAYITA MARINELA 60G	1	7803473003232	1	300	1	0	\N	\N
2967	BOLSA BASURA 80X110	1	7805160000098	1	1250	1	0	\N	\N
2969	CONFORT ROMANO 10UN . 	1	7804659790045	1	2000	1	0	\N	\N
2970	SUPREMO MATICO 20 BL.	1	7801875058089	1	1100	1	0	\N	\N
2971	DESODORANTE MAJIX ICE 	1	8696630126610	1	1800	1	0	\N	\N
2972	DESODORANTE MAJIX FUSION 	1	8696630126566	1	1800	1	0	\N	\N
2973	DESODORANTE MAJIX AFRIQUE 	1	8696630126627	1	1490	1	0	\N	\N
2974	DESODORANTE MAJIX CHANGEMENT	1	8696630126528	1	1490	1	0	\N	\N
1470	MANZANA FUJI	11	104	2	1000	1	800	\N	\N
2975	DESODORANTE MAJIX LINSTINCT	1	8696630126511	1	1800	1	0	\N	\N
1221	ALFI 45G MARINELA 	1	7803473002020	1	350	1	250	\N	\N
1004	JUGO LIVEAN MANGO 7GR	1	P006	1	200	1	0	\N	\N
1232	GANSITO MANJAR 47 G 	1	7803473004307	1	350	1	0	\N	\N
4374	ESTUCHE NAVIDAD PRIVILEGIO 90G	1	7802225572545	1	900	1	0	\N	\N
1233	GALLETON AVENA CHOCOLATE FUCHS 50G 	1	7803480000897	1	400	1	0	\N	\N
2880	COSTILLAR AHUMADO 51KG 	1	C35468489	1	4386	1	0	\N	\N
2881	COSTILLAR AHUMADO 44KG 	1	C35468483	1	3827	1	0	\N	\N
3179	LENTEJAS BONANZA 500G	1	7808743604546	1	1100	1	0	\N	\N
3183	QUINOA BANQUETE 250G	1	7801420001836	1	2250	1	0	\N	\N
3184	TALCO BROOKS SILVER TECK 120G 	1	7804902016281	1	1890	1	0	\N	\N
3185	TANAX MATA HORGAS 440G	1	7805300000001	1	3150	1	0	\N	\N
3186	LISTERINE 180ML	1	7702035430090	1	1600	1	0	\N	\N
3187	CAFECITTO ARABICA COLOMBIA 50G	1	614143601293	1	2250	1	0	\N	\N
3312	PIZZA JAMON QUESO PF 250G	1	7801930017938	1	1400	1	0	\N	\N
3313	ZANAHORIA HUEVITOS DE ORO FRUNA 100G 20U	1	7802408005822	1	1000	1	0	\N	\N
218	ILICIT COLOR RUBIO MEDIO 7.0	2	7804923031461	1	2000	1	0	\N	\N
459	POROTOS NEGROS G2 BONANZA 1KG	1	7808743603617	1	1450	1	0	\N	\N
3318	AZUCAR MERKAT 1 KG	1	7804605040156	1	750	1	0	\N	\N
3325	LASAÑA PRECOCIDA  200 GR CAROZZI	1	7802575015518	1	1600	1	850	\N	\N
3317	LYSOFORM BEBE 360CM 	1	7790520014191	1	3200	1	0	\N	\N
3437	CRUNCHIS PAÑITOS XTRA	1	7802420003301	1	1500	1	0	\N	\N
2977	TE VERDE SUPREMO FRUTOS DEL BOSQUE 20BOL.	1	7801875001030	1	1500	1	0	\N	\N
85	CHOCOLATE SAFARI 27 G 	6	7802220741809	1	200	1	0	\N	\N
91	CHUBITON 17.8 G 	6	78024489	1	200	1	0	\N	\N
2978	SPEED STICK FRESH 50 GR	73	7501035907508	1	2690	1	0	\N	\N
3438	PRESERV. LIFE STYLE STUDDED 3UND	74	7804918450031	1	1990	1	0	\N	\N
3439	PRESERV. LIFESTILE V.RIBBER STILUMA 3 UND	74	7804918450024	1	1990	1	0	\N	\N
3440	JABON PALMOLIVE HUMECTANTE125G	1	7891024177655	1	900	1	0	\N	\N
3442	LECHE DESCREMADA SOPROLE 1 LT	1	7802900001346	1	1000	1	0	\N	\N
3441	CEREALES MILO  330 GR NESTLE	1	7613034232571	1	2650	1	0	\N	\N
1236	CEREALES TRIX  330 GRS NESTLE	27	7613034155030	1	2650	1	0	\N	\N
2333	CHANDELLE MOUSSE CHOCOLATE 70G	1	7613036454476	1	580	1	0	\N	\N
3436	MORF TRENZ 220G	1	7802225281126	1	1490	1	0	\N	\N
2334	CHANDELLE MOUSSE COCO 70G	1	7613037162356	1	580	1	0	\N	\N
304	MIFRUT PIÑA YOGURT 90 G 	1	7802200270244	1	350	1	0	\N	\N
1643	CHURRASCO VACUNO 120G LA ESPAÑOLA 	20	7801930015163	1	700	1	0	\N	\N
2982	MIRAFLORES CURRY 210G	1	7800120755582	1	1100	1	900	\N	\N
2983	MIRAFLORES PRIMAVERA 210G	1	7802615007848	1	1100	1	900	\N	\N
294	MARUCHAN A CARNE ASADA 64 GRAMOS	1	041789001888	1	850	1	0	\N	\N
4345	DESINFECTANTE DOÑA GABY ORIGINAL 300ML 	1	8699009446937	1	2500	1	0	\N	\N
1621	CASATA CHOCOLATE SUIZO 1 LITRO SAVORY 	6	7613032657185	1	2700	1	0	\N	\N
3326	SPRIM DURAZNO NECTAR 190 ML	1	7802575220127	1	250	1	0	\N	\N
3327	SPRIM BERRIES 190 ML	1	7802575226143	1	250	1	0	\N	\N
1064	PAPAS LAYS CORTE AMERICANO 400GR	6	7802000010347	1	2900	1	0	\N	\N
2161	CUPCAKES 	12	650	1	600	1	0	\N	\N
3336	LISOFORM ORIGINAL 420CM 	1	7790520014313	1	3300	1	0	\N	\N
3341	LYSOL FLORES 354CM 	1	019200029223	1	3000	1	0	\N	\N
3343	AROM VIRGINIA FRESCURA CITRICA 225G	1	7805040000606	1	1150	1	0	\N	\N
3345	TOALLAS HUMEDAS PLENITUD 42 UN. 	1	7896018703551	1	1950	1	0	\N	\N
3346	LONCO LECHE SOYA CHOCOLATE 1 LT 	1	7802910005174	1	2600	1	0	\N	\N
2985	BOWL CAMARON HABANERO MARUCHAN 	1	041789003981	1	1300	1	0	\N	\N
2986	JUGOSO AL HORNO MAGGI CERDO CRIOLLO 23G	1	7613035190498	1	850	1	0	\N	\N
2987	JUGOSO AL HORNO MEDITERRANEO 24 GR MAGGI	1	7613035191822	1	850	1	0	\N	\N
2988	JUGOSO AL HORNO POLLO FINAS HIERBAS 24G	1	7613035191792	1	850	1	0	\N	\N
1654	MORTADELA ALEMANA WINTER 	3	98	2	5000	1	3990	\N	\N
3013	QUESILLOS NEMESIO ANTUNEZ 	1	1418	1	4000	1	3300	\N	\N
3621	PRINGLES PIZZA 158G 	1	038000138638	1	2450	1	1990	\N	\N
291	MAGNUM COOKIES AND CREAM 77 GRAMOS 	7	7805000310288	1	1790	1	1590	\N	\N
2984	CARNE MOLIDA RECETA DEL ABUELO 	1	7801930012223	1	1600	1	1500	\N	\N
2989	JUGOSO AL HORNO POLLO AL LIMON  24 GR MAGGI	1	7613035190467	1	850	1	0	\N	\N
2990	HEINZ KETCHUP 567G 	1	013000006408	1	3350	1	0	\N	\N
3351	JABON PROTEX AVENA 125G	1	7891024114261	1	990	1	0	\N	\N
3105	NUGGETS PREMIUM CROCANTE ARIZTIA 400G	1	7801965001209	1	1700	1	0	\N	\N
3204	CHEETOS POPCORN CHOCOLATE 55G	1	7802000013393	1	600	1	0	\N	\N
1777	ESPONJA LISA UN	2	042	1	300	1	0	\N	\N
3206	BIGTIME FRUTILLA ACIDA 11G	74	78024137	1	300	1	0	\N	\N
3339	ACETO BALSAMICO IMPERATORK 250 ML 	1	7802356297287	1	1500	1	0	\N	\N
3340	LYSOL ORIGINAL 354 G 	1	019200741866	1	3000	1	0	\N	\N
3200	GOLPE MAXX 45G	1	7757174009461	1	300	1	0	\N	\N
3201	PICADO CARNE FIDEOS Y VERD  215 GR NESTLE	1	7802950003543	1	1490	1	0	\N	\N
375	SHAMPOO PANTENE FUERZA Y RECONSTRUCCIÓN 400 ML 	2	7500435020244	1	3300	1	0	\N	\N
2337	AVENA MULTISEMILLAS 700G	1	7802000012518	1	2600	1	0	\N	\N
3104	AZUCAR CORRIENTE MERKAT 1KG	1	7804627780252	1	1100	1	0	\N	\N
3443	PISTACHO  40 GRS SEMBRASOL	1	7804612220213	1	1700	1	1600	\N	\N
3354	PASTA FRESH UP 50G	1	6922961998827	1	500	1	0	\N	\N
311	NIKOLO 27 G 	6	7802225538053	1	250	1	0	\N	\N
1249	NESCAFE FINA SELECCION 50G FRASCO	1	7613034094292	1	2000	1	0	\N	\N
472	CABELLITOS LUCCHETTI 400G	1	7802500001029	1	1300	1	800	\N	\N
3357	GELATINA NARAN/ORANGE  40 GRS TURBO	1	7801615771810	1	350	1	0	\N	\N
3358	GELATINA TURBO FRAMBUESA 	1	7801615771872	1	350	1	0	\N	\N
3202	JUGO DE LIMON DON JUAN 250ML	1	7802351534509	1	450	1	0	\N	\N
3449	CEBOLLIN 	1	2000000001517	1	550	1	0	\N	\N
3455	LA CREMERIA 1LT PAPAYAS A LA CREMA	6	7613036570602	1	3900	1	0	\N	\N
3453	LA CREMERIA 1LT SABOR BROWNIE FRAMBUESA	6	7613036569712	1	3900	1	0	\N	\N
3451	LA CREMERIA 1LT SABOR CHEESECAKE FRAMBUESA	6	7613036570541	1	3900	1	0	\N	\N
3452	LA CREMERIA 1LT SABOR CHOCOLATE FRAMBUESA	6	7613036568432	1	3900	1	0	\N	\N
3454	CASATA 1LT CHOCOLITO	6	7613035366565	1	3000	1	0	\N	\N
2806	YOUGURT LOS ALERCES MORA 125 GRS	1	7802920002538	1	200	1	0	\N	\N
3103	CHOCLO MONTINA 200G	1	7804115001616	1	650	1	500	\N	\N
818	JABON VANISH 75GR	2	7891035040191	1	900	1	0	\N	\N
393	SOFT CLASSIC 500 ML 	2	7891150057678	1	990	1	0	\N	\N
356	ITALIANA LUCCHETTI 200 GRAMOS	1	7802500037059	1	380	1	0	\N	\N
803	JABON BELLEKISS VIOLETA 700ML	2	7804945051201	1	1250	1	0	\N	\N
592	CREMA CHOCLO  79 GRS MAGGI	1	7802950004571	1	690	1	0	\N	\N
588	BASE CAZUELA DE VACUNO 70GR MAGGI	1	7613031238576	1	690	1	0	\N	\N
4359	TE HOJA MILDRED 200G	1	7801875002051	1	3600	1	0	\N	\N
769	GALLETA CEREAL MIX VAINILLA 115GR	6	7802225689144	1	650	1	0	\N	\N
635	YOGHURT MILO  142 GRS NESTLE	4	7613033088605	1	600	1	0	\N	\N
1257	GALLETA KUKY CHOC  120 GRS NESTLE	26	7802230081179	1	700	1	0	\N	\N
864	DULCES ARCOR BUTTER TOFFEES FRUTOS ROJOS 350GR	6	7790580412777	1	1850	1	0	\N	\N
591	CREMA TOMATES   78 GR MAGGI	1	7802950006742	1	450	1	0	\N	\N
3356	GELATINA TURBO PIÑA 	1	7801615771827	1	400	1	0	\N	\N
407	TE SUPREMO HIERBAS SURTIDAS 20 UN. 	1	7801875061010	1	1200	1	0	\N	\N
3355	GELATINA TURBO 30G 	1	7801615774279	1	990	1	0	\N	\N
2892	GUALLARAUCO LIMONADA MARACUYA 500ML	1	7803908005275	1	1100	1	0	\N	\N
2893	GUALLARAUCO MANGO MARACUYA 500ML 	1	7803908004469	1	1100	1	0	\N	\N
3014	LONCO LECHE BLANCA 1/2 LT.	1	7802910007284	1	650	1	0	\N	\N
3456	DURAZNOS WASIL EN MITADES 3 KG 	1	7801305121321	1	4500	1	0	\N	\N
3015	QUESO MANTECOSO SAN SEBASTIAN 250G 	4	7802911000048	1	1950	1	0	\N	\N
3463	COLACAO 180ML 	1	7802635000478	1	1300	1	0	\N	\N
3017	PERRO CACHORRO ANIMAL PLANET 	31	308	1	2400	1	0	\N	\N
3016	PERRO ADULTO ANIMAL PLANET 	31	309	1	2200	1	0	\N	\N
1468	PEPINO ENSALADA	11	2000000000480	1	350	1	0	\N	\N
3457	TOALLA FABORITA CLASICA 12.5 MTS	74	7806540001834	1	450	1	0	\N	\N
314	NOBLE UND. ALMACENERO 28 METROS	2	7806500504863	1	200	1	0	\N	\N
815	JABON POPEYE BEBE 2UN.	2	7805045001066	1	2100	1	0	\N	\N
1253	GALLETAS MANTEQUILLA 140G MCKAY 	1	7802230083951	1	700	1	0	\N	\N
774	GALLETA CRACKER TRADICIONAL 107GR	6	7802225682107	1	500	1	0	\N	\N
1259	CHOCOLATE PRESTIGIO COCO 35G 	1	7802230975324	1	350	1	0	\N	\N
3458	PAPEL HIGIENICO ALMACENERO  50 MTS NOBLE	73	7806500507864	1	450	1	0	\N	\N
3459	CONFORT NOBLE 40 MTS	1	7806500508199	1	400	1	0	\N	\N
3460	TOALLA PAPEL FAVORITA 3 UN.	1	7806540005603	1	1590	1	0	\N	\N
3461	SERVILLETA CLARA 50UN	1	7898920700659	1	350	1	0	\N	\N
3462	LADYSOFT ULT.16UN.	1	7790250096122	1	2690	1	1990	\N	\N
417	VANISH BLANCO TOTAL 30 GRAMOS 	2	7702626204642	1	400	1	0	\N	\N
1848	CHARQUI DE EQUINO 40G 	6	7804623100153	1	1600	1	0	\N	\N
193	GILLETTE PRETOBARBA 3	2	7702018880409	1	990	1	0	\N	\N
3323	JABON LIQUIDO MAQUI 900ML	1	7804920006257	1	1400	1	0	\N	\N
3019	ECONUTRA ACEITE DE COCO 200ML	1	4796012480034	1	6300	1	0	\N	\N
2891	LONCOLECHE PROTEIN MILK 1LT.	1	7802910006690	1	2150	1	0	\N	\N
1976	AGUA DE LIMON 500ML GUALLARAUCO	53	7803908004452	1	1100	1	0	\N	\N
1262	GALLETA MINI MOROCHA  50 GRS MCKAY	26	7613032443221	1	300	1	0	\N	\N
3465	SALSA DE SOYA LA PRIMERA 250 ML 	1	7802410820154	1	650	1	0	\N	\N
3466	SALSA DIP MAYO QUESO MARCO POLO 220G	1	7802420003592	1	1490	1	0	\N	\N
3467	SALSA DIP GOLF MARCO POLO 220G	1	7802420003479	1	1490	1	0	\N	\N
542	KEM RETORNABLE 1LT	5	7801620350048	1	750	1	0	\N	\N
3468	TE VERDE HOMAR 20 UN	1	2019022400987	1	750	1	0	\N	\N
3470	SUPER LAC MANLAC SIN JABON 6 UN	1	7806800003011	1	400	1	0	\N	\N
1273	LONCO LECHE FRUTILLA SEMIDESCREMADA 1 LITRO 	1	7802910000247	1	1600	1	0	\N	\N
1787	LUSTRA MUEBLE 250 ML VIRGINIA	18	7805040313003	1	1500	1	0	\N	\N
1788	JABON BRILLEX VIOLETA 2L 	36	614143645617	1	1650	1	0	\N	\N
1789	JABON BRILLEX COCO 2L	36	614143645600	1	1650	1	0	\N	\N
508	PAP XPRESS 237CC	5	8801674003876	1	250	1	0	\N	\N
3208	PAÑUELOS DESECHABLES ELITE	73	7806500172116	1	250	1	0	\N	\N
506	PEPSI XPRESS 237 ML	5	7801620003845	6	300	1	0	\N	\N
2895	GUALLARAUCO ALOE VERA SANDIA 500ML 	1	7803908005855	1	800	1	0	\N	\N
504	ORANGE CRUSH RETORNABLE  2 LT CCU	5	7801620330224	1	1350	1	0	\N	\N
223	ILICIT OLOR CHOCOLATE 6.7	2	7804923031294	1	2000	1	0	\N	\N
3209	RUN RUN 50GR	1	7802408001572	1	250	1	0	\N	\N
196	GOLAZO AMBROSOLI 25 G 	6	7802200809178	1	200	1	0	\N	\N
1271	MARGARINA PAN  125 GR SUREÑA	21	7802810021021	1	400	1	0	\N	\N
1238	PINGUINOS CREMOSO 120G 	1	7803473003461	1	800	1	600	\N	\N
1239	PINGUINOS CHOCOLATE 120G 	1	7803473004840	1	600	1	0	\N	\N
493	AGUA MINERAL C/GAS  2250 CC CACHANTUN	5	7801620504175	1	900	1	0	\N	\N
2819	TE CLUB ORIGINAL 100 UNDS	1	7805000306540	1	2590	1	0	\N	\N
3210	CHORIZO SUREÑO SAN JORGE 1KG	1	7801907001755	1	3600	1	0	\N	\N
1276	MERMELADA DAMASCO 250G LOS LAGOS	28	7802810031112	1	600	1	0	\N	\N
3207	VIVO DURAZNO 190 ML	1	7802575220530	1	400	1	0	\N	\N
1254	GALLETA KUKY  120 GRS MCKAY	26	7802230081162	1	700	1	0	\N	\N
3359	GELATINA VIVO BERRIES 22G	1	7802200365759	1	800	1	0	\N	\N
1243	MIL HOJAS MANJAR TRADICIONAL 80G	1	7803403001055	1	600	1	0	\N	\N
3498	NESQUIK CHOCOLATE 180G	1	7613036892964	1	1400	1	0	\N	\N
1851	MANI CONFITADO 10G CAMILA 	6	7804623100283	1	700	1	0	\N	\N
1893	GALLETA GOTERON  1 KILO FRUNA	26	7802408000827	1	1700	1	0	\N	\N
3023	YOGHURT ZEROLACTO CHIRIMOYA  120 GR SOPROLE	1	7802900235239	1	350	1	0	\N	\N
3024	MANTEQUILLA RECETA DE CAMPO 250G	1	7802900002091	1	2650	1	0	\N	\N
3025	DURAZNOS EN MITADES ACONCAGUA 580G	1	7801800100364	1	1400	1	0	\N	\N
3026	DURAZNOS EN CUBITOS 580G	1	7801800104300	1	1200	1	0	\N	\N
3027	FILM  20 MTS KITCHEN	74	7809583800044	1	900	1	0	\N	\N
3499	ARROZ HOMAR G1 1KG	1	7804645050269	1	1150	1	0	\N	\N
1244	GALLETAS RPINCIPE LIMON 84G 	1	7441029506181	1	450	1	0	\N	\N
3503	ATUN LOMITOS AGUA BARQUITO 185G 	1	7804611550809	1	1350	1	0	\N	\N
2324	FLAN CHOCOLATE DAILY 10 PORS. 	1	7809558102494	1	600	1	0	\N	\N
3504	ATUN LOMITO EN AGUA SAN REMO 170 G 	1	8852084174830	1	1350	1	0	\N	\N
3505	ATUN LOMITO ACEITE 184G BARQUITO	1	7804611550816	1	1350	1	0	\N	\N
1275	MERMELADA MORA 250G  LOS LAGOS	28	7802810031136	1	650	1	600	\N	\N
3021	YOGHURT ZEROLACTO VAINILLA  120 GR SOPROLE	1	7802900235253	1	350	1	0	\N	\N
3594	AVENA MANZANA 50G	1	7803525999070	1	450	1	0	\N	\N
3022	YOGHURT ZEROLACTO FRUTILLA  120 GR SOPROLE	1	7802900235222	1	350	1	0	\N	\N
1869	GALLETA TRITON VAINILLA  126 GR MCKAY	26	7802230086952	1	700	1	0	\N	\N
3507	SURTIDO DE CALDILLO MAR CHILENO 190G 	1	7804709995055	1	1350	1	0	\N	\N
682	LECHE CONDENSADA BONLE 397GR	4	7751271018104	1	1000	1	0	\N	\N
729	CAFE ECCO 170 GRS	1	7802950002324	1	1900	1	0	\N	\N
2821	CHOCLO NATURAL ENTERO 	11	2000000001319	1	500	1	0	\N	\N
3501	SALSA DIP MAYO AJO MARCO POLO 220G	1	7802420003455	1	1490	1	0	\N	\N
2112	KUKY CHIP BLANCO 190G 	1	7613035835986	1	1100	1	0	\N	\N
3029	CAFE CRUZEIRO 170G	1	7803111002931	1	5590	1	0	\N	\N
1936	NECTAR MULTIFRUTILLA A.D.V 1.5 LTS LIGHT	38	7802820001082	1	1100	1	0	\N	\N
1261	GALLETA MINI KUKY 40 GRS	26	7802950088823	1	300	1	0	\N	\N
4346	GUANTES MULTIUSO OSO 	1	7804520020363	1	1050	1	0	\N	\N
2103	TRITON WAFERS VAINILLA 36G 	1	7613036944274	1	550	1	0	\N	\N
2104	PEGAMENTO UTUSTOOLS 3G	1	6931598210882	1	300	1	0	\N	\N
2105	PEGAMENTO SUPER GLUE 3G	1	AB571	1	300	1	0	\N	\N
1029	CANADA DRY GINGER ALE RETORNABLE 1LT	5	7801620360016	1	700	1	0	\N	\N
2702	LONGANIZA MONTE OSCURO 	1	2000000001302	1	4900	1	0	\N	\N
1637	CONO CHICO	6	2000000000848	1	0	1	0	\N	\N
3371	CLOROX TRIPLE ACCION 4KG	1	7805025010118	1	4500	1	0	\N	\N
2901	CACHANTUN MAS LIMON 500	1	7801620008307	1	800	1	0	\N	\N
2902	CACHANTUN MAS PIÑA 500ML 	1	7801620008321	1	750	1	0	\N	\N
2903	GELATINA EN HOJAS COLAPEZ 12G 	1	7802410363002	1	1150	1	0	\N	\N
2904	CREMA CHANTILLY  250 GR PRESIDENT	1	3228021000190	1	2650	1	0	\N	\N
1544	VASOS DE CARTON FESTIVITY 10 UN 	34	6922332016211	1	7000	1	0	\N	\N
2908	JABON BALLERINA 340 ML 	1	7804920012173	1	900	1	0	\N	\N
2909	QUESILLO COLUN SIN LACTOSA 160G	1	7802920008080	1	1650	1	0	\N	\N
2905	YOGHURT CHAMITO MANZANA 115G 	1	7613037416787	1	350	1	0	\N	\N
377	SHAMPOO PANTENE LISO EXTREMO 400 ML 	2	7501001165246	1	3300	1	0	\N	\N
799	SHAMPOO HEAD AND SHOULDES LIMPIEZA REN. 375ML	2	7500435020008	1	3600	1	0	\N	\N
2900	HEAD SHOULDERS ALIVIO REFRESC. 375ML 	1	7500435020084	1	3600	1	0	\N	\N
3369	AZUCAR IANZA 1.5LT	1	7801505002680	1	1500	1	0	\N	\N
2896	VINAGRE VINO BLANCO DON JUAN 500 CC	1	7802351524708	1	1000	1	0	\N	\N
1280	LECHE ENTERA CALO BLANCA 500ML 	1	7802910005556	1	650	1	0	\N	\N
3213	BORTOLASO SURTIDO 350G	1	7802215146015	1	1500	1	0	\N	\N
3214	BORTOLASO COCO 350G	1	7802215146039	1	1500	1	0	\N	\N
1281	ACEITE BELMONT CANOLA 1 LT	1	7802810009272	1	2990	1	0	\N	\N
2587	ACEITE MERKAT 1.5 LT 	1	7790272000763	1	2700	1	0	\N	\N
2703	 SURLAT YOGHURT BATIDOS VAINILLA 1KG 	1	7804617470385	1	1200	1	0	\N	\N
3374	HUEVITOS RELLENOS MANJAR BANDEJA 20U	1	7802225571654	1	2400	1	0	\N	\N
3375	HUEVITOS BON O BON CHOC. BANDEJA 20U	1	7802225572668	1	2500	1	0	\N	\N
3370	ARRIZ MERKAT 1 KG 	1	7804608221361	1	1100	1	0	\N	\N
3380	HUEVITOS MACIZOS BANDEJA 35U	1	7802225575003	1	2300	1	0	\N	\N
3050	SALSA TOMATE MERKAT 200G	1	7801800104188	1	250	1	0	\N	\N
3526	ATUN LOMITO ACEITE 170 GR COLORADO	1	7801255000080	1	1350	1	0	\N	\N
3527	CHURRASCO VACUNO  90 GRS KING	7	7809611709622	1	800	1	0	\N	\N
3528	HAMBURGUESAS VACUNO KING KONG  185 GR KING	7	7809611710628	1	1000	1	0	\N	\N
3529	YOGHURT FRUTILLA 125 GR ALERCES	1	7802920106021	4	200	1	0	\N	\N
4	ACEITE VEGETAL DE REYES 900 ML 	1	7804609020062	1	1100	1	0	\N	\N
2915	CASATA CHOCOLATE SAVORY 1LT 	6	7802710832154	1	2700	1	0	\N	\N
2913	CASATA VAINILLA SAVORY 1LT 	6	7802710832116	1	2500	1	0	\N	\N
3372	MAIZENA CAMPINO 100 GR	1	7804520017578	1	1100	1	0	\N	\N
2937	FUCHS CALABAZA NUEZ 380G	1	7803480001115	1	1500	1	0	\N	\N
2940	SALSA SOYA  500 ML TRAVERSO	1	7802315561114	1	2400	1	0	\N	\N
3236	HARINA CISNE PERLA SIN POLVO 1KG 	1	7809561800219	1	1000	1	0	\N	\N
3238	HARINA PAN 1KG 	1	7702084137520	1	2250	1	0	\N	\N
1389	JAMON POLLO COCIDO PF 	3	44	2	8000	1	6900	\N	\N
2939	PREPIZZA TOQUES CEBOLLA IDEAL	1	7803473001603	1	1800	1	1600	\N	\N
2906	JALEA FRAMBUESA  110 GR SOPROLE	1	7802900295080	1	350	1	0	\N	\N
1390	JAMON PAVO COCIDO PF 	3	45	2	8000	1	6900	\N	\N
1286	LECHE FRUTILLA  1 LT SOPROLE	21	7802900050023	1	1500	1	0	\N	\N
2938	PAN MOLDE LINAZA-CHIA FUCHS 380 GR	24	7803480001092	1	1700	1	1500	\N	\N
1367	PIERNA ARTESANAL RECETA DEL ABUELO 	3	22	2	12000	1	8900	\N	\N
3240	LADY SOFT ULTRANOCTURNA X16	1	7806500962786	1	1990	1	0	\N	\N
3242	LASAGNA TRADICIONAL  400 GR CAROZZI	1	7802575007261	1	1750	1	0	\N	\N
1659	ENCHUFE MACHO	35	7895623021630	1	700	1	0	\N	\N
1002	JUGO LIVEAN HUESILLO 7GR	1	P004	1	200	1	0	\N	\N
1287	SAL DE MAR LOBOS ENTREFINA 800G	1	7803600000868	1	1900	1	0	\N	\N
255	JUGO ZUKO FRUTILLA 25 GRAMOS 	1	7802800578849	1	200	1	0	\N	\N
236	JUGO LIVEAN PIÑA 7 GRAMOS 	1	7802800576456	1	200	1	0	\N	\N
465	ACEITE 250 CC BELMONT	1	7802810012531	1	750	1	0	\N	\N
2963	LECHE COLUN CHOC. SIN LACTOSA 1LT 	1	7802920007519	1	1400	1	0	\N	\N
3598	TODDY BLOCK CHOCO VAINILLA 101G	1	768044019425	1	450	1	0	\N	\N
2965	DIANA ULTRA ACTIVE 10UN 	1	8690879300015	1	700	1	0	\N	\N
2966	COFFEE-MATE ORIGINAL 170G	1	7501059295872	1	1550	1	0	\N	\N
4347	TOALLA ELITE DECO 2 ROLLOS 	1	7806500404125	1	2050	1	0	\N	\N
2976	DESODORANTE MAJIX MARINE 	1	8696630126580	1	1490	1	0	\N	\N
3435	PROTECTOR DIARIO NATURELLA 80 UN. 	1	7501001407629	1	2900	1	0	\N	\N
2223	TABLETON 50GR	26	7802408003118	1	200	1	0	\N	\N
2992	JUREL UNICA AL TOMATE 200G 	1	7801233000187	1	800	1	0	\N	\N
2993	BIOFRESCURA CAMPOS DE HIELO 1.5LT. 	1	7804609730558	1	2800	1	0	\N	\N
2995	DETERGENTE MATIC DIELLI 3LT. 	1	7804920005304	1	2500	1	0	\N	\N
2996	TRAPERO EXCELL ABRILLANTADOR LAVANDA 10UN. 	1	7805020002132	1	2300	1	0	\N	\N
3559	DESOD. OLD SPICE FRESH 150ML 	1	7506339349047	1	2500	1	0	\N	\N
3560	DESOD. OLD SPICE VIP 150ML 	1	7506339349023	1	2500	1	0	\N	\N
3562	BIO GARNIER CLARIFY SENSI-CALM 150 ML 	1	7509552900323	1	2500	1	0	\N	\N
3563	BIO GARNIER TOQUE SECO 150ML 	1	7509552910766	1	2500	1	0	\N	\N
3564	BIO GARNIER CLARIFY AFINA EL VELLO 150ML 	1	7509552907483	1	2500	1	0	\N	\N
3566	ACOND. FRUCTIS OIL REPAIR3 350ML 	1	7509552914429	1	2500	1	0	\N	\N
3567	SHAMPOO FRUCTIS OIL REPAIR 350ML 	1	7501839105247	1	2500	1	0	\N	\N
3561	BIO GARNIER CLARIFY 150 ML	1	7506078948075	1	2500	1	0	\N	\N
2964	LADYSOFT NOC. ULTRADELG. 16 UN. 	1	7806500000426	1	2500	1	1990	\N	\N
1264	LECHE BLANCA SEMIDESCREMADA 1 LITRO 	1	7802920000091	1	1450	1	1100	\N	\N
2994	LIMPIADOR EXCELL SUAVIDAD BEBE 900CC	1	7805020001647	1	1700	1	0	\N	\N
1467	CEBOLLA MORADA 	11	2000000000473	1	500	1	0	\N	\N
3642	PEPINILLOS DON JUAN 400G	1	7802351451400	1	1200	1	0	\N	\N
1647	HAMBURGUESA VACUNO PF 90G	20	7801930008981	1	500	1	0	\N	\N
5369	ALKA CEREZA	1	78020146	1	300	1	250	\N	\N
1932	COCA COLA LIGHT RETORNABLE 2 LT	50	7801610022283	1	1400	1	0	\N	\N
32	MIRAFLORES LARGO ANGOSTO GRADO 2 , 1 KG. 	1	7802615006940	1	1000	1	0	\N	\N
3055	SHAMPOO BALLERINA 60ML 	1	7804920003591	1	300	1	0	\N	\N
3707	MANZANILLA CON MIEL SUPREMO 2B	1	7801875058164	1	1100	1	0	\N	\N
2997	MOSTACILLA FANTASIA MARCOPOLO 25G	1	7802420810206	1	250	1	0	\N	\N
2998	DECORACION CHOCOLATE MARCOPOLO 20G	1	7802420810183	1	250	1	0	\N	\N
3000	FIJADOR DUO NORMAL 	1	7804947601213	1	1400	1	0	\N	\N
2421	FIJADOR EXTRA FUERTE 165ML 	1	7804947601114	1	1400	1	0	\N	\N
3001	SALSA ITALIANA  200 GR SAN REMO	1	7802575365026	1	350	1	0	\N	\N
3002	YERBA MATE ARUBA 500G	1	7801430001574	1	2100	1	0	\N	\N
3003	GALLETA DE ARROZ CON QUINOA 110G	1	7804635931332	1	990	1	0	\N	\N
3004	GALLETA DE ARROZ  CON QUINOA 110G	1	7804635931325	1	990	1	0	\N	\N
3005	LECHE NIDO ETAPA 5 800G	1	7613032422967	1	6300	1	0	\N	\N
3006	COLUN CHOCOLATE LIGHT 200ML 	1	7802920002217	1	400	1	0	\N	\N
3007	KETCHUP DON JUAN 250G	1	7802351615000	1	800	1	0	\N	\N
3008	ALCAPARRAS MARCOPOLO 110G	1	7802420103315	1	1800	1	0	\N	\N
3447	QUESO CHEDAR 140G 	1	7804613391332	1	1200	1	0	\N	\N
3448	QUESO GAUDA 140G	1	7804613391349	1	1200	1	0	\N	\N
3010	SOPA COLISEO CARNE 65G	1	7804608223426	1	600	1	0	\N	\N
3011	SOPA COLISEO CAMARON 65G	1	7804608223433	1	600	1	0	\N	\N
3012	SOPA COLISEO POLLO 65G	1	7804608223419	1	600	1	0	\N	\N
3474	LISTERINE ZERO ALCOHOL 180 ML 	1	7702031976387	1	1600	1	0	\N	\N
3446	KILLER CASA Y JARDIN 560CM 	1	7805040004291	1	3990	1	2800	\N	\N
3054	LAYS ARTESANAS 195G 	1	7802000012389	1	1900	1	0	\N	\N
3643	KENT WHITE 	1	78025288	1	4400	1	4200	\N	\N
3494	CHAMPIÑONES ENTEROS HOMAR 425G 	1	7804645050085	1	1390	1	0	\N	\N
3476	JABON LIQUIDO YOG/VAINILLA COCO 900 ML BALLERINA	73	7804920001689	1	1400	1	0	\N	\N
3477	JABON AVENA Y ALMENDRA  1000 ML BALLERINA	73	7804920230232	1	1650	1	0	\N	\N
3478	LYSOL FLORES JARDIN 900ML 	1	7805010003842	1	1990	1	0	\N	\N
3479	LYSOL MARINA 900ML	1	7791130008709	1	1990	1	0	\N	\N
3472	MANJAR RECETA CASERA NESTLE 400G	1	7613038774725	1	1900	1	0	\N	\N
3481	OMO MATIC 200G	1	7805000313746	1	550	1	0	\N	\N
3009	CHUCHOCA 	1	2500133002608	2	2000	1	0	\N	\N
3495	CHAMPIÑONES LAMINADOS HOMAR 425G 	1	7804645050139	1	1390	1	0	\N	\N
3493	PALMITOS EN RODAJAS HOMAR 400G 	1	7804645050030	1	1300	1	0	\N	\N
3237	VANISH ROPA BLANCA 400ML	1	7791130002271	1	1100	1	0	\N	\N
3483	GUANTES ASEO MANLAC M	1	7806800035029	1	990	1	0	\N	\N
3484	GUANTES MANLAC L	1	7806800035036	1	1890	1	0	\N	\N
4348	PAÑO CELULOSA ARUBA 	1	7804645200145	1	500	1	0	\N	\N
4031	HEAD SHOULDERS INVIERNO 400ML 	1	7500435120289	1	3600	1	0	\N	\N
3486	SHAMPOO SUAVELINA PLACENTA 1 LT	1	7804920268037	1	1590	1	0	\N	\N
3487	SHAMPOO SUAVELINA BABY 1 LT 	1	7804920026705	1	1590	1	0	\N	\N
3056	CONFORT FAVORITA AIRES DE FRESCURA 	1	7806540007829	1	1250	1	0	\N	\N
3060	MERMELADA LIGHT FRUTILLA  200 GRS REGIMEL	1	7801305003368	1	1150	1	0	\N	\N
3061	MERMELADA LIGHT MORA  200 GRS REGIMEL	1	7801305002460	1	1150	1	0	\N	\N
3062	MERMELADA DURAZNO 200 GRS REGIMEL	1	7801305002477	1	1150	1	0	\N	\N
3063	MERMELADA DAMASCO  200 GR REGIMEL	1	7801305002491	1	1150	1	0	\N	\N
3065	CLORINDA ROPA COLOR 930G	1	7805080693714	1	1750	1	0	\N	\N
3595	DIGESTIVE SUGAR FREE NUTRABIEN 39GR	1	7803525999056	1	350	1	0	\N	\N
3488	SHAMPOO SUAVELINA MANZANILLA 1 LT 	1	7804920268020	1	1590	1	0	\N	\N
3489	JABON LIQ. TANGO SILKY SOFT 500ML	1	8692641009881	1	1690	1	0	\N	\N
3490	JABON LIQ. TANGO BERRIES 500ML 	1	8692641009904	1	1690	1	0	\N	\N
3496	CLORINDA CONCENTRADO 2 LT .	1	7805080100038	1	2450	1	0	\N	\N
3485	GUANTES ASEO MANLAC S	1	7806800035012	1	1100	1	990	\N	\N
3491	JABON LIQ. TANGO APPLE 500ML 	1	892166000358	1	1690	1	0	\N	\N
3492	CHAMPIÑONES LAMINADOS HOMAR 184G 	1	7804645050146	1	550	1	0	\N	\N
1269	MERMELADA FRAMBUEZA VIVO 200G	1	7802200400016	1	1100	1	0	\N	\N
3508	ROLLS BLANCO  140 GRS COSTA	1	7802215121241	1	1700	1	0	\N	\N
3506	CHORITOS NATURAL CONOSUR 190G 	1	8410721071227	1	1300	1	0	\N	\N
3030	SERVILLETAS 33X33 ELITE	73	7806500225522	1	550	1	0	\N	\N
3031	CHANTILLY LUCUMA 60G	1	7802800563036	1	690	1	0	\N	\N
3032	CHANTILLY MOKA 60G	1	7802800563029	1	690	1	0	\N	\N
3593	AVENA CHOCOLATE 50G	1	7803525999087	1	500	1	450	\N	\N
3034	YERBA MATE ORO MATE 250G	1	7804649510011	1	1550	1	0	\N	\N
2498	LAMINADO MANTECOSO LAS PARCELAS DE VALDIVIA 350G	1	7804619570045	1	3990	1	0	\N	\N
3035	YERBA MATE ISABELLE 250G	1	7804605470212	1	1550	1	0	\N	\N
3037	YERBA MATE ORO MATE 250G	1	7804649510042	1	1550	1	0	\N	\N
3038	ALCOHOL 70	1	7804614181925	1	1300	1	0	\N	\N
3039	YERBA MATE MAPUCHE 250G	1	7801840000105	1	1500	1	0	\N	\N
3067	FULL MASTICRUNCH 13G	1	7750885017763	1	150	1	0	\N	\N
4349	LIMPIA PISOS FABULOZO 2 LT 	1	100300	1	1300	1	0	\N	\N
3068	MENTITAS MASTI CRUNCH 13G	1	7750885017725	1	150	1	0	\N	\N
3069	CHOCOLITO FRUNA	62	7802408000650	1	250	1	0	\N	\N
3066	ADES SOJA NATURAL 1LT	1	7790895643859	1	3300	1	0	\N	\N
836	GALLETA SODA CLASICA  180 GR MCKAY	6	7802230086648	1	850	1	0	\N	\N
3267	SENSOR PLUS 	1	7809604500007	1	1300	1	0	\N	\N
3121	QUEQUE MARMOLADO CHOC/VAINILL 200 GR IDEAL	1	7793890252101	1	1000	1	0	\N	\N
3122	QUEQUE IDEAL 200G LIMON	1	7793890252118	1	1000	1	0	\N	\N
2803	YOGURT LOS ALERCES 125GRS 	1	7802920002521	1	200	1	0	\N	\N
2075	KENT 4 10	55	78021068	1	2500	1	0	\N	\N
2080	LUCKY STRIKE AZUL 10	55	78016408	1	2500	1	0	\N	\N
3072	NATURISIMO SAZONADOR 180G	1	7460123434725	1	1990	1	0	\N	\N
1160	SAPOLIO LIMON 450G 	1	7751851023054	1	990	1	0	\N	\N
1963	AQUARIUS MANZANA 500 ML ANDINA	53	7801610481004	1	750	1	0	\N	\N
3071	NATURELL MANZANA 90G	1	7804655061019	1	450	1	350	\N	\N
1660	KIT ESMALTE OLEOSO ANALIA 40ML	36	7804603700397	1	350	1	0	\N	\N
3073	BELMONT CLICK 20 UNIDADES	55	78024656	1	3800	1	0	\N	\N
3269	CONO SUELTO INDIVIDUAL GRANDE 	1	2000000001487	1	150	1	0	\N	\N
2839	ARROZ GLARGO OREGON 1KG 	1	7809637200028	1	1150	1	0	\N	\N
3135	QUESO RALLADO PARMESANO SOPROLE 80G	1	7802900001360	1	1390	1	0	\N	\N
3074	QUESO LAMINADO RAFULCO 500G	1	7804646540059	1	3100	1	0	\N	\N
3608	MUIBON 18G	1	7802800556175	1	200	1	0	\N	\N
878	NECTAR WATTS SELECCION MANGO/MARACUYA 1LT	5	7801620006211	1	1700	1	0	\N	\N
1989	NECTAR NARANJA  200 ML ANDINA 	38	7802820700091	1	250	1	0	\N	\N
1150	LIMPIADOR PISO FLOTANTE PRIMAVERA EXCELL 900CC	1	7805020001814	1	2990	1	0	\N	\N
887	LIMONADA LOVE LEMON PINK 475CC	5	7804643820123	1	1200	1	0	\N	\N
673	PALMITOS ENTEROS BONAFOOD 400GR	1	7801434001716	1	1650	1	0	\N	\N
1185	ARROZ BONANZA G1 GLARGO1KG	1	7808743604515	1	950	1	0	\N	\N
1174	QUESO MANTECOSO FUNDO LOS ALERCES 160G 	1	7802920005843	1	1250	1	0	\N	\N
3297	MOSTAZA TARTARA 240G 	1	7802351000660	1	1300	1	0	\N	\N
3075	HELADOS CUPULA 230CC 	1	2000000001432	1	500	1	0	\N	\N
1461	CILANTRO 	11	2000000000435	1	500	1	0	\N	\N
3618	NEGRITA BALLS 120G	1	7613037471601	1	1600	1	0	\N	\N
3300	PAÑO ESPONJA MERKAT 3UN 	1	7809635702746	1	1000	1	0	\N	\N
3077	ESPONJA METAL DORADA VIRUTEX 	1	2000000001449	1	650	1	0	\N	\N
3078	VITAL GASIFICADA 330CC	1	7802820330212	1	600	1	0	\N	\N
3076	MARUCHAN DE POLLO 85G	1	041789002915	1	850	1	0	\N	\N
3619	DOÑA GABY LAVALOZAS	1	7802660006872	1	650	1	0	\N	\N
791	PASTA DENTAL COLGATE LUMINOUS WHITE 90GR	2	7891024123027	1	2600	1	0	\N	\N
4032	SHAMPOO FAMILAND 750 ML 	1	7804945062344	1	2000	1	0	\N	\N
3328	SPRIM NARANJA NECTAR 190 ML	1	7802575220110	1	250	1	0	\N	\N
3301	CROQUETA SALMON 80G	1	7809611700384	1	550	1	0	\N	\N
1223	GALLETAS PRINCIPE CHOCOLATE BLANCO 84G	1	7441029515268	1	400	1	0	\N	\N
1212	PAN RALLADO IDEAL 250G	24	7803403002212	1	1100	1	950	\N	\N
1217	TKCHE 44G MARINELA 	1	7803473004758	1	400	1	300	\N	\N
1222	ROLLO 50G MARINELA 	1	7803473004741	1	300	1	0	\N	\N
1227	MANKEKE 120 G 	1	7803473004376	1	650	1	500	\N	\N
1211	PAN COMPLETO  415 GR IDEAL	24	7803473214058	1	1500	1	0	\N	\N
1102	CACAO POLVO AMARGO MARCO POLO 200GR	1	7802420119309	1	1200	1	0	\N	\N
2889	PAN DE PASCUA AGUA DE PIEDRA 900GR	1	7803403104015	1	4500	1	0	\N	\N
3086	ACEITE OIL 900ML	1	7804607500733	1	1150	1	0	\N	\N
230	JALEA FRAMBUESA 100 G 	1	7802200361140	1	350	1	0	\N	\N
2700	GALLETA NAVIDAD 220 GR COSTA	1	7802215506147	1	1050	1	0	\N	\N
2701	GRAN CEREAL CHOCOLATE 44G	1	7802215503009	1	250	1	0	\N	\N
587	SALSA DE CARNE MAGGI 33GR	1	7613031259328	1	690	1	0	\N	\N
1242	GALLETA AGUA S/SAL  180 GRS MCKAY	26	7802230086587	1	850	1	0	\N	\N
628	JALEA FRAMBUESA 110GR NESTLE	1	7613035281493	1	350	1	0	\N	\N
3099	ARROLLADO PRIMAVERA 20 UN.	1	7804653610172	1	3490	1	0	\N	\N
2801	AJI SALSA MONTTI 100GR	1	781718287173	1	300	1	0	\N	\N
3102	ARVERJAS MONTINA 200G	1	7804115001630	1	500	1	0	\N	\N
1097	SNACK MIXN DULCE EVERCRISP 100GR	6	7802000013379	1	1000	1	0	\N	\N
1101	CACAO POLVO DULCE MARCO POLO 200GR	1	7802420119286	1	800	1	0	\N	\N
601	SOPA MAGGI CARNE CON VERDURAS 72GR	1	7802950005288	1	450	1	0	\N	\N
158	FULL MASTI CRUNCH 16 G 	6	7750885006989	1	150	1	0	\N	\N
3347	TANAX MATA INSECTOS 220CC	1	7805300049154	1	2200	1	0	\N	\N
3348	SUPREMO ORIGINAL BLEND 40G	1	7801875000606	1	1000	1	0	\N	\N
3349	TALCO  80 GR BROOKS	73	7804910019434	1	1300	1	0	\N	\N
3196	NOVA CLASICA MEGAROLLO 25MT 	1	7806500401223	1	1890	1	0	\N	\N
4033	HEAD SHOULDERS ACEITE COCO 400ML 	1	7500435142557	1	3600	1	0	\N	\N
1248	ALTEZA OBLEA BOCADO 140 GRS	26	7802230082503	1	950	1	0	\N	\N
1245	ALTEZA OBLEA FRUTILLA 140 GRS	26	7802230082527	1	950	1	0	\N	\N
1246	ALTEZA OBLEA HELADO 140 GRS	26	7802230082534	1	950	1	0	\N	\N
1207	TORTILLA BURRERA  8 UNDS TIA ROSA	23	7803403000195	1	1750	1	1500	\N	\N
3100	EMPANADITAS DE QUESO 24UN.	1	7780201379169	1	2990	1	2200	\N	\N
3101	PRIMAVERA MONTINA 200G	1	7804115001661	1	650	1	500	\N	\N
3198	GARBANZOS BONANZA 1KG	1	7808743602498	1	1850	1	0	\N	\N
3112	TOALLITAS HUMEDAS HUGGIES 48 UN	73	7896018700628	1	1150	1	0	\N	\N
3117	GALLETAS DULCES ZOOLOGICO 800G	1	7750243049580	1	1990	1	0	\N	\N
3118	AQUAFRESH 85G	1	7794640171819	1	1350	1	0	\N	\N
3119	AQUAFRESH 158G	1	7794640171826	1	1500	1	0	\N	\N
3115	HARINA CON POLVO 1KG 	1	7802612000040	1	1000	1	0	\N	\N
3116	AZUCAR COLISEO 1 KILO	1	7804608220111	1	1000	1	0	\N	\N
3114	HARINA SIN POLVO 1KG 	1	7802612000057	1	1300	1	1000	\N	\N
3626	MAGISTRAL 300 ML 	1	7506309827483	1	1750	1	0	\N	\N
3352	PROTEX ALOE 125G	1	7891024113684	1	990	1	0	\N	\N
3197	ARROZ RINCON DEL SUR G2 1 KG	1	7808743602818	1	890	1	0	\N	\N
3360	GELATINA FRAMBUESA CARICIA	1	7802575281364	1	400	1	0	\N	\N
3361	CIF CREMA LIMON 750 CC	73	7791290008458	1	1990	1	0	\N	\N
1100	NESQUIK POLVO FRUTILLA 180GR	1	7613036838191	1	1400	1	0	\N	\N
1195	SOPA PARA UNO TOMATE 14G GOURMET	1	7802410371021	1	400	1	0	\N	\N
3322	JABON LIQUIDO CREMA HUMECTANTE  1000 ML BALLERINA	73	7804920350831	1	1400	1	0	\N	\N
3337	ANTIBAC ORIGINAL 400CC	1	7805300050716	1	1950	1	0	\N	\N
3338	SILICONA AEROSOL 650CC 	1	7827775554612	1	3350	1	0	\N	\N
3040	BABY LEE ACONDICIONADOR 900ML	1	7804920021410	1	1500	1	0	\N	\N
3516	PASTILLA BAÑO VAINILLA 40 GR OSO	73	7804520016373	1	650	1	0	\N	\N
3203	COLADO PAVO/VERD.215 GR NESTLE	1	7613030262374	1	1690	1	0	\N	\N
2894	GUALLARAUCO LIMONADA FRAMBUESA 500ML 	1	7803908005268	1	1100	1	0	\N	\N
8	ACOND. FRUCTIS BRILLO VITAMINADO 350 ML 	2	7509552914108	1	2500	1	0	\N	\N
2820	SALSA TARTARA DON JUAN 200G 	1	7802351631208	1	850	1	0	\N	\N
1288	LECHE EN POLVO COLUN DESCREMADA 600G	1	7802920005997	1	3890	1	0	\N	\N
3041	TANAX CASA Y JARDIN 440CC	1	7805300049666	1	3150	1	0	\N	\N
3376	HUEVITOS BON O BON BANDEJA 20U	1	7802225572651	1	2500	1	0	\N	\N
1289	CREMA BATIR  1 LT NESTLE	21	7802950022308	1	3100	1	0	\N	\N
415	GALLETA TUAREG 120 G 	6	7802215502262	1	650	1	0	\N	\N
1263	LECHE BLANCA DESCREMADA COLUN 1 LITRO 	1	7802920000084	1	1450	1	1200	\N	\N
3344	AROM VIRGINIA VAINILLA 225G	1	7805040000620	1	1250	1	0	\N	\N
3377	HUEVITOS BON O BON BOLSA 10U	25	7802225572569	1	1300	1	0	\N	\N
3378	HUEVITOS MACIZOS BOLSA 70U	25	7802225569613	1	4300	1	0	\N	\N
3379	HUEVITOS MACIZOS BANDEJA 22U	25	7802225571739	1	1500	1	0	\N	\N
3044	PROTEIN MILK CAPPUCCINO 1LT 	1	7802910007093	1	1500	1	0	\N	\N
3517	PASTILLA BAÑO FRUTILLA 40 GR OSO	73	7804520016397	1	650	1	0	\N	\N
2087	KENT 8 20	55	78021037	1	4000	1	0	\N	\N
1126	LONCO LECHE S/LACTOSA ENTERA 1 LITRO	1	7802910000971	1	1400	1	0	\N	\N
3046	ACEITE DE OLIVA PLATA 250ML 	1	7804616320155	1	2650	1	0	\N	\N
3048	ACEITE OLIVA BANQUETE 500 ML	1	7801420000600	1	5050	1	4490	\N	\N
1296	LECHE CHOCOLATE SURLAT 200ML 	1	7808709500813	1	380	1	0	\N	\N
3520	DESODORANTE FRUTILLA CREMA AMB.  320 CC AROM	73	7805040002860	1	1800	1	0	\N	\N
3509	TE SUPREMO MYSTIC CEYLAN 80 UN	1	7801875002044	1	2990	1	0	\N	\N
3510	TE SUPREMO CEYLAN EXPRESS 100 UN	1	7801875033062	1	2590	1	0	\N	\N
3512	SAL LOBOS 250G 	1	7803600002503	1	900	1	0	\N	\N
3513	SAL SELECCION  125 GRS LOBOS	1	78098152	1	500	1	0	\N	\N
3514	PASTILLA P/ESTANQUE PINO  40 GR OSO	73	7804520016403	1	650	1	0	\N	\N
3515	PASTILLA P/ESTANQUE LAVANDA  40 GR OSO	73	7804520016380	1	650	1	0	\N	\N
3521	AROM FANTASIA MARINA 225G	1	7805040000583	1	1450	1	0	\N	\N
3518	AROM FRUTILLA CREMA 225G	1	7805040000552	1	1450	1	0	\N	\N
3519	HOME SWEET HOME FLORAL 360 ML 	1	7804947001709	1	1800	1	0	\N	\N
57	BON O BON OBLEA 27 G 	6	7802225584609	1	200	1	0	\N	\N
2624	FILETILLOS SUPER POLLO 700G	1	7809611707468	1	3990	1	0	\N	\N
3523	AMBIENTADOR SAPOLIO ARRULLOS DE BEBE 360G	1	7751851006088	1	1890	1	0	\N	\N
3524	CHOLGAS AL NATURAL CONOSUR 190G 	1	8410721071272	1	1350	1	0	\N	\N
3525	ATUN LOMITOS EN ACEITE MAR DEL SUR 170G	1	7803505140089	1	1250	1	0	\N	\N
3051	VITAMINWATER NARANJA 500ML 	1	7790895001215	1	1300	1	0	\N	\N
3052	VITAMINWATER CITRICO TROPICAL 500ML 	1	7790895001239	1	1300	1	0	\N	\N
368	SHAMPOO BALLERINA SIN SAL PALTA Y ALMENDRA 900 ML 	2	7804920003225	1	2000	1	1500	\N	\N
3045	LONCO LECHE SIN LACTOSA 1LT 	1	7802910000988	1	1400	1	0	\N	\N
3053	FRUTI FRU 70ML 	1	7802408000681	1	300	1	0	\N	\N
3558	CLORO IMPEKE 1 LT	1	7806810028875	1	990	1	0	\N	\N
5350	HAMBURGUESA VEGANA 100GR	1	3*7801930021133	1	700	1	0	\N	\N
3632	CHICLE UNICORNIO 14G	1	78025387	1	200	1	0	\N	\N
3636	LIMPA VIDRIOS MR. MUSCULO 450CM 	1	7790520011831	1	1890	1	0	\N	\N
4036	BARIK FRESH AROMAS 45G	1	7800011000982	1	600	1	0	\N	\N
3637	LOMITOS AL AGUA ANTARTIC 160G 	1	7804621470777	1	1400	1	0	\N	\N
3532	MINI DONUTS 40G	1	7802215502286	1	250	1	0	\N	\N
3535	BARRA QUAKER MANZANA 20G	1	7802000003714	1	250	1	0	\N	\N
1360	CARNE MOLIDA VACUNO  250 GRS PF	20	7801930007878	1	1000	1	0	\N	\N
4350	ESPONJA LISA  SAPOLIO 	1	7751851027816	1	300	1	0	\N	\N
3540	DURAZNO TROCITOS WASIL 380G	1	7801305002057	1	1200	1	0	\N	\N
3541	NESCAFE 3 EN 1 24G 	1	7613035311565	1	300	1	0	\N	\N
3542	VIRUTEX ACERO CON JABON 	1	7806810002295	1	200	1	0	\N	\N
3544	TOALLAS HUMEDAS CHIKOOL GOLD 80U	68	6957931413161	1	1550	1	0	\N	\N
3547	ILICIT COLOR CHOCOLATE CEREZA 5.2	1	7804923066364	1	2000	1	0	\N	\N
3548	HARINA YANINE 3KG. 	1	7802612000019	1	2800	1	0	\N	\N
3550	YERBA MATE PAMPA 500 GR	1	7807901670836	1	2750	1	0	\N	\N
3551	YERBA MATE BRASILEÑA YTACUA 250	1	7790387800012	1	1600	1	0	\N	\N
3553	AMPOLLETAS 53W	1	7804660910012	1	650	1	0	\N	\N
3554	AMPOLLETAS 42W	1	7804660910005	1	650	1	0	\N	\N
1993	SPRITE 591 ML	48	7801610591994	1	1000	1	900	\N	\N
2004	SPRITE ZERO 1,5 LT	48	7801610223727	1	1700	1	1500	\N	\N
3546	ILICIT COLOR CEREZA 7.46	36	7804923031423	1	2150	1	2000	\N	\N
3545	ILICIT COLOR GRANADA 66.46	1	7804923031331	1	2150	1	2000	\N	\N
3537	GALLETA MINI MANTEQUILLA 40 GRS MCKAY	1	7613031651412	1	300	1	0	\N	\N
3534	GALLETA DE AGUA COSTA 210 G	1	7802215501401	1	850	1	0	\N	\N
1908	COCA COLA RETORNABLE 3 LT	49	7801610333129	1	2000	1	0	\N	\N
3536	GALLETA GRETEL CHOC.LECHE  85 GRS COSTA	1	7802215515019	1	1000	1	0	\N	\N
3243	ENCENDEDOR 	1	7804612131274	1	300	1	0	\N	\N
3555	AMPOLLETAS 70W	1	7804660910029	1	650	1	0	\N	\N
2083	PALLMALL MENTHOL CLICK 10	55	78019065	1	2100	1	2000	\N	\N
3556	ARROZ LOS CHINOS 1 KG 	1	7803110104025	1	1350	1	0	\N	\N
3557	ACEITE 900 CC RINCON DEL SUR	1	7808743604423	1	1600	1	0	\N	\N
3638	LOMITOS EN ACEITE ANTARTIC 160G 	1	7804621470784	1	1400	1	0	\N	\N
3639	MASCARILLAS FACIALES 	1	2000000001531	1	1000	1	0	\N	\N
3631	HORTALIZAS Y FRUTAS 1 KG MINUTO VERDE	7	7801220001388	1	2300	1	0	\N	\N
3640	BON O BON BLANCO Y NEGRO 	1	77956712	1	150	1	0	\N	\N
3568	SHAMPOO FRUCTIS ANTICASPA 350ML	1	7804960970778	1	2500	1	0	\N	\N
3570	CLORO GEL IMPEKE LIMON 900ML	1	7806810022187	1	1400	1	0	\N	\N
3571	CEREAL MONO CHOC 360G	1	7800120166517	1	2400	1	0	\N	\N
3552	JABON LAVAR    170 GR POPEYE	73	7805045001158	1	1100	1	0	\N	\N
3572	ENERGETICA BEAR BERRY	54	7804654560018	1	1400	1	0	\N	\N
3647	CONFORT SCOTT 6 ROLLOS 	1	7809604029782	1	1500	1	0	\N	\N
3574	IRONRADE 500G 	1	7804604728727	1	850	1	0	\N	\N
3575	CALDO VERDURA NATUREZZA 8G	1	7803700257094	1	100	1	0	\N	\N
3576	CALDO CARNE NATUREZZA 8G	1	7803700257070	1	100	1	0	\N	\N
3577	CALDO COSTILLA NATUREZZA 8G	1	7803700257087	1	100	1	0	\N	\N
3578	CALDO GALLINA NATUREZZA 8G	1	7803700257063	1	100	1	0	\N	\N
3579	DURACELL C 	1	041333000992	1	1500	1	0	\N	\N
2757	WATTS FRAMBUESA SIN AZUCAR 200G	1	7802810006219	1	1100	1	0	\N	\N
3581	ROKLETS	1	7802225427364	1	450	1	0	\N	\N
3582	EVEREADY 9V1	1	039800011626	1	1000	1	0	\N	\N
3649	ARROZ INTEGRAL MIRAFLORES 1 KG 	1	7800120737427	1	2000	1	1850	\N	\N
2071	KENT 4 20	55	78021044	1	4000	1	0	\N	\N
3584	DEDALITOS 250 GR CAROZZI.	1	7802575012197	1	500	1	0	\N	\N
4351	JABON BALLERINA 350 ML 	1	7804920350176	1	1200	1	900	\N	\N
3585	SALCHICHA TRADICIONAL SAN JORGE 250G	1	7801907008402	1	700	1	0	\N	\N
3538	GALLETA MININIZA 40 GR MCKAY	1	7613031651443	1	300	1	0	\N	\N
3650	COLUN SIN LACTOSA SEMIDESC. 1LT 	1	7802920009322	1	1300	1	0	\N	\N
3586	JABON BARRA ROSA VENUS 	1	7501026027185	1	600	1	0	\N	\N
3588	DULCE DE MEMBRILLO MERKAT 500G 	1	7804000000908	1	1200	1	0	\N	\N
3592	POROTO VERDE CORTE FRANCES  350 GR FRUTOS DEL MAIPO	7	7801300000034	1	1100	1	0	\N	\N
3656	SUPREMO RENDIDORA 50 BLS. 	1	7801875032041	1	1150	1	0	\N	\N
3657	AMPOLLETA WESTINGHOUSE 75 W	1	3000721900013	1	900	1	0	\N	\N
3645	HELLMANS KETCHUP 1 LT	1	7802640720545	1	2650	1	0	\N	\N
3580	MARGARINA SUREÑA POTE 500 GRS	1	7802810022387	1	1990	1	0	\N	\N
3646	KETCHUP HELLMAN´S 500GR	1	7802640720538	1	1750	1	0	\N	\N
3654	HARINA INTEGRAL EL PERAL 1 KG	1	7802651000131	1	1100	1	0	\N	\N
3659	VELAS ANTORCHA 	1	7805007139738	1	1200	1	0	\N	\N
3660	DURAZNOS EN CONSERVA CENTAURO 820G	1	7801256001017	1	1600	1	0	\N	\N
3590	COLUN DESCREMADA SIN LACTOSA 1LT 	1	7802920009339	1	1300	1	0	\N	\N
3569	CONFORT 8 ROLLOS 27 MTS 	1	7806500506980	1	2400	1	0	\N	\N
4355	JABON HIPOALERGENICO DOYPACK  1 LT BALLERINA	73	7804920350862	1	1400	1	0	\N	\N
3057	NOBLE D/H CON ROLLITO X4 UN	73	7806500508137	1	1250	1	0	\N	\N
3661	SALSA DE SOYA TRADICIONAL GOURMET 165CC	1	7802410416302	1	1550	1	0	\N	\N
3662	GEL DE PELO LAKES 220GR	1	7809634801723	1	1300	1	0	\N	\N
3665	LECHE EN POLVO ENTERA 1KG	1	7804606290932	1	5200	1	0	\N	\N
3666	DETERG. LIQUIDO DOÑA GABY FLORAL 3 LT 	1	7804655190467	1	4990	1	0	\N	\N
3667	DETERG. LIQ. DOÑA GABY BOSQUE ENCANTADO 3LT 	1	7804655193178	1	4990	1	0	\N	\N
3668	YERBA MATE COLON SUAVE 500G	1	7840037014624	1	2300	1	0	\N	\N
3669	VAINILLA LA PRIMERA 250G 	1	7802410281009	1	990	1	0	\N	\N
770	GALLETA CEREAL MIX BERRIES 115GR	6	7802225688796	1	650	1	0	\N	\N
3244	JABON ESSENTIAL 2 LT 	1	7812110030043	1	1500	1	0	\N	\N
3672	NOVA MEGA ROLLO 32MTS	1	7806500406105	1	1350	1	0	\N	\N
3674	CHORICILLO COCKTAIL PF 180 GRS	1	7801930006390	1	1200	1	0	\N	\N
3673	SOPA POLLO ARROZ  1 UN MAGGI	1	7802950006629	1	450	1	0	\N	\N
3655	POLVO HORNEAR IMPERIAL 100G 	1	7802950008777	1	850	1	0	\N	\N
3587	SALAME AHUMADO PF 100G	1	7801930017952	1	2200	1	2000	\N	\N
3589	COLUN ENTERA SIN LACTOSA 1LT	1	7802920009315	1	1450	1	1300	\N	\N
3675	PARCHE CURITA 	1	2000000001548	1	30	1	0	\N	\N
3651	CEBOLLA EN ESCABECHE UNIDAD	31	315	1	250	1	0	\N	\N
3601	VIENESA LA ESPAÑOLA 220 UN	1	7801930015279	1	2400	1	0	\N	\N
3606	ENO REGULAR 5G	1	7794640170881	1	250	1	0	\N	\N
3607	ENO LIMON 5G	1	7794640170904	1	250	1	0	\N	\N
3611	MONO ROLLS 230G	1	7802215166525	1	1900	1	0	\N	\N
3612	CAREZZA BARRA  160 GR COSTA	1	7802215101335	1	1900	1	0	\N	\N
3613	VIENESA DE POLLO MONTINA 250G	1	7801965005603	1	500	1	0	\N	\N
3614	VELA ARELA 4 UN. 	1	7805025690488	1	700	1	0	\N	\N
3615	PIZZA JAMON QUESO PF 465G 	1	7801930013268	1	3100	1	0	\N	\N
3616	PANCETA AHUMADA 150G 	1	7801930000602	1	2500	1	0	\N	\N
3082	MI HOGAR DOBLE HOJA 27MT. 	1	7804653340581	1	1150	1	0	\N	\N
3676	DORINA MARGARINA 125G	1	8719200694156	1	450	1	0	\N	\N
4356	JABON BALLERINA 1 LT 	1	7804920005588	1	1600	1	0	\N	\N
376	SHAMPOO PANTENE HIDRATACIÓN EXTREMA 400 ML 	2	7506309840024	1	2650	1	0	\N	\N
3083	SOPROLE MANTEQUILLA UNTABLE 350G	1	7802900001377	1	2990	1	0	\N	\N
3084	CREMA HUMECTANTE DOVE 200ML 	1	7501056346188	1	2300	1	0	\N	\N
3087	PIÑAS RODAJAS ESNERALDA 820G	1	7801315151608	1	2200	1	0	\N	\N
3089	NESTUM ARROZ 250 GR	1	7613036048132	1	1900	1	0	\N	\N
2537	COLONIA LILA BABYLAND 210ML 	1	7804945076143	1	1790	1	0	\N	\N
3090	NESTUM CACAO 250G 	1	7613036048019	1	1900	1	0	\N	\N
3091	ARROZ CARRUSEL G2 1KG 	1	7808743604973	1	1100	1	0	\N	\N
3092	AZUCAR SHOGUN 1 KG 	1	7804627780016	1	750	1	0	\N	\N
3093	VASOS CUMPLEAÑOS ELY 500CC 10UN 	1	7898509281517	1	990	1	0	\N	\N
3094	TENEDORES PLASTICOS UNIDAD 	1	2000000001456	1	70	1	0	\N	\N
3095	CUCHARAS PLASTICAS UNIDAD	1	2000000001463	1	80	1	0	\N	\N
3096	CONSOME DE POLLO 15G	1	7802410000341	1	400	1	0	\N	\N
3610	PAN BLANCO MOLDE 750 GR IDEAL	24	7803473002662	1	2600	1	2200	\N	\N
3653	ACEITE MERKAT 900 ML 	1	7790272000558	1	2500	1	1300	\N	\N
3600	RAMITAS QUESO 250G	1	7802000014123	1	2000	1	1800	\N	\N
3617	CHEETOS DE QUESO 55G	1	7802000013683	1	500	1	0	\N	\N
3097	SOPA DE CARNE 15G	1	7802410000358	1	400	1	0	\N	\N
3098	MARUCHAN POLLO PICANTE 64G	1	041789001840	1	700	1	0	\N	\N
4382	QUESO LLANERO 	1	997	2	10500	1	0	\N	\N
2730	ESCOBILLON EL GLADIADOR 	1	664697118976	1	2000	1	0	\N	\N
2733	ESPONJA DORADA INOXIDABLE ARUBA 	1	7804645200008	1	480	1	0	\N	\N
3107	PROTECTORES CAREFREE 15 UN.	1	7702031500605	1	700	1	0	\N	\N
3109	AUDIFONO MAXELL EB95	1	025215492891	1	1500	1	0	\N	\N
3110	AUDIFONOS ATEREO DBLUE 	1	4710007730836	1	2500	1	0	\N	\N
3111	PIÑAS EN RODAJAS BONAFOOD 340G	1	7801434001747	1	1100	1	0	\N	\N
3623	BIOFRESCURA BOSQUE NATIVO 3LT 	1	7804609730305	1	6200	1	0	\N	\N
3624	ROLLS CRISPY BERRIES  140 GR COSTA	1	7802215121326	1	1700	1	0	\N	\N
3625	ALFAJOR PREMIUM  60 GR CALAF	47	7802220776474	1	450	1	0	\N	\N
4358	TE DE HOJA EMBLEM CEYLON 125G	1	7805000314767	1	1900	1	0	\N	\N
3628	TE EMBLEM 100 UNDS	1	7801810117543	1	2650	1	0	\N	\N
3630	GARBANZOS AGROPRODEX 1GK 	1	7803920050734	1	2100	1	0	\N	\N
2128	PAN DE CENTENO	59	801	2	3500	1	0	\N	\N
1298	CREMA BATIR COLUN 200 ML 	1	7802920777283	1	890	1	0	\N	\N
2709	DONASEPT NORMAL C/ALAS 8 UN	73	7702026173494	1	850	1	0	\N	\N
2710	KOTEX ULTRAFINA 8 UN.	1	7809604028211	1	900	1	0	\N	\N
1816	NOSOTRAS NORMAL C/ALAS 8UN. 	36	7804902111467	1	850	1	0	\N	\N
2823	CRUNCHIS PLATANO 270G	1	7802420004438	1	1500	1	0	\N	\N
2824	MAGNUM CLASICO 78ML 	1	7805000310486	1	1790	1	1590	\N	\N
1299	CREMA BATIR SURLAT 200 ML 	1	7808709500196	1	750	1	0	\N	\N
3627	CANADA DRY ZERO 2.0 LT PET	75	7801620008055	1	1100	1	1300	\N	\N
3622	KENT BLUE UP 	1	78025271	1	4400	1	4200	\N	\N
66	BRILLINA TIERRA DE COLOR 360 CM3 	2	7805040001474	1	1550	1	1300	\N	\N
3081	ARIEL DOWNY 400G	1	7500435111270	1	1200	1	1100	\N	\N
3602	CHEETOS 300G 	1	7802000014390	1	2000	1	1950	\N	\N
2711	MARCO POLO CASERAS 240G	1	7802420150104	1	2500	1	2200	\N	\N
3106	PAPAS FRITAS MONTINA 2.5 KG	1	2087189060009	1	6490	1	0	\N	\N
1301	LECHE ENTRERA COLUN 200ML 	1	7802920801858	1	450	1	0	\N	\N
1305	CREMA LISTA SIN LACTOSA 200ML LONCO LECHE 	1	7802910004177	1	1100	1	0	\N	\N
1306	LECHE VAINILLA 200 ML COLUN 	1	7802920106106	1	400	1	0	\N	\N
1308	DURAZNOS MITADES EN CONSERVA MERKAT 3KG	1	7801800104584	1	4500	1	0	\N	\N
1237	GALLETON AVENA CRANBERRIES NATURALE 50G 	1	7803480000903	1	400	1	0	\N	\N
1179	HARINA DE MAIZ BLANCO PRECOCIDA 1KG	1	739907000010	1	1990	1	0	\N	\N
77	CHOCO BRESLER 80 ML 	7	7805000307059	1	690	1	0	\N	\N
1209	PAN BLANCO ARTESANAL  600 GRS IDEAL	24	7803403000447	1	2100	1	0	\N	\N
252	JUGO ZUKO DAMASCO 25 GRAMOS 	1	7802800578863	1	200	1	0	\N	\N
598	CALDO COSTILLA  8 TABL. MAGGI	1	7613033822315	1	850	1	0	\N	\N
596	CALDO MAGGI CEBOLLA/AJO 80GR	1	7613035189713	1	900	1	0	\N	\N
725	NESCAFE TRADICIONAL   50 GRS	1	7802950002119	1	1790	1	0	\N	\N
2714	CHORITOS EN ACEITE COLORADO 190G 	1	7801255000318	1	1200	1	0	\N	\N
2715	CHORITOS AL NATURAL COLORADO 190G	1	7801255000301	1	1150	1	0	\N	\N
2826	FUROR OBLEA 40G	1	7801552001476	1	200	1	0	\N	\N
1310	DURAZNO TROCITOS  3 KG ACONCAGUA	17	7801800100371	1	5690	1	0	\N	\N
2827	CAÑONAZO  25 GR FRUNA	47	7802408003668	1	200	1	0	\N	\N
580	GELATINA DAILY FRAMBUESA 22.5GR	1	7809558102449	1	600	1	0	\N	\N
579	GELATINA DAILY NARANJA 22.5GR	1	7809558102463	1	600	1	0	\N	\N
1542	BOLSAS PARA DULCES DE CUMPLEAÑOS AVENGERS 	34	5201552519988	1	0	1	0	\N	\N
597	CALDO VERDURA  8 TABL. MAGGI	1	7613033822285	1	990	1	0	\N	\N
595	CALDO MAGGI LONGANIZA 80GR	1	7613030870753	1	1000	1	0	\N	\N
726	CAFE GOLD TARRO PRIMERA SEL. 50GR	1	7802800500635	1	1500	1	0	\N	\N
824	MASTER SUAVE 5LT	2	945127003	1	2600	1	0	\N	\N
242	JUGO SPRIM MANGO 35 GAMOS 	1	7802575222961	1	190	1	0	\N	\N
256	JUGO ZUKO HUESILLO 25 GRAMOS 	1	7802800578900	1	200	1	0	\N	\N
723	CAFE DESCAFEINADO TARRO MONTERREY 50GR	1	7802800500468	1	1650	1	0	\N	\N
3120	GALLETAS MEDIA TARDE 300G	1	7802225680530	1	1390	1	1200	\N	\N
1208	PREPIZZA CLASICO  500 GR IDEAL	19	7803403236341	1	1800	1	1600	\N	\N
63	CARTE DOR POSTRE ALMENDRADO BRESLER 1 LITRO 	7	7802705618398	1	3490	1	0	\N	\N
254	JUGO ZUKO FRAMBUESA 25 GRAMOS 	1	7802800578856	1	200	1	0	\N	\N
1178	VELAS BLANQUITA 4UN 36G	1	1971083100682	1	550	1	0	\N	\N
1673	SALSA DE AJO DON JUAN 100G	1	1007	1	550	1	0	\N	\N
1148	LUSTRA MUEBLES LAVANDA 5X1 280ML INTRA PREMIO 	1	7751851011112	1	1250	1	0	\N	\N
1274	MANTECA  100 GRS ASTRA	21	7802810006844	1	550	1	0	\N	\N
84	CHOCOLATE ORLY TRUFA 115 G 	6	7802200894150	1	1100	1	1000	\N	\N
823	MATIC DOÑA GABY 3 KG	2	7804655190047	1	4300	1	0	\N	\N
263	JUGO ZUKO PIÑA 25 GRAMOS 	1	7802800578825	1	200	1	0	\N	\N
248	JUGO SPRIM PAPAYA 	1	7802575223104	1	190	1	0	\N	\N
2807	YOGURT CALAN FRUTILLA 1KG	1	7802955003999	1	1200	1	0	\N	\N
2808	YOGURT CALAN VAINILLA 1KG 	1	7802955004033	1	1200	1	0	\N	\N
2809	FILETITOS DE POLLO SIN MARINAR SADIA 800G	1	7891515499662	1	3390	1	0	\N	\N
2716	SILICONA AUTO SAPOLIO 360ML 	1	7751851006248	1	1600	1	0	\N	\N
2778	E LONG ENERGY DRINK 500 CC	54	7804604726181	1	1000	1	0	\N	\N
1154	SAPOLIO ATA ARAÑAS 360 ML	1	7751851010283	1	2500	1	0	\N	\N
2717	PANTENE BRILLO EXTREMO 200ML 	1	7501007457789	1	1250	1	0	\N	\N
2718	PANTENE MICELAR 200ML 	1	7500435128599	1	1250	1	0	\N	\N
2719	PANTENE RIZOS DEF. 200ML 	1	7501001169091	1	1250	1	0	\N	\N
2722	LAVALOZAS SAPOLIO 750ML 	1	7751851010764	1	1300	1	0	\N	\N
2723	LAVALOZAS SAPOLIO 1250 ML 	1	7751851025089	1	2000	1	0	\N	\N
1657	ADAPTADOR DE ENCHUFE	35	451	1	900	1	0	\N	\N
2754	TRAPERO HUMEDO EXCELL 5 UN. 	1	7805020002002	1	1400	1	0	\N	\N
2755	WATTS MORA SIN AZUCAR 200G	1	7802810006202	1	1100	1	0	\N	\N
2756	WATTS DAMASCO SIN AZUCAR 200G	1	7802810006196	1	1100	1	0	\N	\N
2720	HEAD SHOULDERS CONTROL GRASA 180ML 	1	7500435019576	1	1500	1	0	\N	\N
594	CALDO MAGGI SABOR POLLO DE CAMPO 80GR	1	7613032875114	1	900	1	0	\N	\N
2725	NOVA ULTRA MEGAROLLO 32MT 	1	7806500406204	1	2700	1	0	\N	\N
706	HARINA C/POLVOS PUENTE ALTO 1KG	1	7809559200045	1	950	1	0	\N	\N
1800	JABON LIQ. TANGO ALOEVERA	36	892166000389	1	1690	1	0	\N	\N
1443	MANTEQUILLA  125 GR SOPROLE	21	7802900120016	1	990	1	0	\N	\N
1798	JABON LIQ. TANGO GREEN APPLE 500ML 	36	8692641009911	1	1690	1	0	\N	\N
2724	AVENA INSTANTANEA QUAKER 500G 	1	7802600133217	1	1400	1	0	\N	\N
2770	MITI MITI MENTA 100G	1	78022386	1	100	1	0	\N	\N
2777	BETUN LIQUIDO NEGRO  60 ML VIRGINIA	73	7805040001658	1	1600	1	0	\N	\N
2592	SUPER 8 CHUAA 42 GR 	47	7613031353927	1	300	1	0	\N	\N
2298	MOLINO YANINE 3 KGS 	1	7802612000248	1	2300	1	0	\N	\N
2301	SOPROLE NEX 500G	1	7802900639013	1	1750	1	0	\N	\N
2302	ALCOHOL SANY FARM 250 ML 	1	7804614181635	1	1300	1	0	\N	\N
2304	TOALLAS HUMEDAS OPTIMO 50UN. 	1	7804663190015	1	1000	1	0	\N	\N
2096	BARRA CEREAL CHOCAPIC	1	5900020028075	1	250	1	0	\N	\N
495	CACHANTUN C/GAS 1,6 LTS	5	7801620852955	1	650	1	0	\N	\N
532	GATORADE FRUTAS TROPICALES 750 ML	5	7801620005184	1	900	1	0	\N	\N
966	KEM XTREME SUGAR FREE  DES. 1.5LT	5	7801620006112	1	1500	1	0	\N	\N
2758	SEMOLA FRAMBUESA  140 GR SOPROLE	1	7802900220082	1	600	1	0	\N	\N
3245	JABON ESSENTIAL 2LT 	1	7812110030012	1	1500	1	0	\N	\N
1091	PAPAS MOMS LISA EVERCRISP 280GR	6	7802000011122	1	1500	1	0	\N	\N
501	NECTAR WATTS DURAZNO 200 ML	5	7802810006325	1	250	1	0	\N	\N
2108	KUKY CHIP CHIPERS 190G 	1	7613034891730	1	1300	1	1100	\N	\N
1307	LECHE VAINILLA SEMIDES. LONCO LECHE 1 LT	1	7802910000261	1	1600	1	0	\N	\N
2109	GALLETA GRILL 35 GR	26	7613030008897	1	250	1	0	\N	\N
2110	GRILL ALBAHACA 35G 	1	7613036468329	1	250	1	0	\N	\N
2111	GALLETA AGUA FAMILIAR  205 GRS MCKAY	26	7802230086570	1	750	1	0	\N	\N
986	CARAMELO MENTA/CHOCOLATE AMBROSOLI UND	6	224	1	100	1	0	\N	\N
2775	WATTS DURAZNO 1.75 LT	76	7801620007256	1	1350	1	0	\N	\N
1007	KRYZPO QUESO 100GR	1	7802800534456	1	1000	1	0	\N	\N
2593	GALLETA MINI COCO 40 GR MCKAY	1	7613031651474	1	300	1	0	\N	\N
2315	GALLETA GRETEL CHOC. BLANCO  85 GRS COSTA	26	7802215515026	1	1000	1	0	\N	\N
1255	GALLETA CRIOLLITA 100 GRS MCKAY	26	7802230082831	1	1290	1	1000	\N	\N
2314	GALLETA GRETEL YOG/FRUTILLA  85 GRS COSTA	26	7802215515064	1	1000	1	0	\N	\N
1442	MANTEQUILLA C/SAL  250 GR SOPROLE	21	7802900121013	1	2250	1	0	\N	\N
2776	WATTS NARANJA 1.75 LT	76	7801620007539	1	1350	1	0	\N	\N
2774	WATTS PIÑA 1.75 LT	76	7801620007546	1	1350	1	0	\N	\N
1528	BOMBILLAS PLASTICA DESECHABLES 12UN 	34	6922332110728	1	800	1	0	\N	\N
1717	MANZANA VERDE 	11	134	2	1000	1	0	\N	\N
302	MI PERRO CHOCOLO BRESLER 60 ML 	7	7805000318048	1	690	1	0	\N	\N
2595	VALOR 85 CACAO NEGRO SIN AZUCAR 	1	8410109109832	1	3200	1	0	\N	\N
3930	ATU  DESMENUZADO ESMERALDA 170G 	1	7801315135295	1	1000	1	0	\N	\N
1062	MANI SALADO EVERCRISP 30GR	6	7802000013133	1	500	1	0	\N	\N
4360	SERVILLETAS ELITE 220UN	1	7806500221357	1	1600	1	0	\N	\N
4362	GALLETA FAMILIAR SANTIAGO 375G	1	7802264020007	1	1390	1	0	\N	\N
2042	HAMBURGUESA VACUNO LA ESPAÑOLA 50 GRS	20	7801930015224	1	120	1	0	\N	\N
2009	LECHE FRUTILLA  200 ML SOPROLE	21	7802900056025	1	450	1	0	\N	\N
920	BIGTIME SEVEN CRYSTALMINT 7UN	6	78024335	1	450	1	0	\N	\N
2773	FLAN TOFFE GOLD 120G	1	7802900002152	1	450	1	0	\N	\N
919	BIGTIME SEVEN MINT 7UN	6	78024090	1	450	1	0	\N	\N
922	BIGTIME ULTRA RED BERRY 24GR	6	7794612413831	1	900	1	0	\N	\N
2300	QUESO RANCO 9 LAMINAS COLUN 	1	7802920004129	1	1700	1	0	\N	\N
2242	RIO BUENO COLUN 8 LAMINAS 	1	7802920006345	1	1750	1	0	\N	\N
1214	AZUCAR COLISEO 5 KILOS 	1	7804608220180	1	3200	1	0	\N	\N
2011	NECTAR NARANJA  1 LT VIVO	38	7802575226310	1	850	1	0	\N	\N
2013	HELADOS DE INVIERNO PACK	6	1500	1	1250	1	0	\N	\N
1001	JUGO LIVEAN LIMONADA 7GR	1	P003	1	200	1	0	\N	\N
2016	SURLAT SEMIDESCREMADA CHOC... 	1	7804617470279	1	380	1	0	\N	\N
2017	NECTAR PIÑA  1 LT VIVO	38	7802575226327	1	850	1	0	\N	\N
2024	PATE TERNERA LA PREFERIDA 125G	1	7801916031392	1	650	1	0	\N	\N
319	PALMITOS ENTEROS WASIL 400 GRAMOS 	1	7801305133645	1	2200	1	0	\N	\N
583	BASE MAGGI POLLO CRISPY 80GR	1	7613030019060	1	690	1	0	\N	\N
2023	PATE TERNERA SAN JORGE 125G 	1	7801907004305	1	750	1	400	\N	\N
2010	LECHE PLATANO SEMIDESCREMADA  200 ML LONCOLECHE	21	7802910001046	1	450	1	0	\N	\N
1093	MANI SALADO EVERCRISP 160GR	6	7802000013164	1	1350	1	1100	\N	\N
366	SHAMPOO BALLERINA MICELAR AGUA DE COCO Y FLOR DE CACTUS 900ML	2	7804920005861	1	1400	1	0	\N	\N
2597	ARROZ PUERTAS COLORADAS G2 1 KG	1	7804653410031	1	850	1	0	\N	\N
2321	TRENCITO 24G 	1	7613034276490	1	400	1	0	\N	\N
464	ACEITE VEGETAL OLIN 250G	1	7804607500726	1	550	1	0	\N	\N
2728	BETUN MARRON LIQUIDO  60 CC NUGGET	73	7501058743145	1	1550	1	0	\N	\N
1837	MANTECA CRUCINA 200GRS	1	7802810022158	1	1000	1	0	\N	\N
4363	GALLETA FAMILIAR SANTIAGO 375 G	1	7802264000344	1	1390	1	0	\N	\N
2729	TOALLA ROMANO XL 	1	7804659790014	1	1500	1	0	\N	\N
1838	MANTECA  200 GRS ASTRA	21	7802810006837	1	2100	1	0	\N	\N
747	TE YELLOW LABEL  10 UN LIPTON	1	7801810712847	1	650	1	0	\N	\N
2316	TARTALETA GRANDE 	12	652	1	8000	1	0	\N	\N
2734	JABON LIQUIDO IO 350ML 	1	7804932000151	1	690	1	0	\N	\N
2735	JABON LIQUIDO IO 350 ML 	1	7804932000137	1	690	1	0	\N	\N
2736	JABON LIQUIDO IO 350ML 	1	7804932000854	1	690	1	0	\N	\N
1839	YOGHURT CON FRUTILLA  110 GR GRIEGO	21	7802900231828	1	400	1	0	\N	\N
1189	FIDEOS INSTANTANEOS POLLO TRAVERSO 	1	7802337939021	1	700	1	0	\N	\N
1843	MANI MERKEN 100G CAMILA 	6	7804623100252	1	700	1	0	\N	\N
1854	LECHE COLUN CHOCOLATE 	1	7802920007182	1	400	1	0	\N	\N
1855	YOGU YOGU FRUTILLA 200 ML	21	7802910301207	1	350	1	0	\N	\N
1856	SOPROLE ZEROLACTO CHOCOLATE 200G 	1	7802900197070	1	450	1	0	\N	\N
2251	SEDAL RIZOS DEFI. 190ML 	1	7791293030753	1	990	1	0	\N	\N
895	BEBIDA NESQUIK FRUTILLA 200ML	4	7802950005677	1	450	1	0	\N	\N
4037	PALMITOS ESMERALDA RODAJAS 400G	1	7802420510151	1	1890	1	1650	\N	\N
298	MAYONESA HELLMANNS 93 GRAMOS 	1	7805000301484	1	800	1	0	\N	\N
670	MAYONESA HELLMANNS 186GR	1	7803200804378	1	1350	1	0	\N	\N
2596	LUCKY CRUSH 20	55	78024892	1	4700	1	4500	\N	\N
94	CLORINDA CONCENTRADO 500 G	2	7805080692519	1	800	1	0	\N	\N
894	LECHE MILO  200 ML NESTLE	4	7802950006209	1	600	1	450	\N	\N
2320	SAHNE-NUSS 30G	1	7613035588776	1	500	1	0	\N	\N
315	NOGGER BRESLER 85 ML 	7	7805000307097	1	1100	1	990	\N	\N
893	LECHE SVELTY CACAO S/LACTOSA 200ML	4	7613036441940	1	450	1	0	\N	\N
905	DULCE CALAF SUNNY UNIDAD 	6	208	1	0	1	0	\N	\N
1514	ESPARRAGO 	11	128	2	1000	1	0	\N	\N
835	BOLSA BASURA CLEAN 50 X 70 CM.	2	7801875001306	1	600	1	0	\N	\N
1778	ESPONJA ACANALADA UN 	2	048	1	250	1	0	\N	\N
28	AMPOLLETAS PHILIPS 53 W 	1	8718699591199	1	650	1	0	\N	\N
674	PALMITOS EN RODAJA BONAFOOD 400GR	1	7801434001730	1	1400	1	0	\N	\N
4357	JABON BALLERINA 1 LT 	1	7804920005571	1	1600	1	0	\N	\N
114	AXE MARINE 150 ML 	2	7791293025827	1	2500	1	0	\N	\N
2625	QUESILLO COLUN DE CAMPO 320G	1	7802920000732	1	1590	1	0	\N	\N
2626	JUREL BARQUITO 425G	1	7804611550694	1	1100	1	0	\N	\N
1913	RUCAS SELECT ARTESANAS 	1	6917554726338	1	1100	1	0	\N	\N
904	CRICRI MASTI CRUNCH 16.2 GR AMBROSOLI	6	7750885009089	1	150	1	0	\N	\N
461	ARROZ CURRY CHAMPIÑON TUCAPEL 210G	1	7801420500025	1	1100	1	0	\N	\N
638	CHANDELLE LUCUMA  130 GRS NESTLE	4	78057241	1	700	1	0	\N	\N
1665	SAL DE MAR A GRANEL 	11	132	2	850	1	0	\N	\N
1942	COCA COLA DESECHABLE 1 LTS	48	7801610001974	1	1100	1	0	\N	\N
72	CHANCACA DELICIOSA 225 G 	1	7805040413130	1	1100	1	0	\N	\N
1945	COCA COLA ZERO EXPRESS 237CC	1	8004	1	300	1	0	\N	\N
1756	PROT.DIARIO DONASEPT 15 UN	16	7702026147068	1	500	1	0	\N	\N
1765	PVC FILM 30MTS 	2	3000	1	1800	1	0	\N	\N
1766	FOIL ALUMINIO VANNI 7.5MT	2	3001	1	1550	1	0	\N	\N
1769	LAV. TRIONER 200CC 	1	7805094000782	1	550	1	0	\N	\N
1770	LIMPIA VIDRIOS SODAK 500CC 	2	9201804500111	1	1100	1	0	\N	\N
1773	DESODORANTE INODORO OSO 40G 	2	7804520023586	1	490	1	0	\N	\N
1774	DESODORANTE INDORO OSO 40G	2	7804520023579	1	490	1	0	\N	\N
1776	VIRUTILLA DORADA CLEANIG	2	046	1	450	1	0	\N	\N
1775	ESPONJA METALIA MANLAC	2	7806800004018	1	230	1	0	\N	\N
1685	VANISH COLORES VIVOS 400ML 	22	7805010205703	1	990	1	0	\N	\N
2020	HUILCO MANTECOSO LAM. 250G 	1	7804647570116	1	2500	1	0	\N	\N
175	GALLETAS FRAC VAINILLA 130 G 	6	7802215512285	1	700	1	600	\N	\N
1948	TENEDOR PLASTICO DESECHABLE ROSA	1	9000000043664	1	500	1	0	\N	\N
1929	COCA COLA ZERO DESECHABLE 3 LT	49	7801610305560	1	2400	1	0	\N	\N
1531	TENEDOR PLASTICO DESECHABLE VERDE 	34	9000000043640	1	500	1	0	\N	\N
238	JUGO SPRIM DURAZNO 35 GRAMOS 	1	7802575222916	1	190	1	0	\N	\N
1927	COCA COLA ZERO 591 ML	48	7801610000601	1	900	1	0	\N	\N
4364	GALLETA FAMILIAR SANTIAGO 375G	1	7802264020403	1	1390	1	0	\N	\N
1951	TAI PIÑA 2LT DESCH. 	50	7801610035719	1	600	1	0	\N	\N
4047	SHAMPOO FAMILAND 750 ML 	1	7804945062665	1	2000	1	0	\N	\N
1530	TENEDOR PLASTICO DESECHABLE AMARILLO 	34	9000000043619	1	500	1	0	\N	\N
1947	COCA COLA ZERO 1 LT	48	7801610350904	1	1100	1	0	\N	\N
2628	GALLETA SODA LIGHT FAMILIAR  180 GR MCKAY	1	7613031214884	1	800	1	0	\N	\N
2630	BENEDICTINO SABOR PERA 500ML	1	7802820452181	1	690	1	0	\N	\N
2631	BENEDICTINO SABOR MANZANA 500ML 	1	7802820452105	1	690	1	0	\N	\N
1796	JABON CITRUS C2 85G 	36	7840118212581	1	350	1	0	\N	\N
2348	PAÑAL DES. RN 20 UNDS HUGGIES	68	7794626004001	1	3600	1	0	\N	\N
2349	KOTEX ULTRAFINA 8 UN C/ALAS	16	7809604029270	1	730	1	0	\N	\N
2351	CASSATA BRICK 1 LT 	1	7802710350504	1	2350	1	0	\N	\N
2350	CARAMELOS CICLOPE 60 UN. 	1	7802225313476	1	1350	1	0	\N	\N
2353	LENGUAS DE GOMITAS 40 UN.	1	7802215270055	1	2950	1	0	\N	\N
2354	HALLOWEEN MASTICABLES 600GR 	1	7802200112957	1	3800	1	0	\N	\N
2355	GOMITAS AMBRODIENTES 300G	1	7802200127579	1	2950	1	0	\N	\N
1943	COCA COLA DESECHABLE 1,5 LT	48	7801610001622	1	1700	1	0	\N	\N
1740	HUEVO EXTRA GRANEL	1	501	1	180	1	150	\N	\N
1926	COCA COLA LIGHT 591 ML	48	7801610000595	1	1000	1	900	\N	\N
1933	COCA COLA ZERO RETORNABLE 2 LT	50	7801610350256	1	1300	1	1500	\N	\N
1954	VITAL C/GAS 1,6 LT	52	7802820020953	1	750	1	0	\N	\N
330	CONFORT DOBLE HOJA 22 METROS 4UN	2	7806500506829	1	1100	1	1000	\N	\N
331	CONFORT DOBLE HOJA 4R 30 METROS 	2	7806500505006	1	1450	1	0	\N	\N
2599	DETERG. ACE 2X1 MANZANILLA 400G	1	7500435146364	1	990	1	0	\N	\N
2629	CRUNCHIS MANI 250 	1	7802420003684	1	1700	1	1500	\N	\N
1940	NECTAR DURAZNO  2 LT ANDINA DEL VALLE	38	7802820210422	1	1500	1	0	\N	\N
1939	NECTAR NARANJA  2 LT ANDINA DEL VALLE	38	7802820210521	1	1500	1	0	\N	\N
2357	HALLOWEEN MASTICABLES ACIDOS 180 G 	1	7802200113015	1	1400	1	0	\N	\N
2358	GOITAS DE GELATINA OJOS 250G	1	7802215270048	1	2950	1	0	\N	\N
2359	CARAMELOS CALABAZA 60 UN 	1	7802225313483	1	1350	1	0	\N	\N
2360	CARAMELOS PIÑA Y NARANJA 200G 	1	7802225312073	1	900	1	0	\N	\N
2632	CHAPSUI  500 GR FRUTOS DEL MAIPO	7	7801300000706	1	1400	1	0	\N	\N
3871	BOLSA BASURA KING KONG 50X70	1	7804672080017	1	550	1	0	\N	\N
1967	COCA COLA LATA 350 CC	48	7801610001196	1	700	1	0	\N	\N
1972	COCA COLA ZERO LATA 220 ML	48	7801610220108	1	600	1	0	\N	\N
1935	NECTAR PIÑA  1,5 LT ANDINA	38	7802820700251	1	1400	1	0	\N	\N
912	CHICLE MENTA BIGTIME 11GR	6	78005624	1	300	1	0	\N	\N
1973	COCA COLA LATA  220 ML	48	7801610220016	1	600	1	0	\N	\N
2356	GOMITAS CEREBROS 300G	1	7802200112971	1	2950	1	0	\N	\N
1955	AGUA MINERAL BENEDICTINO S/GAS 1.5 LTS	52	7802820441512	1	700	1	0	\N	\N
1957	AQUARIUS PERA 1.6 LTS	52	7801610461013	1	950	1	0	\N	\N
1952	TAI NARANJA 2LT DESECH. 	50	7801610034712	1	600	1	0	\N	\N
657	ATUN DESMENUZADO AL ACEITE  185 GR SAN JOSE	1	7801235268110	1	950	1	0	\N	\N
1984	COCA COLA PET 250 CC	48	7801610001936	1	400	1	0	\N	\N
1664	POROTOS A GRANEL 	11	131	2	1800	1	0	\N	\N
2282	YERBA MATE COLISEO 250 GR	64	7804608222382	1	1200	1	0	\N	\N
882	BEBIDA STARKE ALOE 500ML	5	742832656658	1	1000	1	0	\N	\N
1990	NECTAR MANZANA  200 ML ANDINA 	38	7802820700473	1	250	1	0	\N	\N
1968	SPRITE LATA 350 CC	48	7801610005194	1	700	1	0	\N	\N
1953	VITAL SIN GAS 1600 CC	52	7802820021950	1	750	1	0	\N	\N
1956	AQUARIUS UVA 1.6 LTS	52	7801610461044	1	950	1	0	\N	\N
1958	AQUARIUS MANZANA 1.6 LTS	52	7801610461006	1	950	1	0	\N	\N
1965	POWER ADE FROZEN BLAST  1 LT COCACOLA	54	7802820851021	1	1000	1	0	\N	\N
1966	POWER ADE NARANJA  1 LT COCACOLA	54	7802820851052	1	1000	1	0	\N	\N
405	TE SUPREMO BRAZIL 20 UN. 	1	7801875041012	1	750	1	0	\N	\N
1941	BENEDICTINO C/GAS 3 LT	51	7802820443356	1	1000	1	0	\N	\N
1998	SPRITE 1,1 LTS	48	7801610106402	1	1000	1	0	\N	\N
1999	LIMON Y NADA DEL VALLE 1.5L DES	38	7801610282038	1	1400	1	0	\N	\N
2002	FANTA ZERO 1,5 LT	48	7801610671030	1	1400	1	0	\N	\N
2005	NECTAR NARANJA TP ANDINA DEL VALLE 1 LT	38	7802820700084	1	750	1	0	\N	\N
2633	TURBO PLUS 2 LTS 	1	7801615775443	1	200	1	0	\N	\N
2635	TURBO ZERO PERA 	1	7801615761125	1	200	1	0	\N	\N
2634	TURBO LIMON ZERO 2 LTS 	1	7801615771261	1	200	1	0	\N	\N
2636	TURBO MANZANA ZERO 	1	7801615771278	1	200	1	0	\N	\N
4316	YOGHURT 1+1 155G	1	7802900002220	1	400	1	0	\N	\N
2637	TURBO PIÑA ZERO 	1	7801615776822	1	200	1	0	\N	\N
2638	TURBO BERRIES ZERO 	1	7801615776327	1	200	1	0	\N	\N
2639	TURBO DURAZNO ZERO 	1	7801615771230	1	200	1	0	\N	\N
2640	TURBO FRUTILLA ZERO 	1	7801615771223	1	200	1	0	\N	\N
2641	TURBO NARANJA ZERO 	1	7801615771216	1	200	1	0	\N	\N
2642	TURBO PIÑA 	1	7801615775504	1	200	1	0	\N	\N
2643	TURBO NARANJA 	1	7801615775481	1	200	1	0	\N	\N
1996	NORDIC MIST GINGER ALE  1,5 L COCACOLA	48	7801610019269	1	1600	1	0	\N	\N
2040	QUESILLO BIOLAC 250CC	3	1602	1	1000	1	0	\N	\N
1983	KAPO FRAMBUESA 252 ML	38	7802820250268	1	250	1	0	\N	\N
1982	KAPO MANZANA 252 CC	38	7802820250244	1	250	1	0	\N	\N
1981	KAPO NARANJA 252 ML	38	7802820250206	1	250	1	0	\N	\N
4048	SHAMPOO FAMILAND 750 ML 	1	7804945062559	1	2000	1	0	\N	\N
323	PAÑALES BABYSEC G 20UN	2	7806500794202	1	3690	1	0	\N	\N
1997	SPRITE DESECHABLE 1,5 LT	48	7801610005262	1	1700	1	0	\N	\N
2003	FANTA DESECHABLE 3 LT	49	7801610002650	1	2400	1	0	\N	\N
2372	RUSTICAS SAL DE MAR 185G 	1	7802420002182	1	2000	1	2000	\N	\N
2370	POP CORN CARAMELO 250G	1	7802420003806	1	1700	1	1500	\N	\N
2367	PAPAS CASERAS JAMON SERRANO 200G 	1	7802420001864	1	1700	1	1500	\N	\N
2368	PAPAS FRITAS C/AMERICANO 250 GR MARCO POLO	46	7802420003912	1	1500	1	0	\N	\N
2371	CRUNCHIS PAPAS 280G	1	7802420004278	1	1700	1	1500	\N	\N
782	GALLETA ARCOR CHOC KISS 35GR	6	7802225688567	1	200	1	0	\N	\N
2006	NECTAR PIÑA TP ANDINA DEL VALLE 1 LT	38	7802820700275	1	750	1	0	\N	\N
339	POETT LAVANDA 485 ML 	2	7805025694202	1	950	1	0	\N	\N
2007	NECTAR DURAZNO TP ANDINA DEL  VALLE 1 LT	38	7802820500097	1	750	1	0	\N	\N
562	NECTAR GRAN SELECCION PIÑA/GUAYABA WATTS 1LT 	5	7801620006204	1	1700	1	0	\N	\N
328	PAÑALES HUGGIES XG 16UN 	2	7809604029423	1	4700	1	0	\N	\N
563	NECTAR WATTS PIÑA 200 ML	5	7802810006400	1	250	1	0	\N	\N
499	NECTAR DURAZNO BOCA ANCHA  300 ML WATTS	5	7801620011666	1	650	1	0	\N	\N
498	NECTAR WATTS BOCA ANCHA TUTIFRUTILLA 300ML	5	7801620001834	1	650	1	0	\N	\N
965	NECTAR WATTS MANZANA 200 ML	5	7802810006592	1	250	1	0	\N	\N
548	TE LIPTON FRAMBUESA 400ML	1	7801620006082	1	650	1	0	\N	\N
433	CACHANTUN MAS CITRUS 500 CC	5	7801620002367	1	750	1	0	\N	\N
2036	QUAKER AVENA INSTANTANEA 900 G	1	7802000011474	1	2000	1	0	\N	\N
1496	ALCACHOFAS 	11	2000000000640	1	0	1	0	\N	\N
2644	TURBO MELON TUNA 	1	7801615775528	1	200	1	0	\N	\N
2645	TURBO MANGO 	1	7801615775511	1	200	1	0	\N	\N
2646	TURBO MANZANA 	1	7801615775474	1	200	1	0	\N	\N
2647	TURBO FRUTILLA 	1	7801615775450	1	200	1	0	\N	\N
397	FUZOL PRIMAVERA 1 LITRO 	2	7804920280596	1	1200	1	0	\N	\N
2648	TURBO DURAZNO 	1	7801615775436	1	200	1	0	\N	\N
2649	TURBO HUESILLO 	1	7801615775467	1	200	1	0	\N	\N
2650	TURBO TUTTI FRUTILLA 	1	7801615775542	1	200	1	0	\N	\N
2651	BENEDICTINO TOQUE FRUTILLA SIN GAS  1,5 LT COCACOLA	75	7802820442137	1	900	1	0	\N	\N
2652	BENEDICTINO POMELO 1.5 ML 	1	7802820452365	1	900	1	0	\N	\N
2653	BENEDICTINO LIMON 1.5ML 	1	7802820442120	1	900	1	0	\N	\N
2035	LOVE LEMON MENTA JENGIBRE 475CC	1	7804643820154	1	1300	1	1200	\N	\N
898	COYAC YOGUETA/PINPOP UNIDAD	6	202	1	10	1	100	\N	\N
2374	RUSTICAS MERKEN 185G	1	7802420002359	1	2000	1	2000	\N	\N
2375	CASERAS CREMA COBOULETTE 200G	1	7802420001840	1	1700	1	1500	\N	\N
4317	HUEVO SORPRESA	1	6920484010668	1	500	1	1300	\N	\N
2654	ALOE VERA COCO HOMAR 500ML	1	7804645050337	1	1000	1	0	\N	\N
166	GALLETAS DONUTS CHOCOLATE 100 G 	6	7802215508523	1	1000	1	0	\N	\N
2657	ALOE VERA PIÑA 500ML 	1	7804645050238	1	1000	1	0	\N	\N
78	CHOCOLATE INKAT 26 G 	6	7802220140602	1	250	1	0	\N	\N
2376	NESTUM 5 CEREALES 25G	1	7613037484250	1	300	1	0	\N	\N
2378	PRESTIGIO 90 ML 	1	7613035918429	1	1490	1	0	\N	\N
2377	BILZ Y PAP SAVORY 90ML 	1	7613035737754	1	600	1	0	\N	\N
1751	MANJAR  200 GR SOPROLE	21	78040519	1	790	1	0	\N	\N
863	DULCES ARCOR BUTTER TOFFEES LECHE 350GR	6	7790580404284	1	1850	1	0	\N	\N
1190	VASOS 16OZ GRIZ 25 UN 	34	7898509283917	1	2300	1	0	\N	\N
2143	COLADO CRECIDOS POLLO VERDURA 215 GR	42	7613030264088	1	1690	1	0	\N	\N
2144	AMPOLLETAS LED 5W	1	7895623005005	1	1300	1	0	\N	\N
2152	MASTER CAT ADULTO 500 GR	60	7801920001381	1	1350	1	0	\N	\N
2153	MASTERDOG ADULTO CARNE 700 GR	60	7802575533180	1	1350	1	0	\N	\N
2155	PEDIGREE ADULTO	60	902	2	2000	1	0	\N	\N
2142	CARBON BOLSA 	1	2000000001005	1	1300	1	1000	\N	\N
1023	MAMMA MIA PIAMONTESA 200GR	1	7802500038032	1	550	1	0	\N	\N
1109	MASCARRONI CAROZZI 400 G 	1	7802575003188	1	800	1	0	\N	\N
2168	ENERGIZER AA2 	1	039800015464	1	200	1	0	\N	\N
2658	ALFAJOR CHILENO NUTRABIEN 45GR	1	78040588	1	400	1	300	\N	\N
1950	TAI PAPAYA 2 LT DESCH. 	50	7801610032718	1	600	1	0	\N	\N
2379	FOSFOROS ATACAMA 10 UN 	1	7804603463247	1	1000	1	0	\N	\N
2182	NATUR TRIGO 20G 	1	7802220650002	1	250	1	0	\N	\N
2174	AZUCAR IANSA 400G 	1	7801505000228	1	500	1	0	\N	\N
1708	CANELA ENTERO  15GR MP	41	7802420002038	1	500	1	0	\N	\N
2156	MASTER DOG ADULTO	60	903	2	1900	1	1500	\N	\N
1994	SPRITE ZERO 591 CC	48	7801610591888	1	1000	1	900	\N	\N
2655	ALOE VERA MANGO 500ML 	1	7804645050191	1	1300	1	1000	\N	\N
1738	MANJARATE  80 GR SOPROLE	21	7802900401016	1	550	1	0	\N	\N
2181	GALLETA CHAMPAÑITAS  85 GR COSTA	26	7802215515347	1	900	1	0	\N	\N
2180	GALLETAS CHAMPAÑA 140 GR COSTA	26	7802215515071	1	1400	1	0	\N	\N
1802	JABON LIQ. TANGO MIX BERRIES 500ML 	36	892166000365	1	1690	1	0	\N	\N
2183	NATUR MAIZ 20G 	1	7802220739363	1	250	1	0	\N	\N
2184	NATUR FRUTILLA 20G	1	7800120176011	1	250	1	0	\N	\N
2179	NATUR NATURAL ARROZ 40G 	1	7802220740314	1	320	1	0	\N	\N
2185	CHORIZO PARRILLERO LA ESPAÑOLA 24 UN 	1	7801930014166	1	2500	1	0	\N	\N
1314	QUEQUE SABOR VAINILLA 225 GRS	30	7803473300034	1	950	1	0	\N	\N
1363	HAMBURGUESA POLLO 50G WINTER 	20	7801900340653	1	150	1	0	\N	\N
4318	PIZZA PF	1	7801930012360	1	3100	1	0	\N	\N
5351	HAMBURGUESA VEGANA RDA 100G	1	7801930021133	1	700	1	0	\N	\N
1364	HAMBURGUESA VACUNO 50G WINTER 	20	7801900340486	1	150	1	0	\N	\N
1801	JABON LIQ. TANGO OLIVE 500ML 	36	892166000372	1	1200	1	0	\N	\N
1529	TENEDOR PLASTICO DESECHABLE ROJO 	34	9000000043602	1	500	1	0	\N	\N
1532	PLATOS DE CARTON UNICORNIO 10UN 	34	2018157167017	1	750	1	0	\N	\N
2194	CREMISSIMO PIÑA 1 LT 	1	7805000305253	1	2390	1	0	\N	\N
244	JUGO SPRIM MELON TUNA 35 GRAMOS 	1	7802575223050	1	190	1	0	\N	\N
2199	HELLMANNS 930G 	1	7802640403103	1	2900	1	0	\N	\N
1505	ACELGA 	11	2000000000688	1	350	1	0	\N	\N
2200	QUESO LAMINADO GAUDA 500G 	1	7804613390854	1	2800	1	0	\N	\N
2201	MANI SIN SAL 100G	1	7804623100276	1	700	1	0	\N	\N
2204	QUESILLO COLUN 160G 	1	7802920000718	1	990	1	0	\N	\N
2205	QUESILLO COLUN 320G	1	7802920000749	1	1590	1	0	\N	\N
2209	COLUN LIGHT S/LAC. CHIRIMOYA 125G	1	7802920006895	1	300	1	0	\N	\N
1500	DURAZNOS PELUDOS 	11	118	2	1250	1	0	\N	\N
2211	COLUN LIGHT GRIEGO 120G	1	7802920008189	1	400	1	0	\N	\N
2212	MAIZENA DROPA 100 GRS	1	7802640793563	1	2390	1	0	\N	\N
1974	FANTA LATA 220 ML 	48	7801610220061	1	600	1	0	\N	\N
2217	CHIP MOVISTAR 	1	7809610821684	1	1000	1	0	\N	\N
2659	DELICIA DE FRAM. NUTRA BIEN 42G	1	78045248	1	400	1	300	\N	\N
576	SOPA MARUCHAN CARNE DE RES 85GR	1	041789002229	1	700	1	0	\N	\N
1365	HAMBURGUESA CARNE ANGUS 100G LA PREFERIDA	20	7801916038575	1	800	1	500	\N	\N
2202	PILA ALCALINA PEQ AAA DURACELL	56	041333428482	1	800	1	750	\N	\N
2380	PELOTAS DE PING PONG 6 UN	1	5906735130096	1	800	1	0	\N	\N
2218	CHIP WOM 	1	0010081325	1	1000	1	0	\N	\N
2219	NARANJA Y NADA 1500ML 	1	7801610283035	1	1400	1	0	\N	\N
5372	PAILA MARINA 500G	1	302005	1	2490	1	0	\N	\N
1391	PECHUGA PAVO ASADO PF 	3	46	2	8900	1	0	\N	\N
283	LOOP GOMITAS ACIDAS 25 G 	6	7802200135413	1	300	1	0	\N	\N
2230	MUSTANG FRUNA	62	7802408000636	1	350	1	0	\N	\N
2231	CONO TWINGO FRUNA	62	7802408000698	1	350	1	0	\N	\N
2232	CHIRY FRUNA	62	7802408000674	1	200	1	0	\N	\N
2233	PALITO MORA MORA FRUNA	62	7802408000582	1	200	1	0	\N	\N
2234	PALITO FRAMBUESA FRUNA	62	7802408000599	1	150	1	0	\N	\N
2235	PALO PALITO FRUTAL PAPAYA FRUNA	62	7802408000629	1	150	1	0	\N	\N
2236	HAMBURGUESA POLLO ARIZTIA 100G	1	7804115722238	1	350	1	0	\N	\N
2210	COLUN LIGHT S/LAC. 125G	1	7802920006871	1	300	1	0	\N	\N
2237	CHEETOS FLAMIN HOT 50G	1	7802000013751	1	600	1	0	\N	\N
2240	LAYS FLAMIN HOT 40G	1	7802000013782	1	600	1	0	\N	\N
1949	TENEDOR PLASTICO DESECHABLE AZUL 	1	9000000043633	1	500	1	0	\N	\N
2241	SUAVIZANTE BRIKS 1.5LTS 	1	7804566346182	1	1690	1	0	\N	\N
2244	CREMA SVELTY LIGHT 236G 	1	7613032415235	1	1290	1	0	\N	\N
2246	TUTTE COTONITOS 	1	7809634801167	1	1330	1	0	\N	\N
2248	CEPILLO DISNTES CORONA NIÑOS 	1	6926091406207	1	500	1	0	\N	\N
2249	CHUÑO ARUBA 500G	1	7801430001604	1	1200	1	0	\N	\N
2250	SEDAL RESTAURACION 190ML 	1	7791293030630	1	990	1	0	\N	\N
2261	ARCOR LECHE BLANCO 100G	1	7802225590150	1	1000	1	0	\N	\N
2265	OBA OBA 21 G	1	7802225281614	1	200	1	0	\N	\N
2267	CHUCHOCAQ A GRANEL 	1	2500133002509	1	500	1	0	\N	\N
2221	CHUCRUT DON JUAN 200 GR	61	7802351441203	1	890	1	0	\N	\N
1192	CHOCLITOS COCKTAIL 425G ESMERALDA 	1	7802420510403	1	1390	1	0	\N	\N
2133	SALMON CON PIEL 	12	656	2	17000	1	10000	\N	\N
99	CLOROX ROPA BLANCA 370G	2	7805025690419	1	990	1	0	\N	\N
2276	EGOCENTRICO SAVORY 85ML 	1	78006164	1	700	1	0	\N	\N
2277	LAYS OREGANO  38 GR EVERCRISP	46	7802000010934	1	600	1	0	\N	\N
629	JALEA NARANJA 110 GR NESTLE	1	7613035281431	1	350	1	0	\N	\N
2262	MANI SALALDO EVERCRISP 75G	1	7802000013140	1	600	1	0	\N	\N
2229	MUSTANG CHIRIMOYA ALEGRE	62	7802408000667	1	300	1	0	\N	\N
4051	CHAMPIÑON ENTERO GHOSH 184G 	1	7804610400174	1	750	1	0	\N	\N
4321	ACEITE VEGETAL 900 ML CALLAO	1	7794870000903	1	1200	1	0	\N	\N
1419	POROTOS VERDES 400G MONTINA 	32	7804115001425	1	750	1	0	\N	\N
2266	LA CREMERIA 1L PLATANO MANJAR 	6	7613036568890	1	3900	1	0	\N	\N
142	FIDEO LUCCHETTI SPAGHETTI N° 5 400 GRAMOS 	1	7802500000053	1	1300	1	800	\N	\N
2245	LECHE EN POLO COLUN DESCREMADA 400G	1	7802920002118	1	3000	1	0	\N	\N
2279	PICKLES JC 200G	1	7809580600234	1	800	1	0	\N	\N
977	CHICLE ORBIT WHITE 10UN	6	42069942	1	550	1	0	\N	\N
605	SOPA COSTILLA C/FIDEOS  79 GR MAGGI	1	7613030612247	1	450	1	0	\N	\N
2381	LAYS MEDITERRANEAS J.SERRANO  38 GR EVERCRISP	46	7802000010910	1	600	1	0	\N	\N
2280	CHUCRUT JC 200G	1	7809580600227	1	800	1	0	\N	\N
2281	SALSA AMERICANA JC 200G	1	7809580600258	1	800	1	0	\N	\N
695	MANJAR POTE  400 GRS NESTLE	1	78003095	1	1500	1	0	\N	\N
1439	MANTEQUILLA C/SAL  125 GRS COLUN	21	7802920202105	1	1300	1	0	\N	\N
2283	QUESILLO S/LAC. COLUN 320G 	1	7802920008073	1	1650	1	0	\N	\N
2285	MANJARATE MOUSSE CHOC MANJAR 102  80 GR SOPROLE	21	7802900000899	1	550	1	0	\N	\N
1616	TRITON 90ML SAVORY 	6	7613037484724	1	1490	1	0	\N	\N
1071	CABRITAS EVERCRISP 42GR	6	7802000002816	1	400	1	0	\N	\N
2287	CENTELLA TRES LECHES 50ML 	1	7613036342353	1	200	1	0	\N	\N
1520	PECHUGA DESHUESADA GRANEL 	31	304	2	3980	1	0	\N	\N
2033	MR. BIG ENERGY 600ML 	54	7804646000010	1	2000	1	0	\N	\N
1612	SAHNE-NUSS 125ML SAVORY	6	7613035421592	1	1590	1	0	\N	\N
1638	CONO CHICO DOBLE	6	2000000000855	1	1800	1	0	\N	\N
1409	MORTADELA DE POLLO PF 	3	64	2	5000	1	2500	\N	\N
2369	CRUNCHIS TUBOS QUESO 270 G	1	7802420001703	1	1700	1	1500	\N	\N
1648	HAMBURGUESA DE VACUNO MAMUT 185G RECETA DEL ABUELO	20	7801930010809	1	1500	1	1200	\N	\N
2288	DORITOS FLAMIN HOT	1	7802000013799	1	600	1	0	\N	\N
2289	NECTAR ANDINA LIGHT PIÑA 200 ML	38	7802820641554	1	250	1	0	\N	\N
2008	MIEL PRODUCTO CHILENO	1	7898509285423	1	3500	1	0	\N	\N
1852	MARAVILLAS FAMILIAR 320G CAMILA 	6	7804623100603	1	2100	1	0	\N	\N
1076	GATOLATE EVERCRISP 270GR	6	7802000011467	1	1900	1	0	\N	\N
1622	CASATA PASAS AL RON 1 LITRO SAVORY 	6	7802710835216	1	2700	1	0	\N	\N
1083	SNACK MIX ORIGINAL EVERCRISP 120GR	6	7802000011887	1	1000	1	0	\N	\N
2243	MANJAR CALO 400G	1	7802910006829	1	1600	1	0	\N	\N
2286	BRAZO DE REINA CON NUEZ	1	2000000001128	1	4800	1	0	\N	\N
1054	RAMITAS QUESO EVERCRISP 42GR	6	7802000003479	1	400	1	0	\N	\N
1318	CHURRASCO MONTINA 120G 	1	7804115844596	1	1000	1	0	\N	\N
440	QUESO PARMESANO COLUN RALLADO 40G	1	7802920116013	1	800	1	0	\N	\N
3246	LONCO LECHE CAPPUCCINO 1LT 	1	7802910006652	1	1600	1	0	\N	\N
421	VIENNETTA CLÁSICA LECHE VAINILLA BRESLER 1 LITRO 	1	7802705613645	1	2990	1	0	\N	\N
1510	JENGIBRE 	11	124	2	5500	1	0	\N	\N
1617	CHARLOT FRAMBUESA 1 LITRO SAVORY 	6	7802710566202	1	3000	1	0	\N	\N
623	YOGURTH NESTLE FRAMBUESA 115GR	4	7613036467179	1	230	1	0	\N	\N
781	GALLETA SELZ PIZZA 35GR	6	7802225684736	1	250	1	0	\N	\N
2382	CONQUISTAS PALMERITAS 35G	1	7802225680325	1	200	1	0	\N	\N
6	ACONDICIONADOR FRCUTIS FRESCURA VITAMINADA 350 ML 	2	509552915112	1	1900	1	0	\N	\N
104	CONDORIHELADO BRESLER 60 ML 	7	7805000305161	1	590	1	0	\N	\N
925	BON O BON CHOCOLATE UNIDAD 15GR	6	78023215	1	150	1	0	\N	\N
137	FIDEO ACONCAGUA TALLARINES N°87 400 GRAMOS 	1	7802575300478	1	400	1	0	\N	\N
971	CARAMELO MASTICABLE KEGOL UVA UNIDAD	6	216	1	50	1	0	\N	\N
485	PAP ZERO DES. 2 LTS	5	7801620006518	1	1100	1	1300	\N	\N
229	LUX ROSAS FRANCESAS 125 G 	2	7791293037608	1	1000	1	900	\N	\N
1319	FILETILLO DE POLLO GRANEL AGROSUPER	31	301	2	3980	1	0	\N	\N
784	GALLETA DOS EN UNO CHOCOLATE 35GR	6	7802225682893	1	300	1	200	\N	\N
786	GALLETA DOS EN UNO LIMON 35GR	6	7802225682619	1	300	1	200	\N	\N
1979	MONSTER VERDE 473ML 	54	070847009511	1	1500	1	0	\N	\N
347	ROCKLETS ALMENDRA 30 G 	6	7802225427678	1	450	1	0	\N	\N
277	LENTEJAS EN CONSERVA WASIL 380 G 	1	7801305004082	1	1350	1	0	\N	\N
1095	DORITOS RULETA EVERCRISP 48GR	6	7802000012204	1	0	1	0	\N	\N
190	GARBANZOS EN CONSERVA WASIL 380 GRAMOS 	1	7801305004075	1	1690	1	0	\N	\N
4322	OIKOS TROZOS DE PAPAYA DANONE 110G	1	7802955006556	1	500	1	0	\N	\N
4323	OIKOS COLCHON DE FRUTAS FRUTOS DEL BOSQUE DANONE 150G	1	7802955008697	1	550	1	0	\N	\N
198	GOLPE 36 G 	6	7802225587198	1	200	1	0	\N	\N
204	HOBBY ENERGY 55G 	6	7802225583978	1	750	1	0	\N	\N
200	GROSSO CRUNCH FRUAL 5 G 	6	78921511	1	100	1	0	\N	\N
205	HOBBY NOUGAT MINI 40 G 	6	7802225583121	1	400	1	0	\N	\N
227	LE SANCY 90 G MIEL Y ALMENDRAS 	2	7791293020129	1	650	1	0	\N	\N
1426	SOFRITO  150 KG FRUTOS DEL MAIPO	32	7801300000409	1	500	1	0	\N	\N
1427	CHOCLO GRANO 200 GRS FRUTOS DEL MAIPO	32	7801300012075	1	500	1	0	\N	\N
2663	ESCOBILLON VIRUTEX	73	7806810011303	1	1700	1	0	\N	\N
668	MAYODELI KRAFT 850GR	1	7798146130950	1	3200	1	0	\N	\N
2667	CHAMPIÑON LAMINADOS 230G	1	7801434001815	1	1390	1	0	\N	\N
881	BEBIDA STARKE PIÑA 500ML	5	742832851398	1	1000	1	0	\N	\N
2666	FITCOCO SABILA 500ML	1	857501005665	1	1100	1	0	\N	\N
2661	PRESERV. LIFESTYLES ULTRA S. NUDA 3 UND 	74	7804918450017	1	1990	1	0	\N	\N
4375	ESTUCHE NAVIDAD BON O BON 210G	1	7802225511674	1	2390	1	0	\N	\N
172	GALLETAS DULCES VINO 160 G 	6	7802215505300	1	650	1	0	\N	\N
793	SHAMPOO HEAD AND SHOULDERS 90ML	2	7506195148686	1	1200	1	0	\N	\N
2664	ESCOBILLON VIRUTEX AZUL 	1	7806810011334	1	2300	1	0	\N	\N
312	NOBLE ORQUIDEA 4 ROLLOS 28 METROS 	2	7806500504856	1	800	1	0	\N	\N
2383	ALOE VERA MANGO 500ML 	1	7804628241905	1	1000	1	0	\N	\N
2384	ALOE VERA NATURAL 500ML 	1	7804628241899	1	1000	1	0	\N	\N
2385	ALOE VERA GRANADA 500ML 	1	7804628241912	1	1000	1	0	\N	\N
2386	GALLETAS DE ARROZ CLASICAS 150G 	1	7801420001775	1	1350	1	0	\N	\N
2387	GALLETAS DE ARROZ DULCES 150G 	1	7801420001782	1	1350	1	0	\N	\N
3247	SOPROLE LIGHT 200ML	1	7802900028473	1	450	1	400	\N	\N
2388	AZUCAR MERKAT 1 KG 	1	7808743601903	1	500	1	0	\N	\N
2389	ACEITE OLIVA 250 ML KARDAMILI	9	7808725800003	1	2750	1	0	\N	\N
2391	COLUN ENTERA SIN LAC. 1 LT	1	7802920007397	1	1400	1	0	\N	\N
2392	COLUN SIN LAC. SEMIDESC. 	1	7802920007410	1	1400	1	0	\N	\N
4324	PROBIOTICOS CALAN 90ML	1	7802955010195	1	350	1	0	\N	\N
219	ILICIT COLOR RUBIO MEDIO CENIZA 7.1	2	7804923031478	1	2000	1	0	\N	\N
211	ILICIT COLOR MIEL 7.35	2	7804923031508	1	2000	1	0	\N	\N
214	ILICIT COLOR RUBIO CENIZA PROFNDO 7.11	2	7804923031485	1	2000	1	0	\N	\N
2552	JALEA REGIMEN 100G	1	78018600	1	400	1	0	\N	\N
437	DOÑA CLARA 200 GR 	1	7802300000161	1	450	1	350	\N	\N
639	CHANDELLE TOURBILLON MANJAR/LUC NESTLE 90GR	4	7613033893926	1	500	1	0	\N	\N
2668	ALOE VERA SABILA 1LT	1	857991002014	1	1800	1	0	\N	\N
2669	DETERGENTE MAGGIE 1KG 	1	7804606200115	1	1100	1	0	\N	\N
2670	CHAMONIX TRISABOR 1LT 	1	7613032484903	1	1900	1	0	\N	\N
2672	BENEDICTINO LIMONADA GENJIBRE 	1	7802820452280	1	900	1	0	\N	\N
4052	ORAL B 5 ML 	1	7506195130957	1	1000	1	0	\N	\N
2393	CALIPO  STRAWBERRY 105NL	1	8000920401248	1	890	1	0	\N	\N
2395	KOLORIX PIÑA 55ML 	1	7805000318093	1	450	1	0	\N	\N
109	CRICRI MASTI CRUNCH 16 G 	6	6754884009089	1	150	1	0	\N	\N
348	ROCKLETS CHOCOLATE 35 G 	6	7802225427210	1	450	1	0	\N	\N
340	POETT PRIMAVERA 485 ML 	2	7805025694219	1	950	1	0	\N	\N
3248	DULCE DE LECHE EN LINEA SIN AZUCAR 380G	1	7804000001172	1	3700	1	0	\N	\N
788	GALLETA RELLENA DOS EN UNO VAINILLA/FRUTILLA 118GR	6	7802225409186	1	350	1	0	\N	\N
789	GALLETA RELLENA DOS EN UNO CHOCOLATE/VAINILLA 118GR	6	7802225409193	1	350	1	0	\N	\N
335	PAW PATROL BRESLER 60 ML 	7	7805000318406	1	690	1	0	\N	\N
2037	PIE DE LIMON GRANDE 	12	631	1	8000	1	0	\N	\N
1415	QUESO GAUDA LAMINADO LACTEOS DEL MAULE 	3	70	2	6800	1	0	\N	\N
215	ILICIT COLOR RUBIO CLARO 8.0	2	7804923031515	1	2150	1	2000	\N	\N
1410	JAMONADA DE POLLO PF	3	65	2	6000	1	3700	\N	\N
1718	PLATANO MADURO 	11	135	2	600	1	0	\N	\N
2390	COLUN DESC. SIN LACTOSA 1 LT. 	1	7802920007403	1	1400	1	0	\N	\N
541	PAP RETORNABLE 1LT	5	7801620300043	1	750	1	0	\N	\N
3872	MERMELADA WATTS FRAMBUESA 250G 	1	7802810031082	1	1000	1	0	\N	\N
777	OBLEA DOS EN UNO CHOCOLATE 140GR	6	7802225660204	1	900	1	0	\N	\N
547	TE LIPTON DURAZNO 400ML	1	7801620003319	1	650	1	0	\N	\N
531	GATORADE COOL BLUE 750 ML	5	7801620005191	1	900	1	0	\N	\N
525	GATORADE FRUTAS TROPICALES 1LT	5	7801620005153	1	1100	1	0	\N	\N
1503	CIBOULETTE 	11	2000000000664	1	0	1	0	\N	\N
1619	SAHNE-NUSS 1LITRO SAVORY 	6	7802710566240	1	3400	1	0	\N	\N
632	SEMOLA CARAMELO NESTLE 135GR	4	7613035953949	1	600	1	0	\N	\N
74	CHIRI ALEGRE BRESLER 75 GRAMOS 	7	7805000307073	1	690	1	0	\N	\N
46	AZUCAR FLOR IANSA 500 GRAMOS 	1	7801505231974	1	1300	1	0	\N	\N
654	JUREL ATLAS 425 GRS	1	7801235131155	1	1400	1	0	\N	\N
656	MEDALLON DE JUREL AL NATURAL SAN JOSE 425G 	1	7801235001090	1	1450	1	0	\N	\N
804	JABON BELLEKISS CREMOSO 700ML	2	7804945051218	1	1250	1	0	\N	\N
1270	MERMELADA FRUTILLA  250 GR WATTS	28	7802810031075	1	1000	1	0	\N	\N
660	ATUN DESMENUZADO AGUA COLORADO 170 GR	1	7801255000103	1	700	1	0	\N	\N
681	LECHE EVAPORADA BONLE 375ML	2	7751271124201	1	1300	1	0	\N	\N
199	GROSSO CRUNCH 5 G 	6	78926974	1	100	1	0	\N	\N
1557	GLOBOS AZUL 50 PCS 	34	131303	1	1500	1	0	\N	\N
779	MINI SELZ CLASICA 35 GR ARCOR	6	7802225683050	1	250	1	0	\N	\N
1842	MANI TOSTADO100G CAMILA 	6	7804623100177	1	1100	1	0	\N	\N
517	KEM ZERO 2.5ML RETORNABLE	5	7801620005320	1	1700	1	0	\N	\N
557	BILZ ZERO 3 LTS DESECHABLE	5	7801620005085	1	1950	1	0	\N	\N
2674	GALLETAS MCKAY 30G	1	7613037035315	1	300	1	0	\N	\N
3249	JUGO LIMON MONTANER 500 ML 	1	7802345101014	1	850	1	0	\N	\N
1092	PAPAS LAYS CORTE AMERICANO EVERCRISP 230GR	6	7802000012679	1	1800	1	0	\N	\N
1065	RAMITAS QUESO EVERCRISP 270GR	6	7802000002793	1	1700	1	0	\N	\N
1250	GALLETAS NIZA MCKAY 150G 	1	7613032590369	1	700	1	0	\N	\N
1620	CASATA SAHNE-NUSS 900ML SAVORY 	6	7613036566377	1	4500	1	3900	\N	\N
507	BILZ XPRESS 237 ML	5	7801620003869	1	250	1	0	\N	\N
383	SHIP NARANJA 2 LITROS 	5	7801608000057	1	650	1	0	\N	\N
384	SHIP PAPAYA 2 LITROS 	5	7801608000286	1	650	1	0	\N	\N
386	SHIP PIÑA 2 LITROS 	5	7804604720141	1	650	1	0	\N	\N
1623	CASATA CHIRIMOYA ALEGRE 1 LITRO SAVORY 	6	7802710835155	1	2700	1	0	\N	\N
2396	VAN CAMPS ACEITE 160G	1	7702367003900	1	1800	1	1750	\N	\N
1571	CABLE USB QIHANG HUAWEI 	35	3325201534084	1	2300	1	0	\N	\N
616	CHIQUITIN DAMASCO 45GR	4	78041103	1	250	1	0	\N	\N
640	CHANDELLEN TOURBILLON CHOCOLATE NESTLE 90GR	4	7613033893636	1	500	1	0	\N	\N
716	DULCE DE MEMBRILLO ECKART 250GR	1	7804000100257	1	690	1	0	\N	\N
711	NESTUM TRIGO Y FRUTAS 250GR	1	7613035939400	1	1900	1	0	\N	\N
1489	BROCOLI 	11	2000000000596	1	950	1	0	\N	\N
1490	COLIFLOR 	11	2000000000602	1	0	1	0	\N	\N
1112	CABELLITOS ANGEL  400 GR CAROZZI	10	7802575001030	1	1300	1	800	\N	\N
1640	CONO GRANDE SIMPLE 	6	2000000000879	1	2100	1	0	\N	\N
685	POLVOS HORNEAR  20 GRS IMPERIAL	1	7802950005110	1	200	1	0	\N	\N
426	VIZZIO IMULSIVO 13 G 	6	7802215102172	1	200	1	0	\N	\N
679	PIÑA EN TROZOS BONAFOOD 850GR	1	7801434000795	1	1450	1	0	\N	\N
1434	CHORIZO PARRILLERO  1 KILO TIL	33	7801930006611	1	2500	1	0	\N	\N
1581	VELA DE CUMPLEAÑOS 	34	9328191780411	1	650	1	0	\N	\N
1047	GOMITAS MOGUL OSITOS 25GR	6	7790580409180	1	300	1	250	\N	\N
901	LOLY CHOC UNIDAD	6	205	1	150	1	0	\N	\N
1568	AUDIFONOS BEOTES SMART STEREO EARPHONE 	35	3325201524832	1	2000	1	0	\N	\N
2677	CHEETOS POPCORN CARAMELO 55G	1	7802000012921	1	600	1	0	\N	\N
667	MAYONESA CASERA HELLMANNS DELI 200GR	1	7805000315917	1	1100	1	0	\N	\N
2397	LECHE CHOCOLATE NESQUIK  200 ML NESTLE	21	7802950005264	1	450	1	0	\N	\N
724	CAFE  50 GR ECCO	1	7802950008715	1	800	1	0	\N	\N
492	CACHANTUN MAS GRANADA 1,6 LT	5	7801620006631	1	1100	1	1050	\N	\N
2523	WATTS ALCAYOTA SIN AZUCAR 250 GR 	28	7802810031044	1	1000	1	0	\N	\N
778	GALLETA DOS EN UNO COCO 35GR	6	7802225682763	1	300	1	200	\N	\N
467	ACEITE MARAVILLA 900 ML NATURA	1	7790272001005	1	2300	1	0	\N	\N
2039	QUESILLO BIOLAC 500CC	3	1603	1	1500	1	0	\N	\N
382	SHIP LIMON SODA 2 LITROS 	5	7804604725252	1	650	1	0	\N	\N
1860	ACEITE BONANZA 900CC	9	7808743602740	1	1350	1	0	\N	\N
2291	YERBA MATE GROSSO 250G 	1	7804520011736	1	1330	1	0	\N	\N
2292	COTTONSEC PEQUEÑO 24 UN. 	1	7809536101938	1	3200	1	0	\N	\N
2293	COTTONSEC G 20 UN. 	1	7809536102058	1	3200	1	0	\N	\N
937	CHUBI 22 GR ARCOR	6	7802225426381	1	150	1	0	\N	\N
2294	COTTONSEC XG 16 UN. 	1	7809536102065	1	3200	1	0	\N	\N
2295	COTTONSEC XXG 16 UN 	1	7809536102072	1	3200	1	0	\N	\N
2678	MANI SALADO EVERCRISP 160G	1	941844	1	1000	1	0	\N	\N
2679	CHEETOS FLAMIN HOT 156G	1	7802000013768	1	1800	1	0	\N	\N
2680	CHAMONIX TRISABOR 2.5L 	1	7613033037894	1	3500	1	0	\N	\N
2681	SURLAT YOGHURT BATIDO 1KG	1	7804617470378	1	1200	1	0	\N	\N
2682	PASTA SABOR CAENE  85 GR MAGGI	1	7891000092996	1	650	1	0	\N	\N
2675	DORITOS RULETA 180G	1	7802000012211	1	1500	1	0	\N	\N
2676	SNACK MIX 320 G	1	7802000007569	1	2550	1	0	\N	\N
2398	NUGGETS DE POLLO SUPER POLLO 1KG 	1	7809611700445	1	3300	1	0	\N	\N
2685	SALSA FRAMBUESA 280G	1	7802410506294	1	1690	1	0	\N	\N
107	CORNETTO VAINILLA CARAMEL BRESLER 140 ML 	1	8690637818370	1	1490	1	0	\N	\N
2687	GRAN CEREAL S/AZUCAR 135G	1	7802215303739	1	750	1	0	\N	\N
1550	PALOS DE BROCHETA BAMBOO 30 CM 	34	6952151523003	1	700	1	0	\N	\N
3821	VAINILLA MARCO POLO 100ML	1	7802420117374	1	650	1	0	\N	\N
1369	JAMON PIERNA RECETA DEL ABUELO 	3	24	2	8000	1	7000	\N	\N
1516	MORTADELA FINA RDA	3	73	2	6500	1	4000	\N	\N
1596	MORTADELA JAMONADA 	3	88	2	6000	1	3500	\N	\N
2684	SALSA CHOCOLATE GOURMET 280G	1	7802410506249	1	2000	1	1400	\N	\N
2686	BENEDICTINO 6.5 LT	1	7802820650013	1	1800	1	0	\N	\N
1895	TABLETON CHOCOLATE 650GRS FRUNA	26	7802408000841	1	3100	1	2350	\N	\N
787	MINI SELZ JAMON 35 GR	6	7802225682930	1	300	1	250	\N	\N
3250	SOPROLE CHOCOLATE LIGHT 1LT 	1	7802900028374	1	1400	1	0	\N	\N
1901	SPRITE EXPRESS 237CC 	1	8000	1	300	1	0	\N	\N
2400	PULPA PIÑA AZUCAR 1 KG	7	2000000001135	1	3300	1	0	\N	\N
2401	FRAMBUESA IQF 1 KG 	7	2000000001142	1	4000	1	0	\N	\N
2402	MIX BERRIES IQF 1KG.	7	2000000001159	1	4300	1	0	\N	\N
2403	PULPA FRAMBUESA S/AZUCAR 1KG. 	7	2000000001166	1	3650	1	0	\N	\N
717	DULCE MEMBRILLO  250 GRS WATTS	1	7802810034045	1	800	1	0	\N	\N
3251	TE HOJA MILDRED 25G	1	7801875029027	1	2950	1	0	\N	\N
2404	PULPA FRUTILLA C/AZUCAR 1KG 	7	2000000001173	1	3000	1	0	\N	\N
2405	PULPA ARANDANO S/AZUCAR 1KG	7	2000000001180	1	3800	1	0	\N	\N
2406	PULPA FRAMBUESA C/AZUCAR 1KG	7	2000000001197	1	3300	1	0	\N	\N
2407	PULPA MANGO S/AZUCAR 1KG 	7	2000000001203	1	3800	1	0	\N	\N
647	YOGURTH GRIEGO N. FRUTILLA 115GR	4	7613037016178	1	350	1	0	\N	\N
325	PAÑALES BABYSEC P 24UN	2	7806500792208	1	3690	1	0	\N	\N
326	PAÑALES BABYSEC XG 16UN	2	7806500795285	1	3690	1	0	\N	\N
2691	LECHE CULTIVADA CHIRIMOYA 	1	7802920005171	1	550	1	0	\N	\N
436	SALSA SOBRE  200 GRS MALLOA	1	7802300000154	1	380	1	0	\N	\N
2409	CHUPETAS CARAMELO HALLOWEEN 40UND 	1	7802215290084	1	2550	1	0	\N	\N
2410	MONSTERS GOMITAS HALLOWEEN 400G	1	7802215290060	1	2950	1	0	\N	\N
140	FIDEO LUCCHETTI CORBATAS 400 GRAMOS 	1	7802500003023	1	800	1	0	\N	\N
2690	MINI TRITON FRUTILLA 40G	1	7613036637589	1	300	1	0	\N	\N
2688	TRITON VAINILLA 46G	1	7613037438253	1	300	1	0	\N	\N
258	JUGO ZUKO MANZANA 25 GRAMOS 	1	7802800578832	1	200	1	0	\N	\N
1030	PEPSI RETORNABLE 1LT	5	7801620076009	1	700	1	0	\N	\N
1543	VASOS DE CARTON FESTIVITY 10 UN 	34	6922332016150	1	700	1	0	\N	\N
1518	TRUTRO ENTERO GRANEL 	31	302	2	2300	1	0	\N	\N
1205	CLORO CONCENTRADO  2 LT DOÑA GABY	22	7804614280406	1	1400	1	0	\N	\N
1046	ALKA STRONG 400GR	6	P016	1	250	1	0	\N	\N
2415	MIRAFLORES CAMPESINO 210G 	1	904621	1	850	1	0	\N	\N
546	CACHANTUN C/GAS 500 CC	5	7801620015800	1	650	1	600	\N	\N
2689	MINI TRITON CHOCOLATE 40G	1	7613036637558	1	300	1	0	\N	\N
3825	PEPSODENT 90G	1	7805000180874	1	1100	1	0	\N	\N
3826	ESPONJA ACANALADA SAPOLIO 	1	7751851028172	1	220	1	0	\N	\N
2417	FOSFOROS PAVO REAL 	1	9315861128888	1	450	1	0	\N	\N
2418	BOLSA BASURA 80 X 110 GABY 10 UNDS	69	7804655191037	1	1650	1	0	\N	\N
2419	BOLSAS BASURA TREBOL 70X90	1	742832159586	1	900	1	0	\N	\N
2420	BOLSA BASURA DOÑA GABY 50X60	1	7804655192447	1	500	1	0	\N	\N
2422	ACEITE PARRAL 1LT	1	7790272006550	1	990	1	0	\N	\N
2428	VIENESAS LA ESPAÑOLA 5UN. 	1	7801930014258	1	600	1	0	\N	\N
2430	CROCANTY 1 LT SAVORY 	1	7613035366596	1	3000	1	0	\N	\N
380	SHIP FRUTAL 2 LITROS 	5	7801608000293	1	650	1	0	\N	\N
1167	HAMBURGUESA BACON 100G RA	1	7801930012087	1	650	1	0	\N	\N
2247	FIJADOR FUERTE 165ML 	1	7804947601220	1	1400	1	0	\N	\N
2411	 MANTEQUILLA  LACTEOSORNO 250G 	1	7804647450470	1	2200	1	0	\N	\N
2423	LECHE SEMID.VAINILLA 1 LT COLUN	21	7802920007168	3	1200	1	0	\N	\N
798	SHAMPOO HEAD AND SHOULDES SUAVE 375ML	2	7500435125130	1	3600	1	0	\N	\N
2431	ALMENDRADO SAVORY 1LT	1	7613033725333	1	3700	1	0	\N	\N
2414	DETERGENTE MATIC 3B	1	945127010	1	1800	1	0	\N	\N
477	RIGATI LUCCHETTI 400G	1	7802500184487	1	1300	1	800	\N	\N
2435	LUMINOSA 4UND. 	1	7805025690518	1	850	1	0	\N	\N
846	GALLETA SALVADO CHIA SELZ 519GR	6	7802225689830	1	2000	1	0	\N	\N
2426	NECTAR WATTS TUTTIFRUTILLA 1.75LT.	1	7801620007966	1	1350	1	0	\N	\N
857	DULCES ARCOR MENTA CHOCOLATE 530GR	6	7790580243678	1	2190	1	0	\N	\N
2116	ENCENDEDOR RED POWER 1	58	7804520011606	1	300	1	0	\N	\N
2118	JUGO RINDE 2 NARANJA - 24 G	1	7730908400529	1	180	1	0	\N	\N
2135	CISNES DE CREMA 	12	647	1	1500	1	0	\N	\N
2438	HARINA MERKAT 5KG 	1	7802655000458	1	3900	1	0	\N	\N
2442	ABOLENGO 3 ROLLOS 	1	7806500404736	1	1100	1	0	\N	\N
2439	HARINA SELECTA 3KG	1	7802615005301	1	5750	1	3450	\N	\N
2427	SALCHICHA TRADICIONAL  5 UN PF	33	7801930000916	1	700	1	0	\N	\N
1182	LECHE SEMIDES.PLATANO 1 LT COLUN	21	7802920007175	3	1200	1	0	\N	\N
2136	CARBON EN BOLSA 1 KG	1	12345	1	1300	1	1000	\N	\N
2443	BARRA CEREAL VIVO 21G	1	7802215301414	1	250	1	0	\N	\N
2437	HARINA MERKAT C/POLVO 	1	7802655000427	1	1000	1	0	\N	\N
2447	FACE PAINTS 	1	6932012111020	1	1500	1	0	\N	\N
2448	HAPPY BIRTHDAY 	1	090660512043	1	600	1	0	\N	\N
2446	MAMADERA AVENT 	1	6951245781244	1	2500	1	0	\N	\N
2441	SCOTT RINDES MAX DOBLE HOJA 6UN	1	7809604026644	1	1990	1	0	\N	\N
2063	PALLMALL CLICK 20	55	78018884	1	3500	1	0	\N	\N
2064	PALLMALL MENTHOL CLICK 20	55	78019058	1	3400	1	0	\N	\N
1311	DURAZNOS TROCITOS MERKAT 3KG 	1	7801800104591	1	4500	1	0	\N	\N
2432	CHARLOT MORA CREMA 1LT	1	7613031246205	1	3000	1	0	\N	\N
2433	CASATA LUCUMA SAVORY 1LT	6	7802710350054	1	2700	1	0	\N	\N
372	SHAMPOO FRUCTIS NUTRICIÓN VITAMINADA 350 ML 	2	7509552906493	1	2500	1	0	\N	\N
2450	JUEGO LOTERIA 	1	2000000001234	1	2000	1	0	\N	\N
245	JUGO SPRIM MULTIFRUT 35 GR 	1	7802575223067	1	190	1	0	\N	\N
2451	VELAS HAPPYBIRTHDAY 	1	120660524569	1	700	1	0	\N	\N
2751	BOLSAS IMPEKE 50X70	1	7806810800754	1	550	1	0	\N	\N
2452	VELAS DE CUMPLEAÑOS 	1	6932525038043	1	650	1	0	\N	\N
2453	ESCOBILLA DE ROPA 	1	B023	1	850	1	0	\N	\N
848	GALLETA SALVADO BAGLEY TRIPACK 642GR	6	7802225317313	1	2300	1	0	\N	\N
1421	PRIMAVERA DE VEDURAS 400G MONTINA 	32	7804115001432	1	750	1	0	\N	\N
2122	KANIKAMA 500G 	7	211006	1	2300	1	0	\N	\N
1634	VELAS DE CUMPLEAÑOS BIRTGDAY CANDLE SET 12UN 	34	9328567891345	1	650	1	0	\N	\N
324	PAÑALES BABYSEC M 24UN	2	7806500793205	1	3500	1	0	\N	\N
876	AGUA S/GAS  PURE LIFE 6 LTS	5	7801620006044	1	1950	1	0	\N	\N
4325	MONDADIENTE TTOOTHPICK	1	6936805400094	1	500	1	0	\N	\N
192	GELATINA AMBROSOLI NARANJA 50 GRAMOS 	1	7802200363984	1	400	1	0	\N	\N
2146	BRAZO DE REINA GRANDE	12	648	1	5000	1	0	\N	\N
2454	DUFOUR ULTRA PURA 5 LTS.	1	7804520002024	1	1290	1	0	\N	\N
2081	LUCKY STRIKE AZUL 20 U	55	78000285	1	4400	1	4200	\N	\N
364	SERVILLETA ELITE UNA HOJA 	2	7806500221128	1	550	1	420	\N	\N
128	DINDON 115 G COSTA 	6	7802215502514	1	650	1	0	\N	\N
2147	CHORIZOS WINTER 1KG 	1	7801900270042	1	2500	1	0	\N	\N
2150	CHAMITO TUTTI FRUTTI 80ML 	1	2000000001036	1	350	1	0	\N	\N
2456	CINTILLOS HALLOWEEN 	1	2000000001241	1	1000	1	0	\N	\N
2457	BOLSAS DE HALLOWEEN 	1	2000000001258	1	1500	1	0	\N	\N
2459	ACEITE VEGETAL 900 ML LA REINA	9	7802810009593	1	1200	1	0	\N	\N
2462	CADAVER ARTICULADO 	1	6922332100620	1	1500	1	0	\N	\N
2463	MASCARAS FESTIVITY 	1	6922332126484	1	1500	1	0	\N	\N
2464	MASCARAS FESTIVITY 	1	6922332118304	1	1500	1	0	\N	\N
391	SHIP ZERO NARANJA 3 LITROS 	5	7801608000149	1	800	1	0	\N	\N
2460	ACEITE BELMONT 900ML 	1	7802810010971	1	1860	1	0	\N	\N
447	SPAGHETTI N5 3VEGETALES LUCCHETTI 400G	1	7802500002354	1	1350	1	800	\N	\N
321	PAÑAL BABYSEC XXG 16UN	2	7806500731085	1	3690	1	0	\N	\N
414	TOALLA HUMEDAS BABYSEC PREMIUM 50 UN. 	2	7806500730514	1	1350	1	0	\N	\N
2120	MARISCO SURTIDO 500G 	7	7804641410029	1	2490	1	0	\N	\N
4445	WHISKAS CARNE 	77	236	2	2990	1	0	\N	\N
379	SHIP COLA 2 LITROS 	5	7801608000040	1	650	1	0	\N	\N
2465	MASCARAS FESTIVITY 	1	6930165300025	1	1500	1	0	\N	\N
2466	MASCARAS FESTIVITY 	1	6922332122677	1	1500	1	0	\N	\N
2467	PANTY NEGRA ESQUELETO 	1	6922332112357	1	2000	1	0	\N	\N
2148	SALCHICHAS TRAD. WINTER 225G	1	7801900087701	1	600	1	0	\N	\N
2455	TORTA 20 PERSONAS BIZCOCHO	12	657	2	17000	1	0	\N	\N
1632	VELAS DE CUMPLEAÑOS BALLOONS 24UN 	34	7806130003729	1	700	1	0	\N	\N
2123	CAMARONES 	7	998	2	12000	1	0	\N	\N
2468	PANTY TELA DE ARAÑA 	1	6922332100989	1	2000	1	0	\N	\N
2469	PANTY MURCIELAGO NEGRO 	1	6922332100996	1	2000	1	0	\N	\N
4326	BOLSOS DE GENERO ARTESANAL 	1	2000000001685	1	2500	1	0	\N	\N
4328	CASATA MANJAR SAVORY 900 ML 	1	7613287043061	1	3900	1	0	\N	\N
2470	GUIRNALDA HALLOWEEN 	1	6922332100071	1	890	1	0	\N	\N
2471	GUIRNALDA HALLOWEEN 	1	6922332100033	1	890	1	0	\N	\N
2149	YOGHURT NATURAL  155 GR SOPROLE	21	7802900130114	1	400	1	0	\N	\N
780	GALLETA ARCOR FESTIDULCE 35GR	6	7802225680448	1	300	1	200	\N	\N
2478	MANI SALADO  180 GRS SEMBRASOL	70	7804644840076	1	1000	1	0	\N	\N
2482	CHARKI DE EQUINO 20G 	1	7804612220268	1	950	1	0	\N	\N
2486	PASAS  80 GRS SEMBRASOL	70	7804612220220	1	850	1	0	\N	\N
1069	GATOLATE EVERCRISP 110GR	6	7802000011450	1	1000	1	0	\N	\N
742	TE SUPREMO JENGIBRE LIMON 20UN.	1	7801875001580	1	1500	1	0	\N	\N
2488	MANI CONFITADO  120 GRS SEMBRASOL	70	7804644840021	1	1300	1	1200	\N	\N
2479	SUPER MIX  80 GRS SEMBRASOL	70	7804612220428	1	1400	1	1300	\N	\N
2487	MANI TIPO JAPONES  100 GR SEMBRASOL	70	7804644840229	1	1400	1	1300	\N	\N
2492	MOSTAZA TRAVERSO 350G	1	7802337910013	1	1600	1	0	\N	\N
2163	PATE JAMON  125 GR RECET DEL ABUELO	33	7801930008509	1	700	1	0	\N	\N
2162	PATE SALAME  125 GR RECET DEL ABUELO	33	7801930008226	1	700	1	0	\N	\N
1710	PIMENTON MOLIDO15G MP 	1	7802420811494	1	230	1	0	\N	\N
1709	NUEZ MOSCADA5G MP	1	7802420810138	1	250	1	0	\N	\N
71	CHAMPIÑONES LAMINADOS ESMERALDA 400 GRAMOS 	1	7802420510083	1	1500	1	0	\N	\N
1346	QUEQUE CHICO 	12	615	1	600	1	0	\N	\N
2158	CABRITA TRADICIONAL KIÑE 	6	7800000000016	1	600	1	0	\N	\N
2127	CHEF VEGETAL 1 LT 	1	7802810002129	1	3490	1	2500	\N	\N
2159	CABRITA COLORES KIÑE	47	2000000001050	1	700	1	0	\N	\N
2408	SUAVIZANTE PININA 5LT 	2	2000000001210	1	2800	1	0	\N	\N
946	ROCKLETS BON O BON DOYPACK 130GR	6	7802225427807	1	1000	1	0	\N	\N
2160	JAMON SANDWICH DE AVE MONTINA 	31	306	2	6000	1	3300	\N	\N
2493	SALSA GOURMET CARAMELO 300G	1	7802410506393	1	2000	1	1400	\N	\N
2491	CHAMPIÑON ENTERO LAMINADO 400G ESM. 	1	7801315148882	1	1500	1	0	\N	\N
490	CACHANTUN MAS UVA 500 CC	5	7801620005344	1	850	1	800	\N	\N
2484	MANI CON  CASCARA  100 GRS SEMBRASOL	70	7804644840083	1	1400	1	1300	\N	\N
2485	ALMENDRAS NATURALES SELECCION 50 GRS SEMBRASOL	70	7804612220190	1	1400	1	1300	\N	\N
2483	CHARKI DE EQUINO 	1	7804612220275	1	2200	1	2000	\N	\N
2480	MANI SALADO  120 GRS SEMBRASOL	70	7804612220404	1	1300	1	1200	\N	\N
2157	HELADO DE PIÑA CHAMONIX	6	7613032484934	1	1900	1	1800	\N	\N
5373	CARNE DE CHORITOS 500G	1	7804641410005	1	2490	1	2300	\N	\N
2165	MIHOGAR 4 ROLLOS 50MTS 	1	7804653340864	1	1350	1	0	\N	\N
2495	REXONA MEN MOTIONSENSE 	1	7791293022567	1	2650	1	0	\N	\N
2496	CREMA PARA BATIR CALO 200G	1	7802910006836	1	750	1	0	\N	\N
2497	CREMA LISTA  200 ML CALO	21	7802910001978	1	750	1	0	\N	\N
117	DOVE ORIGINAL 150 ML 	2	7506306241183	1	2300	1	0	\N	\N
2499	LAMINADO GAUDA COLUN 500G	1	7802920777498	1	3600	1	0	\N	\N
2166	ENERGIZER D2	1	039800011398	1	750	1	0	\N	\N
828	VIRUTILLA FINA MANLAC 2 MEDIANA	2	7806800001130	1	750	1	0	\N	\N
982	YOGURTH CHAMYTO DAMASCO 115GR	4	7613037416329	1	250	1	0	\N	\N
1864	GLOBOS 18SEP 12 U	1	6901719980123	1	0	1	0	\N	\N
2508	CARAMELOS SURTIDOS HALLOWEEN 750G	1	7802200127753	1	2400	1	0	\N	\N
1037	CARAMELO MASTICABLE KEGOL MANZANA UNIDAD	6	227	1	50	1	0	\N	\N
289	MAGNUM ALMENDRAS BRESLER 100 ML 	7	7805000310462	1	1790	1	1590	\N	\N
1662	LENTEJAS GRANEL 	11	129	2	1800	1	0	\N	\N
2512	CEREALES ESTRELLITAS  330 GRS NESTLE	27	7613034232601	1	2100	1	0	\N	\N
4054	PRINGLES	1	038000183713	1	1990	1	0	\N	\N
4055	TRENTO	1	7896306612831	1	400	1	0	\N	\N
2505	CHOC. HEIDI DARK MILD 80G	1	5941021013523	1	2650	1	2200	\N	\N
2504	CHOC. HEIDI DARK MINT LEMON 	1	5941021003203	1	2650	1	2200	\N	\N
2494	SALSA CHOCOLATE  250 GR AMBROSOLI	71	7802200183025	1	1950	1	0	\N	\N
2514	DANKY CHEESKATER SAVORY 125ML 	1	7613036633000	1	1590	1	0	\N	\N
1043	ALKA ICE STRONG 390GR	6	7802225310277	1	250	1	0	\N	\N
1225	SUPER 8 CUCHUFLAI 10G 	1	7613036623155	1	100	1	0	\N	\N
1090	PAPAS LAYS CORTE AMERICANO 72GR	6	7802000010897	1	800	1	0	\N	\N
2515	CHURRAZO 35G 	1	7802408005778	1	200	1	0	\N	\N
907	TURRON DOS EN UNO 45GR	6	7802225260657	1	250	1	0	\N	\N
1878	GALLETA MANTEQUILLA  200 GR FRUNA	26	7802408003484	1	650	1	500	\N	\N
2476	GRAN PIPONA  230 GRS SEMBRASOL	70	7804644840151	1	1800	1	1700	\N	\N
2506	CHOC. HEIDI DARK CRANBERRI 80G	1	5941021005122	1	2650	1	2200	\N	\N
973	CARAMELO MASTICABLE KEGOL FRUTILLA UNIDAD	6	218	1	50	1	0	\N	\N
984	COLGATE TRIPLE ACCION 99GR	2	P002	1	1200	1	0	\N	\N
2171	TRAPERO HUMEDO EXCELL MULT. 	1	7805020001876	1	2250	1	0	\N	\N
3253	SOPROLE ZERO LACTO 1LT	1	7802900195076	1	1400	1	0	\N	\N
2539	LIMONADA ORIGIMAL PRANZO 475CC	1	7804666920008	1	1290	1	0	\N	\N
2549	DESODORANTE MAJIX 	1	8696630126559	1	1800	1	0	\N	\N
2550	DESODORANTE MAJIX 	1	8696630126597	1	1490	1	0	\N	\N
2551	DESODORANTE MAJIX 	1	8696630126573	1	1800	1	0	\N	\N
2554	JALEA REGIMEN MARACUYA 100G	1	7801305005041	1	400	1	0	\N	\N
712	CEREALES SOBRE ZUCOSOS NESTLE 30GR	6	7613031291359	1	300	1	0	\N	\N
2555	CORNETO 74G	1	7805000318109	1	690	1	0	\N	\N
2556	JALEA REGIMEN  NARANJA 100G	1	78018570	1	400	1	0	\N	\N
2557	JALEA REGIMEN LIMON 100G	1	78018594	1	400	1	0	\N	\N
1175	QUESO CHANCO LAMINADO 250G LACTEOS DEL MAULE 	1	7804613390960	1	1600	1	0	\N	\N
2561	RAMITAS MARCO POLO 270G	1	7802420127687	1	1200	1	0	\N	\N
2189	PIÑA GRANADINA BRESLER 2.5L	1	7805000317621	1	3500	1	0	\N	\N
1196	SOPA POLLOCON FIDEOS 70G GOURMET 	1	7802410002246	1	500	1	0	\N	\N
1197	SOPA COSTILLA CON FIDEOS 62G GOURMET 	1	7802410002253	1	500	1	0	\N	\N
1041	ALKA ICE CEREZA 390GR	6	7790580406301	1	250	1	0	\N	\N
2192	PAN DE PASCUA  500 GR IDEAL	24	7803473003676	1	2200	1	0	\N	\N
2191	PAN DE PASCUA F.CONFI.IDEAL 700 GR	24	7803473242211	1	4200	1	0	\N	\N
2190	PICADO CARNE/ESPINACA 215 GR NESTLE	43	7802950003642	1	1990	1	0	\N	\N
1460	LECHUGA MARINA 	11	2000000000428	1	650	1	0	\N	\N
2193	SAVORY PIÑA 1LT	1	7802710831119	1	2350	1	0	\N	\N
2542	DURAZNOS MITADES 820G DOS CABALLOS 	1	7801380101522	1	1800	1	0	\N	\N
2563	ALUBACS BOLSAS HERMETICAS 	1	7801875001191	1	2400	1	0	\N	\N
2564	CLORO TRADICIONAL  250 ML CLOROX	22	7805025012501	1	450	1	0	\N	\N
2565	POROTO HALLADO DIAZ 500G	1	7801350500157	1	1400	1	0	\N	\N
2560	RAMITAS MARCO POLO  270G	1	7802420127694	1	1200	1	0	\N	\N
2510	MAGNUM BLANCO FRAMBUESA78NL 	1	7805000310479	1	1790	1	1590	\N	\N
2513	MEGA MARACUYA 90ML SAVORY 	1	7613037506211	1	1690	1	1590	\N	\N
827	POETT LAVANDA 250 CC	2	7805025688355	1	450	1	0	\N	\N
2567	ACOND. BALLERINA PALTA	1	7804920003232	1	1400	1	0	\N	\N
2568	ACOND MANZANILLA BOLSA 900 ML BALLERINA	72	7804920055040	1	1400	1	0	\N	\N
1133	SAL PARRILLERA YODADA 750G TRINIDAD 	1	7804667660002	1	1150	1	0	\N	\N
2569	SHAMPOO HIPOALERGENICO 900 ML BALLERINA	72	7804920019349	1	1500	1	0	\N	\N
2566	ACOND. BALLERINA NUT. HIDRAT. 	1	7804920005915	1	2000	1	1500	\N	\N
2571	TANAX PULGAS Y GARRAPATAS 220CC	1	7805300052093	1	2590	1	0	\N	\N
2449	SET MAQUILLAJE VAMPIRO ARGOS 	1	7805670187302	1	2000	1	0	\N	\N
2559	FOSFOROS PUERTO VARAS 250UN	1	7804603462158	1	1300	1	0	\N	\N
2558	ACEITE COLISEO VEGETAL 900ML 	1	7804608220005	1	2800	1	1850	\N	\N
1063	PAPAS LAYS STAX ORIGINAL 140GR	6	7802000009266	1	1700	1	0	\N	\N
892	DURAZNOS EN CUBOS ACONCAGUA 4UN	1	7801800103563	1	2700	1	0	\N	\N
1785	 CERA ARUBA 300CC	2	7805027000520	1	600	1	0	\N	\N
80	CHOCOLATE ORLY BERRIES 115 G 	6	7802200894136	1	1100	1	1000	\N	\N
4056	SQUARES PISTACHO	1	59080480	1	300	1	0	\N	\N
2573	LECHE DESCREMADA  1 LT SOPROLE	21	7802900034016	1	1000	1	0	\N	\N
2575	MIL PURA DE ABEJA TOCOMIEL 1/2 KILO 	1	2000000001289	1	2660	1	0	\N	\N
2577	LUSH COCOA CREME COOKIES ORIGINAL 	1	8681042330052	1	350	1	0	\N	\N
2578	LUSH PEANUT BUTTER COOKIES 	1	8681042330359	1	350	1	0	\N	\N
378	SHAMPOO PANTENE RESTAURACIÓN 400 ML 	2	7501006721133	1	2650	1	0	\N	\N
2581	LUSH COCOA CREAM COOKIES WITH COFFEE	1	8681042330557	1	350	1	0	\N	\N
4057	3 EN 1 USB 2A/1.2M ONEPLUS 	1	8944870150996	1	5000	1	0	\N	\N
4058	3 EN 1 USB ONE PLUS 	1	8944870151016	1	5000	1	0	\N	\N
4059	DATA CABLE B6151 ONE PLUS 	1	8944870161510	1	5000	1	0	\N	\N
4060	IRM FAST CHARGER 2 PORT. 	1	7858816062162	1	4000	1	0	\N	\N
1786	CERA ARUBA AMARILLA 300CC	2	7805027000537	1	750	1	0	\N	\N
4329	NOVA CLASICA 12M	1	7806500406488	1	650	1	0	\N	\N
641	FLAN NESTLE VAINILLA 110GR	4	7613035493957	1	350	1	0	\N	\N
2572	LECHE ZEROLACTOSA SEMIDES.1 LT SOPROLE	21	7802900200817	1	1200	1	1100	\N	\N
1166	APANADO DE POLLO 100G PF 	1	7801930018010	1	400	1	350	\N	\N
4061	SUPER BASS INEARSTEREO ELMCOEL 	1	7858816064920	1	4500	1	0	\N	\N
4062	AUDIFONOS EARPHONE FLASHPILL 	1	7858816068904	1	3500	1	0	\N	\N
4063	CABLE USB MTK 	1	8944870597593	1	6000	1	0	\N	\N
3827	JUREL AL NATURAL UNICA 425G	1	7801233000040	1	1390	1	0	\N	\N
2582	HAMBURGUESAS LA PREFERIDA 100G	1	7801916037615	1	500	1	0	\N	\N
1794	DOVE PINK 100G 	36	067238891183	1	850	1	0	\N	\N
2296	TOALLA NOVA CLASICA OSO 1UNID	65	7804520023319	1	500	1	0	\N	\N
2297	PAPEL HIGIENICO OSO 4UNID	66	7804520021933	1	1150	1	0	\N	\N
2198	YOGHURT LIGHT VAINILLA  120 GR SOPROLE	21	7802900234256	1	350	1	0	\N	\N
2197	SOPROLE FRUTILLA LIGHT 155G	1	7802900000943	1	450	1	0	\N	\N
1293	MANJAR  400 GR SOPROLE	21	7802900410018	1	1690	1	0	\N	\N
2107	TREMENDA MOROCHA 90G 	1	7613036333665	1	850	1	0	\N	\N
2580	LUSH VANILLA CREME COOKIES 	1	8681042330458	1	350	1	0	\N	\N
1294	MANJAR CALO 1 KILO 	1	7802910000872	1	2450	1	0	\N	\N
1784	DOVE GENTLE EXFOLIATING 100G 	1	8717163607268	1	1200	1	0	\N	\N
1343	MERENGUITOS 	12	614	1	500	1	0	\N	\N
2178	TRAPERO SIMPLE C/OJAL ARUBA 	1	7804645200152	1	1200	1	0	\N	\N
4330	TRENTO DARK 30G	1	7896306621147	1	350	1	0	\N	\N
3729	MANTEQUILLA QUILLAYES 125G	1	7802930000531	1	1250	1	0	\N	\N
3730	MANTEQUILLA QUILLAYES 250G	1	7802930000142	1	2600	1	0	\N	\N
4096	BATERIA PANASONIC 9V	1	8887549053832	1	1100	1	0	\N	\N
4140	MAXI SHIPS 200G	1	2000000001616	1	1150	1	0	\N	\N
4182	JUGO SPRIM LIMON DE PICA 35G	1	7802575223395	1	190	1	0	\N	\N
4228	NOVA CLASSICA GIGANTE 359 HOJAS	1	7806500401278	1	2990	1	0	\N	\N
3368	CLORO LIQUIDO EGLE PREMIUM 1LT	1	7812571801404	1	1000	1	0	\N	\N
3678	AUDIFONOS FIDDLER 	1	001BG047NEGR0	1	1850	1	0	\N	\N
1350	PIE DE LIMON INDIVIDUAL	12	626	1	1200	1	0	\N	\N
3802	JAMON PLANCHADO SOLER 	31	316	2	13000	1	0	\N	\N
1755	HUGGIES MANZANILLA 80UN. 	1	7702425805187	1	1250	1	0	\N	\N
1258	GALLETAS TRITON MANIWHITE 126G 	1	7613037085181	1	700	1	0	\N	\N
765	GALLETA ARCOR CHOC KISS 135GR	6	7802225688048	1	650	1	0	\N	\N
2794	ARROZ GRANO LARGO G2 AGROPRODEX 1KG 	1	7803920000579	1	850	1	0	\N	\N
2793	ARROZ COLISEO 1 KG G2	1	7804608220098	1	1200	1	0	\N	\N
3189	BENEDICTINO S/GAS 500 CC	75	7802820441000	3	550	1	0	\N	\N
1356	ENREJADOS DE MERMELADA	12	618	2	600	1	0	\N	\N
1292	LECHE SEMIDES.CHOCOLATE 1 LT COLUN	21	7802920801087	3	1550	1	0	\N	\N
713	CEREALES TRIX  30 GR NESTLE	6	7501073427532	1	300	1	0	\N	\N
346	RICOLATE CALAF 28 G 	1	7802220141081	1	300	1	0	\N	\N
301	MENTITAS MASTI CRUNCH 16 G 	6	7750885006941	1	150	1	0	\N	\N
2912	KEM PIÑA MARACUYA 2LT 	1	7801620008444	1	1300	1	0	\N	\N
3230	BOLSAS BASURA 50X70 VIRUTEX	73	7806810800433	1	680	1	0	\N	\N
3231	NESCAFE DOLCA 100 GR	1	7802950002164	1	3350	1	0	\N	\N
3299	MANTEQUILLA LOS ALERCES 125G	1	7802920202204	1	990	1	0	\N	\N
3425	CALDO VERDURA 120GR. MAGGI 	1	7613033821523	1	1400	1	0	\N	\N
3728	ALFAJOR PANCHOTE 50 GR	47	7802408001305	1	200	1	0	\N	\N
2825	CHAMPIÑONES LAMINADOS 500GR	1	7804653610462	1	1650	1	0	\N	\N
4331	BIO FRESCURA DE 3 KILOS 	1	7804609730282	1	5990	1	0	\N	\N
3018	CARNE VEGETAL DE SOYA 	31	310	1	4000	1	0	\N	\N
2102	TRENCITO TUBITO 16G 	1	78939387	1	250	1	0	\N	\N
3064	JUREL NATURAL MAR DEL SUR 425G 	1	7803505000406	1	1150	1	0	\N	\N
3047	ACEITE OLIVA BANQUETE 250 ML	1	7801420000617	1	3200	1	2200	\N	\N
3049	VITAL KIDS 250ML 	1	7802820133226	1	300	1	0	\N	\N
3658	AMPOLLETAS 100W WESTINGHOUSE 	1	3000721900020	1	900	1	0	\N	\N
3079	TOALLA NOVA EXTRA X 3 12.5 MTS	73	7806500405207	1	1690	1	0	\N	\N
1317	RAPIDITAS TAMAÑO M 8UN.	1	7803403002571	1	1000	1	0	\N	\N
1771	LIMPIAVIDRIOS SAPOLIO 650ML	2	7751851405935	1	850	1	0	\N	\N
2352	MONEDAS DE TERROLATE 20 UN. 	1	7802225570978	1	1300	1	0	\N	\N
1995	FANTA 1,1 LTS	48	7801610106303	1	1000	1	0	\N	\N
1748	MANJAR SOPROLE POTE 200MG 	1	78040516	1	790	1	0	\N	\N
2106	TRITON LEMON WHITE 126G 	1	7613036615815	1	700	1	0	\N	\N
86	CHOCOLATE VIZZIO 120 G 	6	7802215104848	1	1750	1	0	\N	\N
3320	SEMOLA TRIGO  250 GR CAROZZI	1	7802575007438	1	690	1	0	\N	\N
473	ARROZ G2 ARUBA 500G	1	7801430830068	1	600	1	0	\N	\N
2220	SALSA AMERICANA  200 GR DON JUAN	61	7802351421205	1	890	1	0	\N	\N
9	ACONDICIONADOR FRUCTIS FRESCURA VITAMINADA 350 ML 	2	7509552915112	1	2500	1	0	\N	\N
197	GOLDEN NUSS AMBROSOLI 140 G 	6	7802200840263	1	1400	1	0	\N	\N
451	TALLARINES 87  400 GR COLISEO	1	7798031153712	1	550	1	0	\N	\N
897	CHAMYTO TUTTIFRUTI 80ML	4	201	1	0	1	0	\N	\N
1094	GALLETA TODDY 178GR	6	7790310982525	1	1100	1	0	\N	\N
1661	PALETAS DE PING PONG REGAIL	37	6980154920864	1	2500	1	0	\N	\N
2445	PALETAS DE PLAYA 	1	2000000001227	1	3500	1	0	\N	\N
2490	RUSTICAS CORTE REJILLA 185G	1	7802420004322	1	2000	1	0	\N	\N
2822	KETCHUP HELLMANNS 100G	1	7802640793471	1	750	1	0	\N	\N
1199	BASE PARA PESCADO FRITO 80G GOURMET 	1	7802410350903	1	730	1	0	\N	\N
2579	LUSH COCOA CREME COOKIES DARK 	1	8681042330250	1	350	1	0	\N	\N
4333	  GALLETAS NAVIDEÑAS 	1	7802215504068	1	1300	1	0	\N	\N
590	MILO SACHET  28 GRS MILO	1	7613034868237	1	300	1	0	\N	\N
2305	TOALLAS DESMA. FACECLIN 25 UN	1	7806519000493	1	800	1	0	\N	\N
327	PAÑALES HUGGIES G 20 UN	2	7809604029416	1	4700	1	0	\N	\N
3152	SPRITE ZERO LATA 350CC	75	7801610223192	1	600	1	0	\N	\N
2603	ALWAYS ULTRAFINA CON ALAS 16UN.	1	7500435130622	1	1900	1	0	\N	\N
3170	MORF 30G	1	7802225280860	1	250	1	0	\N	\N
3333	TOALLA PAPEL FRESH 3 ROLLOS 	1	742832833639	1	1100	1	0	\N	\N
2882	BENEDICTINO CON GAS 1.5 LTS	75	7802820441529	1	700	1	0	\N	\N
550	PAP DESECHABLE 3 LTS	5	7801620001216	1	2000	1	1950	\N	\N
621	1+1 TRIX 142GR	4	7613033081477	1	600	1	0	\N	\N
3731	QUESO CHANCO 9 LAMINAS 150G	1	7802930001453	1	1890	1	1600	\N	\N
3732	QUESO GAUDA QUILLAYES 9 LAM. 150G	1	7802930001323	1	1830	1	1400	\N	\N
1252	GALLETAS MARAVILLA 147 G MCKAY 	1	7613032789480	1	700	1	0	\N	\N
3539	GALLETA COCO MCKAY 120G	1	7613030518426	1	700	1	0	\N	\N
1428	CHOCLO TROZO  200 GRS FRUTOS DEL MAIPO	32	7801300000539	1	600	1	0	\N	\N
1742	GOLD TRADICIONAL  165 GR SOPROLE	21	7802900000356	1	600	1	0	\N	\N
3281	VINAGRE ROSADO HIGUERAS 250ML	1	7802337920401	1	550	1	0	\N	\N
439	SPAGHETTI 5  400 GRS DON VITTORIO	1	7750243286145	1	600	1	0	\N	\N
2947	VIENESAS LA ESPAÑOLA 20 UND. 	1	7801930014272	1	2400	1	0	\N	\N
3445	LEVADURA SAF-INSTANT 125G	1	7798018850566	1	1850	1	0	\N	\N
189	GALLETAS SODA LINE 54 G 	6	7802215511622	1	250	1	0	\N	\N
1266	LONCO LECHE SEMIDESCREMADA CHOCOLATE 1 LITRO 	1	7802910000230	1	1600	1	0	\N	\N
2014	SAHNE NUSS 250 GR NESTLE	25	7802230070227	1	3600	1	3400	\N	\N
3502	SURTIDO CALDILLO  425 GR MAR CHILENO	1	7804709995062	1	1750	1	0	\N	\N
2898	HEAD SHOULDERS MEN 3X1	1	7500435019491	1	3600	1	0	\N	\N
3241	GALLETAS VIVO 4SEMILLAS 153G	1	7802215501609	1	800	1	0	\N	\N
2306	GOLDEN NUSS 25G 	1	7802200042865	1	400	1	0	\N	\N
3635	MONO ROLLS 400G	1	7802215168970	1	2600	1	0	\N	\N
2802	YOGURT LOS ALERCES FRAMBUESA 125GRS	1	7802920106038	1	200	1	0	\N	\N
3350	JABON PROTEX OMEGA 3 125G	1	7891024028575	1	990	1	0	\N	\N
3710	ACEITE VEGETAL EL MONARCA 900ML	1	7804658860091	1	1550	1	0	\N	\N
3633	WAFFER CLASICA 95G	1	7802215504846	1	1200	1	0	\N	\N
3085	TOALLAS HUMEDAS CHIKOOL 80UN. 	1	6957931415653	1	1550	1	0	\N	\N
2713	LUSH COCOA CREME COOKIES	1	8681042330151	1	350	1	0	\N	\N
2342	TWISTOS HORNEADOS 110G 	1	7802000001796	1	1000	1	0	\N	\N
148	FIDEOS ACONCAGUA ESPIRALES 400 GRAMOS 	1	7802575300492	1	500	1	0	\N	\N
2600	LADY SPEED STICK POWDER FRESH 150ML	1	7509546063843	1	2250	1	0	\N	\N
2656	ALOE VERA GRANADA 500ML	1	7804645050214	1	1000	1	0	\N	\N
261	JUGO ZUKO NARANJA PLATANO 25 GRAMOS 	1	7802800578887	1	200	1	0	\N	\N
113	AXE APOLLO 150 ML 	2	7791293025780	1	2200	1	0	\N	\N
565	NECTAR LIGHT PIÑA PET  1,5 LT WATTS	5	7801620006341	1	1500	1	1350	\N	\N
2837	RIGOCHOC 113G 	1	7802225640558	1	1300	1	1100	\N	\N
4334	CONQUISTA 300G	1	7802225680547	1	1100	1	0	\N	\N
1017	KRYZPO PIZZA 40GR	1	7802800535590	1	700	1	0	\N	\N
1361	CARNE MOLIDA 250G SAN JORGE 	20	7801907009782	1	1100	1	1000	\N	\N
226	LE SANCY 90 G FRUTOS ROJOS Y YOGURTH 	2	7791293036557	1	1000	1	650	\N	\N
404	TE CLUB ORO 20 UN. 	1	7805000311599	1	900	1	0	\N	\N
82	CHOCOLATE ORLY MENTA 115 G 	6	7802200894112	1	1100	1	1000	\N	\N
1193	TAMPAX SUPER PLUS 10 UN 	1	020800600347	1	2450	1	0	\N	\N
844	GALLETA SALVADO MULTIGRANO SELZ 519GR	6	7802225689939	1	2000	1	0	\N	\N
1810	SERVILLETA GIULIETTA 300UN. 	2	661094233585	1	1400	1	0	\N	\N
1140	CHORITOS ACEITE  425 GRS CRUCERO	17	7804520988281	1	1650	1	0	\N	\N
822	SAPOLIO FERIA DE FLORES 2KG	2	7751851025362	1	3900	1	0	\N	\N
1700	OREGANO ENTERO20G MP	1	7802420110177	1	390	1	0	\N	\N
2026	MANTECA PALMIN 200G	1	7802810006851	1	1000	1	0	\N	\N
2027	MANTECA  100 GRS PALMIN	21	7802810006868	1	500	1	0	\N	\N
4267	CIGARRO ATLAS WHITE 20 UN	55	78022782	1	2300	1	0	\N	\N
1231	GALLETAS PRINCIPE CHOCOLATE 84G	1	7441029504613	1	450	1	0	\N	\N
266	KETCHUP JB 100 GRAMOS 	1	7802640600090	1	550	1	0	\N	\N
2214	AJI EN SALSA 100G 	1	2000000001104	1	250	1	0	\N	\N
445	CORBATAS TALLIANI 400G	1	7802500008028	1	990	1	0	\N	\N
76	CHOCMAN COSTA 33G 	6	7802215303401	1	150	1	0	\N	\N
479	ARROZ G2 HOMAR 1KG	1	7804645050009	1	650	1	0	\N	\N
2226	MUSTANG ALMENDRADO FRUNA	62	7802408005167	1	450	1	0	\N	\N
2227	HELADOS GIGI VASITO 120CC 	1	2000000001111	1	350	1	0	\N	\N
2516	QUESO RANCO 15 LAMINAS COLUN 	1	7802920004112	1	2700	1	0	\N	\N
2412	RIO BUENO MANTECOSO 13 LAM. 250G	1	7802920006352	1	2750	1	0	\N	\N
174	GALLETAS FRAC CLÁSICA 130 G 	6	7802215512261	1	600	1	0	\N	\N
2224	TORTILLA MEXICANA TIA ROSA IDEAL	23	7803473002242	1	1500	1	1400	\N	\N
4268	OREGANO ENTERO EDRA 200G	1	7802420004865	1	400	1	0	\N	\N
306	MOSTAZA DON JUAN 100 GRAMOS 	1	7802351311001	1	400	1	0	\N	\N
1811	YOGHURT BATIDO FRUTILLA  120 GR SOPROLE	21	7802900230227	1	300	1	250	\N	\N
2015	CHOCOLATE TRENCITO 150 GRS	25	7802230070029	1	2290	1	1900	\N	\N
1324	PAN PITA	8	8	2	2200	1	1750	\N	\N
1606	TRULULU 70ML SAVORY 	6	7613032180096	1	400	1	0	\N	\N
1821	GUANTE DOMESTICO TALLA M	2	2112345680866	1	650	1	0	\N	\N
1822	GUANTES DE BAÑO	2	B138B138	1	300	1	0	\N	\N
45	ATUN LOMITOS EN AGUA DEYCO 170 GRAMOS 	1	7801534002309	1	1200	1	0	\N	\N
56	BON O BON MINI 25 G 	6	7802225513494	1	300	1	0	\N	\N
60	CAFE PREMIER GRANULADO GOLD 170 GRAMOS 	1	7802800500758	1	3600	1	0	\N	\N
61	CALIPTUS 25 G AMBROSOLI 	6	7802200139664	1	200	1	0	\N	\N
502	BILZ RETORNABLE  2 LT CCU	5	7801620290177	1	1350	1	0	\N	\N
2058	CALUGAS DE LECHE 	1	2000000000954	1	100	1	0	\N	\N
2044	MAYODELI KRAFT 200 G	1	7798146130974	1	1100	1	0	\N	\N
246	JUGO SPRIM NARANJA 35 GRAMOS 	1	7802575222893	1	190	1	0	\N	\N
297	MAYONESA CLICK 760 GRAMOS 	1	7805000301422	1	1500	1	0	\N	\N
2065	LUCKY STRIKE CLICK & ROLL 20	55	78015432	1	4100	1	0	\N	\N
4269	GOOD LEMON 475 ML LIMONADA MARACUYA	1	7804667390183	1	1500	1	0	\N	\N
1028	ESPIRALES ROMANO 400GR	1	7802500017013	1	600	1	0	\N	\N
602	SOPA MAGGI CARNE CON SEMOLA 8GR	1	7802950008821	1	0	1	0	\N	\N
1582	MONDADIENTES ESTILO 100 PCS 	34	7896187800013	1	500	1	0	\N	\N
1437	SALCHICHA POLLO 5 UN PF	33	7801930006420	1	750	1	0	\N	\N
454	PURE DE PAPAS POLVO MAGGI 250G	1	7613037027488	1	1400	1	0	\N	\N
303	MIFRUT FRUTILLA YOGURT 90 G 	1	7802200270237	1	350	1	0	\N	\N
2121	PAILA MARINA 500G 	7	7804641410012	1	1800	1	0	\N	\N
599	CALDO CARNE 8TBL. MAGGI 	1	7802950005967	1	990	1	0	\N	\N
18	AEROSOL IGENIX DESINF. VAINILLA 360 CM3	2	7805040000699	1	1900	1	0	\N	\N
162	GALLETA FRAC MENTA 130 G 	6	7802215203039	1	600	1	0	\N	\N
332	ELITE 4 ROLLOS 30 METROS 	2	7806500508618	1	1450	1	0	\N	\N
487	BILZ ZERO DES. 2 LTS	5	7801620006501	1	1100	1	1300	\N	\N
617	CHIQUITIN PLATANO 45GR	4	78041110	1	300	1	250	\N	\N
1558	BOLSOS DE REGALO PARA VINOS CON CORDON 	34	2000000000732	1	1200	1	900	\N	\N
2239	TUAREG MANGO PIÑA 	1	7802215502545	1	650	1	0	\N	\N
2113	CASATA SABOR TRES LECHE SABORY	6	7613031238217	1	2800	1	2350	\N	\N
333	NOBLE DOBLE HOJA 4UN 25 MT	2	7806500507956	1	1000	1	0	\N	\N
484	SIX PACK CERV.BUDWEISER 355 ML	3		1	0	1	0	\N	\N
650	NESCAFE MIXES VIENES 18 GR	1	7613033458507	1	350	1	0	\N	\N
665	MOSTAZA JB 240GR	1	7802640400287	1	1300	1	0	\N	\N
345	RAID MATA MOSQUITOS MOSCAS Y ZANCUDOS SON OLOR 360 CM3	2	7790520508607	1	2900	1	0	\N	\N
132	ESCOBILLÓN CLORINDA MULTIUSOGRANDE FIBRAS SUAVES 	2	7805080140034	1	2300	1	0	\N	\N
634	SEMOLA FRAMBUESA NESTLE 135GR	4	7613035953741	1	600	1	0	\N	\N
648	FLAN NESTLE CHOCOLATE 110GR	4	7613035493926	1	300	1	0	\N	\N
443	CARACOQUESOS CAROZZI 296G	1	7802575015075	1	2000	1	1300	\N	\N
856	DULCES ARCOR BASTON VIENA 470GR	6	7790580344207	1	1950	1	0	\N	\N
1635	VELAS DE CUMPLEAÑOS HAPPY BIRTHDAY 24 UN 	34	6941596872319	1	1150	1	0	\N	\N
759	GALLETA CHOCOLINAS 170GR	6	7790040414440	1	700	1	0	\N	\N
4270	LIMONADA BLUEBERRY GOOD LEMON 475	1	7804667390060	1	1500	1	0	\N	\N
1452	EMPANADA NAPOLITANA 	12	637	1	900	1	0	\N	\N
143	FIDEO LUCCHETTI TALLARINES N° 77 400 GRAMOS 	1	7802500000039	1	1300	1	800	\N	\N
1454	TORTA DE HOJA 15 PERSONAS 	12	634	2	17000	1	0	\N	\N
539	PEPSI RETORNABLE 2 LT	5	7801620015688	1	1300	1	0	\N	\N
1483	CEBOLLIN	11	2000000000534	1	550	1	0	\N	\N
2307	MARGARINA POTE 250 GR SOPROLE	21	7802900611019	1	1100	1	0	\N	\N
1450	EMPANADA DE PINO 	12	635	2	1500	1	0	\N	\N
2093	BATERIA MAXDAY	1	7895623003001	1	1000	1	0	\N	\N
644	MOUSSE TRENCITO 70GR	4	7613037076820	1	550	1	0	\N	\N
398	SUCEDÁNEO DE LIMÓN TRAVERSO 250 ML 	1	7802337801014	1	600	1	0	\N	\N
2078	PALLMALL PLOMO 10	55	78018860	1	2000	1	1800	\N	\N
285	CLORO GEL IMPEKE TRADI. 900 ML 	2	7806810022170	1	1550	1	1650	\N	\N
120	BIO FRESCURA BOSQUE NATIVO 800G	2	7804609730176	1	1900	1	1300	\N	\N
270	LADYSOFT NOC. ULTRAD. ULTRAS. C/ALAS  8UN.	2	7806500960492	1	900	1	1000	\N	\N
1453	KUCHEN CHICO 	12	633	2	800	1	0	\N	\N
299	MAYONESA SUPREME CLASICA HELLMANNS 451 GRAMOS 	1	7805000301989	1	2590	1	0	\N	\N
2067	CONO SFOT CHICO 	6	2000000000961	1	600	1	0	\N	\N
2125	PERSIANAS 	12	644	1	550	1	0	\N	\N
2052	SCHICK XTREME 3 NORMAL	36	7591066721020	1	1000	1	0	\N	\N
2053	SCHICK XTREME3 SENCIBLE	57	7591066701015	1	1000	1	0	\N	\N
1331	QUEQUE INTEGRAL 	12	602	1	2500	1	0	\N	\N
195	GILLETTE WILKINSON 	2	78016118	1	550	1	0	\N	\N
133	ESOBILLÓN CLORINDA MULTIUSO MEDIANO FIBRAS SUAVES 	2	7805080140027	1	2500	1	0	\N	\N
2055	SCHICK QUATTRO 4 TITANIUM	57	4891228530136	1	1000	1	0	\N	\N
2092	CHAMPIÑON GRANEL 	3	100	2	3000	1	0	\N	\N
1334	ALFAJOR MIL HOJAS 	12	604	1	800	1	0	\N	\N
4271	LIMONADA ORIGINAL GOOD LEMON475ML	1	7804667390008	1	1500	1	0	\N	\N
1336	CACHITOS RELLENOS 	12	607	1	800	1	0	\N	\N
1332	MERENGUE RELLENO MANJAR 	12	603	1	250	1	0	\N	\N
1780	CIF CREMA ORIGINAL 375 CC	22	7791290008007	1	1300	1	0	\N	\N
396	FUZOL PIEL DELICADA 1 LITRO 	2	7804920280695	1	1200	1	0	\N	\N
1779	VIRUTILLA FINA OLLA UN	2	049	1	390	1	0	\N	\N
1686	VANISH WHITE 400ML	1	7805010213241	1	990	1	0	\N	\N
733	CAFE TARRO CRUZEIRO 100GR	1	7896019207027	1	1600	1	0	\N	\N
2070	PALL MALL BERRY 20	55	78024601	1	3400	1	0	\N	\N
1499	UVA BLANCA SIN PEPA 	11	117	2	1500	1	0	\N	\N
416	TUYO OBLEA 19 G 	6	7802215514531	1	150	1	0	\N	\N
1747	LADYSOFT TAMP. SUPER PLUS 8UN	1	7806500966036	1	2100	1	0	\N	\N
425	VINAGRE ROSADO TRAVERSO 500 ML 	1	7802337101046	1	950	1	0	\N	\N
1613	SAHNE-NUSS 225ML SAVORY 	6	7613035493650	1	3190	1	0	\N	\N
275	LAV. QUIX CONCENTRADO 500 ML 	2	7805000115906	1	1500	1	0	\N	\N
1749	LADYSOFT TAMP. SUPER 8UN	1	7806500966029	1	2100	1	0	\N	\N
1333	ALFAJOR TRADICIONAL 	12	605	1	700	1	0	\N	\N
2308	GALLETA MINI VINO 40 GR MCKAY	26	7613031649815	1	300	1	0	\N	\N
1614	SAHNE-NUSS 90ML SAVORY 	6	7613035808133	1	1690	1	1490	\N	\N
2056	PILA ALCALINA CHICA AA DURACELL	56	041333016634	1	800	1	750	\N	\N
38	ARVEJITAS WASIL 300 GRAMOS	1	7801305005324	1	550	1	0	\N	\N
860	GOMITAS MOGUL ARCOR 400GR	6	7790580405595	1	1800	1	0	\N	\N
858	DULCES ARCOR MEDIA HORA 400GR	6	7802225310635	1	1700	1	0	\N	\N
678	PIÑA EN TROZOS BONAFOOD 340GR	1	7801434001761	1	1500	1	0	\N	\N
751	TE CEYLAN MILDRED 50UN.	1	7801875001757	1	1400	1	0	\N	\N
2098	CAPRI FRUTILLA 90G 	1	7613034270399	1	1200	1	990	\N	\N
737	TE LIPTON YELLOW LABEL 20 UN	1	7801810712663	1	1400	1	0	\N	\N
4272	AKAMAKI  MENTA 475ML ANTIOXIDANTE	1	7804667390206	1	1500	1	0	\N	\N
410	SUPREMO PREMIUM CEYLON 20 UN. 	1	7801875047113	1	1250	1	0	\N	\N
179	GALLETAS HIP MINI 35 G 	6	7802215516412	1	250	1	0	\N	\N
739	TE SUPREMO CEYLAN MYSTIC 50UN.	1	7801875002037	1	2200	1	0	\N	\N
855	DULCES ARCOR CRIATURAS DE LA NOCHE 185GR	6	7757174008853	1	1500	1	0	\N	\N
675	SALSA DE SOYA PEARL RIVER BRIDGE 150ML	1	6947593010600	1	1390	1	0	\N	\N
1772	JUREL EL NAVEGANTES 	1	7801246120032	1	1150	1	0	\N	\N
1203	ATUN LOMITOS EN AGUA 184G VAN CAMPS 	1	7702367000022	1	1400	1	0	\N	\N
869	CHUPETES DOS EN UNO CABEZON 432GR	6	7802225036689	1	1800	1	0	\N	\N
1703	CANELA MOLIDA 15G MP	1	7802420810060	1	400	1	0	\N	\N
2091	MOROCHA MCKAY 240G 	47	7613036310925	1	1000	1	0	\N	\N
891	CEREAL KIDS ARCOR MAIZ 100GR	6	7802225690065	1	1000	1	0	\N	\N
31	ARROZ MIRAFLORES LARGO ANCHO GRADO 1,  500 GRAMOS 	1	7800120716644	1	900	1	850	\N	\N
2028	MANTECA CRUCINA 100G 	1	7802810022042	1	690	1	0	\N	\N
1158	LIMPIADOR EN POLVO SAPOLIO MULTIUSO 450G	1	7751851107532	1	850	1	0	\N	\N
146	FIDEO ROMANO TALLARINES N°77 400 GRAMOS 	1	7802500016023	1	600	1	0	\N	\N
2252	DESODORANTE REXONA MEN  50 GR MOTIONSENSE	57	75026752	1	2600	1	0	\N	\N
2253	SEDAL ACOND. 190ML 	1	7791293030746	1	990	1	0	\N	\N
144	FIDEO ROMANO CABELLITOS 400 GRAMOS 	1	7802500017006	1	600	1	0	\N	\N
409	SUPREMO MANZANILLA 20 UN. 	1	7801875058065	1	1200	1	1100	\N	\N
754	GALLETAS SCONES BIZCOCHO ARCOR 250GR	6	7802225625005	1	1700	1	1500	\N	\N
182	GALLETAS MINI VINO 40 G 	6	7802215516214	1	300	1	250	\N	\N
1603	CENTELLA SAVORY 50ML 	6	7613032180157	1	250	1	200	\N	\N
683	LECHE CONDENSADA  397 GRS NESTLE	4	7613030049883	1	1390	1	0	\N	\N
360	SALSA TOMATE EL VERGEL 200 GRAMOS 	1	7809635400710	1	300	1	0	\N	\N
395	FUZOL COLOR PLUS 1 LITRO 	2	7804920280343	1	1200	1	0	\N	\N
871	CHUPETES TAFI 475 GR ARCOR	6	7802225230216	1	3100	1	0	\N	\N
1861	BIOSAL SAL YODADA 400G	1	7803600000813	1	1300	1	0	\N	\N
1663	GARBANZOS GRANEL 	11	130	2	2000	1	0	\N	\N
870	DULCES ARCOR BUTTERN CREAM CHUPETE LECHE 432GR	6	7790580275655	1	1800	1	0	\N	\N
865	DULCES ARCOR BUTTER TOFFEES BON O BON 350GR	6	7790580412784	1	1850	1	0	\N	\N
873	GOMITAS MOGUL JELLY BUTTONS 1KG	6	7790580308100	1	2990	1	0	\N	\N
4273	ALOE ORIGINAL 500ML	1	884394008619	1	1000	1	0	\N	\N
927	BON BON BLANCO 15 GR ARCOR	6	78024106	1	150	1	0	\N	\N
943	BAZOOKA CHICLE JIRAFA MENTA 14GR	6	210	1	150	1	0	\N	\N
900	DULCE AMBROSOLI VARIADOS UNIDAD 	6	204	1	100	1	0	\N	\N
2099	CAPRI TRUFA 90G 	1	7613034276766	1	1200	1	990	\N	\N
387	SHIP ZERO COLA 3 LITROS 	5	7801608000132	1	800	1	0	\N	\N
1704	BICARBONATO30G MP	1	7802420810046	1	250	1	0	\N	\N
1695	AJI DE COLOR 15G MARCO POLO	1	7802420810015	1	250	1	0	\N	\N
1699	OREGANO MOL. 15G MP 	1	7802420810145	1	250	1	0	\N	\N
1702	CLAVO OLOR ENT. 5G MP	1	7802420110092	1	250	1	0	\N	\N
2255	ROLLS CROCANTE  150 GR COSTA	46	7802215121258	1	1700	1	0	\N	\N
676	SALSA DE SOYA TRAVERSO 320ML	1	7802337001476	1	1200	1	0	\N	\N
2256	MONO FRUT 190ML 	1	7802575237101	1	330	1	0	\N	\N
1706	CLAVO OLOR MOL. 5G MP 	1	7802420110108	1	250	1	0	\N	\N
672	CHAMPIÑONES ENTEROS ARUBA 400GR	1	7801430150210	1	1290	1	0	\N	\N
14	ANTIBAC DESINF. AIRE DE MONTAÑA 220 CC 	2	7805300052086	1	1300	1	0	\N	\N
934	ALFAJOR ARCOR BON O BON 40GR	6	7790040613706	1	400	1	0	\N	\N
910	CEREAL KIDS SAPITO 25GR	6	7802225690102	1	300	1	0	\N	\N
2263	TODDY BLOCK 101G	1	7500478012473	1	1000	1	0	\N	\N
1701	CURRY 15G MP 	1	7802420810121	1	250	1	0	\N	\N
1070	CHEEZELS EVERCRISP 30GR	6	7802000005930	1	500	1	0	\N	\N
54	BOLSAS DE ASEO SUPERIOR 80X110CM 10 UND 	2	7801875069153	1	1800	1	0	\N	\N
909	CEREAL KIDS HUESITOS 25GR	6	7802225690041	1	300	1	0	\N	\N
915	CHICLE STRONG BIGTIME 11GR	6	78068315	1	300	1	0	\N	\N
916	CHICLE SANDIA BIGTIME 11GR	6	78007505	1	300	1	0	\N	\N
942	MANCHATE LA LENGUA DOS EN UNO CHERRY UNIDAD 14GR	6	209	1	200	1	0	\N	\N
945	MANCHATE LA LENGUA DOS EN UNO FRUTILLA UNIDAD 14GR	6	212	1	200	1	0	\N	\N
941	LANGUETAZO ARCOR MANZANA 13GR	6	7802225212540	1	100	1	0	\N	\N
4274	ENERGY DRINK TULA 250ML	54	7804651810093	1	1500	1	0	\N	\N
939	GOMITAS MOGUL CONITOS 25GR	6	7790580409227	1	300	1	200	\N	\N
935	GOMITA MOGUL PIECITOS 25GR	6	7790580409135	1	300	1	200	\N	\N
584	BASE PESCADO FRITO  85 GR MAGGI	1	7802950004427	1	690	1	0	\N	\N
914	CHICLE AQUA BIGTIME 11GR	6	78011748	1	300	1	0	\N	\N
208	ILICIT COLOR CASTAÑO OSCURO 3.0	2	7804923031249	1	2000	1	0	\N	\N
1712	MERKEN 15G MP	1	7802420810565	1	250	1	0	\N	\N
917	BIGTIME ACID FRUTIA 11GR	6	78024496	1	300	1	0	\N	\N
614	CHAMYTO FRUTILLA 80ML	4	78011786	1	300	1	0	\N	\N
970	CEPILLO DE DIENTES COLGATE PREMIUM CLEAN 1UN	2	6910021007206	1	990	1	0	\N	\N
975	PAÑO MULTIUSO VIRUTEX UN	2	220	1	750	1	0	\N	\N
932	ROCKLETS MANI 150GR	6	7802225427579	1	1700	1	0	\N	\N
981	DULCE CAREZZA UNIDAD	6	222	1	0	1	0	\N	\N
933	CHUBI 150GR	6	7802225426336	1	1200	1	0	\N	\N
908	CEREAL KIDS MAIZ 20GR	6	7802225690058	1	300	1	0	\N	\N
938	GOMITAS MOGUL EXTREME GUSANITOS 25GR	6	7802225412179	1	200	1	0	\N	\N
1698	AJO POLVO 15G MP 	1	7802420810022	1	250	1	0	\N	\N
928	CHOCOLATE ARCOR BON O BON 110GR	6	7802225590105	1	1100	1	0	\N	\N
929	CHOCOLATE ARCOR ROCKLETS CHO. 125GR	6	7802225000314	1	1100	1	0	\N	\N
930	CHOCOLATE ARCOR SAPITO 100GR	6	7802225590099	1	1100	1	0	\N	\N
2018	NECTAR DURAZNO  1 LT VIVO	38	7802575226334	1	1200	1	850	\N	\N
913	CHICLE REFRESCANTE BIGTIME 11GR	6	78068308	1	300	1	0	\N	\N
1213	LAGUITO 70G 	1	7803403000737	1	400	1	350	\N	\N
956	JUGO EN POLVO VIVO BERRIES 7GR	1	7802200266193	1	200	1	0	\N	\N
50	BOLSAS DE ASEO CLEAN 110 X 120 CM 5 UND 	2	7801875001610	1	4300	1	0	\N	\N
976	CHICLE ORBIT HIERBABUENA 10UN	6	50173822	1	550	1	0	\N	\N
1366	HAMBURGUESA VACUNO 100G WINTER 	20	7801900083451	1	300	1	0	\N	\N
1	AGUA GASIFIADA LIV 3 LITROS 	5	7801608001290	1	900	1	0	\N	\N
449	ESPIRALES 3 VEGETALES LUCCHETTI 400G	1	7802500184579	1	1350	1	800	\N	\N
4276	CHUPETON	1	6971285300007	1	150	1	0	\N	\N
4277	TRENTO CERESA 22G	1	7896306621215	1	400	1	0	\N	\N
949	PICKLE 200 GR TRAVERSO	1	7802337910235	1	1200	1	0	\N	\N
953	JUGO EN POLVO VIVO NARANJA 8GR	1	7802200266001	1	200	1	0	\N	\N
952	JUGO EN POLVO VIVO LIMONADA 7GR	1	7802200266056	1	200	1	0	\N	\N
585	SALSA BLANCA  36 GR MAGGI	1	7613031571444	1	690	1	0	\N	\N
957	JUGO EN POLVO VIVO MANZANA 7GR	1	7802200266063	1	200	1	0	\N	\N
960	JUGO EN POLVO VIVO DURAZNO/HUESILLO 7GR	1	7802200266414	1	200	1	0	\N	\N
2275	NIDO ETAPA 3+ 800G	1	7613031768622	1	6650	1	0	\N	\N
5374	CLORINDA CLORO GEL FLORES SILVESTRES 900ML	1	7805080695107	1	1650	1	0	\N	\N
958	JUGO EN POLVO VIVO FRUTILLA 7GR	1	7802200266070	1	200	1	0	\N	\N
1863	EL BAMBU PALO BROCHETA	1	6941654303007	1	500	1	0	\N	\N
1728	LEVADURA  10 GR LEFERSA	1	7803000000475	1	200	1	0	\N	\N
974	CARAMELO MASTICABLE LA VACA LECHERA UNIDAD	6	219	1	0	1	0	\N	\N
969	NESCAFE DESCAFEINADO SOBRE 1.8GR	1	215	1	100	1	0	\N	\N
686	ESENCIA VAINILLA TRAVERSO 250ML	1	7802337000578	1	750	1	0	\N	\N
1714	PICADO POLLO CON VERDURAS  215 GR NESTLE	43	7613030099024	1	1390	1	0	\N	\N
1670	JUEGO RINDE 2 24G	1	1004	1	180	1	0	\N	\N
1716	COLADO CARNES Y VERDURAS 115 GRS	1	7613036653961	1	950	1	0	\N	\N
231	JALEA SABOR PIÑA 100 G 	1	7802200361157	1	350	1	0	\N	\N
684	LEVADURA POLVO COLLICO 10GR	1	7803010031124	1	300	1	200	\N	\N
412	TOALLA DE PAPEL ABOLENGO XL 100 METROS 	2	7806500406389	1	2600	1	0	\N	\N
152	FRAC BICHOCOLATE FRUTILLA 130 G 	6	7802215512308	1	700	1	600	\N	\N
972	CHICLE GROSSO SABORES UNIDAD	6	217	1	100	1	0	\N	\N
931	ROCKLETS BALLS 150GR	6	7802225427425	1	1700	1	0	\N	\N
951	CHUCRUT  200 GR TRAVERSO	1	7802337910280	1	890	1	0	\N	\N
631	YOGURTH CHAMYTO FRUTILLA 115GR	4	7613037416725	1	300	1	0	\N	\N
1862	LECHE EVAPORADA IDEAL  375 ML NESTLE	21	7752087774932	1	1550	1	0	\N	\N
1879	RUCAS SELECT QUESO	1	6917554726321	1	1100	1	0	\N	\N
471	CARACOLITOS LUCCHETTI 250G	1	7802500182353	1	500	1	0	\N	\N
963	CEREAL KIDS SAPITO 330GR	1	7802225690089	1	2000	1	0	\N	\N
186	GALLETAS PALMERITAS MINI 40 G 	6	7802215516207	1	250	1	0	\N	\N
990	YOGURTH NESTLE PROTEINA DURAZNO TROZOS 120GR	4	7613037042504	1	450	1	0	\N	\N
987	COYAC YOGUETA FRUTAL UND	6	225	1	0	1	0	\N	\N
4278	HUEVO  MAGIC BON	1	8697422654298	1	350	1	0	\N	\N
2273	NESCAFE TRADICIONAL   170 GRS	63	7802950002126	1	4490	1	0	\N	\N
994	JALEA PIÑA 110GR NESTLE	1	7613035281462	1	350	1	0	\N	\N
2270	BRIGHT 50X70CM 	1	012345678202	1	550	1	0	\N	\N
2272	RICCO DOBLE HOJA 250HOJAS . 	1	7804612610434	1	1000	1	0	\N	\N
16	ANTIBAC DESINF. LAVANDA 220 CC 	2	7805300052048	1	1300	1	0	\N	\N
26	AMBERRIES GOMITAS 25 G 	6	7802200135741	1	200	1	0	\N	\N
959	JUGO EN POLVO VIVO  7GR	1	7802200266049	1	200	1	0	\N	\N
89	CHORITOS EN AGUA ANGELMO 425 GRAMOS 	1	7801250501056	1	2100	1	0	\N	\N
470	DEDALITOS LUCCHETTI 250G	1	7802500182315	1	900	1	500	\N	\N
468	CABELLITOS TALLIANI 400G	1	7802500008011	1	990	1	0	\N	\N
992	YOGURTH NESTLE GRIEGO PAPAYA 115GR	4	7613037016239	1	350	1	0	\N	\N
59	CAFE CLASICO MONTERREY 50 GRAMOS 	1	7802800500437	1	1400	1	0	\N	\N
991	YOGURTH NESTLE PROTEINA FRUTILLA TROZOS 120GR	4	7613037042474	1	450	1	0	\N	\N
1038	CARAMELO BUTTER AND CREAM UNIDAD	6	228	1	0	1	0	\N	\N
998	RINSO LIRIOS Y ROSAS 400 GR	2	7805000313876	1	990	1	0	\N	\N
500	NECTAR WATTS NARANJA 200 ML	5	7802810006752	1	250	1	0	\N	\N
995	DRIVE 400GR	2	7805000313548	1	1400	1	0	\N	\N
983	RINSO HORTENCIA Y FLORES 200G	2	P001	1	650	1	0	\N	\N
1687	DET. LIQ. MATIC SOFT 5LT	22	7804663500210	1	2500	1	0	\N	\N
217	ILICIT COLOR RUBIO EXTRA CLARO 9.0	2	7804923031553	1	2000	1	0	\N	\N
2274	NIDO ETAPA 1+ 800G	1	7613031769551	1	6650	1	0	\N	\N
40	ATUN DESMENUZADO EN ACEITE ANGELMO 170 GRAMOS 	1	7801250000375	1	800	1	0	\N	\N
967	NECTAR WATTS CERO MARACUYA 1.5LT	5	7801620007607	1	1350	1	0	\N	\N
401	SURTIDO DE MARISCOS EN AGUA ANGELMO 425 GRAMOS 	1	7801250000818	1	2500	1	0	\N	\N
996	LIQUIDO RINSO 5 EN 1 1LT	2	7805000310332	1	2700	1	0	\N	\N
962	CEREAL KIDS CARITAS 330GR	1	7802225690072	1	2300	1	0	\N	\N
2268	CONFORT DOBLE HOJA 27MTS 	1	7806500506744	1	1800	1	0	\N	\N
450	CORBATAS 3 VEGETALES LUCCHETTI 400G	1	7802500221595	1	1350	1	800	\N	\N
7	ACOND. FRUCTIS ALOE HIDRA BOMB 350 ML 	2	7509552830620	1	2500	1	0	\N	\N
4279	SPRAY LIGHTER	1	6967052225260	1	150	1	0	\N	\N
666	MOSTAZA HELLMANS 100GR	1	7802640792764	1	750	1	0	\N	\N
1475	AJO 	11	2000000000497	1	200	1	0	\N	\N
663	MAYONESA CLASICA DON JUAN 380GR	1	7802351625030	1	1250	1	0	\N	\N
997	OMO LIQUIDO 1LT	2	7805000310325	1	3300	1	0	\N	\N
212	ILICIT COLOR NEGRO 1.0	2	7804923031225	1	2000	1	0	\N	\N
210	ILICIT COLOR GUINDA 6.66	2	7804923031409	1	2000	1	0	\N	\N
399	SUCEDÁNEO DE LIMÓN TRAVERSO 500 ML 	1	7802337801038	1	1000	1	0	\N	\N
955	JUGO EN POLVO VIVO ARANDANO/CIRUELA 7GR	1	7802200266308	1	200	1	0	\N	\N
1006	JUGO LIVEAN MELONTUNA 7GR	1	P008	1	200	1	0	\N	\N
1003	JUGO LIVEAN PERA 7GR	1	P005	1	200	1	0	\N	\N
1012	KRYZPO ORIGINAL 100GR	1	7802800534401	1	1000	1	0	\N	\N
1026	MOSTACCIOLI ROMANO 400GR	1	7802500144429	1	600	1	0	\N	\N
1032	JUGO SPRIM MANZANA FUJI 35GR	1	P011	1	190	1	0	\N	\N
2167	ENERGIZER AAA2	1	039800014009	1	200	1	0	\N	\N
2203	IANZA CERO K STEVIA + SUCRALOSA 180ML 	1	7801505001737	1	3200	1	0	\N	\N
1713	COLADO CRECIDOS CARNE VERDURA 215 GR	42	7613030264040	1	1690	1	0	\N	\N
989	YOGURTH NESTLE FRUTILLA 115GR	4	7613036464963	1	300	1	250	\N	\N
961	PILA PANASONIC D UNIDAD	1	213	1	700	1	500	\N	\N
1010	PAPAS ORIGINAL  140 GRS KRYZPO	1	7802800533565	1	1700	1	0	\N	\N
1525	CUCHARA DE PLASTICO LILA 	34	9000000059917	1	500	1	0	\N	\N
51	BOLSAS DE ASEO SUPERIOR 110 X 120CM 5 UND 	2	7801875069191	1	5990	1	0	\N	\N
2269	NOBLE DOBLE HOJA 6 ROLLOS 	1	7806500507925	1	1650	1	0	\N	\N
896	LECHE CHOCOLATE TRENCITO  200 CC NESTLE	4	7802950006339	1	450	1	0	\N	\N
2100	CAPRI GUINDA 90G 	1	7613034303660	1	1200	1	990	\N	\N
1048	GOMITAS MOGUL OSITOS EXTREME 25GR	6	7802225403207	1	300	1	200	\N	\N
615	CHAMYTO FRAMBUESA 80ML	4	78013865	1	0	1	0	\N	\N
4280	DUCREM	1	78954731	1	100	1	0	\N	\N
4281	DUCREM	1	78917644	1	150	1	0	\N	\N
1036	ALIMENTO PEDIGREE CACHORRO SANO CRECIMIENTO 9KG	1	P014	1	0	1	0	\N	\N
1044	ALKA ICE MENTOL 390GR	6	7790580317416	1	250	1	0	\N	\N
2173	NESTUM TRIGO MIEL    250 GR NESTLE	27	7613035939370	1	1900	1	0	\N	\N
1042	ALKA MENTOL 400GR	6	7802225310185	1	250	1	0	\N	\N
1009	PAPAS QUESO  140 GRS KRYZPO	1	7802800533572	1	1700	1	0	\N	\N
1027	QUIFAROS ROMANO 400GR	1	7802500017020	1	500	1	0	\N	\N
1886	GALLETA VAINILLA FABULAZOO  700 GR FRUNA	26	7802408002364	1	1400	1	0	\N	\N
469	MARIPOSAS LUCCHETTI 250G	1	7802500002026	1	900	1	500	\N	\N
1432	PATE JAMON  125 GR PF	33	7801930003139	1	450	1	0	\N	\N
1865	MERMELADA WATTS MORA 250 GRS	28	7802810031037	1	1000	1	0	\N	\N
385	SHIP PAPAYA ZERO 3 LITROS 	5	7801608000323	1	800	1	0	\N	\N
1523	BOLSA DE DULCE 16X27CM CONEJO NARANJO	34	5606858321479	1	1600	1	0	\N	\N
1056	GATOLATE EVERCRISP 30GR	6	7802000009969	1	500	1	0	\N	\N
2129	BOCADITO DE PRINCESA 	59	802	2	2000	1	1300	\N	\N
573	WATTS DAMASCO 1,5 LTS	5	7801620011628	1	1500	1	1350	\N	\N
567	NECTAR PIÑA PET  1,5 LT WATTS	5	7801620011635	1	1500	1	1350	\N	\N
570	WATTS TUTTIKIWI 1,5 LT	5	7801620002343	1	1500	1	1350	\N	\N
64	CERA BRILLINA AMARILLA 360 CM3	2	7805040001443	1	1550	1	1300	\N	\N
1015	PAPAS ORIGINAL  40 GRS KRYZPO	1	7802800535569	1	700	1	0	\N	\N
1900	NONITAS 55GRS FRUNA	1	7802408011052	1	300	1	200	\N	\N
1016	PAPAS QUESO  40 GR KRYZPO	1	7802800535576	1	700	1	0	\N	\N
1057	TRATATRAGA FRAMBUESA EVERCRISP 30GR	6	7802000008733	1	500	1	0	\N	\N
1058	CHISPOP TUTIFRUTI EVERCRISP 30GR	6	7802000010811	1	400	1	0	\N	\N
1059	SNACK MIX ORIGINAL EVERCRISP 50GR	6	7802000010941	1	500	1	0	\N	\N
1705	COCO RALLADO25G MP 	1	7802420119323	1	230	1	0	\N	\N
1067	RAMITAS QUESO EVERCRISP 90GR	6	7802000010996	1	800	1	0	\N	\N
1068	RAMITAS ORIGINAL EVERCRISP 90GR	6	7802000011009	1	800	1	0	\N	\N
222	ILICIT OLOR ALMENDRA 8.31	2	7804923031546	1	2000	1	0	\N	\N
207	ILICIT COLOR CASTAÑO MEDIO 4.0	2	7804923031263	1	2000	1	0	\N	\N
1866	MERMELADA DURAZNO  250 GR WATTS	28	7802810031020	1	1000	1	0	\N	\N
4283	GRANOLA VIVO 370	1	7800120163134	1	2400	1	0	\N	\N
1035	ACOND.PANTENE HIDROCAUTERIZACION 400ML	2	P013	1	2700	1	0	\N	\N
2309	LAYS CREMA CEBOLLA 40G	1	7802000009297	1	600	1	0	\N	\N
1072	CHEEZELS EVERCRISP 110GR	6	7802000011931	1	1000	1	0	\N	\N
1074	CHEEZELS EVERCRISP 270GR	6	7802000011832	1	1900	1	0	\N	\N
1075	CHISPOP TUTIFRUTI EVERCRISP 270GR	6	7802000011863	1	1600	1	0	\N	\N
1077	CHEETOS EVERCRISP 350GR	6	7802000003028	1	1950	1	0	\N	\N
1078	CHEETOS EVERCRISP 140GR	6	7802000003011	1	1000	1	0	\N	\N
561	NECTAR SELECCION NARANJA VALENCIA WATTS 1LT	5	7801620006198	1	1700	1	0	\N	\N
1079	DORITOS QUESO EVERCRISP 75GR	6	7802000010903	1	800	1	0	\N	\N
1080	DORITOS QUESO EVERCRISP 180GR	6	7802000001505	1	1500	1	0	\N	\N
1085	SNACK MIX 2 EVERCRISP 100GR	6	7802000011894	1	1000	1	0	\N	\N
1086	PAPAS LAYS CORTE AMERICANO EVERCRISP 42GR	6	7802000012570	1	600	1	0	\N	\N
1087	DORITOS QUESO EVERCRISP 46GR	6	7802000012297	1	600	1	0	\N	\N
1089	PAPAS LAYS CORTE AMERICANO EVERCRISP 120GR	6	7802000002571	1	1000	1	0	\N	\N
1759	DURAZNO TROZO 2 CABALLOS 425 GRS	1	7801380000290	1	1200	1	0	\N	\N
1761	DURAZNO MITADES 2 CABALLOS 590 GRS	1	7801380101423	1	1500	1	0	\N	\N
1082	TWISTOS QUESO EVERCRISP 43GR	6	7802000005534	1	500	1	0	\N	\N
1433	PATE POLLO  125 GRS PF	33	7801930003122	1	450	1	0	\N	\N
225	LE SANCY 90 G ACEITE DE ALMENDRAS 	2	7791293020099	1	1000	1	700	\N	\N
52	BOLSAS DE ASEO SUPERIOR 50X70 CM 10 UN 	2	7801875069351	1	950	1	800	\N	\N
918	BIGTIME SEVEN STRONG 7UN	6	78024045	1	450	1	0	\N	\N
2278	ALOE VERA COCO-MANZ.- UVA 500ML 	1	7803908005848	1	800	1	0	\N	\N
1781	RAID CASA Y JARDIN 205G 	18	7790520002273	1	2650	1	0	\N	\N
1061	PAPAS MOMS LISAS EVERCRISP 180GR	6	7802000011917	1	1000	1	0	\N	\N
1096	TWISTOS TOSTADITAS INTEGRAL QUESO EVERCRISP 43GR	6	7802000013331	1	500	1	0	\N	\N
1103	DULCE DE MEMBRILLO ECKARTR 500GR	1	7804000100509	1	1250	1	0	\N	\N
1008	KRYZPO ORIGINA 60GR.	1	7802800533701	1	900	1	0	\N	\N
4284	PEPSODENT 40G	1	7805000314491	1	550	1	0	\N	\N
568	WATTS TUTTIARANDANO 1,5 LTS	5	7801620003500	1	1350	1	0	\N	\N
1142	SURTIDO CALDILLO ACEITE 190G	1	7804520019664	1	890	1	0	\N	\N
2583	MAYONESA DON JUAN 1KG 	1	7802351000592	1	1890	1	0	\N	\N
2094	PAN TOSCANO 	12	641	2	3500	1	0	\N	\N
2311	RAMITAS QUESO 120 GR EVERCRIPS	46	7802000002786	1	1000	1	0	\N	\N
2586	ALUFOIL 7 1/2 METROS 	1	7801875150257	1	1500	1	0	\N	\N
2589	AJI PEBRE 350G	1	7802337000561	1	1600	1	0	\N	\N
2590	AJI  CHILENO 350G	1	7802337910020	1	1100	1	0	\N	\N
43	ATUN LOMITOS EN ACEITE ANGELMO 170 GRAMOS 	1	7801268001364	1	1200	1	0	\N	\N
1110	CARACOLES CAROZZI 400G 	1	7802575002433	1	1300	1	800	\N	\N
1111	ESPIRALES  400 GRS CAROZZI	10	7802575002235	1	1300	1	800	\N	\N
1114	CORBATITAS CAROZZI 400 G 	1	7802575006233	1	800	1	0	\N	\N
1115	CORBATAS 400 GRS CAROZZI	10	7802575006035	1	1300	1	800	\N	\N
1116	FETTUCCINE CAROZZI 400 G 	10	7802575004833	1	1300	1	750	\N	\N
1120	CREMA DE ESPARRAGOS 68 G GOURMET 	1	7802410003137	1	500	1	0	\N	\N
1519	PECHUGA POLLO ENTERA GRANEL 	31	303	2	4800	1	2800	\N	\N
589	BASE CAZUELA DE AVE 70GR MAGGI 	1	7613031238613	1	690	1	0	\N	\N
1034	 CACHANTUN MAS GRANADA 500CC	5	7801620005856	1	850	1	800	\N	\N
213	ILICIT COLOR NEGRO AZULADO 2.8	2	7804923031232	1	2150	1	2000	\N	\N
1339	MENDOCINOS 	12	613	1	700	1	0	\N	\N
1106	GALLETAS BOCADITOS MEMBRILLO 300GR	6	7802225630900	1	1700	1	1500	\N	\N
1171	HAMBURGUESAS VACUNO  50 GRS PF	20	7801930009407	1	400	1	0	\N	\N
1055	RAMITAS ORIGINAL EVERCRISP 42GR	6	7802000003462	1	400	1	0	\N	\N
2665	ALOE VERA SABILA 500ML 	1	857991002007	1	1000	1	0	\N	\N
707	HARINA S/POLVOS  PUENTE ALTO 1KG	1	7809559200052	1	800	1	0	\N	\N
4285	VIVO GRANOLA 370G	1	7800120163141	1	2400	1	0	\N	\N
1741	GOLD CARAMELO CHOCOLATE 155 GRS SOPROLE	1	7802900001858	1	550	1	0	\N	\N
3255	CONEJITO PICNIC COSTA 18G	1	7802215116704	1	650	1	0	\N	\N
1084	SNACK MIX ORIGINAL EVERCRISP 84GR	6	7802000012280	1	800	1	0	\N	\N
1151	LIMPIADOR PISO FLOTANTE CHOCOLATE VAINILLA EXCELL 900CC	1	7805020000671	1	1700	1	0	\N	\N
1127	JUGO POLVO NARANJA RINDE DOS LITROS 24G	1	7730908402165	1	180	1	0	\N	\N
1128	JUGO POLVO PIÑA RINDE DOS LITROS. 24G	1	7730908402196	1	180	1	0	\N	\N
2312	RAMITAS SALADAS 120 GR EVERCRIPS	46	7802000002755	1	1000	1	0	\N	\N
2043	HAMBURGUESA POLLO 50 GRS LA ESPAÑOLA.	20	7801930015200	1	120	1	0	\N	\N
1129	SERVILLETAS ELITE GOLD 20 UN. 	1	7806500224006	1	750	1	0	\N	\N
853	CANDY SURTIDO ARCOR 100UN	6	7802225218702	1	1700	1	0	\N	\N
697	AZUCAR RUBIA 500 GR IANSA	1	7801505231950	1	1400	1	1300	\N	\N
709	ALMIDON DE MAIZ CAMPINO 250GR	1	7804520024149	1	1400	1	0	\N	\N
1757	NOSOTRAS C/ALAS NORMAL 10UN	1	7702026173623	1	1100	1	0	\N	\N
1760	NOSOTRAS S/ALAS NORMAL 10UN	1	7702026180959	1	680	1	0	\N	\N
1113	ALFABETO 250 GR CAROZZI	10	7802575003249	1	900	1	700	\N	\N
1763	NUBELIN DOBLE HOJA 27MTS 24UN.	1	7804653340970	1	7250	1	0	\N	\N
1132	DURAZNOS CONSERVA MITADES 820G WASIL 	1	7801305700038	1	1490	1	0	\N	\N
701	AZUCAR 1 KG CALLAO	1	7804605040293	1	650	1	0	\N	\N
220	ILICIT COLOR RUBIO OSCURO 6.0	2	7804923031447	1	2000	1	0	\N	\N
216	ILICIT COLOR RUBIO CLARO CENIZA 8.1	2	7804923031522	1	2000	1	0	\N	\N
194	GILLETTE VENUS SIMPLY 3	2	7702018072439	1	1100	1	0	\N	\N
841	GALLETA AGUA LIGHT SELZ 200GR	6	7802225689472	1	850	1	0	\N	\N
290	MAGNUM CHOCOLATE ALMENDRAS 100 ML 	7	7805000310493	1	1790	1	1590	\N	\N
1724	MAYONESA CLASICA DON JUAN 760 GRS	1	7802351625047	1	1850	1	1800	\N	\N
693	MANJAR COLUN POTE TRADICIONAL 200GR	1	7802920777511	1	1050	1	0	\N	\N
224	ILICIT OLOR ROJOS INTENSOS MANDARINA 77.44	2	7804923031348	1	2150	1	2000	\N	\N
1144	COCTEL DE FRUTAS 590G ACONCAGUA 	1	7801800000015	1	1500	1	0	\N	\N
1121	ARROZ ARUBA PREGR 1/2 KG. 	1	7801430430121	1	600	1	0	\N	\N
1131	DURAZNOS CONSERVA TROCITOS WASIL 820G 	1	7801305000572	1	1490	1	0	\N	\N
1125	LONCO LECHE S/LACTOSA DESC. BLANCA 1 LITRO	1	7802910083509	1	1400	1	0	\N	\N
392	SHIP ZERO PIÑA 3 LITROS 	5	7804604720158	1	800	1	0	\N	\N
1727	LECHE ENTERA COLUN 900GRS 	1	7802920001982	1	5590	1	0	\N	\N
4286	BIOSAL 500G	1	7809561700076	1	1500	1	0	\N	\N
1726	LECHE ENTERA POLVO COLUN 400 GRS	1	7802920001999	1	2750	1	0	\N	\N
797	TAMP. KOTEX SUPER PLUS 8UN.	2	7441008154617	1	2250	1	0	\N	\N
1790	JABON BRILLEX MANZANA 2L	36	614143645624	1	1650	1	0	\N	\N
1122	ARROZ PREGRANEADO GRADO 1 ARUBA 1 KG	13	7801430430091	1	1100	1	0	\N	\N
1553	GLOBOS BLANCOS 50 PS	34	131301	1	1500	1	0	\N	\N
483	AGUA TONICA CANADA DRY 1.5 LTS	5	7801620370107	1	1400	1	0	\N	\N
55	BON O BON BARRA 30 GRAMOS 	6	7802225582551	1	400	1	0	\N	\N
1155	SAPOLIO MATA CUCARACHAS Y HORMIGAS 360 ML 	1	7751851006613	1	2500	1	0	\N	\N
3263	YERBA MATE VERDEFLOR PEPERINA 500G	1	7793670400500	1	2990	1	0	\N	\N
1156	SAPOLIO CASA Y JARDIN 360 ML 	1	7751851006644	1	2500	1	0	\N	\N
438	CORBATA CHICA DON VITTORIO 400G	1	7750243286176	1	600	1	0	\N	\N
2318	CHEESECAKE INDIVIDUAL 	12	654	1	1500	1	0	\N	\N
269	KOTEX NORMAL C/ALAS EX. SUAVE 8UN	2	7793620003249	1	850	1	750	\N	\N
1535	SET ABANICOS FELIZ CUMPLEAÑOS 3MT 	34	5606858330891	1	0	1	0	\N	\N
1108	ACEITE MARAVILLA VEGETAL 1 LTS CHEF	1	7802810002099	1	2500	1	0	\N	\N
4372	ENDULZANTE STEVIA DAILY 270 ML	1	7809558101725	1	4300	1	0	\N	\N
1445	MANTEQUILLA  125 GRS CALO	21	7802910150508	1	850	1	0	\N	\N
1676	SALSA DE AJO DE DON JUAN 100G 	1	7802420003486	1	550	1	0	\N	\N
1375	COPPA ARROLLADO LA ESPAÑOLA	3	30	2	5500	1	4700	\N	\N
1401	JAMON ARTESANAL PF 	3	56	2	11000	1	7000	\N	\N
1404	ARROLLADO HUASO SIN AJI PF 	3	59	2	8000	1	5500	\N	\N
1130	JUGO LIMON DON JUAN 500 CC	14	7802351534707	1	1000	1	900	\N	\N
795	TAMPONES KOTEX REGULAR 8UN.	2	7441008154594	1	2250	1	0	\N	\N
719	LECHE EN POLVO COLUN 110GR	1	7802920801032	1	700	1	0	\N	\N
578	GELATINA DAILY LIMON 22.5GR	1	7809558102456	1	600	1	0	\N	\N
600	CALDO MAGGI GALLINA 132GR	1	7802950005943	1	1400	1	0	\N	\N
1431	PATE TERNERA  125 GRS PF	33	7801930003115	1	450	1	0	\N	\N
1449	CHAMPIÑON ENTERO NATURES FARM 200G 	32	7801365000284	1	1750	1	0	\N	\N
1256	GALLETAS VINO 155G MCKAY 	1	7613032443191	1	700	1	0	\N	\N
849	MARSHMALLOW MOGUL MORF 220GR	6	7802225280822	1	1490	1	0	\N	\N
1180	MAIZ AMARILLO DOÑAREPA 1KG 	1	7702020212021	1	2250	1	0	\N	\N
1429	PASTA DE POLLO PIMENTON LA PREFERIDA 125G	3	7801916029726	1	650	1	0	\N	\N
239	JUGO SPRIM DURAZNO HUESILLO 35 GRAMOS 	1	7802575222930	1	190	1	0	\N	\N
243	JUGO SPRIM MANZANA 35 GRAMOS 	1	7802575222985	1	190	1	0	\N	\N
240	JUGO SPRIM FRAMBUESA 35 GRAMOS 	1	7802575222947	1	190	1	0	\N	\N
2029	MANTEQUILLA BIOLAC 	1	1600	1	1600	1	0	\N	\N
1430	PASTA DE POLLO CIBOULETTE 125G LA PREFERIDA 	3	7801916029702	1	650	1	0	\N	\N
1000	DULCES ARCOR BUTTER TOFFEES SURTIDO 400GR	6	7790580412746	1	2200	1	0	\N	\N
81	CHOCOLATE ORLY FRUTILLA 115 G 	6	7802200894143	1	1100	1	1000	\N	\N
79	CHOCOLATE ORLY ALMENDRA 100 G 	6	7802200894167	1	1100	1	1000	\N	\N
1814	YOGHURT CHOCO KRISPIS    140 GR SOPROLE	21	7802900332419	1	550	1	0	\N	\N
705	SAL FINA ANDESAL 1KG	1	7804651630004	1	400	1	0	\N	\N
1803	JABON LIQ. TANGO COCO 500ML 	36	8692641009874	1	1200	1	0	\N	\N
830	MASTER PISO PRIMAVERA 1.8LT	2	945127040	1	1300	1	0	\N	\N
1383	JAMON PIERNA AHUMADO PF 	3	38	2	10000	1	9000	\N	\N
1385	PECHUGA DE POLLO AHUMADO PF 	3	40	2	10000	1	8900	\N	\N
1386	PECHUGA DE PAVO COCIDA PF 	3	41	2	10000	1	8900	\N	\N
1392	PECHUGA PAVO COCIDA 	3	47	2	12000	1	8900	\N	\N
1397	PECHUGA DE PAVO ACARAMELADA PF 	3	52	2	13000	1	8900	\N	\N
704	SAL COCINA  1 KILO LOBOS	1	7803600041236	1	650	1	0	\N	\N
100	CLOROX COLORES VIVOS 370G	2	7805025693731	1	990	1	0	\N	\N
267	KOTEX NOCTURNA CON ALAS 8UN	2	7702425802735	1	1150	1	0	\N	\N
1340	DONUTS RELLENAS 	12	611	1	900	1	0	\N	\N
1677	SALSA DE QUESO DON JUAN 100G 	1	7802420003509	1	550	1	0	\N	\N
1672	SALSA DE TOMATE DON VITORIO 200G	1	1006	1	350	1	0	\N	\N
1671	SALSA DE TOMATE DAMPEZZO 200G	1	1005	1	250	1	0	\N	\N
1675	MAYONESA DON JUAN 100G	1	1009	1	300	1	0	\N	\N
825	QUIX LIMON 200 ML	2	7805000169459	1	800	1	0	\N	\N
69	CERA LIQ. BLEM INC. 450 CM3	2	7790520012685	1	1950	1	0	\N	\N
1537	GUIRNALDA BANDERIN FELIZ CUMPLEAÑOS 3MT 	34	5606858330938	1	0	1	0	\N	\N
4287	CARNE DE SOYA 	1	1236547893156489	1	2000	1	0	\N	\N
1809	TOALLA REGIO 3 UN 60 HOJAS	2	742832803984	1	1000	1	0	\N	\N
1813	DENTO JUNIOR 50G 	36	7891528039350	1	650	1	0	\N	\N
4411	TAKIS ORIGINAL	1	757528039622	1	1700	1	0	\N	\N
1674	SALSA DE QUESO DON JUAN 100G	1	1008	1	550	1	0	\N	\N
1871	RUCAS SELECT CROCANTES CHILLI 	1	6917554956261	1	1100	1	0	\N	\N
1284	LONCO LECHE PLATANO SEMIDESCREMADA 1LT	1	7802910000254	1	1600	1	0	\N	\N
1441	MANTEQUILLA C/SAL  250 GRS COLUN	21	7802920203300	1	2990	1	0	\N	\N
432	GRANBY MATIC 800G	2	7805000316709	1	1500	1	0	\N	\N
1477	AJI PASTA EN BOLSA 	11	2000000000510	1	0	1	0	\N	\N
1578	VELA DE CUMPLEAÑOS 	34	7806130004757	1	700	1	0	\N	\N
1579	VELA DE CUMPLEAÑOS 	34	6953214558857	1	0	1	0	\N	\N
1580	VELA DE CUMPLEAÑOS 	34	9328567891383	1	0	1	0	\N	\N
1806	JABON TOCADOR EXOTICA 85G	36	7840118212611	1	400	1	0	\N	\N
1805	JABON TOCADOR PINK C2 85 GR	18	7840118212628	1	400	1	0	\N	\N
1804	JABON TOCADOR ORANGE C2 85 GR	36	7840118212598	1	400	1	0	\N	\N
1448	MANTEQUILLA  250 GRS CALO	21	7802910150607	1	2500	1	0	\N	\N
1812	HEAD SHOULDERS 2X1 LIMP 375 ML 	36	7500435020046	1	3600	1	0	\N	\N
1679	MOSTAZA DON JUAN 240G	1	7802351314606	1	1100	1	0	\N	\N
1446	MANTEQUILLA SIN SAL 250G SOPROLE 	21	7802900111014	1	1900	1	0	\N	\N
1636	CONO CHICO SIMPLE	6	900	1	1400	1	0	\N	\N
1526	TENEDOR PLASTICO DESECHABLE MORADO 	34	9000000046689	1	500	1	0	\N	\N
1576	VELA DE CUMPLAÑOS 	34	9328567890386	1	650	1	0	\N	\N
1577	VELA DE CUMPLEAÑOS 	34	6956814017144	1	650	1	0	\N	\N
1549	TARJETA DE INVITACION CARITAS 6 PCS 	34	5606858329925	1	800	1	0	\N	\N
696	AZUCAR FLOR CRAV 500GR	1	7801430590566	1	650	1	0	\N	\N
1808	OPTIMO PREMIUM 50MT 4UN. 	2	7804653340475	1	1650	1	0	\N	\N
1552	BOMBILLAS PLASTICAS DESECHABLES 100 UN	34	9328201179310	1	1200	1	0	\N	\N
1554	GLOBOS AMARILLOS 50 PCS 	34	131305	1	1500	1	0	\N	\N
978	LAPIZ PASTA BIC UNIDAD	1	221	1	250	1	0	\N	\N
1555	GLOBOS COLORES  50 PCS 	34	131332	1	1500	1	0	\N	\N
108	CREMISSIMO CHOOLATE BRESLER 1 LITRO 	7	7805000305277	1	2390	1	0	\N	\N
1541	BOLSAS PARA DULCES DE CUMPLEAÑOS DOKI	34	5201552529406	1	0	1	0	\N	\N
1572	AUDIFONOS BASS IPHONES 	35	3325201542119	1	1500	1	0	\N	\N
2591	SUPER 8 2.0 MANI	1	7613032475581	1	600	1	0	\N	\N
149	FLAN EN POLVO AMBROSOLI VAINILLA 60 GRAMOS 	1	7802200371026	1	400	1	0	\N	\N
1563	AUDIFONOS EXTRA BASS FIAME 	35	3325201535548	1	2300	1	0	\N	\N
1573	ADAPTADORES DUO USB UNIVERSAL 	35	2000000000749	1	900	1	0	\N	\N
513	KEM PIÑA 500 CC	5	7801620016036	1	900	1	0	\N	\N
509	KEM XPRESS 237 ML	5	7801620003852	1	250	1	0	\N	\N
1602	CARBON QUINCHO 2.5K	1	7809583500296	1	2800	1	2000	\N	\N
761	GALLETA COQUITAS 170GR	6	7790040414433	1	700	1	0	\N	\N
1599	ARROLLADO HUASO SAN JORGE 	3	91	2	8600	1	0	\N	\N
775	OBLEA DOS EN UNO VAINILLA 140GR	6	7802225660105	1	900	1	0	\N	\N
794	ALGODON COPOS COTOBEL 50UN.	2	7806545030150	1	450	1	0	\N	\N
831	FOSFOROS PUERTO VARAS 10 CAJAS	2	7804603462097	1	500	1	0	\N	\N
540	BILZ RETORNABLE 1LT	5	7801620290047	1	750	1	0	\N	\N
783	GALLETA ARCOR DINOSAURIOS 35GR	6	7802225614498	1	200	1	0	\N	\N
2216	CHIP CLARO 	1	7809596424237	1	1000	1	0	\N	\N
1591	FIAMBRE SANDWICH SAN JORGE 	3	83	2	6000	1	3800	\N	\N
1593	JAMONADA DE PAVO SAN JORGE 	3	85	2	6000	1	4200	\N	\N
1600	ARROLLADO LOMO C/A SAN JORGE 	3	92	2	8000	1	5500	\N	\N
762	GALLETA DOS EN UNO COCO 135GR	6	7802225688017	1	650	1	0	\N	\N
763	GALLETA DOS EN UNO MANTEQUILLA 135GR	6	7802225688000	1	650	1	0	\N	\N
764	GALLETA DOS EN UNO LIMON 135GR	6	7802225688024	1	650	1	0	\N	\N
164	GALLETAS CHOCOLATE 140 G 	6	7802215505287	1	650	1	0	\N	\N
4288	CARNE DE SOYA PEQUEÑO	1	1236548964615835	1	1000	1	0	\N	\N
522	GINGER ALE  2,5 LT CANADA DRY	5	7801620019686	1	1500	1	0	\N	\N
620	YOGHURT CHOCAPIC  142 GRS NESTLE	4	7613033081538	1	600	1	0	\N	\N
1583	FIAMBRE DE AVE COCIDO 	3	75	2	6900	1	0	\N	\N
2130	BRAZO DE REINA 	12	646	1	1000	1	0	\N	\N
708	CHANCACA IANSA 450GR	1	7804077000115	1	2390	1	2100	\N	\N
103	COLGATE TRIPLE ACCIÓN 75 ML 	2	7509546000985	1	1250	1	0	\N	\N
44	ATUN LOMITOS EN ACEITE DEYCO 170 GRAMOS 	1	7801534002316	1	1200	1	0	\N	\N
1815	YOGHURT ZUCARITAS  140 GR SOPROLE	21	7802900332402	1	550	1	0	\N	\N
1823	TALLARINES 87  400 GRS CAROZZI	10	7802575004635	1	1300	1	800	\N	\N
1420	ARVEJAS GRANO 200 GRS FRUTOS DEL MAIPO	32	7801300012068	1	500	1	0	\N	\N
524	GATORADE NARANJA 1 LT	5	7801620005177	1	1100	1	0	\N	\N
533	GATORADE NARANJA 750 ML	5	7801620005207	1	900	1	0	\N	\N
543	ORANGE CRUSH RETORNABLE 1LT	5	7801620330071	1	700	1	0	\N	\N
544	LIMON SODA RETORNABLE 1LT	5	7801620340049	1	750	1	0	\N	\N
1681	TIC TAC FRUTOS ROJOS 16G	1	78938533	1	400	1	0	\N	\N
1682	TIC TAC DIVERSION DE FRUTAS 16G	1	78934696	1	400	1	0	\N	\N
1683	TIC TAC NARANJA 16G 	1	78600027	1	400	1	0	\N	\N
758	GALLETA CRACKER 54GR	6	7802225683289	1	250	1	0	\N	\N
1595	JAMONADA PREMIUM SAN JORGE 	3	87	2	7000	1	5500	\N	\N
1597	PECHUGA ASADA 	3	89	2	12000	1	7000	\N	\N
558	CACHANTUN SIN GAS 1,6 LTS	5	7801620852962	1	700	1	650	\N	\N
1592	MORTADELA LISA SAN JORGE 	3	84	2	5000	1	2900	\N	\N
771	GALLETA CEREAL MIX MIEL/ALMENDRAS 115GR	6	7802225689076	1	650	1	0	\N	\N
773	GALLETA CRACKER MERKEN 107GR	6	7802225682152	1	500	1	0	\N	\N
772	GALLETA CRACKER OREGANO 107GR	6	7802225682121	1	500	1	0	\N	\N
767	GALLETA ROCKLETS VAINILLA 165GR	6	7802225688758	1	990	1	0	\N	\N
184	GALLETAS OBSESIÓN CREMA CHOCOLATE 85 G 	6	7802215505027	1	1000	1	0	\N	\N
790	GALLETA BON O BON 95GR	6	7802225640770	1	1300	1	1000	\N	\N
434	CORBATA GRANDE DON VITTORIO 400G	1	7750243286183	1	890	1	0	\N	\N
1198	CREMA POLLO 72G GOURMET 	1	7802410002291	1	730	1	0	\N	\N
251	JUGO ZUKO CHIRIMOYA 25 GRAMOS 	1	7802800570997	1	200	1	0	\N	\N
435	ESPIRALES DON VITTORIO 400G	1	7750243286138	1	890	1	0	\N	\N
645	YOGURTH GRIEGO NESTLE DURAZNO 115GR	4	7613037016208	1	450	1	0	\N	\N
250	JUGO ZUKO MANGO 25 GRAMOS 	1	7802800578870	1	200	1	0	\N	\N
807	TOALLA FRESH UP ULTRAFINA C/ALAS  DIA 8UN.	2	6932757124439	1	650	1	0	\N	\N
361	SALSA TOMATE ITALIANA COLISEO 200 GRAMOS 	1	7804608221644	1	300	1	0	\N	\N
1684	LECHE SUR LECHE CONDENSADA 397G	1	7613031891344	1	1450	1	1290	\N	\N
1534	GUIRNALDA BANDERIN FELIZ CUMPLEAÑOS 3MT 	34	5606858330921	1	0	1	0	\N	\N
646	YOGURTH PROTEINA TROZOS PAPAYA 120GR	4	7613037042269	1	450	1	0	\N	\N
1818	PAPEL HIGIENICO SWAN 	2	7804653340642	1	6990	1	0	\N	\N
1418	PRIMAVERA  550 GRS FRUTOS DEL MAIPO	32	7801300000157	1	1100	1	0	\N	\N
528	REDBULL 355 CC	5	9002490221010	1	1700	1	0	\N	\N
3264	YERBA MATE VERDEFLOR BOLDO 500G	1	7793670000014	1	2990	1	0	\N	\N
446	SPAGHETTI TALLIANI N5 400G	1	7802500007021	1	1400	1	990	\N	\N
444	ESPIRALES TALLIANI 400G	1	7802500008042	1	1400	1	990	\N	\N
809	BABY WIPES BEBIKO 72UN.	2	8690624103151	1	1000	1	0	\N	\N
1141	CHORITOS AGUA  425 GRS CRUCERO	17	7804520988953	1	1650	1	0	\N	\N
1226	BRAUNICHOC 35G 	1	7803525000356	1	400	1	300	\N	\N
608	SOPA NATUREZZA POLLO CON FIDEOS 55GR	1	7803700012013	1	450	1	0	\N	\N
606	SOPA MAGGI POLLO CON VERDURAS 60GR	1	7802950004359	1	450	1	0	\N	\N
609	SOPA NATUREZZA CARACOLITOS 55GR	1	7803700012051	1	450	1	0	\N	\N
652	CAPPUCCINO SOBRE  14 GR NESCAFE	1	7613033458101	1	500	1	400	\N	\N
653	NESCAFE DOBLE CHOCA MOKA 23 GR	1	7613033527173	1	500	1	400	\N	\N
87	CHORITOS EN ACEITE ANGELMO 190 GRAMOS 	1	7801250000306	1	1200	1	0	\N	\N
649	YOGURTH GRIEGO NATURAL 120GR	4	7613036467339	1	500	1	400	\N	\N
785	MINI SELZ QUESO 35 GR ARCOR	6	7802225683234	1	300	1	250	\N	\N
163	GALLETAS CHOCO CHIPS 125 G 	6	7802215505140	1	700	1	650	\N	\N
169	GALLETAS DONUTS ORANGE BITTER 100 G 	6	7802215508547	1	1000	1	0	\N	\N
1873	RUCAS SELECT ORIGINAL 	1	6917554726369	1	1100	1	0	\N	\N
851	MARSHMALLOW MOGUL TRENZ VAINILLA 120GR	6	7802225280259	1	750	1	0	\N	\N
802	SHAMPOO RISOS DEFINIDOS  400 ML PANTENE	2	7501001164645	1	2800	1	0	\N	\N
801	ACONDICIONAR PANTENE RIZOS DEF. 400ML	2	7501001165321	1	2800	1	0	\N	\N
800	ACOND. CONT. CAIDA 400 ML PANTENE	2	7501001303518	1	2800	1	0	\N	\N
22	ALKA MENTA Y LIMON 29 G	6	78024977	1	250	1	0	\N	\N
4290	SHAMPOO KADUS 1000ML	1	7804947004557	1	1500	1	0	\N	\N
806	TOALLA FRESH UP ULTRAFINA C/ALAS  NOCTURNA 8UN.	2	6932757124446	1	650	1	0	\N	\N
810	PAÑALES ADULTO COTIDIAN M 8UN.	2	7806500773429	1	5500	1	0	\N	\N
611	CREMA DE ESPARRAGOS NATUREZZA 55GR	1	7803700012242	1	450	1	0	\N	\N
607	SOPA NATUREZZA POLLO CON ARROZ 55GR	1	7803700012037	1	450	1	0	\N	\N
170	GALLETAS DUETTO COCO 110 G 	6	7802220310197	1	500	1	0	\N	\N
1817	TOALLA PAPEL MAXI XL 450HOJAS	1	9977813	1	1600	1	0	\N	\N
691	MANJAR NESTLE 500GR	1	7802950009415	1	1800	1	0	\N	\N
692	MANJAR  1 KILO NESTLE	1	7802950004892	1	3100	1	0	\N	\N
1494	MELON TUNA 	11	2000000000633	1	1000	1	0	\N	\N
1474	ZAPALLO AMARILLO 	11	108	2	1000	1	0	\N	\N
278	VIRUTEX AROMA CÍTRICO 900 ML 	2	7806810016537	1	1500	1	0	\N	\N
2225	LAYS QUESO CHEDDAR 	1	7802000009310	1	600	1	0	\N	\N
49	NUGGET CAFE MARRON 65 G 	1	7702626302973	1	950	1	0	\N	\N
852	MARSHMALLOW MOGUL MORF TUBER 120GR	6	7802225280358	1	750	1	0	\N	\N
3256	HUEVITOS DE CHOCOLATE RELLENOS 90G	1	7802200850484	1	1250	1	0	\N	\N
854	MASTICABLES TIGRETON ARCOR 270GR	6	7757174008532	1	1950	1	0	\N	\N
75	CHOCMAN ALFAJOR 21 G 	6	7802215143045	1	150	1	0	\N	\N
150	FOSFORO COPIHUITO 	1	7806300010441	1	1000	1	0	\N	\N
151	FOSFORO GRAN ANDES 220 UND. 	1	7806300010038	1	1100	1	0	\N	\N
814	TANAX POLVO 25GR	2	7805300020108	1	850	1	700	\N	\N
279	VIRUTEX AROMA LAVANDA 900 ML 	2	7806810016506	1	1500	1	0	\N	\N
618	CHIQUITIN FRUTILLA  45 GRS NESTLE	4	78041097	1	300	1	0	\N	\N
842	GALLETA SODA LIGHT SELZ 180GR	6	7802225683623	1	900	1	850	\N	\N
156	FULL LIMON 27 G AMBROSOLI 	6	7802200133426	1	200	1	0	\N	\N
1527	CUCHARA PLASTICA DESECHABLE CELESTE 	34	9000000059986	1	500	1	0	\N	\N
950	PEPINILLOS TRAVERSO 200 GR	1	7802337910242	1	1200	1	0	\N	\N
1230	CHOCOLATE  14 GRS TRENCITO	25	7802950072679	1	200	1	0	\N	\N
1831	QUESO CREMA 100G COLUN 	1	7802920463100	1	690	1	0	\N	\N
4291	JABON KADUS 900ML	1	7804947005127	1	1500	1	0	\N	\N
1267	MERMELADA MORA VIVO 200G	1	7802200400023	1	1100	1	0	\N	\N
1268	MERMELADA DURAZNO VIVO 200G	1	7802200400047	1	1100	1	0	\N	\N
1303	LECHE FRUTILLA COLUN 200ML 	1	7802920759135	1	400	1	0	\N	\N
139	FIDEO CAROZZI RIGATONI 400 GRAMOS 	1	7802575002037	1	1300	1	800	\N	\N
138	FIDEO CAROZZI MOSTACCIOLI 400 GRAMOS 	1	7802575001832	1	1300	1	800	\N	\N
1569	CABLE USB QIHANG IPHONE 	35	3325201534077	1	2300	1	0	\N	\N
288	LYSOFORM DESINF. LAVANDA 257 G	2	7790520014184	1	2300	1	0	\N	\N
1210	PAN BLANCO IDEAL 380G 	1	7803403002540	1	1400	1	0	\N	\N
280	VIRUTEX AROMA PRIMAVERA 900 ML 	2	7806810016513	1	1500	1	0	\N	\N
1824	QUESO RALLADO MERKAT 40G	1	7804613390496	1	620	1	0	\N	\N
2228	CREMINO FRUNA	62	7802408000643	1	250	1	0	\N	\N
1184	ACEITE DE OLIVA GRECCO 500 CC 	1	7804608720307	1	5200	1	0	\N	\N
1224	SUPER 8 34G 	1	7613036615266	1	250	1	0	\N	\N
381	SHIP GINGER ALE 2 LITROS 	5	7804604720165	1	650	1	0	\N	\N
1825	CREMA CHANTILLY 60G VANCOOK	1	7802800563111	1	690	1	0	\N	\N
281	CLOROGEL IGENIX EUCALIPTUS 900 ML 	2	7805040000781	1	1300	1	0	\N	\N
282	CLOROGEL IGENIX LAVANDA 900 ML 	2	7805040001825	1	1300	1	0	\N	\N
1820	ESCOBILLA DE ROPA 	2	7805104000047	1	600	1	0	\N	\N
1819	PALA DE BASURA NEGRA 	18	7800143282102	1	1300	1	0	\N	\N
1422	CHOCLO GRANO  500 GRS FRUTOS DEL MAIPO	32	7801300301049	1	1100	1	0	\N	\N
1992	FANTA 591 ML	48	7801610591116	1	1000	1	900	\N	\N
1355	PASTEL INDIVIDUAL VARIEDAD 	12	619	1	1500	1	0	\N	\N
188	GALLETAS SODA LINE 180 G 	6	7802215511042	1	850	1	0	\N	\N
167	GALLETAS DONUTS CHOCOLATE BLANCO 100 G 	6	7802215508530	1	1000	1	0	\N	\N
241	JUGO SPRIM FRUTILLA 35 GRAMOS 	1	7802575222954	1	190	1	0	\N	\N
630	JALEA GUINDA NESTLE 110GR	1	7613035285408	1	350	1	0	\N	\N
264	KETCHUP DON JUAN 1 KG 	1	7802351612207	1	1800	1	0	\N	\N
1045	ALKA CRISTAL 450GR	6	P015	1	250	1	0	\N	\N
3705	CREMA DE MANI CHOSH 340G	1	7804610401256	1	2390	1	0	\N	\N
131	EL VERGEL DURAZNOS EN ALMIBAR EN TROCITOS	1	7809635400024	1	1100	1	0	\N	\N
4292	BALSAMO KADUS 1000ML	1	7804947004540	1	1500	1	0	\N	\N
1522	NOLSA DE DULCE 16X27CM CONEJO AZUL	34	5606858321370	1	1200	1	0	\N	\N
3265	YERBA MATE VERDEFLOR CEDRON 500G	1	7793670400517	1	2990	1	0	\N	\N
4369	QUILLAYES TROZO DE FRUTA YOGURT800G	1	7802930004799	1	2790	1	0	\N	\N
4370	YOGURT QUILLAYES TROZOS DE FRUTA  800G	1	7802930004805	1	2790	1	0	\N	\N
476	CANUTO  400 GRS LUCCHETTI	1	7802500001074	1	1300	1	800	\N	\N
475	QUIFAROS  400 GRS LUCCHETTI	1	7802500001050	1	1300	1	800	\N	\N
1325	PAN INTEGRAL 	8	9	2	2000	1	1650	\N	\N
574	NECTAR NARANJA PLATANO  1,5 LT WATTS	5	7801620004132	1	1350	1	0	\N	\N
1697	COMINO ENTERO15G MP 	1	7802420810107	1	290	1	0	\N	\N
1858	SALSA TOMATE DON VITORIO 200G	1	7750243052634	1	350	1	0	\N	\N
116	DOVE INVISIBLEDRY 150 ML 	2	7506306241176	1	2300	1	0	\N	\N
456	PURE INSTANTANEO BONANZA 125G	1	7808743602047	1	650	1	0	\N	\N
457	PURE INSTANTANEO BONANZA 250G	1	7808743602382	1	1350	1	0	\N	\N
257	JUGO ZUKO LIMÓN DULCE 25 GRAMOS 	1	7802800578917	1	200	1	0	\N	\N
756	GALLETAS CRACKER DIPS ARROZ 200GR	6	7802225689977	1	1200	1	0	\N	\N
757	GALLETAS CRACKER DIPS MAIZ 200GR	6	7802225689984	1	1200	1	0	\N	\N
429	YERBA MATE ARGENTINA SUPREMO 250 GRAMOS 	1	7801875068019	1	1550	1	0	\N	\N
234	JUGO LIVEAN MANZNA VERDE 7 GRAMOS 	1	7802800576432	1	200	1	0	\N	\N
4371	FRUTAS CONFITADAS	1	7803403003059	1	2900	1	0	\N	\N
159	GALLETA DE LIMON 140 G 	6	7802215505270	1	650	1	0	\N	\N
452	PASTA ESPIRALES  400 GR COLISEO	1	7798031153736	1	550	1	0	\N	\N
1556	GLOBOS ROJOS 50 PCS 	34	131302	1	0	1	0	\N	\N
155	FRUTTARE FRUTILLA BRESLER 70 ML 	7	7805000307066	1	900	1	0	\N	\N
122	BIO FRESCURA DESIERTO FLORIDO 400 G	2	7804609730343	1	750	1	0	\N	\N
105	ALMACENERO UNA HOJA 40 METROS 	2	7806500505426	1	4000	1	0	\N	\N
359	SALSA TOMATE D´AMPEZZO 200 GRAMOS 	1	7802810000989	1	250	1	0	\N	\N
954	JUGO EN POLVO VIVO MANGO 7GR	1	7802200266186	1	200	1	0	\N	\N
448	RIGATI 3 VEGETALES LUCCHETTI 400G	1	7802500184494	1	800	1	0	\N	\N
840	GALLETA DE SODA SELZ 180GR	6	7802225683661	1	800	1	0	\N	\N
371	SHAMPOO FRUCTIS FRESCURA VITAMINADA 350 ML 	2	7509552906479	1	2500	1	0	\N	\N
249	JUGO SPRIM PIÑA 35 GR 	1	7802575223128	1	190	1	0	\N	\N
300	MENTITAS AMBROSOLI 25 G 	6	7802200132696	1	200	1	0	\N	\N
305	GOMITAS MOGUL 35 GRAMOS 	6	7790580602000	1	300	1	200	\N	\N
349	ROCKLETS CHOCOLATE BARRA 40 G 	6	7802225573801	1	500	1	0	\N	\N
363	SERVILLETA ABOLENGO 40 UN.	2	7806500241294	1	200	1	0	\N	\N
4305	JABON GEL SIMONDS	1	7804945010734	1	1500	1	0	\N	\N
4306	NOT MAYO 300G	1	7804659650264	1	1650	1	0	\N	\N
4307	JABON AGUA COCO 500ML	1	7804945061767	1	1650	1	0	\N	\N
4308	JABON MIEL 500ML	1	7804945061743	1	1650	1	0	\N	\N
4309	JABON MAQUI 500ML	1	7804945061750	1	1650	1	0	\N	\N
135	FIDEO ACONCAGUA MOSTACCIOLI 400 GRAMOS 	1	7802575309815	1	500	1	0	\N	\N
134	FIDEO ACONCAGUA CARACOLES 400 GRAMOS 	1	7802575061096	1	400	1	0	\N	\N
168	GALLETAS DONUTS COCO CRUNCH 95 G 	6	7802215508554	1	1000	1	0	\N	\N
1834	CHOLGAS ANTARTIC ACEITE 190G 	1	7804621470739	1	1300	1	0	\N	\N
624	YOGURTH NESTLE VAINILLA 115GR	4	7613036466684	1	250	1	0	\N	\N
612	CREMA DE POLLO NATUREZA 55GR	1	7803700012228	1	450	1	0	\N	\N
12	ACOND. PANTENE RESTAURACIÓN 400 ML 	2	7501006721317	1	2800	1	0	\N	\N
1944	COCA COLA 591 ML	48	7801610000571	1	1000	1	900	\N	\N
1904	NECTAR DURAZNO XPRESS 250 ML	48	7802820250213	1	300	1	0	\N	\N
124	OMO MANCHAS DIFICILES 400 G	2	7805000313777	1	1200	1	0	\N	\N
125	OMO MATIC 400 G 	2	7805000313722	1	1250	1	950	\N	\N
4367	GALLETA FAMILIAR SANTIAGO 375G	1	7802264020106	1	1250	1	1390	\N	\N
4293	PLATANO ACAI COCO GUALLARAUCO	1	7803908006616	1	1000	1	0	\N	\N
4368	MANJAR CHOCOLATE GUALLARAUCO 103G 	1	7803908006623	1	1000	1	0	\N	\N
741	TE VERDE SUPREMO LIMON 20UN.	1	7801875055149	1	1400	1	0	\N	\N
4384	COCA COLA LIGHT 1 LTS	75	7801610022979	1	1000	1	0	\N	\N
4383	ANDINA DEL VALLE 1.5 LT 	1	7802820175011	1	1400	1	0	\N	\N
3911	ALGODON HIDROFILO 50 GR AMERICANO	73	7806545010114	1	700	1	0	\N	\N
4373	SUCRALOSA CERO K  250 ML IANSA	1	7801505000235	1	2200	1	0	\N	\N
4365	GALLETA FAMILIAR SANTIAGO 375G	1	7802264020205	1	1390	1	0	\N	\N
4366	GALLETA FAMILIAR SANTIAGO 375G	1	7802264020304	1	1390	1	0	\N	\N
722	CAFE CRUZERITO LIOFILIZADO 50GR	1	7896019209717	1	2000	1	0	\N	\N
1827	MARGARINA MIX 500 GR SOPROLE	21	7802900638016	1	2200	1	0	\N	\N
53	BOLSAS DE ASEO SUPERIOR 70X90 CM 10 UN 	2	7801875069368	1	1390	1	0	\N	\N
1060	SNACK MIX 2 EVERCRISP 50GR	6	7802000010965	1	500	1	0	\N	\N
338	PIÑAS RODAJAS WASIL 560 GRAMOS 	1	7801305100050	1	1600	1	0	\N	\N
1302	LECHE CHOCOLATE  200 ML SOPROLE	21	7802900056070	1	450	1	0	\N	\N
1799	JABON LIQ. TANGO ORANGE 500ML 	36	892166000341	1	1200	1	0	\N	\N
582	GELATINA SIN SABOR MERKAT 30G	1	7804616250988	1	350	1	0	\N	\N
1562	GLOBOS BALLOON 	34	1971104401613	1	1000	1	0	\N	\N
805	PROTECTOR LADYSOFT CLASICO 44UN.	2	7806500963295	1	1550	1	0	\N	\N
3266	VIRUTILLA REGULAR ARUBA GRADO 4	1	7805027000377	1	600	1	0	\N	\N
228	LUX JAZMIN 125 G 	2	7791293037615	1	900	1	0	\N	\N
313	NOBLE ALMACENERO 12 ROLLOS 28 METROS 	2	7806500000518	1	2400	1	0	\N	\N
2139	BOLSAS REUTILIZABLES MORADO MEDIANAS 	1	2123	1	850	1	0	\N	\N
1229	GALLETA NEGRITA BAÑADA 30 GRS	26	7802230073907	1	200	1	0	\N	\N
1615	TRITON 125ML SAVORY 	6	7613037484854	1	990	1	0	\N	\N
776	OBLEA DOS EN UNO FRUTILLA 140GR	6	7802225660303	1	900	1	0	\N	\N
1835	BOLSA BASURA WINNEX 105X150CM 	2	012345678110	1	4000	1	0	\N	\N
1840	MIX FRUTOS SECOS 100G CAMILA	6	7804623100269	1	900	1	0	\N	\N
755	GALLETAS MANA CHOCOLATE ARCOR	6	7790040415645	1	1600	1	0	\N	\N
272	LADYSOFT ULTRAD. NOC. T/SUAVE C/ALAS 8UN.	2	7806500960911	1	1000	1	850	\N	\N
838	GALLETA DOS EN UNO CHOCOLATE 140GR	6	7802225688031	1	550	1	0	\N	\N
4385	HAMBUERGUESA SAN JORGE N90G	1	7801907001762	1	750	1	650	\N	\N
753	GALLETAS SURTIDAS DOS EN UNO 400GR	6	7802225272056	1	1500	1	0	\N	\N
626	YOGURTH NESTLE PLATANO 115GR	4	7613036467230	1	230	1	0	\N	\N
171	GALLETAS DUETTO FRUTILLA 110 G 	6	7802220310081	1	500	1	0	\N	\N
115	AXE MUSK 150 ML 	2	7791293025834	1	2500	1	0	\N	\N
3043	TANAX MOSCAS Y ZANCUDOS 440G	1	7805300049673	1	2990	1	0	\N	\N
2186	VASOS CHICOS UNIDAD	1	2000000001081	1	50	1	0	\N	\N
2025	QUESO LAMINADO RAFULCO 250G	1	7804646540042	1	1680	1	0	\N	\N
671	CHAMPIÑONES LAMINADOS ARUBA 400 GR	1	7801430150319	1	1200	1	0	\N	\N
1513	POMELO 	11	127	2	900	1	0	\N	\N
3406	ACEITE MERKAT MARAVILLA 1 LT 	1	7808743604300	1	1750	1	0	\N	\N
2032	MR. BIG ENERGY 2LT 	54	7804646000058	1	3000	1	0	\N	\N
2424	RICE CAKES NATURAL 100G	1	8606012181601	1	1050	1	0	\N	\N
2444	FLORAX 4 ROLLOS DOBLE HOJA 	1	7804612610274	1	1100	1	0	\N	\N
2458	MASCARAS HALLOWEEN BLANCO Y NEGRO 	1	2000000001265	1	1000	1	0	\N	\N
154	FRUTILLAS ENTERA WASIL 410 GRAMOS 	1	7801305002378	1	1550	1	0	\N	\N
1040	ALKA ICE MIEL 390GR	6	7790580406318	1	250	1	0	\N	\N
2570	TANAX MATA ARAÑAS/BARATAS	18	7805300049598	1	2590	1	0	\N	\N
394	FUZOL CLASSIC 1 LITRO 	2	7804920280572	1	1200	1	0	\N	\N
1715	COLADOS POLLO Y VERDURAS 115 GRS	1	7613036749565	1	950	1	0	\N	\N
1502	BERENJENA 	11	2000000000657	1	0	1	0	\N	\N
1081	TWISTOS JAMON IBERICO EVERCRISP 43GR	6	7802000005541	1	500	1	0	\N	\N
811	PAÑALES G  8 U COTIDIAN	2	7806500773610	1	5500	1	0	\N	\N
260	JUGO ZUKO NARANJA 25 GRAMOS 	1	7802800578801	1	200	1	0	\N	\N
554	LIMON SODA  DES.3 LTS	5	7801620001643	1	2000	1	1950	\N	\N
2962	LADYSOFT BASICA 8 UN. 	1	7806500961710	1	400	1	0	\N	\N
183	GALLETAS OBSESIÓN 85 G CREMA MANI 	6	7802215514333	1	1000	1	0	\N	\N
3108	AUDIFONOS MAXEL EB95	1	025215190247	1	1900	1	1550	\N	\N
2051	PILA PANASONIC D UNIDAD 	56	7756726001809	1	700	1	500	\N	\N
147	FIDEO SPAGHETTI CAROZZI N°5 400 GRAMOS 	1	7802575004437	1	1300	1	800	\N	\N
1424	POROTOS VERDES 150G FRUTOS DEL MAIPO	32	7801300002939	1	500	1	0	\N	\N
1073	CHEETOS EVERCRISP 64GR	6	7802000011900	1	500	1	0	\N	\N
1797	JABON C2 WHITE 85 GR	36	7840118212635	1	400	1	0	\N	\N
1124	CREMA DE CHOCLO 79 G GOURMET 	1	7802410002284	1	500	1	0	\N	\N
4295	MALLOA 175G	1	7805000319786	1	380	1	0	\N	\N
365	SHAMPOO BALLERINA MANZANILLA 900 ML 	2	7804920018779	1	2100	1	0	\N	\N
1348	PIE DE LIMON 	12	623	1	5000	1	0	\N	\N
3810	CIF CLOROGEL LIMON 900ML 	1	7805000148539	1	2390	1	0	\N	\N
3806	SHAMPOO PANTENE PRO-V	1	7501006721119	1	1250	1	0	\N	\N
3807	ANDINA DURAZNO 250ML	1	2000000001579	1	300	1	0	\N	\N
3405	YOGHURT LIGHT FRUTILLA  120 GR SOPROLE	1	7802900234225	1	350	1	0	\N	\N
3407	CLORO GEL QU2000 2 LT	1	7804663500036	1	1800	1	0	\N	\N
3408	CLORO DON CALVO 5LT	22	2000000001500	1	2000	1	0	\N	\N
3433	LENTEJAS SAN JOSE 1 KG 	1	7801235000505	1	2400	1	0	\N	\N
2960	LECHE COLUN CARAMELO 1LT 	1	7802920008103	1	1750	1	0	\N	\N
2961	LADYSOFT NOC. NORMAL TELA SUAVE 8UN. 	1	7806500960652	1	1300	1	0	\N	\N
262	JUGO ZUKO PAPAYA 25 GRAMOS 	1	7802800570980	1	200	1	0	\N	\N
3811	PRESERVATIVOS FOHLEN 3 UN. 	1	6959373801933	1	1500	1	0	\N	\N
1481	NARANJAS 	11	111	2	1100	1	1200	\N	\N
268	KOTEX NOC. ULTRAF. SUAVE 8UN	2	7809604028228	1	990	1	0	\N	\N
3835	LECHE BUEN DIA  900 GR NIDO	1	7613032496432	1	6490	1	0	\N	\N
3836	LECHE HUESOS SVELTY 800G	1	7613033567773	1	6650	1	0	\N	\N
3839	QUESO COLUN RANCO 150G	1	7802920115504	1	1700	1	0	\N	\N
3840	ALGODON WIN 	1	7809634801204	1	700	1	0	\N	\N
1138	DIANA MAKE UP 25 PCS ROSADA 	1	8690879905012	1	990	1	0	\N	\N
2792	HARINA DE MAIZ JUANA 1KG. 	1	7707325840085	1	2050	1	0	\N	\N
123	BIOFRESCURA DESIERTO FLORIDO 800G	2	7804609730268	1	1900	1	1450	\N	\N
3804	PRINGLES QUESO CHEDDAR 158GR. 	1	038000138577	1	2450	1	1990	\N	\N
2299	LECHE SEMID.MANJAR 1 LT COLUN	21	7802920007151	3	1550	1	0	\N	\N
3803	PAPAYAS A LA CREMA 613G GUALLARAUCO 	1	7803908003967	1	4300	1	0	\N	\N
1170	HAMBURGUESA POLLO 90G PF 	1	7801930009223	1	700	1	500	\N	\N
1172	HAMBURGUESAS POLLO  50 GRS PF	20	7801930009414	1	400	1	0	\N	\N
743	SUPREMO CEDRON 20UN.	1	7801875058034	1	1150	1	0	\N	\N
4296	INVITE 	1	8692806623778	1	1990	1	0	\N	\N
1341	ROSQUILLAS 	12	629	1	250	1	0	\N	\N
3235	BANQUETE ARROZ G1 1KG 	1	7803110102212	1	1800	1	0	\N	\N
1014	LASAÑA PRECOCIDA LUCCHETTI 360GR	1	7802500221663	1	1700	1	0	\N	\N
3473	MANJAR NESTLE 800G 	1	7613038639161	1	3250	1	0	\N	\N
3868	CHOCLITOS COCTEL 425G 	1	7804610400068	1	1200	1	0	\N	\N
480	ACEITE VEGETAL SMARTPRICE 900ML	1	7794870056009	1	1200	1	0	\N	\N
3813	MANTEQUILLA UNTABLE COLUN 200G	1	7802920001326	1	2500	1	0	\N	\N
1783	RAID SIN OLOR 145G 	18	7790520002327	1	2000	1	0	\N	\N
90	CHUBI AGITAME 	6	78025172	1	500	1	0	\N	\N
1493	MELON CALAMEÑO 	11	2000000000626	1	1000	1	0	\N	\N
24	ALKA MIEL 29 G 	6	78020153	1	250	1	0	\N	\N
861	GOMITAS MOGUL EXTREME ARCOR 400GR	6	7802225412131	1	1800	1	0	\N	\N
287	LYSOFORM DESINF. ORIGINAL 360 CM3 	2	7790520014177	1	2300	1	0	\N	\N
3721	CREMA NESTLE LIGHT 236G	1	7613037138306	1	1100	1	0	\N	\N
4387	MANGO CONGELADO GUALLARAUCO 333G	1	7803908000508	1	1950	1	0	\N	\N
4388	MONSTER MANGO LOCO	1	070847035800	1	1500	1	0	\N	\N
4390	DANKYN KING 	1	7613287171665	1	1590	1	0	\N	\N
4392	POWER ADE AZUL 1 LT 	1	7802820671988	1	1000	1	0	\N	\N
4394	CHORITOS AL NATURAL 190GR	1	7804610400754	1	1400	1	0	\N	\N
4395	LOMITOS EN AGUA SAN JOSE 140GR	1	7801235001656	1	1300	1	0	\N	\N
4389	PEPINILLOS DON JUAN 400G	1	7802351451202	1	1200	1	0	\N	\N
4396	ATUN LOMITOS ACEITE SAN JOSE 140GR 	1	7801235001649	1	1300	1	0	\N	\N
4393	COCKTAIL DE FRUTAS COLISEO 567GR 	1	7804608223747	1	1500	1	0	\N	\N
4397	REPUESTO GILLETE MAS 3 	1	7506339399523	1	1650	1	0	\N	\N
3869	PALMITOS ENTEROS HOMAR 400G 	1	7804645050016	1	3150	1	1550	\N	\N
3471	MANLAC PLATA 3 UN	1	7806800004285	1	1990	1	1290	\N	\N
4353	JABON BALLERINA 350 ML 	1	7804920350664	1	1200	1	900	\N	\N
4391	RAPIDITAS IDEAL 200 GR	1	7803403000331	1	1200	1	1000	\N	\N
4386	HAMBURGUESA CARNE DE ANGUS 185 G 	1	7801916038582	1	1250	1	1100	\N	\N
4398	CHORITO EN ACEITE GHOSH 190G	1	7804610400730	1	1450	1	0	\N	\N
3866	TOMATES PICADOS SANTE 400G 	1	7804610401423	1	1100	1	0	\N	\N
4297	CABLE IPHONE	1	7450078489437	1	9200	1	0	\N	\N
4298	QUESO GAUDA GRANULADO 250G	1	7801930020532	1	1850	1	0	\N	\N
4299	PERFORMANCE 500ML	1	742832192477	1	1500	1	0	\N	\N
3867	ESPARRAGOS GHOSH 370 ML 	1	7804610401102	1	2300	1	0	\N	\N
4400	SURTIDO DE MARISCO EN ACEITE AGELMO 425G	1	7801268000374	1	2500	1	0	\N	\N
3042	TANAX MATA INSECTOS 440G	1	7805300049659	1	3150	1	0	\N	\N
4406	MELON 350ML	1	8809713910239	1	1000	1	0	\N	\N
4407	STRAWBERRY FRESA 350ML	1	8809713910192	1	1000	1	0	\N	\N
4408	WATERMELON SANDIA 350ML	1	8809041429809	1	1000	1	0	\N	\N
4409	MOMS CASERAS 160G	1	7802000013850	1	1000	1	0	\N	\N
4410	TAKIS XPLOSION	1	757528039646	1	1700	1	0	\N	\N
4412	TAKIS FUEGO	1	757528039608	1	1700	1	0	\N	\N
4417	ANDINA DEL VALLE 200ML 	1	7802820557770	1	250	1	0	\N	\N
4419	CACHANTUN MAS LIMONADA MENTA 1.6 LT  	1	7801620007010	1	1050	1	0	\N	\N
4418	LAYS PIZZA 134G	1	7802000013638	1	1600	1	0	\N	\N
2614	QUESO CREMA FILADELFIA  227 GR LA VAQUITA	1	7804613390953	1	2250	1	0	\N	\N
4413	CHAMITO CHOCAPIC 142G 	1	7613287084286	1	550	1	0	\N	\N
4414	RAMITAS ORIGINAL 48G	1	7802000013737	1	400	1	0	\N	\N
4415	YOGURTH LOS ALERCES 1 KG 	1	7802920001289	1	1300	1	0	\N	\N
4416	MIX FRUTAS ACONCAGUA 280G	1	7801800103716	1	2200	1	0	\N	\N
4421	ENVASE 	1	2000000001708	1	500	1	0	\N	\N
4422	MOGUL TIBURONCITOS 	1	7790580200114	1	300	1	250	\N	\N
4300	MEMO CANNABIS ENERGY 500ML	1	742832179249	1	1500	1	0	\N	\N
4423	PALITO PIÑA 	1	4*7802408000520	1	150	1	0	\N	\N
4399	CAFE DESCAFEINADO GOLD 170G 	1	7802800500819	1	4900	1	0	\N	\N
2085	LUCKY CRUSH 10 UN	55	78024403	1	2700	1	2500	\N	\N
510	BILZ 500 CC	5	7801620016012	1	1000	1	900	\N	\N
2077	KENT BELMONT BLUE 10	55	78021020	1	2200	1	2000	\N	\N
4427	TOSTITOS 300G 	1	7802000012327	1	1700	1	0	\N	\N
4315	OIKOS 150G	1	7802955007799	1	550	1	0	\N	\N
4401	DURAZNOS EN CUBITO 567GR	1	7804610400433	1	1300	1	0	\N	\N
4402	DURAZNOS EN MITADES GHOSH 425G	1	7804610400167	1	1000	1	0	\N	\N
4403	BOLSA ASEO SUPERIOR 79 X90	1	7801875001948	1	800	1	0	\N	\N
4428	LAYS CREMA CEBOLLA 134	1	7802000013621	1	1700	1	0	\N	\N
529	REDBULL 250 CC	5	9002490100070	1	1300	1	0	\N	\N
3020	PHILADELPHIA 210G	1	7622210512352	1	2990	1	0	\N	\N
1946	COCA COLA ZERO DESECHABLE 1,5 LT	48	7801610350409	1	1600	1	0	\N	\N
4338	COCA COLA LIGHT DESECHABLE 1,5 LT	75	7801610022726	1	1600	1	0	\N	\N
3205	NECTAR DAMASCO  1,5 LT ANDINA	1	7802820000030	1	1400	1	0	\N	\N
1937	NECTAR PIÑA  2 LT ANDINA DEL VALLE	38	7802820210620	1	1500	1	0	\N	\N
4327	POTE BRESLER MYM BLAST 1.89 LT 	1	7805000314255	1	3000	1	0	\N	\N
4441	PEDIGREE CACHORRO 	77	232	2	2800	1	2400	\N	\N
4429	MANTEQUILLA SIN SAL COLUN 250G 	1	7802920203409	1	2000	1	0	\N	\N
4430	TUBIG CHOCOLATE 	1	7896079846501	1	200	1	0	\N	\N
2574	MIX FRUTAS EN CUBITOS CONSERVA 	1	7801800103747	1	2700	1	0	\N	\N
2068	FANTA RETORNABLE 2 LTS	50	7801610671115	1	1000	1	0	\N	\N
3603	ANDINA DEL VALLE DURAZNO RETORN. 1.5LT	1	7802820500066	1	1400	1	0	\N	\N
3677	ANDINA MIX 1.5	1	7802820881004	1	1400	1	0	\N	\N
4431	MANCHATE LA LENGUA FRESA 	1	78025257	1	200	1	0	\N	\N
4432	MANCHATE LA LENGUA MENTA 	1	78025264	1	200	1	0	\N	\N
2914	IGENIX CLOROGEL FLORAL 900ML 	1	7805040001832	1	1350	1	0	\N	\N
3424	CLOROX ANTISPLASH 950G 	1	7805025697357	1	1590	1	0	\N	\N
4433	MERMELADA WHATTS CIRUELA 250G	1	7802810031051	1	1000	1	0	\N	\N
4301	ALOE MANGO500ML	1	8809041429601	1	1000	1	0	\N	\N
4425	CHEESECAKE MARACUYA 103G GUALLARAUCO	1	7803908006609	1	1590	1	0	\N	\N
4443	PEDIGREE ADULTO 	77	234	2	2500	1	2200	\N	\N
1930	COCA COLA ZERO RETORNABLE 3 LT	49	7801610333327	1	2000	1	0	\N	\N
1919	SPRITE VIDRIO 1 LT	48	7801610005040	1	1000	1	900	\N	\N
4442	MASTER DOG CACHORRO 	77	233	2	2600	1	1700	\N	\N
4404	GRAPE UVA 350ML	1	8809041429823	1	1000	1	0	\N	\N
4434	MERMELADA WHATTS MORA SIN AZUCAR 200G	1	7802650006202	1	1100	1	0	\N	\N
4437	KOTEX ULTRA FINA 16 UNI	1	7809604012241	1	2490	1	0	\N	\N
4438	CREMISSIMO 1.89 LT 	1	7805000305345	1	3000	1	0	\N	\N
4451	AUDIFONOS AIWA	1	7804612214014	1	3390	1	0	\N	\N
4452	ALEO ORIGINAL 500ML	1	884394000774	1	1000	1	0	\N	\N
4447	MONSTER JUICE RIPPER 473ML	1	070847009559	1	1500	1	0	\N	\N
4449	POETT ESPIRITU JOVEN 200ML 	1	7805025690938	1	450	1	0	\N	\N
4450	AUDIFONOS DB	1	4710007730843	1	2590	1	0	\N	\N
4453	ALOE PINEAPPLE 500ML	1	8809041429670	1	1000	1	0	\N	\N
4454	ALOE STRAWBERRY 500ML	1	8809041429625	1	1000	1	0	\N	\N
4455	BENEDICTINO 2L	1	7802820454208	1	1000	1	0	\N	\N
4456	KIWI PERA 500ML	1	7804651870110	1	1000	1	0	\N	\N
4473	ESCOBILLA PARA LAVAR 	1	7806800008924	1	350	1	0	\N	\N
4459	LAVALOZAS LIMON CITRUS  1 L VIRGINIA	73	7805040002136	1	1500	1	0	\N	\N
4465	MANTEQUILLA RUMAY	1	7804634400242	1	2000	1	0	\N	\N
2907	CONFORT DOBLE HOJA 25MTS. 	1	7806500001119	1	1200	1	0	\N	\N
4466	ANDINA DEL VALLE 1.75	1	7802820175059	1	1400	1	0	\N	\N
4468	SPRIM PAPAYA 	1	7802575223555	1	190	1	0	\N	\N
4471	NOVA GIULIETTA 90 MTS 	1	8021161003411	1	3500	1	0	\N	\N
4467	SPRITE ZERO 3 LT 	1	7801610284339	1	2400	1	0	\N	\N
4474	CEREAL KELLOYYS CHOCO KRISPIS 	1	7501008067406	1	4800	1	0	\N	\N
4354	JABON BALLERINA 900 ML 	1	7804920002747	1	1400	1	0	\N	\N
1469	CEREZA	11	103	2	1600	1	0	\N	\N
4294	ILICIT RUBIO DORADO	1	7804923031492	1	2000	1	0	\N	\N
4436	PAPAS MEDITERRANEAS LAYS 34G	1	7802000014864	1	600	1	0	\N	\N
3167	LUCKY STRIKE MELON TUNA 20U	1	78025240	1	4700	1	4500	\N	\N
4435	MERMELADA WHATTS ALCAYOTA SIN AZUCAR 200G	1	7802810010209	1	1100	1	0	\N	\N
4405	LEMON LIMON 350ML	1	8809713910215	1	1100	1	1000	\N	\N
4200	PALLMAN ROSADO XL	1	78025066	1	3600	1	3500	\N	\N
4448	MANI JAPONES 100 G	1	7802420125492	1	1000	1	0	\N	\N
1924	COCA COLA RETORNABLE 1,5 LTS	48	7801610001288	1	1000	1	0	\N	\N
1923	FANTA RETORNABLE 1,5 LTS	48	7801610002230	1	1000	1	0	\N	\N
1925	SPRITE RETORNABLE 1,5 LTS	48	7801610005231	1	1000	1	0	\N	\N
3963	ANDINA DEL VALLE FRUTILLA 1.5 LT	1	7802820175202	1	1400	1	0	\N	\N
2853	COCA COLA ZERO RETORNABLE 2,5 LT	75	7801610350652	1	1800	1	0	\N	\N
1750	PROT. LARGOS NOSOTRAS 30UN.	1	7702026180904	1	1800	1	0	\N	\N
3644	KENT SILVER 	1	78025332	1	4400	1	4200	\N	\N
4470	PINZAS DE MADERA PARA ROPA 	1	8000798056281	1	1200	1	0	\N	\N
4475	SALSA SOYA GHOSH 	1	7804610400976	1	1050	1	0	\N	\N
4476	TOALLAS HUMEDAS TEDDY 80 UN 	1	7808304315935	1	1400	1	0	\N	\N
3482	VANISH ROPA COLOR 400ML 	1	7791130002240	1	1100	1	0	\N	\N
4472	SESAMO TOSTADO 30G MARCO POLO	1	7802420002502	1	350	1	0	\N	\N
4477	AQUAFRESH WHITENING 75 G	1	7794640172311	1	1300	1	0	\N	\N
4045	TOALLAS HUMEDAS BABYSEC FRESH 50 PCS 	1	7806500730958	1	1150	1	0	\N	\N
832	FOSFOROS PUERTO VARAS 150UN.	2	7804603463612	1	990	1	0	\N	\N
4478	PECHUGA DESHUESADA 700G SUPER POLLO	1	7809611707444	1	3800	1	0	\N	\N
4173	AQUAFRESH 2 UN. 95G	1	7800029002039	1	2800	1	0	\N	\N
4479	COLA CAO INSTANTNEO 180G	1	7802635000652	1	1300	1	0	\N	\N
4837	WHISKAS GATITOS 	77	239	2	2990	1	0	\N	\N
4464	TRONCO DE CASTAÑA SAN FRANCISCO 	1	7802926000170	1	4500	1	0	\N	\N
4439	BIGTIME ULTRA SANDIA 	1	78024441	1	900	1	0	\N	\N
4481	HUGGIES PROMO PACK XG16	1	7809604030245	1	3900	1	0	\N	\N
4482	BABYSEC PREMIUN XG14	1	7806500799498	1	3500	1	0	\N	\N
4483	PAYITA XPLOT	1	6920484008375	1	300	1	0	\N	\N
284	CLORINDA GEL MENTA 900 ML 	2	7805080695091	1	1850	1	1650	\N	\N
4469	KENT BOOST UP 	1	78025318	1	4600	1	4400	\N	\N
343	PROT. LADYSOFT ULTRAD. 20 UN	2	7806500962335	1	750	1	650	\N	\N
4484	MANO CLAP	1	6957342988517	1	250	1	200	\N	\N
4460	FRAMBUESAS A LA CREMA SAN FRANCISCO 1 LT	1	7802926000033	1	6300	1	4500	\N	\N
4463	SAN FRANCISCO SUSPIRO LIMEÑO 	1	7802926000149	1	6300	1	4500	\N	\N
4462	TIRAMISU SAN FRANCISCO 1 LT 	1	7802926000194	1	6300	1	4500	\N	\N
4302	ALOE DRINK VERA 500ML	1	884394006462	1	1000	1	0	\N	\N
4303	ALOE VERA DRINK 500ML	1	884394006486	1	1000	1	0	\N	\N
4495	FUZOL SUAVIZANTE RELAX 1.2LT 	1	7804920006684	1	2500	1	0	\N	\N
4496	GRINS LIMPIAVIDRIOS 500ML 	1	8010690023908	1	1500	1	0	\N	\N
3391	LAVALOZAS EXCELL ANTIGERMENES 500CC	1	7805020002163	1	1200	1	0	\N	\N
4485	RELOJ DE NIÑO	1	0001	1	200	1	0	\N	\N
4497	LAVALOZAS GRINS 500 ML 	1	8010690101262	1	990	1	0	\N	\N
4004	LAVALOZAS TREMEX 200ML	1	7804644721542	1	600	1	0	\N	\N
4487	NOVA CLASICA 3 ROLLOS 12M C/U	1	7806500406709	1	1550	1	0	\N	\N
4488	DOVE DELICIOUS CARE  90GR	1	7891150019560	1	1150	1	0	\N	\N
4489	PEPSODENT 130G X2	1	7805000311360	1	2800	1	0	\N	\N
4498	LAVALOZAS GRINS 500ML 	1	8010690101255	1	990	1	0	\N	\N
4490	CAFE PREMIER GOLD 50G	1	7802800500772	1	1650	1	0	\N	\N
4491	CHUÑO DELICADO 250 GR	1	7804520155119	1	600	1	0	\N	\N
4499	CLORO GEL DOÑA GABY 900ML 	1	7804655191129	1	1600	1	0	\N	\N
4500	PAÑO ABSORBENTE MULTIUSO GABY 10 UN	73	7804655191112	1	1600	1	0	\N	\N
4501	LAVALOZAS GRINS 500ML 	1	8010690101279	1	990	1	0	\N	\N
4492	YERBA MATE ORO 500GR	1	7804649510066	1	2800	1	0	\N	\N
4493	CACAO DULCE LA PASTELERA 150G	1	7801434001341	1	750	1	0	\N	\N
4494	CACAO AMARGO LA PASTELERA 150G	1	7801434001891	1	750	1	0	\N	\N
4502	DESODORANTE FULL LOVE 	1	8692641039482	1	1900	1	0	\N	\N
2416	MIRAFLORES PAELLA 175G	1	7802615008036	1	1100	1	1050	\N	\N
4254	AGUA CEREZA 500 ML	1	7804651870103	1	1000	1	0	\N	\N
4457	LECHE CONDENSADA 320G	1	7613039604007	1	1800	1	0	\N	\N
2980	MIRAFLORES CHAUFAN 210G 	1	7802575755575	1	1100	1	1050	\N	\N
4312	DULCE DE LECHE SOPROLE 1KG	1	7802900413019	1	3000	1	0	\N	\N
3033	POLVOS HORNEAR  200 GR IMPERIAL	1	7802950005028	1	1690	1	1550	\N	\N
4304	JABON CREMA SPA CASTAÑA	1	7804945061804	1	1650	1	0	\N	\N
3212	KOTEX PROTECTOR DIARIO 40U	1	7809604028464	1	1400	1	0	\N	\N
4504	RAMITAS QUESO 48GR	1	7802000013720	1	500	1	400	\N	\N
3844	ACEITE DALMACEN 900ML	1	7278945911870	1	2800	1	1250	\N	\N
2981	MIRAFLORES CHAMPIÑON 210G 	1	7802615007985	1	1050	1	0	\N	\N
4536	COCLONE 72 GR	1	7801552006129	1	250	1	0	\N	\N
4461	SAN FRANCISCO CHOCOLATE NUSS	1	7802926000965	1	4500	1	0	\N	\N
4510	CASATA PISTACHO SAN FRANCISCO 1 LT 	1	7802926000927	1	4500	1	0	\N	\N
4511	CASATA PLATANO MANJAR SAN FRANCISCO 1 LT 	1	7802926000101	1	4500	1	0	\N	\N
4512	CASATA MARACUYA A LA CREMA SAN FRANCISCO 1 LT 	1	7802926001221	1	4500	1	0	\N	\N
4513	CASATA CREMISSIMO TRISAVOR 	1	7802705400924	1	3500	1	0	\N	\N
4519	INSALATA CAROZZI 250G	1	7802575015389	1	1290	1	1100	\N	\N
4520	FLAGG LUCUMA MANJAR 110G	1	7801552006457	1	850	1	0	\N	\N
4522	EMOJI 55GR 	1	7801552006082	1	400	1	0	\N	\N
4525	PALETA SANDIA TRENDY	62	7801552002299	1	300	1	0	\N	\N
4527	COCO CHOC 53 GR 	1	7801552006488	1	400	1	0	\N	\N
4313	COLUM SIM LACTOSA 200 ML	1	7802920009636	1	450	1	0	\N	\N
3884	EMPANADA QUESO  8 U PRODUCTOS REVILLA	7	7604229133957	1	2200	1	0	\N	\N
4530	CHIRIMOYA ALEGRE TRENDY	62	7801552002855	1	250	1	0	\N	\N
4531	MR BIG ENERGY ICE 120G	1	7801552006198	1	600	1	0	\N	\N
4533	LENGUIX FRAMBUESA TRENDY	62	7801552002435	1	300	1	0	\N	\N
4537	HELADO AGUA PIÑA 78GR	1	7801552005962	1	350	1	0	\N	\N
4539	GOMUTCHO YOGURT	1	7891151029452	1	150	1	0	\N	\N
4543	LECHE CULTIVADA COLUN LIGHT FRUTILLA 1 LT 	1	7802920001203	1	1700	1	0	\N	\N
4544	NOVA CLASICA FAMILIAR 300	1	7806500241201	1	1850	1	0	\N	\N
4546	HEIDI BOUQUET 120 G  	1	5941021017897	1	3490	1	0	\N	\N
4547	YOGURT QUILLAYES PAPAYAS 800G	1	7802930004812	1	2790	1	0	\N	\N
4565	CANDY HELICPTERO	1	6923256962776	1	200	1	0	\N	\N
4515	GALLETAS DELICIAS	1	7802225686006	1	1700	1	1500	\N	\N
4311	SOPROLE PROTEIN 1 LITRO	1	7802900002381	1	1900	1	0	\N	\N
4516	GOURMET HAMBURGUESA 650G	1	7803480001214	1	2400	1	2200	\N	\N
4517	ARTESANAL 450G	1	7803403003066	1	1850	1	1750	\N	\N
4509	CASATA COOKIES AND CREAM SAN FRANCISCO 1 LT 	1	7802926001580	1	6300	1	4500	\N	\N
4548	1 MAS 1 SOPROLE 	1	7802900337049	1	600	1	0	\N	\N
4549	HERSHEYS KISSES TRUFA 120G        	1	7501024546190	1	3200	1	0	\N	\N
4550	HERSHEYS KISSES CARAMELO 120G	1	7501024583003	1	3200	1	0	\N	\N
4551	HERSHEYS KISSES CEREZA 120G	1	7501024546138	1	3200	1	0	\N	\N
4532	HAWAI 120G 	1	7801552002541	1	600	1	0	\N	\N
4524	COLUMBIA 60 GR	1	7801552006051	1	350	1	0	\N	\N
4534	PIÑA COLADA 55 GR 	1	7801552002459	1	250	1	0	\N	\N
4529	HELADO EL CHAVO  65 CC TRENDY	62	7801552003234	1	200	1	0	\N	\N
4535	TROCK XTRA CRUNCH 76 GR 	1	7801552006235	1	690	1	0	\N	\N
4458	LAVALOZAS PININA 1LT 	1	2000000001715	1	1700	1	0	\N	\N
4552	SALSA OLIVE 400G	1	8076809513708	1	2350	1	0	\N	\N
4553	SALSA BOLOGNESE 400G	1	8076809513678	1	3000	1	0	\N	\N
4554	ACEITUNA DESCORAZADAS 100G	1	7802351000806	1	1300	1	0	\N	\N
4555	ACEITUNA RELLENA PASTA DE PIMIENTO 125G	1	7802351000790	1	1400	1	0	\N	\N
4566	TWISTOS QUESO 110G	1	7802000001819	1	1000	1	0	\N	\N
202	HARINA C/P MONT BLANC 1 KG. 	1	7802615005516	1	1750	1	1200	\N	\N
3906	ACOND. ELVIVE 200 ML	1	7509552908473	1	1250	1	0	\N	\N
3907	SHAMPOO ELVIVE 200ML	1	7509552910957	1	1250	1	0	\N	\N
3908	SURTIDO DE MARISCO GHOSH 	1	7804610400785	1	1450	1	0	\N	\N
3896	CHORITO NATURAL DUBCHAK 	1	7804655280212	1	2050	1	0	\N	\N
3909	SURTIDO MARISCO GHOSH 425 G	1	7804610400778	1	2000	1	0	\N	\N
2968	PAPEL ALUMINIO  7,5 MTS KITCHEN	73	7809583800020	1	1200	1	0	\N	\N
3912	JABON DOVE  COCONUT 	1	8712561277372	1	1100	1	0	\N	\N
4559	ESPONJA ACERA FALVANIZADO	1	700083653611	1	300	1	0	\N	\N
1352	REPOLLITO GRANDE 	12	628	1	800	1	0	\N	\N
3856	LECHE NATURAL SOPROLE 200ML	1	7802900002268	1	450	1	0	\N	\N
4560	CHOCOLATE BELGA 650G	1	7802926001252	1	7200	1	5500	\N	\N
4538	PAW PATROL 50GR	1	7801552006563	1	500	1	450	\N	\N
4523	TRENDYCHOC 60GR 	1	7801552006068	1	500	1	450	\N	\N
4521	TUCU TUCU 65 GR	1	7801552005993	1	350	1	0	\N	\N
4526	DISCOVER 	1	7801552006334	1	150	1	0	\N	\N
4563	FRUGELE FRAMBUESA 	1	7802705400955	1	300	1	0	\N	\N
4557	HELADO FRUGELE BRESLER	1	7802705400986	1	690	1	0	\N	\N
4567	MAYONESA MAGGI 1KG 	1	7613031551668	1	2500	1	0	\N	\N
4568	AJI CHILENO ATACAMA TRAVERSO 200GR	1	7802337910808	1	1690	1	0	\N	\N
4570	SUAVIZANTE DOÑA GABY 500 ML	73	7804655190573	1	990	1	0	\N	\N
4571	PACK FAMILIAR X3  FRESH UP 90GR	1	6957136585205	1	2390	1	0	\N	\N
4581	SALSA DIP TARTARA 230G	1	7802420003462	1	1100	1	0	\N	\N
4582	SALSA INFIERNO MEDIUM 250G	1	7802351001810	1	1100	1	0	\N	\N
4332	ATUN  LOMITO LIGHT ROBINSON  CRUSOE	1	7804621470814	1	1690	1	0	\N	\N
1793	DOVE GO FRESH 100G	36	8717163410134	1	1100	1	0	\N	\N
4040	ATUN DESM. ACEITE HOMAR 160G 	1	8857122882722	1	900	1	0	\N	\N
4572	CHORITOS EN ACEITE ANGELMO 425 GR 	1	7801250501049	1	2100	1	0	\N	\N
4573	ATUN LOMITOS ROBINSON CRUSOE 160G	1	7804621470821	1	1690	1	0	\N	\N
4574	PICADILLO MARISCOS ANGELMO 190G	1	7801268000558	1	1200	1	0	\N	\N
4575	ATUN DESMENUSADO HOMAR 160G	1	8857122882715	1	900	1	0	\N	\N
4576	CHORITOS EN SALSA PICANTE ANGELMO 190G	1	7801268000398	1	1200	1	0	\N	\N
4577	CHORITOS AHUMADOS ANGELMO 190G 	1	7801250000047	1	1200	1	0	\N	\N
4578	SURTIDO MARISCOS ANGELMO 190G	1	7801268000367	1	1350	1	0	\N	\N
4584	JABON LUX 80G	1	8999999527716	1	500	1	0	\N	\N
41	ATUN DESMENUZADO EN AGUA ANGELMO 170 GRAMOS 	1	7801250000368	1	800	1	0	\N	\N
4579	PEGAMENTO SUPER COBRA 	1	2000000001739	1	300	1	0	\N	\N
4585	DRIVE 400G	1	7805000314903	1	1400	1	0	\N	\N
4586	DETERGENTE LIQUIDO AUSTRAL 3 LTS 	1	7804660170102	1	2800	1	0	\N	\N
4588	DE TODITO 140G	1	7802000015151	1	1000	1	0	\N	\N
274	LADYSOT ULTRAD. T/SUAVE C/ALAS 8UN	2	7790250096078	1	900	1	0	\N	\N
4587	CEREAL FITNESS ORIGINAL 330G 	1	7613035652101	1	2690	1	2300	\N	\N
4564	JAMON PIERNA AHUMADO 	31	318	2	11000	1	9300	\N	\N
4480	LAYS STAX QUESO CHEEDAR 134G	1	7802000013614	1	1700	1	0	\N	\N
4561	AVELLANA EUROPEA 650G	1	7802926001269	1	7200	1	5500	\N	\N
4562	VAINILLA FRANCESA 650G	1	7802926001245	1	7200	1	5500	\N	\N
4589	GOMUTCHO 	1	7891151029438	1	150	1	0	\N	\N
4590	ABRILLANTADOR PISO FLOTANTE EXCELL 900CC	1	7805020001296	1	2990	1	0	\N	\N
4591	SUAVIZANTE FUZOL SENS ENERGY 1.2L	1	7804920006677	1	2500	1	0	\N	\N
3861	BOLSA REUTILIZABLE CHICA 	1	6940404040124	1	500	1	0	\N	\N
4612	SAN FRANCISCO LIGHT BERRY	1	7802926000491	1	4500	1	0	\N	\N
3434	QUESO CABEZA 	31	2500311002406	2	6500	1	0	\N	\N
564	NECTAR LIGHT DURAZNO PET  1,5 LT WATTS	5	7801620000738	1	1350	1	0	\N	\N
136	FIDEO ACONCAGUA SPAGHETTI N° 5 400 GRAMOS 	1	7802575309808	1	500	1	0	\N	\N
4592	CORBATAS ACONCAGUA 400G	1	7802575309846	1	500	1	0	\N	\N
463	ACEITE DEOLIVA CHEF 250CC	1	7802810009494	1	3990	1	0	\N	\N
4593	ARROZ TUCAPEL BLUE BONNET G2	1	7801420950097	1	800	1	0	\N	\N
4595	LECHE CULTIVADA COLUN LIGHT 1 LT 	1	7802920001234	1	1700	1	0	\N	\N
2662	DOVE ORIGINAL 90G	1	7898422746759	1	1100	1	0	\N	\N
4597	CREMA DE COCO GHOSH 400 ML 	1	7804610400853	1	1890	1	0	\N	\N
3764	WATTS MANZANA 1,5 LT	1	7801620001902	1	1350	1	0	\N	\N
4600	SODA LIGHT TRI-PACK 540GR 	1	7802225683654	1	2300	1	0	\N	\N
4601	LONGAVI DAMASCO 110G	1	7804608121678	1	180	1	0	\N	\N
4602	LONGAVI VAINILLA 110G	1	7804608121654	1	180	1	0	\N	\N
4603	LONGAVI MORA 110G	1	7804608121692	1	180	1	0	\N	\N
4604	PRINGLES 124G	1	038000184963	1	1300	1	0	\N	\N
4606	PALO DE ESCOBILLON 	1	2000000001746	1	800	1	0	\N	\N
572	NECTAR DURAZNO WATTS 1,5 LTS	5	7801620011611	1	1350	1	0	\N	\N
4607	TOALLA NOVA BRIGHT XL 	1	614143695223	1	1700	1	0	\N	\N
2425	NECTAR WATTS TUTTIARANDANO 1.75LT.	1	7801620007973	1	1350	1	0	\N	\N
4608	ALKA 	1	78021365	1	300	1	250	\N	\N
4611	SAN FRANCISCO  LIGHT CHOCOLATE NUSS	1	7802926000484	1	4500	1	0	\N	\N
3404	ANTIGRASA WYN 750 ML 	1	7804609730381	1	3350	1	2250	\N	\N
4599	LAVALOZAS VIRGINIA 750 ML 	1	7805040001313	1	1750	1	1500	\N	\N
4598	GRANOLA AVENA MIEL Y ALMENDRAS QUAKER 342G	1	7802000015038	1	2600	1	2200	\N	\N
4596	AVENA INST. QUAKER 450G	1	7802000014949	1	1400	1	0	\N	\N
4614	PAPEL HIGIENICO BRIGHT 300MT 	1	614143695247	1	1700	1	0	\N	\N
4615	CREMA LIMPIADORA DOÑA GABY	1	7804655191495	1	1890	1	0	\N	\N
4610	SAN FRANCISCO LIMON	1	7802926000248	1	2950	1	0	\N	\N
4609	SAN FRANCIDCO GUAYABA	1	7802926000910	1	2950	1	0	\N	\N
4647	NOVA CLASICA MEGA ROLLO 30 MTS 	1	7806500406471	1	1550	1	0	\N	\N
4507	DETERGENTE MASTER MATIC 3 LTS. 	1	945127007	1	3200	1	0	\N	\N
318	PALMITOS EN RODAJAS WASIL 400 GRAMOS 	1	7801305001883	1	1800	1	0	\N	\N
4613	ANDINA DURAZNO 1.75	1	7802820175035	1	1400	1	0	\N	\N
4594	ACETO BALSAMICO 250 ML 	1	7808725800140	1	2990	1	0	\N	\N
3910	BOLSA BASURA IMPEKE 70X90CM 	1	7806810800761	1	1050	1	0	\N	\N
4620	PALMITOS MERKAT 400 GR	1	7861160801400	1	1700	1	0	\N	\N
4621	CARNE PICADA PF 250 GR 	1	7801930018591	1	1300	1	0	\N	\N
4622	POWER ADE 	1	7802820701012	1	850	1	0	\N	\N
4623	CARNE MOLIDA MONTINA 	1	7804115844671	1	1000	1	0	\N	\N
4624	LOLY CHOC 73 GR 	1	7802705400979	1	690	1	0	\N	\N
4625	SALSA TARTARA  DON JUAN 250 GRS 	1	7802351633301	1	1400	1	0	\N	\N
4626	SALSA JALAPEÑO INFERNO 250GR	1	7802351001803	1	1500	1	0	\N	\N
4627	CHOCOCHIPS SANTIAGO 700GR 	1	7802264060027	1	2400	1	0	\N	\N
4628	ESPONJA DORADA BRIGHT 	1	700083653567	1	650	1	0	\N	\N
4632	HELADO DE AGUA PIÑA SAN FRANCISCO 750 GR	1	7802926000446	1	2950	1	0	\N	\N
4633	ALCAPARRAS EDRA 110GR	1	7802420005220	1	1800	1	0	\N	\N
4634	VIVO VEGGIE 	1	7802200267152	1	200	1	0	\N	\N
4635	VIENNETTA RON 554G	1	7802705619463	1	2990	1	0	\N	\N
4637	NUGGETS DE POLLO MONTINA 1KG	1	7801965001162	1	5990	1	0	\N	\N
4639	LECHE NIDO BUEN DIA 700GR	1	7613039961902	1	4700	1	0	\N	\N
4640	PAPAS PREFRITAS PF 500G	1	7801930016474	1	1000	1	0	\N	\N
4642	SAN FRANCISCO FRAMBUESA	1	7802926000040	1	2890	1	0	\N	\N
4638	CRUNCHIS QUESO 280 GRS	1	7802420151439	1	1700	1	1500	\N	\N
4630	SAN FRASCISCO BROWNIE 	1	7802926001085	1	6300	1	4500	\N	\N
4636	MAGNUM CHOCOLATE NUSS 552G	1	7805000318062	1	4990	1	4490	\N	\N
4641	NUGGETS MONTINA 	1	7801965001445	1	2200	1	2000	\N	\N
4644	ALOE VERA MANGO 500 ML 	1	7804643820413	1	1700	1	0	\N	\N
4645	ALOE VERA ORIGINAL 500 ML 	1	7804643820383	1	1700	1	0	\N	\N
4646	ALOE VERA GRANADA 500 ML 	1	7804643820406	1	1700	1	0	\N	\N
4648	DORITOS 320GR	1	7802000012372	1	1900	1	0	\N	\N
4649	CARGADOR HOCO TYPE C 	1	6931474709103	1	7000	1	0	\N	\N
4508	YOGURTH SOPROLE FRUTILLA 165G	1	7802900300029	1	400	1	0	\N	\N
4650	WHISKAS CARNE 85G	1	7896029046609	1	650	1	0	\N	\N
4655	PALETA CHOCOLATE NUSS SAN FRANCISCO 80G	1	7802926001405	1	1500	1	0	\N	\N
4656	PALETA FRAMBUESAS A LA CREMA SAN FRANCISCO 80G	1	7802926001429	1	1500	1	0	\N	\N
1711	COMINO MOLIDO15G 	1	7802420810114	1	250	1	0	\N	\N
4657	PALETA CHOCOLATE FRAMBRUESAS SAN FRANCISCO 80G	1	7802926001412	1	1500	1	0	\N	\N
4659	YERBA MATE YARI SWEET LIMON 475CC	1	7804655320000	1	1700	1	0	\N	\N
4660	YERBA MATE YARI POMELO PUNCH 275CC	1	7804655320055	1	1700	1	0	\N	\N
4661	YERBA MATE YARI PASSIONATE RASPBERRY 455CC	1	7804655320017	1	1700	1	0	\N	\N
4662	YERBA MATE YARI STRAWBER LEMON	1	7804655320024	1	1700	1	0	\N	\N
4663	SALSA DE TOMATE A LA ALBAHACA LUCCHETTI 200G	1	7802500037134	1	400	1	0	\N	\N
4665	BABY SEC FRESH 45 UN. 	1	7806500731214	1	1000	1	0	\N	\N
4667	AQUAFRESH 125 ML 	1	7800029001841	1	1900	1	0	\N	\N
4668	GUANTES DOÑA GABY 	1	7804655191167	1	1700	1	0	\N	\N
4669	GUANTES DOÑA GABY 	1	7804655191143	1	1700	1	0	\N	\N
4670	GUANTES 	1	7804655191150	1	1700	1	0	\N	\N
4671	CEPILLO DENTAL ORAL B	73	3014260833176	1	1000	1	0	\N	\N
4680	CEREAL OREO+YOGHURT 140 GR	1	7802900280079	1	550	1	0	\N	\N
2522	CEPILLO DE DIENTES CORONA	1	7707202223680	1	1000	1	0	\N	\N
4672	CEPILLO DENTAL INFANTIL 	1	6926833002117	1	1000	1	0	\N	\N
4673	COLADO ZAPALLITO ITALIANO Y CARNE 215G	1	7613033189845	1	1990	1	0	\N	\N
4674	MARUCHAN CARNE 64 GRS	1	041789001925	1	850	1	0	\N	\N
4676	SAL DE MAR FINA OCEANICA 500G	1	7755019000253	1	1000	1	0	\N	\N
4677	SUCEDANEO LIMON DE PICA TRAVERSO 500ML	1	7802356296198	1	1300	1	0	\N	\N
4664	GUALLARAUCO FRUTILLA NARANJA 0 AZUCAR 	1	7803908006418	1	500	1	500	\N	\N
4678	GALLETA SAL DEL MAR CRACKELET  70 GR COSTA	1	7802215501531	1	600	1	0	\N	\N
4679	MORF XS	1	7802225280815	1	1550	1	0	\N	\N
4681	PATE DE CAMPO LA PREFERIDA 125G	1	7801916035260	1	650	1	0	\N	\N
4682	PATE DE JAMON LA PREFERIDA 125G	1	7801916000176	1	650	1	0	\N	\N
4683	AZUCAR IANSA 1.1 KILO	1	7801505001034	1	1300	1	0	\N	\N
4684	SALSA DE TOMATES BOLOGNESA MALLOA 200G	1	7805000302252	1	380	1	0	\N	\N
4540	CHICLE SUPER ACIDO	1	6920311061399	1	200	1	0	\N	\N
4541	MABU EXPLOTA X4	1	6965111223110	1	300	1	0	\N	\N
4666	COLGATE TRIPLE ACCION 100 ML 	1	7509546000343	1	2100	1	0	\N	\N
4691	ORBIT BUBBLEMINT 10 UNI	1	42247371	1	550	1	0	\N	\N
4716	CARACOLES LUCCHETTI 400G	1	7802500184364	1	1300	1	800	\N	\N
4717	CABELLOS DE ANGEL ACONCAGUA 400G	1	7802575300416	1	500	1	0	\N	\N
4692	CHAMPIÑON LAMINADO ANGELMO 400 G 	1	7801268002095	1	1350	1	0	\N	\N
4693	CHAMPIÑON ENTERO ANGELMO 400G	1	7801268002071	1	1350	1	0	\N	\N
4694	CHORITOS AL NATURAL MAR CHILENO 	1	7804709995031	1	1500	1	0	\N	\N
4695	CABALLA COLORADO AL NATURAL 425G 	1	7801255000134	1	1400	1	0	\N	\N
4696	PALMITOS ENTEROS GHOSH 400G	1	7804610400129	1	1800	1	0	\N	\N
4697	GLITT 50X70	1	7804673690017	1	600	1	0	\N	\N
4698	BOLSA BASURA GLITT 70X90	1	7804673690024	1	950	1	0	\N	\N
4699	BOLSA BASURA GLITT 80X110	1	7804673690031	1	1500	1	0	\N	\N
4700	BOLSA BASURA GLITT 80X120	1	7804673690048	1	1800	1	0	\N	\N
4701	DIANA NOCTURNA 	1	8690879300053	1	750	1	0	\N	\N
4702	FEEL CLEAN DESMAQUILLANTE 	1	7898936110800	1	1350	1	0	\N	\N
4703	DIANA ULTRA 	1	8690879300039	1	700	1	0	\N	\N
4704	ESPONJA LISA MANLAC PACK 4 UND 	1	7806800005176	1	800	1	0	\N	\N
4705	CASATA TRENDY 1L	1	7801552004095	1	2090	1	0	\N	\N
4706	COLA CAO PILLOEWS  440G 	1	7802635691218	1	3990	1	0	\N	\N
4707	PIÑA	1	7803908006425	1	500	1	0	\N	\N
4708	AZUCAR FLOR MERKAT 1KG	1	7801505003168	1	1400	1	0	\N	\N
4709	HOJUELAS+BERRIES VIVO LINE 320G	1	7800120169235	1	2600	1	0	\N	\N
4690	GLADE 500CM	1	7790520991867	1	1200	1	900	\N	\N
4710	ALKA EUCALIPTUS	1	7802225412261	1	300	1	0	\N	\N
4711	MONO CHOC	1	7800120166777	1	1900	1	0	\N	\N
4712	CREMONA COCO 140G	1	7802408005389	1	450	1	0	\N	\N
4714	CALO	1	7802910006324	1	2500	1	0	\N	\N
4718	HELADO FRAC 70ML BRESLER	1	7802705401105	1	690	1	0	\N	\N
4719	PAN BLANCO 560 GR IDEAL	24	7803403002229	1	2200	1	0	\N	\N
4720	TE SUPREMO 200G	1	7801875047137	1	3590	1	0	\N	\N
4724	HELADO PALETA MARACUYA SAN FRANCISCO	1	7802926001443	1	1000	1	0	\N	\N
3176	BABYLAND 150 CPS	1	7804945005594	1	1500	1	0	\N	\N
374	SHAMPOO FRUCTIS OIL REPAIR LISO COCO 350 ML 	2	7509552816242	1	2500	1	0	\N	\N
4734	ATUN DESMENUZADO EL PESCADOR 104 GR 	1	7804660690334	1	800	1	0	\N	\N
4735	ATUN DESMENUZADO EL PESCADOR 104G 	1	7804660690341	1	800	1	0	\N	\N
4736	ATUN EN LOMITO LA SIRENA 120G 	1	028571000908	1	1330	1	0	\N	\N
2066	KENT BELMONT BLUE 20	55	78020627	1	4000	1	0	\N	\N
4737	ATUN DESMENUZADO DOÑA LUPE 120G	1	7804643510192	1	750	1	0	\N	\N
4738	STEVIA EN LINEA 180 ML 	1	7804000002247	1	1990	1	0	\N	\N
4631	TANAX CASA Y JARDIN 220CC	1	7805300049161	1	2500	1	0	\N	\N
4739	SPRAY DESINFECTANTE BRIGHT 450ML	1	781159480751	1	2200	1	0	\N	\N
3283	BAYGON MATA MOSCAS/MOSQUITOS 360CC	73	7840784000239	1	3100	1	0	\N	\N
4725	PAPEL ALUMINIO BRIGHT 6 MTS	1	3894143695165	1	1350	1	0	\N	\N
4727	DESODORANTE BIOMEN 150ML 	1	7509552913675	1	2500	1	0	\N	\N
4728	DESODORANTE BIOMEN 150 ML 	1	7506078948099	1	2500	1	0	\N	\N
4729	DESODORANTE BIOMEN 150 ML 	1	7506078971998	1	2500	1	0	\N	\N
4730	COCO RALLADO 100G	1	7802420810220	1	650	1	0	\N	\N
4731	MANTEQUILLA MIX CALO 350G 	1	7802810011237	1	1600	1	0	\N	\N
4732	CERA DEPILATORIA MILLEFIORI 100 GR	1	7804923060522	1	2100	1	0	\N	\N
4733	CERA DEPILATORIA MILLEFIORI 100 G 	1	7804923060508	1	2100	1	0	\N	\N
2365	LUCKY STRIKE 20	1	78024878	1	4600	1	4400	\N	\N
4658	KENT CLICK UP 	55	78025295	1	4600	1	4400	\N	\N
4713	GALLETA CRACKELET  85 GRS COSTA	1	7802215511011	1	600	1	0	\N	\N
4740	MANJAR COLUN 250G 	1	7802920221434	1	900	1	0	\N	\N
4741	MANJAR COLUN RECETA DE CAMPO 1 KG 	1	7802920005928	1	3200	1	0	\N	\N
4742	ARROZ SAN JOSE GRADO 2 1KG 	1	7801235000499	1	1650	1	1400	\N	\N
4569	SALSA AJI CAPITAL TRAVERSO 200GR 	1	7802337910815	1	1690	1	0	\N	\N
4580	MOSTAZA TIPO DIJON 240G	1	7802420003554	1	1100	1	0	\N	\N
829	VIRUTILLA GRSA MANLAC 4 MEDIANA	2	7806800001031	1	550	1	0	\N	\N
4744	PIÑAS CUBITOS  565 GR WASIL	1	7801305001517	1	1600	1	0	\N	\N
232	JUGO LIVEAN DURAZNO 7 GRAMOS 	1	7802800576449	1	200	1	0	\N	\N
2361	ADES PIÑA 200ML	1	7790895643712	1	400	1	0	\N	\N
4746	SAL SIRENA 1 KG 	1	7803600981587	1	350	1	0	\N	\N
4747	YERBA MATE MAPUCHE 1 KG 	1	7801840000129	1	6400	1	0	\N	\N
4748	LECHE CALO DESCREMADA 1 KG	1	7802910002906	1	5550	1	0	\N	\N
4756	FILM PLASTICO BRIGHT 15 MTS	1	3894143695189	1	1300	1	0	\N	\N
4757	PIÑA EN RODAJA BONADOOF 850G	1	7801434001785	1	2400	1	0	\N	\N
4758	LAVALOZAS KLIN 500 ML 	1	7804660170140	1	1100	1	0	\N	\N
4759	VELAS SIGNO INTERROGACIN 	1	7805670702901	1	450	1	0	\N	\N
4760	VELAS CUMPLEAÑOS 12 UN	1	7805670702833	1	650	1	0	\N	\N
4761	SALSA MAGICA CHOCOLATE AMBROSOLI 215G	1	7802200183018	1	2590	1	0	\N	\N
4763	COMINO MOLIDO 15G 	1	7802420004735	1	300	1	0	\N	\N
4764	BICARBONATO 30	1	7802420004667	1	300	1	0	\N	\N
4767	DE TODITO DULCE 290G	1	7802000015205	1	2400	1	0	\N	\N
4768	REDBULL 473CC	54	9002490238841	1	2200	1	0	\N	\N
4769	PRINGLES SOUR CREAM AND ONION 158G	1	038000138430	1	1990	1	0	\N	\N
4770	CREMONA FRUTILLA FRUNA 14G	1	7802408005396	1	450	1	0	\N	\N
4771	POSTRE HELADO SAN FRANCISCO PIE DE LIMON 1L	1	7802926000156	1	4500	1	0	\N	\N
4772	ARROLLADO PRODUCTO CONGELADO 10U	1	7604229110101	1	2500	1	0	\N	\N
4765	VINAGRE DE VINO TINTO DON JUAN 500ML	1	7802351524807	1	1000	1	0	\N	\N
4762	PIMIENTA MOLIDA 15G	1	7802420004964	1	450	1	0	\N	\N
4755	TRAPERO BRIGHT ALGODON CON OJAL 50X70CM	1	614143695131	1	1300	1	0	\N	\N
4773	TODDY 142.5	1	7500478008780	1	950	1	0	\N	\N
4775	GALLETAS SIN GLUTEN 150G	1	7803520001921	1	2300	1	0	\N	\N
4743	ARROZ BANQUETE PREG. GRADO 1	1	7803110102250	1	1700	1	0	\N	\N
4776	GALLETAS SIN GLUTEN 150G	1	7803520002249	1	2300	1	0	\N	\N
4777	GALLETAS SIN GLUTEN 150G	1	7803520002232	1	2300	1	0	\N	\N
4778	PAN INTEGRAL 580G	1	7803403002243	1	2100	1	0	\N	\N
4779	ADULTO CARNE 100G	1	7802575531759	1	650	1	0	\N	\N
2	NUGGET NEGRO 65 G 	1	7702626302966	1	950	1	0	\N	\N
4780	CACHORROS CARNE 85G	1	7802575532664	1	650	1	0	\N	\N
4781	ADULTO POLLO 100G	1	7802575531728	1	650	1	0	\N	\N
4782	GATITOS CARNE LECHE 85G	1	7802575532640	1	650	1	0	\N	\N
4785	TRENTO 	1	7896306612817	1	400	1	0	\N	\N
4790	CHERRIES IN LIQUEUR 150G 	1	9002859037863	1	3690	1	0	\N	\N
4791	BISCUIT ASSORTEMENT 200G 	1	9002859078576	1	2990	1	0	\N	\N
4793	GRAZIOSO ESPRESSO 100GR 	1	9002859037221	1	2000	1	0	\N	\N
4794	GRAZIOSO MILCHSCHOKOLADEN 98 GR 	1	9002859106378	1	2000	1	0	\N	\N
2501	CHOC. HEIDI DARK ORANGE 80G	1	5941021001254	1	2200	1	0	\N	\N
4809	VITAMIN WATER	1	7790895001260	1	1000	1	0	\N	\N
2503	CHOC. HEIDI DARK INTENSE 80G 	1	5941021001261	1	2650	1	2200	\N	\N
4810	VITAMIN WATER	1	7790895001208	1	1000	1	0	\N	\N
2502	CHOC. HEIDI DARK EXTREME  85 COCOA	1	5941021001674	1	2650	1	2200	\N	\N
2500	CHOC. HEIDI DARK PISTACHO 80G 	1	5941021007577	1	2650	1	2200	\N	\N
4795	ALOE VERA 	1	8809041429564	1	1000	1	0	\N	\N
4796	TRENTO 22G	1	7896306621192	1	400	1	0	\N	\N
4797	SOPA POLLO SEMOLA 68 GR	1	7802950008814	1	450	1	0	\N	\N
4798	BASE HAMBURGUESAS  90 GR MAGGI	1	7802950006575	1	690	1	0	\N	\N
4799	CREMA POLLO  72 GR MAGGI	1	7802950006766	1	500	1	0	\N	\N
4800	BASE ESCALOPA MAGGI 90G	1	7802950004458	1	690	1	0	\N	\N
4811	ALOE 	1	7803908006043	1	1000	1	0	\N	\N
4808	GRANOLA AVENA MIEL Y PASAS QKUAKER 342G 	1	7802000015045	1	2200	1	0	\N	\N
4774	GALLETAS SIN GLUTEN 150G	1	7803520001938	1	2590	1	2300	\N	\N
165	GALLETAS COCO 125 G 	6	7802215505409	1	650	1	0	\N	\N
4792	BRANDY BEANS 200 GR 	1	9002859037542	1	3990	1	0	\N	\N
4801	MARUCHAN RAMEN SABOR CAMARON 85G	1	041789002977	1	700	1	0	\N	\N
4802	POSTRE CREMA MANJAR COCO AMBROSOLI 100G	1	7802575271143	1	800	1	0	\N	\N
2313	SOPROLE LIGHT CHIA ARANDANO 155G	1	7802900000967	1	450	1	0	\N	\N
4803	POSTRE DE SEMOLA AMBROSOLI 150G	1	7802575241047	1	800	1	0	\N	\N
4804	GELATINA LIVEAN NARANJA 0 AZUCAR 20G	1	7802800567010	1	700	1	0	\N	\N
4616	POWER ADE LIMA LIMON ZERO 1LT	1	7802820672121	1	1000	1	0	\N	\N
4617	POWERADE ZERO LIMA LIMON  600ML	75	7802820669961	1	850	1	0	\N	\N
4618	PERNIL COCIDO CHILLAN 	31	319	2	7900	1	0	\N	\N
4805	PIMENTON MOLIDO EDRA 15G	1	7802420005305	1	230	1	0	\N	\N
4806	POSTRE SAN FRANCISCO PREMIUM TRES LECHES 1L	1	7802926001276	1	5500	1	0	\N	\N
4807	ESPONJA MANLAC 3U	1	7806800005251	1	650	1	0	\N	\N
4813	LECHE NIDO ETAPA +1 360G	1	7613032476700	1	3250	1	0	\N	\N
4814	ELITE 50 MTS 8 ROLLOS 	1	7806500509752	1	4900	1	0	\N	\N
4815	DETERGENTE DIELLI MATIC 5 LTS	1	7804920005311	1	3200	1	0	\N	\N
4817	CABALLA FILETES ACEITE SAN REMO 	1	6924944824192	1	1500	1	0	\N	\N
4818	ATUN OTUNA LOMITO ACEITE 	1	7801230004249	1	1400	1	0	\N	\N
4821	ESPRESSO COCA COLA CON CAFE 235ML	1	7801610235102	1	700	1	0	\N	\N
4822	MAXI ROLLO EDXO ELITE 1 ROLLO 	1	7806500404354	1	1550	1	0	\N	\N
4823	PAÑALES BABYSEC CLASSIC PLUS G	1	7806500733669	1	3500	1	0	\N	\N
4824	SEVEN UP 500ML	1	7801620855215	1	900	1	0	\N	\N
4825	ACEITE DE OLIVA SANTE 250 ML 	1	7804610401553	1	2990	1	0	\N	\N
4840	MERKEN MOLIDO 	1	7802420004834	1	250	1	0	\N	\N
4784	TORTILLA PANCHO VILLA XL	1	7802095180123	1	1700	1	0	\N	\N
4826	PACK BIGTIME MENTA 55G	1	7802225150705	1	1000	1	0	\N	\N
4828	AZUCAR MERKAT 1K	1	7804608220999	1	900	1	0	\N	\N
4841	POLLO A LA PLANCHA 80 GR	1	7801930009612	1	500	1	0	\N	\N
4812	ADES SOJA MAS JUGO NARANJA 1 LT	1	7790895643842	1	3300	1	0	\N	\N
4816	LUCUMA MANJAR 	1	7803908001406	1	900	1	0	\N	\N
1316	PAN MOLDE MULTIGRANO FUCHS 380 GR	24	7803480001078	1	2400	1	1500	\N	\N
4675	TE LIPTON YELLOW LABEL 200G	1	87801810712676	1	3490	1	0	\N	\N
2303	BABY WIPES 72 UN 	1	8690879919163	1	1200	1	0	\N	\N
3913	AVENA INST.500 GR VIVO	1	7800120169952	1	1300	1	0	\N	\N
259	JUGO ZUKO MELONTUNA 25 GRAMOS 	1	7802800578894	1	200	1	0	\N	\N
4831	TE ECOLOGIC FRUTOS DEL BOSQUE 	1	8435336282820	1	3000	1	0	\N	\N
4832	TE ECOLOGIC TE VERDE	1	8435336282806	1	3000	1	0	\N	\N
4834	SOPROLE 165G	1	7802900300302	1	400	1	0	\N	\N
4835	PAN INTEGRAL BADUCCO 400G	1	7891962056753	1	1700	1	0	\N	\N
4836	PAN BLANCO BAUUCCO 400G	1	7891962056746	1	1700	1	0	\N	\N
4847	GRINS LAVANDA 	1	8010690023953	1	600	1	0	\N	\N
4838	BOLSA DE ASEO AZERO 80X110 CM X 10 UN	1	7801875069160	1	1600	1	0	\N	\N
4839	BROWNIE NUECES 68G	1	7803480000750	1	400	1	0	\N	\N
4843	JABON WOMEN 150G	1	8680972088811	1	1000	1	0	\N	\N
4844	JABON MANZANILLA ALOEVERA 150G	1	8680972088798	1	1000	1	0	\N	\N
4845	ESPONJA CLOROX 	1	7702137005516	1	350	1	0	\N	\N
4846	TANAX MATA TODO INSECTO 440CC 	1	7805300049604	1	3150	1	0	\N	\N
4848	GRINS AROMA LIMON 	1	8010690096261	1	650	1	0	\N	\N
4849	GRINS AROMA VAINILLA 	1	8010690023984	1	600	1	0	\N	\N
1297	YOGU YOGU DAMASCO 200 ML	21	7802910300200	1	450	1	0	\N	\N
2818	LECHE CHOC. PROTEIN+ 200 ML SOPROLE	1	7802900001520	1	450	1	0	\N	\N
4856	PAÑO ABSORBENTE MANLAC 	1	7806800005367	1	700	1	0	\N	\N
4857	PAÑO ABSORBENTE SAPOLIO 	1	7751851028271	1	600	1	0	\N	\N
4858	FRESH UP 90 G	1	6922961996502	1	800	1	0	\N	\N
4861	BOLSA BASURA GLITT 50X55	1	7804673690000	1	550	1	0	\N	\N
4862	AVENA Y PASAS NUTRA BIEN 50G	1	7803525999063	1	500	1	450	\N	\N
4842	LECHE COLUN DESC. 100G 	1	7802920003184	1	850	1	0	\N	\N
4830	GALLETA SURTIDA 350G SANTIAGO	1	7802264020700	1	1390	1	1250	\N	\N
4860	DE TODITO SABOR QUESO 50G	1	7802000015137	1	600	1	0	\N	\N
4833	HELADO FRAC 	1	7802705401099	1	750	1	690	\N	\N
4850	CASATA  SAVORY 	1	7613287221629	1	2800	1	2500	\N	\N
4859	SOFRITO 200G	1	7804115001821	1	600	1	550	\N	\N
4863	FOSFOROS ANDES HOGAR 250 UN. 	1	7806300010144	1	1500	1	0	\N	\N
4864	JABON GRANADA -BALLERINA350ML	1	7804920003171	1	900	1	0	\N	\N
4866	AZUCAR RUBIA BONANZA 500GR	1	7808743605277	1	1100	1	0	\N	\N
4868	TOCINO AHUMADO SOLER 100GR	1	7801927000301	1	2000	1	0	\N	\N
4870	KIT CHARGER MKICRO USB	1	6927900078974	1	7000	1	0	\N	\N
4652	MASTER CAT ATUN 85 G	1	7802575531742	1	650	1	0	\N	\N
4869	KIT CHARGER TYP C	1	6927900079001	1	7000	1	0	\N	\N
4872	LENTEJAS G 2 DREYES	1	7804609020154	1	1700	1	0	\N	\N
4873	FREJOL BLONCO 1KG	1	7803910000169	1	2500	1	0	\N	\N
4889	ESCOBILLA PLASTICA	1	8424559051412	1	1250	1	0	\N	\N
441	QUESO REGGIANITO COLUN RALLADO 40G	1	7802920423609	1	800	1	0	\N	\N
4875	CIF CREMA LIMON 750 G	1	7791290790520	1	2250	1	0	\N	\N
4876	TOALLA HUMEDA HUGGIES 48 UN. 	1	7794626996672	1	1800	1	1550	\N	\N
4877	LUSTRA MUEBLES VIRGINIA 360 CM 	1	7805040000644	1	2250	1	0	\N	\N
4878	LUSTRA MUEBLES VIRGINIA 360 CM 	1	7805040002167	1	2250	1	0	\N	\N
4879	TRENCITO BALLS 15G	1	7613037471311	1	1700	1	0	\N	\N
5491	CONEIRO TRENDY 70G	1	7801552006389	1	900	1	0	\N	\N
4880	ANTIGRASA NARANJA GRINS 500 ML 	1	8010690093147	1	1700	1	0	\N	\N
4882	DAILY 400ML	1	7809558101107	1	2100	1	0	\N	\N
4883	AZUCAR EXTRA FINA  500 GRS DELICADA	1	7804520022138	1	800	1	0	\N	\N
4884	FUSILLI INTEGRAL 400G	1	7802575015617	1	900	1	0	\N	\N
4885	SPAGHETTI INTEGRAL 400G	1	7802575015600	1	1390	1	900	\N	\N
4886	FINO SELECCION ORGANICO 100G	1	7613036501507	1	6490	1	0	\N	\N
4891	PASTA DE ZAPATO CAFE SAPOLIO	1	7751851028691	1	990	1	0	\N	\N
4892	TALLIANI 400G	1	7802500007038	1	990	1	0	\N	\N
4871	YERBA MATE VERDE FLOR 250 G	1	7793670000021	1	1490	1	0	\N	\N
4893	NECTAR LIVEAN FRUTILLA 200 ML 	1	7802800544356	1	350	1	0	\N	\N
1610	BIG BANG 80ML SAVORY 	6	7613037637731	1	600	1	0	\N	\N
728	NESCAFE DOLCA 170 GR	1	7802950002171	1	4100	1	0	\N	\N
4887	FINA CELECCION COLOMBIA 100G	1	7613037071368	1	7300	1	6700	\N	\N
4881	SAL PARRILLERA S.CEBOLLA 290G	1	7803600001841	1	2650	1	0	\N	\N
1521	BOLSA DE DULCE 16X27 CONEJO ROSA	34	5606858321424	1	1200	1	0	\N	\N
2164	PATE CAMPO R. DEL ABUELO  125 GR PF	33	7801930008219	1	700	1	0	\N	\N
4899	ALIÑO COMPLETO 15 G	1	7802420004636	1	300	1	0	\N	\N
4900	FRANELA AMARILLA MANLAC 	1	7806800007132	1	500	1	0	\N	\N
4901	CHELE NIDO ENTERA 1500G	1	7613039961797	1	12500	1	0	\N	\N
4890	ESCOBILLA CALZADO	1	11672	1	1300	1	0	\N	\N
4905	CEREAL MILO 230G	1	7613287193896	1	1400	1	0	\N	\N
4908	PALAS BRIGHT	1	606110015080	1	1300	1	0	\N	\N
4909	HUEVO CONEJO BON O BON 50G	1	77940810	1	1150	1	0	\N	\N
4910	CONEJO BON O BON 110 GR 	1	77941145	1	1990	1	0	\N	\N
4911	HUEVO SAPITO CHOCOLATE 107 GR 	1	7802225572576	1	1990	1	0	\N	\N
4912	HUEVO SAPITO FRUTILLA 107 G	1	7802225572712	1	1990	1	0	\N	\N
4913	HUEVO BON O BON 55 GR 	1	7790580587901	1	1900	1	0	\N	\N
4914	HUEVO BON O BON BLANCO 55G 	1	7790580588007	1	1900	1	0	\N	\N
4915	HUEVO BON O BON 110GR 	1	7790580587802	1	3400	1	0	\N	\N
4916	HUEVI CHUBI 110 GR 	1	7790580412449	1	2600	1	0	\N	\N
4917	PURA FRUTA SAVIORY FRAMBUESA	1	7613037777659	1	1000	1	0	\N	\N
4918	PAÑALES BABYSEC XG 16U	1	7806500733676	1	3500	1	0	\N	\N
4919	PAÑALES BABYSEC XXG 16U	1	7806500733683	1	3500	1	0	\N	\N
4923	CHAMPIÑONES LAMINADOS 114 G 	1	7801268002101	1	800	1	0	\N	\N
4924	JABONES DOVE 100G 	1	8711600804357	1	1200	1	0	\N	\N
4926	LIMPIAPISOS EXCELL PRIMAVERA 900 CC	1	7805020311043	1	1100	1	0	\N	\N
4902	LECHE NIDO ETAPA 3	1	7613031769582	1	17500	1	14700	\N	\N
4904	LECHE NIDO ETAPA 1	1	7613031768592	1	17500	1	14800	\N	\N
4653	SALCHICHA SUREÑA SAN JORGE 20 UN	1	7801907001557	1	3450	1	2500	\N	\N
4907	TRIX 220G	1	7613287193834	1	1400	1	0	\N	\N
4906	CHOCAPIC 230G	1	7613287193803	1	1400	1	0	\N	\N
4921	GALLETA CHAMPAÑA GULLON 200G	1	8410376035407	1	1650	1	1350	\N	\N
4925	SOPA INSTANTANEA VITELLI 65G 	1	6959237325865	1	1050	1	600	\N	\N
4922	TODDY CLASICA 380G	1	7500478011711	1	2000	1	0	\N	\N
4619	GAGLEY BI-PACK	1	7802225690225	1	2000	1	0	\N	\N
4927	LIMPIAPISOS EXCELL CITRICO 900 CC	1	7805020311029	1	1100	1	0	\N	\N
4928	LIMPIAPISOS EXCELL LAVANDA 900 CC 	1	7805020311012	1	1100	1	0	\N	\N
4929	POETT SOLO PARA TI 250 ML	73	7805025694769	1	620	1	0	\N	\N
4930	EUROFOIL  7.5 MTS 	1	7805005040104	1	1500	1	0	\N	\N
4931	SALSA DE SOYA GHOSH 150 ML 	1	7804610400990	1	900	1	0	\N	\N
4685	ATUN LOMITO EN ACEITE SAN JOSE 160G	1	7801235001885	1	1300	1	0	\N	\N
4686	QUEQUE VAINILLA IDEAL 200G	1	7793890252095	1	1000	1	0	\N	\N
4687	RENOVADOR NEUMATCIOS 	1	7808304316031	1	3490	1	0	\N	\N
4936	BON BON BASE MANI 290G	1	7790580108489	1	2790	1	0	\N	\N
4937	HUEVITOS 50 UNIDAD	1	6933626118429	1	3490	1	0	\N	\N
4939	KETCHUP JB 240G 	1	7802640400355	1	1400	1	0	\N	\N
4940	AZERO 70X90 MEDIANO	1	7801875069245	1	1000	1	0	\N	\N
4941	PROBIOTICOS MANZANA CALAN 90ML	1	7802955008819	1	350	1	0	\N	\N
4960	MIEL PURA DE ABEJA TOCOMIEL 1/2 KG	1	2000000001760	1	3100	1	0	\N	\N
4944	MUIBON COCO 13 G 	1	7802800556199	1	200	1	0	\N	\N
4947	HARINA MONT BLANC 5KG	1	7802615005653	1	5200	1	0	\N	\N
4948	YERBA MATE AMANDA 500G	1	7792710002179	1	4500	1	0	\N	\N
4949	ZANAHORIA ROMA 90G	1	7896466220303	1	1700	1	0	\N	\N
4950	FRUTYS 20U	1	6957342992965	1	300	1	0	\N	\N
4951	CONEJO CAREZZA	1	7802215116544	1	1100	1	0	\N	\N
2138	BOLSAS REUTILIZABLES MEDIANA	1	2122	1	850	1	0	\N	\N
4952	HUEVITOS MACIZOS 50 U	1	7802215110689	1	5200	1	0	\N	\N
4953	LAVALOZAS VIRUTEX 500ML	1	7806810020978	1	1400	1	0	\N	\N
4955	MASCARILLAS DESECHABLES 	1	6973316900019	1	900	1	0	\N	\N
1841	ALMENDRAS 50G CAMILA 	6	7804623100351	1	900	1	0	\N	\N
843	GALLETA AGUA LIGHT SELZ 600GR	6	7802225689519	1	2000	1	0	\N	\N
4651	WHISKAS ATUN 85 G 	1	7896029046562	1	650	1	0	\N	\N
4942	PAPEL HIGIENICO NOBLE 4ROLLOS 23M	1	7806500508779	1	1000	1	0	\N	\N
4946	PAPAS KRYZPO QUESO 260G	1	7802800534128	1	2700	1	0	\N	\N
4938	POSTRE TRISABOR  1 LT TRENDY BONGELATA	62	7801552000189	3	2790	1	2690	\N	\N
4956	TE CLUB CEYLAN PREMIUM 100 UNDS	1	7805000311605	1	3500	1	2600	\N	\N
4961	MIEL PURA DE ABEJA TOCO MIEL 1/4 KG	1	2000000001777	1	2000	1	0	\N	\N
4958	PACK SALSA TOMATE DOÑA CLARA 6UN	1	7805000306885	1	0	1	0	\N	\N
4959	MIEL PURA DE ABEJA TOCOMIEL 1 KG	1	2000000001753	1	5600	1	0	\N	\N
4688	ALOE ORIGINAL 1.5L	1	8809041429441	1	2500	1	0	\N	\N
4962	PROTEIN CHOCOLATE 45G	1	798190137544	1	1050	1	0	\N	\N
4963	PROTEIN COCO 45G	1	798190137551	1	1050	1	0	\N	\N
4965	SALMAS 8 PAQUETES DE 3 GALLETAS 144GR	1	658480001101	1	1750	1	0	\N	\N
4972	LENTEJAS 6 MM HOMAR 1KG	1	7804645050443	1	2200	1	0	\N	\N
4973	JUREL HOMAR 425 G 	1	7804645050474	1	1550	1	0	\N	\N
4975	JABON LIQUIDO YOGHURT Y BERRIES   1000 ML BALLERINA	73	7804920002761	1	1400	1	0	\N	\N
4976	JABON CREMA PIEL SENSIBLE 1 LT 	1	7804920005724	1	1600	1	0	\N	\N
4977	JABON CREMA ACEITE DE KARITE 1 LT	1	7804920005731	1	1600	1	0	\N	\N
4978	JABON YOGURT ARANDANOS 1 LT 	1	7804920005595	1	1600	1	0	\N	\N
4979	JABON LIQUIDO ANTIBACTERIAL COCO Y LIMA 	1	7804920002754	1	1400	1	0	\N	\N
4980	JABON LIQUIDO GRANADA	1	7804920003966	1	1400	1	0	\N	\N
4998	TIJERA GRANDE 	1	7891597502953	1	2150	1	0	\N	\N
2145	TORTA 15 P BIZCOCHO	12	649	2	13000	1	0	\N	\N
4981	ARROZ MERKAT 1KG GRANO LARGO DELGADO	1	7804605040149	1	1200	1	0	\N	\N
4982	IN KAT HUEVITOS 25U	1	7802220142170	1	2100	1	0	\N	\N
4964	ANDINA DE VALLE FRESH 1.5L	1	7802820331516	1	1400	1	0	\N	\N
4957	MINI TRITON 	1	4*7613039589069	1	300	1	0	\N	\N
4985	LENGUIX FRUTAL	1	7801552006426	1	300	1	0	\N	\N
2117	JUGO RINDE 2 PIÑA - 24 G	1	7730908401588	1	180	1	0	\N	\N
4986	LISOFORM ORIGINAL 360 CC	73	7805050583533	5	3200	1	0	\N	\N
4987	PALETA FRAMBUESA 55G SAN FRANCISCO 	1	7802926001382	1	1000	1	0	\N	\N
4988	FANTA GRAPE 335ML	1	049000014242	1	1000	1	0	\N	\N
4989	FANTA PINEAPPLE 355ML	1	049000014273	1	1000	1	0	\N	\N
1119	PAN DE TAPADITO	8	3	2	2200	1	1900	\N	\N
4983	BISTEC PECHUGA DE PAVO ARIZTIA 100G	1	7801965001506	1	900	1	0	\N	\N
4990	PALO BROCHETAS GRUESO 35CM X 50	1	9201500004418	1	1300	1	0	\N	\N
4991	AURICULARES STEREO EARPHONE SOMAO	1	6945546500505	1	3200	1	0	\N	\N
4992	TEST DE EMBARAZO CICLOTEST	1	7800078000161	1	2200	1	0	\N	\N
4993	AUDIFONOS SUPER BASS 	1	6925871611077	1	1700	1	0	\N	\N
4994	CABLE USB ANDROID 2 MTS	1	1000200	1	2200	1	0	\N	\N
4995	PINZA NEGRA CEJAS	1	1000201	1	400	1	0	\N	\N
4996	VELA FELIZ CUMPLEAÑOS BIRTHDAY CANDLE 	1	6972105910017	1	1300	1	0	\N	\N
4721	PIMENTONES MIX  150 GR FRUTOS DEL MAIPO	7	7801300000850	1	600	1	0	\N	\N
4999	CAFE CLASICO MONTERREY 100G	1	7802800500420	1	2000	1	0	\N	\N
5000	QUESILLO SAN FRANCISCO	1	7802926000019	1	2500	1	0	\N	\N
5010	HUEVITO BUONO 300G	1	7896466221508	1	3350	1	0	\N	\N
5011	FERRERO ROCHER 150 GRS	1	7898024396994	1	7290	1	0	\N	\N
5013	NUGGUET TEMPURO	1	7801965001179	1	1800	1	0	\N	\N
5014	POSTRE SAN FRANCISCO TRES LECHES 1L	1	7802926000750	1	4500	1	0	\N	\N
5015	AVENA INTEGRAL 400 GR MI TERRA 	1	7803500000449	1	2700	1	0	\N	\N
5016	PROTEINA DE SOYA 300 GR MI TERRA 	1	7803500000203	1	1600	1	0	\N	\N
5017	NUGGETS SALMON 400 GR	1	7809611717399	1	3690	1	0	\N	\N
5031	EL SUEÑO DE MONY EMPOLVADOS	1	2000000001807	1	4500	1	0	\N	\N
4984	LOMITO PECHUGA DE PAVO ARIZTIA 120G	1	7801965001490	1	950	1	0	\N	\N
5034	EL SUEÑO DE MONY 	1	2000000001838	1	4500	1	0	\N	\N
979	PAPELILLO OCB ORGANICO	2	30087859	5	800	1	0	\N	\N
235	JUGO LIVEAN NARANJA 8 GRADOS 	1	7802800576418	1	200	1	0	\N	\N
5019	CHEETOS 22 G	1	7802000002991	1	300	1	0	\N	\N
5020	GANSITO CHOCO WAFER 23 G	1	7750727010143	1	200	1	0	\N	\N
5021	FILETE DE MERLUZA 500GR 	1	7801323000127	1	4100	1	0	\N	\N
5018	NOVA GIGANTE 150METROS	1	7806500406174	1	4800	1	0	\N	\N
5002	AQUAFRESH TRIPLE PROTECTION 126G	1	7800029002015	1	1500	1	0	\N	\N
4722	SALCHICHA HOT DOGS SAN JORGE 380G	1	7801907010061	1	1300	1	0	\N	\N
5001	TOALLAS HUMEDAS BABYSEC PREMIUM 45U	1	7806500731177	1	1200	1	0	\N	\N
5022	NUGGETS MERLUZA 400 GR 	1	7801323000684	1	2350	1	0	\N	\N
5035	FANIC GALLETAS 	1	2000000001845	1	4500	1	0	\N	\N
5023	BAYGON 450 CM 	1	7790520991522	1	2690	1	0	\N	\N
5024	GLADE MANZANA 900 CM 	1	7790520001061	1	1400	1	0	\N	\N
5026	MINI TORTA RFAMBUESA 550G	1	7804669193027	1	4900	1	0	\N	\N
5027	MINI TORTA GRANA MANJAR 500GR	1	7804669193003	1	4900	1	0	\N	\N
5028	MINI TORTA MINITORTA NUTELLA 550GR	1	7804669193034	1	4900	1	0	\N	\N
4723	HELADO PALETA LIMON SAN FRANCISCO	1	7802926001375	1	1000	1	0	\N	\N
5029	FANIC GALLETAS 	1	2000000001784	1	4500	1	0	\N	\N
5030	FANIC GALLETAS 	1	2000000001791	1	4500	1	0	\N	\N
5036	ENJUAGUE BUCAL COLGATE 180 ML	1	7891024039625	1	1500	1	0	\N	\N
5038	KILLER MATA ARAÑAS 560 CM	1	7805040004321	1	3990	1	0	\N	\N
5039	DETERGENTE MATIC 1KG 	1	7804663500173	1	1990	1	0	\N	\N
5041	CEPILLO DE CIENTE CHIKOOL 	1	6926597174365	1	990	1	0	\N	\N
5042	CEPILLO DE DIENTE CHIKOOL 	1	6926597171494	1	990	1	0	\N	\N
5043	TOALLA NOVA TORK 2 ROLLOS	1	7806540004569	1	1990	1	0	\N	\N
5045	DETERGENTE LIQUIDO FUZOL 3.5 LT 	1	7804920001061	1	6800	1	0	\N	\N
5046	DETERGENTE LIQ. ACE 1.9 LT 	1	7500435011938	1	5200	1	0	\N	\N
5033	JOHANY QUEQUE COLORES 	1	2000000001821	1	4500	1	0	\N	\N
5048	MINI TORTA MARACUYA 600GR 	1	7804669193041	1	4900	1	0	\N	\N
5049	ESPONJA ACANALADA 	1	6845685232858	1	250	1	0	\N	\N
5051	ESPONJA COCINA DORADA 	1	6845869652342	1	350	1	0	\N	\N
5052	SUAVIZANTE GENESIS 2 LT 	1	7802018350008	1	1200	1	0	\N	\N
5053	TRAPERO LIMPIEZZITO 	1	6846821421235	1	990	1	0	\N	\N
4689	GLADE 900CM	1	7790520001009	1	1400	1	0	\N	\N
5054	TOALLA FEMENINA NOCTURNA CHIKOOL 	1	6957931412737	1	630	1	0	\N	\N
5055	DESODORANTE AMBIENTAL CAMPOS DE LAVANDA GLADE	73	7790520016447	1	1500	1	0	\N	\N
5044	KILLER MATA MOSCAS 560 CM	1	7805040004307	1	3990	1	0	\N	\N
5037	RAID MATA ARAÑAS HORMIGAS CUCARACHAS 307 GR	73	7790520982100	1	4100	1	4000	\N	\N
1165	PAPAS DUQUESAS 500 G PF	1	7801930017846	1	1500	1	1200	\N	\N
5056	DESODORANTE AMBIENTAL ANTITABACO  360 CC GLADE	73	7790520016393	1	1500	1	0	\N	\N
5057	GLADE PARAISO AZUL 360 CC	73	7790520016515	1	1500	1	0	\N	\N
5058	COTTON CHIKOOL 55 UN 	1	6920180301190	1	990	1	0	\N	\N
5059	BOLSA BSURA TAK 70X90	1	7703147170119	1	650	1	0	\N	\N
5060	BOLSA BASURA TASK 80X110	1	7703147029240	1	1250	1	0	\N	\N
5061	PACK EMUBABY 2X80 160 UN 	1	7804603541419	1	3100	1	0	\N	\N
5062	DESODORANTE NIEVA INVISIBLE 150 ML	1	4005900036605	1	2200	1	0	\N	\N
5063	NIVEA MEN INVISIBLE 150 ML 	1	4005900376459	1	2200	1	0	\N	\N
5064	NIVEA TOQUE DE SEDA 150 ML 	1	4005900547316	1	2200	1	0	\N	\N
5065	NIVEA FRESH 150 ML 	1	4005900515865	1	2200	1	0	\N	\N
4749	DESODORANTE AXE MARINE 152 ML 	1	7791293038582	1	2500	1	0	\N	\N
4750	DESODORANTE AXE MUSK 152 ML 	1	7791293038575	1	2500	1	0	\N	\N
4751	AXE SECO APOLLO 152 ML.	73	7791293025896	1	2500	1	0	\N	\N
4752	DESODORANTE AXE BLACK 150 ML	73	7791293028781	1	2500	1	0	\N	\N
4753	TE EXCELSIOR  CEYLAN 125G	1	7801315161126	1	1100	1	0	\N	\N
5067	LAYS  250 GR EVERCRISP	1	7802000002564	1	2100	1	0	\N	\N
5070	COLA 6G 	1	6923256464225	1	300	1	0	\N	\N
5071	LOL HUEVO	1	8435477903592	1	490	1	0	\N	\N
5072	HUEVO BON BON 	1	8699462604288	1	490	1	0	\N	\N
5073	PATE LA PREFERIDA SALAME 125G	1	7801916029733	1	650	1	0	\N	\N
5092	PASTA TRATTORIA 400G 	1	7802575203014	1	1000	1	0	\N	\N
370	SHAMPOO FRUCTIS BRILLO VITAMINADO 350 ML 	2	7509552906448	1	2500	1	0	\N	\N
5093	PASTA TRATTORIA 400 GR 	1	7802575201089	1	1000	1	0	\N	\N
5075	EXTRA DELIVERY 	1	2000000001852	1	2000	1	0	\N	\N
5076	BENEDICTINO 3 LT 	1	7802820443301	1	1000	1	0	\N	\N
5077	BONGELATA TRENDY	1	7801552005115	1	2690	1	0	\N	\N
5078	LUCUMA MANJAR SAN FRANCISCO 1 LT 	1	7802926000071	1	4500	1	0	\N	\N
5074	GLORIA LECHE CONDENSADA	1	7501058611062	1	1890	1	1600	\N	\N
2364	ELITE 25 METROS	1	7806500512769	1	2400	1	1300	\N	\N
5068	WATTS FRUTILLA 	1	7801620002916	1	1500	1	1350	\N	\N
5069	SANGURUCHO CRAZY 125	1	7613035391369	1	1100	1	0	\N	\N
5080	VIRTEX TOALLAS  DESINFECTANTES 35 U	1	7806810007337	1	3000	1	0	\N	\N
5081	IGENIX LAVANDA	1	7805040000705	1	2400	1	0	\N	\N
5083	MALULOS FRUNA 35G	1	7802408004733	1	250	1	0	\N	\N
5094	PASTA TRATTORIA 400GR	1	7802575201010	1	1000	1	0	\N	\N
5095	PASTA TRATTORIA 400GR 	1	7802575201041	1	1000	1	0	\N	\N
5084	PECHUGA POLLO ACARAMELADA 	31	320	2	12000	1	7900	\N	\N
5085	LECHE SEMIDESCREMADA COLUN 200ML	1	7802920009605	1	450	1	0	\N	\N
5086	PAÑALES HUGGIES XXG 16 UNI	1	7809604030252	1	3200	1	0	\N	\N
5087	PHILADELPHIA ORIGINAL UNTABLR 150G	1	7622201429447	1	1990	1	0	\N	\N
5088	HOME SWEET HOME CASA Y JARDIN 360 ML 	1	7804947003864	1	2200	1	0	\N	\N
5089	CHAMPIÑON ENTERO 230G	1	7801434001822	1	1390	1	0	\N	\N
5090	GHOSH ALMEJAS NATURAL 425G 	1	7804610400822	1	2390	1	0	\N	\N
5091	ALMEJAS GHOSH 190G 	1	7804610400839	1	1550	1	0	\N	\N
5096	PASTA TRASTTORIA 400GR 	1	7802575201034	1	1000	1	0	\N	\N
5097	COLUN LIGHT CHOCOLATE 1 LT	1	7802920007687	1	1400	1	0	\N	\N
5098	TE NEGRO DE  HOJA 125 GR 	1	4792055016773	1	1390	1	0	\N	\N
5099	PICADILLO AL AGUA ANGELMO 190G	1	7801250601596	1	1200	1	0	\N	\N
5107	MANI SALADO EVERCRIPS 290G	1	7802000013171	1	1500	1	0	\N	\N
5108	PAILA MARINA DALFARO 1 KG	1	7809504800252	1	6500	1	0	\N	\N
5109	SURTIDO DE MARISCOS DALFARO 500GR	1	7809504801327	1	3300	1	0	\N	\N
5110	ZIPLOC 12 UN. 	1	7790520989956	1	1800	1	0	\N	\N
5111	RUMAY CREAM CHEESE 190G	1	7804634400518	1	1900	1	0	\N	\N
5112	PILA DURACELL 2025	1	041333038872	1	1000	1	0	\N	\N
5113	PAN MOLDE INTEGRAL RIVEROS	1	77777777	1	2000	1	0	\N	\N
5114	CAFE GOLD TENTACIONES LATT VAINILLA 15 G	1	7802800503742	1	350	1	0	\N	\N
5115	CAFE GOLD TENTACIONES LATTE CARAMEL 15 G	1	7802800503759	1	350	1	0	\N	\N
5117	MANI SIN SAL 160G	1	7802000013157	1	1000	1	0	\N	\N
5118	PALL MALL AZUL 20	1	78026100	1	2500	1	0	\N	\N
5121	DOÑA GABY 200G	1	7804655191426	1	1100	1	0	\N	\N
4754	ENELDO  MARCO POLO8G	1	7802420811388	1	450	1	0	\N	\N
420	VIENNETTA BRESLER MORA 1 LITRO 	1	7802705619012	1	3490	1	2990	\N	\N
5122	INSECTICIDA TANAX POLVO 125 GR	73	7805300049116	1	2100	1	0	\N	\N
5124	HEINZ 397GR	1	735051016372	1	1800	1	0	\N	\N
5125	BARRA FRUTOS SECOS CHOCOLATE 39G	1	7793890254303	1	550	1	0	\N	\N
4787	CHILE RECLA 	1	69086812000066	1	250	1	0	\N	\N
5128	GARBANZOS SIN PIEL MERKAT 500G	1	7809637200943	1	1100	1	0	\N	\N
5129	TOCINO LA PREFERIDA 100G	1	7801916039602	1	2000	1	0	\N	\N
5130	AJI MERKEN DON JUAN 250 GR 	1	7802351241049	1	1300	1	0	\N	\N
5131	AJI CHILENO JB 100GR	1	7802640000142	1	550	1	0	\N	\N
5134	WISKAS POUCH SARDINA  85 GR WHISKAS	60	7797453000543	1	650	1	0	\N	\N
5132	JOHANY CUCHUFLI CHOCOLATE 	1	15425474101	1	4500	1	0	\N	\N
5123	KETCHUP TRAVERSO 100GR	1	7802337976064	1	500	1	0	\N	\N
5135	WHISKAS POLLO 85 GR	60	7797453000550	1	650	1	0	\N	\N
5136	WISKAS POUCH GATITO  85 GR WHISKAS	60	7797453000406	1	650	1	0	\N	\N
5137	LECHE CULTIVADA LITRO	1	7802900000554	1	1900	1	0	\N	\N
5165	PANTY CAFFARENA NEGRO TALLA 2	1	7805810121357	1	1500	1	0	\N	\N
4997	VELA BIRTHBAY CANDLE	1	6972105919997	1	700	1	0	\N	\N
273	LADYSOFT ULTRAD. T/ULTRASEC. C/ALAS 8UN  	2	7790250096061	1	900	1	0	\N	\N
5166	HAMBURGUESA VACUNO SAN JORGE 55 G	1	7801907006866	1	400	1	0	\N	\N
5146	PEPSI ZERO 	1	7801620016043	1	900	1	0	\N	\N
5147	LAPIZ PASTA AZUL LEO SMART	1	6992194420136	1	200	1	0	\N	\N
5148	NAIPE INGLES 	1	6948726903622	1	2000	1	0	\N	\N
3605	TAPSIN CALIENTE NOCHE 5G	1	7800004399567	1	700	1	0	\N	\N
2084	PALLMALL ROJO 10	55	78018846	1	2000	1	1800	\N	\N
5127	WATTS NARANJA 300 ML 	1	7801620011659	1	700	1	650	\N	\N
519	PEPSI ZERO RETORNABLE  2,5 LT CCU	5	7801620006907	1	1550	1	1500	\N	\N
5120	GARNIER 2.0	1	7899026462540	1	2200	1	2000	\N	\N
622	YOGURTH NESTLE MORA 115GR	4	7613036467148	1	300	1	230	\N	\N
4788	MABU SORPRESA	1	6970466220011	1	500	1	350	\N	\N
4789	DINO	1	6920484009655	1	500	1	350	\N	\N
1608	CRAZY CHIRIMOYA ALEGRE 170ML SAVORY	6	7613036868228	1	1100	1	0	\N	\N
5156	PANTY CAFFARENA GRAFITO TALLA 2	1	7805810121296	1	1750	1	0	\N	\N
5159	PANTY CAFFARENA GRAFITO TALLA 4	1	7805810185168	1	1500	1	0	\N	\N
5153	PANTY CAFFARENA ALMENDRA TALLA 3	1	7805810121524	1	1750	1	0	\N	\N
5150	PANTY CAFFARENA ALMENDRA TALLA 4	1	7805810185151	1	1750	1	0	\N	\N
5149	PANTY CAFFARENA AMBAR TALLA 4	1	7805810185175	1	1750	1	0	\N	\N
5151	PANTY CAFFARENA APRICOT TALLA 2	1	7805810121333	1	1750	1	0	\N	\N
5161	PANTY CAFFARENA APRICOT TALLA 3	1	7805810121586	1	1750	1	0	\N	\N
5155	PANTY CAFFARENA CHAMPAGNE TALLA 2	1	7805810121340	1	1750	1	0	\N	\N
5160	PANTY CAFFARENA CHAMPAGNE TALLA 3	1	7805810121593	1	1750	1	0	\N	\N
5158	PANTY CAFFARENA COGNAC TALLA 2	1	7805810121364	1	1750	1	0	\N	\N
5154	PANTY CAFFARENA COGNAC TALLA 3	1	7805810121616	1	1750	1	0	\N	\N
5157	PANTY CAFFARENA COGNAC TALLA 4	1	7805810185144	1	1750	1	0	\N	\N
5145	FOSFOROS MERKAT 	1	7804603463452	1	1000	1	0	\N	\N
5144	TRITON LIMON 40 G	1	7613039589069	1	300	1	0	\N	\N
5162	PANTY CAFFARENA GRAFITO TALLA 3	1	7805810121548	1	1500	1	0	\N	\N
5164	PANTY CAFFARENA NEGRO TALLA 3	1	7805810121609	1	1500	1	0	\N	\N
3080	NOBLE DOBLE HOJA 6 ROLLOS 	1	7806500508229	1	1650	1	0	\N	\N
5167	LIQUIDO RINSO 5EN  1L	1	7805000310349	1	2700	1	0	\N	\N
5168	AJI PEBRE 240G	1	7802351241018	1	1300	1	0	\N	\N
5169	SUPERIOR 50X55 20U	1	7801875069092	1	1250	1	0	\N	\N
5170	AZERO 80X120	1	7801875069269	1	2800	1	0	\N	\N
5171	EMPANADA NAPOLITANA  8 U PRODUCTOS REVILLA	7	7604229133728	1	2200	1	0	\N	\N
5172	EMPANADA JAMON QUESO  8 U PRODUCTOS REVILLA	7	7604229133483	1	2200	1	0	\N	\N
5175	CHOC BRELLA	1	8697288504645	1	500	1	0	\N	\N
5176	CAFE GOLD CAPPUCINO	1	7802800503735	1	350	1	0	\N	\N
5177	CHOCOLATE DE LECHE MUIBON 145GR	1	7802800556137	1	1300	1	0	\N	\N
5180	KOTEX ULTRA FINA EXTRA SUAVE 16 UNIDADES 	1	7809604012234	1	2600	1	0	\N	\N
5193	PROTEIN CHOCOLATE MANI	1	7001186034516	1	1050	1	0	\N	\N
5194	FUCHS AVENA QUINOA 380G 	1	7803480001085	1	1600	1	0	\N	\N
5179	GRANUTS MIX ARANDANOS 40GR	1	7802800556229	1	500	1	0	\N	\N
5195	TE NEGRO ECOLOGIC  30G	1	8435336282813	1	3000	1	0	\N	\N
5196	CASATA TRENDY 1 LT 	1	7801552006297	1	2090	1	0	\N	\N
5178	MUIBON BURBUMILK 38GR	1	7802800556434	1	500	1	0	\N	\N
4943	MUIBON CRUNCH 35G	1	7802800556458	1	350	1	0	\N	\N
5182	BENEDICTINO LIMON JENGIBRE 2 LT	1	7802820454307	1	950	1	0	\N	\N
5183	BON O BON DULCE DE LECHE 	1	77975270	1	150	1	0	\N	\N
5184	COSTA MILK LIBRE DE AZUCAR 80 GR 	1	7802215101465	1	2200	1	0	\N	\N
5185	CACAO 62 CACAO 100GR 	1	7802215101625	1	1990	1	0	\N	\N
4819	DULCE DE LCHE EN LINEA 380G 	1	7804000002537	1	3700	1	0	\N	\N
4820	ATUN LOMITOS OTUNA 	1	7801230004409	1	1400	1	0	\N	\N
5187	SOPROLE QUESO GOUDA 9 LAMINAS 150 G	1	7802900001148	1	1250	1	0	\N	\N
5186	PRODUCTOS ARTESANALES JOHANY	1	12345678978	1	4500	1	0	\N	\N
5188	SOPROLE QUESO GAUDA 15 LAMINAS 250 G	1	7802900001162	1	2000	1	0	\N	\N
642	CHIQUITIN SORPRESA FRUTILLA 128ML	4	7613036711180	1	850	1	0	\N	\N
5198	QUESO RALLADO  40 GRS LA VAQUITA	1	7804613390298	1	750	1	0	\N	\N
5199	SUPREMO TE VERDE PREMIUN	1	7801875000590	1	2400	1	0	\N	\N
5192	PROTEIN CHOCOLATE  15G	1	7001186034370	1	1050	1	0	\N	\N
5119	PALL MALL CLICK 20 	1	78026117	1	2700	1	0	\N	\N
5181	ROCKLETS 	1	7802225582360	1	500	1	0	\N	\N
5191	GLOBO DE COLOR MEDIANO POR UNIDAD CELEBRACIONES ELY 	1	7898509283337	1	1990	1	0	\N	\N
5200	TRATTORIA 400G	1	7802575204042	1	1000	1	0	\N	\N
1049	CHOCOLATE CHUBI 138GR	6	7802225582476	1	1100	1	0	\N	\N
5201	CASSATA LECHE ASADA  1 LTS TRENDY	62	7801552004088	1	2090	1	0	\N	\N
5202	PAPAS MARCO POLO 200G	1	7802420151477	1	1000	1	0	\N	\N
5203	RED BULL BLUE 250CC	54	90415319	1	1300	1	0	\N	\N
5204	CARGADOR IPHONE CERTIFICADO	1	6931474709080	1	7000	1	0	\N	\N
5221	SHAMPOO FAMILAND GRANADA 750G	1	7804945062658	1	2000	1	0	\N	\N
5222	YELLOW SMOOTHIE OKF 500 ML	1	884394007933	1	1500	1	0	\N	\N
5197	CAFE MOCKA ITALIANO 	1	7802926001283	1	7200	1	5500	\N	\N
1607	CHOCOLITO 85ML SAVORY 	6	7613032186852	1	700	1	0	\N	\N
5223	PURPLE SMOOTHIE OKF 500 ML	1	884394007971	1	1500	1	0	\N	\N
5224	ORANGE SMOOTHIE OKF 500 ML 	1	884394007919	1	1500	1	0	\N	\N
5225	GREEN SMOOTHIE OKF 500 ML	1	884394007957	1	1500	1	0	\N	\N
5227	SHAMPOO DOVE 400 ML 	1	7891150050488	1	2650	1	0	\N	\N
5228	SHAMPOO DOVE MEN 400G	1	7891150023505	1	2650	1	0	\N	\N
5229	SHAMPOO PANTENE 400 ML	1	7500435128612	1	2650	1	0	\N	\N
5230	SUAVE NIÑOS SHAMPOO 350 ML 	1	7791293027852	1	1500	1	0	\N	\N
5231	TOALLA PAPEL BLANCO DE SUR 22.5 CM 	1	7804655192027	1	3990	1	0	\N	\N
5232	RINSO 1 KG	1	7805000313814	1	2100	1	0	\N	\N
5233	MAGISTRAL 500 ML	1	7506309827490	1	2250	1	0	\N	\N
5189	SOPROLE MARGARINA NEXT 250 G	1	7802900619022	1	1000	1	0	\N	\N
5234	+PLUS DETERGENTE 5 LT	1	7809823894239	1	2000	1	0	\N	\N
5235	HUGGIES TOALLITAS HUMEDAS	1	7794626007170	1	1000	1	0	\N	\N
5236	KLAREN 3 UDS 50 GRS	1	7805005003079	1	2100	1	0	\N	\N
5237	JABON MEN 203 150 GR	1	8680972088804	1	850	1	0	\N	\N
5238	IGENIX VIRGINIA 480 CM	1	7805040004208	1	3000	1	0	\N	\N
5239	ANTITRANSPIRANTE BEAUTY TOUCH NIVEA 150 ML	1	4005808630660	1	2200	1	0	\N	\N
5240	ALGODONES CHIKOOL 50 UDS	1	6920180310093	1	800	1	0	\N	\N
5245	BON O BON CHOCOLATE 90G	1	7802225512121	1	1200	1	0	\N	\N
5241	BUTTER TOFFEES	1	7790580419912	1	2200	1	0	\N	\N
5242	FLAN VIVO VAINILLA 80G	1	7802200365797	1	850	1	0	\N	\N
5243	GELATINA VIVO 0 AZUCAR 22G	1	7802200365735	1	800	1	0	\N	\N
5244	GELATINA 0 AZUCAR SABOR PIÑA 22G	1	7802200365742	1	800	1	0	\N	\N
5246	CEBOLLAS EN ESCABECHE 	31	321	2	1000	1	0	\N	\N
5248	SAN FRANCISCO MANGO AGUA 1L	1	7802926001573	1	2950	1	0	\N	\N
5249	CASSATA CHOCOLATE SUIZO F/BOSQUE  1 LTS TRENDY	62	7801552004040	1	2090	1	0	\N	\N
5250	MONSTER ULTRA PARADISE 473 ML	1	070847035206	1	1500	1	0	\N	\N
5251	ACEITUNAS SEVILLANAS DON JUAN 340 G	1	7802351131203	1	0	1	0	\N	\N
5253	FIESTA NEON	1	6957342992743	1	500	1	0	\N	\N
2031	PALLMALL PLOMO 20	55	78019096	1	3300	1	3200	\N	\N
2086	LUCKY STRIKE CLICK & ROLL 10	55	78016293	1	2600	1	2500	\N	\N
5254	ALOE VERA SPARKLING GRAPEFRUIT 500ML	1	884394009289	1	1000	1	0	\N	\N
5257	ALOE VERA SPARLING PINEAPLLE 500ML	1	884394009302	1	1000	1	0	\N	\N
5255	ALOE VERA SPARKLING ORIGINAL 500ML	1	884394008909	1	1000	1	0	\N	\N
5275	DOM DETERGENTE GELACTIVO 3TS	1	9201801000034	1	2990	1	0	\N	\N
5258	MARUCHAN RAMEN SABOR CARNE DE RES 85G	1	041789002922	1	700	1	0	\N	\N
5259	ALOE POMELO 	1	884394000972	1	1000	1	0	\N	\N
5274	AMPOLLETA BRIGH 72 WATTS 	1	606110015073	1	700	1	0	\N	\N
5276	JALEA GUINDA  110 GR SOPROLE	1	7802900295103	1	350	1	0	\N	\N
4851	TANAX EN POLVO 	1	7805300010109	1	2100	1	0	\N	\N
1611	ZOORPRESA 60G SAVORY 	6	7613037568424	1	500	1	0	\N	\N
3999	PEPSODENT 130G	1	7805000311346	1	1800	1	0	\N	\N
4854	JABON DOVE 100G	1	8712561548953	1	1200	1	0	\N	\N
4855	YOGU YOGU VAINILLA 200 ML	1	7802910305205	1	450	1	0	\N	\N
1295	YOGU YOGU MORA 200 ML	21	7802910303201	1	450	1	0	\N	\N
5260	DORITOS 42	1	7802000015496	1	600	1	0	\N	\N
5261	NESTLE ESPECIALIDADES 251G	1	7613039352151	1	3500	1	0	\N	\N
5262	BOLSA ASEO SUPERIOR 80X120 CM	1	7801875069177	1	2250	1	0	\N	\N
5264	BOLSA SUPRIOR 50X65 CM	1	7801875001801	1	500	1	0	\N	\N
5265	SUPEIOR 100 X130CM	1	2000000001869	1	5000	1	0	\N	\N
5266	SUPERIOR 100 X130CM	1	2000000001876	1	5000	1	0	\N	\N
5267	SUPERIOR 100 X130CM	1	2000000001883	1	5000	1	0	\N	\N
5268	SUPERIOR 100 X 130CM	1	2000000001890	1	0	1	0	\N	\N
5269	SUPERIOR 100 X130 CM	1	7801875000378	1	5000	1	0	\N	\N
5270	CUCHUFLI BAÑADO ABUELA MARIA 	1	7802607000352	1	2500	1	0	\N	\N
5278	GOLD NUECES Y CRANBERRIES 165GR	1	7802900335168	1	600	1	0	\N	\N
4853	TRI-PACK FRESH UP 90 G	1	6957136595778	1	2300	1	0	\N	\N
538	PEPSI RETORNABLE 2,5 LT	5	7801620001957	1	1550	1	1500	\N	\N
5256	ALOE VERA SPARKLING LIMA 500ML	1	884394009265	1	1200	1	1000	\N	\N
4852	MANLAC DORADA 	1	7806800004230	1	1800	1	1600	\N	\N
1604	KRIKO 65ML SAVORY 	6	7613034999115	1	650	1	600	\N	\N
3381	KEN IKON MIX 20UN.	1	78025219	1	3800	1	3500	\N	\N
5277	DE TODITO 50G	1	7802000015120	1	600	1	0	\N	\N
5279	QUILQUE MANTECOSO 150G	1	7802900001186	1	1500	1	0	\N	\N
5281	TOALLA NOVA ULTRA MEGAROLLO 2UN	1	7806500406495	1	2700	1	0	\N	\N
5287	FLOW 18 GR	1	7802800556052	1	200	1	0	\N	\N
5288	MUIBON BLANCO 48 GRS	1	7802800556045	1	500	1	0	\N	\N
5289	MUIBON CRUNCH 120G	1	7802800556403	1	1200	1	0	\N	\N
5290	MUIBON BURBUMILK 100G	1	7802800556427	1	1200	1	0	\N	\N
5292	PAN BLANCO SANDWICH	1	27803473212238	1	2200	1	0	\N	\N
5293	PINGUINOS 	1	7803473005359	1	500	1	0	\N	\N
5294	MUIBON 30G	1	7802800556120	1	400	1	0	\N	\N
5298	SUPREMO LEBALM 20 UD	1	7801875058133	1	1850	1	0	\N	\N
5299	SUPREMO LIMON 20 UDS	1	7801875001962	1	1850	1	0	\N	\N
5300	BEBEX XXG 24UNI 	1	7806500771463	1	2490	1	0	\N	\N
5304	BROWNIE 40G	1	7803500000616	1	700	1	0	\N	\N
5305	MIEL VIDA SANA.TU ELECCION 1 KL	1	1111111111	1	3600	1	0	\N	\N
5306	PAN ARTESANO HAMBURGUESA 665G	1	7803403002588	1	2300	1	0	\N	\N
5308	JUGO LIVEAN FRUTOS ROJOS 8G	1	7802800576739	1	200	1	0	\N	\N
5309	PROTEIN +155G	1	7802900001414	1	550	1	0	\N	\N
5310	YOGHURT LIGHT DURAZNO  120 GR SOPROLE	1	7802900234218	1	350	1	0	\N	\N
5311	YOGHURT AMERICANO FRUTILLA 155 GR	1	7802900230920	1	650	1	0	\N	\N
5312	COLUM 0 GRASA TOTAL	1	7802920106168	1	450	1	0	\N	\N
5313	LECHE CULTIVADA PROTEIN 1L	1	7802900002312	1	2500	1	0	\N	\N
5314	ROLLS NUTS	1	7802215108174	1	1700	1	0	\N	\N
5324	PASTA POLLO TOCINO	1	7801916031620	1	650	1	0	\N	\N
4894	NECTAR LIVEAN NARANJA 200 ML	1	7802800544318	1	350	1	0	\N	\N
5280	CANELA MOLIDA EDRA 15G	1	7802420004681	1	400	1	0	\N	\N
4314	LECHE ASADA SOPROLE 120G	1	7802900202019	1	650	1	600	\N	\N
5282	AVENA MULTISEMILLAS QUAKER 630 G	1	7802000015007	1	2990	1	2800	\N	\N
5315	AVENA INSTANTANEA 750G	1	7802000014925	1	2990	1	2390	\N	\N
5320	GALLETA AMORI SABOR MORANGO 	1	7891152300536	1	500	1	0	\N	\N
5291	FUCHS MULTIGRANO 	1	7803480000309	1	2200	1	0	\N	\N
5295	GARNIER 6.6	1	7899026462656	1	2000	1	0	\N	\N
5297	ANDINA DE MANZANA 1.5	1	7802820700435	1	1400	1	0	\N	\N
5296	ANDINA DE VALLE PIÑA 1.5L	1	7802820645859	3	1400	1	0	\N	\N
4895	NECTAR LIVEAN MANZANA 200 ML	1	7802800544332	1	350	1	0	\N	\N
4896	NECTAR LIVEAN DURAZNO 200 ML 	1	7802800544325	1	350	1	0	\N	\N
4897	TALLARINES LUCHTTI 78 400G	1	7802500000046	1	1300	1	800	\N	\N
4898	HAWAY LIMONADA FRAMBUESA 118GR	1	7801552006341	1	500	1	0	\N	\N
5325	RED SANDIA	1	90446849	1	1300	1	0	\N	\N
5326	LENTEJA 6 MM OREGON 1 KG	1	7809637200042	1	1700	1	0	\N	\N
5327	MERKAT LENTEJAS	1	7808743603068	1	1990	1	0	\N	\N
3258	HUEVITOS PICNIC 22 UN. 	1	7802215116728	1	2100	1	0	\N	\N
3938	LECHE CONDENSADA 390G	1	7804610400075	1	1100	1	0	\N	\N
3939	CHAMPIÑONES LAMINADOS GHOSH 400G	1	7804610400624	1	1350	1	0	\N	\N
1159	PAÑO ABSORVENTE MULTIUSO ARUBA 1UN 	1	7804645200138	1	500	1	0	\N	\N
3941	GELATINA MERKAT 22G	1	7809558105150	1	500	1	0	\N	\N
3942	MOUSSE VIVO LIMON 25G	1	7802200369214	1	990	1	0	\N	\N
5328	GALLETA VIVOSALVADO  585 GR COSTA	1	7802215501623	1	2200	1	0	\N	\N
5329	SALSA QUESOCHEDDAR 200G	1	7802410452041	1	1200	1	0	\N	\N
5330	LECHE EN POLVO ALCAFOOL 1 KG	1	7804638830045	1	4200	1	0	\N	\N
1991	FANTA ZERO 591 CC	48	7801610591123	1	900	1	0	\N	\N
1417	REPOLLO 	11	2000000000312	1	800	1	0	\N	\N
2394	CALIPO LIME 105 ML	1	8000920401187	1	890	1	0	\N	\N
1680	TIC TIC DE MENTA 16G	1	78600010	1	400	1	0	\N	\N
1832	PAÑUELOS FAVORITA 6UN 	1	7806540356101	1	1250	1	0	\N	\N
1830	PAÑUELOS ELITE 6UN. MENTOL 	1	7806500174202	1	990	1	0	\N	\N
1833	CHOLGAS ANTARTIC AGUA 190G	1	7804621470722	1	1300	1	0	\N	\N
5302	CIF CREMA MULTIUSO ORIGINAL 750G	1	7791290790513	1	2600	1	0	\N	\N
2196	ACEITUNAS	31	307	2	5490	1	0	\N	\N
5303	AVENA SHOCK 140GRS.	1	7803520002164	1	1750	1	1600	\N	\N
5307	PIZZA PF 465 G 	1	7801930010861	1	3490	1	3100	\N	\N
1605	COLA DE TIGRE 70ML SAVORY 	6	7613033495335	1	400	1	0	\N	\N
3812	SUPER 8 BALLS 120G 	1	7613037074680	1	1600	1	0	\N	\N
3831	FLAN VAINILLA LIVEAN 	1	7802800562527	1	700	1	0	\N	\N
1691	MAGGI TUCO CARNE  245G	40	7802950012316	1	1300	1	0	\N	\N
1753	CREMA TARRO  157 GRS NESTLE	21	7613032414580	1	950	1	0	\N	\N
4932	LECHE EN POLVO COLUN 400G 	1	7802920009858	1	2800	1	0	\N	\N
4933	ACEITE NATURA 1 LT 	1	7790272001012	1	2500	1	0	\N	\N
4934	ENCENDEDOR 	1	4891305180179	1	300	1	0	\N	\N
4935	CACHANTUN NATURAL SIN GAS 1 LT 	1	7801620005412	1	950	1	0	\N	\N
4966	ARTE DOR SIGNATURE CHOCOLATE CHIPS 1LT	1	7805000311384	1	5500	1	0	\N	\N
4967	INFERNO POTATO CHIPS 175G	1	7802351002022	1	1250	1	0	\N	\N
4969	COLA CAO 400G TARRO	1	7802635000249	1	2500	1	0	\N	\N
4971	CORN FLAKES ORIGINAL 500 GR	1	7896004004549	1	2750	1	0	\N	\N
5003	PEDIGREE POUCH ADULTO CARNE  100 GRS PEDIGREE	60	7797453000475	1	650	1	0	\N	\N
5004	GATOLATE 220G	1	7802000015304	1	1600	1	0	\N	\N
5007	MUIBON MANI 40 GRS 	1	7802800556021	1	400	1	0	\N	\N
5009	CEREZAS AL LICOR 360G 	1	7802200105881	1	4350	1	0	\N	\N
5040	OMO MATIC 3 KG 	1	7805000313692	1	7200	1	0	\N	\N
5050	VIRUTILLA ACERO LIMPIEZZITO	1	6845869652120	1	600	1	0	\N	\N
5025	DRIVE 1 KG 	1	7805000313593	1	2990	1	0	\N	\N
5100	PASTA TRATTORIA 400 G 	1	7802575204035	1	1000	1	0	\N	\N
5101	PASTA TRATTORIA 400G 	1	7802575201225	1	1000	1	0	\N	\N
5102	ACEITE DE OLIVA SANTE 500 ML	1	7804610401577	1	4200	1	0	\N	\N
5103	RED BULL YELLOW 250ML	54	90424496	1	1300	1	0	\N	\N
3159	CACHANTUN MAS LIMONADA JENGIBRE 1600ML	1	7801620008314	1	1050	1	0	\N	\N
4970	CORAZONES DE ALCACHOFA 400 GR	1	7802420001284	1	2700	1	2300	\N	\N
2752	BENEDICTINO PERA 1500ML 	1	7802820452204	1	900	1	0	\N	\N
559	CACHANTUN MAS CITRUS 1600 CC	5	7801620006600	1	1100	1	1050	\N	\N
4968	ALOE VERA FRUTILLA HOMAR 500ML	1	7804645050207	1	1300	1	1000	\N	\N
5005	CHEEZELS 220G	1	7802000015335	1	2000	1	1600	\N	\N
5006	CHIS POP 220G	1	7802000015328	1	2000	1	1600	\N	\N
494	CACHANTUN MAS LIMON-NARANJA 1.6 LTS	5	7801620007744	1	1050	1	0	\N	\N
3838	QUESO COLUN GAUDA 250G	1	7802920801056	1	2700	1	0	\N	\N
2850	CACHANTUN MAS MANZANA 1,6 LT	75	7801620006624	1	1050	1	0	\N	\N
3943	TALCO SIMONDS 100G	1	7804945001206	1	2100	1	0	\N	\N
3947	ALOE VERO FRUTILLA 500ML	1	6971549920057	1	1000	1	0	\N	\N
286	LOS TRES NEGRITOS 24 G 	6	7802200009028	1	150	1	0	\N	\N
5140	BIMBO CHOCOLATE 30G	1	7802215504792	1	200	1	0	\N	\N
5141	BIMBO VAINILLA 30G	1	7802215504785	1	200	1	0	\N	\N
5142	MINI NIK 30G	1	7802215502293	1	250	1	0	\N	\N
5143	INFERNO	1	7802351002008	1	1500	1	0	\N	\N
5139	ROCKLETS CHOCOLATE BLANCO	1	7802225590167	1	1100	1	0	\N	\N
5174	UNO FRUTILLA 80 ML	1	78022263	1	350	1	0	\N	\N
5205	CABLE USB V8	1	6971536924365	1	1500	1	0	\N	\N
5206	CARGADOR V8 ECO	1	711719990048	1	3700	1	0	\N	\N
5207	CABLE AUX 1.0	1	88888888	1	1700	1	0	\N	\N
5208	PRALINES CORAZON AVELLANA	1	9002859037962	1	7190	1	0	\N	\N
5209	PRALINES CORAZON CHERRY	1	9002859057106	1	7190	1	0	\N	\N
5210	PRALINES CORAZON MILK	1	9002859037948	1	7190	1	0	\N	\N
5211	MAITRE TRUFFOUNT 20 G BLU3	1	9002859075384	1	3800	1	0	\N	\N
5212	MAITRE TRUFFOUT CHOCOLATES 180 GR	1	9002859063558	1	3490	1	0	\N	\N
5213	PLRALINES CHOCOLATE 180 GR	1	9002859037566	1	3490	1	0	\N	\N
5214	BOM BOM SURTIDO MAITRE AMARILLO 100G 	1	9002859055638	1	5400	1	0	\N	\N
5215	BOMBON SURTIDO MAITRE ROJO 100G	1	9002859055652	1	5400	1	0	\N	\N
5216	BOMBOM MAITRE AZUL 100 GRS	1	9002859088469	1	5400	1	0	\N	\N
730	NESCAFE TRADICIONAL   100 GRS	1	7802950002133	1	3500	1	0	\N	\N
5104	WOMAN BEAUTY SKIN 1.6 LT	1	7801620008734	1	1300	1	0	\N	\N
460	ARROZ CHAUFAN TUCAPEL 210G	1	7801420500032	1	1100	1	0	\N	\N
462	ARROZ PRIMAVERA TUCAPEL 210G	1	7801420500018	1	1100	1	0	\N	\N
1960	VITAL SIN GAS 600 ML	53	7802820600209	1	600	1	0	\N	\N
560	CACHANTUN MAS MANZANA/DURAZNO 1.6 LT	5	7801620007621	1	1100	1	1050	\N	\N
5105	PAPAYAS A LA CREMA SAN FRANCISCO 1 LT 	1	7802926000132	1	6300	1	4500	\N	\N
1559	ESCOBILLA PARA ZAPATOS MADERA 	18	120190515013	1	850	1	0	\N	\N
3259	HUEVOS INKAT 25 UN 	1	7802220310531	1	2100	1	0	\N	\N
4013	BOLSA BASURA CHACAO 70X90	1	7801430400087	1	900	1	0	\N	\N
2535	COLONIA ROSADA BABYLAND 210ML 	1	7804945076174	1	1790	1	0	\N	\N
1723	MAYONESA HELLMANNS 744 GR	29	7803200804156	1	3300	1	0	\N	\N
1139	SURTIDO CALDILLO NATURAL  190 GR CRUCERO	17	7804520240006	1	890	1	0	\N	\N
1730	NEQUIK CHOCOLATE 200GRS NESTLE	45	7613030120728	1	1300	1	0	\N	\N
1545	VASOS DE CARTON FESTIVITY 10 UN 	34	6922332016204	1	700	1	0	\N	\N
1566	SERVILLETAS UNICORNIO 	34	170190517142	1	600	1	0	\N	\N
1560	ALARGADOR BLANCO 3 MT 	34	5605787909888	1	4300	1	0	\N	\N
4112	SHAMPOO BALLERINA 750ML	1	7804920005816	1	2000	1	0	\N	\N
658	LOMITOS ACEITE SAN JOSE 170GR	1	7801235001687	1	1500	1	0	\N	\N
3889	AEROSOL FRESH STRAWBERRY 	1	8696630133069	1	1200	1	0	\N	\N
2816	MALLOA ALBAHACA 245G	1	7805000311483	1	1250	1	0	\N	\N
3923	ESPONJA DE ACERO BRIGHT 	1	700083653550	1	500	1	0	\N	\N
3929	LOMITO JUREL NATURAL 17G	1	7801235001595	1	1250	1	0	\N	\N
3925	JUREL COLORADO 425 G 	1	7801255320102	1	1500	1	0	\N	\N
2749	SUPREME 312G	1	7805000314286	1	1690	1	0	\N	\N
3931	CHORIPACK TRAVERSO 240G	1	7802337930462	1	1500	1	0	\N	\N
4166	VIVO NECTAR MANZANA 1LITRO	1	7802575226358	1	850	1	0	\N	\N
3935	GELATINA BERRIES LIVEAN 20G	1	7802800567058	1	700	1	0	\N	\N
5492	OKEBUM CHOCO MANI 	1	7801552005009	1	500	1	0	\N	\N
677	PIÑA EN TROZOS ESMERALDA 565GR	1	7802420000256	1	1650	1	0	\N	\N
3864	DAILY TRADICIONAL 180 ML 	1	7809558101992	1	1100	1	0	\N	\N
1260	GALLETA MINI TRITON  40 GR MCKAY	26	7613032464042	1	300	1	0	\N	\N
3975	LASAÑA PRECOCIDA CAROZZI 360G	1	7802575015174	1	1600	1	0	\N	\N
604	SOPA CARACOLITOS MAGGI	1	7802950006636	1	690	1	0	\N	\N
2082	LUCKY STRIKE DOBLE CLIK LILA 10	55	78022010	1	2700	1	2500	\N	\N
1136	NOSOTRAS BUENAS NOCHES 8 UN	16	7702026180287	1	1550	1	1150	\N	\N
1435	SALCHICHA SUREÑAS  5 UN PF	33	7801930005096	1	800	1	0	\N	\N
2366	PAPAS FRITAS CASERAS MARCO POLO 250 GR	46	7802420003929	1	1500	1	0	\N	\N
3977	ZUCARITAS CHOCOLATE 480G	1	7702103772312	1	3800	1	0	\N	\N
4213	TOALLAS HIGIENICAS ALWAYS  8 UN	1	7500435127240	1	600	1	0	\N	\N
4214	DESODORANTE BODY SP DARK TEMP  90 GRS AXE	73	7791293025797	1	2500	1	0	\N	\N
4215	DESODORANTE AXE 	1	7791293039114	1	2500	1	0	\N	\N
4216	DESODORANTE AXE 	1	7506306226852	1	2500	1	0	\N	\N
482	ARROZ G1 TUCAPEL 1KG	1	7801420140139	1	1690	1	0	\N	\N
1466	CEBOLLA	11	2000000000466	1	300	1	0	\N	\N
4124	COCKTEL DE FRUTAS GHOSH 820 G	1	7804610400488	1	2500	1	0	\N	\N
4125	CREMA BATIR 1 LT COLUN	1	7802920000435	1	3100	1	0	\N	\N
4131	SWISSBEAUTY COTONITOS	1	7805190000082	1	1000	1	0	\N	\N
4133	REPOLLO	1	2000000001593	1	650	1	0	\N	\N
4134	JABON DAVE COCNUT 100G 	1	8712561306409	1	1200	1	0	\N	\N
4157	PANTRUCAS NATUREZZA 110G	1	7803700612527	1	900	1	0	\N	\N
4136	ANTARTIC CON ACEITE MARISCOS	1	7804621471385	1	1400	1	0	\N	\N
4137	ANTARTIC MARISCOPS CON AGUA 	1	7804621471378	1	1400	1	0	\N	\N
4138	MAXI CHIPS 200G	1	2000000001609	1	1150	1	0	\N	\N
4139	MALVA CHOC  250 GR COSTA	1	7802220071807	1	2050	1	0	\N	\N
4142	ARROZ STA MARTA GRADO 1 1KG	1	7801450000076	1	1200	1	0	\N	\N
4143	ARROZ STA MARTA GRADO 2 1KG	1	7801450000052	1	1100	1	0	\N	\N
4144	ROCKLETS MAX 46G	1	7802225427234	1	450	1	0	\N	\N
4179	MOGUL DIENTE 150G	1	7790580405762	1	990	1	0	\N	\N
4262	VIVO DAMASCO 200G	1	7802200400061	1	1100	1	0	\N	\N
4264	PROTEIN + SOPROLE	1	7802900002022	1	600	1	0	\N	\N
4265	LONCO LECHE PROTEIN 14 G	1	7802910007079	1	550	1	0	\N	\N
4255	COLUN LIGHT LECHE CULTIVADA 	1	7802920005195	1	550	1	0	\N	\N
3428	CLORINDA CLORO GEL ORIGINAL 750 ML	1	7805080696593	1	1350	1	0	\N	\N
3774	YOGU YOGU CHIRIMOYA 200 ML	1	7802910306202	1	450	1	0	\N	\N
4266	POWER ADE FROZEN BLAST  600 ML COCACOLA	54	7802820651157	1	900	1	850	\N	\N
2753	BRILLINA ROJA 360CM 	1	7805040001450	1	1550	1	1300	\N	\N
4141	GALLETA MAXI CHIPS  200 GR COSTA	1	7802215505058	1	1150	1	0	\N	\N
4135	SAHNE NUSS 90G	1	7613287103529	1	1690	1	1490	\N	\N
3778	TOALLA DE PAPEL GIORDANA 100 MTS.	1	7804000600	1	3000	1	0	\N	\N
3775	CALDO COSTILLA 120GR. MAGGI 	1	7613033822254	1	1400	1	0	\N	\N
2840	CHORITOS EN AGUA ROBINSON CRUSOE 190G	1	084773611502	1	1500	1	0	\N	\N
3776	CALDO GALLINA  8 TABL. MAGGI	1	7802950005936	1	990	1	0	\N	\N
3780	JABON VERDE DOÑA GABY 200GR	73	7804364325358	1	1100	1	0	\N	\N
3781	JABON BLANCO DOÑA GABY 200GR.	73	7804364325150	1	1100	1	0	\N	\N
1485	CHOCLO NATURAL TROZO 	11	2558	1	600	1	0	\N	\N
3782	BON O BON CAJA 105GR. 	1	7802225511551	1	1100	1	0	\N	\N
1902	FANTA EXPRESS 237CC	1	8001	1	300	1	0	\N	\N
2922	CERA TIERRA DE COLOR  340 CC NUGGET	73	7805010001527	1	1400	1	0	\N	\N
3180	GARBANZOS BONANZA 500G	1	7808743604553	1	1390	1	0	\N	\N
748	TE CLUB CEYLAN PREMIUM 20 UN	1	7805000311612	1	1100	1	0	\N	\N
3530	DULCE MEMBRILLO PERELLO 250G	1	7809562401286	1	650	1	0	\N	\N
3058	POET PRIMAVERA 900ML 	1	7805025697531	1	1550	1	0	\N	\N
3257	CHOCOLATE DE LECHE MIX 130G	1	7802200848320	1	3000	1	0	\N	\N
3522	AMBIENTADOR SAPOLIO BRISA MARINA 360G	1	7751851006064	1	1890	1	0	\N	\N
1309	DURAZNOS MITADES EN CONSERVA ACONCAGUA 3KG	1	7801800100203	1	5600	1	0	\N	\N
427	VIZZIO 21G 	6	78024380	1	150	1	0	\N	\N
2195	CHAMONIX PIÑA 2.5LT	1	7613033037924	1	3500	1	0	\N	\N
2413	DETERNGENTE WINNEX 1KG	1	6953018100351	1	1300	1	0	\N	\N
2115	ENCENDEDOR 	1	7804520011613	1	300	1	0	\N	\N
948	SUPER 8  29 GR NESTLE	6	7613030612339	1	200	1	0	\N	\N
2188	PAÑUELOS FAVORITA 	1	7806540310103	1	250	1	0	\N	\N
2477	PIPONA  120 GR SEMBRASOL	70	7804612220633	1	1300	1	1200	\N	\N
1795	JABON BLUE FRESH C2 85 GR	36	7840118212604	1	400	1	0	\N	\N
1746	CREMA SURLAT 1L	1	7808709500189	1	3000	1	0	\N	\N
3261	HUEVITOS RELLENOS AMBROSOLI 15 UN. 	1	7802200850477	1	1600	1	0	\N	\N
1506	ARANDANO 	11	120	2	500	1	690	\N	\N
1692	SOYA 155ML MARCO POLO	1	7802420116414	1	1790	1	0	\N	\N
3549	HARINA YANINE 5 KG. 	1	7802612000026	1	6200	1	4200	\N	\N
3059	RINSO MATIC 350G	1	7805000319236	1	950	1	800	\N	\N
731	CAFE GOLD TARRO PRIMERA SEL. 170GR	1	7802800500611	1	3990	1	0	\N	\N
2097	CAPRI ALMENDRA 90 G 	1	7613034276797	1	1200	1	990	\N	\N
2151	LECHE CULTIVADA 180ML 	1	7802920005201	1	550	1	0	\N	\N
157	FULL LIMON ZERO AMBROSOLI 19 G 	6	7802200111530	1	200	1	0	\N	\N
145	FIDEO ROMANO N° 5 SPAGHETTI 400 GRAMOS	1	7802500016016	1	600	1	0	\N	\N
153	FRUTILLAS A LA CREMA 25 G 	6	7802200135864	1	200	1	0	\N	\N
19	AGUA PURIFICADA LIV 6 LITROS 	5	7804604726259	1	1300	1	0	\N	\N
745	TE SUPREMO LLANTEN 20UN.	1	7801875058058	1	1100	1	0	\N	\N
821	SAPOLIO BEBE 800GR	2	7751851018777	1	1800	1	0	\N	\N
3262	YERBA MATE VERDEFLOR HIERVAS SERRANAS 500G	1	7793670000052	1	2990	1	0	\N	\N
88	CHORITOS EN AGUA ANGELMO 190 GRAMOS 	1	7801250000320	1	1200	1	0	\N	\N
5116	PATE MERKEN 	1	7801916029719	1	650	1	0	\N	\N
5271	NESCAFE UGANDA ORIGINAL 100G 	1	7613037115208	1	6700	1	0	\N	\N
1828	MANTEQUILLA SOPROLE UNTABLE 200G	1	7802900026622	1	2890	1	0	\N	\N
2588	MILO  300 GR NESTLE	1	7613030121046	1	2790	1	0	\N	\N
735	TE CEYLAN MILDRED 125 GR	1	7801875029010	1	1850	1	0	\N	\N
1497	PEPINO FRUTA 	11	115	2	1200	1	0	\N	\N
1107	ACEITE MIRAFLORES VEGETAL 1 LITRO	1	7801320019375	1	2600	1	0	\N	\N
4376	SUNY CALUGAS  400 GR COSTA	1	7802220721603	1	2750	1	0	\N	\N
4377	GOLDEN NUSS 120	1	7802200840294	1	1100	1	0	\N	\N
4378	COSTA 72% CACAO & NARANJA 80GR	1	7802215101489	1	1990	1	0	\N	\N
3743	OPTIMO MANZANA 750ML.	1	7804663190299	1	1300	1	0	\N	\N
1653	MORTADELA CON SALAME 	3	97	2	7000	1	6500	\N	\N
4444	PEDIGREE RAZA PEQUEÑA 	77	235	2	2800	1	1700	\N	\N
161	GALLETA FRAC CHOCOLATE 130 G 	6	7802215512278	1	70	1	600	\N	\N
552	ORANGE CRUSH 3 LTS DESECHABLE	5	7801620001599	1	2000	1	1950	\N	\N
2069	PALLMALL CLICK 10	55	78019041	1	2100	1	2000	\N	\N
160	GALLETA FRAC BI CAPUCCINO  130 G 	6	7802215512292	1	700	1	600	\N	\N
4867	LAYS ORIGINAL 134 G 	1	7802000013607	1	1700	1	1600	\N	\N
1651	PECHUGA DE PAVO AHUMADA ARIZTIA 	3	95	2	11000	1	6500	\N	\N
5338	QUESO MANTECOSO QUILQUE 500GR	1	7802900001193	1	3800	1	0	\N	\N
888	LIMONADA LOVE LEMON NARANJADA LIGHT 475CC	5	7804643820185	1	1200	1	0	\N	\N
3305	POETT SOLO PARA TI 900ML 	1	7805025694776	1	1550	1	0	\N	\N
3190	VITAL C/GAS 2 LTS	75	7802820020908	1	900	1	0	\N	\N
3316	LYSOFORM FLORAL 360CM	1	7790520014207	1	2650	1	0	\N	\N
944	BAZOOKA CHICLE JIRAFA TUTTI-FRUTTI 14GR	6	211	1	150	1	0	\N	\N
3591	PIÑAS EN RODAJAS MANDALAY 565G	1	7803505200011	1	1350	1	0	\N	\N
2322	CHISPOP  110 GR EVERCRISP	46	7802000011870	1	1000	1	0	\N	\N
1977	NARANJA Y NADA 500 CC	48	7801610283073	1	900	1	0	\N	\N
1978	MONSTER BLANCA 473ML 	54	070847021964	1	1500	1	0	\N	\N
42	ATUN LOMITO EN AGUA ANGELMO 170 GRAMOS 	1	7801268001357	1	1200	1	0	\N	\N
2169	PANTY CHABELA NYLON VARIEDAD 	1	2000000001067	1	980	1	0	\N	\N
2170	PANTY CHABELA ELASTICADA VARIEDAD 	1	2000000001074	1	1500	1	0	\N	\N
2175	IO ACOND. YOGHURT Y HUEVO 	1	7808714795471	1	990	1	0	\N	\N
2176	IO ACOND. CAMOMILLA 	1	7808714788749	1	990	1	0	\N	\N
2177	IO ACOND. YOGHURT Y HIERBAS 	1	7808714736542	1	990	1	0	\N	\N
2999	FLAN BERRIES LIVEAN 20G	1	7802800562541	1	700	1	0	\N	\N
3832	GELATINA NARANJA 100 GR AMBROSOLI	1	7802200361089	1	850	1	0	\N	\N
2326	GELATINA CEREZA 100 GR AMBROSOLI	67	7802200361102	1	850	1	0	\N	\N
3833	GELATINA FRUTILLA AMBROSOLI 100 GR	1	7802200361119	1	850	1	0	\N	\N
3834	GELATINA PIÑA 100 GR AMBROSOLI	1	7802200361096	1	850	1	0	\N	\N
1137	DIANA MAKE-UP REMOVER WIPES 2 PCS AZUL	1	8690879905029	1	990	1	0	\N	\N
3842	AZUCAR IANSA 750G	1	7801505001713	1	950	1	0	\N	\N
5217	FLAKED TRUFFES 145 G	1	9002859106996	1	3800	1	0	\N	\N
5218	FLAKED TRUFFLES MILK 145 G	1	9002859107016	1	3800	1	0	\N	\N
5219	SHAMPOO FAMILAND JALEA REAL 750 ML	1	7804945062528	1	2000	1	0	\N	\N
5220	SHAMPOO FAMILAND QUILLAY 750 	1	7804945062542	1	2000	1	0	\N	\N
5283	LECHE CULTIVADA ZERO LACTO 1 LT	1	7802900000578	1	2500	1	0	\N	\N
5284	ACEITE MERKAT 900 ML	1	7804608223037	1	1500	1	0	\N	\N
610	CREMA DE CHOCLO NATUREZZA 0GR	1	7803700012259	1	450	1	0	\N	\N
2154	PEDIGREE CACHORRO 	60	901	2	2400	1	2000	\N	\N
5286	AKA MAQUI 475 ML	1	7804667390190	1	1500	1	0	\N	\N
613	SOPA NATUREZZA POLLO CON SEMOLA 55GR	1	7803700012082	1	450	1	0	\N	\N
5321	GALLETA AMORI SABOR CHOCOLATE	1	7891152300512	1	500	1	0	\N	\N
5322	GALLETA ESCURETO MABU	1	7891152300567	1	600	1	0	\N	\N
3814	MARGARINA POTE 500 GR SOPROLE	1	7802900617011	1	1750	1	0	\N	\N
2440	KETCHUP DON JUAN 800G	1	7802351615024	1	1900	1	0	\N	\N
5226	PALITOS DE HOJA	12	659	1	600	1	0	\N	\N
5316	AVENA INSTANTANEA TRADICIONAL 750G	1	7802000014932	1	2100	1	0	\N	\N
5317	MANTEQUILLA DE CAMPO FUTALEUFU 250G	1	7804648260245	1	2400	1	0	\N	\N
5318	MANTEQUILLA  250 GR SANTA SARA	1	7804610860206	1	2500	1	0	\N	\N
3843	HARINA REPOSTERIA  1 KILO EL PERAL	1	7802651000018	1	950	1	0	\N	\N
3823	LAVALOZAS EXCELL 	1	7805020001012	1	1100	1	0	\N	\N
3837	MANJAR DULCELE  1 KG 	1	7804669190033	1	2390	1	0	\N	\N
5352	HERSHEYS 40 G	1	7898292887163	1	750	1	0	\N	\N
5332	REGGIANITO 80G	1	7802920423814	1	1500	1	0	\N	\N
5333	ENERGIZER 2032	1	8888021300185	1	1000	1	0	\N	\N
5334	CONEIRO TRENDY 	1	7801552006358	1	950	1	0	\N	\N
5331	NECTAR LIGHT DURAZNO  1,5 LT ANDINA DEL VALLE	1	7802820048322	1	1400	1	0	\N	\N
5341	FLAN DULCE DE LECHE SOPROLE 120G	1	7802900002411	1	300	1	0	\N	\N
5343	FLAN TOFFEE SOPROLE 120G	1	7802900002428	1	300	1	0	\N	\N
3252	DULCE DE LECHE SOPROLE 500G	1	7802900414016	1	1600	1	0	\N	\N
662	MAYONESA KRAFT 397 GR 	1	021000026968	1	3050	1	0	\N	\N
5346	YOGHURT TROZOS PIÑA  165 GR SOPROLE	1	7802900000318	1	550	1	0	\N	\N
5347	ARROZ CON LECHE SOPROLE 130G	1	7802900002435	1	650	1	0	\N	\N
2762	SEMOLA CARAMELO SOPROLE 140 GR 	1	7802900022143	1	600	1	0	\N	\N
5348	BROWNIE MINI 	1	7803525001179	1	250	1	0	\N	\N
5353	KAPO LIMON 252 ML	9	7802820200997	1	250	1	0	\N	\N
5342	FLAN CARAMELO SOPROLE 120G	1	7802900002343	1	350	1	300	\N	\N
5344	FLAN VAINILLA SOPROLE 120G	1	7802900002336	1	400	1	300	\N	\N
5335	LAYS CORTE LISO 240G	1	7802000014307	1	1900	1	0	\N	\N
5336	AZUCAR FLOR IANSA 1K	1	7801505001232	1	2100	1	1890	\N	\N
5337	NESTUM 250G	1	7613036048040	1	1900	1	0	\N	\N
5340	YOGURT ZERO LACTO GOLD FRUTOS SECOS 155G	1	7802900001889	1	600	1	0	\N	\N
3968	ISABELA CARNE	1	7896022051051	1	600	1	0	\N	\N
5375	VIVO DURRAZNO MERMELADA 	1	7802200400092	1	1100	1	0	\N	\N
5376	VIVO FRASMBUESA MERMELADA 	1	7802200400078	1	1100	1	0	\N	\N
5377	LAVALOZAS KLIN AROMA LIMON	1	7804660170126	1	1100	1	0	\N	\N
5378	BASILICO 400G	1	8076809513739	1	2350	1	0	\N	\N
664	MAYONESA KRAFT LIGHT 449GR	1	021000026982	1	2950	1	0	\N	\N
5381	SEMOLA CARAMELO POSTRES DE LA ABUELA SOPROLE 140G	1	7802900002404	1	600	1	0	\N	\N
5379	MAYODELI KRAFT 90 GR	1	7802351000950	1	650	1	0	\N	\N
5383	YOGURTH AMERICANO 155G	1	7802900230913	1	650	1	0	\N	\N
5339	QUESO CREMA SOPROLE 100G	1	7802900001230	1	600	1	0	\N	\N
5380	MAYODELI KRAFT 350 GR	1	7802351000929	1	2590	1	0	\N	\N
1892	GALLETA CREMONA CHOCOLATE 160GR	26	7802408005334	1	450	1	0	\N	\N
5356	ZAETA MATA ARAÑAS 260G	1	7804915004732	1	2700	1	0	\N	\N
5357	TANAX MOSCAS Y ZNCUDOS 500 CC 	1	7805300050204	1	3490	1	0	\N	\N
5358	TRATTORIA PASTA DE ARROZ 250G 	1	7802575201232	1	2650	1	2450	\N	\N
5359	ENJUAGUE BUCAL FRESH UP 250 ML 	1	7804670490030	1	1500	1	0	\N	\N
3870	FRUTILLAS AL JUGO GHOSH 410 G 	1	7804610400495	1	1200	1	0	\N	\N
5360	MAYONESA TRAVERSO 760 G 	1	7802337500016	1	1650	1	0	\N	\N
5361	ATUN DESMENUZADO ISADORA 170G	1	7801434000375	1	900	1	0	\N	\N
5362	ATUN DESMENUZADO 170G 	1	7801434000382	1	900	1	0	\N	\N
5384	PROTEIN+ FRUTILLA 155G	1	7802900001407	1	600	1	0	\N	\N
5405	SACS CRUSH MANGO 238ML	1	8809041426921	1	700	1	0	\N	\N
97	CLORINDA GEL ORIGINAL 900 ML 	2	7805080695084	1	1850	1	0	\N	\N
5355	ESPUMA DE AFEITAR MAJIX 	1	8696630128737	1	3900	1	2100	\N	\N
5349	QUESO MANTECOSO HUILCO 	1	7804647570123	1	4900	1	4400	\N	\N
890	CEREAL KIDS ARCOR TRIGO 100GR	6	7802225690133	1	1000	1	0	\N	\N
889	CEREAL KIDS ARCOR ARROZ 100GR	6	7802225690140	1	1000	1	0	\N	\N
5385	ENCENDEDOR	1	6943981900027	1	300	1	0	\N	\N
5386	RED BULL BLANCA	1	90435539	1	1300	1	0	\N	\N
5387	CARTE DOR DULCE DE LECHE 1 LT	1	7805000311414	1	3490	1	0	\N	\N
5388	ANDINA DEL VALLE 2L SIN AZUCAR	1	7802820700633	1	1500	1	0	\N	\N
5389	POSTRE CREME CARAMELO 120 GR GOLD	1	7802900120214	1	650	1	0	\N	\N
5390	POSTRE PANNA COTTA GOLD 120 GR	1	7802900120283	1	650	1	0	\N	\N
5391	POSTRE DOLCE PISTACHO GOLD 120 GR	1	7802900120276	1	650	1	0	\N	\N
5392	MANJARATE WHITE 80 GR	1	7802900002558	1	550	1	0	\N	\N
5393	QUESILLO SIN LACTOSA SOPROLE ZERO LACTO 300 GR	1	7802900149017	1	1800	1	0	\N	\N
5394	HARINA DE AVENA 400 G 	1	7803500000500	1	3100	1	0	\N	\N
5395	IGENIX DESINFECTANTE PISOS LAVANDA 900ML	1	7805040004857	1	990	1	0	\N	\N
5396	IGENIX DESINFECTANTE VAINILLA 900 ML 	1	7805040004864	1	990	1	0	\N	\N
5397	LAVALOZAS VIRGINIA 200ML	1	7805040003300	1	500	1	0	\N	\N
5400	SUPREMO TE VERDE MATCHA 20 BL 	1	7801875001849	1	1200	1	0	\N	\N
5402	CHORIZO PARRILLERO  1 KG PF	3	7801930006376	1	3600	1	0	\N	\N
5403	CALZONES ROTOS 	1	7604229133544	1	2790	1	0	\N	\N
5404	SOPAIPILLAS C/ZAPALLO COCKTAIL 18 UNIDADES	7	7604229133933	1	1300	1	0	\N	\N
5408	INCA KOLA350 ML	1	7801610277829	1	1100	1	0	\N	\N
5409	+ENERGY WAKE UP 250ML	1	884394001337	1	1000	1	0	\N	\N
5411	PARMESANO QUILLAYES 100G 	1	7802930002504	1	1900	1	0	\N	\N
5412	PARMESANO MOZZARELLA EDAM QUILLAYES 100G	1	7802930002498	1	1900	1	0	\N	\N
5413	GRUYERE Y MOZZARELLA QUILLYES 100G	1	7802930002481	1	1900	1	0	\N	\N
5414	BEBIDA DE ALMENDRAS QUILLAYES 1L	1	7802930004430	1	2990	1	0	\N	\N
5407	+ENERGY POWER UP 250ML	1	884394003188	1	1000	1	0	\N	\N
5406	ALOE VERA OKF 240 ML	1	884394002532	1	1000	1	0	\N	\N
5401	ZUCARITAS KELLOYS 	1	7702103772282	1	4450	1	4100	\N	\N
5398	TRAGONA FRAMBUESA 220 G	1	7802000015311	1	2000	1	1600	\N	\N
5399	KRYSPO PICANTE 130G	1	7802800535910	1	1700	1	1600	\N	\N
5415	BEBIDA DE AVENA QUILLAYES 1 LT	1	7802930004454	1	2990	1	0	\N	\N
5416	BEBIDA DE ARROZ QUILLAYES 1LT	1	7802930004447	1	2990	1	0	\N	\N
5417	WHISKAS CARNE SOUFFLE 	1	7797453001489	1	650	1	0	\N	\N
5418	WHISKAS SABOR SALMON 85 GR	60	7797453000413	1	650	1	0	\N	\N
5433	AVENA MULTISEMILLA QUAKER	1	2000000001906	1	0	1	0	\N	\N
947	TIFFANY MAX 150GR	6	7802225430234	1	1200	1	0	\N	\N
5419	PHILADELPHIA ORIGINAL 180G	1	7622201797560	1	2500	1	0	\N	\N
5420	PALITO DE COCTEL GOOD FOOD 100U	1	777	1	700	1	0	\N	\N
5421	LECHE ENTERA CREMOSA 1 LT SOPROLE 	1	7802900002633	1	1000	1	0	\N	\N
5422	LAYS CORTE LISO 380 G	1	7802000014710	1	2900	1	0	\N	\N
5424	LECHE CULTIVADA PROTEIN+ 1LT	1	7802900002329	1	2500	1	0	\N	\N
5425	COCOA RAFF 300G	1	7802800531134	1	2100	1	0	\N	\N
5429	CHORITOS AL AGUA 425GRS MAR DEL SUR	1	7803505150132	1	2500	1	0	\N	\N
5430	CHORITOS EN ACEITE MAR DEL SUR	1	7803505140010	1	1300	1	0	\N	\N
5435	CHAMPIÑONES LAMINADOS  400 GRS WASIL	1	7801305003191	1	1800	1	0	\N	\N
5431	SURTIDO PARA CALDILLO MAR DEL SUR 	1	7803505140058	1	1400	1	0	\N	\N
5436	7802810006196	1	2000000001913	1	0	1	0	\N	\N
5437	CHAMPIÑONES ENTEROS  400 GR WASIL	1	7801305002446	1	1600	1	0	\N	\N
5427	CHORITOS AL ACEITE 425G MAR DEL SUR	1	7803505150118	1	2500	1	0	\N	\N
5438	YOGURTH AMERICANO DURAZNO	1	7802900002213	1	650	1	0	\N	\N
5439	PIZZA BENJITA	1	73718687301173718687	1	2200	1	0	\N	\N
5428	SURTIDO PARA CALDILLO MAR DEL SUR 425GRS	1	7803505150101	1	3100	1	0	\N	\N
5440	PIZZA BENJITA	1	2000000001920	1	0	1	0	\N	\N
5442	LYSOFORM 285 CM 	1	7790520990655	1	2300	1	0	\N	\N
5319	PAN HAMBURGUEZA O CHURRASCO BENJITA 10U	1	737186873011	1	2500	1	0	\N	\N
5441	SERVILLETAS ELITE 300 UDS	1	7806500225805	1	1990	1	0	\N	\N
5443	TRENTO	1	7896306623158	1	400	1	0	\N	\N
5444	TRENTO	1	7896306621208	1	400	1	0	\N	\N
5445	TRENTO	1	7896306618420	1	350	1	0	\N	\N
5426	LAYS JAMON SERRANO 200 G	1	7802000015427	1	2000	1	0	\N	\N
5432	DE TODITO 290G	1	7802000015199	1	2450	1	2400	\N	\N
5446	SOPROLE 115	1	7802900002206	1	400	1	0	\N	\N
5452	CEREAL QUINOA 30 GR	1	7803520002409	1	550	1	0	\N	\N
5453	CEREAL QUINOA 30 GR	1	7803520002393	1	550	1	0	\N	\N
5454	QUINOLA 30 GRS	1	7803520002416	1	550	1	0	\N	\N
520	BILZ ZERO 2.5LT RETORNABLE	5	7801620004941	1	1700	1	0	\N	\N
874	KEM RETORNABLE  2,5 LT CCU	5	7801620001889	1	1700	1	0	\N	\N
5455	OBLEA GULLON SIN AZUCAR 60G	1	8410376017687	1	850	1	0	\N	\N
5456	OBLEA GULLON SIN AZUCAR 60G	1	8410376037685	1	850	1	0	\N	\N
521	PAP ZERO RETORNABLE 2.5 LTS	5	7801620004903	1	1700	1	0	\N	\N
5457	HERSHEYS AO LEITE 92G	1	7899970400018	1	1600	1	1200	\N	\N
5458	HERSHEYS BLANCO 92GR	1	7899970400032	1	1600	1	1200	\N	\N
5459	TOSTADA CLASICA BAUDUCCO 142GR	1	7891962060453	1	1000	1	0	\N	\N
5460	CHARQUI EQUINO KIÑE 25 GR	1	2000000001937	1	1400	1	0	\N	\N
5461	CHARQUI EQUINO KIÑE 40 GR	1	2000000001944	1	2600	1	0	\N	\N
5477	GALLETAS BORTOLASO SURTIDO 320G	1	7802215146084	1	1400	1	0	\N	\N
5463	RAID INSECTICIDA MAX	1	7790520017444	1	4500	1	0	\N	\N
5464	TRAVERSO KETCHUP 450G	1	7802337910907	1	2100	1	0	\N	\N
5465	SALSA SABOR QUESO CHEDDAR 200G	1	7802095000650	1	1200	1	0	\N	\N
5466	AJI CREMAN TRAVERSO 450G	1	7802337910945	1	2300	1	0	\N	\N
5478	AMPOLLETA LED MEGABRIGHT A55	1	7804660913402	1	1000	1	0	\N	\N
5479	VELAS INVENA 4UN	1	7801815041362	1	900	1	0	\N	\N
518	ORANGE CRUSH RETORNABLE  2500 CC CCU	5	7801620001964	1	1750	1	1700	\N	\N
523	LIMON SODA RETORNABLE  2,5 LT CCU	5	7801620002305	1	1750	1	1700	\N	\N
515	BILZ RETORNABLE  2,5 LT CCU	5	7801620172800	1	1750	1	1700	\N	\N
5462	RAID MATA TODO INSECTO 360 CM	73	7790520007155	1	3790	1	3600	\N	\N
4874	RAID INSECTICIDA 222G	1	7790520017420	1	3790	1	3900	\N	\N
5447	POPCORN 270G	1	7802000012938	1	1900	1	1800	\N	\N
5450	DUO VAINILLA 500G	1	8410376036862	1	2400	1	2100	\N	\N
5449	DUO CACAO 500G	1	8410376044409	1	2400	1	2100	\N	\N
5451	TAKIS ORIGINAL 200G	1	757528044985	1	1500	1	0	\N	\N
5468	ARRUBA VIRUTILLA FINA MEDIANA GRADO 2	1	7805027000384	1	600	1	0	\N	\N
5469	JABONES LUX	1	8999999527563	1	500	1	0	\N	\N
5470	COLGATE 	1	8935236000031	1	1000	1	0	\N	\N
5471	PAÑO MULTIUSO 38X40	1	7806800007095	1	1300	1	0	\N	\N
5474	VIRUTILLA GRUESA MEDIANA  1 U VIRUTEX	73	7806810000048	1	1300	1	0	\N	\N
4605	DOÑA GABY	73	7804655191525	1	1890	1	0	\N	\N
5475	TODOS UNIDOS 370G	1	7702103772336	1	4800	1	0	\N	\N
5476	PROTEIN+SOPROLE	1	7802900002039	1	600	1	0	\N	\N
5481	CAJA MASCARILLA 50 UN 	1	2000000001951	1	2000	1	0	\N	\N
5482	FOSFOROS SEGURIDAD  10 UN COPIHUE	1	7806300010021	1	1900	1	0	\N	\N
5483	PACK X 3 PASTA DENTAL PEPSODENT 90 GR	78	7805000172497	1	2600	1	0	\N	\N
5484	NOBLE CON ROLLITOS	1	7806500508267	1	1250	1	0	\N	\N
5485	PILA DURACELL 2016	1	041333038889	1	1000	1	0	\N	\N
5486	GINGER ALE 2 LT DES	75	7801620360214	1	1300	1	0	\N	\N
5487	BON O BON BLANCO 110G	1	7802225590112	1	1100	1	0	\N	\N
5488	MANGO LAYS	1	7801620008796	1	1350	1	0	\N	\N
5489	NESCAFE DESCAFEINADO	1	7613032835811	1	5150	1	0	\N	\N
5493	PATE DE CAMPO RDA	1	7801907004404	1	650	1	0	\N	\N
5494	NECTAR MANZANA ANDINA DE VALLE 1LT	1	7802820700466	1	750	1	0	\N	\N
5495	CALDO MAGGI 	1	7613287221841	1	150	1	0	\N	\N
5173	EMPANADA POLLO MANDARIN 10 UNI	1	7604229110118	1	4400	1	0	\N	\N
1351	REPOLLITO CHICO 	12	627	2	350	1	0	\N	\N
5152	PANTY CAFFARENA ALMENDRA TALLA 2	1	7805810121272	1	1750	1	0	\N	\N
1277	MERMELADA FRUTILLA 250G LOS LAGOS 	28	7802810031174	1	650	1	600	\N	\N
1285	MERMELADA 250G DURAZNO LOS LAGOS	28	7802810031129	1	650	1	600	\N	\N
875	PEPSI ZERO DES.2 LTS	5	7801620006877	1	1100	1	1000	\N	\N
5504	ALOE PINEAPPLE 240 ML	1	884394001658	1	1000	1	0	\N	\N
5472	GUALLARAUCO TROPICAL	1	7803908001987	1	4000	1	0	\N	\N
5473	GUALLARAUCO MANJAR CHOCOLATE	1	7803908006746	1	4000	1	0	\N	\N
5163	PANTY CAFFARENA CHAMPAGNE TALLA 4	1	7805810185137	1	1750	1	0	\N	\N
5496	PAN BLANCO GRAN SANDWICH  700 GR IDEAL	24	7803473212238	1	2500	1	0	\N	\N
4514	ARROLLADO PRIMAVERA 10 UN.	1	2000000001722	1	3250	1	0	\N	\N
5382	ARROLLADO JAMON QUESO	1	2100000000488	1	3500	1	0	\N	\N
5497	PURE DE PAPAS INSTANTANEO MERKAT 125 G	1	7804638830007	1	900	1	0	\N	\N
5498	LASAÑA	1	7801930019987	1	1990	1	0	\N	\N
5499	MUBON 100G	1	7802800556038	1	950	1	0	\N	\N
5500	MUIBON COOKIES50G	1	7802800556090	1	950	1	0	\N	\N
5501	MAYONESA JANO 930GR DOYPACK	1	7802310000298	1	1650	1	0	\N	\N
5502	VELAS ESPIRAL 12 UN 	1	7805670702550	1	700	1	0	\N	\N
5410	ALOE VERA KING 240 ML	1	884394001511	1	1000	1	0	\N	\N
5503	ALOE GRAP 240 ML 	1	884394001597	1	1000	1	0	\N	\N
5505	ALOE STRAWBERRY 240 ML 	1	884394001559	1	1000	1	0	\N	\N
5506	CORNET COSMILK 	1	8697288400039	1	500	1	0	\N	\N
5507	CONFORT UNA HOJA 100 METROS 4 ROLLOS	1	7806500509592	1	3750	1	0	\N	\N
5508	NOVA	1	7806500401315	1	1500	1	0	\N	\N
5509	CREMISSIMO 2.4 L T	1	7802705400900	1	3490	1	0	\N	\N
5510	DORITO 100G	1	7802000015502	1	1000	1	0	\N	\N
5511	ZERO LACTO BATIFRUT	1	7802900001896	1	600	1	0	\N	\N
5512	TE SUPREMO ANIS 20U	1	7801875055057	1	1390	1	0	\N	\N
5513	SOPA INSTANTANEA 65 GR	1	6959237326275	1	700	1	0	\N	\N
5514	MARGARINA QUALY 250 G	1	7891515492816	1	790	1	0	\N	\N
720	LECHE POLVO SUPER  120 GR CALO	1	7802910003699	1	950	1	0	\N	\N
5515	HARINA INTEGRAL SELECTA 1 KG	1	7800120455291	1	1750	1	0	\N	\N
5516	HARINA SELECTA CON POLVO DE HORNEAR 1KG	1	7802615005103	1	1600	1	1350	\N	\N
5517	NESCAFE MEXICO 100GR 	1	7613038103563	1	3500	1	0	\N	\N
5518	3 QUINOA VIVO 250GR 	1	7800120749062	1	2650	1	2590	\N	\N
5519	NORI GOLD 	1	6947593018149	1	2500	1	0	\N	\N
5531	DURACELL 2032	1	041333038865	1	1000	1	0	\N	\N
3663	POLENTA CAROZZI 250G	1	7800120749055	1	1200	1	1100	\N	\N
5520	TALLARINES 87 400 GR	1	7802575034014	1	1500	1	950	\N	\N
5521	RAVIOLI ESPINACA 400GR	1	7802575047069	1	1950	1	0	\N	\N
3993	ESPIRALES MIX CAROZZI 400G	1	7802575031051	1	1350	1	950	\N	\N
5523	CORBATAS INTEGRAL 400GR	1	7802500222172	1	950	1	0	\N	\N
5524	ACEITE OLIVA TRATTORIA 500 ML	1	7802575204073	1	4790	1	0	\N	\N
5525	NESCAFE BRASIL 100GR 	1	7613038103754	1	3500	1	0	\N	\N
5526	NESCAFE COLOMBIA 100 GR 	1	7613038103679	1	3500	1	0	\N	\N
5528	TE CLUB NEGRO SUSTENTABLE 100U	1	7802420006012	1	3500	1	3200	\N	\N
5529	FERRERO 8 UDS 100G	1	7861002900117	1	4490	1	0	\N	\N
5532	NONITAS 125G 	1	7802408006089	1	650	1	0	\N	\N
2991	GOURMET BARBECUE 280G 	1	7802410400462	1	2100	1	0	\N	\N
5533	ALOE 1.5	1	884394002495	1	2500	1	0	\N	\N
5285	ARROZ MIRAFLORES LARGO ANCHO GRADO 2 1 KG	1	7802615006575	1	1690	1	1550	\N	\N
5534	CHEMMER 	1	4719867213190	1	300	1	0	\N	\N
5536	ENDER SOKITO	1	8682213004109	1	1000	1	0	\N	\N
5537	CEREJA MABU 100G	1	7896079820532	1	2800	1	0	\N	\N
5538	AVELA MABU 100G	1	7896079823731	1	2800	1	0	\N	\N
5539	TRUFAS MABU 100G	1	7896079827630	1	2800	1	0	\N	\N
5540	CROC CHOC 16G	1	7896383000811	1	400	1	0	\N	\N
1847	CHARQUI DE EQUINO 20G 	6	7804623100160	1	1200	1	0	\N	\N
4786	CHICLE ROLLO	1	6922996520260	1	300	1	0	\N	\N
5541	MOCRO USB FIDDLER 	1	7809601113118	1	2500	1	0	\N	\N
5542	MICRO USB FIDDLER 	1	7809601113149	1	2500	1	0	\N	\N
5543	MICRO USB FIDDLER	1	7809601113095	1	2500	1	0	\N	\N
5544	MICRO USB FIDDLER	1	7809601113125	1	2500	1	0	\N	\N
3973	LAVALOZAS EXCELL 1 LT 	1	7805020002057	1	1200	1	0	\N	\N
5545	MICRO USB FIDDLER	1	7809601113132	1	2500	1	0	\N	\N
5557	ESCOBILLON BRIGHT 	1	606110373340	1	2000	1	0	\N	\N
5273	SALSA BBQ SANTE 280ML	1	7804610401331	1	1990	1	1700	\N	\N
5527	LECHE EN POLVO COLUN DESCREMADA 350 GR 	1	7802920009872	1	2800	1	0	\N	\N
5546	LAYS OREGANO 200G	1	7802000015410	1	2300	1	2000	\N	\N
5535	REX ADHESIVO	1	7809593103807	1	700	1	0	\N	\N
2290	SWAN 6 ROLLOS 23. METROS 	1	7804653341045	1	1990	1	0	\N	\N
5547	JALEA 	1	7802200361171	1	350	1	0	\N	\N
5549	CABRITAS KIÑE 	1	0000000016	1	600	1	0	\N	\N
5550	DORITOS 172G	1	7802000015533	1	1500	1	0	\N	\N
5552	PAÑAL INDIVIDUAL BABYSEC 	1	7806500799542	1	300	1	0	\N	\N
5553	CHARQUI KIÑE 	1	2000000001968	1	1950	1	0	\N	\N
5554	DIN DON MINI 	1	7802215503535	1	250	1	0	\N	\N
5555	GALLETA TUAREG 48 GRS	47	78030299	1	250	1	0	\N	\N
5558	PAPAS PF 2.5 	1	7801930013879	1	4750	1	0	\N	\N
5032	JOHANY ALFAJORES 	1	2000000001814	1	4500	1	0	\N	\N
5559	VIVO DAMASCO 	1	7802200400108	1	1100	1	0	\N	\N
5133	JOHANY CUCHUFLI BLANCO 	1	5421578451	1	4500	1	0	\N	\N
5560	KINDER CHOCOLATE MAXI 21G	1	80050094	1	500	1	0	\N	\N
5561	CHOCO CRIKET	1	8682213000743	1	600	1	0	\N	\N
5562	BARRA FRUTOS SECO 35G	1	7793890254297	1	450	1	0	\N	\N
5563	WHISKAS CARNE	1	7797453000420	1	650	1	0	\N	\N
5575	DETERGENTE LIQUIDO MATIC 3L	1	7804663500005	1	3200	1	0	\N	\N
5576	DETERGENTE LIQUIDO MATIC 3L	1	7804663500012	1	3200	1	0	\N	\N
5565	PROTECTOR LADY SOFT 100 UN 	1	7806500963301	1	3590	1	0	\N	\N
5566	SOPROLE SIN AZUCAR 	1	7802900234232	1	350	1	0	\N	\N
5567	MUIBON GALLETA BLANCO 	1	7802800556410	1	400	1	0	\N	\N
5569	GOLD MOKA 	1	7802800503728	1	400	1	0	\N	\N
5570	CHAMPIÑON BLANCO 	1	781718789189	1	1700	1	0	\N	\N
5577	TEDDY 50X70	1	7808304315881	1	550	1	0	\N	\N
5578	DOVE GO FRESH 150ML	1	7791293033259	1	2900	1	0	\N	\N
5571	COSTA NUSS ALMENDRA SIN AZUCAR 110 G	1	7802215101472	1	2200	1	0	\N	\N
5579	DOVE GO FRESH	1	7506306241169	1	2900	1	0	\N	\N
5551	VIVO MORA 	1	7802200400085	1	1100	1	0	\N	\N
5568	NOSOTRAS ULTRA SUAVE 8 UN	1	7702026180355	1	800	1	750	\N	\N
5556	VELAS INVENA GRANDES	1	7801815041348	1	1900	1	1600	\N	\N
5564	GRETEL MANI 	1	7802215505348	1	1000	1	0	\N	\N
862	PRIVILEGIO BOLSA 252GR	6	7802225510264	1	2200	1	0	\N	\N
5580	DOVE DERMO ACLARANT	1	7506306241152	1	2900	1	0	\N	\N
1359	TRENZA RELLENA 	12	630	2	2800	1	0	\N	\N
5581	REXONA INVISIBLE	1	7791293022635	1	1950	1	0	\N	\N
3219	CACHANTUN MAS WOMAN 1,6 LTS	75	7801620007379	1	1300	1	0	\N	\N
5582	AGUA ALOE 	1	884394004550	1	1000	1	0	\N	\N
4766	AGUA WOMEN CIRUELA 1.6L	1	7801620008727	1	1300	1	0	\N	\N
5572	MR MUSCULO CITRUZ 450CM	1	7790520012524	1	2190	1	0	\N	\N
5573	MR MUSCULO LAVANDA 450CM	1	7790520012517	1	2190	1	0	\N	\N
5574	MR MUSCULO FLORAL 450CM	1	7790520012531	1	2190	1	0	\N	\N
5584	LAYS LIMON	1	7802000015380	1	600	1	0	\N	\N
5585	SOPROLE	1	47802900230296	1	250	1	0	\N	\N
5586	INPEKE NO RAYA	1	2000000001975	1	400	1	0	\N	\N
5589	GRIEGO 	1	2*7802900231804	1	400	1	0	\N	\N
5587	IMPEKE NO RAYA ESPONJA SPUNITA	1	2000000001982	1	400	1	0	\N	\N
5588	IMPEKE VIRUTILLA DE OLLA 	1	2000000001999	1	500	1	0	\N	\N
4827	LASAÑA PF 330G	1	7801930019925	1	2200	1	0	\N	\N
5591	ESPIRALES BOLOÑESA 300 GR	1	7801930022246	1	2000	1	0	\N	\N
5593	CARIOCA 	1	157802408015081	1	200	1	0	\N	\N
5594	CARIOCA	1	147802408015081	1	200	1	0	\N	\N
5595	CREMA MARISCOS 	1	7802950002256	1	690	1	0	\N	\N
5597	COLA CAO STEVIA	1	7802635001031	1	1300	1	0	\N	\N
5598	KINDER BUENO 21.5 G	1	8000500190012	1	500	1	0	\N	\N
5599	LA CREMERIA BROWNIE 	1	7613036568364	1	3900	1	0	\N	\N
5600	CASATA BRESLER 2.4 LT	1	7802705401020	1	3490	1	0	\N	\N
5601	YOGHURT TROZOS FRUTILLA  165 GR SOPROLE	1	7802900000301	1	600	1	0	\N	\N
5583	DORITO 285	1	7802000015632	1	2400	1	2200	\N	\N
1412	PAVO PIMENTON PF 	3	67	2	6000	1	4900	\N	\N
5590	MAGGI	1	7613031259823	1	690	1	0	\N	\N
1380	SALAME AHUMADO PF 	3	35	2	12500	1	12000	\N	\N
2207	PAPAS PREFRITAS 1K PF	1	7801930017822	1	2300	1	2000	\N	\N
5602	JABON ELITE HUMECTANTE 90 G 	1	7730219021338	1	1100	1	0	\N	\N
5603	JABON ELITE HUMECTANTE PACK 3	1	7806500982425	1	2000	1	0	\N	\N
5604	JABON LIQUIDO BRIGHT 900 ML 	1	781159480744	1	1400	1	0	\N	\N
5605	JABON LIQUIDO BRIGHT 900 ML 	1	781159480713	1	1400	1	0	\N	\N
5606	JABON LIQUIDO BRIGHT 900 ML 	1	781159480652	1	1400	1	0	\N	\N
5607	JABON LIQUIDO BRIGHT 900 ML 	1	781159480645	1	1400	1	0	\N	\N
5608	DESODORANTE AMBIENTAL BRIGHT 400 ML 	1	3894143695295	1	1400	1	0	\N	\N
5609	DESODORANTE AMBIENTAL BRIGHT 400 ML 	1	3894143695301	1	1400	1	0	\N	\N
5610	DESODORANTE AMBIENTAL BRIGHT 400 ML 	1	3894143695288	1	1400	1	0	\N	\N
5611	DESODORANTE AMBIENTAL BRIGHT 400 ML 	1	3894143695431	1	1400	1	0	\N	\N
5612	NOVA ULTRA 3 ROLLOS 	1	7806500405641	1	1550	1	0	\N	\N
4558	ESPONJA LISA BRIGHT 4U	1	606110373302	1	1000	1	0	\N	\N
5614	MOSTAZA DON JUAN 500G	1	7802351000844	1	1300	1	0	\N	\N
5616	RONSON ENCENDEDOR	1	7804612131557	1	700	1	0	\N	\N
4954	TERRA CAMOTES 180G	1	7802420004452	1	2500	1	0	\N	\N
2373	TERRA VEGETALES RUSTICOS 180G	1	7802420002694	1	2500	1	0	\N	\N
5615	CUADRITO ALMENDRA	1	59080497	1	300	1	0	\N	\N
5617	CABLE IPHONE A USB	1	7809601113156	1	2800	1	0	\N	\N
5618	ABLE IPHONE A USB 1 MT	1	7809601113163	1	2800	1	0	\N	\N
5596	TERRA MAIZ MORADO 180G	1	7802420005053	1	1000	1	0	\N	\N
5619	CABLE TIPO C A USB 1 MT	1	7809601113187	1	2800	1	0	\N	\N
5620	VELA 20 Y TANTOS	1	7805670177686	1	2250	1	0	\N	\N
5621	VELA 30 Y TANTOS	1	7805670177693	1	2250	1	0	\N	\N
5622	VELA 40 Y TANTOS	1	7805670177709	1	2250	1	0	\N	\N
5623	VELA 50 Y TANTOS	1	7805670182680	1	2250	1	0	\N	\N
5624	MIESKO WHISKY	1	5900353615683	1	4990	1	0	\N	\N
5625	MIESZKOB BRANDY	1	5900353615690	1	4990	1	0	\N	\N
5626	COTONITOS CHIKOOL	1	6920180300094	1	350	1	0	\N	\N
2062	PAVO  ACARAMELADO SOPRAVAL 	12	17	2	13000	1	8000	\N	\N
5613	ESPONJA LISA PACK 4U	1	3894143695516	1	1350	1	0	\N	\N
4654	TERRA 180G	1	7802420002915	1	2500	1	0	\N	\N
5640	TRAPERO DESINFECTANTE IGENIX 10 UNIDADES 	1	7805040004925	1	2990	1	0	\N	\N
5641	WHISKAS 	1	5*7797453000437	1	650	1	0	\N	\N
5642	CHOTIOS DEYCO 190G	1	7801534001661	1	1500	1	0	\N	\N
5628	BRIGHT	1	3894143695264	1	1400	1	0	\N	\N
5630	PIZZA	1	3*7801930013244	1	2200	1	0	\N	\N
5632	CHAMONIX 2.5	1	7613287192943	1	3500	1	0	\N	\N
5633	OTUNA EN AGUA 	1	7801230004416	1	1400	1	0	\N	\N
5634	MARUCHAN CAMARON	1	3*041789001987	1	850	1	0	\N	\N
5635	MARUCHAN CAMARON	1	041789001987	1	850	1	0	\N	\N
5636	NIKOLO	1	7802225538091	1	300	1	0	\N	\N
5638	CEPILLO DE DIENTES MR ORAL	1	6971667826811	1	1000	1	0	\N	\N
5639	FRUTILLAS EL VERGEL 	1	7801800107981	1	2100	1	0	\N	\N
5643	LAYS TARRO 	1	7802000009280	1	1600	1	0	\N	\N
1524	BOLSOS CON CORDEL DE REGALO DISEÑOS 32X26CM 	34	2000000000695	1	1000	1	0	\N	\N
5644	XERETA 	1	7896186300613	1	1000	1	0	\N	\N
5645	RITTER SPOT NUT SELECTION 100G	1	4000417701008	1	2400	1	0	\N	\N
5646	RITTER SPORT SEMI AMARGO 100G	1	4000417020000	1	2400	1	0	\N	\N
5647	RITTER SPORT CON LECHE 100G	1	4000417018007	1	2400	1	0	\N	\N
5648	BATIFRUT 	1	7802900000332	1	600	1	0	\N	\N
5649	ARROLLADO 	1	2100000000487	1	3250	1	0	\N	\N
1725	MILO  150 GRS NESTLE	44	7613030447979	1	1600	1	0	\N	\N
5651	VELA BRIGHT CHICA 	1	3894143695448	1	650	1	0	\N	\N
1173	QUESO CHEDDAR 160 GR LOS ALERCES	21	7802920005836	1	1290	1	0	\N	\N
5652	VELA BRIGHT GRANDE 	1	3894143695462	1	1700	1	0	\N	\N
5654	BETUN NEGRO 5 ML	1	6932872710104	1	1400	1	0	\N	\N
5627	BETUN VIRGINIA 	1	7805040112675	1	1300	1	0	\N	\N
5650	GALLETA MARIA GULLON 600 GR 	1	8410376040135	1	1800	1	1690	\N	\N
2461	BOLSOS DE REGALO CON CORDON 18X24	1	2000000001272	1	950	1	700	\N	\N
5637	TAKIS 200	1	757528044978	1	1500	1	0	\N	\N
5629	AJO	1	7802420004605	1	300	1	0	\N	\N
5655	AMPOLLETAS RAYOVAC 	1	783094061880	1	1300	1	0	\N	\N
5656	HELADOS INVIERNO CHOCOLATE 	1	7804628170120	1	4500	1	0	\N	\N
5657	HELADOS INVIERNO PAYASO COLOR 	1	7804628170083	1	4500	1	0	\N	\N
2399	HELADOS DE INVIERNO 	1	7804628170052	1	4500	1	0	\N	\N
5658	MANTEQUILLA LAS PRADERAS 	1	7804647450487	1	2500	1	0	\N	\N
5661	TE SUPREMO CEYLAN EXPRESS 100GR	1	7801875033048	1	1700	1	0	\N	\N
5653	BETUN PARA ZAPATOS MARRON	1	8434485175687	1	1650	1	0	\N	\N
5659	FRAMBUESA CHOCOLATE GUALLARAUCO 	1	7803908006654	1	1590	1	0	\N	\N
5660	WHISKAS 	1	7797453000437	1	650	1	0	\N	\N
5665	PALMITOS ENTEROS 400GR 	1	7802420510113	1	1600	1	0	\N	\N
5666	CHOCAPIC 350 GR 	1	7613287521507	1	2650	1	0	\N	\N
5667	TIKA NATIVAS 180 GR 	1	7804630010582	1	2500	1	0	\N	\N
5668	PROTEIN BARRA 	1	7804673910023	1	1050	1	0	\N	\N
5672	TIKA NATIVA 180 GR 	1	7804630010599	1	2500	1	0	\N	\N
5631	PIZZA PEPPERONI	1	7801930013244	1	3100	1	0	\N	\N
5675	BATIFRUT 	1	4*7802900002442	1	600	1	0	\N	\N
5676	SMOOTHIE 	1	884394008923	1	1500	1	0	\N	\N
5678	ACEITE CAÑUELAS 1 LT 	1	7792180008176	1	1850	1	0	\N	\N
1164	CHURRASCO VACUNO RECETA DEL ABUELO 120G 	1	7801930011028	1	1100	1	0	\N	\N
1161	PIZZA A LA PIEDRA JAMON QUESO  425 GR LA ESPAÑOLA	19	7801930013015	1	3100	1	0	\N	\N
5681	SNACK SALAMINI 100GR	1	7801930017242	1	1950	1	0	\N	\N
5012	PIZZAA SALAME 	1	7801930013305	1	3100	1	0	\N	\N
5679	SAL MERKAT 1 KG 	1	7803600000820	1	350	1	0	\N	\N
5663	CACAO DULCE COPACABANA 200GM	1	7802420520020	1	850	1	0	\N	\N
5664	CORAZONES DE ALCACHOFA ESMERALDA 400GR	1	7801315000197	1	2750	1	0	\N	\N
5674	CREMONA VARIEDADES	1	7802408005419	1	500	1	0	\N	\N
5680	SNACK MINI SALAMIN 60 GR	1	7801930021218	1	1500	1	0	\N	\N
5682	TORTILLAS PARA BURRITOS 8 UN. 	1	7801930017525	1	1850	1	1700	\N	\N
4320	PIZZA JAMON QUESO PF 465G	1	7801930010854	1	3490	1	3100	\N	\N
5673	MARISCO SURTIDO 500G	1	303010	1	2490	1	0	\N	\N
5677	MANGOS A LA CREMA SAN FRANCISCO 	1	7802926000903	1	6300	1	4500	\N	\N
5683	ENSALADA QUINOA PF 240RG	1	7801930016139	1	1800	1	0	\N	\N
5684	PASTEL DE CHOCLO 280GR	1	7801930013732	1	2500	1	0	\N	\N
5685	LASAÑA DE VERDURAS 375 GR 	1	7801930018416	1	2800	1	0	\N	\N
5671	MARAVILLA CONFITADA 	1	7804612220732	1	1400	1	1300	\N	\N
5688	MACARRONES BOLOÑESA	1	7801930009865	1	2100	1	0	\N	\N
5689	PAN COMPLETO BENJITA 10U	1	7777777	1	2000	1	0	\N	\N
5687	COMPOTA MANZANA Y PERA90G	1	7804655061026	1	450	1	0	\N	\N
5690	SAHNE NUSS 400G	1	7613287479976	1	7590	1	0	\N	\N
5691	ALCOHOL GEL ELITE 320ML	1	7806500981534	1	3200	1	0	\N	\N
5692	AUDIFONOS MAXELL STEREO BUDS 	1	025215498909	1	2000	1	0	\N	\N
5693	AUDIFONOS MAXELL STEREO BUDS 	1	025215498879	1	2000	1	0	\N	\N
5694	AUDIFONOS MAXELL STEREO BUDS	1	025215498893	1	2000	1	0	\N	\N
5695	TABLETA SUPER 8 130G	1	7613038598987	1	1500	1	0	\N	\N
5696	SQUARE CAFE 	1	59080473	1	300	1	0	\N	\N
5697	CRACKELET SNACK ORIGINAL 35G	1	7802215508592	1	250	1	0	\N	\N
5698	CRACKELET SNACK SEMILLAS 35G	1	7802215508615	1	250	1	0	\N	\N
5699	CRACKELET SNACK JAMON AHUMADO 35G	1	7802215508608	1	250	1	0	\N	\N
5701	ROLLS	1	7802215101816	1	1700	1	0	\N	\N
5702	ALOE 	1	8809041427638	1	1000	1	0	\N	\N
5704	COLGATE 50 GR	1	7702010111464	1	600	1	0	\N	\N
5705	SHAMPOO BALLERINA 	1	7804920002624	1	2000	1	0	\N	\N
5706	YOGHURT TROZOS PAPAYA  110 GR GRIEGO	1	7802900231804	1	400	1	0	\N	\N
5707	ACEITE DE OLIVA NUESTRA COCINA 250 ML 	1	6923256452246	1	2200	1	0	\N	\N
5708	ACEITE DE OLIVA NUESTRA COCINA 250 ML	1	7804632500210	1	2200	1	0	\N	\N
5716	ADES SOJA+JUGO DE ANANA	1	7790895643804	1	3300	1	0	\N	\N
5700	SIN GLUTEN CHIP CHOCO	1	8410376037883	1	2590	1	2400	\N	\N
5670	GRISINES CON CEBOLLA MORADA 120G	1	7840131003821	1	1500	1	0	\N	\N
5669	GRISINES CON CIBOULETTE SABOR MANTEQUILLA 120G	1	7840131003838	1	1500	1	0	\N	\N
5710	CHOCOLATE NUS 0 AZUCAR SAN FRANCISCO 1 LT	1	7802926001757	1	6300	1	4500	\N	\N
5709	VAINILLA SAN FRANCISCO 1  LT 	1	7802926001764	1	6300	1	4500	\N	\N
5711	CHAMPIÑONES ENTEROS 150 GR	11	2000000002002	1	1850	1	0	\N	\N
5712	ADES SOJA VAINILLA 1 LT	1	7790895643873	1	3300	1	0	\N	\N
530	RED BULL SUGARFREE 250 ML	5	9002490214852	1	1300	1	0	\N	\N
5718	AGUAS +	1	7801620007027	1	800	1	0	\N	\N
5720	DINOSAURIO MUSICAL 	1	2000000002019	1	2000	1	0	\N	\N
5721	MUÑECA EGGI	1	2000000002026	1	1500	1	0	\N	\N
5722	DRAGONBALL 	1	8435477906210	1	1500	1	0	\N	\N
5723	WATTS NECTAR PIÑA GUAYABA	1	7801620006174	1	950	1	0	\N	\N
5724	CEREZAS AL LICOR AMBROSOLI 8U	1	7802200848375	1	2500	1	0	\N	\N
5725	TOCINO PARRILLERO 	1	7801916039619	1	2500	1	0	\N	\N
5726	LARANJA	1	7896186300620	1	1000	1	0	\N	\N
5727	SVELTY DESCREMADA NESTLE 800G	1	7613032425616	1	5990	1	0	\N	\N
5728	HEARTS QUAKER 320G 	1	7802000012587	1	2290	1	0	\N	\N
5729	QUADRITOS QUAKER 340 GR	1	7802000014987	1	2890	1	0	\N	\N
5730	QUADRITOS QUAKER CANELA 342 GR 	1	7802000014970	1	2890	1	0	\N	\N
5731	SLIME FRASCO 	1	5690161324081	1	1500	1	0	\N	\N
5371	KANIKAMA 500G	1	7804635610237	1	2100	1	0	\N	\N
5732	BURBUJAS CON SILVATO 	1	2000000002033	1	1200	1	0	\N	\N
5733	HUEVO SLINE 	1	2000000002040	1	2000	1	0	\N	\N
5734	PROTEIN BARRA 	1	7804673910184	1	1050	1	0	\N	\N
5736	PIZZA CHORIZO 460G	1	7893000801608	1	3000	1	0	\N	\N
5737	COLA CAO 400G	1	7802635000508	1	2800	1	0	\N	\N
5738	CHOCO KRISPY 490G	1	7501008002131	1	3900	1	0	\N	\N
5740	ATUN EN AGUA  ESMERALDAS  170G	1	7802420510205	1	1100	1	0	\N	\N
5741	PRONTISSIMO CLASSICO 95G	1	8000070052581	1	5800	1	0	\N	\N
5742	PRONTISSIMO INTENSO 95G	1	8000070052635	1	5800	1	0	\N	\N
1134	VINAGRE MANZANA  500 CC TRAVERSO	15	7802337102302	1	1990	1	1600	\N	\N
3353	PASTA FRESH UP 130G	1	6957136500222	1	1200	1	0	\N	\N
837	GALLETA SODA FAMILIAR  180 GR COSTA	6	7802215501968	1	850	1	0	\N	\N
5735	PIZZA MIX DE QUESO 460G	1	7893000801363	1	3600	1	3000	\N	\N
5744	MANI SALADO 403G	1	7802000015519	1	2200	1	2000	\N	\N
5743	ZUCARITAS KELLOYYS 300GR 	1	7793306993413	1	2700	1	0	\N	\N
5745	JUGO EN CAJA	1	7802810006677	1	250	1	0	\N	\N
1357	BRAZO DE REINA VARIEDAD	12	620	1	6000	1	0	\N	\N
5746	TOALLA HUMEDAS	1	6942648910584	1	1000	1	0	\N	\N
5748	LOS ALERCES	1	7802920001029	1	1200	1	0	\N	\N
5750	CONFORT 22 MTS DOBLE HOJA 6 UND	1	7806500507642	1	1800	1	0	\N	\N
5751	CHORRITOS SAN JOSE 190G	1	7801235277112	1	1700	1	1560	\N	\N
5763	KRYZOI EMPANADA 	1	7802800533534	1	1600	1	0	\N	\N
5752	CHORITOS SAN JOSE AL NATURAL 100G	1	7801235276115	1	1560	1	0	\N	\N
5753	HUEVO OSITOS CARIÑOSITOS	1	8435477904940	1	1500	1	0	\N	\N
5754	HUEVO BABY SHARK 	1	8435477905756	1	1500	1	0	\N	\N
5755	FRAPELLA 55GR 	1	8697428018599	1	1100	1	0	\N	\N
5756	FRAPELLA TRIO STICKS 65GR	1	8697428018636	1	1600	1	0	\N	\N
5757	MUÑECA HUEVO 	1	2000000002057	1	2000	1	0	\N	\N
5759	HUEVO ACUATICO 	1	2000000002071	1	1500	1	0	\N	\N
5760	HUEVO DRAGON ARMABLE 	1	2000000002088	1	1500	1	0	\N	\N
5765	FROOTA SIN AZUCAR 150G	1	7803520140279	1	1400	1	0	\N	\N
5766	FROOTA SIN AZUCAR 150G	1	7803520140163	1	1400	1	0	\N	\N
5769	PROTEIN GRANOLA 350GR	1	781718976190	1	4350	1	0	\N	\N
5775	FILETILLO SIN MARINAR 1KG	1	7891515553715	1	4650	1	0	\N	\N
5771	SHAMPOO DOVE 	1	7891150062801	1	2500	1	0	\N	\N
5777	FERRERO CORAZON 100G	47	7898024395072	1	6200	1	0	\N	\N
1358	ROLLOS DE MANJAR NUEZ 	12	609	2	690	1	0	\N	\N
5778	CEPILLO FRESH UP	73	6926833001240	1	1000	1	0	\N	\N
5747	BABYSEC	1	7806500799504	1	3990	1	3500	\N	\N
5764	FROOTA SIN AZUCAR 150GRS	1	7803520140217	1	1650	1	1400	\N	\N
5767	FROOTAA SIN AZUCAR 	1	7803520140026	1	1650	1	1400	\N	\N
5768	FROOTA SIN AZUCAR 150G	1	7803520140200	1	1650	1	1400	\N	\N
5749	HOT DOG 480G	1	7803403003158	1	1650	1	1500	\N	\N
5770	MINI CHORIZO 60G	1	7801930021195	1	1950	1	1500	\N	\N
5776	HERSHEY 40 CACAU 92G	1	7899970400070	1	1600	1	1300	\N	\N
1456	PAN DE PASCUA ARTESANAL 	12	632	1	3700	1	3500	\N	\N
5772	WATSS	1	7801620006761	1	1350	1	0	\N	\N
5773	ALKA 	1	78022348	1	300	1	250	\N	\N
5779	AMERICAN SABRO MAYONESA 447G	1	860001535457	1	2400	1	0	\N	\N
5781	ALBONDIGAS SAN JOSE 240 GR	1	7801235002097	1	1850	1	0	\N	\N
5782	SAN JOSE MEDALLON DE JUREL 245G	1	7801235002318	1	1300	1	0	\N	\N
5758	PELOTA SALTARINA	1	2000000002064	1	1600	1	0	\N	\N
5761	AUTO TRANSFORMER	1	2000000002095	1	2000	1	0	\N	\N
5783	QUILLAYES CREMA CHANTILLY CHOCOLATE 250G	1	7802930004720	1	3390	1	0	\N	\N
5784	QUILLAYES CHANTILLY SIN LACTOSA 250G	1	7802930002610	1	3600	1	0	\N	\N
5785	QUILLAYES NARANJA 100 FRUTA	1	7899916913244	1	3390	1	0	\N	\N
5786	QUILLAYESNATURAL ONE 	1	7899916913282	1	3390	1	0	\N	\N
877	CACHANTUN SIN GAS BIDON 6 LT	5	7801620005054	1	1700	1	0	\N	\N
5787	GLOBOS KIKO 50 U	1	7806130006898	1	3300	1	0	\N	\N
5788	GLOBOS 18SEP	1	8985517564769	1	1400	1	0	\N	\N
5789	BOLSA DE REGALO 32X44	1	7801298232448	1	1900	1	0	\N	\N
5790	BOLSA DE REGALO 26X32	1	6969347811257	1	1100	1	0	\N	\N
5791	COLES NEGROS 6U	1	2000000002118	1	650	1	0	\N	\N
5792	TAPSIN DIA	1	78039957	1	250	1	0	\N	\N
5793	TAPSIN NOCHE	1	78005853	1	250	1	0	\N	\N
5794	ESCOBILLA PLASTICA 	1	2000000002125	1	650	1	0	\N	\N
5795	PAPEL DE REGALO 	1	2000000002132	1	300	1	0	\N	\N
5796	CANELA EDRA 	1	7802420004674	1	500	1	0	\N	\N
5797	TE NEGRO ARANDANO Y MAQUI 40G	1	7801875002150	1	2350	1	0	\N	\N
5798	TE VERDE CON MORINGA JENGIBRE Y LIMON 40G	1	7801875002167	1	2350	1	0	\N	\N
5801	DESINFECTANTE +MATA 99.9 DE LAS BACTERIAS 360ML	1	7804947003536	1	1800	1	0	\N	\N
5802	WYN VIDRIO Y MULTIUSO 750ML	1	7804609730404	1	2400	1	0	\N	\N
5803	TEST DE EMBARAZO	1	7800078000345	1	2200	1	0	\N	\N
3924	PIÑAS EN RODAJA ESMERALDA 567G	1	7801315151516	1	1850	1	0	\N	\N
5799	IKON ROSE 	1	78026414	1	3800	1	3500	\N	\N
5800	IKON TROPICAL 	1	78026438	1	3800	1	3500	\N	\N
5804	PEDIGREE DENTASTIX 45G	1	7896029052327	1	990	1	0	\N	\N
5805	PEDIGREE DENTASTIX 110G	1	7896029052334	1	1600	1	0	\N	\N
5806	PEDIIGREESTIX 179.9	1	7797453971843	1	1900	1	0	\N	\N
5807	ARENA SANITARIA ECOLOGICA TOP.K9 2KG	1	7803948000612	1	2650	1	0	\N	\N
5809	MR BIG JIRAFA 2.5 LITROS	54	7804646000256	1	3600	1	0	\N	\N
5810	CBSE YERBA MATE 500GR	1	7790710334603	1	3000	1	0	\N	\N
5812	LAYS 110G	1	7802000015694	1	1200	1	1000	\N	\N
5811	MIMOSA CLASICA 8 UN	1	7794626996740	1	650	1	0	\N	\N
4165	PROTECTOR DIARIO KOTEX 20 UN. 	1	7793620003546	1	800	1	0	\N	\N
5813	SALSA INFIERNO RED 200 GR	1	7802351002053	1	2200	1	0	\N	\N
5814	SPICY CHEDAR INFIERNO 150G	1	7802351001995	1	1200	1	0	\N	\N
5818	CACHANTUN	1	7801620008543	1	1050	1	0	\N	\N
5821	AJI PEBRE 250 GR	1	7802351241025	1	1100	1	0	\N	\N
5822	REGIO 4 ROLLOS	1	7804670690089	1	1000	1	0	\N	\N
5820	TUCAPEL 1 G	1	7801420001690	1	1750	1	0	\N	\N
5819	AGUA MAS	1	7801620008536	1	1050	1	0	\N	\N
5823	SUCRALOSA MERKAT	1	7809558103057	1	2250	1	0	\N	\N
5824	POROTOS NEGROS IANSA 	1	7801505003045	1	1400	1	0	\N	\N
5825	MANTEQUILLA HUILCO 200GR	1	7804647570642	1	2100	1	0	\N	\N
5826	CACHANTUN 	1	7801620008581	1	1050	1	0	\N	\N
5827	DIS FRUTT	1	7613287766755	1	500	1	0	\N	\N
5828	SALSA DE TOMATE TRAVERSO 200G	1	7802337410001	1	250	1	0	\N	\N
5829	AMPOLLETAS RAYOVAC 6W	1	783094061866	1	1100	1	0	\N	\N
5830	MANGO MARACUYA	1	7801620006181	1	950	1	0	\N	\N
2050	PILA ALCALINA DURACELL D UNIDAD	56	041333000985	1	1900	1	0	\N	\N
5831	CARRE 140G 	1	7591016850305	1	500	1	0	\N	\N
5832	CHOCOLATE CARRE 100 GR	1	7591016852101	1	1990	1	0	\N	\N
5833	AGUA MAS	1	7801620008529	1	1050	1	0	\N	\N
5808	MR. BIG LATA 500CC	54	9120033164799	1	1300	1	1100	\N	\N
5817	GARNIER 	1	7898587775908	1	2200	1	2000	\N	\N
5816	LOTUS BISCOFF 250GR	1	5410126716016	1	2490	1	0	\N	\N
5834	STAR MATIC 5L	1	2000000002156	1	2200	1	0	\N	\N
5835	BALLLERINA	1	7804920003454	1	2000	1	0	\N	\N
5836	AGUA MAS	1	7801620005788	1	1050	1	0	\N	\N
5839	QUILLAYES QUESO CHACRA 500G	1	7802930000920	1	2700	1	0	\N	\N
5840	YBARRA MAYONESA 426G	1	8410086315035	1	2950	1	0	\N	\N
5841	AMORETTA DESSERTS CHOCOLATE 189G	1	5900353645895	1	9990	1	0	\N	\N
5843	AGUA MAS 	1	7801620009106	1	1050	1	0	\N	\N
3695	ESTUCHE AMOUR PISTACHO 116G	1	5900189006501	1	3990	1	0	\N	\N
5846	ARROZ CALLAO 1KL	1	7804605040040	1	1200	1	0	\N	\N
2132	LA GOTITA 2ML 	1	77317186	1	1990	1	0	\N	\N
5844	ACONDICIONADOR	1	7804920005823	1	2000	1	0	\N	\N
5847	MIGA SANDWICH 440G CASTAÑO	1	7803468003056	1	2450	1	0	\N	\N
5848	CALABAZA MIX 400G CASTAÑA	1	7803468000123	1	1500	1	0	\N	\N
5849	LINAZA CHIA 400G CASTAÑO	1	7803468003025	1	1500	1	0	\N	\N
5845	INCA KOLA RETORNABLE 2L	1	7801610237632	1	1000	1	0	\N	\N
5850	MULTIGRANO 400G CASTAÑO	1	7803468002257	1	1500	1	0	\N	\N
5852	PAN INTEGRAL SIN LACTOSA 630G	1	7803468001519	1	2100	1	0	\N	\N
5853	PAN BLANCO 630G CASTAÑO	1	7803468001496	1	2100	1	0	\N	\N
5854	PRE PIZZA CLASICA 250G CASTAÑO 	1	7803468003087	1	900	1	0	\N	\N
5855	PAN HAMBURGUEZA 460G	1	7803468002905	1	1700	1	0	\N	\N
5856	PITA INTEGRAL 300G	1	7803468002523	1	1250	1	0	\N	\N
5858	SWEETEE SIN AZUCAR 	1	614143816192	1	1850	1	0	\N	\N
5859	PULPA DE FRUTILLA 333G	1	7803908000645	1	1950	1	0	\N	\N
5860	ENERGIZER A23	1	8888021300376	1	300	1	0	\N	\N
5851	PAN HOT DOG XL 480G CASTAÑO	1	7803468001427	1	1500	1	0	\N	\N
5861	CACHANTUN MAS 	1	7801620008550	1	1050	1	0	\N	\N
5865	LAVALOZA IMPEKE 300 ML	1	7806810002417	1	600	1	0	\N	\N
5842	CHETTO	1	7802000015779	1	1200	1	1000	\N	\N
5863	PIZZA PEPPERONI 430G	1	7801930010908	1	3490	1	3100	\N	\N
5857	SAN FRACISCO FRUTOS DEL BOSQUE 0 AZUCAR 	1	7802926001771	1	6300	1	4500	\N	\N
5862	DANKY	1	7613287792143	1	1690	1	1590	\N	\N
5866	POPEYE 400 G	1	7805045002353	1	1290	1	0	\N	\N
5867	DETERGENTE POPEYE 800 ML	1	7805045000205	1	3900	1	0	\N	\N
1487	MORRON ROJO 	11	2000000000572	1	1300	1	0	\N	\N
5870	QUESO CREMA 	1	7802900001261	1	900	1	0	\N	\N
5871	TE SUPREMO CANELA 	1	7801875055019	1	1200	1	0	\N	\N
5872	TRENDY	1	7801552004057	1	2090	1	0	\N	\N
5873	AGUA MS	1	7801620008512	1	1050	1	0	\N	\N
5874	FRUGELE	1	7802705400948	1	300	1	0	\N	\N
5875	TE BAILAHUEN 20U SUPREMO	1	7801875058010	1	1390	1	0	\N	\N
5876	TE HIERBA MELISA 20U 	1	7801875001979	1	1390	1	0	\N	\N
5877	CHAI	1	614143816185	1	1850	1	0	\N	\N
5878	BRIGH	1	3894143695479	1	1990	1	0	\N	\N
1486	MORRON VERDE 	11	2000000000565	1	1300	1	0	\N	\N
5880	CHOCOLATE JAZZ	1	8697288501675	1	550	1	0	\N	\N
5762	ANTIESTRES 	1	2000000002101	1	1600	1	0	\N	\N
5881	CHOCOLATE ZARINA 	1	8682213005083	1	550	1	0	\N	\N
5882	CHOCOLATE BISCUITO 	1	8697288505178	1	550	1	0	\N	\N
5883	TROMPO LUZ 	1	2000000002163	1	2500	1	0	\N	\N
5884	MUÑECA CUP CAKE 	1	2000000002170	1	2000	1	0	\N	\N
5885	DEFORMER CAR	1	2000000002187	1	2500	1	0	\N	\N
5886	CASTAÑO DUO 760 G	1	7803468001779	1	2250	1	0	\N	\N
5887	PIÑA GRANADINA 204L	1	7802705401211	1	4490	1	0	\N	\N
5864	HUEVO MINIONS 	1	8435477905398	1	1300	1	0	\N	\N
5888	SOPA INSTANTANEA SABOR CAMARON	1	7804628245408	1	600	1	0	\N	\N
5889	SOPA INSTANTANEA SABOR QUESO	1	7804628245415	1	600	1	0	\N	\N
5890	MOSTAZA HEINZ	1	7802351001049	1	1850	1	0	\N	\N
5891	POROTO HALLADO MERKAT 1 KG	1	7808743603297	1	2200	1	0	\N	\N
3397	POROTO HALLADO BONANZA 1KG	1	7808743602474	1	2790	1	0	\N	\N
5869	CONFORT DOBLE HOJA 6 ROLLOS 	1	7806500508755	1	2200	1	0	\N	\N
2979	PASTA DENTAL ANTICARIES  108,8 GRS COLGATE	73	7509546009179	1	1200	1	1190	\N	\N
5879	COMPOTA	1	7804655061316	1	450	1	0	\N	\N
5892	LENTEJAS MERKAT 500 GR	1	7809637200967	1	990	1	0	\N	\N
5893	CIF CLORO 750 GR	1	7791290010772	1	2600	1	0	\N	\N
5894	4 ESPONJAS LISA CLOROX 	1	7702137005523	1	1100	1	0	\N	\N
5896	ACTIV	1	7802900284305	1	500	1	0	\N	\N
5898	MAS PIÑA	1	7801620008574	1	1050	1	0	\N	\N
5899	SAL LIGHT 1 KG 	1	7803600000462	1	1150	1	0	\N	\N
5900	AJI PEBRE 450 GR 	1	7802337910938	1	2300	1	0	\N	\N
4503	ARROZ CAMPESINO MIRAFLORES 210GR	1	7800120176769	1	1100	1	0	\N	\N
5467	MOSTAZA TRAVERSO 450G	1	7802337910921	1	2300	1	0	\N	\N
5901	ARROZ BANQUETE  G2 1 KG 	1	7803110102236	1	1600	1	0	\N	\N
5902	ACEITE DE OLIVA TERRA SANTA 250 ML 	1	7804609780003	1	3000	1	0	\N	\N
5903	DESODORANTE NIVEA 	1	4005808662388	1	2700	1	0	\N	\N
5904	DESODORANTE NIVEA 	1	4005808715688	1	2700	1	0	\N	\N
5905	DESODORFANTE NIVEA 	1	4005808231065	1	2700	1	0	\N	\N
5066	NIVEA DRY SILVER 150 ML 	1	4005808305964	1	2700	1	0	\N	\N
5906	DESODORANTE NIVEA 	1	4005808979677	1	2700	1	0	\N	\N
5907	DESODORANTE NIVEA 	1	4005900515933	1	2700	1	0	\N	\N
5908	SOPA INSTANTANEA DE POLLO 64 G 	1	059491002505	1	750	1	0	\N	\N
5909	DESODORANTE NIVEA 	1	4005900515872	1	2700	1	0	\N	\N
5912	LAYS 200 GR 	1	7802000012402	1	1500	1	0	\N	\N
2726	DETERG. LIQUIDO MATIC 5 LT 	1	7804663500050	1	2200	1	0	\N	\N
5910	DUO CAKE 34G	1	7891962055732	1	250	1	0	\N	\N
5911	ROTOS AZUCARADOS DISLAC	1	7804669193065	1	1400	1	0	\N	\N
5913	DULCE DE LECHE LA SERENISIMA 400GR 	1	7790742140609	1	2200	1	0	\N	\N
3712	SAL PARRILLERA LOBOS 	1	7803600002190	1	2100	1	0	\N	\N
703	SAL PARRILLERA  750 GR LOBOS	1	7803600981532	1	1500	1	0	\N	\N
3444	QUESO HUILCO GOUDA LAMINADO 500G	1	7804647570086	1	4400	1	4200	\N	\N
2021	HUILCO GOUDA LAM. 250G 	1	7804647570079	1	2500	1	0	\N	\N
5895	MEGA 	1	7613287793881	1	1990	1	1590	\N	\N
5897	DANKY	1	7613287792174	1	1690	1	1590	\N	\N
2576	QUESO CHACRA FUNDO BRAMADERO 400G 	1	7802911000000	1	2500	1	2300	\N	\N
5914	ACTIV	1	4*7802900228453	1	400	1	0	\N	\N
5915	ACTIV	1	7802900228453	1	400	1	0	\N	\N
5916	NECTAR DAMAZCO	1	7801620011673	1	650	1	0	\N	\N
5917	CEPILLO DENTAS NIÑO AUTO	1	6971667823339	1	1650	1	0	\N	\N
5918	CEPILLO DENTAL NIÑA 	1	6936145900070	1	1650	1	0	\N	\N
5919	VELAS MAGIC 10U	1	6933696871279	1	650	1	0	\N	\N
5920	CABLE PLUZZ	1	6820210024986	1	2150	1	0	\N	\N
5921	BOLSA DE REGALA  24X32CM	1	6972526711323	1	1000	1	0	\N	\N
5922	PALOS DE BROLLETA 	1	5056282247300	1	990	1	0	\N	\N
5924	DESINFECTANTEHOME 	1	7804947003543	1	2500	1	0	\N	\N
5925	PAN DE MOLDE BLANCO 	1	737186873035	1	2000	1	0	\N	\N
5926	ESPONJA MAGICA BRIGHT X3	1	606110373326	1	1200	1	0	\N	\N
5927	ZUKO 	1	7802800570799	1	200	1	0	\N	\N
5928	SUPER CHILENITO HELADO 	1	2000000002194	1	300	1	0	\N	\N
5929	ANDINA DEL VALLE 2 L T 	1	7802820210118	1	1500	1	0	\N	\N
5930	ACTIV	1	7802900228422	1	500	1	0	\N	\N
5931	ANDINA 	1	7802820210521 	1	1500	1	0	\N	\N
5932	FANTA DES 3LT	1	7801610671313	1	2400	1	0	\N	\N
5933	PROTEIN MAS	1	*7802900002107	1	550	1	0	\N	\N
5934	DORITOS 100G	1	7802000015748	1	1200	1	1000	\N	\N
5935	ANDINA DEL VALLE 2L ZERO AZUCAR NARANJA	1	7802820210729	1	1500	1	0	\N	\N
5936	BRESLER PIÑA	1	7802705401051	1	2990	1	2390	\N	\N
5937	COMINO MOLIDO 100G	1	7802420005275	1	1200	1	0	\N	\N
5938	DETERGENTE MATIC 3KG	1	7804663500180	1	2990	1	0	\N	\N
5940	PAN PARRILLERO 13UNI	1	7803468001441	1	1350	1	0	\N	\N
5941	MOTO 4X4	1	2000000002200	1	3000	1	0	\N	\N
5943	ENCENDEDOR 	1	4891761183103	1	300	1	0	\N	\N
5945	VIVO BERRIES 190 ML	76	7802575220479	1	400	1	0	\N	\N
5946	VIVO PIÑA 190 ML	76	7802575220455	1	400	1	0	\N	\N
5947	QUINOA 1 GK 	1	7800120749048	1	4290	1	0	\N	\N
5944	FROOTA 	1	7803520140194	1	1650	1	1400	\N	\N
5939	MINI TOAST 90G	1	7803468002486	1	1500	1	0	\N	\N
1279	LECHE CHOCOLATE  1 LTS SOPROLE	21	7802900050078	1	1500	1	0	\N	\N
5949	CREMA CHANTILLY	1	7802930002580	1	3750	1	0	\N	\N
5948	PLATOS PLASTICOS UNIDAD 	1	2000000002217	1	150	1	0	\N	\N
5950	NATURAL VEGGIES 900ML	1	7899916911905	1	3350	1	0	\N	\N
5951	VIVO 	1	3*7802575220516	1	300	1	0	\N	\N
5953	PROTEIN	1	7804673910191	1	1050	1	0	\N	\N
5952	VIVO	1	7802575220516	1	400	1	0	\N	\N
5954	DOBLE QUIFAROS CAROZZI	1	7802575001047	1	1300	1	800	\N	\N
5955	QUIFAROS CAROZZI	1	7802575011336	1	1300	1	800	\N	\N
5956	CAPELLINI CAROZZI	1	7802575001849	1	800	1	0	\N	\N
5957	MOSTACHO  400 GRS LUCCHETTI	1	7802500001067	1	1300	1	800	\N	\N
5958	RIGATONI DON VITTORIO	1	7750243294867	1	890	1	0	\N	\N
5959	MARIPOSA  250 GR CAROZZI	1	7802575006455	1	900	1	800	\N	\N
5960	BARILLA ARRABBITA 400G	1	8076809513388	1	2250	1	0	\N	\N
5962	PROTEIN	1	7804673910030	1	1050	1	0	\N	\N
5963	QUESO GAUDA FRUTILLAR 250 GR	1	7801930019192	1	2300	1	0	\N	\N
5964	YOGURT SOPROLE CON TROZOS	1	7802900000950	1	450	1	0	\N	\N
5967	ALMENDRA SIN AZUCAR  1L	1	7790742340306	1	2690	1	0	\N	\N
5968	SUNY 	1	7802705401303	1	800	1	0	\N	\N
5969	PINGUINOS	1	7501030425953	1	250	1	0	\N	\N
5719	MASCOTA 	1	4606998037132	1	1000	1	0	\N	\N
5973	ANTARTIC	1	084773470079	1	1400	1	0	\N	\N
2810	PEPSODENT 130G	1	7805000180881	1	1800	1	0	\N	\N
5975	PF HAMBURGUESA	1	7801930021959	1	500	1	0	\N	\N
5965	CAFE DESCAFEINADO GOLD 100 GR	1	7802800500826	1	3990	1	0	\N	\N
5974	PIMIENTA NEGRA ENTERA	1	7802420810169	1	450	1	0	\N	\N
1181	LECHE SEMID.FRUTI 1 LT COLUN	21	7802920007137	3	1550	1	0	\N	\N
5966	FRAC NARANJA 130 GR 	1	7802215502576	1	700	1	600	\N	\N
1265	LECHE ENTERA  1 LTS COLUN	21	7802920777542	3	1150	1	0	\N	\N
5961	TAKIS	1	757528044992	1	1500	1	0	\N	\N
5970	DOBLON 	1	7802705401334	1	400	1	350	\N	\N
5971	FLIPY	1	7802705401327	1	450	1	0	\N	\N
5977	EL VERGEL DURAZNOS MITADES	1	7801800107912	1	1650	1	1100	\N	\N
5979	SCOOTT	1	7809604029683	1	1000	1	0	\N	\N
5980	JABON LIQUIDO BALLERINA 500 ML	1	7804920005939	1	1490	1	0	\N	\N
5981	JABON LIQUIDO BALLERINA 500 ML	1	7804920005946	1	1490	1	0	\N	\N
5982	JABON LIQUIDO BALLERINA 500 ML	1	7804920005786	1	1490	1	0	\N	\N
5983	NECTAR ZUKO 200 ML	1	7802800575237	1	400	1	0	\N	\N
5985	ALOE DRINK 1.5	1	8809041427621	1	2500	1	0	\N	\N
5988	NECTAR ZUKO 200ML	1	7802800575251	1	400	1	0	\N	\N
5989	NECTAR ZUKO 200ML	1	7802800575213	1	400	1	0	\N	\N
5423	FLAGG	1	7801552003975	1	850	1	0	\N	\N
5490	CONEIRO TRENDY 70G	1	3*7801552006389	1	950	1	0	\N	\N
5991	HAMBURGUESA DE POLLO PF 100 GR	1	7801930021874	1	500	1	0	\N	\N
5992	PAN MOLDE BLANCO 	1	7803468001489	1	2000	1	0	\N	\N
5993	DELI MIX 80G	1	7802420002731	1	1300	1	0	\N	\N
6001	COLUN FLAN 100G	1	78013339	1	350	1	0	\N	\N
6002	COLUN LAN CHOCOLATE 100G	1	78013315	1	350	1	0	\N	\N
6003	VIVO MIFRUT 85G COMPOTA	1	7802200270114	1	450	1	0	\N	\N
2213	COMPOTA VIVO DURAZNO 90GR.	1	7802200270015	1	450	1	0	\N	\N
6004	VIVO MIFRUT COMPOTA CON AVENA 85G	1	7802200270381	1	450	1	0	\N	\N
3773	COMPOTA VIVO MANZANA 90GR.	1	7802200270022	1	450	1	0	\N	\N
5994	MARSH MALLOWS 230G	1	7802200129115	1	1500	1	0	\N	\N
5978	QUAKER AVENA MULTISEMILLAS  600G	1	7802000015021	1	2990	1	2650	\N	\N
3772	COMPOTA VIVO PERA 90GR.	1	7802200270039	1	450	1	0	\N	\N
5986	GALLETA SUNY 120 GR 	1	7802215502569	1	650	1	0	\N	\N
5837	COMPOTA	1	7804655061156	1	450	1	0	\N	\N
5686	COMPOTA MANZANA Y PLATANO NATURELL 90G	1	7804655061163	1	450	1	0	\N	\N
5987	MANI LA BOLSAZA JAP.EVERCRISP	1	7790310984901	1	1500	1	1000	\N	\N
5972	LOOP HELADO	1	7802705401310	1	400	1	350	\N	\N
4528	MINI CONO 46 GR 	1	7801552001803	1	500	1	450	\N	\N
5990	HAMBURGUESA VACUNO MONTINA 150G	1	7804115001883	1	1200	1	1100	\N	\N
5984	LOMITO DE CERDO MONTINA 90GR	1	7804115001906	1	900	1	800	\N	\N
5995	VELAS	1	7801815041379	1	1200	1	0	\N	\N
5996	RIVEROS 	1	737186873059	1	2000	1	0	\N	\N
5997	COLUN LIGHT 125G	1	4*7802920001296	1	300	1	0	\N	\N
5999	COLUN LIGTH	1	7802920001296	1	300	1	0	\N	\N
6000	COLUN LIGTH VAINILLA 125G	1	7802920001074	1	300	1	0	\N	\N
6010	AUDIFONOS MLAB	1	6927900077229	1	2200	1	0	\N	\N
4053	COLUN LIGHT 125G	1	7802920000916	1	300	1	0	\N	\N
6011	AUDIFNOS MLAB	1	6927900077212	1	2200	1	0	\N	\N
34	TUCAPEL GRAN SELECCION GRADO 1,  1KG. 	1	7801420250142	1	1850	1	1800	\N	\N
6012	AUDIFONOS MLAB 	1	6927900077243	1	2200	1	0	\N	\N
2137	BOLSAS REUTILIZABLES ROJAS CHICAS  	1	2121	1	350	1	0	\N	\N
6008	AUDIFONOS MLAB 	1	6927900077236	1	2200	1	0	\N	\N
6009	AUDIFONOS MLAB 	1	6927900077250	1	2200	1	0	\N	\N
6013	USB TIPO C	1	6927900080069	1	2700	1	0	\N	\N
6014	USB TIPO C	1	6927900080076	1	2700	1	0	\N	\N
6015	USB TIPO C	1	6927900080052	1	2700	1	0	\N	\N
2602	TOALLA FEMENINA REGULAR C/ALAS NATURELLA 	73	7506309895208	1	990	1	0	\N	\N
6016	GEORGALOS CHOCOLATE	1	7790380024859	1	1900	1	0	\N	\N
6017	GEORGALOS CHOCOLATE BLANCO 	1	7790380024958	1	1900	1	0	\N	\N
6018	GEORGALOS  CON ALMENDRAS 70G	1	7790380024941	1	1900	1	0	\N	\N
6020	JABON HUMECTANTE ELITE 230ML 	1	7806500982401	1	1850	1	0	\N	\N
6036	PISTACHOS CASALINGA 180 GR	1	781159477676	1	4600	1	0	\N	\N
6037	CASTAÑAS DE CAJU 180 GR CASALINGA	1	781159477638	1	4600	1	0	\N	\N
6038	AVENA INSTANTANEA 500 GR 	1	7802615002034	1	1400	1	0	\N	\N
6039	HELADO NESTLE MANJAR	1	7613287794017	1	450	1	0	\N	\N
1323	PAN AMASADO 	8	7	2	2100	1	1750	\N	\N
1326	PAN FRICA 	8	10	2	2100	1	1750	\N	\N
6019	JABON HUMECTANTE ELITE 700 ML 	1	7806500982432	1	2190	1	0	\N	\N
6007	TAKIS EXPLOSION 56G	1	757528039639	1	650	1	0	\N	\N
6005	TAKIS 56G	1	757528039615	1	650	1	0	\N	\N
6006	TAKIS FUEGO 56G	1	757528039592	1	650	1	0	\N	\N
6021	NOVA GIGANTE 100M	1	7806500406365	1	5300	1	0	\N	\N
6023	MIX TORINO 60 GR	1	781159477485	1	990	1	0	\N	\N
6024	MANI TOSTADO CUBIERTO CHOCOLATE60GR	1	781159477751	1	1350	1	0	\N	\N
6025	CRANBERRIES CUBIERTO CHOCOLATE 60GR	1	781159477744	1	1500	1	0	\N	\N
6026	ALMENDRAS CUBIERTASCON CHOCOLATE 60 GR	1	781159477737	1	1650	1	0	\N	\N
6027	MIX ROMA 180 GR	1	781159477430	1	2850	1	0	\N	\N
6028	MIX TORINO 200 GR	1	781159477423	1	2450	1	0	\N	\N
6029	ALMENDRAS CUBIERTAS CHOCOLATE 200 GR	1	781159477706	1	4500	1	0	\N	\N
6030	MANI TOSTADO CUBIERTO CHOCOLATE 200 GR	1	781159477782	1	3800	1	0	\N	\N
6031	MIX MILAN 180 GR	1	781159477447	1	3350	1	0	\N	\N
6032	MIX GENOVA 180 GR	1	781159477416	1	2750	1	0	\N	\N
6033	CRANBERRIES CUBIERTOS CHOCOLATE 200 GR	1	781159477768	1	4200	1	0	\N	\N
6034	MIX VENECIA 200 GR	1	781159477409	1	2700	1	0	\N	\N
6035	MIX FLORENCIA 200 GR	1	781159477393	1	2600	1	0	\N	\N
6040	TORONTO NESTLE 125G 	1	7591016161128	1	3290	1	0	\N	\N
6045	SAN JOSE CHORITOS AL NATURAL 425G	1	7801235000291	1	2290	1	0	\N	\N
6041	HUEVO DINOSAURIO 	1	2000000002224	1	2000	1	0	\N	\N
6042	SAN JOSE SURTIDO DE MARISCOS AL NATURAL 190G	1	7801235280112	1	1600	1	0	\N	\N
6043	SAN JOSE SURTIDO DE MARICOS AL NATURAL 425G	1	7801235000277	1	3550	1	2650	\N	\N
6044	CHORITOS COLORADO EN ACEITE 425G	1	7801255000332	1	2250	1	0	\N	\N
6046	COLORADO CHORITOS AL NATURAL 425G	1	7801255000325	1	2250	1	0	\N	\N
6047	LIMPIADOR LAVANDA  900 CC POETT	73	7792960000147	1	1950	1	0	\N	\N
6048	LIMPIADOR CITRICA 900 CC POETT	1	7805025697760	1	1950	1	0	\N	\N
6049	CIF 375G	1	7791290790490	1	1700	1	0	\N	\N
6051	CERA LIQUIDA BLEM ROJO 450 CM3	1	7790520995605	1	2000	1	0	\N	\N
6052	PAÑALES HUGGIES 20 UN G	1	7809604030238	1	3200	1	0	\N	\N
6053	PAÑALES HUGGIES 20 UN M	1	7809604030221	1	3200	1	0	\N	\N
6054	VELAS 4 UNID	1	3894143695455	1	1100	1	0	\N	\N
3154	CHANDELLE MANGO SIN LACTOSA 130G	1	7613038442204	1	700	1	0	\N	\N
6056	PIZZA SADIA 460 GR 	1	7893000801448	1	3600	1	3000	\N	\N
6059	JAMON SERRANO RESERVA 80G	1	7809568600010	1	2900	1	0	\N	\N
6061	HARINA 1 KG 	1	7802500100012	1	1290	1	0	\N	\N
201	GUAGUITAS 21 G 	6	7802200130074	1	300	1	0	\N	\N
6058	NUTREGAL FIDEOS 400G	1	7750243064989	1	500	1	0	\N	\N
6062	CHOCOCHIP COOKIES 400G	1	8906064281176	1	4390	1	0	\N	\N
6063	BUTTER COOKIES 114G	1	8906064281251	1	2000	1	0	\N	\N
6064	CHIS POP 100G	1	7802000015984	1	1000	1	0	\N	\N
6065	GOODNES FRUTILLA NESTLE 140G	1	7613287424037	1	500	1	0	\N	\N
6066	GOODNES NESTLE 140G	1	7613287424068	1	500	1	0	\N	\N
6067	GOODNES NESTLE 140G	1	7613287423764	1	500	1	0	\N	\N
6068	PRESTIGIO NESTLE 80 G	1	7613039580097	1	600	1	0	\N	\N
6069	SAHNE-NUSS NESTLE 100G	1	7613287426635	1	600	1	0	\N	\N
6070	EL MANJAR MOUSSE NESTLE 70G	1	7613038649191	1	600	1	0	\N	\N
6071	SAFARI	1	7802220140633	1	250	1	0	\N	\N
2941	CARBON ESPECIAL PARA ASADO 2.2 KG 	1	2000000001364	1	2800	1	2500	\N	\N
6075	LAYS MAX  MAYONESA KETCHUP 200G	47	7802000011030	1	2000	1	0	\N	\N
6076	LAYS SABOR LIMON 200G	1	7802000015397	1	2000	1	0	\N	\N
6078	HELADO FRUGELE 	1	7802705401365	1	300	1	0	\N	\N
6079	HAMBURGUESA VACUNO MONTINA 100 GR 	1	7804115001708	1	700	1	0	\N	\N
6073	HUEVO PAW PATROL	1	8435477903172	1	1300	1	0	\N	\N
6072	HUEVO DRAGON BALL	1	8435477906623	1	1300	1	0	\N	\N
6074	HUEVO PEPPA	1	8435477906593	1	1300	1	0	\N	\N
6100	CARAMELOS 280G	1	7802200107144	1	1350	1	0	\N	\N
5815	SLIME	1	2000000002149	1	2500	1	0	\N	\N
6080	PALETAS DE PING PONG CON MALLA 	1	2000000002231	1	4800	1	0	\N	\N
6057	POROTOS NEGROS ESMERALDA 400G	1	7801315000173	1	1200	1	0	\N	\N
619	YOGHURT ZUCOSOS  142 GRS NESTLE	4	7613033088766	1	600	1	0	\N	\N
637	CHANDELLE CHOCOLATE  130 GRS NESTLE	4	78093676	1	700	1	0	\N	\N
6077	VIVO SODA 123 GR	1	7802215502002	1	890	1	0	\N	\N
6055	PIZZA SADIA 460 GR 	1	7893000801523	1	3600	1	3000	\N	\N
1169	HAMBURGUESA VACUNO 100G RA 	1	7801930010380	1	800	1	700	\N	\N
6081	PELOTA DE PING PONG INDIVIDUAL 	1	2000000002248	1	200	1	0	\N	\N
6082	CHUPETE REPUESTO 	1	2000000002255	1	500	1	0	\N	\N
6083	CHUPETE DE ENTRETENCION 	1	2000000002262	1	550	1	0	\N	\N
6084	BOMBILLAS DE PAPEL 25 UN. 	1	2000000002279	1	1300	1	0	\N	\N
6085	PALOS DE BROCHETA GRANDE 	1	6953675840508	1	1650	1	0	\N	\N
6086	SCOTCH CHICO UNIDAD 	1	2000000002286	1	200	1	0	\N	\N
6087	BETUN ZAPATOS NEGRO 75 ML 	1	8434485175694	1	1650	1	0	\N	\N
6088	BURBUJA UNICORNIO 	1	2000000002293	1	1600	1	0	\N	\N
6089	MONDADIENTES 	1	6970437240826	1	600	1	0	\N	\N
6090	BOLSA DE REGALO 	1	6901042032445	1	1900	1	0	\N	\N
6091	BOLSA DE REGALO 	1	6901080231244	1	1000	1	0	\N	\N
6092	BOLSA DE REGALO	1	6901050424324	1	1000	1	0	\N	\N
6093	BOLSA DE REGALO 	1	2016113304435	1	850	1	0	\N	\N
6094	BOLSA DE REGALO 	1	7899183913640	1	850	1	0	\N	\N
6096	SANGRIENTO 252 GR 	1	7802225510172	1	1800	1	0	\N	\N
6097	GOMITAS 360 GR 	1	7802225409506	1	2190	1	0	\N	\N
6098	ARCOIRIS 330 GR 	1	7790580416447	1	1790	1	0	\N	\N
5263	LONCO LECHE SIN LACTOSA 1 LT	1	7802910000223	1	1600	1	0	\N	\N
2627	LONCO LECHE CHOC. SIN LACTOSA 1LT	1	7802910000728	1	1600	1	0	\N	\N
6099	MASTICABLES SABORES FRUTALES 80U	1	7802200107175	1	1990	1	0	\N	\N
6103	PEDIGREE 100G	1	7797453000796	1	650	1	0	\N	\N
6102	PEDIGREE 100G	1	7797453000482	1	650	1	0	\N	\N
6111	CABRITAS 	1	7802000003448	1	1400	1	0	\N	\N
6112	GLADE 	1	7501032924010	1	1350	1	0	\N	\N
6113	TRIPACK TRITON 	1	2000000002309	1	1690	1	0	\N	\N
6104	PEDIGREE 100	1	7797453000802	1	650	1	0	\N	\N
6105	PEDIGREE POUCH CACHORRO CARNE  85 GR PEDIGREE	60	7797453000468	1	650	1	0	\N	\N
6106	ARENA BIODEGRADABLE 2KL	1	7802575533524	1	3100	1	0	\N	\N
6107	PRESTOBARBA BIC 	1	070330703629	1	600	1	0	\N	\N
2481	MANI SIN SAL  100 GRS SEMBRASOL	70	7804612220398	1	1300	1	1200	\N	\N
2489	MANI MERQUEN  100 GRS SEMBRASOL	70	7804612220374	1	1300	1	1200	\N	\N
3689	BARRA MOCCACHINO GUALLARAUCO 94G	1	7803908005909	1	1590	1	0	\N	\N
4167	CONO FRAMBUESA GUALLARAUCO	1	7803908005916	1	1590	1	0	\N	\N
6108	PELOTA LUMINOSA	1	112121212	1	2500	1	0	\N	\N
6109	ARDILLA JUGUETE	1	23232323232	1	2000	1	0	\N	\N
6110	TIC TAC	1	77965363	1	400	1	0	\N	\N
6114	CASTAÑO	1	7803468001946	1	1400	1	0	\N	\N
6115	PASTA DENTAL ORAL B 50 GR	1	7500435157803	1	1000	1	0	\N	\N
6116	YOGURT VEGGIE 	1	7613038884028	1	450	1	0	\N	\N
6117	LENTEJAS ESSEN 1 KG 	1	7804673790007	1	1600	1	0	\N	\N
6118	MARSH MALLOW	1	7802200129108	1	1500	1	0	\N	\N
6119	VEGGIE  NESTLE 	1	7613038883953	1	350	1	0	\N	\N
6120	AVENA 450	1	7802000014956	1	1400	1	0	\N	\N
6121	CHUCRUT MERKAT 400 GR 	1	7802420000621	1	550	1	0	\N	\N
6122	SALSA TOSCANA 200 GR 	1	7802575341136	1	790	1	0	\N	\N
6123	SALSA TOSCANA 200GR 	1	7802575341150	1	790	1	0	\N	\N
6124	SALSA TOSCANA 200 GR 	1	7802575341167	1	890	1	790	\N	\N
6133	JUGO SOPROLE 200 ML 	1	7802900481131	1	350	1	0	\N	\N
2284	TRIGO MOTE OSO 500G	1	7803960100208	1	1500	1	0	\N	\N
6125	FOSFOROS MERKAT 10 UN. 	1	7804603463438	1	1100	1	0	\N	\N
6134	NECTAR NARANJA 200 CC SOPROLE	76	7802900481063	1	350	1	0	\N	\N
6126	FRAC	1	7802705401228	1	1490	1	0	\N	\N
6135	NECTAR MANZANA 200 CC SOPROLE	76	7802900481162	1	350	1	0	\N	\N
6136	NECTAR PIÑA SOPROLE 200 ML	76	7802900481032	1	350	1	0	\N	\N
6137	HELADO ROLLS 98 GR	1	7802705401341	1	990	1	0	\N	\N
6129	MALBORO ROJO 	1	78026216	1	3000	1	0	\N	\N
455	PURE INSTANTANEO 125 GRS MAGGI	1	7802950006865	1	1190	1	0	\N	\N
6128	MALBORO BLANCO 	1	78026230	1	3300	1	3000	\N	\N
6130	NEGRITA	1	7613287755810	1	200	1	0	\N	\N
6127	TERRA 180G	1	7802420006647	1	2500	1	0	\N	\N
4920	CONO SUSPIRO LIMEÑO 103 G 	1	7803908006647	1	1590	1	0	\N	\N
4426	CHOCOLATE NARANJA 106G	1	7803908006593	1	1590	1	0	\N	\N
5082	VIRUTEX TOALLAS MULTIUSO 10U	1	7806810007399	1	2750	1	0	\N	\N
6131	JUREL DEYCO 425 GR 	1	7801534002293	1	1500	1	0	\N	\N
6132	TORTILLAS 8 UNIDADES 	1	7803468003469	1	1600	1	0	\N	\N
2954	LAVALOZA PININA 1 LT 	1	2000000001401	1	1700	1	0	\N	\N
6139	VIVO BRESLER	1	7802705401259	1	990	1	0	\N	\N
6143	SARDINAS SAN JOSE EN ACEITE	1	7801235552417	1	850	1	0	\N	\N
535	PEPSI ZERO DES. 3 LT CCU	5	7801620006891	1	1950	1	0	\N	\N
33	ARROZ SAN JOSE LARGO ANGOSTO GRADO 2,  1 KG. 	1	7801235000833	1	1550	1	1200	\N	\N
6144	ARROZ SAN JOSE G 1 	1	7801235000482	1	1400	1	0	\N	\N
3915	CHORITOS SAN JOSE EN ACEITE 200G 	1	7801235000284	1	3200	1	2450	\N	\N
6145	MINIONS HELADO 90 GR	1	7801552006617	1	500	1	0	\N	\N
6146	CASTAÑO GRANOS ANCESTRALES 380 GR 	1	7803468001748	1	1590	1	0	\N	\N
6148	STEVIA ENLINEA 250ML	1	7804000002230	1	2100	1	0	\N	\N
6149	AMBROSITO	1	7802200135765	1	200	1	0	\N	\N
6150	COCTEL ARCOR 820G	1	7790580421960	1	2200	1	0	\N	\N
6151	PALITO NARANJA FRUNA 	1	7802408000544	1	250	1	0	\N	\N
6152	SALAME 100 GR 	1	7801916030340	1	2000	1	0	\N	\N
6154	CASATA TRENDY 1 LT 	1	7801552001964	1	2090	1	0	\N	\N
6156	MASA PIZZA CASTAÑO 500 GR 	1	7803468001229	1	1650	1	0	\N	\N
6162	GALLETAS BAUDUCCO VAINILLA	1	7891962032306	1	750	1	0	\N	\N
549	BILZ DESECHABLE 3 LTS	5	7801620001193	1	1950	1	0	\N	\N
3762	SEVEN UP DESECHABLE 3 LTS	75	7801620001322	1	1950	1	0	\N	\N
556	PAP ZERO 3 LTS DESECHABLE	5	7801620005078	1	1950	1	0	\N	\N
6158	TRAPERO HUMEDO DESINFECTANTE VIRUTEX	1	7806810007443	1	3200	1	0	\N	\N
4361	KILLER MATA TODO INSECTO 560CM	1	7805040004314	1	3790	1	3000	\N	\N
6138	DETERGENTE BRIGHT 800 GR 	1	614143695186	1	1600	1	0	\N	\N
6163	GALLETAS BAUDUCCO NUECES	1	7891962036892	1	750	1	0	\N	\N
6140	MENTOS KISS 35 GR 	1	7895144605678	1	1900	1	1800	\N	\N
6141	MENTOS KISS 35 GR	1	7895144605685	1	1900	1	1800	\N	\N
6157	TROCK	1	7801552006693	1	800	1	690	\N	\N
6147	PLATANOSO 54G	1	7801552006686	1	400	1	350	\N	\N
6159	QUESO CHANCO QUILLAYES 250G	1	7802930003822	1	2750	1	0	\N	\N
6164	LONCO LECHE 1 LT PLATANO 1 LT 	1	7802820210132	1	1600	1	0	\N	\N
6166	CAFE MARLEY 20G	1	2000000002316	1	700	1	0	\N	\N
6142	ANDINA 1.75 LT 	1	7802820175257	1	1400	1	0	\N	\N
6153	ANDINA DEL VALLE 1.75 LT 	1	7802820175080	1	1400	1	0	\N	\N
2509	SALSA MANJAR 280G	1	7802410506447	1	1690	1	0	\N	\N
6167	SALSA FRUTILLA GOURMET 300G	1	7802410506348	1	1690	1	0	\N	\N
6168	GOURMET SALSA SABOR CHOCOLATE SIN AZUCAR 280G	1	7802410506263	1	1750	1	0	\N	\N
6169	HARINA INTEGRAL MOLINO YANINE 1KG	1	7802612000286	1	1100	1	0	\N	\N
6165	KETCHUP MARCO POLO 400G	1	7802420001871	1	1100	1	0	\N	\N
6171	CERA DEPILATORIA MILLEFIORI 	1	7804923003031	1	5590	1	0	\N	\N
1689	MAGGI TUCO CHAMPIÑON  245G	39	7613034426345	1	1300	1	0	\N	\N
698	ENDULZANTE STEVIA DAILY 180ML 	1	7809558101947	1	2950	1	0	\N	\N
6173	DAILY SUCRALOSA 180 ML	1	7809558101930	1	2000	1	0	\N	\N
6174	DETERGENTE ACE 3 KILOS	1	7506195159422	1	6300	1	0	\N	\N
6190	CHICLES MENTOS BOTELLA FRUTILLA	1	80733140	1	1100	1	0	\N	\N
6196	SALSA DE AJO 165CC	1	7802410225300	1	2000	1	0	\N	\N
4344	DETERGENTE ACE 800 GR 	1	7500435146388	1	1700	1	0	\N	\N
6175	MARLEY	1	781159004025	1	700	1	0	\N	\N
6176	MARLEY COFFEE	1	781159004018	1	700	1	0	\N	\N
6177	MARSH MALLOWS SANDIA 230G	1	7802200129092	1	1550	1	0	\N	\N
6178	LECHE CALO 900 ML 	1	7802910002241	1	5590	1	0	\N	\N
6179	MIX VENECIA 60GR	1	781159477478	1	1200	1	0	\N	\N
6170	NESCAFE DECAF 170G	1	7613287581099	1	5100	1	0	\N	\N
1396	PECHUGA DE POLLO ASADA 	3	51	2	12000	1	8900	\N	\N
6191	COLA CAO ISTANTANEO	1	7802635000157	1	2390	1	0	\N	\N
1690	MAGGI TUCO POLLO  245G	40	7613031315604	1	1300	1	0	\N	\N
6172	SALSA TOMATES  ALBAHACA  245 GR TUCO	1	7613034424624	1	1300	1	0	\N	\N
6197	ACONCAGUA DURAZNOS CUBITOS 580G	1	7801800000022	1	1990	1	0	\N	\N
6160	QUESO MANTECOSO QUILLAYES 250G 	1	7802930004164	1	3320	1	2750	\N	\N
6161	GALLETAS BAUDUCCO CHOCOLATE	1	7891962032290	1	750	1	0	\N	\N
6180	BANDEJA PASCUEROS COLGANTES 12 UN 	1	7802215111693	1	2990	1	0	\N	\N
6181	PALOS DE BROCHETA 	1	6953675830509	1	1200	1	0	\N	\N
6182	BOMBIN + GLOBOS	1	7877771040619	1	1650	1	0	\N	\N
6183	CHIRIMOYA NARANJA GUALLARAUCO 111G	1	7803908007163	1	1590	1	0	\N	\N
553	GINGER ALE  DES.3 LTS CANADA DRY	5	7801620001896	1	1950	1	0	\N	\N
6185	TALCO PARA NIÑOS BABYLAND 100 G	1	7804945007802	1	1490	1	0	\N	\N
6186	AVELLANAS EUROPEAS TOSTADAS 180 G	1	781159477652	1	4000	1	0	\N	\N
6187	LOMO EMPANIZADO DE SALMON  100G	1	7809611718402	1	790	1	0	\N	\N
6188	CHICLES MENTOS UP 2 U	1	75072582	1	2000	1	0	\N	\N
6189	CHICLES MENTOS BOTELLA	1	80951032	1	1100	1	0	\N	\N
6193	CREMISSIMO BRESLER 105G	1	7802705401402	1	990	1	0	\N	\N
6194	JUMEX NECTAR DE DURAZNO 335ML	1	7501013118056	1	1000	1	0	\N	\N
6195	JUMEX NECTAR DE PIÑA 335ML	1	7501013118117	1	1000	1	0	\N	\N
6198	COLA DE MONO ESENCIA 100ML	1	7802410512325	1	2450	1	0	\N	\N
6202	TAKIS HOT NUTS 200G	1	757528046408	1	1500	1	0	\N	\N
6206	MAYONESA YBARRA 445 GRAMOS	1	8410086331059	1	2690	1	0	\N	\N
6207	MOLDE	1	7803468003476	1	2100	1	0	\N	\N
6209	PRIVILEGIO NAVIDEÑO 60G	1	7802225510196	1	850	1	0	\N	\N
6210	BON O BON NAVIDEÑOS 210G	1	7802225512183	1	2100	1	0	\N	\N
6214	MANI CONFITADO CAMILA 100GR	1	7804623100283B	1	1000	1	0	\N	\N
5345	1+1 MINI COOKIES 140G	1	7802900228170	1	600	1	0	\N	\N
6208	NORDIC  ZERO 1.5 LTS 	75	7801610271056	1	1600	1	0	\N	\N
6211	GALLETAS NAVIDEÑAS 220G	1	7802225680769	1	1000	1	0	\N	\N
6212	NIK BLOCK 160G	1	7802215508639	1	1550	1	0	\N	\N
6204	TAKIS WAPAS 170G	1	757528045340	1	1800	1	0	\N	\N
6203	TAKIS AAS 170G	1	757528045302	1	1800	1	0	\N	\N
6199	TAKIS 40G	1	757528045296	1	600	1	0	\N	\N
6200	TAKIS 40G	1	757528045333	1	600	1	0	\N	\N
6201	TAKIS HOT NUTS 200G	1	757528046729	1	1500	1	0	\N	\N
6184	YOGURT FRAMBUESA 59G	1	7803908007170	1	850	1	0	\N	\N
6205	HAMBURGUESAS VACUNO  100 GRS LA CRIANZA	7	7809611700513	1	800	1	700	\N	\N
6215	DORITOS 92G BOLSAZA	1	7892840817589	1	1000	1	0	\N	\N
6217	CHORITOS DEYCO 190 GR	1	7801534001678	1	1500	1	1300	\N	\N
6230	CEREAL KIDS EN LINEA 330 GR	1	7804000001653	1	2600	1	0	\N	\N
6218	ATUN LOMITO EN AGUA	1	7801255000073	1	1350	1	0	\N	\N
6219	BOMBILLIN SOPROLE 200 ML 	1	7802900481049	1	350	1	0	\N	\N
6220	ALOE VERA 500 ML 	1	8809041429359	1	1000	1	0	\N	\N
6221	HELADO VIVO FRUTILLA 79 GR 	1	7802705401266	1	990	1	0	\N	\N
6222	HAWAI PIÑA 109 GR 	1	7801552006594	1	600	1	0	\N	\N
6223	CALDO DE COSTILLA 	1	7613287222022	1	100	1	0	\N	\N
6224	MARAVILLAS ARTESANALES 	1	2000000002323	1	600	1	0	\N	\N
6225	NUGGETS DE POLLO SUPER POLLO 400 GR	7	7809611700667	1	1500	1	0	\N	\N
6227	GRANOLA PROTEINA CON ALMENDRAS Y COCO 300 GR	1	7804000002759	1	3900	1	0	\N	\N
6231	GRANOLA  SIN AZUCAR CACAO ENLINEA 320GR	1	7804000001981	1	2550	1	0	\N	\N
6232	GRANOLA ALMENDRAS ENLINEA 320GM	1	7804000001998	1	2600	1	0	\N	\N
6233	GRANOLA CRANBERRIES ENLINEA	1	7804000002001	1	2550	1	0	\N	\N
6234	TRENTO 	1	7896306618291	1	400	1	0	\N	\N
6235	MERMELADA DE DAMASCO  SIN AZUCAR AÑADIDA 350G	1	7804000002582	1	1850	1	0	\N	\N
6236	MERMELADA DE FRANBUESA SIN AZUCAR AÑADIDA 350G	1	7804000002551	1	1850	1	0	\N	\N
6237	MERMELADA DE FRUTILLA SIN AZUCAR AÑADIDA 350G	1	7804000002568	1	1850	1	0	\N	\N
6238	MERMELADA MORA SIN AZUCAR AÑADIDA 350G	1	7804000002544	1	1850	1	0	\N	\N
6239	FERRERO COLLECTION 77G	1	7898024397151	1	5950	1	0	\N	\N
6240	FRUITS Y NUTS MAUI MARCOPOLO 80 GR	47	7802420127151	1	1550	1	0	\N	\N
6241	VAINILLA VAINA 1UNIDAS	1	7802420005022	1	3850	1	0	\N	\N
6245	MICRO USB 	1	6927900077779	1	2500	1	0	\N	\N
6242	PEOSI 350ML	1	7801620852689	1	700	1	650	\N	\N
6216	FELIZ NAVIDAD SIN AZUCAR AÑADIDA	1	7803520002904	1	1500	1	0	\N	\N
6229	CEREAL SABOR FRUTAL EN LINEA 330 GR	1	7804000001837	1	2600	1	0	\N	\N
6228	CEREAL KIDSEN LINEA 330GR	1	7804000001455	1	2600	1	0	\N	\N
6243	BRESLER ROLLS 531	1	7802705401396	1	4790	1	0	\N	\N
6226	HAMBURGUESAS POLLO  100 GRS LA CRIANZA	7	7809611700865	1	800	1	700	\N	\N
6244	CHOKITA BALLS	1	7613287832153	1	1700	1	0	\N	\N
6246	LENTEJAS PREMIUM IANSA 390GR	1	7801505003052	1	1400	1	0	\N	\N
6247	POROTOS BLANCOS IANSA 390 GR	1	7801505003038	1	1400	1	0	\N	\N
6248	HUEVO SORPRESA 	1	8435477906159	1	1300	1	0	\N	\N
6249	ALOE	1	8809041429779	1	2500	1	0	\N	\N
6269	GUAYABA	1	7501013118063	1	1000	1	0	\N	\N
2673	GALLETAS MUSEO MCKAY 30G	1	7613037035285	1	300	1	0	\N	\N
1342	KUCHEN GRANDE	12	612	2	8000	1	0	\N	\N
6261	JUGO NATURAL QUILLAYES 900 ML	1	7899916906086	1	3390	1	0	\N	\N
6250	FRAC 52G	1	7802215503375	1	300	1	0	\N	\N
6251	SALCHICHAS SUREÑAS RECETA DEL ABUELO 10UNI	1	7801930013831	1	2600	1	0	\N	\N
6252	PAP LATA 310ML	1	7801620009069	1	650	1	0	\N	\N
6262	JUGO NATURAL QUILLAYES 900 ML 	1	7899916913305	1	3390	1	0	\N	\N
6263	LOVE LEMON 	1	7801552006754	1	300	1	0	\N	\N
6253	PRINCIPE MERENGUE MANJAR 6 UND 	1	7803403101069	1	2100	1	0	\N	\N
6254	DOVE FUERZA VITAL 400ML	1	7791293038346	1	2650	1	0	\N	\N
6259	SAN FRANCISCO ARANDANO	1	7802926000958	1	2950	1	0	\N	\N
6264	CREMISSIMO CHIRIMOYA 	1	7802705401358	1	990	1	0	\N	\N
6265	ARIZTIA FILETILLO DE POLLO 650G	1	7808749501153	1	3990	1	0	\N	\N
6266	VEGGIE COCO	1	7613038678290	1	450	1	0	\N	\N
6267	SAVORY MORA CREMA 1 LT 	1	7802710835117	1	2500	1	0	\N	\N
6268	CAPPUCCINO LATA 240 ML 	1	884394002921	1	2000	1	0	\N	\N
6271	MOSTAZA TRAVERSO 100GR	1	7802337920340	1	500	1	0	\N	\N
6272	BRIGHT 50 X 70 	1	3896110015099	1	990	1	0	\N	\N
6273	BOLSA BRIGHT 80 X 110	1	3896110015082	1	2150	1	0	\N	\N
6255	DOVE REGENERECION EXTREMA 400ML	1	7791293038759	1	2650	1	0	\N	\N
6256	PAÑO ESPONJA NATURAL 6UN	1	7806810005258	1	3300	1	0	\N	\N
6270	ENERGETICA SCORE	1	742832751988	1	1500	1	1300	\N	\N
6213	TRITON FRUTILLA	1	7613034565884	1	700	1	0	\N	\N
1240	GALLETAS TRITON NARANJA 126G 	1	7613031042913	1	700	1	0	\N	\N
1251	GALLETAS LIMON 150G MCKAY 	1	7613032589714	1	700	1	0	\N	\N
6257	AYGON MATA MOSCAS Y MOSQUITOS 450CM	1	7790520991539	1	2850	1	0	\N	\N
6258	DOVE FUERZA VITAL 00L	1	7891150064881	1	2650	1	0	\N	\N
6274	BOLSA BRIGHT 80 X 120 	1	3894143695257	1	2650	1	0	\N	\N
6275	BOLSA BRIGHT 70 X 90 	1	3896110013408	1	1690	1	0	\N	\N
6276	MENTA EUCALIPTUS	1	7802408001091	1	300	1	0	\N	\N
6277	PAPAS FRITAS QUESO MANTECOSO MARCO POLO 200GR	1	7802420006296	1	1500	1	0	\N	\N
6279	MAJIX FOR MEN 200 ML 	1	8696630128720	1	2100	1	0	\N	\N
6280	AXE APOLLO 150 ML 	1	7791293041100	1	2500	1	0	\N	\N
819	JABON VANISH WHITE 75GR	2	7891035040276	1	1400	1	0	\N	\N
6282	NIVEA 150 ML 	1	4005900036643	1	2700	1	0	\N	\N
6283	KEM PIÑA LATA 310 ML 	1	7801620008888	1	650	1	0	\N	\N
6284	PATE LA PREFERIDA TERNERA 160 GR 	1	7801916000718	1	650	1	0	\N	\N
6285	AXE MARINE 150 ML 	1	7791293041087	1	2500	1	0	\N	\N
6286	TERRA CAMOTE 170 GR 	1	7802420006654	1	2500	1	0	\N	\N
6287	LIMPIA VIDRIOS QU 1 LT 	1	7804663500272	1	2100	1	0	\N	\N
6288	CREMA NATUREZA 	1	7803700012211	1	500	1	0	\N	\N
6289	JUGO ZUCO 	1	7802800579297	1	300	1	0	\N	\N
6291	ACEITE VEGETAL NUESTRA COCINA 900 ML 	1	7790272008295	1	1750	1	0	\N	\N
6292	ESPONJA LISA    4 UN VIRUTEX	73	7806810004305	1	700	1	0	\N	\N
6293	AZUCAR NUESTRA COCINA 1 KG 	1	7804627780290	1	1000	1	0	\N	\N
6295	DESOD. AMBIEN FRUTAS SILVESTRES  40 GR AROM	73	7805040312174	1	750	1	0	\N	\N
6297	PAN COMPLETO 19 CM HOUSEBROT  530 GR 	1	2000000002330	1	2000	1	0	\N	\N
1609	CRAZY FLOCOS 170ML SAVORY 	6	7613035772588	1	1100	1	0	\N	\N
4726	DESODORANTE BIOMEN 150ML 	1	7509552913729	1	2500	1	0	\N	\N
5008	MUIBON FLOW 40 GRS 	1	7802800556076	1	500	1	0	\N	\N
6296	DESOD. AMBIEN VAINILLA  40 GR AROM	73	7805040312211	1	950	1	750	\N	\N
6290	OKF CAFFE 	1	884394002907	1	2000	1	0	\N	\N
1344	PALMERITAS 	12	616	1	800	1	0	\N	\N
6278	MIL HOJAS MANJAR AGUA PIEDRA 280GR	47	7803473002143	1	2600	1	2150	\N	\N
1465	PAPAS	11	102	2	550	1	0	\N	\N
4865	DUAL	1	6931474709097	1	7000	1	0	\N	\N
1980	MONSTER AZUL 473ML 	54	070847033219	1	1500	1	0	\N	\N
2429	PRESTIGIO CASATA 900ML 	1	7613036566346	1	3900	1	0	\N	\N
1484	ZAPALLO ITALIANO 	11	2000000000541	2	650	1	0	\N	\N
1504	ESPINACA 	11	2000000000671	1	650	1	0	\N	\N
4545	MELON 	11	139	2	1000	1	0	\N	\N
1509	KIWI 	11	123	2	1550	1	0	\N	\N
1479	FRUTILLAS 	11	110	2	2200	1	0	\N	\N
3815	LECHE ASADA NESTLE 	1	7613038883762	1	790	1	0	\N	\N
1024	CABALLA SAN JOSE 425GR	1	P009	1	900	1	0	\N	\N
110	AEROSOL FRESKITO LAVANDA 360CC 	2	7805300050013	1	1500	1	0	\N	\N
112	AEROSOL FRESKITO VAINILLA 360 CC	2	7805300050037	1	1500	1	0	\N	\N
367	SHAMPOO BALLERINA NUTRIION E HIDRATACION 900 ML 	2	7804920005878	1	2000	1	1400	\N	\N
1533	GUIRNALDA BANDERIN FELIZ CUMPLEAÑOS 3MT	34	5606858330914	1	0	1	0	\N	\N
2206	QUESILLO 320G	1	7802920001135	1	1590	1	0	\N	\N
320	PAN CORRIENTE	8	1	2	1890	1	1450	\N	\N
358	SALSA DE TOMATE NATURAL LUCCHETTI 200 GRAMOS 	1	7802500037073	1	500	1	400	\N	\N
655	JUREL  425 GRS SAN JOSE	1	7801235131117	1	1690	1	0	\N	\N
1322	PAN CANAPE	8	6	2	2200	1	1900	\N	\N
4420	KAPPO PIÑA 	1	7802820250220	1	250	1	0	\N	\N
1328	PECHUGA AHUMADA SOPRAVAL 	8	12	2	12000	1	8000	\N	\N
6298	ACEITE DE OLIVA VITA 250ML	1	7804652020910	1	2100	1	0	\N	\N
1329	JAMON COCIDO SOPRAVAL 	8	13	2	12000	1	7900	\N	\N
2057	QUESO DE CABEZA 	8	16	2	8000	1	7000	\N	\N
6299	ACEITE DE OLIVA CANEPA EXTRA VIRGERN 500ML	1	7804380001106	1	4660	1	0	\N	\N
1320	DOBLADITAS 	8	4	2	2100	1	1750	\N	\N
6300	ACEITE VEGETAL MIRAFLORES 900ML	1	7801320242025	1	3850	1	0	\N	\N
1321	PAN DE COMPLETO 	8	5	2	2100	1	1750	\N	\N
1117	JAMON SANDWICH PF	3	21	2	7500	1	6000	\N	\N
1327	CHUCHOCA DE CAUQUENES 	8	11	2	2200	1	3000	\N	\N
1368	ARROLLADO ARTESANAL RECETA DEL ABUELO 	3	23	2	8000	1	7600	\N	\N
6310	JAMON COLONIAL PF	1	54	2	11000	1	0	\N	\N
6192	PECHUGA DE PAVO ASADA SOPRAVAL 	3	53	2	12000	1	8000	\N	\N
5942	JAMONADA CENTENARIO 	3	36	2	10000	1	6000	\N	\N
1371	JAMONADA DE PAVO RECETA DEL ABUELO 	3	26	2	7000	1	5200	\N	\N
1372	JAMON PIERNA SANDWICH RECETA DEL ABUELO 	3	27	2	8000	1	7000	\N	\N
1373	PICHANGA 	3	28	2	4500	1	3150	\N	\N
1370	MORTADELA JAMONADA RDA	3	25	2	7000	1	5000	\N	\N
1374	SALAMIN AHUMADO ARTESANAL RECETA DEL ABUELO 	3	29	2	6300	1	5700	\N	\N
1376	JAMON ARTESANAL 	3	31	2	11000	1	0	\N	\N
6309	MORTADELA CON SALAME 	1	49	2	7000	1	0	\N	\N
1377	JAMONADA DE POLLO RECETA DEL ABUELO 	3	32	2	7000	1	4500	\N	\N
1382	JAMON COLONIAL PF 	3	37	2	11000	1	9000	\N	\N
1378	SALCHICHON CERVECERO RECETA DEL ABUELO 	3	33	2	6200	1	5600	\N	\N
1379	PECHUGA DE PAVO ASADA RECETA DEL ABUELO 	3	34	2	12500	1	7000	\N	\N
1387	PICKLE	3	42	2	5800	1	3500	\N	\N
1388	JAMON CENTENARIO ACARAMELADO 	3	43	2	10000	1	9000	\N	\N
3992	PASTA MIX CAROZZI 400G	1	7802575034038	1	1500	1	950	\N	\N
5522	LUCCHETTI INTEGRAL 400GR	1	7802500222196	1	1500	1	950	\N	\N
6304	ELITE MAXI ROLLO DECO 2 UN 	1	7806500406747	1	2890	1	0	\N	\N
1405	ARROLLADO HUASO CON AJI 	3	60	2	8000	1	5500	\N	\N
1400	JAMON ACARAMELADO ARIZTIA 	3	55	2	12000	1	7000	\N	\N
1384	JAMON PAVO ACARAMELADO 	3	39	2	12000	1	9000	\N	\N
1403	ARROLLADO LOMO PF 	3	58	2	10000	1	7500	\N	\N
1402	ARROLLADO HUASO PF 	3	57	2	10000	1	8600	\N	\N
1406	MORTADELA JAMONADA PF 	3	61	2	6000	1	3700	\N	\N
1407	MORTADELA FINA PF 	3	62	2	5000	1	2900	\N	\N
6312	JAMON SANDWICH PF	1	66	2	7500	1	0	\N	\N
1408	JAMONADA DE PAVO 	3	63	2	7000	1	4500	\N	\N
1393	JAMON PIERNA ACARAMELADO PF 	3	48	2	11000	1	8900	\N	\N
6301	ACEITER VEGETAL NATURA 900ML 	1	7790272008318	1	3650	1	0	\N	\N
6302	NUTRGAL SPAGHETTI N5 	1	7750243064972	1	600	1	0	\N	\N
6303	ACEITE DE MARAVILLA D ALMACEN 900ML	1	7278945911849	1	2800	1	0	\N	\N
6305	POROTO TORTOLA OREGON 1KG	1	7809637200035	1	3490	1	0	\N	\N
6306	POROTO HALLADO OREGON 1KG	1	7809637200004	1	2300	1	0	\N	\N
6307	GARBANZO OREGON 1KG	1	7809637200059	1	1900	1	0	\N	\N
6308	ARROZ PARA SUSHI PARTNER 2KG	1	7804643512035	1	2990	1	0	\N	\N
6311	ACEITE MARAVILLA MIRAFLORES 900ML	1	7801320000007	1	3490	1	0	\N	\N
6314	SPA VITELLI CARNE 65 GR	43	6959237325841	1	1050	1	0	\N	\N
6316	ATUN EN AGUA PACIFIC CATCH	1	030267905008	1	1550	1	0	\N	\N
6317	LOMITO EN ACEITE COLICEO	1	7804608220210	1	1250	1	0	\N	\N
4903	LERCHE NIDO ETAPA 5	1	7613032422516	1	17500	1	13700	\N	\N
4556	ATUN LOMITOS SAN JOSE 160G	1	7801235001878	1	1600	1	1300	\N	\N
3113	VAN CAMPS EN AGUA 160G	1	7702367003917	1	1800	1	1750	\N	\N
5301	NESTLE MILO 700G	1	7613034635525	1	6000	1	0	\N	\N
727	NESCAFE DOLCA 50 GR 	1	7802950009262	1	1790	1	1590	\N	\N
4945	MAYONESA KRAFT 794 GRS	1	021000026326	1	5100	1	4690	\N	\N
6320	NOT MAYO GARLIC 350G	1	7804659650059	1	2500	1	0	\N	\N
6321	NOT MAYO PICY 350G	1	7804659650042	1	2500	1	0	\N	\N
6324	MOSTAZA TRAVERSO 240G	1	7802337930226	1	1400	1	0	\N	\N
6325	AJI PEBRE TRAVERSO 230G	1	7802337930233	1	1790	1	0	\N	\N
6326	KETCHUP 240ML TRAVERSO	1	7802337930240	1	1400	1	0	\N	\N
6327	ACEITUNA AZAPA 330G DON JUAN	1	7802351111304	1	1350	1	0	\N	\N
3151	PICKLES EN VINAGRE DON JUAN 400GR	1	7802351461201	1	990	1	0	\N	\N
2222	ACEITUNAS HUASCO 340G	1	7802351121204	1	1350	1	0	\N	\N
2727	SALSA SOYA  250 ML TRAVERSO	1	7802315560667	1	1150	1	0	\N	\N
6060	SALSA DE SOYA 500ML 	1	7802420116445	1	2750	1	0	\N	\N
1191	ESPARRAGOS VERDES ENTEROS 42G ESMERALDA 	1	7802420510380	1	2690	1	0	\N	\N
5739	POROTOS BLANCOS 400G	1	7801315000135	1	1000	1	0	\N	\N
3809	CREMA CHANTILLY CHOCOLATE 60GR. 20 PORCIONES	1	7802800563043	1	650	1	890	\N	\N
3808	CREMA CHANTILLY 60GR. 20 PORCIONES 	1	7802800563012	1	650	1	890	\N	\N
1413	SALCHICHON CERVECERO ESPECIAL PF 	3	68	2	7000	1	5800	\N	\N
1472	PLATANOS 	11	106	2	1150	1	1450	\N	\N
1414	MORTADELA JAMONADA LA ESPAÑOLA 	3	69	2	5000	1	3200	\N	\N
1584	QUESO LAMINADO 	3	76	2	9990	1	7500	\N	\N
1416	QUESO CHANCO EN BARRA PF	3	71	2	8000	1	0	\N	\N
1517	JAMON DE PAVO AHUMADO LA CRIANZA 	3	74	2	12000	1	7500	\N	\N
1482	LIMON 	11	112	2	1350	1	950	\N	\N
1598	JAMON COLONIAL SAN JORGE 	3	90	2	10000	1	7500	\N	\N
1464	TOMATES 	11	101	2	1550	1	1200	\N	\N
6313	GRANIZO CAROZZI 250 GR 	1	7802575003843	1	900	1	0	\N	\N
1586	JAMON ACARAMELADO WINTER 	3	78	2	9000	1	7000	\N	\N
1587	ARROLLADO LOMO S/A SAN JORGE 	3	79	2	6000	1	5500	\N	\N
1588	PECHUGA DE PAVO AHUMADA SAN JORGE 	3	80	2	12000	1	7000	\N	\N
1601	MORTADELA JAMONADA DE AVE SAN JORGE 	3	93	2	6000	1	4200	\N	\N
1590	FIAMBRE DE PAVO COCIDO SAN JORGE 	3	82	2	9000	1	7000	\N	\N
1649	PECHUGA DE PAVO ASADA ARIZTIA 	3	94	2	11000	1	6500	\N	\N
1585	JAMON PIERNA ARTESANAL WINTER 	3	77	2	9000	1	6800	\N	\N
1652	PECHUGA DE PAVO COCIDA ARIZTIA 	3	96	2	11000	1	6500	\N	\N
2041	ARROLLADO DE HUASO 	3	99	2	10000	1	8900	\N	\N
1501	DURAZNO PLATANO 	11	119	2	1590	1	2000	\N	\N
1478	PEPPERONI 	11	109	2	12290	1	850	\N	\N
1491	FILETE DE MERLUZA 	11	113	2	5400	1	1000	\N	\N
1594	JAMONADA DE AVE SAN JORGE 	3	86	2	6000	1	3500	\N	\N
1498	UVA ROSADA	11	116	2	1500	1	0	\N	\N
1511	PALTA LISA 	11	125	2	3500	1	3800	\N	\N
1512	PALTA HASS 	11	126	2	4500	1	3990	\N	\N
6315	ALMIDON DE MAIZ CAMPINO 400G	1	7804520026358	1	1600	1	0	\N	\N
1105	DULCE DE MEMBRILLO WATTS 500GR	1	7802810034052	1	1400	1	0	\N	\N
4440	MASTER DOG ADULTO 	77	231	2	2400	1	1700	\N	\N
1104	DULCE DE CIRUELA WATTS 500GR	1	7802810005946	1	1600	1	0	\N	\N
718	DULCE DE MORA WATTS 500GR	1	7802810000170	1	1600	1	0	\N	\N
4446	WHISKAS PESCADO 	77	237	2	2990	1	2300	\N	\N
2671	LUCKY WILD 20	55	78024717	1	4700	1	4500	\N	\N
4486	MASTER CAT SALMON 	77	238	2	2800	1	2300	\N	\N
6319	QUESO CABEZA	1	311	2	6500	1	0	\N	\N
3543	CHULETA DE CERDO GRANEL 	31	312	2	5500	1	3500	\N	\N
3599	CHESSECAKE GRANDE 	31	314	1	10000	1	300	\N	\N
6345	LUCKY STRIKE CHARGED 	1	78026292	1	4600	1	0	\N	\N
4518	JAMON PLANCHADO SAN JORGE 	31	317	2	12000	1	9000	\N	\N
2594	QUESILLO ACHIBUENO REDONDO 500G 	1	1296	1	2550	1	2300	\N	\N
1739	HUEVO SUPER GRANEL	1	502	2	180	1	130	\N	\N
4275	PALLAMAN VERDE	1	78025059	1	3600	1	3500	\N	\N
1455	BRAZO DE REINA VARIEDAD 	12	638	1	6000	1	900	\N	\N
2073	PALLMALL AZUL 20	55	78007673	1	3300	1	3200	\N	\N
2124	CHESSECAKE CHICO 	12	643	1	1700	1	1000	\N	\N
1349	QUEQUE GRANDE	12	625	1	3000	1	2500	\N	\N
6294	PALL MALL CLICK XL 	1	78025035	1	3600	1	3500	\N	\N
2119	QUESO EN BARRA	1	999	2	12000	1	9750	\N	\N
2038	BROWNIE 	12	639	1	1100	1	800	\N	\N
2079	PALLMALL AZUL 10	55	78018853	1	2000	1	1800	\N	\N
5272	NESCAFE SUMATRA ORIGINAL 100G	1	7613037107210	1	7300	1	6700	\N	\N
4888	FINA SELECCION  ALTA RICA 100G	1	7613037069723	1	7300	1	6490	\N	\N
6318	NESCAFE FINA SELECCION ESPRESSO 100G	1	7613037071399	1	7300	1	0	\N	\N
2319	NESCAFE TRADICION GRANULADO 50 GR	63	7613032203122	1	1900	1	0	\N	\N
2958	NESCAFE TRADICION  GRANULADO 100 GR	1	7613032203719	1	3300	1	0	\N	\N
3028	NESCAFE TRADICION 170G	1	7613032203795	1	5300	1	5150	\N	\N
5079	CAFE NESCAFE TRADICION SUPER PACK	1	7613036653435	1	9200	1	8100	\N	\N
6322	TE SUPREMO TILO 20 UND	1	7801875058126	1	1200	1	0	\N	\N
6323	TE SUPREMO PAICO 20 UND	1	7801875058102	1	1200	1	0	\N	\N
3497	CAFE GOLD DESCAF. 50G 	1	7802800501830	1	2100	1	0	\N	\N
3511	TE VERDE PREMIUM SUPREMO 20 UN 	1	7801875000583	1	1790	1	0	\N	\N
3652	MONTERREY DESCAF. 170G	1	7802800500444	1	3990	1	0	\N	\N
749	TE CEYLAN  20 UN EMBLEM	1	7801810117420	1	1000	1	750	\N	\N
4745	CAFE CRUZEIRO 170GR 	1	7896019207041	1	2500	1	0	\N	\N
58	CAFE CLASICO MONTERREY 170 GRAMOS 	1	7802800500413	1	2650	1	0	\N	\N
5548	CAFE CORONADO 170 GR	1	7802800512010	1	1990	1	0	\N	\N
5662	CACAO AMARGO COPACABANA 150GR	1	7802420520013	1	1200	1	0	\N	\N
5138	VIVO AVENA CHOC 200G	1	7800120170194	1	1500	1	0	\N	\N
2434	HARINA SELECTA 1KG	1	7802615005202	1	1600	1	1350	\N	\N
2271	SAL LOBOS EXTRA GRUESA 800G	1	7803600001858	1	1900	1	0	\N	\N
355	SAL FINA LOBOS 1 K	1	7803600031275	1	650	1	0	\N	\N
6328	SAL TRINIDAD 1KG 	1	7803605000108	1	350	1	0	\N	\N
48	AZUCAR GRANULADA LA PATRONA 1 KG. 	1	7801505000280	1	1200	1	750	\N	\N
3319	AZUCAR BONANZA 1KG	1	7808743600036	1	1200	1	860	\N	\N
5774	AZUCAR GRANULADA 1.6	1	7804627780306	1	1900	1	1550	\N	\N
47	AZUCAR GRANULADA IANSA 1 KG. 	1	7801505231912	1	1360	1	1100	\N	\N
6332	SVELTY DESC. 350G	1	7613032557065	1	3790	1	0	\N	\N
3664	LECHE POLVO INSTANTANEA NESTLE 1 KG 	1	7613030788751	1	5600	1	0	\N	\N
2795	LECHE COLUN ENTERA 120G	1	7802920003023	1	900	1	0	\N	\N
6334	YERBA MATE BRASIL 500G	1	7802420006814	1	3200	1	0	\N	\N
430	YERBA MATE DOÑA JAVIERA 250 GRAMOS 	1	7801875067043	1	1650	1	0	\N	\N
1826	CREMA PASTELERA 72G VANCOOK	1	7802800563210	1	650	1	0	\N	\N
5780	LECHE CONDENSADA 128GR	1	7506475103565	1	1850	1	1550	\N	\N
3364	NUTELLA 140G	1	7898024395232	1	2350	1	2550	\N	\N
1754	CREMA TARRO  236 GRS NESTLE	21	7613032415679	1	1400	1	0	\N	\N
680	CREMA  200 ML NESTLE	4	7802950022322	1	850	1	800	\N	\N
1290	CREMA BATIR  1 LT SOPROLE 	21	7802900107017	1	3100	1	0	\N	\N
422	VINAGRE BLANCO  TRAVERSO 250 ML 	1	7802337101015	1	600	1	0	\N	\N
424	VINAGRE ROSADO TRAVERSO 250 GRAMOS 	1	7802337101022	1	600	1	0	\N	\N
1928	COCA COLA DESECHABLE 3 LT	49	7801610323236	1	2400	1	0	\N	\N
3860	SALSA AJO Y OREGANO 200G 	1	7802410452003	1	1500	1	1200	\N	\N
6329	MAYONESA MAGGI 90G	1	8445290002808	1	600	1	0	\N	\N
6330	TE PENNYROYAL SUPREMO 	1	7801875001955	1	1200	1	0	\N	\N
6331	COMINO ENTERO 15G EDRA	1	7802420005268	1	350	1	0	\N	\N
2001	FANTA DESECHABLE 1,5 LT	48	7801610002261	1	1700	1	0	\N	\N
3629	JENGIBRE EN POLVO 15G	1	7802420002212	1	320	1	0	\N	\N
1696	ROMERO 10G MARCO POLO	1	7802420811487	1	320	1	0	\N	\N
1707	CIBOULETTE 2G MP 	1	7802420110054	1	390	1	0	\N	\N
1915	FANTA RETORNABLE 3 LT	49	7801610333426	1	2400	1	2000	\N	\N
6333	PIÑAS RODAJAS SAN REMO 565G	1	8858710000047	1	2200	1	0	\N	\N
6335	BEBIDA EXPRESS COCA COLA 237ML	1	7801610880104	1	300	1	0	\N	\N
6336	PIÑAS EN TROCITOS SAN REMO 565G	1	8858710000054	1	2200	1	0	\N	\N
1970	FANTA LATA 350 CC	48	7801610002193	1	700	1	0	\N	\N
5838	PERAS BC 800G	1	7793360002236	1	2200	1	0	\N	\N
1918	SPRITE ZERO RETORNABLE 2 LT	50	7801610223284	1	1300	1	1000	\N	\N
2000	SPRITE DESECHABLE 3 LT	49	7801610005651	3	2400	1	0	\N	\N
6339	VITAL CON GAS 2.5	1	7802820251005	1	850	1	0	\N	\N
4129	DURAZNO EN MITADES HOMAR 820 G 	1	7804645050467	1	2800	1	2300	\N	\N
4974	DURAZNOS EN CUBO 820 G	1	7804645050481	1	2800	1	1850	\N	\N
6341	MANJAR SIN LACTOSA380G COLUN	1	7802920010298	1	2050	1	0	\N	\N
6343	MANJAS LOS NOGALES 200G	1	7801907067782	1	1200	1	0	\N	\N
5480	NUTELLA 350 GR 	1	80177173	1	6490	1	5390	\N	\N
3304	LEVADURA COLLICO 125 G	1	7803010031056	1	2100	1	1750	\N	\N
6337	YERBA MATE DONA JAVIERA 500 G	1	7801875067036	1	2600	1	0	\N	\N
750	TE  20 U MILDREN	1	7801875052018	1	1100	1	650	\N	\N
3293	PURE INSTANTANEO  250 GRS MAGGI	1	7802950006827	1	1900	1	0	\N	\N
3679	PURE DE PAPAS ALCAFOOD 250G 	1	7804638830076	1	1750	1	0	\N	\N
6338	YERBA MATE VERDEFLOR 1KG	1	7793670000076	1	4990	1	0	\N	\N
6340	CREMA ESPINACA PUERRO CIBOULETTE 44G	1	7613287529404	1	990	1	0	\N	\N
6342	CREMA ZAPALLO	1	7613287529329	1	990	1	0	\N	\N
6344	CREMA CHAMPINONES 	1	7613287529350	1	990	1	0	\N	\N
603	SOPA POLLO FIDEOS MAGGI	1	7802950006612	1	690	1	450	\N	\N
5868	CONFORT DOBLE HOJA 8 ROLLOS	1	7806500508724	1	2550	1	0	\N	\N
6346	DURAZNOS EN CUBITOS NUESTRA COCINA 4 UN 452G	1	7807975003905	1	2400	1	0	\N	\N
5976	EL VERGEL COCTEL DE FRUTAS 	1	7801800107813	1	1650	1	0	\N	\N
129	DURAZNOS MITADES WASIL 590 GRAMOS 	1	7801305100258	1	1750	1	1500	\N	\N
6347	FRUTILLAS ENTERAS EN ALMIBAR ACONCAGUA 570G	1	7801800100104	1	2300	1	0	\N	\N
4132	POWER ADE ROJO  1 LT COCACOLA	54	7802820701210	1	1000	1	0	\N	\N
4829	POWER ADE NARANJA    600 ML COCACOLA	54	7802820651003	1	900	1	850	\N	\N
1961	BENEDICTINO C/GAS  500 CC COCACOLA	53	7802820441123	1	600	1	500	\N	\N
6348	LUCKY STRIKE COMPACT 	1	78026179	1	3600	1	0	\N	\N
6349	LUCKY COMPACT FRESH WILD 	1	78026162	1	3600	1	0	\N	\N
6350	MANJAR NESTLE 400G	1	7613287558947	1	2250	1	0	\N	\N
6351	ELITE ULTRA DOBLE HOJA 4 R X 50MTS	1	27806500509820	1	3490	1	0	\N	\N
5106	CONFORT NOBLE 6 ROLLOS 22M	1	7806500508533	1	1990	1	1650	\N	\N
6352	NECTAR WATTS MANZANA 1.5	1	7730130002614	1	1500	1	0	\N	\N
329	PAÑALES HUGGIES XXG 16UN	2	7809604029430	1	4700	1	0	\N	\N
566	NECTAR LIGHT NARANJA PET  1,5 LT WATTS	5	7801620853396	1	1500	1	1350	\N	\N
6353	PAÑALES HUGGIES XXG 14 UN 	1	7809604029911	1	4100	1	0	\N	\N
2933	CACHANTUN MAS PIÑA 	1	7801620008338	1	1100	1	1000	\N	\N
6354	BABYSEC G 18UND	1	7806500799481	1	3990	1	0	\N	\N
489	CACHANTUN MAS PERA 500 CC	5	7801620004859	1	850	1	800	\N	\N
6355	TE CLUB CEYLAN PEMIUM 50 BLS 	1	7802420006128	1	2200	1	0	\N	\N
6356	KETCHUP HEINZ 900G 	1	608875007713	1	2850	1	0	\N	\N
6155	MAYODELI KRAFT 850G	1	7802351000912	1	3890	1	0	\N	\N
497	CACHANTUN SIN GAS 500 CC	5	7801620015817	1	650	1	600	\N	\N
3409	JABON SIMONSDS	1	7804945010635	1	2100	1	0	\N	\N
6357	MOSTAZA HEINZ 60G	1	7802351001063	1	600	1	0	\N	\N
5530	CACHANTUN CON GAS 2.5 LT	1	7801620005887	1	850	1	800	\N	\N
265	KETCHUP DON JUAN 100 GRAMOS 	1	7802351611002	1	400	1	0	\N	\N
1678	MAYONESA DON JUAN 100G.	1	7802351624002	1	400	1	0	\N	\N
6358	JABON BALLERINA 1LT	1	7804920003164	1	2000	1	0	\N	\N
6359	CACHANTUN SIN GAS 2.5	1	7801620005894	1	850	1	0	\N	\N
2771	LADY SOFT TAMPONES REGULAR 8UN. 	1	7806500966012	1	2100	1	0	\N	\N
1752	TAMP. NOSOTRAS SUPER 3UN.	1	7702026173746	1	2200	1	0	\N	\N
516	PAP RETORNABLE  2,5 LT CCU	5	7801620172725	1	1750	1	1700	\N	\N
4505	MAJIX ESPUMA DE AFEITAR SPORT	1	8696630128713	1	2100	1	0	\N	\N
4506	ESPUMA DE AFEITAR MAJIX OLIVE OIL 	1	8696630130259	1	2100	1	0	\N	\N
93	CLORINDA CONCENTRADO 250 G	2	7805080100014	1	550	1	0	\N	\N
6361	QUITAMANCHAS BLANCO CLOROX 960G	1	7805025693342	1	1600	1	0	\N	\N
96	CLORINDA GEL ORIGINAL 500 G	2	7805080691536	1	1150	1	0	\N	\N
1767	SAPOLIO SACAGRASA 650ML 	2	7751851559324	1	2100	1	1600	\N	\N
6365	RAID CASA Y JARDIN 271G	1	7790520992055	1	3790	1	0	\N	\N
6367	BETUN LIQUIDO VIRGINIA 60ML	1	7805040001665	1	1300	1	0	\N	\N
4310	IMPEKE 930G 	1	7806810029056	1	1850	1	0	\N	\N
6370	VANISH BLANCO TOTAL 450ML	1	7702626214948	1	1800	1	0	\N	\N
6372	VANISH MULTIUSO 450ML	1	7702626214931	1	1800	1	0	\N	\N
126	OMO MATIC 800 GRAMOS 	2	7805000313715	1	2400	1	0	\N	\N
6375	BRIGHT LIGHT 400G	1	614143695193	1	1000	1	0	\N	\N
6378	TRAPERO HUMEDO TEDDY 12 UN	73	7808304315911	1	3290	1	0	\N	\N
6379	LAVALOZAS DORA 250ML	73	7805023000234	1	400	1	0	\N	\N
6382	LAVALOZAS VIRGINIA 450ML	73	7805040001382	1	990	1	0	\N	\N
5713	ABRILLANTADOR BLEM REPUESTO	1	7790520993953	1	2990	1	0	\N	\N
6384	FILM ADHERENTE ILCO 20METROS	1	7806810200745	1	1500	1	0	\N	\N
6050	LAVALOZAS IMPEKE 750 ML	1	7806810020992	1	1800	1	0	\N	\N
6387	LAVALOZAS MASTER 759ML 	73	945127013	1	1200	1	0	\N	\N
6390	CERA LIQUIDA BLEM INCOLORO 800ML	1	7790520992949	1	2450	1	0	\N	\N
6393	ABRILLANTADOR BLEM 800ML	1	7790520993946	1	3890	1	0	\N	\N
6395	CERA LIQUIDA BLEM PRCELANATO 800CM	1	7790520992895	1	2450	1	0	\N	\N
68	CERA NUGGET INCOLORA 340 C 	2	7805010001558	1	1650	1	1400	\N	\N
67	CERA NUGGET AMARILLA 340 CC 	2	7805010001534	1	1650	1	1400	\N	\N
431	RINSO MATIC 700G	2	7805000319229	1	1500	1	0	\N	\N
6398	TRAPERO AMARILLO BRIGHT LIGHT 	1	700083653536	1	1200	1	0	\N	\N
6399	VIRUTEX AROMA VITALIDAD 900ML	1	7806810016353	1	1500	1	0	\N	\N
6400	PAPEL HIGENICO NOBLE 1 UN 40 METROS	24	7806500508557	1	400	1	0	\N	\N
4289	NOVA	1	7806500241416	1	500	1	550	\N	\N
6360	SHAMPOO BALLERINA 900ML	1	7804920006905	1	2000	1	0	\N	\N
5047	TRIPACK PEPSODENT 90 GR	1	7805000180898	1	2500	1	2390	\N	\N
6362	FRESH UP 3 EN 1 125 G	1	6957136500192	1	2500	1	0	\N	\N
6364	SHAMPOO ONDAS Y RIZOS BALLERINA 900ML	1	7804920007155	1	2000	1	0	\N	\N
6366	ACONDICIONADOR DETOX 900ML BALLERINA	1	7804920005274	1	2000	1	0	\N	\N
102	COLGATE TRIPLE ACCIÓN 50 G 	2	7891024131909	1	600	1	0	\N	\N
6368	SHAMPOO GRANADA S/SAL BALLERINA 900 ML	73	7804920003201	1	2000	1	0	\N	\N
6369	SHAMPOO BALLERINA ACCION ANTIOXIDANTE 900ML	1	7804920006172	1	2000	1	0	\N	\N
6374	ACONDICIONADOR DETOX BALLERINA 900ML 	1	7804920007469	1	2000	1	0	\N	\N
6376	ACONDICIONADOR BAJOPOO 900ML	1	7804920005908	1	2000	1	0	\N	\N
6386	TOALLITAS HUMEDAS FRESH UP 	73	7804670490009	1	2100	1	0	\N	\N
6389	TOALLITAS HUMEDAS HUGGIES 80 UN 	1	7794626996689	1	2590	1	0	\N	\N
6392	TOALLA HUMEDA BABYSEC X3	73	7806500731221	1	1100	1	0	\N	\N
6401	GARNIER 7.7 CASTANO CARAMELO	1	7898587775939	1	2200	1	0	\N	\N
2605	ALWAYS SECA NOCHE 8UN. 	1	7590002012383	1	1550	1	0	\N	\N
2917	SEVEN UP LIGHT DES.2 LTS	75	7801620855161	1	1000	1	0	\N	\N
6363	LIMON SODA 2 LT 	1	7801620340216	1	1390	1	0	\N	\N
486	ORANGE CRUSH ZERO DES.2LTS	5	7801620853198	1	1100	1	1300	\N	\N
514	LIMON SODA  500 CC 	5	7801620016111	1	1000	1	900	\N	\N
6260	CANADA DRY 500ML	1	7801620016128	1	1000	1	900	\N	\N
3070	PEPSI DES.500 ML	75	7801620075941	1	1000	1	900	\N	\N
6371	FANTA FRUTILA 591CC	1	7801610777664	1	1000	1	0	\N	\N
6373	FANTA PIÑA 591CC	1	7801610257098	1	1000	1	0	\N	\N
6377	ALOEVERA HOMER 500 ML	1	7804645050221	1	1300	1	0	\N	\N
5703	LIMAO	1	7896186300637	1	1200	1	1000	\N	\N
6380	JUGO JUMEX PERA 335ML	1	7501013118018	1	1300	1	0	\N	\N
6383	JUGO MEYSU 330 ML	1	8681049021137	1	1200	1	0	\N	\N
6385	JUGO MEYSUI MANZANA 330 ML	1	8681049021205	1	1200	1	0	\N	\N
6388	JUGO MEYSUI NARANJA 330ML	1	8681049021151	1	1200	1	0	\N	\N
6391	JUGO MEYSUI PIÑA 330 ML	1	8681049021199	1	1200	1	0	\N	\N
6394	BEBIDA CARAMEL 240 ML 	1	884394003249	1	2000	1	0	\N	\N
6396	FANTA PIÑA 1.75	1	7801610251768	1	1700	1	0	\N	\N
6397	FANTA PIÑA 1.75	1	7801610253762	1	1700	1	0	\N	\N
1737	GOLD CHOC Y ALMENDRAS 165 GR	21	7802900000363	1	600	1	0	\N	\N
4336	LECHE CULTIVADA FRUTILLA 1 LT SOPROLE	1	7802900170028	1	2200	1	1900	\N	\N
6095	LECHE CULTIVADA SOPROLE 1 LT 	1	7802900170059	1	2200	1	1900	\N	\N
6402	LECHE CULTIVADA CHIRIMOYA 1LT	1	7802900170301	1	2200	1	0	\N	\N
2562	CREMA CHANTILLY SOPROLE 250G	1	7802900097011	1	3690	1	3500	\N	\N
1849	YOGHURT BATIDO PLATANO  120 GR SOPROLE	21	7802900230296	1	300	1	250	\N	\N
993	FLAN CARAMELO 120 GR NESTLE	4	7613035493988	1	350	1	0	\N	\N
6403	COMPOTA MANZANA NESCLE1200 G	1	7613037839326	1	450	1	0	\N	\N
6404	VIONESAS SOLER 5 UNIDADES	1	7801927052614	1	2000	1	0	\N	\N
1436	SALCHICHAS PREMIUM RECETA DEL ABUELO 5 UN.	33	7801930007120	1	1300	1	1200	\N	\N
1438	SALCHICHA PAVO  5 UN PF	33	7801930000923	1	800	1	750	\N	\N
6405	QUESO MOZARELLA 200G	1	7804647570727	1	2350	1	0	\N	\N
3178	QUESO LAMINADO FRUTILLAR 250G	1	7801930018614	1	2600	1	2300	\N	\N
6022	MIX GENOVA 60GR	1	781159477492	1	1000	1	990	\N	\N
6381	KENT NEO 20	1	78026384	1	4000	1	0	\N	\N
6406	VITAL 2.5 LT 	1	7802820252002	1	900	1	0	\N	\N
6410	HABAS 500GR	1	7801220701011	1	1500	1	0	\N	\N
1538	BOLSOS DE REGALO CON CORDON 22X18 CM 	34	2000000000701	1	1300	1	900	\N	\N
6412	AMPOLLETAS LED BRIGHT 	1	7804660913419	1	1100	1	0	\N	\N
3573	MR. BIG LATA 330CC	54	9120033164782	1	1500	1	1000	\N	\N
3277	PAN PITA INTEGRAL 300 GR IDEAL	24	7803473000750	1	1600	1	1200	\N	\N
6417	MENTOS CLEAR BREATH 	1	80918516	1	1000	1	0	\N	\N
6418	MENTOS FRUIT 	1	75068318	1	400	1	0	\N	\N
6419	MENTOS MENTA 	1	75069414	1	300	1	0	\N	\N
6420	NAMUR 25 GR	1	7790380003816	1	300	1	0	\N	\N
6426	LILY MUÑECA SORPRESA 	1	8590311101258	1	1800	1	0	\N	\N
6427	HUEVO DINO SORPRESA 	1	6957342908683	1	250	1	0	\N	\N
4542	DE TODITO 290GR 	1	7802000015182	1	2600	1	2400	\N	\N
5190	SOPROLE QUESO MANTECOSO QUILQUE 15 LAMINAS 250G	1	7802900001339	1	2600	1	2200	\N	\N
4783	ADULTOS CARNE 85G	1	7802575531735	1	650	1	0	\N	\N
1216	GANSITO 50G MARINELA 	1	7803473543189	1	450	1	350	\N	\N
5434	AVENA MULTISEMILLA QUAKER	1	7802000015014	1	2990	1	2600	\N	\N
3620	PRINGLES ORIGINAL 149G 	1	038000138416	1	2450	1	1990	\N	\N
2208	BOLSA  PAPEL PAN CHICA	12	655	1	100	1	0	\N	\N
6407	CEREAL CORN FLAKES 500G 	1	LÑK7896004004549	1	3490	1	0	\N	\N
4103	CEREAL TRITON 360G	1	7613039565827	1	2650	1	0	\N	\N
5592	CEREAL TRIX 300 GR	1	7613287593436	1	2650	1	0	\N	\N
6408	PACK TRITON VAINILLA 378 G	1	7613033820045	1	1690	1	0	\N	\N
6409	COLA CAO POLLOWS 200G	1	7802420006982	1	1650	1	0	\N	\N
1247	ALTEZA OBLEA CHIRIMOYA 140 GRS	26	7802230082510	1	950	1	0	\N	\N
4319	LAYS MEDITERRANEAS JAMON SERRANO 34G EVERCRIPS	1	7802000014857	1	600	1	0	\N	\N
6411	TRITON DOBLE CREMA 147 G	1	7613287493026	1	700	1	0	\N	\N
5448	DUO CHOCOLATE 500G	1	8410376017113	1	2400	1	2100	\N	\N
6413	TRIPACK CRACKER 270G 	1	7802225688994	1	1500	1	0	\N	\N
6414	CREMONA 140 G	1	7802408005372	1	500	1	0	\N	\N
3967	NUTELLA GO 	1	062020050526	1	1490	1	0	\N	\N
6415	CREMONA 150G	1	7802408005402	1	500	1	0	\N	\N
187	GALLETAS SODA 54 GR 	6	7802215511615	1	250	1	0	\N	\N
4643	TRI-PACK SODA 540 G 	1	7802225683692	1	2300	1	0	\N	\N
3533	GALLETA MINI COCADITAS  40 GRS COSTA	1	7802215505980	1	300	1	250	\N	\N
6416	SELZ CLASICA 42 G	1	7802225684767	1	300	1	0	\N	\N
4084	OBLEA DOS EN UNO 108	1	7896058200058	1	950	1	0	\N	\N
4085	OBLEA DOS EN UNO 108	1	7896058258141	1	950	1	0	\N	\N
2257	GALLETA MANTEQUILLA  140 GR COSTA	26	7802215505294	1	650	1	0	\N	\N
5354	LOS TILOS QUESO FRESCO 350G	1	7802080000146	1	2500	1	2200	\N	\N
1291	LECHE BLANCA ENTERA SOPROLE 1 LT	21	7802900001308	1	1150	1	0	\N	\N
6421	LECHE CHICA LONCO LECHE 200 ML	1	7802910000544	1	450	1	0	\N	\N
6422	LONCO LECHE CHOCOLATE 200 ML	1	7802910054202	1	450	1	0	\N	\N
6423	NOT MILK 1LT CHOCOLATE	1	7804659650172	1	2790	1	0	\N	\N
6424	NOT MILK 1LT 	1	7804659650066	1	2550	1	0	\N	\N
6425	LECHE LONCO LECHE 1LT SIN LACTOSA VAINILLA	1	7802910005013	1	1600	1	0	\N	\N
6428	LECHE ALMENDRA VEGETAL 1 LT 	1	7790742340108	1	3500	1	0	\N	\N
6429	LECHE DE ALMENDRAS QUILLAYES 1LT	1	7802930005369	1	3500	1	0	\N	\N
6430	LECHE DE ARROZ QUILLAYES SIN AZUCAR 1LT	1	7802930005383	1	3500	1	0	\N	\N
6431	LECHE ENTERA NATURAL LONCO LECHE 1 LT	1	7802910007253	1	1100	1	0	\N	\N
6432	MICRO USB 	1	7809601110988	1	2200	1	0	\N	\N
3310	PAN DE COMPLETO IDEAL XL 6PZAS.	1	7803403002632	1	1650	1	1500	\N	\N
5126	PAN IDEAL LINAZA CHIA 650 GR 	1	7803480001269	1	2500	1	0	\N	\N
6433	LAZAÑA PF 330G	1	7801930022406	1	2500	1	0	\N	\N
6434	PAELLA PF 330G 	1	7801930000732	1	2500	1	0	\N	\N
3367	TORTILLA GRANDOTA XXL 8 UNDS TIA ROSA	1	7803403002304	1	2200	1	2000	\N	\N
6435	BARRA PROTEICA GIBIT 15G	1	7800955252140	1	1690	1	0	\N	\N
6436	KIWICHA BARRA DE CEREAL 	1	703980799093	1	1500	1	0	\N	\N
6437	ALFAJOR LAGOS DEL SUR 45 GR	1	7803400000204	1	600	1	0	\N	\N
4629	LAYS 42 G	1	7802000014765	1	600	1	0	\N	\N
6438	DORITOS SABOR A QUEZO 42 G	1	7802000014833	1	600	1	0	\N	\N
6439	KIWICHA AMARANTO 60 GR	1	703980799079	1	1500	1	0	\N	\N
6440	GATOLATE CHOCOLATE 100G	1	7802000015717	1	1600	1	0	\N	\N
6441	CHEEZELS100G	1	7802000015687	1	1600	1	0	\N	\N
6442	KIWICHA PLATANO 60GR	1	703980799086	1	1500	1	0	\N	\N
6443	RAMITAS QUEZO 110G 	1	7802000015786	1	1200	1	0	\N	\N
6444	RAMITAS 110G 	1	7802000015793	1	1200	1	0	\N	\N
6445	TORTILLA ANDALE CASTAÑO 340 G	1	7803468003452	1	1500	1	0	\N	\N
6446	BRAZO DE REINA AGUA DE PIEDRA	1	7803403000478	1	2800	1	0	\N	\N
6447	PASAS KIÑE 100GR	1	658325372007	1	1050	1	0	\N	\N
6448	MARAVILLA KIÑE 230GR	1	658325372144	1	1350	1	0	\N	\N
6449	MARAVILLAS KIÑE 330GR	1	658325371772	1	1950	1	0	\N	\N
6450	MARAVILLA 120GR	1	658325372151	1	950	1	0	\N	\N
6451	CHARQUI KIÑE 40 GR 	1	658325372205	1	2990	1	0	\N	\N
6452	CHARQUI 20 GR 	1	658325372212	1	1550	1	0	\N	\N
6453	PISTACHOS 40 GR	1	658325371895	1	1350	1	0	\N	\N
6454	ALMENDRAS KIÑE 50 GR 	1	658325371901	1	1050	1	0	\N	\N
6455	MANI KIÑE 100 GR 	1	658325371864	1	950	1	0	\N	\N
6456	MANI JAPONES KIÑE 100 GR 	1	658325372120	1	950	1	0	\N	\N
6457	MANI KIÑE 180 GR 	1	658325371833	1	1050	1	0	\N	\N
6459	CHARQUI 60 GR 	1	658325372199	1	4050	1	0	\N	\N
6461	MANI CON CASCARA 100 GR 	1	658325372243	1	1050	1	0	\N	\N
6462	FRUTOS SECOS 100 GR 	1	658325372236	1	1050	1	0	\N	\N
6464	MANI CONFITADO 100 GR 	1	658325371840	1	950	1	0	\N	\N
6470	CAREZZA COSTA 120GR	1	7802215101786	1	1900	1	0	\N	\N
6471	TRENCITO MANJAR 128 	1	8445290004383	1	1900	1	0	\N	\N
6474	CHOCOLATE SIN AZUCAR GEORGALOS 70GR	1	4790390024859	1	1400	1	0	\N	\N
6476	SAHNE-NUSS SIN AZUCAR 100 GR 	47	7613030155973	1	3300	1	0	\N	\N
6479	QUESO LAMINADO LOS CRIADORES 500 GR 	1	7804608121791	1	6300	1	0	\N	\N
6458	KANIKAMA 500 G	1	7804635611296	1	1800	1	0	\N	\N
6460	LOMO SALMON AQUA 85 G	1	7809611718389	1	1050	1	0	\N	\N
6463	ARITOS REBOZADOS 400G	1	8411076014259	1	6950	1	0	\N	\N
6465	SURTIDO DE MARISCOS 1KILO	1	7804660840166	1	4990	1	0	\N	\N
6466	FIKLETE SALMON ATLANTICO 500 G	1	7809611719171	1	11250	1	0	\N	\N
6467	NUGGETS DE SALMON 200G	1	7809611719331	1	1900	1	0	\N	\N
6468	MERLUZA CON PIEL EL GOLFO 500G	1	7801323004026	1	4500	1	0	\N	\N
6469	CAMARON DULCE MAR 500 G	1	7804641410036	1	6890	1	0	\N	\N
6472	MANIAX LIMON AJI 5G	1	7790310984888	1	600	1	0	\N	\N
6473	MANIAX SABOR A QUESO 45G	1	7500478025848	1	600	1	0	\N	\N
5370	MANI PASAS Y ALMENDRAS 150G	1	7802000006173	1	1500	1	0	\N	\N
2712	PAPA FRITA CORTE AMERICANO MARCOPOLO 420 GR	1	7802420151378	1	2500	1	2200	\N	\N
6475	INFIERNO RUSTICAS 175G	1	7802351002244	1	1700	1	0	\N	\N
6477	INFIERNOI SPICY CHEDDAR 250G	1	7802351002206	1	1200	1	0	\N	\N
6478	GANSITO GALLETA	1	7500810001127	1	500	1	0	\N	\N
6480	FRUTOS DEL BOSQUE	1	7800000010138	1	5000	1	0	\N	\N
6481	CHOCOLATE CHIPS 	1	7800000010121	1	5000	1	0	\N	\N
6482	CREAMY CHOCOLATE 	1	7804664380286	1	5000	1	0	\N	\N
6483	COOKIES Y CREAM	1	7804664380255	1	5000	1	0	\N	\N
6484	MENTA CHIPS	1	7804664380279	1	5000	1	0	\N	\N
6485	FRIENDLYS CHOCOLATE ALMOND CHIP	1	029839006960	1	6300	1	0	\N	\N
6486	BREYERS EXTRACREAMY CHOCOLATE 1.5 LT	1	077567250056	1	6300	1	0	\N	\N
6487	BREYERS CHOCOLATE PEANUT BUTTER 1.5LT	1	077567603326	1	6300	1	0	\N	\N
6488	BREYERS SALTED CARAMEL 1.5 LT	1	077567254450	1	6300	1	0	\N	\N
6489	BREYERS MINT CHOCOLATE CHIP	1	077567254245	1	6300	1	0	\N	\N
6490	BREYERS DOUBLE COOKIE CRUMBLE 1.5 LT	1	077567254504	1	6300	1	0	\N	\N
6491	HELADO CHIRIMOYA GUALLARAUCO	1	7803908000812	1	900	1	0	\N	\N
6492	CALIPPO LIMA LIMON	1	7802705401167	1	990	1	0	\N	\N
6493	CALIPPO FRUTILLA 	1	7802705401181	1	990	1	0	\N	\N
6494	HELADO ROLLS BRESLER 531 G	1	7802705401389	1	4300	1	0	\N	\N
6495	MAGNUM CHOCOLATE BLANCO FRAMBUESA 	1	7805000318079	1	4990	1	0	\N	\N
6496	CASATA BRESLER VAINILLA 504G	1	Q7805000305284	1	2990	1	0	\N	\N
6497	ELADO PURA FRUTA MANGO	1	7613037777741	1	1000	1	0	\N	\N
6498	CASATA CREMERIA DULCE DE FRAMBUESA 1LT	1	7613036570572	1	4500	1	0	\N	\N
6499	HELADO POSTRE DULCE DE LECHECHOCOLATE 535G	1	8445290110039	1	3990	1	0	\N	\N
6500	CRAZY FRAMBUESA	1	7613035779037	1	1100	1	0	\N	\N
6501	PURA FRUTA SABORY	1	7613287843586	1	3490	1	0	\N	\N
6502	FLAGG 120 G	1	7801552005733	1	900	1	0	\N	\N
6503	HELADO HAWAI 	1	7801552006587	1	900	1	0	\N	\N
6504	COLUMBIA 60G	1	7801552005979	1	350	1	0	\N	\N
6505	HELADO CONTUTI 80G 	1	7801552006679	1	550	1	0	\N	\N
6506	BONGELATA SABOR TIRAMISU	1	7801552000196	1	2790	1	0	\N	\N
6507	HAMBURGUESA BIGDE POLLO	1	7801965001537	1	1200	1	0	\N	\N
6508	HAMBURGUESA DE POLLO SAN JORGE 90G	1	7801907006859	1	750	1	0	\N	\N
6509	PAPAS PREFRITAS SAN JORGE CRUJIENTES Y HONEABLES 1KILO	1	7801907022880	1	2200	1	0	\N	\N
6510	NUGGETS DE POLLO 300G	1	7801907026208	1	1300	1	0	\N	\N
6511	PAPAS DUQUESAS 1KILO SAN JORGE	1	7801907001458	1	2500	1	0	\N	\N
6512	HAMBURGUESA MASTODONTE185 G	1	7809611708410	1	1300	1	0	\N	\N
6513	CABRITAS KIÑE	1	658325372267	1	700	1	0	\N	\N
2507	CHOC. HEIDI DARK ESPRESSO 80G	1	5941021001247	1	2650	1	2200	\N	\N
3583	1MAS 1 CHOC	1	7802900337414	1	550	1	0	\N	\N
902	BOMBOM CHERRY AMBROSOLI UNIDAD	6	206	1	250	1	0	\N	\N
1471	PERAS 	11	105	2	890	1	0	\N	\N
1395	PECHUGA DE PAVO AHUMADA PF 	3	50	2	12000	1	8900	\N	\N
118	ARIEL  MATIC 400 GRAMOS 	2	7500435137393	1	1200	1	0	\N	\N
\.


--
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 181
-- Name: producto_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_id_producto_seq', 40, true);


--
-- TOC entry 2138 (class 0 OID 28666)
-- Dependencies: 186
-- Data for Name: promocion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promocion (id_promocion, id_producto, id_estado, lunes, martes, miercoles, jueves, sabado, domingo, fecha_inicio, fecha_fin, viernes, descripcion) FROM stdin;
1	5345	1	t	f	t	f	f	t	2024-05-14	2024-05-31	f	HOLA,ES UNA PROMOCION
2	465	1	t	t	t	t	t	t	2024-05-24	2024-07-01	t	
\.


--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 185
-- Name: promocion_id_promocion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promocion_id_promocion_seq', 48, true);


--
-- TOC entry 2157 (class 0 OID 42472)
-- Dependencies: 205
-- Data for Name: promocion_por_imagen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promocion_por_imagen (id_promocion_imagen, nombre, image_data, id_datos_local, lunes, martes, miercoles, jueves, viernes, sabado, domingo, fecha_inicio, fecha_fin, id_estado) FROM stdin;
1	poster.png	\\x504e470d0a1a0a	1	t	t	t	t	t	t	t	2024-06-08	2024-06-21	1
\.


--
-- TOC entry 2148 (class 0 OID 28819)
-- Dependencies: 196
-- Data for Name: tipo_img; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_img (id, tipo_img) FROM stdin;
1	Fondo
2	Logo
\.


--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 195
-- Name: tipo_img_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_img_id_seq', 2, true);


--
-- TOC entry 2126 (class 0 OID 20190)
-- Dependencies: 174
-- Data for Name: tipo_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_usuario (id_tipo_usuario, nombre_tipo_usuario) FROM stdin;
2	Cajero
3	lector
1	Administrador
\.


--
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 173
-- Name: tipo_usuario_id_tipo_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_usuario_seq', 3, true);


--
-- TOC entry 2130 (class 0 OID 20206)
-- Dependencies: 178
-- Data for Name: umedida; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.umedida (id_umedida, nombre_umedida, nombre_corto, id_estado) FROM stdin;
1	UNIDAD	UN	1
2	KILOGRAMO	KG	1
3	LITRO	LT	1
4	GRAMO	GR	1
5	MILIMETRO	ML	1
6	CENTIMETRO CUBICO	CC	1
\.


--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 177
-- Name: umedida_id_umedida_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.umedida_id_umedida_seq', 14, true);


--
-- TOC entry 2136 (class 0 OID 20373)
-- Dependencies: 184
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, rut, nombre_usuario, apellido1, apellido2, correo, telefono, id_genero, contrasena, id_estado, id_tipo_usuario, id_datos_local, token) FROM stdin;
1	77.115.675-4	DATAMAULE	.	.	datamaule@gmail.com	987654321	3	$2y$10$0SkOF0cv1.Z0xQPeeSa93ebZVjLlVyzt6jvthqCKDRcw5LpqzO09W	1	1	1	ad54f8ab1f78302e154812f7d1f2af36
30	21.603.401-5	matias	sepulveda	avila	asd@asd.cl	987654321	1	$2y$10$PPg4UtXbr2vzUg.iiLCb8OzecgaaBnp6DGl6KiNiiejrU1aqLey1y	1	1	1	5d2dd40eb4d95771070ee86810352df7
\.


--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 183
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 30, true);


--
-- TOC entry 1979 (class 2606 OID 28785)
-- Name: configuraciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.configuraciones
    ADD CONSTRAINT configuraciones_pkey PRIMARY KEY (id_configuracion);


--
-- TOC entry 1987 (class 2606 OID 42338)
-- Name: configuracionespromocion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.configuracionespromocion
    ADD CONSTRAINT configuracionespromocion_pkey PRIMARY KEY (id_configuracionespromocion);


--
-- TOC entry 1975 (class 2606 OID 28747)
-- Name: datos_local_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.datos_local
    ADD CONSTRAINT datos_local_pkey PRIMARY KEY (id_datos_local);


--
-- TOC entry 1955 (class 2606 OID 20203)
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 1959 (class 2606 OID 20219)
-- Name: familia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.familia
    ADD CONSTRAINT familia_pkey PRIMARY KEY (id_familia);


--
-- TOC entry 1985 (class 2606 OID 42330)
-- Name: fuente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.fuente
    ADD CONSTRAINT fuente_pkey PRIMARY KEY (id_fuente);


--
-- TOC entry 1951 (class 2606 OID 20187)
-- Name: genero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_pkey PRIMARY KEY (id_genero);


--
-- TOC entry 1977 (class 2606 OID 28758)
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- TOC entry 1973 (class 2606 OID 28723)
-- Name: images_promocion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.images_promocion
    ADD CONSTRAINT images_promocion_pkey PRIMARY KEY (id);


--
-- TOC entry 1989 (class 2606 OID 42356)
-- Name: pk_destacado; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.destacado
    ADD CONSTRAINT pk_destacado PRIMARY KEY (id_destacado);


--
-- TOC entry 1993 (class 2606 OID 42479)
-- Name: pk_promocion_por_imagen; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.promocion_por_imagen
    ADD CONSTRAINT pk_promocion_por_imagen PRIMARY KEY (id_promocion_imagen);


--
-- TOC entry 1991 (class 2606 OID 42383)
-- Name: precio_volumen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.precio_volumen
    ADD CONSTRAINT precio_volumen_pkey PRIMARY KEY (id_precio_volumen);


--
-- TOC entry 1961 (class 2606 OID 20263)
-- Name: producto_cbarra_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_cbarra_key UNIQUE (cbarra);


--
-- TOC entry 1963 (class 2606 OID 20261)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 1969 (class 2606 OID 28675)
-- Name: promocion_id_producto_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_id_producto_key UNIQUE (id_producto);


--
-- TOC entry 1971 (class 2606 OID 28673)
-- Name: promocion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_pkey PRIMARY KEY (id_promocion);


--
-- TOC entry 1981 (class 2606 OID 28824)
-- Name: tipo_img_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.tipo_img
    ADD CONSTRAINT tipo_img_pkey PRIMARY KEY (id);


--
-- TOC entry 1983 (class 2606 OID 28826)
-- Name: tipo_img_tipo_img_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.tipo_img
    ADD CONSTRAINT tipo_img_tipo_img_key UNIQUE (tipo_img);


--
-- TOC entry 1953 (class 2606 OID 20195)
-- Name: tipo_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo_usuario);


--
-- TOC entry 1957 (class 2606 OID 20211)
-- Name: umedida_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.umedida
    ADD CONSTRAINT umedida_pkey PRIMARY KEY (id_umedida);


--
-- TOC entry 1965 (class 2606 OID 20378)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 1967 (class 2606 OID 20380)
-- Name: usuario_rut_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_rut_key UNIQUE (rut);


--
-- TOC entry 2010 (class 2606 OID 42344)
-- Name: configuracionespromocion_id_datos_local_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracionespromocion
    ADD CONSTRAINT configuracionespromocion_id_datos_local_fkey FOREIGN KEY (id_datos_local) REFERENCES public.datos_local(id_datos_local);


--
-- TOC entry 2009 (class 2606 OID 42339)
-- Name: configuracionespromocion_id_fuente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracionespromocion
    ADD CONSTRAINT configuracionespromocion_id_fuente_fkey FOREIGN KEY (id_fuente) REFERENCES public.fuente(id_fuente);


--
-- TOC entry 1995 (class 2606 OID 20220)
-- Name: familia_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.familia
    ADD CONSTRAINT familia_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 2014 (class 2606 OID 42480)
-- Name: fk_datos_local; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocion_por_imagen
    ADD CONSTRAINT fk_datos_local FOREIGN KEY (id_datos_local) REFERENCES public.datos_local(id_datos_local);


--
-- TOC entry 2011 (class 2606 OID 42357)
-- Name: fk_destacado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracionespromocion
    ADD CONSTRAINT fk_destacado FOREIGN KEY (id_destacado) REFERENCES public.destacado(id_destacado);


--
-- TOC entry 2015 (class 2606 OID 42485)
-- Name: fk_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocion_por_imagen
    ADD CONSTRAINT fk_estado FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 2013 (class 2606 OID 42394)
-- Name: fk_estado_precio_volumen; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_volumen
    ADD CONSTRAINT fk_estado_precio_volumen FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 2002 (class 2606 OID 28787)
-- Name: fk_id_datos_local; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_id_datos_local FOREIGN KEY (id_datos_local) REFERENCES public.datos_local(id_datos_local);


--
-- TOC entry 2008 (class 2606 OID 28838)
-- Name: fk_id_datos_local; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuraciones
    ADD CONSTRAINT fk_id_datos_local FOREIGN KEY (id_datos_local) REFERENCES public.datos_local(id_datos_local);


--
-- TOC entry 2007 (class 2606 OID 28827)
-- Name: fk_tipo_img; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT fk_tipo_img FOREIGN KEY (tipo_img_id) REFERENCES public.tipo_img(id);


--
-- TOC entry 2006 (class 2606 OID 28759)
-- Name: images_id_datos_local_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_id_datos_local_fkey FOREIGN KEY (id_datos_local) REFERENCES public.datos_local(id_datos_local);


--
-- TOC entry 2005 (class 2606 OID 28724)
-- Name: images_promocion_id_promocion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images_promocion
    ADD CONSTRAINT images_promocion_id_promocion_fkey FOREIGN KEY (id_promocion) REFERENCES public.promocion(id_promocion);


--
-- TOC entry 2012 (class 2606 OID 42384)
-- Name: precio_volumen_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_volumen
    ADD CONSTRAINT precio_volumen_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- TOC entry 1998 (class 2606 OID 20274)
-- Name: producto_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 1996 (class 2606 OID 20264)
-- Name: producto_id_familia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_id_familia_fkey FOREIGN KEY (id_familia) REFERENCES public.familia(id_familia);


--
-- TOC entry 1997 (class 2606 OID 20269)
-- Name: producto_id_umedida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_id_umedida_fkey FOREIGN KEY (id_umedida) REFERENCES public.umedida(id_umedida);


--
-- TOC entry 2004 (class 2606 OID 28681)
-- Name: promocion_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 2003 (class 2606 OID 28676)
-- Name: promocion_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- TOC entry 1994 (class 2606 OID 28859)
-- Name: umedida_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.umedida
    ADD CONSTRAINT umedida_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 2001 (class 2606 OID 20391)
-- Name: usuario_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 2000 (class 2606 OID 20386)
-- Name: usuario_id_genero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_genero_fkey FOREIGN KEY (id_genero) REFERENCES public.genero(id_genero);


--
-- TOC entry 1999 (class 2606 OID 20381)
-- Name: usuario_id_tipo_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_tipo_usuario_fkey FOREIGN KEY (id_tipo_usuario) REFERENCES public.tipo_usuario(id_tipo_usuario);


--
-- TOC entry 2165 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-07-01 13:51:49

--
-- PostgreSQL database dump complete
--

