CREATE USER 'java'@'%' IDENTIFIED BY 'Adm1n@2021p@sw';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'java'@'%' WITH GRANT OPTION;
GRANT ALL ON db1.* TO 'java'@'%';