// New Syntax
// class EmpService extends cds.ApplicationService {
//   init() {
//     const { Employees, LeaveRequests } = this.entities
//     this.before ('READ', Employees, req => {console.log("Before Reading the Employee entity")})
//     this.on ('READ', Employees, req => {console.log("During Reading of the Employee entity")})
//     this.after ('READ', Employees, req => {console.log("After Reading the Employee entity")})
//     return super.init()
//   }
// }
// module.exports = EmpService
// ---------------------------------Unmanaged CRUD-----------------------------------------------
// const cds = require('@sap/cds')
// module.exports = cds.service.impl(async function () {

// import cds from '@sap/cds'
// export default cds.service.impl(async function() {

//     const { Employees } = this.entities

//     // CREATE - Employee
//     this.on('CREATE', Employees, req => {
//         const createEmp = req.data
//         INSERT (createEmp) .into(Employees)
//         return createEmp
//     })

//     // READ - Employee
//     this.on('READ', Employees, req => {
//         // return readEmp
//         // if(!req.user.is('Admin') && !req.user.is('Viewer')) {
//         //     return req.reject(403, 'Not Authorized')
//         // }
//         const readEmp = SELECT.from (Employees)
//         return readEmp
//     })

//     // UPDATE - Employee
//     this.on('UPDATE', Employees, req => {
//         const updateEmp = req.data
//         UPDATE (Employees) .set (updateEmp) .where ({ employeeId: updateEmp.employeeId })
//         return updateEmp
//     })

//     // DELETE - Employee
//     this.on('DELETE', Employees, req => {
//         const deleteEmp = req.data
//         DELETE .from (Employees) .where ({ employeeId: deleteEmp.employeeId })
//         return deleteEmp
//     })


// })

//--------------------------------------Actions and Functions----------------------------------
import cds from '@sap/cds';
export default class EmployeeService extends cds.ApplicationService {
    init() {
        const { Employees } = this.entities;

        async function getEmployeeCount() {
            const result = await SELECT
                .from(Employees)
                .columns('count(employeeId) as employeeCount');
            const empCount = result[0].employeeCount;
            const employees = await SELECT.from(Employees);
            employees.forEach(employee => {
                employee.employeeCount = empCount;
            });
            return employees;
        }

        this.on('READ', async (req) => {
                const emp = await getEmployeeCount() 
            return emp
        });

        // this.on('readEmployee', async (req) => {
        //     return await SELECT.from(Employees)
        // });

        this.on('createEmployee', async (req) => {
            const { employeeId, employeeName, employeeEmail, employeeDepartment, employeeDesignation, employeeJoiningDate } = req.data;
            await INSERT.into(Employees).entries({ employeeId, employeeName, employeeEmail, employeeDepartment, employeeDesignation, employeeJoiningDate, employeeComments });
            return await SELECT.one.from(Employees).where({ employeeId });
        });

        this.on('updateEmployee', async (req) => {
            const { employeeId, employeeName, employeeEmail, employeeDepartment, employeeDesignation, employeeJoiningDate } = req.data;
            await UPDATE(Employees).set({ employeeName, employeeEmail, employeeDepartment, employeeDesignation, employeeJoiningDate, employeeComments }).where({ employeeId });
            return await SELECT.one.from(Employees).where({ employeeId });
        });

        this.on('deleteEmployee', async (req) => {
            const { employeeId } = req.data;
            const deletedCount = await DELETE.from(Employees).where({ employeeId });
            return deletedCount > 0;
        });

        return super.init();
    }
}