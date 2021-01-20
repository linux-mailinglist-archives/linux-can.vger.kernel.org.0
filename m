Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD62FCDEC
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 11:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbhATKNQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 20 Jan 2021 05:13:16 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:42990 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbhATJSh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2021 04:18:37 -0500
Received: by mail-yb1-f174.google.com with SMTP id b11so16545376ybj.9
        for <linux-can@vger.kernel.org>; Wed, 20 Jan 2021 01:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rNysPJKwIOgrglxJkIFlafPBKoVf5FD9MqVX/IDTO1A=;
        b=r7Gk25FBZ3fmXt+Y+KwCvvMGbkPtOQZBwa44LPAcdeOcTUnFnddXRrXcdudIc2ayJi
         w130NVi8UjkakCMFPXfESv6aW0KfVrlPEVQJCpMwc/S/5MPbjFwcpdUQgDlGh16N0ys7
         tV6rF4W8CGSRVoZq6J5OvGLb6xO6lbRx6pjfFwnVn/bN+AeS0trGtc3mE5aYS6litykp
         ATAf2847lbQy3hpQ0Pw6uw/f3wC+gQvf1CeqwV00JmTO8nGYYL0PgZ8r/OLuM2uYUT4p
         PRtjraIiiQdjFpKfmmzquEUHbIFrwoUfePY2zyAMy+ieCFShajCN4zW8qPjG+sfeCZaw
         A6iQ==
X-Gm-Message-State: AOAM531SdLMewEmIrkWSdZBxE9hQXUmGmm4hlh/JcCUWyHyXDlVw5BFf
        UIsVTM/LdMeX+R5Y3qXiyDcguGCE6oxMajV2M7o=
X-Google-Smtp-Source: ABdhPJziOEnj1wUo7OnFqtH2CT4s8oDzQlfYj6J1e6+Qxi+yh10t4lCAZ0Be0eBrDowRm4E8h1kDx97M34wUA88hzzE=
X-Received: by 2002:a25:5583:: with SMTP id j125mr11380829ybb.307.1611134275831;
 Wed, 20 Jan 2021 01:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20210120090930.137581-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20210120090930.137581-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 20 Jan 2021 18:17:45 +0900
Message-ID: <CAMZ6RqJSYx=-nHJSLtca9w-X-JVVvEZL_bBc_Q1Z=2pCH_dT-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix several use after free bugs
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 20 Jan 2021 à 18:09, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> This series fix three bugs which all have the same root cause.
>
> When calling netif_rx(skb) and its variants, the skb will eventually
> get consumed (or freed) and thus it is unsafe to dereference it after
> the call returns.
>
> This remark especially applies to any variable with aliases the skb
> memory which is the case of the can(fd)_frame.
>
> The pattern is as this:
>     skb = alloc_can_skb(dev, &cf);
>     /* Do stuff */
>     netif_rx(skb);
>     stats->rx_bytes += cf->len;
>
> Increasing the stats should be done *before* the call to netif_rx()
> while the skb is still safe to use.
>
>
> Changes since v1:
>   - fix a silly typo in patch 2/3 (variable len was declared twice...)
>
>
> Vincent Mailhol (3):
>   can: dev: can_restart: fix use after free bug
>   can: vxcan: vxcan_xmit: fix use after free bug
>   can: peak_usb: fix use after free bugs
>
>  drivers/net/can/dev/dev.c                  | 4 ++--
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 8 ++++----
>  drivers/net/can/vxcan.c                    | 6 ++++--
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
>
> base-commit: 1105592cb8fdfcc96f2c9c693ff4106bac5fac7c
> --
> 2.26.2

And of course, I just saw Marc comments just after sending the v2...
Please ignore this message, there will be a v3 rebased on net/master.

And sorry for the noise.


Yours sincerely,
Vincent
