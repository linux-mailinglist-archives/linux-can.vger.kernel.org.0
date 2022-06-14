Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626F54A977
	for <lists+linux-can@lfdr.de>; Tue, 14 Jun 2022 08:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiFNGaO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Jun 2022 02:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiFNGaM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2022 02:30:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B3F1A056
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 23:30:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id g2so8593008ljk.5
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/NRQuFI8tEQXP2R7fZneo4JlnHTbiMdQlJzFDy5/J8=;
        b=lrFPz/wx6XrLQGNEu8CKre9K0jQFp+dy8jJWh3TUwhh2UVTs3Vp7U+HSRra96066F5
         7sp86ZpCsDXLu3zdEVYRFErGjFwESqminOPfQAd7rgdXOEDkwQv+E+gY7/cJQzrvb2/G
         YMiDBQUrTt6RzIyR5nGUQqa2mxdTBz85+Zgvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/NRQuFI8tEQXP2R7fZneo4JlnHTbiMdQlJzFDy5/J8=;
        b=72XJK5HGFMAlLbqwRPxYbuUnO2vJWqiru3b49iLtYXw8/PGp7k9kqAhrHY/XUp/PBa
         kahCA3A7riS7SGJS74i9gVrO/YzusuD3+FUR4+R6eqCzXhqzreKht3LSCX0bQdBP1bnq
         3fqOBwb3MsfWqfPweegEbfJ2hhBM5Spjq8RNfD7UEad7dLGdfwikWqELGh3I22QLNREH
         d5PoNCIVH2tcZb0MIr/nc0seWXK9EDMxjceP6the2tUB1IYKZyLLsxeYMd2gIWBK3dZD
         Y0Tewq71LIJQOLS76ZHeBLa8SyyHtBv2WF15HPMtOmMQNWkh5iitLMseJgsZ7TyfXGKE
         06yg==
X-Gm-Message-State: AJIora/em+gtN5UhLbNm7PgPK78QTirNT9zB6a6yEsu4s1MnnpojMuIB
        qWZArJdYlYiZat/gZkAQBrRiRqi55rxT3Ju+xbNw+g==
X-Google-Smtp-Source: AGRyM1vki/GDT4R9HSfcOufQmMmcVvrY9hZXpMmPyqajie+XQicj+VJMw0EtntKoXRxEIjIFi4beAZancDZ6mpEZ3BI=
X-Received: by 2002:a2e:9609:0:b0:255:8364:9fd8 with SMTP id
 v9-20020a2e9609000000b0025583649fd8mr1611482ljh.132.1655188208918; Mon, 13
 Jun 2022 23:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
 <20220612213927.3004444-14-dario.binacchi@amarulasolutions.com> <20220613073706.rk3bve57zi2p3nnz@pengutronix.de>
In-Reply-To: <20220613073706.rk3bve57zi2p3nnz@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Tue, 14 Jun 2022 08:29:57 +0200
Message-ID: <CABGWkvqb3VHEMUaRsxcdL0+85hOSwJAtYWq+JskQ3KG+Hnca5g@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] can: slcan: extend the protocol with CAN state info
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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

On Mon, Jun 13, 2022 at 9:37 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 12.06.2022 23:39:27, Dario Binacchi wrote:
> > It extends the protocol to receive the adapter CAN state changes
> > (warning, busoff, etc.) and forward them to the netdev upper levels.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > Changes in v3:
> > - Drop the patch "can: slcan: simplify the device de-allocation".
> > - Add the patch "can: netlink: dump bitrate 0 if can_priv::bittiming.bitrate is -1U".
> >
> > Changes in v2:
> > - Continue error handling even if no skb can be allocated.
> >
> >  drivers/net/can/slcan/slcan-core.c | 66 ++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> > index 48077edb9497..5ba1c141f942 100644
> > --- a/drivers/net/can/slcan/slcan-core.c
> > +++ b/drivers/net/can/slcan/slcan-core.c
> > @@ -78,6 +78,9 @@ MODULE_PARM_DESC(maxdev, "Maximum number of slcan interfaces");
> >  #define SLC_CMD_LEN 1
> >  #define SLC_SFF_ID_LEN 3
> >  #define SLC_EFF_ID_LEN 8
> > +#define SLC_STATE_LEN 1
> > +#define SLC_STATE_BE_RXCNT_LEN 3
> > +#define SLC_STATE_BE_TXCNT_LEN 3
> >
> >  struct slcan {
> >       struct can_priv         can;
> > @@ -175,6 +178,67 @@ int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on)
> >    *                  STANDARD SLCAN DECAPSULATION                     *
> >    ************************************************************************/
> >
> > +static void slc_bump_state(struct slcan *sl)
> > +{
> > +     struct net_device *dev = sl->dev;
> > +     struct sk_buff *skb;
> > +     struct can_frame *cf;
> > +     char *cmd = sl->rbuff;
> > +     u32 rxerr, txerr;
> > +     enum can_state state, rx_state, tx_state;
> > +
> > +     if (*cmd != 's')
> > +             return;
>
> Checked by the caller?
>
> > +
> > +     cmd += SLC_CMD_LEN;
> > +     switch (*cmd) {
> > +     case 'a':
> > +             state = CAN_STATE_ERROR_ACTIVE;
> > +             break;
> > +     case 'w':
> > +             state = CAN_STATE_ERROR_WARNING;
> > +             break;
> > +     case 'p':
> > +             state = CAN_STATE_ERROR_PASSIVE;
> > +             break;
> > +     case 'f':
> > +             state = CAN_STATE_BUS_OFF;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     if (state == sl->can.state)
> > +             return;
> > +
> > +     cmd += SLC_STATE_BE_RXCNT_LEN + 1;
>
> Have you checked that you have received that much data?
>
> > +     cmd[SLC_STATE_BE_TXCNT_LEN] = 0;
> > +     if (kstrtou32(cmd, 10, &txerr))
> > +             return;
> > +
> > +     *cmd = 0;
> > +     cmd -= SLC_STATE_BE_RXCNT_LEN;
> > +     if (kstrtou32(cmd, 10, &rxerr))
> > +             return;
>
> Why do you parse TX first and then RX?

Since adding the end-of-string character to the counter to be decoded
invalidates the next one.
If I had started from the rx counter, I would have found the
transmission counter always at 0.

Thanks and regards,
Dario

>
> > +
> > +     skb = alloc_can_err_skb(dev, &cf);
> > +
> > +     if (skb) {
> > +             cf->data[6] = txerr;
> > +             cf->data[7] = rxerr;
> > +     }
> > +
> > +     tx_state = txerr >= rxerr ? state : 0;
> > +     rx_state = txerr <= rxerr ? state : 0;
> > +     can_change_state(dev, skb ? cf : NULL, tx_state, rx_state);
>
> alloc_can_err_skb() set cf to NULL if no skb can be allocated.
>
> > +
> > +     if (state == CAN_STATE_BUS_OFF)
> > +             can_bus_off(dev);
> > +
> > +     if (skb)
> > +             netif_rx(skb);
> > +}
> > +
> >  static void slc_bump_err(struct slcan *sl)
> >  {
> >       struct net_device *dev = sl->dev;
> > @@ -378,6 +442,8 @@ static void slc_bump(struct slcan *sl)
> >               return slc_bump_frame(sl);
> >       case 'e':
> >               return slc_bump_err(sl);
> > +     case 's':
> > +             return slc_bump_state(sl);
> >       default:
> >               return;
> >       }
> > --
> > 2.32.0
> >
> >
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
