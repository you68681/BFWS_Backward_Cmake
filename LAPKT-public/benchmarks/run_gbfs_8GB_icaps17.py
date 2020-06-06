# python run_trapper.py benchmark_csv ecai12 results_folder
#
# python run_trapper.py benchmark brfs_trap trapper-domains results
# python run_trapper.py benchmark brfs_stats trapper-domains results
# python run_trapper.py benchmark brfs trapper-domains results
#
# python run_trapper.py compare results_lmcut,results_brfs,brfs_trap-2G/results_brfs_trap_a2,brfs_trap-2G/results_brfs_trap_a1 trapper-domains
#
# python run_trapper.py compare results_brfs,brfs_trap-2G/results_brfs_trap_a2,brfs_trap-2G/results_brfs_trap_a1 trapper-domains
#
# python run_trapper.py compare brfs_stats/results_brfs_stats_a1,brfs_stats/results_brfs_stats_a2,brfs_stats/results_brfs_stats_a3,brfs_stats/results_brfs_stats_h1,brfs_stats/results_brfs_stats_h2 trapper-domains
#
# ########################
#
# Prerequisites:
#   - valgrind
#   - timeout
#   - dot (graphviz)
#   - krtoolkit
#
# For the best results with profiling, compile with the following:
#   scons -Q debug=1
#


from os import system as cmd
from sys import argv
import glob, os, sys, re
from math import log10
import math
from domains import *
import matplotlib.pyplot as plt
from matplotlib import pyplot



USAGE = """
 Usage:
    python run.py profile <executable> <ipc directory> [<domain pddl> <problem pddl>]
    python run.py benchmark <executable> <ipc directory> <results directory> [<domain>]
    python run.py compare <directories with , separated> <ipc directory> <plot/latex/none/portfolio/portfolio-plot>
    python run.py clean
    """

# Set the time limit (in seconds)

timelimit = 1800
memorylimit = 1000

cores = 7 # Only used for the benchmarking

OLD = 1
NEW = 2

# Set the style of planner you are using
TYPE = OLD

benchmark = None
domains = None
ipc = None
results_directory = "results"

def profile_domain(planner, dom, domain, problem):

    print
    print "Profiling %s..." % dom

    if TYPE == OLD:
        cmd("timeout %d valgrind --tool=callgrind %s --domain %s/%s --problem %s/%s > %s.out 2>&1" % (timelimit, planner, ipc, domain, ipc, problem, dom))
    elif TYPE == NEW:
        cmd("timeout %d valgrind --tool=callgrind %s %s/%s %s/%s /dev/null > %s.out 2>&1" % (timelimit, planner, ipc, domain, ipc, problem, dom))
    else:
        assert False, "What the deuce?"

    callfile=glob.glob('callgrind.out.*')[0]
    cmd("python gprof2dot.py -f callgrind %s 2> /dev/null | dot -Tpng -o %s.png > /dev/null 2>&1" % (callfile, dom))
    cmd("rm %s" % callfile)
    

