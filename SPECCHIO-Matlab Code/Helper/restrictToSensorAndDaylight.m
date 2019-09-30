function [ids_rstr, space_rstr, spectra_rstr, filenames_rstr] = restrictToSensorAndDaylight(user_data, sensorType, startTime, endTime, all_ids)
% Import queries:
import ch.specchio.queries.*; 

% Create a new query for spectrum ids ('spectrum'):
query = Query('spectrum');
query.setQueryType(Query.SELECT_QUERY); %public static final String SELECT_QUERY = "select";

query.addColumn('spectrum_id')

% Create the condition: SELECT * FROM specchio WHERE CONDITION (e.g
% SPECTRUM IS IN SENSOR OR TIME FRAME)
cond = ch.specchio.queries.QueryConditionObject('spectrum', 'spectrum_id');
cond.setValue(all_ids);
cond.setOperator('in');
query.add_condition(cond);

% Condition for sensor type (e.g. QEpro or FLAME):
cond = SpectrumQueryCondition('spectrum', 'Acquisition Time');
file_format_id = user_data.specchio_client.getFileFormatId(sensorType);
cond.setValue(num2str(file_format_id));
cond.setOperator('=');
query.add_condition(cond);

% Condition for startTime:
cond = SpectrumQueryCondition('spectrum', 'Acquisition Time');
cond.setValue(startTime);
cond.setoperator('>=')
query.add_condition(cond);

% Condition for endTime:
cond = SpectrumQueryCondition('spectrum', 'Acquisition Time');
cond.setValue(endTime);
cond.setOperator('<=');
query.add_condition(cond);

ids = user_data.specchio_client.getSpectrumIdsMatchingQuery(query);

spaces = user_data.specchio_client.getSpaces(ids, 'Spectrum Number');
ids_rstr = spaces(1).getSpectrumIds(); % get ids sorted by  'Spectrum Number'
space_rstr = user_data.specchio_client.loadSpace(spaces(1));
spectra_rstr = space_rstr.getVectorsAsArray();
filenames_rstr = user_data.specchio_client.getMetaparameterValues(ids_rstr, 'File Name');

end 
