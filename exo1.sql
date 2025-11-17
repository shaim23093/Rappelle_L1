-- 1) Afficher l’id, first_name, last_name des employés qui n’ont pas d’équipe. 
SELECT e.id, e.first_name, e.last_name
FROM Employee e
LEFT JOIN belong b ON e.id = b.employee_id
WHERE b.team_id IS NULL;

-- 2) Afficher l’id, first_name, last_name des employés qui n’ont jamais pris de congé de leur vie.
SELECT e.id, e.first_name, e.last_name
FROM Employee e
LEFT JOIN take t ON e.id = t.employee_id
WHERE t.leave_id IS NULL;

-- 3) Afficher les congés de tel sorte qu’on voie l’id du congé, le début du congé, la fin du congé, le nom & prénom de l’employé qui prend congé et le nom de son équipe.
SELECT 
    l.id AS leave_id,
    l.start_date,
    l.end_date,
    e.first_name,
    e.last_name,
    tm.name AS team_name
FROM Leave l
JOIN take t ON l.id = t.leave_id
JOIN Employee e ON t.employee_id = e.id
LEFT JOIN belong b ON e.id = b.employee_id
LEFT JOIN Team tm ON b.team_id = tm.id;

-- 4)Affichez par le nombre d’employés par contract_type, vous devez afficher le type de contrat, et le nombre d’employés associés.
SELECT contract_type, COUNT(*) AS employee_count
FROM Employee
GROUP BY contract_type;

-- 5) Afficher le nombre d’employés en congé aujourd'hui. La période de congé s'étend de start_date inclus jusqu’à end_date inclus.
start_date <= TODAY AND end_date >= TODAY

SELECT COUNT(*) AS employees_on_leave_today
FROM take t
JOIN Leave l ON t.leave_id = l.id
WHERE CURRENT_DATE BETWEEN l.start_date AND l.end_date;

-- 6) Afficher l’id, le nom, le prénom de tous les employés + le nom de leur équipe qui sont en congé aujourd’hui. Pour rappel, la end_date est incluse dans le congé, l’employé ne revient que le lendemain. 
SELECT 
    e.id,
    e.first_name,
    e.last_name,
    tm.name AS team_name
FROM Employee e
JOIN take t ON e.id = t.employee_id
JOIN Leave l ON t.leave_id = l.id
LEFT JOIN belong b ON e.id = b.employee_id
LEFT JOIN Team tm ON b.team_id = tm.id
WHERE CURRENT_DATE BETWEEN l.start_date AND l.end_date;
