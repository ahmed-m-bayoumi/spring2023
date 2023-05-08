while true

    a = round(592895*rand());
    b = round(592895*rand());

    figure('Name','SVM Model 1');
    gscatter(labeled_features(:,a),labeled_features(:,b), labeled_features(:,end));
    hold on
    plot(SVMModel.SupportVectors(:,a), SVMModel.SupportVectors(:,b), 'ko', 'MarkerSize',10)

    v1= num2str(a, '%02d');
    v2= num2str(b, '%02d');

    xlabel(['Dimension ' v1]);
    ylabel(['Dimension ' v2]);
    
    hold off
    legend('Class -1', 'Class 1', 'Support Vectors')

    waitforbuttonpress()
    close all
end