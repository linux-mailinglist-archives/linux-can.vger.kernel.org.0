Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836634888D6
	for <lists+linux-can@lfdr.de>; Sun,  9 Jan 2022 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiAILXM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 9 Jan 2022 06:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiAILXM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 Jan 2022 06:23:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E9C061748
        for <linux-can@vger.kernel.org>; Sun,  9 Jan 2022 03:23:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o12so34091990lfk.1
        for <linux-can@vger.kernel.org>; Sun, 09 Jan 2022 03:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VuyKoLpWpEEZox/0t1toTPqDMCC65viZRvg9Agp6Rc=;
        b=dJPaZcxnQDoggqCqDo8SgAfO7tb06gDGic1MlpIuAl1WKAb1IrZyFWhx4ySSrIWNyJ
         qWJ6FrK8U+m+QW4qoDRndMDgG8p564Lt49T0onB8wBboILu+sjsS7VqS1UIErAg4zhn/
         aUCXP6JgTQq/tdxHxNMCmbydvDrjg1E6eYGAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VuyKoLpWpEEZox/0t1toTPqDMCC65viZRvg9Agp6Rc=;
        b=ORbl/RU6/CAJFrLCqCulXRP+mbjtXi12Qa95BTT+d1MNfbrgRi05Uj5xrRuhrpclLr
         /kuPrEDPhjf8OWmXcCD3eKBOHtNlhqK0mAVKjBCGDJp/QU7WZ9Jzx/iy/RwA6Q4uAdRn
         R32xLpF91yp++rZJDEDSVcL6PJhYoG3nvOfHahVWkeN0Ki67HQtqKRQiAiQxhiVrN/CR
         VVa+nhGa6SrDG2+C23mDQ9acQeKCmzaxWNt7eFfsFcjQ0WV8S10HrKvOJCsIgX8T51Bg
         rTmfIRb2wSIg2dDR1CeaOgHHqMP2nBGLuW4NUeviABBg5UEwx6hmmrUud7RetlMMgXaz
         dyJg==
X-Gm-Message-State: AOAM530G8T2CfryB/2jXf6FjasniBp33Gla9oGkS4xHftOZSMet/FaK0
        3s0Ey6s6MSV+U9R2AYK+3q+4WHybn6ehB1Eb/zxNDg==
X-Google-Smtp-Source: ABdhPJz+5GwtyaN/5n8Jbaloti4ZQbWg5UCqS9v3FH2+ZEJYOcidZDDjriHT2NrEphgQkiv8v8+L/snICziKs2BJanM=
X-Received: by 2002:a05:651c:145:: with SMTP id c5mr57989978ljd.237.1641727385719;
 Sun, 09 Jan 2022 03:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20220108181633.420433-1-dario.binacchi@amarulasolutions.com> <20220108201650.7gp3zlduzphgcgkq@pengutronix.de>
In-Reply-To: <20220108201650.7gp3zlduzphgcgkq@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Sun, 9 Jan 2022 12:22:54 +0100
Message-ID: <CABGWkvoGs_VBGD-7dt18LY9NV=63w50OceKjmaKYeqDe_WJk9g@mail.gmail.com>
Subject: Re: [RFC PATCH] can: flexcan: add ethtool support to get rx/tx ring parameters
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Jan 8, 2022 at 9:16 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 08.01.2022 19:16:33, Dario Binacchi wrote:
> > Adds ethtool support to get the number of message buffers configured for
> > reception/transmission, which may also depends on runtime configurations
> > such as the 'rx-rtr' flag state.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> >  drivers/net/can/flexcan/flexcan-ethtool.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/net/can/flexcan/flexcan-ethtool.c b/drivers/net/can/flexcan/flexcan-ethtool.c
> > index 5bb45653e1ac..d119bca584f6 100644
> > --- a/drivers/net/can/flexcan/flexcan-ethtool.c
> > +++ b/drivers/net/can/flexcan/flexcan-ethtool.c
> > @@ -80,7 +80,24 @@ static int flexcan_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> >       return 0;
> >  }
> >
> > +static void flexcan_get_ringparam(struct net_device *ndev,
> > +                               struct ethtool_ringparam *ring)
>
> This doesn't compile on net-next/master, as the prototype of the
> get_ringparam callback changed, fixed this while applying.
>
> > +{
> > +     struct flexcan_priv *priv = netdev_priv(ndev);
> > +
> > +     ring->rx_max_pending = priv->mb_count;
> > +     ring->tx_max_pending = priv->mb_count;
> > +
> > +     if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
> > +             ring->rx_pending = __sw_hweight64(priv->rx_mask);
>
> I've replaced the hamming weight calculation by the simpler:
>
> |               ring->rx_pending = priv->offload.mb_last -
> |                       priv->offload.mb_first + 1;
>
> > +     else
> > +             ring->rx_pending = 6;
> > +
> > +     ring->tx_pending = __sw_hweight64(priv->tx_mask);
>
> ...and here I added a hardcoded "1", as the driver currently only
> support on TX buffer.
>
> > +}
> > +
> >  static const struct ethtool_ops flexcan_ethtool_ops = {
> > +     .get_ringparam = flexcan_get_ringparam,
> >       .get_sset_count = flexcan_get_sset_count,
> >       .get_strings = flexcan_get_strings,
> >       .get_priv_flags = flexcan_get_priv_flags,
>
> BTW: If you're looking for more TX performance, this can be done by
> using more than one TX buffer.

I didn't expect only one message buffer to be used for transmission

thanks and regards,
Dario

> It's also possible to configure the
> number of RX and TX buffers via ethtool during runtime. I'm currently
> preparing a patch set for the mcp251xfd to implement this.
>
> regards,
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
