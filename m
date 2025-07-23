Return-Path: <linux-can+bounces-4044-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE2EB0ED4F
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E442C1C82ECA
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE527A477;
	Wed, 23 Jul 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="JPUEA50P"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806F278E5A
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259603; cv=fail; b=ey4IIbarStoqJ4U5I/E4socYXjEgft7oHJEAzggDRoMuIfkLVIwqMbPRh9eGuy0DMpQBuhLq7dd+lHUkR+HhsPml/70JBGE9ZJql3341ylB7bGbnTiPyeiez9VFcRGQNaQlZp7P+PwVFwzuPPXMLaoOBwPwU83kd+tZLDmP0Inc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259603; c=relaxed/simple;
	bh=2mZbWZLIqsFZGKChck0jsMrOAg/5Ct6bpyXUvykfIU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4D6o3Uq4dfxdui6UA4o/a/Dznkb6JHjnFBBvH9rl06oB9Cdn9SaVGklXqUOfA36lksI+Bon+QKOLmcvPI0iiOkW82Nde0uo+KkTyI6UH1MXAqILkO1pD/3rkmSHLUf7Dfa2yuRp81fiMeLj9M2cxGddd8KA4yxKkowoxsAFxDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=JPUEA50P; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMBpytLLvYnZ3BpAKmiGMYWwXljqE7KRWEbRSA0O6JQZE2iAcx7iucIPRa05NvBUWCu/AvB3TUtp38oFpxux2UQThBN5Z7i9SCflxlxdfCB0yu/wIFPeJVOYhXL2hhjADx9l373PTeQaGFBtlE40UeNl7pF2Vbh31RmN13SwckxUv/3nVuDYAB0jSmbg6BXM+W6wqcccqhiHEZxwsa2ZwgwrxafAIBLcoVZJfjAGzE3TfP8HwdFkAzZ/+Viz5Xs0bH4GB+Zatn7Wgh3Z7UWx6k3dseiusKUUX24cv2M1n1UzrI8f/VKDw64Lhk3csyxW8jz5tyzL1Wj/UWcB4pGq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgnK0dntkXMhm4wmtVnMeFz/3xGPIqi1NKtLFG3UOOo=;
 b=Ta+7Zw6gZbbkjR9Pd6eYLt9i3ELDcl8uwCUZ3wI0C2DC5ihlsZVkATNkqidL4labNnxprj7lFldD9h8Z9+fFRXd3CqSbJEPGbiPSUWruND/cC7kuDYG7bfxF8KCt/rW1WrJiYqb0Q4g3HiShwCZKa30gKi4lv6pPsi2D1Rs2B1iiQTkkQi/Kekgaj4vPVkCYHXSTaYgfRRAF3V1ae45/GUmbBFv6vSoX611sUrlh/WRuC5lROjxtRfGI0nXXVZ6p4Oprruz7ZdvFwPMbSfyeIqpwrQ7BEZNl+4GnhQWgyApVrLXbs6f1Qy0e00KgmxSSJ66BMVxOH7t4BCdl731iOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgnK0dntkXMhm4wmtVnMeFz/3xGPIqi1NKtLFG3UOOo=;
 b=JPUEA50PvoTPznMT/Pj7M6HrcB1OeKLj+ZB8MBijMwdzoYNfiqApe9gAU5Ud3bgLZnAejlxtvWuPpU7Bfmi5SR36N7RtSiPDf8dtKC8NL/k4KcSeqkR8y0sNQOoA4tQI6bHeZaWKv+qrOO7YW1ig5/mhHxbfpych6BdLYr4ygtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:11 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:11 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 9/9] can: kvaser_pciefd: Add devlink port support
