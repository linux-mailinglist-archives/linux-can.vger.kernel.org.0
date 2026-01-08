Return-Path: <linux-can+bounces-6032-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC9D01D23
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 10:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F381337D652
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BF3364E9A;
	Thu,  8 Jan 2026 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="c/9PQ0L9";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="c/9PQ0L9"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021116.outbound.protection.outlook.com [52.101.70.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6D364045;
	Thu,  8 Jan 2026 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.116
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858183; cv=fail; b=mxy7oW2VThdvtEpn9vzxnHyhPZh5QzDnCB+gs4QBeJtdM3HW+cpZ7BSAc2zdThfE/Q87PRj34j970ENRbe0xrHMUiDN7X6nQehXiZrcUfbEbO1plO3UurBpeojKl/6pzTnqZnmgyVvPNBtVR/3GIW8KxepnoAKNyF3RT+otS0lY=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858183; c=relaxed/simple;
	bh=6HUT3ZVqBcDl6+mb4DFYoN5fYa4BTHjqdB3ghQ+KkI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9TGAgV60nKrBUCR7wwogZ+ii6gAM7Z2SSC8UxOhuvHYnmju6593601azHGqGv57p7YyT9e5yVhkeCIbjH+YM0GgF9obSnIEO+QyH7aKRmU2iW3C7f663AnjkK8bdLCipB2PrcLX7yWkS2svi/kHKu7SZ0QYQieSh7t1L9jYqJw=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=c/9PQ0L9; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=c/9PQ0L9; arc=fail smtp.client-ip=52.101.70.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bOnsIvuLFlMF54GsK2BvkWFLnOGm/HoLHT/3OKQWfsQ08+H/rN+Z3OImTbXWuGt2OTYz+YVNd0C0sRxmzx6HZTRsutluLzqSjC6K+70WNJkWTZLbHUVtbbsAP5VXgc2Pbibne/1LdHLrSq79k6IlOKCW+puRjnBYz8x/lDynBNOilAv4DTD7hlNn+4kEav2ldDCaIhYzPbRilnji63NrRaLs8OWX54qteEmbBrZVoF2PnLIRtj9uKlRGL+C/lJz3dvMC2NGTYwbDB7VcEYf8QvJk9mRgEszcaz0A/Hz6A6WQn7lEmA41OjuBigBgEajt8obim2KIL0UTysi628iMcg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iew2lyWpItyxuMh0pLQYH7yZ/C7z3T4akgckmm4WyXU=;
 b=EuaXawDMOorQch9GcuCfmKGt6REsy8h0dDhUJn6r2Gm7kgR6uYTmDZWXOChEzZo067j2dIYxIsv5ODTIqKDrzKar710TNgFRPb6BiXZzumU8NUjjTmgwNgMqymiNFPzQuy+J9btE2q5BGjBoIc9vDMcEPURBAj5VddtcKKNKE8Y7Aybu1c6eVqmo+N+fhPypuo0h/XM+/C/KBGE4NKWe/Z1BegLBbOp6Xns2nK+BFIrNM+OQ4ZQwLX+OHTZXByoeGxqYAeORFlE6Y3MSMD8PuTv44eOmdiEgv7xknHq8j6sD/R6ruwGzIudrHIhoaGXkyAj+bEFIITAUQKj1GwAq7w==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iew2lyWpItyxuMh0pLQYH7yZ/C7z3T4akgckmm4WyXU=;
 b=c/9PQ0L9/pRNFMnDSeakyHocgaq/E0b8K/OF+nOJgSOCyaeUstvYqSzMNJHI7ctKjd7ZslxCxFzw36ecZelqP7VabNYaDL9JPb1d6yW6qqYz8kkXam3Gj/kw4SS69FqO/esBzFgYWYSRbOqFMx3xNyEqkAhCajsd7QE6EW8g11o=
Received: from DUZPR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::10) by DBAPR04MB7304.eurprd04.prod.outlook.com
 (2603:10a6:10:1ab::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 07:42:51 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::e1) by DUZPR01CA0082.outlook.office365.com
 (2603:10a6:10:46a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 07:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1 via
 Frontend Transport; Thu, 8 Jan 2026 07:42:51 +0000
Received: from emails-4225107-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-71.eu-west-1.compute.internal [10.20.6.71])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 0FBA8809F5;
	Thu,  8 Jan 2026 07:42:51 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1767858171; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=iew2lyWpItyxuMh0pLQYH7yZ/C7z3T4akgckmm4WyXU=;
 b=L8xG0YwI2dlLkKVm2RCYu58NSPBr3fsv7keMF17dpk4wgvytjbZbCQeVcGOMz040Q7tbG
 BpyH9tCw9YSk2x9llWggacnlZeW2zwdhfR6QB+B39u2aZNfRkcz9FCOmw4vvhiM9iOI4HKI
 /bx4zKI4IHw3v55TdkqMYWoyZeIlIGE=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1767858171;
 b=GNsqHA+r/+OCaMMvGRgoQYp45DfCdKlMLiIjEpOASiZbCI/unrpVcusiEXq7PFX9j+0SU
 jyIhv2yqEninw6cRfQbz59xYcLiZFs5T+z2p04q7TC+jfkzvq3R2Kmkb2YcG4fRCjMNL2bo
 Ji+DiuxWRthCBBXMOZbfLe92spVkqiY=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaze8Uu8gT+z5AqE6oNuhmdiEFwlD4S5L2DHtz/NzcqTpVx0cq4bWFzcx+58miFGBotLY+09rws2GKTAX+4v0dLQOQ2txBN/XWkFexY++RUzjU5lDVbGjA2HPZ8+d188j69Xn2Md/QybCtE2SK8wt2ioSmQhjLp3FWca2hDUIwO+/BK2+rArE/C903RnOkFgj/JE2MhaRTEVEd5SRjSQE0ljlWM/w6vvFKximD7GPvYT78ti/OQxlycPGSteoA5wKRzOY7LTg5lo7Ir0KubBt9NDMuZ2E7X3bTxJ4NCmgkis0Aay76GgQexqYYfJg1QrkiV0gp3YOO/DW0Qg/oZbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iew2lyWpItyxuMh0pLQYH7yZ/C7z3T4akgckmm4WyXU=;
 b=WQVCFbJ+9wTNtfAWx0lqr2G/PivjAyK0eRYFGIL1jUgDx4q0Q5mUu4xFQ1x1l4b0wNIhQ2rv5GDIZ/zpc378Hwu6QMR2u3WYEHDP6e5q/f0VJVCXXLArgYDiDsj+ja2Kb8/wajHNT1hUSSxhRHq0wSPQ2mBNrJGr7vKCegVKHlsxHk5SkzfwsrlbrpJh+sMsHqlz0ycEW3ghwn32dv6uXZpVUJBv8FFOZlXrVY82NqeEcrQTb40jxr7ovZjK4zA3jlJ9UJpIOjCwQge2iYcTiNgSAVyxnRrvfJqMWNY/BM6eenKUamAb1X4Iiy1Dlq8L6WQtsTj+W5JTIJHpkeWJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iew2lyWpItyxuMh0pLQYH7yZ/C7z3T4akgckmm4WyXU=;
 b=c/9PQ0L9/pRNFMnDSeakyHocgaq/E0b8K/OF+nOJgSOCyaeUstvYqSzMNJHI7ctKjd7ZslxCxFzw36ecZelqP7VabNYaDL9JPb1d6yW6qqYz8kkXam3Gj/kw4SS69FqO/esBzFgYWYSRbOqFMx3xNyEqkAhCajsd7QE6EW8g11o=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS1PR04MB9288.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:42:40 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 07:42:40 +0000
