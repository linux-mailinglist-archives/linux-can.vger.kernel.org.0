Return-Path: <linux-can+bounces-6530-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHbOJrcqimm6HwAAu9opvQ
	(envelope-from <linux-can+bounces-6530-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 19:43:03 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A916A113B9A
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 19:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0184C300460D
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAB3A0E84;
	Mon,  9 Feb 2026 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XXUwhqIs";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XXUwhqIs"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023130.outbound.protection.outlook.com [52.101.72.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF9387370;
	Mon,  9 Feb 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.130
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662577; cv=fail; b=nBbHxE8fZ1B6x19HuQICAbeZz+Zw3+kYYllTKmyCEb3J/X5VFbJhJbBx2AJxIWg8uWxV4RiY3cM6yiGhVQITagNrxvWIxqIxnSFHWXx0CpAv4lE4qiVu5M4gUCCQTrw0PZueQF4n1iVOplKrwtCo84Qh2tOrTT9E7kdpuXARE6U=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662577; c=relaxed/simple;
	bh=wE7JgnK9q+5iFGW6bfxaEg7Y6UHwLFRfr75ZfJsowc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0uBf0G5qHSQqu7ZRu1thtf04eMTj8zI3DgL3C6Q/Qw+/ovelbbyLu577v5b3f1sxpIrpNsJ8HlCjm2nX/DcIIf4SMbaNORbpcAveGKd+wW+8QgcJal0xJ0ZVWJiPZLfO7DhwN5uRY88fohouAB9x96MNf/6/87fXXJk0jr80nA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=XXUwhqIs; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=XXUwhqIs; arc=fail smtp.client-ip=52.101.72.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pXjsA9EuqygBjlCTjuUp7HaPaWV8NOJ9ymO/BKAVHh1QUroheNVqXrxoKkYL7bFEkImGJ06xH1/L9Km8NpmM0nPxJfd2J+XWPbJxDzXN7bXEsutqdSCtqq7q+Eeb768SYJsivnfKxSs07oLld0NOAVKZ+17XFoU6LR8+YqpOyLhjTqPCXxJt9ecjE99TrmISrQp4FLvJvX55JuK7qEqDz9XOTIJBqd6oDk42clBUds086P4O5briiAGL4IK4w+ULOioXu+Uho2qKJvIP2ieXCntQR5oK+cItKrPkE+8wqppOvu7eCLRMdgHs8cqnP5UdMAEwxNNP3o2d4zpdxjsCfw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE7JgnK9q+5iFGW6bfxaEg7Y6UHwLFRfr75ZfJsowc8=;
 b=zK/OV7UgCNKxnr1F6e06MLOMtrrwQA+28/MmkgAEJdTUA3vquxLCZPDsXQ3vqvBp7scz85S/fIBB8TwqHovCX2PU4GeEv0GiAGOIP59clu1S+PeSj/sbMmCYQ4k3YS0OovWFOiZ0qh8lSL1ESKLX5zR9QGG93lOV8Lc8yIxLSXkSRHZLHkD+LJoSRZcNCzgnCSkjv0FzL5z30PWnvyDBvjtidXkNL1YUMsvL48ToDTSrgseXu5R0eEW9tEB+Jmw39LTNmaTjQeRR3YgV/99qiJxyyJ2cZGzIM9w5OKrrSynXqqQJf5I1Y4UjCs2mt67pHKS7onpXfR6hAfrtEa8bJA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE7JgnK9q+5iFGW6bfxaEg7Y6UHwLFRfr75ZfJsowc8=;
 b=XXUwhqIstfvnXe5ymkbjbxVRXV98Gnbny6zCV90F2rQUKxXmf+Gdn0l4bAPO3xp0JtyWKzRjdkfJYWJM1vrK8rJ/FUfCXjLsN15u8pPJsVtfhIcwrLr0iKvpz8YoPjM7OfRaBK55+rgq40FUVU4wTyQ4WzAT+iKNtvCRPjVGwlY=
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by DB9PR04MB8362.eurprd04.prod.outlook.com
 (2603:10a6:10:241::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 18:42:53 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::cf) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 18:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8
 via Frontend Transport; Mon, 9 Feb 2026 18:42:52 +0000
Received: from emails-7853744-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-8.eu-west-1.compute.internal [10.20.5.8])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 0ECB5800C5;
	Mon,  9 Feb 2026 18:42:52 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770662572; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=wE7JgnK9q+5iFGW6bfxaEg7Y6UHwLFRfr75ZfJsowc8=;
 b=L/DBKNtrTCct3dkxy0BYTXaiOz3DGMAVcdILeQt2ZobyEMi/EkfvijPygN8cI7iyubIWG
 djbmI90sB2CuMu+RKJi6SZ/N7p3SrikjaB1ofB8BJGdaxhJWlIyG0qH6ePPDSXIH0kvCX1X
 BL+O5ID/BF4M18j2qsyCXxafXRYMSaI=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770662572;
 b=TMkgYl1rzXKcUO0O+O2SBKJmZWbK1GRXcdsXOEV6ABih5BhOZq68oC/qRBk7JMC6ytjRQ
 8tqNkPxKv0g1FxoeldkdbLoWh0vjzLhlvFXJP3UFGS262WofyePAZHsCA5VV9nxWPwz4s7L
 ejVYj4Xt7fViNXN+BuxSxIDIdxOr46A=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD0ERUd4gOn0fwYwjd5QKKrchvY/A/ESws3syiZ+5wxr7AvWirrCQKGPks/QfZsUIVhuqspmIQEgQNRssAKiUELA1BVdvOl0w/KTU2hucOqfwe5R5tOX6EJZ4xsuuKZC8UM1y2NZHeG4CNqQLS0S22GyV/KKWB4wNG/kMJZmWjg4BknAsHosIayeJ2oojHBz/UoX7QmPA0L6VblPaBCdoCwPgJDtZb8Rk2PsChNKgZ3+jgZqkh8KpyPXmPtd36PledXKFu+VGADlG+rYiLw23/ejbOBgbubCGtp4tjLB5sVEy5A4saIiL7+1css+f2odSMKQQYSlur+0C3jSofPadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE7JgnK9q+5iFGW6bfxaEg7Y6UHwLFRfr75ZfJsowc8=;
 b=PvK5hcrwhtFo15zjdQXnGODH9o8YRpRU0XLyg9UKtwdh2wrEw5V90c4ickVghSxLXqZq9uKgsfViBFhfYkER0ldOPtL8vBxzhanAyEaek0ppScwmeRIKBZMiLe5zSnx43DYQDFpNDrve5Nus/+Fx263Eu9Jdh/Mzn4gtB926SQ9+T5plhoQPZF9pkh70XOhOX2Qktu8CK/2b8lAXmkwI9Xk7EzS5tXALKtq5K/OMMSPvJjvB81GaY+OpJeS9CPZ9DmFOeu62WWWsAYwl0u8hsCA/BGTpSHT/qQuibcjgH3bcoRwiMmiF35SoaBg0iinw0Mub2pSTULntAKoEBdqg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE7JgnK9q+5iFGW6bfxaEg7Y6UHwLFRfr75ZfJsowc8=;
 b=XXUwhqIstfvnXe5ymkbjbxVRXV98Gnbny6zCV90F2rQUKxXmf+Gdn0l4bAPO3xp0JtyWKzRjdkfJYWJM1vrK8rJ/FUfCXjLsN15u8pPJsVtfhIcwrLr0iKvpz8YoPjM7OfRaBK55+rgq40FUVU4wTyQ4WzAT+iKNtvCRPjVGwlY=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PA1PR04MB10602.eurprd04.prod.outlook.com (2603:10a6:102:490::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 18:42:42 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:42:42 +0000
From: Josua Mayer <josua@solid-run.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Janusz
 Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Thread-Topic: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Thread-Index:
 AQHcmREOqpOO6qV7AUmUzlczA9k35bV6IsaAgAA3k4CAAAanAIAAAuSAgAAxz4CAAABpgIAAH3+A
Date: Mon, 9 Feb 2026 18:42:41 +0000
Message-ID: <7d4a93b5-3f27-4385-99aa-8e1c94816ba5@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
 <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
 <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
 <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
 <CAPDyKFrDLEzKrFY0GeevptDdRe7JAUzXgqM7fVtQ_PnYDi+N_A@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrDLEzKrFY0GeevptDdRe7JAUzXgqM7fVtQ_PnYDi+N_A@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PA1PR04MB10602:EE_|DB5PEPF00014B92:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e6f344-dac8-4ec3-819b-08de680b0806
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NGoyVFdmTlNRb2d4MnFMalhuRFZEUmkyMGFaSm9jUnVYdTNmc1QxQnhLcDFH?=
 =?utf-8?B?S010L2Vsa2ZmVnNxVk56LzRTNllNWU93cDQ4cEVMd25aUjFucTkrSUZ1Yndy?=
 =?utf-8?B?M1pheTlxaEFLNThpZTRORnh1czZiSGU0YndLL09jTkNFRjhSc2RYbXF0VEhq?=
 =?utf-8?B?WjhnT2NGNnUxVjFnTGRFSHgrSkxtTTc2VUIrZWtrVmFyMlRxSmdyblF2Y2d4?=
 =?utf-8?B?QTRwOWs2VTcyekpNWUpCeTBOcFVIemt1RDFaVHZ2UmN5Y2d2eWgwL044Qlla?=
 =?utf-8?B?ZDBxUzlNZi81NDZ0YVpZUmNFYk8xNnJ4YXNETndRTmdOVFd3cEJNQjVoekJa?=
 =?utf-8?B?Y2R2QmFBLzVKZVdWUmI2RlUxN3ZmZHh1VjJYV2hBQlBjUHVyMDYweE84Yjln?=
 =?utf-8?B?Umx4SlkzbFppUmhpUXpVK29PNEwybENhWFJjVjYyeURMeTNhMndEUlUwYWVp?=
 =?utf-8?B?ejNoYk0zRkdidEp0TkM2bEJTOGNMaXV2TEZnOGwvL3Vvc3lpK0VvMUE0TVEw?=
 =?utf-8?B?TnRoZnA5VGsrMWN5NXBYaWsxNk9hcTBqK3VCd3FUVjZvbEFyejA4NDk5T1lR?=
 =?utf-8?B?eU16ZkYwOVlGMnF4SEpNaUx2RzRQdVNaajBlNnM4bVdsK0hyRlJHeVZjNWVS?=
 =?utf-8?B?bmF0WmJZZ0QwY2RDVTc4dGFBcDFuV3Rabi9VcFI1TERSeXAyS09iTjVzRWdG?=
 =?utf-8?B?WTc0bytzK0EwL1RVak9hcW5wYzN6WEpSd01HMWZ0a1M5NEl3Q2FxSWduN1Bz?=
 =?utf-8?B?Q1hwUzh0Mm15VFdLTnl2VEdOdmhXZUF4TUU3elY0a3VIS2dBL2NvcDM1alB0?=
 =?utf-8?B?WHNUYXhpRUNhcVYzMVZobHN3MFBTUFliSEYxOWc2SmlCYlNVbEtOVE1mTGUx?=
 =?utf-8?B?eGNHbCt6WWZsYU1rOEFROUhIWVBmZ1kwaWozdkE3ZWpDV3dwR0M0MGwraElz?=
 =?utf-8?B?cDgrNjR0WURzVGFpSHBDNHNtL05MUnRwMHJWS3htdkJFaEVGM1VoV2UxRThW?=
 =?utf-8?B?UFVIb0k3OFRTR1UyQ2k0YURLOGhTeFZFOWRnSVZrbGdBdUlnMVNQSEd6ZVpi?=
 =?utf-8?B?bFJpMXl2QkpySjlRVzJLVDBDU0YrekNLME8zOGVsYm5RbUJMRHQ5Z2tZd05i?=
 =?utf-8?B?ZVRKK01IdmlmYVp1SHY4VlhLTERydVZrQUhWMzVDNldVV3MxT2FEcytheXRT?=
 =?utf-8?B?SzFLWTZXSzlMUlpIR1V3VWwwZU40VjJFMVh4K3RxeVlOZC9KUXRIOU9uMisv?=
 =?utf-8?B?am9GaTY4N1dqbXVTL21nS2REbEc3U1dpSE5vRjA1cGZrRENWVENjdXpHZTAr?=
 =?utf-8?B?eGV2eHNxQkJld0NxYjNISmZadXpoeVNWMWVFai9rVFRTRDNtTTA4RCt2Sm5p?=
 =?utf-8?B?OU40b2FhZEZmNDI3aGUyWldVQVlrTml6Ym1uUDhvQ29hNWxuMFIzb2tyQmx0?=
 =?utf-8?B?NEhhKzk1aWtZb3ZqeDdvcSsxajI1a1NKMlVsZjJtb1RKbHgxd09uVzdjUlFJ?=
 =?utf-8?B?M2doaHR6WUtZeUJQNWZ0UjQwS1ZMYmdlMG1xU3g3ZUl4a29jSGM5bExIN2Uz?=
 =?utf-8?B?N09EM2FweG9wTlkySHkvVkN0YmVPTjV3TmNkeFhzMUtjTUxkempqVmNqYVBm?=
 =?utf-8?B?bXlnaU5TR0FSUUJXcUcyaVYvc0wzTVFZNkpOVCt4aTZjZE1Sazdiak5hb1JZ?=
 =?utf-8?B?VU40TEtQcWJpck9rNWZjUDgwQllHemNTYWR4NWZtQXQyNWxpTHRnVXVXUmR2?=
 =?utf-8?B?ZjhoMVlDWmNFeEhCeCtPVHpLNVZZNUJzTGxOeERodlBHSC9wMm5zSVI0K1lQ?=
 =?utf-8?B?aU1LQ3JGZS8yakNRUGJESFBWbDIxVTgwbVZUTTlRY1JXWllHVmhyZnJCVERn?=
 =?utf-8?B?N0F1eDRZUW0zQzk2ZXMveDFYQkdPMGFaR3FmUGIzbnMvL1dVWGlRcjUyOU1k?=
 =?utf-8?B?amFqMFpGWEcyMjJ6UGMxYms4YmQ0bkNPTXRlcG14Y1FKM3hQVjBWRzAvZHF5?=
 =?utf-8?B?aFppUmVncjVJdXc2UzlaT0JjUUw4ZWJnYkhPZllRS25DN0VIcGpBbktXVXpP?=
 =?utf-8?B?YmFIT1FXemdXOVlHc1l2eERJRnB1QUV3R0IxbkNEWkUzZmdUKzQrZC9vYzcz?=
 =?utf-8?B?L0Q1SDlyMzlzOVhWVmN3bmNnMmpudjE0eXgwZ0pjZDVPMGZjSHF4UndXM3hz?=
 =?utf-8?Q?P5hDJf0qwsXWQ4Rj2ksUlxg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3E40DA29581904881638CAAFE7739F6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10602
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 1d71732e4c1a4761afa3a7bfe4aabca6:solidrun,office365_emails,sent,inline:0ea476da65ac73c1ee2a2b562127c20d
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	feeeed72-ac00-425b-49b8-08de680b01f5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|7416014|82310400026|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TThZYzRqN0xrbkZtUW9ML2phWVovSmRvTk9udktkOHR6RE5RclFDSDRYZklh?=
 =?utf-8?B?bnhPNWFybzRhNVJ3M0N3UGZOcWhRUXBzclkzSjlBa0NTRTZMSHJmZzdPQjBT?=
 =?utf-8?B?QVVCTU5xMlVPY3E2MHJMNkowMHJhczE3ZlYzMWRkYkdqaWwvMys4UVNxR3pL?=
 =?utf-8?B?SFMvR2JVMERrZnRyVDI2ajRTY1YxU3daNm5qeXlrMG45K3F2Wm0yV1RjZzhO?=
 =?utf-8?B?RUZ0OWk1UUZLTjNQTVpGZW5oOC9XUXRIQTE3RkVkc2xjQ0RJM0J1M3NGLzVw?=
 =?utf-8?B?cFp6V0dTd0pidktnRFVHak1GRjErUmN4RGVXbmxNejFsaDZHWkk1MGNQL3Jr?=
 =?utf-8?B?bDhkU0p1N1Q3d05lZzVKWTFqTzc1RThwaWNFajdQL0dsd2puN25UeS81MEY1?=
 =?utf-8?B?MFpzZnZjU0dIZ1dxMHlHYVFCdjBuNyt1eENZbCtHWWNqZkZKaE50di85MTAx?=
 =?utf-8?B?clArSXZVM1JsMjdsR1E5M2lqSFFYNC80Q0Vmb2d6UTNvUE9WcGpnbVFsM0pF?=
 =?utf-8?B?Y04xTm4vYTVFWXFybzFnaldaSDJTOUwxa2Y2V0dZaDFzdUVGT21KcmFwTXRs?=
 =?utf-8?B?MUl4M3VjVmswakV6OHBkZUd4M25maGdkZXZUT3Q0aTdoYUh2dHoybmtQampv?=
 =?utf-8?B?QzVsOVhZTEgwYjN6L1BaUXpETmtHejBSVm55MTg1L2N1Zzg2VksrUUpyNWsv?=
 =?utf-8?B?L1YvbkhzNk9ZcW5tVkhwMmNqYjhaT1hyeU1lL3RaWHRTK2FoYXIwYVpyaldU?=
 =?utf-8?B?UmxVNFRNM2JhckNpMTVwZ3gyTHpiT3dEdHpsaG9xWEJiQUJCdGxWU2d6OFhl?=
 =?utf-8?B?RkZpTnNvWjllMjYyOVpyS0FXU05ZTjlHZkRIVURYaXV5bFV6TWlXRDgxUVdq?=
 =?utf-8?B?WFBFanhnY25tWmV3QlltV2pnY2lwQ25FalFuQ2lDMnNPcU9XQ3U5eFNCYU42?=
 =?utf-8?B?MW9zSmxzYk1CT0ZpRjJsOTdSbkd1dWZWTWhOam0vb3g4UWZTWUM1MmJnUHhO?=
 =?utf-8?B?UEtRVmM3elhNQjRGSENYdHVTcGxVMFBVVzFPVHIxZ0NwWlhNR2haWkR4UHJh?=
 =?utf-8?B?dnB4cUM5VURTWmdZWlcvcU5EOTZNQ2RwNlhpbXdCTXRSV3U1MU5sdjBabTJv?=
 =?utf-8?B?dFQyYVlhWWxRUjNULzVRYkhUcFp4YWV5cTFiMFBqVGc1N2p6NUxTRzFDT1p0?=
 =?utf-8?B?cVFrU1d4YmMvc2FIdElGOXpXSkdSbUZIQTJHbTJnbzl3S0VWSUNEdWdrTCtz?=
 =?utf-8?B?eml3RTVLMEliRWxPaThRd1FFSGtxNTgzZE5tc2NoQUlCNkgwVURHTEl0OEdD?=
 =?utf-8?B?YTJkaEIvU2M1czMrMDE1ZXAxOEUxa3d1Rm81SXlJNGludUcvWTFYc2x4UEkx?=
 =?utf-8?B?UXgrY1dPRlpESGdIQ0lQNGlYYWlOWHFQRFBjRmRFKzdoZVJyaVd6SmVqNXA5?=
 =?utf-8?B?UFdTVkQ0dnFDYms2a2dLSjJzNDZnczRtdTRyZ1JkbEROR3kzTnUwTEhUcmVz?=
 =?utf-8?B?NnhRNEFEalo5MStwK3kzb0VmR2l3TTlOMjk2aWlXbzZyU0xhMk43VTFNMmQr?=
 =?utf-8?B?MFdLZEFvUjBzN2Q4cFkvKzFaWGhaclY0TWtXbExNNFRndm1YcGxSYklpTlBB?=
 =?utf-8?B?R292ZG1PNjN1TUNXcUIwTlZMS1haRDUrUEt6YVBWeVIxUUN0djNsY3g1RXFp?=
 =?utf-8?B?azZPV0FiaXdBak1MVWtNbDhuSlQxTWEzaVF0ZzN2Z1BETUhQSUdXSWpIR0Ra?=
 =?utf-8?B?NkdYVlN2bXNCbjk3ZVJEL1NvWXhhclBKWDdIakQzUHVESWN6ZXpTQlRKc1hV?=
 =?utf-8?B?MjExdjhqV3M4N1U0MnBLS1RoV0pXSm9tUFV4eHlaSDRRaGtHUkRzdzVHUjMv?=
 =?utf-8?B?d1YvVXFMZmhBRm9USitSeHN3dDRCb0todHZDWStmdVFnUGYrdDVXT3NxZm5p?=
 =?utf-8?B?a2hydGJRUW5qQzl0REhwbjRUOVJDYTlVL0VyeTQxem5HZjJtSzVVbWFvbHNm?=
 =?utf-8?B?ZkdPRjcvYWtYelFZWGN1ejArWHBhQ3dwRnY5TXNVem1ZaktxM01WaVZTejVE?=
 =?utf-8?B?MG4wcHRZVXQrZkdMdkVSVnc4aTJZNzZLd2p6SVhPT1dlZmUxNi9UUkpWeStO?=
 =?utf-8?B?TVpJUEZsQ1ZDd0RtMXFNaVlXS1k1MEwvOTA2Znd4OW1vRXFsMHkxbFp6bzZE?=
 =?utf-8?B?RnVSVmtsbE1zbnZpMFBvelJkWE1XUnh0R1l5emMwVWN4KzRSUWJWZEhkMWNY?=
 =?utf-8?B?WWd6VE5FNnd4bFJYRU5OTzZyZWZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(7416014)(82310400026)(14060799003)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fArgAfnCOXVACiwbQSLaoPG23AJDrlrcAkGXglJ4AZ/DOfLIgSFNrULXRxBs1NESm3MnmbpJo7Nxxo1jXzP5rhqEeY5+b2vqitaSZbRnyjdyZr9aTn/eGZgmzlX5gJm0TK/j6ScEyWgpWxSlxmJ9oz7fVWm8L+F8Yyrw8WJZ83D30bKqw8USypj2KlrDi4D+X+IJ6CTUBi/ClHVhv+gsxcL9K2rGPV5TKhq1T3MHsRR2Cef1r5KAtdo+k/7JVF2aGBNGLptkbkPfHgG642mtKvBWwZegcLc/7LLwaBS1E0fxw+q3F4l8BwL1d7Esao2c00r2qQyOBAe/emG4IIl1kPRFTmMBGc9Nn17oXSfGf5VMdl9ST39ONj/dFKxdd+hDOTL7+l9OTABsnNymMZJevc/2zjFSabNtTG6VcIx3iVaHn80X2H4AUZPW5ss7ai9k
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:42:52.1308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e6f344-dac8-4ec3-819b-08de680b0806
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6530-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,linaro.org:email];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A916A113B9A
X-Rspamd-Action: no action

T24gMi85LzI2IDE4OjQ5LCBVbGYgSGFuc3NvbiB3cm90ZToNCj4gT24gTW9uLCA5IEZlYiAyMDI2
IGF0IDE3OjQ4LCBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4gd3JvdGU6DQo+
PiBPbiBNb24sIDkgRmViIDIwMjYgYXQgMTQ6NTAsIFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEu
c2U+IHdyb3RlOg0KPj4+IEhpIQ0KPj4+DQo+Pj4gMjAyNi0wMi0wOSBhdCAxNDozOSwgVWxmIEhh
bnNzb24gd3JvdGU6DQo+Pj4+IE9uIE1vbiwgOSBGZWIgMjAyNiBhdCAxNDoxNiwgUGV0ZXIgUm9z
aW4gPHBlZGFAYXhlbnRpYS5zZT4gd3JvdGU6DQo+Pj4+PiAyMDI2LTAyLTA5IGF0IDEwOjU3LCBV
bGYgSGFuc3NvbiB3cm90ZToNCj4+Pj4+PiBJIGhhdmUgYWxyZWFkeSBhcHBsaWVkIGZvciB2OCBh
bmQgaXQncyBnb2luZyB0byBiZSBpbiBteSBwdWxsLXJlcXVlc3QNCj4+Pj4+PiBmb3IgdjcuMCBp
biBhIGZldyBob3Vycy4NCj4+Pj4+Pg0KPj4+Pj4+IFBsZWFzZSBzZW5kIGluY3JlbWVudGFsIGZp
eGVzIG9uIHRvcCBpbnN0ZWFkIG9mIGEgbmV3IHZlcnNpb24gb2YgdGhlDQo+Pj4+Pj4gc2VyaWVz
LCB0aGVuIEkgY2FuIHBpY2sgdGhlbSBhcyBmaXhlcyBmb3IgdjcuMC4NCj4+Pj4+IEhpIQ0KPj4+
Pj4NCj4+Pj4+IFNvcnJ5IGZvciBiZWluZyBsYXRlIHdpdGggdGhpcywgYnV0IGFzIHRoZSBtdXgg
bWFpbnRhaW5lciBJJ20gbm90DQo+Pj4+PiBmb25kIG9mDQo+Pj4+Pg0KPj4+Pj4gMDI4ZWMwMDM4
MWY1ICgibXV4OiBhZGQgaGVscCB0ZXh0IGZvciBNVUxUSVBMRVhFUiBjb25maWcgb3B0aW9uIg0K
Pj4+Pj4NCj4+Pj4+IGFuZCB3b3VsZCBub3QgbGlrZSB0byBzZWUgaXQgaW4gcmMxLiBDYW4geW91
IHByZXZlbnQgdGhhdCBzb21lIHdheT8NCj4+Pj4gU29ycnksIGJ1dCBteSBwdWxsLXJlcXVlc3Qg
YW5kIGJyYW5jaCB3YXMgYWxyZWFkeSBwcmVwYXJlZC4NCj4+Pj4NCj4+Pj4gUGxlYXNlIHNlbmQg
YW4gaW5jcmVtZW50YWwgcGF0Y2ggb24gdG9wIHRoZW4gSSBjYW4gcGljayBpdCB1cCBhcyBhIGZp
eA0KPj4+PiBmb3IgNy4wLXJjMS4gVW5sZXNzIHlvdSB3YW50IHRvIG1hbmFnZSB0aGlzIHlvdXJz
ZWxmIHZpYSB5b3VyIHRyZWUuDQo+Pj4gVGhhdCB1bmZvcnR1bmF0ZS4gVGhlIHBhdGNoIHNlcmll
cyBoYXMgbm90IHlldCBtYWRlIGl0IHRvIHRoZSBuZXh0DQo+Pj4gdHJlZSBzaW5jZSBpdCBoYXMg
bm90IHNlZW4gYW55IHVwZGF0ZXMgdGhlIGxhc3QgZmV3IGRheXMuIFdoYXQgdGVzdGluZw0KPj4+
IGhhcyB0aGVzZSBwYXRjaGVzIHJlY2VpdmVkPw0KPj4gVGhlIHBhdGNoZXMgZGlkbid0IG1ha2Ug
aXQgdG8gbmV4dCwgZm9yIHNvbWUgcmVhc29uLiBJIHF1ZXVlZCB0aGVtIHVwDQo+PiBsYXN0IHdl
ZWsgb24gdGhlIDR0aCBGZWIsIGRlZmluaXRlbHkgYSBiaXQgb2YgYSBzdHJldGNoIHRvIHBpY2sg
dGhlbSwNCj4+IEkgYWRtaXQgdGhhdCwgYnV0IEkgdHJ1c3QgSm9zdWEgdG8gaGVscCB3aXRoIGFu
eSBraW5kIG9mIHByb2JsZW0gdG8NCj4+IHNob3cgdXAuDQo+Pg0KPj4gSW4gcmVnYXJkcyB0byBh
ZGRpdGlvbmFsIHRlc3RzIGFuZCByZXZpZXdzLCBsb3RzIG9mIHBlb3BsZSBoYXZlIGJlZW4NCj4+
IGhlbHBpbmcgb3V0IHdpdGggdGhpcyBhbmQgd2UgaGF2ZSBhbHNvIHJlY2VpdmVkIHBhdGNoYm90
IHJlcG9ydHMgdGhhdA0KPj4gSm9zdWEgZml4ZWQgdG9vLCBhbG9uZyB0aGUgcm9hZC4gTW9yZW92
ZXIsIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRoZQ0KPj4gc2VyaWVzIHdhcyBwb3N0ZWQgYWxyZWFk
eSBpbiBOb3ZlbWJlciBsYXN0IHllYXIuDQo+Pg0KPj4gQXMgSSBzYWlkLCBsZXQncyBmaXggYW55
IG9mIHRoZSBwcm9ibGVtcyBvbiB0b3AsIGl0IHNob3VsZCBiZSB0aGF0IGhhcmQsIHJpZ2h0Pw0K
PiAvcy9zaG91bGQvc2hvdWxkIG5vdA0KDQpJIHNlbnQgdGhlIGNvbXBpbGUgZml4IHdpdGggYjQs
IGJ1dCBpdCByZWR1Y2VkIHRoZSBsaXN0cyBhbmQgcGVvcGxlIENDJ2QsDQpJIHdhc24ndCBzdXJl
IGlmIEkgc2hvdWxkIGJlIENDaW5nIG1tYyBsaXN0IGFnYWluOg0KDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjYwMjA5LXJ6LXNkaW8tbXV4LWZpeC12MS0xLThlYTBkYTU2NWIxNEBzb2xp
ZC1ydW4uY29tDQoNCkFueSBvdGhlciBjaGFuZ2VzIEkgcHJvcG9zZWQgd2l0aCB2OSBjYW4gYmUg
cmUtcHJvcG9zZWQNCmFuZCBkaXNjdXNzZWQgaW4gYSBmdXR1cmUgcGF0Y2gtc2V0Lg0K


