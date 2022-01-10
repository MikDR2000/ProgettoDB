-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Gen 10, 2022 alle 15:56
-- Versione del server: 10.4.22-MariaDB
-- Versione PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `palestra`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `clienti`
--

CREATE TABLE `clienti` (
  `CodCli` int(11) NOT NULL,
  `Cognome` varchar(25) NOT NULL COMMENT 'Cognome cliente',
  `Nome` varchar(25) NOT NULL COMMENT 'Nome cliente',
  `CFCli` char(16) NOT NULL COMMENT 'Codice fiscale',
  `CertMedico` tinyint(1) DEFAULT NULL COMMENT 'Certificato medico cliente',
  `TipoCli` varchar(11) NOT NULL CHECK (`TipoCli` in ('giornaliero','mensile','trimestrale','annuale','corso'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `corso`
--

CREATE TABLE `corso` (
  `NomeCo` varchar(25) NOT NULL,
  `NumSala` smallint(6) DEFAULT NULL CHECK (`NumSala` in (1,2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `dipendenti`
--

CREATE TABLE `dipendenti` (
  `CFDip` varchar(16) NOT NULL,
  `Cognome` varchar(25) NOT NULL,
  `Nome` varchar(25) NOT NULL,
  `Stipendio` float(6,2) DEFAULT 0.00,
  `DataN` date NOT NULL,
  `Transaz` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `schedatecnica`
--

CREATE TABLE `schedatecnica` (
  `IdScheda` int(11) NOT NULL,
  `Dip` varchar(16) NOT NULL,
  `Cliente` int(11) NOT NULL,
  `Data` date NOT NULL,
  `Peso` float(4,1) NOT NULL CHECK (`Peso` > 0),
  `Altezza` smallint(6) NOT NULL CHECK (`Altezza` > 0),
  `Grasso` smallint(6) NOT NULL CHECK (`Grasso` > 0),
  `Muscolo` smallint(6) NOT NULL CHECK (`Muscolo` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `transazione`
--

CREATE TABLE `transazione` (
  `IdTrans` int(11) NOT NULL,
  `Tipo` char(7) NOT NULL CHECK (`Tipo` in ('entrata','uscita')),
  `Causale` varchar(100) DEFAULT NULL,
  `Importo` float(6,2) DEFAULT NULL,
  `Data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `clienti`
--
ALTER TABLE `clienti`
  ADD PRIMARY KEY (`CodCli`);

--
-- Indici per le tabelle `corso`
--
ALTER TABLE `corso`
  ADD PRIMARY KEY (`NomeCo`);

--
-- Indici per le tabelle `dipendenti`
--
ALTER TABLE `dipendenti`
  ADD PRIMARY KEY (`CFDip`),
  ADD KEY `Transaz` (`Transaz`);

--
-- Indici per le tabelle `schedatecnica`
--
ALTER TABLE `schedatecnica`
  ADD PRIMARY KEY (`IdScheda`),
  ADD KEY `Dip` (`Dip`),
  ADD KEY `Cliente` (`Cliente`);

--
-- Indici per le tabelle `transazione`
--
ALTER TABLE `transazione`
  ADD PRIMARY KEY (`IdTrans`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `clienti`
--
ALTER TABLE `clienti`
  MODIFY `CodCli` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `schedatecnica`
--
ALTER TABLE `schedatecnica`
  MODIFY `IdScheda` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `transazione`
--
ALTER TABLE `transazione`
  MODIFY `IdTrans` int(11) NOT NULL AUTO_INCREMENT;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `dipendenti`
--
ALTER TABLE `dipendenti`
  ADD CONSTRAINT `dipendenti_ibfk_1` FOREIGN KEY (`Transaz`) REFERENCES `transazione` (`IdTrans`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Limiti per la tabella `schedatecnica`
--
ALTER TABLE `schedatecnica`
  ADD CONSTRAINT `schedatecnica_ibfk_1` FOREIGN KEY (`Dip`) REFERENCES `dipendenti` (`CFDip`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `schedatecnica_ibfk_2` FOREIGN KEY (`Cliente`) REFERENCES `clienti` (`CodCli`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
