Return-Path: <linux-can+bounces-299-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB4785961D
	for <lists+linux-can@lfdr.de>; Sun, 18 Feb 2024 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDDF1C21042
	for <lists+linux-can@lfdr.de>; Sun, 18 Feb 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D21D525;
	Sun, 18 Feb 2024 09:53:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from projects.drlauer-research.com (projects.drlauer-research.com [88.99.0.140])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06EB1D520
	for <linux-can@vger.kernel.org>; Sun, 18 Feb 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.0.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708250034; cv=none; b=RlCqBw1AlFmgjxqH3oHjNYuXvr5FwNCWV+ypZpHmzP267UOong5nhJm73COqWHh8lwo8MbgWkPjuqvsMoLqn3Lf/ih7E78k2vwyCO5y5WppCS55DGAuVyRoPI9bzVyayCAzHFG+6tD0KDNYCrcdtRL6UscSuwvbtGDlSrN1myWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708250034; c=relaxed/simple;
	bh=nulETjBgPUI0wnZK/u29tA+/GGEtcYwbYvSSJ1xO02Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DTSOUJrT96IGddI/heA3lOTvFuZwNo5CzZbmrcCYPDN94suVdHXOhnnA2yj2k37MbgdIxN9FVMQ3piNwKCinNuP5HZxLdeNLLPwpZmFCDsZSQqAhzFwXyRtGPf/ddXLdriKU/Psby2KwE7fbpq79PaACYGPH8G314oSZ53xuHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de; spf=pass smtp.mailfrom=vanille.de; arc=none smtp.client-ip=88.99.0.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanille.de
Received: from smtpclient.apple (unknown [IPv6:2a02:3037:205:4ed9:91d7:27fc:11de:814d])
	by projects.drlauer-research.com (Postfix) with ESMTPSA id ABBF248001C;
	Sun, 18 Feb 2024 10:45:12 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: "Dr. Michael Lauer" <mickey@vanille.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
Date: Sun, 18 Feb 2024 10:45:02 +0100
Message-Id: <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de>
References: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: iPhone Mail (21D61)



> On 16. Feb 2024, at 14:40, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
> =EF=BB=BFOn 09.02.2024 22:25:37, Oliver Hartkopp wrote:
>>> On 2024-02-09 18:28, Dr. Michael 'Mickey' Lauer wrote:
>>> My team and I have designed and developed
>>> a new CAN(FD) adapter based on ESP32S3 and MCP2518fd
>>> primarily aimed at ECU firmware reprogramming,
>>> but eventually also for the use as OBD2-adapter,
>>> CAN-logger, etc.
>>>=20
>>> The next incarnation will also have a
>>> USB interface and I=E2=80=99m planning the necessary
>>> changes for its firmware.
>>>=20
>>> I would like it to be compatible with SocketCAN
>>> out of the box =E2=80=94 optimally without writing a
>>> Linux driver, but rather reusing an existing one.
>>>=20
>>> Which of the mainline SocketCAN drivers would you recommend
>>> basing my USB protocol on? =46rom a quick glance,
>>> I=E2=80=99m leaning towards GS-USB, since this already
>>> supports different hardware families.
>>=20
>> Yes. I would also recommend the gsusb driver and the CandleLight firmware=

>> project on the other side:
>=20
> ACK. gs_usb is the way to go for USB-to-CAN adapters.

Ok, good to hear. We=E2=80=98ll go with that then.

>=20
>> https://github.com/candle-usb/candleLight_fw
>>=20
>> ... where currently the CAN FD support is in the testing phase IIRC.
>=20
> The USB protocol for CAN-FD is stable and supported by the kernel and
> the Work-In-Progress firmware. The firmware can be found here:
>=20
> | https://github.com/candle-usb/candleLight_fw/pull/139
> | https://github.com/candle-usb/candleLight_fw/pull/176
>=20
> We're currently discussing the implementation details of the firmware,
> but the USB part is, as mentioned above, stable

Sounds pretty cool. Our design is based on an ESP32-S3 though, so I have to d=
uplicate that effort. Is there some kind of USB protocol definition for what=
 gs-usb expects or do I need to learn that from the implementation?

Cheers,

M=


