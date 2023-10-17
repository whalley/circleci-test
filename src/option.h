/*******************************************************
 Copyright (C) 2006 Madhan Kanagavel
 Copyright (C) 2021-2022 Mark Whalley (mark@ipx.co.uk)

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

#pragma once

#include "defs.h"

/*
   mmOptions caches the options for MMEX
   so that we don't hit the DB that often
   for data.
*/
class Option
{
public:
    enum USAGE_TYPE { NONE = 0, LASTUSED, UNUSED, DEFAULT };
    enum THEME_MODE { AUTO = 0, LIGHT, DARK };

public:
    Option();
    static Option& instance();
    void LoadOptions(bool include_infotable = true);

    // set and save the option: m_dateFormat
    void setDateFormat(const wxString& date_format);
    const wxString getDateFormat() const;

    // set and save the option: m_language
    wxLanguage getLanguageID(bool get_db = false);
    // get 2-letter ISO 639-1 code
    const wxString getLanguageCode(bool get_db = false);
    void setLanguage(wxLanguage& language);

    // set and save the option: m_userNameString
    void UserName(const wxString& username);
    const wxString UserName() const;

    // set and save the option: m_localeNameString
    void LocaleName(const wxString& locale);
    const wxString LocaleName() const;

    // set and save the option: m_financialYearStartDayString
    void FinancialYearStartDay(const wxString& setting);
    const wxString FinancialYearStartDay() const;

    // set and save the option: m_financialYearStartMonthString
    void FinancialYearStartMonth(const wxString& setting);
    wxString FinancialYearStartMonth();

    // set the base currency ID
    void setBaseCurrency(int base_currency_id);
    // returns the base currency ID
    int getBaseCurrencyID();

    // set and save the option: m_databaseUpdated
    void DatabaseUpdated(bool value);
    bool DatabaseUpdated();

    void HideShareAccounts(bool value);
    bool HideShareAccounts();

    void HideDeletedTransactions(bool value);
    bool HideDeletedTransactions();

    void BudgetFinancialYears(bool value);
    bool BudgetFinancialYears();

    void BudgetIncludeTransfers(bool value);
    bool BudgetIncludeTransfers();

    void BudgetReportWithSummaries(bool value);
    bool BudgetReportWithSummaries();

    void BudgetOverride(bool value);
    bool BudgetOverride();

    // Deduct monthly budget from yearly budget
    void BudgetDeductMonthly(bool value);
    bool BudgetDeductMonthly();

    void TransPayeeSelection(int value);
    int TransPayeeSelection();

    void TransCategorySelectionNonTransfer(int value);
    int TransCategorySelectionNonTransfer() const;

    void TransCategorySelectionTransfer(int value);
    int TransCategorySelectionTransfer() const;

    void set_bulk_transactions(bool value);
    bool get_bulk_transactions() const;

    void TransStatusReconciled(int value);
    int TransStatusReconciled();

    void TransDateDefault(int value);
    int TransDateDefault();

    void SendUsageStatistics(const bool value);
    bool SendUsageStatistics();

    void CheckNewsOnStartup(bool value);
    bool CheckNewsOnStartup();

    void SharePrecision(int value);
    int SharePrecision();

    // Allows a year or financial year to start before or after the 1st of the month.
    void setBudgetDaysOffset(int value);
    int getBudgetDaysOffset() const;
    /**Re-adjust date by the date offset value*/
    void setBudgetDateOffset(wxDateTime& date) const;

    // Allows the 'first day' in the month to be adjusted for reporting purposes
    void setReportingFirstDay(int value);
    int getReportingFirstDay() const;

    /* stored value in percantage for scale html font and other objects */
    void setHTMLFontSizes(int value);
    int getHtmlFontSize();

    void setThemeMode(int value);
    int getThemeMode() const;

    void setFontSize(int value);
    int getFontSize() const;

    void setIconSize(int value);
    void setToolbarIconSize(int value);
    void setNavigationIconSize(int value);

    int getIconSize();
    int getNavigationIconSize();
    int getToolbarIconSize();

    int AccountImageId(int account_id, bool def, bool ignoreClosure = false);
    bool getSendUsageStatistics() const;

    void IgnoreFutureTransactions(bool value);
    bool getIgnoreFutureTransactions() const;

    void ShowToolTips(bool value);
    bool getShowToolTips() const;

