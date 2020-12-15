Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32982DAC29
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgLOLiH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 06:38:07 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40926 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgLOLiG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 06:38:06 -0500
Received: by mail-yb1-f195.google.com with SMTP id t13so18529951ybq.7
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 03:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzjA2IqmUbucrLDR+Ei4Xmnm0GH2Qy5lrzaYtVDu3RE=;
        b=ALk/PEy6uGRmvaG4E7cd36GO5mlLdcpjdS29SHJG9IelHP1/izY2K5cROuJWwwIOoB
         wCcyk5OmGuxlC3XhYOypTTyICyLFM3KtWYapeExNohCIbV7LedAPbZr1PDd7hIsyneOG
         h/1FKzVDoMpqWS+p6JUBcIeTkEW2+xbhIsV7giRtydUb++HOdgnNF6hVc3spJ1o7/8yo
         Ihr8zJsdvFQu2tEdmtRwkdXuoM6EU+SNOX47MZu0IVjSql1bvjCiCW4meqz91uY+ov1V
         t2uLBZ6M6vpX6dnxK6I/wP2CunUUuO4vRN1SfIxvpBPsJZKhspr64HgH9noX4/SYrkJh
         ZfRw==
X-Gm-Message-State: AOAM530AZfhnlBOMrU0sfFD9qGgyaomTa6OdX0qXGb/T1QIinlrltmn+
        F6UTTEBIGJjfvO/fV+t/BFutGC/LFWe/lSi2e+s=
X-Google-Smtp-Source: ABdhPJzcgGHdoQQ0yIQ2/m4hitzef/9yuV9P/JqQnAFdLn2GuEFxb58zm9tHnt0DxBUuYSmabfgSbmIBJhAE1uqhdKk=
X-Received: by 2002:a25:287:: with SMTP id 129mr32013720ybc.145.1608032245131;
 Tue, 15 Dec 2020 03:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20201214091426.417867-1-mkl@pengutronix.de> <fe7ac11a-410b-ee50-8494-da13055b544e@pengutronix.de>
In-Reply-To: <fe7ac11a-410b-ee50-8494-da13055b544e@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 15 Dec 2020 20:37:14 +0900
Message-ID: <CAMZ6RqKPOmZ9jx83g+dt2p+ZrHquuTWHPZM=BuZqyXiEmC8J5w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce
 function to get data length of frame in data link layer
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue 15 Dec. 2020 at 17:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 12/14/20 10:14 AM, Marc Kleine-Budde wrote:
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > This patch adds the function can_skb_get_dll_len() which returns the length of
> > a CAN frame on the data link layer, including Start-of-frame, Identifier,
> > various other bits, the CRC, the End-of-frame, the Inter frame spacing and the
> > actual data.
> >
> > Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Not-Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Not-Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Hello,
> >
> > while reviewing the etas_es58X driver and hacking on BQL support for the
> > mcp251xfd driver, it turned out the a function to calculate the length of the
> > CAN frame that's send over the wire should go into the generic CAN dev code.
> >
> > Looking at the CAN and OSI layering I think the first layer where we have all
> > the bits that we see on the wire is the data link layer (DLL).
> >
> > https://www.can-cia.org/can-knowledge/can/can-data-link-layers
> >
> > This is why I named the function can_skb_get_dll_len().
> >
> > I'm planing to add a (better) calculation of the CAN-FD dll_len, depending on
> > the data and including different CRC lengths.
> >
> > As this code is copied from the etas_es58X driver, I've added the authors as
> > Co-developed-by and I'd like to add their S-o-b to this patch.
> >
> > Please review and commnt on the naming on the functions.
>
> When implementing BQL we need the CAN frame's DLL len twice:
> 1. When sending the package to the hardware
> 2. After the TX-complete IRQ
>
> We can calculate this information twice, but I thought we might put it into the
> struct can_skb_priv.
>
> https://elixir.bootlin.com/linux/latest/source/include/linux/can/skb.h#L34
>
> Thoughts?

I am not knowledgeable enough on this part to guarantee if there will
be no side effects but regardless, I like the idea.

Also, an u8 is enough to hold the value. I wonder if it would be fine
to change ifindex to, for example, u16, so that we do not lose any
memory.

I would look like that:

struct can_skb_priv {
    u16 ifindex;
    u8 frame_len;
    u8 res;
    int skbcnt;
    struct can_frame cf[];
};

And the final result in the driver would look as below:

/* Tx branch */
can_skb_prv(skb)->frame_len = can_skb_get_frame_len(skb);
netdev_sent_queue(can_skb_prv(skb)->frame_len);

/* Rx branch */
netdev_completed_queue(can_skb_prv(skb)->frame_len);

This is quite neat.
