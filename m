Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE82C5915
	for <lists+linux-can@lfdr.de>; Thu, 26 Nov 2020 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391535AbgKZQSa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Nov 2020 11:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391528AbgKZQSa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Nov 2020 11:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606407508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IL7sPB68gF1YeWIUFuBJ//YIBDjI3bDL6qHHKubt/Z0=;
        b=UrXDoUgTxqj1WRS8neld6HV6fanuCB2c0WlpqmfwON3ejDu/FMVt0X7ml3vyqXOkPXTaHP
        iyzjRcaEhT909GCHvuy4UukfBBVO3DDHbtx6yRTBEFxNxYSd2Xp6GyufOqP8gIVepFFwdR
        sF5812evLGCZkSl+1M/68FsLiI2eGX4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-X1A2H9_PPa6uW4htBTlHtQ-1; Thu, 26 Nov 2020 11:18:27 -0500
X-MC-Unique: X1A2H9_PPa6uW4htBTlHtQ-1
Received: by mail-qt1-f197.google.com with SMTP id f19so1497138qtx.6
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2020 08:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IL7sPB68gF1YeWIUFuBJ//YIBDjI3bDL6qHHKubt/Z0=;
        b=Tao/fOWG8M/u1mlc1kv0GGW6dzf7baFv9/Jl1pM1zOADc37N50XrqTXv/zbikwywtt
         orN5TJCAE7tx5GGO7da/s5hlcSSvlVeu2zMbGmHuVNVOWLyoX30RTKDzPWZogGnTWh63
         wgt6vBUciIi9Zqs7DxNa0kWYlPqEPfh/QYhnEKBAuEM1IfpVNK2A4qCU/DNJkW4/mOzH
         PD6msf4ucSBMzEGSB9s4LolJrtE4tIylKsKdrZhg41/vc0XY6MEPe2vE9EjQlLzvHZ7R
         5NYKPsNoNXFPtdf2aaENNaI9iXPfWi4BEfW0lLkRx9QD9TK9QDP0TxOKcVKfS5xOERr5
         ifFQ==
X-Gm-Message-State: AOAM5318/SAb/BqWLZWB86IUOcydv/BukbbTRsXGTlDL0GQF2oI4cGjH
        CbIAEhdUUN2CxDMuxHaAPt1hUldNeG9St5RcmSPSlboGZLE0bnoReIBBOtqUXOb1AkcswQrOzPm
        TELKlmFI1OHewpoXZnz8DLRaMFIlhgn8w/zDC
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr3807128qkf.425.1606407506116;
        Thu, 26 Nov 2020 08:18:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCU4CKAolN2PpaYdMoKCHma/+NC3lHjkQkQkRPTWC20j3rANbYTTy+FG9V7n634RRlgf0kcsxPjR4LO+NB5fA=
X-Received: by 2002:a37:ac8:: with SMTP id 191mr3793888qkk.381.1606407504531;
 Thu, 26 Nov 2020 08:18:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook> <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook> <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
 <1c7d7fde126bc0acf825766de64bf2f9b888f216.camel@HansenPartnership.com>
 <CANiq72m22Jb5_+62NnwX8xds2iUdWDMAqD8PZw9cuxdHd95W0A@mail.gmail.com>
 <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>
 <CANiq72k5tpDoDPmJ0ZWc1DGqm+81Gi-uEENAtvEs9v3SZcx6_Q@mail.gmail.com>
 <4993259d01a0064f8bb22770503490f9252f3659.camel@HansenPartnership.com>
 <CANiq72kqO=bYMJnFS2uYRpgWATJ=uXxZuNUsTXT+3aLtrpnzvQ@mail.gmail.com>
 <44005bde-f6d4-5eaa-39b8-1a5efeedb2d3@gmail.com> <CANiq72nobq=ptWK-qWxU91JHqkKhMcRtJNnw2XJd5-vSJWZd8Q@mail.gmail.com>
 <CAMuHMdV5kOakvZJMWLxbpigFPS+Xuw6DVYsWCWZy7wGsv3idcw@mail.gmail.com>
In-Reply-To: <CAMuHMdV5kOakvZJMWLxbpigFPS+Xuw6DVYsWCWZy7wGsv3idcw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 26 Nov 2020 17:18:13 +0100
Message-ID: <CACO55tsBj3gLECoMWtViDitd7fVTnW+Cp0LVmqYkR=QFBJkEmQ@mail.gmail.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        bridge@lists.linux-foundation.org,
        target-devel <target-devel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-ide@vger.kernel.org, dm-devel@redhat.com,
        keyrings@vger.kernel.org,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org,
        linux-i3c@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        linux-afs@lists.infradead.org,
        Lars Ellenberg <drbd-dev@lists.linbit.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
        scsi <linux-scsi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        oss-drivers@netronome.com, linux-atm-general@lists.sourceforge.net,
        ceph-devel <ceph-devel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com,
        usb-storage@lists.one-eyed-alien.net, coreteam@netfilter.org,
        intel-wired-lan@lists.osuosl.org,
        linux-input <linux-input@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-sctp@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        linux-geode@lists.infradead.org, linux-block@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        linux-hams@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-can@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        GR-Linux-NIC-Dev@marvell.com, Linux-MM <linux-mm@kvack.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        samba-technical@lists.samba.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        patches@opensource.cirrus.com, Joe Perches <joe@perches.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Nov 26, 2020 at 4:28 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Miguel,
>
> On Thu, Nov 26, 2020 at 3:54 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Wed, Nov 25, 2020 at 11:44 PM Edward Cree <ecree.xilinx@gmail.com> wrote:
> > > To make the intent clear, you have to first be certain that you
> > >  understand the intent; otherwise by adding either a break or a
> > >  fallthrough to suppress the warning you are just destroying the
> > >  information that "the intent of this code is unknown".
> >
> > If you don't know what the intent of your own code is, then you
> > *already* have a problem in your hands.
>
> The maintainer is not necessarily the owner/author of the code, and
> thus may not know the intent of the code.
>
> > > or does it flag up code
> > >  that can be mindlessly "fixed" (in which case the warning is
> > >  worthless)?  Proponents in this thread seem to be trying to
> > >  have it both ways.
> >
> > A warning is not worthless just because you can mindlessly fix it.
> > There are many counterexamples, e.g. many
> > checkpatch/lint/lang-format/indentation warnings, functional ones like
> > the `if (a = b)` warning...
>
> BTW, you cannot mindlessly fix the latter, as you cannot know if
> "(a == b)" or "((a = b))" was intended, without understanding the code
> (and the (possibly unavailable) data sheet, and the hardware, ...).
>

to allow assignments in if statements was clearly a mistake and if you
need outside information to understand the code, your code is the
issue already.

> P.S. So far I've stayed out of this thread, as I like it if the compiler
>      flags possible mistakes.  After all I was the one fixing new
>      "may be used uninitialized" warnings thrown up by gcc-4.1, until
>      (a bit later than) support for that compiler was removed...
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

