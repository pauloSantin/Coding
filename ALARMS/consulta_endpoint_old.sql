WITH  ConnectionCCDate AS(
SELECT
    esch.endpointid,
    name as STATUS,
    max(trunc(esch.LASTMODIFIEDDATE - numtodsinterval(3,'hour'))) AS DATA
FROM
    centralservices.endpointstatuscodehistory esch
    INNER JOIN centralservices.statuscodes sc ON sc.statuscodeid = esch.statuscodeid
    inner join centralservices.ENDPOINTS e ON e.endpointid = esch.endpointid
WHERE
    sc.name = 'Discovered'
GROUP BY
    esch.endpointid,
    name
)
SELECT
    ep.endpointid as id_endpoint,
    ep.serialnumber as SERIAL_NUMBER,
    mt.meterno as meterno,
    substr(ep.firmwareversion, - 5) AS fw_radio,
    case 
        when substr(mt.firmwareversion, 1,1) = 'M' then substr(mt.firmwareversion, - 5)
        when substr(mt.firmwareversion, 1,3) = 'E13' then mt.firmwareversion
        when substr(mt.firmwareversion, 1,2) = 'CS' then mt.firmwareversion
        else    mt.firmwareversion 
    end as fw_meter,
    case em.endpointmodelid
        
        WHEN 65615 THEN 'Router'
        WHEN 65655 THEN 'Power Vault'
        WHEN 65654 THEN 'DA Recloser'
        WHEN 65675 THEN 'CS Mesh'
        WHEN 65614 THEN 'IWR SGP+M3'
        ELSE 'UNDEFINED - ' || to_char(em.endpointmodelid)
    END AS endpoint_model,
    g.name               AS configuration_group,
    sl.servloc AS service_location,
    gps.latitude As latitude,
    gps.longitude As longitude,
    sc.name              AS status,
    cc.name              AS collector,
    te.name              AS tenant_group,
    to_char(ep.lastbillableread, 'DD/MM/YYYY HH24:MI:SS') AS dt_last_billable_reading,
    to_char(ccd.DATA , 'DD/MM/YYYY') AS dt_connection,
    rfs.layer,
    to_char(SYSDATE - 1, 'dd/mm/yyyy') AS dt_ref
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
    LEFT JOIN centralservices.ConnectionCCDate       ccd ON ccd.endpointid = ep.endpointid
    INNER JOIN centralservices.rfendpointproperties  rfs ON  rfs.endpointid = ep.endpointid
WHERE
    mt.meterno IS NOT NULL
    ---and g.name <> 'LG Inventory Group'
    --and  em.endpointmodelid = 65655
    and sc.name  <> 'Inventory'
    --and ep.hwmodelid = 65619
ORDER BY 6
