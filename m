Return-Path: <linux-can+bounces-6624-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QETdKonenml9XgQAu9opvQ
	(envelope-from <linux-can+bounces-6624-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:35:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CD196910
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E0AA3037051
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C3395DB4;
	Wed, 25 Feb 2026 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TuSNjOzt";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TuSNjOzt"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023120.outbound.protection.outlook.com [40.107.159.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D3395249;
	Wed, 25 Feb 2026 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.120
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019299; cv=fail; b=ZdOCnKCkBuqLIMRzODlZYzgsqH98dHReVyqI/kGMcvYXhal3qmSl5NDLABUqJ6BJnbUKWt5JZ2jf6M3u2b0T0bezyr280n2lGSmo6zOVcHEBZY7ak414FCVgFlYKCPTv1hrxwv6KzXnVCT7vkdhDvSm2ote0CqjFBswT//Xo+9w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019299; c=relaxed/simple;
	bh=MaXGRVFV5D4+x651nqdtVkDjvYCRYwsLmnrZ6kDPYiM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ae2uCWkUcd5+S9TiNOgb7Qa90gB01oz0AMmG4Dc0sxOoDk9pCPDnRAxyi3RoIVxq7ZSEzD9SDzmnj4kmwouJ1X3svImB7AACdYiad++8gxn65/Eh2Ihg5WEjBnigIyCG4pmbO90i/pOyIb1cEZ604QKso1O9ssldvOldcxW213s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TuSNjOzt; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TuSNjOzt; arc=fail smtp.client-ip=40.107.159.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FXKTyQp19AW5rm+pXour04se3aEQAkekj0c55ytqEj3Z2uiEramTLhreiACixKXN5UIi8vWOgH5keTvcs818YWC8RfrQb+GL3tDvAQhjSq4ss++rhbY3XQj75lK4GnWzrh4vCCkK23atn2aIec5Jv7GTgOA0e8egeA2UAqTqzS7pzlZnMowywdVJlfLzE8J2vco+NkMw3RSYjj7zRkFxYRYAsvow562Sm49x3rykjfNuQ9UynTn1DJ7rcwU8TRNw62gH1pluEsN/9qMnuvAdkt0FOMekxGVN1/sJZ4sSNe0YnfrK8zmNioPqTOQI9SQrLXxcxiKB8gDk+D/t/52/ig==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=UEVVZxCkdKQaBNEzZaiLV5rDdMDoDszoczoVkU3OetBmOTBafpQ7G6cVNfdhM8wWWls/cvjcJRVwHMs4k6gqe847mt+ToYn3i7g+H+YLTnqjtlpBpBbMboK53VFVA6QcFvz88lw7cFCKgFmMoQgPEdqfPO7CGHEUN4XHSJCtkGlIuNgGeLH3qg+piLpTFftGV9/oq2zXlrnvVP1qbpLTOV+xv2iRBa4oqFyirE1Bs9hjod2S3/sdwc4lyf/ROgOuti4qXVhbUlCw6O382I7oDLFjYD42rhmRD3HIeyYzUC0/Js48PoJW9vQi6oZ2xbtVPdBZ5uHG3nTqdSLuTsrjtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=TuSNjOztaT/MrlY1KJazE8DHX1R0ST6unoW9lil+LZL+Nsz1T5ij522hYsVnMeMOoULBqdtPmft/NPKFw01HqJkLDTdPhojgqHkQEpn56nwFZBgebzqI3krSDw0xM3dEm+PoN2X5+bJo5v3R5WLFMwbpWD7OQxrL4ewztOq6VnY=
Received: from DUZPR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::10) by GV1PR04MB10379.eurprd04.prod.outlook.com
 (2603:10a6:150:1d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 11:34:50 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::cc) by DUZPR01CA0179.outlook.office365.com
 (2603:10a6:10:4b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 11:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:34:50 +0000
Received: from emails-8729467-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-66.eu-west-1.compute.internal [10.20.5.66])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 01CE88005D;
	Wed, 25 Feb 2026 11:34:50 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:42 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUjAsP8fsnr2zz5AfE+63wbV0+Z5JKT7mECnxdBf84SYwwwJUdOnJJmp7ahb2FWN04QLjbvzCN8zIz4I8W43vgW7o9jbqo0IUWj8cL7i+Ir0AyOXKe5rt2TjKaZvk+iTa7pkYES6/Z4OKFduxrQnm9XALX5z9IRr8ci+HMoo8PQJpWzmQqrLG0bRjqd1vjI7nHXlCMklHbxML/BapVudvhxyoO5aBlZyuwx0bketobfp9eD9ugzRtcJq7Qqzu2SdaKnLzReQsGPLOpG4nBTAvpK5kOX1H0M8icH8nYFRzaU/qkFg0WDBI6MVf4KfAEsjWwnCeoxW09g0KU1txkOjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=AFhtYBNBHu50Z0EExEwTSB3VAPuvQYI+Q3Pnmb4XsqpguhopzQ032MRsrYL2hlRf2cQ8N1ZX4vYEHlqLl0V7nSQWVfO0DXr0ugSUyxlBwyf7c1OIYKba28g2LVa/idmtyIgcZmby5lh1z7n5843Msqhe8BFBhhQcoLEjTaCuwwhi0YRYzEwUIt+ZYakSq6C83sIe+7CTAgR3qbQxfvxAg7XwePEYBXodpjcLMru03TJj1SWIRWq/gMWGxFx4fqdj/Ml6NY+YdNlfS8SiRqTd+ZoO+uDmchoLwLpLj1NeoaT6LffI0u6RocP4W7vxomzR/yKNugWFqbUuSA5e5as+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=TuSNjOztaT/MrlY1KJazE8DHX1R0ST6unoW9lil+LZL+Nsz1T5ij522hYsVnMeMOoULBqdtPmft/NPKFw01HqJkLDTdPhojgqHkQEpn56nwFZBgebzqI3krSDw0xM3dEm+PoN2X5+bJo5v3R5WLFMwbpWD7OQxrL4ewztOq6VnY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 11:34:40 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:40 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:19 +0200
Subject: [PATCH v10 5/9] phy: renesas: rcar-gen3-usb2: drop helper getting
 optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-5-1ee44f2ea112@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM8PR04MB7827:EE_|DB5PEPF00014B9A:EE_|GV1PR04MB10379:EE_
X-MS-Office365-Filtering-Correlation-Id: e165b121-6a1e-4f22-9fa3-08de7461e2f6
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 jAxJ+6gfT6MfFwkBJg+qLIhn6y40K280nNZYyxO+3WVtn1BnXvtgaa7fylgOKELBbZFIAxfNIaUliy2zxnOCbzpsrCRwARk2OJTPDqry0y385yGjA7jw3FwW7r9QuMVqinaJrxOEUgIjwv5HVhynttIpDzdXysPjzg//Da50qnTtI6PjFwUcXfPK91fiytDNGEtp//v4QF9mmZ/hur9UE3DYpTWCsTNN68TCC5wJGEsuO+UvFgdDfdo7LHu4YkTdRsKDIJ6NgRO0hrT7MBEws5wazrOIqEOisXU2pH778DqjgbOB1WzGLlmK507z3V0Et644xaL6FdGUyOUJZdPS8ARcFdR3B/OrDXoc0iXCidW02XPZ2313pQBhfD3MIyry5y2yWrOtCVVdyDRHjPVRvYCOVaClPk2fqEIPJB25K/PNl6KSCieZZAAy8s/IMxz6DSIVSQAZSLhOAIKtITpQeSE30KfD4SXzy8CvhC9pn8srmj3DZz4IFjaO/R1uNjdRWrwCLE6SF/tXqmqyFeA3yxkkpU7DTF+s7mJJ+Y7nwv9wxW34RFcZBp9MMaWFCIEQ7lSkJOOos0j7tvaECXhSs/XtzqOXAfFmYEHF2CoVVZ3RWsFMtgB4dUP3CfoMyyP9qOwRwgeObkrv3CSJKA3rOLKq0Snq5KkxkGc0bmM3R6d43nJPkJTHfDhbfqqQqO/BHPGWBF2LG1EuAYUa/YpGEHWNMuy7QFvcRpoReNYmlDYLxosrGmGKrwV4OWTCq5KMCa4WlIgBtKB89+SUj1IlVLzrZcfg6Bc28KHe+c7TTKPms0Y1xF57Kz2kdiQB3a2x
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 68d4e54edf6b4c0d81f17207880c4119:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	18e1d34e-ff8a-4993-4288-08de7461dd20
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|14060799003|35042699022|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	1a2AL8BP0W0Up7RUznqa5fy6xlyAcyFc1TagHjMf73Kjz7QkiunWMOuKUSeWtwRXB8L4uZ5pCyyPwLrSkXOn9pPKx9PAp6VwK/PGTixNP+3FvDvXywLmwYF7vXJ5FMDj/loh1FbeE5j4z6m2d2eMjXhmVA8jkB+ivj/8kZzrbRcUDh/Ltw1Ep7CDoShO0fiIe9FphcKpT4IPrfwfnAIyAKXFXAsIhUndXV6Wyop3U9Uyd1o2G9aehAEtXbPHJ63rBaOC/fgRm/EalaEFacfMwtgcPhhNsQGdKE4GvguJhV1Yft3XiabG5JW8vtGmKKWxYwINZtN89z/zDwaTCgt3GIodiLotQfTQQnrdieeG+z6rcbgU9iQInT7McFUG0/XMQNzfQEmG68S69UU63Vl5vrGlLGIaW2PhcNcGmSXkn7raLaFiY9SnkGqb8EfL896TobSaW/voDy7HmaS6B9fEYmGl/FPxWkiizfpTl7N1y0i2OfBKyE46UX3jF6pURAyFJ8rhAyPSaH6qO0+US2l6ls2Ak+okZNFvwzrTFca8lblQNlUUQhVcYH2sRCYeI12EZAFUOem1Egu2wvw7UYsVbezdVQgXXZD1eV8r8X8j1i1XumyRDhVSIOs2IFltgv1HbvdnJSBhBwHRp88OANsU7HjN7xjGxaX7lrKNqF9ikLei2K2vbu5rvjin1IDDzIS52UGeNQ4xM8pAkXqSmj1vgQFtcOOSj2XNyVVN90Lrmapxb2hCBzm1Lv3OsMI7c+kL9iHbY7ooNJiKeCAwxMrXTQFm+12qOPROBkVzHEETzLOsKY+wHEK9pMt5zpPCaRWiJS7+DMlIGv3MwaWd+aNKlU3JBHKlWh4uj8Wkpw/5iek=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(14060799003)(35042699022)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H196Hdaouu3EKRuCmKwHqRs8ANcn+YW/w1/2uijF7OiyBiJdNdbkqhXsaQgnd3nkH+J0VFJ7AkO3UtPNdjvXWL51vWoagCp2MTN3d2p/fAbpG86MRv7MwieVzL/vekmaznzRmOfXZePgt/Gls8dwC9X3l4w3nwDT7pvCCuX0cqzdBZxlg5AHrnpbFEPrNYrfwLouMglVp/vEcxGbyMCxIg1Lx8QhF1xJHKR+29ul+L3Vegur5I6T9DS2VVuhqS3dIFnRBEzYDSa3pzl6LPo+pbQpdOTKpMcDcoAB6IZXV8fEB7Ly7fDEeLucom4sULGFK9tj3HTWCHVwFmDqVeF8xwrWAXMUlK7MNX3rY1qAvJXu169V8qoG6tiuA/0ax1O60We8W+75KGg7Oi7k5EClqCfPN2E005MyB06Ck3gcCZt7PtmexN9EsKzpZpCNk6qJ
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:50.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e165b121-6a1e-4f22-9fa3-08de7461e2f6
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10379
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6624-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4F8CD196910
X-Rspamd-Action: no action

Multiplexer subsystem has now added helpers for getting managed optional
mux-state.

Switch to the new devm_mux_state_get_optional_selected helper.

This change is only compile-tested.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 1155b111420a..79e820e2fe55 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -939,21 +939,6 @@ static int rcar_gen3_phy_usb2_vbus_regulator_register(struct rcar_gen3_chan *cha
 	return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(channel, enable);
 }
 
-/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
-static inline struct mux_state *
-rcar_gen3_phy_mux_state_get_optional(struct device *dev, const char *mux_name)
-{
-	if (!of_property_present(dev->of_node, "mux-states"))
-		return NULL;
-
-	return devm_mux_state_get(dev, mux_name);
-}
-
-static void rcar_gen3_phy_mux_state_deselect(void *data)
-{
-	mux_state_deselect(data);
-}
-
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1036,20 +1021,9 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
 	}
 
-	mux_state = rcar_gen3_phy_mux_state_get_optional(dev, NULL);
+	mux_state = devm_mux_state_get_optional_selected(dev, NULL);
 	if (IS_ERR(mux_state))
-		return PTR_ERR(mux_state);
-	if (mux_state) {
-		ret = mux_state_select(mux_state);
-		if (ret)
-			return dev_err_probe(dev, ret, "Failed to select USB mux\n");
-
-		ret = devm_add_action_or_reset(dev, rcar_gen3_phy_mux_state_deselect,
-					       mux_state);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to register USB mux state deselect\n");
-	}
+		return dev_err_probe(dev, PTR_ERR(mux_state), "Failed to get USB mux\n");
 
 	if (channel->phy_data->no_adp_ctrl && channel->is_otg_channel) {
 		ret = rcar_gen3_phy_usb2_vbus_regulator_register(channel);

-- 
2.43.0


