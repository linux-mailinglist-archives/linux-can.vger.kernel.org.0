Return-Path: <linux-can+bounces-6636-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI/VJj5JoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6636-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:23:10 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 131BD1A660B
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 154173088ECC
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B632548A;
	Thu, 26 Feb 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="N7abRCjL";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="N7abRCjL"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023116.outbound.protection.outlook.com [40.107.162.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD343164DF;
	Thu, 26 Feb 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112096; cv=fail; b=RpNKTDMh7RQbwSxneUtY8jUmw2ofhZ18cWSTd2mMzLb4gqQYwkYgYR4B6riIwNGHJ2KsAh+cp36do5soywBS4X6PlFlJXNLRrsLIHQXO9if7F6QN6rfw681U7x9M4fc1GGTexMdzPnWjSr7KfLFuKqo+D5fRlAr3iuzw5HBESiU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112096; c=relaxed/simple;
	bh=+8KsS1ZNRfzeHdEWj8wB2sj9aWlDOnI10gXNI3fVoOo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YThGTtJzFELw8XJABpkgmrWcLc2rrapGqc3p3BYjdsvoOGF1cFCvi3ZjDOecaolghLfRLp1E0p5uo270g/j6s+vYU33AoaticdsTLhULByuVvPIQxyswiQDAa7ryrGyZgaCdBAuRN/JB9SRpN+GqBlBmT1dZ9+h4425qDpp3lPk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=N7abRCjL; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=N7abRCjL; arc=fail smtp.client-ip=40.107.162.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=p1aVSrumbtDMopA0Edw695hwgb2Tq+WIZJMxVgknwePhpvpFAtV92fiG/aNNCwGONpyGAjJT3lIhFBE9SkJeA2Q1Za4AKSofPfsy8InKGc/5vSb9tODtU5SC3/zbdhYrd4Fmtc4t6aQlfiKsXjO0e1F2BqhIZBM/FR+a2+mkiru8LohrKO3QOlo28op3XEH6/2InJsATj0wW4eUPmMUpTY5/LEey2tH4cLwZ++uCzYLcHHtL+uChuALb8nN6cEGQWz/iu3U+eSI9Q+adWS97yFjEnf2PuTijct+I6YOo+VVDxve32RsoA0rWwSynFN9SbbO+UEsIRWszGKkLAg5LyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW8Xk5aM4eU5Otdz909/H0HJebndtQ25fTzn027d9rw=;
 b=U2B7AFZ3ss64t6bMPDOPM1aPIGqEoYCGGfzZMeYK6yXndvbeBchAWNCAIFUtJjJlAx/faAkCiF64eZxwy7JqlHo/ijigsFfmKUC8ehxbY1uEt154AWA0uRX/mfsTGedX81V7oyslVB2eaMfwix9TRnBKUqwXXW/Is/er4SxTZSoZRST1xYKrx8cPWub47aw8uH0nx6TCn3ekWkkZPENClfuK2woi0AhTxi6ZVWesmgKFRYfkiu4BWh91FayyZ3zaH9vwOCB0nOsl8BFTxguflmoM4v8zJo9so8dgSaGXXYMU1/QCaahDqIZwoSrBMWgB52gE2/rSGDThC3LOAs7/XA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW8Xk5aM4eU5Otdz909/H0HJebndtQ25fTzn027d9rw=;
 b=N7abRCjLJ5rbY+LVGqT7mxnsltxqTYgUAptz9xitVHlXCwhuBthzfzzoR0jkosMh86BwrBdzDT/doiSfLQGgnNKD8TyyqciB++f47Lm85rNy+t8vVo5WnIVyv19yIB0XKx9DefctGom9sztRkXWwzgjI46O5GEUxMXqEk0BONwM=
Received: from AM6P192CA0086.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::27)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:21:30 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:209:8d:cafe::f2) by AM6P192CA0086.outlook.office365.com
 (2603:10a6:209:8d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Thu,
 26 Feb 2026 13:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:30 +0000
Received: from emails-6412129-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 4366080116;
	Thu, 26 Feb 2026 13:21:30 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:23 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbWd8ZbqDvNTMsjyLfNk7cQEEcrhVjNcpW2Ads39v8/RxrbG9i/5ZPhMSrNWTM1iJlNtqKhrqGXG+4z5MksCqLYc3q3045CdDFtkl3ymFAoYoXb31UMtH4AEInIfjPPwRKaVCcRC2sXo+fd4J860W57sooB0mX5gLqFXtf4Ps+enAlas4qhslTHkvwOcnPHiDnDIZE3zWtQyf+XQcpDIul1BYHw1gJ1qcNcHF5xakApTRVdpX+Rhy0nbmbt+Eidt3B/N4MCVwDbBOMWqJzvRRPLI+Rv+LWs/5FHvrdk3JsQr7mOt7zjT5ywQPQ6YeJiKcVqWkxLpHohXECof7Pgemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW8Xk5aM4eU5Otdz909/H0HJebndtQ25fTzn027d9rw=;
 b=rLFPGMxZxgEmp6EhJETu4hdzA4IkxCsNisKg5O4u4VrH7m0SacY5zhGOkk1nxsg64e2nOLC0kRYSFWS2tDXpidjcv2MO/dKe+XanESa62QkUinMZye5UqgHoOc9cVuhcjW8ypfggrr2OtQ1trq7o8n6V7ARRLuVS4DAfYNW4XRrKmot60P7Vt/wmv8D/swYqq8sXL4xsCIWwOHU7UVONb24kUi7OfRhRGw+p5Ie7f4T1DRiO+B+vy3IujqnRIloelZStUTtaGbI5lm5nH5MTfW9zqS9Lsee2O1eOzShcQRa/vJnLOQX/ypL5bJMZla6u/fQcqGEcFXarFoqKfnVtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW8Xk5aM4eU5Otdz909/H0HJebndtQ25fTzn027d9rw=;
 b=N7abRCjLJ5rbY+LVGqT7mxnsltxqTYgUAptz9xitVHlXCwhuBthzfzzoR0jkosMh86BwrBdzDT/doiSfLQGgnNKD8TyyqciB++f47Lm85rNy+t8vVo5WnIVyv19yIB0XKx9DefctGom9sztRkXWwzgjI46O5GEUxMXqEk0BONwM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 13:21:20 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:20 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v11 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Date: Thu, 26 Feb 2026 15:21:08 +0200
Message-Id: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRIoGkC/23SzWrDMAwH8FcpPs9DkmNb2WnvMXbwV1bD2oxkD
 d1K331OYTQ1Pkrw+0s2uog5TTnN4mV3EVNa8pzHYykQn3Yi7N3xI8kcS0MQkEYkltOvnGMe5eF
 0li4EjcoOaJBFEV9TGvL5Fvf2Xup9nr/H6eeWvuDabecsKEFiikkhRzQwvM7jZ45yOh2fw3gQa
 9ZCd0+Aj56K98FrRs8co215tfEIj14VH5whjl6baKDlu39vAKHavyu+j86AQTewCy2vNx4rr4t
 XQdnEbMmwanmz8VS936yenVO9JtsTt7zd+mq+Xfen5L2JDuLQ9Hz3BOrRc/FAXXIdaDYqtXy/9
 dX8fp3vlE+oQlmu+f8ImwDS1QHB7YJS1w2UXDmwOuF6vf4BbeHd6O0CAAA=
X-Change-ID: 20251128-rz-sdio-mux-acc5137f1618
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
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR04MB8747:EE_|AM0PR04MB6786:EE_|AM4PEPF00027A60:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 79eff4c7-dbf1-409b-a030-08de7539f454
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 m2mn2A8gNImRWwVXi/qGk/RAnRuwuM3oBTpwHJvyzzRicWZwyJOQjS60dxJYI9fr0uiQnSbL/an+MkgiBIFH/qxpJhPVtFiMHz1BaM/ZcNFmU6Zi2f4elW8sYOw1Ri4hP0JTbEVoXXAM0v6qScEI9VvvY8s+AaHvelTxvOC8jznnfJBebWL+/9PZLqQQNqIrqsiyIGi7r6mcB9I37ZLhde+3TUexnEbSctqgMo6KOg4O9bEgD+lEG3zN4GJuDpVeXuZ9dnGx2A47mmX/Qva33bHhK/R5GYowFVkhN5jsqgIxcr/j+vWpzpRcvNo22iqKbAK1bQAPaTifW6K2aOCaDlR8qxSiIcyCcFkrUtn8C3+YLmTNWNah8PLWVEfhi3mqx36tErwxylISQjf5J0L2qrcV/k1uI2tcpndX5NZDBRyoQEUF+A2je5J8SiwlvURBumFtrYQeo/rzX0WD2kesf4jTv/qQZze4FJWswaFU+PBeDYnv0Vl/ltUyjeYMGjW8Hl5Rdn30ZrblpdgsyJUnR6ZpufnzrZIPORuzDJMwkMXhrGAuICdTPj+8tZD5ndGnB2x2AIxpSARt5NwwmkJxoFNj+2D3ouVkosAfD4VFxBrsZeDRJLGqr/PxORsnOMLEltduUjY2jvvwcRl1baAkxM9cyD3+hqsmMaukEs0PhfQgtDSXDoOjzz8+v9tpJfJuPQ3Ym7py4mj6ZCybleSgSseNoGa5E/2H296e8izwwQYcy6tl8KcEx5sk9fedGWwBSSKT2fwhmSgrb5OBSdCNMQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c07e53a4491a4d2c96789a36f5667bbe:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d95e3b03-c3d6-4d4b-7ef9-08de7539ee24
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|7416014|35042699022|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	Eup+AxrKbeBt6g3aEzNWJRyyQNvzKZIp/g1b3EBtmiBJaZWDOHxYN1E3aLAaB18P/B0Ts4d5e9LndULec3fyNbeI57tfswpOQQHn7RABUhBPg4vIuBU/thGDVNlFHkz77QYI7/Eg/Ykp1ZIRV43LnfMI7ftvN6PbAUPe6ZtN6XortPJj1PPSIGkyrr9MW1lZl7NQumCXAnLK60FnWP1Gy94+IKZsjjhobxFgDqfclh1JCUeWnlwYH/oXPBgZS2/NNgxk8p7Ziwzh9jllij6Rv/d2BOEz58KwzYMAK2NlLz+jAf0a1r3tBLSypaB7CfOr/wbNczDgy6sAWOx+rk83KUZLAWmgMF9g561volojz87tTXC5+erDgDo/YTgYDMthoTOT3nZ6FVO/OUtPGLMy1nnhsaDgA2t3L0B1PLEHqTK1T1GaHQzj84/o7OUybpxyyGuNjGqSYfpvgDK1j0DI36YK03eUhOmIgeHGn6uRA6hRwijZrb9wqTH4qEa58uqdKLOrWJcXXWSHzd3Htgzw9w/v6ETwWnRXzfMoeN7puvA1w2sdcuykX2hrlBzC7cyBeBKQsL0b6Ys5zqmEXWvNdL/bTYzdb4ttb/7+tv2u9TEm3lAfeD+bCSZIu7GfPHDzZtC8DMcli3Poxb4Vb5pCPTT8I7K+0PgyT16G8ixiovrbnbddTSuAs1ehoEti51XxK0x8LiWH2cRih9x7xDzwGmX87tAVETDra/1jmRFNTS2dhQWa9TB4evHTiZ8pLr0QphRqjTap4TYaEkDN0qCAPMegFx5ETI9WfTKNfmk4zJo=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(7416014)(35042699022)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1IQYnEp9b9mhamgqgDA09KS36FH9Nw/RXFoLfaUkPYlp4ooB0LCv7c2nW2vQ6KiQrXS0N/pVzgYrMnAEEEtGOu0UwbsGVDQnvzDyzeHCkYbKuS4N6IEhIK2JJREk6N+kT09FTcBU5eJchkcUnpvAwKqIhz5SBvrwaxM9JUBp31hAxfJFlXlvphW9CnxaKpWMGz5UaZ4+ciZ3/SMKDqQWGWr6jm+7oOdvIsHxyv+Ryz6GO7hZtsgsZxMyCva3AU+04hokjRUBr66n3ryW/FfY6wKb43qCU3Sa/oxY41f1deM2R3VbffoLQsOC8VhyuGF3jZq6laD6OxBc1+NsztrQiiBFhoeZSSqxRy5sNE3JVJl7U1rAzOogescETd2/RJjb/lrj9DzWlVTbJ4ceoiV1dDQTCRuErvCkpOxiB1r9B+zw7XrGSQjYNkCrtv67gX9E
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:30.5137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eff4c7-dbf1-409b-a030-08de7539f454
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6636-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 131BD1A660B
X-Rspamd-Action: no action

This series has evolved over time from adding generic mux support for
renesas sdhi driver, to partial rewrite of the mux framework.

Several drivers have started implementing driver-local managed and
unmanaged helper functions for getting and selecting a mux-state object.

mmc maintainers have requested that new code shall intreoduce and use
generic helper functions that can be shared by all drivers, avoiding
code duplication.

This series is structured in 5 parts, each of which is self-sufficient
depending only on the previous patches. This shall allow the first N
patches to be applied even if the last ones need further discussion.

1. Rename driver-local helper functions to avoid name collision with
   global version to be introduced later.

2. Implement generic device-managed helper functions in mux core.

3. Convert driver local code from similar patterns to use the newly
   added global helpers.

4. Change mux-core Kconfig so that it can be enabled through menuconfig,
   without an explicit "select" dependency from other drivers.

5. add dt bindings and driver support for mux in renesas sdhi driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v11:
- changed approach to Kconfig making MULTIPLEXER a bool, and adding a
  user-visible wrapper for menuconfig.
  (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
- dropped the "default m if COMPILE_TEST".
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- improved kerneldoc line wrapping.
- removed unnecessary changes to original devm_mux_control-get.
- fix "reference preceded by free" in mux_state_get function
- Link to v10: https://lore.kernel.org/r/20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com

Changes in v10:
- added renesas-sdhi Kconfig dependency for MULTIPLEXER, avoiding build
  errors in case setting SDHI=y and MULTIPLEXER=m is attempted.
  Trailers were dropped on this patch to encourage fresh review.
- renamed phy-can-transceiver driver-local helper function to be
  consistent with other driver-local functions, and dropped all trailers
  for this particular patch.
- reconsidered the Kconfig changes due to inputs from mux core author
- handle newly-added mux usage in rcar-gen3-usb2 introduced with
  v7.0-rc1
- streamline patch sequence
- rebase on v7.0-rc1
- Link to v9: https://lore.kernel.org/r/20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com

Changes in v9:
- compile-tested on x86 with MULTIPLEXER=m/y/unset.
- fixed Kconfig changes so that CONFIG_MULTIPLEXER can be selected.
  through menuconfig / .config as intended.
- updated trailers
- document null return value for mux_control_get_optional.
- fix build error for CONFIG_MULTIPLEXER=m, found with x86_64
  allmodconfig: replaced ifdef ... with if IS_ENABLED(...).
  (Reported-by: Mark Brown <broonie@kernel.org>)
- Link to v8: https://lore.kernel.org/r/20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com

Changes in v8:
- Add defensive null checks for all non-optional calls to internal
  mux_get function.
- Document NULL return value on applicable functions.
- Avoid IS_ERR_OR_NULL and ERR_PTR(0) to disarm smatch errors.
- Link to v7: https://lore.kernel.org/r/20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com

Changes in v7:
- picked up reviewed-tags
- fix Kconfig change to add the missing prompt for CONFIG_MULTIPLEXER,
  and enable it by default when COMPILE_TEST is set.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- fix another kernel build robot warning: undocumented C struct member
- Link to v6: https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com

Changes in v6:
- replaced /* with /** for devm_mux_state_state function description.
- collected review tags.
- fixed checkpatch warnings (space-before-tab, void-return).
  (Reported-by: Geert Uytterhoeven)
- fixed use-after-free in mux core mux_get function.
  (Reported-by: Geert Uytterhoeven)
- fix mux helper error path uninitialised return code variable.
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com

Changes in v5:
- implemented automatic mux deselect for devm_*_selected.
  (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
- because of semantic changes I dropped reviewed and acks from omap-i2c
  patch (Andreas Kemnade / Wolfram Sang).
- fix invalid return value in void function for mux helper stubs
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com

Changes in v4:
- added MULTIPLEXER Kconfig help text.
- removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
  not required for all devices using this driver.
- added stubs for all symbols exported by mux core.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- refactored mux core logic to silence ENOENT errors only on optional
  code paths, keeping error printing unchanged otherwise.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- picked up various reviewed- and acked-by tags
- Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com

Changes in v3:
- updated omap-i2c and phy-can-transceiver to use new helpers.
- created generic helper functions for getting managed optional mux-state.
  (Reported-by: Rob Herring <robh@kernel.org>)
- picked up binding ack by Rob Herring.
- replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
  commit descriptions.
  (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
- Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com

Changes in v2:
- dropped mux-controller node from dt binding example
  (Reported-by: Conor Dooley <conor@kernel.org>
   Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com

---
Josua Mayer (9):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      phy: renesas: rcar-gen3-usb2: rename local mux helper to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      phy: can-transceiver: drop temporary helper getting optional mux-state
      phy: renesas: rcar-gen3-usb2: drop helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mux: add visible config symbol to enable multiplexer subsystem
      mmc: host: renesas_sdhi_core: support selecting an optional mux

 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 drivers/i2c/busses/i2c-omap.c                      |  24 +--
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mux/Kconfig                                |  17 +-
 drivers/mux/core.c                                 | 194 ++++++++++++++++++---
 drivers/phy/phy-can-transceiver.c                  |  10 --
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  30 +---
 include/linux/mux/consumer.h                       | 108 +++++++++++-
 8 files changed, 305 insertions(+), 90 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251128-rz-sdio-mux-acc5137f1618

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


