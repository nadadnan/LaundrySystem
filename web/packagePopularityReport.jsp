<%-- 
    Document   : packagePopularityReport
    Created on : 25 May 2025, 9:51:44 pm
    Author     : M S I
--%>

<%@ page import="java.util.*, com.Model.PackagePopularity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Package Popularity Report (Graph)</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Convert PDF -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                padding: 20px;
                max-width: 900px;
                margin: auto;
            }
            h2 {
                text-align: center;
                margin-bottom: 30px;
            }
            #chart-container {
                position: relative;
                height: 400px;
                width: 100%;
            }
            p.no-data {
                text-align: center;
                font-size: 1.2rem;
                color: #888;
                margin-top: 50px;
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
        <h2>Package Popularity Report</h2>

        <%
            List<PackagePopularity> report = (List<PackagePopularity>) request.getAttribute("report");
            if (report != null && !report.isEmpty()) {
                StringBuilder labels = new StringBuilder();
                StringBuilder timesOrdered = new StringBuilder();
                StringBuilder revenueGenerated = new StringBuilder();

                for (PackagePopularity p : report) {
                    labels.append("'").append(p.getPackageName().replace("'", "\\'")).append("',");
                    timesOrdered.append(p.getTimesOrdered()).append(",");
                    revenueGenerated.append(p.getRevenueGenerated()).append(",");
                }

                String labelStr = labels.length() > 0 ? labels.substring(0, labels.length() - 1) : "";
                String timesStr = timesOrdered.length() > 0 ? timesOrdered.substring(0, timesOrdered.length() - 1) : "";
                String revenueStr = revenueGenerated.length() > 0 ? revenueGenerated.substring(0, revenueGenerated.length() - 1) : "";
        %>

        <div id="chart-container">
            <canvas id="packageChart"></canvas>
        </div>

        <script>
            const ctx = document.getElementById('packageChart').getContext('2d');

            const packageChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [<%= labelStr%>],
                    datasets: [
                        {
                            label: 'Number of Times Ordered',
                            data: [<%= timesStr%>],
                            backgroundColor: 'rgba(54, 162, 235, 0.7)',
                            yAxisID: 'y1'
                        },
                        {
                            label: 'Revenue Generated (RM)',
                            data: [<%= revenueStr%>],
                            backgroundColor: 'rgba(255, 159, 64, 0.7)',
                            yAxisID: 'y2'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    stacked: false,
                    scales: {
                        y1: {
                            type: 'linear',
                            position: 'left',
                            title: {
                                display: true,
                                text: 'Times Ordered'
                            },
                            beginAtZero: true,
                        },
                        y2: {
                            type: 'linear',
                            position: 'right',
                            title: {
                                display: true,
                                text: 'Revenue (RM)'
                            },
                            beginAtZero: true,
                            grid: {
                                drawOnChartArea: false,
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: 'Package Popularity and Revenue'
                        }
                    }
                }
            });
        </script>

        <% } else { %>
        <p class="no-data">No package data found.</p>
        <% }%>

        <div style="text-align: center; margin: 20px 0;">
            <button onclick="downloadPDF()" class="back-btn">Download PDF</button>
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
                pdf.save("Package_Popularity_Report.pdf");
            }
        </script>


    </body>
</html>
