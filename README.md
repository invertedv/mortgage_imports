## mortgage_imports

### Overview

This package builds clickhouse databases of loan-level mortgage performance
that is annotated with FHFA HPI, interest rates and economic data.  
As a necessary pre-requisite, the package creates separate clickhouse 
databases of the latter three.

The types of data created are:

- FHFA house prices
- Interest Rates
- Regional economic data
- Mapping of zip codes to MSA/MSAdiv/CBSA/CBSAdiv  
- Fannie Mae

Separate databases of the first four a created. The final Fannie database
is augmented with annotations based on these tables.

### Data Sources and pre-processing

**FHFA**
The data is downloaded from [here](https://www.fhfa.gov/DataTools/Downloads/Pages/House-Price-Index-Datasets.aspx).
The series needed are:

- 3-digit zip (HPI_AT_3zip.xls)
- MSADiv level (HPI_AT_metro.csv)
- Non-metro area (HPI_AT_nonmetro.csv)
- State (HPI_AT_state.csv)

Excel files need to be saved as CSV. If there is a header row, this should
be deleted.

**Interest Rates**

Interest rates are downloaded from the St. Louis Federal Reserve Fred II 
database. There are two downloads -- one for rates available at a daily
frequency and one for rates available at a weekly frequency.

Daily rates are:

- 10-Year Treasury Constant Maturity Rate
- 12-Month London Interbank Offered Rate (LIBOR), based on U.S. Dollar
- 1-Month London Interbank Offered Rate (LIBOR), based on U.S. Dollar
- 3-Month London Interbank Offered Rate (LIBOR), based on U.S. Dollar

The data is [here](https://research.stlouisfed.org/useraccount/datalists/257884).

Weekly rates are:

- 15-Year Fixed Rate Mortgage Average in the United States
- 30-Year Fixed Rate Mortgage Average in the United States
- 5/1-Year Adjustable Rate Mortgage Average in the United States

The data is [here](https://research.stlouisfed.org/useraccount/datalists/257882).

The files should be downloaded as text files. Then:
1. Delete header row
2. Delete any dates prior to 1970
3. run fromdos on file (linux)

**Economic Data**

At this time, only unemployment rates are pulled. These are pulled at the
MSA, MSADivision, CBSA, CBSADivision and micropolitan levels. The data
is pulled directly from the BLS.

- The msa data is from [here](https://download.bls.gov/pub/time.series/la/la.data.60.Metro)
- The division data is from [here](https://download.bls.gov/pub/time.series/la/la.data.62.Micro)
- The state data is from [here](https://download.bls.gov/pub/time.series/la/la.data.3.AllStatesS)
- The micropolitan data is [here](https://download.bls.gov/pub/time.series/la/la.data.62.Micro)

After the files are downloaded:

- Delete the header row
- run fromdos on the file (linux)

**Map Data**

The map data maps zip codes into:

- CBSA codes (zip_cbsa table)
- CBSA with division codes (zip_cbsad table)
- County codes (zip_cty table)

The first two tables include micropolitan mappings.
The tables have all zip codes. A value of 00000 means the zip is 
not in a metro or micro area

The source of this data is [HUD](https://www.huduser.gov/portal/datasets/usps_crosswalk.html).
The files downloaded are:

- ZIP_CBSA_CCYYMM (zip to MSAs)
- ZIP_CBSA_DIV_CCYYMM (zip to MSA Divisions (division only))
- ZIP_CTY_CCYYMM (zip to county)
- state.txt (state fips codes)

Note that there are zip codes in more than one MSA. This information is
retained in the final table. The input data also includes the percent
of addresses in the zip/cbsa intersection which are residential. This is
also retained in the CBSA tables.

** Fannie Data**

This data is downloaded directly from [fannie](https://capitalmarkets.fanniemae.com/credit-risk-transfer/single-family-credit-risk-transfer/fannie-mae-single-family-loan-performance-data)

There is no pre-processing other than unzipping the files.

### Databases and Tables

The following are created by this package:

- **fhfa** database
  - *msad*  HPI at MSA/division level
  - *state* HPI at the state level
  - *state_non_msa* HPI at state level excluding msas
  - *zip3* HPI at the zip3 level
  - *msad_map* map of MSA/division to their name  
    
- **rates** database
  - *daily_raw* daily interest rates, as read in
  - *weekly_raw* weekly interest rates, as read in
  - *monthly* monthly rates, constructed by averaging the values in the
    first two tables
    
- **econ** database
  - *unemp_cbsa* unemployment at the CBSA level
  - *unemp_cbsad* unemployment at the CBSA/Division level
  - *unemp_micro* unemployment at the micropolitan level
  - *unemp_msa* unemployment at the MSA level
  - *unemp_msa* unemployment at the MSA/Division level
  - *unemp_state* unemployment at the State level.
    
- **map** database
  - *st_cd* State FIPS codes
  - *zip_cbsa* Zip to CBSA code map
  - *zip_cbsad* Zip to CBSA/Division code map
  - *zip_cty* Zip to county FIPs code map.
    
- **fannie** database
  - *final* Fannie loan-level dataset annotated with HPI, rates
    and unemployment.
  
  The 3-digit Zip FHFA HPI is used
    