def benchmark_domain(planner, dom, extra_args, lmcut=False):
    
    from krrt.utils import get_value, match_value, run_experiment, write_file, get_lines
    
    print "Benchmarking %s..." % dom

    global ipc
    if (lmcut or ('lama' in planner) or ('mercury' in planner) or ('jasper' in planner) ) and '../' != ipc[:3]:
        ipc = '../' + ipc
    
    if TYPE == OLD:
        domprob_args = [" %s --domain %s/%s/%s --problem %s/%s/%s" % (extra_args,ipc,dom,domain,ipc,dom,problem) for (domain, problem) in benchmark[dom]]
    elif TYPE == NEW:
        #domprob_args = ["%s/%s/%s %s/%s/%s o/dev/null" % (ipc,dom,domain,ipc,dom,problem) for (domain, problem) in benchmark[dom]]
        domprob_args = ["%s/%s/%s %s/%s/%s %s" % (ipc,dom,domain,ipc,dom,problem,extra_args) for (domain, problem) in benchmark[dom]]
    else:
        assert False, "What the deuce?"


    if os.path.exists(results_directory) is False:
        os.mkdir(results_directory)
    sand = None

    if lmcut:
        sand = 'lmcut-'+dom

    if 'lama' in planner:
        sand = 'lama-'+dom

    if 'jasper' in planner:
        sand = 'jasper-'+dom

    if 'mercury' in planner:
        sand = 'mercury-'+dom
        
    results = run_experiment(base_directory=".",
                             base_command=planner,
                             single_arguments={'domprob': domprob_args},
                             time_limit=timelimit,
                             memory_limit=memorylimit,
                             results_dir=results_directory,
                             progress_file=None,
                             processors=cores,
                             clean_sandbox=True,
                             sandbox=sand)
    
    data = []
    for resid in results.get_ids():

        res = results[resid]


        if lmcut or 'lama' in planner or 'jasper' in planner or 'mercury' in planner:
            prob = res.single_args['domprob'].split()[1].split('/')[-1]
        elif TYPE == OLD:
            prob = res.single_args['domprob'].split(' ')[-1].split('/')[-1]
        elif TYPE == NEW:
            prob = res.single_args['domprob'].split(' ')[-4].split('/')[-1]
        else:
            assert False, "What the deuce?"

        
        if 'old-' in planner:
            cmd("tail -26 %s > TMP_OUTPUT" % res.output_file)
            outfile = "TMP_OUTPUT"
        else:
            outfile = res.output_file

        os.system("cp %s %s"%(outfile, outfile+dom))

        
        if res.timed_out:
            data.append("%s,time,-1,-1,-1,-1" % prob)
        elif match_value("%s.err" % res.output_file, '.*std::bad_alloc.*'):
            data.append("%s,mem,-1,-1,-1,-1" % prob)
        elif match_value("%s.err" % res.output_file, '.*MemoryError.*'):
            data.append("%s,mem,-1,-1,-1,-1" % prob)
        elif match_value("%s.err" % res.output_file, '.*cannot allocate memory.*'):
            data.append("%s,mem,-1,-1,-1,-1" % prob)
        elif match_value("%s.err" % res.output_file, '.*Segmentation fault.*'):
            data.append("%s,seg,-1,-1,-1,-1" % prob)
        elif match_value("%s.err" % res.output_file, '.*This configuration does not support axioms.*'):
            data.append("%s,ax,-1,-1,-1,-1" % prob)
        else:
            if match_value(outfile, '.*Plan found with cost: ([0-9]+).*'):
                quality = get_value(outfile, '.*Plan found with cost: ([0-9]+).*', int)
                generated = get_value(outfile, '.*Nodes generated during search: ([0-9]+).*', int)
                expanded = get_value(outfile, '.*Nodes expanded during search: ([0-9]+).*', int)
                data.append("%s,ok,%.2f,%d,%d,%d" % (prob, res.runtime, quality, generated, expanded))
            elif match_value(outfile, '.*Plan found with cost: NOTFOUND'):
                quality = get_value(outfile, '.*Plan found with cost: ([0-9]+).*', int)
                generated = get_value(outfile, '.*Nodes generated during search: ([0-9]+).*', int)
                expanded = get_value(outfile, '.*Nodes expanded during search: ([0-9]+).*', int)
                data.append("%s,nosol,%.2f,%d,%d,%d" % (prob, res.runtime, quality, generated, expanded))            
            elif match_value(outfile, '.*Plan length: ([0-9]+).*'):
                quality = get_value(outfile, '.*Plan length: ([0-9]+).* step\(s\)\.', int)
                generated = get_value(outfile, '.*Generated ([0-9]+).* state\(s\)\.', int)
                expanded = get_value(outfile, '.*Expanded ([0-9]+).* state\(s\)\.', int)
                data.append("%s,ok,%.2f,%d,%d,%d" % (prob, res.runtime, quality, generated, expanded))            

            else :
                print "Error with %s" % prob
                data.append("%s,err,%.2f,-1,-1,-1" % (prob, res.runtime))

        if 'old-' in planner:
            cmd("rm TMP_OUTPUT")

    data.sort()
    header = ['problem,status,runtime,quality,generated,expanded']
    data = header + data
    
    
    write_file("%s/%s.csv" %( results_directory, dom), data)
    
    #cmd("rm -rf %s"%results_directoy)

def get_string(file_text, regex):
    """ Lifts a value from a file based on a regex passed in. """

    # Get the text of the time
    left,sep,right = file_text.partition(regex)
    if sep: # True iff 'Figure' in line
        return right.split('\n')[0]

