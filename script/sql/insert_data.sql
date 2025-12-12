INSERT INTO abbonamento (nome_abbonamento, perc_offerta) VALUES
('Silver', 10),
('Gold', 15),
('Platinum', 20);

INSERT INTO passeggero (codice_fiscale, num_cliente, email, password, nominativo) VALUES
('RSSMRA80A01H501U', 'CLI001', 'mario.rossi@email.com', 'password123', 'Mario Rossi'),
('BNCGNN85B15F205X', 'CLI002', 'giulia.bianchi@email.com', 'password456', 'Giulia Bianchi'),
('VRDLCA90C20L219T', 'CLI003', 'luca.verdi@email.com', 'password789', 'Luca Verdi'),
('NRIANR75D25M301V', 'CLI004', 'anna.neri@email.com', 'password321', 'Anna Neri'),
('FRNGPP88E30H501W', 'CLI005', 'giuseppe.ferrari@email.com', 'password654', 'Giuseppe Ferrari'),
('RSSPLA92F10I001Y', 'CLI006', 'paola.rossi@email.com', 'password987', 'Paola Rossi'),
('BNCMRC87G05L219Z', 'CLI007', 'marco.bianchi@email.com', 'password147', 'Marco Bianchi'),
('VRDSRA83H20F205A', 'CLI008', 'sara.verdi@email.com', 'password258', 'Sara Verdi'),
('NRIFRC89I15M301B', 'CLI009', 'francesco.neri@email.com', 'password369', 'Francesco Neri'),
('FRNMLN91L01H501C', 'CLI010', 'milena.ferrari@email.com', 'password741', 'Milena Ferrari');

INSERT INTO abbonamento_attivo (cf_passeggero, id_abbonamento, data_inizio, data_fine) VALUES
('RSSMRA80A01H501U', 1, '2024-01-01', NULL),
('BNCGNN85B15F205X', 2, '2024-02-15', NULL),
('VRDLCA90C20L219T', 3, '2024-03-01', NULL),
('NRIANR75D25M301V', 1, '2024-01-20', NULL),
('FRNGPP88E30H501W', 2, '2024-02-01', NULL),
('RSSPLA92F10I001Y', 3, '2024-03-15', NULL),
('BNCMRC87G05L219Z', 1, '2023-06-01', '2023-12-31'),
('VRDSRA83H20F205A', 2, '2024-01-10', NULL);



INSERT INTO tratta (id_stazione_partenza, id_stazione_arrivo, distanza_km) VALUES
(3009, 2703, 129),
(2703, 3699, 200),
(3699, 4135, 81),
(4135, 3483, 232),
(3483, 4901, 188),
(4901, 5141, 220), 
(2703, 4050, 243), 
(2915, 2703, 121),  
(3699, 4050, 129),   
(3483, 5141, 374),   
(4901, 4440, 315),   
(4440, 4324, 166), 
(4324, 4411, 86),  
(4411, 4751, 11),  
(2819, 3009, 127), 
(4135, 3699, 81), 
(3483, 4135, 232),
(4987, 3483, 188),  
(5141, 4901, 220),   
(4050, 3699, 129);   



INSERT INTO corsa (id_tratta, data_partenza, data_arrivo, posti_disponibili, stato) VALUES
(41, '2024-12-20 08:00:00', '2024-12-20 09:20:00', 150, 'Regolare'),
(44, '2024-12-20 10:30:00', '2024-12-20 12:50:00', 200, 'Regolare'),
(45, '2024-12-20 14:15:00', '2024-12-20 16:05:00', 180, 'Regolare');

