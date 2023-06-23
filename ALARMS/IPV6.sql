/*Consulta de equipamentos trazendo SerialNumber, MeterNO, IPv6, ServiceLocation, Latitude, Longitude */
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
    LEFT JOIN customers                              cs ON cs.customerid = mt.customerid
WHERE
    ep.hwmodelid IN (
        --65613,	  --3thd Party
        65620,	    --COLETOR APLICAÇÃO
        65619,	    --COLETOR RÁDIO
        --65675,	  --CS MESH
        65655,	    --CT
        --65676,	  --E13
        --65657,	  --E450
        --65624,	  --E650
        -- 65658,65659 -- E430
        65654,	    --RELIGADOR
        65615	      --ROTEADOR
        --65614	    --SGPM3
        --999999999
        --0
    )
