Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260B611AA58
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfLKL6N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 11 Dec 2019 06:58:13 -0500
Received: from smtpx.feld.cvut.cz ([147.32.192.33]:33763 "EHLO
        smtpx.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKL6N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 06:58:13 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 06:58:11 EST
Received: from localhost (styx [192.168.200.7])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 3766242C93;
        Wed, 11 Dec 2019 12:49:02 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.feld.cvut.cz ([192.168.200.2])
        by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10060)
        with ESMTP id NyC2ijDlYOOD; Wed, 11 Dec 2019 12:49:00 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id DFC5442BEB;
        Wed, 11 Dec 2019 12:48:59 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.93-RC1)
        (envelope-from <michal.sojka@cvut.cz>)
        id 1if0UF-0001jP-IN; Wed, 11 Dec 2019 12:48:59 +0100
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     linux-can@vger.kernel.org
Cc:     Bernd Krumboeck <b.krumboeck@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: usb_8dev - WARN_ON(in_irq())
Date:   Wed, 11 Dec 2019 12:48:59 +0100
Message-ID: <87immnaxqs.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear all,

I use usb_8dev USB2CAN converter and I'm getting non-killable processes
and the following warnings in dmesg. Any idea, how to fix it?

Thanks
-Michal

Dec 11 10:27:38 kernel: usb 1-5.2: new full-speed USB device number 12 using xhci_hcd
Dec 11 10:27:38 kernel: usb 1-5.2: New USB device found, idVendor=0483, idProduct=1234, bcdDevice= 1.00
Dec 11 10:27:38 kernel: usb 1-5.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Dec 11 10:27:38 kernel: usb 1-5.2: Product: USB2CAN converter
Dec 11 10:27:38 kernel: usb 1-5.2: Manufacturer: 8Devices
Dec 11 10:27:38 kernel: usb 1-5.2: SerialNumber: 7272B673
Dec 11 10:27:38 kernel: usb_8dev 1-5.2:1.0 can0: firmware: 2.1, hardware: 2.0
...
Dec 11 10:28:54 kernel: ------------[ cut here ]------------
Dec 11 10:28:54 kernel: WARNING: CPU: 5 PID: 0 at net/core/skbuff.c:651 skb_release_head_state.cold+0xc/0x17
Dec 11 10:28:54 kernel: Modules linked in: can_raw can xt_conntrack xt_MASQUERADE nf_conntrack_netlink nft_counter xt_addrtype nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink br_netfilter bridge stp llc xfrm_user xfrm_algo ctr ccm rfcomm fuse cpufreq_userspace cpufreq_powersave cpufreq_conservative squashfs bnep uinput snd_hda_codec_realtek snd_hda_codec_generic iwlmvm btusb btrtl btbcm btintel x86_pkg_temp_thermal snd_hda_intel mac80211 intel_powerclamp coretemp libarc4 bluetooth snd_hda_codec kvm_intel snd_hda_core iwlwifi binfmt_misc drbg snd_hwdep dell_laptop kvm snd_pcm_oss ledtrig_audio dell_wmi uvcvideo videobuf2_vmalloc mei_wdt videobuf2_memops snd_mixer_oss ansi_cprng nls_ascii dell_smbios videobuf2_v4l2 efi_pstore irqbypass nls_cp437 intel_rapl_msr snd_pcm videobuf2_common iTCO_wdt snd_timer usb_8dev dcdbas ecdh_generic vfat ecc joydev videodev iTCO_vendor_support intel_cstate dell_smm_hwmon crc16 fat can_dev snd mei_me rtsx_pci_ms cfg80211
Dec 11 10:28:54 kernel:  sparse_keymap serio_raw dell_wmi_descriptor wmi_bmof mc intel_wmi_thunderbolt tpm_crb efivars memstick mei watchdog intel_uncore intel_rapl_perf soundcore processor_thermal_device intel_rapl_common intel_pch_thermal intel_soc_dts_iosf battery tpm_tis tpm_tis_core dell_smo8800 tpm int3403_thermal int340x_thermal_zone dell_rbtn rng_core acpi_pad rfkill ac evdev int3400_thermal acpi_thermal_rel sch_fq_codel vcan ecryptfs i2c_dev nfsd parport_pc auth_rpcgss ppdev nfs_acl lockd lp parport grace loop sunrpc dm_crypt efivarfs ip_tables x_tables autofs4 hid_generic usbhid hid btrfs zstd_decompress zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod dm_mirror dm_region_hash dm_log dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel i915 ghash_clmulni_intel xhci_pci xhci_hcd rtsx_pci_sdmmc i2c_algo_bit mmc_core drm_kms_helper usbcore ahci libahci aesni_intel e1000e libata drm
Dec 11 10:28:54 kernel:  rtsx_pci nvme psmouse aes_x86_64 scsi_mod crypto_simd cryptd glue_helper nvme_core ptp i2c_i801 pps_core mfd_core usb_common wmi video button
Dec 11 10:28:54 kernel: CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.3.0-1-amd64 #1 Debian 5.3.7-1
Dec 11 10:28:54 kernel: Hardware name: Dell Inc. Latitude E5470/06DNG5, BIOS 1.21.6 10/02/2019
Dec 11 10:28:54 kernel: RIP: 0010:skb_release_head_state.cold+0xc/0x17
Dec 11 10:28:54 kernel: Code: 54 24 08 e8 1c 57 ae ff 0f 0b 48 8b 54 24 08 48 8b 74 24 10 4c 63 4c 24 1c e9 b2 93 ff ff 48 c7 c7 60 4b c6 8d e8 fa 56 ae ff <0f> 0b 48 8b 43 60 e9 1d 9e ff ff 44 89 ce 48 c7 c7 c8 6a d0 8d e8
Dec 11 10:28:54 kernel: RSP: 0018:ffffb8cf401c8cb8 EFLAGS: 00010046
Dec 11 10:28:54 kernel: RAX: 0000000000000024 RBX: ffff93e8bb326d00 RCX: 0000000000000000
Dec 11 10:28:54 kernel: RDX: 0000000000000000 RSI: ffff93e8bdb57688 RDI: ffff93e8bdb57688
Dec 11 10:28:54 kernel: RBP: ffff93e8bb326d00 R08: ffff93e8bdb57688 R09: 0000000000000004
Dec 11 10:28:54 kernel: R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8d413959
Dec 11 10:28:54 kernel: R13: ffff93e8bb326d00 R14: 0000000000000082 R15: ffff93e8bdb6b64c
Dec 11 10:28:54 kernel: FS:  0000000000000000(0000) GS:ffff93e8bdb40000(0000) knlGS:0000000000000000
Dec 11 10:28:54 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 11 10:28:54 kernel: CR2: 00000042084c6000 CR3: 0000000344a0a005 CR4: 00000000003606e0
Dec 11 10:28:54 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Dec 11 10:28:54 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Dec 11 10:28:54 kernel: Call Trace:
Dec 11 10:28:54 kernel:  <IRQ>
Dec 11 10:28:54 kernel:  skb_release_all+0xe/0x30
Dec 11 10:28:54 kernel:  kfree_skb+0x32/0xa0
Dec 11 10:28:54 kernel:  enqueue_to_backlog+0x99/0x230
Dec 11 10:28:54 kernel:  ? recalibrate_cpu_khz+0x10/0x10
Dec 11 10:28:54 kernel:  netif_rx_internal+0x41/0x100
Dec 11 10:28:54 kernel:  netif_rx+0x18/0xb0
Dec 11 10:28:54 kernel:  can_get_echo_skb+0x32/0x60 [can_dev]
Dec 11 10:28:54 kernel:  usb_8dev_write_bulk_callback+0x7d/0xb0 [usb_8dev]
Dec 11 10:28:54 kernel:  __usb_hcd_giveback_urb+0x6f/0x120 [usbcore]
Dec 11 10:28:54 kernel:  xhci_giveback_urb_in_irq.isra.0+0x76/0xf0 [xhci_hcd]
Dec 11 10:28:54 kernel:  xhci_td_cleanup+0xfd/0x140 [xhci_hcd]
Dec 11 10:28:54 kernel:  xhci_irq+0xbb0/0x1cf0 [xhci_hcd]
Dec 11 10:28:54 kernel:  __handle_irq_event_percpu+0x48/0x180
Dec 11 10:28:54 kernel:  handle_irq_event_percpu+0x31/0x80
Dec 11 10:28:54 kernel:  handle_irq_event+0x3c/0x5c
Dec 11 10:28:54 kernel:  handle_edge_irq+0x98/0x1e0
Dec 11 10:28:54 kernel:  handle_irq+0x1f/0x30
Dec 11 10:28:54 kernel:  do_IRQ+0x4b/0xd0
Dec 11 10:28:54 kernel:  common_interrupt+0xf/0xf
Dec 11 10:28:54 kernel:  </IRQ>
Dec 11 10:28:54 kernel: RIP: 0010:cpuidle_enter_state+0xc4/0x420
Dec 11 10:28:54 kernel: Code: e8 c1 39 ae ff 80 7c 24 0f 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 39 03 00 00 31 ff e8 33 50 b4 ff fb 66 0f 1f 44 00 00 <45> 85 e4 0f 89 cf 01 00 00 c7 45 10 00 00 00 00 48 83 c4 18 44 89
Dec 11 10:28:54 kernel: RSP: 0018:ffffb8cf400d7e68 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
Dec 11 10:28:54 kernel: RAX: ffff93e8bdb6a580 RBX: ffffffff8debab60 RCX: 000000000000001f
Dec 11 10:28:54 kernel: RDX: 0000000000000000 RSI: 000000002f32b87a RDI: 0000000000000000
Dec 11 10:28:54 kernel: RBP: ffff93e8bdb74400 R08: 000000584dd590cb R09: 0000000000000082
Dec 11 10:28:54 kernel: R10: ffff93e8bdb69504 R11: ffff93e8bdb694e4 R12: 0000000000000004
Dec 11 10:28:54 kernel: R13: 000000584dd590cb R14: 0000000000000004 R15: ffff93e8bb635d00
Dec 11 10:28:54 kernel:  ? cpuidle_enter_state+0x9f/0x420
Dec 11 10:28:54 kernel:  cpuidle_enter+0x29/0x40
Dec 11 10:28:54 kernel:  do_idle+0x1dc/0x270
Dec 11 10:28:54 kernel:  cpu_startup_entry+0x19/0x20
Dec 11 10:28:54 kernel:  start_secondary+0x160/0x1b0
Dec 11 10:28:54 kernel:  secondary_startup_64+0xa4/0xb0
Dec 11 10:28:54 kernel: ---[ end trace 6b8bc0481012eb0c ]---
...
Dec 11 10:28:54 kernel: usb_8dev 1-5.2:1.0 can0: Tx URB aborted (-2)

