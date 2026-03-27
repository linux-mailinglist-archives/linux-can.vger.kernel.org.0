Return-Path: <linux-can+bounces-7270-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIIMNIDSxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7270-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:54:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5103496AB
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9135A30862FB
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055BC37FF57;
	Fri, 27 Mar 2026 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iZjjwYf6"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB63351C3E;
	Fri, 27 Mar 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637332; cv=fail; b=H6D8PsKfcMzQ9BIwJduiN8X/Oe7DtwZEkHs6AemzpgNXNcGENleYk9MF75O6Ptc9noofQi+/UwJ6AIc+qSkoJGJxDiRbaLOj7hj6zjGJmaylDgPsNqfyUGo8G7OzPXovz0Iya3JJYkeupdoi+voeJozL1FmFCcflZtSxBZvz8e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637332; c=relaxed/simple;
	bh=mQdIFULVUAb7COyFv07quhBljnal/hmcGdWRVOZPdP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=shTQpF11SEvXiWoxE2W6MW5goKy1c2k+1sMZCYAec9Dd9mDo6Mhbla2CdoPtY4+1a3m/pxRXCpFwipf0dn2f5KFm7AxrOoATOk+LQan1YSk00OmW3ZpqeazFXuT/CEDGw7ZDa9P+rTLdDZ5MlZ7FNA6iYSFcFb3D8+db+maVwpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iZjjwYf6; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH8Qum/sQXhgWP2b1b8lGzaoYTmGjVPxR/wDemyDUBHWIjYpDP1xn2/0XLPKBHcv9Fn0mFHMKmq5Z+pdpvcsSmm8yBLdXrfnxUFYyslkfetVPaEQI4BKEwg2tsujT/jlRLxT0NIEswITDDguDTtv9W2MU/cPNx+dgePmLbSkiXA8lvd+ix6sTFMLykmSmn5jmgDqodn2wOUqJEQb9n2BWpA+VdEc3Zgy8cPhvATrEhC05kaJkCmmY/HXsngO6SHq6/yL5kXJMgx4b3cDhzsLbj6hadbxTUELoBt96miLUIkEvmigKVH6CRhHczOHZJ4NHVnbdmixuOlZcHMHyhmGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxflwS6PD9ZAZBlYtnbZwu03zwm3N9kRTsHs3rQEKIc=;
 b=aphSPLSRektt8CNB4IPGyBCP9ArSSlpardOfuXfh8EvuY55azWO14YIM5D+cJG/VrrxDe6+5UE70XNpDY8lQIT8AavILg4+WmgQky9m9tSvagZAk6mXBOib4fGW+2/gEVT3n3KQTZMtoWlJcsm80o/Ok09FnT3Sij0tlVD3vX2uo450tfoFhSb5oX27aNY7wamGUoJShwb9fDLDoSzjNHxxV//6yhXG4Av+sDtBevRM2yr9YVn45jRveAcmgjYlDZGJWeuWNny9GD1qDtFUVW6ylT+wd+13u5RzZlIOKfPGpOQ+WudAHONetHYP8i8NVxuD97zWKP/A+yIhgYoD96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxflwS6PD9ZAZBlYtnbZwu03zwm3N9kRTsHs3rQEKIc=;
 b=iZjjwYf62clnbbYsrqznPQ4G9LtOkNDzjNUWdo+ThmH6bPwp9Y96wIvUMKL10AouicQGLMhXVJV1kHGeYYCAzUd++DxmLiiu12vfqjEuhpQ5ezNgsovhPPA3x6GJrDQe83cWn3jGeTPj17rDccap+ow2Xky0w9eT03YEMR6cP1fLGC/+AL7gz5Vr5MtTi4H3HI+IbifS/sppJuL7FrESkZUqAZItR5D8MRVqzfU4RD3b5rl3zzqxNfqQsaYJMNeJC0BpOrZ6NtzB7XJo/+SeqYQ9XleS4vdUii7n86260ahnobbkQI+6+oWpNpGJHJtMkNHSjJDHBpnLoxe+oXH1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:42 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:42 +0000
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v6 phy-next 05/28] phy: add <linux/pm_runtime.h> where missing
Date: Fri, 27 Mar 2026 20:46:43 +0200
Message-ID: <20260327184706.1600329-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6599583c-b6a0-49e0-296c-08de8c3177e1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 t2sSsNvwfRZeL+M3DmicuJ8QVe9ruTd4yOVANZdxKl2072i4OBajfhqJlB90tzR8/yZdkH028+d6BMP34rzuKyA0sMpmB4SzvLHwG54Cmd4qr5gz3kXYs/DXOsm4UKmXgyAavqvPNex6aUplFWp/wD3iL79A7yUmeJv83G9oe1BAXwkdQpHyPoo3wJXd0afArKkXj7bdXEmnypAogjMbZnYwj6nWvAqkxXknagLWTJ/c7GZ0CmFWR4VES0a9YCiIGOR0mpdAtA6AD0Wg7Xa/0NJuqZvnoJ2amn5Db4NYVkiIRfpR7ePbkx95PO4yWePp0UYwA78Fw5hIeH+dGmzuOrHvWTWsfL1LcfTjaVoTIGMdxtN3T/yhInWCdlH0iwYTvEDMjnZapn7PSK0qO29Ax3yjd0wclHXl2TDucYlM90oCDrZBFLiM1KfF8KB2tcbvMu0CXrs3TuZVUAMluV+uDUMMrpEbkbgdYOxbnStAqv9Q0HOcmaUeiINL9N1kLigSP+lSPAbMVp4/LRN+y+qz6Uamk7pEw1Tv+84AMTEY7RKPvhMkjKb61YCatIHYtpST6ui3AL+H15uKFyLelHrG8UppddXnSaEsXpPRUEHEyaMQ/kKOdsu/opsX0/AXNmRWUmVkEwclK/pS0LuwW7gmtgUmB8H3hAX0dCoPe+NWw4vX23XUuPSjyE5beq9p+iESnElg3z1UNI021z811Z7xKnER5B9PKMkSZwORM4BlfvE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ejMyZ1ppeVB0RnY4Q3REd3BKbmJOc0NBOEgyeXlFZk9TRHJPcjVDbGZsYVI5?=
 =?utf-8?B?YnVtM1JsZndYQzUvZFZMMDNMNlNoVjV4N0VkYURvc2dVYWZFM2VXSmpDUi9r?=
 =?utf-8?B?LzB2WjU2QWYrbXAvbHhpMXRveENtM05JZWt2ZXBnYjNVbDJJRTJBS0xIdzZX?=
 =?utf-8?B?TDgxZG5SRjhoTEswVkdKNm80R1lGMTdDOHZWZ1FVSW0yVG1MczBOUWdYZmJS?=
 =?utf-8?B?RTRLcFY1aTRySXZhU0xBODhLUWFSUEZVK0JQOGlFbWJvdUlOK0VhWll6aTNl?=
 =?utf-8?B?bjJsSEJWckl0NzRsekk3MkVSRE5DZ2YvZ3ZCRGx1M0R0ODB1U0JtclN1S0Nw?=
 =?utf-8?B?NHBSb01rOUs1Y0hsT0hoeVJZa2NXa0p6WnZQcjFtVlZ5VzU4Tk5NTWRiU21M?=
 =?utf-8?B?TFZUT3U4UTc3K3Y0dUgyRHpLK2diSzlGZUtPK3JDOXFZOFBGb0REZkkvWlZ1?=
 =?utf-8?B?MUY0TDBhYUlUMGNiaUowMTB1WVFza2NhY2h4MWM3UTUzNXA1L1UwVXlBN00w?=
 =?utf-8?B?UmdtM1IwVCtMRVFiRC9HRHBkN3FRSWplYU9qNHoxOUNZVDMyOUtuUlJWM1Q4?=
 =?utf-8?B?UGxubHQwSDJwekNNNUZGblBQalZneE50V1VWUklVNFU1YnZTMUtlekZncDlj?=
 =?utf-8?B?MkJwekRXZkRPb3hzTUg2VzZ4ekM0V0dhRmloOFJtR3ljbWVhQ2dpYjVQekZk?=
 =?utf-8?B?a1RObUxsUG5ZeW5jRlc1ZEpGRW5kKzh1ZHhtenRMYWE0My9qVXFJSm03WCt4?=
 =?utf-8?B?N2xPMTVVOGFYczlEYldiVEV5NGxJdXFSNlpMSlVaL0laOG16dDR3b3QzMUVi?=
 =?utf-8?B?Y2RRbmo3c2s5TTNTbmhEa2Rjck1VZzBYdDJLbTdmSitORHF6RDcxcjA0RU5m?=
 =?utf-8?B?WERuVFFvTGlBOG96T0txUDhwNTJTejFMNmVhSDUveVRxYmJwMWpRQnJLejY3?=
 =?utf-8?B?S0E1UHlrSnU1eWxUejg3R1hsUFFDOWNEczlGN0Q1ay9jYkdDV0U1L2hTVGc4?=
 =?utf-8?B?M05HRVB6L0pSWDdMREp4WEp2NWVjTGtDYnhreVY4YjR0RGZqeXdDalBaODkv?=
 =?utf-8?B?b2l5c05lUlVVL0YrbkFuZTNGUkZ1cTFJUHR0L1hNa280LzNFcktGZXlrWjJX?=
 =?utf-8?B?eWVqazl5VzEyajJCY3FVUmRCd2VyUWRHSlpTYURDa3Q4cjVWN2tzL2VKcndL?=
 =?utf-8?B?cUtZYlNxUEswVUJucWdQNXRqMVBBdGg1MGJGc3VBbkhzRUlHVVBCbzlYdGl2?=
 =?utf-8?B?blcyOGFqYkc2RjRLZStyOVlxR0VxS2pKWmI2emFhQzlMMHM0VXg2Mi9IMldE?=
 =?utf-8?B?eFU3bS92aW5qL3N3eVBGVTlYeWZlSVRScXF4Zmg2N3l5Rk5YUnpZR3hBR0t3?=
 =?utf-8?B?L0h2bVoveWZaTHZRa1BFMExoNWFmTGFhUGlIN1pmQ0RRdzUrODltMytQa3ZW?=
 =?utf-8?B?RDM4MjNIWk15VklGaEVRYWZEWlJqWHA0aTVRQUgrS3hHR1IzYkJWYzBTRm96?=
 =?utf-8?B?a2Q1NlBkT3B0Q3ZPSjAzck5YK1hvRnllbmNVMVM3SkN0QkpibXVEVnBtTzZt?=
 =?utf-8?B?TzJCMTNMUkJFeWVWcHZsdWFvSTlqb1h1NmRqRkJiNlNXMUhTc3haRUQvYWtT?=
 =?utf-8?B?UEQzV2Y4bW8vUkxsRXIzd1VVaGQ2ZG1TcVkxVkZUcWxyWXc5SVRhZjFEd3JI?=
 =?utf-8?B?VFZ6VzhxaVRIangwUWh0UWdGU3BiSXNXaklVN2poL084N3pScDhDQjQwdGtr?=
 =?utf-8?B?VVJzdWJKK0VJaGhkYlRBTS9raCszYWlMdWVLZ2NScE9BamNueFFWRU1IQy9p?=
 =?utf-8?B?Tks1THV5WWpJUlVzdDRUN2xnbFZOWkpvbDhHa3V0Ty9zOHBUWXYrRStoeStM?=
 =?utf-8?B?MXdmUDVpY3dxVTQ0SlFjMEduNm9XemxYYzhBaXlSL0RUOFU4bFVLRmxTbDVo?=
 =?utf-8?B?RE01eVZtY3Q1bjlKb09pdmpNbTh4SFI1SVlNSHNScVVFVC9RNWZzSGxyRjZt?=
 =?utf-8?B?YWlKQXJCSDc0ZFg4YVNNK1Y3RnpEOHhWaXpOL3Uyck9ZYlg5UmhTdk02QytI?=
 =?utf-8?B?YmVwU1BCMU1mQS94aUhzVDg1TzVyQ2VrTko2UlFjR0Q0RFMzbjYxUlM0Tm41?=
 =?utf-8?B?WkdqNUZBYlgwanRsSUVCTzVUcCtLWlBKNmIzc01KbWlOOG00cmJhT2NEYjBT?=
 =?utf-8?B?U0VHeU9ObE0xYU4zdktGNUsxYTFtN0ZUS0J0NHllRlJTd2RTRjBzY3ZoQ3Zz?=
 =?utf-8?B?T0EvSkY0dnVtdFhobS9IMHMxYzNER1JuK2t1RGZOcVpDeVdQNUFFVXpaWkFK?=
 =?utf-8?B?dWZqMjFINVU3TG1YQkwrY2lPUVFrcVh6c3k1elRsQUJkUDNrcm1ra1FGa2lE?=
 =?utf-8?Q?6r5OEkG4VZO/MC9CvClFDcq4PeekMO2YMA9ur41raP6LU?=
