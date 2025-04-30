Return-Path: <linux-can+bounces-3508-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9173AA410F
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 04:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900979A54E8
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E519DF7A;
	Wed, 30 Apr 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="VJehqcyU"
X-Original-To: linux-can@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F513B5A9
	for <linux-can@vger.kernel.org>; Wed, 30 Apr 2025 02:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981015; cv=none; b=Ys9dakkrLZJL/vGxlpSG1dwFUNsgV2Vr7cutlnDDh0+m8St4uyXCKeEtYWGHGgDKXIgig0RDAPVRu6s5f4de66kRaZXCL/ZfEtFl5cntVS+UdMYptBoJLWq4qzRRUe2lF9QxWwn8gZ5NGszpRn1CRnOUv5BjSIawxtpMdY44hwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981015; c=relaxed/simple;
	bh=RcsP80pfrQt0VA0Ub0PFjgelw51XMBN4xppLlJi4yrU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=phviSWTpyW0pnX4Sof0oZVDQl5J14DDcr9Aa0bzz0J0JKdSm36JbP2gyef0dbnzYwLOCI0VyYe43EIiXLn7CQaV/p12g0HJOJmbkxkek7wAoLaJtYpdxfnM8gSIhD3FEFmGlo7RE2N5fUUmvyoiH4nTJEeKXNfiXhnShy1g/648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=VJehqcyU; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745981009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snDS8pozO0Xi//BMrok2Uxd+UfcmrScbOyEg0p3gE78=;
	b=VJehqcyUxJjgDJXht6i27Qd3lzUEpimYxSZGSlHKU/Bua2wnDhtwnKtzALN93wmbtaiuAB
	EpsC4LH6rmXgdY1w6NIWFFgfh7LcyZtL4tvyCp8iEfDrSneXcdSXx+Fb5dPPe9EKH3NkOD
	kvm4R+zdtM4ZoliuC11WPB5F97rwQPIrxmnXNoWy1ko3Q5enT5dQtivjES7uXy/uXXG3ri
	GvkkK6fTCiFnTcY854rNOIXuDxmo5CsUUHd3q/AmzjpIRUSd3IxbxQ71pQmvmcDBAWu7HG
	T7v/b1bUdKLzEHYzOMDNYBXq1mZTNocRu7EtqMD1uFRE5xjJk/pmFZghR7LFcg==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH v4] can: mcp251xfd: fix TDC setting for low data bit rates
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kelsey Maes <kelsey@vpprocess.com>
In-Reply-To: <87c3e3b0-f069-4053-b10a-5091cedbb940@wanadoo.fr>
Date: Tue, 29 Apr 2025 19:43:13 -0700
Cc: linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDE0052A-9434-43B7-9D6F-EB3151C93DA6@vpprocess.com>
References: <20250429173221.52101-1-kelsey@vpprocess.com>
 <87c3e3b0-f069-4053-b10a-5091cedbb940@wanadoo.fr>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT

On Apr 29, 2025, at 19:00, Vincent Mailhol <mailhol.vincent@wanadoo.fr> =
wrote:
>=20
> On 30/04/2025 at 02:32, Kelsey Maes wrote:
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
>          ^^^^^^^^^^
>=20
> Did you update this part of the message after introduction the manual =
mode? This
> should have read:
>=20
>  tdcv 0..63 tdco 0..63
>=20
> after the update.

It did read like that during my testing, I just did not update the =
quote. Should I issue a
v5 patch?

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
>> The automatic, manual, and off TDC modes were tested at speeds up to, =
and
>> including, 8 Mbit/s on real hardware and behave as expected.
>=20
> Thanks for also adding the manual mode!
>=20
>> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip =
MCP25xxFD SPI CAN")
>> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
>> Closes: =
https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess=
.com
>> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
>=20
> Congrats for your first patch! Notwithstanding of above nitpick:
>=20
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thanks! Should I add this tag in the v5? Is there anything else I need =
to do to get this upstream?

--
Kelsey Maes
VP Process Inc.





