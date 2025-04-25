Return-Path: <linux-can+bounces-3489-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD6A9CE68
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 18:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E781BA3AAC
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD8194A60;
	Fri, 25 Apr 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="iMIx9Vpx"
X-Original-To: linux-can@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074912701AE
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599368; cv=none; b=gExqq9HtG4Uzz9giBlqxGFFgkNqDbNSfYsRn2a+Mu6Vbguv6wd4NA1PXJbNBVELX6Oj1Ttg/UMWMOhlv5TQ7Pape748WOo1GAYcw4fUhzl4YXGmxFRxALOXEF2bgptPRS8oTthXnLeYQnnsHA7YeT3YfPWht4D5JvF9a5vX7Mn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599368; c=relaxed/simple;
	bh=TejLi4NkaPCTcGE209qciTiEjv1aecF6ZdC4FTrBEjk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RTjykBaLtP8e9eI4f1uQpnNrzwefsAh7XVlxszmXGvQuph4knV826GRZCWJiOYd31UpfBQ9xsto4WsNjENvksLKKY+SxA3GxNR43uklgRaFHcWVWSeSNiMEwC61CJWQAA4XfkLW1W5Hex6Xg66fEeLutxIpwsKhJ+eyBs6kuaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=iMIx9Vpx; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745599363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTSFzJNj2tMkkuBimBQduP2VLHvnqE+MNGxt/s3EJEU=;
	b=iMIx9Vpx3mi5rzGAvRy0zGpci3aXIWkkKzaKcPL/t1pXrUzrIDODNDbVEgsfRQ1+vNKS9J
	n6CLzhWnwbREcvhMZzfPiPcqu6iIvT7zpv3hB9BIMOr4FMNypnZwJD4iakQsRGj03zcW6e
	kEEcaU6nRH6qavUaPTX/pQUVmNNGXlbGTQJqXhKZrA39EHX0YcSm743OB6ZZsC9uOYMoEa
	bzhmRQrbhmKu7OhcNpPjDX5ZUHwMiAKcbrZSMaWVsk2tpH95ymwky1O2dfhXpwUXWlF0Px
	nSk90z0xSSb2n+covP0li6VkCxxCWWWlkawXkmqDlynKmlTk5LIOs7iODZTMhQ==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kelsey Maes <kelsey@vpprocess.com>
In-Reply-To: <CAMZ6RqK9ehF74x+xWAqyTFv4k5kVxxAdsqVeYM0yVXaJtKLxtg@mail.gmail.com>
Date: Fri, 25 Apr 2025 09:42:28 -0700
Cc: linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <91295576-C918-419E-B529-196BDDF1BE35@vpprocess.com>
References: <07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com>
 <CAMZ6RqK9ehF74x+xWAqyTFv4k5kVxxAdsqVeYM0yVXaJtKLxtg@mail.gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT


> On Apr 24, 2025, at 19:26, Vincent Mailhol =
<mailhol.vincent@wanadoo.fr> wrote:
>> ---
>> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 ++++++++----
>> 1 file changed, 8 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c =
b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> index 3bc56517f..1180c489b 100644
>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> @@ -577,9 +577,13 @@ static int mcp251xfd_set_bittiming(const struct =
mcp251xfd_priv *priv)
>>        /* Transmitter Delay Compensation */
>>        tdco =3D clamp_t(int, dbt->brp * (dbt->prop_seg + =
dbt->phase_seg1),
>>                       -64, 63);
>> -       val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>> -                        MCP251XFD_REG_TDC_TDCMOD_AUTO) |
>> -               FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>> +       if (can_tdc_is_enabled(&priv->can))
>=20
> Did you test that this function ever returns true? The framework can
> normally detect whether TDC should be turned on or off, but for this,
> it needs to do some basic calculations using the TDC const values
> which you did not provide.

Good point, I did not test it directly. The propagation delay of my loop =
is
low enough that it should work without TDC at all in most cases, even at
4 Mbit.=20

> For this, you will need to populate:
>=20
>  priv->can.tdc_const
>=20
> To test, use:
>=20
>  ip --details link show can0
>=20
> On a low dbitrate, the TDC should be off, but on higher bitrates (e.g.
> 5 Mbps) you should confirm that the TDCO value is calculated.

That command doesn=E2=80=99t give any indication of TDC. Does this mean =
it=E2=80=99s not
enabled? What should I be looking for?

I will try populating tdc_const as well.

>> +               val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>> +                                MCP251XFD_REG_TDC_TDCMOD_AUTO);
>> +       else
>> +               val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>> +                                MCP251XFD_REG_TDC_TDCMOD_DISABLED);
>> +       val |=3D FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>                                                         ^^^^
> Once you do the above changes, the tdco will be calculated by the
> framework. If I remember well, the mcp251xfd uses a relative TDCO, so
> you should use can_get_relative_tdco().
>=20
>  =
https://elixir.bootlin.com/linux/v6.14/source/include/linux/can/dev.h#L115=


Are you sure it=E2=80=99s a relative TDCO? The Microchip documentation =
doesn=E2=80=99t
explicitly say one way or the other but their calculation spreadsheet
matches the existing DBRP * DTSEG1 calculation in the driver and my
own embedded implementations which are all indicative of an absolute
TDCO.

>=20
>>=20
>>        return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
>> }
>> @@ -2086,7 +2090,7 @@ static int mcp251xfd_probe(struct spi_device =
*spi)
>>        priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>>                CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING =
|
>>                CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
>> -               CAN_CTRLMODE_CC_LEN8_DLC;
>> +               CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
>>        set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>>        priv->ndev =3D ndev;
>>        priv->spi =3D spi;
>=20
> Your patch is corrupted:
>=20
>  Applying: can: mcp251xfd: make TDC controllable from userspace
>  Patch failed at 0001 can: mcp251xfd: make TDC controllable from =
userspace
>  error: corrupt patch at line 10
>=20
> It seems it has to do with encoding. Here is what I get
>=20
>  $ wget =
https://lore.kernel.org/linux-can/07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpp=
rocess.com/raw
>  $ ./scripts/checkpatch.pl raw
>  ERROR: patch seems to be corrupt (line wrapped?)
>  #64: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:576:
>  mcp251xfd_priv *priv)
>=20
>  ERROR: spaces required around that '=3D' (ctx:WxV)
>  #73: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:578:
>  +        val =3D3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>               ^
>=20
>  ERROR: spaces required around that '=3D' (ctx:WxV)
>  #76: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:581:
>  +        val =3D3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>               ^
>=20
>  ERROR: spaces required around that '|=3D' (ctx:WxV)
>  #78: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:583:
>  +    val |=3D3D FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>           ^

Ah wonderful. I will try and sort this one out. This is my first attempt =
at an email
patch submission.

--
Kelsey Maes
VP Process Inc.





