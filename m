Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1D36D3C8
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 10:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhD1ITD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhD1ITC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 04:19:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332CC061574
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 01:18:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 130so28978531ybd.10
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDsZLTfAlM2Ip+iySBnXCNmCYlyvfgBz3QPUUrtZED4=;
        b=ABcPjZzcssVsCoTqNtNt7ywSuUUIsg/u0qdNqWNHmA7rG6HTDkqDmaE9cJQO4BxKwC
         PaSWYhyDcDsL2ICFIk1twGRyk0yLbyEBoivZb8O2lNp6Vpg9oOgpkuOFCOxlRZlb0XFG
         hFJ7g0W+s4mRoWV+m8lafcqYryno9XuK0aFLQK0LLOJRRwyCgtIYbnoYyQVQK8Vodw+d
         zy4RKh817q7AZHxHrBV3ybXfd0hMHbKwwmvPqVb6y76HkoKye+U6CkAC6HzwQRTNFuEb
         3oYovsq9qR3WQ09KufOWsehBEI7XLyMV+OVlfZf4G/P2e4QWviPMR7gJcVf8iZAOPbDU
         a8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDsZLTfAlM2Ip+iySBnXCNmCYlyvfgBz3QPUUrtZED4=;
        b=UjKkV/GVX9NoIdz64th9V13v73QHrSR029nWehOnI9oAmrCB/H6byyd/BGUkyeCaxA
         Qv4ur4lx3cF2DunTWYhZnivUFN73OxKElEESrjoJNVTZJ66HrgnSOKbWKfYVl3kATVaX
         5WMMSs+TWFIBcjgdnxw35PYhqYkjO2LKuDKssviEEZoRqRW7btNbm1wdwTpDnH8VcX82
         cbRqChi7XiuMY3Kvt58UMUjPZTnbMv23SYlHcAuxeND79+Ib9SdS/EFeXGf5e3eny9Vh
         FTQP0HXdUTddpjc8VoDtHT3K+xrsyl0iTEr7VLVoXB75g6rQnd9NGGVCFjKPrcBgApx9
         YPrg==
X-Gm-Message-State: AOAM531bTHwlu7BejK1nYm6xyafakW6mdlJyY2Ja0ZstErneZcDs/E/u
        9L/me3PwYCSRonWd9tOZFatjohzAV3I4J/eIceSWNgpCLum5qw==
X-Google-Smtp-Source: ABdhPJyIGCEuvfl+F0T8tq7pkJTNtTWv1xwgE/Zim6d2o4rkuHLPJA2e5LEVxYQQ+pbOnEMzrnq30qsKIc1U4UbsDSg=
X-Received: by 2002:a25:e64b:: with SMTP id d72mr22276378ybh.343.1619597896057;
 Wed, 28 Apr 2021 01:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de> <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
 <20210402192759.up2tperefmwyt3r2@pengutronix.de> <CAAfyv35ofuk-z4qByJp3y9JRuAYPu4WaUaBf_o9QyschPNOOUg@mail.gmail.com>
 <CAAfyv37Wkh0rrAeEDyO1No6t0dnm=dSayZLdMvP6nWXCz12vdg@mail.gmail.com>
In-Reply-To: <CAAfyv37Wkh0rrAeEDyO1No6t0dnm=dSayZLdMvP6nWXCz12vdg@mail.gmail.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Wed, 28 Apr 2021 10:18:05 +0200
Message-ID: <CAAfyv35fksdrAp_=ptbXYNAdiPvyFJGy6k_iZiaNu+GaOWQZkA@mail.gmail.com>
Subject: Re: m_can error/overrun frames on high speed
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Apr 5, 2021 at 9:41 PM Belisko Marek <marek.belisko@gmail.com> wrote:
>
> Hi Marc,
>
> On Mon, Apr 5, 2021 at 7:31 PM Belisko Marek <marek.belisko@gmail.com> wrote:
> >
> > On Fri, Apr 2, 2021 at 9:28 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > >
> > > On 01.04.2021 11:04:25, Belisko Marek wrote:
> > > > Is there anything I can tune to have it read faster? Thanks.
> > >
> > > Indeed, with current net-next/master, you put the NAPI on a per
> > > networking device from softirq to threaded mode.
> > >
> > > | echo 1 | sudo tee /sys/class/net/can0/threaded
> > >
> > > Then you a separate NAPI thread per networking device that can be tuned
> > > with chrt, etc...
> > OK I've tse threaded mode for NAPI and for napi:can0 thread I set chrt
> > -p 99 <pid> but unfortunately there are still buffer overruns which is
> > kind of strange.
> >
> > For rx-offload branch I was not able yet to run it on my platform
> > (have panic during boot which I need to resolve first).
> OK I resolved boot issues on my platform and tested using rx-offload
> branch but again the issue is present.
> It's enough to generate can frames using candeg can0 -g0 and I get
> after some time error/overrun errors.
> I'm trying now to bump rx-offload patches on top of linux-can-next
> testing branch and test it.
Was bit fast with response. With rx-offload feature receiving can
frames with high speed (small gaps) is working fine as expected.
So what are the next steps? I can port rx-offload for c_can to actual
master and verify and post patches for review?
> >


Thanks and BR,

marek