def match_value_local(file_text, regex):
    """ Checks if the regex matches the contents of a specified file. """

    # Get the text of the time
    pattern = re.compile(regex, re.MULTILINE)
    if pattern.search(file_text):
        return True
    else:
        return False


def benchmark_domain_csv( dom ):
    
    from krrt.utils import get_value, match_value, write_file
    print "Benchmarking %s..." % dom

    global ipc
   
    if os.path.exists(results_directory) is False:
        return false
    
    sand = None

    
    data = []

    
    results = glob.glob(results_directory+"/*"+dom)

    for filename in results:
        
        f = open(filename, 'r')
        file_text = "\n".join(f.readlines())
        f.close()

        ## Only happens when FF simplifies goal to False in Mistery 3 problems
        if get_string(file_text, 'Problem: ') is None: continue
        
        prob = get_string(file_text, 'Problem: ')
        prob += "_a" + get_string(file_text, '#Actions: ')
        prob += "_f" + get_string(file_text, '#Fluents: ')

        print filename
        if match_value_local(file_text, '.*Plan found with cost: ([0-9]+).*'):
            runtime = get_value(filename, '.*Total time: -?([0-9]+\.[0-9]+).*', float)
            quality = get_value(filename, '.*Plan found with cost: ([0-9]+).*', int)
            generated = get_value(filename, '.*Nodes generated during search: ([0-9]+).*', int)
            expanded = get_value(filename, '.*Nodes expanded during search: ([0-9]+).*', int)
            data.append("%s,ok,%.2f,%d,%d,%d" % (prob, runtime, quality, generated, expanded))            
        else:
            print "Error with %s" % prob
            data.append("%s,err,%.2f,-1,-1,-1" % (prob, -1))


    data.sort()
    header = ['problem,status,runtime,quality,generated,expanded']
    data = header + data
    
    
    write_file("%s/%s.csv" %( results_directory, dom), data)
    
    #cmd("rm -rf %s"%results_directoy)
    
