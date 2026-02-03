Return-Path: <linux-can+bounces-6481-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAqxIw0WgmmZPAMAu9opvQ
	(envelope-from <linux-can+bounces-6481-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:36:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3DDB58C
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D1883046EAA
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4F3AEF4F;
	Tue,  3 Feb 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lgKxybsU";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lgKxybsU"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023104.outbound.protection.outlook.com [52.101.72.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21F3ACA78;
	Tue,  3 Feb 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.104
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132955; cv=fail; b=foZb5D2wt+UAsFmY/w2qov8TmCfK4iRUXDdl0TT0rLuLAsOt8CT4Q7tjv+04oNNuRtAsoOTqEIfiAswWwfGt2owy97zPizdqUBYHHipAt/xdpheBfG2f7Rvf2REj8Rk3klZiSvxG91zkRRz4vO0K03Z/jxk1sA/4B4jri9tnt+w=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132955; c=relaxed/simple;
	bh=qUgapvh0UwC/pF/wJ6jp6Ixy4cLdoaxC4QNBhoOaV2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KhQcKMogcUW0D6XOXARoilElCro2B1c1C1tGNruKC1DgUlzIWFGztTrEv34Gzwa7KKlbnm5OnXWEHk4Q4iDGtYPBvhLw0GBHpTrwZLLAMNZ1lkYcCLfuupEdvVn9ZfGLbJBfztmm5vm5rLZ/gbevuioZ28mNMEoCxbn1OlDqcIM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lgKxybsU; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lgKxybsU; arc=fail smtp.client-ip=52.101.72.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WPzpB1RtUWluWrvRJOsEmyQ/BtZ/YImj4GaEJXOM8OeEakgzKvnMbJhy0fpz8wIh/SF1UtVio0vrPyow7FIy6iUdjV3bd8N8IfpeYLhvHjL9f40XgpcWH7juLOLvBDRWboDjaE/PWK1Rd5UpLjVDruqk+bJ1bq4KoSrTuy6g3HFjsWidFBFj9er8kVwiqUKIiYlTKUt38KX5Bt0CecPfv2iupPqQmQbAdT+lkWq+ThhQXmtJqhen5bnO2nsSMQno/+/okOYMhN0A6/AYWSJJTwLCokNC/oKqzFpAIY2q5yhgHsJZuHXD0lSx8KtiSU16+LvxMbYc3pVcmtSTuD5YYg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUgapvh0UwC/pF/wJ6jp6Ixy4cLdoaxC4QNBhoOaV2Y=;
 b=Adp4H2uIqKUnlbpN5FkjpiIFbhWVfOtrLC+7rOhnQ3F5bazQAHoW3OUEpF9sgOFJCzIqTgzRnGx7V0/3k+JnKQOY2wSUCtqojWU3pPewZj6EZKp+IAZ9M++TkQD3zSCTYM66EpDTlDjqF9DouXeQZt29TgycW8qaZMm6duHB9LMeuCeG6VqSy6glsQKHWwR5Oj+QjOY84q7uRCuwSb2pb/Hl0L0qliHp9d5s8n8ZyA8YITkNKDW0cQT4uyLmQlt+xI3nHWT61DCzjQm3/XTxnQemGt0XEQ7vkLontWouhQ+zQFLGiXPjMUC579LPfsMGjDInd/BFaJPSdE33ksWeyw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUgapvh0UwC/pF/wJ6jp6Ixy4cLdoaxC4QNBhoOaV2Y=;
 b=lgKxybsUxhg+84BZ+rpL8Sn6qVHRtB+ATrUejdB6h/HlMXuAEE0LpknYekrzF5HXP4tN8kihXLVqCcwUxqUOMUhTtLwlKkklEtbVqeOI3dVJ/L9i+WeeBYkJ4+/SSi2Mp5ndsgQwr+uyYeIrEvUVKohV7oPPiZL1Nl1Rc0lSPeY=
Received: from AM0PR02CA0197.eurprd02.prod.outlook.com (2603:10a6:20b:28e::34)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:35:50 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::7d) by AM0PR02CA0197.outlook.office365.com
 (2603:10a6:20b:28e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 15:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 15:35:49 +0000
Received: from emails-4541641-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-224.eu-west-1.compute.internal [10.20.6.224])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A9D3B805A7;
	Tue,  3 Feb 2026 15:35:49 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770132949; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=qUgapvh0UwC/pF/wJ6jp6Ixy4cLdoaxC4QNBhoOaV2Y=;
 b=UOFe+KoiMT3fNDWa4n5EHSlZnZSoPfrYDCNLHjEhQQB5Hg+ulO2QkZWnzWcE462g7YBKG
 i0Ar2KrivvarwO1O9TOgAneZMhPBnBb1pQhULAJihzN/a6L2r9MLc2Lx4eIE1GiGHcRQQqK
 p18OF3+Sdn/+m9lKSfRer5gdAZlVKGE=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770132949;
 b=SsbA2b4ltPfM6EkY/0NwMmIxCu5USOFF/YL20oR5a46FJY40iEGbkpuMXuuQnjSXug47E
 nULqb9Rhji8mruba3F7aricBokdE/5fwo6J0XcbDJ4SuxEJ4/SEFewAQCNkCPz0m1R05nTC
 GjkVGk4nfYRNQN893Ccvrdb4E+x6vsY=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI8+QGeP2Ndxa7QrchfAvqbnoAmUdinr/L9EhoBesUGuEwAzRBtkC0WotIIWfsTVMnE/xN6RBmgh6SRextKluvOWElG8tadXkjEZgzCI07pCGKJ3nNy3fKiqFOpM6kx/JNhq49Vd1pjBjOPFkmXk6ty7Vuuuo14a9sGPL98TygGxuudjHtQYkhUVyhTme7jAgmfSt+47p+/poH2oDWSQsKobMe94YMd4PzZ/zjHCLsuY8PinJjXET1D/ztmgpJKMrDZH6H3JIzY4wOGY7QmseWU9oHjhnpo+qPcCdSlHxfsdq3kUcmvBqih5Y1/IinG0OYx09k/WrEHuRjcj4yZV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUgapvh0UwC/pF/wJ6jp6Ixy4cLdoaxC4QNBhoOaV2Y=;
 b=Ka/hsIWPkIYOhzqip3h8aRSW7KIilGvakNe73MetiC00Dk3lFk/MMur4b8uiM2vPJS0cxdPQyLxNhVJA3y4clOrfcwMPkKWUPnTcu4K0ER1UM4p+qjK9r23k1eI9FAe7jaSZIgf399rTgdoqA/EnWfHxqKdS3/p4Qku4uBqU0WpYR2HmVqE7SV3YEbTZrb2ZBRaI6rbcKTLVFmFXfZ5PMqVPy7CxvLmcz9cgxup3cBgUFOd5//P+wSMNkh1+fuMNDHrk/iF6WuPjepd7MuuwVHeyfn7Ab2q6GMlEKEkWaannRqEtzDMcCgSIP3vD8OGl2k8p9JM7gUdMylWoulkzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUgapvh0UwC/pF/wJ6jp6Ixy4cLdoaxC4QNBhoOaV2Y=;
 b=lgKxybsUxhg+84BZ+rpL8Sn6qVHRtB+ATrUejdB6h/HlMXuAEE0LpknYekrzF5HXP4tN8kihXLVqCcwUxqUOMUhTtLwlKkklEtbVqeOI3dVJ/L9i+WeeBYkJ4+/SSi2Mp5ndsgQwr+uyYeIrEvUVKohV7oPPiZL1Nl1Rc0lSPeY=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB9181.eurprd04.prod.outlook.com (2603:10a6:150:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:35:38 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 15:35:37 +0000
From: Josua Mayer <josua@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v8 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Thread-Topic: [PATCH v8 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Thread-Index: AQHclQ1AQuOyED2mKkaecBH9RP2m/LVxG2KA
Date: Tue, 3 Feb 2026 15:35:37 +0000
Message-ID: <e6bccab9-79ce-4b9b-942e-01c504228d7b@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-2-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-2-024ea405863e@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|GV1PR04MB9181:EE_|AMS0EPF000001AE:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c276dc-e2a9-446b-a40d-08de6339e8a8
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WTdHT2hZV1pDUWVRK3N6RElKa2hONzhrWkpQdVZjLzJHN0pycGdSZDhHQWZR?=
 =?utf-8?B?OXZIQVdKazBQL2dQMTZjWUdLSWlDSjBzTEVxT0NrVEVvd1RyZXpOUWFkTTVo?=
 =?utf-8?B?K1JwV0dmb2RHL09SM3l2dUloY1RrZlF6dUE5anZ1SkhsM0hhV01ZeENCVE56?=
 =?utf-8?B?OTdMZU9pQnFPYm5pVjd0dlJ1UUwwTGxYMmdHMjNhRFZKV1k4TUNkVVNteFA0?=
 =?utf-8?B?T1F5M2ZrL0ZEQUZjVXJPOVZhM2Z1RGNvck1QMFRtUlYranpKOVZUS0llUkNx?=
 =?utf-8?B?WXZiblpHKzFuZnJiSk12enpXOVhzTTMrbW8yemMvLzFtYTl1Y2w4RS8yeTBk?=
 =?utf-8?B?MEVNUFJBalJzZkV3ZEpibE9BUjN6a29TVGV6QWNWTEJOQnhyM0Q3NkNTSUJI?=
 =?utf-8?B?TncrYXZWdlAyV0lKODdlYjhSVUZLb0o0K09ma0lVdWIwU2tlMzJvUi82Ri9Z?=
 =?utf-8?B?OWdwODd1TW1aU1l0K2RuK1UyVlZ1UlZ0QytHdmduM1NzMkxQMUdUaG5wbXBK?=
 =?utf-8?B?bHhYY2FLeW1pd0h3M3Yyd05WOFpTcnRmY29HS3JNSzBBWEZ5ZTgzaHAwNWRX?=
 =?utf-8?B?dURpalFTaFpmTHdUNjMzcy9UbXlDUjNoYldpQ2VTU25HYXFYb1hLd3RhT2JB?=
 =?utf-8?B?TEt5ZzBzdnVBU2hTN015L3ZyZ29PekxJbm5ZOGlVRlB0Si93Y0czRStBdmxV?=
 =?utf-8?B?Ky9SWFo4d0o2bkVwbWRDYkl1Vmx0NHJmVDgwbnhiTjZpeDMrdXlXMmpxSHo3?=
 =?utf-8?B?ZXdlV3o4amxDenBqRGhUaHJ4b2d4Sm1weUlkZ2p3eUY1TE5peEVqamE0U1E4?=
 =?utf-8?B?YnZNWGRaVW53RlArUndyU2FQd05URWdRYXpBeFJWT01LYUVRYlNESTErYU9o?=
 =?utf-8?B?MmNqT2N2MjU3QjAxT05Jcko4WlVnOWgxVlY0Zmloa1FkQ0RqMU5nQVhSS1BF?=
 =?utf-8?B?TEZPTWFvVXpHZExPRTNyUkkzek9Yc1ZyZXhtbnJRUEdZMjJXd3BLOGhnYi9V?=
 =?utf-8?B?Z2NJVmhIaVRweEJ1WEtkeEFUbUxHN0FiQTE0a2JJSnZUbGhzZE4zTENqQ1Fr?=
 =?utf-8?B?MWdCbi9QMStmbW1UL1F1M3RMamRSOVNVM1dIYXJ2NG1WVHNtT2krRjVNdXEy?=
 =?utf-8?B?U2VVUnpMVWNoSURMSEpFSjdxWTlZTXIwWnlUYk9mcDNXUEtsUFFsKy9TOFBq?=
 =?utf-8?B?VzdTY0FaUThNTlB2bUR4aTJrdEhUU0w3ZTltenhZTnF0Y3owcVczL1I2N2tw?=
 =?utf-8?B?ZUZIb0VQaENCQXluR0tsSUFobnFvYkVLYlBveFVtOWRvSno3WWZtSzlmZStO?=
 =?utf-8?B?WUl0WlJQM3pVNWRMeFBPUk9rMUVqOWZyN0tVZmpEUDM1WjdyTlRZbmhLd2RQ?=
 =?utf-8?B?SC96TUZZaXMrYnBjVFRDRWFzb0w4dmJPNXp4QjNJMEZZODJkcnBDb0R3WGxF?=
 =?utf-8?B?WE53MUg3R3JJbHFRVWlnM01vU3dNVGw1UVg4UU5IQXR6WmxyMEkzeUNHTSs1?=
 =?utf-8?B?VHoyWkVRcit0SUVPbTFRZlpMS1gzWXJQYlpvRXNPMExOQ0lBZ2lzSW9rNWU4?=
 =?utf-8?B?Q3RWeWZCdEozZEpZaS9UNmtSM0ZtRnNDOUJkK05OWXFzcGNWZ0YxMDljVk5V?=
 =?utf-8?B?bWFKTU1vcmxYUURPRmhIM0kyQ1dkSTNvOTZlV29YdlFEbC8wcmhOWEFzQU8x?=
 =?utf-8?B?TXNuM0U0VXpETUVyL1B3eFFVak5tVk5SSHNFZW1jd0NGY0RkRGoyYWE0V2px?=
 =?utf-8?B?bXJEUm51dHNhVlJ4OFpNOUk3ZE13MWZlUFdPYzBQMlVOZGZ0SVJiZmp4bXp4?=
 =?utf-8?B?aW11SWRsMVdnWkhOSHR2ZGd2aTUwbnlIaWw1a2Z1UkNVa0kyczRjelo5a2wy?=
 =?utf-8?B?K3JHZklqQ2pnVFVQaW1tM2ZHRkQ2S1Jma3o1WFl4bEt1U0t6RHcycXRuSlJL?=
 =?utf-8?B?aGY4aGNJL1hGNFNEcjZ4VnZwVWtoazhENkxWTURDOWxIeTYrVkNvSWV0eWZj?=
 =?utf-8?B?UmM3SXdzWlRDcngxb2RuTU8vV2dSZUlCQ2ZxOGtpYkFsZ1RubmF1TFk2R1NF?=
 =?utf-8?B?bk5mY242cGQ5bFVZVWFVenc5VjhkRkxFdUt2cHgvT0Fwc21tWTRzMWtNa3JZ?=
 =?utf-8?B?dVhoa2x5SC9uOFpQSkZBTUFZeFhVZUpnU0VzV0tsWmN2YzhheHkvaW5iZXpq?=
 =?utf-8?Q?JvgqxWukXWqbIq71NlJcSOJGdoFLDeGcOmGcAdh3D6jj?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <783DAD6815A96E44BF779C4828927A1E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e3ae7101d3164d8ea6d985231a36aae7:solidrun,office365_emails,sent,inline:aad7f826f582911679b0e9e274983a08
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1176f94c-b854-4678-c306-08de6339e15e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjVxRFJBRzVDem52UW9JTzlPeng1cG4xNGg3VnRMMXBxKyszS2UwRG1sNmp4?=
 =?utf-8?B?VjViWjd3cVNQL2pFd3NoWHpWVDBOMmRiL20rOVhtL3JaelFzMGVpeE0yUGxZ?=
 =?utf-8?B?cnFmL01IeHlxSGRmZFhFd2d0bjhvT1dWRVVXLytSeWZFSE9qcWpVam5FYWxp?=
 =?utf-8?B?Yms0OENXVzBYL3RnVno4VytQZ3hFRWVVRnQ2NnF1R01EY1BNTlZvb0o3RGVJ?=
 =?utf-8?B?Q090azRKZlB4WndhZWJ4NUVFZ2l4eGhUdTdObkR6RE01Y2QvMmxueHdNdjQ5?=
 =?utf-8?B?ZDhyRk5rM3dDc1gwdW12UG5qT0NUUlo3TzdRaUVyRkdnb3RzUzFtYlJ0VWFh?=
 =?utf-8?B?VFRKWFRUMEpneFNtYWUzQ09wMGdkRmV6QXNQTVRCN1B4TFFLSStzdE5rTFha?=
 =?utf-8?B?UnE3Q2RHZEVYTHkraDhnNmpyNGZoeVoxZDFqcDdIbnRWSko4TEROc1dSY1Yy?=
 =?utf-8?B?bU50YWo0WVNBRjlNSFVWaVR3Tkg3SW41UWlTaDFYQmtwM3NUOHhxS09QalBS?=
 =?utf-8?B?NThTb0RZN3pibVBpbVF0NHdHSXBYQzI5em56T3BiM09HSnBmMktYOFdKZkY1?=
 =?utf-8?B?ajl0MVRVL0ZYYWQ1aGRGRkJNK2RwakZVR3czandkaWFWY3hUUk8vNXdQTmp6?=
 =?utf-8?B?bjFZWTF3bkV1dERJdUtRMlZnSkg4RzZDUEVBUWNQK2crVHA4QTZlMjJPYU5w?=
 =?utf-8?B?SGRROXdyZ0s4ZHVCYTdINkc3UzhSU2I4LzVaMEcwb1hsN3NOZXdNU1RWaXRT?=
 =?utf-8?B?ckV6QnRmUWVETks2elI5UmFyNmJiaWV1MzBCc3pNYTFIWlFXNFdZelI2eWxX?=
 =?utf-8?B?WTFZRm9lWGxLTW5la01oNEtnVjBJVFpxZTBHK2EvMnZTanZLMG1NUDFFTFJV?=
 =?utf-8?B?VEFZSkZIcUwySGNwTGh2M2pZSXNWcXlIUVAzQnNCcnEyZVAyZVE1Q29Da3pH?=
 =?utf-8?B?blZWSXljaWZyaExnYkQyUFc2ZWVKOEVWMUE4NlhvYzlZbjBtWi9QTmR2Tmg4?=
 =?utf-8?B?c2QrZnhEWFZOOUhMb1pmQ1FFVGJpbTZxMmdRbXI0VEhnYTNrY0dMakdRQVZi?=
 =?utf-8?B?YmJIQytQbklISnZaZGNIMXl5MExBeHltZFAzTG43eUF2c0w4MWFReG1wRXN3?=
 =?utf-8?B?VGJJOTZxWEYyVHhGQVFqWUs5dGJDL0Ntb3hrSWtVV3hFZkdFL3lsUWJmeSt4?=
 =?utf-8?B?R0lLT0dWcHIyUFlJZWx6OW9iQmxFcExjMnlUMGQraDZGT1BSa3NZU0x6VHBp?=
 =?utf-8?B?S0NTMTM4Smw5cmYvUTFCNmoxZ3ZvS2lmOGdCT0dzeXdNWVJONnByc1hZK2kw?=
 =?utf-8?B?ejcvM2lsSHF1ZWVpZ21sUndQYzU2b3ZFQ0VmSTJwM0lZT0xFVGdmNzNiR29J?=
 =?utf-8?B?MXdEektEWGtldkRySmhiK0JvOFFyUUwwdSt0bXZyL3FHMTBTQmcyT0hzajBU?=
 =?utf-8?B?SW5nZStGMjNzUW51M3BKREVEQXlNSGpGb0FiT0EvNnJ4V0l3WXFsZktwWUFh?=
 =?utf-8?B?OUFBTGhHc1lSaEVNdlU5ODVVOHRKOE56RWhSaUZ4VTd4UThMeTBlWGxmQ2py?=
 =?utf-8?B?b3U1UVZ5aTVtbzN2ckFpNGx4MUpFWVA1NjBBLzQ4My84ekZvZ2MwTGMrbDU3?=
 =?utf-8?B?Sk5vTHFONFhXV2hKdWU0S2RBRnAxeUM0VkNURTVHSzNZMk9UTk4vVG5qRGZT?=
 =?utf-8?B?SXVKVmVqRDN3QUQvREloZGJBSGVLNWhiUUFTYURDbVJlakcrQ1pCSStHVm90?=
 =?utf-8?B?dXV2UEkyeUpoWHJNQjVkWmYyTWJwUmVLMnN3aGZJTFUvcWFtcEZiK0NYU210?=
 =?utf-8?B?UUxSMWZ1NmRteHQrYmZDOEtDU2MzUUhCczJyRk4veGVPenYvc05GdUUxUWZY?=
 =?utf-8?B?c1FVSy9pZVl4bUhmYy9IY0dLNU1TSnc4L0NOMHBkYjFqVkhOdHZtd1g4aWl6?=
 =?utf-8?B?bEo3NlJ1QmNjaTJ3bGliTUVLcFJTUHFxajFYQU56QzFiT0ZpNUlIdm5qS1Jz?=
 =?utf-8?B?QlBQT05ITUtyc1gySkhqOXRNaUVFVXpOdlpPQTlNSURWZ0drN2tnREdhTkRz?=
 =?utf-8?B?a1p5TnNqNmxFdW1UZUFZN2o2OUREbTFVWHZmODJkOVlVd0JYV3BFSUZaYXly?=
 =?utf-8?B?VisrZldzNWdrZWVOOXRBT3VpUFYrUHVZRS90OHJoNkxiekdFNVRKZGZhUjJM?=
 =?utf-8?B?RVpZWEpQdlNlRTIyRU9OeUdpL0huYVhUbldoTGZNZ0NrSVh5NHgxc21LTnhS?=
 =?utf-8?Q?4LlQ/FehEOdrBncFliRtOnL+BW7hNBCwqqgn6HZSNM=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b+GbjKrbSSIZlVw4mFjqmKbkh2SYEwcIyl2YL5NMkWte2KxRo9yKWPw2b44hTlDMN1DDma25gDoYpVxqYBJouF72+cyKU6WVGexNrEjS4NDAXhlrQs+C9P6BrNeLxsIalETXgPZepaQMWCk3lruAHKw8Iz1dRjRbk9d0nHE4mxKhAgSqXbgD3F1qy1KQ6sfCTLiQnheIMh0iFBZYw7TTKv3OVWaB3AWRAXgP8hvn5yD13zHJ+PDLApjFKvFRLLuriIQzzpbv6j1fkr/SfEpEKCNSjcrtTDA60dLtox6Pted0L4IT/ShVsg01Q/mey1I16m5agOZbVDyeecSEm0Kt9Ze0XBN50VKEdqGoO175g0734lWbmuULZYwBqLpsgUMgOB8bn9yp2orEZY+bqrAJAbLExlZysioZbV+sjkor4qccVJHexdrnttmK7QPkg3mW
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:35:49.9835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c276dc-e2a9-446b-a40d-08de6339e8a8
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6481-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: E0E3DDB58C
X-Rspamd-Action: no action

T24gMDMvMDIvMjAyNiAxNTowMSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+IEluLXRyZWUgcGh5LWNh
bi10cmFuc2NlaXZlciBkcml2ZXIgaGFzIGFscmVhZHkgaW1wbGVtZW50ZWQgYSBsb2NhbA0KPiB2
ZXJzaW9uIG9mIGRldm1fbXV4X3N0YXRlX2dldF9vcHRpb25hbC4NCj4NCj4gVGhlIG9tYXAtaTJj
IGRyaXZlciBnZXRzIGFuZCBzZWxlY3RzIGFuIG9wdGlvbmFsIG11eCBpbiBpdHMgcHJvYmUNCj4g
ZnVuY3Rpb24gd2l0aG91dCB1c2luZyBhbnkgaGVscGVyLg0KPg0KPiBBZGQgbmV3IGhlbHBlciBm
dW5jdGlvbnMgY292ZXJpbmcgYm90aCBhZm9yZW1lbnRpb25lZCB1c2UtY2FzZXM6DQo+DQo+IC0g
bXV4X2NvbnRyb2xfZ2V0X29wdGlvbmFsOg0KPiAgICBHZXQgYSBtdXgtY29udHJvbCBpZiBzcGVj
aWZpZWQgaW4gZHQsIHJldHVybiBOVUxMIG90aGVyd2lzZS4NCj4gLSBkZXZtX211eF9zdGF0ZV9n
ZXRfb3B0aW9uYWw6DQo+ICAgIEdldCBhIG11eC1zdGF0ZSBpZiBzcGVjaWZpZWQgaW4gZHQsIHJl
dHVybiBOVUxMIG90aGVyd2lzZS4NCj4gLSBkZXZtX211eF9zdGF0ZV9nZXRfc2VsZWN0ZWQ6DQo+
ICAgIEdldCBhbmQgc2VsZWN0IGEgbXV4LXN0YXRlIHNwZWNpZmllZCBpbiBkdCwgcmV0dXJuIGVy
cm9yIG90aGVyd2lzZS4NCj4gLSBkZXZtX211eF9zdGF0ZV9nZXRfb3B0aW9uYWxfc2VsZWN0ZWQ6
DQo+ICAgIEdldCBhbmQgc2VsZWN0IGEgbXV4LXN0YXRlIGlmIHNwZWNpZmllZCBpbiBkdCwgcmV0
dXJuIGVycm9yIG9yIE5VTEwuDQo+DQo+IEV4aXN0aW5nIG11eF9nZXQgaGVscGVyIGZ1bmN0aW9u
IGlzIGNoYW5nZWQgdG8gdGFrZSBhbiBleHRyYSBhcmd1bWVudA0KPiBpbmRpY2F0aW5nIHdoZXRo
ZXIgdGhlIG11eCBpcyBvcHRpb25hbC4NCj4gSW4gdGhpcyBjYXNlIG5vIGVycm9yIGlzIHByaW50
ZWQsIGFuZCBOVUxMIHJldHVybmVkIGluIGNhc2Ugb2YgRU5PRU5ULg0KPg0KPiBDYWxsaW5nIGNv
ZGUgaXMgYWRhcHRlZCB0byBoYW5kbGUgTlVMTCByZXR1cm4gY2FzZSwgYW5kIHRvIHBhc3Mgb3B0
aW9uYWwNCj4gYXJndW1lbnQgYXMgcmVxdWlyZWQuDQo+DQo+IFRvIHN1cHBvcnQgYXV0b21hdGlj
IGRlc2VsZWN0IGZvciBfc2VsZWN0ZWQgaGVscGVyLCBhIG5ldyBzdHJ1Y3R1cmUgaXMNCj4gY3Jl
YXRlZCBzdG9yaW5nIGFuIGV4aXQgcG9pbnRlciBzaW1pbGFyIHRvIGNsb2NrIGNvcmUgd2hpY2gg
aXMgY2FsbGVkIG9uDQo+IHJlbGVhc2UuDQo+DQo+IFRvIGZhY2lsaXRhdGUgY29kZSBzaGFyaW5n
IGJldHdlZW4gb3B0aW9uYWwvbWFuZGF0b3J5L3NlbGVjdGVkIGhlbHBlcnMsDQo+IGEgbmV3IGlu
dGVybmFsIGhlbHBlciBmdW5jdGlvbiBpcyBhZGRlZCB0byBoYW5kbGUgcXVpZXQgKG9wdGlvbmFs
KSBhbmQNCj4gdmVyYm9zZSAobWFuZGF0b3J5KSBlcnJvcnMsIGFzIHdlbGwgYXMgc3RvcmluZyB0
aGUgY29ycmVjdCBjYWxsYmFjayBmb3INCj4gZGV2bSByZWxlYXNlOiBfX2Rldm1fbXV4X3N0YXRl
X2dldA0KPg0KPiBEdWUgdG8gdGhpcyBzdHJ1Y3R1cmUgZGV2bV9tdXhfc3RhdGVfZ2V0Xypfc2Vs
ZWN0ZWQgY2FuIG5vIGxvbmdlciBwcmludA0KPiBhIHVzZWZ1bCBlcnJvciBtZXNzYWdlIHdoZW4g
c2VsZWN0IGZhaWxzLiBJbnN0ZWFkIGNhbGxlcnMgc2hvdWxkIHByaW50DQo+IGVycm9ycyB3aGVy
ZSBuZWVkZWQuDQo+DQo+IENvbW1pdCBlMTUzZmRlYTlkYjA0ICgicGh5OiBjYW4tdHJhbnNjZWl2
ZXI6IFJlLWluc3RhdGUgIm11eC1zdGF0ZXMiDQo+IHByb3BlcnR5IHByZXNlbmNlIGNoZWNrIikg
bm90ZWQgdGhhdCAibXV4X2dldCgpIGFsd2F5cyBwcmludHMgYW4gZXJyb3INCj4gbWVzc2FnZSBp
biBjYXNlIG9mIGFuIGVycm9yLCBpbmNsdWRpbmcgd2hlbiB0aGUgcHJvcGVydHkgaXMgbm90IHBy
ZXNlbnQsDQo+IGNvbmZ1c2luZyB0aGUgdXNlci4iDQo+DQo+IFRoZSBmaXJzdCBlcnJvciBtZXNz
YWdlIGNvdmVycyB0aGUgY2FzZSB0aGF0IGEgbXV4IG5hbWUgaXMgbm90IG1hdGNoZWQNCj4gaW4g
ZHQuIFRoZSBzZWNvbmQgZXJyb3IgbWVzc2FnZSBpcyBiYXNlZCBvbiBvZl9wYXJzZV9waGFuZGxl
X3dpdGhfYXJncw0KPiByZXR1cm4gdmFsdWUuDQo+DQo+IEluIG9wdGlvbmFsIGNhc2Ugbm8gZXJy
b3IgaXMgcHJpbnRlZCBhbmQgTlVMTCBpcyByZXR1cm5lZC4NCj4gVGhpcyBlbnN1cmVzIHRoYXQg
dGhlIG5ldyBoZWxwZXIgZnVuY3Rpb25zIHdpbGwgbm90IGNvbmZ1c2UgdGhlIHVzZXINCj4gZWl0
aGVyLg0KPg0KPiBXaXRoIHRoZSBhZGRpdGlvbiBvZiBvcHRpb25hbCBoZWxwZXIgZnVuY3Rpb25z
IGl0IGJlY2FtZSBjbGVhciB0aGF0DQo+IGRyaXZlcnMgc2hvdWxkIGNvbXBpbGUgYW5kIGxpbmsg
ZXZlbiBpZiBDT05GSUdfTVVMVElQTEVYRVIgd2FzIG5vdCBlbmFibGVkLg0KPiBBZGQgc3R1YnMg
Zm9yIGFsbCBzeW1ib2xzIGV4cG9ydGVkIGJ5IG11eCBjb3JlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9t
dXgvY29yZS5jICAgICAgICAgICB8IDIwNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tDQo+ICAgaW5jbHVkZS9saW51eC9tdXgvY29uc3VtZXIuaCB8IDEwOCArKysr
KysrKysrKysrKysrKysrKysrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjc4IGluc2VydGlvbnMo
KyksIDM1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdXgvY29yZS5j
IGIvZHJpdmVycy9tdXgvY29yZS5jDQo+IGluZGV4IGEzODQwZmUwOTk1Zi4uMmU4Mjk1ZTNhYWJl
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL211eC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdXgv
Y29yZS5jDQo+IEBAIC00Niw2ICs0NiwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsYXNzIG11
eF9jbGFzcyA9IHsNCj4gICAJLm5hbWUgPSAibXV4IiwNCj4gICB9Ow0KPiAgIA0KPiArLyoqDQo+
ICsgKiBzdHJ1Y3QgZGV2bV9tdXhfc3RhdGVfc3RhdGUgLQlUcmFja3MgbWFuYWdlZCByZXNvdXJj
ZXMgZm9yIG11eC1zdGF0ZSBvYmplY3RzLg0KPiArICogQG1zdGF0ZToJCQkJUG9pbnRlciB0byBh
IG11eCBzdGF0ZS4NCj4gKyAqIEBleGl0OgkJCQlBbiBvcHRpb25hbCBjYWxsYmFjayB0byBleGVj
dXRlIGJlZm9yZSBmcmVlLg0KPiArICovDQo+ICtzdHJ1Y3QgZGV2bV9tdXhfc3RhdGVfc3RhdGUg
ew0KPiArCXN0cnVjdCBtdXhfc3RhdGUgKm1zdGF0ZTsNCj4gKwlpbnQgKCpleGl0KShzdHJ1Y3Qg
bXV4X3N0YXRlICptc3RhdGUpOw0KPiArfTsNCj4gKw0KPiAgIHN0YXRpYyBERUZJTkVfSURBKG11
eF9pZGEpOw0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgX19pbml0IG11eF9pbml0KHZvaWQpDQo+IEBA
IC01MTYsMTcgKzUyNiwxOSBAQCBzdGF0aWMgc3RydWN0IG11eF9jaGlwICpvZl9maW5kX211eF9j
aGlwX2J5X25vZGUoc3RydWN0IGRldmljZV9ub2RlICpucCkNCj4gICAJcmV0dXJuIGRldiA/IHRv
X211eF9jaGlwKGRldikgOiBOVUxMOw0KPiAgIH0NCj4gICANCj4gLS8qDQo+ICsvKioNCj4gICAg
KiBtdXhfZ2V0KCkgLSBHZXQgdGhlIG11eC1jb250cm9sIGZvciBhIGRldmljZS4NCj4gICAgKiBA
ZGV2OiBUaGUgZGV2aWNlIHRoYXQgbmVlZHMgYSBtdXgtY29udHJvbC4NCj4gICAgKiBAbXV4X25h
bWU6IFRoZSBuYW1lIGlkZW50aWZ5aW5nIHRoZSBtdXgtY29udHJvbC4NCj4gICAgKiBAc3RhdGU6
IFBvaW50ZXIgdG8gd2hlcmUgdGhlIHJlcXVlc3RlZCBzdGF0ZSBpcyByZXR1cm5lZCwgb3IgTlVM
TCB3aGVuDQo+ICAgICogICAgICAgICB0aGUgcmVxdWlyZWQgbXVsdGlwbGV4ZXIgc3RhdGVzIGFy
ZSBoYW5kbGVkIGJ5IG90aGVyIG1lYW5zLg0KPiArICogQG9wdGlvbmFsOiBXaGV0aGVyIHRvIHJl
dHVybiBOVUxMIGFuZCBzaWxlbmNlIGVycm9ycyB3aGVuIG11eCBkb2Vzbid0IGV4aXN0Lg0KPiAg
ICAqDQo+IC0gKiBSZXR1cm46IEEgcG9pbnRlciB0byB0aGUgbXV4LWNvbnRyb2wsIG9yIGFuIEVS
Ul9QVFIgd2l0aCBhIG5lZ2F0aXZlIGVycm5vLg0KPiArICogUmV0dXJuOiBQb2ludGVyIHRvIHRo
ZSBtdXgtY29udHJvbCBvbiBzdWNjZXNzLCBhbiBFUlJfUFRSIHdpdGggYSBuZWdhdGl2ZSBlcnJu
byBvbiBlcnJvciwNCj4gKyAqIG9yIE5VTEwgaWYgb3B0aW9uYWwgaXMgdHJ1ZSBhbmQgbXV4IGRv
ZXNuJ3QgZXhpc3QuDQo+ICAgICovDQo+ICAgc3RhdGljIHN0cnVjdCBtdXhfY29udHJvbCAqbXV4
X2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm11eF9uYW1lLA0KPiAtCQkJCSAg
IHVuc2lnbmVkIGludCAqc3RhdGUpDQo+ICsJCQkJICAgdW5zaWduZWQgaW50ICpzdGF0ZSwgYm9v
bCBvcHRpb25hbCkNCj4gICB7DQo+ICAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9m
X25vZGU7DQo+ICAgCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsNCj4gQEAgLTU0Miw3ICs1
NTQsOSBAQCBzdGF0aWMgc3RydWN0IG11eF9jb250cm9sICptdXhfZ2V0KHN0cnVjdCBkZXZpY2Ug
KmRldiwgY29uc3QgY2hhciAqbXV4X25hbWUsDQo+ICAgCQllbHNlDQo+ICAgCQkJaW5kZXggPSBv
Zl9wcm9wZXJ0eV9tYXRjaF9zdHJpbmcobnAsICJtdXgtY29udHJvbC1uYW1lcyIsDQo+ICAgCQkJ
CQkJCSBtdXhfbmFtZSk7DQo+IC0JCWlmIChpbmRleCA8IDApIHsNCj4gKwkJaWYgKGluZGV4IDwg
MCAmJiBvcHRpb25hbCkgew0KPiArCQkJcmV0dXJuIE5VTEw7DQo+ICsJCX0gZWxzZSBpZiAoaW5k
ZXggPCAwKSB7DQo+ICAgCQkJZGV2X2VycihkZXYsICJtdXggY29udHJvbGxlciAnJXMnIG5vdCBm
b3VuZFxuIiwNCj4gICAJCQkJbXV4X25hbWUpOw0KPiAgIAkJCXJldHVybiBFUlJfUFRSKGluZGV4
KTsNCj4gQEAgLTU1OCw4ICs1NzIsMTIgQEAgc3RhdGljIHN0cnVjdCBtdXhfY29udHJvbCAqbXV4
X2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm11eF9uYW1lLA0KPiAgIAkJCQkJ
CSAibXV4LWNvbnRyb2xzIiwgIiNtdXgtY29udHJvbC1jZWxscyIsDQo+ICAgCQkJCQkJIGluZGV4
LCAmYXJncyk7DQo+ICAgCWlmIChyZXQpIHsNCj4gKwkJaWYgKG9wdGlvbmFsICYmIHJldCA9PSAt
RU5PRU5UKQ0KPiArCQkJcmV0dXJuIE5VTEw7DQo+ICsNCj4gICAJCWRldl9lcnIoZGV2LCAiJXBP
RjogZmFpbGVkIHRvIGdldCBtdXgtJXMgJXMoJWkpXG4iLA0KPiAtCQkJbnAsIHN0YXRlID8gInN0
YXRlIiA6ICJjb250cm9sIiwgbXV4X25hbWUgPzogIiIsIGluZGV4KTsNCj4gKwkJCW5wLCBzdGF0
ZSA/ICJzdGF0ZSIgOiAiY29udHJvbCIsDQo+ICsJCQltdXhfbmFtZSA/OiAiIiwgaW5kZXgpOw0K
PiAgIAkJcmV0dXJuIEVSUl9QVFIocmV0KTsNCj4gICAJfQ0KPiAgIA0KPiBAQCAtNjE3LDEwICs2
MzUsMjggQEAgc3RhdGljIHN0cnVjdCBtdXhfY29udHJvbCAqbXV4X2dldChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGNvbnN0IGNoYXIgKm11eF9uYW1lLA0KPiAgICAqLw0KPiAgIHN0cnVjdCBtdXhfY29u
dHJvbCAqbXV4X2NvbnRyb2xfZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqbXV4
X25hbWUpDQo+ICAgew0KPiAtCXJldHVybiBtdXhfZ2V0KGRldiwgbXV4X25hbWUsIE5VTEwpOw0K
PiArCXN0cnVjdCBtdXhfY29udHJvbCAqbXV4ID0gbXV4X2dldChkZXYsIG11eF9uYW1lLCBOVUxM
LCBmYWxzZSk7DQo+ICsNCj4gKwlpZiAoIW11eCkNCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT0VO
VCk7DQo+ICsNCj4gKwlyZXR1cm4gbXV4Ow0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTCht
dXhfY29udHJvbF9nZXQpOw0KPiAgIA0KPiArLyoqDQo+ICsgKiBtdXhfY29udHJvbF9nZXRfb3B0
aW9uYWwoKSAtIEdldCB0aGUgb3B0aW9uYWwgbXV4LWNvbnRyb2wgZm9yIGEgZGV2aWNlLg0KPiAr
ICogQGRldjogVGhlIGRldmljZSB0aGF0IG5lZWRzIGEgbXV4LWNvbnRyb2wuDQo+ICsgKiBAbXV4
X25hbWU6IFRoZSBuYW1lIGlkZW50aWZ5aW5nIHRoZSBtdXgtY29udHJvbC4NCj4gKyAqDQo+ICsg
KiBSZXR1cm46IEEgcG9pbnRlciB0byB0aGUgbXV4LWNvbnRyb2wsIGFuIEVSUl9QVFIgd2l0aCBh
IG5lZ2F0aXZlIGVycm5vLg0KIMKgKiBSZXR1cm46IFBvaW50ZXIgdG8gdGhlIG11eC1zdGF0ZSBv
biBzdWNjZXNzLCBhbiBFUlJfUFRSIHdpdGggYSANCm5lZ2F0aXZlIGVycm5vIG9uIGVycm9yLA0K
IMKgKiBvciBOVUxMIGlmIG11eCBkb2Vzbid0IGV4aXN0Lg0KDQpJZiB0aGVyZSB3aWxsIGJlIHY5
LCBJIHNoYWxsIGNoYW5nZSB0aGlzIHRvIGJlIG1vcmUgcHJlY2lzZSBzaW1pbGFyIHRvIA0Kb3Ro
ZXIgZnVuY3Rpb25zLg0KPiArICovDQo+ICtzdHJ1Y3QgbXV4X2NvbnRyb2wgKm11eF9jb250cm9s
X2dldF9vcHRpb25hbChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm11eF9uYW1lKQ0K
PiArew0KPiArCXJldHVybiBtdXhfZ2V0KGRldiwgbXV4X25hbWUsIE5VTEwsIHRydWUpOw0KPiAr
fQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwobXV4X2NvbnRyb2xfZ2V0X29wdGlvbmFsKTsNCj4gKw0K
PiAgIC8qKg0KPiAgICAqIG11eF9jb250cm9sX3B1dCgpIC0gUHV0IGF3YXkgdGhlIG11eC1jb250
cm9sIGZvciBnb29kLg0KPiAgICAqIEBtdXg6IFRoZSBtdXgtY29udHJvbCB0byBwdXQgYXdheS4N
Cj4gQEAgLTY1NywxMCArNjkzLDEzIEBAIHN0cnVjdCBtdXhfY29udHJvbCAqZGV2bV9tdXhfY29u
dHJvbF9nZXQoc3RydWN0IGRldmljZSAqZGV2LA0KPiAgIAlpZiAoIXB0cikNCj4gICAJCXJldHVy
biBFUlJfUFRSKC1FTk9NRU0pOw0KPiAgIA0KPiAtCW11eCA9IG11eF9jb250cm9sX2dldChkZXYs
IG11eF9uYW1lKTsNCj4gKwltdXggPSBtdXhfZ2V0KGRldiwgbXV4X25hbWUsIE5VTEwsIGZhbHNl
KTsNCj4gICAJaWYgKElTX0VSUihtdXgpKSB7DQo+ICAgCQlkZXZyZXNfZnJlZShwdHIpOw0KPiAg
IAkJcmV0dXJuIG11eDsNCj4gKwl9IGVsc2UgaWYgKCFtdXgpIHsNCj4gKwkJZGV2cmVzX2ZyZWUo
cHRyKTsNCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7DQo+ICAgCX0NCj4gICANCj4gICAJ
KnB0ciA9IG11eDsNCj4gQEAgLTY3MCwxNCArNzA5LDE2IEBAIHN0cnVjdCBtdXhfY29udHJvbCAq
ZGV2bV9tdXhfY29udHJvbF9nZXQoc3RydWN0IGRldmljZSAqZGV2LA0KPiAgIH0NCj4gICBFWFBP
UlRfU1lNQk9MX0dQTChkZXZtX211eF9jb250cm9sX2dldCk7DQo+ICAgDQo+IC0vKg0KPiArLyoq
DQo+ICAgICogbXV4X3N0YXRlX2dldCgpIC0gR2V0IHRoZSBtdXgtc3RhdGUgZm9yIGEgZGV2aWNl
Lg0KPiAgICAqIEBkZXY6IFRoZSBkZXZpY2UgdGhhdCBuZWVkcyBhIG11eC1zdGF0ZS4NCj4gICAg
KiBAbXV4X25hbWU6IFRoZSBuYW1lIGlkZW50aWZ5aW5nIHRoZSBtdXgtc3RhdGUuDQo+ICsgKiBA
b3B0aW9uYWw6IFdoZXRoZXIgdG8gcmV0dXJuIE5VTEwgYW5kIHNpbGVuY2UgZXJyb3JzIHdoZW4g
bXV4IGRvZXNuJ3QgZXhpc3QuDQo+ICAgICoNCj4gLSAqIFJldHVybjogQSBwb2ludGVyIHRvIHRo
ZSBtdXgtc3RhdGUsIG9yIGFuIEVSUl9QVFIgd2l0aCBhIG5lZ2F0aXZlIGVycm5vLg0KPiArICog
UmV0dXJuOiBQb2ludGVyIHRvIHRoZSBtdXgtc3RhdGUgb24gc3VjY2VzcywgYW4gRVJSX1BUUiB3
aXRoIGEgbmVnYXRpdmUgZXJybm8gb24gZXJyb3IsDQo+ICsgKiBvciBOVUxMIGlmIG9wdGlvbmFs
IGlzIHRydWUgYW5kIG11eCBkb2Vzbid0IGV4aXN0Lg0KPiAgICAqLw0KPiAtc3RhdGljIHN0cnVj
dCBtdXhfc3RhdGUgKm11eF9zdGF0ZV9nZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFy
ICptdXhfbmFtZSkNCj4gK3N0YXRpYyBzdHJ1Y3QgbXV4X3N0YXRlICptdXhfc3RhdGVfZ2V0KHN0
cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqbXV4X25hbWUsIGJvb2wgb3B0aW9uYWwpDQo+
ICAgew0KPiAgIAlzdHJ1Y3QgbXV4X3N0YXRlICptc3RhdGU7DQo+ICAgDQouLi4NCg==


