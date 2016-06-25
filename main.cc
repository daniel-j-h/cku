#include <cstdio>
#include <cstdlib>

#include <capstone/capstone.h>
#include <keystone/keystone.h>
#include <unicorn/unicorn.h>

[[noreturn]] static void panic(const char *msg) {
  std::fprintf(stderr, "Error: %s\n", msg);
  std::fflush(stderr);
  std::quick_exit(EXIT_FAILURE);
}

static void ensure(bool cond, const char *msg) {
  if (!cond)
    panic(msg);
}

static void ensure(bool cond) {
  if (!cond)
    ensure(cond, "unknown");
}

struct x86_64 {
  x86_64() {
    auto rc = ::cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
    ensure(rc == CS_ERR_OK);
  }

  ~x86_64() {
    auto rc = ::cs_close(&handle);
    ensure(rc == CS_ERR_OK);
  }

  csh handle;
};

void printVersions(std::FILE *out) {
  int csMajor, csMinor;
  ::cs_version(&csMajor, &csMinor);

  unsigned ksMajor, ksMinor;
  ::ks_version(&ksMajor, &ksMinor);

  unsigned ucMajor, ucMinor;
  ::uc_version(&ucMajor, &ucMinor);

  std::fprintf(out, "Capstone: %d.%d, "
                    "Keystone: %u.%u, "
                    "Unicorn: %u.%u\n",
               csMajor, csMinor, ksMajor, ksMinor, ucMajor, ucMinor);
}

int main() {
  printVersions(stderr);

  x86_64 machine;
}
