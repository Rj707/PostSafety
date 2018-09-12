enum Route: String
{
    case Register           = "/api/register"
    case Login              = "/api/EmployeesLogin"
    case UpdateEmployees    = "/api/UpdateEmployees"
    case ListEmployees      = "/api/Employees/"
    case UpdateDeviceToken  = "/api/UpdateDeviceToken/"
    
    case IncidentCompany    = "/api/IncidentCompany/"
    case ChecklistDetails   = "/api/ChecklistDetails"
    case SingleChecklist    = "/api/Checklists"
    
    case AllReports         = "/api/AllReports/"
    case Reports            = "/api/ReportsAPI"
    case SharedReports      = "/api/SharedReports/"
    
    case CreateReport       = "/api/CreateReport/"
    case UpdateReport       = "/api/UpdateReport/"
    
    case CloseReport        = "/api/CloseReport"
    case SendReports        = "/api/SendReports/"
    case CreateAlert        = "/api/CreateAlert/"
    
    case UploadImage        = "/api/UploadImage/"
    
    case LocationsList      = "/api/LocationsList/"
    case SubCategory        = "/api/SubChecklistDetails/"
    
    case Notifications      = "/api/Notifications"
    case SafetyUpdates      = "/api/SafetyUpdates"
    case Trainings          = "/api/Trainings/"
    case PolicyProcedures   = "/api/PolicyAndProcedures/"
    
    case SummaryStatsCount  = "/api/SummaryReportsCount/"
    case SummaryStatsDetail = "/api/SummaryStatiticsReports/"
    
    case ReportRead         = "/api/ReportIsRead"
    case SafetyUpdatesRead  = "/api/SafetyUpdatesIsRead"
    case TrainingIsRead     = "/api/TrainingIsRead/"
    case NotificationIsRead = "/api/NotificationIsRead/"
    case ProcedurePolicyRead = "/api/ProcedureNPolicyIsRead/"
    
    func url() -> String
    {
        return Constants.BaseURL + self.rawValue
    }
}
