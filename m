Return-Path: <linux-can+bounces-3491-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB60FA9D005
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D7D4E46F0
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095C1940A2;
	Fri, 25 Apr 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="SXZjWOXV"
X-Original-To: linux-can@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD41F463F
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603313; cv=none; b=t3Bdigwl+AF78SmUay+RiOfn3doqhR9faXOr/EzoE26TacAloEp+I2tpvma50b0Dl8Du4dSQyGFDvLSXsqdsN7XFlAzxwpaX1wEC47n4QR8TOQ9dXdTvtYcWKIr8sN6NiVA6yUXQEm58bX3Ga9XY+fMRNadT7fxz+MPcafeMgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603313; c=relaxed/simple;
	bh=gE2fjZGUZSvRmCpCBqwE3yf4uVAQ3rWQ5V1ydK1yLU0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BXRYyVh74X8EPs3Ec4OLBU3+3LZEmJ2h8y3dUqxMbLBwQQ5Q7zQwBHi2H8l5O12GeedaiGBvnkCCPso/QD2b3bOYuknGrRRu7gcSB0EbgC1QdV2l3dd1baMer8Isj3knV8Bu3y1JnadQ8+ncc3kQfYRz6kn1Pt/DaG7TAQPvdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=SXZjWOXV; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745603306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZEwSDzirsTM1uS/SohAaseyO8/TCGPCjBnHSJRySEY=;
	b=SXZjWOXVkEc79x/B72B4c+LYpXMo249EfFoQSPV5JCf3gM5dW3q61R96yOUj6ukir02HnB
	Is7Ca8Wlfd17xlEE0FmkHiWI9apcbO7scSDrGEpcL0xbpKMCUQR9PN5+YRpp4ROfkDlwtv
	kFDVPnEa9DGTdgmW2Yp3UFBlQuDO+bog8BtsFLJ9rzdvEGYIa6AMEWPix4LJJtEd01anjd
	hhWtiKVTeaWnwQWsNBOoDjVA2YmFvZTw0GmfGv6HhKPFHLHuYlixqRuIfKY1OUDPP76jnj
	5vi3pkH308kkULn/OFAeM6giY35aZEA71vGE+c1XV+JKP2m9S4SGHy5lztG0lw==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kelsey Maes <kelsey@vpprocess.com>
In-Reply-To: <dbf42ea2-6506-43ea-8f8c-3df9f620a166@wanadoo.fr>
Date: Fri, 25 Apr 2025 10:48:12 -0700
Cc: linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8DDA77C-227E-4F9C-80D4-DC9EAC6C3917@vpprocess.com>
References: <07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com>
 <CAMZ6RqK9ehF74x+xWAqyTFv4k5kVxxAdsqVeYM0yVXaJtKLxtg@mail.gmail.com>
 <91295576-C918-419E-B529-196BDDF1BE35@vpprocess.com>
 <dbf42ea2-6506-43ea-8f8c-3df9f620a166@wanadoo.fr>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT


