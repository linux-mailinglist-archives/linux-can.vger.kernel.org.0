Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F62D0785
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 23:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgLFWBj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 17:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFWBj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Dec 2020 17:01:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EDAC0613D0
        for <linux-can@vger.kernel.org>; Sun,  6 Dec 2020 14:00:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1km25R-0008UT-FF; Sun, 06 Dec 2020 23:00:57 +0100
Received: from [IPv6:2a03:f580:87bc:d400:d9f1:3797:6007:7ecb] (unknown [IPv6:2a03:f580:87bc:d400:d9f1:3797:6007:7ecb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E3A4C5A554B;
        Sun,  6 Dec 2020 22:00:55 +0000 (UTC)
To:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
 <20201206192625.GB15319@x1.vandijck-laurijssen.be>
 <79e6ef83-2779-1a4a-29a1-8c34a3b52a40@pengutronix.de>
 <DB8P190MB063437FAE61F7457D031DC1FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <576867c2-613f-da3a-655d-beedd3027169@pengutronix.de>
 <DB8P190MB0634B660BCFD655ED5D96E9FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <95c71974-290a-89c5-2297-827a3081a84e@pengutronix.de>
 <DB8P190MB06345524F4EB1E411B4CE3D1D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: AW: AW: AW: mcp251xfd No Oscillator (clock) defined
Message-ID: <09e12bd1-8698-6a8a-0ed4-6fa7e03c0f7e@pengutronix.de>
Date:   Sun, 6 Dec 2020 23:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DB8P190MB06345524F4EB1E411B4CE3D1D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kr4VPJn5nJWS6hJ2SLKbk1EjUte8D17Li"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kr4VPJn5nJWS6hJ2SLKbk1EjUte8D17Li
Content-Type: multipart/mixed; boundary="Vlt6GvGc7glKwvjlQYoIpqpaAYyT1j8mI";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <09e12bd1-8698-6a8a-0ed4-6fa7e03c0f7e@pengutronix.de>
Subject: Re: AW: AW: AW: mcp251xfd No Oscillator (clock) defined
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
 <20201206192625.GB15319@x1.vandijck-laurijssen.be>
 <79e6ef83-2779-1a4a-29a1-8c34a3b52a40@pengutronix.de>
 <DB8P190MB063437FAE61F7457D031DC1FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <576867c2-613f-da3a-655d-beedd3027169@pengutronix.de>
 <DB8P190MB0634B660BCFD655ED5D96E9FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <95c71974-290a-89c5-2297-827a3081a84e@pengutronix.de>
 <DB8P190MB06345524F4EB1E411B4CE3D1D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DB8P190MB06345524F4EB1E411B4CE3D1D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>

--Vlt6GvGc7glKwvjlQYoIpqpaAYyT1j8mI
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/6/20 10:23 PM, Sven Schuchmann wrote:
>> Von: Marc Kleine-Budde <mkl@pengutronix.de>
>> Gesendet: Sonntag, 6. Dezember 2020 21:49
>>
>> On 12/6/20 9:36 PM, Sven Schuchmann wrote:
>>>> -----Urspr=C3=BCngliche Nachricht-----
>>>> Von: Marc Kleine-Budde <mkl@pengutronix.de>
>>>> Gesendet: Sonntag, 6. Dezember 2020 21:15
>>>>>> As it's now working in general, Sven can test from setup under Lin=
ux.
>>>>>
>>>>> if I try to load under linux with:
>>>>> sudo dtoverlay mcp251xfd spi0-0 interrupt=3D25
>>>>>
>>>>> I get:
>>>>> [   36.154548] CAN device driver interface
>>>>> [   36.158644] mcp251xfd spi0.0: No Oscillator (clock) defined.
>>>>
>>>> The clock is missing. Let's see if it is added to the DT.
>>>>
>>>> Do a diff of the DT before and after applying the overlay.
>>>>
>>>> | sudo dtc -I fs /proc/device-tree -o before
>>>> | sudo dtoverlay mcp251xfd spi0-0 interrupt=3D25
>>>> | sudo dtc -I fs /proc/device-tree -o after
>>>> | diff -u before after
>>>>
>>>> Send the output of the diff.
>>> Here is the diff:
>>> --- before	2020-12-06 20:31:40.430361119 +0000
>>> +++ after	2020-12-06 20:32:35.939656243 +0000
>>> @@ -35,6 +35,13 @@
>>>  			clock-frequency =3D < 0x337f980 >;
>>>  		};
>>>
>>> +		mcp251xfd-spi0-0-osc {
>>> +			compatible =3D "fixed-clock";
>>> +			#clock-cells =3D < 0x00 >;
>>> +			phandle =3D < 0xde >;
>>                                   ^^^^^^^^
>>> +			clock-frequency =3D < 0x2625a00 >;
>>> +		};
>>> +
>>>  		clk-usb {
>>>  			compatible =3D "fixed-clock";
>>>  			#clock-cells =3D < 0x00 >;
>>> @@ -1029,6 +1036,12 @@
>>>  				brcm,function =3D < 0x04 >;
>>>  			};
>>>
>>> +			mcp251xfd_spi0_0_pins {
>>> +				brcm,pins =3D < 0x19 >;
>>> +				phandle =3D < 0xdd >;
>>> +				brcm,function =3D < 0x00 >;
>>> +			};
>>> +
>>>  			uart1_pins {
>>>  				brcm,pins;
>>>  				phandle =3D < 0x15 >;
>>> @@ -1546,6 +1559,18 @@
>>>  			dmas =3D < 0x0b 0x06 0x0b 0x07 >;
>>>  			pinctrl-names =3D "default";
>>>
>>> +			mcp251xfd@0 {
>>> +				compatible =3D "microchip,mcp251xfd";
>>> +				clocks =3D < 0xde >;
>>                                          ^^^^^^^^
>>
>> That looks good so far.
>>
>>> +				interrupt-parent =3D < 0x0f >;
>>> +				interrupts =3D < 0x19 0x08 >;
>>> +				phandle =3D < 0xdf >;
>>> +				reg =3D < 0x00 >;
>>> +				pinctrl-0 =3D < 0xdd >;
>>> +				spi-max-frequency =3D < 0x1312d00 >;
>>> +				pinctrl-names =3D "default";
>>> +			};
>>> +
>>>  			spidev@1 {
>>>  				compatible =3D "spidev";
>>>  				#address-cells =3D < 0x01 >;
>>> @@ -1557,6 +1582,7 @@
>>>
>>>  			spidev@0 {
>>>  				compatible =3D "spidev";
>>> +				status =3D "disabled";
>>>  				#address-cells =3D < 0x01 >;
>>>  				#size-cells =3D < 0x00 >;
>>>  				phandle =3D < 0xa6 >;
>>
>> Is the clock detcted and loaded by the clock framework?
>>
>> Can you create a diff for "/sys/kernel/debug/clk/clk_summary" before a=
nd after
>> loading the overlay?
>=20
> The diff shows no difference, the output is always:

Hmm, is the clk framework overlay aware? I think this is not a CAN specif=
ic
issue. Maybe open an issue on the linux-rpi kernel or try the latest rpi
linux-5.10 kernel.

If you open an issue, please add me, I'm @marckleinebudde on github.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--Vlt6GvGc7glKwvjlQYoIpqpaAYyT1j8mI--

--kr4VPJn5nJWS6hJ2SLKbk1EjUte8D17Li
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl/NVJIACgkQqclaivrt
76n7kgf+JIC0dZp0WRV8tS23fNTUdHXiQ5i9O/vWjYE0qtH/4NlYkPZQ9nztcWfw
3dGzQMe9aOQcfvIHX9N8TTTY51IHKun7G1KLaYjkMBbDKc9KRMHGlTJjasiOISm4
1gcu7SQCv0lvp1/8WJmqkN/ABh2Gmdx9rYV2iW1U66BPGe5ymn9/jy3Hwxl6j/Hi
+k1p6+csIGHylT4xXiVaqbM83bcabib0hhqTD55fNWUv3X9p3O9wsI8LpzvEkl6C
OqXvO8dsNOmkA1fdfcMu7bZImLap8hDPB2kZmTXsXDl3ROKFLLGkz9+fC/lqFyYd
c5ZpsYKM61BkQyRrBOXNexGq5GuD7w==
=oeQw
-----END PGP SIGNATURE-----

--kr4VPJn5nJWS6hJ2SLKbk1EjUte8D17Li--
