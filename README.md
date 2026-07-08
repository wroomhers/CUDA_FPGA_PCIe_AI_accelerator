# PCIe XDMA DDR AI Accelerator Test

![Vivado](https://img.shields.io/badge/Vivado-2025.2-orange)
![FPGA](https://img.shields.io/badge/FPGA-XC7A35T--FGG484--2-blue)
![PCIe](https://img.shields.io/badge/PCIe-Gen2%20x2-green)
![DDR3](https://img.shields.io/badge/Memory-DDR3-lightgrey)

Bu depo, Artix-7 tabanlı bir FPGA üzerinde PCIe üzerinden erişilebilen DDR3 bellek ve AXI-Stream tabanlı basit bir yapay zeka hızlandırıcı hattını test etmek için hazırlanmış Vivado projesidir.

Tasarımın ana fikri şudur: host bilgisayar PCIe XDMA üzerinden FPGA'ya erişir, DDR3 belleğe veri yazar/okur, AXI DMA bu veriyi HLS ile üretilmiş `fpga_relu_accelerator` IP'sine stream olarak taşır ve sonuç tekrar DDR3'e yazılır.

## Mimari

```text
Host PC
  |
  | PCIe Gen2 x2
  v
XDMA
  |
  v
AXI Interconnect
  |------------------> MIG 7-Series DDR3 Controller
  |------------------> AXI DMA kontrol register'ları
  |------------------> fpga_relu_accelerator kontrol register'ları

DDR3 -> AXI DMA MM2S -> fpga_relu_accelerator -> AXI DMA S2MM -> DDR3
```

## Teknik Özet

| Özellik | Değer |
| --- | --- |
| Vivado sürümü | 2025.2 |
| FPGA parçası | `xc7a35tfgg484-2` |
| Top module | `PCIe_wrapper` |
| Block design | `pcie_xdma_ddr_ai_accel_test.srcs/sources_1/bd/PCIe/PCIe.bd` |
| PCIe IP | `xdma:4.2` |
| PCIe link | Gen2, x2, 5.0 GT/s |
| XDMA AXI arayüzü | 64-bit AXI master, 125 MHz |
| XDMA kanalları | 1 read, 1 write |
| DDR kontrolcü | `mig_7series:4.2` |
| DDR adres alanı | 1 GB |
| AXI DMA | Scatter-Gather kapalı, MM2S + S2MM |
| HLS IP | `fpga_relu_accelerator:1.0` |
| Hızlandırıcı veri yolu | 32-bit AXI-Stream giriş/çıkış |
| Debug LED | Active-low 4-bit build/version göstergesi |

## Adres Haritası

Adresler XDMA `M_AXI` tarafından görülen bellek haritasıdır.

| Blok | Base address | Aralık |
| --- | ---: | ---: |
| DDR3 bellek | `0x00000000` | `1G` |
| ReLU accelerator AXI-Lite kontrol | `0x40010000` | `64K` |
| AXI DMA register'ları | `0x41E00000` | `64K` |

## Proje Yapısı

```text
.
|-- pcie_xdma_ddr_ai_accel_test.xpr        # Vivado proje dosyası
|-- pcie_xdma_ddr_ai_accel_test.srcs/
|   |-- sources_1/bd/PCIe/PCIe.bd          # Ana block design
|   |-- sources_1/new/build_version_led.v  # Active-low LED modülü
|   `-- constrs_1/new/                     # Pin ve timing constraint dosyaları
|-- pcie_xdma_ddr_ai_accel_test.runs/
|   `-- impl_1/PCIe_wrapper.bit            # Üretilmiş bitstream
|-- ledli_1.mcs                            # Flash programlama çıktısı
`-- ledli_1.prm                            # Flash programlama parametreleri
```

`*.runs`, `*.cache`, `*.gen`, `*.hw`, `*.sim` ve `*.ip_user_files` gibi Vivado çıktıları `.gitignore` ile göz ardı edilir. Bu klasörler yerel derleme sırasında Vivado tarafından yeniden üretilebilir.

## Gereksinimler

- AMD/Xilinx Vivado 2025.2
- `xc7a35tfgg484-2` hedefli Artix-7 FPGA kartı
- PCIe endpoint testleri için host tarafta Xilinx XDMA sürücüsü
- HLS IP deposu: proje `../../vitis_workspace/relu_accelerator` yolunu IP repository olarak referanslıyor. Farklı bir klasör kullanıyorsan Vivado içinde IP repository yolunu güncelle.

## Vivado ile Kullanım

Projeyi açmak için:

```bash
vivado pcie_xdma_ddr_ai_accel_test.xpr
```

Vivado içinde önerilen akış:

1. `PCIe.bd` block design dosyasını aç.
2. IP repository yolunun `fpga_relu_accelerator` IP'sini gördüğünden emin ol.
3. `Validate Design` çalıştır.
4. Gerekirse `Generate Output Products` çalıştır.
5. Synthesis, implementation ve bitstream adımlarını başlat.

Tcl üzerinden aynı akış:

```tcl
launch_runs synth_1 -jobs 8
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
```

Üretilen bitstream:

```text
pcie_xdma_ddr_ai_accel_test.runs/impl_1/PCIe_wrapper.bit
```

Flash için hazır MCS çıktısı:

```text
ledli_1.mcs
```

## Host Tarafı Test Akışı

Bu depo host test yazılımı içermiyor; ancak beklenen kullanım akışı şöyledir:

1. FPGA'yı bitstream veya MCS ile programla.
2. Host sistemde XDMA sürücüsünün yüklendiğini ve PCIe cihazının enumerate olduğunu doğrula.
3. XDMA karakter aygıtları üzerinden DDR3 adres alanına giriş verisini yaz.
4. AXI DMA ve `fpga_relu_accelerator` kontrol register'larını programla.
5. DMA tamamlanınca sonuç buffer'ını DDR3 üzerinden geri oku.

Linux tarafında cihazın görünürlüğünü hızlıca kontrol etmek için:

```bash
lspci -d 10ee:
```

## Debug Notları

- `build_version_led.v` içindeki varsayılan `VERSION = 4'h1` değeridir.
- `version_led_n` sinyalleri active-low çalışacak şekilde terslenmiştir.
- LED pinleri `debug_leds.xdc` içinde `L13`, `M13`, `K14`, `K13` olarak atanmıştır.
- Son yerel implementation loguna göre bitstream başarıyla üretilmiş, DRC 0 hata ile tamamlanmış ve post-route timing karşılanmıştır.

## Dikkat Edilecekler

- `PCIe.xdc` dosyasında Xilinx örnek template yorumları bulunuyor; gerçek hedef parça ve PCIe link ayarları için proje/BD değerlerini esas al.
- Kart pinleri ve reset/clock polariteleri kullanılan fiziksel karta göre mutlaka tekrar kontrol edilmeli.
- HLS IP yeniden üretilecekse `fpga_relu_accelerator` IP'sinin interface isimlerinin (`in_data`, `out_data`, `s_axi_ctrl`) block design ile uyumlu kalması gerekir.
