Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50085341989
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 11:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCSKIZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 19 Mar 2021 06:08:25 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:46542 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhCSKIF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 06:08:05 -0400
Received: by mail-yb1-f173.google.com with SMTP id h82so5604657ybc.13
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 03:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K5a0Wlyc20AxbXxKgHMANnZxmtDe9jb43AUfKxk+klY=;
        b=j9ZTtr3Y4MJLGFDcfPEI+LrK9La5Ne5lENCDfxMcjEu3MkJxXt3bLsMFT6dnuCYX/4
         Qvf7iK4BBzbrjZeeDKosL1ujoXCGVsZqgyEKxzeuOuDpXHdmIwYyCsCHN89ytOjSpZel
         uP0tem7JM2vFjowOgTJZiM3YM4wIGuETfYO4AFfUO+nSBFkTr9YyBPvG+1tSUiIos5eg
         c5QNW8J+qXExaKrACnLKNaKd4v3Ey4BGl7pBdchtgFOilthpDePWHTzpDwdpXqC69o17
         QU1j20WH9eGUCTHio19mA3Y03+ZxLABFywAwsJHxmTdPaSim/r3uoXFKL1tW5R/iHWKx
         LzQA==
X-Gm-Message-State: AOAM533wHlsqrDdES21roe7GfzbxkZ2/fP5uIBUexDmEOxvPETW05eXk
        7cie7oyPd7MZMf8/q5Mqeb9mrhgh9Ct+L6nu0Y11IfRZT5rcSg==
X-Google-Smtp-Source: ABdhPJxvsL5EB0dO+hh1kM3RzkC/xKdhaAg2tVleuCXmDmLZlUs8xGu5BXrUm21GQeEBr734iHMmoWVAnUu6aXz3CoY=
X-Received: by 2002:a25:3853:: with SMTP id f80mr5318329yba.514.1616148485070;
 Fri, 19 Mar 2021 03:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-3-s.grosjean@peak-system.com> <20210309152837.3vpzfgcxsexr7l7u@pengutronix.de>
 <20210319083925.rvkbikpmkfxhjmr2@pengutronix.de> <CAMZ6RqL_ua4NzJ5VMC8Nw0iSXfBDDuOpabVJv+EEK82c4AsnEQ@mail.gmail.com>
 <20210319095630.pheblaalfg6r6zvo@pengutronix.de>
In-Reply-To: <20210319095630.pheblaalfg6r6zvo@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 19 Mar 2021 19:07:54 +0900
Message-ID: <CAMZ6RqKNysYHXQHF+X+F_wbusdjByDaiQNwy9NvAtiAopFsG8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 mars 2021 at 18:56, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 19.03.2021 18:47:06, Vincent MAILHOL wrote:
> > On Fri. 19 Mar 2021 at 17:39, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 09.03.2021 16:28:37, Marc Kleine-Budde wrote:
> > > > On 09.03.2021 09:21:27, Stephane Grosjean wrote:
> > > > > Since the peak_usb driver also supports the CAN-USB interfaces
> > > > > "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch adds
> > > > > their names to the list of explicitly supported devices.
> > > > >
> > > > > Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> > > > > ---
> > > > >  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > > index 6183a42f6491..8e6250c4c417 100644
> > > > > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > > @@ -19,6 +19,8 @@
> > > > >
> > > > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
> > > > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
> > > > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB X6 adapter");
> > > > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-Chip USB");
> > > >
> > > > I've exchanged these, to correspond the order of the device ids.
> > >
> > > Funny side note:
> > > MODULE_SUPPORTED_DEVICE was a noop define. All uses have been globally
> > > removed from Linus' tree after this patch hit linux-net/master, but
> > > before it landed in Linus' tree.
> >
> > Silly question but does it mean that we should not use
> > MODULE_SUPPORTED_DEVICE in newly submitted patches?
>
> ACK - It's been removed from Linus' tree, see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6417f03132a6952cd17ddd8eaddbac92b61b17e0
>
> > After seeing Stéphane's patch, I added it to my driver. Even if it is
> > a noop define, it adds meta information in the source code so I was
> > inclined to keep it.
>
> As the noop define has been removed, the driver will no longer compile.

Got it, thanks for the link to the commit!


Yours sincerely,
Vincent
