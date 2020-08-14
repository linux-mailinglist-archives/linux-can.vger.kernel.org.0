Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B322244BA0
	for <lists+linux-can@lfdr.de>; Fri, 14 Aug 2020 17:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgHNPI0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Aug 2020 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNPIZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Aug 2020 11:08:25 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C6C061384
        for <linux-can@vger.kernel.org>; Fri, 14 Aug 2020 08:08:25 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so11144068iod.1
        for <linux-can@vger.kernel.org>; Fri, 14 Aug 2020 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/s2FrX3sOZH7no5QOEmHRzOhQVsVJV+GlCWiadD/1Y=;
        b=LEWYvBdNwTdiV0b8gagS099psX2ZTBY08MCdDLkfhQmHSUVkjzakpT0EfxfiCAYaE8
         /OkkJXoSbJ6veoGQVa3lmvWYmhsJF9jcEWcztXamvh77ReCnPiG0d1cetjiChrUMi4vf
         TvWqrjfc1wIT3ogVPxlvE7jo7QJHGBLIcpZF9Zoc/LQby6CVF9FdDkVFf5S99X97VslS
         qPlRhUMonmBDJLxsx5hj8Hu3cAaDPX5T8Gh2CsbatiS3i39mWQ3efAOzsbdT7ZWO3T/q
         jx1fhEqDviWXcPyOI2PZ5vjEBUV9/BV04FBlc7tKTj2Q9cBwg/KTZozPjg3a04C+IqT0
         rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/s2FrX3sOZH7no5QOEmHRzOhQVsVJV+GlCWiadD/1Y=;
        b=ja+G3mEyvtdWZiCleU7Nf/GPjn8aKievXr4soynyjXV75LOZb2RmIQYfdIjPfhZLmL
         DHtr5Ayh+q2C/OYbUBB2eqlip5hcjuaUvt6Fzw3AXkx6D7kFjgQbiHKgDcIgFKSRM+bY
         QM8o4Wg7sb7UkaCudUoZyMExGODw7qxF9gZlRBBW3Ddrjdzob2OESqLZ5H7gB1iDqIoF
         yk0On/ph4ee7oOHoL5mKtkwAGQVI7azh6jCmwwVjAlbQ1cf6r1be77fn7QSTZH0avy/f
         P7OyDwhLWTn+fOcJvF4Qprb1fp0yZeZQen/zwoY56nGZwszd85D+ni28aNZdRn3JTMYb
         OAxQ==
X-Gm-Message-State: AOAM533Ya8pAFYaLWqzFpl4NPcORmoh1fiNBJ5FVei4EjMgXm337J4lR
        IsnpdHmfccurQALrhcDE+HsroiTmnHLNL+GIgBN58Q==
X-Google-Smtp-Source: ABdhPJzdGGuDLFD574yj/KgkS3PLqUK92XBd83rc5Qk4H3COqG6GLDYdIApTwhzmJJy7esoAuG0qE1EejRn5qkW3fKM=
X-Received: by 2002:a02:3f0d:: with SMTP id d13mr3023467jaa.99.1597417702800;
 Fri, 14 Aug 2020 08:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200814110428.405051-1-mkl@pengutronix.de> <20200814110428.405051-2-mkl@pengutronix.de>
 <CAG_fn=U8djv7NEWi5Zc+_=8Bh_srT4M6gObnVFLON+sEkWFv9w@mail.gmail.com>
In-Reply-To: <CAG_fn=U8djv7NEWi5Zc+_=8Bh_srT4M6gObnVFLON+sEkWFv9w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Aug 2020 08:08:11 -0700
Message-ID: <CANn89iLX_w0Bz211qPk_npCqq1NbBQsGMNZkkZQgC_qa7k+KaQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] can: j1939: fix kernel-infoleak in j1939_sk_sock2sockaddr_can()
To:     Alexander Potapenko <glider@google.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>, linux-can@vger.kernel.org,
        kernel@pengutronix.de, syzbot <syzkaller@googlegroups.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Aug 14, 2020 at 6:20 AM Alexander Potapenko <glider@google.com> wrote:
>
>
>
> On Fri, Aug 14, 2020, 13:04 Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>

>>  net/can/j1939/socket.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
>> index 78ff9b3f1d40..b634b680177f 100644
>> --- a/net/can/j1939/socket.c
>> +++ b/net/can/j1939/socket.c
>> @@ -553,6 +553,11 @@ static int j1939_sk_connect(struct socket *sock, struct sockaddr *uaddr,
>>  static void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
>>                                        const struct j1939_sock *jsk, int peer)
>>  {
>> +       /* There are two holes (2 bytes and 3 bytes) to clear to avoid
>> +        * leaking kernel information to user space.
>> +        */
>
>
> Do we want to keep these "2 bytes and 3 bytes' in sync with the struct layout in the future? Maybe it's not worth it to mention the exact sizes?

struct is uapi, you will have a hard time trying to use these holes,
since old kernels were sending crap/garbage/passwords ;)
