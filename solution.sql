# Write your MySQL query statement below
SELECT 
    request_at AS "Day",
    ROUND(canceled_trips / all_trips, 2) AS "Cancellation Rate"
FROM (
    SELECT 
        SUM(IF(status != 'completed', 1, 0)) canceled_trips,
        COUNT(*) all_trips,
        request_at
    FROM (
        SELECT 
            *,
            SUM(IF(banned = 'Yes', 1, 0)) flag_banned
        FROM Trips
        INNER JOIN Users ON client_id = users_id OR driver_id = users_id
        GROUP BY id
    ) tabel_2
    WHERE 
        flag_banned = 0
        AND request_at BETWEEN "2013-10-01" AND "2013-10-03"
    GROUP BY request_at
) tabel_1
