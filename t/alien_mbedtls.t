use Test2::V0 -no_srand => 1;
use Test::Alien;
use Alien::mbedtls;

alien_ok 'Alien::mbedtls';

my $xs = do { local $/; <DATA> };

xs_ok { xs => $xs, verbose => 1 }, with_subtest {
  my $version_number = mbedtls_version_get_number();
  my $version_string = mbedtls_version_get_string();
  
  ok $version_string, "version_string";
  note "version_string = $version_string";

  ok $version_number, "version_number";
  note "version_number = $version_number";
  note sprintf "version_number = %x", $version_number;
};

done_testing

__DATA__
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <mbedtls/version.h>

MODULE = main PACKAGE = main

unsigned int
mbedtls_version_get_number()

const char *
mbedtls_version_get_string()
  CODE:
    static char buffer[18];
    mbedtls_version_get_string(buffer);
    RETVAL = buffer;
  OUTPUT:
    RETVAL
