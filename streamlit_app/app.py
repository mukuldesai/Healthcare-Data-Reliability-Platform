import streamlit as st
import pandas as pd
import snowflake.connector
import plotly.express as px

st.set_page_config(
    page_title="Healthcare Data Reliability Platform",
    layout="wide"
)

st.title("🏥 Healthcare Data Reliability Platform")
st.caption("Snowflake + dbt + Monitoring + Streamlit")
st.write("App started successfully")
st.write("Snowflake config loaded:", "snowflake" in st.secrets)

# -----------------------------
# Snowflake Connection
# -----------------------------
@st.cache_resource
def get_connection():
    try:
        conn = snowflake.connector.connect(
            user=st.secrets["snowflake"]["user"],
            password=st.secrets["snowflake"]["password"],
            account=st.secrets["snowflake"]["account"],
            warehouse=st.secrets["snowflake"]["warehouse"],
            database=st.secrets["snowflake"]["database"],
            schema=st.secrets["snowflake"]["schema"],
            role=st.secrets["snowflake"]["role"]
        )
        return conn
    except Exception as e:
        st.error(f"Snowflake connection failed: {e}")
        st.stop()


@st.cache_data(ttl=300)
def run_query(query):
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute(query)
        df = cur.fetch_pandas_all()
        cur.close()
        return df
    except Exception as e:
        st.error(f"Query failed: {e}")
        st.code(query)
        st.stop()


# -----------------------------
# Sidebar
# -----------------------------
section = st.sidebar.radio(
    "Navigation",
    [
        "Pipeline Health",
        "Row Counts",
        "Freshness",
        "Business Snapshot"
    ]
)

# -----------------------------
# Pipeline Health
# -----------------------------
if section == "Pipeline Health":
    st.subheader("Pipeline Health Dashboard")

    df = run_query("""
        select *
        from PIPELINE_HEALTH_DASHBOARD
        order by model_name
    """)

    st.dataframe(df, use_container_width=True)

    status_counts = df["PIPELINE_STATUS"].value_counts().reset_index()
    status_counts.columns = ["Status", "Count"]

    fig = px.bar(
        status_counts,
        x="Status",
        y="Count",
        title="Pipeline Status Summary"
    )

    st.plotly_chart(fig, use_container_width=True)


# -----------------------------
# Row Counts
# -----------------------------
elif section == "Row Counts":
    st.subheader("Row Count Monitoring")

    df = run_query("""
        select *
        from ROW_COUNT_MONITORING
        order by row_count desc
    """)

    st.dataframe(df, use_container_width=True)

    fig = px.bar(
        df,
        x="MODEL_NAME",
        y="ROW_COUNT",
        title="Rows by Table / Model"
    )

    st.plotly_chart(fig, use_container_width=True)


# -----------------------------
# Freshness
# -----------------------------
elif section == "Freshness":
    st.subheader("Freshness Monitoring")

    df = run_query("""
        select *
        from FRESHNESS_MONITORING
        order by latest_record_timestamp desc
    """)

    st.dataframe(df, use_container_width=True)


# -----------------------------
# Business Snapshot
# -----------------------------
elif section == "Business Snapshot":
    st.subheader("Business Snapshot")

    col1, col2, col3 = st.columns(3)

    encounters = run_query("""
        select count(*) as total_encounters
        from FCT_ENCOUNTERS
    """)

    claims = run_query("""
        select count(*) as total_claims
        from FCT_CLAIMS
    """)

    hospitals = run_query("""
        select count(*) as total_hospitals
        from DIM_HOSPITAL
    """)

    col1.metric("Total Encounters", int(encounters.iloc[0, 0]))
    col2.metric("Total Claims", int(claims.iloc[0, 0]))
    col3.metric("Hospitals", int(hospitals.iloc[0, 0]))

    top_hospitals = run_query("""
        select organization_name, utilization
        from DIM_HOSPITAL
        order by utilization desc
        limit 10
    """)

    fig = px.bar(
        top_hospitals,
        x="ORGANIZATION_NAME",
        y="UTILIZATION",
        title="Top Hospitals by Utilization"
    )

    st.plotly_chart(fig, use_container_width=True)