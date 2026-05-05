Return-Path: <linux-can+bounces-7483-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pf1Dye3+WmNBAMAu9opvQ
	(envelope-from <linux-can+bounces-7483-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:23:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 956454C98D9
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0641A303CFBE
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9B30E82C;
	Tue,  5 May 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="gBhczW0y";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="gBhczW0y"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020131.outbound.protection.outlook.com [52.101.69.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C4308F36;
	Tue,  5 May 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.131
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972754; cv=fail; b=n2g2r0PAMl+Zd4I8VxNODvtH3paLvJgUKTkIHKnAHaFOLLE+iAhk/KhmhprPAMY+BweTqjtpZ7tFrtbsbZbOrw7vjK9GFbDPJnezGSW9YTUp5SeLSgYZLOpe4wrv+Wu/iBoTHt+kWnz7mrzws/wXcyeHYWWNn+AZnHWxCP0ty70=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972754; c=relaxed/simple;
	bh=x8i4nk7fnGMWhznqlB/9npOU5Hy8+f4LoViuxxVAODs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oyk9MnsjDpOsocvZWuKXjV13qBhRM6HA7LvWoL1nE6Vnj1cBs0JFD5fFbNnMrDYd4lojem2T3VrcNi7ab2oAPUpzEGhO4lHUsfMtYpk8+xIYSEvGsZOZBkEm1EP6U3ZuxV2oZpvL1haW9plJQz1aB5sqN+Toc+u4uZvICBydv00=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=gBhczW0y; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=gBhczW0y; arc=fail smtp.client-ip=52.101.69.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=feJoX3T6xth9fa5AB0Z8BqlTT6tBdcYB51G78lxCrmIqglaWE0vorA9Wf4z/PWARPc1w6BopNoi5JPcx7q7ASjXj3oMUlNRKtGewqPJ0maRdWc65fO1tLVbOiYBsEW9Dny9NGBYcwhMHsxV7uyS1SGEhZb03L7KACyWs+tmgztmo8CasWWVY2qspxDwtPQMK1j3VEdptYVKC5cxPKCWcR/EWyVQnnyn/Lt4HOobotnPoJVb12y+4pnsRwoXebBG2OflCkC6E38aV9vFUJRwPwiUqnEG7Ozjewmj9fAgLTBis0L/13j0DtNEDjtCzVbtDJwPvoCoD22N8UvT/eKiZZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8i4nk7fnGMWhznqlB/9npOU5Hy8+f4LoViuxxVAODs=;
 b=t/q3XrPZa7y3QqkduDGju+0pbZiBhWJtomst0qHaAneEvpSLdHS0cuY5buouA2cCJTmKuwwOOjikEkDklRmfObVXwIMcZ8ZbnOwKbYw8Qs2iFNk+tWHlnu0BZlbBRd90N4CHKyY0Do1gH9ZYJ6J/zqkGdhMo1zeuTdNkP00KwZ0HnTkgEbgVsU0UQSYn9zS8NsyoUT0cCfzVJCVygwKbhJ61znhatQK0UQFUgZwtk2f+YISbRxNBjjvBWKdOhsP5ZO1gWHCjECLFC0mcXNqhJV5jaWsHRBd5C7YzHOImLFSzs4utOgi2H1rq3fRShyy5VM5hb+EhoofoypLjAUzNRg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8i4nk7fnGMWhznqlB/9npOU5Hy8+f4LoViuxxVAODs=;
 b=gBhczW0yutrgBsW4K+S+jiCHGDZqYOem0ph/vFTfQxjMNuYixYQ600ME7Re7Vec9LgEtn/a0JurTUfwhrgP9IaNGy8fQ6K40n3EPFlJgphrvzyFUTZZJ/B55Z2AQABK+OxZwnxQyDz14clLXmXTmo+1HfsCzZ6XeaVIZaTlagvshA02VEgQ8ar4xngaIU6LEGHmLrXvxiUbLv71iNp88c/yKjFqPjqs7mCZQrCPro5+u7qiAIXSi0W/6j7XT42QaA33+2hMfaUvij9Qh8y/sCwk7DcI1X0zMmYNDUeeRSVHmFDn2TdF7YRPePo6q8ZYxrTZffHRlF2hHlwRXrb9B8Q==
Received: from DUZPR01CA0252.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::22) by VI0PR04MB11614.eurprd04.prod.outlook.com
 (2603:10a6:800:300::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:19:09 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::9c) by DUZPR01CA0252.outlook.office365.com
 (2603:10a6:10:4b5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 09:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Tue, 5 May 2026 09:19:09 +0000
Received: from emails-6496621-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-105.eu-west-1.compute.internal [10.20.6.105])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E24B8803C3;
	Tue,  5 May 2026 09:19:08 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Tue May  5 09:18:33 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+Qf0kYx/vGbV5rqEsyXWeeo506kdk9v6sSBVe5aQ+n3duBc+EUEEAywuDczY5/wQvEEE22L4daRob59v3G9gT1axT+JzpqBEgOKPR2OdW/apv+Upu+07Px+PeGCRtkj3lI4DSHfGwBlypJ0ZgY9FSkj6uRg4b+eityyhW7bQ14OeAGgwKRjnRzfp5qH62wK/2QMPVHf2DktbebsdLORoQfOgyE8//qgNGYbCRJPv6aaPiH/8uDXe7rA26+Age/jmnYOZFramlxNBdl0pXbThZP7mym5rDeZi5vPLLGCEp18KNyCX1ugnYPwe2e+wo/G/0ckwEVdNl73inljwOBTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8i4nk7fnGMWhznqlB/9npOU5Hy8+f4LoViuxxVAODs=;
 b=YJ2qncoL2PGN/3+byrjMsWag7TaJ4L5XmqoMh89uEGF2jiKgs18XAnO5K20gWPtJ0bGBxSGmN2VFDt1o5LG/EIYm82qNZOnJOnN2tnuktDiGxw87VcdmB2GGsICHlMa2Wt0PZVdRHemSFaBq8HheEXdw0Bg6TTLgFlgqqSDMOjzYRmZaAbBSm5vfHbYMNfva2O1CIUEq3bKEDjOs2ZDBeiGEbWFKzWvHeCnCgPjfZsulW/uUiyAOqpsQEukppGE/wkU1WyemTgoeB58s56uikchM5sc838pPuCkgQTtWU4Tebr2S/IwHMHFRp/6HfxXRx5ysHQv8+CO067WaFcSVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8i4nk7fnGMWhznqlB/9npOU5Hy8+f4LoViuxxVAODs=;
 b=gBhczW0yutrgBsW4K+S+jiCHGDZqYOem0ph/vFTfQxjMNuYixYQ600ME7Re7Vec9LgEtn/a0JurTUfwhrgP9IaNGy8fQ6K40n3EPFlJgphrvzyFUTZZJ/B55Z2AQABK+OxZwnxQyDz14clLXmXTmo+1HfsCzZ6XeaVIZaTlagvshA02VEgQ8ar4xngaIU6LEGHmLrXvxiUbLv71iNp88c/yKjFqPjqs7mCZQrCPro5+u7qiAIXSi0W/6j7XT42QaA33+2hMfaUvij9Qh8y/sCwk7DcI1X0zMmYNDUeeRSVHmFDn2TdF7YRPePo6q8ZYxrTZffHRlF2hHlwRXrb9B8Q==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by VI0PR04MB11614.eurprd04.prod.outlook.com
 (2603:10a6:800:300::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:18:31 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:18:31 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Thread-Topic: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Thread-Index:
 AQHctkzt2/uGtBr9E0uHhoJ+wJjgi7XfEH0AgBPvoQCAAChpAIAAAgmAgAAdRoCACnJqgIABuWwA
Date: Tue, 5 May 2026 09:18:30 +0000
Message-ID: <3b11269f-fb3d-4973-8dd5-79255581ad12@solid-run.com>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
 <7bcb68c4-e4bd-4ad9-bb75-99e0845b204c@solid-run.com>
 <ae9l4n8wocbVegcJ@ashevche-desk.local>
 <5d4c3c95-cbe1-4439-8036-b014264ce8c2@solid-run.com>
 <ae-AJdSrnXiuc1mW@ashevche-desk.local> <afhDm5_ydU83xFKU@ashevche-desk.local>
In-Reply-To: <afhDm5_ydU83xFKU@ashevche-desk.local>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|VI0PR04MB11614:EE_|DB5PEPF00014B98:EE_|VI0PR04MB11614:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2c76d3-1e0d-4c45-0b9b-08deaa875d08
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 uhcmNEsfgE0i3Sf0hTThY46+r1htmFnhNK6ORA1ZOvUzXmN5WVr3gLNL8YXlNpqpPENz38pohnQ/CafufKZR3gtPfCmZVcAOULSUFjVgSBU0RnEYXdrzQsuCN/DjKfyMOsekhZmByFJafcmrGs0IXxI3dSNnqXcA60yvGLXyXjbnx/JYix+S1DTeZBSC1bHLDvbzyuCKd8LCITONG6hQkwRVYCN9DF6SFN5FwQnvtadtwjgW4wLl1o0XIvbnICpaCbwG/tRV8Xg7JZ5S56HMGsdRZBC86K9zbSLe1DoZWTK7wB3P69Hqrjk6h2BM3CiyHQLjNI6iac5xxNvvBk0RxJdThx+l51JeyslOvYt45KTv3xLe5N+nk0QFzsBPB5bFQE0sVlvPFomrL88hWu13o6tpmMarVrXz6Dz6M4a8RhCBgs2ZvXHtacYq/URm+yYisbYRr0zeDXJIb+WFpQcQAscTLBL2of8/JNy3pZA9+ivINPlg+yp2pnWhBR16JoCFGgvtyR9M70vdOkn6gIGu4Sq8ceYUEkoo4nlGfU5w43jiVkX1idXhrRiKUm/QBm23vsvNRMYpiO9eUyMxcT0RGf2VQyaUiqcapOCZOyoQGVL5JM44iGx4MxQ/WaSDoWixaOyvzM9PU/+0VBXtOsX/A9OdyDRFzgaIF8ckMYIRQUObOlaaHplyMG+arRId9kVGnlTcpgncO9JhI4rLvFyg+P0AoAmDMlT8GpLQX4VQIt3cGPKhAJHimat+CArK3odk
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <92F1CC0BE0358649A76D2667A4E7A195@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 AxDW3d1E4e4x7Cf5EiFda5NmNnhqBrZ+TysaCzahKcZzWPd4ChkAH01GU9cYvlh5gsZMqHK7SM9D8CvK/b35bJNFQIJBpNU5Q1ysBSUtdDSvhj2xH3+rINw4D7CZh4kpeMSmFuUflNAzOM4VVPtRof3mjcpigb/7LoOMuAHSItczNjBT+iHxExmUYl5d+db7AXGcGWhJW4LZ5liGkmVBB+ubykx/MTZOFsKmDQSEjjYtAtwADRacqiyPROFgUiizL7tEsYD8jLaFtA3ZSBJ2xt/BrepzCeiaXePAeWjs8xJr+VaKer/rkG54+PTiAgf9q8KwTV8j1ECWgjCrvTidXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11614
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 8290ba194f964b13bfe6b3dcd11f50bd:solidrun,office365_emails,sent,inline:e5f4c0cce52b3aa936fab29a235a2a66
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e2f5d28e-b2a7-4e35-aad1-08deaa874640
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|376014|1800799024|36860700016|35042699022|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iZQy/Rzq4AZpOlfqAC/MVqRLCDaVYE7XARbOWDH7LEXARJMhba2VL1ZHWoOjucSU+hiWVtwFz95ztiT/1vtIv/dzv4JeF29LlmZzofyE9efk0eTX0deUAFcHODiutPRNQP+Xoyz8D95pM3PGFMElMjc0FdKIYicnv86FdQhb6ofJRQvLeiqDalsMEETxzajbQwpZ7ROfz48oHIMQNjtX7GyvjAiZ+zzz60B5Rl/3p5dxy5u1xpnnHvWyhhI/iHx9KhmX2PeZQVSnkvVWLafsFfMdKtsCFng1qRQHB05ymh1Es3j9yEJ1AmvA2+Ty7JkbeyQNIWvDRJMNiptFI3mTSg032ZRdXbSp1M+NimoxaOg+v49xroKPWEZJ91CM6OnQ+1E8Ez8dOngqQmVa6T9EK8EbeoC0/xVvner5wlTrwS4eXY0c83LTrWxhNl+OVkhZwiq4KZj5N9ZPumvpdUcBmaoiVrbEChLXEygAAaLU6BVN6zCth6OuTzipGXSYVK1eDbJD2QFSUbH5yXdvoVf/tr/Js9AwIzvq50Yra3WooXKbs2xK2PkO6iBrO1pz9VTtz5JquJerFWeHezy3kZW0JDN+8UWb3Q6PML9ExfdwAbmO0pgDPo59jDdXjifdtJN8wksJne0WLCCcFwL3hcZcJzKN/Zl+JIyfSpNx7HDXC7ihFfUE1ApuXwlWZQT/66hPSw5Wh8tGAWLkCCZJzY6AKJU8LW6UMbHeXygRntHFatA=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(376014)(1800799024)(36860700016)(35042699022)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	39xvUlUCL60RkNewG1obVKo9Fe8ocSd/3Z2D28asYzqxKnuZ5JnvyiUvcTwOWnDGysmJgjt03sruBJ2vN88j4PQIGP2w8ipzEFHXB4CcFXSp07O6OV7UIhLAIJzOwMnqJt+Wrvmo2hL/hj1YrGH6Sy4dLi2vufF+T5clc/tHKg1VUAilgKp9Gb7lszI7bV6ypuAV+K2UUKNR0PznxKbgUMjYyUNapF/B6oMRI4JURajC7jBdscyyPc0ajzHFPK5yOHV/alCXUd4kQNWmtyz70JmKoEK780bbu7PvSp2szUBZYg1X6+vZ12C77lf49GZ8SICtwtpz0GgPxvIhJaiS83HHSMT5och8hBaahUv+AAPzta1FUEUqFLMSVMa62JenxVwsCD/kwa48QpLl6be5+vnJAhv4PblNtqR3g5LYkA3Ku0KrkSNMPYLzHuhhkxIH
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:19:09.0725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2c76d3-1e0d-4c45-0b9b-08deaa875d08
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11614
X-Rspamd-Queue-Id: 956454C98D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7483-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[solid-run.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

QW0gMDQuMDUuMjYgdW0gMDg6NTggc2NocmllYiBBbmR5IFNoZXZjaGVua286DQo+IE9uIE1vbiwg
QXByIDI3LCAyMDI2IGF0IDA2OjI2OjM0UE0gKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToN
Cj4+IE9uIE1vbiwgQXByIDI3LCAyMDI2IGF0IDAxOjQxOjQzUE0gKzAwMDAsIEpvc3VhIE1heWVy
IHdyb3RlOg0KPj4+IEFtIDI3LjA0LjI2IHVtIDE1OjM0IHNjaHJpZWIgQW5keSBTaGV2Y2hlbmtv
Og0KPj4+PiBPbiBNb24sIEFwciAyNywgMjAyNiBhdCAxMTowOTo0OEFNICswMDAwLCBKb3N1YSBN
YXllciB3cm90ZToNCj4+Pj4+IEFtIDE0LjA0LjI2IHVtIDIwOjQzIHNjaHJpZWIgQW5keSBTaGV2
Y2hlbmtvOg0KPj4+Pj4+IE9uIFR1ZSwgTWFyIDE3LCAyMDI2IGF0IDA5OjI3OjI2UE0gKzAxMDAs
IEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gLi4uDQo+DQo+Pj4+PiBGb3IgdW5rbm93biByZWFz
b24geW91ciBwYXRjaC1zZXQgZGlkIG5vdCBhcnJpdmUgaW4gbXkgaW5ib3guDQo+Pj4+PiBQZXJo
YXBzIGl0IHdlbnQgbWlzc2luZyBmb3Igb3RoZXJzLCB0b28/DQo+Pj4+IEFyZSB5b3UgaW4gdGhl
IE1BSU5UQUlORVJTIGZvciB0aGlzIHBhcnQgb2YgdGhlIGtlcm5lbD8NCj4+Pj4gVGhlIENBTiBO
RVRXT1JLIERSSVZFUlMgYW5kIEdFTkVSSUMgUEhZIEZSQU1FV09SSyBkbyBub3QgbGlzdCB5b3Vy
IG5hbWUuDQo+Pj4gQ29ycmVjdC4gSSB0b3VjaGVkIGNhbiBwaHkgb25jZSByZWxhdGVkIHRvIG11
eCBvbmx5Lg0KPj4+PiBJZiB5b3UgdGhpbmsgb2YgbWFpbCBkZWxpdmVyeSBpbiBnZW5lcmFsLCBp
dCdzIGRlbGl2ZXJlZCBhdCBsZWFzdCB0byB0aGUgTUwNCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjYwMzE3MjAzMDAxLjIxMDg1NjgtMS1hbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20vDQo+Pj4+DQo+Pj4+IFRCSCBJIGRvbid0IGtub3cgd2hhdCB0byBhbnN3ZXIg
dG8geW91ciBxdWVzdGlvbiBhcyBJIGRvbid0IGtub3cgeW91ciBleHBlY3RhdGlvbnMgYW5kDQo+
Pj4+IGhvdyBpdCBzaG91bGQgYmUgZnVsZmlsbGVkIHRha2luZyBpbnRvIGFjY291bnQgbXkgYWJv
dmUgcXVlc3Rpb24uLi4NCj4+PiBDaGFuZ2Vsb2cgdjI6DQo+Pj4gLSBDYydlZCB0byBVbGYgYW5k
IEpvc3VhIGR1ZSB0byBhYm92ZQ0KPj4+DQo+Pj4gVGhpcyBpcyB3aHkgSSBleHBlY3RlZCBpdCBp
biBteSBpbmJveC4NCj4+PiBVc3VhbGx5IGluIHRoaXMgc2l0dWF0aW9uIEkgYmxhbWUgbXkgcHJv
dmlkZXIuDQo+PiBBaCwgYmxhbWUgbWUgdGhlbi4gSSBtb3N0IGxpa2VseSBtaXNzZWQgdG8gYWRk
IHlvdXIgbmFtZSB0byB0aGUgQ2MgbGlzdC4NCj4gSG1tLi4uIEkgaGF2ZSBjaGVja2VkIGFuZCB5
b3VyIGFkZHJlc3MgaXMgaW4gdGhlIENjIGZvciB0aGUgd2hvbGUgc2VyaWVzLA0KPiBzbyBJIHdp
dGhkcmF3IHRoYXQgSSBhZG1pdCBlYXJsaWVyIHRoYXQgcHJvYmxlbSBpcyBvbiBteSBzaWRlLiBQ
bGVhc2UsIGNoZWNrDQo+IGlmIGV2ZXJ5dGhpbmcgZmluZSBvbiB5b3Vycy4gTm90ZSwgSSdtIGFi
b3V0IHRvIHNlbmQgYSB2My4NClJlY2VpdmVkIHYzLCB0aGFua3MhDQo+DQo+Pj4+IEJ1dCB0aGFu
a3MgZm9yIHRoZSByZXZpZXdpbmchIEkgd2lsbCBhZGRyZXNzIHRoZSBjb21taXQgbWVzc2FnZSBp
biB2My4NCj4+PiBHcmVhdCENCj4+IEFuZCB3aWxsIHRyeSBoYXJkIHRvIG1ha2Ugc3VyZSB5b3Vy
IGFkZHJlc3Mgd2lsbCBiZSBpbiB0aGUgQ2MgbGlzdC4=

