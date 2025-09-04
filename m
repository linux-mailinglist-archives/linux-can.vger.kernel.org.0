Return-Path: <linux-can+bounces-4467-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEDEB435EE
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F48D1BC89E8
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E212D12E0;
	Thu,  4 Sep 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1ND2Yc4"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316252D0C95;
	Thu,  4 Sep 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975049; cv=fail; b=QgC2p54RBjoIYQ4N/5EBCbTrODPiNJF2vqh2eCWVdXKX/UqLQCS8scfMSJXIKVpitobVzlWFyHvS3+DHw7bMKKrItPH+NhQKRmvICT8GjdzGD1nIg5jiu2bab0a8GkjIEQvxvdMJSMoEiwWwWMTConuRASShj5XG+S4rejS1tLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975049; c=relaxed/simple;
	bh=FY4pPZ1aDEMyqYllvZTAPBnGkv/MTxPgh/KCOmnd5ew=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qcHsm+UWrA+HSBbnYql53txrvIMJIZbAyVSWPTPVgJ9Y/hSgAPX3Q+yRJrljgZdP4avtyAFoE97rhuoGHxBZ2Ji4RRwApUslMRDDquHtR0jnRlhuRD86CzsjVKge/HJRr5u2Uhgf8T3msSK8LWlnicSz0de3PIIt50/ArNOY7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1ND2Yc4; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHCU7pq1Cw5USI7TFrxYCIcPPvjwCShS8vu4BcNuNt8cxWQDUVw8WTaezJh+diJTAowuhC7b47dKWHLX2eRaKSRTu/hEhOewSdAv3NrEl3DjMDrGnXqG3wimZaH+t4VN3plej0Dpg1oMPQaEUhUDTe6e6iGcZIv9A5eJuga9uTJaM8T0g2zUPBk+bqyiJTIppCNzgFfTyOrO6ruShGLEPIxYVJ8PDRoNR2b0kQdjuRVTaa4fxtdJxwMb+mFQCWD8bNB5Y3ZeNmIwCbfWqdwhvaBLi0p78RxSIvkhHUzd/0/5HHJytCJkBzmh62vSYDve1SE+eUsHwTgcR+0G1sN4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoupLKXdR+Z7rmxKgymA6UFa1Dro42TjvfEoLuUf82Y=;
 b=QEOs29vXUzoijqExfQ8eil2Brz/wsDEZ5TfB4+wpdKLxC5iT44Hs2Uf4Sl3usEgGbiDtdL4hWhS5BMQlvQi1jHnTFYT9sKAY1+Iy1EnW+NdQm0jx9mmdpu/VMX4enFDfUE3DfGIUG5nzObVCuCBTnfHgcjjKSRQMlvN0BPVXO8PEi4QO7a7sc9JVW/T8aGhJuBQYVyEdcIjvsJGPm9Jcp7yCkmaQIKHYdm6BbCH7AKKvj1iJ3PfQuGKlbfY/+JMgzpX/Qn2Rpzum4xvyeamO4i4196zgY8WvIGn+NGpF7FQDFXI2Z2I1nDDMsze9M79uvNx3UBL55F0SnK8spraJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoupLKXdR+Z7rmxKgymA6UFa1Dro42TjvfEoLuUf82Y=;
 b=A1ND2Yc4K3PxaLQOsvuuj2/rJthTP/xTGZ+k+Qs1lJ4wAMkCJWjc+0zZCNTHJNB1Wm6biUWMzCrUrorDolW4SYCt3P5OnoWA3v4MZx0sIXWlESEdmgYG4+diUUq9v+oxNNMQlSOsBBbTYTn7mcrxCQE3hSq9LmeTDrLrJSy8BfQc94MiEVsTc8rs/8JrjjF3K6VZ6PLf2pCqECSLtipuZeFL09h2Eq2a1c/foaZO7I/EgrAWqv8Y1/0L8mGCvdnpFhlWe8uYjaHKYzBnLxs4fF6hcsADrwFGeoNvJjkkZ6Gc+uvl2oOyjBapdRk6iQcF67DAcqJ7Yzija9CUtzlnMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:24 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:46 +0800