> On Apr 25, 2025, at 10:01, Vincent Mailhol =
<mailhol.vincent@wanadoo.fr> wrote:
>=20
> On 26/04/2025 at 01:42, Kelsey Maes wrote:
>>> On Apr 24, 2025, at 19:26, Vincent Mailhol =
<mailhol.vincent@wanadoo.fr> wrote:
>>>> ---
>>>> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 ++++++++----
>>>> 1 file changed, 8 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c =
b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>>> index 3bc56517f..1180c489b 100644
>>>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>>> @@ -577,9 +577,13 @@ static int mcp251xfd_set_bittiming(const =
struct mcp251xfd_priv *priv)
>>>>       /* Transmitter Delay Compensation */
>>>>       tdco =3D clamp_t(int, dbt->brp * (dbt->prop_seg + =
dbt->phase_seg1),
>>>>                      -64, 63);
>>>> -       val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>>> -                        MCP251XFD_REG_TDC_TDCMOD_AUTO) |
>>>> -               FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>>>> +       if (can_tdc_is_enabled(&priv->can))
>>>=20
>>> Did you test that this function ever returns true? The framework can
>>> normally detect whether TDC should be turned on or off, but for =
this,
>>> it needs to do some basic calculations using the TDC const values
>>> which you did not provide.
>>=20
>> Good point, I did not test it directly. The propagation delay of my =
loop is
>> low enough that it should work without TDC at all in most cases, even =
at
>> 4 Mbit.=20
>>=20
>>> For this, you will need to populate:
>>>=20
>>> priv->can.tdc_const
>>>=20
>>> To test, use:
>>>=20
>>> ip --details link show can0
>>>=20
>>> On a low dbitrate, the TDC should be off, but on higher bitrates =
(e.g.
>>> 5 Mbps) you should confirm that the TDCO value is calculated.
>>=20
>> That command doesn=E2=80=99t give any indication of TDC. Does this =
mean it=E2=80=99s not
>> enabled? What should I be looking for?
>=20
> No TDC indication means it is off.
>=20
> Look at the description of this commit:
>=20
> =
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3D=
0c263d7c36ff99cd2f6bc1e0702181cbdc50f7b8
>=20
> I posted the TDCO output there.
>=20
> Look at the ctrlmode flags:
>=20
>  $ ip --details link show can0
>  1:  can0: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT =
group default
> qlen 10
>      link/can  promiscuity 0 minmtu 0 maxmtu 0
>      can <FD,TDC-AUTO> state STOPPED (berr-counter tx 0 rx 0) =
restart-ms 0
>              ^^^^^^^^
>=20
> Here, the TDC-AUTO flag is on. If none of the TDC flags show off, then =
TDC is
> off and the tdc section is missing.
>=20
>> I will try populating tdc_const as well.

Thank you, this makes sense. With tdc_const values I am now seeing =
similar output.

>>>> +               val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>>> +                                MCP251XFD_REG_TDC_TDCMOD_AUTO);
>>>> +       else
>>>> +               val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>>>> +                                =
MCP251XFD_REG_TDC_TDCMOD_DISABLED);
>>>> +       val |=3D FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>>>                                                        ^^^^
>>> Once you do the above changes, the tdco will be calculated by the
>>> framework. If I remember well, the mcp251xfd uses a relative TDCO, =
so
>>> you should use can_get_relative_tdco().
>>>=20
>>> =
https://elixir.bootlin.com/linux/v6.14/source/include/linux/can/dev.h#L115=

>>=20
>> Are you sure it=E2=80=99s a relative TDCO? The Microchip =
documentation doesn=E2=80=99t
>> explicitly say one way or the other but their calculation spreadsheet
>> matches the existing DBRP * DTSEG1 calculation in the driver and my
>> own embedded implementations which are all indicative of an absolute
>> TDCO.
>=20
>=20
> No, I am not sure. But if it is an absolute value, then it can only be =
positive.
>=20
> The fact that it is clamped between -64 and 63 is a strong hint that =
this is a
> relative TDCO:
>=20
> =
https://elixir.bootlin.com/linux/v6.14.3/source/drivers/net/can/spi/mcp251=
xfd/mcp251xfd-core.c#L579
>=20
> I also discussed this with Marc in the past. It was a few years ago.
>=20
> But I did not check the datasheet personally, so take my comment with =
a grain of
> salt.

I believe I actually read that thread in researching this issue. I think =
that discussion
missed that while the TDCO value can be positive or negative the TDCV =
value is
strictly positive, between 0 and 63. None of the CAN controllers I am =
familiar with
permit the sum of TDCO and TDCV to exceed the maximum TDCV value. I =
honestly
don=E2=80=99t know why this value is allowed to be negative or if it=E2=80=
=99s a datasheet error. What
I can say is that my testing has shown that when using =
can_get_relative_tdco() at a
4 Mbit data rate the final TDCO value is 1, which is close to the ideal =
relative TDCO
of 0 but only 10% of the bit time in an absolute model, I get bus-off =
errors in dmesg.
If I use priv->can.tdc.tdco which provides a final TDCO of 8, exactly =
80% of the bit=20
time in my configuration, the bus works.

I=E2=80=99m going to prepare a new patch based on absolute TDCO for now.

--
Kelsey Maes
VP Process Inc.





