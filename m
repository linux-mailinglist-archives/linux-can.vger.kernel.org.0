Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA27BA500
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbjJEQNa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbjJEQMV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:12:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3587AAF
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:28:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoImK-0004iL-1D; Thu, 05 Oct 2023 09:28:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoImJ-00BDDe-J3; Thu, 05 Oct 2023 09:28:11 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5097922F730;
        Thu,  5 Oct 2023 07:28:11 +0000 (UTC)
Date:   Thu, 5 Oct 2023 09:28:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 27/27] can: at91_can: switch to rx-offload implementation
Message-ID: <20231005-overfull-chirping-9900063427f4-mkl@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
 <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de>
 <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h5zkfusjw3m7wies"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--h5zkfusjw3m7wies
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.10.2023 21:55:41, Vincent Mailhol wrote:
> > @@ -638,7 +613,9 @@ static void at91_read_mb(struct net_device *dev, un=
signed int mb,
> >         else
> >                 cf->can_id =3D FIELD_GET(AT91_MID_MIDVA_MASK, reg_mid);
> >
> > -       reg_msr =3D at91_read(priv, AT91_MSR(mb));
> > +       /* extend timstamp to full 32 bit */
>                     ^^^^^^^^
>=20
> timestamp

fixed

> > +       *timestamp =3D FIELD_GET(AT91_MSR_MTIMESTAMP_MASK, reg_msr) << =
16;
>=20
> If I understand correctly, you only use the hardware timestamp for the
> napi but you do not report it to the userland.

ACK

> Not a criticism of this series, but it seems to me that it would be
> easy to add one follow-up patch that would populate
> skb_shared_hwtstamps->hwtstamp and update ethtool_ops->get_ts_info in
> order to report those hardware timestamps to the user.

Yes. I have proof-of-concept patches for it laying around, but I want to
get this mainline first. One limitation of the hardware is that the
timer is only 16 bits wide and runs on CAN clock, which means a maximum
of 1MHz. This causes the timer to overflow every 64ms, which in turn
requires a worker every 30ms or so. For this reason, I want hardware TS
to be configurable and this is not yet implemented. Also $CUSTOMER
doesn't need HW timestamps :)

> >         cf->len =3D can_cc_dlc2len(FIELD_GET(AT91_MSR_MDLC_MASK, reg_ms=
r));
> >
> >         if (reg_msr & AT91_MSR_MRTR) {
> > @@ -652,151 +629,12 @@ static void at91_read_mb(struct net_device *dev,=
 unsigned int mb,
> >         at91_write(priv, AT91_MID(mb), AT91_MID_MIDE);
> >
> >         if (unlikely(mb =3D=3D get_mb_rx_last(priv) && reg_msr & AT91_M=
SR_MMI))
> > -               at91_rx_overflow_err(dev);
> > -}
> > +               at91_rx_overflow_err(offload->dev);
>=20
> (...)
>=20
> This concludes my "review" of this series. Because I was scrolling
> through it and not doing anything thorough, I will not be giving my
> review-by tag even if there is a follow-up v2. That said, aside from
> my comment on patch 01/27 and the random typo nitpick, nothing seemed
> off.

Thanks for looking into it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h5zkfusjw3m7wies
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUeZYcACgkQvlAcSiqK
BOh+Nwf9FX7f+vHlDE6UQphmrq7jDKix7fMVWmg9ZgK2RjqpD2GzKdv6fXl1OxPX
P05iIvD27PcB/ZT7vROjMX1vJdfHgc4efQSjMEArNS2oKlmkhkFMQa0cjh8KNzld
QpVolQ5neEeaPrne4hxsLxtLdIb0Gz8ZsrSldVB+d3tLoImPlLc1EUFPCchYxraR
u9YtPl7PxMQfHPxfxkzwZ7i4eu+cvTv2+dZAL9u8nnFHZW/Mxuv9/ropH4Ksu0z/
gpqR3YPE4BKejm0OiGCB5QgqTM1s5M+ztTi7u2orrzVSRBQENqFEFEJNiAUqMHJX
dvE26BTAha/Ep345g5lRTZxYaGzuKQ==
=Ft0C
-----END PGP SIGNATURE-----

--h5zkfusjw3m7wies--
