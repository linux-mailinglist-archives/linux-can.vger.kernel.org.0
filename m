Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC327F644
	for <lists+linux-can@lfdr.de>; Thu,  1 Oct 2020 01:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgI3Xsm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 19:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgI3Xsl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 19:48:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9EC061755
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2020 16:48:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so3463093qke.13
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2020 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LPdb74S4jauVVLUsGZ/UYTN0rjjvjELxWrN8cAyg2gg=;
        b=XFbgbRH4EcEHjoSpFw3ynPiFhqNa5WbBuQroh4Oz8hsDn4Q/pWnNYbaNRZotSgI4hS
         wliCiRYxbViqhpH27I7Zp8V3nX5QOXjI0n5CR6I+TGjio6w90EORBTBScvZAauQu8v1v
         OVZjqn3QB5Tter11pbR7hjwHojncFY8uZ/7HvwiJnTqpD7k6KUTNwketAXzLajRuKY6n
         qHdlknEqmHniBe69Vq74ppNEVrPcc4brnpy5tjTsK3whtkflHTGnRrXNG+hlSEb0QoFz
         CVIv3Ig9i+NIoGUFimEIo7g55NO4az8KqH3lY9mdK9MpsU+dwiVW0OPN63VrbPlE6Knq
         wvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LPdb74S4jauVVLUsGZ/UYTN0rjjvjELxWrN8cAyg2gg=;
        b=hXJJkfaYMxnlL8epcxAJYAy+QJe8Ts9fVLX7Jjr5i2jYF5pwm/FuBczMqs4R0w3R2P
         7FlzXQV8CFXIWVZSQ0ycKBvPVjjxWHPPdLjrHQp/7SyLOfHumOu3bn+ABmOp6ONSMStq
         60GpcRobo88VJ8Pxowcg+6rgC7XtUiLiZJYO+teU1y7nTcjGvSqNv6eR1EwVyknynXe6
         Uf48GpeXnRfmo0CDg0kXrOzQsW+dw30OZE07SkPe3H05chm6DgIQroFWtDquQr0xC2/c
         Y9y74fR9C2awuSYR4DbWCBGatSFkoq43DUlbAyv+lUfVldge8pAhCJudBIari6DdoHL+
         8D2w==
X-Gm-Message-State: AOAM533JOuQmYoLwC1whi9cCLkiM1XfyJtSTRmKtBlJi9IH/vthKK9ak
        BOTKWOCqb+qstZ0B5RBqg2zH81t6OojOKkcBAu9RbuRqTqk=
X-Google-Smtp-Source: ABdhPJw90X53NqVcik+t4nYlRRJMs+4Ul7/2xlCT98WGqL924tePMSLy5PCrQBWtkzC10TuSsKrHVCwzCBaholsK0UU=
X-Received: by 2002:a37:e311:: with SMTP id y17mr4999031qki.153.1601509720442;
 Wed, 30 Sep 2020 16:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200728090736.7628-1-s.grosjean@peak-system.com> <VI1PR03MB50536800A01EB17C97D9B6BDD62F0@VI1PR03MB5053.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR03MB50536800A01EB17C97D9B6BDD62F0@VI1PR03MB5053.eurprd03.prod.outlook.com>
From:   =?UTF-8?Q?Fabi=C3=A1n_Inostroza?= <fabian.inostroza.p@gmail.com>
Date:   Wed, 30 Sep 2020 20:48:29 -0300
Message-ID: <CAArkK-czkq_qg=V+mfoCJHxAoKLGTgp-nM2GPheVT6L5+==Z1A@mail.gmail.com>
Subject: Re: [PATCH] can/peak_usb: fix timestamp wrapping
To:     =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ping

Fabi=C3=A1n Antonio Inostroza Paredes
Ingeniero Civil Electr=C3=B3nico
Fono: +56962243036


