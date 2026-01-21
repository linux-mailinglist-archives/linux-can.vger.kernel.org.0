Return-Path: <linux-can+bounces-6244-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIlmD5+dcGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6244-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:34:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5354784
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13CDC4251C3
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC047ECF1;
	Wed, 21 Jan 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NF/WxHnA";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NF/WxHnA"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023136.outbound.protection.outlook.com [52.101.83.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4547ECDF;
	Wed, 21 Jan 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.136
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987287; cv=fail; b=IMJPG5LFIAVeosLPNtKKWpRdyHp1Y0JfL/jYgJ8+sp/x7TmW25vqunEk9hK1+NQ8EZQj6swoLI0B6l6+dDC0KkZsV3SemzTYt8/32mZembzBCTDrrgYABnJ47gDnJ312WSGhjxjUxgOdiv6bqmb97QtIxitRLXxDcoTAAj3Yzcw=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987287; c=relaxed/simple;
	bh=H+dxOlw7D+/ac+pzWaD9F9Ao/kAHfSrb2565gnhAQBo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JS4ElZhLP8msJsxTExGRmCr7uoQtA0IR9rCoqrNbaUehOvdw9bzYTRPhhOMeEPwAZiINTVBdIXsXE84yhMDKHiVY4Xj2U/k9/f+asVv1QjgiMR/UdcR7B5OKC9mdlcKEaULyJg8wNcmJRWJr95Hbc/VVYVvNuQyBtqI/nFy/Zww=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NF/WxHnA; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NF/WxHnA; arc=fail smtp.client-ip=52.101.83.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nsKqreK+GF4UGHeDIxo41zqgWmdEaRnO3kl1wUpH/AsZRA727fxsKdavpStnCelIL5YzViMTnpGyXsgsJM1m97H7srjzjRnfwaN+fJuUIEE4gYh/vtmvpRzMQ55nALQaeULPLigzYqajsngQYxVrOlaAZvoEcqm1eBDFUHJ1dwbILMVp9M3TmOePpzymbDHO6/pQRDr/CdjAYQkuzoTGvwjLkiWpMWcDzV2kkss955uM6s2pdcMxywMug5M/RUCyp2kBU4HSLCYIW7Biwc0QthRR/A1BD5QLv2vMNbADqJfNXE+0Q2csg3cmRtsyzw/pvBgu3X5XpT0O/5MBA/YsaQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=GxHzleVIQe29BTglcBvwIm3Z0VUPMZDVosg7F8b99eVPkN55LBW8nUd2x0rcPPafpsqAu1qPLg8KgsaG4nWCKcN7+WpDoZGRJOBkHuwQQtlDj7VvksjfzRcL5PE2P99aCBYoK/ubqoNifYfX8tZcueO5xnrt9GhRtlN8IrDD/n7hQEnBXKCH6ca8+5wNCd9Gn/kJyzr1FqhMsKYpLZww7onFYd/KOP750eFFrFbJmm9aSYLF+fEr+MFJZSv16b4kzd345fbMoLJmNWa/diHzzjQE0e3hO1wMeC/NLim3wBn0xyYUiZZy5L6dHe5NEf9T7XgV1uyhvKzrOVPnIxRYdA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=NF/WxHnA99Eg/QErfOFJBRGcZgaVTcR3weUu2b/2a15PbZlaSOkwu8T5SCibovwzPvC5sqPV+2VS1KVgR9irMKGhxYlaWEinTzeKfb6B575w3Embl1L5PW5cEbNYBS/HHEhaa40m5KpSb94eBDsm3q+m5r8/g8KA4XQvoON8uyg=
Received: from AS9PR04CA0151.eurprd04.prod.outlook.com (2603:10a6:20b:48a::21)
 by AS8PR04MB7782.eurprd04.prod.outlook.com (2603:10a6:20b:28a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:22 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:48a:cafe::b) by AS9PR04CA0151.outlook.office365.com
 (2603:10a6:20b:48a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 09:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:21:22 +0000
Received: from emails-3454305-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-30.eu-west-1.compute.internal [10.20.6.30])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 17AE880616;
	Wed, 21 Jan 2026 09:21:22 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987282; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=XRjPD7jcDTB7X/0mGEU6OZHDQfqWArnHwjwAZy7fAqTW+lhoP7QDrmGe4ssXsWmaGISL2
 CqjmOACqJFX/XmVGRl2+joAmMXP6b949idL0x9MqVd+rgAtWd8TbhjOu2h1/IJJAc/Il8Ie
 zw1+HrPPml6dZ/BM839eKBr7g6Zg+MQ=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987282;
 b=QHlAWpO/K/3NUf7dxQag3EFbNnqAuNkGaldVN4hEizOszN+hDowtCcW03Tr9x2CZRb808
 hPmc259T2SE+ExfSZMA0waW0uZGdtQzwTI9h9n5n8vFpnlzsSuTJ+C922Nv6JNa3/7Pw/+f
 vsMqahqqCJqZ6aV221eGz0ryxTaSth0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENVB4u5JckEp65/tf64RmXLr72cxj4L+Mv7n2b12Mcv8Q5VQaZblK5wjZB1EsWOEkwQr2ya+/sPqg7J04sX+8CW/5lX3n5K2zR6UvDiTK7SVRIRJ/FQiaWKzyBWvKsJSgfdRhlLvRjHU99HzlzZCBqumpkfUsQk70B2LaRJxQxA/fz+bQVvZkqXQgjuX1Bq4bfmSngyJq3pwd8jtVM672fvAPS1lEbLkOyAzU6MHdGywVLEGtg4WFFpl+F34gkoM1ESy8Q3OYV26bABIZgux50dR3jjpHObsKgeKY2iItSU7t0p5iw4zNoX2QqApOlrDDnxKratjFKrFKB1yL2w0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=oNfOLi1lS3QSxfXfWgJ+J0rak5jGZG3dbD3U1d2y+L+q6jW7PSEKhQT656Jr2K0Jq6h1uwJ8zME8SsOYgYdqbfshBXjbfv5gjkLjZi6zTVE0BJpSBtsOJUpG39LXBkqWnjUYeriOOeK3EIQY67qwR1nlyxuiCy2Rzwk7bhwIRSco9aQuW6QbSOgzRtY2tRz6eLmvwBYWjhj7lACKa8VcZApJ+4n06mSJsiTGlEDInSyNYH3vY8n2M5jFT6W7Xl3C6SF6v6OC7WL7PucT97xyPwt9UO83Q3QPmAlKpR45IM1I91AwiFT21NBsULBdwfItphED1u5SypiAklbm+iOM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=NF/WxHnA99Eg/QErfOFJBRGcZgaVTcR3weUu2b/2a15PbZlaSOkwu8T5SCibovwzPvC5sqPV+2VS1KVgR9irMKGhxYlaWEinTzeKfb6B575w3Embl1L5PW5cEbNYBS/HHEhaa40m5KpSb94eBDsm3q+m5r8/g8KA4XQvoON8uyg=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:07 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:21:07 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 21 Jan 2026 11:20:43 +0200
Subject: [PATCH v6 6/7] dt-bindings: mmc: renesas,sdhi: Add mux-states
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-rz-sdio-mux-v6-6-38aa39527928@solid-run.com>
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|AMS0EPF000001B0:EE_|AS8PR04MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b6185e-c0f3-4cf9-0845-08de58ce7183
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bC9ibWcwNC8vMUhFMzJIOGVrMitVajhxdi9XS2p4R1pVbzF6aXMzYllNV1VN?=
 =?utf-8?B?clM1VFpQUmlZY3ZLU3ZHY3pYMjFxZjdGTk5IbW9qck0vaGs2c3ZPUmdiZmdE?=
 =?utf-8?B?S1FhcndGak12cFNlWGMwdUN3L0txbjNpQXhuN3p2czhLY3FFNFN2ZUdTNGlF?=
 =?utf-8?B?YndkNksybHo3QlJENW02WTlMaDdlcG4zZmt3NWh3cStjeWJOVU5oQm9RbGov?=
 =?utf-8?B?UGVjN0JZR1d1NXZNendqdWZuUksvQnFRR3RjdEVZUUY0Z0I2VFVkQ3B6Ym1E?=
 =?utf-8?B?Y3Jtc0crWmZoTFhyQ3JmcVJpcUFKZTJoUllmd3cvZWdFd1hNUExGUDRmaGVL?=
 =?utf-8?B?V1JJSXVud1FYWFp6YUk2YnUxQ29TRDRrVk5zVEtiVE1sbVZtb3ZIOFV2bnUv?=
 =?utf-8?B?S1pqQmlwUkJmOEovSTJoQkQvYnpmcEJQdGNwSmdqUmZRN0pJOE80SE4xQ0RM?=
 =?utf-8?B?RzVxSCs0OUdRS3NDVDdpUzVtQ0tDUFFtSThZQmhNK3V1M0RnUENBYXBnL3hE?=
 =?utf-8?B?Z1NVUm82OTdoNmt3cWtxWWRvbXRaRmFjQXF4d2xZYmhLOVlYSE9leU02Sysw?=
 =?utf-8?B?Q3ZwODk4YnZnQXZ0S1Vad2FtTWhlTEVZVDNhemtUUGxVNkRHWlBTbFR2THhY?=
 =?utf-8?B?dHZyZ1Q4czRneENXR1kwaVFqTGgxVmxQUUVLR3VYblhCdm5RbW0xNGcza2Qy?=
 =?utf-8?B?SGNjSkxPNTg3eGV0NjI1dE81bytyNnZzS21IMXZoODBFTWNYNUNSTmNvQ0FN?=
 =?utf-8?B?a0k2ZElDcGxmeHBMMlArLzZxZnR4WHRMaURUeGM3MnBJZGx2dDl6cFNFcXpB?=
 =?utf-8?B?TWRMdUUyOE5mTmRtRlpZRjZUTEJwYUl4NzZ4anZQQ1UrT29zV28zZjZtUjl4?=
 =?utf-8?B?UG5EUDY1bEpEaEN4SnlpeHFjQi9tdmdvWWJ4WlQyRlV1Y3pJU1pkWldBaU1E?=
 =?utf-8?B?WGQ1MXI2RkhWMVYzaTl3VVZtcmZqK1JnbkF3YlZydzhVSFY4ZUdtdHBOcndM?=
 =?utf-8?B?bFZUMVZ3MVQyTzlnR0ljaFdVaHNkRzdpUzJ0Ty9yR2JWbmVFYWhNQ3lXWkQw?=
 =?utf-8?B?WUNqdkFVVXRCSW5RVWNTQjlXdWVSNCticVFrTWV3RmVHZVN3Smg4YXBDMXlt?=
 =?utf-8?B?UGM0YUxxc1ZtdFp6UUFnbVRLL0dnb3M1bEVpbHdNQkpDSnFzVmduQ3lpU2Fj?=
 =?utf-8?B?TEZMZWIvUnZUbEZKMTJNNHhKWENLeVdKdEg4ZU9mbXNmYzQvRDAzMml4dm1H?=
 =?utf-8?B?MGdIa0FpUE5pUTlxbCtVU2ZYeURuMFJPU2RVOURxT2dsZDVvVUVTcHpuQTFO?=
 =?utf-8?B?S05lN3JSQlBuWE5qaGVMVzloWUpIYmZ4RCs3NDZ5c2Npa0xYWW00VDBvODVp?=
 =?utf-8?B?akg3akNhNDZnVDl5bkJpbmlBRG1BUFM4VkFiUTMyYTl2Ti9aRzFTdDkvK0JS?=
 =?utf-8?B?WXVwZTQwc25OUkxwQVZKRVZWMWMvUWI0TWtUMjJkN2Q0YmVEREFkNitsNS9D?=
 =?utf-8?B?NFAzeitDcXUwL0U4d1lsK2lkZVlZbFBJRytuUFFER1hONEpKNTUxbjBmbkVR?=
 =?utf-8?B?bDVvV2ZJTzlCYW1zUVJWazhHTFBiNzJ1SVdvUFZwOEFsY25BU2RTODFWWSts?=
 =?utf-8?B?ZDVoekNZc3p3Sm84WmFXVmdMN1NVTEpveng4WmlFazVBZUlKV2Y0Q0dJYzg2?=
 =?utf-8?B?eU1ZUUZSL1BqNWk1My9tK3ZTK3ZzT0ZPZ2xhVFlhWVdnVnpMbHhGU20za1VM?=
 =?utf-8?B?Vms4MXpSSzNwR1p1R3Y0TkJFVXJWWXV5TE1ob3RFYkgwSXdZTEY5Qm1SK2F3?=
 =?utf-8?B?dWdnMWdrR0lDWE5UcVovc2taamU3cGxEeUNycGR6NDNoN2JsUE01MDZPMVFn?=
 =?utf-8?B?d0l1UnZXQll4RFl4TlBTMkJESStWUzNaVXh1dnNiKzlQRWJIOGxLRHRIV0Y5?=
 =?utf-8?B?TXJ1SXY2aVM2cWFHcjFYWUlQSE5GOCtub01iTWZnR09HcGpObVloQzUyVldT?=
 =?utf-8?B?QkVzZE11MGFnOTVteDdDdkNIQjlMRTVocGFLcnNhcGhDcVRNbHAxRFEvaS9o?=
 =?utf-8?B?RVZSWFh5cldWVVIxNGVDQWROZStzZm8zYlQ5eFl4dnlvNm9NSHMxVDZhV1Y2?=
 =?utf-8?B?aGpFTUkzdmsvbldSWk13bjRGc0V6RmZqT0IwWFNBMFUrb3FMMjBtQkpiVnhj?=
 =?utf-8?Q?+aQhEA4iaNjGSuTKk5diBO4=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 96983e1673434c2497adaff514021d24:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3ca65cf9-514f-40b5-39b9-08de58ce67e5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|36860700013|35042699022|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGF1elUvbXVGdnVEQjU5T1R4MUg4R2xNazg1TkdjM3c3QmFYVnBsV2xpMFJt?=
 =?utf-8?B?Skx2dFFOV3VzS1FBckNqcnpvdEtXbmJoR2pQRzFYalQxV1FJSk5rZzd3TXBL?=
 =?utf-8?B?anJ6ZVgvdzNUc3R1WDk4TmhxdTZHMmw1SlY1S01NRENmRUZVSitkODVIOHZ5?=
 =?utf-8?B?VWhhWncrNXJsSzFyeTZGeVl2SGtaUTBHY0J3cVN2RE5leFBzeTkrWXdHc2w4?=
 =?utf-8?B?clhHdWFoU3hCWXQxYUlaTEdhQnNNaGdwUzZsSGcyL0RwQTAzMVpiVyttMU5M?=
 =?utf-8?B?NVJnTHBlRDJZdlBLeW5vUlk3MElUdzJjOEYxTmQzNWNhakZoUUNzMjMxdW9y?=
 =?utf-8?B?My82RXBNQzZlbnIydlNlbE1oSVBxQmx4TCtpU094c1krYStnQ2ZSRkhFSHdG?=
 =?utf-8?B?MFdLdm5SU2JPZ3I5ejRULzhXZnVlMnByRkc1VTNsd212S0NuRVl4MStGSXBy?=
 =?utf-8?B?WVJ4QWhUakVyTWM5MkpEVU10SmZueW1weUtuUXI3bm55a01TcjZOd0c3K2pH?=
 =?utf-8?B?RWhDTjFUOFdkOXNkeXR5WjJTcFI2ZmEyYkk4S1FWcDRpMmNMeGFDYXZKakRT?=
 =?utf-8?B?YnpLQkVtODVibkthYkNzYVdDWDgzRGhFMEc0ajRicFNGTGx2S3NpQUt6UzhH?=
 =?utf-8?B?Y1VFUGp6Smw3b1d5UVBLRUd5WjEvNVlmUVhxWXpFbCtjTTNlWVZySi9Qam1t?=
 =?utf-8?B?bHNwR2NMMWNSaHRLWjV2WFJQeDVaL3VjQlJIVXpEdndWWVZ0OEFseGR1Ri94?=
 =?utf-8?B?ZExaaU9qNVV3M0NLUnZlRThVcCsxTktKSlZrdEVtOTltM0h5NnVhQUI4RkNV?=
 =?utf-8?B?VXBYV29YMEoxRWx6OVJkR3cvTGcrY3FwcTZET0ZvQkd1QUVBS3k0cm8veGVF?=
 =?utf-8?B?WkZVMzVaeGkwaHFKMnluV3NyVjByUGFuaEpPNEFmQzRBc0ROaWRUeXU5ZExC?=
 =?utf-8?B?ZUJKMXdhZ1V6K01OYTVoRkhYNTF1amhKcXZ6TExtbVV1MWdZNkVkVHVaUVNs?=
 =?utf-8?B?UXJ6dFh3Zk1OSjd4RHQ2ZGN6dmQzdmVlNnk1OTlSNkxKMVhpL0xxRTJUb3BP?=
 =?utf-8?B?U3gva0Qvb1BvMUx4WHYrcXUzSUhjbThocmI5UGduVHVBcEFmaERqRFF3c1pR?=
 =?utf-8?B?b1RLdVVUQnZSSHhkWE54OEFReDdjYllKOHkzSVNtQ3M2Yk1DSVBZd1FGdzFU?=
 =?utf-8?B?WHdQTGFSZWlseGZqSklCSWZjSk1nVmpjanhsSDZ5OERxVjA1NzVUQzNteW5h?=
 =?utf-8?B?YnIwM2RrWE0xV3l4SURJTE0vdEkxTEJIQW5hZUlvWjliODBBdzUwelB2ZSts?=
 =?utf-8?B?dFVMUFpmTU1oYVU3RTlDbnR5bk1nLzhLMzNJQlBJK3I2N2c3WnFTbW1uQ2Vy?=
 =?utf-8?B?QVRoY0ZmbUVwbTBYUTd6S3IxUHREMDJ3S3o1QStRQUU2VXhGa0RYRXBMYWNS?=
 =?utf-8?B?bzJ2Z0h1QS9FYk53YVEyQWxISEo5VERhNWRJNDlZUjFxUWhHbXpHMVZIY3du?=
 =?utf-8?B?aHdsWnlRS3RWN0xqaEN5WnNrVExkaWQvZjY5clc4VnVSZ3ExaVg5dldvOWNa?=
 =?utf-8?B?bFpjRjRHYWFwdTN2S2YrTWdPdHZzSUtvWTNHRE9taHRiNktQcUJtZVZBUnpL?=
 =?utf-8?B?ZXVwckJWR3JUbjlGbk5VWjhBdkZJR2RUTUpWUlBEN29LV1BneUt1N3l4Q2h1?=
 =?utf-8?B?cEJHS2pVY1ZCa0F6M2puaS8xZlY1N2hhKzBCUTlUVlVwdklIejVwNTJwUk9C?=
 =?utf-8?B?aEVyMml2dndXOXhpS1FndndjQlhDNjVpQXUveWlxcXU5TTYyeGpCcHlHeXk0?=
 =?utf-8?B?bGgrRHVCaE1MaDFETVRzak5BVTZiQ1UzMTNNMjA5RlNEZ0hGcHk0ekF6eHc5?=
 =?utf-8?B?SFk3SlNoUTZhYVBPaVZXOFVDNXVpM3Z6dlZ4U1hLTko4aTc5a1FQSTMyclky?=
 =?utf-8?B?VUw3eWhRdnUxVWZXZC8rTjFYTXNuTU8xbHVqNEJIWnRsM2JFLytyT1dHejJk?=
 =?utf-8?B?SjV4UnVveUdzeW1ZZE1UMUxDY01vcU5qbTB5Uy9Wak9GakQ1MmltR0o0ZWR5?=
 =?utf-8?B?aFhBRjlwTWJHc3R4NDRWL3l6NjRjY0R2QmQxL2FWU2F3WG14M0J1VjM0ZndR?=
 =?utf-8?B?Zjcrc1VmYVI0aFBocDkvSHFvYis1SkFvclFRNjJVeGtjbXQ3VExTOWppd2Vi?=
 =?utf-8?B?RFh1UlRiSTRCd1NxVEYwZSs4Qjlnd0RKSUwwNWUvMzJKaDV2SHR1a3k1WFc3?=
 =?utf-8?B?WlBicGREU2dpYnVZWXhWVmo3VkFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(36860700013)(35042699022)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:22.3090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b6185e-c0f3-4cf9-0845-08de58ce7183
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7782
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6244-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ee120000:email,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1ED5354784
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add mux controller support for data or control lines that are muxed
between a host and multiple cards.

There are several devices supporting a choice of eMMC or SD on a single
board by both dip switch and gpio, e.g. Renesas RZ/G2L SMARC SoM and
SolidRun RZ/G2L SoM.

In-tree dts for the Renesas boards currently rely on preprocessor macros
and gpio hogs to describe the respective cards.

By adding mux-states property to sdhi controller description, boards can
correctly describe the mux that already exists in hardware - and drivers
can coordinate between mux selection and probing for cards.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index c754ea71f51f..64fac0d11329 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -106,6 +106,11 @@ properties:
   iommus:
     maxItems: 1
 
+  mux-states:
+    description:
+      mux controller node to route the SD/SDIO/eMMC signals from SoC to cards.
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
@@ -275,6 +280,7 @@ examples:
         max-frequency = <195000000>;
         power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
         resets = <&cpg 314>;
+        mux-states = <&mux 0>;
     };
 
     sdhi1: mmc@ee120000 {

-- 
2.43.0



