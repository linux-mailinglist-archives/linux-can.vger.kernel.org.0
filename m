Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7FBFC0B5
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2019 08:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfKNHYn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Nov 2019 02:24:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40240 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNHYn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Nov 2019 02:24:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id j26so4158618lfh.7
        for <linux-can@vger.kernel.org>; Wed, 13 Nov 2019 23:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VzADENh7Kdnoiehx7lHy3ibgcb6G8dufNurQ6QKIcF4=;
        b=vrHqCKgDTsRpUxz0HgjWwI6eqrjmUpsvwKcO0E1fNAOyLcNnNSu2swX50WWQ8mnkof
         u4D3fuM/32shmbOGH1rmsrVMcjUdWLkWBTiSMibJueFX3CXxVgohK1uXcnBXUla22RPN
         ObnowvVCavrGf/OppgU8+7066OW0AN+ChJFa6GW3lUiY0Ky4yRWdal2pdhvNzoU1R/eQ
         q/TjQ1XKTeRQpGb1qG9j3gI8ERjuotDYmVq1FnYBPYjkyiPW/xdZQHAsejDPn3TgCFuM
         UWPTbOv+fHblGOuKlINdNs+dxIOSP0ubLb+FzBgGoOyN6exBwmE5z2MrRNBNWnm4PsCL
         jmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=VzADENh7Kdnoiehx7lHy3ibgcb6G8dufNurQ6QKIcF4=;
        b=p+OQy0iFpTEUc5P0twJcZUBeRzQR65RHYXFrWfIeOWlyDk8J88lzMh10IRaqw4rj+f
         7F07RGQOraNp+jb9xHcE18ORRPQeIEX+Nry2nFVpMEofjBL0QBYLVjIr/u6hE4jjkSDo
         uU8X9D4/zLD9nbe7R/V+JGuABS0j5Qg5w6JOfHQ1by670hpH8REbRmhX2TETaTbjBKm+
         vKjKcFRm9K99/WIkhZ3idTmBlP/F1Djkioz4/TDFy2B698kdiCZdq65ElP81HWmCh5mE
         vJXodzcxiMnTCCy5hugFMdyv9d1slfq703j0QyQE4F9hwjLcA/9acoJLsIzme5hvtQSX
         1nDw==
X-Gm-Message-State: APjAAAU28vSOzPJ+MbVotM20zpU9/zCmweykMZ9AhMF2wjid90UFapZK
        AHsPGOT7fNFCWahAdcynhDZKjQ==
X-Google-Smtp-Source: APXvYqxEmRNz+ut3qFzbbmp922h/OTvOqTBBMzcVw4Q9DGjWJ0x++O0yVMe+8xcDYLwHJBzXYLw+kw==
X-Received: by 2002:ac2:5288:: with SMTP id q8mr5658036lfm.138.1573716280605;
        Wed, 13 Nov 2019 23:24:40 -0800 (PST)
Received: from GL-434 ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id b80sm2125691lfg.49.2019.11.13.23.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 23:24:40 -0800 (PST)
From:   jouni.hogander@unikie.com (Jouni =?utf-8?Q?H=C3=B6gander?=)
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] slcan: Fix memory leak in error path
References: <20191113100801.19803-1-jouni.hogander@unikie.com>
Date:   Thu, 14 Nov 2019 09:24:38 +0200
In-Reply-To: <20191113100801.19803-1-jouni.hogander@unikie.com> (jouni
        hogander's message of "Wed, 13 Nov 2019 12:08:01 +0200")
Message-ID: <87woc2apjd.fsf@unikie.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

jouni.hogander@unikie.com writes:

> From: Jouni Hogander <jouni.hogander@unikie.com>
>
> This patch is fixing memory leak reported by Syzkaller:
>
> BUG: memory leak unreferenced object 0xffff888067f65500 (size 4096):
>   comm "syz-executor043", pid 454, jiffies 4294759719 (age 11.930s)
>   hex dump (first 32 bytes):
>     73 6c 63 61 6e 30 00 00 00 00 00 00 00 00 00 00 slcan0..........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>   backtrace:
>     [<00000000a06eec0d>] __kmalloc+0x18b/0x2c0
>     [<0000000083306e66>] kvmalloc_node+0x3a/0xc0
>     [<000000006ac27f87>] alloc_netdev_mqs+0x17a/0x1080
>     [<0000000061a996c9>] slcan_open+0x3ae/0x9a0
>     [<000000001226f0f9>] tty_ldisc_open.isra.1+0x76/0xc0
>     [<0000000019289631>] tty_set_ldisc+0x28c/0x5f0
>     [<000000004de5a617>] tty_ioctl+0x48d/0x1590
>     [<00000000daef496f>] do_vfs_ioctl+0x1c7/0x1510
>     [<0000000059068dbc>] ksys_ioctl+0x99/0xb0
>     [<000000009a6eb334>] __x64_sys_ioctl+0x78/0xb0
>     [<0000000053d0332e>] do_syscall_64+0x16f/0x580
>     [<0000000021b83b99>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     [<000000008ea75434>] 0xffffffffffffffff
>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
> ---
>  drivers/net/can/slcan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index bb6032211043..0a9f42e5fedf 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -617,6 +617,7 @@ static int slcan_open(struct tty_struct *tty)
>  	sl->tty =3D NULL;
>  	tty->disc_data =3D NULL;
>  	clear_bit(SLF_INUSE, &sl->flags);
> +	free_netdev(sl->dev);
>=20=20
>  err_exit:
>  	rtnl_unlock();

Observed panic in another error path in my overnight Syzkaller run with
this patch. Better not to apply it. Sorry for inconvenience.

BR,

Jouni H=C3=B6gander
