Return-Path: <linux-can+bounces-6242-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A4oCEqecGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6242-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:37:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D959554849
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0AE5582933
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9D47DD78;
	Wed, 21 Jan 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HhXXMGOG";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HhXXMGOG"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023123.outbound.protection.outlook.com [40.107.162.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAE46AEF3;
	Wed, 21 Jan 2026 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.123
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987278; cv=fail; b=ipdTQMs2ug8PmFQuO6w44oQFSjnWHr/EEoHjdW8Qe9ycNMQu56Z32F9RSdoeN+q9idNuRupm5mz22iKH0hURwHmAAFTjLWHRXM+LRQFBB5+cRNAaI2IVsl7SO8QALU9QOyJE2uTIvdg9I6glrcu7nCrz9fdOWpfXsSy05A7yE0g=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987278; c=relaxed/simple;
	bh=sjb5eqgiKJnv5oQS0oIqpitPoO+3g2RRM66VyIKvlUc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VlM25w8bT9RDGD+BgzoamkNjD/avMEpMaprj+uliyjgD2UNdJk4cAMyoGtS92brg8/VGfPu5dJbP1abynGToNDV91I4lkfuQ0LFYRRZaPkvTByLp/gPk0OcMNJwBCEYP8bFk9OOiARsRkFyFySVNqJP7YS+pq2Z4XPw9VuBx/es=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HhXXMGOG; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HhXXMGOG; arc=fail smtp.client-ip=40.107.162.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uutVfzHlmbZjMm/l1z8Fs72VvKmaEvvwZDTf/ONgPkkl3t43rEbtdGd9TSLhqS5c0udQuuNAKGBHe0W3UpsiJO5WHqw7ZNz/izaLB7RLwv9gYEq5pm+wQbp92uzJ12TlkIdFDDYiJlUk3eEHKmbOStKAIVC+stv0Spcb1DkuqB/UL9DyzdBHP8q9cYRaAhJls/jHrlxJJVnQCrOi5+oYy1v+2iZk144iJ9CkjYOGku5xMIA/jYpRcwE36paGkHVtXeuO7Wn0URZntMibemoN2e9YTjcLJXLJFYP5ytYF24znPCOmkjZLRBhU+yUZpdeXE3XbN6W2vE/tmEJBdO6juA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=EoZaeszuas6CYHXxcTK1bHJZKE4nVmIvqzmRxsJUeRJdler6yGaiOKznv1zKREc+oT+3VOiofd7hikXW/ZWQKO4dAhFIXvcCG00sQmxdnHAXkJjO2CaEP97Lf1P5VIwK/H4V1wA48s1E1+1PRwd9Zx1HFrsbrPaQMKi3TR0HYmOFDO1ORPjdkyuLV0rj1JShOrSjuXl75lnn4z4d1UXg+SY/WBWt3tvatqlVieE3owplyPtGYqe8VZN3DaxdYv+fMolslzS8Dn129LCiypaFUJ1Xixzp+tvEc4TM/qZPPc4UkqffJuZoh/8peWE7lnYhuUzMg2Yyg36vrfZrudNbLg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=HhXXMGOGGiv7k7hmm+NgLPEEYNRtAZoFlwBqJoFAytzy4pPf/3k0gk9/PsTQBSHwWA1EdJo1hRImPd54f8l9Roebo4qLbzPY0E6xjr8dmYz99tFuNAxRK22WOYdMYxqBoOkkJ2w3DJI9SpOCK2KwUeh1Ziwrlnu1UvovSRwat/c=
Received: from AS4P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::9)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 21 Jan
 2026 09:21:12 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::8e) by AS4P190CA0023.outlook.office365.com
 (2603:10a6:20b:5d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 09:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:21:10 +0000
Received: from emails-4243079-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-21.eu-west-1.compute.internal [10.20.5.21])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 5CE8B805CC;
	Wed, 21 Jan 2026 09:21:10 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987270; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=NM0B6eTxR4+f8zfL6AHoE+Q9iJLBK8UenI+CDgiQoFsy5870TgOp/FbwaGPnJBv5huPqU
 2cB/HBJtnyFA+lZn5u7xd5SDDCLvPJVSvNLoXgqs0weI+VMsQCRHduaq5/9k+vw6fS2iZQq
 xzupuLnKVB+YxgF8pvgjDj/iqvhdNUw=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987270;
 b=I1iAj0evadwF4md/SBzQkso++l0WlUPBvhykbBYpE5zhAhrByuB8Vxr64BKcmgQV/Snrh
 7Bvc5hP+1pr4tb/xqwOVR5dTIpNuKSZdHgwdSJosQO18mZmLBsaNa+7+EordZGCDfIpcqp+
 dFFC7mdL9p8KPPx4wxp29W7V8dw9OuY=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0DS1QjxZT1M8llUPRYGpUagkG0HSNhJx+J0nIJXsLo9BgeHUmeMvAL8IUi9IqM1FPzHeu8itBMvAGnOBoJL1b4KeDJgRTS5foVHgIFDeaJfWMbAbzABl22RtyMj146nN2M0WBd2UYsU0yaw/pmIl8xDVoOccjdL1DY6cGYEDJDPVChoJwiM/fK/LrrcNj/mj4nlWxceYLYjPa1jHo8GQ8QYKsHjN0ZRuYVUwf+h2vKmam81Ms6eKecfyBCY/EyxB8u4We1FQSBmg6Gpf8BANiDD+jyKX5N5ijplszvAQSrgvOZwL2N/l+v0EAntlUK6u04m1sCfhVT5brSkyeIfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=q3AkLFc0BF2FN21I+OqqGee+P+3tjTLMvjjYb8dc39n+cikD9pBtPkvSEFt376DkIphyMU4ebQh9WBPAIXZ74tWrf/c8qKU5dXDL+kEEt0Tz71cMlDsRZX9fud2lu9+0GKNYCGRKaadfcIL3GhoGGRR91HR2lEDhzhESsWt2szBNyPhbJKTp60WUtzsXrhYQhP5De+OdJfqGlI9nGhrKj1FxupA46EIqlzEOLS0n9NkhFc9/ySn0KOjGiHs6t5W+DRQs1leOiuSH8HUnDoujfez892EQj7pEbb8WOoOBrya+qo/w/iZphjHBkfYt7zF56Wm9C+iMyy4riW78csjUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMq9e7lFT/4HlxXcKY0WZRSp5MwkaPp8LUo4aIBkWkY=;
 b=HhXXMGOGGiv7k7hmm+NgLPEEYNRtAZoFlwBqJoFAytzy4pPf/3k0gk9/PsTQBSHwWA1EdJo1hRImPd54f8l9Roebo4qLbzPY0E6xjr8dmYz99tFuNAxRK22WOYdMYxqBoOkkJ2w3DJI9SpOCK2KwUeh1Ziwrlnu1UvovSRwat/c=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:00 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:21:00 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 21 Jan 2026 11:20:41 +0200
