from __future__ import print_function

import vim

class Signal():
    def __init__(self, name, width):
        self.name = name
        self.width = width

        if (width > 1):
            self.s_range = '[%2d:0]' % (width-1)
        else:
            self.s_range = ' ' * 6

    def format(self, fstring):
        dt = dict()
        dt['name'] = self.name
        dt['width'] = str(self.width)
        dt['range'] = self.s_range

        s = fstring.format(**dt)
        return s

class Interface():
    def __init__(self, name):
        self.name = name
        self.ls_signal = list()

    def add_signal(self, name, width):
        sig = Signal(name, width)
        self.ls_signal.append(sig)

    def format(self, fstring, filter_out=None):
        s = ''
        for sig in self.ls_signal:
            if (filter_out is not None) and (sig.name in filter_out):
                continue
            s += sig.format(fstring) + '\n'
        return s

dt_intf = dict()


# APB
apb = Interface('apb')
apb.add_signal('psel', 1)
apb.add_signal('pwakeup', 1)
apb.add_signal('enable', 1)
apb.add_signal('prot', 3)
apb.add_signal('pwrite', 1)
apb.add_signal('paddr', 20)
apb.add_signal('pwdata', 32)
apb.add_signal('prdata', 32)
apb.add_signal('pready', 1)
apb.add_signal('pslverr', 1)

dt_intf[apb.name] = apb


def fmt(intf_name, fstring):
    intf = dt_intf[intf_name]
    s = intf.format(fstring)
    print(s)
    vim.command('let @@ = "%s"' % s)

def apb_def():
    fmt('apb', 'logic {range} {name};')

def apb_port():
    fmt('apb', '.{name}({name}),')
