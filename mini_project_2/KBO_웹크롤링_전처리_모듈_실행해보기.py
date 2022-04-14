import KBO_웹크롤링_전처리_모듈 as kwp

year, path = kwp.run_start()
path, source_data_path = kwp.kbo_record_web_crawling(year, path)
kwp.kbo_preprocessing(path, source_data_path)