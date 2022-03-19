Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931D94DE934
	for <lists+linux-can@lfdr.de>; Sat, 19 Mar 2022 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbiCSQGD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Mar 2022 12:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiCSQGB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Mar 2022 12:06:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6AA1D2532
        for <linux-can@vger.kernel.org>; Sat, 19 Mar 2022 09:04:40 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nVbZF-0003va-HR; Sat, 19 Mar 2022 17:04:37 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-5e0d-31a6-08b1-9333.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:5e0d:31a6:8b1:9333])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B50084F322;
        Sat, 19 Mar 2022 16:04:35 +0000 (UTC)
Date:   Sat, 19 Mar 2022 17:04:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org, Srinivas Neeli <sneeli@xilinx.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: bittiming: can_calc_bittiming(): prefer small bit
 rate pre-scalers over larger ones
Message-ID: <20220319160435.fzjqtpjxbmce4c4z@pengutronix.de>
References: <20220318144913.873614-1-mkl@pengutronix.de>
 <202203191346.42561.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gv4altgetdapz6ua"
Content-Disposition: inline
In-Reply-To: <202203191346.42561.pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gv4altgetdapz6ua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.03.2022 13:46:42, Pavel Pisa wrote:
> On Friday 18 of March 2022 15:49:13 Marc Kleine-Budde wrote:
> > The CiA (CAN into Automation) lists in their Newsletter 1/2018 in the
> > "Recommendation for the CAN FD bit-timing" [1] article several
> >
> > recommendations, one of them is:
> > | Recommendation 3: Choose BRPA and BRPD as low as possible
> >
> > [1]
> > https://can-newsletter.org/uploads/media/raw/f6a36d1461371a2f86ef0011a5=
1371
> >2c.pdf
> >
> > With the current bit timing algorithm Srinivas Neeli noticed that on
> > the Xilinx Versal ACAP board the CAN data bit timing parameters are
> > not calculated optimally. For most bit rates, the bit rate
> > prescaler (BRP) is !=3D 1, although it's possible to configure the
>=20
> I have already thought about algorithm and optimal number of bitquanta
> per bittime. In the fact, I think than original LinCAN algorithm version
> which I have provided for SocketCAN used reversed preference for BPR.

It's complicated, at least for all evolutions of the algorithm we had in
the Linux kernel.

Side note: I've imported all Linux mainline algorithms into the
           can-calc-bit-timing tool available on my github:
           https://github.com/marckleinebudde/can-utils/tree/improve-can-ca=
lc-bit-timing
           Use the "--algo=3D" parameter to select the actual algorithm.
           Use diff to compare the bit timing:
           diff -u <(./can-calc-bit-timing --alg=3Dv2.6.31 mcan-v3.1+) <(./=
can-calc-bit-timing --alg=3Dv4.8 mcan-v3.1+)

For CAN bitrate/CAN clock rate/bit timing constant parameter
combinations where exact solutions are possible (no bit rate error and
no sample point errors are possible), the original algorithm will select
the solution with the lowest BRP. However, where exact solutions are not
possible, it will prefer those with larger BRP. With my proposed fix,
the behavior in the same for both cases.

> But I think that too small or too big ratio is bad.

It's complicated.

Valid solutions with the same (even optimal) bit rate and sample point
but with different BRPs are not equal. Why? All evolutions of the
algorithm use a default SJW of 1 (if no value if provided by the user -
the original algorithm even forces a fixed value of 1).

SJW =3D=3D 1 means the SJW has the length of one Time Quanta (TQ). The leng=
th
of a TQ directly depends on the BRP:

    TQ =3D BRP / CAN Clock Frequency

This results in the SJW measured in time units, is not the same for
different BRPs and thus not the same for valid bit timing parameters
with different BRPs. So your statement is correct, at least while using
a fixed SJW =3D=3D 1.

But, for CAN-FD we should use the same BRP for the arbitration and
data bit timing parameters. Why is that the case?
- Some controllers use the same BRP for the arbitration and the data bit
  timing.
- Different BRPs can result in a phase error when switching from
  arbitration to data bit timing
- For Transceiver Delay Compensation (TDC) to work, both BRPs must be 1.
  Although some controllers support 2, aswell.
- The CiA recommends it. See Recommendation 2:
  https://can-newsletter.org/uploads/media/raw/f6a36d1461371a2f86ef0011a513=
712c.pdf

> So for our actual NuttX ESP32C3 driver developed by our studnet Jan
> Charvat, I consider to add some mechanism how to specify optimal
> bitquanta per bittime ratio.

As elaborated above, this indirectly influences the size of the SJW. The
CiA has also a recommendation regarding SJW (same paper as above):

| Recommendation 5: Chose sjw D and sjw A as large as possible
|
| The maximal possible values are min(ps1 A/D, ps2 A/D). A large sjw A
| value allows the CAN node to resynchronize quickly to the transmitting
| node. A large sjw D value maximizes the CAN clock tolerance.

> The question is if that should be additional parameter in the struct
> can_bittiming_const
>=20
>   https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can/n=
etlink.h#L47
>=20
> or if that should be some constant defined for data bitrate and
> probably the second for arbitration bitrate.

The struct can_bittiming_const is user space API and cannot be changed.
If we need more parameters we would first convert the struct
can_bittiming_const based netlink type into a nested type. The nested
type then can be extended at will without breaking the API.

But this is independent if the enhancement of the bit timing algorithm.

> If there is interrest I try to provide some patch which would prefer
> the nearest suitable BPR to optimal timequanta to bittime ratio.

I'm really interested in your thoughts and patches. For easier testing,
I'm developing the algorithm in the can-calc-bit-timing tool, it can
easily be extended for more variants. Feel free to add a new variant.
Send me a PR on github or patches on this list.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gv4altgetdapz6ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI1/xAACgkQrX5LkNig
011EHQgAlB/uLsBIeebtkGHEJ48/foe7Qm+ZQ365KYFNTx8cRG4f1A5oB1OXo0n0
TrVvFrkjkcp+QklZOvAP8EybTaIgTK7la0TIqX1qRE1DiZormoCDMPW5f3qoT9h2
B/opZS4FGjwIoNu1TCKbGGFavOEyQwJbtmJ8a0OOXV8iq7cPDNP3krc+zQlpGWfs
X7WgjJEwWmaQ1m8Ph+9Zs2YpmNJwXeiuy6KTo6pvf9fNTf7OvaCAfY4CYym5WS36
msEatkRA7bvdVvqaVZTNm0NTzbHuR6XzSnA6qH3wqAbw8dSqR3ArtV4EqIr5Lc0n
3EyW4gcHBVxi20R1hPogKXMAIiZJ0w==
=WEIT
-----END PGP SIGNATURE-----

--gv4altgetdapz6ua--
