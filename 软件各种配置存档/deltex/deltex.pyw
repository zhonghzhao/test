import os
files = os.listdir('./')
del_suffix = ['toc', 'vrb', 'aux', 'log', 'nav', 'out', 'snm', 'fdb_latexmk','fls','thm','un~','tex~','pre','brf','blg','bbl','idx','ilg','ind','xdv','tex.bak','tex.sav','out.bak','TEX.bak','TEX.sav','org~','#','mw','html~','bcf','xml','dvi']
for file in files:
    for suffix in del_suffix:
        if file.endswith(suffix):
            os.remove(file)