Date: Wed, 23 Jul 2025 10:32:36 +0200
Message-ID: <20250723083236.9-10-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083236.9-1-extja@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d913bfa-d827-44bd-6588-08ddc9c38efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LUkL2a4itwgSCo1zncSRuCVITtVvEzX2kkxEJhKj8pFP5WGSy2vRMuAduDIZ?=
 =?us-ascii?Q?kPVq1xdFtnFk/MYJ6qNhGlnGaJoC+2wb0m5ZnQnXfSm93hSEl+6qnmJhfS1q?=
 =?us-ascii?Q?HIR1sSmzxsZrevQvyOcw8z/T7vFAJBdVVJ1quhWqe76ebYp0zFzWzPKcX+Pz?=
 =?us-ascii?Q?fDoKN4yUjnXFACFx8tcAyj8ExEYh7gdnt2fkrO/sPZ6etoxotQYssRgawlIm?=
 =?us-ascii?Q?o7n/J1le72W8WOMVuLPG7ykL3KE5GZ13BtaagjpIBcKWdXhvfkreuACpjVdq?=
 =?us-ascii?Q?WOkqc+raKh3BpjzqHz0tdFnrCW1MDRtOi0yJczauCgRQVCS0175FXmnimE5S?=
 =?us-ascii?Q?BzxPzNjtA1wZZCTgHuDzha4WJz1O3EFY7VqATR8422XGJrrxgluh2X2YXZiP?=
 =?us-ascii?Q?0sfX6XtYq4V5lm3isN/Hw1o/cXdXYHVOgrR7WgpwejzAdpuv4dt0K91aqEud?=
 =?us-ascii?Q?EGZDaZXQBywynxuo5pk8Leh20cD/slemKAIK+BISEEgNldu4IgWYyAghpuWm?=
 =?us-ascii?Q?c6OxHaPOUyIysEm6E8iFaT/JW+6EV5/h4MAJVCEU8rJZ/GgBr316wO8vryhH?=
 =?us-ascii?Q?xHvysdFi7B1VDt4EVhx2G90Ir1TKhzVbafViqSPz+IP4UCaD3UR0CoqnxFVo?=
 =?us-ascii?Q?n5vqFKJouVTj8OhoeHw6cggSfNP14wuAUY1rRzU5ds4XWiDn+qz6PaqVQQmU?=
 =?us-ascii?Q?mjg/HPchxXlyTzYz3cG98cftRyPmf8Hqmp2nBROXf2P/p+VJbw1M4Z8+1UEU?=
 =?us-ascii?Q?R0JmsHX+Oe9y090wFfQrfGVneujjLe/4LAq8AZXjWGf1UMmVBVUzx2BgxYkD?=
 =?us-ascii?Q?pL0r0nsv9OcV5Ae1/YMT0O6TVEgtVpKQpjbSPbgYclLmsE1zpJZWGAedxpsb?=
 =?us-ascii?Q?5YiS5nl5z2UvVWU38VnrTW4g4y/vi0U4okeoiQ/mTwxMaPALFxruLtuAsQ6n?=
 =?us-ascii?Q?rwjLwvrDRuP9vofHTjSEb9Xynms2v9Nc/QFsna4TOIXzLPAmRynMwuzNewfP?=
 =?us-ascii?Q?Xk8nYOMRN2XNTcC+NDXw3xA8BpRYFpdA2aSCIp8dtlK+t7Z06rwwFklJCm99?=
 =?us-ascii?Q?ME9OzrCsCI7uNuTLIT36yrtgbaJOjP8W/Xw5m3i6ct8lv7E2i/YQIFSghqWv?=
 =?us-ascii?Q?Re3+33Rzt3AEqHo6yPTCY1/9lZKNeD66BUW9WvPCdrNpM3MoriuEI4D/khBS?=
 =?us-ascii?Q?82yAzOMOSk1JabmgAs5zd2R1WVqjzJPz2KrbcD+8Xis0Cb6Y0LPSxIkUpsM0?=
 =?us-ascii?Q?PUtaOk7AdYJu3OedXiZoS4R6YeXBqDBqmdN/G1Y5oZ1juBohlq7KbmUn8SIy?=
 =?us-ascii?Q?MNo8BE59cpc2HlO5wu1F/FQwwknjjqJhZabp//0P76Q5xiRL/KapcFm7EW/I?=
 =?us-ascii?Q?Y5hQ96r75TTG4rPCEF49OOmsakMGFUpv5O2gLmZ1wsJf6Dpikdk9/hWDisHI?=
 =?us-ascii?Q?FlqzKsjAYxU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1K9bz/uaQHFk35zJmzMwkrh+30QNafrxYjCHwvZ+mZ1EDgck7OL6XfKSKRJD?=
 =?us-ascii?Q?rxOV6Fv1Z+R0MB0T2UYrk4ypv0c0hvM1PjgjXKsATqfQoXg5NZitd8FtPeSi?=
 =?us-ascii?Q?YCdSsqFldWdKpleU90OSPTU61kExLvLHt88LxF36hkLGzj7m8eYBWg0zibqu?=
 =?us-ascii?Q?WXR/l+I4vTHJbcO5PhdMadD+PDxQ2OGDbhmdd8/FbDKvWpttRsfDFj8/fg3h?=
 =?us-ascii?Q?6FdQ7PDO5cFRTX8JARc2SHGPCPEVdbA0Qh8a6AkUWlL4VCx41lXoDNyP8y9X?=
 =?us-ascii?Q?Frvk6cxupVgifpeCI+/EgojxzN9Q+W7sCeVmQtU1aLfXqB44R8ENVeadHLBe?=
 =?us-ascii?Q?xVPfA4JF5Dic7XOO4XTtmQHY16EyzmrPIwQY82DLDb+aY2t1jMfKBeSwzawv?=
 =?us-ascii?Q?lkqf4sUfSG2qKq3LsO1YwFoPHrRhwfYIId3d2ULsVMrRrM+jv5gJ7Q6bio9c?=
 =?us-ascii?Q?i0EincUV+tscj4JplNeExJqc0ulZZsJHzE7wGZyLjCDpAA4JXkyCAF9m0kHT?=
 =?us-ascii?Q?rsL5P9XuetEHWs5bnW92XMSoXMbARuJHZ7+vIB/yjyu/rg+Ul1AAL1bllFmQ?=
 =?us-ascii?Q?0t8bbLulcWkYtiBcnGbDHy5gfkXMd6Cvr8xNFKgHUXA8zcv032SPWZsbBFNz?=
 =?us-ascii?Q?z7K6L0xX/EnGx2iCKbeNsUF6eYy90dZ3AVXlK5CLZbsn9GsFW+vpMWR2lzhB?=
 =?us-ascii?Q?ebw/V+Iy1MO/dHWlvJw75f5EYYlMo8LJE4GXNZjQl1yGSAtayNLecPO5UvoE?=
 =?us-ascii?Q?x8JZJ4m4cbix1nAfhdk3abCoTHzf0MVwMgHRIPZ5jYeblsP7NiCKwPNQbRK3?=
 =?us-ascii?Q?nNv2TKFnPX0ake4UI9YQrczHi3Jn1gFTSJoppd4aWXhmxbRUWHdZwP+wr4Pm?=
 =?us-ascii?Q?nvCbIMSpefKKLexAu4zjxkUDUlym9rEfZrNZhmY5KrYlZOgqN3+1rmzqiwVK?=
 =?us-ascii?Q?p10zMBU96XTfq/yrnxSZhZj4QXof7huOV0Gt9TUyoUj8URyS2HFy1Ny4ydtJ?=
 =?us-ascii?Q?9v02Z4TrLIm/YoLNMJpZFAnxUBPhsqpUBsxW6Y8Dcy4rupvsCPBgWNzLth/n?=
 =?us-ascii?Q?fkKHkLH8Vx7UB7MSUHL7EwtUntSBzfjtZKL2RRd59dMJRpYsx82dqdLx1f7T?=
 =?us-ascii?Q?Igz0jEobSpFSC2PO7BatxVQ4ZxI7Qx8RDI657WHXoX6ITSJZ2+9QLf+xR+LW?=
 =?us-ascii?Q?EHdXPgIKj5S01doHtG85ezJZqOQCeLwLZFsdGGLoT5PO/VaD2mFWeEVQruAT?=
 =?us-ascii?Q?VtEfltlX5U/QqcEgcjVx3t8Up39vO4GJmXFbGuMm2qlo4nyTfLpB3J2r/Mmp?=
 =?us-ascii?Q?YL9MokUwW9IsZCl53ltRnoiDpcSSAUTMh4Q1nNPRL56Ou+XWp/XPGI60u6a7?=
 =?us-ascii?Q?eudGf1+TbZYtW4LiF8cDUTaYIM0claMwgW6gYQyhXkaWtP0D2nKmNnhZ8pc7?=
 =?us-ascii?Q?8iKYXy0O6nxaN/SFuf5wx1P4eBH3KVytLXh57Aujx3of/9/5mUz1gBLHJmpG?=
 =?us-ascii?Q?FM+VILgNcNjOjEupPrj1Q2oMAZ2oRQ5QO4Lc4MTh8R78MMpLRU5NbburbxAw?=
 =?us-ascii?Q?g8X0igTnkSVClzCSIe/1GwncFaMxGZ11CzBaGzq8ANLXQnsd0roAdbovikLT?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d913bfa-d827-44bd-6588-08ddc9c38efe
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:11.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liu4vFGVtLkhMDtIFZDITkxlnml2aUNI7UREaxx7ZXn1DIjHbVZ7wTnLxnttC/VIN12tnHGxipvIDtkNd2hoLXKSoUkERrxvG7OPot5lV6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
$ devlink dev
pci/0000:07:00.0
pci/0000:08:00.0
pci/0000:09:00.0

