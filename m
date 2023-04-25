Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE06EE8D8
	for <lists+linux-can@lfdr.de>; Tue, 25 Apr 2023 22:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjDYUK0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Apr 2023 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjDYUKU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2023 16:10:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44C1544D
        for <linux-can@vger.kernel.org>; Tue, 25 Apr 2023 13:10:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fc94476e2so74447487b3.1
        for <linux-can@vger.kernel.org>; Tue, 25 Apr 2023 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682453417; x=1685045417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajM0LwQkx5V/I2/UibvsrZZndqIviz/M9DBiru/mXQg=;
        b=dTvvZyFpBT/vP4cJvDwecqbyU3C1xxDniswbOHTFkvd0pEIf0axd4MmboZLWTzEgH9
         muG1HEnAOXQVlKjiu6CWR/NK5EL8p/F4SqMJPUKKJbRxmitYmgvkaCysoxwKpcvlAU7n
         UPXVEZFigyrCV9ZpEjJDoinTLybvaQr+AdOmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682453417; x=1685045417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajM0LwQkx5V/I2/UibvsrZZndqIviz/M9DBiru/mXQg=;
        b=Jg9CxRKHuxXVu8ZvykWRTMsjJqO/7VbvplmJ7REMgG0fjEiSvaxrfq2cTXBy4u8ETT
         RfFqXLDfMpiHsQnRrrULgYYH3PZM/kODSsI87kY3fydlmHaOM9UHlsHdywUjeiSX1k/z
         ePzwLX6pxG3tZaHRItf/bAniBs0Fc54j5TcY3KPItYaai1xtGtbYfO5tl1ow1UYtLRvd
         b0iMKHROX5kvM9ZMTk1PEfkcdqIMAgn85AN7ExLWaTYek/fYiUTn02+rmpHy/UM3Risj
         YEO5OI/jw1eqVG67n1FJOpcEaV+bl/NAQla87dStHBfupca99mQLwBhMTdKj3p+TUPWH
         eNnQ==
X-Gm-Message-State: AAQBX9froFm1m9JL9NLzyMz42RC/4FpwHOxsscqlaVE6tyAqYDKECbEJ
        tYTkdGTB5miiQupKXHbXwgitJjSLrwwvBdnfSFlWhg==
X-Google-Smtp-Source: AKy350aQ40+4HpZ6RTwx6wGwaL/ZQkmDudx4fSWnKEsjw/eI3Ll2kkGSGGDzzDshudDy4AnnqGlIXyWsPZ8R7tXg9+w=
X-Received: by 2002:a81:6742:0:b0:54c:b26:b0e with SMTP id b63-20020a816742000000b0054c0b260b0emr11871415ywc.25.1682453416722;
 Tue, 25 Apr 2023 13:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230423172528.1398158-1-dario.binacchi@amarulasolutions.com>
 <20230423172528.1398158-5-dario.binacchi@amarulasolutions.com>
 <20230423-surplus-spoon-4e8194434663-mkl@pengutronix.de> <CABGWkvqA2hwgfGvVWS08Qu-2ZUbwc82ynhvq8-FqFuhHoV-vhw@mail.gmail.com>
 <20230424-fracture-going-5dcaf06a9e6c-mkl@pengutronix.de>
In-Reply-To: <20230424-fracture-going-5dcaf06a9e6c-mkl@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Tue, 25 Apr 2023 22:10:05 +0200
Message-ID: <CABGWkvp+ffrHgOVF48Zug+b4MfTbsQeCkiKDUAMm+M3NHwutJg@mail.gmail.com>
Subject: Re: [PATCH 4/4] can: bxcan: add support for single peripheral configuration
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Apr 24, 2023 at 12:06=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:
>
> On 24.04.2023 08:56:03, Dario Binacchi wrote:
> > > This probably works. Can we do better, i.e. without this additional c=
ode?
> > >
> > > If you add a syscon node for the single instance CAN, too, you don't
> > > need a code change here, right?
> >
> > I think so.
> >
> > I have only one doubt about it. This implementation allows,
> > implicitly, to distinguish if the peripheral is in single
> > configuration (without handle to the gcan node) or in double
> > configuration (with handle to the gcan node). For example, in single
> > configuration the peripheral has 14 filter banks, while in double
> > configuration there are 26 shared banks. Without code changes, this
> > kind of information is lost. Is it better then, for future
> > developments, to add a new boolean property to the can node of the dts
> > (e.g. single-conf)?
>
> The DT ist not yet mainline, so we can still change it. Another option
> is to have "st,can-primary" and "st,can-secondary" for the shared
> peripherals and nothing for the single instance.

I did some tests following your suggestion. It is however necessary to
make some small changes to the driver.
I will send v2 as soon as possible.

Thanks and regards,
Dario

>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
