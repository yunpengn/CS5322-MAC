-- Create all labels required.
CREATE OR REPLACE FUNCTION label_users RETURN LBACSYS.LBAC_LABEL AS
    label_val VARCHAR(80);
BEGIN
    label_val := 's:adm';
    RETURN TO_LBAC_DATA_LABEL('edu_ols', label_val);
END;

CREATE OR REPLACE FUNCTION label_addresses(addr_type VARCHAR) RETURN LBACSYS.LBAC_LABEL AS
    label_val VARCHAR(80);
BEGIN
    IF addr_type = 'mailing' THEN
        label_val := 'c:adm';
    ELSE
        label_val := 'c:fin';
    END IF;

    RETURN TO_LBAC_DATA_LABEL('edu_ols', label_val);
END;

CREATE OR REPLACE FUNCTION label_fees RETURN LBACSYS.LBAC_LABEL AS
    label_val VARCHAR(80);
BEGIN
    label_val := 'c:fin';
    RETURN TO_LBAC_DATA_LABEL('edu_ols', label_val);
END;

CREATE OR REPLACE FUNCTION label_modules RETURN LBACSYS.LBAC_LABEL AS
    label_val VARCHAR(80);
BEGIN
    label_val := 'u';
    RETURN TO_LBAC_DATA_LABEL('edu_ols', label_val);
END;

CREATE OR REPLACE FUNCTION label_grades(module_id NUMBER) RETURN LBACSYS.LBAC_LABEL AS
    label_val   VARCHAR(80);
    module_code VARCHAR(5);
BEGIN
    SELECT code INTO module_code FROM modules WHERE id = module_id;

    label_val := 's';
    RETURN TO_LBAC_DATA_LABEL('edu_ols', label_val);
END;