def compare_results(dirs, latex = False, plot = False, portfolio = False, show=[]):
    
    from krrt.utils import load_CSV
    print
    print "Comparing results for %s..." % (dirs)

    if len(show) == 0:
        show = range(len(dirs))
        if portfolio is True:
            show.append(len(dirs))
    ldirs = len(dirs)
    ptf1 = [0,2]
    ptf2 = [0,2]
    #ptf1 = [0,2,3]
    #ptf2 = [0,4,5]
    if portfolio is True:
        ldirs+=2
        #ldirs+=1
        pname1 = "PORTFOLIO-1,2,2-C"
        pname2 = "PORTFOLIO-1,2-M,2-M-C"
        # for i, name in enumerate(dirs):
        #     if i == 0: continue
        #     pname += name.split('results_8GB_')[-1]
        
        print pname1,pname2
        
    cum_time = [0] * ldirs
    for i in range(ldirs):
        cum_time[i] = [0] * timelimit
    num_problems = [0] * ldirs
    coverage = [0] * ldirs
    time_better = [0] * ldirs
    time_score = [0] * ldirs
    pruned_score = [0] * ldirs
    generated_score = [0] * ldirs
    
    quality_better = [0] * ldirs
    quality_score = [0] * ldirs
    nodes_expanded = [0] * ldirs
    nodes_generated = [0] * ldirs
    nodes_pruned = [0] * ldirs
    time_total = [0] * ldirs
    search_time = [0] * ldirs

    pruned_avg  = [0] * ldirs
    
    baseline = None
    
    for i in range(len(dirs)):
        if dirs[i] == 'results_brfs':
            baseline = i
            break
    for dom in sorted(domains):
        

        data = []
        cov = []
        t_score = [0] * ldirs
        st_score = []
        q_score = [0] * ldirs
        p_score = []
        g_score = [0]  * ldirs
        p_avg = []
        local_num_problems = {}

        un_cov = 0
        for i in range(len(dirs)):
            direc = dirs[i]
            data.append(load_CSV("%s/%s.csv" % (direc, dom))[1:])
            cov.append(len(filter(lambda x: 'ok' == x[1], data[-1])))
            un_cov = len(filter(lambda x: 'ok' != x[1], data[-1]))
            #Only solved within 900 sec
            # cov.append(len(filter(lambda x: ('ok' == x[1] and float(x[2]) <= 900.0), data[-1])))
            # un_cov = len(filter(lambda x: 'ok' != x[1] or float(x[2]) > 900.0, data[-1]))
            
            coverage[i] += cov[-1]
            num_problems[i] += cov[-1] + un_cov
        local_num_problems[dom] = cov[-1] + un_cov

        shared_data = []
        
        for prob in zip(*data):
            if 0 != len(filter(lambda x: 'ok' == x[1], prob)):                
                for x in prob:
                    if x[1] != 'ok' and x[1] != 'nosol' :
                        x[2] = sys.maxint
                    if x[1] != 'ok' and x[1] != 'nosol':
                        x[3] = sys.maxint
                
                shared_data.append(list(prob))

        #portfolio with folders 1..n
        if portfolio:
            # tlimit = timelimit / (len(dirs) - 1) 
            # cov_portfolio = 0
            # for x in shared_data:
            #     solved = False
            #     tsum = 0.0
            #     qual = 0
            #     exp = 0
            #     gen = 0
            #     for i in range(1,len(dirs)):
            #         if  x[i][1] != 'ok' and float(x[i][2]) > tlimit:
            #             tsum += tlimit
            #             continue
            #         tsum += float(x[i][2])
            #         exp += int(x[i][4])
            #         gen += int(x[i][5])
            #         if x[i][1] == 'ok':
            #             solved = True
            #             qual = x[i][3]
            #             break
            #     if solved is True:
            #         if tsum < timelimit:
            #             cov_portfolio+=1
            #             x.append( [x[0][0], 'ok', tsum, qual, exp, gen] )
            #         else:
            #             x.append( [x[0][0], 'time', sys.maxint , qual, exp, gen] )
            #             print x,tsum
            #     elif tsum < timelimit:
            #         x.append( [x[0][0], 'nosol', tsum , qual, exp, gen] )
            #     else:
            #         x.append( [x[0][0], 'time', sys.maxint , qual, exp, gen] )                 
            #     #print x
            # cov.append( cov_portfolio )
            # coverage[len(dirs)] += cov_portfolio

            tlimit = timelimit / (len(ptf1)) 
            cov_portfolio = 0
            for x in shared_data:
                solved = False
                tsum = 0.0
                qual = 0
                exp = 0
                gen = 0
                for i in ptf1:
                    if  x[i][1] != 'ok' and float(x[i][2]) > tlimit:
                        tsum += tlimit
                        continue
                    tsum += float(x[i][2])
                    exp += int(x[i][4])
                    gen += int(x[i][5])
                    if x[i][1] == 'ok':
                        solved = True
                        qual = x[i][3]
                        break
                if solved is True:
                    if tsum < timelimit:
                        cov_portfolio+=1
                        x.append( [x[0][0], 'ok', tsum, qual, exp, gen] )
                    else:
                        x.append( [x[0][0], 'time', sys.maxint , qual, exp, gen] )
                        #print x,tsum
                elif tsum < timelimit:
                    x.append( [x[0][0], 'nosol', tsum , qual, exp, gen] )
                else:
                    x.append( [x[0][0], 'time', sys.maxint , qual, exp, gen] )                 
                #print x
            
            cov.append( cov_portfolio )
            coverage[len(dirs)] += cov_portfolio

            tlimit = timelimit / (len(ptf2))
            #tlimit = [100,0,0,0,500,1200]
            cov_portfolio = 0
            for x in shared_data:
                #if  x[0][1] != 'ok' and  x[0][1] != 'nosol': print x[0]
                solved = False
                tsum = 0.0
                qual = 0
                exp = 0
                gen = 0
                for i in ptf2:
                    if  x[i][1] != 'ok' and float(x[i][2]) > tlimit:
                        tsum += tlimit
                        continue
                    tsum += float(x[i][2])
                    exp += int(x[i][4])
                    gen += int(x[i][5])
                    if x[i][1] == 'ok':
                        solved = True
                        qual = x[i][3]
                        break
                if solved is True:
                    if tsum < timelimit:
                        cov_portfolio+=1
                        x.append( [x[0][0], 'ok', tsum, qual, exp, gen] )
                    else:
                        x.append( [x[0][0], 'time', sys.maxint , qual, exp, gen] )
                        #print x,tsum
                elif tsum < timelimit:
                    x.append( [x[0][0], 'nosol', tsum , qual, exp, gen] )
                else:
                    x.append( [x[0][0], 'time', sys.maxint , qual, exp, gen] )                 
                #print x


            cov.append( cov_portfolio )
            coverage[len(dirs)+1] += cov_portfolio


        #for the Cumulative time count
        for i in show:            
            for x in shared_data:
                if x[i][1] != 'ok': continue
                #if x[i][1] != 'nosol': continue
                #if x[i][1] != 'nosol' and x[i][1] != 'ok' : continue
                t = int(math.floor(float(x[i][2])))
                cum_time[i][t] += 1
                    
            
        for i in show:
            tsum = 0
            common_solved = 0
                            
            for x in shared_data:
                if x[i][1] != 'ok': continue
                all_solve = True
                for j in range(len(x)):
                    if x[j][1] != 'ok':
                        all_solve = False
                        break
                t = float(x[i][2])
                if all_solve is False: continue
                common_solved+=1
                tsum += t
                    
            if common_solved > 0:
                t_score[i]=(tsum / common_solved )
            else:
                t_score[i] = 0 
             
            time_score[i] += t_score[i]

        for i in show:
            qsum = 0
            common_solved = 0
                            
            for x in shared_data:
                if x[i][1] != 'ok': continue
                all_solve = True
                for j in range(len(x)):
                    if x[j][1] != 'ok':
                        all_solve = False
                        break
                t = float(x[i][3])
                if all_solve is False: continue
                common_solved+=1
                qsum += t
                    
            if common_solved > 0:
                q_score[i]=qsum / common_solved 
            else:
                q_score[i]=0 
             
            quality_score[i] += q_score[i]     
     
            
        if baseline is None:
            for i in show:
                tsum = 0
                common_solved = 0
                for x in shared_data:
                    if x[i][1] != 'ok': continue                    

                    all_solve = True
                    for j in range(len(x)):
                        if x[j][1] != 'ok':
                            all_solve = False
                            break


                    t = float(x[i][4])

                    if all_solve is False: continue
                    common_solved+=1
                    tsum += t

                if common_solved > 0:
                    g_score[i] = tsum / common_solved
                else:
                    g_score[i]= 0

                generated_score[i] += g_score[i]
        else:
            #Generated Reduction percentage
            for i in show:
                tsum = 0
                total_solved = 0
                baseline_generated = 0.0
                xgen = 0.0
                for x in shared_data:

                    if x[baseline][1] != 'ok': continue                    
                    if x[i][1] != 'ok': continue
                    total_solved+=1

                    baseline_generated += float(x[baseline][4])
                    xgen += float(x[i][4])

                if xgen == 0:
                    g_score.append( 1 )
                else:
                    g_score.append( baseline_generated / xgen )

                generated_score[i] += g_score[i]


        #n_gen_1 = sum([int(x[0][4]) for x in shared_data])
        #n_gen_2 = sum([int(x[1][4]) for x in shared_data])
        #nodes_generated[0] += n_gen_1
        #nodes_generated[1] += n_gen_2

        #n_exp_1 = sum([int(x[0][5]) for x in shared_data])
        #n_exp_2 = sum([int(x[1][5]) for x in shared_data])
        #nodes_expanded[0] += n_exp_1
        #nodes_expanded[1] += n_exp_2

        #time_1 = sum([float(x[0][2]) for x in shared_data])
        #time_2 = sum([float(x[1][2]) for x in shared_data])
        #time_total[0] += time_1
        #time_total[1] += time_2
        if latex is True:
            info = "%s (%d)&"%(dom,local_num_problems[dom])
            max = 0
            for i in show:
                if cov[i] > max:
                    max = cov[i]
            for i in show:
                if cov[i] == max:
                    info += " \\textbf{{\\color{red} %d }} &"%cov[i]
                else:
                    info += " %d &"%cov[i]
                #info += " %.2f &"%(t_score[i])
                #info += " %.2f &"%(q_score[i])

            info = info[:-1]+"\\\\"
            print info
        else:
            print "\nDomain: %s" % dom
            print "Coverage: %s" % ' -vs- '.join(["%d" % cov[i] for i in show])        
            print "Avg Time: %s" % ' -vs- '.join(["%.2f" % t_score[i] for i in show])
            print "Avg Quality: %s" % ' -vs- '.join(["%.2f" % q_score[i] for i in show])
        
            if g_score[0] > 0:
                print "Avg Generated Factor: %s" % ' -vs- '.join(["%.2f" % (t/g_score[0]) for t in g_score])
       
    if latex is True:
        info = "Total Coverage (%d) & "%num_problems[0]
        for i in show:
            #info += " %d &"%coverage[i]
            info += " %d &"%coverage[i]
            #info += " %.0f "%(quality_score[i]/ len(quality_score))
            #info += " (%.0f) &"%(time_score[i]/ len(time_score))
            # info += " %d &"%coverage[i]
            # info += " %.2f &"%(time_score[i])
            # info += " %.2f &"%(quality_score[i])
        info = info[:-1]+"\\\\"
        print info
        
        info = "Average Time &"
        for i in show:
            info += " %.0f &"%(time_score[i]/ len(time_score))
        info = info[:-1]+"\\\\"
        print info
        
        info = "Average Quality &"
        for i in show:
            info += " %.0f &"%(quality_score[i]/ len(quality_score))

        info = info[:-1]+"\\\\"
        print info
        
    else:
        print "\nDomain: all %d"%(num_problems[0])
        print "Coverage: %s" % ' -vs- '.join(["%d" % coverage[i] for i in show])
        print "Avg Time: %s" % ' -vs- '.join(["%.2f" % (time_score[i] / len(time_score)) for i in show])
        print "Avg Quality: %s" % ' -vs- '.join(["%.2f" % (quality_score[i] / len(quality_score)) for i in show])
        
        #print "Avg Generated Factor: %s" % ' -vs- '.join(["%.2f" % (generated_score[i]/generated_score[0]) for i in show])
    if plot is True:
        for i in show:
            for t in range(timelimit-1):
                cum_time[i][t+1] += cum_time[i][t]

        solv_markers = [""] * ldirs
        for i, name in enumerate(dirs):
            solv_markers[i] = name.split('results_8GB_')[-1]

        if portfolio is True:
            #solv_markers[ ldirs-1 ] = "PORTFOLIO" + "-".join( name for name in solv_markers[1:] )
            solv_markers[ ldirs-2 ] = pname1
            solv_markers[ ldirs-1 ] = pname2
        cactus(cum_time, solv_markers, show)
    
