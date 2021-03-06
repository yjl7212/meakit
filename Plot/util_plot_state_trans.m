function [ elec_cluster ] = util_plot_state_trans( network_vector, seq, clu_sub, elec, varargin )
%UTIL_PLOT_STATE_TRANS Plot the state transitions of the selected
%electrodes.
%   Input:
%           network_vector:     Network activity vectors (elecs * bins)
%           seq:                The channel sequence indexer for
%                               network_vector (very important when you
%                               pickoff some 'inactive' channels).
%           clu_sub:            The clustering results, generated by
%                               util_extract_cluster. Through this, each
%                               bin is assigned to a clustered state.
%           elec:               Electrodes you want to analyze.
%                               e.g. 12 / [14 22] / 'all'
%           method:             'pl' / 'sc' / 'im' / 'no' [default]: 'pl'
%           threshold:          The threshold for determining whether the
%                               electrode is participating. 
%                               [default]: 1. You may increase it with your
%                               bin length (1:1000 ms), if = 0, channels
%                               with few firings can be counted.
%           remove0:            If true, remove the zero state which is
%                               caused by no firings from the selected
%                               electrode at the bin. [default]: 1
%
%   Output:
%           elec_cluster:       Assign the state transitions to each
%                               electrodes by time bins.
%
%   Example:
%           [ elec_cluster ] = util_plot_state_trans( network_vectors, seq,
%           subscript, 'all', 'threshold', 0, 'remove0', 1, 'method',
%           'im');
%
%   Created on Jul/27/2010 By Pu Jiangbo
%   Britton Chance Center for Biomedical Photonics

% Analyze parameters
pvpmod(varargin);

if ~exist('method', 'var')
    method = 'pl';
end

if ~exist('threshold', 'var')
    threshold = 1;
end

if ~exist('remove0', 'var')
    remove0 = true;
end

if ischar(elec)
    if strcmpi(elec, 'all')
        elec = util_convert_hw2ch((1:64));
    end
end

% Init
elec_cluster = zeros(length(elec), size(network_vector, 2));

% Convert struct to vector
clu_vec = util_convert_struct_2_vector_cluster(clu_sub);

% Assign states to each selected electrode
for i = 1:length(elec)
    if threshold == 0
        elec_cluster(i, network_vector(seq == util_convert_ch2hw(elec(i)), :) > threshold ) = ...
                clu_vec(network_vector(seq == util_convert_ch2hw(elec(i)), :) > threshold);
    else
        elec_cluster(i, network_vector(seq == util_convert_ch2hw(elec(i)), :) >= threshold ) = ...
                clu_vec(network_vector(seq == util_convert_ch2hw(elec(i)), :) >= threshold);
    end
    %elec_cluster( i, network_vector(util_convert_ch2hw(elec(i)), :) >= threshold ) = clu_vec( network_vector(util_convert_ch2hw(elec(i)), :) >= threshold );
end

% Remove zeros
if remove0
    elec_cluster_r = cell(length(elec), 1);
    for i = 1:length(elec)
       elec_cluster_r{i} = elec_cluster(i, elec_cluster(i, :) ~= 0 );
    end
    elec_cluster = elec_cluster_r;
end

% Visualization
figure
if strcmpi(method, 'pl')
    % Prepare figure
    for i = 1:length(elec)
        if remove0
            % The data is in a cell array
            plot(elec_cluster{i} + (i - 1) * (max(clu_vec) + 1), 'color', 'k', 'LineStyle', '-', 'Marker', '.', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [0 0 0]);
        else
            plot(elec_cluster(i,:) + (i - 1) * (max(clu_vec) + 1), 'color', 'k', 'LineStyle', '-', 'Marker', '.', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [0 0 0]);
        end
        hold on
    end
    hold off
    
    % Set label
    xlim([0 size(network_vector, 2)])
    ylim([0 length(elec) * (max(clu_vec) + 1) - 1]);
    j = 1;
    for i = 1:length(elec)
        for clu_i = 0:max(clu_vec)
            yticklabel{j} = [num2str(elec(i)) ' (' num2str(clu_i) ')'];
            j = j + 1;
        end
    end
    set(gca, 'ytick', [0:(length(elec) * (max(clu_vec) + 1) - 1)])
    set(gca, 'yticklabel', yticklabel)
    xlabel('Bins')
    ylabel('Channels and States')
elseif strcmpi(method, 'sc')
    % Prepare figure
    % We use merely the same script as pl, because plot is faster than
    % scatter and currently, just change LineStyle from '-' to 'none' is
    % acceptable.
    for i = 1:length(elec)
        if remove0
            % The data is in a cell array
            plot(elec_cluster{i} + (i - 1) * (max(clu_vec) + 1), 'color', 'k', 'LineStyle', 'none', 'Marker', '.', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [0 0 0]);
        else
            plot(elec_cluster(i,:) + (i - 1) * (max(clu_vec) + 1), 'color', 'k', 'LineStyle', 'none', 'Marker', '.', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [0 0 0]);
        end
        hold on
    end
    hold off
    
    % Set label
    xlim([0 size(network_vector, 2)])
    ylim([0 length(elec) * (max(clu_vec) + 1) - 1]);
    j = 1;
    for i = 1:length(elec)
        for clu_i = 0:max(clu_vec)
            yticklabel{j} = [num2str(elec(i)) ' (' num2str(clu_i) ')'];
            j = j + 1;
        end
    end
    set(gca, 'ytick', [0:(length(elec) * (max(clu_vec) + 1) - 1)])
    set(gca, 'yticklabel', yticklabel)
    xlabel('Bins')
    ylabel('Channels and States')
elseif strcmpi(method, 'im')
    % Prepare figure
    if remove0
        % The data is in a cell array
        % I dont think it is useful to implement this.
        disp('Sorry, this part is not yet implemented');
        return
    else
        imagesc(elec_cluster);
    end
    
    axis xy
    xlabel('Bins')
    ylabel('Channels (Hardware Index)')
    
    % Set colorbar label
    cbar_yticklabel = {};
    for i = 0:max(clu_vec)
        cbar_yticklabel = [cbar_yticklabel {num2str(i)}];
    end
    colormap(jet(max(clu_vec) + 1));
    cbar_axes = colorbar('YTick', (0:max(clu_vec)), 'YTickLabel', cbar_yticklabel);
    set(cbar_axes, 'box', 'off');
    set(cbar_axes, 'TickDir', 'out');
    set(cbar_axes, 'YTickMode','manual');
elseif strcmpi(method, 'no')
    disp('No figure is generated.');
else
    error('Not supported yet');
end



end

