Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE7298575
	for <lists+linux-can@lfdr.de>; Mon, 26 Oct 2020 03:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421304AbgJZB7u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Oct 2020 21:59:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37086 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421303AbgJZB7u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Oct 2020 21:59:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id f7so9061434oib.4
        for <linux-can@vger.kernel.org>; Sun, 25 Oct 2020 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6liV2lf1L1Xkd0AvZKsJ5yMl7uo9CundS/uVIartic=;
        b=cw2mXt6eKPiH+zuxSikCtuek2az5JLtGahagc9U+4fdY7HIRBdOZ9MpQtPkdO/yx83
         u6YizzpHMhH6wE57dgL64x7IPGBZ3YAsIA5AbV4dl9XupsVEyMUD4QeXB9SgRLgXzGIz
         suWrRMvPJZfCCB9b0PKi4iShE7+ONLlXp/v+JIOQCciw0/HA3Q8Ndn07FQ2GbreVROns
         XZwaUH0yL9+fYIsTq8GdvXDpvGMrk3BwBL146gMdviP+VBdhOiQ2+Dw/J6ykG+oYjnER
         JFEBory1VPM+OBZF8bJdGaR9/C01JHg9I6cBDlwVHgzZUpfXtEp7S4tfP1MfM8VQLiv0
         aXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6liV2lf1L1Xkd0AvZKsJ5yMl7uo9CundS/uVIartic=;
        b=EIwWEnXGF1rbblrExJMJx2YcVRZVYyQe3m/f3nm05ZureVqJqh1Il8RejeaiFoJLlu
         NmcDsKnVtILt+Kjah1XhVXwdt898U1WA5u6vVS0SM/obvHux5QnWuF5sgzEbcgsAc9ws
         X9//xdZZC7U6O+DnWGt2grEblWHSOY/mmCrGFXBs4Yx4I+n+VjHHyNiUzCRNMn15aKz9
         YuNX0JUOHsH1OmyljlNq9gsR72Huj2cWVmYPnD52lOeXktJyh4e0k7Y2a/iR0QYbPZ8N
         s8+yeXoaN0bWn0XH9ycUQN91s9ddl+TiENrk3OMaG7+f3P9SBH/nFSJF5mRB1wwdLPnO
         xnYw==
X-Gm-Message-State: AOAM531DLkInNMCRFeTSk+XV0sYgM/lebuLoOubpudIZ6vnTqJVMmceN
        Qi7ktUBxRVxOGWZZFhrivgLbXTS1v7U7gh7BqB3fEeuDMxHiUeu5
X-Google-Smtp-Source: ABdhPJw9ztfYNpUetZDW4P4cvAuEV4Vusn7zr0kpZ4Kf6zlvkOWi/qOuvjWty2QB3J8+S+uzPv9wePzKnragu/dLltQ=
X-Received: by 2002:aca:b644:: with SMTP id g65mr9191036oif.164.1603677589085;
 Sun, 25 Oct 2020 18:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
 <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de> <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
 <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net> <20201025105808.2pltif74at3xwtjd@hardanger.blackshift.org>
 <68846197-98dc-b991-1ec8-a477ceb8d614@posteo.de> <715b3c3b-dbbc-688c-9757-578455c3a607@pengutronix.de>
 <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de>
In-Reply-To: <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Sun, 25 Oct 2020 20:59:55 -0500
Message-ID: <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, Oct 25, 2020 at 1:42 PM Patrick Menschel <menschel.p@posteo.de> wrote:
>
> > The
> > https://github.com/marckleinebudde/linux/commits/v5.4-rpi/mcp251xfd-20201022-54
> > branch already contains overlays:
> >
> > https://github.com/marckleinebudde/linux/commit/9e02abd4fe591b2d7f369cdaaaf8f1269b7c8693
> >
> > Marc
> >
>
> OK, I should have known better ;-)
>
> --
> Patrick

Are there any additional parameters that you are specifying for
"dtoverlay" in config.txt, such as spimaxfrequency?

Thanks,
Drew
