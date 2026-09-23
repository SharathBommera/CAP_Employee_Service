sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project1/test/integration/pages/EmployeesList.gen",
	"project1/test/integration/pages/EmployeesObjectPage.gen"
], function (JourneyRunner, EmployeesListGenerated, EmployeesObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project1') + '/test/flp.html#app-preview',
        pages: {
			onTheEmployeesListGenerated: EmployeesListGenerated,
			onTheEmployeesObjectPageGenerated: EmployeesObjectPageGenerated
        },
        async: true
    });

    return runner;
});

