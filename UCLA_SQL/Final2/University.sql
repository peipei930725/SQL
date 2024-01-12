CREATE TABLE University(
    WorldRank INT NOT NULL,
    Institution VARCHAR(255) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    NationalRank INT,
    EducationRank INT,
    EmployabilityRabk INT,
    FacultyRank INT,
    ResearchRank INT,
    Score DECIMAL(10,2),
    PRIMARY KEY (WorldRank)
);