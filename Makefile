HEADERS=FYE,TLO,EST_DATE,TERM_DATE,CHTR_CITY,FIRST_NAME,LAST_NAME,BLDG,STREET,CITY,STATE,ZIP,PD_COVERED_TO,LIABILITIES,DISBURSEMENTS,MEMBERS,F_NUMBER,XREF,F_CODE,TYPE_RPT,STATUS,CHTR_CNTY,CHTR_ST,AFF_CODE,AFF_NAME,D_NAME,D_PFIX,D_NUM,D_SFIX,U_NAME,M_NAME,M_ADDRESS,M_CITY,M_ST,M_ZIP,FFC,F_ASSETS,F_RECEIPTS

.PHONY : all
all : lm.db lm.csv

lm.db : lm.csv
	csvs-to-sqlite $< $@

lm.csv : lm060126.csv lm070227.csv
	csvstack $^ > $@

%.csv : %.dat %.dct
	python scripts/dat_to_csv.py $^ | csvcut -c $(HEADERS) > $@

lm060126.dat : LORS2006_ascii.zip
	unzip -DD $<

lm070227.dat : LORS2007_ascii.zip
	unzip -DD $<

LORS2006_ascii.zip:
	wget -O $@ http://users.econ.umn.edu/~holmes/data/LORS/LORS2006_ascii.zip

LORS2007_ascii.zip:
	wget -O $@ http://users.econ.umn.edu/~holmes/data/LORS/LORS2007_ascii.zip



