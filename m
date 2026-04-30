Return-Path: <linux-can+bounces-7431-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PzFEQo482lgygEAu9opvQ
	(envelope-from <linux-can+bounces-7431-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:07:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C664A15B3
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 940463014A09
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4A3F7A95;
	Thu, 30 Apr 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y73JJvgC"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DE3E51C4;
	Thu, 30 Apr 2026 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547228; cv=fail; b=hzheWMVHKz1D9viHSJBMpawTAOYMOxXANBGQoWFZySoQdOiu6GFznenlqskT4pNDbVzka9rRJg5XUMBTi1pPTTRl9xQQd3odcgd+nGTCmfWzGCVnBFawseTpADqnwk089CcvyMaPsDSdfpqPMvPqx6fIlQgnLKcy3DRWnmASfIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547228; c=relaxed/simple;
	bh=T35Kbj574lMj5j3cBJFxvQ8isadTNnSjUUhqcZ8Qv28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRFVXqzhlsgE9VwWDHDCzU4d/hoHEbtkcAp0y4chlQkZMOaRm86/hZB7CV9Ri+uv4ghmt8DTjBONPTmjnzY0Ftc78la036l9BDo8b5pB71pDOXstascbUlqw63dz14rGwEBEi7x5cKYLm6oBdOJHK0UznPKzq1yxqWdN3Buk/9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y73JJvgC; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4h1iu6mlekwyHXT6VK6SfSSwbY435VARL42Zc2ea3Pji0HjM4KBVO5K5sl8v4lsx5je6iXF5ayrG/w7Y2AodRnK6Z0ceKb407mziAv3aDfboL0ip2DEtUtdS5lBfdqXtjkzwaScCqgAf/Sy+lnmA0Wy0Hvb8JCgpdr/qtltZmoYZ8ynBd7SERIdKodKxf2NF41GN4PGcOyt65YJyqJo6ia46JftNA6nJLAHgMFas2kkv3GNdHv3TBWd+LED2DZYQ4IwWyBucVK3sAEczZY6qex+fIRawMOWHJW5iZHMeXVidzwFy/xD115ykevFNbD74+v1qoe+1r88CvzxTG/dGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVauDuVwmD+ZQKnIuah022QgJoygjPauUp0xZSKihRM=;
 b=XIB/VIccm/C/p6iDrBH48TCsVyYBGaHshcOYkfTXhr8QOWFoqTbCdaaaQTn9umRcwTCDxMsxNK6N1VZeopG0EcFCmDvlzPQBAAeQ4aS5/lsTGlo9pZ6QsN/0uRc8Mco12hHxR8HnQod6gUTkwgzPLB6nm9N2FqCuOzrK3rqcgtAHi+TqMf7/sJ2X+rfkZS8WtbjeMxdNmoVw7jPTPYBl6kSX1/WSCDbHj1PxkSUK8+FzITaXGLGBRHBHUdUFJBaU651xtT0VSL4KWnE1jCS87QXz2Z7mzxqqLfoKO4XiLsWRSZKAC6hjoqBEIahPOGo7mtxgZ3OFf65gSUydh02obQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVauDuVwmD+ZQKnIuah022QgJoygjPauUp0xZSKihRM=;
 b=Y73JJvgCtUsDcqBoFPzd/2FVR9Vy+Yf2Z08INX3MWrvyiC8YOQ3QrhyQv+cvax/+atKRZwe9AlTJVlt01NPtS7UywABcIz/FzXVuP3BkKf3CqB1rFdMjSdldfbA/hGaPzkLCgOQ4eYF4dlYTjpSyGvBJpH+wB6D3+H5hLK7yjklJlLR7+jEkk8+gU9FZbyg1b9rHHc/VPX7+ivruREJtNqVhNBCOHlDHZIZRVQEpSL+8kseX59w/LG4suCAxJuxEI0Kn9hqYZqCEb2omf/NEd6lnGCey3TiOx3KzsHhIbJyRRhKt8HU5FFxG7ObI+HLXVHhoIAkRTXbFBq61TBKy2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10609.eurprd04.prod.outlook.com (2603:10a6:150:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:06:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:06:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Yixun Lan <dlan@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: [PATCH v7 phy-next 02/27] PCI: Add missing headers transitively included by <linux/phy/phy.h>
Date: Thu, 30 Apr 2026 14:06:27 +0300
Message-Id: <20260430110652.558622-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::6) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 8840f344-7489-43b9-91e1-08dea6a89982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qw63ik/bkJrbuaXQWl8NJQXPoAy0OBaG3g1K7RMoaJYPSMJVm8iES+vWgZLG5bwawnNkDFcS+Md8l1+Qkb9x9bdm5hmCCHE73P4xNz1uLFrEFZJpKf4hcsnxT5yZxvnTyY68usbo7DWL2E0SyaqZyc4sYv6CLKGHwpvfNiHOlj/H7egnnyoGPdIZl9Kn1tP4TugYbGx0THTsWlWg8t3OvoGGltfjczu26XY4IM2tmq/LVLsPuiVMNQLLfKk45lOGCOmLtVEGr9/U5bSKYMkqsiHZnSwivORzwoBjFFNGCn2lf1lRnof7yAdHS0719HOlKT2bzyAkke7WKh8GDIg7ZdEfclDqmZytIq8c6IW9CZ3JLecmKPdHy2gimHVFxJnOReykHMhBHS9T9JPwJm/AUWd6kk4n3RzO/dtqaj9u0efyqsU+5RRJEJ9r5WlaIwjZQFuLhy8Eef5vfwowW/gnf+2Asyqux5/mk/xn44uNE/R7mXls8Tp/F9TAEOIeXlG2DjD/y6wL2ZTq215du9Hr+tbYhbx4+by4CXPs9Gx4qKPjHpaer4ku6EzlMU2Es5bhB2c7S3tw/qjsEeSs2i3EJhk8HOEv9rXNdi5HePgkepcsLEbd/WCsjJS9SlJzlfEIWwrmsxgRv0Wd0EJkbazfBNxsJb0CEDcnrdrHF9wRgaIf/pu79HoizGjijP+WDcrn/iRGtO8mJAqAd0+yCj8yVf6kuH2rDXlftUEklLEFJfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNuMUFjODBpcTBOcGdhbCt4Umd3NEphUXpJWnVlKzA3YnUvK1U4N2JIb001?=
 =?utf-8?B?UzJaM1NKNzR0dFpyMndhSGVFcytsb2R0TVlZLzZ4by9oLzFoakZLRkp2dWQ2?=
 =?utf-8?B?dDlGcWo4UEZaVVpYY0Y5RmNxMGpDL1NiOXNvWHpnSGpSV1BLU2F2SzI3QTVy?=
 =?utf-8?B?Ym1qeG9FdTlJZmpiaUcwKy9nbllyN21lVWZZOGNKWWVXWS9GdjFaRGlvbDNz?=
 =?utf-8?B?eWd1Rjk3K09zcTdTMWVKcnZFZXg2SHhFeXVlZHQyenovN2tubkp2Z3Zmcncx?=
 =?utf-8?B?UXdmc2ZiOHZSL3dkYzJZRlNocWg2cncxQ0FpOEFJOFA1bkoxeGo0MXltNmMr?=
 =?utf-8?B?b2tNN01NdG9CVVZubjBvZ3JDSWdTeVFzUmI2TFNEdFF1NmR3bnpHOUJYZjRn?=
 =?utf-8?B?ZFhmMFJCV3ZqS203bzkxNk1qUVk0ankrSk1HTHE3eHdHYmtlZ3ZwM2Q5Nmx6?=
 =?utf-8?B?Y255Q0JZb0VYOUpSam1mcWZaR0h4aFZ0YUNUWWlyZWpZUVh6SWxBbWxadzl1?=
 =?utf-8?B?RnNoMkRNNjd4QzdEdUVTb2RJSWxnRUN6RTVqQ25tN05oWVhRbG1MV29qb0ds?=
 =?utf-8?B?bWRsNlQzY1VzQURsMFlwdWlEbGpzODZGbFoxbnV3azI1TVYvbUdwU0s2NTVs?=
 =?utf-8?B?dVU1QkFIYjlpclFYL0VWQXhYaDVOKzl6Nm1PRDVSeEhMbXdsMWVremkrUGdz?=
 =?utf-8?B?dXNqcnIyclMyMlhLeVVPenNvczVFZUFMZkQzNDBuSkltYXdRVHJtdTQrUE10?=
 =?utf-8?B?WVFKZnJiY0VJYkdNQXBlY21FSUN2SWtJSStock9QWFpYMnk5bkZZTEppVGpa?=
 =?utf-8?B?YzY5L0ErNWphTU1uY1A3V29aaHJTVVFpdUd0c25VczVhRlp0cUIySi9wY3NY?=
 =?utf-8?B?K0JFRTlwSFdxNGJyNUMyRnU3ZDZrWmwraXVMYlRqSUcxbkF3dUt4d0R6SU9C?=
 =?utf-8?B?Nkp3V2x4aCtScE50K0Y0WWxJY2hmZVJXdUYwVGtoTDl1SzVIRFdKRHhzc1My?=
 =?utf-8?B?YzZhRkFlY1Y4aDlsbStOcjNWS25GK3Y2Wmk5K0ovNVR1OUFMT2hVNUZ6c2xN?=
 =?utf-8?B?SC9LRGt5V1kxWHlkTVZwVzRDeTFSWk4wVjJsUGNxSVNMOVBPWVgrdXZIbDMx?=
 =?utf-8?B?QlhMdUR2ODVEZEpOaEhFL3l2SVJCTmpJWGZqZjlNN1ViMjFXblBpQmFXWnJP?=
 =?utf-8?B?UUJDc0NPelRuY2ZlK1dPUWgwcE5acERHbEhQWnJIamxWMUovZWJjSy9GVGsx?=
 =?utf-8?B?U3hBNkpyeDljUm5TZTE3eXF6dkNnQXdJVm14Yk9RVWZ0VStOWWFXOERwTlZv?=
 =?utf-8?B?eTg3VmNyNFI1SGw0RzIrMWlOWHg0NUJTbWxqOXBnYlprZDlXQTIyNDl3UHB0?=
 =?utf-8?B?Sk5YTTdRanFGd29kR1JpMjlISGVHbThyMVhVNE1jZHgwTEJna0xUbVVwWWdY?=
 =?utf-8?B?Yk1WaEUzNUllYzhZUE16VFdJWVhmY0hQRVd5V29JaFFmZDVka1pZbklZVTRy?=
 =?utf-8?B?bHdHTWRDOHczVVVTTDkxRldQQ3lIZU5hTThOUGVLUWlvZy84dlV6SW1obngv?=
 =?utf-8?B?bzZuT252M1lPbDhTY0JwRy92NmFNWjlpUzlOL1Z2YXppcEFnOWROU3VYUkV5?=
 =?utf-8?B?azVIUURqZFpqdFZNS2lqbGFVZUNKVkg1Z0JlQ3FOOGVic2pvaE5weGMxa1dD?=
 =?utf-8?B?dHloWmErNS93MHpsTlNnMjRtVkVGODdNcFhHM2kwY3BlVVZYRC9EVnJ1dTVm?=
 =?utf-8?B?K1ZlbklzR1lwRVUxaGpHUkZOTjlHWmNOV0I1MmNKS3VwZXpDUVEwM1FaUDQz?=
 =?utf-8?B?aFhYZm5Ta2gyZ0VBaGtmcGFmeWN3ZnR0VkgwdWhFZGNCSm9kUWdLY3RVWmxv?=
 =?utf-8?B?c3FHaUF1L1N2bjh5WnhJTHorS1VHeHZWTEc5SFkvSmozVXp0c1E3aWpIU25Q?=
 =?utf-8?B?WDZIRkZiMTdUNzlObHYvYUtHTXlWaDR0QnQ5dVY2dTF3TFB5MWRRdHdDWlU3?=
 =?utf-8?B?Vi9YSzRsYkdKRytvaHUrRVB2UDQzUENDNVNDMXlBN1QvV3lxUjhsU0xxVytt?=
 =?utf-8?B?aysrMnB1RUFITmxiTzNkZzM2WXVzcDVIOVR6RXl1UWJhMy9qUDNvcktPWjdk?=
 =?utf-8?B?NjVGbk9GMjBJRUdjUEQzRkV3aU82NURaSUFWUDEzSTltTTFoeWRDalhLNktu?=
 =?utf-8?B?M1lDcGtncXo1S2Vxc3FhV3NndXJ0eFFaVS9EN3JqbG9OVktlZFFqU2V3QlpM?=
 =?utf-8?B?UFFMUTVuNm1UMzdKL3N6VXpuSHpDMFQ3T3Znb0ZiY084cGJIMVZnaCtmdVFi?=
 =?utf-8?B?TXlVRTNNUFBHazFDLzNNTUJjSDRmTFdzWGNHdEtOeHozTFo2MVhyL2djYUJR?=
 =?utf-8?Q?6IOY+uXwK2V8Wg+ammkYaB7ZHxJUfZDZT/XDA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8840f344-7489-43b9-91e1-08dea6a89982
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:06:59.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrlFdvl2koy2/GNIsgYz1DuxIRFijPZNE/YhRgRkcMiQxG8Cm2s3eOyxmMLn9TEaruRe/J1IPq4XgsNV+DyBBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10609
X-Rspamd-Queue-Id: 02C664A15B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,google.com,sntech.de,gmail.com,nvidia.com,rock-chips.com,starfivetech.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7431-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]

