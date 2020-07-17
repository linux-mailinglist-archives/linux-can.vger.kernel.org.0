Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8857D223A90
	for <lists+linux-can@lfdr.de>; Fri, 17 Jul 2020 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgGQLc2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jul 2020 07:32:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:23652 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQLc1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jul 2020 07:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1594985542;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9UwNi0B5bicfNVF/eJweiWoI/D5diOSsXkMo5H3gqyE=;
        b=I2q7BWoyYvk66h3xXP+7dPYGD+vN+hwDEPTEkYLTZi2S5L12YmdkBgorycXYSm4CbK
        XXbXbtpbyqmY681OaD84xMn0cilaSBdM7lQ9taVE4I6VFvP2vNCU0qQL/iE80Zwjqq1r
        XrVqV9SgxaEBJlbMzfr/UghrPZVagfqib2Fk/vdDBhxgbKyhbZCFsASVPvsLImGXT6jE
        EZKKWnS9gb7Qx2UIQ5sgIyUbaHhY9iIVh2+Xy5eUduN5I2gWRfQ/PaHq9yS2SZRSNLCx
        pzH48LL+9ycJ1vbvP7zSncQqVjihg39ChmRTt1xYj1V5hwLuz/hz322hBhCkTi4T2OmP
        If9A==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVMh+lyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.192.66]
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id R09ac6w6HBWE1jL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 17 Jul 2020 13:32:14 +0200 (CEST)
Subject: Re: [Bug] Kernel Panic on Deletion of the network-namespace
 containing the SocketCAN interface
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>,
        Philipp Lehmann <leph1016@hs-karlsruhe.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "christian.sauer.w@sew-eurodrive.de" 
        <christian.sauer.w@sew-eurodrive.de>
References: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
 <88fb5401-746a-5589-650d-a88fde43b122@hartkopp.net>
 <DB7PR03MB505186792325DBBF2471EF1ED67C0@DB7PR03MB5051.eurprd03.prod.outlook.com>
 <925ff8f7-3d24-54d7-38c3-34f127965d3a@hartkopp.net>
Message-ID: <7f1b53a6-299d-1c32-7a15-216019db6b8f@hartkopp.net>
Date:   Fri, 17 Jul 2020 13:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <925ff8f7-3d24-54d7-38c3-34f127965d3a@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I found it!

diff --git a/net/core/dev.c b/net/core/dev.c
index 90b59fc50dc9..add15461a9e2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10517,7 +10517,7 @@ static void __net_exit 
default_device_exit(struct net *net)
                         continue;

                 /* Leave virtual devices for the generic cleanup */
-               if (dev->rtnl_link_ops)
+               if ((dev->rtnl_link_ops) && (dev->type != ARPHRD_CAN))
                         continue;

                 /* Push remaining network devices to init_net */

The problem is, that 'real' CAN interfaces use the rtnl_link_ops to 
configure bitrates and other CAN controller specific settings.

But the fact that rtnl_link_ops are available makes somebody thinking 
this is only a virtual interface - and therefore the transition of the 
interface back to the root namespace is skipped.

The patch above fixes the issue but I'm not sure if we need a more 
general solution here.

Best,
Oliver

