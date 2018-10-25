function plot_DW_data_with_theory_IC( data, mu_full, yr_list)
% mu_full, yr_list are theory's prediction
figure()
hold on
% -- shade for democrats ----
Dleft = data.Dmu - data.Dsig;
Dright = data.Dmu + data.Dsig;

inBetweenD = [Dleft',fliplr(Dright')];
y = [data.year, fliplr(data.year)];

fillR = fill(inBetweenD, y , 'b', 'LineStyle', 'none');
fillR.FaceAlpha = 0.2;

% -- line for democrats ----
h1 = plot(data.Dmu, data.year,'b--');

% -- shade for republicans ----
Rleft = data.Rmu - data.Rsig;
Rright = data.Rmu + data.Rsig;

inBetweenR = [Rleft',fliplr(Rright')];

fillR = fill(inBetweenR, y , 'r', 'LineStyle', 'none');
fillR.FaceAlpha = 0.2;

% -- line for republicans ----
plot(data.Rmu, data.year, 'r--')

h3 = plot(mu_full(:,1), yr_list, 'k-');
plot(mu_full(:,2), yr_list, 'k-')


hold off
xlabel('Party position, \mu')
ylabel('Year')
ylim([1861 2013])
xlim([-1 1])
legend([h3, h1], {'Model', 'Data'})

box on

end

