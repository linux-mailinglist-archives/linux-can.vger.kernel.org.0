Return-Path: <linux-can+bounces-4143-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C47B11EBC
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD9B3B5BA8
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5482ED878;
	Fri, 25 Jul 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="GnJ455dE"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA092ECE82;
	Fri, 25 Jul 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446917; cv=fail; b=sjlhhhgCMXMBMcHTI+MzWkujAKK0e/yKmdZ1+efEHtfjyRhax8DMWOHmQnIBBNvu1c+t9RpUoSlvgOlBeUruoTMDg6URIOtgIJM78J1w7QnAiqWhA1d9dgIlcMAiSE7MD6N10SKQuEoqV+Sz2DGpqQ4rnHsj2217Fo1dHrP2KzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446917; c=relaxed/simple;
	bh=DeOQFN9ntF8IQmCZEwN33C94aPyhI9oCF22XaX7+74M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LTjZh0QgcqVoxmfWONK0xqJaw5NbjnchqRphwf0JXHtdZLePgLlcGkfGjID6cZ0Z9MGBvZUTJXbR3PJGWK9HUAkXQ8qZsVFPNUFFbt9FGldIDO2JobiREi+W/W/HdKlMDpyoy07vk7NmSbSFWD3LwUxajrbaPXrFiFuWk/YyDhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=GnJ455dE; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEFHYbmBbb8AAbboEJbakvjHfds1+/jvHOZ6O8ykyYO8Kh0ZMNHYpnI66FSg3pI9v06BMy5Trc0rJOSeTZOise9mMRPzaW7INYmgOgSdfjnSolbng0GOZM88v+bPWEJfIZEx0DuoVR+SGGGMHHjfTfHW1gFgBOxwUuHwgHJKsJJtTosydY5Gu4jSTd4/sawP8bR6unZktxnZI+8koQhq4sPqpWkWXC9faiE+rYcRvXlMMkYif4Hd6gGnK6cHHXS5DzE83yQcVh+m2NaYUcjuKucfAuxa3E1zwo2bELDnsFXdWEtxnwhW2P11++s43hZ2PHmo+KX71LS0tWGhgL6EPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYX/+/9NZjWIkXzaZopG4cuUa022Ob05YA2uY6obG3w=;
 b=MN9rdCKkD373G5sK7iGk6UMUWTyTkk3RPxbK94nR2pY/fmkXrnlSHvNxRG6ej0vvydH2hYQ4KnAQDnMdraAoNJkmlfDe27OYNknWoiRTiD1ytmya0Q7v5GFtSg8RtbL6BarZlwYug0WTKVVHG9zfgrVM5ipg9Z4L/EY+kAEZVyG7/9QXTaoeH30gUskpudWCd1u8OppS0r3FPA+pYZpv9WAl6IyB9NZwcHfq3IVqVVDKLfB/1j0ZivSaV476OBsl9eaSm3TMC2Exd8HxK79nBwCgh8tH/TdY9zO+vJ3dAN+GdZlBFtBXzsDVRsZGQiVfnompTDXi8Iu+aSNPz6QcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYX/+/9NZjWIkXzaZopG4cuUa022Ob05YA2uY6obG3w=;
 b=GnJ455dEyVbbvwL9XSp4WXlqnJnxjJt53KB5W44ILPa8RZOxudnsEw5kCf8tjPeRf4eIp3EZhZisTs/z9RMjWvyfKU4130ct6WAFwXxUwnf4yRyPx4TNKnpaYYzs/HS073OWQeaS/NCzRh9WtLJ4GvrzRCTB0Yngd/YyWfpS3jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:06 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:06 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 09/11] can: kvaser_usb: Expose device information via devlink info_get()
