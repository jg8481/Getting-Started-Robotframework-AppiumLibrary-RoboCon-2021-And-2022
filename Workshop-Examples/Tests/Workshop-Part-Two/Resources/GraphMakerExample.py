import os
import time
import psutil
import pandas
from datetime import datetime
from bokeh.models import ColumnDataSource, HoverTool
from bokeh.models import DatetimeTickFormatter
from bokeh.plotting import figure, output_file, show

class GraphMakerExample:
    ROBOT_LIBRARY_SCOPE = 'TEST'

    def create_mobile_device_memory_usage_graph(self):
        directory = os.getcwd()
        csv_path= os.path.join(directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "mobile-device-memory-usage-graph.csv")
        graph_path = os.path.join(directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "mobile-device-memory-usage-graph.html")
        df = pandas.read_csv(csv_path)
        plot = figure(title="Mobile Application Memory Usage On Device", toolbar_location='above', x_axis_label='Elapsed Time (Minutes & Seconds)', y_axis_label='Memory Usage %')
        plot.line(x=df.Elapsed_Time, y=df.Mobile_Device_Memory_Usage, legend_label="Mobile Application", line_width=2)
        hover_tool = HoverTool(tooltips=[('Mobile Device Memory Usage % Value', '@y')])
        output_file(graph_path)
        plot.add_tools(hover_tool)
        show(plot)
