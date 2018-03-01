json.filter_html render partial: 'filter_list'
json.table_html render partial: 'orders_table', locals: { orders: @orders }
