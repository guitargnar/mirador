

echo "Setting up weekly Mirador maintenance..."


(crontab -l 2>/dev/null; echo "0 2 * * 0 cd $(pwd) && ./mirador_maintenance.sh") | crontab -

echo "✓ Weekly maintenance scheduled for Sundays at 2 AM"
echo "✓ Logs will be saved in maintenance_logs/"
echo ""
echo "To run maintenance manually: ./mirador_maintenance.sh"
echo "To view scheduled jobs: crontab -l"
