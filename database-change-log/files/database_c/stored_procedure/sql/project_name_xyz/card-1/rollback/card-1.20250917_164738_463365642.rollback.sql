DROP PROCEDURE add_employee(emp_name VARCHAR, emp_age INT);

CREATE OR REPLACE PROCEDURE add_employee(emp_name VARCHAR, emp_age INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employees (name, age) VALUES (emp_name, emp_age);
    RAISE NOTICE 'rollback version';
END;
$$;