From: Josua Mayer <josua@solid-run.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Vignesh R
	<vigneshr@ti.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andi Shyti
	<andi.shyti@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, kernel
 test robot <lkp@intel.com>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v4 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Thread-Topic: [PATCH v4 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Thread-Index: AQHceM9JqQzQE9ugI0yaCzbfoWSvFLU8IvmAgAvQIoA=
Date: Thu, 8 Jan 2026 07:42:39 +0000
Message-ID: <3396461.44csPzL39Z@josua-pc>
References: <20251229-rz-sdio-mux-v4-2-a023e55758fe@solid-run.com>
 <202601010305.tpY47HE4-lkp@intel.com>
In-Reply-To: <202601010305.tpY47HE4-lkp@intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AS1PR04MB9288:EE_|DU6PEPF0000A7DE:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a07d456-380f-4e17-aada-08de4e8986cc
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|13003099007|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?27eWl7XoDjOWoVFmkLNhayXgN+3Sr95XN+75mEsq+PYNhbc9FjyIPgu0CwLa?=
 =?us-ascii?Q?Pte7hKzBiJAd5UT9kUXNHuHnj/cOFBRNm56u6vfNXdKZ5dUrevkVzDuvnTNH?=
 =?us-ascii?Q?kN9NNLyvGAZUybomFFneCElAsfehs9L5MGReTrfLyd02cgs9Kbw/X38/LCIe?=
 =?us-ascii?Q?mnZ2qjx24xOwoDSGVC9sBTfkYSiXP+DR5Vkb2sRqTYCXKDOSTwAUELILNWba?=
 =?us-ascii?Q?cYigjtODP3ZCbH4OrusclABMZUdrliZOI+/FclF+laVl62Vs+2cLTo9UHNuD?=
 =?us-ascii?Q?I3hCb/X8KlLIGCI30ksAAxdHhkOHm3InoILL7oYV1rZ/NHlbLc94/WjyFv4+?=
 =?us-ascii?Q?mqOzpCC/9s8E/WtyZXobA4BYFDT8JLhstEsOAaOLZX6osgOmDMI6sm8eOiiU?=
 =?us-ascii?Q?madacHVdNQGBCuzcWNlucb4TJszBMKufUxP6W4oBNtnxiRDpLoPPvKP5gG9A?=
 =?us-ascii?Q?3U1QXTNkAkmckQySFOBIbBmSClGUW2++U1QugNEzjSnxkmGT/zALqdT7/n4+?=
 =?us-ascii?Q?Z4OrhCusiuGJWrf43sMaswnVHXijUymH1VgFTz9SR8gGlpRrlQ9cxORtbAjP?=
 =?us-ascii?Q?rhd4eLESLIi/i45rYd6U6r66ZODKKNRX/A6daVw6IHLUWGe7uPVzvI8f+sk5?=
 =?us-ascii?Q?S5f1St6WaHNKOe6bXX/TwVlwiWeUHhIIxjGn7BzDl8pPdGm6fqDCfazYXigW?=
 =?us-ascii?Q?/Oe1TF7RjJOc9vTDi9mClLx9v/3pK+QSqCMgkNSthZ6RG+p6pyPDyKTjtg3i?=
 =?us-ascii?Q?qsCKmKP1xL3n1Fpe2Z0ZVYSK1wFJA/Uod1Uq7v7r5A+CaoN5HtOkj3bNIYzE?=
 =?us-ascii?Q?UL629vbuixOr+NfAEBHZ+l6Zc6O7A8YuK6tyfYBsv5/yUjBF3mTq23fGLaG/?=
 =?us-ascii?Q?rvyO+gyj5pTkH5TNEANw6xpqUZ7WDhFa+y994iq7wc9FJpOSTZzR7qMr7Exx?=
 =?us-ascii?Q?D1EJPlbX3g9A8sdeTCMOZV2vV1uYnv7FXBIC7EmXQpo0usXnFPfNujFfcs4h?=
 =?us-ascii?Q?Nv2CXUB6Kq443okWGba45BnmNuSGvbKM2q3qa6SJQbBAvwN4R6MA/csUv+DR?=
 =?us-ascii?Q?oFRVvwCRvR4lBt64CVnpMs4+5+PG5RSZqVwjVZhJ/GXAH1KDTwrU40f96eZj?=
 =?us-ascii?Q?rXnp9ZmP/Cojy5yC8zgXi+M+gnUE959Bfqhowba4QDY0PYuJFG1MzfWMg4Kg?=
 =?us-ascii?Q?Hyrlgm6I5a6KWatyeq2DO8uZYqN/fxSJosWSMnQ6LCroyINiqRRxH2k/sjp5?=
 =?us-ascii?Q?YtcDoUD0aSF3/yKhnQ6ER8QqEOisx28LFRR1/l3vTWHcioMERmfEVRoNs3uO?=
 =?us-ascii?Q?vr1z9qoXg69ieNxxVljzXATAtbZ/iwtbPqefSZlLqSxEZ3s+Lc9jWbIfHR53?=
 =?us-ascii?Q?QhmvIrhrLixKfyt/ruvhDNWSOgPK0+twATPYXPDIlDv0QRK+9AWLxdUN+2ay?=
 =?us-ascii?Q?ZCL45jiyWZq5mxih3C9PtOBSyho1mGcAq/4KdnBkvUf+rgar732CD6CMV7aC?=
 =?us-ascii?Q?sWz0U0f/WVxtR5D0vN4L5NFnBTXxk+jMheEA/kGWSSoOv7kw6S75MlyyxQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(13003099007)(921020);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23689A1EFCFB834FAFB76DF5DB22BA6F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9288
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: f663b1991b574a4c93718838da6e29fb:solidrun,office365_emails,sent,inline:a110d822b3037142edc8c94754f8d9ab
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c1a480c1-489d-4152-d48e-08de4e898017
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|7416014|376014|36860700013|14060799003|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v74CFEc07TaedPjF0iCrz3h5rijjNOlnvjaSmV3TAcofiJVetPxFA1eiFHOH?=
 =?us-ascii?Q?BvMz7zSoCg2jCTif+ZSNvgKkMbLatMuPusCkBW+06ZanjWMFElLYkpUg+tXE?=
 =?us-ascii?Q?ONJ2YiDatHT3XVcDiCqMWj0x6bP0zHM35+mvmqzB8+yowCBKrQcL2VMaZ62a?=
 =?us-ascii?Q?lvaVXqwkd3EmzaP3VziP1wat2nxxA6J7ro0buT2bQeodSCCNMMk40Pr07f72?=
 =?us-ascii?Q?7akaV6sVDnG1SPlNlluVurVwWh7NHm+Sm2/578Gw6dRf3iCCPraVLfphk8BL?=
 =?us-ascii?Q?4f3K14Sm8aXdTNNZFH3J9wkYhBhVUpyfGKMZampnp5hmHBe8U5QxzlZZG6TG?=
 =?us-ascii?Q?8sFPLAWoX9VO+gEtS/G8mktZbDFvJHghDW73aT/astIYkZMxGb32J3T0GBFQ?=
 =?us-ascii?Q?a39U1381Eobcph96zYiKETi1208lJm7nToIMrGoSAhDDXNr8bXHYmFZFCZcL?=
 =?us-ascii?Q?l+ERDaMdFEKKbeDJaWYEU+sDrTOv8FuB69dkoUwRzFps0gWjJ2C/3rq86D8R?=
 =?us-ascii?Q?aRzb9FpkVEpNO3lKzMKg7JZvXeA0ahsBdxgD79J11XAeyeT1nxs7HzQRp4xN?=
 =?us-ascii?Q?ft0IFDW0OolzhQ8+QDSL6eA8duIrxtqK1x+Oq7HLKux8z2/a9FdOyWwPAgSU?=
 =?us-ascii?Q?wMHVG7Vf8fQj+3mSWpjHLyta4ze+ZcT27PsmPabyetD6/5jq3wm8KOJM+GDV?=
 =?us-ascii?Q?IPFhzyJz/iOrneyHLk3KJqkM2mtCghJGVT3JhZBqwT6/hOw35eZRje0WUh0l?=
 =?us-ascii?Q?05mgTamIjBOB00EPUcu2no7ROf6uA7DIZdxByBrG4DDuYAY/1s1B06rhDM3W?=
 =?us-ascii?Q?3ofoQho07M71aMnW/DIE8wB0ud0XYa93/kdzGz6qDBXNRyFOfKUDx7Bz07Jf?=
 =?us-ascii?Q?4iOlZUUG2vXWUELhnjGquiUgnGaukbyJ7MnBtR0E7Ycqr4DTfSQaklLHI2gu?=
 =?us-ascii?Q?/N21/uPwQDj7QMaB8kP867dkbxJTi334ubrBeJtCHw2WI0nTs9mAyw36NmJR?=
 =?us-ascii?Q?WPQEFlG/JHhTU3HDtGeVncvUOrdPIeg0CzUz6KptZvj83C+Mv5p7wyM/DZeN?=
 =?us-ascii?Q?ou95tGv4eCd3PQ3r0EkrhZpz8VUNx6CX7Op6BHlPp9yNsv/B/1kIZjmIfmit?=
 =?us-ascii?Q?AwGG53fNkWiHrYcoRUBtVSeMGK23K8Kg0x90Do+TmCjxpuMIuSSYp7Do4Pim?=
 =?us-ascii?Q?w6rweQuM81qg+6EjerLTLV1aF8TBUbjmI1+3ky0p+oK/8bfy5W6UeqN0/e9r?=
 =?us-ascii?Q?Wzn0ci6KpljeENc/5R92IxhrTE+daN60NGVWJZ1idx0InXt/uUeVurs4UARi?=
 =?us-ascii?Q?innVYnQFYZNWYG39WUGAbxnZdLr5uOubXgHPXCWBFJDtkkOhowsgEkW8+Ahy?=
 =?us-ascii?Q?IrAe3DC5Db5yvLDkZMT2ZpiKGKPI8ida9rmfzZyDsn5PpC5uaF3ODzghqCzW?=
 =?us-ascii?Q?4fp6o5b1Q+QuiliVwsG3fbDaspuN8vYvnHCe7ShLkl03K9H+x4ievCckg1gR?=
 =?us-ascii?Q?MVmVRGF057MpkING9kqQ2JVNDqxOUb6NMC6sFnbBNaNm7UBHuY2ZCRqLVpya?=
 =?us-ascii?Q?Oir3j4MEx8O+PMWHijEx5LCX162ofJ9NBzm2+PgW?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(7416014)(376014)(36860700013)(14060799003)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:42:51.1819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a07d456-380f-4e17-aada-08de4e8986cc
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

On Wednesday, 31 December 2025 21:18:51 IST kernel test robot wrote:
> Hi Josua,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]
>=20
> url:  =20
> https://github.com/intel-lab-lkp/linux/commits/Josua-Mayer/phy-can-transc=
ei
> ver-rename-temporary-helper-function-to-avoid-conflict/20251229-223153 ba=
se:
>   8f0b4cce4481fb22653697cced8d0d04027cb1e8
> patch link:  =20
> https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-2-a023e55758fe%40solid-=
ru
> n.com patch subject: [PATCH v4 2/7] mux: Add helper functions for getting
> optional and selected mux-state config: parisc-randconfig-002-20260101
> (https://download.01.org/0day-ci/archive/20260101/202601010305.tpY47HE4-l=
kp
> @intel.com/config) compiler: hppa-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20260101/202601010305.tpY47HE4-l=
kp
> @intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion
> of the same patch/commit), kindly add following tags
>=20
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202601010305.tpY47HE4-lkp@intel.c=
om
> | /
> All error/warnings (new ones prefixed by >>):
>=20
>    In file included from drivers/mux/core.c:19:
>=20
>    include/linux/mux/consumer.h: In function 'mux_control_put':
> >> include/linux/mux/consumer.h:138:9: warning: 'return' with a value, in
> >> function returning void [-Wreturn-type]
>      138 |  return -EOPNOTSUPP;
>=20
>          |         ^
>=20
To be fixed in next version

