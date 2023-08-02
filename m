Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55276D602
	for <lists+linux-can@lfdr.de>; Wed,  2 Aug 2023 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHBRt5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Aug 2023 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBRtl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2023 13:49:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4B44B0
        for <linux-can@vger.kernel.org>; Wed,  2 Aug 2023 10:48:57 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so26271cf.0
        for <linux-can@vger.kernel.org>; Wed, 02 Aug 2023 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690998533; x=1691603333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATBxTKtUEN3adqzZhNmXHivsXNy4yJoXN/eNj+na73o=;
        b=gC1HmOeksBgVpmy9lCWqeuiYpUX0ZAZT6MkINWUs5XnpdeuIXlxX5sJjegO5h+3G+H
         5BjTW2uYy+8I50Tv24IrTAyEmkT1TBcYQOuGBKiFOJHQ/cr/+4HYWxitoZWInb/cAfVm
         VmbdfDAHZhC1pt3Pd43oZ0kItdaeLjYVbUzshGYQLeI5mHtd1p1zANaByjpoCWqj00EA
         PVaC6qHPM5lAnyoYHFmIi6JjIQ6+zw67xJyN50T+IkH4cskvgCQV4vqvuijm1yCCHcbN
         furuZhTVyCsJsl662jecIkATe3OF8XmBw8JaKL8CYUvizA96t9q7S51ieUWmKjro/sjf
         If4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998533; x=1691603333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATBxTKtUEN3adqzZhNmXHivsXNy4yJoXN/eNj+na73o=;
        b=ImLCAI+t+tPEcc4DRZr5Gu58HmabjrXpAdD+rtKkiUy58kBfUFsgEIfH9V1OgrlzDu
         7hPV0J9JNAa6fD07Y9qdPFp6Trr0BucZRCZZPVAzt7Unf7hbyYFyiWAQMjx1fcR8f1Nm
         Mqo4oPyONzg6jOV9t2ca+j3YNGVbusn30zBY1aWwkjGo+WuyDRUoLsGipxCqIG567jXB
         cw5A73CX9vD1AVuGj43ltuW899XYMsYnyWnXHsNDEbangzaOZT4ATzfL5fweuCforK/F
         FBZ0vcpnf0RbqWWAMhY5ZJ2rg1MKu5CY7SNTWYI1flZRYy0ztLEan6s9614K5zszxtXT
         lmaQ==
X-Gm-Message-State: ABy/qLauni9WRU5S+drJWUw2wwUmwYbSgzGj9KXilJvqRF99eXzYYnYZ
        bXta/FBrlIetCrdMR3Vr77JfI3TfssXzrt16s44Akg==
X-Google-Smtp-Source: APBJJlGvTM2nVQ4xfnp9oMNReDoQoZIyuC+cErLAFZMXyF9StpmZSOtmw1AqSDqQZcI/uc8WONGAlHyQPysuJGkA9BQ=
X-Received: by 2002:a05:622a:1a28:b0:40f:db89:5246 with SMTP id
 f40-20020a05622a1a2800b0040fdb895246mr546108qtb.21.1690998533179; Wed, 02 Aug
 2023 10:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
 <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
 <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
 <1e0e6539-412a-cc8d-b104-e2921a099e48@huawei.com> <CANn89iKoTWHBGgMW-RyJHHeM0QuiN9De=eNWMM8VRom++n_o_g@mail.gmail.com>
 <3566e594-a9e5-8ba4-0f5a-d50086cebd82@huawei.com>
In-Reply-To: <3566e594-a9e5-8ba4-0f5a-d50086cebd82@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 2 Aug 2023 19:48:41 +0200
Message-ID: <CANn89iJ8jFxGo0d_8KnM2f=Xbh=iqb=+zcGn+U6PypuqNdWBUQ@mail.gmail.com>
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, socketcan@hartkopp.net,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp
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

On Wed, Jul 19, 2023 at 9:49=E2=80=AFAM Ziyang Xuan (William)
<william.xuanziyang@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/7/19 13:04, Eric Dumazet =E5=86=99=E9=81=93:
> > On Wed, Jul 19, 2023 at 6:41=E2=80=AFAM Ziyang Xuan (William)
> > <william.xuanziyang@huawei.com> wrote:
> >>
> >>> On Mon, Jul 17, 2023 at 9:27=E2=80=AFAM Marc Kleine-Budde <mkl@pengut=
ronix.de> wrote:
> >>>>
> >>>> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
> >>>>> Got kmemleak errors with the following ltp can_filter testcase:
> >>>>>
> >>>>> for ((i=3D1; i<=3D100; i++))
> >>>>> do
> >>>>>         ./can_filter &
> >>>>>         sleep 0.1
> >>>>> done
> >>>>>
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
> >>>>> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
> >>>>> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
> >>>>> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
> >>>>> [<00000000fd468496>] do_syscall_64+0x33/0x40
> >>>>> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >>>>>
> >>>>> It's a bug in the concurrent scenario of unregister_netdevice_many(=
)
> >>>>> and raw_release() as following:
> >>>>>
> >>>>>              cpu0                                        cpu1
> >>>>> unregister_netdevice_many(can_dev)
> >>>>>   unlist_netdevice(can_dev) // dev_get_by_index() return NULL after=
 this
> >>>>>   net_set_todo(can_dev)
> >>>>>                                               raw_release(can_socke=
t)
> >>>>>                                                 dev =3D dev_get_by_=
index(, ro->ifindex); // dev =3D=3D NULL
> >>>>>                                                 if (dev) { // recei=
vers in dev_rcv_lists not free because dev is NULL
> >>>>>                                                   raw_disable_allfi=
lters(, dev, );
> >>>>>                                                   dev_put(dev);
> >>>>>                                                 }
> >>>>>                                                 ...
> >>>>>                                                 ro->bound =3D 0;
> >>>>>                                                 ...
> >>>>>
> >>>>> call_netdevice_notifiers(NETDEV_UNREGISTER, )
> >>>>>   raw_notify(, NETDEV_UNREGISTER, )
> >>>>>     if (ro->bound) // invalid because ro->bound has been set 0
> >>>>>       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_list=
s will never be freed
> >>>>>
> >>>>> Add a net_device pointer member in struct raw_sock to record bound =
can_dev,
> >>>>> and use rtnl_lock to serialize raw_socket members between raw_bind(=
), raw_release(),
> >>>>> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to=
 free receivers in
> >>>>> dev_rcv_lists.
> >>>>>
> >>>>> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice =
notifier")
> >>>>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> >>>>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>>>
> >>>> Added to linux-can/testing.
> >>>>
> >>>
> >>> This patch causes three syzbot LOCKDEP reports so far.
> >>
> >> Hello Eric,
> >>
> >> Is there reproducer? I want to understand the specific root cause.
> >>
> >
> > No repro yet, but simply look at other functions in net/can/raw.c
> >
> > You must always take locks in the same order.
> >
> > raw_bind(), raw_setsockopt() use:
> >
> > rtnl_lock();
> > lock_sock(sk);
> >
> > Therefore, raw_release() must _also_ use the same order, or risk deadlo=
ck.
> >
> > Please build a LOCKDEP enabled kernel, and run your tests ?
>
> I know now. This needs raw_bind() and raw_setsockopt() concurrent with ra=
w_release().
> And there is not the scenario in my current testcase. I did not get it. I=
 will try to
> reproduce it and add the testcase.
>
> Thank you for your patient explanation.

Another syzbot report is firing because of your patch

Apparently we store in ro->dev a pointer to a netdev without holding a
refcount on it.
