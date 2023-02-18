DO $$

    DECLARE given_schema 	varchar(7);	    -- schema (a.k.a lab work variant) name --
    DECLARE current_table 	varchar(50);	-- name of table which was found via iteration in schema --
    DECLARE table_counter 	INTEGER;	    -- variable for counter logic implementation --
    DECLARE counter 		INTEGER = 1;	-- counter of tables with NULL values --
    
    BEGIN

    given_schema := 's312621';

	-- Info printing --

    RAISE INFO 'Anonymous block for finiding tables which are contains NULL value in any row of any column.';
    RAISE INFO 'Schema: %', given_schema;
    RAISE INFO '##### List of tables with NULL value ##### ';
    RAISE INFO 'Table name:';
    RAISE INFO '---------------';

	-- Iteration by all tables in given schema --
    
    FOR current_table IN (SELECT tablename FROM pg_tables WHERE schemaname = given_schema)

	-- Body of iteration. Check via loop if current table contains any NULL value --
    
    LOOP
        EXECUTE
        format('SELECT * FROM %I WHERE NOT (%I IS NOT NULL);', current_table, current_table) INTO table_counter;

	-- Increment counter if NULL was found and print current table name to RAISE INFO --

        IF table_counter IS NOT NULL THEN 
            RAISE INFO '% | %', counter, current_table;
            counter := counter + 1;
        END IF;
    END LOOP;

    END

$$;
