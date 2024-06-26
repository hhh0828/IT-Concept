import tkinter as tk
from tkinter import ttk
import requests

def on_ok_click():
    for selected_item in selected_items:
        send_selection_to_server(selected_item)
    result_label.config(text="Selections sent to the server.")
    
def on_cancel_click():
    result_label.config(text="Operation canceled")

def on_select_click():
    selected_item = selectable_listbox.get(tk.ACTIVE)
    if selected_item not in selected_items:
        selected_items.append(selected_item)
        update_selected_listbox()
        notification_label.config(text="")
        
    else:
        notification_label.config(text=f"'{selected_item}' already selected", fg="red")

def undo_selection():
    selected_index = selected_listbox.curselection()
    if selected_index:
        selected_items.pop(selected_index[0])
        update_selected_listbox()

def update_selectable_listbox(event):
    search_text = search_var.get().lower()
    selectable_listbox.delete(0, tk.END)  # Clear the listbox
    for option in options:
        if search_text in option.lower():
            selectable_listbox.insert(tk.END, option)

def update_selected_listbox():
    selected_listbox.delete(0, tk.END)
    for item in selected_items:
        selected_listbox.insert(tk.END, item)

def send_selection_to_server(selected_item):
    server_url = "http://your_server_ip:your_server_port/receive_selection"
    data = {"selected_item": selected_item}

    try:
        response = requests.post(server_url, json=data)
        if response.status_code == 200:
            print("Selection sent to the server successfully.")
        else:
            print(f"Failed to send selection to the server. Status code: {response.status_code}")
            print(response.text)
    except Exception as e:
        print(f"An error occurred while sending selection to the server: {e}")


# Create main application window
app = tk.Tk()
app.title("User Interaction App")

# Create and configure selectable items listbox on the left
options = ["IT-concept", "KSM", "Mazars"]
selectable_listbox = tk.Listbox(app, selectmode=tk.SINGLE, exportselection=0)
for option in options:
    selectable_listbox.insert(tk.END, option)
selectable_listbox.pack(side=tk.LEFT, pady=10)

# Create and configure search box
search_label = tk.Label(app, text="Search:")
search_label.pack()
search_var = tk.StringVar()
search_entry = tk.Entry(app, textvariable=search_var)
search_entry.pack(pady=10)
search_entry.bind('<KeyRelease>', update_selectable_listbox)

# Create and configure buttons
ok_button = tk.Button(app, text="OK", command=on_ok_click)
ok_button.pack(side=tk.LEFT, padx=5)
cancel_button = tk.Button(app, text="Cancel", command=on_cancel_click)
cancel_button.pack(side=tk.LEFT, padx=5)
select_button = tk.Button(app, text="Select", command=on_select_click)
select_button.pack(side=tk.LEFT, padx=5)
undo_button = tk.Button(app, text="Undo", command=undo_selection)
undo_button.pack(side=tk.LEFT, padx=5)

# Create and configure selected items listbox on the right
selected_items = []
selected_listbox = tk.Listbox(app, selectmode=tk.SINGLE, exportselection=0)
selected_listbox.pack(side=tk.LEFT, pady=10)

# Create and configure notification label
notification_label = tk.Label(app, text="", fg="red")
notification_label.pack(pady=10)

# Display result label
result_label = tk.Label(app, text="")
result_label.pack(pady=10)

# Start the Tkinter event loop
app.mainloop()
