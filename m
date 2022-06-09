Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD854469B
	for <lists+linux-can@lfdr.de>; Thu,  9 Jun 2022 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiFIIyd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242576AbiFIIyX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 04:54:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16CB1F5AEC
        for <linux-can@vger.kernel.org>; Thu,  9 Jun 2022 01:52:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g25so25350330ljm.2
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AX9+sxGX0p4pOxpI6WHP+Cxv1wFDNrQZS5LsuLWat6c=;
        b=pjVfJTL0Wwdpk9HiOlKjTQg7bkwGj+pY84mbxzvjsLhVYXR6U8Rg2nPDuZ5HMH6v3J
         3+P5k+4IJqQ+WQXgKtmb7vGsizWlSroLv6H3JP/F+mAC6VtRwB/gyffLMwfSXCWNSsX4
         FKwLGPngTJnGsuDDl13f/LaGeEAPaQgqUrLpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AX9+sxGX0p4pOxpI6WHP+Cxv1wFDNrQZS5LsuLWat6c=;
        b=fi30OHds1hxEQ4+RSoCcoC1XvgpoyZ8E8lhpNZL760JqxhSiQZmr6KPsNpIjUZjPa4
         XmEhIXL4UdNx8jGD/vuPGvPlLwszDNq7+nhkGbjwcIJEgZX/1+LmkLauNL7l7Q8Zyzxf
         iFaj/O1F1KPXO8b4zKIvWq0sNIGGVg0vosEiMKX4eJWhPclsM89voYQBAMgVcIiQ1i/u
         +cS7tappvCx697Mg+RX0RhuWaNNYayDaOT9vvLqyzhVGnhTpdHK5NBjd/aAYzTaGzO07
         IRPkcDuQ0am/8U1g/VNiB4mVoN54RqwWGJKODpGM9a9wBGYs923yRNhIShUSDKDzY1nX
         QpFg==
X-Gm-Message-State: AOAM532OFDpD9PHlbnVJOMZFXQTbMCYmrihiKtVTxVuNCvl8K5h0y4RI
        +2+WezNcfyF77YL8cj617kAOY637NrHOscM0Kkl6TQ==
X-Google-Smtp-Source: ABdhPJxUFTdxUuteJmRI/lqFmzsXvopo7OOc1rcCwtQ7+Yy56rWK/epG3i42NMpsVweOVL+4zdiNtWLt5EWvGdUHw6Y=
X-Received: by 2002:a2e:6e0c:0:b0:255:98fb:cb45 with SMTP id
 j12-20020a2e6e0c000000b0025598fbcb45mr11214233ljc.55.1654764734145; Thu, 09
 Jun 2022 01:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
 <20220607094752.1029295-12-dario.binacchi@amarulasolutions.com>
 <20220607105225.xw33w32en7fd4vmh@pengutronix.de> <CABGWkvozX51zeQt16bdh+edsjwqST5A11qtfxYjTvP030DnToQ@mail.gmail.com>
 <20220609063813.jf5u6iaghoae5dv3@pengutronix.de> <CABGWkvrViDyWfU=PUfKq2HXnDjhiZdOMWSBt3xcmxFKxhHKCyw@mail.gmail.com>
 <20220609080112.24bw2764ov767pqc@pengutronix.de>
In-Reply-To: <20220609080112.24bw2764ov767pqc@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Thu, 9 Jun 2022 10:52:03 +0200
Message-ID: <CABGWkvq2nbfYRww0KWB1YxLQ92hjsWjfV9+nT-cKzc5FPF=DzA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] can: slcan: add ethtool support to reset
 adapter errors
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Thu, Jun 9, 2022 at 10:01 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 09.06.2022 09:24:14, Dario Binacchi wrote:
> > > > > I'm a big fan of bringing the device into a well known good state during
> > > > > ifup. What would be the reasons/use cases to not reset the device?
> > > >
> > > > Because by default either slcand and slcan_attach don't reset the
> > > > error states, but you must use the `-f' option to do so. So, I
> > > > followed this use case.
> > >
> > > Is this a CAN bus error state, like Bus Off or some controller (i.e. non
> > > CAN related) error?
> >
> > The help option of slcan_attach and slcand prints " -f (read status
> > flags with 'F\\r' to reset error states)\n" I looked at the sources of
> > the adapter I am using (USBtin, which uses the mcp2515 controller).
> > The 'F' command reads the EFLG register (0x2d) without resetting the
> > RX0OVR and RX1OVR overrun bits.
>
> The Lawicel doc [1] says 'F' is to read the status flags not to clear
> it. However commit 7ef581fec029 ("slcan_attach: added '-f' commandline
> option to read status flags") [2] suggests that there are some adapters
> that the reading of the status flag clears the errors. IMHO the 'F'
> command should be send unconditionally during open.

When in doubt I would follow the slcand / slcan_attach approach, that don't
send the 'F \ r' command by default. We would be more backward compatible
as regards the sequence of commands to be sent to the controller.

>
> [1] http://www.can232.com/docs/can232_v3.pdf
> [2] https://github.com/linux-can/can-utils/commit/7ef581fec0298a228baa71372ea5667874fb4a56
>
> > The error states reset is done by 'f <subcmd>' command, that is not
> > managed by slcan_attach/slcand.
>
> Is the 'f' command is non-standard?

It's possible.

Thanks and regards,
Dario

>
> >         switch (subcmd) {
> >             case 0x0: // Disable status reporting
> >                 mcp2515_write_register(MCP2515_REG_CANINTE, 0x00);
> >                 return CR;
> >             case 0x1: // Enable status reporting
> >                 mcp2515_write_register(MCP2515_REG_CANINTE, 0x20); //
> > ERRIE interrupt to INT pin
> >                 return CR;
> >             case 0x2: // Clear overrun errors
> >                 mcp2515_write_register(MCP2515_REG_EFLG, 0x00);
> >                 return CR;
> >             case 0x3: // Reinit/reset MCP2515 to clear all errors
> >                 if (state == STATE_CONFIG) {
> >                     mcp2515_init();
> >                     return CR;
> >                 }
> >                 break;
> >         }
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