def cactus(data, solv_markers, show):
    plt.figure(num=1, figsize=(3,4))
    markers = ('o', 'v', '^', '<', '>', '8', 's', 'p', '*', 'h', 'H', 'D', 'd','5','6')
    colors_used = 0
    for i, s in enumerate(solv_markers):
        if i not in show: continue
        ys = list()
        xs = list()
        
        for x, t in enumerate(sorted(data[i])):
            xs.append(x+0.1)
            ys.append(t)
        # for t in range(10):
        #     xs.append(t)
        #     ys.append(int(t/3))

        z_color = [ 'b', 'r', 'g',  '#808080', 'orange', 'y', 'k',  'm', 'c', 'darkgoldenrod','firebrick','pink']
        plt.scatter(xs, ys, c=z_color[colors_used],marker="+", label=s) #markers[i]
        plt.plot(xs, ys , c=z_color[colors_used])
        colors_used+=1
    plt.xscale('log')
    plt.ylabel('Cum. inst. solved')
#    plt.ylabel('Cum. inst. solved and failed')
#    plt.ylabel('Cum. failed')
    plt.xlabel('Time (s)')
    plt.axes().set_xlim(0.1, 1800 )
    plt.axes().set_ylim(0, 280)
#    plt.axes().set_ylim(0, 400)
#    plt.axes().set_ylim(0, 1600)

    plt.axes().grid(b=True, linestyle='-', color='0.75')
    #plt.axes().legend(loc=2)
    plt.axes().legend(loc=3)
    plt.show()
    fig = plt.gcf()
    fig.set_size_inches(3, 4, forward=True)
    fig.savefig('cactus.pgf')


