Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F209F27E6B6
	for <lists+linux-can@lfdr.de>; Wed, 30 Sep 2020 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgI3Ked (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgI3Ked (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 06:34:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5391C061755
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2020 03:34:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kNZRL-0001FK-Hf; Wed, 30 Sep 2020 12:34:27 +0200
Received: from [IPv6:2a03:f580:87bc:d400:b742:a929:3f3f:414e] (unknown [IPv6:2a03:f580:87bc:d400:b742:a929:3f3f:414e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EC57656E619;
        Wed, 30 Sep 2020 10:34:25 +0000 (UTC)
Subject: Re: mcp25xxfd driver questions
To:     =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Cc:     linux-can@vger.kernel.org, Bas Vermeulen <bas.vermeulen@molex.com>,
        Thomas Kopp <Thomas.Kopp@microchip.com>
References: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
 <66662c88-aa9a-325d-8152-c5befbfafa2a@pengutronix.de>
 <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>
 <6bfc53ae-e40c-98b1-af78-66aca4d911cc@pengutronix.de>
 <fafb1bf7-5427-34a5-54b1-c80280e466a1@csselectronics.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b701b416-d17f-eda2-6b68-732be5da22e9@pengutronix.de>
Date:   Wed, 30 Sep 2020 12:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fafb1bf7-5427-34a5-54b1-c80280e466a1@csselectronics.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="31zMAz8kZZ87vizRkzwv19FFCrtEq7dDc"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--31zMAz8kZZ87vizRkzwv19FFCrtEq7dDc
Content-Type: multipart/mixed; boundary="wfdRpZ8GL1xmmX6lg1Z42LbbRjdrHQQkK";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Cc: linux-can@vger.kernel.org, Bas Vermeulen <bas.vermeulen@molex.com>,
 Thomas Kopp <Thomas.Kopp@microchip.com>
Message-ID: <b701b416-d17f-eda2-6b68-732be5da22e9@pengutronix.de>
Subject: Re: mcp25xxfd driver questions
References: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
 <66662c88-aa9a-325d-8152-c5befbfafa2a@pengutronix.de>
 <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>
 <6bfc53ae-e40c-98b1-af78-66aca4d911cc@pengutronix.de>
 <fafb1bf7-5427-34a5-54b1-c80280e466a1@csselectronics.com>
In-Reply-To: <fafb1bf7-5427-34a5-54b1-c80280e466a1@csselectronics.com>

--wfdRpZ8GL1xmmX6lg1Z42LbbRjdrHQQkK
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/30/20 12:11 PM, Magnus Aagaard S=C3=B8rensen wrote:
>> Ah, ok. More users are always welcome. Which SoC are you using?
> We are controlling the test boards using a Raspberry Pi 4, so I assume =

> it is a Broadcom BCM2711.

Ok....The SPI clock situation on the rpi4 is not optimal. But's a a diffe=
rent
story :)

>>>>> 1. I could not find any references to the GPIOs of the chip. Is it
>>>>> correct that these are not exposed to the host system?
>>>> ACK, gpio support is not implemented yet. Drop me a note, if you nee=
d it.
>>> On the board I'm currently working on getting up and running, we have=
 no
>>> need for GPIOs or any of the other advanced features of the MCP2518FD=
=2E
>>> On our older board, we do utilize the GPIO and oscillator output
>>> functionality of the chip. It works for now with the old driver, so i=
t
>>> is not a priority. It would be nice to have this functionality in the=

>>> future for us.
>> Bas Vermeulen (Cc'ed) is using the mainline driver (or an older versio=
n of it)
>> and send a pull request for oscillator output
>> (https://github.com/marckleinebudde/linux/pull/5). I did an initial re=
view
>> there. This is a good starting point if you want to contribute (or dro=
p me a
>> note for commercial support).
>>
>>>>> 2. When setting the oscillator frequency outside the
>>>>> MCP25XXFD_SYSCLOCK_HZ_MIN and MCP25XXFD_SYSCLOCK_HZ_MAX range, the
>>>>> frequency is compared to the max value scaled by the max PLL value.=
 Is
>>>>> the intention to compare with the min value? Currently, an external=

>>>>> oscillator of 4 MHz and a PLL value of 10, resulting in 40 MHz, is
>>>>> treated as being too low.
>>>> This is intended. I have no hardware with a 4MHz osc to test, so I d=
ecided to
>>>> not support the 4MHz osc for now. If you design new hardware I sugge=
st to use a
>>>> 40MHz osc, as probably no one has tested the hardware thoroughly in =
the PLL
>>>> mode. If you need 4MHz support, it can be added, given there is hard=
ware.
>>> I can provide some test information if needed, as I have internal
>>> testing hardware with a 4 MHz oscillator already. Are there any speci=
fic
>>> message sequences that needs to be tested?
>> You have to take care of the PLL in the functions mcp25xxfd_chip_clock=
_enable(),
>> mcp25xxfd_chip_softreset_check(), mcp25xxfd_chip_clock_init().
>>
>> The MCP25XXFD_REG_OSC_PLLEN bit has to be set and the MCP25XXFD_REG_OS=
C_PLLRDY
>> bit has to be polled.
>>
>> I'm not sure what SPI speed you can use, when communicating with the m=
cp, if the
>> PLL is not enabled. Maybe Thomas (Cc'ed) can answer this. I suspect yo=
u can only
>> use 2MHZ (or rather 85% of it) if you have a 4 MHz OSC with PLL still =
disabled.

> Thanks for the hints, I'll see if I can adapt it to our use case.

I'm looking forward for patches :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--wfdRpZ8GL1xmmX6lg1Z42LbbRjdrHQQkK--

--31zMAz8kZZ87vizRkzwv19FFCrtEq7dDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl90Xy4ACgkQqclaivrt
76nsgwf/XbZhfAUuA7gkUO8igvvIKYP5UyUJRfGbYS+7ltjRqOXEiOnqxssNq4u9
gXliRV5wqP6xFU7oNVdcqArX90p6aQOhsTOAzIKisMQX5bE4QlhW309Ph+o7jiui
Nfe4RA7aJL43vM7L560TSZ44iFvm0M10pms+Xds0+Ckc8DuVCbbmA57jvRrDEbQS
mb/owzqVFUA6PtYk/6YCAD2tCofMfVWp714y08G9kV0Hr+AWQHSsEMRkkA6tmeCp
xay2JWJKP0ZI3bGznRL16lK5BIiTxKpips9wwQkE9FxWf0Eqhf+IbxqnJ+uHOVLF
wQpgZYuGCwPd1uYmP0dqvyMj3qcBIw==
=BuRN
-----END PGP SIGNATURE-----

--31zMAz8kZZ87vizRkzwv19FFCrtEq7dDc--
