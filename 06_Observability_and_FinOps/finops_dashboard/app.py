import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

from finops_lib import load_sources, normalize, kpis

st.set_page_config(page_title="Multi-Cloud FinOps Dashboard", layout="wide")

st.title("Multi-Cloud FinOps Dashboard (AWS • Azure • GCP)")

data_dir = st.sidebar.text_input("Data directory", "data")
aws, az, gcp = load_sources(data_dir)
df = normalize(aws, az, gcp)

total, by_provider, by_group, monthly = kpis(df)

c1, c2, c3 = st.columns(3)
c1.metric("Total Cost (USD)", f"${total:,.2f}")
c2.metric("Top Provider", by_provider.iloc[0]['provider'])
c3.metric("Top Service Group", by_group.iloc[0]['service_group'])

st.subheader("Monthly Trend")
fig1 = plt.figure()
plt.plot(monthly["month"], monthly["cost_usd"])
plt.xticks(rotation=45)
plt.ylabel("Cost (USD)")
st.pyplot(fig1)

left, right = st.columns(2)

with left:
    st.subheader("Cost by Provider")
    st.dataframe(by_provider, use_container_width=True)

with right:
    st.subheader("Cost by Service Group")
    st.dataframe(by_group, use_container_width=True)

st.subheader("Raw Normalized Data")
st.dataframe(df.sort_values(["month","provider","service_group"]), use_container_width=True)
