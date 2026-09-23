namespace Employee;
using { managed } from '@sap/cds/common';

entity Employee {
    key employeeId            : UUID;
        employeeName          : String(50) not null;
        employeeEmail         : String(100) @assert.format: '^[a-zA-Z0-9._%+-]+@(gmail|yahoo|phoenixteam)\.com$';//doesn't work in unmanaged
        employeeDepartment    : String(50);
        employeeDesignation   : String(50);
        employeeJoiningDate   : Date;
        employeeLeaveRequests : Association to many LeaveRequests on employeeLeaveRequests.employee = $self;
    virtual employeeCount     : Int16;
}

type leaveType  : String enum {
    annualLeave;
    sickLeave;
    casualLeave;
}

type statusType : String enum {
    Pending;
    Approved;
    Rejected;
}

entity LeaveRequests {
    key leaveRequestId   : UUID;
        employee         : Association to Employee;
        leaveRequestType : leaveType not null;
        startDate        : Date not null;
        endDate          : Date not null;
        noOfDays         : Integer;
        reason           : String(100) not null;
        status           : statusType not null;
        appliedDate      : Date not null;
        approverName     : String(50);
}


extend entity Employee with managed;

extend entity Employee {
    employeeComments : localized String(50);
}
