# GPU-FPGA PCIe-DMA Yapay Zeka Hızlandırma Prototipi

![Vivado](https://img.shields.io/badge/Vivado-2025.2-orange)
![FPGA](https://img.shields.io/badge/FPGA-Artix--7%20XC7A35T-blue)
![PCIe](https://img.shields.io/badge/PCIe-Gen2%20x2-green)
![Memory](https://img.shields.io/badge/Memory-DDR3-lightgrey)

Bu repo, **"Yapay Zeka Uygulamalarında Yüksek Hızlı DMA Üzerinden CUDA ve FPGA Entegrasyonu ile Performans İyileştirme"** başlıklı bitirme çalışmasının FPGA/Vivado tarafını içerir.

Çalışmanın amacı FPGA'yı GPU'nun yerine koymak değil; GPU tabanlı yapay zeka akışlarında tekrar eden küçük ama sık kullanılan işlemleri PCIe-DMA üzerinden erişilen düşük güçlü FPGA hızlandırıcılarıyla desteklemektir. Tez kapsamında ReLU ve kuantizasyon gibi mikro işlemler incelenmiş; bu Vivado projesinde XDMA, AXI, DDR3/MIG, AXI DMA ve HLS tabanlı ReLU hızlandırıcı hattı bir araya getirilmiştir.

## Büyük Resim

Deneysel sistemde host bilgisayar, NVIDIA GTX 1660 SUPER GPU ve ALINX AX7A035B Artix-7 FPGA kartı aynı PCIe altyapısı üzerinde çalıştırılmıştır. Başlangıçta doğrudan GPU-FPGA GPUDirect RDMA/P2P aktarımı hedeflenmiş, ancak tüketici sınıfı GTX 1660 SUPER kısıtları nedeniyle nihai mimari **pinned host memory + Xilinx XDMA** akışına çevrilmiştir.

```text
CUDA / GPU akışı
      |
      v
Pinned host memory
      |
      | XDMA H2C / C2H
      v
PCIe endpoint on FPGA
      |
      v
XDMA -> AXI Interconnect -> MIG DDR3
                         -> AXI DMA control
                         -> HLS accelerator control

DDR3 -> AXI DMA MM2S -> fpga_relu_accelerator -> AXI DMA S2MM -> DDR3
```

Bu repo özellikle FPGA tarafındaki şu katmanı temsil eder:

- PCIe endpoint ve XDMA köprüsü
- Host ile FPGA DDR3 belleği arasında AXI memory-mapped veri yolu
- AXI DMA ile DDR3'ten AXI-Stream hızlandırıcıya veri taşıma
- HLS tabanlı `fpga_relu_accelerator` IP entegrasyonu
- Debug için active-low build/version LED çıkışı
- Bitstream ve MCS üretim akışı

## Donanım ve Yazılım Ortamı

| Bileşen | Kullanım |
| --- | --- |
| Host sistem | Gigabyte GA-Z97M-D3H, Intel Core i3-4160 |
| GPU | NVIDIA GTX 1660 SUPER, CUDA referans akışı |
| FPGA kartı | ALINX AX7A035B |
| FPGA | Xilinx Artix-7 XC7A35T |
| FPGA bellek | Kart üzerindeki DDR3, MIG 7-Series ile sürülüyor |
| PCIe | GPU: Gen3 x16, FPGA: Gen2 x2 |
| Host OS | Ubuntu 24.04 LTS, Linux kernel 6.x |
| FPGA araçları | AMD/Xilinx Vivado 2025.2 |
| Host aktarım katmanı | Xilinx XDMA Linux sürücüsü |
| GPU-FPGA aktarım yaklaşımı | Pinned host memory + XDMA H2C/C2H |

## Vivado Proje Özeti

| Özellik | Değer |
| --- | --- |
| Proje dosyası | `pcie_xdma_ddr_ai_accel_test.xpr` |
| Vivado sürümü | 2025.2 |
| Hedef parça | `xc7a35tfgg484-2` |
| Top module | `PCIe_wrapper` |
| Block design | `pcie_xdma_ddr_ai_accel_test.srcs/sources_1/bd/PCIe/PCIe.bd` |
| PCIe/XDMA IP | `xilinx.com:ip:xdma:4.2` |
| XDMA link | PCIe Gen2 x2, 5.0 GT/s |
| XDMA AXI | 64-bit AXI master, 125 MHz |
| DDR kontrolcü | `xilinx.com:ip:mig_7series:4.2` |
| AXI DMA | MM2S + S2MM, scatter-gather kapalı |
| HLS IP | `xilinx.com:hls:fpga_relu_accelerator:1.0` |
| Hızlandırıcı stream genişliği | 32-bit AXI-Stream |
| Üretilmiş bitstream | `pcie_xdma_ddr_ai_accel_test.runs/impl_1/PCIe_wrapper.bit` |
| Flash çıktısı | `ledli_1.mcs` |

## Adres Haritası

XDMA `M_AXI` tarafından görülen ana adres bölgeleri:

| Blok | Base address | Aralık | Açıklama |
| --- | ---: | ---: | --- |
| DDR3 bellek | `0x00000000` | `1G` | Hosttan yazılan/veri işleme için kullanılan ana FPGA belleği |
| ReLU accelerator control | `0x40010000` | `64K` | HLS IP AXI-Lite kontrol register alanı |
| AXI DMA register | `0x41E00000` | `64K` | MM2S/S2MM DMA kontrol register alanı |

## Deneysel Çıktılar

Tez kapsamında bu mimarinin gerçek donanım üzerinde çalıştığı kademeli olarak doğrulanmıştır.

| Test | Sonuç |
| --- | --- |
| PCIe aygıt tanıma | FPGA, Linux tarafında Xilinx Device `7022` olarak tanındı |
| XDMA sürücü | H2C/C2H karakter aygıtları oluşturuldu |
| DDR3 doğrulama | Hosttan yazılan veri DDR3'ten byte seviyesinde doğru okundu |
| Efektif DMA aktarımı | Yaklaşık `4.18 Gbit/s`, yani `522 MB/s` uçtan uca sistem aktarımı |
| ReLU IP | FPGA çıktısı yazılımsal referansla eşleşti |
| ReLU performansı | Fonksiyonel olarak başarılı; düşük işlem yoğunluğu nedeniyle GPU'dan hızlı değil |
| ReLU enerji | GPU yaklaşık `39.020 mJ`, FPGA yaklaşık `2.995 mJ`; yaklaşık `13x` enerji avantajı |
| Kuantizasyon genel sistem sonucu | GPU-only akışa göre yaklaşık `%10.30` uçtan uca süre iyileşmesi |
| Kuantizasyon güç analizi | FPGA on-chip güç yaklaşık `1.693 W` |

ReLU bu çalışmada daha çok PCIe-DMA + HLS IP entegrasyonunun doğrulanması için iyi bir ilk blok oldu. Asıl sistem seviyesi performans katkısı kuantizasyonda görüldü; çünkü kuantizasyon sabit noktalı/integer aritmetik ile FPGA üzerinde daha verimli uygulanabiliyor.

## Proje Yapısı

```text
.
|-- pcie_xdma_ddr_ai_accel_test.xpr
|-- pcie_xdma_ddr_ai_accel_test.srcs/
|   |-- sources_1/bd/PCIe/PCIe.bd
|   |-- sources_1/new/build_version_led.v
|   `-- constrs_1/new/
|       |-- PCIe.xdc
|       `-- debug_leds.xdc
|-- pcie_xdma_ddr_ai_accel_test.runs/
|   `-- impl_1/PCIe_wrapper.bit
|-- ledli_1.mcs
|-- ledli_1.prm
`-- README.md
```

Önemli not: Bu repo ağırlıklı olarak Vivado FPGA projesidir. CUDA/C++, pinned memory benchmark yazılımları ve kuantizasyonun tüm host tarafı deney kodları bu dizinde görünmüyor. Bu dizindeki Vivado tasarımı, tezde anlatılan GPU-FPGA sisteminin FPGA donanım altyapısını oluşturur.

## Vivado ile Açma

```bash
vivado pcie_xdma_ddr_ai_accel_test.xpr
```

Projeyi açtıktan sonra kontrol edilmesi gerekenler:

1. `PCIe.bd` block design dosyasını aç.
2. `Validate Design` çalıştır.
3. HLS IP repository yolunu kontrol et. Proje `../../vitis_workspace/relu_accelerator` yolunu referanslıyor.
4. Gerekirse `Generate Output Products` çalıştır.
5. Synthesis ve implementation adımlarından sonra bitstream üret.

Tcl ile derleme:

```tcl
launch_runs synth_1 -jobs 8
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
```

## FPGA Programlama

Geçici programlama için bitstream:

```text
pcie_xdma_ddr_ai_accel_test.runs/impl_1/PCIe_wrapper.bit
```

Flash programlama için MCS:

```text
ledli_1.mcs
```

Bitstream yüklendikten sonra PCIe kartının host tarafından enumerate olması için çoğu sistemde host tarafında yeniden başlatma gerekebilir. PCIe endpoint projelerinde programlama sırası, reset hattı ve host boot süreci kritik olabilir.

## Host Tarafı Doğrulama Akışı

Linux tarafında beklenen kademeli test sırası:

1. FPGA bitstream/MCS ile programlanır.
2. Host sistem başlatılır.
3. PCIe enumeration kontrol edilir:

```bash
lspci -d 10ee:
```

4. XDMA kernel sürücüsü yüklenir.
5. Aygıt dosyaları kontrol edilir:

```bash
ls /dev/xdma*
```

Beklenen temel aygıtlar:

```text
/dev/xdma0_h2c_0
/dev/xdma0_c2h_0
/dev/xdma0_control
```

6. DDR3 yazma-okuma testi yapılır.
7. AXI DMA ve HLS IP register alanları üzerinden ReLU testi çalıştırılır.
8. Sonuçlar yazılımsal referans çıktılarla karşılaştırılır.

## Entegrasyonda Öğrenilen Kritik Noktalar

- GTX 1660 SUPER ile doğrudan GPUDirect RDMA/P2P pratik olarak kullanılamadığı için mimari pinned host memory üzerine kuruldu.
- PCIe `rev ff` kararsızlığı yalnızca host/sürücü problemi olarak ele alınmadı; MIG/AXI tarafındaki `ID_WIDTH=4` düzenlemesi sistem kararlılığında kritik oldu.
- CUDA initialization bazı DMA testlerini etkilediği için GPU ve FPGA işlemleri ayrı process yapılarıyla izole edildi.
- ReLU gibi çok basit işlemlerde veri aktarımı, DMA setup ve polling maliyeti işlem süresinden baskın gelebiliyor.
- Kuantizasyon gibi sabit noktalı/integer mikro işlemler FPGA tarafında daha anlamlı hızlandırma potansiyeli gösteriyor.
- Artix-7 XC7A35T, ReLU ve kuantizasyon gibi mikro hızlandırıcılar için yeterli; daha büyük CNN katmanları veya geniş ön işleme blokları için LUT/BRAM/DSP kapasitesi sınırlayıcı oluyor.

## Debug LED

`build_version_led.v` modülü 4-bit active-low LED çıkışı üretir.

```verilog
parameter [3:0] VERSION = 4'h1
assign version_led_n = ~VERSION;
```

LED pinleri `debug_leds.xdc` içinde atanmıştır:

| LED | Pin |
| --- | --- |
| `version_led_n[0]` | `L13` |
| `version_led_n[1]` | `M13` |
| `version_led_n[2]` | `K14` |
| `version_led_n[3]` | `K13` |

## Kapsam

Bu çalışma, pahalı veri merkezi GPU/FPGA kartları olmadan da erişilebilir donanımlarla PCIe-DMA tabanlı GPU-FPGA entegrasyonunun kurulabileceğini göstermektedir. Bu repo da o sistemin FPGA tarafındaki temel yapı taşıdır: PCIe endpoint, XDMA aktarımı, AXI-MIG-DDR3 bellek yolu ve HLS hızlandırıcı entegrasyonu.
