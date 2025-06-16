<%-- 
    Document   : salesReport
    Created on : 25 May 2025, 6:57:01 pm
    Author     : M S I
--%>

<%@ page import="java.util.Map" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Sales Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- Convert PDF -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            max-width: 960px;
            margin: auto;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .chart-container {
            position: relative;
            width: 100%;
            height: auto;
        }

        canvas {
            width: 100% !important;
            height: auto !important;
        }

        .no-data {
            text-align: center;
            padding: 50px 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        
        .back-btn {
    display: inline-block;
    padding: 10px 20px;
    background-color: #2c3e50;
    color: #fff;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 600;
    box-shadow: 0 4px 8px rgba(44, 62, 80, 0.3);
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .back-btn:hover {
    background-color: #1a252f;
    box-shadow: 0 6px 12px rgba(26, 37, 47, 0.5);
  }
  .back-btn-container {
    text-align: center;
    margin-top: 20px; /* add some spacing from above */
  }
    </style>
</head>
<body>

<div class="container">
    <h2>Monthly Sales Report</h2>
    <div id="chart-container" class="chart-container">
        <canvas id="salesChart"></canvas>
    </div>

<%
    Map<String, Double> salesData = (Map<String, Double>) request.getAttribute("salesData");

    if (salesData != null && !salesData.isEmpty()) {
        StringBuilder labels = new StringBuilder();
        StringBuilder values = new StringBuilder();

        for (Map.Entry<String, Double> entry : salesData.entrySet()) {
            labels.append("'").append(entry.getKey()).append("',");
            values.append(entry.getValue()).append(",");
        }

        String labelStr = labels.substring(0, labels.length() - 1);
        String valueStr = values.substring(0, values.length() - 1);
%>

<script>
    const ctx = document.getElementById('salesChart').getContext('2d');
    const salesChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<%= labelStr %>],
            datasets: [{
                label: 'Total Sales (RM)',
                data: [<%= valueStr %>],
                backgroundColor: 'rgba(54, 162, 235, 0.6)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1,
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                },
                tooltip: {
                    mode: 'index',
                    intersect: false,
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Month'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Sales (RM)'
                    }
                }
            }
        }
    });
</script>

<%
    } else {
%>
    <div class="no-data">
        <p>No sales data available for display.</p>
    </div>
<%
    }
%>

<div style="text-align: center; margin: 20px 0;">
    <button onclick="downloadPDF()" class="back-btn">Download PDF</button>
</div>


</div>
<div class="back-btn-container">
  <a href="view_reports.jsp" class="back-btn">← Back to Reports</a>
</div>

<!-- Convert PDF -->
        <script>
            async function downloadPDF() {
                const chartContainer = document.getElementById('chart-container');

                // Use html2canvas to capture the chart as an image
                const canvas = await html2canvas(chartContainer);

                // Create a new jsPDF instance
                const {jsPDF} = window.jspdf;
                const pdf = new jsPDF();

                // Get image data from canvas
                const imgData = canvas.toDataURL('image/png');

                // Calculate width & height to maintain aspect ratio
                const pdfWidth = pdf.internal.pageSize.getWidth();
                const imgProps = pdf.getImageProperties(imgData);
                const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;

                // Add image to PDF
                pdf.addImage(imgData, 'PNG', 0, 10, pdfWidth, pdfHeight);

                // Save the PDF
                pdf.save("Monthly_Sales_Report.pdf");

            }
        </script>
</body>
</html>