Date: Fri, 25 Jul 2025 14:34:50 +0200
Message-ID: <20250725123452.41-10-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c246833-d3f5-46e7-0e18-08ddcb77af41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGFx2zOpEJU6mT489IlJkADIw6qubXjG68RnGi3qgjiraoTO5g/E4sxPdRZZ?=
 =?us-ascii?Q?LMMRYUNzkfSi/Wyxokqzzlc4PrO/NVHHGqarvr1K/bLuKreA8DsENN0Ztza9?=
 =?us-ascii?Q?+znR/3xehJwHzNaqJ+vDKOnYOfxeZMWZlfysjuyRFMPysxaimV280d43xgQX?=
 =?us-ascii?Q?DrF6ZbgYgnHx3Lk8lb3U95xTXEdj2BRNnqWSgamhn3cYVN6VTHipMiFBOIRA?=
 =?us-ascii?Q?J58ipEGg3SoOgrGj+D5fEBO4nQGH8UauuSN9Qx1phfqIEwYPnCBnIj9VxPbe?=
 =?us-ascii?Q?VHmUSOrqmV4CYeP8ltcIWk/mQAsptfXURKagLyx/HVmPz49wJw4pCnJjm1Xx?=
 =?us-ascii?Q?N296h9JYCZ6K93SD0JaXlkhGdEk8G1kXza9inihP9CwawidEJIwOn1v/nxom?=
 =?us-ascii?Q?CyxkvQWeWMQKmecuormLs/i0ZSWWQ9H+SEDGc3yB7ZITNhvrMEOkJkU9nSEJ?=
 =?us-ascii?Q?8agI1Nru/b1XB/JsR8XU/LspLlsDhq5wwyyZy5weIk88uKYzi4LcOpObw36b?=
 =?us-ascii?Q?LVG8vqV2pBkSJTlCYtifZlULCF0vvrdwJzqbm6jS5Za3MfBzqaAaVzmIpZr6?=
 =?us-ascii?Q?r2eTdmMAbHTK8bjy9CpbP2goy6dkqettEjFDl/EtmLD1qE3T45qEuBzdG0gG?=
 =?us-ascii?Q?csVWOJPpoPjHm/erbllE7mGzz2WJ2He2Lj51aik2MZjPs//Nl+DHEn2iAOxD?=
 =?us-ascii?Q?6p3+R3o0L9b7pqAlbSD94hd4bKa/Y/rhTnXRNj2Iyo+QgFYYgNIQDiU1PMnq?=
 =?us-ascii?Q?ZhUJxfoM60EwbdcSKtIOEIOEqdCiIyyP6zhwU1xXEH2ZMZ1LPf9cOozN12dL?=
 =?us-ascii?Q?0d/h7YXoUDx72L2jalwhdC1cQ2cyemJoYVT5bkqrNcae3FZdeS9vgk6wHszC?=
 =?us-ascii?Q?gG1YKrzwAN97MrNn6vNL+bIUIzprT3F6i76xAa6IT+nDXUajEWW/D/JztnOZ?=
 =?us-ascii?Q?tQC91X5tSpngXORLbcHPtQ8ZpuSXUlyT6bHp7bBXLoZ8U0IXdRKEp0oHgStj?=
 =?us-ascii?Q?heaXGGozngM2TxU7QYUW/OHGPXfq9JayReqwnwCCaXK/Z5dAclvh0Fw6qHiX?=
 =?us-ascii?Q?PCHht31bcdAJcwLXtvPFUv83g8fkNohMfWRjB3E016tju5AyHzNe0LGK/+FT?=
 =?us-ascii?Q?7WUJbyKxt4GT0v6AMNcJ9JyzqaEi51zWLsZZ3Q7F6i4SeJLpKOzbvVg7oBBl?=
 =?us-ascii?Q?OjzhaAyXjnkIEe9a5pJZ37fqCENiHtpNEkc9BD75rm5QpZ67juRyKr9jYJWA?=
 =?us-ascii?Q?kcHaoXxp4Kqy9RPi/HNLuo6ld2cY465/0bWs/dXQ6gtcFAMSdL9To2GHtqD4?=
 =?us-ascii?Q?0h0O0Uvto70HIe4ztA08c9kCIDczEa/9+/g1WsLCdBpLUkExw/coBlYzephz?=
 =?us-ascii?Q?nM0tD6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?70CRUVtRPByhjiVQmBDrCBGIPAqpWUqq2Hrjs8af+J/1xLceB9LzTwVV+PHH?=
 =?us-ascii?Q?4s8mx+tOKnfYmwhbsz2pIH2lux41lWMxv+spvBgcjUy4nqMla4zvaJD9ZLq6?=
 =?us-ascii?Q?m+WpJuKI14aW3thhhpQ3NpOQgdzAjfz/BAhewj6yfz4/RmP/bViqgscXQAWF?=
 =?us-ascii?Q?QhMhLaoqFdbwm891nXYkWsderc1fSD722i3qF0wVW5g6OWiUdH0yzXupl2s3?=
 =?us-ascii?Q?vpsQ9tL/rBfAFS9IocV8a3AlD2BcV1y4T3a/K7lEh8fRnfpXZj7WpNMMiQwE?=
 =?us-ascii?Q?bF4DJ3j7ABr2LVu3B/mpzi+DqUUe/Pwl1GQsRpWERn1CGHWR5f0lClKeCDBi?=
 =?us-ascii?Q?e23r0VpHBnYN2DWqXS4k4iwCQ1hlZLL/edKVCZ0f/LTdzS8yIzhjVkAao1yk?=
 =?us-ascii?Q?kgamiDscfK0aNLmWxZkbQQ6EaLZ6SbaV1VYpuwnvUMVlqAh/i8CfvO5FNDBs?=
 =?us-ascii?Q?jOKLh1+cVNZDKORKPrqRTpfhz4i6DCdbKSslGKcoAu7gtVPrIiIGRwjVNK5b?=
 =?us-ascii?Q?3Bjyyv0jBcGMuVOjo8URrpPMHpvTTQfJ3vVJrTwInXHa7EA+q9kwHtx/OLvo?=
 =?us-ascii?Q?z0XGMtXzH8JkKEzp63XexLm13Ru7mKsBTr1uUfo3iVIRAbdu7MovDdAd5zcR?=
 =?us-ascii?Q?fHZo0RwhwmpabgNxlI0BHlTTlMJ5BnJZKXJonyB1wws7vIp+VcoTgujoel8c?=
 =?us-ascii?Q?MlFGwShEoTu/p+I+tRFhuqYIeLrujagLMnnhDbQ4TrVPNJl1uV9ekwbbYyyP?=
 =?us-ascii?Q?zVF3KLvUNnHAV5AQLLvyyIGKrXsD/ZL28rJvjQJgMuE/GYZgiVclfUwoQtp+?=
 =?us-ascii?Q?82LjYyB1nyxmGznM7iGTlZS4ExpWVCSv0/c8eeEikvKeuSJb07qidxWjxQS+?=
 =?us-ascii?Q?UEzPY9a6zVCDuNHQustzv2MhuyhgQgK8Ph/2GyQpjg15AgNaH34rcqMjle54?=
 =?us-ascii?Q?tVrdNjsfiJMCDRSVdz/+u9Sx29POGfhp6CMnXt9n5iPbl3VEeHWY8tShOYxX?=
 =?us-ascii?Q?c2qiz1hVTjNJQMm10F7kA7SNOSqX8LKE0JU2qAIjuTaM8Yqo/+A4orFn/BKs?=
 =?us-ascii?Q?7371JpvaT2QDwVoDj4I4zEROt0iSupxoe9rOlJRXxakzJqjsKzpoRcAJ2leU?=
 =?us-ascii?Q?YWEKiGvAnPPBD8lC/tNj+IUaM5HOMQQFwUrhgzJBukBktCPyrqvJ15Jnwmfm?=
 =?us-ascii?Q?DmAMHKMBB5+rGG21/I5yPda6MGEVDmiBfBn3ru78HZ4onanXCzsB76YsepH5?=
 =?us-ascii?Q?d4FKF21IYBmGJgaSYu8ZFrNW31JoNLLsc1na4yTAWa7kJsLZcUxU8Pa3PBfE?=
 =?us-ascii?Q?0llSbod5u4ejZANBDtbfh/YnvxijKpE+aRALw+Tud6M+ykEAvhexmBDti2Vb?=
 =?us-ascii?Q?Wv17MrxF/8/0jHJRbtXUuV+sKXOGeRNoaYH95ZCyoJeMqLJM5abdu04Nmr1A?=
 =?us-ascii?Q?iPW7de52+Zk+C8CdSvBBTQcRpFkSc9tiRI320RKTCiiGuyFG/G5fqoTVdrMi?=
 =?us-ascii?Q?98OQGtUN8oncL4KSjFnK3MFBqu6iS/ZqPmdZ/uTnpQ7h6Ztw9xftOsjpXgJC?=
 =?us-ascii?Q?0nHt64E+hmS4Laxbl5meEUethE2NsF0vgEPvFL1TcEBo2/Jo/Fn/OO93zste?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c246833-d3f5-46e7-0e18-08ddcb77af41
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:06.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IXtS/XYcxDlOV/fxuBoVi0WzNb6FEwxhXSY9iQ/pREzzT7I9ZKqWXXMYixSlouE8EyNY1cHAzyWxizZo/uHDjg/ob712URUfHmjcRCfwZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Expose device information via devlink info_get():
  * Serial number
  * Firmware version
  * Hardware revision
  * EAN (product number)

