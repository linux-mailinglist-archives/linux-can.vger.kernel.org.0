Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758ABFAE90
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 11:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKMKb0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 05:31:26 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:23373 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMKb0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2019 05:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573641084;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=W2ac4lgJr1e/W4aXTlKO0x3lNG/DuLUqPxIAzbKAsuE=;
        b=WA0rYr+fZ9BgKNHK64iBBrvIIsZrtKGvoYHyX6c115IDDr6SX1AXEwrjuXPzD34COB
        EC4znyeNYDm5mwAtLjnhjXsSFyJ4aJNjCUfqSoNbTnnKlOkaPLKSEWUKVCtWz3Z+FWhR
        U9/vm/RJEPXyypvvki2BM0CiGhzDqY00xL9Wr5ZpO/jDvYgc3PohPihpQXPLGktY6/ev
        6Qx94a04RgAvCF3eY7mZflWsiowlORLFLAYGICE3bXHN8/O1QxRl6FP0AdS6rjwTG/lZ
        4wd/4gu1kiZsjDKG0yM8ejDsblRGje5VrO3/okwc9zgx98xhTeFXdy1Zy5yS23Ca0Evs
        ny5g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onjMalKFWXBdFnhSk9f/"
X-RZG-CLASS-ID: mo00
Received: from [10.120.65.22]
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id C03a03vADAVNiki
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 11:31:23 +0100 (CET)
Subject: Re: [PATCH] slcan: Fix memory leak in error path
To:     jouni.hogander@unikie.com, linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20191113100801.19803-1-jouni.hogander@unikie.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a45ac1fb-d653-bc87-b2f6-bd1a41e29907@hartkopp.net>
Date:   Wed, 13 Nov 2019 11:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113100801.19803-1-jouni.hogander@unikie.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 13/11/2019 11.08, jouni.hogander@unikie.com wrote:
> From: Jouni Hogander <jouni.hogander@unikie.com>
> 
> This patch is fixing memory leak reported by Syzkaller:
> 
> BUG: memory leak unreferenced object 0xffff888067f65500 (size 4096):
>    comm "syz-executor043", pid 454, jiffies 4294759719 (age 11.930s)
>    hex dump (first 32 bytes):
>      73 6c 63 61 6e 30 00 00 00 00 00 00 00 00 00 00 slcan0..........
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>    backtrace:
>      [<00000000a06eec0d>] __kmalloc+0x18b/0x2c0
>      [<0000000083306e66>] kvmalloc_node+0x3a/0xc0
>      [<000000006ac27f87>] alloc_netdev_mqs+0x17a/0x1080
>      [<0000000061a996c9>] slcan_open+0x3ae/0x9a0
>      [<000000001226f0f9>] tty_ldisc_open.isra.1+0x76/0xc0
>      [<0000000019289631>] tty_set_ldisc+0x28c/0x5f0
>      [<000000004de5a617>] tty_ioctl+0x48d/0x1590
>      [<00000000daef496f>] do_vfs_ioctl+0x1c7/0x1510
>      [<0000000059068dbc>] ksys_ioctl+0x99/0xb0
>      [<000000009a6eb334>] __x64_sys_ioctl+0x78/0xb0
>      [<0000000053d0332e>] do_syscall_64+0x16f/0x580
>      [<0000000021b83b99>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>      [<000000008ea75434>] 0xffffffffffffffff
> 
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

@Jouni: Can you please take a look into slip_open() in
drivers/net/slip/slip.c ?

The slcan code is adapted from the original slip.c at this point. I 
checked that the same problem can be found in slip.c too.

Best regards,
Oliver

> ---
>   drivers/net/can/slcan.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index bb6032211043..0a9f42e5fedf 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -617,6 +617,7 @@ static int slcan_open(struct tty_struct *tty)
>   	sl->tty = NULL;
>   	tty->disc_data = NULL;
>   	clear_bit(SLF_INUSE, &sl->flags);
> +	free_netdev(sl->dev);
>   
>   err_exit:
>   	rtnl_unlock();
> 
