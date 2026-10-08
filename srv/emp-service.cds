using Employee as my from '../db/schema';

@impl:'srv/emp-service.js'

service EmployeeService {//@(odata:'/admin'){
  // // @restrict: [
  // //   { grant: 'READ', to: ['Viewer'] },
  // //   { grant: '*', to: ['Admin'] }
  // // ]
  //   entity Employees as projection on my.Employee;
  //   entity LeaveRequests as projection on my.LeaveRequests;
  entity Employees as projection on my.Employee; //actions{
    //bound function
    //function getLeaveRequest() returns Integer;
    
    //bound action
    //action promote(newDesignation : String(50) not null) returns Employees;
  //};
  //unbound function
  //function getEmployeeCount() returns Integer;
  // function getEmployeeCount(employeeId: Int16) returns Employees;
  // function readEmployee() returns array of Employees;
  // action createEmployee(
  //     employeeId: UUID, 
  //     employeeName:String, 
  //     employeeEmail:String, 
  //     employeeDepartment:String, 
  //     employeeDesignation:String, 
  //     employeeJoiningDate:Date
  // ) returns Employees;
  
  // action updateEmployee(
  //     employeeId: UUID, 
  //     employeeName:String, 
  //     employeeEmail:String, 
  //     employeeDepartment:String, 
  //     employeeDesignation:String, 
  //     employeeJoiningDate:Date
  // ) returns Employees;
  // action deleteEmployee(employeeId: UUID) returns Boolean; 

  //unbound action
  // action onboardEmployee(
  //       employeeName       : String(50) not null,
  //       employeeEmail      : String(100) not null,
  //       employeeDepartment : String(50),
  //       employeeDesignation: String(50)
  //   ) returns Employees;

}