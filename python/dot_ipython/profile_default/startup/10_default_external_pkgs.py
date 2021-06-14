import importlib
import sys
from collections import namedtuple


Package = namedtuple('Package', ['name', 'alias', 'pip_name'])
Package.__new__.__defaults__ = (None,) * len(Package._fields)

if sys.version_info < (3,0):
   import subprocess
   PY3 = False
   ModuleNotFoundError = ImportError
else:
   PY3 = True

packages = [
    Package('numpy', alias='np'),
    Package('scipy'),
    Package('matplotlib.pyplot', alias='plt', pip_name='matplotlib'),
]

for pkg in packages:
    try:
        vars()[pkg.alias or pkg.name] = importlib.import_module(pkg.name)
    except ModuleNotFoundError:
        print("Could not find '{}', installing".format(pkg))
        if PY3:
            magic_cmd = u"%pip install {}".format(pkg.pip_name or pkg.name)
            get_ipython().magic(magic_cmd)
        else:
            subprocess.check_call([sys.executable, "-m", "pip", "install", pkg.pip_name or pkg.name])
        vars()[pkg.alias or pkg.name] = importlib.import_module(pkg.name)

