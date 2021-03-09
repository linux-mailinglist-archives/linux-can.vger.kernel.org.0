Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31B332547
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCIMSS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:18:18 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:45873 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIMSM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 07:18:12 -0500
Received: by mail-yb1-f171.google.com with SMTP id l8so13696881ybe.12
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 04:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYfe4YsWmLR8DqQ1+nqBY7yqR6R6yDNohuTgp//Kio8=;
        b=nB1a8hgECo5Y9JGAsIEvQq105LNgXyoUk5z/rEnekH3OR4fvqJrXEikYjYPfWu060l
         xV/qZRQuoQPITQMPDCM8ikqB0bKdJVkNsNejLTPL703iv8Khj8kox3K7k6J2AVThclED
         d/DOWriJXvyxSV6P9sXwMo53nYJ2Mb/U0QAZQZwLiMZGmmIKdJQhKobcphthljwlGhVI
         Ogr1uaGDF4rsOwhgm8mg0LCxxIkDezYTQpqG7C+GFD3BAlRAP8BLho6h20bEG7pBm65R
         5ZdK/2xCKQQN7qj49Ve2lmKdTtF0UJNQl4mmMYPj57fQ3QmW62vs06lxs68FdUfY4Rhh
         tHmQ==
X-Gm-Message-State: AOAM533Nuhx0Mf4MNTk1AKjFeWtP+3JmdJTf78I33MRRsbafa0qEl19o
        LvMTj16X6iQuxq0jIm1NvUmEp6PfDZMAm1RNfUIUVeBCcTuiiA==
X-Google-Smtp-Source: ABdhPJweSrOG6NPtAL5openz0bt0rh2+KkxTJKMZCnRhu18D2wcZfXE07PytQQ3sfatTS92NzgNPDHuh7ZGDI+vMME0=
X-Received: by 2002:a25:2c96:: with SMTP id s144mr23120101ybs.487.1615292291711;
 Tue, 09 Mar 2021 04:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr> <2f2db145-0d70-0795-2dda-54f5ade68681@gmail.com>
In-Reply-To: <2f2db145-0d70-0795-2dda-54f5ade68681@gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 Mar 2021 21:18:00 +0900
Message-ID: <CAMZ6RqKExqbVkJ+efo=ROU3v1biRNFPzs3P3=p+yF7bTAUFY-g@mail.gmail.com>
Subject: Re: [PATCH v12 0/1] Introducing ETAS ES58X CAN USB interfaces
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jimmy,

On Tue. 9 Mar 2021 at 17:30, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
>
> On 2021-03-08 17:34, Vincent Mailhol wrote:
> > Here comes the twelfth iteration of the ETAS es58x usb driver. The
> > major difference from previous version is the total removal of
> > spinlocks. Aside of that, I also implemented the TDC accordingly to
> > the patch series which I submitted here two weeks ago.
> >
> > This patch series is based on linux-can-next/testing. It requires the
> > latest patches in that branch to compile.
> >
> > Crossing fingers, hoping that we are now close to a release.
> >
> > Thank you in advance for your review and for your time!
> >
> >
> > Yours sincerely,
> > Vincent
>
> Hi Vincent,
>
> Can you please send me the patch, since it does not reach the mailing list (+100 000 characters).

I resent it. It is now available at: https://lkml.org/lkml/2021/3/9/456

Also, I guess that your main interest is the TDC. If so, please
check function es58x_fd_enable_channel() and structure
es58x_tdc_const both in es58x_fd.h


Yours sincerely,
Vincent
