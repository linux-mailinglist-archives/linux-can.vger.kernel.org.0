Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE12F529D
	for <lists+linux-can@lfdr.de>; Wed, 13 Jan 2021 19:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbhAMSoj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jan 2021 13:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbhAMSoj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jan 2021 13:44:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C82C061794
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 10:43:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g24so3033907edw.9
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KzoTFWjybD/r1NtUndSBUsrUMAZKtv7j5VbLpYXnf8=;
        b=icWSwC1XH5N1j1UsZ/I7yXSO2Bv9DrpZ/ESFacPkPRQgTp1eWA3+zVHPoxj1Qm0SZX
         XRmJOUOfeW4HsHiyTLtZmqOSXY/m2eUjdfixjihZpMeSaqGcuWYhqnxqnvwOOZQrIT6/
         KWKbi8bS8cgWIac6Ielih93TzACXUza3NWz+BdUlAfelqSaboZMEi3b9UijIKTxG/ysB
         BrB7pQ62DDbb4S1PBE5RiK2aJ9jt+jZTDZDDicAVmK//PhpUpYfU83v1YvwC7kS8NMea
         rzlX1xEID3oVPCpG/GkZr696RfGGJIFIhYmsAT52lmQWh/8Gwmv8rp2AYDaSJvskvdnd
         loSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KzoTFWjybD/r1NtUndSBUsrUMAZKtv7j5VbLpYXnf8=;
        b=EFOMwr61kLWg+ts3l9T2HCu17OmLQMBUZgyMH7PwIqyNR9PIf7tQtALYkSZkvFH0mf
         X8sYFU9ZuKxEw0pPNCtEzT9SrzutPIp5nXsSsbbH23vPUcy1IqhefZhCGffqQ75X9tcy
         w9z7n8VAJY57UaO44Gs4i/gOqzf+qfc2lKaus2OFmcC/VF2hIKiTE14F1Qv8MJKGBTnJ
         a5LrNu42vAsPL9jiWE2ksKXZ9Wx2UO/XEAM3sQbnUZJb094N+oe/efjsBG9f/0kNL+mX
         +n+YjfqYh7p+9xxHQiRG+4W7rHbkTz7x5yg3PgFocRIZHcJbwlFLReTgGOAWf+jDduyv
         IEdg==
X-Gm-Message-State: AOAM5324fADsgcVsYt+Ps/6CQgYcRzrnBA0v2tFkMVfl7dq0uFrqqdSs
        kfMtKDWxEwxG1ecyR/Vfg14e2f6SYI7IBu4zGh4YHbZ5rQgIvw==
X-Google-Smtp-Source: ABdhPJz7yGlfZHsDJZRnLziMXfyryL2sAq76aj1N0CBiX2AVdhW2jODpzHCel2BFEEJKxOfntxde1pCc+7MHDoiPUdo=
X-Received: by 2002:aa7:cf8f:: with SMTP id z15mr2930266edx.17.1610563437312;
 Wed, 13 Jan 2021 10:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20190208132954.28166-1-andrejs.cainikovs@netmodule.com>
In-Reply-To: <20190208132954.28166-1-andrejs.cainikovs@netmodule.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 13 Jan 2021 15:43:46 -0300
Message-ID: <CAAEAJfBWMWuuVebLjURJE=+UtJ8OQxXtEiPWKeQMgQTJ5rivfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] D_CAN RX buffer size improvements
To:     Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Zysset <Patrick.Zysset@netmodule.com>,
        "Federico Rossi (fede.a.rossi@gmail.com)" <fede.a.rossi@gmail.com>,
        Max Sonnaillon <Max.Sonnaillon@ppst.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi everyone,

This series was recently brought to my attention, in connection to a
long-standing
packet drop issue that we had on a Sitara-based product.

I haven't tested this personally, but I've been notified that this was
backported
to the v4.19 kernel, and the packet drop was fixed.

It seems the series never managed to get upstreamed,
but I think this should be resurrected and merged (probably with after
some cleanup/review).

Thanks,
Ezequiel

On Fri, 8 Feb 2019 at 10:31, Andrejs Cainikovs
<Andrejs.Cainikovs@netmodule.com> wrote:
>
> Re-sending entire patchset due to missed cover letter, sorry.
>
> This patchset introduces support for 64 D_CAN message objects with an option of
> unequal split between RX/TX.
>
> The rationale behind this is that there are lots of frame loss on higher bus
> speeds. Below are test results from my custom Sitara AM3352 based board:
>
>   Sender: timeout 15m cangen can0 -g 0 -i x
>   Target: candump can0,0~0,#FFFFFFFF -td -c -d -e
>
>   * Without patches:
>     - 15 minute RX test, 500kbps
>     - 16 RX / 16 TX message objects
>     - 77 received frames lost out of 4649415
>
>   * With patches applied:
>     - 15 hours RX test, 500kbps
>     - 56 RX / 8 TX message objects
>     - 41 received frames lost out of 279303376
>
> Please note, I do not have ability to test pure C_CAN, so it is left untested.
>
> ---
>
> Andrejs Cainikovs (2):
>   can: c_can: support 64 message objects for D_CAN
>   can: c_can: configurable amount of D_CAN RX objects
>
>  drivers/net/can/c_can/Kconfig | 20 ++++++++++
>  drivers/net/can/c_can/c_can.c | 93 +++++++++++++++++++++++++++----------------
>  drivers/net/can/c_can/c_can.h | 20 +++++++---
>  3 files changed, 94 insertions(+), 39 deletions(-)
>
> ---
> 2.11.0
>
