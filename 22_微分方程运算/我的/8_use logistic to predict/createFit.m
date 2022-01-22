function [fitresult, gof] = createFit(year, population)
    %CREATEFIT(YEAR,POPULATION)
    %  Create a fit.
    %
    %  Data for 'untitled fit 1' fit:
    %      X Input : year
    %      Y Output: population
    %  Output:
    %      fitresult : a fit object representing the fit.
    %      gof : structure with goodness-of fit info.
    %
    %  另请参阅 FIT, CFIT, SFIT.
    
    %  由 MATLAB 于 21-Jan-2022 11:34:20 自动生成
    
    
    %% Fit: 'untitled fit 1'.
    [xData, yData] = prepareCurveData( year, population );
    
    % Set up fittype and options.
    ft = fittype( 'xm/(1+(xm/3.9-1)*exp(-r*(t-1790)))', 'independent', 't', 'dependent', 'x' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.Lower = [0 -Inf];
    opts.StartPoint = [0.05 1000];
    opts.Upper = [1 2000];
    
    % Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );
    
    % Plot fit with data.
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, xData, yData );
    legend( h, 'population vs. year', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
    % Label axes
    xlabel( 'year', 'Interpreter', 'none' );
    ylabel( 'population', 'Interpreter', 'none' );
    grid on
    
    
