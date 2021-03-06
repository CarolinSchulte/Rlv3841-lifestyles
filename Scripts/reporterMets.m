clear
clc

%requires reporterMets function from the RAVEN Toolbox
%(DOI:10.1371/journal.pcbi.1006541)

model = readCbModel('iCS1224.mat');

%remove genes associates with DNA, RNA and protein synthesis reactions
rnaSynGenes = {'RL_RS09365', 'RL_RS09205', 'RL_RS09210', 'pRL120319',...
    'RL_RS23765', 'RL_RS17530', 'RL_RS02200', 'RL_RS09180', 'RL_RS17630',...
    'RL_RS00680', 'RL_RS24385'};

dnaSynGenes = {'RL_RS01955', 'RL_RS24365', 'RL_RS24360', 'RL_RS10615',...
    'RL_RS12385', 'RL_RS00060', 'RL_RS12955', 'RL_RS08045', 'RL_RS00850',...
    'RL_RS16960', 'RL_RS00850', 'RL_RS00720', 'RL_RS08965', 'RL_RS08150',...
    'RL_RS12750', 'RL_RS00025', 'RL_RS17560', 'RL_RS09025', 'RL_RS08335'}; 

protSynGenes = {'RL_RS13610', 'RL_RS10595', 'RL_RS08315', 'RL_RS08005',...
    'RL_RS21575', 'RL_RS10770', 'RL_RS10775', 'RL_RS10805', 'RL_RS04955',...
    'RL_RS04915', 'RL_RS04650', 'RL_RS24345', 'RL_RS21580', 'RL_RS12740',...
    'RL_RS02255', 'RL_RS01415', 'RL_RS01410', 'RL_RS08940', 'RL_RS10635',...
    'RL_RS13025', 'RL_RS13340', 'RL_RS15565', 'RL_RS10560', 'RL_RS21575',...
    'RL_RS04590', 'RL_RS02090', 'RL_RS00565', 'RL_RS09240', 'RL_RS09360',...
    'RL_RS09220', 'RL_RS09355', 'RL_RS09310', 'RL_RS00650', 'RL_RS23435',...
    'RL_RS09290', 'RL_RS09265', 'RL_RS11505', 'RL_RS01950', 'RL_RS21300',...
    'RL_RS09275', 'RL_RS13550', 'RL_RS09330', 'RL_RS09225', 'RL_RS09315',...
    'RL_RS08675', 'RL_RS09190', 'RL_RS09195', 'RL_RS09185', 'RL_RS08680',...
    'RL_RS09295', 'RL_RS09340', 'RL_RS09280', 'RL_RS09370', 'RL_RS09325',...
    'RL_RS09260', 'RL_RS01405', 'RL_RS24065', 'RL_RS09270', 'RL_RS09255',...
    'RL_RS09300', 'RL_RS24070', 'RL_RS09285', 'RL_RS09245', 'RL_RS09335',...
    'RL_RS20730', 'RL_RS09005', 'RL_RS01400', 'RL_RS09250', 'RL_RS09305',...
    'RL_RS09320', 'RL_RS09200', 'RL_RS11510', 'RL_RS09235', 'RL_RS09160',...
    'RL_RS09230', 'RL0266', 'RL_RS00670'};

biomassGenes = {'RL_RS00855', 'RL_RS11600', 'RL_RS16990', 'RL_RS20455',...
    'RL_RS16995', 'RL_RS17035', 'RL_RS23405', 'RL_RS16985', 'RL_RS13230',...
    'RL_RS19415', 'RL_RS04410', 'RL_RS05500', 'RL_RS11520', 'RL_RS00665',...
    'RL_RS00010'};


model = removeGenesFromModel(model,[protSynGenes dnaSynGenes rnaSynGenes biomassGenes]);

plants = {'pea','alfalfa','sugarbeet'};

%microarray data from DOI:10.1186/gb-2011-12-10-r106

for plant = plants
    MA_ID = strcat('Data/MA_rhizosphere_',plant,'.txt'); 
    outfile = char(strcat('Results/reporterMets_',plant,'.csv'));
    [orf,FC,pvalue] = textread(char(MA_ID),'%s%f%f');
    repMets = reporterMetabolites(model,orf,pvalue,true,outfile,FC);
end