$ devlink port
pci/0000:07:00.0/0: type eth netdev can0 flavour physical port 0 splittable false
pci/0000:07:00.0/1: type eth netdev can1 flavour physical port 1 splittable false
pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false
pci/0000:07:00.0/3: type eth netdev can3 flavour physical port 3 splittable false
pci/0000:08:00.0/0: type eth netdev can4 flavour physical port 0 splittable false
pci/0000:08:00.0/1: type eth netdev can5 flavour physical port 1 splittable false
pci/0000:09:00.0/0: type eth netdev can6 flavour physical port 0 splittable false
pci/0000:09:00.0/1: type eth netdev can7 flavour physical port 1 splittable false
pci/0000:09:00.0/2: type eth netdev can8 flavour physical port 2 splittable false
pci/0000:09:00.0/3: type eth netdev can9 flavour physical port 3 splittable false

$ devlink port show can2
pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false

$ devlink dev info
pci/0000:07:00.0:
  driver kvaser_pciefd
  versions:
      running:
        fw 1.3.75
pci/0000:08:00.0:
  driver kvaser_pciefd
  versions:
      running:
        fw 2.4.29
pci/0000:09:00.0:
  driver kvaser_pciefd
  versions:
      running:
        fw 1.3.72

$  sudo ethtool -i can2
driver: kvaser_pciefd
version: 6.8.0-40-generic
firmware-version: 1.3.75
expansion-rom-version:
bus-info: 0000:07:00.0
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h |  4 +++
 .../can/kvaser_pciefd/kvaser_pciefd_core.c    |  8 ++++++
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 25 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
index 34ba393d6093..08c9ddc1ee85 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -59,6 +59,7 @@ struct kvaser_pciefd_fw_version {
 
 struct kvaser_pciefd_can {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
@@ -89,4 +90,7 @@ struct kvaser_pciefd {
 };
 
 extern const struct devlink_ops kvaser_pciefd_devlink_ops;
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can);
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can);
 #endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index b553fc1fc3d7..d99708a9f00c 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -945,6 +945,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
 		u32 status, tx_nr_packets_max;
