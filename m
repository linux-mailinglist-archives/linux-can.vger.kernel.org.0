Return-Path: <linux-can+bounces-6241-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCcPMuyecGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6241-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:39:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D98548C9
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1358C866190
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BA47DD58;
	Wed, 21 Jan 2026 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RxPFWtA5";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RxPFWtA5"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021079.outbound.protection.outlook.com [52.101.70.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212447D92C;
	Wed, 21 Jan 2026 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.79
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987275; cv=fail; b=tPpWyRz6E42GemtklGeZ3MH1Ev1LNECD69e19XRrzlSEM5ummyup3KHE0LobnRP7N4jHabGDiKgaM7GSTI2KBEDknj2/SooVLb7+ZTGASdSq+KMjCKIRJ4Mefl1s/a7wcdh+GgAKvuUjYEWMb0LOOJuQqjAVHI3Fq33pbQEcQtY=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987275; c=relaxed/simple;
	bh=dFIfuqVb7DsDJj8DhlQITcwhJ4cUlMREWd3QBAdJEkc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pEjVigjyWVmA9WsPERnhmulaKbidBEnpnLRuIvFozwXpi/0dOQeI6FKEm8+LM1ku9OGUaOZ+NI4RAyM1T0TRzEKwlc0BO4nIHU2wVL2I/2I6OBcdUDsn7vfR7tyYeTf2QYC9BWJcHNCQjMDERrCuMItVO1ifyS+v09MF8kkUugs=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=RxPFWtA5; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=RxPFWtA5; arc=fail smtp.client-ip=52.101.70.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rQRa9xRiXwxV1FGj3VmFMF0R1gut7V+RjVgKdvnPSXRn9B3PVkNVyvCV27VHFzJANq3V9P+OrPcvwOrnOMJA60PhgJ/uoz6cNP9dtJq9Go+3u9EY+Usk8jjcniUoEGHnN4/Zx24PV1yYHykPUH1Yavp0ZEAzWAMGJzjSl8XYwnQd070837vKrA4M9sRlRGr6s5/epJg5Tmp4BT2o2jcYAutqc3semQGH0K3jmt//493NU8MT21UHDSeyxBNnGqgehPYPpU6799EwD1JD+CQNhvRVV/AUDxJcxX1sgENQ1ZRkrkRtu0/j7FVA/Nbk315clja/3OvTNnSle3rswuiMWQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG+hM5pb435K7k1J0FdCxicGB997qb3JbeSy3kleQO0=;
 b=fvmVd9lohYZJh4jyNox8YxYPHT3VWt407ZfRO51vjsC/rvM8dat5EFaae3okqz4Nq9aEWNN3u55Z6pGvebokJK9r6e32Lf0+FC10iZa+AfmDHv+pRIUYDO3rm8e/Ccph/DRCwxvCsnwALvfh41V0oqlxlTK5E1p3tUel1IwAshIuyMYLLOlY70yxf2OEB8G5qG9KjVcR/ce3h0ELkoGQx3YTNsHyI9I/SgExzAdCM6gQeVIv2htWZEZHGy1YOBrv0XBWB3+w7QiA844e80c53Oc6ndq8MF2qg3CtJ6wGIAbWv4yGa1MJkEN0u7Js8LdMZFfnezdCwCL6Y/lOj1VPlw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG+hM5pb435K7k1J0FdCxicGB997qb3JbeSy3kleQO0=;
 b=RxPFWtA5vq96cPYbs0zpJYauow5zOUQPhq7Ic2/0sMURbwKwpa/xNR5syeIxHzTil5qYlQGZhGyIM2sZJDfwaSUzWsuKbMzC6XcWERwKuprz3yMxZxC+r/ORxZWMSD7B8lbR76emA+ziRXV5ss8nqlq3kViF4jSZlkK79n6m69s=
Received: from DU2PR04CA0226.eurprd04.prod.outlook.com (2603:10a6:10:2b1::21)
 by AM9PR04MB7697.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:08 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::dc) by DU2PR04CA0226.outlook.office365.com
 (2603:10a6:10:2b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 09:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:21:08 +0000
Received: from emails-6649728-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-30.eu-west-1.compute.internal [10.20.6.30])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1BDD480624;
	Wed, 21 Jan 2026 09:21:08 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987268; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=tG+hM5pb435K7k1J0FdCxicGB997qb3JbeSy3kleQO0=;
 b=mZZRZWjIssEaShW6v2nZmPBIhqUqur+MRT9s1/OSJOer6LePYhE9NXWO92qOdrxfekkrh
 2Dv1w6QzTovYbMwSZAZqPUymoWyyjVgG2KLYwcXIFNgRmYtWlYSs/8ILfFVj+PqHOI952iT
 uk4dOoYK85CmpXc5Y1O4ZWkAVSaNQtw=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987268;
 b=SHdzROkcH2CahDGa78xtyEDbqB/PUzWRhXqsLpl+BsyR41jPw/pHiledxA0cuWOV/bqcG
 WbFTUgyxQTVJmbnWauEGIOc2zPxGAkVD/3eAuEkYL/Hcr2lwLMVDRUY6lQjgstJoF2N7B7s
 1sRhIiDxSNLwAGsQKTmmJaTVfGTsxzc=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukKAeUXsQdpDkI6SmuOF76dHjB11GHZseZF6cwTgAbzqfAigZwhTUv8Tgt46/5IK1YGVJ0gH8SD1ig5xh62hxxchcc8pYr9851RKl1CInYrvWuK0+sjeKtBBt/vUkFanH+HNtRv6R08Dhpr4OUFDIJHKvUl5t6GY7z4hHK6adxRZWB+hCb04C0+oAJbKWh9XnGpFZSuntbvBRFxIZsNq1i+HQK0wOAJFUQBiUIeBgKX+86753o+bLN5JplekeXqfeU3XaQsNr2z9eeBpe5ApT/AqVmA38S+diG7NSlOCXm6iipdF4+oj8qRjsM9ljGzqlM7jjIoFpv+qRyfvyT+Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG+hM5pb435K7k1J0FdCxicGB997qb3JbeSy3kleQO0=;
 b=sc4p1d5qaPIWYCGvdQ+ZJi34DhAUzQKOSK2vfZXV2dAtOouq31kprCc902PFS3uMpAG4gA6F48bChC13J/zy9RzLtgGn+ba0LBFJCs7wXwAaMsFexm0R5R4SLXcpuEz7f29Rv/U0epJfu7ycgA/2oOJ4pd9mCWmBB0MDV/NKEYSy5p87SE02zrsk6QEorSRRBzCoFl6YXhg1dWlhRgDGpLKrijHgDGC1v1CKpvp3+Ded3SCf8ZWwMBdOmITqcQ44aBmHwN9yt+bqTpMYlGiqj43SLuDvjK2ROmMOAMMJb+fkKPz9XwJw8zCupiRDbRvET9MqMPjZz+mrZ5c1kx0CSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG+hM5pb435K7k1J0FdCxicGB997qb3JbeSy3kleQO0=;
 b=RxPFWtA5vq96cPYbs0zpJYauow5zOUQPhq7Ic2/0sMURbwKwpa/xNR5syeIxHzTil5qYlQGZhGyIM2sZJDfwaSUzWsuKbMzC6XcWERwKuprz3yMxZxC+r/ORxZWMSD7B8lbR76emA+ziRXV5ss8nqlq3kViF4jSZlkK79n6m69s=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:20:55 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:20:55 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 21 Jan 2026 11:20:39 +0200
