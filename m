Return-Path: <linux-can+bounces-7170-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMfKA4J6vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7170-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:36:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E52D33F6
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9188B303843B
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F840710F;
	Thu, 19 Mar 2026 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QZHyfwlW"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFB407571;
	Thu, 19 Mar 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959586; cv=fail; b=T/WkZ0cPhjjlogWRubQ9Pn2JUzTwvntnh/lVLj4e5xAhdMHCk3oFAe7r2OeO3FPO6w6ydfrd0lTctM3j4bt97ggPC1syDJkmwRAkJE/wH3azihwoII47GzAjs6XV9B/KL00AoOYfdikFpHdVvSzCdpHN31+CjkeNNAu9U0M1Rbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959586; c=relaxed/simple;
	bh=vvqbgRQb8LMkmNBDH4BPHipoabUfECnj7UBwChAKprA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvnpNdCez0J55fn/ayYY3ccBP2rJYob8SJi8HlBDqVpN2qG11WRsj4IDVaK77ntOScWYnUIEpeq2vop884T1655uihqok619dSXPXv+iftbiAmFJ1GwDxofQBSyvHmLXxjlyRAwOuz3Gp+vT91HPyFbgcJfHPyL3p1QL3Tftris=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QZHyfwlW; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzUqfJoOPecluXkeAcvX/AeTGcvgsXKk8Nbquw+vwkd656mb/saXJ9zeBUpXB4khGgbnqhQyjVNMyuBK0QnCNMQU0Q5MxLpYDem3GDP6JFOGs9q6li04EgIst9hE70S3ySnHjRS4jJ68RwUXF8aDppTLizfALKRR4PKJecsUsB/FwMJm7TJSIYcyt/ZaT61VJCr1taUV/UqaImxcK1Yr40a/jyAn0tpGGxnPWnj2VnBUIyavx4VgHmctdURai2t1a5vbecpP0TJ5N3u350bl8SFLCDvp+GnRcNQzDfMugFthxha8JNwWBB3RRB+3AfZgahLXKVr5xEKifUa2dSTC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLJqBnYouQqh5qS2S5ADGrJeTBgpFcRUJT3ZIejU24A=;
 b=kfMWCqRJJs8uRBJwOskxxr5T8z0WnVIQ36WlbgykbWsWUQrBr3WCj4qLrEDgPQ3OtrvYy4+oZStieFhqIXHpMMTb3T2QFoqYjbafs2VArTlUdcQ+cTbKqBz1PxWdWuGtDnv1ZHioAF+ot+Jf5L2mkWXQNdMU/pQCK+G/HvhE5DpIisho4b1aQRLJqbHE+hEgLp4BgINjja8DnndcTX6lj2MaE421t66J/Qz0v6mzD5dPlyRSEwf3gZu3FAzHc6ti/9rgl3zkEzODts152RjHNHbUEgrX1Cg3tA3778YU3dJ6jIUGaq9l5bHQRIIzbq83V+OEsQLPig+Rol9hRXI1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLJqBnYouQqh5qS2S5ADGrJeTBgpFcRUJT3ZIejU24A=;
 b=QZHyfwlW5qPdaUdMw+akkGTURzHV6gk32NNVRiyUJrLBFIZ0NXn/apnlJuWvxDlO0+85k0uu30jdFCSY12cUtAh7IZLtTGG8AlrmCEXaSP1nEibtHKvWIMKP/9kwlTUobeC5QQQerIYMYK1zldNgGkmtTuBEpdvBJijgpITKOzdbFTETZOSNCemLvH9HjQZHODi58Ttceiq3HU8YI1ygxHmSVJ5CvdR2ztOHjI2dAjPXEs5E0/e8XRk5KdAFQXV79rB5h0eiNhMWHxGhOJTQRnJgn6cU9KA/2O4dY+iXr7HLVBMET0B53yPDCeMf8fC3b3e1UqyCGT1s/zbT1xtlEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:44 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:42 +0000
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
Subject: [PATCH v5 phy-next 02/27] PCI: Add missing headers transitively included by <linux/phy/phy.h>
Date: Fri, 20 Mar 2026 00:32:16 +0200
Message-ID: <20260319223241.1351137-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d107028-ff1d-4616-bde4-08de86076f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CDSZxqx+6y08SDwUfYb2iSEdG+NeNpbjDlc9qXNz6A3plPZA4YcVxuyA6RLcGJZVNMbBl39yKaHF9gsVQrTWVFriFWNxhzA1A6+4GQxVKD4Ut8Myex7xNHakVpxtR3fcF/TCU51mpMs1N47EpDZUUR2ymm9lZmcGdQnSQsIRSIO6GgP4a/AmfyJrD1jOMCUWACMwOXUpdQxUJSiXAnbM8M5PiCGwPE0JJa5EXpqRgoVMV1EySOeTerJx1bhkhu7hywi+obtkkbsbxjx0QnyockI8y2DKuSrWTwBdFkZJIPLEYiS2SAe0qxKM2oDQkiI/yvAY4mv92Gsj+DscVuwyNVEpMb7Kg1+cCpcCu6pxIxpN3GsLxq3wuDc48/TsKkHnDG/CoKx1osDQsI8kenRqizvPz2CF7xl2b/YNAgA7c2gEezaEKh283TpHAvKmM3Qbj2154PTLEFQd0YQaNPrFekxEFVJsDWFjsAuK9CvE/53+E6Tp4ivorcYYFC3K/KD7wXTca5Q4ISWvRQHpRp4bva9/i759MMhkPQsrkZFfQL0t38lUNXmeObd9/Jd80YMWYcWOzWC8LvyYPgQARbXo7CFyg67hUCbM1Ek9PjwBViZIaoq/st3JZE06wmxXQirPfBq2/i6tw0hI32E2/svMzPG6piuMx3vXb9Suj9qQmQLADHWjr9p0yyLkCl1rd6vKxgCGhI9TinbBwYb0TDxaoRLe11rdmipAb3XYDqtuUgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azArSlZUU091blllVXQ5T0Z1MUcwR1JtUkVHcE1McnkyNm5MY2JNT0hKTFFU?=
 =?utf-8?B?Zit3R2Q2VjVaWngvVG9TU0VxUHpRa1pwQmRHeUs5RDRGWCtPVGxzQ1F5ZFow?=
 =?utf-8?B?SmVOR0QxSm4vK2tIb0JaWTJHS2dNa0M5N1AyL05OdmdiaEY5UVNwckRKb3RG?=
 =?utf-8?B?aWJuam0vbDJHRnVLd2tTVHZoMVBBSEtOcjBiVUZMSWZyTjZsZ25rRGNyZlE0?=
 =?utf-8?B?QVJpVjM4N05vai8wMDZZcTZ5YyszMEZXdXBDSFFaSCtPOS80Z09kSUM3VmZY?=
 =?utf-8?B?V1NHRFUyZHoxOFVLS0lPbzgvYkgzTkxXMEdpeVpGTnA0QnVzNjBJU0owRkNj?=
 =?utf-8?B?RW5LeUhYMGdsQlU4TzREbnlsVU42U1RjbWhxOVpyS2tRNEZqeFJpZDUwSXNI?=
 =?utf-8?B?aTREMGxPMjdFVm5TTzJlNmdzNU90bzVzZUZqUDU5SkJUdFRVQXVTWTByckI0?=
 =?utf-8?B?RkcwS09JMWs0WHgwNCt1SGpEeDhxZDgrTTM0eXpOdjVnNE8xTE53ZFQrUkVw?=
 =?utf-8?B?WTZpQ1I1UWZYRUF2OUdiaGRGUll6TlRnU01qSFVyL0R1cURIWVFVRGpyd0hR?=
 =?utf-8?B?SFhHVTFjOElGTWJjSGYwM3IrVFJjWGJXZkltaDFod25ONjI1OFFxYUxaRGh5?=
 =?utf-8?B?ZGM1MCt0V2pYZlRPWkNzRnl4SHdlY1d2dGExRE9JbHpPVFowb1Y2WlBtRmpT?=
 =?utf-8?B?aE42bElpME5IK0ZjWmdCbWw4d3BWYkdLT1FOZlRlc3ZUNkt3ODg0WWtvczdW?=
 =?utf-8?B?emlxbnNpNlpSdWFKNVRNS0dkZkpvUlU1S3FJcVIzQitqeEdJbkt5UEhsSk82?=
 =?utf-8?B?R1JIY1hLUmtHMmdXeGI5ODlNWis0TktwTnhNMzNpMjJibWFkWkgwNDRBYUht?=
 =?utf-8?B?N2JQemFtSTFRSHFySkd2N3orQkFKQkRjVWtJTzVKM3VtV3RzS3pHa3I4N3Ni?=
 =?utf-8?B?ZzVsZ25DeDQrMDB5d2ZSbnpCM01MbURXdGgvMUdMME9YRE12Slc0Ry9oTG8x?=
 =?utf-8?B?Y2JvQS8rcEl2bHFEQTRJTXpPa2JMTTM4NUNHa2FzdjFwUEFDU0Z6eHNwbGMr?=
 =?utf-8?B?OWNYaVp2b2hpTWVSY0l3N01rYkI4Z0o0UW9WcWhuUU1HNnhGM0d5RWx0dE5k?=
 =?utf-8?B?MGNKQ2hkMG45WUxNMGE2YzJFSk1VYy96NERMME94am9hdndvc29pOWY0ak1K?=
 =?utf-8?B?bmRrS0VybHM1REpIUUtaZy9aTUorRUZEWDdETVg5T0krSGpacXY0ajY3ZWdL?=
 =?utf-8?B?TjhpTSs0djk5NzFnNVdNeFJwaG9oRUNrZ3kxZFhKenhvTllmNlpwMFh3cVNX?=
 =?utf-8?B?TlhZdUJqc1RQeWg2emYyeVQ5VGI5WnV0UzlhdTkyUXZPL2ZLRnJYSzNYNkFI?=
 =?utf-8?B?YkpjRk40MTBRZkNXVTFldHFrQmxtUFc3YmlabG1KUzF2WWs1MERZL0JMeUMy?=
 =?utf-8?B?ZTU2ZldIcGpYQ0s4a1RSd3pVNW9KNUl3SWhyaHVhWDN6d0dSYVJ5Y0pFSG1j?=
 =?utf-8?B?bHFKYmhjcnRFMkVhWHlGbjQxRzVUZCtJeFYzcTl5bWdKK043OUgwVExkUzJq?=
 =?utf-8?B?L29Wbm5ScHhFa0Zyam8zc0tGMTBCVFdJVWo0YzNQeWFlREhVOElWY2k1WW12?=
 =?utf-8?B?TFZXVEVGdFM5Mlgxd3UzM3NnZkNvUGoxZVRzTktRdUNvaXd6bVlKWHJackhX?=
 =?utf-8?B?MG1XS0NwSEpSaysybFFHS2xVcWN0RUF1SHhRbFZDZUtJNHJ4WG12RnpJRnNp?=
 =?utf-8?B?Wm5ESHdXSm4wVEZuS0ZMem1oSFpsU1B3NEQxVGdSYU9EbTJROHpZdzdjQ2NW?=
 =?utf-8?B?ZEJzS1FxTi9JTjN3NFpmK1MrUGswVTh4UUZ1U2FBWm1JQ0MrS3hFZWRZRjln?=
 =?utf-8?B?UTRyVm16QkM1TSsvTCtLQ3I1TTFVQWpQR0FtSmVldUdXejUyYW9tVlV5L1hD?=
 =?utf-8?B?OGNYSnJHQTBpekw4T1JlcFBzMUQyQWVDaHlCd1o0b1RLUkFiN1dscnVYYzI5?=
 =?utf-8?B?cm5pV1puUGQzdTZKbHdDN054ZWswYVB6RDEyZzhud3ZiMVFJNGtteVJUczQx?=
 =?utf-8?B?ZTBaazV2K1ZrRFd4NUlGYjhOWlh4OXU2K0hNbHlld1hHQUNQKzBlNW5HYWlS?=
 =?utf-8?B?OVNLVGNjN1V4clRrSVB1WXorT3l5L2dIckVyaWNoTEl4SnRva0Y3U3R0VmNO?=
 =?utf-8?B?UkJVSDBWbG5DdHJlY2Q2b0FwTEk2bzV4VWtVTnVTUXI0eGgwOS8xdmFyKzds?=
 =?utf-8?B?SHZEN09IdlorMmRRQ2I4WXlQZG03NGg2UjZqOWk3Y1QwRldEVWM5L1huRkRR?=
 =?utf-8?B?eWZ6WE1MZ2ZTK0Q1bDlsWGh4bTdTbnlKdTBZQlBIYVR6Q1A0d1ZuT01GQm93?=
 =?utf-8?Q?p51Jh1womAfko/ZGPQovCwJ4xGMRVZB4zonjMxIfB7Xnw?=
X-MS-Exchange-AntiSpam-MessageData-1: Su0X2ezl2MR5ER4kkXNy7Vd/eHwHh+sDhCA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d107028-ff1d-4616-bde4-08de86076f4b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:42.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDFuM3Q29qxSss1364HGWa0ARJNtDsAB4sgUa4Wda7JtsZ0RKYwmWBwTFbQ/Z4UoQLLkYTqqBcefYbrPltxIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7170-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,google.com,sntech.de,gmail.com,nvidia.com,rock-chips.com,starfivetech.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,nvidia.com:email,sntech.de:email,rock-chips.com:email,starfivetech.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 0E3E52D33F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 20fa4dadb82a..642e4c45eefc 100644
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
index 5b17da63151d..e0079ec108ab 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #include "../../pci.h"
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
index 18460f01b2c6..e417122da51d 100644
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
index 06571d806ab3..3378a89580ab 100644
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
2.43.0


