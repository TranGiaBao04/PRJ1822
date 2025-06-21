﻿USE [master]
GO
DROP DATABASE WorkShop
GO

CREATE DATABASE WorkShop 
Go
USE WorkShop
GO

CREATE TABLE tblUsers (
    userId VARCHAR(50) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('Founder', 'Team Member'))
);

CREATE TABLE tblStartupProjects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    description TEXT,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Ideation', 'Development', 'Launch', 'Scaling')),
    estimated_launch DATE NOT NULL
);