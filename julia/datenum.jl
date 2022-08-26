const MATLAB_EPOCH = Dates.DateTime(-0001,12,31)

"""
     datenum(d::Dates.DateTime)
Converts a Julia DateTime to a MATLAB style DateNumber.
MATLAB represents time as DateNumber, a double precision floating
point number being the the number of days since January 0, 0000
Example
    datenum(now())
"""
function datenum(d::Dates.DateTime)
    Dates.value(d - MATLAB_EPOCH) /(1000 * 60 * 60 * 24)
end