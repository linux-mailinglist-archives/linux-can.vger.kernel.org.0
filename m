Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2358FFC1DF
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2019 09:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNIu5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Nov 2019 03:50:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35122 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNIu5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Nov 2019 03:50:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so4390647lfl.2
        for <linux-can@vger.kernel.org>; Thu, 14 Nov 2019 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AhNWycihMyGikBcJvM9ujpsSC0ZMk9L/jLc35VvyDSo=;
        b=tFt3oT92Phlso2NJd6fDVJNj3RtFTaWs2TCdjiTFysSJXmDQiOx1GTXG5FeKJ7+O2X
         V0LQfvZvuomD+XIPRv9cVW0KHyNgyr/XJEEcWnSoEbbiGgZjDizWGo2eVpmEMJvmHnD/
         wgLC080/vaVra5sb3AGIzcaJtDtxxo59Jy3NlvceuVi6sT6nJNalZG3b+YSR/Zbsr6Ef
         6VjK+Gd/e6F1bsuJ6Jv/E2A8GWyi3EMUDr1C5BsZv3mZGyVfTjWRpggsCok3XuiQkYmn
         T2eLURrZSx6jj5am1GAEtyt6eFx37lwEJa612XO9DrpWCwKTTJxcHsXoTEbha27nGRWp
         FzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=AhNWycihMyGikBcJvM9ujpsSC0ZMk9L/jLc35VvyDSo=;
        b=mZz9e0Vkwit4jgIHMTvLWMInrVP8TSHfUBfVX0LKEMSZ4zSAxAJQ4Sc8G8wmNwT8Zo
         8/8gt9oF1PVAgVPNpdm9wosqaxhN2ZYN8ZqrKaWZnJO9JKTPyVojfZTlOorwrjZe7kUr
         YdpFptTBpAEiPtE6YGuASeNYxKuAGaF6gwmJRuPtQwnA5bKIo+H/OC7LTS48ua6SeFTZ
         gACbmmGUF27gqJWUmpfJP4T4ejgAXZZgt57BbWwTY3olDqL22rVhW/cXApd3/lGLtXsh
         X1FCX8NUWZ4vQGtlKOG3P+hPI84lzuwn6sFNMKEj7AT/NjGVXtdXMtaeGEK4+YdPZHRc
         XdcQ==
X-Gm-Message-State: APjAAAU9GHvac75RcQXxmnkUCODubF6gnApdWM1UUcVtdJq11LDTLK+F
        6EFEvIQybqlkYEipg2NQ+TWHiuGWy/HOXA==
X-Google-Smtp-Source: APXvYqw4NDX3pPlsQtNHWCjooYwzAk0q2iAxsXE8oErneAqSJMWKy7gvfGRZem0iZWHNI47/v++cIQ==
X-Received: by 2002:ac2:5b47:: with SMTP id i7mr5897785lfp.82.1573721454677;
        Thu, 14 Nov 2019 00:50:54 -0800 (PST)
Received: from GL-434 ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id j10sm2298051lfc.43.2019.11.14.00.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 00:50:54 -0800 (PST)
From:   jouni.hogander@unikie.com (Jouni =?utf-8?Q?H=C3=B6gander?=)
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] slcan: Fix memory leak in error path
References: <20191113100801.19803-1-jouni.hogander@unikie.com>
        <87woc2apjd.fsf@unikie.com>
Date:   Thu, 14 Nov 2019 10:50:52 +0200
In-Reply-To: <87woc2apjd.fsf@unikie.com> ("Jouni \=\?utf-8\?Q\?H\=C3\=B6gander\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Thu,
        14 Nov 2019 09:24:38 +0200")
Message-ID: <87o8xealjn.fsf@unikie.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

jouni.hogander@unikie.com (Jouni H=C3=B6gander) writes:

> jouni.hogander@unikie.com writes:
>
>> From: Jouni Hogander <jouni.hogander@unikie.com>
>>
>> This patch is fixing memory leak reported by Syzkaller:
>>
>> BUG: memory leak unreferenced object 0xffff888067f65500 (size 4096):
>>   comm "syz-executor043", pid 454, jiffies 4294759719 (age 11.930s)
>>   hex dump (first 32 bytes):
>>     73 6c 63 61 6e 30 00 00 00 00 00 00 00 00 00 00 slcan0..........
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>   backtrace:
>>     [<00000000a06eec0d>] __kmalloc+0x18b/0x2c0
>>     [<0000000083306e66>] kvmalloc_node+0x3a/0xc0
>>     [<000000006ac27f87>] alloc_netdev_mqs+0x17a/0x1080
>>     [<0000000061a996c9>] slcan_open+0x3ae/0x9a0
>>     [<000000001226f0f9>] tty_ldisc_open.isra.1+0x76/0xc0
>>     [<0000000019289631>] tty_set_ldisc+0x28c/0x5f0
>>     [<000000004de5a617>] tty_ioctl+0x48d/0x1590
>>     [<00000000daef496f>] do_vfs_ioctl+0x1c7/0x1510
>>     [<0000000059068dbc>] ksys_ioctl+0x99/0xb0
>>     [<000000009a6eb334>] __x64_sys_ioctl+0x78/0xb0
>>     [<0000000053d0332e>] do_syscall_64+0x16f/0x580
>>     [<0000000021b83b99>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>     [<000000008ea75434>] 0xffffffffffffffff
>>
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
>> ---
>>  drivers/net/can/slcan.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
>> index bb6032211043..0a9f42e5fedf 100644
>> --- a/drivers/net/can/slcan.c
>> +++ b/drivers/net/can/slcan.c
>> @@ -617,6 +617,7 @@ static int slcan_open(struct tty_struct *tty)
>>  	sl->tty =3D NULL;
>>  	tty->disc_data =3D NULL;
>>  	clear_bit(SLF_INUSE, &sl->flags);
>> +	free_netdev(sl->dev);
>>=20=20
>>  err_exit:
>>  	rtnl_unlock();
>
> Observed panic in another error path in my overnight Syzkaller run with
> this patch. Better not to apply it. Sorry for inconvenience.

The panic was caused by another error path fix I had in my Syzkaller
setup. I.e. this patch is ok.

BR,

Jouni H=C3=B6gander
