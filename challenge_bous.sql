PGDMP                     
    y            challenge_bous    13.0    13.0 4    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    41217    challenge_bous    DATABASE     k   CREATE DATABASE challenge_bous WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE challenge_bous;
                postgres    false            ?            1255    41339    adeudototal()    FUNCTION     ?   CREATE FUNCTION public.adeudototal() RETURNS double precision
    LANGUAGE plpgsql
    AS $$
BEGIN
SELECT SUM(valor_adeudado) AS total_adeudado FROM validos;
END;
$$;
 $   DROP FUNCTION public.adeudototal();
       public          postgres    false            ?            1255    41278    date(character varying)    FUNCTION     ?   CREATE FUNCTION public.date(d character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN

perform d::date;
  return true;
exception when others then
  return false;

END;
$$;
 0   DROP FUNCTION public.date(d character varying);
       public          postgres    false            ?            1255    41279    number(integer)    FUNCTION     ?   CREATE FUNCTION public.number(numero integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
perform numero::integer;
  return true;
exception when others then
  return false;

END;
$$;
 -   DROP FUNCTION public.number(numero integer);
       public          postgres    false            ?            1255    41280    number(character varying)    FUNCTION     ?   CREATE FUNCTION public.number(numero character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
perform numero::integer;
  return true;
exception when others then
  return false;

END;
$$;
 7   DROP FUNCTION public.number(numero character varying);
       public          postgres    false            ?            1259    41353    adeudo_y_porcentaje_por_ciudad    TABLE     ?   CREATE TABLE public.adeudo_y_porcentaje_por_ciudad (
    id integer NOT NULL,
    ciudad character varying,
    adeudo integer,
    porcentaje double precision,
    folio_procesados integer
);
 2   DROP TABLE public.adeudo_y_porcentaje_por_ciudad;
       public         heap    postgres    false            ?            1259    41351 %   adeudo_y_porcentaje_por_ciudad_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.adeudo_y_porcentaje_por_ciudad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.adeudo_y_porcentaje_por_ciudad_id_seq;
       public          postgres    false    209            ?           0    0 %   adeudo_y_porcentaje_por_ciudad_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.adeudo_y_porcentaje_por_ciudad_id_seq OWNED BY public.adeudo_y_porcentaje_por_ciudad.id;
          public          postgres    false    208            ?            1259    41342    adeudo_y_porcentaje_por_empresa    TABLE     ?   CREATE TABLE public.adeudo_y_porcentaje_por_empresa (
    id integer NOT NULL,
    empresa character varying,
    adeudo integer,
    porcentaje double precision,
    folio_procesados integer
);
 3   DROP TABLE public.adeudo_y_porcentaje_por_empresa;
       public         heap    postgres    false            ?            1259    41340 &   adeudo_y_porcentaje_por_empresa_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.adeudo_y_porcentaje_por_empresa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.adeudo_y_porcentaje_por_empresa_id_seq;
       public          postgres    false    207            ?           0    0 &   adeudo_y_porcentaje_por_empresa_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.adeudo_y_porcentaje_por_empresa_id_seq OWNED BY public.adeudo_y_porcentaje_por_empresa.id;
          public          postgres    false    206            ?            1259    41319 	   invalidos    TABLE     ?   CREATE TABLE public.invalidos (
    id integer NOT NULL,
    cliente character varying,
    contrato character varying,
    fecha_de_compra date,
    ciudad character varying,
    empresa character varying,
    valor_adeudado integer
);
    DROP TABLE public.invalidos;
       public         heap    postgres    false            ?            1259    41317    invalidos_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.invalidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.invalidos_id_seq;
       public          postgres    false    205            ?           0    0    invalidos_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.invalidos_id_seq OWNED BY public.invalidos.id;
          public          postgres    false    204            ?            1259    41364 
   procesados    TABLE     y   CREATE TABLE public.procesados (
    folio integer NOT NULL,
    numero_de_registros integer,
    adeudo_total bigint
);
    DROP TABLE public.procesados;
       public         heap    postgres    false            ?            1259    41362    procesados_folio_seq    SEQUENCE     ?   CREATE SEQUENCE public.procesados_folio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.procesados_folio_seq;
       public          postgres    false    211            ?           0    0    procesados_folio_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.procesados_folio_seq OWNED BY public.procesados.folio;
          public          postgres    false    210            ?            1259    41253    tabla_de_trabajo    TABLE     ?   CREATE TABLE public.tabla_de_trabajo (
    id integer NOT NULL,
    cliente character varying,
    contrato character varying,
    fecha_de_compra date,
    ciudad character varying,
    empresa character varying,
    valor_adeudado integer
);
 $   DROP TABLE public.tabla_de_trabajo;
       public         heap    postgres    false            ?            1259    41251    tabla_de_trabajo_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.tabla_de_trabajo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.tabla_de_trabajo_id_seq;
       public          postgres    false    201            ?           0    0    tabla_de_trabajo_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.tabla_de_trabajo_id_seq OWNED BY public.tabla_de_trabajo.id;
          public          postgres    false    200            ?            1259    41308    validos    TABLE     ?   CREATE TABLE public.validos (
    id integer NOT NULL,
    cliente character varying,
    contrato character varying,
    fecha_de_compra date,
    ciudad character varying,
    empresa character varying,
    valor_adeudado integer
);
    DROP TABLE public.validos;
       public         heap    postgres    false            ?            1259    41306    validos_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.validos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.validos_id_seq;
       public          postgres    false    203            ?           0    0    validos_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.validos_id_seq OWNED BY public.validos.id;
          public          postgres    false    202            M           2604    41356 !   adeudo_y_porcentaje_por_ciudad id    DEFAULT     ?   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_ciudad ALTER COLUMN id SET DEFAULT nextval('public.adeudo_y_porcentaje_por_ciudad_id_seq'::regclass);
 P   ALTER TABLE public.adeudo_y_porcentaje_por_ciudad ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    209    209            L           2604    41345 "   adeudo_y_porcentaje_por_empresa id    DEFAULT     ?   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_empresa ALTER COLUMN id SET DEFAULT nextval('public.adeudo_y_porcentaje_por_empresa_id_seq'::regclass);
 Q   ALTER TABLE public.adeudo_y_porcentaje_por_empresa ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            K           2604    41322    invalidos id    DEFAULT     l   ALTER TABLE ONLY public.invalidos ALTER COLUMN id SET DEFAULT nextval('public.invalidos_id_seq'::regclass);
 ;   ALTER TABLE public.invalidos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    205    205            N           2604    41367    procesados folio    DEFAULT     t   ALTER TABLE ONLY public.procesados ALTER COLUMN folio SET DEFAULT nextval('public.procesados_folio_seq'::regclass);
 ?   ALTER TABLE public.procesados ALTER COLUMN folio DROP DEFAULT;
       public          postgres    false    210    211    211            I           2604    41256    tabla_de_trabajo id    DEFAULT     z   ALTER TABLE ONLY public.tabla_de_trabajo ALTER COLUMN id SET DEFAULT nextval('public.tabla_de_trabajo_id_seq'::regclass);
 B   ALTER TABLE public.tabla_de_trabajo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            J           2604    41311 
   validos id    DEFAULT     h   ALTER TABLE ONLY public.validos ALTER COLUMN id SET DEFAULT nextval('public.validos_id_seq'::regclass);
 9   ALTER TABLE public.validos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            ?          0    41353    adeudo_y_porcentaje_por_ciudad 
   TABLE DATA           j   COPY public.adeudo_y_porcentaje_por_ciudad (id, ciudad, adeudo, porcentaje, folio_procesados) FROM stdin;
    public          postgres    false    209   ??       ?          0    41342    adeudo_y_porcentaje_por_empresa 
   TABLE DATA           l   COPY public.adeudo_y_porcentaje_por_empresa (id, empresa, adeudo, porcentaje, folio_procesados) FROM stdin;
    public          postgres    false    207   ??       ?          0    41319 	   invalidos 
   TABLE DATA           l   COPY public.invalidos (id, cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado) FROM stdin;
    public          postgres    false    205   @       ?          0    41364 
   procesados 
   TABLE DATA           N   COPY public.procesados (folio, numero_de_registros, adeudo_total) FROM stdin;
    public          postgres    false    211   +@       ?          0    41253    tabla_de_trabajo 
   TABLE DATA           s   COPY public.tabla_de_trabajo (id, cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado) FROM stdin;
    public          postgres    false    201   H@       ?          0    41308    validos 
   TABLE DATA           j   COPY public.validos (id, cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado) FROM stdin;
    public          postgres    false    203   e@       ?           0    0 %   adeudo_y_porcentaje_por_ciudad_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.adeudo_y_porcentaje_por_ciudad_id_seq', 1, false);
          public          postgres    false    208            ?           0    0 &   adeudo_y_porcentaje_por_empresa_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.adeudo_y_porcentaje_por_empresa_id_seq', 1, false);
          public          postgres    false    206            ?           0    0    invalidos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.invalidos_id_seq', 1, false);
          public          postgres    false    204            ?           0    0    procesados_folio_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.procesados_folio_seq', 1, false);
          public          postgres    false    210            ?           0    0    tabla_de_trabajo_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.tabla_de_trabajo_id_seq', 1, false);
          public          postgres    false    200            ?           0    0    validos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.validos_id_seq', 1, false);
          public          postgres    false    202            X           2606    41361 B   adeudo_y_porcentaje_por_ciudad adeudo_y_porcentaje_por_ciudad_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_ciudad
    ADD CONSTRAINT adeudo_y_porcentaje_por_ciudad_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_ciudad DROP CONSTRAINT adeudo_y_porcentaje_por_ciudad_pkey;
       public            postgres    false    209            V           2606    41350 D   adeudo_y_porcentaje_por_empresa adeudo_y_porcentaje_por_empresa_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_empresa
    ADD CONSTRAINT adeudo_y_porcentaje_por_empresa_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_empresa DROP CONSTRAINT adeudo_y_porcentaje_por_empresa_pkey;
       public            postgres    false    207            T           2606    41327    invalidos invalidos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.invalidos
    ADD CONSTRAINT invalidos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.invalidos DROP CONSTRAINT invalidos_pkey;
       public            postgres    false    205            Z           2606    41369    procesados procesados_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.procesados
    ADD CONSTRAINT procesados_pkey PRIMARY KEY (folio);
 D   ALTER TABLE ONLY public.procesados DROP CONSTRAINT procesados_pkey;
       public            postgres    false    211            P           2606    41261 &   tabla_de_trabajo tabla_de_trabajo_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.tabla_de_trabajo
    ADD CONSTRAINT tabla_de_trabajo_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.tabla_de_trabajo DROP CONSTRAINT tabla_de_trabajo_pkey;
       public            postgres    false    201            R           2606    41316    validos validos_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.validos
    ADD CONSTRAINT validos_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.validos DROP CONSTRAINT validos_pkey;
       public            postgres    false    203            \           2606    41370 +   adeudo_y_porcentaje_por_ciudad fkprocesados    FK CONSTRAINT     ?   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_ciudad
    ADD CONSTRAINT fkprocesados FOREIGN KEY (folio_procesados) REFERENCES public.procesados(folio);
 U   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_ciudad DROP CONSTRAINT fkprocesados;
       public          postgres    false    209    211    2906            [           2606    41375 ,   adeudo_y_porcentaje_por_empresa fkprocesados    FK CONSTRAINT     ?   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_empresa
    ADD CONSTRAINT fkprocesados FOREIGN KEY (folio_procesados) REFERENCES public.procesados(folio);
 V   ALTER TABLE ONLY public.adeudo_y_porcentaje_por_empresa DROP CONSTRAINT fkprocesados;
       public          postgres    false    207    2906    211            ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?     