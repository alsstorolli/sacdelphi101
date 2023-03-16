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
-- Name: portadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE portadores (
    port_codigo character varying(3) NOT NULL,
    port_descricao character varying(50),
    port_plan_conta numeric(8,0)
);


ALTER TABLE portadores OWNER TO postgres;

--
-- Data for Name: portadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO portadores (port_codigo, port_descricao, port_plan_conta) VALUES ('001', 'Em Dinheiro', 0);
INSERT INTO portadores (port_codigo, port_descricao, port_plan_conta) VALUES ('002', 'Cartao De Crédito', 0);
INSERT INTO portadores (port_codigo, port_descricao, port_plan_conta) VALUES ('003', 'Cartão De Débito', 0);
INSERT INTO portadores (port_codigo, port_descricao, port_plan_conta) VALUES ('004', 'Cheque', 0);
INSERT INTO portadores (port_codigo, port_descricao, port_plan_conta) VALUES ('005', 'Boleto Bancario', 0);
INSERT INTO portadores (port_codigo, port_descricao, port_plan_conta) VALUES ('006', 'Deposito Bancario', 0);
INSERT INTO portadores (port_codigo, port_descricao, port_plan_conta) VALUES ('007', 'Sem Valor', 0);


--
-- Name: port_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX port_pk ON portadores USING btree (port_codigo);


--
-- PostgreSQL database dump complete
--

