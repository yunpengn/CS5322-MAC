-- Create a policy container.
BEGIN
    SA_SYSDBA.CREATE_POLICY(
        policy_name     => 'edu_ols',
        column_name     => 'label',
        default_options => 'all_control');
END;

-- Creates all levels required.
BEGIN
    SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'edu_ols',
        level_num   => 30,
        short_name  => 's',
        long_name   => 'secret');

    SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'edu_ols',
        level_num   => 20,
        short_name  => 'c',
        long_name   => 'confidential');

    SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'edu_ols',
        level_num   => 10,
        short_name  => 'u',
        long_name   => 'unclassified');
END;

-- Creates all compartments required.
BEGIN
    SA_COMPONENTS.CREATE_COMPARTMENT(
        policy_name => 'edu_ols',
        comp_num    => '003',
        short_name  => 'acd',
        long_name   => 'academic');

    SA_COMPONENTS.CREATE_COMPARTMENT(
        policy_name => 'edu_ols',
        comp_num    => '002',
        short_name  => 'adm',
        long_name   => 'admin');

    SA_COMPONENTS.CREATE_COMPARTMENT(
        policy_name => 'edu_ols',
        comp_num    => '001',
        short_name  => 'fin',
        long_name   => 'finance');
END;

-- Creates all groups required.
BEGIN
    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1000',
        short_name  => 'nus',
        long_name   => 'Neighborhood University of Somerset');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1100',
        short_name  => 'cs',
        long_name   => 'Computing',
        parent_name => 'nus');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1200',
        short_name  => 'ma',
        long_name   => 'Mathematics',
        parent_name => 'nus');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1300',
        short_name  => 'ec',
        long_name   => 'Economics',
        parent_name => 'nus');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1110',
        short_name  => 'cs206',
        long_name   => 'CS206',
        parent_name => 'cs');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1120',
        short_name  => 'cs404',
        long_name   => 'CS404',
        parent_name => 'cs');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1210',
        short_name  => 'ma314',
        long_name   => 'MA314',
        parent_name => 'ma');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1220',
        short_name  => 'ma500',
        long_name   => 'MA500',
        parent_name => 'ma');

    SA_COMPONENTS.CREATE_GROUP(
        policy_name => 'edu_ols',
        group_num   => '1310',
        short_name  => 'ec999',
        long_name   => 'EC999',
        parent_name => 'ec');
END;

-- Reads all created components.
SELECT * FROM ALL_SA_POLICIES;
SELECT * FROM ALL_SA_LEVELS;
SELECT * FROM ALL_SA_COMPARTMENTS;
SELECT * FROM ALL_SA_GROUPS;
