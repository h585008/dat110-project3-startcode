#!/usr/bin/env python
# coding: utf-8

# In[4]:


from pycaret.regression import * 
import pandas as pd 
import numpy as np
import streamlit as st
from PIL import Image
import os


# In[9]:


class StreamlitApp:
    
    def __init__(self):
        self.model = load_model('model/Final_Huber_Model_10Nov2021') 
        self.save_fn = 'path.csv'     
        
    def predict(self, input_data): 
        return predict_model(self.model, data=input_data)
    
    def store_prediction(self, output_df): 
        if os.path.exists(self.save_fn):
            save_df = pd.read_csv(self.save_fn)
            save_df = save_df.append(output_df, ignore_index=True)
            save_df.to_csv(self.save_fn, index=False)
            
        else: 
            output_df.to_csv(self.save_fn, index=False)  
            
    
    def run(self):
        image = Image.open('assets/pretty_house.jpg')
        st.image(image, use_column_width=False)
    
    
      #  add_selectbox = st.sidebar.selectbox('How would you like to predict?', ('Online')) 
        st.sidebar.info('This app is created to predict house prices' )
        st.sidebar.success('DAT158')
        st.title('House prices prediction')
        
       
      #  if add_selectbox == 'Online': 
            
       
        OverallQual = st.number_input('OverallQual', min_value=1, max_value=10, value=5)
        MSZoning = st.selectbox('MSZoning', ['A', 'C', 'FV', 'I', 'RH', 'RL', 'RP','RM'])
        GrLivArea = st.number_input('GrLivArea', min_value=300, max_value=6000, value=1500)
        OverallCond = st.number_input('OverallCond', min_value=1, max_value=9, value=5)           
        GarageType = st.selectbox('GarageType', ['2Types', 'Attchd', 'Basment', 'BuiltIn', 'CarPort', 'Detchd', 'NA'])
        LandSlope = st.selectbox('LandSlope', ['Gtl', 'Mod', 'Sev'])
        FullBath = st.number_input('FullBath', min_value=0, max_value=5, value=0) 
        Neighborhood = st.selectbox('Neighborhood', ['Blmngtn', 'Blueste', 'BrDale', 'BrkSide', 'ClearCr', 
                                                         'CollgCr', 'Crawfor', 'Edwards', 'Gilbert', 'IDOTRR', 
                                                         'MeadowV', 'Mitchel', 'Names','NoRidge', 'NPkVill', 
                                                         'NridgHt', 'NWAmes', 'OldTown','SWISU', 'Sawyer', 
                                                         'SawyerW', 'Somerst', 'StoneBr', 'Timber', 'Veenker', 'Up', 'Down'])
        Functional = st.selectbox('Functional', ['Typ', 'Min1', 'Min2', 'Mod', 'Maj1', 'Maj2', 'Sev', 'Sal'])
            
            
        output=''
        input_dict = {'OverallQual':OverallQual, 'MSZoning':MSZoning, 'GrLivArea':GrLivArea, 'OverallCond':OverallCond, 
                          'GarageType':GarageType, 'LandSlope':LandSlope, 
                          'FullBath':FullBath, 'Neighborhood':Neighborhood, 'Functional':Functional, 'MSSubClass':0,
            'LotFrontage':0,
            'LotArea':0,
            'Street':"Null",
            'Alley':"Null",
            'LotShape':"Null",
            'LandContour':"Null",
            'Utilities':"Null",
            'LotConfig':"Null",
            'Condition1': "Null",
            'Condition2': "Null",
            'BldgType':"Null",
            'HouseStyle':"Null",
            'YearBuilt':0,
            'YearRemodAdd':0,
            'RoofStyle':"Null", 
            'RoofMatl':"Null",
            'Exterior1st':"Null",
            'Exterior2nd':"Null",
            'MasVnrType':"Null",
            'MasVnrArea':0,
            'ExterQual':"Null",
            'ExterCond':"Null",
            'Foundation':"Null",
            'BsmtQual':"Null",
            'BsmtCond':"Null",
            'BsmtExposure':"Null", 
            'BsmtFinType1':"Null",
            'BsmtFinSF1':0,
            'BsmtFinType2':"Null",
            'BsmtFinSF2':0,
            'BsmtUnfSF':0,
            'TotalBsmtSF':0, 
            'Heating':"Null",
            'HeatingQC':"Null", 
            'CentralAir':"Null",
            'Electrical':"Null",
            '1stFlrSF':0, 
            '2ndFlrSF':0,
            'LowQualFinSF':0,
            'BsmtFullBath':0,
            'BsmtHalfBath':0,
            'HalfBath':0,
            'BedroomAbvGr':0,
            'KitchenAbvGr':0,
            'KitchenQual':"Null",
            'TotRmsAbvGrd':0, 
            'Fireplaces':0,
            'FireplaceQu':"Null",
            'GarageYrBlt':0,
            'GarageFinish':"Null",
            'GarageCars':0,
            'GarageArea':0,
            'GarageQual':"Null",
            'GarageCond':"Null",
            'PavedDrive':"Null",
            'WoodDeckSF':0,
            'OpenPorchSF':0,
            'EnclosedPorch':0,
            '3SsnPorch':0,
            'ScreenPorch':0,
            'PoolArea':0,
            'PoolQC':"Null",
            'Fence':"Null",
            'MiscFeature':"Null",
            'MiscVal':0,
            'MoSold':0,
            'YrSold':0, 
            'SaleType':"Null",
            'SaleCondition':"Null"}
            
        input_df = pd.DataFrame(input_dict, index=[0])
        
        if st.button('Predict'):
            output = self.predict(input_df)
            self.store_prediction(output)
            
        st.success('Predicted output: ')
        st.write(output['Label']
                     
sa = StreamlitApp()
sa.run()
