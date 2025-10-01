Return-Path: <linux-can+bounces-5088-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934EBB07D7
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C7E7AD425
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA72F3C0A;
	Wed,  1 Oct 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="es06D76T"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795C2F066A;
	Wed,  1 Oct 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325030; cv=fail; b=Fy6XZd+H9yQO8JZKfvMhdfoYcjgSWrbjS/L+JQV9X3lMwu09OWtEJN3mGSOOH+c55bskwdYmsEmBHKBWpy7k6XUBk8f77NXJw/nfXFa5Gcxo1k0Ds2CF5noUqR1kTzWmLAqUFZ3emkSs8ZdsyBASzmOdNnMi7+M50Ekng64UnnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325030; c=relaxed/simple;
	bh=ase2+k8pd8bzXXxQYGyQM6ABcB9QXMPnzHXCEiCcOrQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GgImtdu99DatxPycS7DD+T3zGTbfQ18WZgKFbUoAlXuHHu8ibBCyb2FuCUn2xtzNVWx+f3Nfpc5Oe8p3bgvrNEZHJ35bC2TEKqLj2paV16gPM5mTgHQppwz/mPk0r+U54RxWV64vLRRDh8NrShB+zzfRVknBfzTGItrQlf858Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=es06D76T; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLVXlR5NdLAvUUh0RJ/10pYn7P2ObYUPkTk/GuJUwLtrqfJqMKtR6tJyAZ6VZRtNoG3Bmb0bkbN2f4LAEEp1xVP7Ca+K5GwoQAJT8nVAfhEb71P1WmvixQ2LtmEVl4UyP0z/40IFaoQj5Rl/Q8+czNqzWLJBUo9cMCbK2kc9IHZ05NbbyMzPUJwmV43OlJZJC5UtHwd8Sn7LYEjl87Mv1LKTHJm7OpzfKWR11sIh+q++3g/NxXRAWmAvSTUfaTrweKHO+GmxO9f4kBDveZ0x5FucMS6CkABL5OaHDK2NzN6etpj2B1L7ejFfHLVG0urxGSZCqLrMbYBagvdpyD6QAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz8I7gIK5sl0eeM4Ngr5WcnwD840cIJ43e1bzsbE67U=;
 b=q2+vCpSt0y18TZRUncoTZ6GyMAI6sd3VM9YKg+e88yhOKsIsM/Re8q2qVGXX/HcsYTTBqfIGMPWObyHuEX4dsB8RQM4PVexbOvWV6zmsrxhcdLsrMZdB9DyFQuInMz3zim44BScmG06qNa4TsAuS4OIjEgjFuAjnEBK1z9J6SHjCMlrdE0GlE9oh2N+H52+j+Hu6NTI7tCmIDyAgkHV3gwCN89zHcyirte4xlqZFh/XInwmzMfRN+e2X/ysybMloFKreSc286UPHpURh3eQiUrppwXPd917pIC9pXCXDWOfcKgLOKE4ssPngz077GVd6K7icujErJl5cUdVZBB0tBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz8I7gIK5sl0eeM4Ngr5WcnwD840cIJ43e1bzsbE67U=;
 b=es06D76Tkqn/OKG7gOcecKD1FZiK6lE068DK3BqxAt/edTD2WalOPjazsYWCd/COtTguPVumgzeqRirn8u9/qEYU7QnI4Y9EyeXlhGHEN3wySHbA2mBxW+tKj+M26yEULBrUlDVhSusKd0jHEb3thQLapM1soC79JQZVn9WywaIsmj12VoXGhMpIXPrH9Yyi/PgoX1cOtzZcKV734zsXE92ZrhBq4BMZ7DRkKAHkNyES6tXLZ4jWYA88pw1ZzmzvXWbTCC/IAVAgHR7cpoHKu+Ojn1hlTDvqSKFsrULYI8Q2wJ9G+2HiyAGyqvjcTuqjxNd/sKzT9YIh6pNfgL/fag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Wed, 1 Oct
 2025 13:23:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:43 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:39 +0800
