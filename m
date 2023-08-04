Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8076FFFD
	for <lists+linux-can@lfdr.de>; Fri,  4 Aug 2023 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjHDMMs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Aug 2023 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHDMMq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Aug 2023 08:12:46 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B2C46A6
        for <linux-can@vger.kernel.org>; Fri,  4 Aug 2023 05:12:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40c72caec5cso287291cf.0
        for <linux-can@vger.kernel.org>; Fri, 04 Aug 2023 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691151160; x=1691755960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s9PeUooyC8qhvBcKQS9T55d/lYfQlIqcG46kUEyt5c=;
        b=o3SUOv0fNU/Qo6QS5FN1/gksOhXGAjzxwow+NBsX+ymC7vDvYILpALy+vji0CWqCp2
         KIW4sE6XVCzevU0RkfdsMbNWMjZl7BwHhWCXVXtUefyEqGFIe/ftjTLRbScS9W3nhG+8
         GJUtKVFaQSgeL41akKY3PGrVF0Y/BoXVDepjkj2QEG6WhIzHTeaF8G4wMxX6332i5Y3S
         wLrEC6Jgm5sSx/BaOvoO6cuxH+9lI/5u2RyRulQcSMtupqtNZ93KVBH/eVUdfFNj0V0p
         YjX97C8IuVj/EPd8DYAsPjfLn1BeCb6mRcGHUgUVmY6KU1cgz8ASrT73nO8x7QiN10Pk
         J1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691151160; x=1691755960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s9PeUooyC8qhvBcKQS9T55d/lYfQlIqcG46kUEyt5c=;
        b=VEhyjawU+PpXpB+XRdRx2cg99ddESk5XTBdKg3wmZzcKJ62tpyAsd2CHIcIHqKMLzd
         RcYYyzF59D/WvY7QXEVZd8kRTf32AAR0fkqFplR97c7CyUKvOCa6ikkIHMU3D2iB0o7K
         zRQx5bEYfD/uWR+4npcpQ6IBgF0M0V0xXWgA7ixA6WwS0dXEHv5VFx9I6SmsW1hImWzm
         Nhm0XzBc0Qv3cLxUvknUbYXziuD5L+nFuKTbc4fqN4KtnPNi6UKt9fy6ybxuabktLytJ
         nzdBmJGhquRJpGld8q/IBazQqgiHKMRrJxTQsvZR91z3OYso5LgZpd7mSwAK66vDYf32
         BT/w==
X-Gm-Message-State: AOJu0Yxpm3fujqVb1rflujwo10ziymgAnEaQTLpIjVr42dFaz9jkqVLa
        Dvnu2wdVacIXdIBY2KF7//kCQZf6H+dIfhRxLUIE63OO5PKS53e70Ls=
X-Google-Smtp-Source: AGHT+IGb6ZvfdGnbJV2KGJ8pa6r7RBZf7XZLkoEPxSC09gnEE1vK2ztjEGlDDxGEGLQjXsAFP2ijWd3gu+2rI7YBKbo=
X-Received: by 2002:a05:622a:1884:b0:403:a43d:bd7d with SMTP id
 v4-20020a05622a188400b00403a43dbd7dmr244515qtc.4.1691151159985; Fri, 04 Aug
 2023 05:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230804112811.42259-1-socketcan@hartkopp.net>
In-Reply-To: <20230804112811.42259-1-socketcan@hartkopp.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 4 Aug 2023 14:12:29 +0200
Message-ID: <CANn89iJKNSOp+1SQuD_T3M2TQo-4HOsYVV6MwoPVwQjdrb7JKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] can: raw: add missing refcount for memory leak fix
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        Ziyang Xuan <william.xuanziyang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Aug 4, 2023 at 1:28=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp.=
net> wrote:
>
> Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
> a new reference to the CAN netdevice that has assigned CAN filters.
> But this new ro->dev reference did not maintain its own refcount which
> lead to another KASAN use-after-free splat found by Eric Dumazet.
>
> This patch ensures a proper refcount for the CAN nedevice.

Hi Olivier

I would feel a bit safer with new longterm device references if you
could add an ro->dev_tracker and use netdev_put() netdev_hold() and
friends ;)

Thanks !

>
> Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/raw.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/net/can/raw.c b/net/can/raw.c
> index e10f59375659..a61c417fdd27 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -283,12 +283,14 @@ static void raw_notify(struct raw_sock *ro, unsigne=
d long msg,
>
>         switch (msg) {
>         case NETDEV_UNREGISTER:
>                 lock_sock(sk);
>                 /* remove current filters & unregister */
> -               if (ro->bound)
> +               if (ro->bound) {
>                         raw_disable_allfilters(dev_net(dev), dev, sk);
> +                       dev_put(dev);
> +               }
>
>                 if (ro->count > 1)
>                         kfree(ro->filter);
>
>                 ro->ifindex =3D 0;
> @@ -389,14 +391,16 @@ static int raw_release(struct socket *sock)
>         rtnl_lock();
>         lock_sock(sk);
>
>         /* remove current filters & unregister */
>         if (ro->bound) {
> -               if (ro->dev)
> +               if (ro->dev) {
>                         raw_disable_allfilters(dev_net(ro->dev), ro->dev,=
 sk);
> -               else
> +                       dev_put(ro->dev);
> +               } else {
>                         raw_disable_allfilters(sock_net(sk), NULL, sk);
> +               }
>         }
>
>         if (ro->count > 1)
>                 kfree(ro->filter);
>
> @@ -447,36 +451,43 @@ static int raw_bind(struct socket *sock, struct soc=
kaddr *uaddr, int len)
>                 if (dev->type !=3D ARPHRD_CAN) {
>                         dev_put(dev);
>                         err =3D -ENODEV;
>                         goto out;
>                 }
> -               if (!(dev->flags & IFF_UP))
> -                       notify_enetdown =3D 1;
> -
> -               ifindex =3D dev->ifindex;
>
>                 /* filters set by default/setsockopt */
>                 err =3D raw_enable_allfilters(sock_net(sk), dev, sk);
> -               dev_put(dev);
> +               if (err) {
> +                       dev_put(dev);
> +                       goto out;
> +               }
> +
> +               ifindex =3D dev->ifindex;
> +               if (!(dev->flags & IFF_UP))
> +                       notify_enetdown =3D 1;
>         } else {
>                 ifindex =3D 0;
>
>                 /* filters set by default/setsockopt */
>                 err =3D raw_enable_allfilters(sock_net(sk), NULL, sk);
>         }
>
>         if (!err) {
>                 if (ro->bound) {
>                         /* unregister old filters */
> -                       if (ro->dev)
> +                       if (ro->dev) {
>                                 raw_disable_allfilters(dev_net(ro->dev),
>                                                        ro->dev, sk);
> -                       else
> +                               /* drop reference to old ro->dev */
> +                               dev_put(ro->dev);
> +                       } else {
>                                 raw_disable_allfilters(sock_net(sk), NULL=
, sk);
> +                       }
>                 }
>                 ro->ifindex =3D ifindex;
>                 ro->bound =3D 1;
> +               /* bind() ok -> holding a reference to new ro->dev */
>                 ro->dev =3D dev;
>         }
>
>   out:
>         release_sock(sk);
> --
> 2.39.2
>