Subject: [PATCH v5 3/9] phy: phy-can-transceiver: Add dual channel support
 for TJA1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-3-23d8129b5e5d@nxp.com>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
In-Reply-To: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=5981;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=FY4pPZ1aDEMyqYllvZTAPBnGkv/MTxPgh/KCOmnd5ew=;
 b=i0SuwoIVZ4X6UWJi46UoPDyc37KXEtP6WQliD3tABKFOlHvjdhkoIZ2P4KP6uDln15LmKqKQU
 bflzu2Td8xnCdpjqcQCgmuubrewUXVcqHT08W1ypfx8eKtTQ2FcPtq7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 31deaf64-a81e-4f6b-1b08-08ddeb8e456f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDA1ellDMmZnYzVydCtEdmFiUlkrUWtXb2VTL09XZFA2blFUbzJLV2dZR3h6?=
 =?utf-8?B?ZlVOVTJMLzVJS3RKNlQwZTFvMUhtZHUxRnZmS0hVa2oxQnlDNVQ1YnlKbm8r?=
 =?utf-8?B?SkNid2laV0x4NEFKam1OaEtTZlN2UmdHQ1YvbDRQSFZHOEkvVzA2SzJqaVY4?=
 =?utf-8?B?ZmFtMzhhRlh0Uy95aGF4MEUxRU1XKzJRWm4wZDFsaVh0WURpbUplUXNETGND?=
 =?utf-8?B?bTNYUnJjVEZQbGtMZ3locThYWUFmMXhIc241YkJTdlMzY041MWJiRmlSamV1?=
 =?utf-8?B?ZGMzaExNNzlFSWFKMEJzcWx2cUdFTGZHUUFPZmpXVFNSR3hkeGxGTklKRlY2?=
 =?utf-8?B?T0VZWDlVZzdaNUZzQVNya3BCNjJFc0VEMjlRd0YxRjRHc2ZrYW91K05XVnA3?=
 =?utf-8?B?TEI3NG0yZjRhUlYwcUsxY3djUC9iWVJyQmtTd3FNeTJDRUQ2RGNZVmwwRGIw?=
 =?utf-8?B?NVVZalhjRlhLS3VtNDBGUk5PYWErWlAzNWRFVGFpTTZBc1NLWER5VURSUjZu?=
 =?utf-8?B?bHdnWWJiQnR1UjdVbXVhVkplZHEvdURHS21tNnRYeFo4QmdXckZGWG5jeTZF?=
 =?utf-8?B?Tm9Sb1JVQlRTT29zNU1MZXJhRWdkQXJrN1lMOWNlSS9ZY3o5RXdSalNoeUo2?=
 =?utf-8?B?czhtVTBKUEtLR0p1Zll2ZURYOCtlWi9OSE5KSlJhZnlDbXNuYWpBNXA3eGJs?=
 =?utf-8?B?dHV5aW4zdmhEa1JJR0dSUFJhZXUwV2JSZEs0LzNSRHlKV3N3enYrU1lXRk9a?=
 =?utf-8?B?blc0R09zL2FhUk92bmxidkxmTlhHV1gwVTJhQm1VV0htWXFMM1U5QStRNjlr?=
 =?utf-8?B?VTErQ1llYjNwWEZQMzBWaFZWYk40MzVHVmN1YkZzNzBmaFJsTVBNNHlYTklk?=
 =?utf-8?B?d2JHMVFqSWFGSnJMQ09DejRaTWpFZ2NEVm9ENmR5L0hnd2JRMjVKY1lUaWts?=
 =?utf-8?B?OXhnUitvOHlHUmxhSEEwbjFCU2N6S04yL1hrU0crY2QrZGxOVjQxdGcraXZx?=
 =?utf-8?B?ZW1vUk05ODNDblhDSWs1amUrSTVTMW8rWmgrWnF5WkZrMzJHYkNLY2lmd1lX?=
 =?utf-8?B?K0ttb0FiMWlmYk5RMUU5MWlvM0Nzd0RqZTREelorcjJJVkI4QUp3bnB3aWFD?=
 =?utf-8?B?ejluT0Fka01ZZUsxenpxRVpSK3l4dHdMWEZ4dTJxSFlzUFM4TiswVksyYUZB?=
 =?utf-8?B?Tk40U05Va01reEUwYlg4bTVXc0tjcGt1RmNxQlVyMldaNkE3aHcwU1dLTHor?=
 =?utf-8?B?UE94SXhUWEErR1gzT2poSGYvS3p0REFhb0hNdzd1THZCaXhCVzQ0TDQyQnFI?=
 =?utf-8?B?UkFPY092OHcwVSsvTWZwTEMxcGhmczRTeEx3VmNkbEdTMDFkOW5jV0hBcW9y?=
 =?utf-8?B?b0dkN2l3UUx3bDRkeUdiUnV6UitUdmord0plWFNkVjdUekxDS0hBUmNld290?=
 =?utf-8?B?d3BjZnA4U2VRQjY1cVdDcEdSekIwejhkdnpUWGVrWHlWdk9IZXZlNW02bHhV?=
 =?utf-8?B?ajhGY3V2bDQ4VEhkNkRYcDVZbXNzYmVRQ0MvTDNOQ1BjZUZRSEdOQ1NMWWt2?=
 =?utf-8?B?Y1N5NE1uSmQyTG82SFFRR1JObktiRUpzbkRhcUtvM2lEelk4dDZ3bTFXVjFt?=
 =?utf-8?B?NURYRHR1TVRpcVFQOGpDd001R2xoV0kra2Z2Q3JOSFN6VmEwYVFQUWZHOGps?=
 =?utf-8?B?U2xMUXd1bkd1R3NwcDBLeDhIQlNaRWJBa3FhMTAzbzhOZEwwUkt1QUp5ekZK?=
 =?utf-8?B?ak8xM2xyNDQvWERHVis1QXZscG9Hb1BiL21TM0NZNGxhMllMRWcyT0RsTHFz?=
 =?utf-8?B?VGIvM3FWcDY0M3pIQlhCOTlabHVSK0dEcTBKSGFRQ0NtOGxyQTkwS2NUYlV5?=
 =?utf-8?B?RzAxb3hwajNQckxEMFgwd1g4dDM4SmZmb2ZUWjlvQm5ycmNZVEV0VERpMkoy?=
 =?utf-8?B?cU1ENm41eHJtNnhYMWg3TUh2SWM5SDJlM0VDU1lOODFsYzYzUElUcjhKQXRh?=
 =?utf-8?Q?7jmCXCaL0FoJyfWGGlzAYPyyc0Il9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZENtM1lFL0xPWnl6OWt0anBHR1VxWkVzMHZ1UUF3QmtnTU9tTzZZMnpoR2Zl?=
 =?utf-8?B?d2JiN1BvdHcvMUMvb1IyRHBEUEMzS1YyaEZuNldzTEcwNW5lbzdqWkNBRUpq?=
 =?utf-8?B?c0xIRzhEeHJhdDIzM0JXdWNNcGM5UnRpYXB6bktMTHNYR3Fnb1ZDZkRKSGVG?=
 =?utf-8?B?dVpFUDd4bS9Sc1RBQTJtVUF6SUExdGFnSVJDckFnR2dCbk1JdTZ0TWQzT2Rk?=
 =?utf-8?B?Z1pUd3lZc0VCY0oyd2xYTUtaa0Q3aTdKc2k2RW1aRHpLYnVSZXJpZ2Q3OGdP?=
 =?utf-8?B?dTdUNEIzQ0JHQTl6ZjE1M0Z1ejJaWHM2ZjE2YWlDYlg1UmhJQ0crRkVINGFs?=
 =?utf-8?B?M092OUdQd05GV21YWUV6aUlBTC93U3JPMHJPT2xTN3REZkg0WG81dmU0M0t2?=
 =?utf-8?B?ekE4QlRyYm42TjBzLzNid1JiVG1wbmkzREVGMHI5aFRxUkcvUjZCVmFVYWpl?=
 =?utf-8?B?dDVUbUpubCtpd2oxT01uVjhlSVNEMVdoSVpkZitPZWszckMva25uL1FQZU9G?=
 =?utf-8?B?OU9WL2NxTU9iM0c1OEtKS284cHdjZmxQVzBiWjh6a05WNUhJelJCbnlEWWhi?=
 =?utf-8?B?TU54U0p1MXhCTWZWbjR1SXRVdkVQaXZWM0tac1lxN21sU1VsUnRIZmNjbS9z?=
 =?utf-8?B?MWtvdlFGS1Z3WkZNWHA5eXJRNE5LRnY1bnYveXZ4Z2ZUMjJobHlaSDRHK0R1?=
 =?utf-8?B?SXdDNlIzZnVvRDNTdUJOaEpYWUtqUW5pU00yOGtQT2R5SGIzOUlYYTluWU0w?=
 =?utf-8?B?SkQ2ZHZ1ckRpbHpkU2FNTGR5a2hxaGZrU29iUnZCMUI0elMyY1ZyWTV4blFT?=
 =?utf-8?B?cHhKUmxZL1V6UHhveUhQb3VxUE00alY4RVFKcXJId0t5Y09KTCtvWUdIbXBN?=
 =?utf-8?B?WVRPdmJFMk1DRko3SUpqMWJTL3dzZ3dieDVUWnZON1NMK0xsRlg0cy9UOXBv?=
 =?utf-8?B?Zm8zeFFaME5wUzlJQ052NkhJQVR5NUNvR0dQMnNDM2Z4RXN2N0ZjWjZJdXg0?=
 =?utf-8?B?aXNsU2FZSFpZMjNKUVBJMVpPYmIyYlBsUTBQY2k0UUU5Q0xjaktOaGJTSHE2?=
 =?utf-8?B?SWtVYUZqSitQM0h6TWhOVGdEUFArSExPb1VCaWFzQVZNaDFCZ1Q3SGNadlZO?=
 =?utf-8?B?bVcxcHhUM095Y3pUOFVtR2U5ZTN4TmhsRGVlYjBwUUZDS0hWM0FDUmt2NWNr?=
 =?utf-8?B?djY0SHZwaWRHelZRNUl3N3A3YWs3ekp2VE5mbklicnY3NW1VR1AwWnZmc1g2?=
 =?utf-8?B?NE9IdzYrWXl0L1c4c1ExVkJJaWUzM0NBYkk4UzhGVzB6L0Vnd2pNYlpNNDZp?=
 =?utf-8?B?b3VzaWtnN3JWK1hodjB6UWRVVzVDdEFnVzNIZStzQzRrVU9YNStwRGZkR0sv?=
 =?utf-8?B?NXJPdjBhTjlTK2x4YmRxbjFpVTQyQVh2V05lVGVzTGxVUW5EVGxvT3B5RnFs?=
 =?utf-8?B?SnZqZUZlRVA3L0FJTjhOSk1XaDdJbkFyMXRtSnNEMmR1ZDRHQzlSaTdTeDFt?=
 =?utf-8?B?dWJWQS9CYnhRaXQzZmx5NGd1RGhKNGJLclRzY2FDQTE1dGJnblE4UEN6NDV4?=
 =?utf-8?B?aiswY1U3djVuc0tDZnV1Rkcxc3RTRmo5V1hIaHdMREJmNlFEejd3UVFCMDJC?=
 =?utf-8?B?WDY5N0ZFSUtvYXllVXc0T2R0bWhKQ0s3ZlZBUzQ5MWQzZ3Q5cVB0UEpUcFRo?=
 =?utf-8?B?dFpyT29CTy9XSmZrQjJIN0d0N3VzYUJZdDF6Zi84YkdlVWZkWWV4MUJaN2Fr?=
 =?utf-8?B?N0trMGd3cG1hVDUwODV2NVJTUzRTSkQwdUdLYWluSDBxa1hRQ3hRdnplc09B?=
 =?utf-8?B?ZStDa3Bobk15eU9lNjlJeGVFS0ZacGVUazZwVHA3YTFhM2Vhb0xzZ0ZMVFdr?=
 =?utf-8?B?cjlKS0JNN0FQVC9RdFphcUJJbk5xMlBkYmRqUllhSVJaSXVIMS9OcHJidkRZ?=
 =?utf-8?B?SHBRYUhhVHcxdW9GMGJaWlp0Q0liQndYUVZFSUptRVg0UHVUSDJLK0FLSnV2?=
 =?utf-8?B?ZTBXME41MXFONWJBL0RrN2Nock9YSXdMYzBGTWdJT0NkWUJ6QnFGOERzMDd1?=
 =?utf-8?B?VERGSkZZdURvQ3pybjh1NENERWxLWVJFNmdpMm83UHFBN3I4QkRsUTM1UWlj?=
 =?utf-8?Q?sCpuqW5CBzQsOkfxeCrAEok2s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31deaf64-a81e-4f6b-1b08-08ddeb8e456f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:24.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geQXU2S7KLLusjMbYKtU5XUw4C32UFIkq9aE6GWfuXRl8mY9M4qjGLJ89AJFpiAjoPavjC6FUH0L+J5xXhvyaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

- Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy has two
  channels.
- Alloc a phy for each channel
- Support TJA1048 which is a dual high-speed CAN transceiver with sleep
  mode supported.
- Add can_transceiver_phy_xlate for parsing phy

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 6415c6af0e8414a6cc8d15958a17ee749a3f28e9..f06b1df76ada023f432dce892c3346f45397ab54 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -17,6 +17,7 @@ struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 };
 
 struct can_transceiver_phy {
@@ -29,6 +30,7 @@ struct can_transceiver_phy {
 struct can_transceiver_priv {
 	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
+	int num_ch;
 };
 
 /* Power on function */
@@ -81,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
 };
 
+static const struct can_transceiver_data tja1048_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -90,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "nxp,tja1048",
+		.data = &tja1048_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -108,6 +118,25 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 	return devm_mux_state_get(dev, mux_name);
 }
 
+static struct phy *can_transceiver_phy_xlate(struct device *dev,
+					     const struct of_phandle_args *args)
+{
+	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
+	u32 idx;
+
+	if (priv->num_ch == 1)
+		return priv->can_transceiver_phy[0].generic_phy;
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = args->args[0];
+	if (idx >= priv->num_ch)
+		return ERR_PTR(-EINVAL);
+
+	return priv->can_transceiver_phy[idx].generic_phy;
+}
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -120,7 +149,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err;
+	int num_ch = 1;
+	int err, i;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
@@ -131,7 +161,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
+		num_ch = 2;
+
+	priv->num_ch = num_ch;
+	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
 						 GFP_KERNEL);
 	if (!priv->can_transceiver_phy)
 		return -ENOMEM;
