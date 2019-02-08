
#include wget 

Exec {
  path => '/bin:/sbin/:/usr/bin/:/usr/sbin/',
} 

package{'icu':}

package{'curl':}

package{'libicu':}

package{'libunwind':}

package{'dotnet-runtime-2.2':}

