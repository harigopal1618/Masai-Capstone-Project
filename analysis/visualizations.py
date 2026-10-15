# Task 11 — Two visualizations (analysis/visualize.py)
import os
import matplotlib.pyplot as plt

# Create directory if it doesn't exist
os.makedirs('visualizations', exist_ok=True)

# --- Visualization 1: Return Rate by Payment Method ---
# Sort descending
hypothesis_sorted = hypothesis_test.sort_values(by='Return Rate (%)', ascending=False)

plt.figure(figsize=(8, 5))
bars = plt.bar(
    hypothesis_sorted['Payment Method'],
    hypothesis_sorted['Return Rate (%)'],
    color=['#e74c3c', '#3498db', '#2ecc71'],
    edgecolor='black'
)

# Add exact percentage labels on top of each bar
for bar in bars:
    yval = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width()/2.0,
        yval + 1,
        f"{yval:.1f}%",
        ha='center',
        va='bottom',
        fontweight='bold'
    )

plt.title("COD Returns at 44.4% — 3x Card", fontsize=14, fontweight='bold', pad=15)
plt.xlabel("Payment Method", fontsize=11)
plt.ylabel("Return Rate (%)", fontsize=11)
plt.ylim(0, 50)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.tight_layout()
plt.savefig('visualizations/return_rate_by_payment.png', dpi=150)
plt.show()
plt.close()


# --- Visualization 2: Outlier-Corrected Monthly Revenue Trend ---
# Convert Period Index to String for plotting
months_str = [str(m) for m in monthly_without_outliers.index]
values = monthly_without_outliers.values

plt.figure(figsize=(10, 5))
plt.plot(
    months_str,
    values,
    marker='o',
    linewidth=2.5,
    color='#2c3e50',
    markerfacecolor='#e74c3c',
    markersize=8
)

# Annotate the peak month (March)
for i, (m, v) in enumerate(zip(months_str, values)):
    if m == '2026-03':
        plt.annotate(
            f"Peak: ₹{v:,.2f}",
            xy=(m, v),
            xytext=(i, v + 1000),
            arrowprops=dict(facecolor='black', shrink=0.08, width=1, headwidth=6),
            fontweight='bold',
            ha='center'
        )
    else:
        plt.text(i, v - 1000, f"₹{v:,.0f}", ha='center', va='top', fontsize=9, color='#555555')

plt.title("Outlier-Corrected Monthly Revenue (True Peak: March 2026)", fontsize=14, fontweight='bold', pad=15)
plt.xlabel("Month (Year-Month)", fontsize=11)
plt.ylabel("Total Order Value (₹)", fontsize=11)
plt.ylim(5000, 25000)
plt.grid(True, linestyle='--', alpha=0.5)
plt.tight_layout()
plt.savefig('visualizations/monthly_revenue_trend.png', dpi=150)
plt.show()
plt.close()