Subject: [PATCH v6 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-rz-sdio-mux-v6-2-38aa39527928@solid-run.com>
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
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|DB1PEPF000509F0:EE_|AM9PR04MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f2fb69-d208-4c01-0ce9-08de58ce6918
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?LzVUOUJ3RlhQalhvenNDSTl3Q3BNQVFad05lZEVCY3I4NThmSG1LYk5WRTBv?=
 =?utf-8?B?RXlsU1JIeXBvSGxiem55dVltYkg0SmtQaGQyTkJGUk9QK2RxSDYwWFY0Yk1T?=
 =?utf-8?B?aHlNcnBUUDZ5Zm9hSHRzZXdWb0hXY29NV1FZcVF5SkVBeDBwU1h5RGh3RDZN?=
 =?utf-8?B?SnZNL0ZIb0R5ZnA0SmJUeEx4VG9GRjM1YnZtZ2dGamRseGJ5Y1J1QW5kUW5R?=
 =?utf-8?B?b0NXV3dYNGJTSi9FTzhicnltaEltTkNSMytkN2lzdkx4b0twbjVlZlFwcGhG?=
 =?utf-8?B?MzFzbFp5eFVqeGFWT3Vyai9QdTljMlJVWWtFZ0xHSEFHdk1lblY2RkR6M1hQ?=
 =?utf-8?B?RzYxeFQxVytVTFQ1eThNaGxwTjF1aGExY1BxRTdkTlNEdjZXNElGUmR0QTNi?=
 =?utf-8?B?R3o5Nm9mbHRDT0lPTzAxU2QzTnIveEhyVmxNV0FEaFVCM2d3c2xQTndmNE5l?=
 =?utf-8?B?UGZpeGFETGJWWUpiaEV5L0tPZHBRZG1talB3TGF4b2JsWTQ2NER3Zi9BU3pY?=
 =?utf-8?B?N3hXOE9oTS9QaWxwL0pQeURLWCtNNjVMdUl2TVZjQVBMMTF5U09PNytlT2xY?=
 =?utf-8?B?SzFtalRuZ2pHa0oyNWVEK01SeXlkVlBGRXNMMjNjcmU1Q1B6QnBVSGkyZHBy?=
 =?utf-8?B?WU9LcFdCVGRUem9IRlNqZmIvMTFDeHZJeFplUXkvVmY3K2s2MmRoV3paQTY0?=
 =?utf-8?B?QTVIb1kzT094d3V1SVZHaXlST3NvOEZLSzJEOFByOUN2bC9RWUZXVmp6d3RO?=
 =?utf-8?B?enJGWHlsaHpyUGZCU1JlaE8xQ3drdGFBZFJoTkdPeFAzRWtrdzlVeEllZ2d3?=
 =?utf-8?B?UnR6UjlueCtySDJRZWNkM0RSOThGMTlGQ2J4NjBlR0ZYVVdYamJGMnIwQVZI?=
 =?utf-8?B?R3NSNjZsTFEwWG1QRjV0b2Y2dUFhUklpZU9LUDgxdTZSWUg4MXgydmlWWndh?=
 =?utf-8?B?M3dVMHY3L08wSzhsTEdQNVhjUERvenRMb1Z4VitjQU1DV0dkUnVRTmlZYkE5?=
 =?utf-8?B?dVBpS09MY2UveFkveWNFMXJFOGI1VzJHWmt0RmJwMU5HSTNHc0dGUnhucUNR?=
 =?utf-8?B?cEUvY2hBY0FRd0xMT2FWRVd3OE11N0lldUF4aW1PYWRSNkxlaWJpSjVmV1dH?=
 =?utf-8?B?QlpZVmpvV1FnQW5KazFvN3hTU2RnS3dZOFJEL0VHbHZjOXRMS2pvVTdaMHRK?=
 =?utf-8?B?SmtCcFFiMHR0RWxFczgwdEdKZXk0bGJsYmFSSEdLNnFMRGJFV3Avd0FGMndr?=
 =?utf-8?B?aXlTVURSa1d5VkdvS0JvNWFNTE4xWFFKdVEvUkY0dWdlTFVvbHVQMndiNjlP?=
 =?utf-8?B?RlRWYWRtVDVhSGVNQVg3S3ZlNWt4bHA0SnpkcWx3b283WGZGd2dhSUlQei95?=
 =?utf-8?B?U1VRVXBIRVNMVVFiRnJUY0pncmZhZzRnelFOUG5mejRleGl0YjdhcGNrWUZF?=
 =?utf-8?B?OVBQbnNBY000eERZQlNWMjJ3QkxjUkxRUGdrcUtacGRzMkduYTh4Q3RFUmQ3?=
 =?utf-8?B?RU5ReWtaTmN6WHhDSkVMZUtWVjczbzJ3U1h2R081QlJBa3h0VkpIYW9IYkZZ?=
 =?utf-8?B?RG9LZUtUTEo1UWk5TVNGZmZYWUw0bm9Qais0bTZOak40SE5zcktaYW8vRWlY?=
 =?utf-8?B?MUFMbjdoNXpCT1NrSzQ2aXA5Zk5qeDFNeVN3cTJFaFBUWDZ2dkJ2SlcwdUpp?=
 =?utf-8?B?UG1oVnR6S2ZqK2tINWMxK0tleGRua3dmK01kRW9IY2JteG0wbSs0T2Yrajlu?=
 =?utf-8?B?cURTZUJjS2dBTjdYR0ZpMVpZVkZYRkFyeFJkeWZRREdxK1FjQXdLS2RpMWFF?=
 =?utf-8?B?eTd4eFVpOVQvOWp1VnBYWlhVSVQwL08rUDU3ZEhKK2wyMWU3cGVoU1dFK0ZE?=
 =?utf-8?B?b1NjcVZWQUVjdWNKeWRFbDRSQW5DMkpTQTBlNmpYL0xsZCtqWTJwL1ZPb3FZ?=
 =?utf-8?B?MUhhSEVWNmpEU0oyM3NPeTQra3hyZWNGWG4zeGwyeWJwVDFBbXAvQ2xKU3pD?=
 =?utf-8?B?OUQwSjJOMHFDQlkwV29SMk4zWXR4Z083UTRqRys5QlQyTFNBNEgrcTh3bHFv?=
 =?utf-8?B?VmtLMTByRk9qWEMvQTdUQ0VpTmI3ZjJQMGRteE5zZE1kU1NTWWsrZG1MT2JT?=
 =?utf-8?B?d0lYTzBJSTVheWtVUkQxZUk3Q0xzYmRLdFp3RzMzUytNcUo4Yis1YWZxUDFz?=
 =?utf-8?Q?myy6K/rkAMtsiATc4xNY2Gr8Fizy6DKns6YxOhWYJT9E?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 748c94ce250840fcbfca2b5dc8c49534:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1a3aba86-4c4f-4d86-94d4-08de58ce6133
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|7416014|82310400026|376014|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0hRQlhseStaTCtxNnRrOU5nSkE2THpuQXdqUmh1c2NyWkN5THNuSEROM1Nt?=
 =?utf-8?B?Z1dVck5maWcwSnhvMUdCSkpXd0NBZlhuVG55YXcvWTVwVUtwN1pBTDh5NXlP?=
 =?utf-8?B?eXB2b2ZyOCtaT0x0K3Q2U0xWT3U3aUV6Q1BFVWlUQURZT0piQnFDUDAvSGx3?=
 =?utf-8?B?dXdPUlZuMTdYdzAxSE9iM1dQTkdaajVhVDlHREZRVEdTa0NkYzczMXhiUk9w?=
 =?utf-8?B?SWZ2WmxKMVIzWVZSRERnQVJjdmhhajk2SklzckFES3pIRkJaQUg1QnozNHUw?=
 =?utf-8?B?eDhId0FORW5WRm5SU1JOdXdiandTL0V2Z0JFOThUQmhEYkxjRXNiUHJwUVow?=
 =?utf-8?B?c1hpNDJBOWZRWHVKTyt5NGJQM21qTndnN21LczdWNnJ6U01ZWXRYMUFoZ05S?=
 =?utf-8?B?N0wzcmcvWEFMRVQ2clRIQlRIa2RLYXM5NHFNVUhiSWFhYU9iUk5Od3ZIRXhu?=
 =?utf-8?B?dHErSGhxNXNMYkF5elc1UjJ1aGp3bTlmdUJsRXAyOEpBUjhGK2kzQllnVnpq?=
 =?utf-8?B?eEJlT0hUVE84L09tSklpMzFWVWtkWHBCMzRFb2tlNnNFMWFraGVUUVFROFdr?=
 =?utf-8?B?RVVBcEc1NW9Ub29BTk1XY0RueWxlWEgySzlJcW9xUjJLK3I3S292S3NEVFpU?=
 =?utf-8?B?TzA0Y05ORmttQjRvNWtCdEI0WUZNRmR1RElTNmxXOUQxYXdnWVA3MmMvdGdS?=
 =?utf-8?B?dGJ2UDY5OVIzTHZvMGVYVk1QY3VrRnVrK1hCb0p3Nm1NbWRvZzdLK1JwTVJu?=
 =?utf-8?B?dnpLZm9aN3o3NE1HWVVLQjdCR1VZUXVHNFRTamxpOE5mdlRrOXF6WkhKZHRv?=
 =?utf-8?B?Qm8xT1Z2VnpWTkRPaHV2Z1VxaHE3ckRDZHltQnBjditud003UUVmQmRBL21n?=
 =?utf-8?B?cC9VTENPQ0xBZWQ2ZFdsV2Nvd01QQndzeEZ0R1hXdUhDcUIrN3Z5dFZmR05j?=
 =?utf-8?B?Sm5mM2VoQmFjdWtGYkRlUWd4Q0dYbjh5RHovQjhEZVZCUzdLQU5nS3FEejEv?=
 =?utf-8?B?ZDlpSDA1TTJzY3J2enFvc1ZwNVRFRGpKcFMxS0R4RE4zdDFMdm1pRHE2bVVC?=
 =?utf-8?B?cWpoUXYxNVNrczJqKzhZaU5IejFLVFpWcTl0SkdTQmJzVVlQaVhWdDhTTnl5?=
 =?utf-8?B?ZG1EeWJxcnBjd0RmUjBVUGwzRGd6ZmFqQXpnT05EMmQvNDAxOElFejQ5eGRP?=
 =?utf-8?B?bTE5TllycXNFMi9XbXZVUHpFbUFHR3BtVTFodUY0UkpoaEFmNWJXQXVFV0g1?=
 =?utf-8?B?RkRGVWF4UWdWMHFQdWhMU0lRZmpDZFByU2IvK0NreHJvWWJZUmRrRGJvZUtT?=
 =?utf-8?B?TSs5MEI2MzlKK0dxcWRVUTEyOFVBNjNuUmNMdkMvQ2tKTVlheG1Hald6OWNI?=
 =?utf-8?B?Q3BZMXdwY3F2bUpxckNFeCtIL2VlQmswaXJwRkMrbWZGY3lKajh6S2hBUDBW?=
 =?utf-8?B?NU95empIQ21MV04zb0VwcTVGRDVpQ29zdjZBcDJnSjZWb29DWU5uSThlVkRq?=
 =?utf-8?B?MVREV2w2NnBKbUpDRGRBMk5URXRXbCtDVi8vaUcrTm5GcmNPRjFPTWRCNlph?=
 =?utf-8?B?a2JtaEp6TVlLeGNJWXZBUzRyRlBSVVRwUkpjalZpVEFzU2VVM0kvSWJENFNR?=
 =?utf-8?B?OHRHVktkcHhObUJmbHFObVpxazMwQnRlSjhKdWZPallTVXFZY2lFcDFZY1BF?=
 =?utf-8?B?elVFQ2VJczBOcWgzVTh2VGhwbStmR1NlQ3dmZXJ3ZUZiL1IyM3AzMWpjOTdD?=
 =?utf-8?B?aVNFQlZtRy80SjZINjFxYmxmMmpibDVtamFTUUY2ektOSy90YmhmV1dFNE92?=
 =?utf-8?B?VkZtc0todENJM3FTekI5SVlyWXkzY3RiVVBQLzNQb1FMcFZuY1ZFK3pSTkVj?=
 =?utf-8?B?eTJhVk01eXU5T29Eay9NYXlZZ3A0MkpVT0ZvZEljTzBTOFFxeGttVEtSUWJo?=
 =?utf-8?B?OVpXa2RKTmhydWN6RnR1bVRhbEJVQUZIbFlBNnM4MXFxcHpJaGl1NmN6d2NL?=
 =?utf-8?B?bm1sa1dlc0gyRkE0REdzSVF0djFrZlNMTS9hZjNnM2Y5MHJZTkJFQXhwTW5l?=
 =?utf-8?B?YTJITldhakFEU2dtbGRSZzJRMUEzNjlKbGQvS3JJNm9hcTk2V0pWV2xBcDhQ?=
 =?utf-8?B?RVI1ZWYxYkx0ZmVoYlhPZ3VkUjNkYVNtNGhQUDNvUUZscVpEc2F0aGgxd1Jx?=
 =?utf-8?B?VnlBNGNjU2IvdHo4V2VjR3VqL3llZkovWGVMb2Y3R21pU2h3SjZsODVrOHNv?=
 =?utf-8?Q?VkuLbO/xVLgqiPmwzoy0tcNXoc+XyvUuUrS5UvgLbw=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(7416014)(82310400026)(376014)(14060799003)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:08.2459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f2fb69-d208-4c01-0ce9-08de58ce6918
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7697
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6241-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,solid-run.com:email,solid-run.com:mid];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 58D98548C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In-tree phy-can-transceiver driver has already implemented a local
version of devm_mux_state_get_optional.

