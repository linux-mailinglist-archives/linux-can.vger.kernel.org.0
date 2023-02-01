Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11E6862F3
	for <lists+linux-can@lfdr.de>; Wed,  1 Feb 2023 10:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBAJib (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 1 Feb 2023 04:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjBAJia (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2023 04:38:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CEC41B61
        for <linux-can@vger.kernel.org>; Wed,  1 Feb 2023 01:38:28 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z3so12194441pfb.2
        for <linux-can@vger.kernel.org>; Wed, 01 Feb 2023 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cqf0fkzBNEuqah8+afkVosf0fgLNN1iUoH0i0WeOt5Q=;
        b=kUTxy7F2pZfk1cbrmHf/+d/oMsNS7hxqe6J7FV0c/8fUp7sqDJrApeSy4fUGzeR/NR
         5HWzAq5dh7kANA5iwBLGjCNxtbqrcbmqurkB9EGFNRuQAQMVMTYtb71rmbaXuSeP7tcF
         fVwjLXOdlkcqsiJX9niINlRcdElsodcs7cin+eu7eRiJucm+4QNqxzswT+0z9sJ63d2T
         OkpTM4z0iu8mDNVP4MTdK/rBDYrJZXosJ1KFEA+lt8Szj0Jf3yYnN6BRm9xW0rGyrgcl
         xK3LD9BHAKMKZQhnnlAGGmAmdcozxPbu6n6lztQjDohu3duvB8UPc95b9vHS0LuuLtLu
         HZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqf0fkzBNEuqah8+afkVosf0fgLNN1iUoH0i0WeOt5Q=;
        b=tQE4zrlBeS2lRAnVCGsV3paEY0NWVUso6cF9uVS8fRLuFASZRh3nl0GCCRNjjUA1MY
         /v9NsLqOQg1kqhTOPysi6NIvUgGJyKmt2WSwSzOHSSxhkZVwXHuMhitU07zw+2c/3uat
         x87+9eo/KvnnRxISIgcx+OsM8nNT7W69+LLyMvo/upaJlNzVxkv80vOvlNNEpvYc/iqe
         Xbb05FvO+usfFfkCsaQOuhv2q+mtTjd98f3zV5fqOmOnYg2EO/82ROvnRJIwpVNAKI5N
         4qhfsVhF2dwDyE++bQhG8PSMnxmKuAKs7vyvhpGOWupkH88F9oxcswFWKO1RTzxEtzMZ
         3Vdw==
X-Gm-Message-State: AO0yUKXnkQlkjLPn2FHd8yzoddDF2qugrD62ONJ6x834m9vDaYlhoEeY
        JRp+jdoPVe2YPUOae4825FJhjv6Di80+5OVZQ1IV1P+FahY=
X-Google-Smtp-Source: AK7set/0uzka2DxFFvoj/098zsja1OtsF0xCrhT7/Dgtyu8xagS4eD+fvOwqcGMPKi+PHoRaaCF923oeMWg9GEnrXn4=
X-Received: by 2002:a63:1b56:0:b0:497:3785:812e with SMTP id
 b22-20020a631b56000000b004973785812emr265751pgm.13.1675244308154; Wed, 01 Feb
 2023 01:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20220907103845.3929288-1-mkl@pengutronix.de> <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
 <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
 <20230131160436.2vfszb3qqsyx3ea7@pengutronix.de> <CAMZ6RqJDARUjhDF5k1DydZMr=YWU9QSXDshTwznV4oh79a7niQ@mail.gmail.com>
 <20230201085810.aoqjbqqojzy65xbz@pengutronix.de>
In-Reply-To: <20230201085810.aoqjbqqojzy65xbz@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 1 Feb 2023 18:38:17 +0900
Message-ID: <CAMZ6Rq+Jf6BUfrmZ3_biW-XigYO4-8BfPezjwhd68DfbhjCSnA@mail.gmail.com>
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

On Wed. 1 Feb 2023 at 17:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01.02.2023 14:49:23, Vincent Mailhol wrote:
> > > I've converted the existing netdev_err() NL_SET_ERR_MSG_FMT(). This
> > > means the error message is transported via netlink to user space and
> > > printed by the "ip" tool.
> >
> > I was not aware of this NL_SET_ERR_MSG_FMT() thing, and let me say
> > that I really like that solution!
> >
> > > | # ip link set flexcan0 txqueuelen 10 type can bitrate 2200000
> > > | Warning: bitrate error 2.5%.
> >
> > The Linux coding style says:
> >
> >   Kernel messages do not have to be terminated with a period.
> >
> > Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#printing-kernel-messages
> >
> > However, I am not sure if this also applies to the ip tool.
>
> I think the period is added by "ip".

Ack. All good then!

> > > |
> > > | # ip link set flexcan0 txqueuelen 10 type can bitrate 22000000
> > > | Error: bitrate error 80.5% too high.
> > >
> > > This is the error message for the SJW check:
> > >
> > > | # ip link set flexcan0 txqueuelen 10 type can bitrate 500000 sjw 3
> > > | Error: SJW 3 bigger than phase_seg1 6 and/or phase_seg2 2.
> >
> > At that point in the code, I assume that sjw was already validated
> > against sjw_max. While not impossible, I think that having sjw bigger
> > than both phase_seg1 and phase_seg2 at the same time is uncommon. I
> > suggest to split the error message in two and only print the relevant
> > one:
> >
> >   Error: SJW 3 bigger than phase_seg1 x
> >   Error: SJW 3 bigger than phase_seg2 x
> >
> > If the user still manages to violate both, only the phase_seg1 error
> > message is displayed.
>
> Makes sense.
>
> > > Maybe add a '=' between the phase_seg and the actual number:
> > >
> > > | Error: SJW 3 bigger than phase_seg1=6 and/or phase_seg2=2.
> >
> > If you ask me my preferences, I will go with column:
> >
> >   Error: SJW: 3 bigger than phase_seg1: 6 and/or phase_seg2: 2.
> >
> > But I will not complain if you pick anything else.
>
> Period looks good.
>
> What about the error value? Always return -EINVAL instead of a mix of
> -EINVAL and -ERANGE?

Looking at the comments from uapi/asm-generic/errno-base.h:

  #define EINVAL 22 /* Invalid argument */
  #define ERANGE 34 /* Math result not representable */

We are not dealing with some non-representable math results, so
-ERANGE is technically incorrect. I did suggest -ERANGE in the past
because it looks natural to me: we define a min and a max, i.e. its a
range. But the doc tells me I am wrong. Naming the error -ENAN (Error
Not A Number) would have been more explicit, but we are not going to
rewrite UAPI error definitions.

Go with -EINVAL This answer also applies to your next message and to
everywhere else in netlink, I guess.


Yours sincerely,
Vincent Mailhol