On Wed, Sep 2, 2020 at 7:44 AM St=C3=A9phane Grosjean
<s.grosjean@peak-system.com> wrote:
>
> Hi Marc,
>
> Any news about that patch?
>
> ---
> St=C3=A9phane Grosjean
> PEAK-System France
> 132, rue Andr=C3=A9 Bisiaux
> F-54320 MAXEVILLE
> T=C3=A9l : +(33) 9.72.54.51.97
>
>
> De : Stephane Grosjean <s.grosjean@peak-system.com>
> Envoy=C3=A9 : mardi 28 juillet 2020 11:07
> =C3=80 : linux-can Mailing List <linux-can@vger.kernel.org>
> Cc : St=C3=A9phane Grosjean <s.grosjean@peak-system.com>
> Objet : [PATCH] can/peak_usb: fix timestamp wrapping
>
> Fabian Inostroza <fabianinostrozap@gmail.com> has discovered a potential
> problem in the hardware timestamp reporting from the PCAN-USB USB CAN
> interface (only), related to the fact that a timestamp of an event may
> precede the timestamp used for synchronization when both records are part
> of the same USB packet. However, this case was used to detect the wrappin=
g
> of the time counter.
>
> This patch details and fixes the two identified cases where this problem
> can occur.
>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 51 ++++++++++++++++++--
>  1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index 0b7766b715fd..267ddc18ed51 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -130,14 +130,55 @@ void peak_usb_get_ts_time(struct peak_time_ref *tim=
e_ref, u32 ts, ktime_t *time)
>         /* protect from getting time before setting now */
>         if (ktime_to_ns(time_ref->tv_host)) {
>                 u64 delta_us;
> +               s64 delta_ts =3D 0;
> +
> +               /* General case: dev_ts_1 < dev_ts_2 < ts, with:
> +                *
> +                * - dev_ts_1 =3D previous sync timestamp
> +                * - dev_ts_2 =3D last sync timestamp
> +                * - ts =3D event timestamp
> +                * - ts_period =3D known sync period (theoretical)
> +                *             ~ dev_ts2 - dev_ts1
> +                * *but*:
> +                *
> +                * - time counters wrap (see adapter->ts_used_bits)
> +                * - sometimes, dev_ts_1 < ts < dev_ts2
> +                *
> +                * "normal" case (sync time counters increase):
> +                * must take into account case when ts wraps (tsw)
> +                *
> +                *      < ts_period > <          >
> +                *     |             |            |
> +                *  ---+--------+----+-------0-+--+-->
> +                *     ts_dev_1 |    ts_dev_2  |
> +                *              ts             tsw
> +                */
> +               if (time_ref->ts_dev_1 < time_ref->ts_dev_2) {
> +                       /* case when event time (tsw) wraps */
> +                       if (ts < time_ref->ts_dev_1)
> +                               delta_ts =3D 1 << time_ref->adapter->ts_u=
sed_bits;
> +
> +               /* Otherwise, sync time counter (ts_dev_2) has wrapped:
> +                * handle case when event time (tsn) hasn't.
> +                *
> +                *      < ts_period > <          >
> +                *     |             |            |
> +                *  ---+--------+--0-+---------+--+-->
> +                *     ts_dev_1 |    ts_dev_2  |
> +                *              tsn            ts
> +                */
> +               } else if (time_ref->ts_dev_1 < ts) {
> +                       delta_ts =3D -(1 << time_ref->adapter->ts_used_bi=
ts);
> +               }
>
> -               delta_us =3D ts - time_ref->ts_dev_2;
> -               if (ts < time_ref->ts_dev_2)
> -                       delta_us &=3D (1 << time_ref->adapter->ts_used_bi=
ts) - 1;
> +               /* add delay between last sync and event timestamps */
> +               delta_ts +=3D (signed int)(ts - time_ref->ts_dev_2);
>
> -               delta_us +=3D time_ref->ts_total;
> +               /* add time from beginning to last sync */
> +               delta_ts +=3D time_ref->ts_total;
>
> -               delta_us *=3D time_ref->adapter->us_per_ts_scale;
> +               /* convert ticks number into microseconds */
> +               delta_us =3D delta_ts * time_ref->adapter->us_per_ts_scal=
e;
>                 delta_us >>=3D time_ref->adapter->us_per_ts_shift;
>
>                 *time =3D ktime_add_us(time_ref->tv_host_0, delta_us);
> --
> 2.25.1
>
>
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183
> Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
> Unsere Datenschutzerklaerung mit wichtigen Hinweisen
> zur Behandlung personenbezogener Daten finden Sie unter
> www.peak-system.com/Datenschutz.483.0.html
>
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183
> Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
> Unsere Datenschutzerklaerung mit wichtigen Hinweisen
> zur Behandlung personenbezogener Daten finden Sie unter
> www.peak-system.com/Datenschutz.483.0.html
