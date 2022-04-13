#!/usr/bin/env python
# coding: utf-8

# In[103]:


import pandas as pd
import os


# In[60]:


# 각 포지션별로 연도별 데이터 합치기
main_path = 'C:/Users/admin/Desktop/KBO 데이터/'
position_folder_list = os.listdir(main_path)
for i in range(len(position_folder_list)) :
    position_folder_path = f'{main_path}/{position_folder_list[i]}'
    year_file_list = os.listdir(position_folder_path)
    tmp_df = pd.DataFrame()
    for j in range(len(year_file_list)) :
        final_path = position_folder_path + '/' + year_file_list[j]
        df = pd.read_csv(position_folder_path + '/' + year_file_list[j], index_col = 0)
        df['연도'] = year_file_list[j][:4]
        tmp_df = pd.concat([tmp_df, df], ignore_index = True)     
    tmp_df = tmp_df[(tmp_df['팀명'] != '합계')].fillna(0)
    tmp_df = tmp_df.groupby(['연도', '순위', '팀명']).sum()
    tmp_df.to_csv(main_path + '/' +  position_folder_list[i] + '.csv')
    
# 데이터 통합하기
main_path = 'C:/Users/admin/Desktop/KBO 데이터/'
position_folder_list = os.listdir(main_path)
list_csv_file = [file for file in position_folder_list if file.endswith('.csv')]
tmp_df = pd.DataFrame()
tmp_df = pd.read_csv(list_csv_file[0]).sort_values(by = ['연도', '팀명'])[['연도', '팀명']].reset_index(drop = True)
for i in range(len(list_csv_file)) :
    file_path = main_path + list_csv_file[i]
    df = pd.read_csv(file_path).sort_values(by = ['연도', '팀명']).drop(['연도', '순위', '팀명'], axis = 1).reset_index(drop = True)
    tmp_df = pd.concat([tmp_df, df], axis = 1)
tmp_df.to_csv(main_path + 'KBO 데이터 통합.csv', index = False)


# In[80]:


tmp_df


# In[115]:


# 전처리 함수 만들어보기
def KBO_preprocessing(path) :
    '''
    path : 전처리한 csv 파일을 다운로드 받을 경로 설정
    '''
    import pandas as pd
    import os
    
    # 각 포지션별로 연도별 데이터 합치기
    main_path = path
    position_folder_list = os.listdir(main_path)
    for i in range(len(position_folder_list)) :
        position_folder_path = f'{main_path}/{position_folder_list[i]}'
        year_file_list = os.listdir(position_folder_path)
        tmp_df = pd.DataFrame()
        for j in range(len(year_file_list)) :
            final_path = position_folder_path + '/' + year_file_list[j]
            df = pd.read_csv(position_folder_path + '/' + year_file_list[j], index_col = 0)
            df['연도'] = year_file_list[j][:4]
            tmp_df = pd.concat([tmp_df, df], ignore_index = True)     
        tmp_df = tmp_df[(tmp_df['팀명'] != '합계')].fillna(0)
        tmp_df = tmp_df.groupby(['연도', '순위', '팀명']).sum()
        tmp_df.to_csv(main_path + '/' +  position_folder_list[i] + '.csv')

    # 데이터 통합하기
    main_path = path
    position_folder_list = os.listdir(main_path)
    list_csv_file = [file for file in position_folder_list if file.endswith('.csv')]
    tmp_df = pd.DataFrame()
    tmp_df = pd.read_csv(main_path + list_csv_file[0]).sort_values(by = ['연도', '팀명'])[['연도', '팀명']].reset_index(drop = True)
    for i in range(len(list_csv_file)) :
        file_path = main_path + list_csv_file[i]
        df = pd.read_csv(file_path).sort_values(by = ['연도', '팀명']).drop(['연도', '순위', '팀명'], axis = 1).reset_index(drop = True)
        tmp_df = pd.concat([tmp_df, df], axis = 1)
    tmp_df.to_csv(main_path + 'KBO 데이터 통합.csv', index = False)
    
KBO_preprocessing('C:/Users/admin/Desktop/새 폴더/')


# In[ ]:




