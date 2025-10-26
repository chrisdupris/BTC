{% macro convert_to_usd(amount_expr) %}
COALESCE({{ amount_expr }}, 0) * (
  SELECT price
  FROM {{ ref('btc_usd_max') }}
  WHERE TO_DATE(REPLACE(snapped_at,' UTC','')) <= CURRENT_DATE()
  ORDER BY TO_TIMESTAMP_NTZ(REPLACE(snapped_at,' UTC','')) DESC
  LIMIT 1
)
{% endmacro %}
