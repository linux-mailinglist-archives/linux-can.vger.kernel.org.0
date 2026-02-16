Return-Path: <linux-can+bounces-6553-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA11LifTkmm6ygEAu9opvQ
	(envelope-from <linux-can+bounces-6553-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 09:19:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D723F14179D
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 09:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7485730011A6
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D180B2989BC;
	Mon, 16 Feb 2026 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hxEoSRs/";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hxEoSRs/"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021075.outbound.protection.outlook.com [52.101.65.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44172620E5;
	Mon, 16 Feb 2026 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.75
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771229985; cv=fail; b=D7Z28LsyFWKY/YRi4HJqm6tzcf4aqqVO7Xwdcjl9qffviBXBS8Wyy9+7Ur+MDGYBeDeffHccKyA2D7EO9gTF8HDOFg+DOd15ecMXHuBNUu2CWxMRw+P+cOcF2axshcrizXAOECXBl/nSUldaiFgRoEBuIgpaJ/OR/aveIjw+93c=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771229985; c=relaxed/simple;
	bh=QVI2KTwPS7kMw/1p7xetTl0i2J+N/urUa904C2DVq9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gj9pNxb3pIHErw5muXnW4iXu8znHv54LGo3ANi8xKrx/+KYFzl5kSz4jqIE1kZ/PpzMan7Pu6WL7FF/sYiQCqxz8GDoSDZ616XubzGto1S3P6J6Uc4maCmsyiWyPQrJvwvOrlhytYRtYt85exBlfbP7IZMx0QEMlw4MCVL2QD/U=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hxEoSRs/; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hxEoSRs/; arc=fail smtp.client-ip=52.101.65.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ffVOwTLo5eXsOC9fCe4wzug5bWI55bNDyBLNBNq65hYgycwY4MnjUagTvUe8WqQ0ziqscVEvkNcZNWTl0zvaog94wpl5ZwORO+TzWCxVorA+pNGh0O/ggdhqZDuS/Hj6m0IB5FO/mhVfE376BeZHOPsabEeDq6FapQ6KNdDdq/nmpqFA9KEqt+iIBl8wv4XIZPj3B7jCcoy8i3/7QgNoe/61Ei/Bb08ZobKBXBlh3jzUR3bSOsH0ua4lEj5C5GpTHUohuVKgcpOvebq1kS/sUKQ/Q3hKF9wucfA7PcU3kWxBYDzoRaEiFZnDs03L/v0PX5OYd7N4n1tIk9/ghM8YBw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVI2KTwPS7kMw/1p7xetTl0i2J+N/urUa904C2DVq9M=;
 b=jAZndEvsUeaoHvLE6a/XkvUxTvdCRChW/8U95maEn+XnKLz6Sj/b0VDvKNmAoATmxfV4BuSI6AEJoPOcCFFlAK/a8YMCqAM189Ynvydjbabc3b5Nug8n9qWldOD+10LbFCiKTUFr9HdKf68dPOvOnvWqqEv2qM/ga56T45puj8EMdyvx94XGnpH2j7boFKMrn1m0UzqwQoS8kXbsKmWZTepvXhly0gzs2KQDDGytiXihXS5gEd8F0dZoPXlA8gH1H/2UgQu3rlF9ox33aReC4wzM+VXjKItY316VlQREaalB0u3nIMwfcNYjtt3uAXzAFeYer4ZyZ0PRz1uT+9ob5w==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVI2KTwPS7kMw/1p7xetTl0i2J+N/urUa904C2DVq9M=;
 b=hxEoSRs/we3JAp6hSllcHOQpRueYdhAGH+UIYUVuC4CFVdMwQoe/ua2bdsU0hC6bO5te4efPkkABk/CRBeHRyQZxiFQZIiLCvnPOvKsdL5CXl/JDNtsKjogrxjLwcoeSNN2XuKtsJTTr3lT6yeCBcIQXw1j/NCsycZuKnO4HqTQ=
Received: from AM0P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::20)
 by VE1PR04MB7440.eurprd04.prod.outlook.com (2603:10a6:800:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:19:40 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::1a) by AM0P190CA0010.outlook.office365.com
 (2603:10a6:208:190::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 08:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 16 Feb 2026 08:19:39 +0000
Received: from emails-6538875-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-134.eu-west-1.compute.internal [10.20.6.134])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 084E1802E3;
	Mon, 16 Feb 2026 08:19:39 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1771229979; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=QVI2KTwPS7kMw/1p7xetTl0i2J+N/urUa904C2DVq9M=;
 b=n6MM3Fk5iVktHwGCMjrVcrGQDEHwfNiFtUrSGekxiFlK7n36aCmhKqRkIVJynxnca/ctH
 5KZwDPr2Q4pr/HazxRQuxudXn72ZqZG5EQ1lfYCP8rPKi4k6L/2b9DRIYXCgHB0ePso4PIr
 DFbgpZTH9iZ1WRw2YolWNpFsv9ShqEc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1771229979;
 b=GynPLI7fcuPiBCRuX9GyCI4sfWdXmBtA3LKZYzqF1h4HyMQHASFwqdaKN+QsLI+3pe5xv
 Ru/dWgMjVAIMeMoleaxkiUnDf/9tcHT5YLdc3/PdIcb5R6JzbqA7YkodOMEyUzQApPWTrAP
 OHnzs6YmTMMFMhtt1GE4Bb6KLIMjE0M=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhZiWhKptMMLfTcWzYixo3iR9Z8w1waYnQgs22GdHQD9MG8+vUwI2UxafBaO3dzTWG0DkeCo5WvAEbXNl/dr8+lDdS5VAqmDtDhOSbcUcd1JgYtFxeBw12QT6sbysTsUHTFkQ83oQZMn7MrCviaO8VITwezugYF1iabvY6Kx0jF8sQnuKQ7gxUI0A2/bpoQKFTk6spuwCP5Ppn/xh2L4wkxv3RUwdcIlX0RukP7daRE1On4e4KGIWoazRok+tuFPEbM5sKq6HCE95OZAC3DUAC/dF+fGsdKkLOrzUvtHqkyQJHF2JgLe67/0fHYtsjocgpbMcYXve6EDdYi5HdEBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVI2KTwPS7kMw/1p7xetTl0i2J+N/urUa904C2DVq9M=;
 b=fxk2reQ8M8qTd/CPreiRt+Lqj80zwT6hzewGfdw9spCiMweJ0sbk0xqMkZWJ1CqiadBoWAhloOyhnDvoql4t8tKDZZkhyW1zoAI/Q+2Aq76XA2h8biZw/eUFZXc1h1eo+2nJjaC3SLz9CH2yWmSB5VU84A+Lhp+7+ZkoOPkuzM5vf9MVcHjxO77siIU6762g21m7VGnv75p3PxzyqB8omM4MHpuaoNSuv/qOk9IFWTnpPYCEuYdSAxTbNm8CX6IEwq9IiQp7tDW6t8ovWftFH8c/7ElNUVn9FyacUQXrx3pSEhSLeDzw1Ia15k6COZBcngGeUKVf/PMlTN4/ZnGl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVI2KTwPS7kMw/1p7xetTl0i2J+N/urUa904C2DVq9M=;
 b=hxEoSRs/we3JAp6hSllcHOQpRueYdhAGH+UIYUVuC4CFVdMwQoe/ua2bdsU0hC6bO5te4efPkkABk/CRBeHRyQZxiFQZIiLCvnPOvKsdL5CXl/JDNtsKjogrxjLwcoeSNN2XuKtsJTTr3lT6yeCBcIQXw1j/NCsycZuKnO4HqTQ=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB10739.eurprd04.prod.outlook.com (2603:10a6:800:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:19:28 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 08:19:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Vladimir Oltean
	<olteanv@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
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
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Thread-Topic: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Thread-Index: AQHcmREPlBYTghYn+UKFA/cQGR2iuLV/TKqAgAABVACABbnOgA==
Date: Mon, 16 Feb 2026 08:19:27 +0000
Message-ID: <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
 <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB10739:EE_|AM3PEPF00009B9D:EE_|VE1PR04MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: aabf3499-a5a6-4301-fbcf-08de6d342132
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?blh2UE1xMncyQVdncHdqejcvdURxblBxREI3KzBPdk9OeEtqMWVSVXY5N1h5?=
 =?utf-8?B?VjhFNHpJbmlaNHo4U3RDTnp0cEx5VzVxalNiNU5IQjRpYTBmSFVDeUlERlZV?=
 =?utf-8?B?VzBKbm9RR2JHeEpwYjlkL3A4cW02OTZhVG41SkRqanVFVEdsMHBxM0tFemh6?=
 =?utf-8?B?RjFmUUNDS29GOHg0cFY5NklqVVpSMDYrL2hOUHA4QVd4ZTJNMmRyczF1Qzgv?=
 =?utf-8?B?N2J4N3JhaEJ3QXk5N0NTUVNkYVFZZGVuU05kbkZ3ZUt3OXdwd3lNTS9VOC9a?=
 =?utf-8?B?Z0F5NWpraWliQitMZnFHQWdGWlpwa0dJUWhLRTNxL2VRNldjYlBsNVhVYWZK?=
 =?utf-8?B?Q2dwWmFlYnZyVTJhOS9PcVpkUWk4SiszNTkrNitkeHcrY2ZiWElnb2puVUxn?=
 =?utf-8?B?OFM2OVc0OXA4Z0c5QWh0QWt3OWVmNDZFMWFBZTAyelUzMEVKTkxJKzVWNGxT?=
 =?utf-8?B?ZkljTm4xbHVQbjZtWW12UVk2UVQ1Q2VOVURkOWlkVXVwOFArSEtZdWVuZG9R?=
 =?utf-8?B?WDVQVVBBcitHc0NhUm5aam5OckdJZHZ0anE5RGdudzlDbkY3c0NFZFBPa0hp?=
 =?utf-8?B?UWVmdDlXcndsWWZBcmVEY2tUWjJiQmo0SFhlaHlQMFJHWGx3M3dZREhEKzc5?=
 =?utf-8?B?aldRa2FLb0VuTmJPeTFuU25JTWlEOC9zUVNwdEVkdUhRK3BsQkNuTUJFbE55?=
 =?utf-8?B?enVoQk92T3dlVGwwYnJPVzdMMXBCZm03bTZmYjUxU2EvSnZXeEUrYWl6aFNz?=
 =?utf-8?B?Wkk1ZUdiUHBYNlJWa29VRVZ6VmN1aE5PVlIyekVsQmJEa3FsUUVZRUZlcXBv?=
 =?utf-8?B?UkZkT3FSTWVibDVVMzVjQTNnTEpQYzh2UkNSazV4WlF5bUF1cElVNExSSTBN?=
 =?utf-8?B?RlozL29xMlVBdEdrdmlsUDRCU3E3UlBINCtIZnhHM013VUordVhHSmRmbUx6?=
 =?utf-8?B?UWlpTTRpbnE1eDhxSENIaUFsTG50NkU0eXBpNFExQXJ4VWdYR0F2U21weGky?=
 =?utf-8?B?dnpIQ1ZSVitPRDNLaTlzYkFFK1dBaUhxZFdGL1ZPcStwZW5ZWm1jVko0RWgy?=
 =?utf-8?B?SlVnM3VDSHNXMEI0RlVkZDY4VFpDdzJXSmtQMW9yVkxzbTdmbXJsZGVxdHZx?=
 =?utf-8?B?U0FZNFA1U1crWWVrVXhkTTh1cmpJVHNEYlBOQ3hxN2IrZU1GSi9TaTR5aVY1?=
 =?utf-8?B?UFhKZlRtTWluUXI0THlYSENFNzI3Z2loVnY2eTBGUThyZUdabXp6Y044U0dK?=
 =?utf-8?B?SEsrYjY3NDJIUFNuQklZdTY4Mk9KdEVJZHA1WlZpWEJXR0F1OEMycHBSc1hG?=
 =?utf-8?B?OFZaemIrTU9mR0lKWDAyTWxNcUtLMVhpSmV3NCttTEROL0J5NGJWR2hqRXFR?=
 =?utf-8?B?aE5NbGVRazR6S25mMVBqK1VXQldWSXRKcTE4YmlCSkpHQnVNTVJkaGV2aDVq?=
 =?utf-8?B?MlhJdENtMzZ3aERiZDVHL2xHc2xzdVBPWnk0NnNPaHBhL3FmY0xTS1dJOEhI?=
 =?utf-8?B?QytZZGZYMFJRNHU3amVlVkkwdFNXdEU5RSt6NEVrMEEvM0NsZU5aaW1YdVRJ?=
 =?utf-8?B?WXo4VWJlSllGMzVLczJzVU9mNURic0EyaXRTbm1BNWdGT09lTDFIMFo4Rzlx?=
 =?utf-8?B?MHpzTHkrOHZsTm13V3FTTXJBN0tHNWc3NUxEcHd4eXdRei84UXpDRGE5M3FS?=
 =?utf-8?B?TEpuU1AvbHRSY3RLeWNIQ2RRcldJR09ZcldoM1VxRmluSk9WaWNMUXVETmZD?=
 =?utf-8?B?SEhhQ1hyQTF0NCtCckxwck5JdnMxUkdCMTZjSlhVUFMxZmk5RGdocVBUejB4?=
 =?utf-8?B?RHN4T0FZYnlVUzlLYi9BeFZCdmdJd285dlI3M2htbkU4NFdQNjR1WUl4UlBz?=
 =?utf-8?B?KzhMdzlHVUdnQVdRcWRITmJQZ1ZQTWZDZUd6MHp0Tlp3K2xZWEN1ekp6aTEv?=
 =?utf-8?B?aDBQMWtuNy9KWlc2NlREcmdWbk8zQS9hSXI0Ty9IUkpyQnJPQkxicEFYVnZ3?=
 =?utf-8?B?eDBZSkF2NXFtbEMzOEtXOXZ2UkNhQUNDUzUrNmZrNGZlK2R5VG95cWxmd2Yw?=
 =?utf-8?B?eS85QjNCdytVMHErMmRwTkpwU1FaOHZBcENDbkxyM0ZHRWVsdUZGUnlrcjB6?=
 =?utf-8?B?cGx5WG1ycFJ3RnBVTkZoOW9tZDNXN2dTQzBucjlxMHlleEVlL2pzNXNZdnY3?=
 =?utf-8?Q?t0rmP7goo6wphrnf7g/Q1ag=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <F46D7B5D059C984E8A15804A3621BC1A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10739
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 7546c8e625f44103abec821b691c85aa:solidrun,office365_emails,sent,inline:c0852e679e960787a3120466a88f665d
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6f994d8e-173d-4b18-0027-08de6d341a3a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|14060799003|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTZqY0s2emtjSnN4dXlKelBHRXdjZFdiL0djR2RqMnhiSHBiRWNLRktQVGZt?=
 =?utf-8?B?MURSVzNOMnFCUHFMcmxuTC81ZDREakhwZU5HZXNjS3lqSEZvRUxXUnREeHdt?=
 =?utf-8?B?M2t3djVNeU9kcC9yWGs0UUpmNFNtR0lqQ1JoTGlRVWZmTXM1bkFEOG9DZ2NM?=
 =?utf-8?B?NDdNNlYxVXNmcm1mRk0vT2RKaGJEQ0NmWUhEVXdtbGMyRS92cEZyV0puSFVG?=
 =?utf-8?B?SFdibGV3dExLaEJLWHdTSFlDNlpSM2VzQTlyUEFtTEkwWWZ0QVA1Y1ZVMWFH?=
 =?utf-8?B?SFFzNEd6TlhTRUFxaHFyZXIzT1JIbm01K0s2d21CK3VwcjdDd0FCOTJhZDJT?=
 =?utf-8?B?cW8yU1kzM0twT2lFU3RjS1M3bXlzZ3A2eTNxdXgrQ29FVFp2TmhLS2pSRmJ6?=
 =?utf-8?B?bW95S1h6SEdua0tES0V0M0ZIMjNqdDJEOCtZVFpsUXZVSlhKTDkybGNJdGVi?=
 =?utf-8?B?QVhQZDNyZFRhTW1qcm5lV1dOYzA3Q0VhdmpvL2JxQkpSZXNlVHBLV0cxd0sr?=
 =?utf-8?B?SHFYVStucXoyaTZISEE4ak5JUEtaZ0g3Z1l5bVpPaTNyQnU1NmVRbFpET1N3?=
 =?utf-8?B?QjFhYU9ma25IVFdDWkUyVkFIMmFRdGZTOVNDQzBSVlBWZnF1L1l4eXliMmN6?=
 =?utf-8?B?SzYzZEg5Q3EzWFJzTTRyVmk0QWM0Nm5hUzhJVGNpL2U0SVMwVUllZ1ZkMWZD?=
 =?utf-8?B?TDRSMnZ5NDVSVW15ak5VVDFlTjcvVCtXc2ZydU1DRkh1VU9STXRRc2x2NXBz?=
 =?utf-8?B?MUhPTnJuZEVlc2dVWk5pTEhyd3h4T09kbDlKZ2JZTTN5Q3ZzNSs2N2syYXpu?=
 =?utf-8?B?OTlxbEVTcmFqR0pNUzVqVlUva0RlQ0c5ZlAxT0NacGRZR1RvL2pIa1NodzNK?=
 =?utf-8?B?RklYd1NWQk9XVXNXMTRXR0hjd3A5OGxmT2Z4MTVPZS9vWWdYMkczZEFHblpI?=
 =?utf-8?B?QzhRemtZanA0TytMSHRtc1NNU2NZWkUwUWRESnlEbUxGeisxNXNadGcyTjJ6?=
 =?utf-8?B?REFuUXJrK05vbWtWSWlhalR6OCtZSk4zTG9lMUlhZHhhbUlIZDJwWjBsVk5u?=
 =?utf-8?B?N21YcmhzOEw2czhQVlZ6RjhUVG9TbUJYb2NIWUQyUzk3b3hldVhwQ1NHU3o1?=
 =?utf-8?B?bEs1dU8xS3dGQkU4dnNjWGxiaEtxVE1EZTNyMzlwK2w5MW1rR3ZRZlIweW1D?=
 =?utf-8?B?M0JGRmc3cEVESDJhb0k0MThDTkFmbTlWL1FBdksrZnZjemQ3UFhqQjljZkls?=
 =?utf-8?B?cCtRaEJra2o3ekNWQUxWZmdPRFQ2SytOWHF0SHNvZElZUFdkN0F5dUxWY1hM?=
 =?utf-8?B?SEx3eUJsdW9LL2M0dEw5T3RFWDVsTmsrOWlOaVFpMG9qMHdCRnhhSktaWGpW?=
 =?utf-8?B?cWJ2NWVaQlkzb3RwVW9aQmZtRGIvSEovRGNhVUdtOGRkODF0RkN3ejVHaU5P?=
 =?utf-8?B?V2ZmWno5a1MvU094SU8rOG41ci83UXBjNytuSkErR2JER2RKc0lZcC9IN0cz?=
 =?utf-8?B?ZitVTGJFbkVnV0d1WXM2bU1zZGZSVjhlWUgxMGxzRERQZ0dJei9DaVJPU1F1?=
 =?utf-8?B?UWthUTBMRm00OFI4bU1CUmtwMXJXS2NEaFJsZmI2RnducDZJT3RzdUFXMWlH?=
 =?utf-8?B?MXdYZjJ3OG1PalBSMGswYlJrRzdpaHhRTFdvSFhPQzhsakxxY0F5ZXhycG83?=
 =?utf-8?B?dkFmZ1RmbXBJeTNHS0xnZXpxZ3N4djZsOHFIdzFwWno1RmxacDVYamFUY1J2?=
 =?utf-8?B?NnFSbHlhWkI1MzM3YkJrdWM0T01RWGRSdlJRSzNUMFhLTXM5WHpvcHkrU1Mv?=
 =?utf-8?B?OFJkcDAvTFVlZGE3am5yc3VwTjJGZTl1dGJwM0J3Z1ZhSUdOWGpoVGhkNEhI?=
 =?utf-8?B?SEpwZjRQVm8rRElPZWZMVnlucUJQaDRXNURaU3lHUjNNK01ONHYrMVhvOFZ6?=
 =?utf-8?B?WmhOdHBlbk01cjJOUkdXQjU4TFZPbU5LL0dUQkZkVStVMCtwbGY2eEFCNktj?=
 =?utf-8?B?dE5ibDdJaXVRdWlVdC9PNUI5QlFiZ1dqZEh2M1FXWEIvaEUwNWVjNDZUUmJo?=
 =?utf-8?B?VmZOTG1LQ0g2bUJSMmwveXBuNERHSWxQdzUxS3hBM3IzTjF2TDR4WGxLSk90?=
 =?utf-8?B?c3ZVY0N2QmdvclhYVTdISEpnQmw4RkhyeUhXMkVvRzRMUEhTUXdVYWt5MG9v?=
 =?utf-8?B?L1NyNzU3OHlTdzBxaFdjYituaEpXMUNFSmlXQVR6d3R4a3g2bExJR1YzaWFZ?=
 =?utf-8?B?VU5OaWR0dDRpOENWQjltN3RMUVlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(14060799003)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lAjmAvMF7TrbZEVmfg5Fa1uEWLBRqwGIFtPljlLtNj0kZLW7h8fJCLrMMoEMmH0ehuowcR+hr3EtrEgvbwP3ss0/vfIeMrFJepvTkOyxjv+BEEBSOrBamfD/pUfVT9dpm7j0AEhuOnh1BGQcmIo+YbSFnY72vb/4oFD6RAcBa9ycO5Dv4UMiV/dHUMz7oOaFXjGpGViUX5AUP6+10NvnqcamSyxNICNzgOxAEhVbJCUpRuZ3KCFSV4o68eUXl6CJdD4pVAxW+iLBAoPOghPK44b8AKebvy+GR58bZrvTJAw/x3r3rxkZBTb5JvH6IrWV3oBzv6zcYWvrAzUsU3skpw3gT3MSx83sbREZdvIFmtYCR+m1YXlz269KRpyhZHq+lcJHuGKpC49p6bXhcrap5CpF1IERXdKEe4jfBKzXEPUSe+u/f2glnYc2EXsM8uC1
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:19:39.4860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf3499-a5a6-4301-fbcf-08de6d342132
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7440
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6553-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-m68k.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sang-engineering.com:email];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D723F14179D
X-Rspamd-Action: no action

SGksDQoNCk9uIDEyLzAyLzIwMjYgMTg6NTMsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4g
SGkgVmxhZGltaXIsDQo+DQo+IE9uIFRodSwgMTIgRmViIDIwMjYgYXQgMTc6NDgsIFZsYWRpbWly
IE9sdGVhbiA8b2x0ZWFudkBnbWFpbC5jb20+IHdyb3RlOg0KPj4gT24gU3VuLCBGZWIgMDgsIDIw
MjYgYXQgMDU6Mzg6NTZQTSArMDIwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+Pj4gUmVuYW1lIHRo
ZSB0ZW1wb3JhcnkgZGV2bV9tdXhfc3RhdGVfZ2V0X29wdGlvbmFsIGZ1bmN0aW9uIHRvIGF2b2lk
DQo+Pj4gY29uZmxpY3Qgd2l0aCB1cGNvbWluZyBpbXBsZW1lbnRhdGlvbiBpbiBtdWx0aXBsZXhl
ciBzdWJzeXN0ZW0uDQo+Pj4NCj4+PiBBY2tlZC1ieTogVmlub2QgS291bCA8dmtvdWxAa2VybmVs
Lm9yZz4NCj4+PiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2Fz
QGdsaWRlci5iZT4NCj4+PiBSZXZpZXdlZC1ieTogV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0Bz
YW5nLWVuZ2luZWVyaW5nLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9z
dWFAc29saWQtcnVuLmNvbT4NCj4+IEluIHRoZSBmdXR1cmUsIHdoZW4geW91IGhhdmUgYSBzZXJp
ZXMgd2l0aCBjcm9zcy10cmVlIGRlcGVuZGVuY2llcywNCj4+IHBsZWFzZSB0cnkgdG8gdGhpbmsg
b2YgaXQgYXMgaW5kaXZpZHVhbCBtaW5pLXNlcmllcyBmb3IgZWFjaCB0cmVlJ3MNCj4+ICduZXh0
JyBicmFuY2gsIGFuZCBzcGVjaWZ5IGNsZWFybHkgdGhhdCB5b3UgbmVlZCBzdGFibGUgdGFncyAo
dG8gYmUNCj4+IHB1bGxlZCBpbnRvIG90aGVyIHRyZWVzKS4NCg0KSSBkb24ndCByZWFsbHkgdW5k
ZXJzdGFuZCBob3cgSSBjb3VsZCBzcGxpdCBteSBzZXJpZXMgdXAgdG8gYXZvaWQgdGhpcyANCmlz
c3VlLg0KDQpEdWUgdG8gdGhlIGZhY3QgdGhhdCBvbmUgKGFuZCBub3cgdHdvKSBkcml2ZXJzIGlt
cGxlbWVudGVkIGxvY2FsDQptdXggaGVscGVycywgdG8gdW5kbyB0aGF0IGFuIGF0b21pYyBjaGFu
Z2UgbXVzdCBiZSBtYWRlIHRyZWUtd2lkZS4NCg0KTWVhbndoaWxlIGl0IG11c3QgYmUgYXZvaWRl
ZCB0aGF0IHdoaWxlIHRoZSBtdXggY29yZSBoZWxwZXJzIGFyZSBiZWluZw0KdGVzdGVkIC8gcmV2
aWV3ZWQsIHRoYXQgYW55IHRyZWUgYWRkcyBhbm90aGVyIGRyaXZlci1sb2NhbCBtdXggaGVscGVy
DQpsaWtlIGFwcGVhcnMgdG8gaGF2ZSBoYXBwZW5lZCBoZXJlLg0KDQpOb3RlIHRoYXQgbXkgcGF0
Y2gtc2V0IGRpZCBnbyB0byBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZyBsaXN0LCB0b28u
DQoNClRoZSBzZWNvbmQgY2hhbGxlbmdlIGZvciB0aGlzIHNlcmllcyB3YXMgdGhhdCBtdXggZnJh
bWV3b3JrIGlzIGJlaW5nDQplbmFibGVkIG9ubHkgYnkgZHJpdmVycyBLY29uZmlnICJzZWxlY3Qi
IC0gYW5kIG5vdCBwb3NzaWJsZSBieSBtZW51Y29uZmlnLg0KVGhpcyBpcyBlLmcuIHJlc3BvbnNp
YmxlIGZvciBiZWluZyB1bmFibGUgdG8gdGVzdCA9bSBidWlsZCB3aXRoIGFybTY0DQpkZWZjb25m
aWcgLSBhbmQgbGVhZCB0byBpdCBvbmx5IGJlaW5nIGRldGVjdGVkIHRocm91Z2gga2VybmVsIHJv
Ym90DQp4ODZfNjQgYWxsbW9kY29uZmlnLg0KDQo+PiBUZWxsaW5nIG1haW50YWluZXJzIHdoYXQg
aXMgeW91ciBleHBlY3RlZA0KPj4gbWVyZ2Ugc3RyYXRlZ3kgaGVscHMgYXZvaWQgbWFraW5nIG1p
c3Rha2VzLg0KPj4NCj4+IEZvciBleGFtcGxlLCBpZiB5b3UgZGlkIHRoYXQgaW4gdGhpcyBzZXQs
IHlvdSB3b3VsZG4ndCBoYXZlIG1pc3NlZCB0aGUNCj4+IGZhY3QgdGhhdCBpbiBsaW51eC1waHkv
bmV4dCwgcGh5LWNhbi10cmFuc2NlaXZlciBpcyBfbm90XyB0aGUgb25seQ0KPj4gb2NjdXJyZW5j
ZSBvZiBkZXZtX211eF9zdGF0ZV9nZXRfb3B0aW9uYWwoKS4gVGhlcmUncyBhbm90aGVyIG9uZSBp
bg0KPj4gZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVzYjIuYywgYW5kIHRoYXQg
c2hvdWxkIGJlIGFsc28NCj4+IGhhbmRsZWQgaW4gb3JkZXIgZm9yIHRyZWVzIHRvIG5vdCBlbnRl
ciBpbmNvbnNpc3RlbnQgc3RhdGVzLg0KPiBUbyBoaXMgZGVmZW5zZSwgdGhlIG9uZSBpbiBkcml2
ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjMtdXNiMi5jDQo+IGlzIGEgcmVjZW50IGFkZGl0
aW9uLg0KPg0KPiBTbyB0aGlzIGlzIHlldCBhbm90aGVyIGNhc2Ugb2YgImNvbnZlcnQgYWxsIGN1
cnJlbnQgdXNlcnMiIChpLmUuIHRob3NlDQo+IHByZXNlbnQgaW4gdGhlIHR5cGljYWwgc3Vic3lz
dGVtIGJhc2UsIHR5cGljYWxseSAqLXJjMSksIHdpdGggbmV3DQo+IHVzZXJzIHBvcHBpbmcgdXAg
aW4gLW5leHQgaW4gcGFyYWxsZWwsIHdoaWNoIGhhcHBlbnMgYWxsIHRoZSB0aW1lLi4uDQo+DQo+
IEdye29ldGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQN
Cj4NCg0K


