--show endian format on your platform (little-endian or big-endian)
select PLATFORM_NAME, endian_format
from v$transportable_platform
join v$database using(PLATFORM_NAME);
