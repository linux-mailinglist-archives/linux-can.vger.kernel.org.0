Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B751EB23
	for <lists+linux-can@lfdr.de>; Sun,  8 May 2022 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiEHC4W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 7 May 2022 22:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358287AbiEHC4U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 7 May 2022 22:56:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96719658F
        for <linux-can@vger.kernel.org>; Sat,  7 May 2022 19:52:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g6so20947724ejw.1
        for <linux-can@vger.kernel.org>; Sat, 07 May 2022 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=motec-com-au.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jVDkHUl1fqfqQLGFjqvBHj+kZDZmLfom5JvGNbdgg4=;
        b=m1so14Tb9iGfnhOfA1ik+03YVB1S3j147piYsa2vFeyo2Nqm8ZTKxhkfyf+pX/z3mU
         pWojsoRO1A5A7FQqUQ/XmvRcxtEE7crXdEuMGNvLMkUz8St272ImE2jSBFXMDBfp68V1
         4+vJAbkTKSw00DeAmYdQ2WqLkwI6CuwNU/zUz+5qzlZNioJpbPR2FhDgy021JN5remtq
         PUO+ZPr3phvbIKuGAmPgCFdsjto7cmZoPQf7UaQZ7O7J/juGFOn/pRLxC20mW/WIO+41
         cGAs+2NoEcvFPFikdahqRk/iAltpdlP5pW2xTgUwGKMxsmHWlxQFSEMUOpebEiLAQb2r
         r2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jVDkHUl1fqfqQLGFjqvBHj+kZDZmLfom5JvGNbdgg4=;
        b=YeKOK4ZGhHgSJSJpjSNvRzDkS8kiXW4n9RxsNpBFwoemrZfbmK5gRhMOk8HaaYCpoE
         nPH1keREJqh8CQv1DJRsTBiOhKBsdoODso94Ef3fH5hdI/aQGW+GPuhx55CPU1YT4zNY
         LNhZA4Jc4gQTorHxFalUlMDQJHTsH2kttmllpjxdxwFLZ8wuCFVlCJwEl13D2nUfRzHk
         GL/iLfKW7XrOpzOlVZ5D47xwHKod5lEjvOD5qBcYys5BtVPcFm8R3pxbE43WksqOgDUZ
         UIWESejkqWc/UH7bePLPGVdXJOwDmA5x+BCDJ0WtVOKaHvhH+/r6u6Jxl14jN7tamLjN
         8jTQ==
X-Gm-Message-State: AOAM531ob47eKgsyCwPgWvhGoWgzr0yXWsVF6G8wVel5Iv2w/pSCCj7i
        J+K+aDsGk8nQ/DsztqmOQYt6gCsuwaKnSlqlfZLPKw==
X-Google-Smtp-Source: ABdhPJxMbGSVhfTCHkAolesSJEG0JlP8qpbg27wSzY2JDrLJrrvEJV+0BSSKyCpSOCwrH3RxO//nmdh0xi96rdz6/+o=
X-Received: by 2002:a17:907:7fa8:b0:6f3:e975:abfa with SMTP id
 qk40-20020a1709077fa800b006f3e975abfamr9336479ejc.86.1651978348179; Sat, 07
 May 2022 19:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1650816929.git.pisa@cmp.felk.cvut.cz> <CAHQrW0_bxDyTf7pNHgXwcO=-0YRWtsxscOSWWU4fDmNYo8d-9Q@mail.gmail.com>
 <20220503064626.lcc7nl3rze5txive@pengutronix.de> <202205030927.15558.pisa@cmp.felk.cvut.cz>
 <20220503085506.d5v4xtpumr7gm7hy@pengutronix.de> <CAA7ZjpbzaSiX6jbV5B88_VqqJga=9y0Kf_Z77Q4DN-5YfQFy0g@mail.gmail.com>
In-Reply-To: <CAA7ZjpbzaSiX6jbV5B88_VqqJga=9y0Kf_Z77Q4DN-5YfQFy0g@mail.gmail.com>
From:   Andrew Dennison <andrew.dennison@motec.com.au>
Date:   Sun, 8 May 2022 12:51:52 +1000
Message-ID: <CAHQrW08jAYde-S_pk3QVdvCzGbeg5TL=wJbGBC4euHx6rowewg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] can: ctucanfd: clenup acoording to the actual
 rules and documentation linking
To:     Ondrej Ille <ondrej.ille@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Carsten Emde <c.emde@osadl.org>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Matej Vasilevski <matej.vasilevski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 8 May 2022 at 01:51, Ondrej Ille <ondrej.ille@gmail.com> wrote:
>
> Hello all,
>
> again, sorry for the late reply, my daily job keeps me very busy, and the vision of completely new silicon
> coming to our office if we meet a tape-out date is somehow motivating :)
>
> Just few notes about the discussion:
>
> 1. Number of TXT Buffers
> I agree that driver should read-out this information from the HW, not rely on fixed configuration.
> True, the default value in HW master is 2, but Linux driver had 4 hard-coded. This was coming from
> times when there were only 4 buffers (no genericity in the HW). IMHO this is HW bug, because the
> intention when doing the "arbitrary number of buffers" extension, was to keep default value the
> same as in previous implementation. System architecture document also has "4" as value of txt_buffer_count generic.
>
> I will fix this ASAP in the master branch, hopefully regression will not complain so that the current driver
> version is compatible with default HW.
>
> As per reading out number of TXT Buffers from HW, Pavel proposed moving TXTB_INFO else-where
> so that there is more space for TX_COMMAND in the same memory word. The rationale here, is having
> reserve in case of an increasing number of TXT Buffers.
>
> But, with the current format of TX_COMMAND, the reserve would be up to 24 TXT Buffers. Even if there
> ever was a use-case for more than 8 buffers, there would need to be another non-compatible changes
> in TX_PRIORITY and TX_STATUS, and the whole register map would anyway not be backwards compatible...
> So, I propose to keep TXTB_INFO in its current location.

Hi Ondrej,

Based on this it seems my patches can be cleaned up for merging.

Pavel / Odjrej: did you want to include the patches in your public
driver tree and submit from there, or shall I submit them? Adding to
yoru tree would keep it in sync with the upstream driver already
submitted. If you provide a review I'll cleanup any issues reported. I
can submit directly to Linux as Marc proposed but having a single
authoritative source seems cleanest to me.

My current patches are on master in this tree:
https://github.com/AndrewD/ctucanfd_ip_core

I'll add "Signed-off-by: " to the commit messages next time I touch
this - once I get clarity on the way forward. I don't have an
immediate need for a Linux driver for ctucanfd so haven't touched this
recently.

Kind regards,

Andrew