The omap-i2c driver gets and selects an optional mux in its probe
function without using any helper.

Add new helper functions covering both aforementioned use-cases:

- mux_control_get_optional:
  Get a mux-control if specified in dt, return NULL otherwise.
- devm_mux_state_get_optional:
  Get a mux-state if specified in dt, return NULL otherwise.
- devm_mux_state_get_selected:
  Get and select a mux-state specified in dt, return error otherwise.
- devm_mux_state_get_optional_selected:
  Get and select a mux-state if specified in dt, return error or NULL.

Existing mux_get helper function is changed to take an extra argument
indicating whether the mux is optional.
In this case no error is printed, and NULL returned in case of ENOENT.

Calling code is adapted to handle NULL return case, and to pass optional
argument as required.

To support automatic deselect for _selected helper, a new structure is
created storing an exit pointer similar to clock core which is called on
release.

To facilitate code sharing between optional/mandatory/selected helpers,
a new internal helper function is added to handle quiet (optional) and
verbose (mandatory) errors, as well as storing the correct callback for
devm release: __devm_mux_state_get

Due to this structure devm_mux_state_get_*_selected can no longer print
a useful error message when select fails. Instead callers should print
errors where needed.

Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
property presence check") noted that "mux_get() always prints an error
message in case of an error, including when the property is not present,
confusing the user."

