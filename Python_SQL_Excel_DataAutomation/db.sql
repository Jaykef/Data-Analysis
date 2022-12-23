
-- (1) 统计过去1周之内（2020-09-07~2020-09-13）每天的订单量、收入、有订单的用户数，并按预定日期降序排列。
SELECT
    o_date
    ,count(order_no)
    ,sum(order_amount)
    ,COUNT( DISTINCT uid)
FROM order_intl_info
WHERE o_date BETWEEN '2020-09-07' AND '2020-09-13'
GROUP BY o_date 
ORDER BY o_date DESC


--（2）统计过去一周之内（2020-09-07~2020-09-13）每天下单用户占当天浏览用户的比例
SELECT
    b.order_date
    ,cn2/cn1
FROM
    (SELECT a_time,count(DISTINCT uid) cn1
    FROM activity_intl_info
    GROUP BY a_time)a
JOIN 
    (SELECT order_date,count(DISTINCT uid) cn2
    FROM order_intl_info
    GROUP BY o_date)b
ON a.a_time=b.o_date


-- （3）找出过去1周之内（2020-09-07~2020-09-13）每天订单量最高的酒店名称
SELECT
    b.order_date
    ,b.h_name
    ,b.rn
FROM
(
    SELECT
        a.order_date
        ,a.h_name
        ,rank() over(PARTITION BY a.order_date ORDER BY a.CNT) rn

    FROM
    (
        SELECT 
            order_date
            ,h_name
            ,count(order_no) AS CNT
        FROM order_intl_info
        WHERE o_date BETWEEN '2020-09-07' AND '2020-09-13'
        GROUP BY o_date,h_name
    )a
)b
WHERE rn=1







