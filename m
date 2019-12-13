Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04F111DF66
	for <lists+linux-can@lfdr.de>; Fri, 13 Dec 2019 09:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMI12 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Dec 2019 03:27:28 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:30463 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMI11 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2019 03:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576225646;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=iJQ/bLe3SScKbO9UgZNa180MQAXsSSAn6KdPADZJU8A=;
        b=IytaOoSay8d9z7UWzA9ren6n8l6K9Ft0y++xEeHOd9SubbrlkDV8R96C5IlqWS1xiy
        bb8TVJjrSKTh1ebxeq2kAIhRE1el3qnbDLUjDmvyom3JNRSuGxR4PD/D4aUA4BvJcJB2
        hPniAOC4PAp+1178w+HQC4mevFGMv03vUFAGSerFEYL3oeMblxtVcU19JPyN9rckqe+W
        G3k6aCEB/lw2iu4Bw8Bt2z1cp+jnYiwVI/Wc34sVwAnnntQf9L8sqetJ7Ifinb0tBkNK
        sz47ZSYdhKmE8r0UT86ghguLJAbmC+WU5POx84ltpMlFpQ6zvk4b0qF/PV7Cn9mfzb76
        79Tg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVMh+mCA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.0.7 DYNA|AUTH)
        with ESMTPSA id x04ebavBD8RP3I2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 13 Dec 2019 09:27:25 +0100 (CET)
Subject: Re: usb_8dev - WARN_ON(in_irq())
To:     Michal Sojka <michal.sojka@cvut.cz>, linux-can@vger.kernel.org
Cc:     Bernd Krumboeck <b.krumboeck@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <87immnaxqs.fsf@steelpick.2x.cz>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c09f9e7c-5267-51a6-4a0b-8f3d2c5b9183@hartkopp.net>
Date:   Fri, 13 Dec 2019 09:27:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87immnaxqs.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michal,

On 11/12/2019 12.48, Michal Sojka wrote:

> I use usb_8dev USB2CAN converter and I'm getting non-killable processes
> and the following warnings in dmesg. Any idea, how to fix it?

> 
> Dec 11 10:27:38 kernel: usb 1-5.2: new full-speed USB device number 12 using xhci_hcd
> Dec 11 10:27:38 kernel: usb 1-5.2: New USB device found, idVendor=0483, idProduct=1234, bcdDevice= 1.00
> Dec 11 10:27:38 kernel: usb 1-5.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> Dec 11 10:27:38 kernel: usb 1-5.2: Product: USB2CAN converter
> Dec 11 10:27:38 kernel: usb 1-5.2: Manufacturer: 8Devices
> Dec 11 10:27:38 kernel: usb 1-5.2: SerialNumber: 7272B673
> Dec 11 10:27:38 kernel: usb_8dev 1-5.2:1.0 can0: firmware: 2.1, hardware: 2.0

Is this the new version with the blue housing?
https://www.8devices.com/products/usb2can_korlan

> ...
> Dec 11 10:28:54 kernel: ------------[ cut here ]------------
> Dec 11 10:28:54 kernel: WARNING: CPU: 5 PID: 0 at net/core/skbuff.c:651 skb_release_head_state.cold+0xc/0x17

> Dec 11 10:28:54 kernel: CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.3.0-1-amd64 #1 Debian 5.3.7-1

> Dec 11 10:28:54 kernel: RIP: 0010:skb_release_head_state.cold+0xc/0x17
> Dec 11 10:28:54 kernel: Code: 54 24 08 e8 1c 57 ae ff 0f 0b 48 8b 54 24 08 48 8b 74 24 10 4c 63 4c 24 1c e9 b2 93 ff ff 48 c7 c7 60 4b c6 8d e8 fa 56 ae ff <0f> 0b 48 8b 43 60 e9 1d 9e ff ff 44 89 ce 48 c7 c7 c8 6a d0 8d e8
> Dec 11 10:28:54 kernel: RSP: 0018:ffffb8cf401c8cb8 EFLAGS: 00010046
> Dec 11 10:28:54 kernel: RAX: 0000000000000024 RBX: ffff93e8bb326d00 RCX: 0000000000000000
> Dec 11 10:28:54 kernel: RDX: 0000000000000000 RSI: ffff93e8bdb57688 RDI: ffff93e8bdb57688
> Dec 11 10:28:54 kernel: RBP: ffff93e8bb326d00 R08: ffff93e8bdb57688 R09: 0000000000000004
> Dec 11 10:28:54 kernel: R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8d413959
> Dec 11 10:28:54 kernel: R13: ffff93e8bb326d00 R14: 0000000000000082 R15: ffff93e8bdb6b64c
> Dec 11 10:28:54 kernel: FS:  0000000000000000(0000) GS:ffff93e8bdb40000(0000) knlGS:0000000000000000
> Dec 11 10:28:54 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Dec 11 10:28:54 kernel: CR2: 00000042084c6000 CR3: 0000000344a0a005 CR4: 00000000003606e0
> Dec 11 10:28:54 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Dec 11 10:28:54 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Dec 11 10:28:54 kernel: Call Trace:
> Dec 11 10:28:54 kernel:  <IRQ>
> Dec 11 10:28:54 kernel:  skb_release_all+0xe/0x30
> Dec 11 10:28:54 kernel:  kfree_skb+0x32/0xa0
> Dec 11 10:28:54 kernel:  enqueue_to_backlog+0x99/0x230
> Dec 11 10:28:54 kernel:  ? recalibrate_cpu_khz+0x10/0x10
> Dec 11 10:28:54 kernel:  netif_rx_internal+0x41/0x100
> Dec 11 10:28:54 kernel:  netif_rx+0x18/0xb0
> Dec 11 10:28:54 kernel:  can_get_echo_skb+0x32/0x60 [can_dev]
> Dec 11 10:28:54 kernel:  usb_8dev_write_bulk_callback+0x7d/0xb0 [usb_8dev]
> Dec 11 10:28:54 kernel:  __usb_hcd_giveback_urb+0x6f/0x120 [usbcore]

Did you do anything weird (e.g. pulling the USB plug on the run) to get 
this problem?

Best,
Oliver