if 1 == len(argv):
    print USAGE
    os._exit(1)

if 'profile' == argv[1]:
    if len(argv) < 4:
        print USAGE
        os._exit(1)
    
    if 'ipc-2006' == argv[3]:
        benchmark = benchmark_06
        domains = domains_06
        profile_problems = profile_problems_06
    elif 'ipc-2011' == argv[3]:
        benchmark = benchmark_11
        domains = domains_11
        profile_problems = profile_problems_11
    else:
        print "Invalid benchmark set: %s" % argv[3]
        os._exit(1)

    ipc = argv[3]

    if len(argv) < 5:
        for (dom, domain, problem) in profile_problems:
            profile_domain(argv[2], dom, domain, problem)
        
    else:
        profile_domain(argv[2], 'custom', argv[4], argv[5])


elif 'benchmark' == argv[1]:
    
    if len(argv) < 5:
        print USAGE
        os._exit(1)

    if 'ipc-2006' == argv[3]:
        benchmark = benchmark_06
        domains = domains_06
        profile_problems = profile_problems_06
    elif 'ipc-2011' == argv[3]:
        benchmark = benchmark_11
        domains = domains_11
        profile_problems = profile_problems_11
    elif 'ipc-2014/seq-sat' == argv[3]:
        benchmark = benchmark_14_sat
        domains = domains_14_sat
        profile_problems = profile_problems_14
    elif 'ipc-2014/seq-agl' == argv[3]:
        benchmark = benchmark_14_agl
        domains = domains_14_agl
        profile_problems = profile_problems_14
    elif 'ecai12' == argv[3]:
        benchmark = benchmark_ecai12
        domains = domains_ecai12
        profile_problems = profile_problems_14
    
    original_results_directory = argv[4]
    ipc = argv[3]

    if len(argv) < 6:
        
        if argv[2] == 'gbfs_hadd':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hadd --ignore_novelty true')
        ## CHAO
        elif argv[2] == 'backward_BFWS':
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('/home/chao/BFWS_Backward_Cmake/cmake-build-release/bfws', dom, '--max_novelty 2 --k-BFWS true')

        elif argv[2] == 'gbfs_hadd_local':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hadd_local --ignore_novelty true')
        elif argv[2] == 'gbfs_mix_novel':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic mix --ignore_novelty false')
        elif argv[2] == 'gbfs_mix':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic mix --ignore_novelty true')
        elif argv[2] == 'gbfs_alternate_novel':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic alternate --ignore_novelty false')
        elif argv[2] == 'gbfs_alternate':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic alternate --ignore_novelty true')
        elif  argv[2] == 'gbfs_hadd_novel':            
                results_directory = argv[4]                
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hadd --ignore_novelty false')
        elif  argv[2] == 'gbfs_hadd_novel_last':            
                results_directory = argv[4]                
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hadd --ignore_novelty false --novelty_last true')
        elif argv[2] == 'gbfs_hff':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hff --ignore_novelty true')
        elif argv[2] == 'gbfs_hff_local':
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hff_local --ignore_novelty true')
        elif argv[2] == 'gbfs_hadd_local_alberta':
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hadd_local --ignore_novelty true --ignore_local_novelty true')
        elif argv[2] == 'gbfs_hff_local_alberta':
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hff_local --ignore_novelty true --ignore_local_novelty true')
        elif  argv[2] == 'gbfs_hff_novel':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hff --ignore_novelty false')
        elif  argv[2] == 'gbfs_hff_novel_last':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f2', dom, '--heuristic hff --ignore_novelty false  --novelty_last true')
        elif  argv[2] == 'bfs_f':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f', dom, '')
        elif  argv[2] == 'siw_then_bfs_f':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./siw-then-bfsf', dom, '')
        elif  argv[2] == 'dfs_plus':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./dfs_plus', dom, '')
        elif  argv[2] == 'bfs_f_exp':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f_exp', dom, '')
        elif  argv[2] == 'bfs_f_exp_fast_preference_land':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f_exp', dom, ' --fast-exploration-novel-land 1')
        elif  argv[2] == 'bfs_f_exp_fast_preference':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f_exp', dom, ' --fast-exploration-novel 1')
        elif  argv[2] == 'bfs_f_exp_fast_complete':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f_exp', dom, ' --fast-complete 1')
        elif  argv[2] == 'bfs_f_exp_fast':           
                results_directory = argv[4]
                for dom in domains:
                    benchmark_domain('./bfs_f_exp', dom, ' --fast 1')
        elif  argv[2] == 'lama':           
                results_directory = argv[4]
                TYPE = NEW                
                for dom in domains:
                    benchmark_domain('../../../Fast-Downward/src/lama-agl', dom, ' tmp.log')
                TYPE = OLD
        elif  argv[2] == 'jasper':           
                results_directory = argv[4]
                TYPE = NEW         
                for dom in domains:
                    benchmark_domain('../../../seq-agl-jasper/plan-ipc seq-agl-jasper', dom, ' tmp.log')
                TYPE = OLD
        elif  argv[2] == 'mercury':           
                results_directory = argv[4]
                TYPE = NEW                
                for dom in domains:
                    benchmark_domain('../../../seq-agl-mercury/plan', dom, ' tmp.log')
                TYPE = OLD
        else:
            for dom in domains:
                results_directory = argv[4]+"_"+argv[2]
                benchmark_domain(argv[2], dom)
            
    else:
        benchmark_domain(argv[2], argv[5])

