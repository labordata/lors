import sys

import pandas
from statadict import parse_stata_dict


stata_dict = parse_stata_dict(file=sys.argv[2])
with open(sys.argv[1], encoding='windows-1252') as f:
    data = pandas.read_fwf(f,
                           names=stata_dict.names,
                           colspecs=stata_dict.colspecs)

data.to_csv(sys.stdout)
