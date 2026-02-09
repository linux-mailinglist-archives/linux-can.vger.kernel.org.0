Return-Path: <linux-can+bounces-6516-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M4+MqO1iWlLBAUAu9opvQ
	(envelope-from <linux-can+bounces-6516-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:23:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9AC10E1DD
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD64E302F3A1
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89082365A0D;
	Mon,  9 Feb 2026 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FDFBjhPB";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FDFBjhPB"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023083.outbound.protection.outlook.com [40.107.162.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD034D4DC;
	Mon,  9 Feb 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.83
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632502; cv=fail; b=SGzJsTNWyUKsQQFyhvWqKQ7FYRUDWj9UEql/vdNZ0QvIp2K/kAA/qNGycgyn0/MT/r9YZ/tOhmmAvLOS5LLxtBxBTcCZIl7PNrMccz//yARMXMGFT17J5+6mD2bMCaMW2koVZ2vTNZpxRq43m2bdE8BrPh5XjJIasaMYtqDxJJ0=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632502; c=relaxed/simple;
	bh=s2d/vylR/Lv4VRCWy1cxfwtj0T7MCFwry1McvGcVVo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XXxZmSueSmXEY+4NiCkF133xqoRwS+dmYoskQrNJ+dsGMdSZIvJUI4PwM/SG1hyHFg9BY/sikLxAJTPIAtQncEZ8gnMw5WcHbDSTDKe41qhoyVPiPAAHb3VMW0g8xBr8LV1kGFsn9OaZxBdpoqEiEbE9IaLmSxIT5kGLe87M9uA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=FDFBjhPB; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=FDFBjhPB; arc=fail smtp.client-ip=40.107.162.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EcrSlbcB+OlgLHvKKyUVqrNDGhHyqdLyYOTyhdLzj6mCBbNu8NMVTLbnaOQxLiNATnCB4dDoHUEjYEmfq2Pz9pjfU169YmIZhUXzaKC8LYuaw0vbOCPLbXX5J0od0gWY3QxwddPSEH6ilyjMxZ35xHyEGhv/sOMJXg7SejYTFx5vJ47RmDzIyurDejKQ6EOAW3d3PKfsj+TD2N+IvPaPHaM15pia6PbeP2+9RVN/GgfoUpKA52K/gxwSp0aCJBpoki4ymDJx5VAgwSWxToWrUVBx0prKhnAMzPGxmIriNvKWYQqTKJApPz9xbq7IegQZtfKzVyGjDXKZlA3njxEwnQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2d/vylR/Lv4VRCWy1cxfwtj0T7MCFwry1McvGcVVo8=;
 b=DdUJOkNIYBQxgc0JqNfYTIbGT8s6cEQI4GjTGzabQBxmSQ26h0KNEp+WVfdUM/RUWyBp0hkNZI9UFZBvPWyoq14G8uTjnDUXZICLzkiIo6th0uFicunCcphA3UT1g8q63Zzow07F9mCFfIjJmiuenW1LmLDVdpEXETU/tC8IexGeSBjQhm/RoVni28VPhH9W9DqCMGLBqys5MtcYn4et1peh5kVzGlO84VRtU9YUewId25M9naZEwpNG87IQa8/Z33pTDMbhgFz6BmADBjfmiZjbXgHPPjJri5btNg/xI39GtcvVLlgqola1L/cSaQSvePSurnwGABd7GsvCxm9pxQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2d/vylR/Lv4VRCWy1cxfwtj0T7MCFwry1McvGcVVo8=;
 b=FDFBjhPBoVWtpAghf/uLj1/mh9uHaenzicT6GogEiQoUcxir4WfHtjzMrvEpT6m41VAkU3rNC5AsNysIZ0XNA2WLEclJiXfAEgiRJo+LQte0c54oyU8KyPSkxUOF7dSc+iUF4wh4WpvYXEp4BPGXpooLKmiX0oculZXpZFeWC/o=
Received: from DUZPR01CA0254.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::26) by GV1PR04MB10606.eurprd04.prod.outlook.com
 (2603:10a6:150:207::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Mon, 9 Feb
 2026 10:21:37 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::bd) by DUZPR01CA0254.outlook.office365.com
 (2603:10a6:10:4b5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 10:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 10:21:37 +0000
Received: from emails-5671083-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-189.eu-west-1.compute.internal [10.20.6.189])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E4C55802E5;
	Mon,  9 Feb 2026 10:21:36 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770632496; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=s2d/vylR/Lv4VRCWy1cxfwtj0T7MCFwry1McvGcVVo8=;
 b=NG2gGH1ViS3AuHJyCl9wjs7+DPQUszi+B04gqplDA8VqjQFs7czI0GUB9+6SCU7zoIPEd
 8KmCnduHx4nmC0ke1b3rBleoTRSu/YFeb9JdC1mghRAdG0cd7V+7830eQ2nDOjVPqVDbES/
 8SYHhm9PRMbtn2up1ltV3eRtR//V3HI=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770632496;
 b=gtRkU+nvS8XYWWeOVA7MkPeoUFlBwxFeSIywXNQaBrpVtovsRBHde39Kx66yAbsBtN0Gk
 HPXXE4fUINTyHcwTIEiPUxs7kpuglqszoBWWygu8VNi8DbfANCcmrW2FJ2ysxPlt9yCVZA6
 9a9OUi5u4oapH7uyPwHkTaYb72aJM0M=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwB8rceAFOwQHKhTkE+6D83tteMUC69RirT9tXO2qGm50s8sviq5nJq3A/T1z2Gurocul33NfVsP1/aoD2cBqSI8raYg8NgbdSeYTAG6aY9nqDoLaBk4wsBtfJ4jo+lJlPg+VDf2k/z4AYodkl+F28+AMmK/FlS2rqwrh9B36caKJeJUspKGMS6AfS/hjHNsUBu/UQlAoHlAOIQMl7xO2mTmwWzcPCOx6086/W3Mc9dt3O3UnWl1acFn+EHOIYn5PDpo1JVYAaXfndTVyVXk5qbwGPWv2izdZm395c8mGOOJOOxZe9UUaHyqgPnnRhRyJm+jux01ZnHZM4zaoYyKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2d/vylR/Lv4VRCWy1cxfwtj0T7MCFwry1McvGcVVo8=;
 b=VBvK3mgHa2ercOVqT/q6qG3pW3db0dtZBKcPkwRhJUjuqF4QBuzrYMEngZ/EvL47eQ2XabNe1aVLpkBMuOD3di47hnUxiMaBpCG3ehtQOzDerf6l9VUpoiU/NIrQo6nxX4U8XwFzNBkbRxE+rGmMqcl23zAMCXClQj2yBeE3z5Dj2C6guln753LXO5Q2xeGUs/GnBmmF48mfo9Nm00u0xnGU5AyVF3m7qkcRUhPC7N7jPReCv6nis6No1vlUQB3fKwUBQCQDv8tBKvJyK0CvNMyzWIu9/xsd5gp0/2GsB0exvU+6hVqLyHsxirljOoX41ZZHBOUUfK6ZOpImkgaTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2d/vylR/Lv4VRCWy1cxfwtj0T7MCFwry1McvGcVVo8=;
 b=FDFBjhPBoVWtpAghf/uLj1/mh9uHaenzicT6GogEiQoUcxir4WfHtjzMrvEpT6m41VAkU3rNC5AsNysIZ0XNA2WLEclJiXfAEgiRJo+LQte0c54oyU8KyPSkxUOF7dSc+iUF4wh4WpvYXEp4BPGXpooLKmiX0oculZXpZFeWC/o=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:21:29 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:21:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang
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
Thread-Index: AQHcmREOqpOO6qV7AUmUzlczA9k35bV6IsaAgAAGywA=
Date: Mon, 9 Feb 2026 10:21:28 +0000
Message-ID: <f643cbbb-9e23-4e88-a2a9-01077d466c12@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VE1PR04MB7423:EE_|DB5PEPF00014B9B:EE_|GV1PR04MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: d744ea5c-15fe-4184-d20d-08de67c501e0
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?b0s0MjYxWE5HR09WOUdtWGhvSmZMVmZXK1BSNmIxSmdWMUI4QnFjVmtvSUd5?=
 =?utf-8?B?aTJZeXYwNFlCWEFQUFJpYysxdXpBcFlxZVpHTU1Lc0ZlanZMSkFwZWMrN29j?=
 =?utf-8?B?dFVVTDdPVVhmRWM1R2xRRkhKajhEY0tOQ2hYdkVlT2dGZmlHZWJtcTVoVHRS?=
 =?utf-8?B?Wk41dFZNWjJ3ci9uc1lnUEdTRlY4RncyUTl6R0FRc216S0pMNGUyM3c2WTdj?=
 =?utf-8?B?a3Q3dGl4aHdzc0ZLM2RsYjlqUXE1dnhROXd0WjQ3aEJxOHJyREpkQlV1VFNJ?=
 =?utf-8?B?SU1zSUxWUjNkVlBsTkttbHFPeGxQb0JnamZNQUl6Uk50dEFTVTJZQ1pCTXNN?=
 =?utf-8?B?aG9EUlRiQ3FTV0dTeFFRM1B5VHhMdjJvMXpQKzJ3YVFMWGxINTZEV1hrS2tj?=
 =?utf-8?B?TnRVVHNHSnFWOCswNkZzRDdUQ1JrNGR1RGRjbkZhSnY2cUpDbGV1WjM4ZUpj?=
 =?utf-8?B?bmJEb2FaNW5yV0hreWpaOURTbG4xMGtuSVdxSEIvU2NOMk15R2hKVzhGY1U0?=
 =?utf-8?B?cXl3Y3hlT3lHa0w1SVloUmR4a0NhdUpxNU9KTDFRZ3o5MXVSd29tc0JuOXZm?=
 =?utf-8?B?Q295ek9JSUk5S1kvc2F3N3VaeWxDNjM2WkZLQUxMeTlxak95ZlZuMnp4cXZk?=
 =?utf-8?B?RVNGUUNVWFdJUGsxZk0rQXN4dkFQVVNQZXhHMUNUSFRkN2RVVmtRZDBQOFR3?=
 =?utf-8?B?Y3d5MnRvcXJ4Tm5ZUE1pd2Y3QzY1WU1nTDVIeWRtZ2MyL3NIZi9qRlFQVG9Q?=
 =?utf-8?B?NzEweWpEeE9ndnArdVNQQy9kYnh5d0Z0bExaMVQzS0hnRkFPZ2pNVzdQWDRq?=
 =?utf-8?B?SUNDYzZQNnN2L0JvekFMVkJaN240UUs2VDYzOWRubDR4YlpTQUxzOGtqRklJ?=
 =?utf-8?B?QkJwakw0RHZTSUIwQjBxYWhpVlhhcFJyZEdkcGdkaXJZWWllRnR3OXcvWXVI?=
 =?utf-8?B?SXYvOVFQS1N2M1B3MHJrV0ZncVdtYkVRT3VwQ3dRSVJyYVAvVWpJUzFpU2hK?=
 =?utf-8?B?RUR2Y2ZwWjNtbytMazIrMDZ6TlFvS1hVNk9DT21CdmFWNTU2Ny95Nmtxak1j?=
 =?utf-8?B?aHFLcHZXUHhzWTJEYXhWRkNSdlYvUEEwSk5RS043cjZZd05uRXJSRVBSYkk4?=
 =?utf-8?B?ZHhiMTB2NDRqWlhGVGtDYXhWMUZWN0lmOGoxVWdFVmk0dzNqUGtrM2NTZTNp?=
 =?utf-8?B?cE41NTA4ZVE0aFdwcWUwM1lBQ2RzVVZtNzFoMS8rY3ZRWFlZd3FmTG9QaG4v?=
 =?utf-8?B?R2ViemdNQlpPbE9iZDc0K2EvemxkYlEvSE5ZQU1EM2NremN0cmNvK1FVNDdh?=
 =?utf-8?B?VzZ2MmFYY1V0bnFMMU93R0lMVmo4b2svV3o3L0hGWGlWOEtnNkY0NmVEUDNU?=
 =?utf-8?B?dFFEN3dSOVJHb1p5L25FeUtJWk1xcGhPTExzMXkyVTFXM1dpSXdHdEtXOWpF?=
 =?utf-8?B?aGJETDlZbVFBZFU3UlB4K00wY2VTZ0NtWXlrTitEVHlTYVpwQ25OK2V2eEFX?=
 =?utf-8?B?RUpNaDRSYkh0d1ZSYlJwSW0zdEo1cXJwVWJMSmo0UkdqNVNrWmthNlorYSt2?=
 =?utf-8?B?MitaTTBLcE1iQ1pYQXFjQlVtRUlTejExVmxGd0VtNFQ3UFJkTkM1MWJHaGxj?=
 =?utf-8?B?QU41cklEZlVxdkgxdjZEQmsrYlo3WEh0UzdrcEdsSnN4dnIya1ZLdUlCcmtQ?=
 =?utf-8?B?QkFlS1RTdlR6QnB0YkVVQWVUU0VrMFh6N3lJZXlES1VGUjNxYjFTVklLT3ZM?=
 =?utf-8?B?U2UwNStDb1k0aE4vOFJQcHkxRnJXSHVYL0JvN25nZTZ0b0lHcWV2ZkErWFgr?=
 =?utf-8?B?US9SSzduZUNaZXUvOS8wZmE0SnlSNFMwUDRDbHgrcHA5d0tSUmJSMjZWbCtu?=
 =?utf-8?B?VE02UkRYVFpLK2JaR05yV1hVVm84OFhMN0ZQK0xZK2RaUXBmNDJPcUtDSWpi?=
 =?utf-8?B?UTBUNWZYVmN1QzFhSUowNTZ5M0R4eWluQSt2ZzJndGV2N0Nib1RCVElJcFJO?=
 =?utf-8?B?aTZaUllQV1ErN0FVZ2lDTWptK29zdkxpUHNKZ0lac1RCSGl2TFRoSndyckx3?=
 =?utf-8?B?RHdMVHFRSDN0NU01TGpudkM0L0E1T05ib3JwRWtRWjZ3UityWWpDcThMQnc0?=
 =?utf-8?B?SFJJSjdna0JpRTZ0VEpnb1dvN3M1dldOZ2Y3SXl1K2pYNXBDbWF0NkF5VTZE?=
 =?utf-8?Q?CvjR2AGtQs1g+GAQYkvYIDU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E87DAE9BB8C5F54C8EB91E0D5B8584E2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: ecd8563f29c748b4835cdb8a226dff30:solidrun,office365_emails,sent,inline:8d66c17a0a0314c4ac1041d9580c006f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ba5573b8-d747-4451-7d13-08de67c4fd03
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1ZMcGI3WVgwT0xyUVhXYWhHbnlHOG5oY0JKbkZ3YUZQdm5qYjF5eUx0ZDBC?=
 =?utf-8?B?bmJ3NWRIc1NnM3RJenVPT0xqaFpkTUlGTjE5UjF0YTQ2dUs2bDNSSmpidGlz?=
 =?utf-8?B?OG05ZTJCcDNQNWlXdzlMWldScFN6ZnhxbFlTRDh5QzVxbGNMaThKUmxVVEdC?=
 =?utf-8?B?UndsYWNjcmh3eU1LVEdkc0FXOGxQbEdLU2ZvU2t4WXdscVZGejdGclRDVzVi?=
 =?utf-8?B?KzdWL01VN2ZwYjdadURiNVlqTjBWUHNqTHE0Y28wcUFJbjNnZlZ3dEV0Tk52?=
 =?utf-8?B?QzlSSXluZzdCbDZhbWtBNXBuUXpoaEVwR2c1VWEzNTJCL01mQTFnRUg2OGhv?=
 =?utf-8?B?ZnY5clJTelJrc2NCa3pZT2M1R1ZsalhyMkQzeldoN2ZCQ3FxNWtGN0k0dTYv?=
 =?utf-8?B?bDFwcmRjd1dJYWdiOUVZT3lvWjBWWFVJZHFjRmFGZFM4M0dqak9zcXcxdDZX?=
 =?utf-8?B?Nk9HOVFhbG1yM2VQc0hrSXg2UmF1Z1pvVEViVExXaDdOUWdZOVNLRldFUUxC?=
 =?utf-8?B?bWwxYXVvaEx1QU1WRXBrenF2MXc1R1BpM212MWZpMXVZc1FVK01ncHlMU0M4?=
 =?utf-8?B?ZFcvTWtYT0E3L2JuM1loTWhFSkp4bXFnRG56WGR4WWtRUFEzOExiVW5jUXIr?=
 =?utf-8?B?eFVlMFFid0tCNjdJeU1IMndmNUVBSmprdkVSVVFuMlJMMWE3aS9qUzM0OXFt?=
 =?utf-8?B?UUcyWDhqSFJBMVh5RUp0Q3lqRzJmVmVBUjc1eiswblNieDg2SVRacVJzRU9m?=
 =?utf-8?B?MVpYTUpVcmVuWkJqeTZXWHNhenNtQTNDVUt6S3VqZmI0eFpsd1BqRVhUeHRs?=
 =?utf-8?B?RDJNbEdUcmp6TWJuZFFhT3NQSWpZZlA3YkptWWRuN2drTlEyOHU5Vm4zLzI0?=
 =?utf-8?B?VG9DSUQwWmtSaGFDZ2hSOEhxMk5EWG4zV2lSUVNXcE4yZ3NvQmhXcjNSODIy?=
 =?utf-8?B?MG1NS2xGQXBzNDRQL0hVV0t5OVAyRTA1cEF4MWhNN1Z3Y2x4QUpCU01hcHls?=
 =?utf-8?B?TDlMK1RPTmYyZ1kwaHVybURHb1YyY2dSM0YreitNZWlEM3ZoOU1neWVqVUtG?=
 =?utf-8?B?Vzh5SzcxMmo3NWwvYmFpcVBFSVNpc3Q1ay9UZzdzNTRuMDg4Mms0cW5XSnZ6?=
 =?utf-8?B?MVR3eDEzNlYrVjlSY2JuY3hPRlFDMlRieDFTNVhNcU9za0lLY1lVbGovOXhT?=
 =?utf-8?B?NmVHRlpyWmZ3T2FFQ29UNHRqc3dFWjNhT3VISmw5VmtjK3R2clUxWklXZ1Yr?=
 =?utf-8?B?bGs0UkpYUnNkd0c1aE56MUN6V01aMlBhbWp3YUZsdytkWlVMN09pa2lyMloy?=
 =?utf-8?B?cFVzRGUzTXlKbmF4YXBNQ1cyTUZSaWJuSlBEYThVZnBLdEt5Vk1WMVA4bVVE?=
 =?utf-8?B?R3puRW02dEF1SVZyME4zc0l6R1dDSzBxNDBrdElpZDk0ZnRlSm84ZFI5clE2?=
 =?utf-8?B?VE93RzB6bWJhaG9YOEpicURNOTFkUkIyMjZ4VXFwMDNjQ1VCK2FTUExVR0xp?=
 =?utf-8?B?TnBSeTRGWTRXQk42aW9DUXVjV1JSUXpmMkJMaUZzc3l1TnNGYlhwcitzMEdQ?=
 =?utf-8?B?ekFMSTUvaWY0SVJmdUxoczNXQytsQ0pJeTY3OThIRkRjb0hoY0lWQlFnNGFw?=
 =?utf-8?B?UXZueUVpTDM4bWJ1T0M3N3dqMFlsTzduRk1lWFFuais1RUtocHJ1U2g4WGl4?=
 =?utf-8?B?QnpBUlprUDZtR1lrVVBxYmpWYVFmVWZJdjVtTDJsUHBjQk9qSXhicEk4UGdT?=
 =?utf-8?B?OGI3bmExVWI3VWVGaXJNcDVKQ09wUXJqYTl0N2NDUVdkbzF4YVZIeGpQUVNt?=
 =?utf-8?B?S1dYVkg1WFlzWVNjQ3FVREVuZ1hvTFl2M0lmQjBIRXBiUWFWa1M1M2xtRHc4?=
 =?utf-8?B?d2VFUWYrcitoQ2NiY3JTd1JtdDE1TkRpYnBQTGRMY2NuKzZLVWN5V1RPM29I?=
 =?utf-8?B?MVMzR1N4WXIvNXE0T3BOY2NPZ3hpaWNYc3hqSTRCSUZ2aUZjNGNLZEJ4bGxJ?=
 =?utf-8?B?RHpiV2NaaFExbFZQVEE2SjNmbHBQUk1IZDNoSFBubDdIaTBtTFFXd3pVbTl6?=
 =?utf-8?B?eWRNTXBqcVlvREVlSXZCWHZtaEJZaDlIelZ6Q0xZSm5pdG80RGdmSjR0cnRI?=
 =?utf-8?B?Y0QzWGRBM3U1NWZMV0NFV0RhVyswdUFOYWVZUllzQ1Y4R0tzbWNLVzFMVGFi?=
 =?utf-8?B?UDhucFM4RHFzQkJEYjYydzFPN0l5cVU4cFFoa2RUeFU5Y1EvWlF4YmQyYk5k?=
 =?utf-8?B?R2tyWTh1OHRXdHgzY2NlNXFybEF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(14060799003)(35042699022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6S2bvggONtQ1GCHbyLYqGZC3olnyDdrwioV6d8Rsehp3vxmwKcvbgvIX6qiEoc8Kg4ZwZZzAfURvbYOVh3Nn3K7+GWtPgsocN64xfgOXhpgKYWzFr90EIO/Q6iHmPjoSSed9LicKt4Rz3r1XGPbqefDo65BnOme1WW7q8n8W5nzC4T69em+M3lw/uuh6wTkZ8yiwLy8rYfzA6I1t62ItMfW7pMDgUNzZ0x6l/DOHkQL1DNy8Ut4E4roSQgCt+yOSBIWJCc3+wjf26fHRMuh9/NHIBsr9t7yBpod/G3Db2Bwl2kCEnNQJYxbJFOoUqFJPSILT2GKeMv9HMbttPCQkUiRqcBsLw/CBGBnQlX0cdwAT1KPjToDlay+z0x8EBk+MMdK3Im6cyXR3AV8FU16E6TTtoWx8V6DpKzNJXizm4pukv1VMihV00ewWu/mujIU8
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:21:37.0476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d744ea5c-15fe-4184-d20d-08de67c501e0
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10606
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6516-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4E9AC10E1DD
X-Rspamd-Action: no action

T24gMDkvMDIvMjAyNiAxMTo1NywgVWxmIEhhbnNzb24gd3JvdGU6DQo+IE9uIFN1biwgOCBGZWIg
MjAyNiBhdCAxNjozOSwgSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+IHdyb3RlOg0K
Pj4gU29tZSBSZW5lc2FzIFNvQyBiYXNlZCBib2FyZHMgbXV4IFNEIGFuZCBlTU1DIG9uIGEgc2lu
Z2xlIHNkaW8NCj4+IGNvbnRyb2xsZXIsIGV4cG9zaW5nIHVzZXIgY29udHJvbCBieSBkaXAgc3dp
dGNoIGFuZCBzb2Z0d2FyZSBjb250cm9sIGJ5DQo+PiBncGlvLg0KPj4NCj4+IFB1cnBvc2UgaXMg
dG8gc2ltcGxpZnkgZGV2ZWxvcG1lbnQgYW5kIHByb3Zpc2lvbmluZyBieSBzZWxlY3RpbmcgYm9v
dA0KPj4gbWVkaWEgYXQgcG93ZXItb24sIGFuZCBhZ2FpbiBiZWZvcmUgc3RhcnRpbmcgbGludXgu
DQo+Pg0KPj4gQWRkIGJpbmRpbmcgYW5kIGRyaXZlciBzdXBwb3J0IGZvciBsaW5raW5nIGEgKGdw
aW8pIG11eCB0byByZW5lc2FzIHNkaW8NCj4+IGNvbnRyb2xsZXIuDQo+Pg0KPj4gSW50cm9kdWNl
IGdlbmVyaWMgaGVscGVyIGZ1bmN0aW9ucyBmb3IgZ2V0dGluZyBtYW5hZ2VkIGFuZCBzZWxlY3Rl
ZA0KPj4gbXV4LXN0YXRlIG9iamVjdHMsIGFuZCBzd2l0Y2ggaTJjLW9tYXAgYW5kIHBoeS1jYW4t
dHJhbnNjZWl2ZXIgZHJpdmVycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8
am9zdWFAc29saWQtcnVuLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2OToNCj4+IC0gY29t
cGlsZS10ZXN0ZWQgb24geDg2IHdpdGggTVVMVElQTEVYRVI9bS95L3Vuc2V0Lg0KPj4gLSBmaXhl
ZCBLY29uZmlnIGNoYW5nZXMgc28gdGhhdCBDT05GSUdfTVVMVElQTEVYRVIgY2FuIGJlIHNlbGVj
dGVkLg0KPj4gICAgdGhyb3VnaCBtZW51Y29uZmlnIC8gLmNvbmZpZyBhcyBpbnRlbmRlZC4NCj4+
IC0gdXBkYXRlZCB0cmFpbGVycw0KPj4gLSBkb2N1bWVudCBudWxsIHJldHVybiB2YWx1ZSBmb3Ig
bXV4X2NvbnRyb2xfZ2V0X29wdGlvbmFsLg0KPj4gLSBmaXggYnVpbGQgZXJyb3IgZm9yIENPTkZJ
R19NVUxUSVBMRVhFUj1tLCBmb3VuZCB3aXRoIHg4Nl82NA0KPj4gICAgYWxsbW9kY29uZmlnOiBy
ZXBsYWNlZCBpZmRlZiAuLi4gd2l0aCBpZiBJU19FTkFCTEVEKC4uLikuDQo+PiAgICAoUmVwb3J0
ZWQtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4pDQo+PiAtIExpbmsgdG8gdjg6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjAyMDMtcnotc2Rpby1tdXgtdjgtMC0wMjRl
YTQwNTg2M2VAc29saWQtcnVuLmNvbQ0KPiBbLi4uXQ0KPg0KPiBJIGhhdmUgYWxyZWFkeSBhcHBs
aWVkIGZvciB2OCBhbmQgaXQncyBnb2luZyB0byBiZSBpbiBteSBwdWxsLXJlcXVlc3QNCj4gZm9y
IHY3LjAgaW4gYSBmZXcgaG91cnMuDQo+DQo+IFBsZWFzZSBzZW5kIGluY3JlbWVudGFsIGZpeGVz
IG9uIHRvcCBpbnN0ZWFkIG9mIGEgbmV3IHZlcnNpb24gb2YgdGhlDQo+IHNlcmllcywgdGhlbiBJ
IGNhbiBwaWNrIHRoZW0gYXMgZml4ZXMgZm9yIHY3LjAuDQoNCk9rYXksIEknbGwgc2VuZCBhIG1p
bmltYWwgcGF0Y2ggdG8gZml4IHRoZSBidWlsZCBlcnJvciBvbmx5IGluIHRoYXQgY2FzZS4NCg0K
VGhhbmtzIQ0KDQo=