    void ShowMoneyTips(bool value);
    bool getShowMoneyTips() const;

    void CurrencyHistoryEnabled(bool value);
    bool getCurrencyHistoryEnabled() const;

    // Homepage income vs expenses graph range
    void setHomePageIncExpRange(int value);
    int getHomePageIncExpRange() const;

private:
    wxString m_dateFormat;
    wxLanguage m_language = wxLANGUAGE_UNKNOWN;
    wxString m_userNameString;
    wxString m_localeNameString;
    wxString m_financialYearStartDayString;
    wxString m_financialYearStartMonthString;
    int m_baseCurrency = -1;
    bool m_currencyHistoryEnabled = false;
    bool m_bulk_enter = false;

    bool m_databaseUpdated = false;
    bool m_hideShareAccounts = true;                //INIDB_HIDE_SHARE_ACCOUNTS
    bool m_hideDeletedTransactions = false;         //INIDB_HIDE_DELETED_TRANSACTIONS
    bool m_budgetFinancialYears = false;            //INIDB_BUDGET_FINANCIAL_YEARS
    bool m_budgetIncludeTransfers = false;          //INIDB_BUDGET_INCLUDE_TRANSFERS
    bool m_budgetReportWithSummaries = true;        //INIDB_BUDGET_SUMMARY_WITHOUT_CATEG
    bool m_budgetOverride = false;                  //INIDB_BUDGET_OVERRIDE
    bool m_budgetDeductMonthly = false;             //INIDB_BUDGET_DEDUCT_MONTH_FROM_YEAR
    bool m_ignoreFutureTransactions = false;        //INIDB_IGNORE_FUTURE_TRANSACTIONS
    bool m_showToolTips = true;                     //INIDB_SHOW_TOOLTIPS
    bool m_showMoneyTips = true;                    //INIDB_SHOW_MONEYTIPS

    int m_transPayeeSelection = Option::NONE;
    int m_transCategorySelectionNonTransfer = Option::NONE;
    int m_transCategorySelectionTransfer = Option::NONE;
    int m_transStatusReconciled = Option::NONE;
    int m_transDateDefault = 0;
    bool m_usageStatistics = true;
    bool m_newsChecking = true;                    //INIDB_CHECK_NEWS
    int m_sharePrecision = 4;

    int m_theme_mode = Option::AUTO;
    int m_html_font_size = 100;
    int m_ico_size = 16;
    int m_font_size = 0;
    int m_toolbar_ico_size = 32;
    int m_navigation_ico_size = 24;

    int m_budget_days_offset = 0;
    int m_reporting_firstday = 1;

    int m_homepage_incexp_range = 0;
};

inline int Option::getIconSize() { return m_ico_size; }
inline int Option::getNavigationIconSize() { return m_navigation_ico_size; }
inline int Option::getToolbarIconSize() { return m_toolbar_ico_size; }
inline const wxString Option::LocaleName() const { return m_localeNameString; }
inline const wxString Option::UserName() const { return m_userNameString; }
inline const wxString Option::FinancialYearStartDay() const { return m_financialYearStartDayString; }
inline int Option::TransCategorySelectionNonTransfer() const { return m_transCategorySelectionNonTransfer; }
inline int Option::TransCategorySelectionTransfer() const { return m_transCategorySelectionTransfer; }
inline bool Option::get_bulk_transactions() const { return m_bulk_enter; }
inline int Option::getThemeMode() const { return m_theme_mode; }
inline int Option::getFontSize() const { return m_font_size; }

inline const wxString Option::getDateFormat() const
{
    return m_dateFormat;
}

inline bool Option::getSendUsageStatistics() const
{
#ifdef _DEBUG
    return false;
#else
    return m_usageStatistics;
#endif
}

inline bool Option::getCurrencyHistoryEnabled() const
{
    return m_currencyHistoryEnabled;
}

inline bool Option::getIgnoreFutureTransactions() const
{
    return m_ignoreFutureTransactions;
}

inline bool Option::getShowToolTips() const
{
    return m_showToolTips;
}

inline bool Option::getShowMoneyTips() const
{
    return m_showMoneyTips;
}

inline int Option::getBudgetDaysOffset() const
{
    return m_budget_days_offset;
}

inline int Option::getReportingFirstDay() const
{
    return m_reporting_firstday;
}

inline int Option::getHomePageIncExpRange() const
{
    return m_homepage_incexp_range;
}
