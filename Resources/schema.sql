create table vaccinations (
	id int primary key,
	iso_code varchar(10),
	continent varchar(20),
	location varchar(50),
	date date,
	population float(15),
	total_vaccinations float(15),
	total_boosters float(15),
	perc_vaccinated float(15),
	perc_fully_vaccinated float(15)
);

create table stats (
	iso_code varchar(30) primary key,
	"GDP" float(10),
	"Population Density" float(5),
	"Urbanization" float(5),
	"Unemployment" float(5)
);