elif 'benchmark_csv' == argv[1]:


    if len(argv) < 4:
        print USAGE
        os._exit(1)

    if 'ipc-2006' == argv[2]:
        benchmark = benchmark_06
        domains = domains_06
        profile_problems = profile_problems_06
    elif 'ipc-2011' == argv[2]:
        benchmark = benchmark_11
        domains = domains_11
        profile_problems = profile_problems_11
    elif 'ipc-2014/seq-sat' == argv[2]:
        benchmark = benchmark_14_sat
        domains = domains_14_sat
        profile_problems = profile_problems_14
    elif 'ipc-2014/seq-agl' == argv[2]:
        benchmark = benchmark_14_agl
        domains = domains_14_agl
        profile_problems = profile_problems_14
    elif 'ecai12' == argv[2]:
        benchmark = benchmark_ecai12
        domains = domains_ecai12
        profile_problems = profile_problems_14
    elif 'all-ipc' == argv[3]:
        benchmark = benchmark_allipc
        domains = domains_allipc
        profile_problems = profile_problems_14
        
    original_results_directory = argv[3]
    ipc = argv[2]
        
    if len(argv) < 5:
        results_directory = argv[3]
        for dom in domains:
            benchmark_domain_csv( dom )
        
        

elif 'compare' == argv[1]:

    if 'ipc-2006' == argv[3]:
        benchmark = benchmark_06
        domains = domains_06
        profile_problems = profile_problems_06
    elif 'ipc-2011' == argv[3]:
        benchmark = benchmark_11
        domains = domains_11
        profile_problems = profile_problems_11
    elif 'ipc-2014/seq-sat' == argv[3]:
        benchmark = benchmark_14_sat
        domains = domains_14_sat
        profile_problems = profile_problems_14
    elif 'ipc-2014/seq-agl' == argv[3]:
        benchmark = benchmark_14_agl
        domains = domains_14_agl
        profile_problems = profile_problems_14
    elif 'ecai12' == argv[3]:
        benchmark = benchmark_ecai12
        domains = domains_ecai12
        profile_problems = profile_problems_14
    elif 'all-ipc' == argv[3]:
        benchmark = benchmark_allipc
        domains = domains_allipc
        profile_problems = profile_problems_14
    elif 'all-ipc-adl' == argv[3]:
        benchmark = benchmark_allipcadl
        domains = domains_allipcadl
        profile_problems = profile_problems_14

    else:
        print "Invalid benchmark set: %s" % argv[3]
        os._exit(1)
        
    ipc = argv[3]

    latex = False
    plot = False
    portfolio = False
    if len(argv) >= 5:
        if argv[4] == 'latex':
            latex = True
        if argv[4] == 'plot':
            plot = True
        if argv[4] == 'portfolio':
            portfolio = True
        if argv[4] == 'portfolio-plot':
            portfolio = True
            plot = True
        if argv[4] == 'portfolio-latex':
            portfolio = True
            latex = True

    show = []
    if len(argv) >= 6:
        show = [ int(n) for n in argv[5].split(',')]
    compare_results(argv[2].split(','), latex, plot, portfolio, show)


elif 'clean' == argv[1]:
    cmd('rm -f *.png')
    cmd('rm -f *.out')
    cmd('rm -f *.csv')


else:
    print USAGE
    os._exit(1)

print
