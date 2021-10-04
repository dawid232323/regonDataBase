CREATE TABLE scientists (
    scien_ID varchar(15) PRIMARY KEY,
    scien_name varchar(100),
    scien_lastName varchar(100),
    scien_specialities varchar(300),
    scien_classification varchar(256),
    scien_connectedProfiles varchar(256),
    scien_college varchar(256),
    scien_collegePlace varchar(256),
    scien_collegeEndingYEar varchar(256),
    scien_professorField varchar(256),
    scien_professorTitleDate DATE,
    scien_habilitationField varchar(256),
    scien_habilitationDyscypline varchar(256),
    scien_habilitationDegreeDate varchar(256),
    scien_habilitationWorkTitle varchar(256),
    scien_habilitationInstitutionID varchar(15),
    scien_doctorateField varchar(256),
    scien_doctorateDyscypline varchar(256),
    scien_doctorateSpeciality varchar(256),
    scien_doctorateDegreeDate DATE,
    scien_doctorateWorkTitle varchar(256),
    scien_doctorateInstitution varchar(15),
    CONSTRAINT habilitation_institutions_key FOREIGN KEY (scien_habilitationInstitutionID) REFERENCES institutions(inst_ID),
    CONSTRAINT doctorate_institution_key FOREIGN KEY (scien_doctorateInstitution) REFERENCES institutions(inst_ID)
);

CREATE TABLE institutions (
    inst_ID varchar(15) PRIMARY KEY,
    ins_name varchar(300)
);
