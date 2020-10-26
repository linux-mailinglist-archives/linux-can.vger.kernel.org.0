Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD332985A7
	for <lists+linux-can@lfdr.de>; Mon, 26 Oct 2020 03:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbgJZCuh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Oct 2020 22:50:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43185 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420272AbgJZCuh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Oct 2020 22:50:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id k68so6742424otk.10
        for <linux-can@vger.kernel.org>; Sun, 25 Oct 2020 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrwFXDuvfTdsXaSzlGyUHx3OYPC4UTZ+MggONW3V+tk=;
        b=gysugqaqKpCxSjUUhzr5YuFSlQ7IjQxIEGCx+Tu/dkMEoEHW3Nza1zqwp9TLtZNXuw
         1Qq1YSX6djXOxcIyHL7Zetmfan5MntoKszG+6Ct+C+b2BZOGKtzxBy32bPeHwcyXzWgl
         BfERg/NHlxVQaPwuzS27SN8gjrR3gYCK0sUd31n1yyN4949hCpE8SiydHHUVgsPntuwH
         k30d+3iHfFlbM1Y028BceH6rUt4mV5dz0V7zau7HwHXgM826mQ5X00uhuCMB++J7nVtO
         lJKIj3zhemueB9sPy4SJMh4+VzeDFzJ57kTbXKnxurHxbpK4ZBliH6PcFEEoPwu+Xm8M
         hm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrwFXDuvfTdsXaSzlGyUHx3OYPC4UTZ+MggONW3V+tk=;
        b=hLBsBzDvveE9/gXpjqwhy6cAQP8Jt5SF9jXFh9DSPdJJVcxuBsSC6lIqEENZR8cwyQ
         wpNQY3kuPCWvTYX/ud7OzlD5KMN7iH2QJtlqnbocUF4v7CdVdq0dbgVUq1tcYtYtpia3
         DqBCwk52fR0Z298sM0leh5SXK1jNR6wuPtisTMW2yM7zI2rzQsql35j9XiniW1GsLrs8
         kx8Bf1V7+Srdw8rx54l87VO6NTaopFSYK1c8Wp/K1LgUg1sOMT1ACqq7Hd3e50MZ07f1
         8+ZkXlCYCORvDOPWGTmlv2q4xSy7B6GtHedTQxzcQyihLaFOVGRRrbSu1j7mCvI/Fvap
         0qPg==
X-Gm-Message-State: AOAM53026Lkj32BtlpDuBV+VU3DOPtRFXB14lctOr5vFwFyr1Czz/UZE
        6IQ6Hl153BVsL1msU+M9uZsoG11l8HXC/HA/Dxbipw==
X-Google-Smtp-Source: ABdhPJxUIWPXgfTmwuqozq3tSkQqro9TPVkS2VETFWVGJGXLh7fMxEgmP4ErEXM/F50EGfPifxKtttV1fRvI/31C2qw=
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr11470801otc.114.1603680634737;
 Sun, 25 Oct 2020 19:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
 <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de> <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
 <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net> <20201025105808.2pltif74at3xwtjd@hardanger.blackshift.org>
 <68846197-98dc-b991-1ec8-a477ceb8d614@posteo.de> <715b3c3b-dbbc-688c-9757-578455c3a607@pengutronix.de>
 <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de> <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
In-Reply-To: <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Sun, 25 Oct 2020 21:50:40 -0500
Message-ID: <CAPgEAj4DceAkPySUekDZPAKwNToxNjz6Yr66_3mqkE-0iiKAYA@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, Oct 25, 2020 at 8:59 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> On Sun, Oct 25, 2020 at 1:42 PM Patrick Menschel <menschel.p@posteo.de> wrote:
> >
> > > The
> > > https://github.com/marckleinebudde/linux/commits/v5.4-rpi/mcp251xfd-20201022-54
> > > branch already contains overlays:
> > >
> > > https://github.com/marckleinebudde/linux/commit/9e02abd4fe591b2d7f369cdaaaf8f1269b7c8693
> > >
> > > Marc
> > >
> >
> > OK, I should have known better ;-)
> >
> > --
> > Patrick
>
> Are there any additional parameters that you are specifying for
> "dtoverlay" in config.txt, such as spimaxfrequency?
>
> Thanks,
> Drew

I'm seeing this message which makes me think my issue is that I am not
setting the oscillator as a dtoverlay param.

[    6.873081] CAN device driver interface
[    6.879904] DEBUG mcp251xfd mcp251xfd_probe(): ENTER
[    6.880068] spi_master spi0: will run message pump with realtime priority
[    6.921312] mcp251xfd spi0.0 (unnamed net_device) (uninitialized):
Failed to detect MCP251xFD (osc=0x00000000).

From /boot/config.txt

[pi4]
dtoverlay=mcp251xfd-spi0-0

Could you please share what your experience has been like?

thanks,
drew