INSERT INTO biglietto (cf_passeggero, id_corsa, id_abbonamento_attivo, prezzo, data_acquisto) VALUES
('RSSMRA80A01H501U', 1, 1, 24.30, '2024-12-19 10:15:00'),
('BNCGNN85B15F205X', 1, 2, 22.95, '2024-12-19 11:20:00'),
('VRDLCA90C20L219T', 1, 3, 21.60, '2024-12-19 12:30:00'),
('NRIANR75D25M301V', 1, 4, 24.30, '2024-12-19 13:45:00'),
('FRNGPP88E30H501W', 1, 6, 22.95, '2024-12-19 14:20:00'),
('RSSPLA92F10I001Y', 1, 7, 21.60, '2024-12-19 15:10:00'),
('BNCMRC87G05L219Z', 1, NULL, 27.00, '2024-12-19 16:00:00'),
('VRDSRA83H20F205A', 2, 9, 42.50, '2024-12-19 09:30:00'),
('NRIFRC89I15M301B', 3, NULL, 50.00, '2024-12-19 10:45:00'),
('FRNMLN91L01H501C', 2, NULL, 50.00, '2024-12-19 11:15:00'),
('RSSMRA80A01H501U', 2, 1, 45.00, '2024-12-19 12:00:00'),
('BNCGNN85B15F205X', 3, 2, 31.45, '2024-12-19 13:20:00'),
('VRDLCA90C20L219T', 1, 3, 21.60, '2024-12-19 14:30:00'),
('NRIANR75D25M301V', 2, 4, 45.00, '2024-12-19 15:45:00'),
('FRNGPP88E30H501W', 3, 6, 31.45, '2024-12-19 08:00:00'),
('RSSPLA92F10I001Y', 3, 7, 29.60, '2024-12-19 09:15:00'),
('BNCMRC87G05L219Z', 3, NULL, 37.00, '2024-12-19 10:30:00'),
('VRDSRA83H20F205A', 2, 9, 42.50, '2024-12-19 11:45:00'),
('NRIFRC89I15M301B', 2, NULL, 37.00, '2024-12-19 12:20:00'),
('FRNMLN91L01H501C', 1, NULL, 27.00, '2024-12-19 13:10:00');


INSERT INTO punto_corsa (id_corsa, id_stazione, n_punto, tipologia, orario_arrivo, orario_partenza) VALUES
(1, 3009, 0, 'Partenza','2024-12-20 08:00:00', '2024-12-20 08:00:00'),  
(1, 2610, 1, 'Fermata', '2024-12-20 10:10:00', '2024-12-20 10:13:00'),
(1, 2703, 2, 'Arrivo', '2024-12-20 15:20:00', '2024-12-20 15:20:00');

INSERT INTO punto_corsa (id_corsa, id_stazione, n_punto, tipologia, orario_arrivo, orario_partenza) VALUES
(2, 3699, 0, 'Partenza', '2024-12-20 10:30:00', '2024-12-20 10:30:00'),
(2, 4152, 1, 'Fermata',  '2024-12-20 11:40:00', '2024-12-20 11:45:00'),
(2, 4135, 2, 'Arrivo',   '2024-12-20 12:50:00', '2024-12-20 12:50:00');

INSERT INTO punto_corsa (id_corsa, id_stazione, n_punto, tipologia, orario_arrivo, orario_partenza) VALUES
(3, 3483, 0, 'Partenza', '2024-12-20 14:15:00', '2024-12-20 14:15:00'),
(3, 4901, 1, 'Arrivo',   '2024-12-20 19:05:00', '2024-12-20 19:05:00');

INSERT INTO punto_corsa (id_corsa, id_stazione, n_punto, tipologia, orario_arrivo, orario_partenza) VALUES
(4, 4987, 0, 'Partenza', '2024-12-20 14:15:00', '2024-12-20 14:15:00'),
(4, 4901, 1, 'Cambio',  '2024-12-20 16:00:00', '2024-12-20 16:03:00'),
(4, 5141, 2, 'Arrivo',   '2024-12-20 19:05:00', '2024-12-20 19:05:00');

INSERT INTO tratta (id_stazione_partenza, id_stazione_arrivo, id_mezzo, distanza_km, prezzo_fisso) VALUES
(3009, 4135, 1, 570, 50.00), 
(4135, 3009, 1, 570, 50.00), 
(4135, 3699, 2, 220, 25.00), 
(3699, 4135, 2, 220, 25.00), 
(2703, 2610, 3, 100, 15.00);