Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78BF57C609
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiGUIRi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 04:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiGUIR3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 04:17:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB57E009
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 01:17:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z22so1586306lfu.7
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXTgtlqLJ4/ccGg/ZVcRqRwbk2jzjIpBAEnjuKYHOG8=;
        b=ECKSOnUYc5HaMnhSUPrnMRaZKeYAD7ValXquz6QlXsQRvt6pM3dc1Zh6iuvqMQqs1p
         vkficU6A26aKu3AISdyt/5LgUlepuAeYYShiP7XLRoKI4zCLuJHsAlBPu3unpyQeF/nL
         tHMzK4wJUtu4FbnPes5doM3OThzn7D/fceMjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXTgtlqLJ4/ccGg/ZVcRqRwbk2jzjIpBAEnjuKYHOG8=;
        b=MXFLXqqq3SNMZZRnVC3CeYSzMBy6Ql9STie/SmBMWesYYnWNOwTjkCxKLLH8rLGtdw
         DPxFv4wZJQAXtzZDaNjwAIsxF+yDkNwhxvFQ9Tfyqj4H8zRKjk6Ab9WtvqzuYL6cDTQo
         Hx3MT2W/iFNNBzzj7JmugQ6UT4keG/4QHwmFWRRGwlkeMw+z/RgGzUzYv4vJdFmSN5/5
         NUi8C0ioDHVrLp5K5TmfLQvNOdBorBPHSsXz8bG2Uy/aU/up4qQfBmmA/jwHqEyHKCgY
         uzIgBkO5VeXnT9bfZiTqlGmSc8n7Kq4PGpSz8Ox4aQ/kI7spWuN7SR9NXh/iQ484MP6Q
         QrZg==
X-Gm-Message-State: AJIora/bhlEvEUyvP9sBT1s3iVS1JOVNJ1I4axAnd3NdFBYJYZiglPeU
        ZFfQg9UhCWfIy/TSt0P6OnAbmCdfMQdEFlhWN2NBMamAPgJYsg==
X-Google-Smtp-Source: AGRyM1syTT0nDSlzBPl3yxxmAFp/qrDcpgxuTHgeAQieT1mLOMdlSf1rR2uu6j+2gJMs2n8OiBAmZwYrMBl4iqln7Ks=
X-Received: by 2002:a05:6512:32c1:b0:489:e9de:2f0 with SMTP id
 f1-20020a05651232c100b00489e9de02f0mr23244981lfg.117.1658391446244; Thu, 21
 Jul 2022 01:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
 <20220716170007.2020037-6-dario.binacchi@amarulasolutions.com> <20220718102203.66y6glwwphptl2tu@pengutronix.de>
In-Reply-To: <20220718102203.66y6glwwphptl2tu@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Thu, 21 Jul 2022 10:17:15 +0200
Message-ID: <CABGWkvqxKBVa_pGhg-aThn76wz-rpiVAqgFNDT-HNd1_Bz7WXw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] can: slcan: send the listen-only command to the adapter
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On Mon, Jul 18, 2022 at 12:22 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> The subject can be enhanced, as the listen-only command ist not send
> unconditionally. What about: "add support for listen-only mode"?

I like it.

>
> On 16.07.2022 19:00:07, Dario Binacchi wrote:
> > In case the bitrate has been set via ip tool, this patch changes the
> > driver to send the listen-only ("L\r") command to the adapter.
>
> ...but only of CAN_CTRLMODE_LISTENONLY is requested.
>
> What about:
>
> For non-legacy, i.e. ip based configuration, add support for listen-only
> mode. If listen-only is requested send a listen-only ("L\r") command
> instead of an open ("O\r") command to the adapter..

I agree with you. It's definitely clearer.

Thanks and regards,
Dario
>
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> >  drivers/net/can/slcan/slcan-core.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> > index 7a1540507ecd..d97dfeccbf9c 100644
> > --- a/drivers/net/can/slcan/slcan-core.c
> > +++ b/drivers/net/can/slcan/slcan-core.c
> > @@ -711,10 +711,21 @@ static int slcan_netdev_open(struct net_device *dev)
> >                       }
> >               }
> >
> > -             err = slcan_transmit_cmd(sl, "O\r");
> > -             if (err) {
> > -                     netdev_err(dev, "failed to send open command 'O\\r'\n");
> > -                     goto cmd_transmit_failed;
> > +             /* listen-only command overrides open command */
>
> I think this comment can be removed.
>
> > +             if (sl->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> > +                     err = slcan_transmit_cmd(sl, "L\r");
> > +                     if (err) {
> > +                             netdev_err(dev,
> > +                                        "failed to send listen-only command 'L\\r'\n");
> > +                             goto cmd_transmit_failed;
> > +                     }
> > +             } else {
> > +                     err = slcan_transmit_cmd(sl, "O\r");
> > +                     if (err) {
> > +                             netdev_err(dev,
> > +                                        "failed to send open command 'O\\r'\n");
> > +                             goto cmd_transmit_failed;
> > +                     }
> >               }
> >       }
> >
> > @@ -801,6 +812,7 @@ static int slcan_open(struct tty_struct *tty)
> >       /* Configure CAN metadata */
> >       sl->can.bitrate_const = slcan_bitrate_const;
> >       sl->can.bitrate_const_cnt = ARRAY_SIZE(slcan_bitrate_const);
> > +     sl->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
> >
> >       /* Configure netdev interface */
> >       sl->dev = dev;
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
