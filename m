Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CFC4886FD
	for <lists+linux-can@lfdr.de>; Sun,  9 Jan 2022 00:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiAHXmZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Jan 2022 18:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiAHXmZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Jan 2022 18:42:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19703C06173F
        for <linux-can@vger.kernel.org>; Sat,  8 Jan 2022 15:42:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso16003455pjm.4
        for <linux-can@vger.kernel.org>; Sat, 08 Jan 2022 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQ/CfdKhUZ5+/TQqUvFWiP+we14F2aVxM/rq+O7X8e8=;
        b=JxzuVIgSRCVhbvxE6QreTw+bZ3DpN8CjujG/D9gtqUYLTdkgfYxxs+V3swGnB/RmVX
         M23Y0BtX3NWijbGeWf7nIBmMBoo9C8XcEGBWptQG5uA37CW2OOwun1Cmnq/iiY4cVvAC
         oU5ITE4GhrshEQKRvCyK50WU5Vi5cG5t4+UlTfnziSyk/eaOgHFe3tGAeyLHuEnjry0r
         Do+ltI5eJkp3CZI3y+s0FBRp/9bbrIHdc2whXzGiKrETcwAvMNEA0flzvW/HJycBWacs
         mRtUgFOpQFwzuTAYUSe/PU22iDryvPGv7FCh8R0r0miMvmH29hTHUX4dOgQz74bUtM4C
         3WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQ/CfdKhUZ5+/TQqUvFWiP+we14F2aVxM/rq+O7X8e8=;
        b=LA55v2tob9CvnKVfWQMxeGG/vu6NB2tFtAZGyrY+/lvhi2i9Lq766E0vuIK8jc4//B
         YoTEFQGG2bSlvIkgV6RyzOJbWcxcrqsqjlpBPqjRO0h6HyJ0QEyen3MB66KjcnZclVa4
         wp8KfBgowaX7s3r+gfXaFL6hbqOmedoUPL0g95cMpPFpK8PBBMUVGTtDcaOxhlP6hr5q
         UQuFkvGjWlUN9IYbXBcZNvqchzoCAM+vvRKfPQczmcSyMtqHVYKeChSE5sfICx3FAyv7
         AmTI9MHXulSQXhEo/ki0K1I5hT2qkJ0Y3K8sZTz6g0545s4njDSVtRLUa/BCaZN2prH2
         Vcbg==
X-Gm-Message-State: AOAM531PAriRPDnTwkCB20/IEUCKDtA/T8IJz7BkCAUyJoccbfU4Vpao
        SrEQC3iekQFpL3GlPk+n+wHPonlDua94VvphLKORMILHosI=
X-Google-Smtp-Source: ABdhPJzYV+0Rw+hblivnhbMXn2ywdxWIFpg+Xc0D/sSXuM1IHk68RZBUPK/bgr2GgUOhcFMUmJLp8+brf6iBiung9cM=
X-Received: by 2002:a05:6a00:1509:b0:4ba:f004:e3af with SMTP id
 q9-20020a056a00150900b004baf004e3afmr70911346pfu.32.1641685343646; Sat, 08
 Jan 2022 15:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20220106002952.25883-1-brian.silverman@bluerivertech.com>
 <20220108222904.plwxywgmnwrwpvmt@pengutronix.de> <20220108231655.oqzfap5yvh5xdumm@pengutronix.de>
In-Reply-To: <20220108231655.oqzfap5yvh5xdumm@pengutronix.de>
From:   Brian Silverman <bsilver16384@gmail.com>
Date:   Sat, 8 Jan 2022 15:41:57 -0800
Message-ID: <CAP01z6Khm+s=HsdYh0+wUF6H3=mVYkvBE0x_g_Qw745VtNayYQ@mail.gmail.com>
Subject: Re: [PATCH] can: gs_usb: Zero-initialize flags
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Jan 8, 2022 at 3:16 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> BTW: Your brian.silverman@bluerivertech.com address fails:
>
> | brian.silverman@bluerivertech.com
> |  host aspmx.l.google.com [2a00:1450:400c:c0c::1a]
> |  SMTP error from remote mail server after RCPT TO:<brian.silverman@bluerivertech.com>:
> |  550-5.2.1 The email account that you tried to reach is disabled. Learn more at
> |  550 5.2.1  https://support.google.com/mail/?p=DisabledUser o10si1930223wrh.555 - gsmtp
>
> Should I change the author's email address to your gmail address?

I wrote it as part of my employment by Blue River, but am currently
moving on to another job. The policy was to have my work email on the
patch. Seems like the same situation whenever somebody uses a work
email and then leaves that job, just in this case the timing is
tighter than common. I think leaving it is best.

To be clear, contributing this was definitely authorized by the
company, I just didn't get around to sending out the patch until
almost my last day.

Thanks,
Brian
