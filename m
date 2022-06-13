Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7334554A0D3
	for <lists+linux-can@lfdr.de>; Mon, 13 Jun 2022 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiFMVHR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jun 2022 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351789AbiFMVGz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jun 2022 17:06:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0907364C5
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 13:44:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id s6so10678367lfo.13
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fP2miIeDd3RvdPHp79IlihT8+88/+UX2uWQapkQGE0=;
        b=B06TDkgq/fXFEQ7rv7+RfcEt5E6ZJGzFJESw4K/NohQVvPR2uJpsrBfwtMFfjD0tUZ
         JGypfRxs5YLGCB3dVm5KEr+4kkEIM8IRFFhd/xJNlM1QB41atBcNDpJjrGaE0JD3Nnmk
         djTp2jho4GdmaqFpLHwg59iOp1+Oo3VNqwPu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fP2miIeDd3RvdPHp79IlihT8+88/+UX2uWQapkQGE0=;
        b=unTQyQNauFY+NQqxZwc29ozOMHc2vVOrspyalsOQythWcePG9ttjvT6ohF0mqREl8l
         81SvusAw6WsuqzCInm4frHljSLXULYr+jb1wXFIuQgYyCZiKmDaTRusqf964j37j7xZb
         PKSAHNSLT4DtdMnZQ1hGw4lUW5Uzy2Qi3GwZFyss7iTqHUYbr7jzuq9xRnpiV4yw1bEn
         yQVFJX8Ljz9Iga9JXtLL8WFc88ZS7bmbDbzbSE3eP6q0ocY9Wtri1PQVef0rn7SADdIz
         B6E8XjVVscZRMZOQaes0bPXFYrJZ3VgWxclsihrqA/K9Gv+m2Eu1rz4dvI5HHJauVeLV
         ecdQ==
X-Gm-Message-State: AJIora+igtTpXy6nzZ9ra03iJrok8AMjMyCpX/7HbvV0CHKGq0tV2PRM
        Cm5zOfN0gETtIn638+ZTZfVQHr3lCOKEtOP6ivbAZA==
X-Google-Smtp-Source: AGRyM1vYPgm33tg0O4fBbd0wNlqs1m0i7xGize2Bn9uDIbrcUMhquZjXmfsuCQne+QOEb6DcTwlV9eea4WD5Msh8xtw=
X-Received: by 2002:a19:431c:0:b0:479:2053:178e with SMTP id
 q28-20020a19431c000000b004792053178emr967165lfa.117.1655153063053; Mon, 13
 Jun 2022 13:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
 <20220612213927.3004444-6-dario.binacchi@amarulasolutions.com> <20220613071058.h6bmy6emswh76q5s@pengutronix.de>
In-Reply-To: <20220613071058.h6bmy6emswh76q5s@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Mon, 13 Jun 2022 22:44:12 +0200
Message-ID: <CABGWkvoNJYfK6bcjYtUi9qKvRfEfHUyrCWDBhOL4EjurW5YJ8Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] can: netlink: dump bitrate 0 if
 can_priv::bittiming.bitrate is -1U
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 13, 2022 at 9:11 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 12.06.2022 23:39:19, Dario Binacchi wrote:
> > Adding Netlink support to the slcan driver made it necessary to set the
> > bitrate to a fake value (-1U) to prevent open_candev() from failing. In
> > this case the command `ip --details -s -s link show' would print
> > 4294967295 as the bitrate value. The patch change this value in 0.
> >
> > Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/net/can/dev/netlink.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> > index 7633d98e3912..788a6752fcc7 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -505,11 +505,16 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
> >       struct can_ctrlmode cm = {.flags = priv->ctrlmode};
> >       struct can_berr_counter bec = { };
> >       enum can_state state = priv->state;
> > +     __u32 bitrate = priv->bittiming.bitrate;
> > +     int ret = 0;
> >
> >       if (priv->do_get_state)
> >               priv->do_get_state(dev, &state);
> >
> > -     if ((priv->bittiming.bitrate &&
>
> What about changing this line to:
>
>         if ((priv->bittiming.bitrate && priv->bittiming.bitrate != -1 &&

That you are right. The code becomes much cleaner.

>
> This would make the code a lot cleaner. Can you think of a nice macro
> name for the -1?
>
> 0 could be CAN_BITRATE_UNCONFIGURED or _UNSET. For -1 I cannot find a
> catchy name, something like CAN_BITRATE_CONFIGURED_UNKOWN or
> SET_UNKNOWN.
>

Personally I would use CAN_BITRATE_UNSET (0) and CAN_BITRATE_UNKNOWN (-1).
Let me know what your ultimate preference is.

Thanks and regards,
Dario

> The macros can be added to bittiming.h and be part of this patch. Ofq
> course the above code (and slcan.c) would make use of the macros instead
> of using 0 and -1.
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
