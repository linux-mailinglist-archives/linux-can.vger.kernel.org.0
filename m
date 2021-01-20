Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC12FC5EC
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 01:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbhATAe5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 19:34:57 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:46586 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbhATAey (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 19:34:54 -0500
Received: by mail-yb1-f170.google.com with SMTP id f6so17783834ybq.13
        for <linux-can@vger.kernel.org>; Tue, 19 Jan 2021 16:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukuPAqJUZSQNEW5/Uq8rdsYafYwdbKyJztl25Zwtmtc=;
        b=RbTXhU3iQTvgVHGfmqCfLwwXqceDcBa0KufKtnUENe+enpOiQU327xJnMqFIGUPkka
         FlgY/FQP/yt/9ZfC8NAb+a6wfb7v51VqyO5qaRTWeVn6H1WbbR8U0SVSpQaSgQxnyFxy
         k8O1DisbA72YMOSbs+M+8PZxMdN2W5tN8ytOXIbsdnN09Hhyg1HDpnBhuQ4a4H6qWmZg
         ogjGYpmHatQ32qQAqdlpA8/+O9WsTCQUpCtZ+tNCB2H65wjctQRNaeOxOEd+KxBx6Tif
         9WsEwsqE+mY0tUkLi8ynCK4sBh6KVMnoF7epH4bQqnFxUjSUi7V0ojSPD0XcESWvFHWh
         Ta8w==
X-Gm-Message-State: AOAM530D/6qRNMPqtXfZmZE4Fh3VWbq42v/qXJoo87SeqNWUnayD/wuM
        Q1kDiNI1zs7g6kUyZt4kY9coGv2pAHy5gJuGg/0=
X-Google-Smtp-Source: ABdhPJwNM+rC7AKfAFQRKkHUgTRvfvfoFlx+FwD31eUKHNB+3F0zi19iGzi1sTdJCxmcwmv7JSUbpyLK2sDRaXfZ8iQ=
X-Received: by 2002:a25:d84:: with SMTP id 126mr9363005ybn.145.1611102852769;
 Tue, 19 Jan 2021 16:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
 <20210119162512.5236-3-mailhol.vincent@wanadoo.fr> <CAMZ6RqJb=y9E3tmT+kPwAB1cYyDE2v4e5iMaoB_J17U-W+WB3w@mail.gmail.com>
 <360fe995-6f8a-81e6-bd0e-fd5d1cca5a92@hartkopp.net>
In-Reply-To: <360fe995-6f8a-81e6-bd0e-fd5d1cca5a92@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 20 Jan 2021 09:34:01 +0900
Message-ID: <CAMZ6RqLLBWsNJZbuUTq9xZDsoD_KGW=Sg92eSi=m3ny0isbfVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] can: vxcan: vxcan_xmit: fix use after free bug
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 20 janv. 2021 at 07:16, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 19.01.21 18:07, Vincent MAILHOL wrote:
> > On Wed. 20 Jan 2021 at 01:25, Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> >>
> >> After calling netif_rx_ni(skb), dereferencing skb is unsafe.
> >> Especially, the canfd_frame cfd which aliases skb memory is accessed
> >> after the netif_rx_ni().
> >>
> >> fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
> >> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >> ---
> >>   drivers/net/can/vxcan.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> >> index fa47bab510bb..a525ef8d19b0 100644
> >> --- a/drivers/net/can/vxcan.c
> >> +++ b/drivers/net/can/vxcan.c
> >> @@ -39,6 +39,7 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
> >>          struct net_device *peer;
> >>          struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >>          struct net_device_stats *peerstats, *srcstats = &dev->stats;
> >> +       u8 len;
> >>
> >>          if (can_dropped_invalid_skb(dev, skb))
> >>                  return NETDEV_TX_OK;
> >> @@ -61,12 +62,13 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
> >>          skb->dev        = peer;
> >>          skb->ip_summed  = CHECKSUM_UNNECESSARY;
> >>
> >> +       u8 len = cfd->len;
> >
> > len = cfd->len;
> > Silly mistake: u8 not needed twice of course...
>
> not tested -> compile tested -> runtime tested
>
> Choose your level!
>
> :-D

I did all the tests on the first patch (can_restart). For the
other two patches, I greped for similar patterns and just test
compile, but I forgot to select the vxcan module thus could not
see the warning.

I take the blame :-)

> >
> >>          if (netif_rx_ni(skb) == NET_RX_SUCCESS) {
> >>                  srcstats->tx_packets++;
> >> -               srcstats->tx_bytes += cfd->len;
> >> +               srcstats->tx_bytes += len;
> >>                  peerstats = &peer->stats;
> >>                  peerstats->rx_packets++;
> >> -               peerstats->rx_bytes += cfd->len;
> >> +               peerstats->rx_bytes += len;
> >>          }
> >>
> >>   out_unlock:
> >> --
> >> 2.26.2
> >>