On 17.07.20 13:02, Oliver Hartkopp wrote:
> 
> 
> On 17.07.20 09:55, Stéphane Grosjean wrote:
>> There's a first WARNING kernel message just when the namespace is 
>> deleted. The WARNING turns into a BUG (kernel NULL pointer 
>> dereference) when removing the interface itself (for example, when the 
>> driver module is removed from memory). Note that the issue occurs with 
>> all our internal as well as USB CAN interfaces.
>>
>> Obviously, the problem doesn't appear when you put the interface back 
>> in the root namespace before the destruction, or when the interface is 
>> a true Ethernet network interface.
> 
> Yes. I checked that with an USB Ethernet interface I have at hand here - 
> and when deleting the test namespace it just emerges in the root 
> namespace again.
> 
> So I wonder what's missing in our configuration for CAN interfaces that 
> this transition is not performed :-/
> 
> Best regards,
> Oliver
> 
> 
>> Context:
>>
>> $ uname -a
>> Linux linux-dev 5.4.0-39-generic #43-Ubuntu SMP Fri Jun 19 10:28:31 
>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>
>> $ dmesg | grep peak_pci
>> [   19.028048] peak_pci 0000:0a:00.0: enabling device (0100 -> 0102)
>> [   19.034283] peak_pci 0000:0a:00.0: can6 at 
>> reg_base=0x00000000136b8b0b cfg_base=0x00000000b826597c irq=27
>> [   19.034378] peak_pci 0000:0a:00.0: can7 at 
>> reg_base=0x000000006b3de9a0 cfg_base=0x00000000b826597c irq=27
>>
>> # ip netns add test
>> # ip link set dev can6 netns test
>> # ip netns delete test
>>
>> [ 1755.805241] ------------[ cut here ]------------
>> [ 1755.805251] WARNING: CPU: 8 PID: 2635 at net/core/dev.c:10039 
>> netdev_exit+0x44/0x50
>> [ 1755.805252] Modules linked in: vboxnetadp(OE) vboxnetflt(OE) 
>> vboxdrv(OE) md4 nls_utf8 cifs libarc4 fscache libdes cfg80211 
>> nls_iso8859_1 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal 
>> intel_powerclamp coretemp kvm_intel peak_usb 8812au(OE) joydev 
>> plin(OE) kvm input_leds pcan(OE) eeepc_wmi snd_hda_codec_hdmi 
>> snd_hda_codec_realtek nouveau pcmcia snd_hda_codec_generic asus_wmi 
>> pcmcia_core crct10dif_pclmul ghash_clmulni_intel peak_pci sja1000 
>> peak_pciefd ledtrig_audio ttm aesni_intel drm_kms_helper snd_hda_intel 
>> snd_intel_dspcfg fb_sys_fops syscopyarea sysfillrect sysimgblt can_dev 
>> snd_hda_codec snd_hda_core crypto_simd snd_hwdep cryptd snd_pcm 
>> glue_helper snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq 
>> snd_seq_device snd_timer sparse_keymap intel_cstate intel_rapl_perf 
>> snd video mei_me mei soundcore wmi_bmof intel_wmi_thunderbolt mxm_wmi 
>> mac_hid sch_fq_codel parport_pc ppdev lp parport drm ip_tables 
>> x_tables autofs4 hid_generic usbhid uas usb_storage hid crc32_pclmul 
>> igb e1000e
>> [ 1755.805306]  ahci i2c_i801 i2c_algo_bit lpc_ich libahci dca wmi
>> [ 1755.805315] CPU: 8 PID: 2635 Comm: kworker/u24:0 Tainted: 
>> G           OE     5.4.0-39-generic #43-Ubuntu
>> [ 1755.805316] Hardware name: ASUS All Series/X99-E WS, BIOS 4001 
>> 05/27/2019
>> [ 1755.805319] Workqueue: netns cleanup_net
>> [ 1755.805324] RIP: 0010:netdev_exit+0x44/0x50
>> [ 1755.805327] Code: 8b bb 30 01 00 00 e8 8b 9d 97 ff 48 81 fb 00 21 
>> be b5 74 13 48 8b 83 90 00 00 00 48 81 c3 90 00 00 00 48 39 c3 75 03 
>> 5b 5d c3 <0f> 0b eb f9 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 
>> e5 41
>> [ 1755.805329] RSP: 0018:ffffb12d0169fdc8 EFLAGS: 00010287
>> [ 1755.805331] RAX: ffff9624c8a70050 RBX: ffff96247642a710 RCX: 
>> 000000008010000b
>> [ 1755.805333] RDX: 000000008010000c RSI: 0000000000000001 RDI: 
>> ffff9624cdc06a00
>> [ 1755.805334] RBP: ffffb12d0169fdd0 R08: 0000000000000000 R09: 
>> ffffffffb4d2e300
>> [ 1755.805335] R10: ffff9624a0d84000 R11: 0000000000000001 R12: 
>> ffffb12d0169fe20
>> [ 1755.805337] R13: ffffffffb5be3f20 R14: ffffffffb5be3f28 R15: 
>> ffff962498ea39d8
>> [ 1755.805339] FS:  0000000000000000(0000) GS:ffff9624cfa00000(0000) 
>> knlGS:0000000000000000
>> [ 1755.805341] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1755.805342] CR2: 000055fbb59cd8e8 CR3: 000000004aa0a006 CR4: 
>> 00000000001606e0
>> [ 1755.805344] Call Trace:
>> [ 1755.805350]  ops_exit_list.isra.0+0x3b/0x70
>> [ 1755.805353]  cleanup_net+0x1f0/0x300
>> [ 1755.805359]  process_one_work+0x1eb/0x3b0
>> [ 1755.805363]  worker_thread+0x4d/0x400
>> [ 1755.805367]  kthread+0x104/0x140
>> [ 1755.805370]  ? process_one_work+0x3b0/0x3b0
>> [ 1755.805373]  ? kthread_park+0x90/0x90
>> [ 1755.805378]  ret_from_fork+0x35/0x40
>> [ 1755.805382] ---[ end trace 832a75ad96f8105e ]---
>> [ 1755.805410] ------------[ cut here ]------------
>> [ 1755.805416] WARNING: CPU: 8 PID: 2635 at fs/proc/proc_sysctl.c:1714 
>> retire_sysctl_set+0x14/0x18
>> [ 1755.805417] Modules linked in: vboxnetadp(OE) vboxnetflt(OE) 
>> vboxdrv(OE) md4 nls_utf8 cifs libarc4 fscache libdes cfg80211 
>> nls_iso8859_1 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal 
>> intel_powerclamp coretemp kvm_intel peak_usb 8812au(OE) joydev 
>> plin(OE) kvm input_leds pcan(OE) eeepc_wmi snd_hda_codec_hdmi 
>> snd_hda_codec_realtek nouveau pcmcia snd_hda_codec_generic asus_wmi 
>> pcmcia_core crct10dif_pclmul ghash_clmulni_intel peak_pci sja1000 
>> peak_pciefd ledtrig_audio ttm aesni_intel drm_kms_helper snd_hda_intel 
>> snd_intel_dspcfg fb_sys_fops syscopyarea sysfillrect sysimgblt can_dev 
>> snd_hda_codec snd_hda_core crypto_simd snd_hwdep cryptd snd_pcm 
>> glue_helper snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq 
>> snd_seq_device snd_timer sparse_keymap intel_cstate intel_rapl_perf 
>> snd video mei_me mei soundcore wmi_bmof intel_wmi_thunderbolt mxm_wmi 
>> mac_hid sch_fq_codel parport_pc ppdev lp parport drm ip_tables 
>> x_tables autofs4 hid_generic usbhid uas usb_storage hid crc32_pclmul 
>> igb e1000e
>> [ 1755.805454]  ahci i2c_i801 i2c_algo_bit lpc_ich libahci dca wmi
>> [ 1755.805460] CPU: 8 PID: 2635 Comm: kworker/u24:0 Tainted: G        
>> W  OE     5.4.0-39-generic #43-Ubuntu
>> [ 1755.805461] Hardware name: ASUS All Series/X99-E WS, BIOS 4001 
>> 05/27/2019
>> [ 1755.805463] Workqueue: netns cleanup_net
>> [ 1755.805467] RIP: 0010:retire_sysctl_set+0x14/0x18
>> [ 1755.805469] Code: 00 00 00 00 49 c7 40 48 00 00 00 00 49 c7 40 50 
>> 00 00 00 00 c3 90 0f 1f 44 00 00 55 48 8b 47 58 48 89 e5 48 85 c0 75 
>> 02 5d c3 <0f> 0b 5d c3 0f 1f 44 00 00 55 48 89 e5 48 83 ec 60 48 89 4c 
>> 24 48
>> [ 1755.805471] RSP: 0018:ffffb12d0169fdc0 EFLAGS: 00010282
>> [ 1755.805473] RAX: ffff9624a697ad58 RBX: ffff96247642a680 RCX: 
>> 0000000080150009
>> [ 1755.805475] RDX: ffff96247642a6b0 RSI: ffffffffb5bfeb48 RDI: 
>> ffff96247642a730
>> [ 1755.805476] RBP: ffffb12d0169fdc0 R08: 0000000000000000 R09: 
>> ffffffffb4776d00
>> [ 1755.805477] R10: ffff9624cad0a9c0 R11: 0000000000000001 R12: 
>> ffffb12d0169fe20
>> [ 1755.805479] R13: ffffffffb5bfeb40 R14: ffffffffb5bfeb48 R15: 
>> ffff962498ea39d8
>> [ 1755.805481] FS:  0000000000000000(0000) GS:ffff9624cfa00000(0000) 
>> knlGS:0000000000000000
>> [ 1755.805482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1755.805483] CR2: 000055fbb59cd8e8 CR3: 000000004aa0a006 CR4: 
>> 00000000001606e0
>> [ 1755.805485] Call Trace:
>> [ 1755.805490]  sysctl_net_exit+0x15/0x20
>> [ 1755.805493]  ops_exit_list.isra.0+0x3b/0x70
>> [ 1755.805496]  cleanup_net+0x1f0/0x300
>> [ 1755.805500]  process_one_work+0x1eb/0x3b0
>> [ 1755.805503]  worker_thread+0x4d/0x400
>> [ 1755.805507]  kthread+0x104/0x140
>> [ 1755.805510]  ? process_one_work+0x3b0/0x3b0
>> [ 1755.805512]  ? kthread_park+0x90/0x90
>> [ 1755.805517]  ret_from_fork+0x35/0x40
>> [ 1755.805520] ---[ end trace 832a75ad96f8105f ]---
>>
>>
>>
>> — Stéphane
>>
>> -----Message d'origine-----
>> De : linux-can-owner@vger.kernel.org <linux-can-owner@vger.kernel.org> 
>> De la part de Oliver Hartkopp
>> Envoyé : jeudi 16 juillet 2020 20:38
>> À : Philipp Lehmann <leph1016@hs-karlsruhe.de>; wg@grandegger.com; 
>> mkl@pengutronix.de
>> Cc : linux-can@vger.kernel.org; christian.sauer.w@sew-eurodrive.de
>> Objet : Re: [Bug] Kernel Panic on Deletion of the network-namespace 
>> containing the SocketCAN interface
>>
>> Hi Philipp,
>>
>> thanks for the report and its reproducer!
>>
>> I assumed the interfaces - at least in the case of 'real' hardware CAN 
>> interfaces - to me moved back to the root name space ... well.
>>
>> I'll take a look at it.
>>
>> Best regards,
>> Oliver
>>
>> On 16.07.20 18:46, Philipp Lehmann wrote:
>>> If a SocketCAN Interface (Tested with a PCAN-USB adapter) is moved 
>>> into a network-namespace and the network namespace is deleted 
>>> afterwards, without moving the device out of the namespace prior to 
>>> the deletion. The device could not be found in any of the network 
>>> namespaces afterwards, only a reboot of the system fixes this. If the 
>>> device is instead removed from the USB-Bus without a restart, a 
>>> kernel panic is the result.
>>>
>>>
>>> Output of uname -r [Linux cpc4x 5.4.0-40-generic #44-Ubuntu SMP Tue
>>> Jun 23 00:01:04 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux]
>>>
>>>
>>> The bug could be reproduced with the following steps:
>>>
>>>
>>> 1. Connect the (USB)-SocketCAN device to the host
>>>
>>> 2. Add a new network namespace [sudo ip netns add test] 3. Move the
>>> CAN-interface to the network name-space [sudo ip link set dev can0
>>> netns test] 4. Delete the namespace [sudo ip netns delete test] 5.
>>> Remove the adapter from the USB-Bus. In most cases this should result
>>> in a kernel panic
>>>
>>
>> -- 
>> PEAK-System Technik GmbH
>> Sitz der Gesellschaft Darmstadt - HRB 9183
>> Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
>> Unsere Datenschutzerklaerung mit wichtigen Hinweisen
>> zur Behandlung personenbezogener Daten finden Sie unter
>> www.peak-system.com/Datenschutz.483.0.html
>>
