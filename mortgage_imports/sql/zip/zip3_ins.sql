/*
 See https://stackoverflow.com/questions/6671183/calculate-the-center-point-of-multiple-latitude-longitude-coordinate-pairs
 */
INSERT INTO zip.zip3
    SELECT
        a.prop_zip3,
        b.prop_city as prop_city,
        atan2(avgz, hyp) * 360.0 / (2.0 * 3.141592654) AS latitude,
        atan2(avgy, avgx) * 360.0 / (2.0 * 3.141592654) AS longitude
    FROM (
        SELECT
            prop_zip3,
            avg(x) AS avgx,
            avg(y) AS avgy,
            avg(z) AS avgz,
            sqrt(avgx * avgx + avgy * avgy) AS hyp
        FROM (
            SELECT
                substr(prop_zip, 1, 3) AS prop_zip3,
                clat * clong AS x,
                clat * slong AS y,
                slat AS z,
                cos(lat) AS clat,
                sin(lat) AS slat,
                cos(long) AS clong,
                sin(long) AS slong,
                (2.0 * 3.141592654 / 360.0) * latitude AS lat,
                (2.0 * 3.141592654 / 360.0) * longitude AS long
            FROM
                zip.zip5)
        GROUP BY prop_zip3) AS a
    JOIN (
        SELECT
            prop_zip3,
            arrayElement(groupArray(prop_city), 1) AS prop_city,
            arrayElement(groupArray(nz), 1) AS num_zips
        FROM(
            SELECT
                substr(prop_zip, 1, 3) as prop_zip3,
                concat(prop_city, ', ', prop_st) AS prop_city,
                count(*) as nz
            FROM
                zip.zip5
            GROUP BY
                prop_zip3, prop_city
            ORDER BY
            nz DESC)
        GROUP BY prop_zip3) AS b
    ON
        a.prop_zip3 = b.prop_zip3;