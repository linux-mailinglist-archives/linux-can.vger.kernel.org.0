Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772534571E2
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhKSPpy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 10:45:54 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:40671 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKSPpx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 10:45:53 -0500
Received: by mail-yb1-f179.google.com with SMTP id 131so29412556ybc.7
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 07:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Touvx3EtJSyVoQfMEaIRjEBsy8qa3kj6nQ4uSC6WAV8=;
        b=sVuky1BcD4OjbTwY/fTwSmj0uUGZ07GTUVZ57dDKyQompcLl/qSrsWtvMwbeKPlVu/
         //XwtHMPe/1R6Y1zYBe5yXmSRL+l8q7KusbTrYJMVxffy0YwMebn6TdpfImxz6sT/jZA
         yCTIwt3ASEj4THZBOiB6pavWrxJt7ris8U9sPUMncR6n6FNlUYf4xgYzea4GvM3yPjUT
         R2GH1koIygHrmh/dDPMgEgNpGaLLfDn8WyKLVthCNWUO8ylJihBDK3uekZptLrB2oaOE
         igc/U6twsGZD5q0pyKjFg/aigVlTxc18mHWS7gOt+X4hnwA82XFXL/ZlbkWxYYGyyCTt
         TGeQ==
X-Gm-Message-State: AOAM533a+gL4thvTe2suRNc4yM9ubkcX51peKshrvALW2SqoYIPsEPvJ
        hCeOtRxg6fwUYNFbTktid6mIQq/6YFeXk8FEqLhQQMbxS74=
X-Google-Smtp-Source: ABdhPJw8coKJbZ/iUFeYKJi9UrQVUsTDw3esbd6Xe7ixvaEdJEwCrEk4cNcBLMSeowjiCUOLo2TyMCJkRB631BrDLTc=
X-Received: by 2002:a25:ae62:: with SMTP id g34mr39864294ybe.388.1637336571353;
 Fri, 19 Nov 2021 07:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20211119131915.2033234-1-extja@kvaser.com> <20211119131915.2033234-5-extja@kvaser.com>
 <90d2eddf-fcfb-0abf-2807-413b12480e8d@kvaser.com>
In-Reply-To: <90d2eddf-fcfb-0abf-2807-413b12480e8d@kvaser.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 20 Nov 2021 00:42:40 +0900
Message-ID: <CAMZ6Rq+gMAypGxVQEy0KKMMcb0n7hHNjefXUB-csAg3NgT_=FA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] can: kvaser_usb: Use CAN_MHZ define in assignment
 of frequency
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 Nov 2021 at 22:30, Jimmy Assarsson <extja@kvaser.com> wrote:
>
> On 2021-11-19 14:19, Jimmy Assarsson wrote:
> > Use the CAN_MHZ define when assigning frequencies.
>
> Maybe we should use the HZ_PER_MHZ define introduced in kernel 5.15 in
> linux/units.h. It also got defines for KILO and MEGA, which we also got
> in linux/can/bittiming.h.
>
> What do you think?

With the recent changes in linux/units.h, I am perfectly fine to
remove the CAN_MHZ, CAN_KBPS and CAN_MBPS macros from
linux/can/bittiming.h.

I am just bothered by the name of the macro HZ_PER_MHZ. Hertz per Mega
Hertz is a ratio without a unit. The clock speed is expressed in
hertz. So:

.frep = 80 * MEGA,
