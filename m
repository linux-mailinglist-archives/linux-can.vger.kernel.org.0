Return-Path: <linux-can+bounces-3498-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D76A9F538
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0338F1A808C2
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AAA18F2FC;
	Mon, 28 Apr 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="DQIjionV"
X-Original-To: linux-can@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041A27A11C
	for <linux-can@vger.kernel.org>; Mon, 28 Apr 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856685; cv=none; b=PR3GDBFgXWGuCScyuwuHl95NBAtd0uhWF5lPF9PWLJifEr7OzJUqOzJa5atcNxm8E7yCNGHZhJ5Bk+CysbJ0uM4/jmJg+CHDdONVnGVk24cvcFJtAZO3dDE03A3mTowwgsqlnNkDPHUs5kS2nEI8ZtspRHMVrIneTdxci6T09jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856685; c=relaxed/simple;
	bh=ZKguwXyVbhZ9Pk73iVtu52EzowDwTy+vRlY8lu39RYM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Gueo00ZsITxlf2d0dC+HGhiQcJdqQjV1cLUmW7kSk9iLfKNCe+SLcSFSbM+meD/b6WrpXJrsfWDWq38kgSWAUy3S/EjLvxdmAjVm7MIVPG/AwF7tbqQHEmuncoXD6ytxr1e0A0Y7l6Pm1hMljM77n3SvFA1H6FowgNkxfMYvI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=DQIjionV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745856680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isG9kKVwy6B8IdTidZLIa4Cr5ue76ODn4gT4qxVwJqM=;
	b=DQIjionVh+s15FewFeMUqFqycp7G/m1ZHQgrkLi7TnFNkwNsAQXp0ZrHViG6YcMi5lLOKO
	sISHGM34AtjeurmXsBoEtibI68M3ZF6jfO9k2aXaNldk0G5XDp0PpMdj3A1dLJF3J65yOH
	ZcWoDWxCngwLes6Zy3UllG1+e8bgSXk2O0Ws1BSkfJ2YqB2S3T+kzVBOj4D/fSwwU16hnI
	dm/Wk7q58sMcCvnb8U+pilvz3sHKJOd/eruJ9qmqFsCUNxi46xljszJ9A97WdehY+ivGfI
	oI8hfioYMXcsoUoUxEcFSZB/0rAHk3LI+IAloE5WN57WCcwkv17M/XiJighmzQ==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kelsey Maes <kelsey@vpprocess.com>
In-Reply-To: <20250428-impressive-masterful-squid-a898c4-mkl@pengutronix.de>
Date: Mon, 28 Apr 2025 09:11:05 -0700
Cc: linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <79BCE02A-D4EC-4362-B0D3-3FE76FB17B78@vpprocess.com>
References: <20250425191336.45581-1-kelsey@vpprocess.com>
 <20250428-impressive-masterful-squid-a898c4-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
X-Migadu-Flow: FLOW_OUT

On Apr 28, 2025, at 01:39, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
> On 25.04.2025 12:13:36, Kelsey Maes wrote:
>> TDC is currently hardcoded enabled so lower CAN FD data bitrates =
result in a
>> bus-off condition. This patch allows userspace to control TDC as =
needed.
>=20
> I think the underlying problem is that the original code always =
enables
> TDC. Lower data bitrates result in a DBRP > 1, as you stated in your
> original mail:
>=20
>>> I have a problem where I get a bus-off condition when using bit
>>> rates that use a DBRP > 1.
>=20
> ...and in auto mode TDC is only enabled for DBRP =3D=3D 1 or 2. =
Switching to
> CAN_CTRLMODE_TDC_AUTO brings the positive side effect, that TDC is
> controllable from user space. So the commit message can be made more
> precise, what about:
>=20
> Subject: can: mcp251xfd: fix TDC setting for low data bit rates
>=20
> THe TDC is currently hardcoded enabled. This means even for lower =
CAN-FD
> data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is
> configured. This leads to a bus-off condition.
>=20
> ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC)
> is only applicable if data BRP is 1 or 2.
>=20
> To fix the problem, switch the driver to use the TDC calculation
> provided by the CAN driver framework (which respects ISO 11898-1 =
section
> 11.3.3). This has the positive side effect, that the user space can
> control TDC as needed.
>=20
> Can you also add these tags:
>=20
> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
> Closes: =
https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess=
.com

