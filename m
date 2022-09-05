Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365315AD6F2
	for <lists+linux-can@lfdr.de>; Mon,  5 Sep 2022 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiIEPy3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Sep 2022 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiIEPyZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2022 11:54:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED74D20B
        for <linux-can@vger.kernel.org>; Mon,  5 Sep 2022 08:54:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVEQU-0004g2-68; Mon, 05 Sep 2022 17:54:18 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:b4c0:a600:5e68:1e31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2A59FDAE34;
        Mon,  5 Sep 2022 15:54:17 +0000 (UTC)
Date:   Mon, 5 Sep 2022 17:54:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jacob Kroon <jacob.kroon@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2ad3nydi3ujbhs6"
Content-Disposition: inline
In-Reply-To: <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
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


--h2ad3nydi3ujbhs6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.09.2022 11:38:31, Jacob Kroon wrote:
> I used "candump can0 -l" on the EG20T host to capture the traffic, and
> then connected an CAN USB analyzer to the network and used that to
> capture the traffic. One thing sticks out. This is the log from the
> CAN USB analyzer:

Who generates these CAN messages?

> > ...
> > 505.7052;RX;0x464;3;0x01;0x01;0x00;;;;;;
> > 505.7052;RX;0x464;3;0x00;0x00;0x00;;;;;;
> > 505.7063;RX;0x65;64;;;;;;;;;

As Oliver pointed out, this doesn't look like a valid CAN frame. Is the
analyzer and/or sender configured for CAN-FD?

> > 505.7662;RX;0x440;3;0x32;0x20;0xFA;;;;;;
> > 505.7912;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
> > 505.9632;RX;0x464;3;0x00;0x00;0x00;;;;;;
> > 505.9632;RX;0x464;3;0x01;0x01;0x00;;;;;;
> > 505.9752;RX;0x468;3;0x51;0x20;0xFA;;;;;;
> > 506.0362;RX;0x440;3;0x32;0x20;0xFA;;;;;;
> > 506.0622;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
> > 506.2112;RX;0x464;3;0x00;0x00;0x00;;;;;;
> > 506.2112;RX;0x464;3;0x00;0x00;0x00;;;;;;
> > 506.2462;RX;0x468;3;0x51;0x20;0xFA;;;;;;
> > 506.3072;RX;0x440;3;0x32;0x20;0xFA;;;;;;
> > 506.3322;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
> > 506.4572;RX;0x464;3;0x00;0x00;0x00;;;;;;
> > 506.4580;RX;0x464;3;0x00;0x00;0x00;;;;;;
> > 506.5162;RX;0x468;3;0x51;0x20;0xFA;;;;;;
> > 522.7203;RX;0x1E;1;0xFF;;;;;;;;
> > ...
>=20
> Note the third message from the top. This is what "candump" on the host
> logs:
>=20
> > ...
> > (1662022485.638794) can0 464#010100
> > (1662022485.638940) can0 464#000000
> > (1662022485.699405) can0 440#3220FA
> > (1662022485.725166) can0 44C#3520FA
> > (1662022485.896858) can0 464#000000
> > (1662022485.897382) can0 464#010100
> > (1662022485.909042) can0 468#5120FA
> > (1662022485.970036) can0 440#3220FA
> > (1662022485.995596) can0 44C#3520FA
> > (1662022486.144685) can0 464#000000
> > (1662022486.144768) can0 464#000000
> > (1662022486.179595) can0 468#5120FA
> > (1662022486.240561) can0 440#3220FA
> > (1662022486.266274) can0 44C#3520FA
> > (1662022486.391248) can0 464#000000
> > (1662022486.391469) can0 464#000000
> > (1662022486.450115) can0 468#5120FA
> > (1662022502.662035) can0 01E#FF
> > ...
>=20
> It fails to see the 3rd message from the previous log. What would that
> indicate ? The CAN analyzer sees the message, but the EG20T doesn't.

Is this error somehow related to the "can0: can_put_echo_skb: BUG!
echo_skb 0 is occupied"?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--h2ad3nydi3ujbhs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMWG6UACgkQrX5LkNig
010Z2Af/YLI0NsMnXL8q1xJtl9PdDzDqggmIad8Bo48Wp4uAFpmMqPzluzmR15qu
hXvhIAEOFMfc95MtRucjBdFXXxzkOaGY6X72yRVHrthbX7yhM377gbNeY6oBcylY
+qVCx3imXKeZ4TshjrVtNkxhnVfA8y3aRxElHBHjYCiPdUdero6rV23aBZOTqH76
M9qzwIcqV+t/mf8irSzHN8Bj1yomuBAKlmea1LchC/rwzNYTYP/INVIN6H/pc90D
JzT2w7Utha1QR9/C0ON29wcDEUdGCgNMmdts0cdc3b7pGl0tn5r8CYbjUUxpiwwZ
ZwwUiysapCIQR2+0kXKpaOc6bvmYrg==
=u64f
-----END PGP SIGNATURE-----

--h2ad3nydi3ujbhs6--
