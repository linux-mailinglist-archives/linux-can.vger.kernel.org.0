Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31B2F0F55
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAKJnq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 04:43:46 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:43916 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbhAKJnq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 04:43:46 -0500
Received: by mail-yb1-f174.google.com with SMTP id y128so16258838ybf.10
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 01:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc7+CniP2jSBdmWIlJ7Bg0QXtpBwIMPvpeP72DFOyWY=;
        b=PhqB2YXURsRYkLY9LIC9aCpkc5unVDddJlj5YV3G4PKWnGKIksWh9wUQs8oWgdS7t+
         0x2PfAC1a8gFvMBHpvzWXLzesk5WeRRUIhaAcLPEFkSzxSnQy9UaU2eGJ9S7vy0XvxZn
         XsrlBbfw3f0pSpKtvjW+VlscNFvIy81xiVfXTWSLx5kUXHkBtTVVOmIx5StaQ3SMngin
         YtnNlh7FHgU84hr8c/+wrMbyJwCerwPa56ymQlKBH/aafXeoyLGapA6jVcD6/U2pxUuY
         tMQijs792SA3hudRl0zN1S4PO2Zy6tpYJG1Cqe2jZBlqer1hMq3El7QI7skyENb7MhnG
         9aJw==
X-Gm-Message-State: AOAM530HCrgzU0g6SyBQWMpMhkz8/dv4efvvAs+bR/I/K/IzSdTF4Ty7
        tnX36UAeppGNqS2K04Vv0Et95fBmUhzy7QRxkkIb7R9aGWFTvQ==
X-Google-Smtp-Source: ABdhPJz/AZilIKYP4mP4cEjMH0oXhWtRDTblZ+fHkS68GiC8tRrJAHmdB7+Z81GenXvFvmrVpDoAjLa5FTu6yQgWc40=
X-Received: by 2002:a25:7c05:: with SMTP id x5mr23213870ybc.487.1610358185219;
 Mon, 11 Jan 2021 01:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <CAMZ6RqJ-4rmFDzmzBeHvjw1-_pen4=yhnvnoRvybEtY5fqEQoQ@mail.gmail.com>
 <a93cad08-6653-720e-fa1c-da43fec7462d@pengutronix.de>
In-Reply-To: <a93cad08-6653-720e-fa1c-da43fec7462d@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 11 Jan 2021 18:42:54 +0900
Message-ID: <CAMZ6Rq+-i94d23zOeED6vh=N_aLfeR-Ex7qn58ZX3P4mKxHL5g@mail.gmail.com>
Subject: Re: [net-next 00/13] can: dev: cleanup and add CAN frame length
 handling support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 at 17:26, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 1/10/21 9:55 AM, Vincent MAILHOL wrote:
> [...]
>
> > Did you test it after the occurence of a can_bus_off() event?
>
> Not yet...
>
> > When the device restarts, you normally have to call
> > netdev_reset_queue(netdev) in order to reset all the BQL
> > statistics.
>
> I only included the relevant parts to illustrate the use of the changed API.
> There is a netdev_reset_queue() in mcp251xfd_ring_init(), which is called via:
> mcp251xfd_chip_start(), mcp251xfd_set_mode()

Great then! I was just worried not to see it mentioned in the
patch.

As a global comment for the series: I am done with my comments,
looking forward to the v2!


Yours sincerely,
Vincent