The first error message covers the case that a mux name is not matched
in dt. The second error message is based on of_parse_phandle_with_args
return value.

In optional case no error is printed and NULL is returned.
This ensures that the new helper functions will not confuse the user
either.

With the addition of optional helper functions it became clear that
drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
Add stubs for all symbols exported by mux core.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
 include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
 2 files changed, 253 insertions(+), 33 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index a3840fe0995f..3da5c464e05e 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -46,6 +46,16 @@ static const struct class mux_class = {
 	.name = "mux",
 };
 
+/**
+ * struct devm_mux_state_state -	Tracks managed resources for mux-state objects.
+ * @mux:				Pointer to a mux state.
+ * @exit:				An optional callback to execte before free.
+ */
+struct devm_mux_state_state {
+	struct mux_state *mstate;
+	int (*exit)(struct mux_state *mstate);
+};
+
 static DEFINE_IDA(mux_ida);
 
 static int __init mux_init(void)
@@ -522,11 +532,12 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
  * @mux_name: The name identifying the mux-control.
  * @state: Pointer to where the requested state is returned, or NULL when
  *         the required multiplexer states are handled by other means.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
  * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
  */
 static struct mux_control *mux_get(struct device *dev, const char *mux_name,
-				   unsigned int *state)
+				   unsigned int *state, bool optional)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -542,7 +553,9 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 		else
 			index = of_property_match_string(np, "mux-control-names",
 							 mux_name);