X-MS-Exchange-AntiSpam-MessageData-1: 6Gjs499puAu4PWvdVEpBod30MCV4jkXMKm8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6599583c-b6a0-49e0-296c-08de8c3177e1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:42.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMsjjr2sGmzYiammncEheXz88Y1nY3r33ubx997gxd/HYf9du80waIsdglqPGuG8/W2p+Dvd9yXh3siKfHKXWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7270-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sntech.de:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,linaro.org:email,glider.be:email]
X-Rspamd-Queue-Id: 8F5103496AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
call runtime PM operations without including the proper header.

This was provided by <linux/phy/phy.h> but no function exported by this
header directly needs it. So we need to drop it from there, and fix up
drivers that used to depend on that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: André Draszik <andre.draszik@linaro.org> # google
---
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>

v2->v6: none
v1->v2: collect tags
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c    | 1 +
 drivers/phy/phy-google-usb.c                   | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c          | 1 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c  | 1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
 drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +
 drivers/phy/rockchip/phy-rockchip-typec.c      | 1 +
 drivers/phy/ti/phy-tusb1210.c                  | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index fd0e0cd1c1cf..ce1dad8c438d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
index ab20bc20f19e..48cfa2e28347 100644
--- a/drivers/phy/phy-google-usb.c
+++ b/drivers/phy/phy-google-usb.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/typec_mux.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 93f1aa10d400..b9ea7d058e93 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490c..2bd5862c5ba8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index b0ecd5ba2464..d88b8a415e85 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index c342479a3798..f62e1f6ecc07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index eb93015be841..191040f6d60f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..8915fa250e81 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-pcie.c b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
index c0e5a4ac82de..3e2cf59ad480 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-pcie.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define PHY_CTRL		0x4000		/* R8A77980 only */
diff --git a/drivers/phy/renesas/r8a779f0-ether-serdes.c b/drivers/phy/renesas/r8a779f0-ether-serdes.c
index 8a6b6f366fe3..c34427ac4fdb 100644
--- a/drivers/phy/renesas/r8a779f0-ether-serdes.c
+++ b/drivers/phy/renesas/r8a779f0-ether-serdes.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define R8A779F0_ETH_SERDES_NUM			3
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..0a318ccf1bbf 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -49,6 +49,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index c3ae9d7948d7..b7080403e649 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,6 +13,7 @@
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
-- 
2.43.0


