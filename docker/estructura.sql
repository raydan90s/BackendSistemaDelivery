--
-- PostgreSQL database dump
--

\restrict fFM9t9z9SecUYxUoOjhtGsqZnD2FZDj1ecRne34i6eoejz37a4cqBFbYJyjdHRU

-- Dumped from database version 18.0 (Debian 18.0-1.pgdg13+3)
-- Dumped by pg_dump version 18.0 (Debian 18.0-1.pgdg13+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actblactivofijo; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.actblactivofijo (
    iidactivo bigint NOT NULL,
    sdescripcion smallint,
    vdescripcionextendida character varying(150),
    smarca character varying(50),
    smodelo smallint,
    vnumerodeserie character varying(50),
    sfamilia smallint,
    vfactura character varying(50),
    sproveedor smallint,
    dfechaadquisicion date,
    dvaloradquisicion numeric(9,2),
    sclase smallint,
    suso smallint,
    sestadofisico smallint,
    subicacion smallint,
    vresponsable character varying(20),
    btienegarantia boolean DEFAULT false,
    dfechadesdeg date,
    dfechahastag date,
    begresado boolean DEFAULT false,
    vusuarioaut character varying(30),
    vmotivoegreso character(1),
    scondicion smallint,
    dfechaegreso date,
    CONSTRAINT chk_activo_valor CHECK ((dvaloradquisicion >= (0)::numeric))
);


ALTER TABLE public.actblactivofijo OWNER TO "Arrobo";

--
-- Name: actblactivofijo_iidactivo_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.actblactivofijo_iidactivo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actblactivofijo_iidactivo_seq OWNER TO "Arrobo";

--
-- Name: actblactivofijo_iidactivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.actblactivofijo_iidactivo_seq OWNED BY public.actblactivofijo.iidactivo;


--
-- Name: actblactivofijomovimientos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.actblactivofijomovimientos (
    iidmovimiento bigint NOT NULL,
    iidactivo bigint NOT NULL,
    subicacion smallint,
    vresponsable character varying(20),
    dfechamovimiento timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    snuevaubicacion smallint,
    vnuevoresponsable character varying(20),
    vusuario character varying(20) NOT NULL,
    vusuarioaut character varying(30),
    vmotivo character varying(250)
);


ALTER TABLE public.actblactivofijomovimientos OWNER TO "Arrobo";

--
-- Name: actblactivofijomovimientos_iidmovimiento_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.actblactivofijomovimientos_iidmovimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actblactivofijomovimientos_iidmovimiento_seq OWNER TO "Arrobo";

--
-- Name: actblactivofijomovimientos_iidmovimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.actblactivofijomovimientos_iidmovimiento_seq OWNED BY public.actblactivofijomovimientos.iidmovimiento;


--
-- Name: activosarchivo; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.activosarchivo (
    num_activo double precision,
    descripcion character varying(255),
    descripcion_extendida character varying(255),
    marca character varying(255),
    modelo character varying(255),
    num_serie character varying(255),
    familia character varying(255),
    cod_cda character varying(255),
    factura character varying(255),
    proveedor character varying(255),
    fecha_adq character varying(255),
    valor_adq character varying(255),
    fecha_gt character varying(255),
    ub character varying(255),
    responsable character varying(255),
    est character varying(255)
);


ALTER TABLE public.activosarchivo OWNER TO "Arrobo";

--
-- Name: factblchequesposfechados; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.factblchequesposfechados (
    iidcheque integer NOT NULL,
    iidpaciente bigint NOT NULL,
    iidbanco integer NOT NULL,
    snumcheque character varying(20) NOT NULL,
    dfecha timestamp without time zone NOT NULL,
    dcantidad numeric(8,2) NOT NULL,
    cestado character(1) DEFAULT 'P'::bpchar NOT NULL,
    vusuario character varying(20),
    CONSTRAINT chk_cheque_cantidad CHECK ((dcantidad > (0)::numeric))
);


ALTER TABLE public.factblchequesposfechados OWNER TO "Arrobo";

--
-- Name: factblchequesposfechados_iidcheque_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.factblchequesposfechados_iidcheque_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factblchequesposfechados_iidcheque_seq OWNER TO "Arrobo";

--
-- Name: factblchequesposfechados_iidcheque_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.factblchequesposfechados_iidcheque_seq OWNED BY public.factblchequesposfechados.iidcheque;


--
-- Name: factblcuenta; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.factblcuenta (
    iidtransaccion integer NOT NULL,
    iidpaciente bigint NOT NULL,
    dfecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    dcantidad numeric(8,2) NOT NULL,
    dsaldo numeric(8,2) NOT NULL,
    cmovimiento character(1) NOT NULL,
    vusuario character varying(20),
    vconcepto character varying(250),
    CONSTRAINT chk_cuenta_movimiento CHECK ((cmovimiento = ANY (ARRAY['D'::bpchar, 'C'::bpchar])))
);


ALTER TABLE public.factblcuenta OWNER TO "Arrobo";

--
-- Name: factblcuenta_iidtransaccion_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.factblcuenta_iidtransaccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factblcuenta_iidtransaccion_seq OWNER TO "Arrobo";

--
-- Name: factblcuenta_iidtransaccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.factblcuenta_iidtransaccion_seq OWNED BY public.factblcuenta.iidtransaccion;


--
-- Name: factbltarjetas; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.factbltarjetas (
    iidtransaccion integer NOT NULL,
    iidpaciente bigint NOT NULL,
    iidbanco integer,
    vreferencia character varying(100),
    dvalor numeric(18,2) NOT NULL,
    ddescuento numeric(18,2) DEFAULT 0,
    ddisponible numeric(18,2) NOT NULL,
    dfechaingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    dfechaactualiza timestamp without time zone,
    vusuario character varying(20),
    bestado boolean DEFAULT true,
    ctipo character(1),
    dfechacheque timestamp without time zone,
    cestadoregistro character(1) DEFAULT 'A'::bpchar NOT NULL,
    CONSTRAINT chk_tarjeta_disponible CHECK ((ddisponible >= (0)::numeric))
);


ALTER TABLE public.factbltarjetas OWNER TO "Arrobo";

--
-- Name: factbltarjetas_iidtransaccion_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.factbltarjetas_iidtransaccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factbltarjetas_iidtransaccion_seq OWNER TO "Arrobo";

--
-- Name: factbltarjetas_iidtransaccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.factbltarjetas_iidtransaccion_seq OWNED BY public.factbltarjetas.iidtransaccion;


--
-- Name: facturasimpresas; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.facturasimpresas (
    talonario integer,
    numfactura integer,
    identificacion character varying(13),
    estado boolean,
    fecha timestamp without time zone
);


ALTER TABLE public.facturasimpresas OWNER TO "Arrobo";

--
-- Name: facturasimpresasdetalle; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.facturasimpresasdetalle (
    talonario integer,
    numfactura integer,
    numfacturaref integer,
    datoadicional character varying(150)
);


ALTER TABLE public.facturasimpresasdetalle OWNER TO "Arrobo";

--
-- Name: facturasruc; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.facturasruc (
    idruc character varying(13),
    razonsocial character varying(150),
    establecimiento character varying(3),
    puntoemision character varying(3),
    secuencial integer
);


ALTER TABLE public.facturasruc OWNER TO "Arrobo";

--
-- Name: fe_doc_data; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.fe_doc_data (
    iiddocument integer NOT NULL,
    ttramadoc text NOT NULL,
    vnumdoc text,
    vtipodoc character varying(2),
    vcodestab character varying(3),
    vptoemi character varying(3),
    vtipoenvio character varying(1),
    vtaxidreceptor character varying(20),
    dfechaemision timestamp without time zone,
    vtaxidemisor character varying(13)
);


ALTER TABLE public.fe_doc_data OWNER TO "Arrobo";

--
-- Name: fe_doc_send; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.fe_doc_send (
    iiddocument integer NOT NULL,
    taxidemisor character varying(13) NOT NULL,
    vtipodoc character varying(2) NOT NULL,
    iidtalonario integer,
    inumfactura integer,
    vdocumentno character varying(30) NOT NULL,
    ctosend character(1) DEFAULT 'P'::bpchar NOT NULL,
    dfechaemision timestamp without time zone,
    vtaxidreceptor character varying(20)
);


ALTER TABLE public.fe_doc_send OWNER TO "Arrobo";

--
-- Name: fe_doc_send_iiddocument_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.fe_doc_send_iiddocument_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fe_doc_send_iiddocument_seq OWNER TO "Arrobo";

--
-- Name: fe_doc_send_iiddocument_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.fe_doc_send_iiddocument_seq OWNED BY public.fe_doc_send.iiddocument;


--
-- Name: invconsultoriobodega; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invconsultoriobodega (
    iidconsultorio integer NOT NULL,
    iidbodega integer NOT NULL,
    bprincipal boolean DEFAULT false NOT NULL
);


ALTER TABLE public.invconsultoriobodega OWNER TO "Arrobo";

--
-- Name: invconsumoproductosconteo; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invconsumoproductosconteo (
    iidconsultorio integer NOT NULL,
    icodreferencia integer NOT NULL,
    iidproducto integer NOT NULL,
    icantidad integer DEFAULT 0 NOT NULL,
    icantidadusada integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_consumo_cantidad CHECK ((icantidad >= 0)),
    CONSTRAINT chk_consumo_usada CHECK ((icantidadusada >= 0))
);


ALTER TABLE public.invconsumoproductosconteo OWNER TO "Arrobo";

--
-- Name: invkitproducto; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invkitproducto (
    iidproductokit integer NOT NULL,
    iidproducto integer NOT NULL,
    dcantidad numeric(10,2) DEFAULT 1 NOT NULL
);


ALTER TABLE public.invkitproducto OWNER TO "Arrobo";

--
-- Name: invproduct; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invproduct (
    codigonom character varying(255),
    u_de_ent character varying(255),
    cant double precision,
    idcodigo integer
);


ALTER TABLE public.invproduct OWNER TO "Arrobo";

--
-- Name: invtblclasificacion; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblclasificacion (
    siclasificacion integer NOT NULL,
    vcodigo character varying(2),
    vdescclasificacion character varying(100),
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.invtblclasificacion OWNER TO "Arrobo";

--
-- Name: invtblclasificacion_siclasificacion_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblclasificacion_siclasificacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblclasificacion_siclasificacion_seq OWNER TO "Arrobo";

--
-- Name: invtblclasificacion_siclasificacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblclasificacion_siclasificacion_seq OWNED BY public.invtblclasificacion.siclasificacion;


--
-- Name: invtblegresoconsumo; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblegresoconsumo (
    iidegreso bigint NOT NULL,
    iiddetalle bigint NOT NULL,
    iidconsultorio integer NOT NULL,
    iidproducto integer NOT NULL,
    dcantidad numeric(18,2) NOT NULL,
    dfechaegreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_egreso_cantidad CHECK ((dcantidad > (0)::numeric))
);


ALTER TABLE public.invtblegresoconsumo OWNER TO "Arrobo";

--
-- Name: invtblegresoconsumo_iidegreso_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblegresoconsumo_iidegreso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblegresoconsumo_iidegreso_seq OWNER TO "Arrobo";

--
-- Name: invtblegresoconsumo_iidegreso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblegresoconsumo_iidegreso_seq OWNED BY public.invtblegresoconsumo.iidegreso;


--
-- Name: invtblmovimientosd; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblmovimientosd (
    iidbodega integer NOT NULL,
    iidtipomov integer NOT NULL,
    iidmovimiento bigint NOT NULL,
    ilinea integer NOT NULL,
    iidproducto integer NOT NULL,
    dcantidad numeric(18,4) NOT NULL,
    dcosto numeric(18,4),
    dfechacaducidad timestamp without time zone,
    scosteado smallint DEFAULT 0,
    scontabilizado smallint DEFAULT 0,
    CONSTRAINT chk_movdet_cantidad CHECK ((dcantidad <> (0)::numeric)),
    CONSTRAINT chk_movdet_costo CHECK ((dcosto >= (0)::numeric))
);


ALTER TABLE public.invtblmovimientosd OWNER TO "Arrobo";

--
-- Name: invtblmovimientosm; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblmovimientosm (
    iidmovimiento bigint NOT NULL,
    iidempresa integer NOT NULL,
    iidbodega integer NOT NULL,
    iidtipomov integer NOT NULL,
    iejercicio smallint NOT NULL,
    iperiodo smallint NOT NULL,
    dfechamov timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    iidproveedor integer,
    iidespecialidad integer,
    iidtratamiento integer,
    iiddetalletratamiento integer,
    vdocumentoreferencia character varying(50),
    iidbodegadestino integer,
    vusuario character varying(20) NOT NULL,
    vobservaciones character varying(150)
);


ALTER TABLE public.invtblmovimientosm OWNER TO "Arrobo";

--
-- Name: invtblmovimientosm_iidmovimiento_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblmovimientosm_iidmovimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblmovimientosm_iidmovimiento_seq OWNER TO "Arrobo";

--
-- Name: invtblmovimientosm_iidmovimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblmovimientosm_iidmovimiento_seq OWNED BY public.invtblmovimientosm.iidmovimiento;


--
-- Name: invtblordenc; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblordenc (
    iidbodegasolicita integer NOT NULL,
    iidmovimiento bigint NOT NULL,
    dfechaingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    vusuario character varying(50) NOT NULL,
    cestado character(1) DEFAULT 'P'::bpchar NOT NULL,
    dfechacotiza timestamp without time zone,
    susuariocotiza character varying(20),
    dfechaaprobada timestamp without time zone,
    susuarioaprueba character varying(20),
    dfechaentrega timestamp without time zone,
    susuarioentrega character varying(20)
);


ALTER TABLE public.invtblordenc OWNER TO "Arrobo";

--
-- Name: invtblordenc_iidmovimiento_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblordenc_iidmovimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblordenc_iidmovimiento_seq OWNER TO "Arrobo";

--
-- Name: invtblordenc_iidmovimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblordenc_iidmovimiento_seq OWNED BY public.invtblordenc.iidmovimiento;


--
-- Name: invtblordend; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblordend (
    iidbodegasolicita integer NOT NULL,
    iidmovimiento bigint NOT NULL,
    ilinea integer NOT NULL,
    iidproducto integer NOT NULL,
    dcantidad numeric(18,4) NOT NULL,
    dcantidadaprobada numeric(18,4) DEFAULT 0,
    iidproveedor integer,
    dvalorunitario numeric(18,4),
    cestado character(1) DEFAULT 'P'::bpchar,
    bestado boolean DEFAULT true,
    dstockactual numeric(18,2),
    vnumfactura character varying(20),
    CONSTRAINT chk_ordend_cantidad CHECK ((dcantidad > (0)::numeric)),
    CONSTRAINT chk_ordend_valor CHECK ((dvalorunitario >= (0)::numeric))
);


ALTER TABLE public.invtblordend OWNER TO "Arrobo";

--
-- Name: invtblordend_ilinea_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblordend_ilinea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblordend_ilinea_seq OWNER TO "Arrobo";

--
-- Name: invtblordend_ilinea_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblordend_ilinea_seq OWNED BY public.invtblordend.ilinea;


--
-- Name: invtblproducto; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblproducto (
    siclasificacion smallint NOT NULL,
    sisubclasificacion smallint NOT NULL,
    iidproducto integer NOT NULL,
    vcodigo character varying(12),
    inombre integer NOT NULL,
    icaracteristica integer,
    imarca integer,
    vmodelo character varying(100),
    siunidadcompra smallint NOT NULL,
    siunidadconsumo smallint NOT NULL,
    dstock numeric(5,2) DEFAULT 0,
    dcantidadminima numeric(5,2) DEFAULT 0 NOT NULL,
    dfechacreacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    dfechaultimomovimiento timestamp without time zone,
    bestado boolean DEFAULT true NOT NULL,
    besdeconteo boolean DEFAULT false,
    CONSTRAINT chk_producto_minimo CHECK ((dcantidadminima >= (0)::numeric)),
    CONSTRAINT chk_producto_stock CHECK ((dstock >= (0)::numeric))
);


ALTER TABLE public.invtblproducto OWNER TO "Arrobo";

--
-- Name: invtblproducto_iidproducto_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblproducto_iidproducto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblproducto_iidproducto_seq OWNER TO "Arrobo";

--
-- Name: invtblproducto_iidproducto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblproducto_iidproducto_seq OWNED BY public.invtblproducto.iidproducto;


--
-- Name: invtblproveedores; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblproveedores (
    iidproveedor integer NOT NULL,
    vruc character varying(20),
    vnombre character varying(150) NOT NULL,
    vnombrecomercial character varying(150),
    vdireccion character varying(250),
    vtelefono character varying(50),
    vemail character varying(100),
    vcontacto character varying(100),
    stipo integer,
    bactivo boolean DEFAULT true NOT NULL,
    dfecharegistro timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.invtblproveedores OWNER TO "Arrobo";

--
-- Name: invtblproveedores_iidproveedor_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblproveedores_iidproveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblproveedores_iidproveedor_seq OWNER TO "Arrobo";

--
-- Name: invtblproveedores_iidproveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblproveedores_iidproveedor_seq OWNED BY public.invtblproveedores.iidproveedor;


--
-- Name: invtblrequisicionc; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblrequisicionc (
    iidbodega integer NOT NULL,
    iidtipomov smallint NOT NULL,
    iidmovimiento bigint NOT NULL,
    dfechaingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    vusuario character varying(50) NOT NULL,
    cestado character(1) DEFAULT 'P'::bpchar NOT NULL,
    iidbodegasolicita integer NOT NULL,
    dfechaaprobada timestamp without time zone,
    susuarioaprueba character varying(20),
    dfechaentrega timestamp without time zone,
    susuarioentrega character varying(20)
);


ALTER TABLE public.invtblrequisicionc OWNER TO "Arrobo";

--
-- Name: invtblrequisiciond; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblrequisiciond (
    iidbodega integer NOT NULL,
    iidtipomov smallint NOT NULL,
    iidmovimiento bigint NOT NULL,
    ilinea integer NOT NULL,
    iidproducto integer NOT NULL,
    dcantidad numeric(18,4) NOT NULL,
    iidbodegasolicita integer NOT NULL,
    dcantidadaprobada numeric(18,4) DEFAULT 0,
    dstockactual numeric(18,2),
    CONSTRAINT chk_reqd_cantidad CHECK ((dcantidad > (0)::numeric))
);


ALTER TABLE public.invtblrequisiciond OWNER TO "Arrobo";

--
-- Name: invtblrequisiciond_ilinea_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.invtblrequisiciond_ilinea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invtblrequisiciond_ilinea_seq OWNER TO "Arrobo";

--
-- Name: invtblrequisiciond_ilinea_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.invtblrequisiciond_ilinea_seq OWNED BY public.invtblrequisiciond.ilinea;


--
-- Name: invtblstockbodega; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblstockbodega (
    iidempresa integer NOT NULL,
    iidbodega integer NOT NULL,
    iidproducto integer NOT NULL,
    dcantidad numeric(18,4) DEFAULT 0 NOT NULL,
    CONSTRAINT chk_stock_cantidad CHECK ((dcantidad >= (0)::numeric))
);


ALTER TABLE public.invtblstockbodega OWNER TO "Arrobo";

--
-- Name: invtblsubclasificacion; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.invtblsubclasificacion (
    siclasificacion smallint NOT NULL,
    sisubclasificacion smallint NOT NULL,
    vcodigo character varying(6),
    vdescsubclasificacion character varying(100) NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.invtblsubclasificacion OWNER TO "Arrobo";

--
-- Name: martblmarcaciones; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.martblmarcaciones (
    vusuario character varying(30) NOT NULL,
    sfechamarcacion timestamp without time zone NOT NULL,
    shoraentradajornadauno character varying(5) NOT NULL,
    shorasalidajornadauno character varying(5),
    shoraentradajornadados character varying(5),
    shorasalidajornadados character varying(5),
    vusuarioingreso character varying(30),
    sfechaingreso timestamp without time zone,
    vestacioningresa character varying(50),
    vusuarioactualiza character varying(30),
    sfechaactualiza timestamp without time zone,
    vestacionactualiza character varying(50)
);


ALTER TABLE public.martblmarcaciones OWNER TO "Arrobo";

--
-- Name: odontblbodegaresponsable; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblbodegaresponsable (
    iidbodega integer NOT NULL,
    vusuario character varying(30) NOT NULL,
    dfechaasignacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    bactivo boolean DEFAULT true
);


ALTER TABLE public.odontblbodegaresponsable OWNER TO "Arrobo";

--
-- Name: odontbldetallerecetapaciente; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontbldetallerecetapaciente (
    iidreceta integer NOT NULL,
    ilinea integer NOT NULL,
    codfarmaco character varying(10) NOT NULL,
    codpactivo character varying(15) NOT NULL,
    codncomercial character varying(15) NOT NULL,
    cantidad smallint NOT NULL,
    descripcion character varying(150) NOT NULL,
    posologia character varying(2024),
    vusuario character varying(20),
    CONSTRAINT chk_detreceta_cantidad CHECK ((cantidad > 0))
);


ALTER TABLE public.odontbldetallerecetapaciente OWNER TO "Arrobo";

--
-- Name: odontbldetallerecetapaciente_ilinea_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontbldetallerecetapaciente_ilinea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontbldetallerecetapaciente_ilinea_seq OWNER TO "Arrobo";

--
-- Name: odontbldetallerecetapaciente_ilinea_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontbldetallerecetapaciente_ilinea_seq OWNED BY public.odontbldetallerecetapaciente.ilinea;


--
-- Name: odontbldetalletratamientopaciente; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontbldetalletratamientopaciente (
    iiddetalle bigint NOT NULL,
    idpaciente bigint NOT NULL,
    iidespecialidad integer NOT NULL,
    sitratamiento smallint NOT NULL,
    iidtratamientodetalle integer CONSTRAINT odontbldetalletratamientopacient_iidtratamientodetalle_not_null NOT NULL,
    dvalor numeric(9,2) NOT NULL,
    ddescuento numeric(9,2) DEFAULT 0,
    dvalorfinal numeric(9,2) NOT NULL,
    cestado character(1) DEFAULT 'P'::bpchar NOT NULL,
    cestadotratamiento character(1) DEFAULT 'P'::bpchar NOT NULL,
    iiddoctor integer NOT NULL,
    iidconsultorio integer NOT NULL,
    vpieza character varying(20),
    vdatopieza character varying(250),
    vobservacion character varying(150),
    vobservacion1 character varying(150),
    iiddetalledescuento integer,
    dfecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dfechainicio timestamp without time zone,
    dfechafinalizacion timestamp without time zone,
    vusuario character varying(20) NOT NULL,
    vusuariomodifica character varying(30),
    dfechamodificacion timestamp without time zone,
    CONSTRAINT chk_pactrat_valor CHECK ((dvalorfinal >= (0)::numeric))
);


ALTER TABLE public.odontbldetalletratamientopaciente OWNER TO "Arrobo";

--
-- Name: odontbldetalletratamientopaciente_iiddetalle_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontbldetalletratamientopaciente_iiddetalle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontbldetalletratamientopaciente_iiddetalle_seq OWNER TO "Arrobo";

--
-- Name: odontbldetalletratamientopaciente_iiddetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontbldetalletratamientopaciente_iiddetalle_seq OWNED BY public.odontbldetalletratamientopaciente.iiddetalle;


--
-- Name: odontbldoctores; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontbldoctores (
    iiddoctor integer NOT NULL,
    vcedula character varying(10),
    vnombres character varying(100) NOT NULL,
    vapellidos character varying(100) NOT NULL,
    iidcargo integer NOT NULL,
    iidespecialidad integer,
    vtelefono character varying(50),
    vcelular character varying(50),
    vemail character varying(100),
    dfechanacimiento date,
    dfechacontratacion date,
    btemporal boolean DEFAULT false NOT NULL,
    cestado character(1) DEFAULT 'A'::bpchar NOT NULL,
    dfechacreacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_doctor_nombres CHECK ((length(TRIM(BOTH FROM vnombres)) > 0))
);


ALTER TABLE public.odontbldoctores OWNER TO "Arrobo";

--
-- Name: odontbldoctores_iiddoctor_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontbldoctores_iiddoctor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontbldoctores_iiddoctor_seq OWNER TO "Arrobo";

--
-- Name: odontbldoctores_iiddoctor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontbldoctores_iiddoctor_seq OWNED BY public.odontbldoctores.iiddoctor;


--
-- Name: odontblfacturadetalle; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblfacturadetalle (
    iiddetallefactura bigint NOT NULL,
    iidfactura bigint NOT NULL,
    ilinea smallint NOT NULL,
    iiddetalle bigint NOT NULL,
    vdescripcion character varying(250) NOT NULL,
    icantidad smallint DEFAULT 1 NOT NULL,
    dpreciounitario numeric(10,2) NOT NULL,
    ddescuento numeric(10,2) DEFAULT 0,
    dsubtotal numeric(10,2) NOT NULL,
    CONSTRAINT chk_factdet_cantidad CHECK ((icantidad > 0)),
    CONSTRAINT chk_factdet_precio CHECK ((dpreciounitario >= (0)::numeric))
);


ALTER TABLE public.odontblfacturadetalle OWNER TO "Arrobo";

--
-- Name: odontblfacturadetalle_iiddetallefactura_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblfacturadetalle_iiddetallefactura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblfacturadetalle_iiddetallefactura_seq OWNER TO "Arrobo";

--
-- Name: odontblfacturadetalle_iiddetallefactura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblfacturadetalle_iiddetallefactura_seq OWNED BY public.odontblfacturadetalle.iiddetallefactura;


--
-- Name: odontblfacturaformapago; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblfacturaformapago (
    iidformapago bigint NOT NULL,
    iidfactura bigint NOT NULL,
    iidformapagotipo integer NOT NULL,
    iidbanco integer,
    vreferencia character varying(100),
    dmonto numeric(10,2) NOT NULL,
    ddescuento numeric(9,2) DEFAULT 0,
    dfechapago timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_factpago_monto CHECK ((dmonto > (0)::numeric))
);


ALTER TABLE public.odontblfacturaformapago OWNER TO "Arrobo";

--
-- Name: odontblfacturaformapago_iidformapago_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblfacturaformapago_iidformapago_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblfacturaformapago_iidformapago_seq OWNER TO "Arrobo";

--
-- Name: odontblfacturaformapago_iidformapago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblfacturaformapago_iidformapago_seq OWNED BY public.odontblfacturaformapago.iidformapago;


--
-- Name: odontblfacturas; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblfacturas (
    iidfactura bigint NOT NULL,
    iidpaciente bigint NOT NULL,
    iidtalonario integer,
    vnumerofactura character varying(17),
    dfechafactura timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dsubtotal numeric(12,2) DEFAULT 0 NOT NULL,
    ddescuento numeric(12,2) DEFAULT 0,
    diva numeric(12,2) DEFAULT 0,
    dtotal numeric(12,2) DEFAULT 0 NOT NULL,
    cestado character(1) DEFAULT 'R'::bpchar NOT NULL,
    bimpresa boolean DEFAULT false NOT NULL,
    vusuario character varying(20) NOT NULL,
    dfechaanulacion timestamp without time zone,
    vusuarioanula character varying(30),
    vmotivoanulacion character varying(250),
    CONSTRAINT chk_factura_total CHECK ((dtotal >= (0)::numeric))
);


ALTER TABLE public.odontblfacturas OWNER TO "Arrobo";

--
-- Name: odontblfacturas_iidfactura_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblfacturas_iidfactura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblfacturas_iidfactura_seq OWNER TO "Arrobo";

--
-- Name: odontblfacturas_iidfactura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblfacturas_iidfactura_seq OWNED BY public.odontblfacturas.iidfactura;


--
-- Name: odontblgarantias; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblgarantias (
    iidgarantia integer NOT NULL,
    iiddetalle bigint NOT NULL,
    dfechainicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dfechafin timestamp without time zone,
    vdescripcion character varying(250),
    bactiva boolean DEFAULT true
);


ALTER TABLE public.odontblgarantias OWNER TO "Arrobo";

--
-- Name: odontblgarantias_iidgarantia_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblgarantias_iidgarantia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblgarantias_iidgarantia_seq OWNER TO "Arrobo";

--
-- Name: odontblgarantias_iidgarantia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblgarantias_iidgarantia_seq OWNED BY public.odontblgarantias.iidgarantia;


--
-- Name: odontblguia; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblguia (
    idguia integer NOT NULL,
    vusuario character varying(20),
    vapellido character varying(100),
    vnombre character varying(100),
    vdireccion character varying(100),
    vtelefono character varying(100),
    vciudad character varying(100),
    vempresa character varying(100),
    vdirempresa character varying(100),
    vtelempresa character varying(100),
    vemail character varying(100),
    dfechaingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.odontblguia OWNER TO "Arrobo";

--
-- Name: odontblguia_idguia_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblguia_idguia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblguia_idguia_seq OWNER TO "Arrobo";

--
-- Name: odontblguia_idguia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblguia_idguia_seq OWNED BY public.odontblguia.idguia;


--
-- Name: odontblpacientes; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblpacientes (
    iidpaciente bigint NOT NULL,
    vcedula character varying(10),
    vprimerapellido character varying(100) NOT NULL,
    vsegundoapellido character varying(100),
    votrosapellidos character varying(100),
    vnombres character varying(100) NOT NULL,
    dfechanacimiento date,
    csexo character(1),
    iedad smallint,
    vdireccion character varying(300),
    iidciudad integer,
    iidpais integer,
    vtelefonocasa character varying(50),
    vtelefonotrabajo character varying(50),
    vcelular character varying(50),
    vfax character varying(50),
    vemail character varying(100),
    vestadocivil character varying(20),
    vocupacion character varying(100),
    vlugartrabajo character varying(150),
    vdirecciontrabajo character varying(200),
    iidciudadtrabajo integer,
    iidnacionalidad integer,
    vrecomendadopor character varying(200),
    vrutafoto character varying(200),
    cestado character(1) DEFAULT 'A'::bpchar NOT NULL,
    dfecharegistro timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dfechaultimaactualizacion timestamp without time zone,
    CONSTRAINT chk_paciente_edad CHECK (((iedad >= 0) AND (iedad <= 150))),
    CONSTRAINT chk_paciente_sexo CHECK ((csexo = ANY (ARRAY['M'::bpchar, 'F'::bpchar, 'O'::bpchar])))
);


ALTER TABLE public.odontblpacientes OWNER TO "Arrobo";

--
-- Name: odontblpacientes_iidpaciente_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblpacientes_iidpaciente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblpacientes_iidpaciente_seq OWNER TO "Arrobo";

--
-- Name: odontblpacientes_iidpaciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblpacientes_iidpaciente_seq OWNED BY public.odontblpacientes.iidpaciente;


--
-- Name: odontblparametrosgeneralescab; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblparametrosgeneralescab (
    sigrupoparametro integer NOT NULL,
    vdescgrupoparametro character varying(100),
    bvisualizausuario boolean DEFAULT true NOT NULL,
    bactivo boolean DEFAULT true NOT NULL,
    vusuarioingreso character varying(30) NOT NULL,
    sfechaingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sfechaactualiza timestamp without time zone,
    vusuarioactualiza character varying(30),
    vestacioningresa character varying(50) NOT NULL,
    vestacionactualiza character varying(50)
);


ALTER TABLE public.odontblparametrosgeneralescab OWNER TO "Arrobo";

--
-- Name: odontblparametrosgeneralescab_sigrupoparametro_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblparametrosgeneralescab_sigrupoparametro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblparametrosgeneralescab_sigrupoparametro_seq OWNER TO "Arrobo";

--
-- Name: odontblparametrosgeneralescab_sigrupoparametro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblparametrosgeneralescab_sigrupoparametro_seq OWNED BY public.odontblparametrosgeneralescab.sigrupoparametro;


--
-- Name: odontblparametrosgeneralesdet; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblparametrosgeneralesdet (
    sigrupoparametro smallint NOT NULL,
    sicodigoparametro smallint NOT NULL,
    vdesccodigoparametro character varying(100) NOT NULL,
    bactivo boolean DEFAULT true NOT NULL,
    vusuarioingreso character varying(30) NOT NULL,
    sfechaingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sfechaactualiza timestamp without time zone,
    vusuarioactualiza character varying(30),
    vestacioningresa character varying(50) NOT NULL,
    vestacionactualiza character varying(50)
);


ALTER TABLE public.odontblparametrosgeneralesdet OWNER TO "Arrobo";

--
-- Name: odontblrecetapaciente; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontblrecetapaciente (
    iidreceta integer NOT NULL,
    idpaciente bigint NOT NULL,
    iiddetalle bigint,
    vusuario character varying(20) NOT NULL,
    dfechaemision timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.odontblrecetapaciente OWNER TO "Arrobo";

--
-- Name: odontblrecetapaciente_iidreceta_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontblrecetapaciente_iidreceta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontblrecetapaciente_iidreceta_seq OWNER TO "Arrobo";

--
-- Name: odontblrecetapaciente_iidreceta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontblrecetapaciente_iidreceta_seq OWNED BY public.odontblrecetapaciente.iidreceta;


--
-- Name: odontbltratamientodetalle; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontbltratamientodetalle (
    iidespecialidad integer NOT NULL,
    sitratamiento smallint NOT NULL,
    iidtratamientodetalle integer NOT NULL,
    vcodigo character varying(15),
    vdescripcion character varying(80),
    dvalortratamiento numeric(8,2),
    bestado boolean DEFAULT true,
    CONSTRAINT chk_tratdet_valor CHECK ((dvalortratamiento >= (0)::numeric))
);


ALTER TABLE public.odontbltratamientodetalle OWNER TO "Arrobo";

--
-- Name: odontbltratamientodetalle_iidtratamientodetalle_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontbltratamientodetalle_iidtratamientodetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontbltratamientodetalle_iidtratamientodetalle_seq OWNER TO "Arrobo";

--
-- Name: odontbltratamientodetalle_iidtratamientodetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontbltratamientodetalle_iidtratamientodetalle_seq OWNED BY public.odontbltratamientodetalle.iidtratamientodetalle;


--
-- Name: odontbltratamientoortodonciapaciente; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontbltratamientoortodonciapaciente (
    iddetalle integer NOT NULL,
    idpaciente bigint,
    dfechapago timestamp without time zone,
    dvalor numeric(9,2),
    cestado character(1)
);


ALTER TABLE public.odontbltratamientoortodonciapaciente OWNER TO "Arrobo";

--
-- Name: odontbltratamientoortodonciapaciente_iddetalle_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontbltratamientoortodonciapaciente_iddetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontbltratamientoortodonciapaciente_iddetalle_seq OWNER TO "Arrobo";

--
-- Name: odontbltratamientoortodonciapaciente_iddetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontbltratamientoortodonciapaciente_iddetalle_seq OWNED BY public.odontbltratamientoortodonciapaciente.iddetalle;


--
-- Name: odontbltratamientopacientelog; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontbltratamientopacientelog (
    iidlog bigint NOT NULL,
    iiddetalle bigint NOT NULL,
    idpaciente bigint,
    iidespecialidad integer,
    sitratamiento smallint,
    iidtratamientodetalle integer,
    dvalor numeric(9,2),
    cestado character(1),
    iiddoctor integer,
    idconsultorio integer,
    vobservacion character varying(150),
    dfecha timestamp without time zone,
    vusuario character varying(20),
    cestadotratamiento character(1),
    vpieza character varying(20),
    vdatopieza character varying(250),
    iiddetalledescuento integer,
    vobservacion1 character varying(150),
    fechaeliminacion timestamp without time zone,
    vusuarioelimina character varying(20)
);


ALTER TABLE public.odontbltratamientopacientelog OWNER TO "Arrobo";

--
-- Name: odontbltratamientopacientelog_iidlog_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.odontbltratamientopacientelog_iidlog_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontbltratamientopacientelog_iidlog_seq OWNER TO "Arrobo";

--
-- Name: odontbltratamientopacientelog_iidlog_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.odontbltratamientopacientelog_iidlog_seq OWNED BY public.odontbltratamientopacientelog.iidlog;


--
-- Name: odontbltratamientos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.odontbltratamientos (
    iidespecialidad integer NOT NULL,
    sitratamiento smallint NOT NULL,
    vcodigo character varying(6),
    vdesctratamiento character varying(500) NOT NULL,
    bactivo boolean DEFAULT true,
    dfechacreacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.odontbltratamientos OWNER TO "Arrobo";

--
-- Name: ortodoncia; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.ortodoncia (
    idespe integer,
    idestr integer,
    codouno character varying(20),
    desuno character varying(500),
    cododos character varying(20),
    desdos character varying(500),
    valor numeric(9,3)
);


ALTER TABLE public.ortodoncia OWNER TO "Arrobo";

--
-- Name: segtblmodulos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.segtblmodulos (
    iidmodulo integer NOT NULL,
    vcodigo character varying(20) NOT NULL,
    vnombre character varying(50) NOT NULL,
    vdescripcion character varying(150),
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.segtblmodulos OWNER TO "Arrobo";

--
-- Name: segtblmodulos_iidmodulo_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.segtblmodulos_iidmodulo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.segtblmodulos_iidmodulo_seq OWNER TO "Arrobo";

--
-- Name: segtblmodulos_iidmodulo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.segtblmodulos_iidmodulo_seq OWNED BY public.segtblmodulos.iidmodulo;


--
-- Name: segtblpermisosusuario; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.segtblpermisosusuario (
    vusuario character varying(30) NOT NULL,
    iidmodulo integer NOT NULL,
    blectura boolean DEFAULT false NOT NULL,
    bescritura boolean DEFAULT false NOT NULL,
    beliminacion boolean DEFAULT false NOT NULL,
    badministracion boolean DEFAULT false NOT NULL,
    dfechaasignacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.segtblpermisosusuario OWNER TO "Arrobo";

--
-- Name: segtblusuarios; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.segtblusuarios (
    vusuario character varying(30) NOT NULL,
    vnombres character varying(80) NOT NULL,
    vapellidos character varying(80) NOT NULL,
    vclave character varying(100) NOT NULL,
    vemail character varying(100),
    vdireccionfoto character varying(200),
    bactivo boolean DEFAULT true NOT NULL,
    iiddoctor integer,
    dfechacreacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dfechaultimamodificacion timestamp without time zone,
    CONSTRAINT chk_usuario_nombres CHECK ((length(TRIM(BOTH FROM vnombres)) > 0))
);


ALTER TABLE public.segtblusuarios OWNER TO "Arrobo";

--
-- Name: tblbancos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblbancos (
    iidbanco integer NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vnombre character varying(100) NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblbancos OWNER TO "Arrobo";

--
-- Name: tblbancos_iidbanco_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblbancos_iidbanco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblbancos_iidbanco_seq OWNER TO "Arrobo";

--
-- Name: tblbancos_iidbanco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblbancos_iidbanco_seq OWNED BY public.tblbancos.iidbanco;


--
-- Name: tblbodegas; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblbodegas (
    iidbodega integer NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vnombre character varying(100) NOT NULL,
    vubicacion character varying(150),
    vresponsable character varying(30),
    bprincipal boolean DEFAULT false NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblbodegas OWNER TO "Arrobo";

--
-- Name: tblbodegas_iidbodega_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblbodegas_iidbodega_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblbodegas_iidbodega_seq OWNER TO "Arrobo";

--
-- Name: tblbodegas_iidbodega_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblbodegas_iidbodega_seq OWNED BY public.tblbodegas.iidbodega;


--
-- Name: tblcargos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblcargos (
    iidcargo integer NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vnombre character varying(100) NOT NULL,
    vdescripcion character varying(250),
    brequiereespecialidad boolean DEFAULT false NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblcargos OWNER TO "Arrobo";

--
-- Name: tblcargos_iidcargo_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblcargos_iidcargo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblcargos_iidcargo_seq OWNER TO "Arrobo";

--
-- Name: tblcargos_iidcargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblcargos_iidcargo_seq OWNED BY public.tblcargos.iidcargo;


--
-- Name: tblciudades; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblciudades (
    iidciudad integer NOT NULL,
    iidpais integer NOT NULL,
    vcodigo character varying(10),
    vnombre character varying(100) NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblciudades OWNER TO "Arrobo";

--
-- Name: tblciudades_iidciudad_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblciudades_iidciudad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblciudades_iidciudad_seq OWNER TO "Arrobo";

--
-- Name: tblciudades_iidciudad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblciudades_iidciudad_seq OWNED BY public.tblciudades.iidciudad;


--
-- Name: tblconfiguracionfacturacion; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblconfiguracionfacturacion (
    iidconfiguracion integer NOT NULL,
    vruc character varying(13) NOT NULL,
    vrazonsocial character varying(200) NOT NULL,
    vnombrecomercial character varying(200),
    vdireccionmatriz character varying(250),
    vestablecimiento character varying(3) NOT NULL,
    vpuntoemision character varying(3) NOT NULL,
    bobligadocontabilidad boolean DEFAULT true NOT NULL,
    bactivo boolean DEFAULT true NOT NULL,
    dfechacreacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.tblconfiguracionfacturacion OWNER TO "Arrobo";

--
-- Name: tblconfiguracionfacturacion_iidconfiguracion_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblconfiguracionfacturacion_iidconfiguracion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblconfiguracionfacturacion_iidconfiguracion_seq OWNER TO "Arrobo";

--
-- Name: tblconfiguracionfacturacion_iidconfiguracion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblconfiguracionfacturacion_iidconfiguracion_seq OWNED BY public.tblconfiguracionfacturacion.iidconfiguracion;


--
-- Name: tblconsultorios; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblconsultorios (
    iidconsultorio integer NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vnombre character varying(100) NOT NULL,
    vubicacion character varying(150),
    icapacidadpacientes smallint,
    bactivo boolean DEFAULT true NOT NULL,
    dfechacreacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_consultorio_capacidad CHECK ((icapacidadpacientes > 0))
);


ALTER TABLE public.tblconsultorios OWNER TO "Arrobo";

--
-- Name: tblconsultorios_iidconsultorio_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblconsultorios_iidconsultorio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblconsultorios_iidconsultorio_seq OWNER TO "Arrobo";

--
-- Name: tblconsultorios_iidconsultorio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblconsultorios_iidconsultorio_seq OWNED BY public.tblconsultorios.iidconsultorio;


--
-- Name: tbldoctorconsultorio; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tbldoctorconsultorio (
    iiddoctor integer NOT NULL,
    iidconsultorio integer NOT NULL,
    dfechaasignacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dfechafinalizacion timestamp without time zone,
    bprincipal boolean DEFAULT false NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tbldoctorconsultorio OWNER TO "Arrobo";

--
-- Name: tblespecialidades; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblespecialidades (
    iidespecialidad integer NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vnombre character varying(100) NOT NULL,
    vdescripcion character varying(250),
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblespecialidades OWNER TO "Arrobo";

--
-- Name: tblespecialidades_iidespecialidad_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblespecialidades_iidespecialidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblespecialidades_iidespecialidad_seq OWNER TO "Arrobo";

--
-- Name: tblespecialidades_iidespecialidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblespecialidades_iidespecialidad_seq OWNED BY public.tblespecialidades.iidespecialidad;


--
-- Name: tblestados; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblestados (
    ccodigo character(1) NOT NULL,
    vdescripcion character varying(50) NOT NULL,
    vmodulo character varying(30) NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblestados OWNER TO "Arrobo";

--
-- Name: tblfacturadores; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblfacturadores (
    iidfacturador integer NOT NULL,
    vciruc character varying(13),
    vnombre character varying(250),
    vapellido character varying(250),
    vdireccion character varying(250),
    vtelefono character varying(100),
    vemail character varying(100),
    bactivo boolean DEFAULT true
);


ALTER TABLE public.tblfacturadores OWNER TO "Arrobo";

--
-- Name: tblfacturadores_iidfacturador_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblfacturadores_iidfacturador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblfacturadores_iidfacturador_seq OWNER TO "Arrobo";

--
-- Name: tblfacturadores_iidfacturador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblfacturadores_iidfacturador_seq OWNED BY public.tblfacturadores.iidfacturador;


--
-- Name: tblformaspago; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblformaspago (
    iidformapago integer NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vdescripcion character varying(50) NOT NULL,
    brequierebanco boolean DEFAULT false NOT NULL,
    brequierereferencia boolean DEFAULT false NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblformaspago OWNER TO "Arrobo";

--
-- Name: tblformaspago_iidformapago_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblformaspago_iidformapago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblformaspago_iidformapago_seq OWNER TO "Arrobo";

--
-- Name: tblformaspago_iidformapago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblformaspago_iidformapago_seq OWNED BY public.tblformaspago.iidformapago;


--
-- Name: tblpaises; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblpaises (
    iidpais integer NOT NULL,
    vcodigo character varying(3) NOT NULL,
    vnombre character varying(100) NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblpaises OWNER TO "Arrobo";

--
-- Name: tblpaises_iidpais_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblpaises_iidpais_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblpaises_iidpais_seq OWNER TO "Arrobo";

--
-- Name: tblpaises_iidpais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblpaises_iidpais_seq OWNED BY public.tblpaises.iidpais;


--
-- Name: tblpiezasdentales; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblpiezasdentales (
    vcodigo character varying(5) NOT NULL,
    vnombre character varying(50) NOT NULL,
    vtipo character varying(30),
    icuadrante smallint,
    bactivo boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_pieza_cuadrante CHECK (((icuadrante >= 1) AND (icuadrante <= 4)))
);


ALTER TABLE public.tblpiezasdentales OWNER TO "Arrobo";

--
-- Name: tbltalonarios; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tbltalonarios (
    iidtalonario integer NOT NULL,
    iidconfiguracion integer NOT NULL,
    vserie character varying(6) NOT NULL,
    inumeroinicial integer NOT NULL,
    inumerofinal integer NOT NULL,
    inumeroactual integer NOT NULL,
    dfechaautorizacion date,
    bactivo boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_talonario_actual CHECK (((inumeroactual >= inumeroinicial) AND (inumeroactual <= inumerofinal))),
    CONSTRAINT chk_talonario_rango CHECK ((inumerofinal >= inumeroinicial))
);


ALTER TABLE public.tbltalonarios OWNER TO "Arrobo";

--
-- Name: tbltalonarios_iidtalonario_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tbltalonarios_iidtalonario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbltalonarios_iidtalonario_seq OWNER TO "Arrobo";

--
-- Name: tbltalonarios_iidtalonario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tbltalonarios_iidtalonario_seq OWNED BY public.tbltalonarios.iidtalonario;


--
-- Name: tbltiposmovimiento; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tbltiposmovimiento (
    iidtipomov integer NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vdescripcion character varying(100) NOT NULL,
    ctipo character(1) NOT NULL,
    bafectastock boolean DEFAULT true NOT NULL,
    bactivo boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_tipomov_tipo CHECK ((ctipo = ANY (ARRAY['E'::bpchar, 'S'::bpchar, 'T'::bpchar])))
);


ALTER TABLE public.tbltiposmovimiento OWNER TO "Arrobo";

--
-- Name: tbltiposmovimiento_iidtipomov_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tbltiposmovimiento_iidtipomov_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbltiposmovimiento_iidtipomov_seq OWNER TO "Arrobo";

--
-- Name: tbltiposmovimiento_iidtipomov_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tbltiposmovimiento_iidtipomov_seq OWNED BY public.tbltiposmovimiento.iidtipomov;


--
-- Name: tblubicaciones; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblubicaciones (
    iidubicacion smallint NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vnombre character varying(100) NOT NULL,
    vdescripcion character varying(250),
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblubicaciones OWNER TO "Arrobo";

--
-- Name: tblubicaciones_iidubicacion_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblubicaciones_iidubicacion_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblubicaciones_iidubicacion_seq OWNER TO "Arrobo";

--
-- Name: tblubicaciones_iidubicacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblubicaciones_iidubicacion_seq OWNED BY public.tblubicaciones.iidubicacion;


--
-- Name: tblunidadesmedida; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.tblunidadesmedida (
    siidunidad smallint NOT NULL,
    vcodigo character varying(10) NOT NULL,
    vnombre character varying(50) NOT NULL,
    vabreviatura character varying(10) NOT NULL,
    bactivo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tblunidadesmedida OWNER TO "Arrobo";

--
-- Name: tblunidadesmedida_siidunidad_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.tblunidadesmedida_siidunidad_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tblunidadesmedida_siidunidad_seq OWNER TO "Arrobo";

--
-- Name: tblunidadesmedida_siidunidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.tblunidadesmedida_siidunidad_seq OWNED BY public.tblunidadesmedida.siidunidad;


--
-- Name: temactivos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.temactivos (
    codigo character varying(10),
    activo character varying(200),
    marca character varying(200),
    modelo character varying(200),
    serie character varying(200)
);


ALTER TABLE public.temactivos OWNER TO "Arrobo";

--
-- Name: temdetalle; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.temdetalle (
    ilinea integer NOT NULL,
    iidproducto integer,
    dcantidad numeric(18,4)
);


ALTER TABLE public.temdetalle OWNER TO "Arrobo";

--
-- Name: temdetalle_ilinea_seq; Type: SEQUENCE; Schema: public; Owner: Arrobo
--

CREATE SEQUENCE public.temdetalle_ilinea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.temdetalle_ilinea_seq OWNER TO "Arrobo";

--
-- Name: temdetalle_ilinea_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arrobo
--

ALTER SEQUENCE public.temdetalle_ilinea_seq OWNED BY public.temdetalle.ilinea;


--
-- Name: temtratamientos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.temtratamientos (
    codespecialidad character varying(50),
    desespecialidad character varying(100),
    idcodtratamiento integer,
    codtratamiento numeric(18,3),
    destratamiento character varying(50),
    valordestra text,
    coddetra character varying(50),
    desdetra character varying(100),
    valortrades numeric(18,2)
);


ALTER TABLE public.temtratamientos OWNER TO "Arrobo";

--
-- Name: vademecum; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.vademecum (
    codigotf double precision,
    tiposdefarmacos character varying(255),
    codigopa character varying(255),
    principiosactivos character varying(255),
    caracteristica text,
    codigonc character varying(255),
    nombrescomerciales character varying(255),
    indicacion text,
    posologia text
);


ALTER TABLE public.vademecum OWNER TO "Arrobo";

--
-- Name: vadfarmacos; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.vadfarmacos (
    codfarmaco character varying(10) NOT NULL,
    descripcion character varying(150)
);


ALTER TABLE public.vadfarmacos OWNER TO "Arrobo";

--
-- Name: vadncomercial; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.vadncomercial (
    codfarmaco character varying(10) NOT NULL,
    codpactivo character varying(15) NOT NULL,
    codncomercial character varying(15) NOT NULL,
    descripcion character varying(150) NOT NULL,
    indicacion text NOT NULL,
    posologia character varying(2024),
    contraindicaciones character varying(250)
);


ALTER TABLE public.vadncomercial OWNER TO "Arrobo";

--
-- Name: vadprincactivo; Type: TABLE; Schema: public; Owner: Arrobo
--

CREATE TABLE public.vadprincactivo (
    codfarmaco character varying(10) NOT NULL,
    codpactivo character varying(15) NOT NULL,
    descripcion character varying(150) NOT NULL,
    caracteristica text NOT NULL
);


ALTER TABLE public.vadprincactivo OWNER TO "Arrobo";

--
-- Name: actblactivofijo iidactivo; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijo ALTER COLUMN iidactivo SET DEFAULT nextval('public.actblactivofijo_iidactivo_seq'::regclass);


--
-- Name: actblactivofijomovimientos iidmovimiento; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijomovimientos ALTER COLUMN iidmovimiento SET DEFAULT nextval('public.actblactivofijomovimientos_iidmovimiento_seq'::regclass);


--
-- Name: factblchequesposfechados iidcheque; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblchequesposfechados ALTER COLUMN iidcheque SET DEFAULT nextval('public.factblchequesposfechados_iidcheque_seq'::regclass);


--
-- Name: factblcuenta iidtransaccion; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblcuenta ALTER COLUMN iidtransaccion SET DEFAULT nextval('public.factblcuenta_iidtransaccion_seq'::regclass);


--
-- Name: factbltarjetas iidtransaccion; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factbltarjetas ALTER COLUMN iidtransaccion SET DEFAULT nextval('public.factbltarjetas_iidtransaccion_seq'::regclass);


--
-- Name: fe_doc_send iiddocument; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.fe_doc_send ALTER COLUMN iiddocument SET DEFAULT nextval('public.fe_doc_send_iiddocument_seq'::regclass);


--
-- Name: invtblclasificacion siclasificacion; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblclasificacion ALTER COLUMN siclasificacion SET DEFAULT nextval('public.invtblclasificacion_siclasificacion_seq'::regclass);


--
-- Name: invtblegresoconsumo iidegreso; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblegresoconsumo ALTER COLUMN iidegreso SET DEFAULT nextval('public.invtblegresoconsumo_iidegreso_seq'::regclass);


--
-- Name: invtblmovimientosm iidmovimiento; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosm ALTER COLUMN iidmovimiento SET DEFAULT nextval('public.invtblmovimientosm_iidmovimiento_seq'::regclass);


--
-- Name: invtblordenc iidmovimiento; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordenc ALTER COLUMN iidmovimiento SET DEFAULT nextval('public.invtblordenc_iidmovimiento_seq'::regclass);


--
-- Name: invtblordend ilinea; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordend ALTER COLUMN ilinea SET DEFAULT nextval('public.invtblordend_ilinea_seq'::regclass);


--
-- Name: invtblproducto iidproducto; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproducto ALTER COLUMN iidproducto SET DEFAULT nextval('public.invtblproducto_iidproducto_seq'::regclass);


--
-- Name: invtblproveedores iidproveedor; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproveedores ALTER COLUMN iidproveedor SET DEFAULT nextval('public.invtblproveedores_iidproveedor_seq'::regclass);


--
-- Name: invtblrequisiciond ilinea; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisiciond ALTER COLUMN ilinea SET DEFAULT nextval('public.invtblrequisiciond_ilinea_seq'::regclass);


--
-- Name: odontbldetallerecetapaciente ilinea; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetallerecetapaciente ALTER COLUMN ilinea SET DEFAULT nextval('public.odontbldetallerecetapaciente_ilinea_seq'::regclass);


--
-- Name: odontbldetalletratamientopaciente iiddetalle; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente ALTER COLUMN iiddetalle SET DEFAULT nextval('public.odontbldetalletratamientopaciente_iiddetalle_seq'::regclass);


--
-- Name: odontbldoctores iiddoctor; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldoctores ALTER COLUMN iiddoctor SET DEFAULT nextval('public.odontbldoctores_iiddoctor_seq'::regclass);


--
-- Name: odontblfacturadetalle iiddetallefactura; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturadetalle ALTER COLUMN iiddetallefactura SET DEFAULT nextval('public.odontblfacturadetalle_iiddetallefactura_seq'::regclass);


--
-- Name: odontblfacturaformapago iidformapago; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturaformapago ALTER COLUMN iidformapago SET DEFAULT nextval('public.odontblfacturaformapago_iidformapago_seq'::regclass);


--
-- Name: odontblfacturas iidfactura; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturas ALTER COLUMN iidfactura SET DEFAULT nextval('public.odontblfacturas_iidfactura_seq'::regclass);


--
-- Name: odontblgarantias iidgarantia; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblgarantias ALTER COLUMN iidgarantia SET DEFAULT nextval('public.odontblgarantias_iidgarantia_seq'::regclass);


--
-- Name: odontblguia idguia; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblguia ALTER COLUMN idguia SET DEFAULT nextval('public.odontblguia_idguia_seq'::regclass);


--
-- Name: odontblpacientes iidpaciente; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes ALTER COLUMN iidpaciente SET DEFAULT nextval('public.odontblpacientes_iidpaciente_seq'::regclass);


--
-- Name: odontblparametrosgeneralescab sigrupoparametro; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblparametrosgeneralescab ALTER COLUMN sigrupoparametro SET DEFAULT nextval('public.odontblparametrosgeneralescab_sigrupoparametro_seq'::regclass);


--
-- Name: odontblrecetapaciente iidreceta; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblrecetapaciente ALTER COLUMN iidreceta SET DEFAULT nextval('public.odontblrecetapaciente_iidreceta_seq'::regclass);


--
-- Name: odontbltratamientodetalle iidtratamientodetalle; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientodetalle ALTER COLUMN iidtratamientodetalle SET DEFAULT nextval('public.odontbltratamientodetalle_iidtratamientodetalle_seq'::regclass);


--
-- Name: odontbltratamientoortodonciapaciente iddetalle; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientoortodonciapaciente ALTER COLUMN iddetalle SET DEFAULT nextval('public.odontbltratamientoortodonciapaciente_iddetalle_seq'::regclass);


--
-- Name: odontbltratamientopacientelog iidlog; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientopacientelog ALTER COLUMN iidlog SET DEFAULT nextval('public.odontbltratamientopacientelog_iidlog_seq'::regclass);


--
-- Name: segtblmodulos iidmodulo; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.segtblmodulos ALTER COLUMN iidmodulo SET DEFAULT nextval('public.segtblmodulos_iidmodulo_seq'::regclass);


--
-- Name: tblbancos iidbanco; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblbancos ALTER COLUMN iidbanco SET DEFAULT nextval('public.tblbancos_iidbanco_seq'::regclass);


--
-- Name: tblbodegas iidbodega; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblbodegas ALTER COLUMN iidbodega SET DEFAULT nextval('public.tblbodegas_iidbodega_seq'::regclass);


--
-- Name: tblcargos iidcargo; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblcargos ALTER COLUMN iidcargo SET DEFAULT nextval('public.tblcargos_iidcargo_seq'::regclass);


--
-- Name: tblciudades iidciudad; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblciudades ALTER COLUMN iidciudad SET DEFAULT nextval('public.tblciudades_iidciudad_seq'::regclass);


--
-- Name: tblconfiguracionfacturacion iidconfiguracion; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblconfiguracionfacturacion ALTER COLUMN iidconfiguracion SET DEFAULT nextval('public.tblconfiguracionfacturacion_iidconfiguracion_seq'::regclass);


--
-- Name: tblconsultorios iidconsultorio; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblconsultorios ALTER COLUMN iidconsultorio SET DEFAULT nextval('public.tblconsultorios_iidconsultorio_seq'::regclass);


--
-- Name: tblespecialidades iidespecialidad; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblespecialidades ALTER COLUMN iidespecialidad SET DEFAULT nextval('public.tblespecialidades_iidespecialidad_seq'::regclass);


--
-- Name: tblfacturadores iidfacturador; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblfacturadores ALTER COLUMN iidfacturador SET DEFAULT nextval('public.tblfacturadores_iidfacturador_seq'::regclass);


--
-- Name: tblformaspago iidformapago; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblformaspago ALTER COLUMN iidformapago SET DEFAULT nextval('public.tblformaspago_iidformapago_seq'::regclass);


--
-- Name: tblpaises iidpais; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblpaises ALTER COLUMN iidpais SET DEFAULT nextval('public.tblpaises_iidpais_seq'::regclass);


--
-- Name: tbltalonarios iidtalonario; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbltalonarios ALTER COLUMN iidtalonario SET DEFAULT nextval('public.tbltalonarios_iidtalonario_seq'::regclass);


--
-- Name: tbltiposmovimiento iidtipomov; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbltiposmovimiento ALTER COLUMN iidtipomov SET DEFAULT nextval('public.tbltiposmovimiento_iidtipomov_seq'::regclass);


--
-- Name: tblubicaciones iidubicacion; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblubicaciones ALTER COLUMN iidubicacion SET DEFAULT nextval('public.tblubicaciones_iidubicacion_seq'::regclass);


--
-- Name: tblunidadesmedida siidunidad; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblunidadesmedida ALTER COLUMN siidunidad SET DEFAULT nextval('public.tblunidadesmedida_siidunidad_seq'::regclass);


--
-- Name: temdetalle ilinea; Type: DEFAULT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.temdetalle ALTER COLUMN ilinea SET DEFAULT nextval('public.temdetalle_ilinea_seq'::regclass);


--
-- Name: actblactivofijo actblactivofijo_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijo
    ADD CONSTRAINT actblactivofijo_pkey PRIMARY KEY (iidactivo);


--
-- Name: actblactivofijo actblactivofijo_vnumerodeserie_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijo
    ADD CONSTRAINT actblactivofijo_vnumerodeserie_key UNIQUE (vnumerodeserie);


--
-- Name: actblactivofijomovimientos actblactivofijomovimientos_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijomovimientos
    ADD CONSTRAINT actblactivofijomovimientos_pkey PRIMARY KEY (iidmovimiento);


--
-- Name: factblchequesposfechados factblchequesposfechados_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblchequesposfechados
    ADD CONSTRAINT factblchequesposfechados_pkey PRIMARY KEY (iidcheque);


--
-- Name: factblcuenta factblcuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblcuenta
    ADD CONSTRAINT factblcuenta_pkey PRIMARY KEY (iidtransaccion);


--
-- Name: factbltarjetas factbltarjetas_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factbltarjetas
    ADD CONSTRAINT factbltarjetas_pkey PRIMARY KEY (iidtransaccion);


--
-- Name: fe_doc_data fe_doc_data_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.fe_doc_data
    ADD CONSTRAINT fe_doc_data_pkey PRIMARY KEY (iiddocument);


--
-- Name: fe_doc_send fe_doc_send_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.fe_doc_send
    ADD CONSTRAINT fe_doc_send_pkey PRIMARY KEY (iiddocument);


--
-- Name: fe_doc_send fe_doc_send_vdocumentno_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.fe_doc_send
    ADD CONSTRAINT fe_doc_send_vdocumentno_key UNIQUE (vdocumentno);


--
-- Name: invconsultoriobodega invconsultoriobodega_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invconsultoriobodega
    ADD CONSTRAINT invconsultoriobodega_pkey PRIMARY KEY (iidconsultorio, iidbodega);


--
-- Name: invconsumoproductosconteo invconsumoproductosconteo_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invconsumoproductosconteo
    ADD CONSTRAINT invconsumoproductosconteo_pkey PRIMARY KEY (iidconsultorio, icodreferencia, iidproducto);


--
-- Name: invkitproducto invkitproducto_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invkitproducto
    ADD CONSTRAINT invkitproducto_pkey PRIMARY KEY (iidproductokit, iidproducto);


--
-- Name: invtblclasificacion invtblclasificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblclasificacion
    ADD CONSTRAINT invtblclasificacion_pkey PRIMARY KEY (siclasificacion);


--
-- Name: invtblclasificacion invtblclasificacion_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblclasificacion
    ADD CONSTRAINT invtblclasificacion_vcodigo_key UNIQUE (vcodigo);


--
-- Name: invtblegresoconsumo invtblegresoconsumo_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblegresoconsumo
    ADD CONSTRAINT invtblegresoconsumo_pkey PRIMARY KEY (iidegreso);


--
-- Name: invtblmovimientosd invtblmovimientosd_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosd
    ADD CONSTRAINT invtblmovimientosd_pkey PRIMARY KEY (iidbodega, iidtipomov, iidmovimiento, ilinea);


--
-- Name: invtblmovimientosm invtblmovimientosm_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosm
    ADD CONSTRAINT invtblmovimientosm_pkey PRIMARY KEY (iidmovimiento);


--
-- Name: invtblordenc invtblordenc_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordenc
    ADD CONSTRAINT invtblordenc_pkey PRIMARY KEY (iidbodegasolicita, iidmovimiento);


--
-- Name: invtblordend invtblordend_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordend
    ADD CONSTRAINT invtblordend_pkey PRIMARY KEY (iidbodegasolicita, iidmovimiento, ilinea);


--
-- Name: invtblproducto invtblproducto_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproducto
    ADD CONSTRAINT invtblproducto_pkey PRIMARY KEY (siclasificacion, sisubclasificacion, iidproducto);


--
-- Name: invtblproducto invtblproducto_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproducto
    ADD CONSTRAINT invtblproducto_vcodigo_key UNIQUE (vcodigo);


--
-- Name: invtblproveedores invtblproveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproveedores
    ADD CONSTRAINT invtblproveedores_pkey PRIMARY KEY (iidproveedor);


--
-- Name: invtblproveedores invtblproveedores_vruc_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproveedores
    ADD CONSTRAINT invtblproveedores_vruc_key UNIQUE (vruc);


--
-- Name: invtblrequisicionc invtblrequisicionc_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisicionc
    ADD CONSTRAINT invtblrequisicionc_pkey PRIMARY KEY (iidbodega, iidtipomov, iidmovimiento);


--
-- Name: invtblrequisiciond invtblrequisiciond_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisiciond
    ADD CONSTRAINT invtblrequisiciond_pkey PRIMARY KEY (iidbodega, iidtipomov, iidmovimiento, ilinea);


--
-- Name: invtblstockbodega invtblstockbodega_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblstockbodega
    ADD CONSTRAINT invtblstockbodega_pkey PRIMARY KEY (iidempresa, iidbodega, iidproducto);


--
-- Name: invtblsubclasificacion invtblsubclasificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblsubclasificacion
    ADD CONSTRAINT invtblsubclasificacion_pkey PRIMARY KEY (siclasificacion, sisubclasificacion);


--
-- Name: martblmarcaciones martblmarcaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.martblmarcaciones
    ADD CONSTRAINT martblmarcaciones_pkey PRIMARY KEY (vusuario, sfechamarcacion);


--
-- Name: odontblbodegaresponsable odontblbodegaresponsable_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblbodegaresponsable
    ADD CONSTRAINT odontblbodegaresponsable_pkey PRIMARY KEY (iidbodega, vusuario);


--
-- Name: odontbldetallerecetapaciente odontbldetallerecetapaciente_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetallerecetapaciente
    ADD CONSTRAINT odontbldetallerecetapaciente_pkey PRIMARY KEY (iidreceta, ilinea);


--
-- Name: odontbldetalletratamientopaciente odontbldetalletratamientopaciente_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT odontbldetalletratamientopaciente_pkey PRIMARY KEY (iiddetalle);


--
-- Name: odontbldoctores odontbldoctores_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldoctores
    ADD CONSTRAINT odontbldoctores_pkey PRIMARY KEY (iiddoctor);


--
-- Name: odontbldoctores odontbldoctores_vcedula_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldoctores
    ADD CONSTRAINT odontbldoctores_vcedula_key UNIQUE (vcedula);


--
-- Name: odontblfacturadetalle odontblfacturadetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturadetalle
    ADD CONSTRAINT odontblfacturadetalle_pkey PRIMARY KEY (iiddetallefactura);


--
-- Name: odontblfacturaformapago odontblfacturaformapago_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturaformapago
    ADD CONSTRAINT odontblfacturaformapago_pkey PRIMARY KEY (iidformapago);


--
-- Name: odontblfacturas odontblfacturas_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturas
    ADD CONSTRAINT odontblfacturas_pkey PRIMARY KEY (iidfactura);


--
-- Name: odontblgarantias odontblgarantias_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblgarantias
    ADD CONSTRAINT odontblgarantias_pkey PRIMARY KEY (iidgarantia);


--
-- Name: odontblguia odontblguia_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblguia
    ADD CONSTRAINT odontblguia_pkey PRIMARY KEY (idguia);


--
-- Name: odontblpacientes odontblpacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes
    ADD CONSTRAINT odontblpacientes_pkey PRIMARY KEY (iidpaciente);


--
-- Name: odontblpacientes odontblpacientes_vcedula_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes
    ADD CONSTRAINT odontblpacientes_vcedula_key UNIQUE (vcedula);


--
-- Name: odontblparametrosgeneralescab odontblparametrosgeneralescab_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblparametrosgeneralescab
    ADD CONSTRAINT odontblparametrosgeneralescab_pkey PRIMARY KEY (sigrupoparametro);


--
-- Name: odontblparametrosgeneralesdet odontblparametrosgeneralesdet_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblparametrosgeneralesdet
    ADD CONSTRAINT odontblparametrosgeneralesdet_pkey PRIMARY KEY (sigrupoparametro, sicodigoparametro);


--
-- Name: odontblrecetapaciente odontblrecetapaciente_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblrecetapaciente
    ADD CONSTRAINT odontblrecetapaciente_pkey PRIMARY KEY (iidreceta);


--
-- Name: odontbltratamientodetalle odontbltratamientodetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientodetalle
    ADD CONSTRAINT odontbltratamientodetalle_pkey PRIMARY KEY (iidespecialidad, sitratamiento, iidtratamientodetalle);


--
-- Name: odontbltratamientoortodonciapaciente odontbltratamientoortodonciapaciente_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientoortodonciapaciente
    ADD CONSTRAINT odontbltratamientoortodonciapaciente_pkey PRIMARY KEY (iddetalle);


--
-- Name: odontbltratamientopacientelog odontbltratamientopacientelog_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientopacientelog
    ADD CONSTRAINT odontbltratamientopacientelog_pkey PRIMARY KEY (iidlog);


--
-- Name: odontbltratamientos odontbltratamientos_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientos
    ADD CONSTRAINT odontbltratamientos_pkey PRIMARY KEY (iidespecialidad, sitratamiento);


--
-- Name: segtblmodulos segtblmodulos_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.segtblmodulos
    ADD CONSTRAINT segtblmodulos_pkey PRIMARY KEY (iidmodulo);


--
-- Name: segtblmodulos segtblmodulos_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.segtblmodulos
    ADD CONSTRAINT segtblmodulos_vcodigo_key UNIQUE (vcodigo);


--
-- Name: segtblpermisosusuario segtblpermisosusuario_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.segtblpermisosusuario
    ADD CONSTRAINT segtblpermisosusuario_pkey PRIMARY KEY (vusuario, iidmodulo);


--
-- Name: segtblusuarios segtblusuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.segtblusuarios
    ADD CONSTRAINT segtblusuarios_pkey PRIMARY KEY (vusuario);


--
-- Name: tblbancos tblbancos_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblbancos
    ADD CONSTRAINT tblbancos_pkey PRIMARY KEY (iidbanco);


--
-- Name: tblbancos tblbancos_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblbancos
    ADD CONSTRAINT tblbancos_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblbodegas tblbodegas_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblbodegas
    ADD CONSTRAINT tblbodegas_pkey PRIMARY KEY (iidbodega);


--
-- Name: tblbodegas tblbodegas_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblbodegas
    ADD CONSTRAINT tblbodegas_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblcargos tblcargos_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblcargos
    ADD CONSTRAINT tblcargos_pkey PRIMARY KEY (iidcargo);


--
-- Name: tblcargos tblcargos_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblcargos
    ADD CONSTRAINT tblcargos_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblciudades tblciudades_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblciudades
    ADD CONSTRAINT tblciudades_pkey PRIMARY KEY (iidciudad);


--
-- Name: tblconfiguracionfacturacion tblconfiguracionfacturacion_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblconfiguracionfacturacion
    ADD CONSTRAINT tblconfiguracionfacturacion_pkey PRIMARY KEY (iidconfiguracion);


--
-- Name: tblconfiguracionfacturacion tblconfiguracionfacturacion_vruc_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblconfiguracionfacturacion
    ADD CONSTRAINT tblconfiguracionfacturacion_vruc_key UNIQUE (vruc);


--
-- Name: tblconsultorios tblconsultorios_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblconsultorios
    ADD CONSTRAINT tblconsultorios_pkey PRIMARY KEY (iidconsultorio);


--
-- Name: tblconsultorios tblconsultorios_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblconsultorios
    ADD CONSTRAINT tblconsultorios_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tbldoctorconsultorio tbldoctorconsultorio_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbldoctorconsultorio
    ADD CONSTRAINT tbldoctorconsultorio_pkey PRIMARY KEY (iiddoctor, iidconsultorio, dfechaasignacion);


--
-- Name: tblespecialidades tblespecialidades_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblespecialidades
    ADD CONSTRAINT tblespecialidades_pkey PRIMARY KEY (iidespecialidad);


--
-- Name: tblespecialidades tblespecialidades_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblespecialidades
    ADD CONSTRAINT tblespecialidades_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblestados tblestados_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblestados
    ADD CONSTRAINT tblestados_pkey PRIMARY KEY (ccodigo);


--
-- Name: tblfacturadores tblfacturadores_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblfacturadores
    ADD CONSTRAINT tblfacturadores_pkey PRIMARY KEY (iidfacturador);


--
-- Name: tblfacturadores tblfacturadores_vciruc_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblfacturadores
    ADD CONSTRAINT tblfacturadores_vciruc_key UNIQUE (vciruc);


--
-- Name: tblformaspago tblformaspago_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblformaspago
    ADD CONSTRAINT tblformaspago_pkey PRIMARY KEY (iidformapago);


--
-- Name: tblformaspago tblformaspago_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblformaspago
    ADD CONSTRAINT tblformaspago_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblpaises tblpaises_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblpaises
    ADD CONSTRAINT tblpaises_pkey PRIMARY KEY (iidpais);


--
-- Name: tblpaises tblpaises_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblpaises
    ADD CONSTRAINT tblpaises_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblpiezasdentales tblpiezasdentales_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblpiezasdentales
    ADD CONSTRAINT tblpiezasdentales_pkey PRIMARY KEY (vcodigo);


--
-- Name: tbltalonarios tbltalonarios_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbltalonarios
    ADD CONSTRAINT tbltalonarios_pkey PRIMARY KEY (iidtalonario);


--
-- Name: tbltiposmovimiento tbltiposmovimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbltiposmovimiento
    ADD CONSTRAINT tbltiposmovimiento_pkey PRIMARY KEY (iidtipomov);


--
-- Name: tbltiposmovimiento tbltiposmovimiento_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbltiposmovimiento
    ADD CONSTRAINT tbltiposmovimiento_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblubicaciones tblubicaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblubicaciones
    ADD CONSTRAINT tblubicaciones_pkey PRIMARY KEY (iidubicacion);


--
-- Name: tblubicaciones tblubicaciones_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblubicaciones
    ADD CONSTRAINT tblubicaciones_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblunidadesmedida tblunidadesmedida_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblunidadesmedida
    ADD CONSTRAINT tblunidadesmedida_pkey PRIMARY KEY (siidunidad);


--
-- Name: tblunidadesmedida tblunidadesmedida_vcodigo_key; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblunidadesmedida
    ADD CONSTRAINT tblunidadesmedida_vcodigo_key UNIQUE (vcodigo);


--
-- Name: tblestados uk_estado_modulo; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblestados
    ADD CONSTRAINT uk_estado_modulo UNIQUE (vmodulo, ccodigo);


--
-- Name: odontblfacturadetalle uk_factdet_linea; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturadetalle
    ADD CONSTRAINT uk_factdet_linea UNIQUE (iidfactura, ilinea);


--
-- Name: odontbldetallerecetapaciente uq_detalle_receta; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetallerecetapaciente
    ADD CONSTRAINT uq_detalle_receta UNIQUE (iidreceta, codfarmaco, codpactivo, codncomercial);


--
-- Name: vadfarmacos vadfarmacos_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.vadfarmacos
    ADD CONSTRAINT vadfarmacos_pkey PRIMARY KEY (codfarmaco);


--
-- Name: vadncomercial vadncomercial_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.vadncomercial
    ADD CONSTRAINT vadncomercial_pkey PRIMARY KEY (codfarmaco, codpactivo, codncomercial);


--
-- Name: vadprincactivo vadprincactivo_pkey; Type: CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.vadprincactivo
    ADD CONSTRAINT vadprincactivo_pkey PRIMARY KEY (codfarmaco, codpactivo);


--
-- Name: idx_activo_responsable; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_activo_responsable ON public.actblactivofijo USING btree (vresponsable);


--
-- Name: idx_activo_serie; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_activo_serie ON public.actblactivofijo USING btree (vnumerodeserie);


--
-- Name: idx_actmov_activo; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_actmov_activo ON public.actblactivofijomovimientos USING btree (iidactivo);


--
-- Name: idx_actmov_fecha; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_actmov_fecha ON public.actblactivofijomovimientos USING btree (dfechamovimiento);


--
-- Name: idx_cheque_paciente; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_cheque_paciente ON public.factblchequesposfechados USING btree (iidpaciente);


--
-- Name: idx_cuenta_fecha; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_cuenta_fecha ON public.factblcuenta USING btree (dfecha);


--
-- Name: idx_cuenta_paciente; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_cuenta_paciente ON public.factblcuenta USING btree (iidpaciente);


--
-- Name: idx_factdet_factura; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_factdet_factura ON public.odontblfacturadetalle USING btree (iidfactura);


--
-- Name: idx_factpago_factura; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_factpago_factura ON public.odontblfacturaformapago USING btree (iidfactura);


--
-- Name: idx_factura_fecha; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_factura_fecha ON public.odontblfacturas USING btree (dfechafactura);


--
-- Name: idx_factura_numero; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_factura_numero ON public.odontblfacturas USING btree (vnumerofactura);


--
-- Name: idx_factura_paciente; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_factura_paciente ON public.odontblfacturas USING btree (iidpaciente);


--
-- Name: idx_movdet_movimiento; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_movdet_movimiento ON public.invtblmovimientosd USING btree (iidmovimiento);


--
-- Name: idx_movdet_producto; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_movdet_producto ON public.invtblmovimientosd USING btree (iidproducto);


--
-- Name: idx_movmto_bodega; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_movmto_bodega ON public.invtblmovimientosm USING btree (iidbodega);


--
-- Name: idx_movmto_fecha; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_movmto_fecha ON public.invtblmovimientosm USING btree (dfechamov);


--
-- Name: idx_movmto_tipo; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_movmto_tipo ON public.invtblmovimientosm USING btree (iidtipomov);


--
-- Name: idx_paciente_apellidos; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_paciente_apellidos ON public.odontblpacientes USING btree (vprimerapellido, vsegundoapellido);


--
-- Name: idx_paciente_cedula; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_paciente_cedula ON public.odontblpacientes USING btree (vcedula) WHERE (vcedula IS NOT NULL);


--
-- Name: idx_paciente_estado; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_paciente_estado ON public.odontblpacientes USING btree (cestado);


--
-- Name: idx_paciente_fecha; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_paciente_fecha ON public.odontblpacientes USING btree (dfecharegistro);


--
-- Name: idx_pactrat_consultorio; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_pactrat_consultorio ON public.odontbldetalletratamientopaciente USING btree (iidconsultorio);


--
-- Name: idx_pactrat_doctor; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_pactrat_doctor ON public.odontbldetalletratamientopaciente USING btree (iiddoctor);


--
-- Name: idx_pactrat_estado; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_pactrat_estado ON public.odontbldetalletratamientopaciente USING btree (cestadotratamiento);


--
-- Name: idx_pactrat_fecha; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_pactrat_fecha ON public.odontbldetalletratamientopaciente USING btree (dfecha);


--
-- Name: idx_pactrat_paciente; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_pactrat_paciente ON public.odontbldetalletratamientopaciente USING btree (idpaciente);


--
-- Name: idx_producto_codigo; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_producto_codigo ON public.invtblproducto USING btree (vcodigo);


--
-- Name: idx_producto_nombre; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_producto_nombre ON public.invtblproducto USING btree (inombre);


--
-- Name: idx_stock_bodega; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_stock_bodega ON public.invtblstockbodega USING btree (iidbodega);


--
-- Name: idx_stock_producto; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_stock_producto ON public.invtblstockbodega USING btree (iidproducto);


--
-- Name: idx_tarjeta_paciente; Type: INDEX; Schema: public; Owner: Arrobo
--

CREATE INDEX idx_tarjeta_paciente ON public.factbltarjetas USING btree (iidpaciente);


--
-- Name: actblactivofijo fk_activo_responsable; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijo
    ADD CONSTRAINT fk_activo_responsable FOREIGN KEY (vresponsable) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: actblactivofijomovimientos fk_actmov_activo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijomovimientos
    ADD CONSTRAINT fk_actmov_activo FOREIGN KEY (iidactivo) REFERENCES public.actblactivofijo(iidactivo);


--
-- Name: actblactivofijomovimientos fk_actmov_responsable_ant; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijomovimientos
    ADD CONSTRAINT fk_actmov_responsable_ant FOREIGN KEY (vresponsable) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: actblactivofijomovimientos fk_actmov_responsable_nuevo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijomovimientos
    ADD CONSTRAINT fk_actmov_responsable_nuevo FOREIGN KEY (vnuevoresponsable) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: actblactivofijomovimientos fk_actmov_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.actblactivofijomovimientos
    ADD CONSTRAINT fk_actmov_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: tblbodegas fk_bodega_responsable; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblbodegas
    ADD CONSTRAINT fk_bodega_responsable FOREIGN KEY (vresponsable) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: odontblbodegaresponsable fk_bodresp_bodega; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblbodegaresponsable
    ADD CONSTRAINT fk_bodresp_bodega FOREIGN KEY (iidbodega) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: odontblbodegaresponsable fk_bodresp_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblbodegaresponsable
    ADD CONSTRAINT fk_bodresp_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: factblchequesposfechados fk_cheque_banco; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblchequesposfechados
    ADD CONSTRAINT fk_cheque_banco FOREIGN KEY (iidbanco) REFERENCES public.tblbancos(iidbanco);


--
-- Name: factblchequesposfechados fk_cheque_estado; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblchequesposfechados
    ADD CONSTRAINT fk_cheque_estado FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: factblchequesposfechados fk_cheque_paciente; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblchequesposfechados
    ADD CONSTRAINT fk_cheque_paciente FOREIGN KEY (iidpaciente) REFERENCES public.odontblpacientes(iidpaciente);


--
-- Name: factblchequesposfechados fk_cheque_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblchequesposfechados
    ADD CONSTRAINT fk_cheque_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: tblciudades fk_ciudad_pais; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tblciudades
    ADD CONSTRAINT fk_ciudad_pais FOREIGN KEY (iidpais) REFERENCES public.tblpaises(iidpais);


--
-- Name: invconsultoriobodega fk_consbod_bodega; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invconsultoriobodega
    ADD CONSTRAINT fk_consbod_bodega FOREIGN KEY (iidbodega) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: invconsultoriobodega fk_consbod_consultorio; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invconsultoriobodega
    ADD CONSTRAINT fk_consbod_consultorio FOREIGN KEY (iidconsultorio) REFERENCES public.tblconsultorios(iidconsultorio);


--
-- Name: invconsumoproductosconteo fk_consumo_consultorio; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invconsumoproductosconteo
    ADD CONSTRAINT fk_consumo_consultorio FOREIGN KEY (iidconsultorio) REFERENCES public.tblconsultorios(iidconsultorio);


--
-- Name: factblcuenta fk_cuenta_paciente; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblcuenta
    ADD CONSTRAINT fk_cuenta_paciente FOREIGN KEY (iidpaciente) REFERENCES public.odontblpacientes(iidpaciente);


--
-- Name: factblcuenta fk_cuenta_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factblcuenta
    ADD CONSTRAINT fk_cuenta_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: odontbldetallerecetapaciente fk_detreceta_medicamento; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetallerecetapaciente
    ADD CONSTRAINT fk_detreceta_medicamento FOREIGN KEY (codfarmaco, codpactivo, codncomercial) REFERENCES public.vadncomercial(codfarmaco, codpactivo, codncomercial);


--
-- Name: odontbldetallerecetapaciente fk_detreceta_receta; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetallerecetapaciente
    ADD CONSTRAINT fk_detreceta_receta FOREIGN KEY (iidreceta) REFERENCES public.odontblrecetapaciente(iidreceta) ON DELETE CASCADE;


--
-- Name: tbldoctorconsultorio fk_docconsul_consultorio; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbldoctorconsultorio
    ADD CONSTRAINT fk_docconsul_consultorio FOREIGN KEY (iidconsultorio) REFERENCES public.tblconsultorios(iidconsultorio);


--
-- Name: tbldoctorconsultorio fk_docconsul_doctor; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbldoctorconsultorio
    ADD CONSTRAINT fk_docconsul_doctor FOREIGN KEY (iiddoctor) REFERENCES public.odontbldoctores(iiddoctor);


--
-- Name: fe_doc_data fk_docdata_send; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.fe_doc_data
    ADD CONSTRAINT fk_docdata_send FOREIGN KEY (iiddocument) REFERENCES public.fe_doc_send(iiddocument) ON DELETE CASCADE;


--
-- Name: fe_doc_send fk_docelec_talonario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.fe_doc_send
    ADD CONSTRAINT fk_docelec_talonario FOREIGN KEY (iidtalonario) REFERENCES public.tbltalonarios(iidtalonario);


--
-- Name: odontbldoctores fk_doctor_cargo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldoctores
    ADD CONSTRAINT fk_doctor_cargo FOREIGN KEY (iidcargo) REFERENCES public.tblcargos(iidcargo);


--
-- Name: odontbldoctores fk_doctor_especialidad; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldoctores
    ADD CONSTRAINT fk_doctor_especialidad FOREIGN KEY (iidespecialidad) REFERENCES public.tblespecialidades(iidespecialidad);


--
-- Name: odontbldoctores fk_doctor_estado; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldoctores
    ADD CONSTRAINT fk_doctor_estado FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: invtblegresoconsumo fk_egreso_consultorio; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblegresoconsumo
    ADD CONSTRAINT fk_egreso_consultorio FOREIGN KEY (iidconsultorio) REFERENCES public.tblconsultorios(iidconsultorio);


--
-- Name: invtblegresoconsumo fk_egreso_detalle; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblegresoconsumo
    ADD CONSTRAINT fk_egreso_detalle FOREIGN KEY (iiddetalle) REFERENCES public.odontbldetalletratamientopaciente(iiddetalle);


--
-- Name: odontblfacturadetalle fk_factdet_factura; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturadetalle
    ADD CONSTRAINT fk_factdet_factura FOREIGN KEY (iidfactura) REFERENCES public.odontblfacturas(iidfactura) ON DELETE CASCADE;


--
-- Name: odontblfacturadetalle fk_factdet_tratamiento; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturadetalle
    ADD CONSTRAINT fk_factdet_tratamiento FOREIGN KEY (iiddetalle) REFERENCES public.odontbldetalletratamientopaciente(iiddetalle);


--
-- Name: odontblfacturaformapago fk_factpago_banco; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturaformapago
    ADD CONSTRAINT fk_factpago_banco FOREIGN KEY (iidbanco) REFERENCES public.tblbancos(iidbanco);


--
-- Name: odontblfacturaformapago fk_factpago_factura; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturaformapago
    ADD CONSTRAINT fk_factpago_factura FOREIGN KEY (iidfactura) REFERENCES public.odontblfacturas(iidfactura) ON DELETE CASCADE;


--
-- Name: odontblfacturaformapago fk_factpago_forma; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturaformapago
    ADD CONSTRAINT fk_factpago_forma FOREIGN KEY (iidformapagotipo) REFERENCES public.tblformaspago(iidformapago);


--
-- Name: odontblfacturas fk_factura_estado; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturas
    ADD CONSTRAINT fk_factura_estado FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: odontblfacturas fk_factura_paciente; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturas
    ADD CONSTRAINT fk_factura_paciente FOREIGN KEY (iidpaciente) REFERENCES public.odontblpacientes(iidpaciente);


--
-- Name: odontblfacturas fk_factura_talonario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturas
    ADD CONSTRAINT fk_factura_talonario FOREIGN KEY (iidtalonario) REFERENCES public.tbltalonarios(iidtalonario);


--
-- Name: odontblfacturas fk_factura_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblfacturas
    ADD CONSTRAINT fk_factura_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: odontblgarantias fk_garantia_detalle; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblgarantias
    ADD CONSTRAINT fk_garantia_detalle FOREIGN KEY (iiddetalle) REFERENCES public.odontbldetalletratamientopaciente(iiddetalle);


--
-- Name: martblmarcaciones fk_marcacion_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.martblmarcaciones
    ADD CONSTRAINT fk_marcacion_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: invtblmovimientosd fk_movdet_maestro; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosd
    ADD CONSTRAINT fk_movdet_maestro FOREIGN KEY (iidmovimiento) REFERENCES public.invtblmovimientosm(iidmovimiento) ON DELETE CASCADE;


--
-- Name: invtblmovimientosm fk_movmto_bodega; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosm
    ADD CONSTRAINT fk_movmto_bodega FOREIGN KEY (iidbodega) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: invtblmovimientosm fk_movmto_bodega_destino; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosm
    ADD CONSTRAINT fk_movmto_bodega_destino FOREIGN KEY (iidbodegadestino) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: invtblmovimientosm fk_movmto_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosm
    ADD CONSTRAINT fk_movmto_proveedor FOREIGN KEY (iidproveedor) REFERENCES public.invtblproveedores(iidproveedor);


--
-- Name: invtblmovimientosm fk_movmto_tipo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosm
    ADD CONSTRAINT fk_movmto_tipo FOREIGN KEY (iidtipomov) REFERENCES public.tbltiposmovimiento(iidtipomov);


--
-- Name: invtblmovimientosm fk_movmto_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblmovimientosm
    ADD CONSTRAINT fk_movmto_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: vadncomercial fk_ncomercial_pactivo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.vadncomercial
    ADD CONSTRAINT fk_ncomercial_pactivo FOREIGN KEY (codfarmaco, codpactivo) REFERENCES public.vadprincactivo(codfarmaco, codpactivo);


--
-- Name: invtblordenc fk_ordenc_bodega; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordenc
    ADD CONSTRAINT fk_ordenc_bodega FOREIGN KEY (iidbodegasolicita) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: invtblordenc fk_ordenc_estado; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordenc
    ADD CONSTRAINT fk_ordenc_estado FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: invtblordenc fk_ordenc_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordenc
    ADD CONSTRAINT fk_ordenc_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: invtblordend fk_ordend_cabecera; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordend
    ADD CONSTRAINT fk_ordend_cabecera FOREIGN KEY (iidbodegasolicita, iidmovimiento) REFERENCES public.invtblordenc(iidbodegasolicita, iidmovimiento) ON DELETE CASCADE;


--
-- Name: invtblordend fk_ordend_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblordend
    ADD CONSTRAINT fk_ordend_proveedor FOREIGN KEY (iidproveedor) REFERENCES public.invtblproveedores(iidproveedor);


--
-- Name: odontbltratamientoortodonciapaciente fk_ortodoncia_estado; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientoortodonciapaciente
    ADD CONSTRAINT fk_ortodoncia_estado FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: odontbltratamientoortodonciapaciente fk_ortodoncia_paciente; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientoortodonciapaciente
    ADD CONSTRAINT fk_ortodoncia_paciente FOREIGN KEY (idpaciente) REFERENCES public.odontblpacientes(iidpaciente);


--
-- Name: odontblpacientes fk_paciente_ciudad; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes
    ADD CONSTRAINT fk_paciente_ciudad FOREIGN KEY (iidciudad) REFERENCES public.tblciudades(iidciudad);


--
-- Name: odontblpacientes fk_paciente_ciudad_trabajo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes
    ADD CONSTRAINT fk_paciente_ciudad_trabajo FOREIGN KEY (iidciudadtrabajo) REFERENCES public.tblciudades(iidciudad);


--
-- Name: odontblpacientes fk_paciente_estado; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes
    ADD CONSTRAINT fk_paciente_estado FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: odontblpacientes fk_paciente_nacionalidad; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes
    ADD CONSTRAINT fk_paciente_nacionalidad FOREIGN KEY (iidnacionalidad) REFERENCES public.tblpaises(iidpais);


--
-- Name: odontblpacientes fk_paciente_pais; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblpacientes
    ADD CONSTRAINT fk_paciente_pais FOREIGN KEY (iidpais) REFERENCES public.tblpaises(iidpais);


--
-- Name: vadprincactivo fk_pactivo_farmaco; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.vadprincactivo
    ADD CONSTRAINT fk_pactivo_farmaco FOREIGN KEY (codfarmaco) REFERENCES public.vadfarmacos(codfarmaco);


--
-- Name: odontbldetalletratamientopaciente fk_pactrat_consultorio; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT fk_pactrat_consultorio FOREIGN KEY (iidconsultorio) REFERENCES public.tblconsultorios(iidconsultorio);


--
-- Name: odontbldetalletratamientopaciente fk_pactrat_doctor; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT fk_pactrat_doctor FOREIGN KEY (iiddoctor) REFERENCES public.odontbldoctores(iiddoctor);


--
-- Name: odontbldetalletratamientopaciente fk_pactrat_estado_pago; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT fk_pactrat_estado_pago FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: odontbldetalletratamientopaciente fk_pactrat_estado_trat; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT fk_pactrat_estado_trat FOREIGN KEY (cestadotratamiento) REFERENCES public.tblestados(ccodigo);


--
-- Name: odontbldetalletratamientopaciente fk_pactrat_paciente; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT fk_pactrat_paciente FOREIGN KEY (idpaciente) REFERENCES public.odontblpacientes(iidpaciente);


--
-- Name: odontbldetalletratamientopaciente fk_pactrat_tratamiento; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT fk_pactrat_tratamiento FOREIGN KEY (iidespecialidad, sitratamiento, iidtratamientodetalle) REFERENCES public.odontbltratamientodetalle(iidespecialidad, sitratamiento, iidtratamientodetalle);


--
-- Name: odontbldetalletratamientopaciente fk_pactrat_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbldetalletratamientopaciente
    ADD CONSTRAINT fk_pactrat_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: odontblparametrosgeneralescab fk_paramcab_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblparametrosgeneralescab
    ADD CONSTRAINT fk_paramcab_usuario FOREIGN KEY (vusuarioingreso) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: odontblparametrosgeneralesdet fk_paramdet_cabecera; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblparametrosgeneralesdet
    ADD CONSTRAINT fk_paramdet_cabecera FOREIGN KEY (sigrupoparametro) REFERENCES public.odontblparametrosgeneralescab(sigrupoparametro) ON DELETE CASCADE;


--
-- Name: odontblparametrosgeneralesdet fk_paramdet_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblparametrosgeneralesdet
    ADD CONSTRAINT fk_paramdet_usuario FOREIGN KEY (vusuarioingreso) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: segtblpermisosusuario fk_permiso_modulo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.segtblpermisosusuario
    ADD CONSTRAINT fk_permiso_modulo FOREIGN KEY (iidmodulo) REFERENCES public.segtblmodulos(iidmodulo);


--
-- Name: segtblpermisosusuario fk_permiso_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.segtblpermisosusuario
    ADD CONSTRAINT fk_permiso_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario) ON DELETE CASCADE;


--
-- Name: invtblproducto fk_producto_clasificacion; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproducto
    ADD CONSTRAINT fk_producto_clasificacion FOREIGN KEY (siclasificacion, sisubclasificacion) REFERENCES public.invtblsubclasificacion(siclasificacion, sisubclasificacion);


--
-- Name: invtblproducto fk_producto_unidad_compra; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproducto
    ADD CONSTRAINT fk_producto_unidad_compra FOREIGN KEY (siunidadcompra) REFERENCES public.tblunidadesmedida(siidunidad);


--
-- Name: invtblproducto fk_producto_unidad_consumo; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblproducto
    ADD CONSTRAINT fk_producto_unidad_consumo FOREIGN KEY (siunidadconsumo) REFERENCES public.tblunidadesmedida(siidunidad);


--
-- Name: odontblrecetapaciente fk_receta_detalle; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblrecetapaciente
    ADD CONSTRAINT fk_receta_detalle FOREIGN KEY (iiddetalle) REFERENCES public.odontbldetalletratamientopaciente(iiddetalle);


--
-- Name: odontblrecetapaciente fk_receta_paciente; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblrecetapaciente
    ADD CONSTRAINT fk_receta_paciente FOREIGN KEY (idpaciente) REFERENCES public.odontblpacientes(iidpaciente);


--
-- Name: odontblrecetapaciente fk_receta_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontblrecetapaciente
    ADD CONSTRAINT fk_receta_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: invtblrequisicionc fk_reqc_bodega; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisicionc
    ADD CONSTRAINT fk_reqc_bodega FOREIGN KEY (iidbodega) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: invtblrequisicionc fk_reqc_bodega_solicita; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisicionc
    ADD CONSTRAINT fk_reqc_bodega_solicita FOREIGN KEY (iidbodegasolicita) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: invtblrequisicionc fk_reqc_estado; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisicionc
    ADD CONSTRAINT fk_reqc_estado FOREIGN KEY (cestado) REFERENCES public.tblestados(ccodigo);


--
-- Name: invtblrequisicionc fk_reqc_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisicionc
    ADD CONSTRAINT fk_reqc_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: invtblrequisiciond fk_reqd_cabecera; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblrequisiciond
    ADD CONSTRAINT fk_reqd_cabecera FOREIGN KEY (iidbodega, iidtipomov, iidmovimiento) REFERENCES public.invtblrequisicionc(iidbodega, iidtipomov, iidmovimiento) ON DELETE CASCADE;


--
-- Name: invtblstockbodega fk_stock_bodega; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblstockbodega
    ADD CONSTRAINT fk_stock_bodega FOREIGN KEY (iidbodega) REFERENCES public.tblbodegas(iidbodega);


--
-- Name: invtblsubclasificacion fk_subclas_clasificacion; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.invtblsubclasificacion
    ADD CONSTRAINT fk_subclas_clasificacion FOREIGN KEY (siclasificacion) REFERENCES public.invtblclasificacion(siclasificacion);


--
-- Name: tbltalonarios fk_talonario_config; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.tbltalonarios
    ADD CONSTRAINT fk_talonario_config FOREIGN KEY (iidconfiguracion) REFERENCES public.tblconfiguracionfacturacion(iidconfiguracion);


--
-- Name: factbltarjetas fk_tarjeta_banco; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factbltarjetas
    ADD CONSTRAINT fk_tarjeta_banco FOREIGN KEY (iidbanco) REFERENCES public.tblbancos(iidbanco);


--
-- Name: factbltarjetas fk_tarjeta_paciente; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factbltarjetas
    ADD CONSTRAINT fk_tarjeta_paciente FOREIGN KEY (iidpaciente) REFERENCES public.odontblpacientes(iidpaciente);


--
-- Name: factbltarjetas fk_tarjeta_usuario; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.factbltarjetas
    ADD CONSTRAINT fk_tarjeta_usuario FOREIGN KEY (vusuario) REFERENCES public.segtblusuarios(vusuario);


--
-- Name: odontbltratamientos fk_tratamiento_especialidad; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientos
    ADD CONSTRAINT fk_tratamiento_especialidad FOREIGN KEY (iidespecialidad) REFERENCES public.tblespecialidades(iidespecialidad);


--
-- Name: odontbltratamientodetalle fk_tratdet_tratamiento; Type: FK CONSTRAINT; Schema: public; Owner: Arrobo
--

ALTER TABLE ONLY public.odontbltratamientodetalle
    ADD CONSTRAINT fk_tratdet_tratamiento FOREIGN KEY (iidespecialidad, sitratamiento) REFERENCES public.odontbltratamientos(iidespecialidad, sitratamiento);


--
-- PostgreSQL database dump complete
--

\unrestrict fFM9t9z9SecUYxUoOjhtGsqZnD2FZDj1ecRne34i6eoejz37a4cqBFbYJyjdHRU

