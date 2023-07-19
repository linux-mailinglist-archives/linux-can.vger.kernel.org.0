Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361D7758C2A
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 05:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGSDc3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 23:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGSDbt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 23:31:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBFB173A
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 20:31:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40371070eb7so479801cf.1
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689737499; x=1692329499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WGKKu7kZoCnbjCX34tBWkzIVGJY3tJhRvan09NcUvU=;
        b=bKkgMv4vS0BAs5XtiLOziKLdKe/OxNIBls/oFRr5wOZJzGiUI1c8RiI23pJWECj88b
         qmYDvp8gSD5hXd9VPfXkx1/Nd+1jvCt7BSo7R3dwZTsncfdN+FxQu1HkNtOzcTrAB0b5
         LJtF8MFq77vAcwk5seJBWELcNu9IlkTXenHGJF75Gir2gjIpY1ok0brn9bxVI5b2rGub
         /1pVP/1qsgAaYtZmvsCiksnYhgWxBxxpLddhFNLYF2E4ujDO/xlQx/99003ND7reIPbA
         TgV3bwj8WRKuVTvDG7TpMSxPnc93fDDfkI0Dat4qQHL5gFX4i+X4GQoVlMAlT/cohMfK
         Uwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689737499; x=1692329499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WGKKu7kZoCnbjCX34tBWkzIVGJY3tJhRvan09NcUvU=;
        b=Tuew+nZIsSX7yxkzxpxDVnJ4YW/6ohSR8rQUUik4kYRQ1XoyIOQO5QBMCLEMlFW9a5
         Fcb2dolvryhgBEZLjwSJSED/LxCV+gU+u7E86a2r8sb/B/7HLwvIxch4TUv1NZmDscxC
         DF64P/gIaVW8kAN3U+L8yO1O5WKPSjmJMhwwwBSGRil5V5lwLlL8KBJLl62ZC6Q8x0GI
         8EuKlmG6fbq1XAdHsWc+Qs7slIvZtEWtp4O2yBqpQFLJfXhU5j1zASzE0IVGx6NBAZjr
         Ha/RfmMSu4bdAlsGtbLlqxwT9jCbiXhnRjtdASO9UhfBhovebM//JOHcYlVRfpep6m2B
         pIag==
X-Gm-Message-State: ABy/qLZJnryP1LlVGHtadK5zUeYsaRfa5gap+FuDFgGUQytKLfOkP6+v
        UhTaKuuPo51ATXv6ySP1s4rhTdy8q9F0d8eNmCoGTA==
X-Google-Smtp-Source: APBJJlG5qPMRFvaVadD1Xf8LaY9bLavGxePqz94LiSjYZEAOxx/qqckQ4ZhDvFo9boxqtLR2Tomw7AXDYwXCeH1XhSI=
X-Received: by 2002:a05:622a:312:b0:3fa:3c8f:3435 with SMTP id
 q18-20020a05622a031200b003fa3c8f3435mr377994qtw.27.1689737499247; Tue, 18 Jul
 2023 20:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com> <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
In-Reply-To: <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 19 Jul 2023 05:31:28 +0200
Message-ID: <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Ziyang Xuan <william.xuanziyang@huawei.com>,
        socketcan@hartkopp.net, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jul 17, 2023 at 9:27=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
> > Got kmemleak errors with the following ltp can_filter testcase:
> >
> > for ((i=3D1; i<=3D100; i++))
> > do
> >         ./can_filter &
> >         sleep 0.1
> > done
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
> > [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
> > [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
> > [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
> > [<00000000fd468496>] do_syscall_64+0x33/0x40
> > [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > It's a bug in the concurrent scenario of unregister_netdevice_many()
> > and raw_release() as following:
> >
> >              cpu0                                        cpu1
> > unregister_netdevice_many(can_dev)
> >   unlist_netdevice(can_dev) // dev_get_by_index() return NULL after thi=
s
> >   net_set_todo(can_dev)
> >                                               raw_release(can_socket)
> >                                                 dev =3D dev_get_by_inde=
x(, ro->ifindex); // dev =3D=3D NULL
> >                                                 if (dev) { // receivers=
 in dev_rcv_lists not free because dev is NULL
> >                                                   raw_disable_allfilter=
s(, dev, );
> >                                                   dev_put(dev);
> >                                                 }
> >                                                 ...
> >                                                 ro->bound =3D 0;
> >                                                 ...
> >
> > call_netdevice_notifiers(NETDEV_UNREGISTER, )
> >   raw_notify(, NETDEV_UNREGISTER, )
> >     if (ro->bound) // invalid because ro->bound has been set 0
> >       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists wi=
ll never be freed
> >
> > Add a net_device pointer member in struct raw_sock to record bound can_=
dev,
> > and use rtnl_lock to serialize raw_socket members between raw_bind(), r=
aw_release(),
> > raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to fre=
e receivers in
> > dev_rcv_lists.
> >
> > Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice noti=
fier")
> > Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> > Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Added to linux-can/testing.
>

This patch causes three syzbot LOCKDEP reports so far.

I suspect we need something like the following patch.

If nobody objects, I will submit this formally soon.

diff --git a/net/can/raw.c b/net/can/raw.c
index 2302e48829677334f8b2d74a479e5a9cbb5ce03c..ba6b52b1d7767fdd7b57d1b8e55=
19495340c572c
100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -386,9 +386,9 @@ static int raw_release(struct socket *sock)
        list_del(&ro->notifier);
        spin_unlock(&raw_notifier_lock);

+       rtnl_lock();
        lock_sock(sk);

-       rtnl_lock();
        /* remove current filters & unregister */
        if (ro->bound) {
                if (ro->dev)
@@ -405,12 +405,13 @@ static int raw_release(struct socket *sock)
        ro->dev =3D NULL;
        ro->count =3D 0;
        free_percpu(ro->uniq);
-       rtnl_unlock();

        sock_orphan(sk);
        sock->sk =3D NULL;

        release_sock(sk);
+       rtnl_unlock();
+
        sock_put(sk);

        return 0;
