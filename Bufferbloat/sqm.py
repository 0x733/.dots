import speedtest

def main():
    st = speedtest.Speedtest()
    st.download()
    st.upload()
    
    download_speed_mbps = st.results.download / 1e6  # Mbps cinsinden download hızı
    upload_speed_mbps = st.results.upload / 1e6  # Mbps cinsinden upload hızı
    
    print(f"Mevcut Download Hızı: {download_speed_mbps:.2f} Mbps")
    print(f"Mevcut Upload Hızı: {upload_speed_mbps:.2f} Mbps")
    
    download_speed_kbps = download_speed_mbps * 1000  # kbps cinsinden download hızı
    upload_speed_kbps = upload_speed_mbps * 1000  # kbps cinsinden upload hızı
    
    download_speed_adjusted_kbps = download_speed_kbps * 0.9  # %10 azaltılmış download hızı
    upload_speed_adjusted_kbps = upload_speed_kbps * 0.9  # %10 azaltılmış upload hızı
    
    print(f"SQM için Ayarlanan Download Hızı: {download_speed_adjusted_kbps:.0f} kbps")
    print(f"SQM için Ayarlanan Upload Hızı: {upload_speed_adjusted_kbps:.0f} kbps")
    
    print("\nLütfen aşağıdaki değerleri OpenWRT cihazınıza manuel olarak girin:")
    print(f"Download Hızı: {int(download_speed_adjusted_kbps)} kbps")
    print(f"Upload Hızı: {int(upload_speed_adjusted_kbps)} kbps")

if __name__ == "__main__":
    main()