Subject: [PATCH v7 8/8] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-8-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=1697;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ase2+k8pd8bzXXxQYGyQM6ABcB9QXMPnzHXCEiCcOrQ=;
 b=ZM2M4ECMFHi67Dsh1ZUHnW3Ku6btmr4Bxxm2FenLbLR5OD3Lf+g8Nu8BG1LIOtg6rtqN4p+Ev
 7IYaR6h9qu1D93RlvkZY4D1VDZz70ahLWjJpVecGV0uIQwKDgD3Kr8r
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10102:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c017cc-e342-43e0-3d55-08de00edbe1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDBtbXJVSm5JRHZSOWVaRTVZMytZMHFkL0YrRHBwdkR5d2VGYi8xUjVpOUk3?=
 =?utf-8?B?cEhCSzlnUzhUMXJvaCsvdTV0cy9QZGVUYnVZd2hMNmV2UktmcVhyQmUwbmVK?=
 =?utf-8?B?VDRudDJUdUdveWUvNlMwUlZHVysrdkRnUVpKSVN6c3p3bllqcU9qUE1aOEhk?=
 =?utf-8?B?RmxHK0l2dk9EV2JsM3g4bFBzaGQrUXl4Y0RwcUVpbDF6YXFJanZ0MVBXcWZH?=
 =?utf-8?B?cjlTTEJSOXExY1VsSHY5anhpQTlJOUhCcjFNZGFLSlMwZW5LdXVjMCtvRSto?=
 =?utf-8?B?eGpyb1hLK2wySlNpeDFiakluS2FHMkR5QkpTVFVrVXRpUXhhalZQNWxUdUhC?=
 =?utf-8?B?SWRtRUF2VUxrK3pVeXF1NnQ5TUlKd3dSL0daVmZJbFFNck1zMTJSNXJjQmNq?=
 =?utf-8?B?SDlFWVZMd0YzWWNsRGY2c042SmsvK0p0SEIwR0U2QTRiOWg4MjNLOHVpVkUz?=
 =?utf-8?B?NFR1N1lDem1YMWZuQVYrR0Nvc1h0aThSN3FxcWw0c3BzcDZqMitYdnd3ZWtt?=
 =?utf-8?B?ajFpRDZwVHhiRXlGOWpZanlnWTRoTzBVVDlVVjlMUkZrQXJjaGF1bWEvbWdm?=
 =?utf-8?B?MGRJMk5ramgxTDhoUHFYeFNwK3ljTDFLdUlFSnFUaUpBWmZSaEdpRUxIWm1Y?=
 =?utf-8?B?OHBzaDFsbXZPdGpkTDFWTzAzd2s2MXdqYTdZaEJveUlVWUJZemdUWTRIN1NO?=
 =?utf-8?B?RmxPMkh0RHFIZGNJNm1RS096U29iSkRtRDc0TWtidmlXNlVhUUVSemlhbVpJ?=
 =?utf-8?B?UUJacnBVblU3bjVua0dLSFcxd3hZNmVUT012OFVYZmNkREJTK210VXpscCti?=
 =?utf-8?B?Uys2VFRWK3FsVDJlYmxxYUY3WDdzNDVCMm1uWjRCTHJnVVV0b0FPeUVFelNq?=
 =?utf-8?B?NjdpLzQxRDZlb0xmOHdYTjhXazdGYW54elkyaUg3YlVaVGwwL2V1MENBZDU2?=
 =?utf-8?B?MUtUeDYxR1Q0N1hSckYwQkg1dFpnOHdVVFFhTmU3eTVodEhCaEhPU0NKd3Vr?=
 =?utf-8?B?VXY2dnc1NHByN3huVGw4aVBMN1JsTFRaeFBrRTVjNFZsTlAycENKUnB1WTMz?=
 =?utf-8?B?N3NmekJhOEVRQU5YVzV2Ti9UTStEcFR6Wm9TUmdkeW9ub3Fob1Bja1FZTEZV?=
 =?utf-8?B?TndyKy9EVVlwcys3Ym4wUmZiVUtxQWpBaGtyL1BROXRiM2VEbDJwNjBQcVpH?=
 =?utf-8?B?RkJyMlNTTDBqUlZvZkp3ald0bXp0dnVvOE9zcmVwU015NDUwMGdhUEZXbVVt?=
 =?utf-8?B?NlloMnpCSGR0UEhoSlVJejNyRlJsajFYeW52a092N0h0bmlRbTRRb3JnWSsx?=
 =?utf-8?B?dFpFUWlqdThVMVd2b2hjNWJUMWRHbFQzbTJ3Y1VPSFltTFgwU3NnNUZLcmtR?=
 =?utf-8?B?OC80dW9Gb2hvNkdhZ2lGbXNYY0h4Qy9QNlR5NldPRnZxRk9rM3N4UGsrQ1hH?=
 =?utf-8?B?OGNVTDJtNjlGSzAreG40ME1VNmwxSkV3azdmZnJlMDNNQjlvNjR4VTFNQjRl?=
 =?utf-8?B?NFpLVjZhNkVyNFBKM0dIaTZ0bTBIbFQvRUt1YUtIVjlVNytIZTY4MHNadmE4?=
 =?utf-8?B?aWQxQ2MycGQxbHlPTmhXL1RiUWdpMGFDa0JiMUYyMVZVQkZlQ1dFQUtXNkEv?=
 =?utf-8?B?YW5YS3pVYXhWRHJJZWozdzJsUitHTlpHRHgyVHE5NnBoOUpYbUl4cTBIS2RX?=
 =?utf-8?B?S0xQNTFQRnVmRFBna3VibXU1Uks1cVptTVVINlFjU2Jka0VIRjlKSi9lVWdL?=
 =?utf-8?B?WXRiRmxwUndJNmlWajdnQWtBcVJ1dzJJTVNVajhvdnB6QnVWcHluVnZCU1dv?=
 =?utf-8?B?YkRORytZWDNHRHREUnJpZ09oNnViOWRXZDR2ZWY4aVlQZ2tac0FvL0Vocmxh?=
 =?utf-8?B?eWpCSkNtWnNYTzAzREl4b2lwdFVhbTVyK0pMdUF6MElCWGpoUlJwYm5mbXZ4?=
 =?utf-8?B?MUlHbk5Wc0NLVWM4NjRDdStsNElLa0MzMThoakEydEV1QVhSZW9rV01MbC9F?=
 =?utf-8?B?V0ZqK051L2trazBSSzJOL0FCTkJwWlQyVnFCbTd0ZmY4MG5VL1VzM1d4R3I5?=
 =?utf-8?B?dVZwK1dNUVR5YnJTWVFBQ2NBV1RBdmxxOFIrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHV2UWdMaHpaQWI0akorc0RmdjByMnJYVENvMGZ3TEhiTkxMMjRtQ1BFSktQ?=
 =?utf-8?B?aU8vTkgyWHh4TEtNQUlFM04rZzFpTm53RkJyN2VkZkE2dWhLZU03NnNvZnV1?=
 =?utf-8?B?UUYxa29FOTE3aEU3S2RqUlBlVnVaSEFZMkhvSDZ1dnp4M3JTYmh2S01BQzJT?=
 =?utf-8?B?Tkd6NEd1c0xMSXp1MFluZGpEUVZBcjRGVmxZR3FoU2pWTUlWOWp5UmUzVkxq?=
 =?utf-8?B?MjdIM055WS9qc3g2c1FpWmQ4Z2dzVER2NlUrcnNqb1lKaVpyM0ZYUWpmMFAr?=
 =?utf-8?B?NE14ZmtMYlhQeHkwQ3FmVHhSYzNHY1BoZW5WOUZGZlJ5TkFYT1ZSZUowbHdQ?=
 =?utf-8?B?NDhPemZHaytBNXUrVis3ZUh1YkVDOTFRNFlaUFMybnhIdXYzVm9OSEMwOW1s?=
 =?utf-8?B?d1FYdFUwVjU5VFBHckUrWHMvSTZ0Uno5M1FoMnJBSmY2Qnh4aU95bW1WSEN4?=
 =?utf-8?B?N0haMmJqdHRtT1o2UFZpRWQvc2hqSHFmQ29QdkpQMHd2OENFR0NrOUF2QW1M?=
 =?utf-8?B?Y2krckwyRmVlN2ozL01sTXpiQkw4OGhlZ1pRMnRrUTg0b0h0Zi81c0RYNmdC?=
 =?utf-8?B?UFFxOHhHRmZ6SVZrTWp5UHIzbGVsam1RUmo3U0FqOGNlS2RDWVAyZGdVRXpt?=
 =?utf-8?B?enNmalJFVUdNMDNYQjVYZnlmVFpzQ1pMaE53YVJSTGp6V2x6NUFvSHA5dXlq?=
 =?utf-8?B?Tm9PNWRjZytleUUxRmY2M0JNbUJ5b1M5NjVmRm9OakJWa05yam1pYjh1UTFv?=
 =?utf-8?B?MGtXaEx2QldLc01oQ0hDSHhaakswbzJtTXlWTDBXUnpiYk1ZRlh0T05iWmM0?=
 =?utf-8?B?b0EzSTVTNVAyM3JTZGo0aVhEUDFhL0Z6Q2RKVmFXREZDczMxUk5hZTdiMTk3?=
 =?utf-8?B?ZEJTUnE1MHZEK0FvYWwyeFRWbm9TYmo3M2hvNUlsaDdHcWIzK3JmcHNYbFd1?=
 =?utf-8?B?bm5GNU5lRThuTGErN05sKzJLbU9HTzVXOVNhOTVvWkpaNHpUbm9xU3N2alBL?=
 =?utf-8?B?cFE5THdKN0hPdE82S01ESWxLUi9rT29VTjBObFh3RlEzak9URjhZYTJJTGs4?=
 =?utf-8?B?SjdYMHhIdjBQdUVJVURiU3JTd3AwRDdabTkwcDQrUllvbUZqQVNtV0pJKzlT?=
 =?utf-8?B?a2oycVpmQXhOcFF3OU5qN2dCOGw2YVhIdklEbHdoZGRuc2hkTTVRZWVHdStq?=
 =?utf-8?B?K2dWR0NmcURYRXorMzBjL0xMSWdSSTJ2OXdaK0lIbUg4c2plb2pWOURPRlhX?=
 =?utf-8?B?RUw0c09BRmcvRzlXbGplaXRZN1ZSeWtWY05weDl1cnNFL3BwNkdibC95eFRw?=
 =?utf-8?B?aWh1NjdFSTlrWkNQSXJteWp2K29hQnhaN0ppN1R2UXoxT2dkd3ZFY1BHNENT?=
 =?utf-8?B?aXFDam9SZUtNVDJuMXZoV3pCZzY2SmttWW5UanVEMXhNRlpsQWVwUjFvR1FW?=
 =?utf-8?B?Y0RYK2VjcStsOTZacDFFWDBOM3ZHNGRUQ1ZWeHVVcklJclJIK0dXUHRMd3R1?=
 =?utf-8?B?SW1kaDc3SlZ4ejNqYm53Z3V2VEpqOTlCYnkwRXE4VWtaV2tkMTU1RHFaVGVa?=
 =?utf-8?B?MlBObExvMm84dVBFRU5oWHRYZmRyYjZER2paUVZaNit4RnFUWEprcEdmdzhm?=
 =?utf-8?B?MkdJaUNWcDczTGlONDMyRGZ4KzA4NDh5NUlsY05yUTJVMDB2c3hNTDZjT0Vo?=
 =?utf-8?B?Z25UVlpyYVV2SThkZWtFZjB5TWFwWm9RTEYraE9DbnZzcGdhNlhWTktnRExB?=
 =?utf-8?B?Yzd3dDFqMUYrS3dBaTVDVnl3VUF3N1ZnRVV3NC9RTmYxc1JESDAzdGRBTm1h?=
 =?utf-8?B?cWxBbTVDSVV1VTg2RTFZdzc4M0JuY1lrbGhLZjNDOHQybEcyRW5zTitJbFlm?=
 =?utf-8?B?WVZ6ZlhydHd5ekVsVWFhTG5KQ3RzTWRsazhzam1yc3dpWjliU3ovT0grTEFW?=
 =?utf-8?B?WVhoa25hRER5SWdSZzlVOXpTbzNKU0RtdHJHZlA4Um9TYTNKT05yd0MxOSt3?=
 =?utf-8?B?U2t1MzRuV1hFVUFvSmgydU1DeHdkOXd3eG1HNzErai9LNG13UkcrRW5vdUNr?=
 =?utf-8?B?cEFzcnJ0WFBWdDE3Y3RoWXA2LzRZWkcwYlJ2ZWlRdW9lMW1DTnJyRE0zd2Q1?=
 =?utf-8?Q?F9etqZoXS71FKuSXP1j3L8U2C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c017cc-e342-43e0-3d55-08de00edbe1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:43.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArLzBwZ2kiuNtxHXOy1iG6k3futyLlyC0m1YNlEgRibcwmbGxFg+rzMLG1jJ4Scjlwh6f6WtGMc0ytQ+swdRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10102

The TJA1057 used on i.MX93 EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index b94a24193e199b266943c58466f4f620e81480ba..8dd5340e8141f44913be8167e85337f179f5edbf 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -81,6 +81,13 @@ vdevbuffer: vdevbuffer@a4020000 {
 
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1057";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		silent-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_vdd_12v: regulator-vdd-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_12V";
@@ -106,14 +113,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can2_standby: regulator-can2-standby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
-	};
-
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -302,7 +301,7 @@ ethphy2: ethernet-phy@2 {
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_standby>;
+	phys = <&flexcan_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


