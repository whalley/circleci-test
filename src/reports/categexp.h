/*******************************************************
 Copyright (C) 2006 Madhan Kanagavel
 Copyright (C) 2017 James Higley
 Copyright (C) 2021 Mark Whalley (mark@ipx.co.uk)
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 ********************************************************/

#ifndef MM_EX_REPORTCATEGEXP_H_
#define MM_EX_REPORTCATEGEXP_H_

#include "reportbase.h"
#include "util.h"
#include <vector>

class mmReportCategoryExpenses : public mmPrintableBase
{
public:
    enum TYPE { GOES = 0, COME , MONTHLY, SUMMARY };
    explicit mmReportCategoryExpenses(const wxString& title, enum TYPE type);
    virtual ~mmReportCategoryExpenses();

    virtual void RefreshData();
    virtual wxString getHTMLText();

protected:
    enum TYPE type_;

private:
    // structure for sorting of data
    struct data_holder { int catID; int subCatID; wxString name; double amount; int categs; };
    std::vector<data_holder> data_;
};

class mmReportCategoryExpensesGoes: public mmReportCategoryExpenses
{
public:
    mmReportCategoryExpensesGoes();
};

class mmReportCategoryExpensesComes : public mmReportCategoryExpenses
{
public:
    mmReportCategoryExpensesComes();
};

class mmReportCategoryExpensesCategories : public mmReportCategoryExpenses
{
public:
    mmReportCategoryExpensesCategories();
};

//----------------------------------------------------------------------------

class mmReportCategoryOverTimePerformance : public mmPrintableBase
{
public:
    mmReportCategoryOverTimePerformance();
    ~mmReportCategoryOverTimePerformance();

    wxString getHTMLText();

protected:
    enum TYPE { INCOME = 0, EXPENSES, TOTAL, MAX };
};

#endif // MM_EX_REPORTCATEGEXP_H_
