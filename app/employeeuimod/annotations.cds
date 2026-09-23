using EmployeeService as service from '../../srv/emp-service';
annotate service.Employees with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'employeeName',
                Value : employeeName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'employeeEmail',
                Value : employeeEmail,
            },
            {
                $Type : 'UI.DataField',
                Label : 'employeeDepartment',
                Value : employeeDepartment,
            },
            {
                $Type : 'UI.DataField',
                Label : 'employeeDesignation',
                Value : employeeDesignation,
            },
            {
                $Type : 'UI.DataField',
                Label : 'employeeJoiningDate',
                Value : employeeJoiningDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'employeeCount',
                Value : employeeCount,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'employeeName',
            Value : employeeName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'employeeEmail',
            Value : employeeEmail,
        },
        {
            $Type : 'UI.DataField',
            Label : 'employeeDepartment',
            Value : employeeDepartment,
        },
        {
            $Type : 'UI.DataField',
            Label : 'employeeDesignation',
            Value : employeeDesignation,
        },
        {
            $Type : 'UI.DataField',
            Label : 'employeeJoiningDate',
            Value : employeeJoiningDate,
        },
    ],
);

