DELETE FROM users WHERE user_name = 'Administrator';
DELETE FROM user_roles WHERE user_name = 'Administrator';

INSERT INTO users( user_name, user_pass ) VALUES( 'Administrator', '12345' );
INSERT INTO user_roles VALUES( 'Administrator', 'Administrator' );
INSERT INTO user_roles VALUES( 'Administrator', 'SystemDeveloper' );

DELETE FROM users WHERE user_name = 'User';
DELETE FROM user_roles WHERE user_name = 'User';
INSERT INTO users( user_name, user_pass ) VALUES( 'User', 'User' );
INSERT INTO user_roles VALUES ('User', 'User');

DELETE FROM users WHERE user_name = 'Test';
DELETE FROM user_roles WHERE user_name = 'Test';
INSERT INTO users( user_name, user_pass ) VALUES( 'Test', 'Test' );
INSERT INTO user_roles VALUES ('Test', 'Test');


