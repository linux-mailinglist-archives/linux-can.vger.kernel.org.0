Return-Path: <linux-can+bounces-3504-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D5CAA1068
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 17:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A627B21A0
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C4221554;
	Tue, 29 Apr 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="NSENwHnO"
X-Original-To: linux-can@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237D2594
	for <linux-can@vger.kernel.org>; Tue, 29 Apr 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940358; cv=none; b=LKj5+8eFhnEIZESB2CiaBd7FG3DPJyMZIrjY/8rOb2ujQJrFLhei7yNI4dq1UXt6OHQuHiKNeH9xjx0vlYDDHZLIg7wrUyS2ezYRTscvWPZbKOITcbsjgwrQIpxnehucBwAYGpb6yNJKsH0XJ0sfO3Y9v37BHxYbQTlsgZjDSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940358; c=relaxed/simple;
	bh=CDu0uRJf1JRhAzKz7hzavJJfwEsIXpK47W7fHjiKC6o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NRmMR2xCkRf6Iz0dpZZ4aA60xNjU3JYS0atBV3bK7QApfX+eI2tt+uHOinfHBV+rL75EGUxm/sYWo0cbUZs1v4qrry+EnlqECJtiRVDM4ly+qxsPb48JpnqRblk1HUoZRoaf7MnrVCIVMP0YiyEVd+sr3a3Eef7JLr4eG+76qWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=NSENwHnO; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745940352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pKA2WJPnLheN9S/zuaNDtIxxDQkL+rBYrBYBo6o1l0=;
	b=NSENwHnO6PDXPNHAadqRIT9t/h/u5MO2m+a+8I9gpWj0P4YjOvFy2OI1WuRwVKnxqxmhOK
	tp22QJsLXaaK0rKnTvjsk+CTRE1CdmUJ0AmFLsyQsTdAK8Ln0QtRd+2DGqJJgmevm2iXS1
	nC4nPYoMUfdH18bll/wT+GZZizo8jAkMgpqQP2BaulcXqEJ2yy7AsP4Keq5GLZjxSENE6B
	RsmU071BKZ54pNt4Mqbx1T3uiXeFKyaQRpPw8YVMg0oZM+BD/PIL4iEhxRaAD++sqF4SLe
	xpxoHYwLDG+f+B8FGs8xKzE6Pw+b2eul9TunXOoKNJF+qwzwfeEqY6vFs6dDvw==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH v3] can: mcp251xfd: fix TDC setting for low data bit rates
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kelsey Maes <kelsey@vpprocess.com>
In-Reply-To: <388e98aa-d923-4bb9-af44-d1bdd0d1c729@wanadoo.fr>
Date: Tue, 29 Apr 2025 08:25:37 -0700
Cc: linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C0E1A24-3164-4A9A-A7FC-8C0A2C01700D@vpprocess.com>
References: <20250428171501.75830-1-kelsey@vpprocess.com>
 <388e98aa-d923-4bb9-af44-d1bdd0d1c729@wanadoo.fr>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT

