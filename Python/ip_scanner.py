import ipaddress
import subprocess
import platform
import socket
from concurrent.futures import ThreadPoolExecutor

output_file = "scan_results.txt"

def scan_range(ip_range):
    try:
        net = ipaddress.ip_network(ip_range, strict=False)
    except ValueError as e:
        print(f"Invalid IP range: {e}")
        return

    print(f"Scanning range: {ip_range}...")
    results = []

    param = "-n" if platform.system().lower() == "windows" else "-c"

    def ping(ip):
        result = subprocess.run(["ping", param, "1", str(ip)],
                                stdout=subprocess.DEVNULL,
                                stderr=subprocess.DEVNULL)
        status = "UP" if result.returncode == 0 else "DOWN"
        domain = ""
        if status == "UP":
            try:
                domain = socket.gethostbyaddr(str(ip))[0]
            except socket.herror:
                domain = "-"
        results.append((status, str(ip), domain))

    with ThreadPoolExecutor(max_workers=50) as executor:
        executor.map(ping, net.hosts())

    # sort results by IP
    results.sort(key=lambda x: ipaddress.ip_address(x[1]))

    with open(output_file, "w") as f:
        for status, ip, domain in results:
            line = f"[{status:<5}]  {ip:<15}  domain: {domain}\n"
            f.write(line)

    print(f"Scan complete. Results saved in {output_file}")

if __name__ == "__main__":
    ip_range = input("Enter IP range (e.g. 192.168.1.0/24): ")
    scan_range(ip_range)
