# employee-surveys
`IBM Watson/HR Employee Attrition` scenario

## Data sources

`data://` located at [`employee-surveys`](https://drive.google.com/open?id=1k4Pk4r4D2nz9xAEgMU7BVJTeEGtJHjY0)

| Dataset | Description | Data filepath | Columns | Rows | Size | Documentation |
|:-- |:--|:--|--:|--:|--:|:--|
| *Employee records* | Employee database maintained by HR; collated from employee profile sheets and employee records database | [`data:///Employee records.csv`](https://drive.google.com/open?id=1QOP_eN3dtOgpb7VG2XI3oiYn4fra6vqe) | 18 columns | 1,470 rows | 181,125 bytes | [`readme.html`](https://github.com/dataseer-carl/dataseer-datalake/blob/master/IBM%20Watson/HR%20Employee%20Attrition/Scenarios/Employee%20Satisfaction%20and%20Performance/readme.html) |
| **Employee Surveys** | Results of employee surveys | [`data:///Employee Surveys.xlsx`](https://drive.google.com/open?id=1RS9WAp087xdkP_AJaRT40OY8P6R7NxMe) |  |  | 101,518 bytes | [`readme.html`](https://github.com/dataseer-carl/dataseer-datalake/blob/master/IBM%20Watson/HR%20Employee%20Attrition/Scenarios/Employee%20Satisfaction%20and%20Performance/readme.html) |
| *Satisfaction survey results* | Results of satisfaction survey accomplished by all staff | [`[data:///Employee Surveys.xlsx]!Satisfaction survey`](https://drive.google.com/open?id=1RS9WAp087xdkP_AJaRT40OY8P6R7NxMe) | 6 columns | 1,470 rows |  |  |
| *Performance rating survey results* | Results of performance rating survey accomplished by managers | [`[data:///Employee Surveys.xlsx]!Performance rating survey`](https://drive.google.com/open?id=1RS9WAp087xdkP_AJaRT40OY8P6R7NxMe) | 6 columns | 1,470 rows |  |  |

## Outline

### EDA

- [ ] **Talent composition**: *Department*, *EducationField*/*JobRole*
- [ ] **Salary-experience trends**: *MonthlyIncome* vs. *TotalWorkingYears*
- [x] **Salary hike-tenure trends**: *SalaryHike* vs. *YearsAtCompany*

#### Data

| Dataset | Description | Columns | Rows | Input Data | Data Processing Scripts | csv Data File | xlsx Data File | R Data File |
|:--|:--|--:|--:|:--|:--|:--|:--|:--|
| Employee records | Parsed **Employee Records** | 18 columns | 1,470 rows | **Employee records** | `script00_records.R` |  |  | [`records.rds`](https://drive.google.com/open?id=1e9waAdTI_2Y1sH74T_4rDCIslftn_4GM) |

#### Plots

| Plot | File | Script | Input data |
|:--|:--|:--|:--|
| Salary hike-tenure trends | `plot00_trend_salaryhikeVStenure.png` | `script00_records.R` | Employee records |
| Salary-work experience trends | `plot01_trend_salaryVSxp.png` | `script00_records.R` | Employee records |