-		if (index < 0) {
+		if (index < 0 && optional) {
+			return NULL;
+		} else if (index < 0) {
 			dev_err(dev, "mux controller '%s' not found\n",
 				mux_name);
 			return ERR_PTR(index);
@@ -558,8 +571,12 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 						 "mux-controls", "#mux-control-cells",
 						 index, &args);
 	if (ret) {
+		if (optional && ret == -ENOENT)
+			return NULL;
+
 		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
-			np, state ? "state" : "control", mux_name ?: "", index);
+			np, state ? "state" : "control",
+			mux_name ?: "", index);
 		return ERR_PTR(ret);
 	}
 
@@ -617,10 +634,23 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
  */
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 {
-	return mux_get(dev, mux_name, NULL);
+	return mux_get(dev, mux_name, NULL, false);
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
 
+/**
+ * mux_control_get_optional() - Get the optional mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: A pointer to the mux-control, an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(mux_control_get_optional);
+
 /**
  * mux_control_put() - Put away the mux-control for good.
  * @mux: The mux-control to put away.
@@ -657,8 +687,8 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux = mux_control_get(dev, mux_name);
-	if (IS_ERR(mux)) {
+	mux = mux_get(dev, mux_name, NULL, false);
+	if (IS_ERR_OR_NULL(mux)) {
 		devres_free(ptr);
 		return mux;
 	}
@@ -677,20 +707,19 @@ EXPORT_SYMBOL_GPL(devm_mux_control_get);
  *
  * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
  */
-static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
 {
 	struct mux_state *mstate;
+	struct mux_control *mux;
 
 	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
 	if (!mstate)
 		return ERR_PTR(-ENOMEM);
 
-	mstate->mux = mux_get(dev, mux_name, &mstate->state);
-	if (IS_ERR(mstate->mux)) {
-		int err = PTR_ERR(mstate->mux);
-
+	mstate->mux = mux = mux_get(dev, mux_name, &mstate->state, optional);
+	if (IS_ERR_OR_NULL(mux)) {
 		kfree(mstate);
-		return ERR_PTR(err);
+		return ERR_CAST(mux);
 	}
 
 	return mstate;
@@ -710,41 +739,132 @@ static void mux_state_put(struct mux_state *mstate)
 
 static void devm_mux_state_release(struct device *dev, void *res)
 {
-	struct mux_state *mstate = *(struct mux_state **)res;
+	struct devm_mux_state_state *devm_state = res;
 
-	mux_state_put(mstate);
+	if (devm_state->exit)
+		devm_state->exit(devm_state->mstate);
+
+	mux_state_put(devm_state->mstate);
 }
 
 /**
- * devm_mux_state_get() - Get the mux-state for a device, with resource
- *			  management.
- * @dev: The device that needs a mux-control.
- * @mux_name: The name identifying the mux-control.
+ * __devm_mux_state_get() - Get the optional mux-state for a device,
+ *			    with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
+ * @init: Optional function pointer for mux-state object initialisation.
+ * @exit: Optional function pointer for mux-state object cleanup on release.
  *
  * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
  */
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name)
+static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
+					      bool optional,
+					      int (*init)(struct mux_state *mstate),
+					      int (*exit)(struct mux_state *mstate))
 {
-	struct mux_state **ptr, *mstate;
+	struct devm_mux_state_state *devm_state;
+	struct mux_state *mstate;
+	int ret;
 
-	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
+	if (!devm_state)
 		return ERR_PTR(-ENOMEM);
 
-	mstate = mux_state_get(dev, mux_name);
-	if (IS_ERR(mstate)) {
-		devres_free(ptr);
-		return mstate;
+	mstate = mux_state_get(dev, mux_name, optional);
+	if (IS_ERR_OR_NULL(mstate)) {
+		ret = PTR_ERR(mstate);
+		goto err_mux_state_get;
 	}
 
-	*ptr = mstate;
-	devres_add(dev, ptr);
+	if (init) {
+		ret = init(mstate);
+		if (ret)
+			goto err_mux_state_init;
+	}
+
+	devm_state->mstate = mstate;
+	devm_state->exit = exit;
+	devres_add(dev, devm_state);
 
 	return mstate;
+
+err_mux_state_init:
+	mux_state_put(mstate);
+err_mux_state_get:
+	devres_free(devm_state);
+	return ERR_PTR(ret);
+}
+
+/**
+ * devm_mux_state_get() - Get the mux-state for a device, with resource
+ *			  management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The mux-state will automatically be freed on release.
+ */
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, false, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(devm_mux_state_get);
 
+/**
+ * devm_mux_state_get_optional() - Get the optional mux-state for a device,
+ *				   with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The mux-state will automatically be freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional);
+
+/**
+ * devm_mux_state_get_selected() - Get the mux-state for a device, with
+ *				   resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, false, mux_state_select, mux_state_deselect);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_selected);
+
+/**
+ * devm_mux_state_get_optional_selected() - Get the optional mux-state for
+ *					    a device, with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+						       const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, mux_state_select, mux_state_deselect);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional_selected);
+
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
  * the non-modular case - that the subsystem is initialized when mux consumers
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 2e25c838f831..3ede55b907eb 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,6 +16,8 @@ struct device;
 struct mux_control;
 struct mux_state;
 
+#ifdef CONFIG_MULTIPLEXER
+
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
@@ -54,11 +56,109 @@ int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name);
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name);
+struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev, const char *mux_name);
+
+#else
+
+static inline unsigned int mux_control_states(struct mux_control *mux)
+{
+	return 0;
+}
+static inline int __must_check mux_control_select_delay(struct mux_control *mux,
+							unsigned int state, unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_select_delay(struct mux_state *mstate,
+						      unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_control_try_select_delay(struct mux_control *mux,
+							    unsigned int state,
+							    unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_try_select_delay(struct mux_state *mstate,
+							  unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_select(struct mux_control *mux,
+						  unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_try_select(struct mux_control *mux,
+						      unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_try_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mux_control_deselect(struct mux_control *mux)
+{
+	return -EOPNOTSUPP;
+}
+static inline int mux_state_deselect(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_control *mux_control_get_optional(struct device *dev,
+							   const char *mux_name)
+{
+	return NULL;
+}
+static inline void mux_control_put(struct mux_control *mux) {}
+
+static inline struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional(struct device *dev,
+							    const char *mux_name)
+{
+	return NULL;
+}
+static inline struct mux_state *devm_mux_state_get_selected(struct device *dev,
+							    const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+								     const char *mux_name)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MULTIPLEXER */
 
 #endif /* _LINUX_MUX_CONSUMER_H */

-- 
2.43.0