+		int ret;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
 				      roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
@@ -1015,6 +1016,11 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		pcie->can[i] = can;
 		kvaser_pciefd_pwm_start(can);
+		ret = kvaser_pciefd_devlink_port_register(can);
+		if (ret) {
+			dev_err(&pcie->pci->dev, "Failed to register devlink port\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1738,6 +1744,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 		if (can) {
 			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			kvaser_pciefd_pwm_stop(can);
+			kvaser_pciefd_devlink_port_unregister(can);
 			free_candev(can->can.dev);
 		}
 	}
@@ -1880,6 +1887,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 		unregister_candev(can->can.dev);
 		timer_delete(&can->bec_poll_timer);
 		kvaser_pciefd_pwm_stop(can);
+		kvaser_pciefd_devlink_port_unregister(can);
 	}
 
 	kvaser_pciefd_disable_irq_srcs(pcie);
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
index b6d3745089d4..194157e6b135 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -6,6 +6,7 @@
 
 #include "kvaser_pciefd.h"
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
@@ -34,3 +35,27 @@ static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_pciefd_devlink_ops = {
 	.info_get = kvaser_pciefd_devlink_info_get,
 };
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = can->can.dev->dev_id,
+	};
+	devlink_port_attrs_set(&can->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(can->kv_pcie),
+				    &can->devlink_port, can->can.dev->dev_id);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(can->can.dev, &can->devlink_port);
+
+	return 0;
+}
+
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can)
+{
+	devlink_port_unregister(&can->devlink_port);
+}
-- 
2.49.0


