Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ABD4E53E8
	for <lists+linux-can@lfdr.de>; Wed, 23 Mar 2022 15:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiCWOFW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Mar 2022 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiCWOFV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Mar 2022 10:05:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B37E093
        for <linux-can@vger.kernel.org>; Wed, 23 Mar 2022 07:03:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nX1aW-0006is-Ro; Wed, 23 Mar 2022 15:03:48 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-7d06-8be6-5c48-871a.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7d06:8be6:5c48:871a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 28D0752107;
        Wed, 23 Mar 2022 14:03:48 +0000 (UTC)
Date:   Wed, 23 Mar 2022 15:03:47 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        manivannan.sadhasivam@linaro.org
Subject: Re: can-next 2022-03-13: mcp251xfd: add
Message-ID: <20220323140347.hkuklvkefvb4l6l5@pengutronix.de>
References: <20220313083640.501791-1-mkl@pengutronix.de>
 <DM4PR11MB539016D37DC0A025799B809BFB189@DM4PR11MB5390.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gb5jebkio32bbtz"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB539016D37DC0A025799B809BFB189@DM4PR11MB5390.namprd11.prod.outlook.com>
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


--5gb5jebkio32bbtz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.03.2022 13:28:20, Thomas.Kopp@microchip.com wrote:
> > this series for the mcp251xfd adds IRQ coalescing support.
>
> Thanks for these patches, the performance gains with activated
> coalescing look awesome!

\o/

> Testing on a Pi4 mostly 1 channel RX-only Full busload scenarios I see
> significantly reduced CPU utilization. This is both for CAN 2.0 and
> CAN-FD use-cases.

\o/

> I tested this patch series against 5.17 mainline

Thanks for testing.
Does the coalescing series apply to v5.17 without the other series?

> and I think the performance when NOT using coalescing regressed
> slightly ("measured" via sar -u 1, not sure if that is a valid
> benchmark?)

"sar" don't know that tool, which Debian package do I have to install?

> I had both driver versions configured for the same fifo sizes and
> coalescing turned off. The mainline driver actually generates slighty
> more SPI interrupts in this scenario (20k CAN 2.0 Frames RXed in
> CAN-FD mode). Not really sure what causes the higher CPU utilization
> or if it's even relevant (maybe on smaller systems than a Pi4)

I don't know the length of the SPI transfers, where the raspi SPI driver
switched from PIO to IRQ mode. If more CAN frames are read in one
transfer (this can happen with deactivated IRQ coalescing, too) the
transfer size might be big enough to trigger an IRQ transfer, especially
in CAN-FD mode.

For better reproducibility I set the scaling_governor to performance:

| echo performance | sudo tee /sys/devices/system/cpu/cpufreq/policy0/scali=
ng_governor

I've no idea why an unpachted v5.17 generates more SPI IRQs.

Can you re-test with performance mode activated, I'm not sure when I
find time to look into this.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5gb5jebkio32bbtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI7KMEACgkQrX5LkNig
010PIwgAl+i2bqRv/ltj2WTmkKvegXhwkeYp3WpK+TRuVXBvltZDWXux7STBpFeW
bTc0SM+ExqvEaejI3FBDfoopYZseHiw39oc9dg4EXP5Vlv/OLFfT7X+bDRVJ0uu+
WNXJAEU5OP6gFGstGf/mvlNfjWyOWIzEdY9HjD0BmjLbC2TgC4qx6uG6utNs+EKj
lA7/et9MPcui8QrBekqBwf1DJeRbkNPU+eC0hPmD4QN0S10okpOX4oq0Oa7/IkNk
Ha5t7rcabGcJVAQ6DoaOo6mfdObAfk78pCsyXc7we2PDtC25yn0FCfTB9reMk7uV
qMBMOgJWtHbYaYaYAF6JOywE5KYNaA==
=Wc72
-----END PGP SIGNATURE-----

--5gb5jebkio32bbtz--