Sure, I=E2=80=99m fine with that.

> BTW: In you original mail, you've written that you're using a bitrate
> of 125 kbit/s and a data bitrate of 500 kbit/s. This is a bit unusual.
> Is that a real world application? Are you allowed to say which one?

We are building an industrial automation system that uses CAN bus in =
place of
RS-485 for controlling potentially distant modules. That particular =
bitrate is one
of 4 possible bitrates the system can operate at: 125 / 500, 250 / 1000,
500 / 2000, 1000 / 4000. We have an automatic bit rate detection =
mechanism
and having a fixed 1:4 ratio simplifies the implementation. The lower =
bitrates
will only be used in situations where a very long bus, poor wiring, =
and/or noise
issues prevent the use of higher bitrates. These are all very common =
issues we
have encountered with our existing RS-485 systems in the field.=20

> I just noticed that there is another potential problem with this
> combination of bit rates. The used BRP for the arbitration- and data
> bitrate are not identical:
>=20
> | Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock =
(CIA recommendation) using algo 'v6.3'
> |                     _----+--------------=3D> TSeg1: 2 =E2=80=A6  256
> |                    /    /     _---------=3D> TSeg2: 1 =E2=80=A6  128
> |                   |    |     /    _-----=3D> SJW:   1 =E2=80=A6  128
> |                   |    |    |    /    _-=3D> BRP:   1 =E2=80=A6  256 =
(inc: 1)
> |                   |    |    |   |    /
> |  nominal          |    |    |   |   |     real  Bitrt    nom   real  =
 SampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  =
 Error      NBTCFG
> |   500000     25  34   35   10   5   1   500000   0.0%  87.5%  87.5%  =
 0.0%   0x00440904
> |   125000     50  69   70   20  10   2   125000   0.0%  87.5%  87.5%  =
 0.0%   0x018a1309
> |=20
> | Data Bit timing parameters for mcp251xfd with 40.000000 MHz ref =
clock (CIA recommendation) using algo 'v6.3'
> |                     _----+--------------=3D> TSeg1: 1 =E2=80=A6   32
> |                    /    /     _---------=3D> TSeg2: 1 =E2=80=A6   16
> |                   |    |     /    _-----=3D> SJW:   1 =E2=80=A6   16
> |                   |    |    |    /    _-=3D> BRP:   1 =E2=80=A6  256 =
(inc: 1)
> |                   |    |    |   |    /
> |  nominal          |    |    |   |   |     real  Bitrt    nom   real  =
 SampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  =
 Error      NBTCFG
> |   500000    125   6    7    2   1   5   500000   0.0%  87.5%  87.5%  =
 0.0%   0x040c0100
>=20
> This leads to a phase error while switching from arbitration to the =
data
> bitrate. A common BRP of 5 is better:
>=20
> | Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock =
(cmd-line) using algo 'v6.3'
> |  nominal                                  real  Bitrt    nom   real  =
 SampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  =
 Error      NBTCFG
> |   125000    125  27   28    8   4   5   125000   0.0%  87.5%  87.5%  =
 0.0%   0x04360703
> |=20
> | Data Bit timing parameters for mcp251xfd with 40.000000 MHz ref =
clock (cmd-line) using algo 'v6.3'
> |  nominal                                  real  Bitrt    nom   real  =
 SampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  =
 Error      NBTCFG
> |   500000    125   6    7    2   1   5   500000   0.0%  87.5%  87.5%  =
 0.0%   0x040c0100

I agree. This problem can be worked around by specifying the timing =
parameters
explicitly, if required. It has not been an issue so far.

--
Kelsey Maes
VP Process Inc.





