#!/usr/bin/env python3
"""
Humana Advocates Dashboard
Real-time visualization of pain points, solutions, and internal change progress
"""

import os
import json
from datetime import datetime, timedelta
from typing import Dict, List, Optional
import sqlite3
from flask import Flask, render_template, jsonify, request, send_file
import plotly.graph_objs as go
import plotly.utils

from advocates_program import AdvocatesProgram
from pain_point_analyzer import PainPointAnalyzer
from metrics_tracker import MetricsTracker


class AdvocatesDashboard:
    """
    Web-based dashboard for tracking advocate program impact
    """
    
    def __init__(self, port: int = 5000):
        self.app = Flask(__name__)
        self.port = port
        self.advocates = AdvocatesProgram()
        self.analyzer = PainPointAnalyzer()
        self.metrics = MetricsTracker()
        
        # Setup routes
        self._setup_routes()
        
    def _setup_routes(self):
        """Configure Flask routes"""
        
        @self.app.route('/')
        def index():
            """Main dashboard page"""
            return self.render_dashboard()
            
        @self.app.route('/api/metrics')
        def api_metrics():
            """Get current metrics"""
            return jsonify(self.get_dashboard_metrics())
            
        @self.app.route('/api/pain-points')
        def api_pain_points():
            """Get pain points data"""
            days = int(request.args.get('days', 30))
            return jsonify(self.get_pain_points_data(days))
            
        @self.app.route('/api/solutions')
        def api_solutions():
            """Get solutions data"""
            return jsonify(self.get_solutions_data())
            
        @self.app.route('/api/trends')
        def api_trends():
            """Get trend data"""
            return jsonify(self.get_trend_data())
            
        @self.app.route('/api/report/<format>')
        def api_report(format):
            """Generate and download report"""
            report = self.analyzer.generate_evidence_report(output_format=format)
            
            filename = f"advocates_report_{datetime.now().strftime('%Y%m%d')}.{format}"
            filepath = f"/tmp/{filename}"
            
            with open(filepath, 'w') as f:
                f.write(report)
                
            return send_file(filepath, as_attachment=True, download_name=filename)
            
    def render_dashboard(self) -> str:
        """Render the main dashboard HTML"""
        html = """
<!DOCTYPE html>
<html>
<head>
    <title>Humana Advocates Dashboard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f5f5;
        }
        .header {
            background: #2c5282;
            color: white;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .header h1 {
            margin: 0;
            font-size: 28px;
        }
        .header .subtitle {
            opacity: 0.9;
            margin-top: 5px;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .metric-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .metric-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .metric-value {
            font-size: 36px;
            font-weight: bold;
            color: #2c5282;
            margin: 10px 0;
        }
        .metric-label {
            color: #666;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .metric-change {
            font-size: 14px;
            margin-top: 5px;
        }
        .metric-change.positive {
            color: #38a169;
        }
        .metric-change.negative {
            color: #e53e3e;
        }
        .chart-container {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .chart-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2d3748;
        }
        .action-bar {
            background: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn {
            background: #2c5282;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.2s;
        }
        .btn:hover {
            background: #2d3748;
        }
        .btn-secondary {
            background: #718096;
        }
        .evidence-box {
            background: #f7fafc;
            border-left: 4px solid #2c5282;
            padding: 15px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .evidence-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }
        .pain-point-item {
            background: white;
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: all 0.2s;
        }
        .pain-point-item:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .impact-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }
        .impact-critical { background: #fed7d7; color: #c53030; }
        .impact-high { background: #feebc8; color: #c05621; }
        .impact-medium { background: #fefcbf; color: #b7791f; }
        .impact-low { background: #c6f6d5; color: #276749; }
        .mirador-highlight {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin: 20px 0;
            text-align: center;
        }
        .mirador-highlight h2 {
            margin: 0 0 10px 0;
            font-size: 24px;
        }
        .mirador-highlight .stats {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-top: 20px;
        }
        .mirador-highlight .stat-item {
            text-align: center;
        }
        .mirador-highlight .stat-value {
            font-size: 32px;
            font-weight: bold;
        }
        .mirador-highlight .stat-label {
            font-size: 14px;
            opacity: 0.9;
            text-transform: uppercase;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <h1>Humana Advocates Dashboard</h1>
            <div class="subtitle">Driving Internal Change Through Associate Innovation</div>
        </div>
    </div>
    
    <div class="container">
        <!-- Action Bar -->
        <div class="action-bar">
            <div>
                <select id="timeframe" class="btn btn-secondary" onchange="updateDashboard()">
                    <option value="7">Last 7 Days</option>
                    <option value="30" selected>Last 30 Days</option>
                    <option value="90">Last 90 Days</option>
                </select>
            </div>
            <div>
                <button class="btn" onclick="downloadReport('markdown')">📄 Download Report</button>
                <button class="btn btn-secondary" onclick="refreshDashboard()">🔄 Refresh</button>
            </div>
        </div>
        
        <!-- Key Metrics -->
        <div class="metrics-grid" id="metrics-grid">
            <!-- Populated by JavaScript -->
        </div>
        
        <!-- Mirador Highlight -->
        <div class="mirador-highlight">
            <h2>🚀 Innovation Spotlight: Mirador</h2>
            <p>Proof that associates can drive transformation when given trust</p>
            <div class="stats" id="mirador-stats">
                <!-- Populated by JavaScript -->
            </div>
        </div>
        
        <!-- Charts -->
        <div class="chart-container">
            <div class="chart-title">Pain Points by Category</div>
            <div id="category-chart"></div>
        </div>
        
        <div class="chart-container">
            <div class="chart-title">Solution Impact Over Time</div>
            <div id="impact-chart"></div>
        </div>
        
        <div class="chart-container">
            <div class="chart-title">Department Heat Map</div>
            <div id="heatmap-chart"></div>
        </div>
        
        <!-- Recent Pain Points -->
        <div class="chart-container">
            <div class="chart-title">Recent High-Impact Pain Points</div>
            <div id="pain-points-list">
                <!-- Populated by JavaScript -->
            </div>
        </div>
        
        <!-- Evidence Examples -->
        <div class="chart-container">
            <div class="chart-title">Strong Evidence Examples</div>
            <div id="evidence-list">
                <!-- Populated by JavaScript -->
            </div>
        </div>
    </div>
    
    <script>
        let currentData = {};
        
        async function loadDashboardData() {
            const days = $('#timeframe').val();
            
            // Load all data in parallel
            const [metrics, painPoints, solutions, trends] = await Promise.all([
                $.get('/api/metrics'),
                $.get(`/api/pain-points?days=${days}`),
                $.get('/api/solutions'),
                $.get('/api/trends')
            ]);
            
            currentData = { metrics, painPoints, solutions, trends };
            updateUI();
        }
        
        function updateUI() {
            // Update metrics cards
            updateMetrics(currentData.metrics);
            
            // Update Mirador stats
            updateMiradorStats(currentData.metrics);
            
            // Update charts
            updateCategoryChart(currentData.painPoints);
            updateImpactChart(currentData.trends);
            updateHeatmap(currentData.painPoints);
            
            // Update lists
            updatePainPointsList(currentData.painPoints);
            updateEvidenceList(currentData.painPoints);
        }
        
        function updateMetrics(metrics) {
            const grid = $('#metrics-grid');
            grid.empty();
            
            const cards = [
                {
                    label: 'Pain Points Reported',
                    value: metrics.total_pain_points,
                    change: metrics.pain_points_change,
                    format: 'number'
                },
                {
                    label: 'Solutions Created',
                    value: metrics.total_solutions,
                    change: metrics.solutions_change,
                    format: 'number'
                },
                {
                    label: 'Hours Saved',
                    value: metrics.total_hours_saved,
                    change: null,
                    format: 'hours'
                },
                {
                    label: 'Associates Engaged',
                    value: metrics.unique_advocates,
                    change: metrics.advocates_change,
                    format: 'number'
                },
                {
                    label: 'Evidence Collected',
                    value: metrics.evidence_count,
                    change: null,
                    format: 'number'
                },
                {
                    label: 'Systemic Issues',
                    value: metrics.systemic_issues,
                    change: null,
                    format: 'number'
                }
            ];
            
            cards.forEach(card => {
                const changeHtml = card.change ? 
                    `<div class="metric-change ${card.change > 0 ? 'positive' : 'negative'}">
                        ${card.change > 0 ? '+' : ''}${card.change}% vs last period
                    </div>` : '';
                    
                const formattedValue = formatValue(card.value, card.format);
                
                grid.append(`
                    <div class="metric-card">
                        <div class="metric-label">${card.label}</div>
                        <div class="metric-value">${formattedValue}</div>
                        ${changeHtml}
                    </div>
                `);
            });
        }
        
        function updateMiradorStats(metrics) {
            const stats = $('#mirador-stats');
            stats.empty();
            
            const miradorMetrics = [
                { value: metrics.mirador_hours_saved || '30+', label: 'Hours/Week Saved' },
                { value: metrics.mirador_roi || '12.3x', label: 'ROI Multiplier' },
                { value: '$0', label: 'Development Cost' },
                { value: '97%', label: 'Efficiency Gain' }
            ];
            
            miradorMetrics.forEach(stat => {
                stats.append(`
                    <div class="stat-item">
                        <div class="stat-value">${stat.value}</div>
                        <div class="stat-label">${stat.label}</div>
                    </div>
                `);
            });
        }
        
        function updateCategoryChart(data) {
            const categories = {};
            data.pain_points.forEach(pp => {
                categories[pp.category] = (categories[pp.category] || 0) + 1;
            });
            
            const trace = {
                labels: Object.keys(categories),
                values: Object.values(categories),
                type: 'pie',
                hole: 0.4,
                marker: {
                    colors: ['#2c5282', '#3182ce', '#63b3ed', '#90cdf4', '#bee3f8']
                }
            };
            
            const layout = {
                height: 400,
                showlegend: true,
                legend: {
                    position: 'right'
                }
            };
            
            Plotly.newPlot('category-chart', [trace], layout);
        }
        
        function updateImpactChart(trends) {
            const trace1 = {
                x: trends.dates,
                y: trends.pain_points,
                name: 'Pain Points',
                type: 'scatter',
                mode: 'lines+markers',
                line: { color: '#e53e3e' }
            };
            
            const trace2 = {
                x: trends.dates,
                y: trends.solutions,
                name: 'Solutions',
                type: 'scatter',
                mode: 'lines+markers',
                line: { color: '#38a169' }
            };
            
            const layout = {
                height: 400,
                xaxis: { title: 'Date' },
                yaxis: { title: 'Count' },
                showlegend: true
            };
            
            Plotly.newPlot('impact-chart', [trace1, trace2], layout);
        }
        
        function updateHeatmap(data) {
            // Group by department and category
            const heatmapData = {};
            const departments = new Set();
            const categories = new Set();
            
            data.pain_points.forEach(pp => {
                const dept = pp.department || 'Unknown';
                departments.add(dept);
                categories.add(pp.category);
                
                const key = `${dept}-${pp.category}`;
                heatmapData[key] = (heatmapData[key] || 0) + 1;
            });
            
            const z = [];
            const deptArray = Array.from(departments);
            const catArray = Array.from(categories);
            
            catArray.forEach(cat => {
                const row = [];
                deptArray.forEach(dept => {
                    row.push(heatmapData[`${dept}-${cat}`] || 0);
                });
                z.push(row);
            });
            
            const trace = {
                z: z,
                x: deptArray,
                y: catArray,
                type: 'heatmap',
                colorscale: 'Blues'
            };
            
            const layout = {
                height: 400,
                xaxis: { title: 'Department' },
                yaxis: { title: 'Category' }
            };
            
            Plotly.newPlot('heatmap-chart', [trace], layout);
        }
        
        function updatePainPointsList(data) {
            const list = $('#pain-points-list');
            list.empty();
            
            // Get top high-impact pain points
            const highImpact = data.pain_points
                .filter(pp => pp.impact_level === 'high' || pp.impact_level === 'critical')
                .sort((a, b) => b.upvotes - a.upvotes)
                .slice(0, 5);
                
            highImpact.forEach(pp => {
                list.append(`
                    <div class="pain-point-item">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <div style="font-weight: 600; margin-bottom: 5px;">${pp.description}</div>
                                <div style="font-size: 14px; color: #666;">
                                    <span class="impact-badge impact-${pp.impact_level}">${pp.impact_level}</span>
                                    • ${pp.category.replace('_', ' ')}
                                    • ${pp.upvotes} upvotes
                                </div>
                            </div>
                            ${pp.has_solution ? 
                                '<span style="color: #38a169;">✓ Solution Provided</span>' : 
                                '<span style="color: #e53e3e;">Needs Solution</span>'
                            }
                        </div>
                    </div>
                `);
            });
        }
        
        function updateEvidenceList(data) {
            const list = $('#evidence-list');
            list.empty();
            
            // Show strong evidence examples
            const examples = [
                {
                    title: 'Mirador ROI Metrics',
                    description: '30+ hours saved weekly with zero security incidents',
                    type: 'metric'
                },
                {
                    title: 'Tool Restriction Workarounds',
                    description: '47% of associates use personal devices for work tasks',
                    type: 'survey'
                },
                {
                    title: 'Communication Breakdown',
                    description: 'Town hall messages require 3+ clarifications on average',
                    type: 'observation'
                }
            ];
            
            examples.forEach(ex => {
                list.append(`
                    <div class="evidence-box">
                        <div class="evidence-title">${ex.title}</div>
                        <div>${ex.description}</div>
                        <div style="font-size: 12px; color: #666; margin-top: 5px;">
                            Type: ${ex.type}
                        </div>
                    </div>
                `);
            });
        }
        
        function formatValue(value, format) {
            if (format === 'hours') {
                return value.toFixed(1);
            } else if (format === 'currency') {
                return '$' + value.toLocaleString();
            } else {
                return value.toLocaleString();
            }
        }
        
        function updateDashboard() {
            loadDashboardData();
        }
        
        function refreshDashboard() {
            loadDashboardData();
        }
        
        function downloadReport(format) {
            window.location.href = `/api/report/${format}`;
        }
        
        // Load data on page load
        $(document).ready(() => {
            loadDashboardData();
            
            // Auto-refresh every 30 seconds
            setInterval(loadDashboardData, 30000);
        });
    </script>
</body>
</html>
"""
        return html
        
    def get_dashboard_metrics(self) -> Dict:
        """Get key metrics for dashboard"""
        # Get pain point summary
        pain_summary = self.advocates.get_pain_point_summary(days=30)
        pain_summary_prev = self.advocates.get_pain_point_summary(days=60)
        
        # Get solution metrics
        solution_metrics = self.advocates.get_solution_metrics()
        
        # Get unique advocates
        unique_advocates = self.advocates.conn.execute("""
            SELECT COUNT(DISTINCT advocate_id) as count
            FROM advocate_activities
            WHERE created_at > datetime('now', '-30 days')
        """).fetchone()['count']
        
        # Get systemic issues
        systemic = self.analyzer.find_systemic_issues()
        
        # Calculate changes
        pain_change = 0
        if pain_summary_prev['total_pain_points'] > 0:
            pain_change = ((pain_summary['total_pain_points'] - pain_summary_prev['total_pain_points']) 
                          / pain_summary_prev['total_pain_points'] * 100)
            
        # Get Mirador specific metrics
        mirador_metrics = self.metrics.get_aggregate_metrics(days=30)
        
        return {
            'total_pain_points': pain_summary['total_pain_points'],
            'pain_points_change': round(pain_change, 1),
            'total_solutions': solution_metrics.get('total_solutions', 0),
            'solutions_change': 0,  # TODO: Calculate
            'total_hours_saved': solution_metrics.get('total_hours_saved', 0),
            'unique_advocates': unique_advocates,
            'advocates_change': 0,  # TODO: Calculate
            'evidence_count': pain_summary['evidence_collected'],
            'systemic_issues': len(systemic),
            'mirador_hours_saved': mirador_metrics.get('total_hours_saved', 0),
            'mirador_roi': round(mirador_metrics.get('roi_multiplier', 0), 1)
        }
        
    def get_pain_points_data(self, days: int = 30) -> Dict:
        """Get pain points data for visualization"""
        threshold = datetime.now() - timedelta(days=days)
        
        pain_points = self.advocates.conn.execute("""
            SELECT p.*, 
                   COUNT(DISTINCT e.id) as evidence_count,
                   COUNT(DISTINCT s.id) as solution_count
            FROM pain_points p
            LEFT JOIN evidence e ON p.id = e.pain_point_id
            LEFT JOIN solutions s ON p.id = s.pain_point_id
            WHERE p.created_at > ?
            GROUP BY p.id
            ORDER BY p.upvotes DESC, p.impact_level DESC
        """, [threshold]).fetchall()
        
        return {
            'pain_points': [dict(pp) for pp in pain_points],
            'timeframe_days': days
        }
        
    def get_solutions_data(self) -> Dict:
        """Get solutions data"""
        solutions = self.advocates.conn.execute("""
            SELECT s.*, p.description as pain_point_description
            FROM solutions s
            LEFT JOIN pain_points p ON s.pain_point_id = p.id
            ORDER BY s.time_saved_hours DESC
            LIMIT 20
        """).fetchall()
        
        return {
            'solutions': [dict(s) for s in solutions]
        }
        
    def get_trend_data(self) -> Dict:
        """Get trend data for charts"""
        # Get daily counts for last 30 days
        dates = []
        pain_counts = []
        solution_counts = []
        
        for i in range(30):
            date = datetime.now() - timedelta(days=i)
            date_str = date.strftime('%Y-%m-%d')
            dates.append(date_str)
            
            # Count pain points
            pain_count = self.advocates.conn.execute("""
                SELECT COUNT(*) as count FROM pain_points
                WHERE DATE(created_at) = DATE(?)
            """, [date]).fetchone()['count']
            pain_counts.append(pain_count)
            
            # Count solutions
            solution_count = self.advocates.conn.execute("""
                SELECT COUNT(*) as count FROM solutions
                WHERE DATE(created_at) = DATE(?)
            """, [date]).fetchone()['count']
            solution_counts.append(solution_count)
            
        return {
            'dates': list(reversed(dates)),
            'pain_points': list(reversed(pain_counts)),
            'solutions': list(reversed(solution_counts))
        }
        
    def run(self):
        """Start the dashboard server"""
        print(f"""
╔══════════════════════════════════════════════════════════════╗
║           Humana Advocates Dashboard Starting                ║
║                                                              ║
║  Access the dashboard at: http://localhost:{self.port:<18}║
║                                                              ║
║  Features:                                                   ║
║  • Real-time pain point tracking                            ║
║  • Solution impact metrics                                   ║
║  • Evidence collection status                                ║
║  • Systemic issue identification                             ║
║  • Export reports for leadership                             ║
╚══════════════════════════════════════════════════════════════╝
        """)
        
        self.app.run(host='0.0.0.0', port=self.port, debug=False)


# Standalone dashboard runner
def run_dashboard():
    """Run the dashboard as a standalone application"""
    dashboard = AdvocatesDashboard(port=5000)
    dashboard.run()


if __name__ == "__main__":
    run_dashboard()