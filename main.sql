CREATE TABLE Clubs (
    ClubID INT PRIMARY KEY,
    ClubName VARCHAR(255),
    Budget DECIMAL(15, 2)
);

CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(255),
    Price DECIMAL(15, 2),
    ClubID INT,
    FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID)
);

DELIMITER //

CREATE PROCEDURE TransferPlayer(
    IN player_id INT,
    IN new_club_id INT,
    IN transfer_fee DECIMAL(15, 2)
)
BEGIN
    DECLARE previous_club_id INT;

    SELECT ClubID INTO previous_club_id
    FROM Players
    WHERE PlayerID = player_id;

    UPDATE Clubs
    SET Budget = Budget - transfer_fee
    WHERE ClubID = previous_club_id;

    UPDATE Players
    SET ClubID = new_club_id
    WHERE PlayerID = player_id;

    UPDATE Clubs
    SET Budget = Budget + transfer_fee
    WHERE ClubID = new_club_id;
END //

DELIMITER ;
