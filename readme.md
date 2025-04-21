### **International Debt Data Analysis – Process Documentation**

#### **Objective**
The goal of this analysis was to explore the `assignments.international_debt` dataset and extract insights related to the global debt situation by evaluating total debt, debt indicators, country-wise debt trends, and repayment behavior.

---

### **1. Preview of Data**
```sql
SELECT * FROM assignments.international_debt LIMIT 30;
```
**Purpose:**  
To get an initial understanding of the dataset structure, fields, and content. This helps in planning the subsequent analysis.

---

### **2. Total Global Debt**
```sql
SELECT (SUM(debt)/1000000)::numeric(12,2) AS total_debt_in_millions
FROM assignments.international_debt;
```
**Logic:**  
Summed all values in the `debt` column and converted the result to millions for easier interpretation.

**Insight:**  
This gives the **total debt owed globally** (in millions), providing a macro-level view of international debt.

---

### **3. Number of Unique Countries**
```sql
SELECT COUNT(DISTINCT country_name) AS number_of_unique_countries
FROM assignments.international_debt;
```
**Logic:**  
Used `DISTINCT` to count how many different countries are represented in the dataset.

**Insight:**  
Shows the **global coverage** of the dataset in terms of number of participating or recorded countries.

---

### **4. Debt Indicator Types**
```sql
SELECT DISTINCT indicator_name 
FROM assignments.international_debt;
```
**Logic:**  
Fetched unique values of `indicator_name` to understand the different debt-related metrics.

**Insight:**  
These indicators reflect **various types of debt metrics** (e.g., external debt, interest, principal repayments) and help categorize the financial obligations of countries.

---

### **5. Country with the Highest Debt**
```sql
SELECT country_name, SUM(debt) AS total_debt
FROM assignments.international_debt
WHERE country_name != ''
GROUP BY country_name 
ORDER BY total_debt DESC
LIMIT 1;
```
**Logic:**  
Grouped the data by country, calculated the total debt per country, and selected the one with the highest debt.

**Insight:**  
Identifies the **most indebted country**, giving a clear view of where the largest debt concentration lies.

---

### **6. Average Debt by Indicator**
```sql
SELECT indicator_name, AVG(debt) AS average_debt
FROM assignments.international_debt
GROUP BY indicator_name;
```
**Logic:**  
Computed the average debt value for each debt indicator.

**Insight:**  
Highlights which indicators typically involve **higher or lower financial amounts**, providing insights into debt structure.

---

### **7. Country with the Highest Principal Repayments**
```sql
SELECT country_name, SUM(debt) AS total_principal_repayments
FROM assignments.international_debt
WHERE indicator_name LIKE '%Principal repayments%' 
  AND debt IS NOT NULL 
  AND country_name != ''
GROUP BY country_name
ORDER BY total_principal_repayments DESC
LIMIT 1;
```
**Logic:**  
Filtered the dataset to include only principal repayment indicators, then calculated total repayments per country.

**Insight:**  
Reveals which country is **most actively repaying its debt principal**, possibly signaling strong fiscal responsibility or recent loan closures.

---

### **8. Most Common Debt Indicator**
```sql
SELECT indicator_name, COUNT(*) AS indicator_count
FROM (
  SELECT DISTINCT country_name, indicator_name
  FROM assignments.international_debt 
  WHERE indicator_name IS NOT NULL 
    AND indicator_name <> ''  
    AND country_name IS NOT NULL 
    AND country_name <> ''
  ORDER BY country_name
) AS distinct_pairs
GROUP BY indicator_name 
ORDER BY indicator_count DESC
LIMIT 1;
```
**Logic:**  
Counted how often each indicator appeared per country, using a distinct country-indicator pair to avoid duplicates.

**Insight:**  
Shows the **most universally reported or tracked debt indicator**, giving a sense of standardization in global debt metrics.

---

### **9. Key Debt Trends & Summary of Findings**
**Additional Observations:**
- **Debt distribution is uneven**: A few countries hold disproportionately high debts compared to others.
- **Principal repayments vary significantly**: Some countries are repaying large sums, while others show limited or no repayments.
- **Indicators vary in meaning and magnitude**: Some indicators have much higher average debts, implying structural or long-term debt components.
- **Data inconsistencies**: A few rows had empty or null values, which were filtered in queries to maintain accuracy.

**Summary:**
This analysis provided a detailed overview of international debt data, highlighting high-debt countries, repayment behavior, and commonly used debt indicators. The insights can help policymakers and researchers identify patterns in global debt management and reporting.

---

Would you like me to convert this into a formatted report or slide deck?