The tegra as well as a few dwc PCI controller drivers uses PM runtime
operations without including the required <linux/pm_runtime.h> header.

Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
controllers use the regulator consumer API without including
<linux/regulator/consumer.h>.

pcie-spacemit-k1.c uses of_get_next_available_child() and of_node_put()
without including <linux/of.h>.

It seems these function prototypes were indirectly provided by
<linux/phy/phy.h>, mostly by mistake (none of the functions it exports
need it).

Before the PHY header can drop the unnecessary includes, make sure the
PCI controller drivers include what they use.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>

v5->v7: none
v4->v5: fix pcie-spacemit-k1 driver, previously missed due to limited
        build coverage
v2->v4: none
v1->v2: collect tag, adjust commit title
---
 drivers/pci/controller/dwc/pci-keystone.c     | 1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 drivers/pci/controller/dwc/pcie-histb.c       | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 3 +++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 1 +
 drivers/pci/controller/pci-tegra.c            | 1 +
 drivers/pci/controller/pcie-rockchip-host.c   | 1 +
 drivers/pci/controller/plda/pcie-starfive.c   | 1 +
 9 files changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 278d2dba1db0..fe4836925c4e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 731d93663cca..ae27ce05247c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/workqueue.h>
 #include <trace/events/pci_controller.h>
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index a52071589377..432a54c5bfce 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/reset.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 257c2bcb5f76..35a297923e7f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/module.h>
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..41316aa54106 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -13,9 +13,12 @@
 #include <linux/gfp.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9dcfa194050e..f1d08814a73c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 512309763d1f..a2c1662b6e81 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..46adb4582fcc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "../pci.h"
 #include "pcie-rockchip.h"
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..22344cca167b 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include "../../pci.h"
 
-- 
2.34.1


