Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469D527E294
	for <lists+linux-can@lfdr.de>; Wed, 30 Sep 2020 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgI3H1r (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 03:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3H1q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 03:27:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8324DC061755
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2020 00:27:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kNWWa-0001Zf-FM; Wed, 30 Sep 2020 09:27:40 +0200
Received: from [IPv6:2a03:f580:87bc:d400:b742:a929:3f3f:414e] (2a03-f580-87bc-d400-b742-a929-3f3f-414e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:b742:a929:3f3f:414e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9C31056E305;
        Wed, 30 Sep 2020 07:27:38 +0000 (UTC)
To:     =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Cc:     linux-can@vger.kernel.org, Bas Vermeulen <bas.vermeulen@molex.com>,
        Thomas Kopp <Thomas.Kopp@microchip.com>
References: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
 <66662c88-aa9a-325d-8152-c5befbfafa2a@pengutronix.de>
 <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: mcp25xxfd driver questions
Message-ID: <6bfc53ae-e40c-98b1-af78-66aca4d911cc@pengutronix.de>
Date:   Wed, 30 Sep 2020 09:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xvI2s64vkRgAtraQkUoVZ8QlXmbOrhg3J"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xvI2s64vkRgAtraQkUoVZ8QlXmbOrhg3J
Content-Type: multipart/mixed; boundary="oJ5sjfRwI4qwiGW3Cg3n4vLkni68u5nof";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Cc: linux-can@vger.kernel.org, Bas Vermeulen <bas.vermeulen@molex.com>,
 Thomas Kopp <Thomas.Kopp@microchip.com>
Message-ID: <6bfc53ae-e40c-98b1-af78-66aca4d911cc@pengutronix.de>
Subject: Re: mcp25xxfd driver questions
References: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
 <66662c88-aa9a-325d-8152-c5befbfafa2a@pengutronix.de>
 <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>
In-Reply-To: <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>

--oJ5sjfRwI4qwiGW3Cg3n4vLkni68u5nof
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/30/20 7:32 AM, Magnus Aagaard S=C3=B8rensen wrote:
> On 29-09-2020 15:46, Marc Kleine-Budde wrote:
>> On 9/29/20 1:07 PM, Magnus Aagaard S=C3=B8rensen wrote:
>>> I'm evaluating the MCP2518FD, and have two questions to the driver.

> I should clarify that we already have an older internal test board with=
=20
> the chip working, using the driver by Martin Sperl. I'm evaluating the =

> possibilities to migrate to this driver in the future, since I can see =

> it is being mainline, but for now I mainly wish to use it on a new=20
> internal test board.

Ah, ok. More users are always welcome. Which SoC are you using?

>>> 1. I could not find any references to the GPIOs of the chip. Is it
>>> correct that these are not exposed to the host system?
>> ACK, gpio support is not implemented yet. Drop me a note, if you need =
it.
>=20
> On the board I'm currently working on getting up and running, we have n=
o=20
> need for GPIOs or any of the other advanced features of the MCP2518FD. =

> On our older board, we do utilize the GPIO and oscillator output=20
> functionality of the chip. It works for now with the old driver, so it =

> is not a priority. It would be nice to have this functionality in the=20
> future for us.

Bas Vermeulen (Cc'ed) is using the mainline driver (or an older version o=
f it)
and send a pull request for oscillator output
(https://github.com/marckleinebudde/linux/pull/5). I did an initial revie=
w
there. This is a good starting point if you want to contribute (or drop m=
e a
note for commercial support).

>>> 2. When setting the oscillator frequency outside the
>>> MCP25XXFD_SYSCLOCK_HZ_MIN and MCP25XXFD_SYSCLOCK_HZ_MAX range, the
>>> frequency is compared to the max value scaled by the max PLL value. I=
s
>>> the intention to compare with the min value? Currently, an external
>>> oscillator of 4 MHz and a PLL value of 10, resulting in 40 MHz, is
>>> treated as being too low.
>
>> This is intended. I have no hardware with a 4MHz osc to test, so I dec=
ided to
>> not support the 4MHz osc for now. If you design new hardware I suggest=
 to use a
>> 40MHz osc, as probably no one has tested the hardware thoroughly in th=
e PLL
>> mode. If you need 4MHz support, it can be added, given there is hardwa=
re.
>=20
> I can provide some test information if needed, as I have internal=20
> testing hardware with a 4 MHz oscillator already. Are there any specifi=
c=20
> message sequences that needs to be tested?

You have to take care of the PLL in the functions mcp25xxfd_chip_clock_en=
able(),
mcp25xxfd_chip_softreset_check(), mcp25xxfd_chip_clock_init().

The MCP25XXFD_REG_OSC_PLLEN bit has to be set and the MCP25XXFD_REG_OSC_P=
LLRDY
bit has to be polled.

I'm not sure what SPI speed you can use, when communicating with the mcp,=
 if the
PLL is not enabled. Maybe Thomas (Cc'ed) can answer this. I suspect you c=
an only
use 2MHZ (or rather 85% of it) if you have a 4 MHz OSC with PLL still dis=
abled.
> The chip will most likely not reach high loads with the setup we have i=
n=20
> mind, so I'll manually change the frequency check in the probe function=
=20
> for now.

This will probably not work, as the driver has to enable the PLL and the =
SPI
clock has to be really slow.

> It's great to hear the reasoning. Thanks for the hard work you and=20
> others have put into this driver and the whole CAN system in linux.

Thanks. I'm just standing on the shoulder of giants. This driver was and =
is
great community work. First of all there was Martin's driver, which shows=
 how a
Linux driver for the chip can look. Then several tireless testers here an=
d on
github, direct and open communication with Microchip, and there are sever=
al
$CUSTOMERs paying to get the driver mainline.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--oJ5sjfRwI4qwiGW3Cg3n4vLkni68u5nof--

--xvI2s64vkRgAtraQkUoVZ8QlXmbOrhg3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl90M2cACgkQqclaivrt
76l4kAgAnQ6EJRbrykuaJAF4iwA28tZBhDPhMTx34eiYnBlgaRoCrhHz2gnDS8eT
UDK13NtwArXCDvKSiMp1OfWg1HzAMkOIJ9mmH3vG2PQOg3nR0eKy0X+4lZGyQDTi
KjYrME7PLj3j2W5Bk8sMpyp75TxiOc6WSvT3neouIp3P4GMuchPIojACCWabGft2
u1PhyN6Hx4Tg+ky6awhe7F3PUxENNBpHUPqPZ30zDtbN3ToMWZXomamit/W8mdti
CJ4OBkWy/y/9yLFMK1lOQKsZte1loq2NK08RSFPxfbEGdqZwJL8KF5h2j9S9ff7Z
uQCJFXFuaZWJVzPg0q2uKywbfEh+DA==
=de5q
-----END PGP SIGNATURE-----

--xvI2s64vkRgAtraQkUoVZ8QlXmbOrhg3J--