>    include/linux/mux/consumer.h:136:20: note: declared here
>      136 | static inline void mux_control_put(struct mux_control *mux)
>=20
>          |                    ^~~~~~~~~~~~~~~
>=20
>    drivers/mux/core.c: At top level:
> >> drivers/mux/core.c:302:14: error: redefinition of 'mux_control_states'
>=20
>      302 | unsigned int mux_control_states(struct mux_control *mux)
>=20
>          |              ^~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:70:28: note: previous definition of
> 'mux_control_states' was here 70 | static inline unsigned int
> mux_control_states(struct mux_control *mux)
>          |                            ^~~~~~~~~~~~~~~~~~

I don't understand how this is possible.
In the header file line 136 the inline declaration for mux_control_states i=
s=20
gated by ifdef CONFIG_MULTIPLEXER else case.

The build of mux/core.c itself is gated in Makefile by CONFIG_MULTIPLEXER.

So mux/core.c is not being built when CONFIG_MULTIPLEXER is not set.
If it is set, we hit in the header file the non-inline declaration near sta=
rt
of the file.

> >>=20
> >> drivers/mux/core.c:365:5: error: redefinition of
> >> 'mux_control_select_delay'
>=20
>      365 | int mux_control_select_delay(struct mux_control *mux, unsigned
> int state,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:74:32: note: previous definition of
> 'mux_control_select_delay' was here 74 | static inline int __must_check
> mux_control_select_delay(struct mux_control *mux,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:403:5: error: redefinition of 'mux_state_select_del=
ay'
>=20
>      403 | int mux_state_select_delay(struct mux_state *mstate, unsigned =
int
> delay_us)
>          |     ^~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:79:32: note: previous definition of
> 'mux_state_select_delay' was here 79 | static inline int __must_check
> mux_state_select_delay(struct mux_state *mstate,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:425:5: error: redefinition of
> >> 'mux_control_try_select_delay'
>      425 | int mux_control_try_select_delay(struct mux_control *mux,
> unsigned int state,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:84:32: note: previous definition of
> 'mux_control_try_select_delay' was here 84 | static inline int __must_che=
ck
> mux_control_try_select_delay(struct mux_control *mux,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:459:5: error: redefinition of
> >> 'mux_state_try_select_delay'
>      459 | int mux_state_try_select_delay(struct mux_state *mstate, unsig=
ned
> int delay_us)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:90:32: note: previous definition of
> 'mux_state_try_select_delay' was here 90 | static inline int __must_check
> mux_state_try_select_delay(struct mux_state *mstate,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:477:5: error: redefinition of 'mux_control_deselect=
'
>=20
>      477 | int mux_control_deselect(struct mux_control *mux)
>=20
>          |     ^~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:118:19: note: previous definition of
> 'mux_control_deselect' was here 118 | static inline int
> mux_control_deselect(struct mux_control *mux)
>          |                   ^~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:503:5: error: redefinition of 'mux_state_deselect'
>=20
>      503 | int mux_state_deselect(struct mux_state *mstate)
>=20
>          |     ^~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:122:19: note: previous definition of
> 'mux_state_deselect' was here 122 | static inline int
> mux_state_deselect(struct mux_state *mstate)
>          |                   ^~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:625:21: error: redefinition of 'mux_control_get'
>=20
>      625 | struct mux_control *mux_control_get(struct device *dev, const
> char *mux_name)
>          |                     ^~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:127:35: note: previous definition of
> 'mux_control_get' was here 127 | static inline struct mux_control
> *mux_control_get(struct device *dev, const char *mux_name)
>          |                                   ^~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:638:21: error: redefinition of
> >> 'mux_control_get_optional'
>      638 | struct mux_control *mux_control_get_optional(struct device *de=
v,
> const char *mux_name)
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:131:35: note: previous definition of
> 'mux_control_get_optional' was here 131 | static inline struct mux_contro=
l
> *mux_control_get_optional(struct device *dev,
>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:650:6: error: redefinition of 'mux_control_put'
>=20
>      650 | void mux_control_put(struct mux_control *mux)
>=20
>          |      ^~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:136:20: note: previous definition of
> 'mux_control_put' was here 136 | static inline void mux_control_put(struc=
t
> mux_control *mux)
>          |                    ^~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:671:21: error: redefinition of 'devm_mux_control_ge=
t'
>=20
>      671 | struct mux_control *devm_mux_control_get(struct device *dev,
>=20
>          |                     ^~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:141:35: note: previous definition of
> 'devm_mux_control_get' was here 141 | static inline struct mux_control
> *devm_mux_control_get(struct device *dev, const char *mux_name)
>          |                                   ^~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:774:19: error: redefinition of 'devm_mux_state_get'
>=20
>      774 | struct mux_state *devm_mux_state_get(struct device *dev, const
> char *mux_name)
>          |                   ^~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:145:33: note: previous definition of
> 'devm_mux_state_get' was here 145 | static inline struct mux_state
> *devm_mux_state_get(struct device *dev, const char *mux_name)
>          |                                 ^~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:788:19: error: redefinition of
> >> 'devm_mux_state_get_optional'
>      788 | struct mux_state *devm_mux_state_get_optional(struct device *d=
ev,
> const char *mux_name)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:149:33: note: previous definition of
> 'devm_mux_state_get_optional' was here 149 | static inline struct mux_sta=
te
> *devm_mux_state_get_optional(struct device *dev,
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:838:19: error: redefinition of
> >> 'devm_mux_state_get_selected'
>      838 | struct mux_state *devm_mux_state_get_selected(struct device *d=
ev,
> const char *mux_name)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:154:33: note: previous definition of
> 'devm_mux_state_get_selected' was here 154 | static inline struct mux_sta=
te
> *devm_mux_state_get_selected(struct device *dev,
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>=20
> >> drivers/mux/core.c:854:19: error: redefinition of
> >> 'devm_mux_state_get_optional_selected'
>      854 | struct mux_state *devm_mux_state_get_optional_selected(struct
> device *dev,
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from drivers/mux/core.c:19:
>    include/linux/mux/consumer.h:159:33: note: previous definition of
> 'devm_mux_state_get_optional_selected' was here 159 | static inline struc=
t
> mux_state *devm_mux_state_get_optional_selected(struct device *dev,
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>          |                                 ~~~
>=20
> --
>    In file included from core.c:19:
>=20
>    include/linux/mux/consumer.h: In function 'mux_control_put':
> >> include/linux/mux/consumer.h:138:9: warning: 'return' with a value, in
> >> function returning void [-Wreturn-type]
>      138 |  return -EOPNOTSUPP;
>=20
>          |         ^
>=20
>    include/linux/mux/consumer.h:136:20: note: declared here
>      136 | static inline void mux_control_put(struct mux_control *mux)
>=20
>          |                    ^~~~~~~~~~~~~~~
>=20
>    core.c: At top level:
>    core.c:302:14: error: redefinition of 'mux_control_states'
>      302 | unsigned int mux_control_states(struct mux_control *mux)
>=20
>          |              ^~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:70:28: note: previous definition of
> 'mux_control_states' was here 70 | static inline unsigned int
> mux_control_states(struct mux_control *mux)
>          |                            ^~~~~~~~~~~~~~~~~~
>=20
>    core.c:365:5: error: redefinition of 'mux_control_select_delay'
>      365 | int mux_control_select_delay(struct mux_control *mux, unsigned
> int state,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:74:32: note: previous definition of
> 'mux_control_select_delay' was here 74 | static inline int __must_check
> mux_control_select_delay(struct mux_control *mux,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:403:5: error: redefinition of 'mux_state_select_delay'
>      403 | int mux_state_select_delay(struct mux_state *mstate, unsigned =
int
> delay_us)
>          |     ^~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:79:32: note: previous definition of
> 'mux_state_select_delay' was here 79 | static inline int __must_check
> mux_state_select_delay(struct mux_state *mstate,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:425:5: error: redefinition of 'mux_control_try_select_delay'
>      425 | int mux_control_try_select_delay(struct mux_control *mux,
> unsigned int state,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:84:32: note: previous definition of
> 'mux_control_try_select_delay' was here 84 | static inline int __must_che=
ck
> mux_control_try_select_delay(struct mux_control *mux,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:459:5: error: redefinition of 'mux_state_try_select_delay'
>      459 | int mux_state_try_select_delay(struct mux_state *mstate, unsig=
ned
> int delay_us)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:90:32: note: previous definition of
> 'mux_state_try_select_delay' was here 90 | static inline int __must_check
> mux_state_try_select_delay(struct mux_state *mstate,
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:477:5: error: redefinition of 'mux_control_deselect'
>      477 | int mux_control_deselect(struct mux_control *mux)
>=20
>          |     ^~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:118:19: note: previous definition of
> 'mux_control_deselect' was here 118 | static inline int
> mux_control_deselect(struct mux_control *mux)
>          |                   ^~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:503:5: error: redefinition of 'mux_state_deselect'
>      503 | int mux_state_deselect(struct mux_state *mstate)
>=20
>          |     ^~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:122:19: note: previous definition of
> 'mux_state_deselect' was here 122 | static inline int
> mux_state_deselect(struct mux_state *mstate)
>          |                   ^~~~~~~~~~~~~~~~~~
>=20
>    core.c:625:21: error: redefinition of 'mux_control_get'
>      625 | struct mux_control *mux_control_get(struct device *dev, const
> char *mux_name)
>          |                     ^~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:127:35: note: previous definition of
> 'mux_control_get' was here 127 | static inline struct mux_control
> *mux_control_get(struct device *dev, const char *mux_name)
>          |                                   ^~~~~~~~~~~~~~~
>=20
>    core.c:638:21: error: redefinition of 'mux_control_get_optional'
>      638 | struct mux_control *mux_control_get_optional(struct device *de=
v,
> const char *mux_name)
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:131:35: note: previous definition of
> 'mux_control_get_optional' was here 131 | static inline struct mux_contro=
l
> *mux_control_get_optional(struct device *dev,
>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:650:6: error: redefinition of 'mux_control_put'
>      650 | void mux_control_put(struct mux_control *mux)
>=20
>          |      ^~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:136:20: note: previous definition of
> 'mux_control_put' was here 136 | static inline void mux_control_put(struc=
t
> mux_control *mux)
>          |                    ^~~~~~~~~~~~~~~
>=20
>    core.c:671:21: error: redefinition of 'devm_mux_control_get'
>      671 | struct mux_control *devm_mux_control_get(struct device *dev,
>=20
>          |                     ^~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:141:35: note: previous definition of
> 'devm_mux_control_get' was here 141 | static inline struct mux_control
> *devm_mux_control_get(struct device *dev, const char *mux_name)
>          |                                   ^~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:774:19: error: redefinition of 'devm_mux_state_get'
>      774 | struct mux_state *devm_mux_state_get(struct device *dev, const
> char *mux_name)
>          |                   ^~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:145:33: note: previous definition of
> 'devm_mux_state_get' was here 145 | static inline struct mux_state
> *devm_mux_state_get(struct device *dev, const char *mux_name)
>          |                                 ^~~~~~~~~~~~~~~~~~
>=20
>    core.c:788:19: error: redefinition of 'devm_mux_state_get_optional'
>      788 | struct mux_state *devm_mux_state_get_optional(struct device *d=
ev,
> const char *mux_name)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    In file included from core.c:19:
>    include/linux/mux/consumer.h:149:33: note: previous definition of
> 'devm_mux_state_get_optional' was here 149 | static inline struct mux_sta=
te
> *devm_mux_state_get_optional(struct device *dev,
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    core.c:838:19: error: redefinition of 'devm_mux_state_get_selected'
>      838 | struct mux_state *devm_mux_state_get_selected(struct device *d=
ev,
> const char *mux_name)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> vim +/mux_control_states +302 drivers/mux/core.c
>=20
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  295
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  296=
=20
> /** a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14=20
> 297   * mux_control_states() - Query the number of multiplexer states.
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  298 =
=20
> * @mux: The mux-control to query. a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  299   * a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  300   * Return: The
> number of multiplexer states. a3b02a9c6591ce drivers/mux/mux-core.c Peter
> Rosin        2017-05-14  301   */ a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14 @302  unsigned int mux_control_states(struc=
t
> mux_control *mux) a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =
=20
> 2017-05-14  303  { a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin     =
 =20
> 2017-05-14  304  	return mux->states; a3b02a9c6591ce drivers/mux/mux-
core.c
> Peter Rosin        2017-05-14  305  } a3b02a9c6591ce drivers/mux/mux-core=
.c
> Peter Rosin        2017-05-14  306  EXPORT_SYMBOL_GPL(mux_control_states)=
;
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  307
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  308=
=20
> /* a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  3=
09
>   * The mux->lock must be down when calling this function. a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  310   */
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  311=
=20
> static int __mux_control_select(struct mux_control *mux, int state)
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  312 =
 {
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  313=
=20
> 	int ret; a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  314 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  315  	if (WARN_ON(state < 0 || state >=3D mux->states))
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  316=
=20
> 		return -EINVAL; a3b02a9c6591ce drivers/mux/mux-core.c=20
Peter Rosin      =20
> 2017-05-14  317 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  318  	if (mux->cached_state =3D=3D state) a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  319  	=09
return 0;
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  320
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  321=
=20
> 	ret =3D mux_control_set(mux, state); a3b02a9c6591ce drivers/mux/mux-
core.c
> Peter Rosin        2017-05-14  322  	if (ret >=3D 0) a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  323  	=09
return 0;
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  324
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  325=
=20
> 	/* The mux update failed, try to revert if appropriate... */
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  326=
=20
> 	if (mux->idle_state !=3D MUX_IDLE_AS_IS) a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  327=20
> 		mux_control_set(mux, mux->idle_state); a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  328 a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  329  	return ret;
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  330 =
 }
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  331
> 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  332=
=20
> static void mux_control_delay(struct mux_control *mux, unsigned int
> delay_us) 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch
> 2021-10-07  333  { 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchur=
ch
> 2021-10-07  334  	ktime_t delayend; 17b5b576ff5faf drivers/mux/core.c   =
=20
> Vincent Whitchurch 2021-10-07  335  	s64 remaining; 17b5b576ff5faf
> drivers/mux/core.c     Vincent Whitchurch 2021-10-07  336 17b5b576ff5faf
> drivers/mux/core.c     Vincent Whitchurch 2021-10-07  337  	if (!
delay_us)
> 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  338=
=20
> 		return; 17b5b576ff5faf drivers/mux/core.c     Vincent=20
Whitchurch
> 2021-10-07  339 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch
> 2021-10-07  340  	delayend =3D ktime_add_us(mux->last_change, delay_us);
> 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  341=
=20
> 	remaining =3D ktime_us_delta(delayend, ktime_get()); 17b5b576ff5faf
> drivers/mux/core.c     Vincent Whitchurch 2021-10-07  342  	if (remaining=
=20
>
> 0) 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  3=
43
>  		fsleep(remaining); 17b5b576ff5faf drivers/mux/core.c    =20
Vincent
> Whitchurch 2021-10-07  344  } 17b5b576ff5faf drivers/mux/core.c     Vince=
nt
> Whitchurch 2021-10-07  345 a3b02a9c6591ce drivers/mux/mux-core.c Peter
> Rosin        2017-05-14  346  /** 17b5b576ff5faf drivers/mux/core.c   =20
> Vincent Whitchurch 2021-10-07  347   * mux_control_select_delay() - Selec=
t
> the given multiplexer state. a3b02a9c6591ce drivers/mux/mux-core.c Peter
> Rosin        2017-05-14  348   * @mux: The mux-control to request a chang=
e
> of state from. a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  349   * @state: The new requested state. 17b5b576ff5faf
> drivers/mux/core.c     Vincent Whitchurch 2021-10-07  350   * @delay_us:
> The time to delay (in microseconds) if the mux state is changed.
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  351 =
=20
> * a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  35=
2=20
>  * On successfully selecting the mux-control state, it will be locked unt=
il
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  353 =
=20
> * there is a call to mux_control_deselect(). If the mux-control is alread=
y
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  354 =
=20
> * selected when mux_control_select() is called, the caller will be blocke=
d
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  355 =
=20
> * until mux_control_deselect() or mux_state_deselect() is called (by
> someone 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-=
07
>  356   * else). a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  357   * a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin    =
 =20
>  2017-05-14  358   * Therefore, make sure to call mux_control_deselect()
> when the operation is a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin  =
 =20
>    2017-05-14  359   * complete and the mux-control is free for others to
> use, but do not call a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin   =
 =20
>   2017-05-14  360   * mux_control_deselect() if mux_control_select() fail=
s.
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  361 =
=20
> * a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  36=
2=20
>  * Return: 0 when the mux-control state has the requested state or a
> negative a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  363   * errno on error. a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  364   */ 17b5b576ff5faf drivers/mux/core.c=
 =20
>   Vincent Whitchurch 2021-10-07 @365  int mux_control_select_delay(struct
> mux_control *mux, unsigned int state, 17b5b576ff5faf drivers/mux/core.c  =
 =20
> Vincent Whitchurch 2021-10-07  366  			     unsigned int=20
delay_us)
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  367 =
 {
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  368=
=20
> 	int ret; a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  369 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  370  	ret =3D down_killable(&mux->lock); a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  371  	if (ret < 0)
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  372=
=20
> 		return ret; a3b02a9c6591ce drivers/mux/mux-core.c Peter=20
Rosin      =20
> 2017-05-14  373 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  374  	ret =3D __mux_control_select(mux, state); 17b5b576ff5fa=
f
> drivers/mux/core.c     Vincent Whitchurch 2021-10-07  375  	if (ret >=3D =
0)
> 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  376=
=20
> 		mux_control_delay(mux, delay_us); a3b02a9c6591ce=20
drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  377 a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  378  	if (ret < 0) a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  379=20
> 		up(&mux->lock); a3b02a9c6591ce drivers/mux/mux-core.c=20
Peter Rosin      =20
> 2017-05-14  380 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  381  	return ret; a3b02a9c6591ce drivers/mux/mux-core.c=20
Peter
> Rosin        2017-05-14  382  } 17b5b576ff5faf drivers/mux/core.c   =20
> Vincent Whitchurch 2021-10-07  383=20
> EXPORT_SYMBOL_GPL(mux_control_select_delay); a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  384 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  385  /**
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  386 =
=20
> * mux_state_select_delay() - Select the given multiplexer state.
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  387 =
=20
> * @mstate: The mux-state to select. 84564481bc4520 drivers/mux/core.c   =
=20
> Aswath Govindraju  2022-01-07  388   * @delay_us: The time to delay (in
> microseconds) if the mux state is changed. 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  389   *
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  390 =
=20
> * On successfully selecting the mux-state, its mux-control will be locked
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  391 =
=20
> * until there is a call to mux_state_deselect(). If the mux-control is
> already 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-=
07
>  392   * selected when mux_state_select() is called, the caller will be
> blocked 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-=
07
>  393   * until mux_state_deselect() or mux_control_deselect() is called (=
by
> someone 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-=
07
>  394   * else). 84564481bc4520 drivers/mux/core.c     Aswath Govindraju=20
> 2022-01-07  395   * 84564481bc4520 drivers/mux/core.c     Aswath Govindra=
ju
>  2022-01-07  396   * Therefore, make sure to call mux_state_deselect() wh=
en
> the operation is 84564481bc4520 drivers/mux/core.c     Aswath Govindraju=
=20
> 2022-01-07  397   * complete and the mux-control is free for others to us=
e,
> but do not call 84564481bc4520 drivers/mux/core.c     Aswath Govindraju=20
> 2022-01-07  398   * mux_state_deselect() if mux_state_select() fails.
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  399 =
=20
> * 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  40=
0=20
>  * Return: 0 when the mux-state has been selected or a negative
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  401 =
=20
> * errno on error. 84564481bc4520 drivers/mux/core.c     Aswath Govindraju=
=20
> 2022-01-07  402   */ 84564481bc4520 drivers/mux/core.c     Aswath
> Govindraju  2022-01-07 @403  int mux_state_select_delay(struct mux_state
> *mstate, unsigned int delay_us) 84564481bc4520 drivers/mux/core.c   =20
> Aswath Govindraju  2022-01-07  404  { 84564481bc4520 drivers/mux/core.c  =
 =20
> Aswath Govindraju  2022-01-07  405  	return
> mux_control_select_delay(mstate->mux, mstate->state, delay_us);
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  406 =
 }
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  407=
=20
> EXPORT_SYMBOL_GPL(mux_state_select_delay); 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  408 a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  409  /**
> 17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  410 =
=20
> * mux_control_try_select_delay() - Try to select the given multiplexer
> state. a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-1=
4=20
> 411   * @mux: The mux-control to request a change of state from.
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  412 =
=20
> * @state: The new requested state. 17b5b576ff5faf drivers/mux/core.c   =20
> Vincent Whitchurch 2021-10-07  413   * @delay_us: The time to delay (in
> microseconds) if the mux state is changed. a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  414   *
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  415 =
=20
> * On successfully selecting the mux-control state, it will be locked unti=
l
> f22d1117b9c3e2 drivers/mux/core.c     Peter Rosin        2022-01-07  416 =
=20
> * mux_control_deselect() is called. a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  417   * a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  418   * Therefore,
> make sure to call mux_control_deselect() when the operation is
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  419 =
=20
> * complete and the mux-control is free for others to use, but do not call
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  420 =
=20
> * mux_control_deselect() if mux_control_try_select() fails. a3b02a9c6591c=
e
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  421   *
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  422 =
=20
> * Return: 0 when the mux-control state has the requested state or a
> negative a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  423   * errno on error. Specifically -EBUSY if the mux-contro=
l
> is contended. a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  424   */ 17b5b576ff5faf drivers/mux/core.c     Vincent
> Whitchurch 2021-10-07 @425  int mux_control_try_select_delay(struct
> mux_control *mux, unsigned int state, 17b5b576ff5faf drivers/mux/core.c  =
 =20
> Vincent Whitchurch 2021-10-07  426  				=20
unsigned int delay_us)
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  427 =
 {
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  428=
=20
> 	int ret; a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  429 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  430  	if (down_trylock(&mux->lock)) a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  431  	=09
return -EBUSY;
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  432
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  433=
=20
> 	ret =3D __mux_control_select(mux, state); 17b5b576ff5faf drivers/mux/
core.c=20
>    Vincent Whitchurch 2021-10-07  434  	if (ret >=3D 0) 17b5b576ff5faf
> drivers/mux/core.c     Vincent Whitchurch 2021-10-07  435=20
> 		mux_control_delay(mux, delay_us); a3b02a9c6591ce=20
drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  436 a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  437  	if (ret < 0) a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  438=20
> 		up(&mux->lock); a3b02a9c6591ce drivers/mux/mux-core.c=20
Peter Rosin      =20
> 2017-05-14  439 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  440  	return ret; a3b02a9c6591ce drivers/mux/mux-core.c=20
Peter
> Rosin        2017-05-14  441  } 17b5b576ff5faf drivers/mux/core.c   =20
> Vincent Whitchurch 2021-10-07  442=20
> EXPORT_SYMBOL_GPL(mux_control_try_select_delay); a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  443 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  444  /**
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  445 =
=20
> * mux_state_try_select_delay() - Try to select the given multiplexer stat=
e.
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  446 =
=20
> * @mstate: The mux-state to select. 84564481bc4520 drivers/mux/core.c   =
=20
> Aswath Govindraju  2022-01-07  447   * @delay_us: The time to delay (in
> microseconds) if the mux state is changed. 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  448   *
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  449 =
=20
> * On successfully selecting the mux-state, its mux-control will be locked
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  450 =
=20
> * until mux_state_deselect() is called. 84564481bc4520 drivers/mux/core.c=
 =20
>   Aswath Govindraju  2022-01-07  451   * 84564481bc4520 drivers/mux/core.=
c=20
>    Aswath Govindraju  2022-01-07  452   * Therefore, make sure to call
> mux_state_deselect() when the operation is 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  453   * complete an=
d
> the mux-control is free for others to use, but do not call 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  454   *
> mux_state_deselect() if mux_state_try_select() fails. 84564481bc4520
> drivers/mux/core.c     Aswath Govindraju  2022-01-07  455   *
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  456 =
=20
> * Return: 0 when the mux-state has been selected or a negative errno on
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  457 =
=20
> * error. Specifically -EBUSY if the mux-control is contended.
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  458 =
=20
> */ 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07 @4=
59
>  int mux_state_try_select_delay(struct mux_state *mstate, unsigned int
> delay_us) 84564481bc4520 drivers/mux/core.c     Aswath Govindraju=20
> 2022-01-07  460  { 84564481bc4520 drivers/mux/core.c     Aswath Govindraj=
u=20
> 2022-01-07  461  	return mux_control_try_select_delay(mstate->mux,
> mstate->state, delay_us); 84564481bc4520 drivers/mux/core.c     Aswath
> Govindraju  2022-01-07  462  } 84564481bc4520 drivers/mux/core.c     Aswa=
th
> Govindraju  2022-01-07  463  EXPORT_SYMBOL_GPL(mux_state_try_select_delay=
);
> 84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  464
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  465=
=20
> /** a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14=20
> 466   * mux_control_deselect() - Deselect the previously selected
> multiplexer state. a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin     =
 =20
> 2017-05-14  467   * @mux: The mux-control to deselect. a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  468   *
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  469 =
=20
> * It is required that a single call is made to mux_control_deselect() for
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  470 =
=20
> * each and every successful call made to either of mux_control_select() o=
r
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  471 =
=20
> * mux_control_try_select(). a3b02a9c6591ce drivers/mux/mux-core.c Peter
> Rosin        2017-05-14  472   * a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  473   * Return: 0 on success and a negativ=
e
> errno on error. An error can only a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  474   * occur if the mux has an idle state=
.
> Note that even if an error occurs, the a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  475   * mux-control
> is unlocked and is thus free for the next access. a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  476   */
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14 @477=
=20
> int mux_control_deselect(struct mux_control *mux) a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  478  { a3b02a9c6591=
ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  479  	int ret =3D 0=
;
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  480
> a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  481=
=20
> 	if (mux->idle_state !=3D MUX_IDLE_AS_IS && a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  482  	  =20
> mux->idle_state !=3D mux->cached_state) a3b02a9c6591ce drivers/mux/mux-co=
re.c
> Peter Rosin        2017-05-14  483  		ret =3D=20
mux_control_set(mux,
> mux->idle_state); a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =
=20
> 2017-05-14  484 a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin      =20
> 2017-05-14  485  	up(&mux->lock); a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  486 a3b02a9c6591ce drivers/mux/mux-core.c
> Peter Rosin        2017-05-14  487  	return ret; a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  488  } a3b02a9c6591=
ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  489=20
> EXPORT_SYMBOL_GPL(mux_control_deselect); a3b02a9c6591ce
> drivers/mux/mux-core.c Peter Rosin        2017-05-14  490





