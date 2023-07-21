INSERT INTO `datastore` (name, label, shared)
SELECT 'epyi_admin_userdata', 'epyi_administration data', 0
WHERE NOT EXISTS (
    SELECT 1 FROM `datastore` WHERE name = 'epyi_admin_userdata'
);