%% Script: Main processing routine for the FLOXBOX 
%   INPUT:
%   hierarchy_id        : hierarchy_id of the SPECCHIO DN hierarchy
%   Java class path     : \MATLAB\R2019a\toolbox\local\classpath.txt -->
%                         make sure to include your specchio installation (specchio-client.jar)
%                         at the top of the classpath.txt
%
%   db_connector_id     : index into the list of known database connection (identical to SPECCHIO client app)
% 
%   OUTPUT:
%   Processing raw (Level-0) FLOXBOX data to Radiance (Level-1) and
%   Reflectance (Level-2)
%   
%   MISC:   
%   The FLOXBOX has two sensors: (1) is the FLAME (in these files sometimes called ROX), full range sensor, files
%   are named F*.csv; (2) is the QEpro, higher resolution for SIF retrieval (in these files someties called FLOX), files are named *.csv. 
%   Naming these sensors ROX or FLOX respectively is wrong, and will be changed to FLAME and QEpro.
%
%   AUTHOR:
%   Bastian Buman, RSWS, University of Zurich
%
%   EDITOR:
%  
%
%   DATE:
%   V1, 27-Sep-2019


%% Imports
import ch.specchio.client.*;
import ch.specchio.queries.*;
import ch.specchio.gui.*;
import ch.specchio.types.*;
import ch.specchio.*;

%% Connect to DB 
user_data.cf                                                = SPECCHIOClientFactory.getInstance();
user_data.db_descriptor_list                                = user_data.cf.getAllServerDescriptors();
user_data.specchio_client                                   = user_data.cf.createClient(user_data.db_descriptor_list.get(2));

%% Look for unprocessed data
% TBD auotmatic checks and file handlers
% cPath       = 'C:\Users\bbuman\Downloads\CH-LAE_Laegeren\2018\';
% listing     = dir(cPath);
% unpr        = listing(3).name;
% fPath       = [cPath unpr '\'];
% fileList    = dir(fPath);
% calFile     = [fPath fileList(4).name];
% QEpro       = [fPath fileList(3).name];
% FLAME       = [fPath fileList(5).name];
% camps       = user_data.specchio_client.getCampaigns();
% thisCamp    = camps(1);
% thisCamp.setPath(fPath);
% inner = LoadCampaignDataHandler();
% outer = SpecchioCampaignDataLoader(inner, user_data.specchio_client);
% SpecchioCampaignDataLoader cdl = new SpecchioCampaignDataLoader(new LoadCampaignDataHandler(), specchioClient);
% loadhandler = user_data.specchio_client new LoadCampaignDataHandler();
% cdl = user_data.specchio_client.SpecchioCampaignDataLoader(LoadCampaignDataHandler(), user_data.specchio_client);
% cdl.setSimple_delta_loading(this.simple_loading_checkbox.isSelected());
% 
% user_data.specchio_client.campaignLoader = this


%% LOAD data to campaign
% TBD

%% QIs for L0
% TBD
% Statistics, Machine Learning, Expert Knowledge

%% PROCESS L0 --> L1
rawDataID           = 128;
switchedChannels    = true;

FLOXBOX_Level_1(rawDataID, connectionID, switchedChannels);

%% QIs for L1
% TBD
% Statistics, Machine Learning, Expert Knowledge

%% PROCESS L1 --> L2
radianceDataID      = 129;
connectionID        = 2;
FLOXBOX_Level_2(radianceDataID, connectionID, switchedChannels);

%% QIs for L2
% TBD
% Statistics, Machine Learning, Expert Knowledge

%% VIs for L2
VIs = compute_VIs(wvl, spectra); % spectra : mxn, where each column is one measurement
inserVIs(user_data, ids, VIs)

%% PRCOESS L2 --> 3
reflectanceDataID   = 83;
FLOXBOX_Level_3(reflectanceDataID, connectionID) % TBD

%% QIs for L3
% TBD
% Statistics, Machine Learning, Expert Knowledge

