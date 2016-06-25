#include <cinttypes>
#include <cstdint>
#include <cstdio>
#include <cstdlib>

#include <iterator>
#include <string>

#include <capstone/capstone.h>
#include <keystone/keystone.h>
#include <unicorn/unicorn.h>

[[noreturn]] static void Panic(const char *msg) {
  std::fprintf(stderr, "Error: %s\n", msg);
  std::fflush(stderr);
  std::quick_exit(EXIT_FAILURE);
}

struct Disasm {
  static void Ensure(::cs_err code) {
    if (code != CS_ERR_OK)
      Panic(::cs_strerror(code));
  }

  Disasm() { Ensure(::cs_open(CS_ARCH_X86, CS_MODE_64, &Handle)); }
  ~Disasm() { Ensure(::cs_close(&Handle)); }

  template <typename IterT> void operator()(IterT First, IterT Last, std::uint64_t Address) const {
    ::cs_insn *Insn;

    static_assert(sizeof(decltype(&*First)) != 1, "Wrong Type: Byte Required");
    const auto Count = ::cs_disasm(Handle, (const std::uint8_t *)&*First, Last - First, Address, 0, &Insn);

    struct Defer {
      ~Defer() { ::cs_free(Insn, Count); }
      ::cs_insn *Insn;
      std::size_t Count;
    } const _{Insn, Count};

    if (Count == 0)
      Ensure(::cs_errno(Handle));

    for (std::size_t Ix{}; Ix < Count; ++Ix)
      std::printf("0x%" PRIx64 ":\t%s\t\t%s\n", Insn[Ix].address, Insn[Ix].mnemonic, Insn[Ix].op_str);
  }

  template <typename RangeT> void operator()(const RangeT &Range, std::uint64_t Address) const {
    using std::begin;
    using std::end;
    return operator()(begin(Range), end(Range), Address);
  }

  ::csh Handle;
};

int main() {
  const std::string code{"\x48\x31\xc0\xb0\x22\x0f\x05"};

  Disasm disasm;
  disasm(code, 0x1000);
}