On Apr 28, 2025, at 22:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> =
wrote:
> On 29/04/2025 at 02:15, Kelsey Maes wrote:
>> The TDC is currently hardcoded enabled. This means that even for =
lower CAN-FD
>> data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is =
configured.
>> This leads to a bus-off condition.
>>=20
>> ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" =
(TDC) is only
>> applicable if DBRP is 1 or 2.
>>=20
>> To fix the problem, switch the driver to use the TDC calculation =
provided by the
>> CAN driver framework (which respects ISO 11898-1 section 11.3.3). =
This has the
>> positive side effect that userspace can control TDC as needed.
>>=20
>> Demonstration of the feature in action:
>>  $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
>>  $ ip -details link show can0
>>  3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP =
mode DEFAULT group default qlen 10
>>      link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>>      can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms =
0
>>     bitrate 125000 sample-point 0.875
>>     tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
>>     mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 =
brp_inc 1
>>     dbitrate 500000 dsample-point 0.875
>>     dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
>>     mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 =
dbrp_inc 1
>>     tdco 0..63
>>     clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 =
gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size =
65536 parentbus spi parentdev spi0.0
>>  $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd =
on
>>  $ ip -details link show can0
>>  3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP =
mode DEFAULT group default qlen 10
>>      link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>>      can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) =
restart-ms 0
>>     bitrate 1000000 sample-point 0.750
>>     tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
>>     mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 =
brp_inc 1
>>     dbitrate 4000000 dsample-point 0.700
>>     dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
>>     tdco 7
>>     mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 =
dbrp_inc 1
>>     tdco 0..63
>>     clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 =
gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size =
65536 parentbus spi parentdev spi0.0
>>=20
>> There has been some confusion about the MCP2518FD using a relative or =
absolute
>> TDCO due to the datasheet specifying a range of [-64,63]. I have a =
custom board
>> with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. =
During testing
>> at a data bit rate of 4 Mbit/s I found that using =
can_get_relative_tdco()
>> resulted in bus-off errors. The final TDCO value was 1 which =
corresponds to a
>> 10% SSP in an absolute configuration. This behavior is expected if =
the TDCO
>> value is really absolute and not relative. Using priv->can.tdc.tdco =
instead
>> results in a final TDCO of 8, setting the SSP at exactly 80%. This =
configuration
>> works.
>>=20
>> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip =
MCP25xxFD SPI CAN")
>> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
>> Closes: =
https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess=
.com
>> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>> ---
>> .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 25 =
+++++++++++++------
>> 1 file changed, 18 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c =
b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> index 3bc56517f..d2184a32d 100644
>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> @@ -75,6 +75,15 @@ static const struct can_bittiming_const =
mcp251xfd_data_bittiming_const =3D {
>> .brp_inc =3D 1,
>> };
>>=20
>> +static const struct can_tdc_const mcp251xfd_tdc_const =3D {
>> + .tdcv_min =3D 0,
>> + .tdcv_max =3D 63,
>=20
> I missed this in my previous review, sorry.
>=20
> Does the mcp251xfd support the manual TDC? Unless you add the
> CAN_CTRLMODE_TDC_MANUAL flag, the TDCV value is simply ignored, c.f.
>=20
>  =
https://elixir.bootlin.com/linux/v6.14/source/include/linux/can/bittiming.=
h#L92
>=20
> All the macro are already there:
>=20
>=20
> =
https://elixir.bootlin.com/linux/v6.14/source/drivers/net/can/spi/mcp251xf=
d/mcp251xfd.h#L76
>=20
> So that shouldn't be hard. Can you test this in =
mcp251xfd_set_bittiming()?
>=20
>  u32 tdcmod, val;
>=20
>  /* ... */
>=20
>  /* Transmitter Delay Compensation */
>  if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO)
>   tdcmod =3D MCP251XFD_REG_TDC_TDCMOD_AUTO;
>  else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
>   tdcmod =3D MCP251XFD_REG_TDC_TDCMOD_MANUAL;
>  else
>   tdcmod =3D MCP251XFD_REG_TDC_TDCMOD_DISABLED;
>=20
>  val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK, tdcmod) |
>   FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.tdc.tdcv) |
>   FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
>=20
>  return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
>=20
> (and yes, in my previous message, I said that it is better to move the =
tdco's
> FIELD_PREP inside the if, but this only applies for a simple if/else, =
if we have
> three branches, the above looks better).

Manual TDCV is supported by the hardware but this patch does not enable =
it. I
can take a quick look at this but it is out of scope for our needs.

>> + .tdco_min =3D 0,
>> + .tdco_max =3D 63,
>> + .tdcf_min =3D 0,
>> + .tdcf_max =3D 0,
>> +};
>> +
>> static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model =
model)
>> {
>> switch (model) {
>> @@ -511,7 +520,6 @@ static int mcp251xfd_set_bittiming(const struct =
mcp251xfd_priv *priv)
>> const struct can_bittiming *bt =3D &priv->can.bittiming;
>> const struct can_bittiming *dbt =3D &priv->can.data_bittiming;
>> u32 val =3D 0;
>> - s8 tdco;
>> int err;
>>=20
>> /* CAN Control Register
>> @@ -575,11 +583,13 @@ static int mcp251xfd_set_bittiming(const struct =
mcp251xfd_priv *priv)
>> return err;
>>=20
>> /* Transmitter Delay Compensation */
>> - tdco =3D clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
>> -        -64, 63);
>> - val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>> -  MCP251XFD_REG_TDC_TDCMOD_AUTO) |
>> - FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
>> + if (can_tdc_is_enabled(&priv->can))
>> + val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>> +  MCP251XFD_REG_TDC_TDCMOD_AUTO);
>> + else
>> + val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>> +  MCP251XFD_REG_TDC_TDCMOD_DISABLED) |
>> + FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
>=20
> Shouldn't this have been the opposite?
>=20
>  if (can_tdc_is_enabled(&priv->can))
>   val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>    MCP251XFD_REG_TDC_TDCMOD_AUTO) |
>   FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
>  else
>   val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
>    MCP251XFD_REG_TDC_TDCMOD_DISABLED);
>=20
> Did you reconfirm that the device works well with high bitrates (e.g. =
5 Mbps)
> with no bus off conditions after the change?

Heh, that=E2=80=99s embarrassing. You are correct that the logic is =
inverted and it
passed my tests up to 4 Mbit/s. My guess here is that the loop delay in =
ideal
conditions is low enough to work without TDC. I will see if I can add a
temporary higher speed for testing.

>> return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
>> }
>> @@ -2083,10 +2093,11 @@ static int mcp251xfd_probe(struct spi_device =
*spi)
>> priv->can.do_get_berr_counter =3D mcp251xfd_get_berr_counter;
>> priv->can.bittiming_const =3D &mcp251xfd_bittiming_const;
>> priv->can.data_bittiming_const =3D &mcp251xfd_data_bittiming_const;
>> + priv->can.tdc_const =3D &mcp251xfd_tdc_const;
>> priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>> CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
>> CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
>> - CAN_CTRLMODE_CC_LEN8_DLC;
>> + CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
>> set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>> priv->ndev =3D ndev;
>> priv->spi =3D spi;

--
Kelsey Maes
VP Process Inc.





