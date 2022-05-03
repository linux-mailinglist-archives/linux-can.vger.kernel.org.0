Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C52517EC3
	for <lists+linux-can@lfdr.de>; Tue,  3 May 2022 09:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiECHZ1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 May 2022 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiECHZ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 May 2022 03:25:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C7100B
        for <linux-can@vger.kernel.org>; Tue,  3 May 2022 00:21:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j6so31735218ejc.13
        for <linux-can@vger.kernel.org>; Tue, 03 May 2022 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=motec-com-au.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3A8Z9h48LHoWnbNOATmNx+a3MlcnNsYt2DmelJVVqo=;
        b=V7Kx2nSrdZ8JWnUtxCBgvmoNKpccnrSHr1ZOyqcFp2M4rn6TVgeF8KgMEh9zH3kOa/
         Gc7/SSBQ43sVdJwQhS6s7aupe2d0QZ+p58kBF7L3dcKeFJvOq7M+wkPTum6GturxTn8/
         0VIF9HvauWy3+PQSMjahdfBjzEXwpXSx1gojmki6odu88nBYc1prETkLaaCjsfJ36zRg
         dpm9ohWAB8OuD/E3eMguF0docXPBxeOoMVmVBG7/8utucxW1B3xE/j+tAG5T2eLDyfHU
         mLhw6L950pjMco5cB8Yv86tsOMYRJfx8wPL+91eu6GRMKCA1RwgvowsB/IbWbfop1nQl
         UB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3A8Z9h48LHoWnbNOATmNx+a3MlcnNsYt2DmelJVVqo=;
        b=4OZAPK/hdSnjFdDzZh2QBM9XVPKksXUREUzbFjF2eAEv95DIEk6UFhw3ugaFkg353+
         B0tszjhaXPdv+r3XnTo3R7vljYTd/ARjsSJdr/ZGzhyXuowOMukfqWsBwqe9164aSgAv
         +AuNIiG1AJ2PDocko6ysStTpQ0v9kVt0Rm2m7A6RjzRE8fWg7KEsUF7SU+swlxzZLBZa
         j5f65gqaMzQ6MWIETWg0bLunbtdWrsQgsYulyaibD1iT0fmR/zM5hh6mlyJr8Rn2o+Tt
         FZs/Jx8XmfdK9nDvOeuey2b+boAnoQDkDZkGYIW4e9D6vdesSxIJ1F/9gyEQErcFKuwz
         1qDw==
X-Gm-Message-State: AOAM531DMhQDTV12jbs1qwQjkCd3V+XOMO1MfOGnXAoSY2MIpW7iP05+
        ewbtQIvV7YvUzok4Zzg3ttdGn/PZionCeJYtXEfGAA==
X-Google-Smtp-Source: ABdhPJzJwFrwxew97oJI1ixgKOy32RNNNtdrIT+fCNH29G0FXa2NYPnSXqHJpXnwqV8904G8Qg9EWUHMNpR3I5ml2kg=
X-Received: by 2002:a17:907:3f25:b0:6b0:5e9a:83 with SMTP id
 hq37-20020a1709073f2500b006b05e9a0083mr14749489ejc.659.1651562512804; Tue, 03
 May 2022 00:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1650816929.git.pisa@cmp.felk.cvut.cz> <20220428072239.kfgtu2bfcud6tetc@pengutronix.de>
 <202204292331.28980.pisa@cmp.felk.cvut.cz> <20220502072151.j6nx5kddqxeyfy3h@pengutronix.de>
 <CAHQrW0_bxDyTf7pNHgXwcO=-0YRWtsxscOSWWU4fDmNYo8d-9Q@mail.gmail.com> <20220503064626.lcc7nl3rze5txive@pengutronix.de>
In-Reply-To: <20220503064626.lcc7nl3rze5txive@pengutronix.de>
From:   Andrew Dennison <andrew.dennison@motec.com.au>
Date:   Tue, 3 May 2022 17:21:16 +1000
Message-ID: <CAHQrW09Ajvm_xs2ThBp8xwR6sPj3Q74_kPtMC9oSE7JDmtaEpQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] can: ctucanfd: clenup acoording to the actual
 rules and documentation linking
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Carsten Emde <c.emde@osadl.org>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Matej Vasilevski <matej.vasilevski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

plain text this time...

On Tue, 3 May 2022 at 16:46, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 03.05.2022 16:32:32, Andrew Dennison wrote:
> > > > When value is configurable then for (uncommon) number
> > > > of buffers which is not power of two, there will be likely
> > > > a problem with way how buffers queue is implemented
> > >
> >
> > Only power of 2 makes sense to me: I didn't consider those corner
> > cases but the driver could just round down to the next power of 2 and
> > warn about a misconfiguration of the IP core.
>
> +1
>
> > I added the dynamic detection because the IP core default had changed
> > to 2 TX buffers and this broke some hard coded assumptions in the
> > driver in a rather obscure way that had me debugging for a bit...
>
> The mainline driver uses a hard coded default of 4 still... Can you
> provide that patch soonish?

I was using the out of tree driver but can have a look at this, unless
Pavel wants to merge this in his tree and submit?

>
> > > You can make use of more TX buffers, if you implement (fully
> > > hardware based) TX IRQ coalescing (== handle more than one TX
> > > complete interrupt at a time) like in the mcp251xfd driver, or BQL
> > > support (== send more than one TX CAN frame at a time). I've played
> > > a bit with BQL support on the mcp251xfd driver (which is attached by
> > > SPI), but with mixed results. Probably an issue with proper
> > > configuration.
> >
> > Reducing CAN IRQ load would be good.
>
> IRQ coalescing comes at the price of increased latency, but if you have
> a timeout in hardware you can configure the latencies precisely.
>
> > > > We need 2 * priv->ntxbufs range to distinguish empty and full
> > > > queue... But modulo is not nice either so I probably come with
> > > > some other solution in a longer term. In the long term, I want to
> > > > implement virtual queues to allow multiqueue to use dynamic Tx
> > > > priority of up to 8 the buffers...
> > >
> > > ACK, multiqueue TX support would be nice for things like the
> > > Earliest TX Time First scheduler (ETF). 1 TX queue for ETF, the
> > > other for bulk messages.
> >
> > Would be nice, I have multi-queue in the CAN layer I wrote for a
> > little RTOS (predates socketcan) and have used for a while.
>
> Out of interest:
> What are the use cases? How did you decide which queue to use?

I had a queue per fd, with queues sorted by id of the next message,
then sent the lowest ID next for hardware with a single queue. For
hardware with lots of buffers there was a hw buffer per queue. I
didn't have to deal with the generic cases that would need to be
handled in linux. I must say ctucanfd has a much nicer interface than
the other can hardware I've used.

Kind regards,

Andrew
