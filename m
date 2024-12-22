Return-Path: <linux-can+bounces-2485-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B818C9FA73D
	for <lists+linux-can@lfdr.de>; Sun, 22 Dec 2024 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17571887193
	for <lists+linux-can@lfdr.de>; Sun, 22 Dec 2024 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53500190676;
	Sun, 22 Dec 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="uZAMc4Ab"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CC7DA8C;
	Sun, 22 Dec 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734888457; cv=none; b=nAD1ydZWBBWCnnhE9uOhLCjqTR4JzEhvohv7umIDuzS8ioCwYYOm0Eg4481M4iazXW0LYa1sequPQGU3HsVBihNS3C40W9CQaRBq2l+yDW9GMPzvhzZBAiHIjYXGeo2P2dbifiz31+HHW4MoK9S3p2irULItgZQkDOexA5IgTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734888457; c=relaxed/simple;
	bh=mWntqmS/N7xkczCX2PFuoOmXZbwTCOLcsCIkyfGC70I=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=t+Z2K2/E7SmPSitfJBlpeSMOjl+biyK82D/QUNZDd1DVbnQtwU8DFX5kH2Ku9zPIcg3uNP+DFpCas5BE3MGhtmHwGnlHRzFX0Na7GqsWdDRFMKA3sOSQYi02oy+SQVuNYi8eJS7v0Bhaya7JxO6ORjbMRPhrNb9AAs9wOl1ahjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=uZAMc4Ab; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734888453; x=1766424453;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=mWntqmS/N7xkczCX2PFuoOmXZbwTCOLcsCIkyfGC70I=;
  b=uZAMc4Abj9XcM23jfVtlyiQETp2/fk6cMiURSqVtlWetY8uI9h0tvla0
   FZ8Sl14fLvJ3ODmNUvx6l0ZEBhVQ+6ZS1Dl7FAUDNwGeDEs4pCP1CyLG1
   cI49U4UXov1n7nnZCU3URqjAPE9+dT1xMLiT+iZhtVQXj96T49GHJo077
   c=;
X-CSE-ConnectionGUID: 5DrgUXrgR6GMNzCvUaHl8w==
X-CSE-MsgGUID: SsgJtOROS+2u4H1bguGcZg==
X-IronPort-AV: E=Sophos;i="6.12,256,1728943200"; 
   d="scan'208";a="28291696"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 22 Dec 2024 18:27:25 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <20241222-resolute-calculating-mamba-531d3d-mkl@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20241221111454.1074285-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221111454.1074285-4-ariel.otilibili-anieli@eurecom.fr> <20241222-resolute-calculating-mamba-531d3d-mkl@pengutronix.de>
Date: Sun, 22 Dec 2024 18:27:25 +0100
Cc: linux-media@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>, linux-kernel@vger.kernel.org
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f7a8a-67684c00-9be3-1d1363a0@197697901>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 3/3] =?utf-8?q?net/can/dev=3A?= Remove dead 
 code
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

On Sunday, December 22, 2024 17:37 CET, Marc Kleine-Budde <mkl@pengutro=
nix.de> wrote:

> On 21.12.2024 12:06:49, Ariel Otilibili wrote:
> > The default switch case ends with a return; meaning this return is =
never
> > reached.
> >=20
> > Coverity-ID: 1497123
> > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
>=20
> Applied this patch only to linux-can-next/testing.

Great, Marc; thanks for the feedback.
>=20
> Thanks,
> Marc
>=20
> --=20
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


