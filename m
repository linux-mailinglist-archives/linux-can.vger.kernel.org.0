Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7893418B3
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 10:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCSJrc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 19 Mar 2021 05:47:32 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:41377 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCSJrS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 05:47:18 -0400
Received: by mail-yb1-f176.google.com with SMTP id p3so3416648ybo.8
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 02:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=40Fs8N2jtcmBvMluRzpkWK00jgszNkOuW+AiCr8/rco=;
        b=WmgiiWBHzb5DbHi/E3mmpy5RnwxveAFcyoZXytXdWBKCUkP7du83wZ2h3ic+uGDGwe
         l2titVubxSnfcPiaXcrb8tLuQp65A1nQS5XRRyks3ypR8nlVn1uZSXu1mmjQROi3W5s3
         1OJR6CCc2EZPW7aTKua28AGASpnu1veVB6lAGGNxNniOw5q8ui4coYRjRwP2hUAm1rIr
         2Y//UvaB84lLDmzvcLETfomOOkqLMiLmn3aV5zra2SG0IvOci0iwWWg7v42nM2hMdrwL
         mW+izArSfSl7Hc9uKJ5C+ld3E09CmUxBbNf7aENJxfGrHT5+Ut7tJR+XeOCN8Rj1hkzc
         mS5w==
X-Gm-Message-State: AOAM531ghpZsidQ6eA9fXjGoNf1jZEWdCWY47H/bMSo8JNZFp+1KtuEE
        I1V5YuKlBzB1Z9juV5J35YOLOsCLnn1tfRRTegS4E+RMXgV4dQ==
X-Google-Smtp-Source: ABdhPJyUSzPWSoUKAHI3oIkhTIM/w/h3/BdgTWwnAsHxdEuAjF78NJEVg7a544FivCD/jP9njPxI9xfBvEksLgRjX9k=
X-Received: by 2002:a25:a1a3:: with SMTP id a32mr5079270ybi.487.1616147237648;
 Fri, 19 Mar 2021 02:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-3-s.grosjean@peak-system.com> <20210309152837.3vpzfgcxsexr7l7u@pengutronix.de>
 <20210319083925.rvkbikpmkfxhjmr2@pengutronix.de>
In-Reply-To: <20210319083925.rvkbikpmkfxhjmr2@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 19 Mar 2021 18:47:06 +0900
Message-ID: <CAMZ6RqL_ua4NzJ5VMC8Nw0iSXfBDDuOpabVJv+EEK82c4AsnEQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 Mar 2021 at 17:39, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 09.03.2021 16:28:37, Marc Kleine-Budde wrote:
> > On 09.03.2021 09:21:27, Stephane Grosjean wrote:
> > > Since the peak_usb driver also supports the CAN-USB interfaces
> > > "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch adds
> > > their names to the list of explicitly supported devices.
> > >
> > > Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> > > ---
> > >  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > index 6183a42f6491..8e6250c4c417 100644
> > > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > @@ -19,6 +19,8 @@
> > >
> > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
> > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
> > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB X6 adapter");
> > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-Chip USB");
> >
> > I've exchanged these, to correspond the order of the device ids.
>
> Funny side note:
> MODULE_SUPPORTED_DEVICE was a noop define. All uses have been globally
> removed from Linus' tree after this patch hit linux-net/master, but
> before it landed in Linus' tree.

Silly question but does it mean that we should not use
MODULE_SUPPORTED_DEVICE in newly submitted patches? After seeing
Stéphane's patch, I added it to my driver. Even if it is a noop
define, it adds meta information in the source code so I was
inclined to keep it.


Yours sincerely,
Vincent
