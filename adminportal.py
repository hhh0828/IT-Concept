import tkinter as tk
from tkinter import ttk
import subprocess

def run_program(profile_path, url):
    program_path = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    
    try:
        subprocess.run([program_path, f'--profile-directory={profile_path}', url], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")

window = tk.Tk()
window.title("Admin Portal")
window.deiconify()

profile_paths = [
    "ECCK",
    "MaximusKR",
    "AngusKnight",
    "Mazars",
    "LBI",
    "IFRC",
    "ATID",
    "KSM",
    "Badaenergy",
    "Trillium",
    "SeoulWines",
    "Instrumentsystem"
]

# IT-Concept를 가장 위에 위치하도록 설정
profile_paths = ["IT-Concept"] + sorted(profile_paths)

url_admin = "https://admin.microsoft.com"
url_exchange = "https://admin.exchange.microsoft.com"
url_azure_portal = "https://portal.azure.com"
url_intune = "https://intune.microsoft.com/"

url_office = "https://office.com"
url_mimecast = "https://login-de.mimecast.com/u/login/?gta=apps&link=/home#/login"
url_remote_support = "https://support.it-concept.kr/Host#Support/All%20Sessions//f61f53cd-bdb9-4fdc-95c6-8875d969f348/Start"
url_ticket = "https://glpi2.it-concept.kr/front/central.php"
url_coreview = "https://www.loginportal.online/login?returnUrl=https:%2F%2Fportal.coreview.com"
url_servicenow = "https://mazars.service-now.com/login.do"
url_gpt = "https://chatgpt.com"
url_TFTticket = "https://trilliumflow.freshservice.com/a/dashboard/default"

label = tk.Label(window, text="Select the site that you want to access and add your account and set your profile so it keeps logon status. - copyright hyunho.hong", font=('TkDefaultFont', 16, 'bold'))
label.grid(row=0, column=1, columnspan=4, pady=15)

for i, profile_path in enumerate(profile_paths):
    ecck_label = tk.Label(window, text=profile_path, font=('TkDefaultFont', 14, 'italic'))
    ecck_label.grid(row=i+1, column=0, padx=20, pady=10, sticky='w')

    if profile_path == "IT-Concept":
        button_office = ttk.Button(window, text="[Office]", style='Cute.TButton', command=lambda path=profile_path, u=url_office: run_program(path, u))
        button_office.grid(row=i+1, column=1, pady=10, sticky='ew')

        button_remote_support = ttk.Button(window, text="[Remote Support]", style='Cute.TButton', command=lambda path=profile_path, u=url_remote_support: run_program(path, u))
        button_remote_support.grid(row=i+1, column=2, pady=10, sticky='ew')

        button_ticket = ttk.Button(window, text="[Ticket]", style='Cute.TButton', command=lambda path=profile_path, u=url_ticket: run_program(path, u))
        button_ticket.grid(row=i+1, column=3, pady=10, sticky='ew')

        button_gpt = ttk.Button(window, text="[GPT]", style='Cute.TButton', command=lambda path=profile_path, u=url_gpt: run_program(path, u))
        button_gpt.grid(row=i+1, column=4, pady=10, sticky='ew')
    elif profile_path == "Mazars":
        button_coreview = ttk.Button(window, text="[CoreView]", style='Cute.TButton', command=lambda path=profile_path, u=url_coreview: run_program(path, u))
        button_coreview.grid(row=i+1, column=1, pady=10, sticky='ew')

        button_servicenow = ttk.Button(window, text="[ServiceNow]", style='Cute.TButton', command=lambda path=profile_path, u=url_servicenow: run_program(path, u))
        button_servicenow.grid(row=i+1, column=2, pady=10, sticky='ew')

        button_mimecast = ttk.Button(window, text="[Mimecast]", style='Cute.TButton', command=lambda path=profile_path, u=url_mimecast: run_program(path, u))
        button_mimecast.grid(row=i+1, column=3, pady=10, sticky='ew')
        
    elif profile_path == "Trillium":
        button_office = ttk.Button(window, text="[Office]", style='Cute.TButton', command=lambda path=profile_path, u=url_office: run_program(path, u))
        button_office.grid(row=i+1, column=1, pady=10, sticky='ew')

        button_remote_support = ttk.Button(window, text="[TFTticket]", style='Cute.TButton', command=lambda path=profile_path, u=url_TFTticket: run_program(path, u))
        button_remote_support.grid(row=i+1, column=2, pady=10, sticky='ew')

        
    else:
        button_admin = ttk.Button(window, text="[Admin]", style='Cute.TButton', command=lambda path=profile_path, u=url_admin: run_program(path, u))
        button_admin.grid(row=i+1, column=1, pady=10, sticky='ew')

        button_exchange = ttk.Button(window, text="[Exchange]", style='Cute.TButton', command=lambda path=profile_path, u=url_exchange: run_program(path, u))
        button_exchange.grid(row=i+1, column=2, pady=10, sticky='ew')

        button_azure_portal = ttk.Button(window, text="[Portal Azure]", style='Cute.TButton', command=lambda path=profile_path, u=url_azure_portal: run_program(path, u))
        button_azure_portal.grid(row=i+1, column=3, pady=10, sticky='ew')

        button_intune = ttk.Button(window, text="[Intune]", style='Cute.TButton', command=lambda path=profile_path, u=url_intune: run_program(path, u))
        button_intune.grid(row=i+1, column=4, pady=10, sticky='ew')

for i in range(len(profile_paths) + 1):
    window.grid_columnconfigure(5, minsize=20)

style = ttk.Style()
style.configure('Cute.TButton', font=('TkDefaultFont', 12, 'bold'), relief='flat', borderwidth=0, background='pink', foreground='black', padding=10)

# 프로그램을 완전히 종료하도록 변경
window.protocol("WM_DELETE_WINDOW", window.quit)

for i in range(len(profile_paths) + 1):
    window.grid_rowconfigure(i, weight=1)

for j in range(6):
    window.grid_columnconfigure(j, weight=1)

window.mainloop()
#changes test