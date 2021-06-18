Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5863AC835
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 11:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhFRKAv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 06:00:51 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:34505 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhFRKAt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 06:00:49 -0400
Received: by mail-lj1-f177.google.com with SMTP id a21so8263285ljj.1
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 02:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsNkDdVLEh+uHxIe0zfYacLXQSdEo7mekDyrb6hiodw=;
        b=liRfmPiq7q99yRgF+35Ia49mTmyKhbTSkCYIdnkP3xnq2cAvEg1QFUqg6f9G3ezNB8
         V+Q5wVA/tzz2ClfT7FIYuA8T5gFo03kV+Dr0lgYt5chWLhSVXBSBk7zHt9BwWLaCJ0zW
         DEbXUWfkS8m1bQ5JSKN+RQQKLkkRbE7SRWt/IsDmHIjUiAUwO1gmmE2QoofJlo9YfBvh
         bSj0TAgSn2ypL4JLeMMte4gA86mrIvC/poDF7974nw2qw1WykY7I56y8N/SY5Ch1Wocq
         Q1T1aWTG6FYFiVIj8epjzYUcQzPwBH10HMpAIdKAp0TDRP7lfhco3w28pck7KhLA+qMF
         JGlg==
X-Gm-Message-State: AOAM532//5n+1Onrd8TDaoB+6OsWdiuc+auMGee1v7HQuNALD8UHAAyQ
        qLemDoZ3/fPOEYCPPb6KAvYMjfpN6YrHiBgXpmk=
X-Google-Smtp-Source: ABdhPJzs2j2qX8Md+MyUZU+RSLxCZWUNlt/CDNfxrmDN34N8eE6xgQNsBf+saJRErr8QR5R3epsa5lpTurI4A6IrYQY=
X-Received: by 2002:a2e:3209:: with SMTP id y9mr8604724ljy.254.1624010319407;
 Fri, 18 Jun 2021 02:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
 <20210618081904.141114-2-mailhol.vincent@wanadoo.fr> <20210618091015.kioemxe3j3cbx6qg@pengutronix.de>
In-Reply-To: <20210618091015.kioemxe3j3cbx6qg@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 18 Jun 2021 18:58:28 +0900
Message-ID: <CAMZ6RqJY5+UOGY8gBEQ76H8h09jeRaBkXRx6G4AhesLEM3Uoag@mail.gmail.com>
Subject: Re: [PATCH 1/2] can: netlink: clear data_bittiming if fd is turned off
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 18 juin 2021 at 18:10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 18.06.2021 17:19:03, Vincent Mailhol wrote:
> > When the FD is turned off through the netlink interface, the value
>
> values
>
> > still remain in data_bittiming and are displayed despite of the
> > feature being disabled.
> >
> > Example:
> >
> > $ ip link set can0 type can bitrate 500000 dbitrate 2000000 fd on
> > $ ip --details link show can0
> > 1:  can0: <NOARP,ECHO> mtu 72 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
> >     link/can  promiscuity 0 minmtu 0 maxmtu 0
> >     can <FD> state STOPPED restart-ms 0
> >         bitrate 500000 sample-point 0.875
> >         tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
> >         ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
> >         dbitrate 2000000 dsample-point 0.750
> >         dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1
> >         ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-inc 1
> >         clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
> >
> > $ ip link set can0 type can bitrate 500000 fd off
> > $ ip --details link show can0
> > 1:  can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
> >     link/can  promiscuity 0 minmtu 0 maxmtu 0
> >     can state STOPPED restart-ms 0
> >         bitrate 500000 sample-point 0.875
> >         tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
> >         ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
> >         dbitrate 2000000 dsample-point 0.750
> >         dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1
> >         ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-inc 1
> >         clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
> >
> > Remark: once FD is turned off, it is not possible to just turn fd back
> > on and reuse the previously input data bittiming values:
>
> > $ ip link set can0 type can bitrate 500000 fd on
> > RTNETLINK answers: Operation not supported
> >
> > This means that the user will need to overwrite data bittiming with
>                                         ^^^^^^^^^
> set
>
> At least with your change it's more a "set again" than to overwrite.
>
> > fresh values in order to turn fd on again.
> >
> > Because old data bittiming values can not be reused, this patch just
> > clears priv->data_bittiming whenever FD is turned off. This way, the
> > data bittiming variables are not displayed anymore.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > Hi Marc,
> >
> > I suggest to rebase this patch before the netlink TDC series.
>
> makes sense - If you're OK with the changes, I'll add them while
> applying.

I am OK with the changes.

> Your patch makes the interface consistent, another option would be to
> allow FD mode if the data bit timing values have been set before.
> Opinions?

One part of me says it would make sense but let's also try to be
realistic. The only reason I spotted this issue is because I was
actively trying to find defects while testing my TDC
implementation. Under normal usage, I never had have such needs.

How many people will need to set fd on, then off, then on again?
Too few I think. Let's force those few people to always provide
the data bittiming values. The overhead which would be needed to
implement this in drivers/net/can/dev/netlink.c is just not worth it.

> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
