Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635658989E
	for <lists+linux-can@lfdr.de>; Thu,  4 Aug 2022 09:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiHDHpW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Aug 2022 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiHDHpV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Aug 2022 03:45:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEB46157
        for <linux-can@vger.kernel.org>; Thu,  4 Aug 2022 00:45:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y23so10925084ljh.12
        for <linux-can@vger.kernel.org>; Thu, 04 Aug 2022 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ororatech.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dhLsCRYGUtuAwALD1KlxKTdhkhp8QSNYwM9InIv21hY=;
        b=vhFbtTOGOksHyzcro9kH4cZHaorB7nfGcWpikpO7dNKwncnTRw1+ByiMFJe/2elMHX
         b7OFjEv9TqgTOdb2zsflnf724l7IR7GO9J3muH/4h9jAjKaDV06uAda+3eRlck9Jm8fU
         N1FdUO8DhuA0L5atc+KdjD8fiwIjd10nsD5xvo8yOopR+hvLU+gT8/ZsGbBGbSPQGPkR
         kFaHhPAqmEtHB61cFq/nc59DDMptgPmfVJayemcGQqG1wEx9CUFQBwl1NCvkklilW4zn
         pPID1KoWR/K7YAtLuEiitRb61GcgIiFrb7XQ5x7X9gM+xOVBccR96aiQBOxUOmkOmO+D
         DqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dhLsCRYGUtuAwALD1KlxKTdhkhp8QSNYwM9InIv21hY=;
        b=NAOaHO2Ji87P5ZvscXk+08tjJbL7DGa6hVLhnm2jK0LtUnNsN60Lnmo3rQHCMUTsnm
         ylpciUalOGNS/HRneLnBYo5netbeQX4s4IQsmlv5odB/Xxquqvle53jiQwlTV0Vdqagr
         Oqj5ezbhqpxKzS0lH7S/hX0VuSzD1+HwnV18FTkMwmQ83So7qRfxz4ss9B8W+NnAhlvu
         xMegcFyvSsBvFvMTfcfBAWFBJK2GYJgooFlNBx4aG4BE2wsJBi6ArhuV9QwnioBBIYoS
         gSqVJKMUNDbwDOuF9yaIeZtzmG4ec8K1sisewI3W3Vj1+uJcuyuYn1n8fXqn8IMR2tL/
         nK7w==
X-Gm-Message-State: ACgBeo3EpmfWiakIGGDsmhw2kPESbYxJLSmdutC3hfnqi7Jjj/GYJ+Ir
        HxjrSns8fCYs5FCTkRxoUj2IKBeJjSwmgKndYwvYLg==
X-Google-Smtp-Source: AA6agR5Sj3szcvbsmwN7u+7x18QMzCdlRlPvPZm74RpikcBlNUt3W+A0c8kDn0SglEOtyhPijnOp/MbeyjstLRROdpA=
X-Received: by 2002:a2e:9e55:0:b0:25d:e795:d852 with SMTP id
 g21-20020a2e9e55000000b0025de795d852mr191846ljk.367.1659599118481; Thu, 04
 Aug 2022 00:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220803185910.5jpufgziqsslnqtf@pengutronix.de>
 <20220804064803.63157-1-sebastian.wuerl@ororatech.com> <20220804070603.s3llvccpldtkejln@pengutronix.de>
In-Reply-To: <20220804070603.s3llvccpldtkejln@pengutronix.de>
From:   =?UTF-8?Q?Sebastian_W=C3=BCrl?= <sebastian.wuerl@ororatech.com>
Date:   Thu, 4 Aug 2022 09:45:07 +0200
Message-ID: <CA+KjhYWukGxZUMMch_vFe=TNYCD0-jmuwO2520oUVDPE2kE1Rw@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251x: Fix race condition on receive interrupt
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Christian Pellegrin <chripell@fsfe.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Aug 4, 2022 at 9:06 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Another optimization idea: Do we need to re-read the eflag1? "eflag" is
> for error handling only and you're optimizing the good path.

I'd argue if a new message entered mailbox 1, this also potentially
changed the error state, so we need to read it.

Thanks a lot for your feedback! Will post v3 soon.

Also I'm sorry for spam in anyones inbox, I didn't get my mailing
program to produce plain-text for the last mail.

best,
Sebastian
