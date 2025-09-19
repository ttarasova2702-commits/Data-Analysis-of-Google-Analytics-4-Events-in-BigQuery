# Data-Analysis-of-Google-Analytics-4-Events-in-BigQuery
 Conducted data extraction and analysis from Google Analytics 4 (GA4) in BigQuery, calculating session and conversion metrics to support data-driven marketing and reporting.

Tasks

  Task 1: Events Table Preparation
- Extracted GA4 events with user, session, and traffic source details.
- Filtered only relevant e-commerce events for 2021 (session start, view item, add to cart, checkout, purchase, etc.).
  
  Task 2: Cohort Analysis
- Prepared dataset for cohort-based retention and engagement analysis.
- Measured user activity and behavioral patterns over time.
  
  Task 3: Conversion Rates
- Calculated conversions:  
  - Session → Add to Cart  
  - Session → Checkout  
  - Session → Purchase  
- Aggregated results by date, source, medium, campaign.
  
  Task 4: Landing Page Performance
  - Extracted `page_path` from `page_location` at session start.
  - Calculated:
  - Unique sessions
  - Purchases
  - Conversion rate per landing page.
    
Tools
  BigQuery
  SQL
  Google Analytics 4 — data source

 Results: Clean datasets with GA4 user and session events.Conversion metrics, page performance, and engagement insights calculated.Data prepared for dashboards and reporting.
