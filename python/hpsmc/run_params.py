import os, sys, json

class RunParameters:

    def __init__(self, json_filename = None):
        if json_filename is None:
            json_filename = os.path.dirname(os.path.realpath(sys.argv[0])) \
                    + "/../../data/run_params.json"
        rawdata = open(json_filename, 'r').read()
        self.json_dict = json.loads(rawdata)

    def get_run_params(self, param_name, key):
        return self.json_dict["run_params"][param_name][key]      

if __name__ == "__main__":

    rp = RunParameters()

    if len(sys.argv) != 3:
        raise Exception("Not enough arguments.\nUSAGE: run_params [param] [key]")

    param_name = sys.argv[1]
    key = sys.argv[2]

    print rp.get_run_params(param_name, key)
