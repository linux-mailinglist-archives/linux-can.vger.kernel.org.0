Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9804EAE3D
	for <lists+linux-can@lfdr.de>; Tue, 29 Mar 2022 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiC2NUF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 09:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiC2NUE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 09:20:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E40135264
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 06:18:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j15so35054775eje.9
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWA6mlXiJvWNSWOj54sl/B0BQZznTOM9hbik+wtU45E=;
        b=kdPpJYVS6sKUqSSZkrLfPp9g0cP2qxTFPeQXSDlr4wZlDy9aJCdqhW3gr+KB3wVABR
         MiyrJEQaIBILgAnCiuGoBNVd+qjQKepVBmmV/oJ7fyIyX41CaxEso+MVgWUs2j6TzWcI
         9NrJ2MuXBK/85JZW5r4hKpmXEoV1bJrHblL83wA+sEMD5wlnTTl1JoeDlISGRAVb8+LW
         xjX7c1gMfNwF8PUOrQAabMlr36QUpAzlGZh848+Q3MJ+sXoNMByLMzm4R3ibQLn28Ur9
         hs44huT2qrXeg7o0jb8vLXpXop/040/6KYBW5sV2C1Go5IrIGIsyQKzf2GYYyKkQWHZY
         IeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWA6mlXiJvWNSWOj54sl/B0BQZznTOM9hbik+wtU45E=;
        b=oOYX2pNeloOWpMUH6stA4ZQjqYjFdCd+V8SkNJhbnFoa4EMr3AUvfRA0R9EtC3Ly3N
         4wwrhuipxPH6kHcm+9VzmH748QF0oQL/JT8F4tx7V6Aig8jmoM15/rjeAo+9yV0CcPlM
         qGnsTapGSB8KB9aXO7b+YVY48kMeLeeupL7MAqGH9+CphBP/uBV0I6E3auQq6Ck9SLAK
         WKMFtalgepFSLm4QvRSMguLlTs+RScjw8EUCOQ1K8SuHfD6RF00rO6xvX922NxI+XUre
         gstULkh5yJd5eDlySEw99PWdF3Ro1uBStOiIKllYFIhmeozO6Oj7DWYeL8r/zszKgs7M
         uZKw==
X-Gm-Message-State: AOAM5312jt1xrpkCZQAJog9Wa8tIrojjXgJ3RHxOtsoU18s4JYJKvg2E
        6d8N/wxzPzBmmDx5SScL752Jbc8oYd79OQGVFRrtN7i86WM=
X-Google-Smtp-Source: ABdhPJwIIdlAEt4bHMGZGZ7EIDlGY0/cF7iBWK8eBqQ1fmf/2y7/XRXrFPwAjqgYk0MxmOlrQyVUV4ErYQvA011szS0=
X-Received: by 2002:a17:906:d554:b0:6df:a6f8:799a with SMTP id
 cr20-20020a170906d55400b006dfa6f8799amr34289133ejc.492.1648559893859; Tue, 29
 Mar 2022 06:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220303225525.29846-1-kris@embeddedTS.com> <CAMRc=McesjKviO=5gK3GN+XukZfSr=um9W8+sqXw9GSFX0QTgw@mail.gmail.com>
 <1648489760.3393.6.camel@embeddedTS.com> <20220328175857.dvmvh5knabc6sq3x@pengutronix.de>
In-Reply-To: <20220328175857.dvmvh5knabc6sq3x@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Mar 2022 15:18:03 +0200
Message-ID: <CAMRc=MdZm1HU3vZcYK=cStmCE6+tQ6R4-ya5t3ZRovf0RZHJQQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: Fix Links to Technologic Systems web resources
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Kris Bahnsen <kris@embeddedts.com>,
        Linus Walleij <linus.walleij@linaro.org>, wg@grandegger.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Mar 28, 2022 at 7:58 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 28.03.2022 10:49:20, Kris Bahnsen wrote:
> > On Fri, 2022-03-04 at 08:24 +0100, Marc Kleine-Budde wrote:
> > >
> > > For the CAN part:
> > >
> > > Acked-by: Marc Kleine-Budde
> > >
> > > regards,
> > > Marc
> >
> > On Mon, 2022-03-07 at 10:22 +0100, Bartosz Golaszewski wrote:
> > >
> > > For GPIO
> > >
> > > Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > >
> >
> >
> > Inquiring about the status of this patch. I have not seen it show up in
> > any repositories. Is there any other action I need to take at this time?
> > Apologies if this time frame is normal for such a low priority patch, I
> > am not sure what to expect. Thanks!
>
> I'm taking the CAN part. I think it's best to repost the GPIO part as a
> separate patch.
>

Yes please, and for the future: if possible separate such changes into
patches aimed at different maintainers.

Bart
