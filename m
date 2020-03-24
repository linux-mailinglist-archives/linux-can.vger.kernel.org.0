Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77C2190C51
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2020 12:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCXLVX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 24 Mar 2020 07:21:23 -0400
Received: from mailproxy04.manitu.net ([217.11.48.68]:54310 "EHLO
        mailproxy04.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCXLVX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Mar 2020 07:21:23 -0400
Received: from [IPv6:2001:a61:b23:a901:a04d:d6f2:5f71:1190] (unknown [IPv6:2001:a61:b23:a901:a04d:d6f2:5f71:1190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy04.manitu.net (Postfix) with ESMTPSA id 4009F804D3;
        Tue, 24 Mar 2020 12:21:21 +0100 (CET)
To:     linux-can@vger.kernel.org
Cc:     Maximilian Schneider <max@schneidersoft.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
From:   Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] can: gs_usb: avoid kernel warning when the device is stopped
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <50bcd1d6-57e2-504a-50b2-4c9561955628@grandegger.com>
Date:   Tue, 24 Mar 2020 12:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This commit fixes partly the kernel warning listed below. It can easily
be triggered by sending messages with "cangen -g1 can0" and then
stopping the interface with "ifconfig can0 down". The warning comes from
skb_release_all() and it occurs, because the "ifconfig down" command
clears the running state before calling the device specific stop/close
routine. In the meantime, TX done events may still occur, calling
can_get_echo_skb(), which calls netif_rx() then netif_rx_internal()
and enqueue_to_backlog(). Because the interface is not running any
longer, the skb is finally dropped, causing the warning below. We now
check the running state in gs_usb_receive_bulk_callback() before
processing the data making the occurrence of that warning much much less
probable. BTW, the warning can cause rather high latencies of 500 ms...
that's likely the reason why it's there. The problem should show up on
other (USB) CAN drivers as well.

[ 1694.131475] ------------[ cut here ]------------
[ 1694.139911] WARNING: CPU: 0 PID: 0 at skb_release_head_state+0x9e/0xb0
[ 1694.147206] Modules linked in: intel_telemetry_pltdrv intel_pmc_ipc intel_punit_ipc intel_telemetry_core x86_pkg_temp_thermal igb tpm_tis tpm_tis_core btusb btrtl dca tpm lpc_ich btbcm spi_pxa2xx_platform mei_me btintel mei thermal rfcomm bluetooth ecdh_generic ntngdm_i2c ntngdm_core ntngdm_bl ntngdm_tsi ntngdm_irq ntngdm_hwmon i915 video
[ 1694.180782] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W       4.14.51apollolake #1
[ 1694.189828] Hardware name: Default string Default string/AGCO_NT-NG, BIOS X3.00c#AGCO BETA 09/19/2019
[ 1694.200136] task: ffffffff840104c0 task.stack: ffffffff84000000
[ 1694.206753] RIP: 0010:skb_release_head_state+0x9e/0xb0
[ 1694.212494] RSP: 0018:ffff8b2b3fc03cb0 EFLAGS: 00010006
[ 1694.218333] RAX: ffffffff835a4fb0 RBX: ffff8b2b3a20b100 RCX: 0000000000000018
[ 1694.226310] RDX: 0000000000010000 RSI: 0000000000000000 RDI: 0000000000000000
[ 1694.234284] RBP: 0000000000020ac0 R08: 0000000000000014 R09: 0000000000000014
[ 1694.242259] R10: 0000000000000000 R11: ffff8b2b3a7a2180 R12: ffff8b2b3fc03d40
[ 1694.250235] R13: ffff8b2b3a20b100 R14: ffff8b2b3fc20bcc R15: 0000000000000086
[ 1694.258211] FS:  0000000000000000(0000) GS:ffff8b2b3fc00000(0000) knlGS:0000000000000000
[ 1694.267256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1694.273678] CR2: 00007f83a2db5130 CR3: 0000000179c6a000 CR4: 00000000003406f0
[ 1694.281653] Call Trace:
[ 1694.284383]  <IRQ>
[ 1694.286629]  skb_release_all+0x9/0x20
[ 1694.290720]  kfree_skb+0x19/0x40
[ 1694.294327]  enqueue_to_backlog+0x7e/0x230
[ 1694.298906]  ? recalibrate_cpu_khz+0x10/0x10
[ 1694.303677]  ? ktime_get_with_offset+0x4f/0xb0
[ 1694.308644]  netif_rx_internal+0x56/0x150
[ 1694.313126]  can_get_echo_skb+0x37/0x60
[ 1694.317415]  gs_usb_receive_bulk_callback+0x111/0x320
[ 1694.323063]  __usb_hcd_giveback_urb+0x7b/0xf0
[ 1694.327924]  xhci_giveback_urb_in_irq.isra.55+0x6d/0x90
[ 1694.333765]  xhci_td_cleanup+0xcb/0x150
[ 1694.338051]  xhci_irq+0x66a/0x20b0
[ 1694.341854]  ? rcu_accelerate_cbs+0x3a/0x190
[ 1694.346628]  __handle_irq_event_percpu+0x32/0xd0
[ 1694.351791]  handle_irq_event_percpu+0x2b/0x70
[ 1694.356757]  handle_irq_event+0x2f/0x50
[ 1694.361044]  handle_edge_irq+0x72/0x190
[ 1694.365331]  handle_irq+0x17/0x20
[ 1694.369038]  do_IRQ+0x3c/0xc0
[ 1694.372355]  common_interrupt+0x7a/0x7a
[ 1694.376639]  </IRQ>
[ 1694.378981] RIP: 0010:cpuidle_enter_state+0x122/0x200
[ 1694.384622] RSP: 0018:ffffffff84003ea8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffffbd
[ 1694.393087] RAX: ffff8b2b3fc1fa00 RBX: 0000000000000002 RCX: 0000018a721a5ae8
[ 1694.401063] RDX: 0000018a721a5ae8 RSI: 0000000050523fbe RDI: 0000000000000000
[ 1694.409040] RBP: ffff8b2b3aa13600 R08: 0000000000000193 R09: 000000000000012a
[ 1694.417015] R10: ffffffff84003e90 R11: 00000000000000ef R12: 0000018a721a5ae8
[ 1694.424990] R13: 0000018a72199308 R14: 0000000000000002 R15: 0000000072efca78
[ 1694.432970]  ? cpuidle_enter_state+0x11e/0x200
[ 1694.437937]  do_idle+0x161/0x1a0
[ 1694.441544]  cpu_startup_entry+0x6a/0x70
[ 1694.445927]  start_kernel+0x414/0x434
[ 1694.450023]  secondary_startup_64+0xa5/0xb0
[ 1694.454697] Code: 88 96 4f 17 00 74 02 5b c3 5b e9 4e 15 bc ff e8 d9 33 04 00 eb dd e8 c2 5a 0d 00 eb 9f 48 83 e7 fe e8 07 d7 01 00 e9 75 ff ff ff <0f> 0b eb ad 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 53 48 89
[ 1694.475869] ---[ end trace 063196a1141471b3 ]---

Signed-of-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a4b4b74..1893267 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -321,7 +321,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	netdev = dev->netdev;
 	stats = &netdev->stats;
 
-	if (!netif_device_present(netdev))
+	if (!netif_device_present(netdev) || !netif_running(netdev))
 		return;
 
 	if (hf->echo_id == -1) { /* normal rx */
-- 
1.9.1

