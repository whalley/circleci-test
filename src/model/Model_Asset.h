/*******************************************************
 Copyright (C) 2013,2014 Guan Lisheng (guanlisheng@gmail.com)
 Copyright (C) 2022 Mark Whalley (mark@ipx.co.uk)

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

#ifndef MODEL_ASSET_H
#define MODEL_ASSET_H

#include "Model.h"
#include "db/DB_Table_Assets_V1.h"
#include "Model_Currency.h" // detect base currency

class Model_Asset : public Model<DB_Table_ASSETS_V1>
{
public:
    enum RATE { RATE_NONE = 0, RATE_APPRECIATE, RATE_DEPRECIATE };

    enum RATEMODE { PERCENTAGE = 0, LINEAR };
    static const wxString PERCENTAGE_STR;
    static const wxString LINEAR_STR;

    enum TYPE { TYPE_PROPERTY = 0, TYPE_AUTO, TYPE_HOUSE, TYPE_ART, TYPE_JEWELLERY, TYPE_CASH, TYPE_OTHER };

    enum STATUS { STATUS_CLOSED = 0, STATUS_OPEN };
    static const wxString OPEN_STR;
    static const wxString CLOSED_STR;

public:
    static const std::vector<std::pair<RATE, wxString> > RATE_CHOICES;
    static const std::vector<std::pair<RATEMODE, wxString> > RATEMODE_CHOICES;
    static const std::vector<std::pair<TYPE, wxString> > TYPE_CHOICES;
    static const std::vector<std::pair<STATUS, wxString> > STATUS_CHOICES;

public:
    Model_Asset();
    ~Model_Asset();

public:
    /**
    Initialize the global Model_Asset table on initial call.
    Resets the global table on subsequent calls.
    * Return the static instance address for Model_Asset table
    * Note: Assigning the address to a local variable can destroy the instance.
    */
    static Model_Asset& instance(wxSQLite3Database* db);

    /**
    * Return the static instance address for Model_Asset table
    * Note: Assigning the address to a local variable can destroy the instance.
    */
    static Model_Asset& instance();

public:
    static DB_Table_ASSETS_V1::ASSETTYPE ASSETTYPE(TYPE type, OP op = EQUAL);
    static DB_Table_ASSETS_V1::STARTDATE STARTDATE(const wxDate& date, OP op = EQUAL);
    
public:
    static wxString get_asset_name(int asset_id);
    static wxArrayString all_rate();
    static wxArrayString all_ratemode();
    static wxArrayString all_type();
    static wxArrayString all_status();
    double balance();
    static wxDate STARTDATE(const Data* r);
    static wxDate STARTDATE(const Data& r);

    static TYPE type(const Data* r);
    static TYPE type(const Data& r);
    static RATE rate(const Data* r);
    static RATE rate(const Data& r);
    static RATEMODE ratemode(const Data* r);
    static RATEMODE ratemode(const Data& r);
    static STATUS status(const Data* r);
    static STATUS status(const Data& r);

    /** Returns the base currency Data record pointer*/
    static Model_Currency::Data* currency(const Data* /* r */);
    /** Returns the calculated current value */
    static double value(const Data* r);
    /** Returns the calculated current value */
    static double value(const Data& r);
    /** Returns the calculated value at a given date */
    double valueAtDate(const Data* r, const wxDate date);
};

#endif // 
