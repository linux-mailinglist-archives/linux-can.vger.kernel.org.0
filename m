Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28EE4E5922
	for <lists+linux-can@lfdr.de>; Wed, 23 Mar 2022 20:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbiCWTae (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Mar 2022 15:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiCWTad (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Mar 2022 15:30:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2E31372
        for <linux-can@vger.kernel.org>; Wed, 23 Mar 2022 12:29:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nX6fD-0001lb-Ue; Wed, 23 Mar 2022 20:28:59 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-8a32-3c37-3138-10d6.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:8a32:3c37:3138:10d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 84789523AF;
        Wed, 23 Mar 2022 19:28:58 +0000 (UTC)
Date:   Wed, 23 Mar 2022 20:28:58 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        manivannan.sadhasivam@linaro.org
Subject: Re: can-next 2022-03-13: mcp251xfd: add
Message-ID: <20220323192858.pixhyf2jzah7eqiv@pengutronix.de>
References: <20220313083640.501791-1-mkl@pengutronix.de>
 <DM4PR11MB539016D37DC0A025799B809BFB189@DM4PR11MB5390.namprd11.prod.outlook.com>
 <20220323140347.hkuklvkefvb4l6l5@pengutronix.de>
 <DM4PR11MB5390224F4ABAED6DFC430266FB189@DM4PR11MB5390.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qbos6cmobxlo5c73"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5390224F4ABAED6DFC430266FB189@DM4PR11MB5390.namprd11.prod.outlook.com>
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


--qbos6cmobxlo5c73
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.03.2022 15:00:31, Thomas.Kopp@microchip.com wrote:
> > For better reproducibility I set the scaling_governor to performance:
> >=20
> > | echo performance | sudo tee
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> >=20
> > I've no idea why an unpachted v5.17 generates more SPI IRQs.
> >=20
> > Can you re-test with performance mode activated, I'm not sure when I
> > find time to look into this.
> >=20
> Yes, will do. For the record, the difference was really marginal. On
> 20k frames I had 39182 vs. 39139 SPI interrupts.

I assume in some case the RX processing took so long that there was
another RX CAN frame ready in the same IRQ handler run.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qbos6cmobxlo5c73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI7dPcACgkQrX5LkNig
013J0wf/dB6VKDgqPubet1bjnLf8VVhyYmwr2gccgir7nHokJzZqARQNtqTbzxqm
T4fZwZIislugH58QuRfdDel/aup9PzjkWtCmikKgYNt2/G1M+bT1T68u5Mo3rJyP
RG2YPmtEb2a38+1nxoM0jMqwcBAE5Xr5WK633pFQk5P+CX6PWa7D/34coBViKb0I
1Oc7HiIoYwc66FO2xFcbx3uDVjPIMty90LzdSi1SqX4ybahVrQm3RDZjU8LGDmxX
946PQ4eHgZGPUWS/nKVD7Sg34fk3lrmmgzXwNMypfD/iG7H9TTRoX/Ubbwf8MNPi
YMTwq38mLAcMHJ22BsSts24DPh1Mwg==
=FX01
-----END PGP SIGNATURE-----

--qbos6cmobxlo5c73--
