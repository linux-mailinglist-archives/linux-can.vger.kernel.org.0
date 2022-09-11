Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6675B4C9C
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 10:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIKIYO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIKIYN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 04:24:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22AD27148
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 01:24:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3454b0b1b6dso66876277b3.4
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=vux7pfAjv8sP1swXZza1/dBq9SIr51zc78+4cJhkKmw=;
        b=Zpo1Zf+tJ/Q3OZnmdXweWmsCBNpfH+lTz0jkdE1YmUFGCBHdKT1zaztBhlK/EDFH46
         3KY+MP+m4XgH6jZ5E8y6earv7ODe9iObMoYR4Y8XofFJ5Y05bPwVodyqLUXY3AM5V0vH
         G/68JN4rqIkLX4b8XeOxaFfz6fNMG0dYZiq+wymwzjJLrVPeFq4gSBCRcTDI3x8ISQXP
         QwPbf2cRqa7nPxNNjqNfVZntpq5KG5eQXJ23jVVRKuOIhPDhg7XIYS9Es0UWmC+iaWth
         x9TMq065ahW25MHZ9M7QOrF9gg2Fly3U+ZvqSfeMMnNEYH6BWHf2sFhDfigUxqozPRYP
         rckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vux7pfAjv8sP1swXZza1/dBq9SIr51zc78+4cJhkKmw=;
        b=PtcvULOUlJYcwyS5Nw+Ziw1dYzxwOCu2PMDzo2Af/EFlmcmaK5z/a8TpgluouEwhl2
         gG/mjFblkeH9g1aXbL2Xi1tv4u/d36p8+bh5B89N3IWOG05mBy8nT1CBfD8JMCy5osav
         xYP76WDm2KX9BGYW0eF/36zWZuuBpd7vyE314xN1RqEtd/f5x83LW8Cg4naCCbx3YyYM
         xtMaFqpd6SH6nVCoIKrhyMaeAg5yv/KhGpDLGOeAgcVjcRspN7zwhZ+6WinsN+7KCj0v
         ybdxGb39iCZvpiKqA8JE+ovOG4hodoBZgoOM80ZwX+4poGW24V/bs0Mh675qAdUmYGsA
         uU5g==
X-Gm-Message-State: ACgBeo1Xzmu16W69JJ/uXsB/tU8UALkNeylhuo6QtLdwe93Km9tgzX8z
        lCWw6UzWh5xxqwUoR1fyWFWMYlcEJDNJgk3zQ+jSzqDA
X-Google-Smtp-Source: AA6agR69RGnkjpVgRK7Q2jrBUwPjkmCJ2I4IXn9pAeDSZLim2B4s3mIHhTv++703HQ5MJNdLcfkubZjWfeJsKjUMsmY=
X-Received: by 2002:a0d:c283:0:b0:335:7a81:f61e with SMTP id
 e125-20020a0dc283000000b003357a81f61emr17814006ywd.220.1662884652152; Sun, 11
 Sep 2022 01:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220907103845.3929288-1-mkl@pengutronix.de> <20220907103845.3929288-3-mkl@pengutronix.de>
In-Reply-To: <20220907103845.3929288-3-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 11 Sep 2022 17:24:01 +0900
Message-ID: <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of min3()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Mark Bath <mark@baggywrinkle.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 7 sept. 2022 =C3=A0 19:59, Marc Kleine-Budde <mkl@pengutronix.de> w=
rote:
> In can_calc_bittiming() there are several open coded checks to ensure
> that SJW is within certain limits. Replace this by a single call to
> min3().
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/calc_bittiming.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/c=
alc_bittiming.c
> index d3caa040614d..ce6bef2444a2 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -158,12 +158,8 @@ int can_calc_bittiming(const struct net_device *dev,=
 struct can_bittiming *bt,
>         if (!bt->sjw || !btc->sjw_max) {
>                 bt->sjw =3D 1;
>         } else {
> -               /* bt->sjw is at least 1 -> sanitize upper bound to sjw_m=
ax */
> -               if (bt->sjw > btc->sjw_max)
> -                       bt->sjw =3D btc->sjw_max;
> -               /* bt->sjw must not be higher than tseg2 */
> -               if (tseg2 < bt->sjw)
> -                       bt->sjw =3D tseg2;
> +               /* sjw must not be higher than sjw_max and tseg2 */
> +               bt->sjw =3D min3(bt->sjw, btc->sjw_max, tseg2);

Not directly a criticism of this patch (as things were already like
that), but if the user provides an incorrect value for SJW (or any
other bittiming argument), wouldn't it be better to inform? Returning
-EINVAL might be too violent. Maybe a dmesg would be good?


Yours sincerely,
Vincent Mailhol
