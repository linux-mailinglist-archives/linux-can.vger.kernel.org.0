Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A6FAF6F
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfKMLO6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 06:14:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36736 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfKMLO5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2019 06:14:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so2119171lja.3
        for <linux-can@vger.kernel.org>; Wed, 13 Nov 2019 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AMwhagyFKUWzkBvWduiSMiM/To4kF5PXl+dM5XYJ8Cc=;
        b=1ZxDdAGEJOL79x2afBLRqnbDVbVlYiA6j/TViUIpW7r5vmI04FWN5d+MQ4zpDEhh2M
         9eBstCMBhAmdy00RYZrABBVX7kiSFMJfPXjrD8gtd8cB/1YqYIPIVd+VDGvzIxL+VeiJ
         4whfHIEJz6QvzX45G8YCHOYsBYyLgt6YbTaJThl/u8KAPbo+TRDNdpCsndesL4NVKzDZ
         RPgV0d/0JN+wsNel1fF47QFU3PIFekLVgKrcD8WKl+siMnajBz85ToEtcx7gZhUy5F/O
         OuGzq4IVY/+sR134yhTr9YlTGU5CIiCpvOzh8UirBPJnr/7XbReV2Gtr0b6athSeyp1a
         /1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=AMwhagyFKUWzkBvWduiSMiM/To4kF5PXl+dM5XYJ8Cc=;
        b=J00qexWfiVgMxDIOu9eeFahKyzKhgqPPDUtFKyvc9RHBFLBnj4ARsfz0AMVFdr79u4
         YpScuxIXdmp3PekmsOu1KIx+LDUtC2kNGL6A7DgM+6EgI+o/0bpZ4TE6ujVJXDS4dNF5
         Y5CaipBG11fmYK6um3Ig0DM8n0Q2/UP/lfm0qnZqNwXMjXZQmoNP853u9D8WOhH+3CGR
         NUPgAM0qOz0ii/WzplDQ1yng8ndJtjvqz4kkRDkLXQuBchSvomm9xyNTzu5K/EfBBSIb
         CoFl43YTow+StQ4BmNoy+qe8rxICOG2VdchFGKOKVlqOfgZlzRRdAFfjI5HZyUUgTnrE
         NGEw==
X-Gm-Message-State: APjAAAW8CqWs6tRrKf2H7QmdF+kkhtcvD6P8T0B6B9XvpRcbMkz2qdv5
        jLLngUPAd6yNELj9Lx9rqrWeOg==
X-Google-Smtp-Source: APXvYqz6VVkw22zDe0X1S9QmkEEn/eFhS4fCwSWZDFFUBuSE2f075Ue4geOpF+DwpmOFtFlpKliEsw==
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr2232598lji.148.1573643695580;
        Wed, 13 Nov 2019 03:14:55 -0800 (PST)
Received: from GL-434 ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id x18sm733611ljc.39.2019.11.13.03.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 03:14:54 -0800 (PST)
From:   jouni.hogander@unikie.com (Jouni =?utf-8?Q?H=C3=B6gander?=)
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] slcan: Fix memory leak in error path
References: <20191113100801.19803-1-jouni.hogander@unikie.com>
        <a45ac1fb-d653-bc87-b2f6-bd1a41e29907@hartkopp.net>
Date:   Wed, 13 Nov 2019 13:14:53 +0200
In-Reply-To: <a45ac1fb-d653-bc87-b2f6-bd1a41e29907@hartkopp.net> (Oliver
        Hartkopp's message of "Wed, 13 Nov 2019 11:31:23 +0100")
Message-ID: <87pnhwownm.fsf@unikie.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan@hartkopp.net> writes:

> On 13/11/2019 11.08, jouni.hogander@unikie.com wrote:
>> From: Jouni Hogander <jouni.hogander@unikie.com>
>>
>> This patch is fixing memory leak reported by Syzkaller:
>>
>> BUG: memory leak unreferenced object 0xffff888067f65500 (size 4096):
>>    comm "syz-executor043", pid 454, jiffies 4294759719 (age 11.930s)
>>    hex dump (first 32 bytes):
>>      73 6c 63 61 6e 30 00 00 00 00 00 00 00 00 00 00 slcan0..........
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>    backtrace:
>>      [<00000000a06eec0d>] __kmalloc+0x18b/0x2c0
>>      [<0000000083306e66>] kvmalloc_node+0x3a/0xc0
>>      [<000000006ac27f87>] alloc_netdev_mqs+0x17a/0x1080
>>      [<0000000061a996c9>] slcan_open+0x3ae/0x9a0
>>      [<000000001226f0f9>] tty_ldisc_open.isra.1+0x76/0xc0
>>      [<0000000019289631>] tty_set_ldisc+0x28c/0x5f0
>>      [<000000004de5a617>] tty_ioctl+0x48d/0x1590
>>      [<00000000daef496f>] do_vfs_ioctl+0x1c7/0x1510
>>      [<0000000059068dbc>] ksys_ioctl+0x99/0xb0
>>      [<000000009a6eb334>] __x64_sys_ioctl+0x78/0xb0
>>      [<0000000053d0332e>] do_syscall_64+0x16f/0x580
>>      [<0000000021b83b99>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>      [<000000008ea75434>] 0xffffffffffffffff
>>
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> @Jouni: Can you please take a look into slip_open() in
> drivers/net/slip/slip.c ?
>
> The slcan code is adapted from the original slip.c at this point. I
> checked that the same problem can be found in slip.c too.
>

Ok, I will check it and send patch for that as well. Thank you for
pointing this out.

BR,

Jouni H=C3=B6gander