Subject: [PATCH v6 4/7] phy: can-transceiver: drop temporary helper getting
 optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-rz-sdio-mux-v6-4-38aa39527928@solid-run.com>
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
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|AMS0EPF000001A0:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: d808e40e-c1a3-46fe-946a-08de58ce6a95
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RUZ3NTc0MjRTQ0pPcEo3ZElHaUhNSFhUMHlJdDR4cUNOR01RRS9zNXMrdFZs?=
 =?utf-8?B?Y0tTd0ZBa3Q5eFJRR3VDS0h3ODZlZ2lXOTc4bEpQemEwV2QrYklRT3N0elZG?=
 =?utf-8?B?TW1GSkxvWklQVzNRdkVRdHZHWk5jeXdEVHJiazdNMXJ2K0dyMzg2UXJWczRw?=
 =?utf-8?B?Y3BTQWRjRTJtN0plOTB2Z3Jqamc0bllnWEJ3dWI1bXRMOUxpUUxXRWsyWTJu?=
 =?utf-8?B?VU1xWis2eEM1OHdTenU5QmovTytHR0Q4dEtMRFdXSURFRHNYdzVJaG1IRGU0?=
 =?utf-8?B?dVFwUlhsZDkyeHNFbW1VQUN0YzJuMmh3b3lVNG9QeFlYbXJUL25IMGRHa3FM?=
 =?utf-8?B?aXo5Tkg5Vk1wT2pNeVhHOE5iSnk3WTdXdnlUVVJvSnd1R0J5ZUQ3NGJ0bDJR?=
 =?utf-8?B?WnN4YVFKa0hsTW5WL2J4UjB2UWZlZFJNK04rYlBMMFF1OVJyNTh5MzBXVlZv?=
 =?utf-8?B?emM5djJ1azY4dG81dUxSb3hyVDFueFEveWlCNXllZFQzamtRN2w5c1lkeFR0?=
 =?utf-8?B?aVNZQW8wMDRuNUdRbmFBNEYwejhqaWMyTHVtS2U2Q29FVnJRdGtSUTI0cEgx?=
 =?utf-8?B?cHRpQy82cU1NUVUyeWdxU2F0UW9BK1k4NlJKVEE1a3lKemo1ZlNjR0p4Vnhx?=
 =?utf-8?B?M1dvUXRTQ21adllUc0Q2MWhxSDUvemxRcCtKMGlPM0xqNUswdHpEU08rYWVW?=
 =?utf-8?B?U3Y5bTFna0szVkxBYXBSbUFNVWhuZTI2UmRHRHMzZDlXanZiS0RmY01YSzhk?=
 =?utf-8?B?YW14U0ZLTHhFS3ZXRkIySDhqSXZvUCtNcmJyTHU1bjBISmFEZVIvNXU4bCth?=
 =?utf-8?B?aXowT2Fqc3dHakFqUHJqVFlvZnJuU2puSmtWeVlKdjMwbFE3ZkJEY25LdDUy?=
 =?utf-8?B?MjZ1ZWJ3K2poRS8yUXAraEhIUERCWUhtRmpQYmlvN1BmR1IvS1JNRVFhOEcy?=
 =?utf-8?B?RncyYnBOU0I2UnJybWs5WkJicGRFaWR5aHBZeTJFL1BFUTlYbnQ3YkNmL3FU?=
 =?utf-8?B?MTErN3p1Uld5MHRuVStmbk95YjlPSFJ3anhabkhqb2VhR2pINS8vUm1uYkJS?=
 =?utf-8?B?Z2F1emZZaW1NRHdZQ0NyeGR6dFFBa2VIMTdRYUQ3UHpnd0pmdVA3QXFKakIw?=
 =?utf-8?B?REZsOUw3bVlYNTg4QkMzZURWQ1pvSDhIRmo2KzJoZVVzS0s5NkpRQlVWTWQy?=
 =?utf-8?B?eHFvZTczZXNLMkxJZEJsVmNQbkd4MGVXTkdwSUVqcEtzM3hEZjN4c01BZlRJ?=
 =?utf-8?B?V1kwRWVXMlVvR2NzN2V4UXdsU1V2SjdhRXBLOEdQWDJzczd4TytmWFJEa2hX?=
 =?utf-8?B?ZHlvR2F5ZW1uQXlGb01jUWx2SnJDODZGQnRNNm15RktEVzFWQ2dCUHF5UDMv?=
 =?utf-8?B?ZVYxcCtqTStUQkpLczJKbENUVzdiSTduR0dHNm91MlJUNWNrZmhPMXNibHFx?=
 =?utf-8?B?RVdGbktMMldtNzNuSE4wbmJaTWxia2o4OHZEYzZHa1FUZDltZ0MxQ2laMlJo?=
 =?utf-8?B?L0t6TkpMc3MvczBKUUpubFdyQ25SL3ZwY1RsTjNsUi9EOGNMaFp2TXVvK1lL?=
 =?utf-8?B?R2dIUHZ6WWtPQnZvNTFDUlp4TjlqSTJldzZKekxqY3ByR1RiWHBTd2E1QnNi?=
 =?utf-8?B?KzVuejRRRWl4TjVic0FjcUtIUDNhVUVRT29CZ1pyLzc4YVpwaE9jUTk4KzI3?=
 =?utf-8?B?eGpjank2LzNxNzZseUI3ZTdwc1IrVTU3eEc2alhLdVhVQVJnYm50OGROUFUz?=
 =?utf-8?B?ZzhtQ0R6d3BUWGZuYlI2UzduOTN1bUVONkVVeHpWaEh4V1ordEw2VFhOcU1k?=
 =?utf-8?B?Q2tJbmsvQ2hBQnp5d0NPeUdXK1JMaUM1NlhkcTAxWXkrZkZleVRYMzJvYUJI?=
 =?utf-8?B?ek0wU3UyYmtYd2JFdjZEVk1LTWcvTUV6YXJzbXhiUHZwL1N6WFZmckJzV0hq?=
 =?utf-8?B?L1JjVlRSMXNRSHFhMDN0bWwrZ3RqS2tXUWN4cGpYU0paRVNKUUtEUTdkVzJl?=
 =?utf-8?B?aWxwUC8rOTk5WUpyditBYUJEUTlSV2I0K1QvOUhpSTU5VDVTRUZrQ3JGYXU2?=
 =?utf-8?B?QjRQK2lJS2xvSVlzdmNORFR1Nm1oNWprTWozVzZ1RW10K1ZlbmtDVWxNbDF4?=
 =?utf-8?B?eGYvQmF2SWpjY01nV2FJZW5zMS80K2h5aFNGekhyM3c3NVRkNDNwRFNrbjZT?=
 =?utf-8?Q?F70MkF1dsnUHm5EUTEhWXXaaZfX2mULISWN+x1e/l7In?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 89210c78a5c546199717ca83d82238af:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c40fab9d-436f-49fd-987f-08de58ce643e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|35042699022|82310400026|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHp0R3VjdXcxYWxZWGkxd1ZZRnFocnIyeXpzVG1YNUVhSC8wWnh4MlppUDV0?=
 =?utf-8?B?aVNCcHJWK1lRQkVMaG5FTDN3a3JMRmZCMk9lMzdZNlJ1Mm5rcmpTSHJzdGJn?=
 =?utf-8?B?N2JIUGFtZWgzN1NhY3J5NlhvcUx3dlg5YjRkL2dJSmRLSnRHcWpxWldzUUNs?=
 =?utf-8?B?Z09jUGVzSmtFWEJRQmRneGY1YTlBdU1zYitiMkd5d1dEMXJXYlNOckhYbVBp?=
 =?utf-8?B?dWhYS3dVcjYycFJ1UVAwcWwwYXZjc2JYMU0wQlZ2T2tmWGZuNzNXazNuVzBh?=
 =?utf-8?B?czc5QXFZbkNsdXpLRlNveXhoL1k5eVlIR2NWQlNHYVlqL29hWmhISW15SUpi?=
 =?utf-8?B?QU1iclRRNHNmOGRlcGlnZlduUU5WempNM0EwK1Y0ZnlQalBVMW5keVRrbjI5?=
 =?utf-8?B?QnkxNU0vY25Pd3FNQWtTS1lLaE1zMldwbFZDSndRU1cwR253TlFvYk5hc0cr?=
 =?utf-8?B?V2ZMQWJCSlFPVVNPK0dCbFlDTzVIRUlqRHlWZzRkdDhxZFczcFFJSXNsY3JI?=
 =?utf-8?B?Rzc1VldreWVVZXllMjUvTVBTYVl6azlFVzZ1Y01pVisrUVZvREZRUlpGSFl0?=
 =?utf-8?B?TkJHZ2FMekZBeSt2WWlEMWZCSzQ2T2tMUkozSWV0NExZeitDQ3pGa29DdTFi?=
 =?utf-8?B?UWRrdER3dnNxL0pScXJwZFZheTQreTZkRTVMSGJrNkoxaVRJbWczRnRuL0JX?=
 =?utf-8?B?Slg0ckgxWWh5TXNQTmtWTk8wUzcxT1dwQnZCVFBCcEZiRWNiTVBnajJvb3Q4?=
 =?utf-8?B?bUlyWUNTNzE3cG9Lell0dUl3end0RFZFYzgvRm5ONjBuaXAzNnFia3FuOGdx?=
 =?utf-8?B?Ry9FdW9QZFpsYnF0dzR4cmFoOXRsQXpOUTNTdkEydTVoaVBlbm0yS1NUOVJy?=
 =?utf-8?B?YW03SUJqdFI3U3BzODNyN1hOZmVHYkM2M0tLc0k3akVBWXR5WjBRMHJzM0lD?=
 =?utf-8?B?eUw2dDh4QURLV0xlcGZNUjhzb2p2akVCVWRoNFdoREdOaUFhZ2JOWGRsYkNI?=
 =?utf-8?B?Z3BHMG00ZUplR2RKWnNqZWVqY3crVmNCU2hvbzhnTVVGSVh2YncwYXlaaUJv?=
 =?utf-8?B?THBjU0hnSUlqbCs4eG9UM1ZwSlRwVGxDVjJZREZkeFFNaTU2MnZHK3ZzYnc3?=
 =?utf-8?B?V2tmUDVsUU9SQTV3NExDNmI2RXRyTUdZc1lpOHJUYnpQWmN5ZmY4VTQ5aDlp?=
 =?utf-8?B?TCtZQ1FLb3gxRUNVTklrbHlsR1FRRURJZXQyWVF3TFpNczllYkxKUTlvNGlW?=
 =?utf-8?B?YXNsVXdVV004aitCbnBVZnZlODY2b3dyVytMaVBiZ0dwSW1WWFBjWkZsekQ1?=
 =?utf-8?B?Y2dydmJqa1p5bVhsbGppd1RiSXFNZmJzaTgvVi9aQ1V0bFNua1NmQW81bU1X?=
 =?utf-8?B?RzVNR0xCcUlLa2lHR1hIRlhudHl4eHRDMVlWQVRGSEpqc2JrajUrb1hhZHJE?=
 =?utf-8?B?VG9LUUJYeFMweVF3MDVHekVnWlUzS285ZHJpMnc0Zi9GRExNLzl0RDBZMlpQ?=
 =?utf-8?B?QmtiK3dZb002NlRLd1ZuVjZ1V2NpcklSbUtKR2dSV1BHaXhtbVFyME9DdjRK?=
 =?utf-8?B?WjdGZlYwVktHY0pHWmdIMCt6akUydTEvYWVCK0xzazFHZXZOUlVLenVWWW15?=
 =?utf-8?B?NjJvZENCWlE2QlcvWVI0eXkzNmQ2VWFTcHdZcGwydHVwaWh2SGdiNnB0eXNH?=
 =?utf-8?B?R1Q5bEMyR3pyZUNmRkdKcW4rMWYxWlluVkJRSTRpR0JRT2g1OFd6cVE2WjE2?=
 =?utf-8?B?WUlTcmlpVWlTb295TVJBZUM2QjNtYnhMRW00YzBuU0dHemVHVTZKZHZ1TUVq?=
 =?utf-8?B?SGNMdHA5Y1hZQzdHNkF0NXZVclJNazVDZ3VrSHNHMzN4VlNLeDRWOFdLRXRE?=
 =?utf-8?B?Uk5GUjJCQlo2aVZMcGJtZ0Z3dDh5VVMzczEydzdJbTRkSW5EVWRHTmhTV2ts?=
 =?utf-8?B?UFU3M3paQmdmdlNXRDNFUGFqbHM5NjRVaHYzOUtlSFBLc0Z6RHR3YkF0bjNB?=
 =?utf-8?B?NzFrSUJLZjFUQ2o2RFNUNThHdDhnU1NBV0JoN2RGRDdGVmFPMXlrbTVQTTdI?=
 =?utf-8?B?M01iSTJCZW5iYloxcE9DdUhIamY0VzBjWW00em40UG4wdmhGT0FMQXd6TkJB?=
 =?utf-8?B?dEVuV0QrQlhZSVJpT2NuNlNHbjY5Vm13Q1krYnJ6LzBEWER6T2xaaU1YRUtM?=
 =?utf-8?B?OG5tYUpKVWFCNDNpVy9rajJvREJMbE42OWt5KzZ0L09LOFRtbnU5WmluQjhI?=
 =?utf-8?Q?1vLbRCMLTWpZU6LPVRo1m88TdKCka2F3femBl9t/kg=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(35042699022)(82310400026)(14060799003)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:10.6838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d808e40e-c1a3-46fe-946a-08de58ce6a95
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6242-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,glider.be:email,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D959554849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiplexer subsystem has now added helpers for getting managed optional
mux-state.

Switch to the new devm_mux_state_get_optional helper.

This change is only compile-tested.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 81591d247128..2b52e47f247a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -126,16 +126,6 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
-/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
-static inline struct mux_state *
-temp_devm_mux_state_get_optional(struct device *dev, const char *mux_name)
-{
-	if (!of_property_present(dev->of_node, "mux-states"))
-		return NULL;
-
-	return devm_mux_state_get(dev, mux_name);
-}
-
 static struct phy *can_transceiver_phy_xlate(struct device *dev,
 					     const struct of_phandle_args *args)
 {
@@ -183,7 +173,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = temp_devm_mux_state_get_optional(dev, NULL);
+	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0