@@ -142,38 +176,43 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	phy = devm_phy_create(dev, dev->of_node,
-			      &can_transceiver_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create can transceiver phy\n");
-		return PTR_ERR(phy);
-	}
-
 	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
 	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
-	phy->attrs.max_link_rate = max_bitrate;
 
-	priv->can_transceiver_phy->generic_phy = phy;
-	priv->can_transceiver_phy->priv = priv;
+	for (i = 0; i < num_ch; i++) {
+		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create can transceiver phy\n");
+			return PTR_ERR(phy);
+		}
 
-	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
-		if (IS_ERR(standby_gpio))
-			return PTR_ERR(standby_gpio);
-		priv->can_transceiver_phy->standby_gpio = standby_gpio;
-	}
+		phy->attrs.max_link_rate = max_bitrate;
 
-	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
-		if (IS_ERR(enable_gpio))
-			return PTR_ERR(enable_gpio);
-		priv->can_transceiver_phy->enable_gpio = enable_gpio;
-	}
+		priv->can_transceiver_phy[i].generic_phy = phy;
+		priv->can_transceiver_phy[i].priv = priv;
 
-	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
+		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
+								     GPIOD_OUT_HIGH);
+			if (IS_ERR(standby_gpio))
+				return PTR_ERR(standby_gpio);
+			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
+		}
+
+		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(enable_gpio))
+				return PTR_ERR(enable_gpio);
+			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
+		}
+
+		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
+				&priv->can_transceiver_phy[i]);
+	}
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }

-- 
2.37.1


