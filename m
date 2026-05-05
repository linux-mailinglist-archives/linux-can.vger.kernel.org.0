Return-Path: <linux-can+bounces-7510-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDvoLDPG+WnXDwMAu9opvQ
	(envelope-from <linux-can+bounces-7510-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:28:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6C4CB3C7
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673AE3018BE0
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED443E9F9;
	Tue,  5 May 2026 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lT+nwBQq"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DBA43C065;
	Tue,  5 May 2026 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975594; cv=fail; b=quO2GMJaCnB95JEO8yLq60nUYG/TIqsNVDDE+MgOdy6ycQaKfhzOnaJyk903QZw1aCp6Y5bLUL9jgij0IK1Vf2qZdwVK955pwmYsO27J2uY/cP1RBi+p3pZXH5RrbKZGSYYE88HiYC2kbbkzEnoA1Qukw16y/D/yOc1FIeE2dfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975594; c=relaxed/simple;
	bh=KENPJe0qdHDy3W/JyYKp8UP4lXlnRKw3qRzWOpNNI7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQnZfEgFgwOk/toc9lJ3gNWwBcxRlZK2OYYJGV2+TNy7cSNLT77vGnIjeNBpKgbt3zjlJ88uLwXrlP5hbUXfQ+x2fMKaKZe912WsXGjcoaq15NKoJ5F7XxwPBEZdlV1CUtf8PtIqXJJie4pZIeRcLMTbdCyklqm8AEVZgw4pbMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lT+nwBQq; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef91doywjKQWUr8qU9wlxH4X3sXqioYc78fmFZPgRxqVqJvgKCUmjvEUUEndUoKPTuy80D39+JZbESx4Dn2wLMvleQBHaycDijL+mvtQoNdcw+++IttuFMCtUx8BX2pKX0hX2Him6Kq9qsp+UIuSyZwF0G5U0edMXPrYqEHwwR9VpJDyg4LAI1BucOq1mYR7+eMOIr+2CkNiPe05N9syYoyfOY3Xv0CbZuqF45bfQE8UdfDh88C7i2h6rjiSgo0HnsTrN1uEWBR1CVR7CKkRyO601hQMXECSnXWiCSJntwUi+a2Zu8YD+arMZJ8dmSTKr73by5PDHQJ+QF4Hknt9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3PYNnv0XpvQd8H8KeWfjsazA8ctcKSqdW2GtGCeSEo=;
 b=GMjKr/AntwWtIWQT+/OL4DROKhjQAEww9ROBf1p9fR32LzyIkB5J51Js+xUA3CxTjm1O1rYzqSkPPWhdCvXx7RmyYCuyUAy82yXzGPEbki7JDvleTaPYijpzbMGKykHMGVgbxlZQlCJyGaCSr2FD0fcbLBSObxBKain9CDLvh5HE61G2cFC9lLQyOPbA8hFZWK6NZhDmp2OGASR3/jFEFtKc7GO7kxnGkw1osvvWaT+u+rHQ1QxlpeXiTrIxHXgT144NVmsR/ZoK2fNaNCYdcmzedyB9uwfQBmYIOpQNhYIl4gn6uf2ATDPEgqgSF6BPNrtT+bljRRDmH6RwrsWCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3PYNnv0XpvQd8H8KeWfjsazA8ctcKSqdW2GtGCeSEo=;
 b=lT+nwBQq2TVG9i7KWpDWKqCyEOcl4hiZmjICmCjRqDlS5UwyPcoDIp1FNzrFYXi7uFd8OdI/TsnA1EDoVYkwlQxkE4kmaqkw1QVIcHnWBFronjTNEqgpEmc53KwhQQT5052M5YxJNKSWEUdmImsKcNpk/1NZVOpl/avO9qSqG4P7ChBWPkEDvXt0nO/hzfTYi9H2CPeEpqIEkrxug0eHYCEN6A7pSQp1cwSsteVrYvzKqIXwQfKMzZHjuzLo0dGEXpGK/GEw3EmCFmn8gNsLFPCHL7bAxISF2glG/FNuisfkJ9wlW2LvbyWq55Q6Q7oQ2/7n54OGPLsnLFjG2ixX1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:23 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:23 +0000
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
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v8 phy-next 21/31] drm/rockchip: dsi: include PHY provider header
Date: Tue,  5 May 2026 13:05:13 +0300
Message-Id: <20260505100523.1922388-22-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c362a9-2884-4dca-f175-08deaa8df605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OqQZOdnX+DVjhmvXyvmeUWFu0oRRPB8Ou1xRUuSwTxZo1iaovulo9/srJPXdAPWQ3EiCrxQ70IHt97rrUoBMf+v/M8Prn0KafrXD+hyPHTVC4AhFjD/svR5JcWsey/8uakjm7lHEbpPrug/o+KxqfymKnQs0cqT+N7qV4YtwF9ofvHJhOtKN2Qdc4tPnvvTgy61KzGFfzo9wEjrVSNHoAwqM2S8BIqrjSIfcxcWM+0HZBbtEKGBTDjpL2KGKIFkPBffm9ODumvCQahfnoigY8jY050+ADPuoP9WZwOFHMoArzw0wdPdBVxYjdsRCG1D1zX95+9K23ccaDUcJLy5ngdGyD/WC1AdeUIrkBjosx+1N8LK+NJmlCyGLaLt6iCVWpP2/+2m9jbl+PLiEbza/hKZCpRUHOTHLhVTIUKwG7QJsHLIZQwjTPhyGxYvqF9f5xkP7LSH4yLyAE6D/XIVVbDhjGYurqSlhcvQ9j17I/bZgvq982aQcGmAvWyBrN9D+hRAOZohISE4O0jtigsGpmlmrV0Bat+uK1x/x++PXtpu2nSnr6pkRnQvrOlgENIQDnHY3RsQ+djLUGDPtoM60H0y3q+TlrIOVRUVefxzXXc3Fkf6Ss8BXaS+SMJwSdHMyNEvL5WeYcKdDI92m4r2W37sOVmIqNu0xXPhyFdzRO75qBZ90xrPiF8t1i/9cy1iF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmRoU0dJME5lenNwZjJkdWNyWmNSNXEvOGZOK3dlWjhESytBNmhkVU9IdlFB?=
 =?utf-8?B?S25wQ0FqV2lnRTFMQzY1dy9XWnprdFdnRGlnNHphU3QzY0lQOFJUZURvQmVx?=
 =?utf-8?B?dngyMGcxb2ViM1hYY2g5MjRGTDB2TlZCTDJXdmkrQzJRRU1LdCtaYXZId3Z3?=
 =?utf-8?B?blp0eVdSOW1Ic2Rja214dTJCOVoyUzNxei82em9yeDRPN29aZHphYlMwemZM?=
 =?utf-8?B?QWJRbkZ1cGczRDdVcW5TeHRrdEpya3c5V05HRk9OU3dXdE5sR3RlRVdERldC?=
 =?utf-8?B?cldBdnhZcGJnY0l5OEpoR0hCTDdMYW02QmhlSFdSZVYxcU9yWS96aHA2SGpl?=
 =?utf-8?B?L3grRFFuRWVGb25HZWcra0lVcHQvaDF4VnFQb05oNW05VGF1ekRCQ20zTXdi?=
 =?utf-8?B?YTJWenY5OUFHYktDZllaS0lSK1dGcVlwQlQ4cndValY4UGh0eENiSFhyc1Vz?=
 =?utf-8?B?TktnQzBQTWxWOFJ2d2liOXJycUs2bTU2aE1HTis5cldXRHVVVURMYmxGeGtN?=
 =?utf-8?B?NmV5WVRtRFlHMlYxSHRoazZlTHpoS3huYzBITUIvZW94QVZRM08yc3RodzVL?=
 =?utf-8?B?QTB2ZG9iODRtYWdqYW5YMm9oMTgwRUVudmdKdzcybktGS3lMejk3VitpWnM3?=
 =?utf-8?B?cWt5SmoxMUxjY1VSY0NWNllRNU1XaWo5NUY1SGNsV0xWNHBQQ0ZmN2t3WVFr?=
 =?utf-8?B?aW03RXlzRXVNYjZpdm9iblppYVJGeFN1T1B1bzQ1TCszNFJxdjROVTFZc3Q2?=
 =?utf-8?B?UE9PNEVsZjJROEZpVTNRMmJaY3JrU21veS9FR3l2SXVaSmRqV05yeXVneDZX?=
 =?utf-8?B?KysvVXJpd3kya0FLSklLc2F3enoxSnpMaGZGb2tVNHY2L2l5b0pCMnZ3TGY3?=
 =?utf-8?B?cXRxMUZWYTJ2KzFMbHVYN0tSZjhQbDhPb1p4RXNIZmdObnFldWk2NTlkbC9p?=
 =?utf-8?B?ZGJtRVlnNjQ5SEJKRktVL2o5M2N2K2VvZkVSMGY5Nzh4RWZVVTVqUm1aSHRP?=
 =?utf-8?B?cnpSUTBLNkh5WHVoRnZZZkRHSU1WVmt0MGNINzM4aVE2Ui93SU8zSnJBNXlq?=
 =?utf-8?B?cC9qdSttbG50ZEgzcTdZUWZSU3M0eFBaSkorMlo2NVFSYnRFV0JmQ3FNZUY4?=
 =?utf-8?B?aFR0MXBaQm9DT3lyMFZISWxkUm5MajJKaHhJMW9KR1ArZkNMU2oyeXl2TGlO?=
 =?utf-8?B?bGROQlUvK2hJcUZ2a24wNDBRUkdvQzdvbFVxK2wzdjd1TWZwYklLbERHM2E4?=
 =?utf-8?B?cG9IQWpFcmpvK21uM015c0ZMNUgydlNPdUU3a3N3UnhDb0hKeFludFhhY2xk?=
 =?utf-8?B?MklIUklERmdzUHVjdDZydzBjQThyN0Zvbk5WQ1hBaWN5bHBDdjJnNWpia1BR?=
 =?utf-8?B?WDhISm55UkIxVGlWV0JDQTN1ZnB2NURuVDZ0OE8xSnZFSmVORUt2WTFtdDFu?=
 =?utf-8?B?VHBvTlA2cDkxQnNOb3Vid1B6U3QxWlA5WUJUTEVPbjR0Zk9aYW9tTjRCMzBL?=
 =?utf-8?B?VmgwV0R5ZUJwY3VQN2tHNHRRKzRGNHN6UDR4UVJ6d1BDRnlndXhwT2lZQVI0?=
 =?utf-8?B?aWx3RUQ2Z3lLdndhMmM1Mzl4SHdwd1JSZVZCRmo2TUhLZDBrcWZnZjZ0VEVq?=
 =?utf-8?B?STE5M08zQWpYaENMMDJZTmZkcDQrK28wUHNNVnBFcWh5d1RHUHAycGFRVDQw?=
 =?utf-8?B?cmcwbkFjTVEvUDNMOHpHVjkrRUJaUVBPeElLWjdBWmZnNVBvb1BBZktvdjc5?=
 =?utf-8?B?TXV3dmwwYmhLR1dMbHZadkRNbHQ5ZGZQZERnN0JZVHBPaklOUW9vekwyNjh1?=
 =?utf-8?B?aWVSQmVvUWtWajVtWE0vV3JuRDJGajFYSkQ0d0dUV3JTckNTVElwUTliTjZK?=
 =?utf-8?B?cnJmSGdqZy9Ya3RBYUNsYk9rMG9ibE9USklPdXIrVTZta0ltTkRqS0dlVkE0?=
 =?utf-8?B?WkdjWHkzRnh0eVpGN3lwYkRMY2Vnb0RKSXB5R2FYUjVYVmZSbE1IZUg5REp1?=
 =?utf-8?B?NVhJYWU4dW8yZGdXdW9BNzMrSGRpdFQ2YS9JaElWbU9yR0c4UkhveEk0UkNu?=
 =?utf-8?B?Y1JROFZwYW1kY1FweGs4L2F4U0R5Wi9KZUYrWXlxZ0tmZzhNaFpXR0p4dzJB?=
 =?utf-8?B?UnB3T1ZIanZURFJSS2FLeU91Zm9RMUEzWTdkNFJuZjBsaXdMZ3dzUGt1bC8v?=
 =?utf-8?B?SVEvckVMUzI0TzU5OVQ4NkhiTFBQU2VYZ1JXaFprTGtSMUlNN1hFUU1iU0pI?=
 =?utf-8?B?ZHd2SGtBTUVtU2VURnVyYWpvVVRjcjZTaE5adnZHb290UGVOT0xWaWdOYWNY?=
 =?utf-8?B?d0w3aVVmN2dTNlRJK2tsNE9SSFhGdVhOT0t5YS9JUTgxV2x0TGE4dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c362a9-2884-4dca-f175-08deaa8df605
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:22.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5l++AEpqrfKSyipfRrXOtAY9RsN1oovPi1oQJe9Qs/Z8eWqRNbQWgK5KzDSGHCplHYuBRaJsMns7P67jwj17w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 1CC6C4CB3C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7510-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,ffwll.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,intel.com:email,sntech.de:email,rock-chips.com:email]

The Rockchip DSI controller is a PHY consumer driver, which is also a
PHY provider (calls devm_phy_create()) that lives out of drivers/phy/.

According to Vinod, this is discouraged, although it would be difficult
for me to address a proper movement here.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v3->v8: none
v2->v3: fix cc list
v1->v2: none
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..c0aaa51e0237 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -27,6 +27,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include "../../../phy/phy-provider.h" /* FIXME */
 #include "rockchip_drm_drv.h"
 
 #define DSI_PHY_RSTZ			0xa0
-- 
2.34.1


