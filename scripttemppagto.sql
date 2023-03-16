--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.0
-- Dumped by pg_dump version 9.6.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: fpgto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fpgto (
    fpgt_codigo character varying(3) NOT NULL,
    fpgt_descricao character varying(50),
    fpgt_reduzido character varying(15),
    fpgt_aplicacao character varying(20),
    fpgt_prazos character varying(100),
    fpgt_acrescimos numeric(10,5),
    fpgt_descontos numeric(10,5),
    fpgt_entrada numeric(10,5),
    fpgt_comissao numeric(10,5),
    fpgt_icmsint numeric(10,5)
);


ALTER TABLE fpgto OWNER TO postgres;

--
-- Data for Name: fpgto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('001', '30', '30', 'R;P;C;V', '30', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('002', '30;60;90;120', '30/60/90/120', 'R;P;C;V', '30;60;90;120', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('003', 'A Vista ', 'Vista', 'R;P;C;V', '0', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('004', '14 Dias', '14', 'R;P;C;V', '14', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('005', '30/60', '30/60', 'R;P;C;V', '30;60', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('008', '7 Dias ', '7;', 'R;P;C;V', '7;', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('009', '30/60/90', '30/60/90', 'R;P;C;V', '30;60;90', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('011', '30-60-90-120-150-180', '6 x ', 'R;P;C;V', '30;60;90;120;150;180', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('013', '28/35 ', '28-35', 'R;P;C;V', '28;35', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('014', '28-42', '25/42', 'R;P;C;V', '28;42', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('015', '21 Dias ', '21', 'R;P;C;V', '21;', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('010', '25/35/42', '28;35;42', 'R;P;C;V', '28;35;42', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('006', '0;30;60;90', '0;30;60;90', 'R;P;C;V', '0;30;60;90', 0.00000, 0.00000, 4644.00000, 3.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('017', '28', '28;', 'R;P;C;V', '28;', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('018', 'A Vista Cartao Débito', 'Cartao', 'P', '0', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('016', '10 Dias', '10', 'R;P;C;V', '10', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('019', '12 Vezes', '12 x', 'R;P;C;V', '30;60;90;120;150;180;210;240;270;300;330;360', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('020', '30/45', '30/45', 'R;P;C;V', '30;45', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('021', '28/42/56', '28/42/56', 'R;P;C;V', '28;42;56', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('022', '1/28/42/56', '1/28/42/56', 'R;P;C;V', '1;28;42;56', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('023', '30-60-90-120-150-180-210-240-270-300', '10 Vezes', 'R;P;C;V', '30;60;90;120;150;180;210;240;270;300', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('024', '1/28/42/60/90', '1/28/42/60/90', 'R;P;C;V', '1;28;42;60;90', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('025', '40-60-100', '3x', 'R;P;C;V', '40;60;100', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('026', '40/70/100', '40/70/100', 'R;P;C;V', '40;70;100', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('012', '28/56/84', '28/56/84', 'R;P;C;V', '28;56;84', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('027', '28/56', '28/56', 'R;P;C;V', '28;56', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('028', '0/15', '0/15', 'R;P;V;C', '0;15', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('029', '20 Dias', '20', 'R;P;C;V', '20', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('030', '0/28/42', '0;28;42', 'R;P;C;V', '0;28;42', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('031', '0/30/60', '0;30;60', 'R;P;V;C', '0;30;60', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('032', '0/30', '0;30', 'R;P;V;C', '0;30', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('033', '18', '18', 'R;P;V;C', '18', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('034', '15', '15', 'R;P;C;V', '15', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('035', '15;30;60', '15;30;60', 'R;P;C;V', '15;30;60', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('036', '28;35;42;49', '28;35;42;49', 'R;P;C;V', '28;35;42;49', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('037', '0/30/60/90/120/150', '0;30;60;90;120;', 'R;P;C;V', '0;30;60;90;120;150', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('038', '0;30;60;90;120;150;180;210;240;270;300', '0;30;60;90;120', 'R;P;C;V', '0;30;60;90;120;150;180;210;240;270;300', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('039', '21;35', '21;35', 'R;P;C;V', '21;35', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('040', '24', '24', 'R;P;C;V', '24', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('041', '7', '7', 'R;P;C;V', '7', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('042', '14/21/28/35', '14/21/28/35', 'R;P;C;V', '14;21;28;35', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('043', '21/41/60/80', '21;41;60;80;', 'R;P;C;V', '21;42;60;80', 0.00000, 0.00000, 0.00000, 0.00000, NULL);
INSERT INTO fpgto (fpgt_codigo, fpgt_descricao, fpgt_reduzido, fpgt_aplicacao, fpgt_prazos, fpgt_acrescimos, fpgt_descontos, fpgt_entrada, fpgt_comissao, fpgt_icmsint) VALUES ('044', '10;30', '10;30', 'R;P;C;V', '10;30', 0.00000, 0.00000, 0.00000, 0.00000, NULL);


--
-- Name: fpgt_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fpgt_pk ON fpgto USING btree (fpgt_codigo);


--
-- PostgreSQL database dump complete
--

