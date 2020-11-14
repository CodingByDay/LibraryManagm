create function books_authors_iu(i_id_books_authors int, i_id_books int, i_id_authors int) returns integer

    language plpgsql
as
$$
DECLARE
    kljuc INTEGER;
BEGIN
    IF (i_id_books_authors IS NULL) THEN
    BEGIN
        -- uporabimo naslednjo vrednost seqvence
        kljuc = nextval('books_authors_id_books_authors_seq');
        -- izvršimo INSERT stavek
        INSERT INTO books_authors VALUES (kljuc, i_name, i_phone_number, i_email_address, i_id_address);
        -- prestrezanje možnih izjem
        EXCEPTION
            WHEN integrity_constraint_violation THEN
                RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
            WHEN not_null_violation THEN
                RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
            WHEN foreign_key_violation THEN
                RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
            WHEN unique_violation THEN
                RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
            WHEN check_violation THEN
                RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
            WHEN string_data_right_truncation THEN
                RAISE EXCEPTION 'Napaka ... vrednost vsebuje več znakov kot je dolžina polja.';
            -- v primeru ostalih napak
            WHEN others THEN
                RAISE EXCEPTION 'Napaka ...';
        END;
    ELSE
    BEGIN
        -- izvršimo UPDATE stavek
        UPDATE publisher
            SET
               name = i_name,
               phone_number = i_phone_number,
               email_address = i_email_address,
               id_address = i_id_address
            WHERE id_publisher = i_id_publisher;
        kljuc = i_id_publisher;
        -- prestrezanje možnih izjem
         EXCEPTION
            WHEN integrity_constraint_violation THEN
                RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
            WHEN not_null_violation THEN
                RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
            WHEN foreign_key_violation THEN
                RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
            WHEN unique_violation THEN
                RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
            WHEN check_violation THEN
                RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
            WHEN string_data_right_truncation THEN
                RAISE EXCEPTION 'Napaka ... vrednost vsebuje več znakov kot je dolžina polja.';
                -- v primeru ostalih napak
                WHEN others THEN
                RAISE EXCEPTION 'Napaka ...';
    END;
    END IF;
    RETURN kljuc;
END;
$$;

alter function publisher_iu(i_id_publisher int, i_name char varying, i_phone_number int, i_email_address int, i_id_address int) owner to postgres;