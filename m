Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE25832BA
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiG0TEU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 15:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiG0TD4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 15:03:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199BEE0D6
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 11:24:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w15so20244566lft.11
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vL7EoqpI4lKSE3qyUKejNa9PK7FcLQ1k4CrPc9ppH8=;
        b=kaRm4XcmzL6e3DzQTCqflXlvJzeVOnszfnnDBuQtbW30apR0+pyoZ5fv817ZiBo137
         Ei8myBVgM8CUH2trnY2HnymqbxH8VjrqG2FpV632z5vGmLd/tcD4wYRIBKozANNtI+Vd
         AZaYQghgyw95cLii3QrLZpPXGMMKG4rrRuQuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vL7EoqpI4lKSE3qyUKejNa9PK7FcLQ1k4CrPc9ppH8=;
        b=LyhuTtko5Nc78yRBd8pE2+Dj83NdPUDh8vtBcMkd7ZKg0ySbx/EqAqznbCClK7ftH7
         TcLuph8rUa25OGqu4sQCsiNLwl5cxOl/GU9regHwz1qEyS/Yqake6ChpuxW2jE7PMRW4
         Z9r9ZE6Yc/jYLj4NzGryiVVX2GkFtCFTqIFcq+Q41qjHnScC0S8ygPn0LUvBTmLcuDOm
         1H5lTe0Cp4DEDjVOE7ll6akPtwTYN8MfNwgZY9XF6mwF+IflCWUX1l8s0ey1/tdQA7Lj
         sOXR62zMYlRgRd+5Jo3qEkqvxwxERGRwoujUWzdcxy4jtRQXvzgFvX2D7nx34v+yN+Oz
         m8Ag==
X-Gm-Message-State: AJIora9m1wR/6k/7r6XI4Gfrpy/YIRf/xSgzZitrgxLYIDcqD6s2oc5o
        LsjW8Rh8DfDfRBV3jvkk7qZnibSRweR8oPKygLPsxA==
X-Google-Smtp-Source: AGRyM1tj4Ud/EKZcoMAxTTfeUBq2RnGDR/fRxao16WOSUdQN/KXsA49da0eQZ0DPAfuKOcC/Flr8EraM05lpOrAwXSY=
X-Received: by 2002:a19:ca5d:0:b0:48a:74a6:2f10 with SMTP id
 h29-20020a19ca5d000000b0048a74a62f10mr8891932lfj.153.1658946241048; Wed, 27
 Jul 2022 11:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
 <20220726210217.3368497-9-dario.binacchi@amarulasolutions.com>
 <20220727113054.ffcckzlcipcxer2c@pengutronix.de> <CABGWkvrmbQcCHdZ_ANb+_196d9HsAxAHc4QS94R19v5STHcbiA@mail.gmail.com>
 <20220727172101.iw3yiynni6feft4v@pengutronix.de> <CABGWkvqF4HSKVrO8W8oyDPCMfx_B2xQZ_EWET11RZb6k8Kmb=w@mail.gmail.com>
 <20220727193313.71d54ce0.max@enpas.org>
In-Reply-To: <20220727193313.71d54ce0.max@enpas.org>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 27 Jul 2022 20:23:50 +0200
Message-ID: <CABGWkvrTga4yyx0Fh99NKkj4vJPy_goOAFGaB1BCj6xONqBCAg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 8/9] can: slcan: add support to set bit time
 register (btr)
To:     Max Staudt <max@enpas.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        netdev@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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

Hello Marc and Max,

On Wed, Jul 27, 2022 at 7:33 PM Max Staudt <max@enpas.org> wrote:
>
> On Wed, 27 Jul 2022 19:28:45 +0200
> Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:
>
> > On Wed, Jul 27, 2022 at 7:21 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > >
> > > Ok - We avoided writing bit timing registers from user space into the
> > > hardware for all existing drivers. If there isn't a specific use case,
> > > let's skip this patch. If someone comes up with a use case we can think
> > > of a proper solution.
> >
> > Ok. So do I also remove the 7/9 "ethtool: add support to get/set CAN
> > bit time register"
> > patch ?
>
> If I may answer as well - IMHO, yes.
>
> Unless we know that BTR is something other than just a different way to
> express the bitrate, I'd skip it, yes. Because bitrate is already
> handled by other, cross-device mechanisms.

Thanks to both of you for the explanations.
Regards,

Dario

>
>
> Max

-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
