Return-Path: <linux-can+bounces-6611-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSPGXxMnGnYDQQAu9opvQ
	(envelope-from <linux-can+bounces-6611-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:47:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF1017668E
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A48300E3E0
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE227365A02;
	Mon, 23 Feb 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nrHwyAiX";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nrHwyAiX"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021108.outbound.protection.outlook.com [52.101.65.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE9364EBA;
	Mon, 23 Feb 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.108
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850645; cv=fail; b=FxlfkWZ3TxOlzqEt7drWFMyauqy4Zxt2H5bTGvphhg3Jvb8qOcZyY+l0r3M/voUxJyjImF0ja5pC9oLWCx8uncB2Slz8VbYrGIzxEW336b1kB5gOOlRX8HMhrzVSKYIlyVsB0Z8FLjqVe6gVu1jzqZgXWHXF9zsV+xjlgI+3r88=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850645; c=relaxed/simple;
	bh=x+BDpn3K8f159ewePo5Z7B54dUe4gv18JarKyfG6e9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJoyDOcvda19moMmjwgrsfBWiaV/dB4plhrQTFTNnCsxjDtA9y00yxuvJ/zLLIHwL02MzOyKqm6rpcbUn9wAOTox3Sb7WbWbQJfavvOJobHVF+xcbub3LGjm3q5DVxunpyXGjYH/0HrX0Rew2q6LUCuthc/0IJXRoFrYTZS1n0Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nrHwyAiX; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nrHwyAiX; arc=fail smtp.client-ip=52.101.65.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UWrvvqvCugTW8mKgWRp/Z6mG2Ad4pc1siVJWr28mMxYjEFL9J3XDT6YEE4AdXNQIsn7V5EBtXHsiHKekdQ/vPN9VaHnK95MHHL/5Ni7d/YKSRz3TO4UkLklOA8FZoBDtGFYFMX7SVZZybdwJrDYvYqTQnOwOTcBoWBOKFurZIZzNqXDWYy0NsSrJGHGJacpRYokinvji6IbBFVbPSg/m7huyl3WOzd80LbuQGbKKHIhYHB226sZXbe3DTRxmyrG42pE2twrS/+wOO2rQKGxXpCVcyml8TEpf3KnGS0G0iJI+xgPkfS+6RSd1phfhW6fpOa4boiIVVhGaR7EIixn2RA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+BDpn3K8f159ewePo5Z7B54dUe4gv18JarKyfG6e9U=;
 b=lt8u1mjZ9nJB4tu8v6Pp6pguYp4U+Ny6OLrlIifwYlHAg9drm/qm6LKvj0JCw1gFzZNyA171tWdtqRK/RwHcTIwxvZihT/Bi3ljUcJkQiZi39mqZBZt+bWWT0olajuN6CxVotCSkdmvk5YKuWr7OmPH2GltO5gJ3CDpiNqg2Dofx5dTfW3ukWDHFCVExLTy0RdwpKBYm6dd3uEP7UbX6FeGVKNZ5Bg2t2UXUFQtst9bKvX3YSRP/syDoAtVKyT7rbZzqnBpsS84PcxlTf1249ahlcIvkXzYKoKE0YW5n6vNX+pQ1vOn7XTljycwflrmiKtcfpPwaXrJsF17jvbTQ6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+BDpn3K8f159ewePo5Z7B54dUe4gv18JarKyfG6e9U=;
 b=nrHwyAiXC8nAhPFYaOQgHVFZorAqlUwhoJgUXGZHcodg/B3Z2+5+EYD5CJnz0Yy0a2ZufcQ80S6OKWsV3HpU/c0PVLL7K3uYcH8sJllniQUl9YOviL3jOkqvk2dUe/9eiEzp/QSkRhSiutUU3Jl6xK9cPVQv2YKy9c3NVP4acrA=
Received: from DB8PR06CA0037.eurprd06.prod.outlook.com (2603:10a6:10:120::11)
 by VI0PR04MB10997.eurprd04.prod.outlook.com (2603:10a6:800:267::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 12:44:00 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::43) by DB8PR06CA0037.outlook.office365.com
 (2603:10a6:10:120::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 12:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 23 Feb 2026 12:43:59 +0000
Received: from emails-1298201-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-176.eu-west-1.compute.internal [10.20.5.176])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 64BB3802AB;
	Mon, 23 Feb 2026 12:43:59 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon Feb 23 12:43:52 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI58yVYRWlSCPqW3QjSx2C4it9YaYos4Vi1YcgIuFVSVZPWlpdczdluYz8eEm4BsLRo1qiE4/u3XvieIp3SGT8gK20jeiILDWduinPLkIVV9VWUgmlYLE43rHNlicbGw/namJQ+5m1cBPALbt0+XXsLDniEwT5hbPpf4w+Tgqc9GHfs7heehqasXXBDG1PcgtyBY1DyqwGQpnuEeS5ak52923RM080uGx4OlKlxf2LQT8nPSIV6hbxX8pYAIYLltIILH6GxFV3LD2zPkGc5MI/jS7LlUldMnM6w//6JJPIe7eEFzi0Z+xCJ6p/t2fdotXu7dD3lVhdZtJl6lK0HiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+BDpn3K8f159ewePo5Z7B54dUe4gv18JarKyfG6e9U=;
 b=DEoBav5Mi8wWGP2oQ/hOEkQYgnTdaNwdfFl3OUhoOQSMOOoKi6XhGP+jZSw2nxh9ddMt+BgVtoaxDtOPULMiGNmIj0HtrlqVNvy4EYOMiJZn5gZXHqOMTz7slPgxkIey3g5smxcz500KAWmkIOscKVDN0uG3Jg77J755cljidTiw/+AnlfVWr2fAqwkdAR35MF38yczQl+9yUWgB7JI4+OIxGlYOzqz9ro7HNFdrXhQa0zo9p7hYIZmon2P4uy4YxdGUS1A2V9Me82hc347jLDD7HcnAI6n2xKV0QZGlZPVRH1HEnVF1iNVGXnnJPa7Rvw9t1wJDgGBxDJiXjuLVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+BDpn3K8f159ewePo5Z7B54dUe4gv18JarKyfG6e9U=;
 b=nrHwyAiXC8nAhPFYaOQgHVFZorAqlUwhoJgUXGZHcodg/B3Z2+5+EYD5CJnz0Yy0a2ZufcQ80S6OKWsV3HpU/c0PVLL7K3uYcH8sJllniQUl9YOviL3jOkqvk2dUe/9eiEzp/QSkRhSiutUU3Jl6xK9cPVQv2YKy9c3NVP4acrA=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 12:43:49 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 12:43:49 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andreas Kemnade <andreas@kemnade.info>, Vladimir Oltean
	<olteanv@gmail.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Vinod Koul
	<vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin
	<peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
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
Thread-Index:
 AQHcmREPlBYTghYn+UKFA/cQGR2iuLV/TKqAgAABVACABbnOgIAAE38AgABjJgCACtOIAA==
Date: Mon, 23 Feb 2026 12:43:48 +0000
Message-ID: <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
 <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com>
 <20260216092914.kmvl7aep7dantcsd@skbuf>
 <20260216162406.0121dd91@kemnade.info>
In-Reply-To: <20260216162406.0121dd91@kemnade.info>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DB9PR04MB9818:EE_|DU6PEPF0000B622:EE_|VI0PR04MB10997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4f7a6e-5c4a-402a-47c0-08de72d9375c
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Ym16WFZRV0FXclJVYmFWNEMyTll2U1NFNTJXdjRCVm9Fai9jMXA4SlVOMWNa?=
 =?utf-8?B?TXhpWERzd0N3TlA2YVVTbXhXVFk5WGY4aEhNYlhVNldlQzh3YU9VcGxXSnFU?=
 =?utf-8?B?cnVybVozU0d1MUh6cUhXaVA2TzJyS216WVFOVkRxY1FEcmRhdE1NNWFKc3lk?=
 =?utf-8?B?VnlzSlR2M3UxNi96dWUwbFhjTmNmTEUzMm1TYURTZ2tMMTF0VVVaQ1FJc2ZR?=
 =?utf-8?B?cElFbXV5OUhrdDl5SGJRVUQ3dGtIZzFvNzA1d1VTUmgyYkI3c1Rad0ZxWHpR?=
 =?utf-8?B?dzBmeEhaNG0xWjkzeGJ2TFVDbTJaemxDandCblpQL05RbzZyelFxWGIxOW1W?=
 =?utf-8?B?UHRxcnBkT256YitaNnJieXlYeXBrenQ3Ym42bzJNYnZ6OEZMd2N0UjdvSlhn?=
 =?utf-8?B?d2d4d1hQaEVrZ2FXOVB3U05ieUpIWTdnSFluWU5OVVE0YVBDNTFTTEw5SFNI?=
 =?utf-8?B?blZWQ09Ca3B5WGNIYjhHaG9XVEhseDFzelNyZS8rajFKdEJuL05mcTRWdlZz?=
 =?utf-8?B?QmV2ellSMzBydWtObjArc2t6QmlZVEdmK3U2QXBtV29sSEpIV3lVSW5wZStT?=
 =?utf-8?B?bjNLakRqV3pMZ0pGOGwrMUc0QXNxVldRdGUyWGErcmZsZmxZbitvS09FY0dP?=
 =?utf-8?B?U3FVODM3RHIvLzlrd3lIa3ZuSktoL2dVRFVUTm5kdlo4THAwc3FzVWFvZWF1?=
 =?utf-8?B?bm5jaWN2Z2ZkQVJSTHpSL3VhSW83d0lLelhzbDF5UzBXNFVubjdUUDNjT0ha?=
 =?utf-8?B?QXpKWEhpaGFxa3dXOFNzMVpYWGxOcy8zRk1WUkxBUldiVit3eTF2TmNkcGc5?=
 =?utf-8?B?bHRkeVN6WG80Si85YnNmWkFkc1l6cUg5Qm5yTTVzRHpPS3c3c0JIRUNkVXl4?=
 =?utf-8?B?UGhuckVPbktvRW85Q3pwdUUrRDFqZUV1K2pWb0F6R3I4Ni93RkVIaExQbENy?=
 =?utf-8?B?b0V2U2NZZ2NYY3pHelp3QU15T1NWOXFyOXRlNzl5OTZvQ1dkZXRkOUMvWm5v?=
 =?utf-8?B?MUZDS1dMTDROMXB6UTNXMVZkNi9uS1FjVkptVGNLVWxUOS8yMjhDdmloMFU0?=
 =?utf-8?B?Y0Q3UVhQNUd4MG1MRVJqemIveDJ6WGdHNkRPYWdnTHdSMnhyYU4wR01uRDdI?=
 =?utf-8?B?U2hvZHlBbXU0Um9ZVm8rcG8xejJnR3I2eDRWc2djL2xpbXZ2L2ErQjg4Yi9h?=
 =?utf-8?B?eXdXZVJIdDMxcGxUM01hekZlR0lrTDBXSWtkUUIzMjBYdndjU3hxenhSSEh5?=
 =?utf-8?B?eVVocEo0Nmh0YjRraHIyOUtOVWFsa2ZrT0hGUlZYOUpxVHk0UGVESFl1b0Va?=
 =?utf-8?B?V0h6MCtLbjZWQ1o0bDhmS3djb1hzU0VOdzlyQ25aQ2I5UEpPeWRnQndtOGNp?=
 =?utf-8?B?bUE3bUdmSlh4OTVOWThCL3BNRnRkOTJiMzU0UFJsL083TytPd2ZYTENjQ3k3?=
 =?utf-8?B?U1k0SXBCbUNoM1dYUUo4WkRnYXZCallhR0piaThFWDV6eGR3SlkwcWg4NWJ3?=
 =?utf-8?B?MG9mcE02ZXZoRmJVUC9OTkdEdlRZWU9GTytLM3V3TkVoVzIxcDRkQllVTVlF?=
 =?utf-8?B?WTNGSGVJeTVrZW5hVXRLM1c5cnpvbW43Y2ptRTh0Z3RoZmE3UGQ2NHQ4ZkRB?=
 =?utf-8?B?SGZiTnJmNnlVRFhQUE56V3FXcGdWTmJHbnZaU1ZLcTBlcC96UVdzeWh6UUUx?=
 =?utf-8?B?VnZuVHhIQUZMUGJUVUx1dWRaK2ZDMEpqM0lScXhEeVlYVkcrNUNOMHdxSUVB?=
 =?utf-8?B?bUkvaWdOMEFoaUN3c0lXeFhWTlVIbWFoY2pMOU5CQXQxK09ydzVSbmczcUFi?=
 =?utf-8?B?VnJuY0ZDbnN5Y0VOWDNOa0lnN0QxQnlwRGs0Vi9zVlNseUpkaTdneFRDeEhm?=
 =?utf-8?B?WUVsMlFjU2RXeXRMcjM4SExCTzZJMzB3U2F0eC8rOUJvUXVOZStsalUxbTVH?=
 =?utf-8?B?bWFIR3V3TmlmaE1JVm5qcEFrNjdKcGMzY1BWTkxmYncvREZMQkdIQmZVdkFP?=
 =?utf-8?B?blUvbjRTNFkyQXVYVk5KbEszcFRZckdaNjhrckhSTThFNFJtTEZSYVBRbmhk?=
 =?utf-8?B?ZFRIY051V05QWnp4UnhlMHQybVh3STZMaXNXdFU0cFJnODVRbE5YYjMwd3Nj?=
 =?utf-8?B?aTZqTkYrZEc0Z1BOS2toK2RkcGk1OUR0TUEyYWI3YjU3NXd2U2FPZGRXdWRa?=
 =?utf-8?Q?K2BdCsJyQuTPflEbuvd215A=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AD722091647944EA8B33C56E2E7711A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: f3988f1111384a4fbc4393466b321259:solidrun,office365_emails,sent,inline:355d9431707635984c7397a32b135fd6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b77dbe00-8e70-467a-d509-08de72d93102
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|14060799003|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0F6TkFqVW1nZHNNYmN2RWx1emtpSkZCMDdNMmM1TGtPU1kzWmozeExvUElK?=
 =?utf-8?B?Q21FamoxdkROM29WQUdyakJTRUVXdHNSNE1lQldmb3ZzbWJWendseHE1U0dG?=
 =?utf-8?B?b2J3ZDB3L1VFeUw0Q0hqR2IxVHEwcVYvV1ZmczhaOHVydm1MZUN4Z1FxUnVm?=
 =?utf-8?B?UzJOZjg1dDBGNG5wODZRelB3ZWhMekNkejVkUWN1czNOalhxcUFQdGo1ZnBN?=
 =?utf-8?B?bWNSLzZpL01sN0ZSZWVrWitBNXJzR2FOenViMXJzS2JYK0Rqd0hBaVB2VkFj?=
 =?utf-8?B?Rlk2WnhtYzVtN2tPRkFZaHF2TGRBMnJPMVYrT2dxeURUM21zei83MVJYUjcx?=
 =?utf-8?B?RnNSUkNOQVFEOFNTaHZsUjBZSlZHSDAxd0ltOTBrM1MzRTBVMkg0cWpqMSsr?=
 =?utf-8?B?a0pkR1lpNU4vazAyNWZiUkV5TitvUktBMnpNOHIwZWF0VU16OGFKU3lGUGJw?=
 =?utf-8?B?U25kczh2VEMrNTQyU3pkQWhEb3lVT0k2WFBiTUt6TDdFdHVxc2t5RUpsL1Ux?=
 =?utf-8?B?UFZKaUhQRktOWDEzMHRRdWFDODF6L0VCSUZkVGpZenNXL3RGREswNnFyekZw?=
 =?utf-8?B?RkJpQ1QvcGhreEErQ1JxczJKZ3p2blFxZGlMV05zQ3ZaNnJRRUIyWXUwUXFT?=
 =?utf-8?B?SDM3eE45VnBFeUVpZnppa1lxaGd4alBoK0x3MUdwYm1SWW9qMUpIam93RU1x?=
 =?utf-8?B?a0ZScTEzUWY2YkZXMGRpYStYTDlQNFo1cERkZ29yUlQ5d1FXKy80MVpIeHNz?=
 =?utf-8?B?UVJ0YnhKbitVZTJ3MXljTDNBclcyTkdUV2JUOEpZSmU0L3QzbXJKeGRhYno2?=
 =?utf-8?B?WTZISzBFVlhGSlE3NE05Q1JaeS9laWIxUzF1OHloRWFFOEtGVWE2eHpSNFZE?=
 =?utf-8?B?YWdLQnNEZjdWZVR2R3JwRmhYNHdEWjJsVDRaTFRSekJKSndCMHd1WFZYdFZa?=
 =?utf-8?B?Z3dsaTA1ZGR1NE9hTjBMZjhpdmRoajQxbFVjdVpwaXJIL01QU0dZcVR3Vjkz?=
 =?utf-8?B?cTZqZ1k0cnFpQjFrWFRsV04wWmRETWpWT1JYOUpsWUlRSngvUlRONHQ2V3FZ?=
 =?utf-8?B?a0V5UEJXOWM4cGhEK3JHcFJaVmI4WUNIOEhlSVBiWFZEVXlyOTI2aVZjdEM2?=
 =?utf-8?B?N3JkdEdYTS9MOTEzYzdMVEZaODB6aEhJVmY2UWdJRXVhR2xLZy9nY2xrUjha?=
 =?utf-8?B?QU1rd1RZNGRHdUphSjJ2TDhkdWorbjd2SDVHcnAzYzhmdXRSSS9MVGhXbUQ4?=
 =?utf-8?B?WW1rNVNWR1BVaFdYbmdvRDhwLzBzS3ZLWGNzZWdERERydFBpTHVkWnYyTENS?=
 =?utf-8?B?R29kazhiNGpYYldhRVcyNmx6dlIvaVZJdklWTVV2QitydnNOYXRyL1JRTTVM?=
 =?utf-8?B?Q2hWSVE1N20xOEQ4THM2N21BaTJ5RldwWFphS243a2dzWjdIWExLYWQ0Nk1l?=
 =?utf-8?B?ZEpZWFhVd3NDZmxldDYxMnRYV0cwWXdWMThqaERxZlJDeG90YkJwb1dHSzlL?=
 =?utf-8?B?SlA3ZHRRMFZIQm5taFo5Kzc2QnFmbFZrVXlvbVM0MGlhVDBEUm1LNjdNZGY0?=
 =?utf-8?B?aWFhU3lwYnhjSytjQTlJYkNaWncxNFk1TE9ZWEdNZTdkMDlPNVZjblVJYWVU?=
 =?utf-8?B?OTdtQXY3a0NDQkVVVE5ERlNYOWdpRnRMdjQwekh3clBZL2dHOUR0WHhyUjZX?=
 =?utf-8?B?OU1PenJ3My9NVGtocVdMenFpd0tiQnFaakdxSURsdER0dS83S2VzRWNmOHRB?=
 =?utf-8?B?bzdFZ2JHYTlDaGQ0SG5hS2xxRHlGc0VIcW1XRFNCNEQ4OXFnSmIra0JHYmg5?=
 =?utf-8?B?ZmxCdmg3bmUzMXBWRWVpMk1xM3dhem5qVmdualpTU1FTQWFXWnUzYmxaVWNl?=
 =?utf-8?B?Znh4ai8zMTQ5OW9ydzE0bDVPVHFDTFRLK3kyZUNraUNUZHVlTU5sbDREWVJ6?=
 =?utf-8?B?UGJ6NWxvK0pQbC9NMlhwMTM4N3NwYWJGSld3aGJtNXNlQVkxMnpCQ1lxUEkv?=
 =?utf-8?B?cHRUM2RQd05SVlJMblVtdkFVTlNBZXF1NGo2Vk9lVXlvaDlqdVEvbFpxd3Jv?=
 =?utf-8?B?eXJSOFNZVTFZQU5QcVp1cU9ReXJOV1luTG53YnJ6NFN5V0VRRU9FdUhaUktC?=
 =?utf-8?B?cmJ3MGZoTWh2RENodk5rK3V1K2wyY2pvVnZVYjB4SzZrU3lzazRrdEYzV2FQ?=
 =?utf-8?B?aUdOTitRZVlpejJZWWFlUGNHNkNUSDJac2UzcnRHL0hGOXh1S3ZwVURuM0xZ?=
 =?utf-8?B?Qjl5SDBkWU5QUDlxNWgwOWowL0Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(14060799003)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QJRId4gh2u4J+D9cWFUT4pQdGiWMZG6EPXZM4IOxCgjPQiqkduDS2VRTjxbKPzWMiDXNysV2dzU0LURJlMKcpflbouJ8CqcOmtS1wD2CAQy2EAPXo7d5IgWl/s2vRk4VW3IT/W7eXDtwSznQXMxHNGpB9DAcfwS9bq1kVHwgzj8DJ0D//lNWYsfK5HxERAvr0ohK5W/kHL+uwj9zc4lA6Z8qFcuuD0MVeciV/9gM7oPG/jSyF3xHeXiC8gqlIKFM+6ehbxQ/t4mko17YazE3lHfO+rY8NfoUpuHNXBmpssC1PUEwyDqA50oSe8/EwRnpcu7yntZ+u7AhynLc5mWycpz4yNUVGOHCuERibA/JtKh/9DI8ty5RT1yN2BfohmjmGn3NaKx71Q/+Glz+es9sFD6qglzbN2GfpuMZcepji7u+yWVO7CpGNKaT2asvDhzm
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 12:43:59.5038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4f7a6e-5c4a-402a-47c0-08de72d9375c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10997
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6611-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kemnade.info,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,solidrn.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-m68k.org,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CEF1017668E
X-Rspamd-Action: no action

QW0gMTYuMDIuMjYgdW0gMTY6MjQgc2NocmllYiBBbmRyZWFzIEtlbW5hZGU6DQo+IE9uIE1vbiwg
MTYgRmViIDIwMjYgMTE6Mjk6MTQgKzAyMDANCj4gVmxhZGltaXIgT2x0ZWFuIDxvbHRlYW52QGdt
YWlsLmNvbT4gd3JvdGU6DQo+DQo+PiBIaSBKb3N1YSwNCj4+DQo+PiBPbiBNb24sIEZlYiAxNiwg
MjAyNiBhdCAwODoxOToyN0FNICswMDAwLCBKb3N1YSBNYXllciB3cm90ZToNCj4+Pj4+IEluIHRo
ZSBmdXR1cmUsIHdoZW4geW91IGhhdmUgYSBzZXJpZXMgd2l0aCBjcm9zcy10cmVlIGRlcGVuZGVu
Y2llcywNCj4+Pj4+IHBsZWFzZSB0cnkgdG8gdGhpbmsgb2YgaXQgYXMgaW5kaXZpZHVhbCBtaW5p
LXNlcmllcyBmb3IgZWFjaCB0cmVlJ3MNCj4+Pj4+ICduZXh0JyBicmFuY2gsIGFuZCBzcGVjaWZ5
IGNsZWFybHkgdGhhdCB5b3UgbmVlZCBzdGFibGUgdGFncyAodG8gYmUNCj4+Pj4+IHB1bGxlZCBp
bnRvIG90aGVyIHRyZWVzKS4gIA0KPj4+IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgaG93IEkg
Y291bGQgc3BsaXQgbXkgc2VyaWVzIHVwIHRvIGF2b2lkIHRoaXMgDQo+Pj4gaXNzdWUuDQo+Pj4N
Cj4+PiBEdWUgdG8gdGhlIGZhY3QgdGhhdCBvbmUgKGFuZCBub3cgdHdvKSBkcml2ZXJzIGltcGxl
bWVudGVkIGxvY2FsDQo+Pj4gbXV4IGhlbHBlcnMsIHRvIHVuZG8gdGhhdCBhbiBhdG9taWMgY2hh
bmdlIG11c3QgYmUgbWFkZSB0cmVlLXdpZGUuDQo+Pj4NCj4+PiBNZWFud2hpbGUgaXQgbXVzdCBi
ZSBhdm9pZGVkIHRoYXQgd2hpbGUgdGhlIG11eCBjb3JlIGhlbHBlcnMgYXJlIGJlaW5nDQo+Pj4g
dGVzdGVkIC8gcmV2aWV3ZWQsIHRoYXQgYW55IHRyZWUgYWRkcyBhbm90aGVyIGRyaXZlci1sb2Nh
bCBtdXggaGVscGVyDQo+Pj4gbGlrZSBhcHBlYXJzIHRvIGhhdmUgaGFwcGVuZWQgaGVyZS4NCj4+
Pg0KPj4+IE5vdGUgdGhhdCBteSBwYXRjaC1zZXQgZGlkIGdvIHRvIGxpbnV4LXBoeUBsaXN0cy5p
bmZyYWRlYWQub3JnIGxpc3QsIHRvby4NCj4+Pg0KPj4+IFRoZSBzZWNvbmQgY2hhbGxlbmdlIGZv
ciB0aGlzIHNlcmllcyB3YXMgdGhhdCBtdXggZnJhbWV3b3JrIGlzIGJlaW5nDQo+Pj4gZW5hYmxl
ZCBvbmx5IGJ5IGRyaXZlcnMgS2NvbmZpZyAic2VsZWN0IiAtIGFuZCBub3QgcG9zc2libGUgYnkg
bWVudWNvbmZpZy4NCj4+PiBUaGlzIGlzIGUuZy4gcmVzcG9uc2libGUgZm9yIGJlaW5nIHVuYWJs
ZSB0byB0ZXN0ID1tIGJ1aWxkIHdpdGggYXJtNjQNCj4+PiBkZWZjb25maWcgLSBhbmQgbGVhZCB0
byBpdCBvbmx5IGJlaW5nIGRldGVjdGVkIHRocm91Z2gga2VybmVsIHJvYm90DQo+Pj4geDg2XzY0
IGFsbG1vZGNvbmZpZy4gIA0KPj4gVG8gYXZvaWQgdGhpcywgYSBjb21iaW5hdGlvbiBvZiBkZXZl
bG9wZXIgZHVlIGRpbGlnZW5jZSArIG1haW50YWluZXIgZHVlDQo+PiBkaWxpZ2VuY2UgaXMgcHJv
YmFibHkgcmVxdWlyZWQuDQo+Pg0KPj4gRnJvbSBsaW51eC1waHkgcGVyc3BlY3RpdmUsIHRoZXJl
IHdpbGwgYmUgc29tZSBhdXRvbWF0ZWQgYnVpbGQgdGVzdGluZw0KPj4gKHdoaWNoIGRpZCBub3Qg
ZXhpc3QgYXQgdGhlIHRpbWUgb2YgeW91ciBzdWJtaXNzaW9uKS4gVGhpcyB3b3VsZCBoYXZlDQo+
PiBjYXVnaHQgdGhlICdoaWRkZW4nIGRldm1fbXV4X3N0YXRlX2dldF9vcHRpb25hbCgpIGNhbGwg
cHJlc2VudCBvbmx5IGluDQo+PiBsaW51eC1waHkvbmV4dCwgd2hlbiB0ZXN0aW5nIHBhdGNoIDIv
Ny4NCkV4Y2VsbGVudCENCj4+DQo+PiBCdXQsIHRvIHdvcmssIHRoZSBidWlsZCBhdXRvbWF0aW9u
IG5lZWRzIHRvIGJlIGFibGUgdG8gYXBwbHkgdGhlIGVudGlyZQ0KPj4gcGF0Y2ggc2V0IG9uIGxp
bnV4LXBoeS9uZXh0LiBTbyBleHBlY3Qgc29tZSBwdXNoYmFjayBpZiBpdCBkb2Vzbid0DQo+PiAo
aGVuY2UgdGhlIHJlY29tbWVuZGF0aW9uIHRvIHNlbmQgYSBtaW5pLXNlcmllcyB0byBsaW51eC1w
aHkgZmlyc3QsIGFuZA0KPj4gcmVxdWVzdCBhIHN0YWJsZSB0YWcpLg0KSXQgd291bGQgaGVscCBp
bW1lbnNlbHkgaWYgdGhlcmUgd2FzIGEgd2F5IHRvIGdldCB0aGUgcGF0Y2hlcyByZW5hbWluZw0K
ZHJpdmVyLWxvY2FsIGNvbmZsaWN0aW5nIGhlbHBlci1mdW5jdGlvbnMgdmVyeSBlYXJseSwgYmVm
b3JlIGFueXRoaW5nIGVsc2UuDQoNCldvdWxkIHRoaXMgc29ydCBvZiBwYXRjaCBiZSBhY2NlcHRh
YmxlIGluIGxpbnV4LW5leHQgbm93LCBzbyBpdCBjYW4gbWFrZQ0KaXQgaW50byB2Ny4wLXJjMT8N
Cg0KSWYgbm90IHRoZW4gdGhhdCBtaW5pLXBhdGNoc2V0IHdvdWxkIGJlIHRoZSBmaXJzdCBvbmUg
SSBzaGFsbCBzdWJtaXQgYWZ0ZXINCnY3LjAtcmMxIGlzIHJlbGVhc2VkLg0KDQpUaGVuIEkgY2Fu
IHRyZWF0IHRoZSBhY3R1YWwgaW1wbGVtZW50YXRpb24gb2YgdGhlIGRldm1fbXV4XyogaGVscGVy
cw0KYXMgYSBzZWNvbmQgc3RhbmRhbG9uZSBwYXRjaC1zZXQuDQoNCkFuZCBmaW5hbGx5IHBhdGNo
aW5nIGFsbCBkcml2ZXJzIHdpdGggbG9jYWwgaGVscGVycyB0byB1c2UgdGhlIG5ldyBnbG9iYWwg
b25lcw0KY2FuIGJlIHBhdGNoLXNldCBudW1iZXIgMy4NCg0KQW55IG9waW5pb25zIG9uIHRoaXM/
DQoNCj4gSSBkbyBub3QgdGhpbmsgdGhhdCBpcyBhdCBhbGwgdGhlIGR1dHkgb2YgdGhlIHBhdGNo
IHN1Ym1pdHRlci4gSSB0aGluayBhcw0KPiBsb25nIGFzIGV2ZXJ5IGRlcGVuZGVuY2llcyBhbmQg
c2lkZSBlZmZlY3RzIGFyZSBkb2N1bWVudGVkLCBpdCBpcyBJTUhPIHVwIHRvIHRoZQ0KPiBtYWlu
dGFpbmVycyB0byBkZWNpZGUgaG93IGl0IGNhbiBiZSBtZXJnZWQgYmVzdC4gVGhleSBrbm93IGJl
c3Qgd2hldGhlciB0aGVyZQ0KPiBpcyBhbnkgZGFuZ2VyIG9mIGNvbmZsaWN0cyBpbiB0aGVpciB3
b3JraW5nIHRyZWUgYmVjYXVzZSB0aGF0IGlzIGFuIGFyZWEgDQo+IHdoZXJlIHBlb3BsZSBhcmUg
d29ya2luZyBvbi4gRXNwZWNpYWxseSB0aGlzIHBhdGNoc2V0IGlzIGFyb3VuZCBmb3IgbW9udGhz
Lg0KPg0KPiAgSW4gTUZEIHdoZXJlIGl0IGlzDQo+IG1vcmUgY29tbW9uIHByYWN0aWNlIHRvIGhh
dmUgY3Jvc3Mtc3Vic3lzdGVtIHBhdGNoc2V0cywgb25jZSBhY2tzIGZyb20NCj4gZXZlcnlvbmUg
YXJlIHRoZXJlLCBNRkQgTWFpbnRhaW5lciBjcmVhdGVzIGFuIGltbXV0YWJsZSBicmFuY2ggd2l0
aCBhIHRhZy4NCj4gVGhlIG1haW50YWluZXJzIG9mIHRoZSBhZmZlY3RlZCBzdWJzeXN0ZW1zIHB1
bGwgaXQgaW4uIA0KVGhpcyBzZWVtcyBsaWtlIGFuIG9wdGlvbiwgaWYgSSBjYW4gZ2V0IHRoZSBw
YXRjaC1zZXQgKG9yIGEgcGFydGlhbCBvbmUpIHJlYWR5IGVhcmx5IGluIHRoZSBjeWNsZS4NCj4N
Cj4gUmVnYXJkcywNCj4gQW5kcmVhcw0KPg==

