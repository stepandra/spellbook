{{
    config(
        materialized='table',
        schema = 'safe_worldchain',
        alias= 'singletons',
        post_hook = '{{ expose_spells(
                        blockchains = \'["worldchain"]\',
                        spell_type = "project",
                        spell_name = "safe",
                        contributors = \'["danielpartida"]\') }}'
    )
}}


-- Fetch all known singleton/mastercopy addresses used via factories.
select distinct singleton as address
from {{ source('gnosis_safe_worldchain', 'SafeProxyFactory_v_1_3_0_evt_ProxyCreation') }}

union
select distinct singleton as address
from {{ source('gnosis_safe_worldchain', 'SafeProxyFactory_v_1_4_1_evt_ProxyCreation') }}