Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8542BB597
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgKTTa4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 14:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbgKTTan (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2020 14:30:43 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA043C061A4A
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2020 11:30:43 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so8845473pfn.0
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2020 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3bv50j9tOMZCSWAChUvUk5K6TgooTRt3SRcQZBJ9fcA=;
        b=GgFl3K9IS/lWsdMjkEVVAtTSDzsQ0sxEOabPKwuHzNJyTA7s1nVN/P5Py+wtAIOvbE
         i43RryzoLL4QMDFVI6bDxTe0ngekUN0rycJ/u5dixn0o4ZWxiMdHtnF6M1zgV7bxdmjG
         OxnZTS8PQwcd6ZCwnahaxVB8GYQEw6f4nxFx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bv50j9tOMZCSWAChUvUk5K6TgooTRt3SRcQZBJ9fcA=;
        b=c6w4rK3gFN1awq1ySMAn/qRPs68EFTuVxDdb4broKz9ca1oyg40vXXOnFmfSjYNh1a
         a50I6q4PszTMc+e/1OFrx78i9BvSUsZYl0QBSJ6gGAn7jZ5WESGMbDpcbnEWfaxPs0W7
         TF13tIuirEUAITWkrzubRROeI8g6bxO48b8KHFfl1Q6Aq0HpMRiV1ITrmQGf94BBe7yw
         heZvmXH62KYOF21cp+qaSKv17K/2ax909exqnRtdMXyTTnGQ4qtrwt4R2VYLPS59e25r
         MQLOwUZ0LzGONju12KF2MFFmuU+sS7FQhp6uIATpCaNBuPbHxDNw/fP+dopnR6T8l+n4
         9b3Q==
X-Gm-Message-State: AOAM532wF/qpPaA6DDTLHscQo7N2E6S5uqRfwM6mU813ln439E2LAGC8
        HQk026K+OPebIlcCFJY9DTQBZg==
X-Google-Smtp-Source: ABdhPJwl3VgOHP/MWhG5DtpaEL0Yyt6dBbRzpe/94BRgWnGkgcq6AJ5JXkZmDK0TJqDkyAhq9Y3Q+Q==
X-Received: by 2002:a63:5043:: with SMTP id q3mr17907345pgl.137.1605900643099;
        Fri, 20 Nov 2020 11:30:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10sm4785681pjj.38.2020.11.20.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:30:41 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:30:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        amd-gfx@lists.freedesktop.org, bridge@lists.linux-foundation.org,
        ceph-devel@vger.kernel.org, cluster-devel@redhat.com,
        coreteam@netfilter.org, devel@driverdev.osuosl.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        dri-devel@lists.freedesktop.org, GR-everest-linux-l2@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, intel-gfx@lists.freedesktop.org,
        intel-wired-lan@lists.osuosl.org, keyrings@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org,
        linux-afs@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-can@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-ext4@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-geode@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
        op-tee@lists.trustedfirmware.org, oss-drivers@netronome.com,
        patches@opensource.cirrus.com, rds-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, samba-technical@lists.samba.org,
        selinux@vger.kernel.org, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        usb-storage@lists.one-eyed-alien.net,
        virtualization@lists.linux-foundation.org,
        wcn36xx@lists.infradead.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Message-ID: <202011201129.B13FDB3C@keescook>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:
> > This series aims to fix almost all remaining fall-through warnings in
> > order to enable -Wimplicit-fallthrough for Clang.
> > 
> > In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> > add multiple break/goto/return/fallthrough statements instead of just
> > letting the code fall through to the next case.
> > 
> > Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> > change[1] is meant to be reverted at some point. So, this patch helps
> > to move in that direction.
> > 
> > Something important to mention is that there is currently a discrepancy
> > between GCC and Clang when dealing with switch fall-through to empty case
> > statements or to cases that only contain a break/continue/return
> > statement[2][3][4].
> 
> Are we sure we want to make this change? Was it discussed before?
> 
> Are there any bugs Clangs puritanical definition of fallthrough helped
> find?
> 
> IMVHO compiler warnings are supposed to warn about issues that could
> be bugs. Falling through to default: break; can hardly be a bug?!

It's certainly a place where the intent is not always clear. I think
this makes all the cases unambiguous, and doesn't impact the machine
code, since the compiler will happily optimize away any behavioral
redundancy.


-- 
Kees Cook
