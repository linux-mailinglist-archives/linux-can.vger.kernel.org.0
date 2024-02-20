Return-Path: <linux-can+bounces-311-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B785B437
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ACE281AAA
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486435A4CE;
	Tue, 20 Feb 2024 07:49:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from projects.drlauer-research.com (projects.drlauer-research.com [88.99.0.140])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E05A4FF
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.0.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415388; cv=none; b=sKuF6pYEwTic1RRpQSfH0iX9nF5GFx4/vQZzfAjhzi6MhjRMS2hatJaQ2eUTIF/lQsu/B9YyblEhbzECr6Tx/sAVQEbeApT/k7M+9zzTFt6IOL1vqsYkXAxlvUrqWXbdZI9zTLh/G6ddLMdr1wOo3YyZ5NLtMfHjH4lVLANPgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415388; c=relaxed/simple;
	bh=QTy/KprOQEpY9wGhJSMPuWwNn9tKg6o8LxBz8DCOckc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YzNh3CDKjpx5yAsETOI1wAeSX2o6T9bZM92/17Z0OS89qzGOUrWVxZCdbooDITFKkleJs5oUhRuQ211UYvoFHYZqST1YN2uUpMxKlLNVT/H03/NGhjQDnMfNYqWjgsiCBOFh2Nx8x27S84pB00O4AZx/bWrYWU103FRtfWPdkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de; spf=pass smtp.mailfrom=vanille.de; arc=none smtp.client-ip=88.99.0.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanille.de
Received: from smtpclient.apple (ip-109-090-164-198.um36.pools.vodafone-ip.de [109.90.164.198])
	by projects.drlauer-research.com (Postfix) with ESMTPSA id B26C048028D;
	Tue, 20 Feb 2024 08:49:37 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
From: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>
In-Reply-To: <20240219-contend-catfight-cd49fff06252-mkl@pengutronix.de>
Date: Tue, 20 Feb 2024 08:49:26 +0100
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8609D943-B86B-4584-88A1-984BD39E25D3@vanille.de>
References: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
 <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de>
 <20240219-contend-catfight-cd49fff06252-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Marc,

>>=20
>> Sounds pretty cool. Our design is based on an ESP32-S3 though, so I
>> have to duplicate that effort. Is there some kind of USB protocol
>> definition for what gs-usb expects or do I need to learn that from =
the
>> implementation?
>=20
> I've put together a very rough summary of the driver's side of view:
>=20
> =
https://gist.github.com/marckleinebudde/99f72d9db67accf08cc6efa367cfe54b
>=20
> Feel free to update.

Wow, that=E2=80=99s very kind of you!
Later this year I=E2=80=99ll take this blueprint to implement the =
necessary
changes in our firmware. I=E2=80=99ll enhance / update your summary
as I=E2=80=99ll go.

Thanks!

:M:=