Example output:
  $ devlink dev
  usb/1-1.2:1.0

  $ devlink dev info
  usb/1-1.2:1.0:
    driver kvaser_usb
    serial_number 1020
    versions:
        fixed:
          board.rev 1
          board.id 7330130009653
        running:
          fw 3.22.527

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol
  - Move include of kvaser_usb.h to previous patch to avoid transient
    Sparse warning reported by Simon Horman [2]

Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5
[2] https://lore.kernel.org/linux-can/20250725-furry-precise-jerboa-d9e29d-mkl@pengutronix.de/T/#mbdd00e79c5765136b0a91cf38f0814a46c50a09b

 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index dbe7fa64558a..aa06bd1fa125 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -7,5 +7,56 @@
 
 #include <net/devlink.h>
 
+#define KVASER_USB_EAN_MSB 0x00073301
+
+static int kvaser_usb_devlink_info_get(struct devlink *devlink,
+				       struct devlink_info_req *req,
+				       struct netlink_ext_ack *extack)
+{
+	struct kvaser_usb *dev = devlink_priv(devlink);
+	char buf[] = "73301XXXXXXXXXX";
+	int ret;
+
+	if (dev->serial_number) {
+		snprintf(buf, sizeof(buf), "%u", dev->serial_number);
+		ret = devlink_info_serial_number_put(req, buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->fw_version.major) {
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 dev->fw_version.major,
+			 dev->fw_version.minor,
+			 dev->fw_version.build);
+		ret = devlink_info_version_running_put(req,
+						       DEVLINK_INFO_VERSION_GENERIC_FW,
+						       buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->hw_revision) {
+		snprintf(buf, sizeof(buf), "%u", dev->hw_revision);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->ean[1] == KVASER_USB_EAN_MSB) {
+		snprintf(buf, sizeof(buf), "%x%08x", dev->ean[1], dev->ean[0]);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct devlink_ops kvaser_usb_devlink_ops = {
+	.info_get = kvaser_usb_devlink_info_get,
 };
-- 
2.49.0


