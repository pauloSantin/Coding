SELECT
    ep.serialnumber,
    mt.meterno,
    ep.ipaddrv6,
    sl.servloc,
    gps.latitude,
    gps.longitude
FROM
    centralservices.endpoints              ep
    LEFT JOIN centralservices.meters                 mt ON mt.meterid = ep.meterid
    LEFT JOIN centralservices.servicelocations       sl ON sl.servicelocationid = mt.servicelocationid
    LEFT JOIN centralservices.gpslocations           gps ON sl.gpslocationid = gps.gpslocationid
    LEFT JOIN centralservices.statuscodes            sc ON sc.statuscodeid = ep.statuscodeid
    LEFT JOIN centralservices.endpointmodels         em ON em.endpointmodelid = ep.hwmodelid
    LEFT JOIN centralservices.tenantgroup            te ON te.tenantid = ep.tenantid
    LEFT JOIN centralservices.rfendpointproperties   rfp ON rfp.endpointid = ep.endpointid
    LEFT JOIN centralservices.collectors             cc ON cc.collectorid = ep.spuid
    LEFT JOIN centralservices.groups                 g ON g.groupid = ep.configurationgroupid
WHERE
    ep.hwmodelid IN (65620, 65619, 65655, 65654, 65615)
