Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367A068A43
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2019 15:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfGONLM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Jul 2019 09:11:12 -0400
Received: from first.geanix.com ([116.203.34.67]:37740 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbfGONLM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 15 Jul 2019 09:11:12 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id DA84A1837
        for <linux-can@vger.kernel.org>; Mon, 15 Jul 2019 13:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563196245; bh=nYa/UN5Ju51nHdDgjoNtF6mz5d5GmsVcBboCBsSj6C0=;
        h=To:From:Subject:Date;
        b=H8BwWDKtME34DBCA658FVTeqVAtElzP0q4CLZZo6+mDJHoYSh0KbPhtHtTyaSSuWD
         DIazrM8G/AG/XJvaoTV8V/wrVH8dEnJiWQwTdLjwJFR/lRpgcaZ4bPZ22x354K9All
         pTl9aXRcmKoK6pyJD9lC+jXKfllVAwUB3C3zgivAfM++z1OnaajiLHc8gbRDe76oNV
         FBGjz2HeT0eUB6RKCv85KkJ3VhUN90swR+6L3s9CZITRQfLcLicze5G8jFzG9TES8I
         dEnenqiZVKURFQDLKvtrUTYF/16I7JeveNChPgh6hodVCzhC9jwYeVY0d2K+MqaC4v
         nu3MRQGD6vr/g==
To:     linux-can@vger.kernel.org
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Subject: Flexcan memory leak
Message-ID: <899874c1-8916-a71a-9426-b65961c01a7b@geanix.com>
Date:   Mon, 15 Jul 2019 15:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8945dcc0271d
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I've encountered a memory (skb) leak in the flexcan driver / can_if 
stack that I don't know exactly how to fix.

My setup is a desktop with a usb2can dongle from 8devices[1] connected 
to the flexcan controller on an imx6ull based custom board.

The flexcan device is configured to 500 kbit/s with both listen-only and 
berr-reports enabled. The usb2can device to 750 kbit/s and listen-only 
disabled.

After sending a single packet on usb2can with cansend, the usb2can 
dongle keeps retransmitting, because of the lacking ACK. This causes the 
flexcan driver to keep allocating skb's and pushing these up the stack 
until my poor device runs out of memory. It takes less than a minute to 
run out.

Initially kmemleak doesn't show a leak, beacuse the skbs are referenced 
somewhere in the device or flexcan objects. After rmmod'ing the flexcan 
module to remove the can0 device, kmemleak detects the leak:

unreferenced object 0xc7012900 (size 176):
   comm "hardirq", pid 0, jiffies 4294948440 (age 1373.620s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 20 05 c9 00 00 00 00  ......... ......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<081222d6>] kmem_cache_alloc+0x170/0x2e0
     [<49d6dbdd>] __build_skb+0x28/0xa0
     [<6505d0e3>] __netdev_alloc_skb+0xf0/0x14c
     [<b270cd0e>] alloc_can_skb+0x20/0xac
     [<259f40c0>] alloc_can_err_skb+0x14/0x38
     [<1d054583>] 0xbf00102c
     [<afa06bcb>] __handle_irq_event_percpu+0x54/0x36c
     [<ee837075>] handle_irq_event_percpu+0x34/0x90
     [<0edce3fa>] handle_irq_event+0x40/0x64
     [<9b077f00>] handle_fasteoi_irq+0xc4/0x174
     [<be43af70>] generic_handle_irq+0x28/0x3c
     [<0324a6ea>] __handle_domain_irq+0x6c/0xe4
     [<60894ba1>] gic_handle_irq+0x50/0xa8
     [<2a8590ee>] __irq_svc+0x70/0x98
     [<097d4ee7>] _raw_write_unlock_irqrestore+0x48/0x4c
     [<4bdad895>] find_and_remove_object+0x60/0x70

I have unsuccessfully tried to reproduce in the other direction.

I have also tried to partially revert commit 
30164759db1bb1062bdf0f92451f57ed295cfa48 ("can: flexcan: make use of 
rx-offload's irq_offload_fifo") to circumvent the rx-offload queuing:


diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4e3caf421a54..3e13d2480828 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -677,7 +677,9 @@ static void flexcan_irq_bus_err(struct net_device 
*dev, u32 reg_esr)
         if (tx_errors)
                 dev->stats.tx_errors++;

-       can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+       dev->stats.rx_packets++;
+       dev->stats.rx_bytes += cf->can_dlc;
+       netif_receive_skb(skb);
  }

  static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)


But that doesn't make a difference either.

I would appreciate some hints on where to look for the missing 
skb_consume()...

[1] https://www.8devices.com/products/usb2can/

-- 
Kind regards,
Martin Hundebøll
Embedded Linux Consultant

+45 61 65 54 61
martin@geanix.com

Geanix ApS
https://geanix.com
DK39600706
