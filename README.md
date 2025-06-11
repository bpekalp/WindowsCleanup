# PowerShell Sistem Temizleyici Betiği 🧹✨

Bu PowerShell betiği, Windows sisteminizdeki geçici, önbellek ve gereksiz dosyaları otomatik olarak temizlemek için tasarlanmıştır. Disk alanını geri kazanmanıza ve sistem performansını potansiyel olarak artırmanıza yardımcı olur.

---

## Özellikler 🚀

* **Kapsamlı Temizlik:** `%TEMP%`, `C:\Windows\Temp`, `Prefetch`, `Recent` klasörleri ve Windows Hata Raporlama dosyaları gibi çeşitli geçici konumları hedefler.
* **Tarayıcı Önbelleği Temizliği:** Google Chrome, Microsoft Edge, Mozilla Firefox, Opera ve Brave gibi popüler tarayıcıların önbelleklerini temizler.
* **Windows Update Kalıntıları:** Windows Update tarafından indirilen geçici dosyaları siler.
* **Geri Dönüşüm Kutusu Boşaltma:** Sistemdeki geri dönüşüm kutusunu boşaltır.
* **Otomatik Onay:** Kullanıcı onayı istemeden otomatik olarak çalışır.
* **Disk Temizleme Sihirbazı Entegrasyonu:** İşlem sonunda Windows'un yerleşik Disk Temizleme Sihirbazı'nı başlatarak ek temizlik yapma imkanı sunar.
* **Görsel Geribildirim:** Her temizlik adımında renkli ve açıklayıcı mesajlar ile emoji'ler kullanarak kullanıcının süreci takip etmesini kolaylaştırır.

---

## Nasıl Kullanılır? 📖

1.  **Betiği İndirin:** Bu depodaki `WindowsCleanup.ps1` dosyasını bilgisayarınıza indirin.
2.  **Yönetici Olarak Çalıştırın:**
    * İndirdiğiniz `WindowsCleanup.ps1` dosyasına sağ tıklayın.
    * Bağlam menüsünden **"Yönetici olarak çalıştır"** (Run as Administrator) seçeneğini seçin.
    * PowerShell tarafından bir güvenlik uyarısı gelirse, betiği çalıştırmak için onay verin.

Betiği çalıştırdığınızda, temizleme işlemi otomatik olarak başlayacak ve tamamlandığında size bilgi verecektir.

---

## Önemli Notlar ve Uyarılar ⚠️

* **Yönetici Yetkisi:** Bu betiği çalıştırmak için **yönetici yetkileri** gereklidir. Yönetici olarak çalıştırmazsanız, betik otomatik olarak kapanacaktır.
* **`Prefetch` Klasörü:** `C:\Windows\Prefetch` klasöründeki dosyaların temizlenmesi, Windows'un uygulama başlangıç hızını yeniden optimize etmesine neden olabilir. Bu, ilk birkaç çalıştırmada bazı uygulamaların biraz daha yavaş açılmasına neden olabilir, ancak sistem zamanla bu verileri yeniden oluşturarak eski hızına dönecektir.
* **Tarayıcılar:** Betik çalışırken açık olan tarayıcılar, önbellek dosyalarını kilitli tutabilir ve bu durumda ilgili tarayıcı önbellekleri tam olarak temizlenemeyebilir. En iyi sonuçlar için betiği çalıştırmadan önce tarayıcılarınızı kapatmanız önerilir.
* **Hata Yönetimi:** Betik, bulunamayan yolları atlar ve çalışmaya devam eder. Herhangi bir hatayla karşılaşılırsa, konsola hata mesajı yazdırılır ancak betiğin tamamının durmasına neden olmaz.
