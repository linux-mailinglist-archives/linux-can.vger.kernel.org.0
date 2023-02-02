Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03BC687A37
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 11:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBBK33 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjBBK3Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 05:29:24 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAE41B4E
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 02:29:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f3so999103pgc.2
        for <linux-can@vger.kernel.org>; Thu, 02 Feb 2023 02:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6jn3SLElpXObmbo74fWi1Pov+fcCiixJ+srdzlEzpO4=;
        b=EcLep38S7P77g9f6dm5mzCf81PMwABo35vOaNg1QKExxEyTdvbyIJzyrWD/F1oFjhB
         7HxkAq31pIpUA6n5EPdTl6Mm60ZSOTMbrP5xhE9WpAxl3/gLb2fD6VG6bFbKNLTEMaFH
         +HLe2ErAaa29XoGWX4sEWn6Yw7Q7amUFYViXfaGP3bnGxOxbFHBxuwAEDq1WsK8BOshj
         BAOGR+HLmmMjsbYEBrkfpe7fOXxltLgBzz5EXx1FGOgNlc8G7LVX/t2xe/NNnrg/nf0d
         NKsnzJ4K3Wd1hqbVnd/gu67lE5YSK+jJHItsGyZikXDUoDQXg1v+fn8F3OiMizAuMqe3
         LO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jn3SLElpXObmbo74fWi1Pov+fcCiixJ+srdzlEzpO4=;
        b=yXWYYHn6uM1jlQf3U/QXdp4P+DFkp0J8bCtrzvmLkacmDu6bDNhLGv1I4XABaJwBvo
         ArZ2hIySOHC1vVO9wK0LXqa9o9Rh1JtQsis/pxPna0b7jvZ+8nB6v6n7r3ur9cR5THwA
         ayqttGvkd0WIaO1Ef8t177PEi/yHc59U/lHStfy6ACGELXxgq2sY/Y0baeZpikaHTv7K
         GlmNW5Qpq59v8R4bCRKjniph97SnGZNqk9P+K0nG4T9lOIRgaJZRqYTMGbiaKFYzGrH5
         IKt0MH7uxS/Om36aL+6Ey9BmUqk+2mfL8bpcQcVPof8zy2fRVMImkxyyWwJAv8lvzh29
         gQDw==
X-Gm-Message-State: AO0yUKWPY6NMhuNUCmBsAbxJh7mxo337ukQiqBZe1LIxzzBJuhbJiuqf
        rZTVUSYZYYQ67Mm/OF8mvlTP7eflXIX2iphe8Vg=
X-Google-Smtp-Source: AK7set/VBrdjsOyTFo1O8yE5jhrxs7GPG4/+n7nBiTIo17v9RcJxWFLO0jGLC8Pavh+p088NyGhKK1OAJgI10r5VjNw=
X-Received: by 2002:a05:6a00:4403:b0:593:e0ce:f9bf with SMTP id
 br3-20020a056a00440300b00593e0cef9bfmr1361397pfb.14.1675333763286; Thu, 02
 Feb 2023 02:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20220907103845.3929288-1-mkl@pengutronix.de> <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
 <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
 <20230131160436.2vfszb3qqsyx3ea7@pengutronix.de> <CAMZ6RqJDARUjhDF5k1DydZMr=YWU9QSXDshTwznV4oh79a7niQ@mail.gmail.com>
 <20230201085810.aoqjbqqojzy65xbz@pengutronix.de> <CAMZ6Rq+Jf6BUfrmZ3_biW-XigYO4-8BfPezjwhd68DfbhjCSnA@mail.gmail.com>
 <20230202095548.xkcnhfvdi2gn4s5i@pengutronix.de>
In-Reply-To: <20230202095548.xkcnhfvdi2gn4s5i@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 2 Feb 2023 19:29:12 +0900
Message-ID: <CAMZ6RqLoY+p4Zd8cDaLUiMqOmfQAgViwbz93Pcv6uH+qm_4FFw@mail.gmail.com>
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of min3()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        mark@baggywrinkle.co.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 2 Feb 2023 at 18:55, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01.02.2023 18:38:17, Vincent Mailhol wrote:
> [...]
> > > > > Maybe add a '=' between the phase_seg and the actual number:
> > > > >
> > > > > | Error: SJW 3 bigger than phase_seg1=6 and/or phase_seg2=2.
> > > >
> > > > If you ask me my preferences, I will go with column:
> > > >
> > > >   Error: SJW: 3 bigger than phase_seg1: 6 and/or phase_seg2: 2.
> > > >
> > > > But I will not complain if you pick anything else.
> > >
> > > Period looks good.
>
> Now looks like this:
>
> | sudo ip link set flexcan0 txqueuelen 10 type can bitrate 22000000
> | Error: bitrate error: 80.5% too high.
> |
> | sudo ip link set flexcan0 txqueuelen 10 type can bitrate 2200000
> | Warning: bitrate error: 2.5%.
> |
> | sudo ip link set flexcan0 txqueuelen 10 type can bitrate 1000000 sjw 10
> | Error: sjw: 10 greater than max sjw: 4.
> |
> | sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 3 phase-seg1 1 phase-seg2 8 tq 10
> | Error: resulting brp: 0 less than brp-min: 1.
> |
> | sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 3 phase-seg1 4 phase-seg2 4 tq 30 sjw 5
> | Error: sjw: 5 greater than max sjw: 4.
> |
> | sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 4 phase-seg1 3 phase-seg2 4 tq 30 sjw 4
> | Error: sjw: 4 greater than phase-seg1: 3.
> |
> | sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 4 phase-seg1 4 phase-seg2 3 tq 30 sjw 4
> | Error: sjw: 4 greater than phase-seg2: 3.

I like it. I am looking forward to seeing the patches.

> > > What about the error value? Always return -EINVAL instead of a mix of
> > > -EINVAL and -ERANGE?
> >
> > Looking at the comments from uapi/asm-generic/errno-base.h:
> >
> >   #define EINVAL 22 /* Invalid argument */
> >   #define ERANGE 34 /* Math result not representable */
> >
> > We are not dealing with some non-representable math results, so
> > -ERANGE is technically incorrect. I did suggest -ERANGE in the past
> > because it looks natural to me: we define a min and a max, i.e. its a
> > range. But the doc tells me I am wrong. Naming the error -ENAN (Error
> > Not A Number) would have been more explicit, but we are not going to
> > rewrite UAPI error definitions.
> >
> > Go with -EINVAL This answer also applies to your next message and to
> > everywhere else in netlink, I guess.
>
> It's -EINVAL everywhere now.

\o/
