import os
import logging

import riscof.utils as utils
from riscof.pluginTemplate import pluginTemplate

logger = logging.getLogger()

class serv(pluginTemplate):
    __model__ = "serv"
    __version__ = "1.4.0"

    def __init__(self, *args, **kwargs):
        sclass = super().__init__(*args, **kwargs)
        config = kwargs.get('config')
        config_dir = kwargs.get('config_dir')
        if config is None:
            print("Please enter input file paths in configuration.")
            raise SystemExit(1)
        self.pluginpath=os.path.join(config_dir, config['pluginpath'])
        self.isa_spec = os.path.join(config_dir, config['ispec'])
        self.platform_spec = os.path.join(config_dir, config['pspec'])
        if 'target_run' in config and config['target_run']=='0':
            self.target_run = False
        else:
            self.target_run = True
        return sclass

    def initialise(self, suite, work_dir, archtest_env):
       self.work_dir = work_dir
       self.suite_dir = suite
       self.compile_cmd = 'riscv64-unknown-elf-gcc -march={0} \
         -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -g\
         -T '+self.pluginpath+'/env/link.ld\
         -I '+self.pluginpath+'/env/\
         -I ' + archtest_env + ' {1} -o {2} {3}'

       add_mdu = 'fusesoc library add mdu https://github.com/zeeshanrafique23/mdu'
       utils.shellCommand(add_mdu).run()

       build_serv = 'fusesoc run --target=verilator_tb --flag=mdu\
         --build --work-root=servant_test award-winning:serv:servant\
         --memsize=8388608 --compressed=1'
       utils.shellCommand(build_serv).run()

    def build(self, isa_yaml, platform_yaml):
      ispec = utils.load_yaml(isa_yaml)['hart0']
      self.xlen = ('64' if 64 in ispec['supported_xlen'] else '32')
      self.isa = 'rv' + self.xlen
      if "I" in ispec["ISA"]:
          self.isa += 'i'
      if "M" in ispec["ISA"]:
          self.isa += 'm'
      if "C" in ispec["ISA"]:
          self.isa += 'c'
      self.compile_cmd = self.compile_cmd+' -mabi='+('lp64 ' if 64 in ispec['supported_xlen'] else 'ilp32 ')

    def runTests(self, testList):
      for testentry in testList.values():
          test = testentry['test_path']
          test_dir = testentry['work_dir']
          file_name = os.path.basename(test)[:-2]

          elf = file_name+'.elf'
          compile_macros= ' -D' + " -D".join(testentry['macros'])
          marchstr = testentry['isa'].lower()

          compile_run = self.compile_cmd.format(marchstr, test, elf, compile_macros)
          utils.shellCommand(compile_run).run(cwd=test_dir)

          objcopy_run = f'riscv64-unknown-elf-objcopy -O binary {elf} {file_name}.bin'
          utils.shellCommand(objcopy_run).run(cwd=test_dir)

          self.makehex(f"{test_dir}/{file_name}.bin", f"{test_dir}/{file_name}.hex")

          #The behavior of --build-root in FuseSoC has changed since version 2.2.1
          #Check first for executable model in the new location and else fall back
          #to the old one
          exe = 'servant_test/Vservant_sim'
          
          sigdump_run = [exe,
                         "+timeout=1000000000",
                         f"+signature={test_dir}/DUT-serv.signature",
                         f"+firmware={test_dir}/{file_name}.hex"]

          utils.shellCommand(' '.join(sigdump_run)).run()
      if not self.target_run:
          raise SystemExit

    def makehex(self, binfile, hexfile):
        with open(binfile, "rb") as f, open(hexfile, "w") as fout:
            cnt = 3
            s = ["00"]*4
            while True:
                data = f.read(1)
                if not data:
                    fout.write(''.join(s)+'\n')
                    return
                s[cnt] = "{:02X}".format(data[0])
                if cnt == 0:
                    fout.write(''.join(s)+'\n')
                    s = ["00"]*4
                    cnt = 4
                cnt -= 1
