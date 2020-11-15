create function accounts_d(i_id_zipcodes integer) returns integer
    language plpgsql
as
$$
DECLARE
    stevilo_vrstic INTEGER = 0;
BEGIN
    IF (i_id_zipcodes IS NOT NULL) THEN
    BEGIN
        -- brisanje vrstice
        DELETE FROM zipcodes
            WHERE id_zipcodes = i_id_zipcodes;
        -- ugotovimo število vrstic na katerih je bila sprememba z izvršitvijo zadnjega SQL stavka
        GET DIAGNOSTICS stevilo_vrstic = ROW_COUNT;
        -- prestrezanje možnih izjem
        EXCEPTION
            WHEN integrity_constraint_violation THEN
                RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
            WHEN restrict_violation THEN
                RAISE EXCEPTION 'Napaka ... odvisni zapisi.';
            -- v primeru ostalih napak
            WHEN others THEN
                RAISE EXCEPTION 'Napaka ...';
    END;
    END IF;
    RETURN stevilo_vrstic;
END;
$$;

alter function zipcodes_d(integer) owner to postgres;

