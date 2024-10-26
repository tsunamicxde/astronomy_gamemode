# Astronomy Role Play - SAMP Server Mod
The last version of the mod that has survived to this day.

_Developed in 2017_

## About

This mod was created for the SAMP server and includes unique gameplay systems. Key features of the mod:

- Registration and Authorization System — a user-friendly interface for logging in and registering new players.
- Quest System — quests of various difficulty levels that help players earn experience, money, and donation currency.
- Crafting System — enables players to create items, develop skills, and participate in the server's economy.

## Installation

### Cloning the Repository

Clone this repository to your local computer:

```bash
https://github.com/tsunamicxde/astronomy_gamemode.git
```

## Database Setup 

To set up the database, create a table in MySQL with the following structure:

```sql
CREATE TABLE players (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Password VARCHAR(32) NOT NULL,
    Mail VARCHAR(64) NOT NULL,
    `Date Reg` DATE NOT NULL,
    Level INT DEFAULT 0,
    Exp INT DEFAULT 0,
    Skin INT DEFAULT 0,
    Sex TINYINT DEFAULT 0,
    Age INT DEFAULT 0,
    Pass INT DEFAULT 0,
    Cash INT DEFAULT 0,
    Money INT DEFAULT 0,
    Quest INT DEFAULT 0,
    Questpoint INT DEFAULT 0,
    Pquest INT DEFAULT 0,
    Squest INT DEFAULT 0,
    Prava INT DEFAULT 0,
    Gold INT DEFAULT 0,
    Apple INT DEFAULT 0,
    Work INT DEFAULT 0,
    Fskill INT DEFAULT 0,
    Catalina INT DEFAULT 0,
    Bcar INT DEFAULT 0,
    Bhacker INT DEFAULT 0,
    Start INT DEFAULT 0,
    Factskill INT DEFAULT 0,
    Metall INT DEFAULT 0,
    Crisp INT DEFAULT 0,
    Shawarma INT DEFAULT 0,
    Sprunk INT DEFAULT 0,
    Cola INT DEFAULT 0,
    Beer INT DEFAULT 0,
    Cigarette INT DEFAULT 0,
    Zhiga INT DEFAULT 0,
    Phone INT DEFAULT 0,
    Book INT DEFAULT 0,
    Mag INT DEFAULT 0,
    Rguitar INT DEFAULT 0,
    Bguitar INT DEFAULT 0,
    Wguitar INT DEFAULT 0,
    Meat INT DEFAULT 0,
    Cozha INT DEFAULT 0,
    Mprava INT DEFAULT 0,
    Gunlic INT DEFAULT 0,
    Huntlic INT DEFAULT 0,
    Fishlic INT DEFAULT 0
);
```

## Server Launch

To start the SAMP server, follow these steps:

- Ensure MySQL Database is Running
- Make sure your database connection settings are set up correctly in the **astronomy.pwn** file:

```c
// ============================= [ Data Base ] =================================
#define 	MYSQL_HOST      		"127.0.0.1"
#define 	MYSQL_USER      		"root"
#define 	MYSQL_DB     			"astronomyrp"
#define 	MYSQL_PASS     			""
```

- Run samp-server.exe

## Developers

- [tsunamicxde](https://github.com/tsunamicxde)
