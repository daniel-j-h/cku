#include <cstdio>
#include <cstdlib>

#include <capstone/capstone.h>
#include <keystone/keystone.h>
#include <unicorn/unicorn.h>

void printVersions(std::FILE *out) {
  int csMajor, csMinor;
  cs_version(&csMajor, &csMinor);

  unsigned ksMajor, ksMinor;
  ks_version(&ksMajor, &ksMinor);

  unsigned ucMajor, ucMinor;
  uc_version(&ucMajor, &ucMinor);

  std::fprintf(out, "Capstone: %d.%d, "
                    "Keystone: %u.%u, "
                    "Unicorn: %u.%u\n",
               csMajor, csMinor, ksMajor, ksMinor, ucMajor, ucMinor);
}

int main() { printVersions(stderr); }
