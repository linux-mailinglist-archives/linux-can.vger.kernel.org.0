Return-Path: <linux-can+bounces-7502-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePmqM9rD+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7502-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:18:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB94CADE4
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C0731E57A7
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B30407584;
	Tue,  5 May 2026 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KIXUPoAP"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E7401A1A;
	Tue,  5 May 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975579; cv=fail; b=Tm9v/D2yaaTpQIEuqLRFZdJsKQjiC3pIuXkNECvdJfZBmx97ywCp1Uj+77cKG36Oy3S6W29mPtKIwKi1p+O3bCkARh85Q+sMpm14JbYThH897tIx3MXKiu0LcuWTN2XNubk7OuNSML1OINM0BSArhzdQ39cofiSAIvUcdrMAJJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975579; c=relaxed/simple;
	bh=cjXby2xYA0i1V+SALq5yg1COFu0MxmYdUmMgpCrEiHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goS4+PzHvimQiVAJlxhXL9af3w5qwbrcZ9c46igsUdDaFBIoEb5njMfA77LiokOg1aY6rRnLklSImeVwC5rs8Npp7JqBNiFyMYo4TdVdgu+8pDQ93+jya4XRR9a7SDVu9ghP5U95alI4Mo3gThcjaczrjeSomGdDBWumqzPwmYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KIXUPoAP; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXvMjDRWa0b0QmeogdawRgnRUOo5QZDjLvpK0z2I8COI6VUL0D+TW07BtjTi+26r1GCHCi8KUEUCe9ciRbS/g6wIB/lM9MpoT0smYxVqK9HdMyGJTn7oV6qpvm2chkzSSHXMDTHxBbV4cyKUAsJZHJxwTnH/QXOZDpN4XtDMZX5p4WC04POnSf0yk+jGLXXwW+NWFnCom+CmviS7K8rpFTEbwpdvmP31cJ20aIj5hgvZi3kFpFnghdX6zcTwH6CIhWYdiMMcWujgk/wa3xOvNZHwCnflNCIYrSdKHecGmjQ33x3xtakLc1ZGh2wCnpjZ1sIKSAgsOa2TM+R6ohggYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PAakOxF+h/O8eJYgvgni3uJ4bCyMHEff5rFPl2wP04=;
 b=uWa4++oToFqsEsh8H+1dexg7J50nAPvxxqSfjvS8dKENhNcwDCLcXOCZP6A5XKkRWEwHmlFjCAfixVq6e7gEzLFV+NXq1aIBvY+4RghaqLz7zWRTIX6VjT0PDQ5MgbD+UWSxd2Xq40vlR6zd+y+sLfIU59za4Ole81nUbnZN3V5RasNHXfaqeiMs7o7BC1LRpsOE+Q/iysX3y9NTvhnEzapK9NBL3Vv2HfwZhIsA0Z/MQhyFyks3UwyMSXKlhVT8sK9+LGV8qNMii81A4848CR1yZFvwo19pQP0vpsOrZrYGcI4tyN6XFi2vP4JLDxc3ncL6XytDW8CZ6eLtokAuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PAakOxF+h/O8eJYgvgni3uJ4bCyMHEff5rFPl2wP04=;
 b=KIXUPoAPk+fqlzYn1L1ewXTypvMb5RGJOFtuBDIJKsaSszszjhOnLhrCtGBPh8xNuGl8D76yfOpgkQbSiFZ+r27l7aN1xiMusova230v84KtEcrEzXp4V3QgPBXa8WVXv0k3MwkM/oObkvFz1m76zZusiES8zG8db1iO9N4SS41AimPLckCi4qbAgcLLuzctdWgIXfYNV1xwOMt9A76LK+RHeasXHEezhmU0IUFb9zHaWvG5e/XvhgITSGSfRqDWC7Jqe+O4yMdTCk8crOGGlZAl7vnxbiYaIeqq8flufVWqOUwjdMosSDJfeEF271hGvZ+AFLBPt5qUWTo2daVNZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:06 +0000
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
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Can Guo <quic_cang@quicinc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v8 phy-next 14/31] scsi: ufs: qcom: include missing <linux/interrupt.h>
Date: Tue,  5 May 2026 13:05:06 +0300
Message-Id: <20260505100523.1922388-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf5705e-0683-482c-96ca-08deaa8dec47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jUtMT1X4/OHu3HZDWSwXgFX+Ib35FSwVmZMf2JOQwGrO3q9z9XHVCtjzTOsSNH89wbt7WnYbukFYSvO1aBcY+wOK0yOpO1uUfZzR8ZwxeZrL6Yc8jzyFehePdsij4rJYPsxTqR3sscVEuqXJ7d09LYb8/XmV9VL8h7fRP1JTnHDIHYUL+SWjIrWzwh5QLsTlH+3t1BAPPfwwiirUtugRQ3F+rWDO90UoTsCdg6to27a9d8F2sFi5uVqFC28oTaFyo/b/zqnwXvLHy1roMoQCwseAxrqLmtmbUPyhylm3LDaDxg/MAs3CCGNjc9q7rDZDAXHPOOByJ+YcoLiqnb1kZKZ6OvU7PsF6p9oFo85j1Kusqk4iGWA+IXjG4NZVWGmkdFK9UdbpiHKJffRlLVCSQ0HOs7S72ISHqw+BBxHulyBdtHUytqLeavPn8I4uqKZzr8oOygveIcs71jZ4nVVStpfIbPLo2xHBZHGxYBtJkwcftHh3nmaR6TuzkyUtLqcfvBIu3hM56f/+aDQAKG2VSHy7KMJiugZ2h7PAzpg1Cwn2/zxPWEGpQZS+XDWMFYkTBAvUo0t4PzX9fjf+UAmSvsdZ1DFx5EVzJnjpB3AIUa/dhFcG/BCRRxDxnURrzEbguz0alie6mtMEurRR+OL1KiFrz+4etnha3FiJ4bCS96mbbguHRedgA11wCeMP/Knj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ibfj9OoUz67kLWrHkyMetFPVe4ctaVJhh8JkRzgNC3WwAW2TMscYFmSe3D09?=
 =?us-ascii?Q?bWarh/PnvuSMiehs9FjZhTI9MH8DhriUAWsEUHSHwhI0wFu/jZkBL2HQP4F9?=
 =?us-ascii?Q?XG9muo0xta3blEOalR08lDibAgEtY1Jrk678NqMmvCgxeI5ujHUixKNtS+sa?=
 =?us-ascii?Q?jBhfb64VRyiYjs1/znSfvj1YtNPKs/fOHzYe43VGW297lJ0YlLOro5xihzcW?=
 =?us-ascii?Q?KGXASD47Z8ueN02lwCF1yS8YTv2qzFjApGBv14HF3vmdGY8gE72RdqLasHtP?=
 =?us-ascii?Q?AXy1G0vJ9TXAbCsecI7zycA/9tRXbjugH1rBbcU8lVv01wxET7pim2QhnyXx?=
 =?us-ascii?Q?VKMh1YZKwCKTMh3QeW9Lbro6TR7B+VlQlE48UZH3A97rpGrP+/PEXFP9luEC?=
 =?us-ascii?Q?ZvyQvR1wL1asxp7BfFBRtWn6o1o4gK48K/hXi5iQUSWD2D+QU7R+ZW74zu8k?=
 =?us-ascii?Q?d7ftlk5bykNHiTceIe9YUAyAxLFACiRdMlmN2THmjcpTbN4uKSAq0JXTVNZF?=
 =?us-ascii?Q?FBwh++sPqxLUDMHMPJPK+fn3GXH3IBVKXasNnW+gna7A5Tgc6MpxBlBmlegG?=
 =?us-ascii?Q?mCvoc7Vq8weLRaJqoG6rk+tfUFIXDcD7eI/tdjrraUYWBnIJL8FJgR4GKQDu?=
 =?us-ascii?Q?AjaP9KCP/DNUf+a/NhSa1mJvPSxYrPzHgICeQOtRZg7JeDZn4G7zq4IeNiMe?=
 =?us-ascii?Q?i5dj2RzaP57t6RrGUP9u2f/dVqhvrXq0hPEJgxva1lCpkENvcsv3i3Ea4e85?=
 =?us-ascii?Q?V6c3wQWZrMnBt9dz70+knJ0W0yOQB0C5ajgen3mQFJxztdJx1D8bwpWq1t3Y?=
 =?us-ascii?Q?bHcMyMkvo0H6eCEwVFqr/qYAce5TwhZL8v4xS5fu2nnOZMQ1irHH6TPajrbi?=
 =?us-ascii?Q?10uH1f0Ba7duNIUPVYUSGqRfOzng7GVNHfAhUoK4XwZ2w0HsKdR6XQptSTEq?=
 =?us-ascii?Q?EGzHqnUQT8U+hZSNKFUoL3Ru/dWHuxfVF4pAl/oKGCuC91oVVzBm014ef/2S?=
 =?us-ascii?Q?BeDR3zAECiZB4k3GBjAKTaLTXwo4NNLzaEUra002KFFMCqGUh1ttOYixUtKf?=
 =?us-ascii?Q?B5fCDgitb4jCwU6YJV95/rzadB3yEZXoxMr7w/rkNHbcdfk89bQA1cdd7lZ6?=
 =?us-ascii?Q?VtLGsZ/gpnYlZyMQjowQwNkvDssFZtZgKOVFsF0J7/BMKfjv74xQBq30IIJw?=
 =?us-ascii?Q?JE8a6K89vM/E0fYWu1+ocjvF0GrkxASJHCTAe7DjOFlMlvOtmwg+EQFyq2ZO?=
 =?us-ascii?Q?gMaX2WzynVywYorCRCn0vvHvIpfZzJAi38Oot4GsgKNqQU/biYaXyv0yLCzc?=
 =?us-ascii?Q?IdER1zL2NguqVFE5+XRiPreFIDHOZbQ3F0LmcOL19ts69IGsvWwGTb5LIH7C?=
 =?us-ascii?Q?V15XC6GavgSZXXjzmhO6PgMV3qOlf5v2S3Hfezb6qUrUK0hagWTiD1LDWNTj?=
 =?us-ascii?Q?IKYM8C2EHus+KY8QCt427F9SsrRZYA/qKcwdWAn3UHfBtdE+F3lmAtivzf1m?=
 =?us-ascii?Q?2CuhkPEUqS9cvx1uCKWysASZQ8pqPvaX/BCxvb0q2VggxdfBscMcC40gDe14?=
 =?us-ascii?Q?PmyAToQu0LqKL9rK8qPJxOsqUQiWsD5uQfODlgypu/F8/MBeBjKLR0v8dAJ2?=
 =?us-ascii?Q?xKCMxy/tVJasy4KHonwgPPXTRzpOoyRVjAxT7qHYkrrU+BtF8s500LfD5Mb/?=
 =?us-ascii?Q?RYMCorJCgu7/z4rmDS/M4VsAhpc4lNlKXlNUpu6j2ISet6InyYdWoDJosG6G?=
 =?us-ascii?Q?iCNXcMgx3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf5705e-0683-482c-96ca-08deaa8dec47
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:06.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US08txz4J+xLd5xPB8wnxMG8q1h4OcJwgnW7sLaACwchLlvTa7lSKe2QMICvlTNQ+OAMuew1yH0g3PLpZzuy8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: E3BB94CADE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7502-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,qualcomm.com:email,hansenpartnership.com:email,quicinc.com:email]

This driver uses devm_request_irq() without including <linux/interrupt.h>
by itself, which would lead to build failures if the headers providing
this transitively were to stop providing it.

On aarch64, we can see, using KCFLAGS='-H' make drivers/ufs/host/ufs-qcom.o,
that the inclusion path is:
drivers/ufs/host/ufs-qcom.c
-> include/linux/acpi.h
   -> arch/arm64/include/asm/acpi.h
      -> include/linux/efi.h
         -> include/linux/rtc.h
            -> include/linux/interrupt.h

Whereas on armv7, the situation is quite different. This architecture
has no CONFIG_ACPI symbol, and therefore on it, <linux/acpi.h> does not
include <asm/acpi.h>, and <linux/interrupt.h> is not provided that way.

It is provided, however, through this "fallback" path:

drivers/ufs/host/ufs-qcom.c
-> include/linux/phy/phy.h
   -> include/linux/regulator/consumer.h
      -> include/linux/suspend.h
         -> include/linux/swap.h
            -> include/linux/memcontrol.h
               -> include/linux/writeback.h
                  -> include/linux/interrupt.h

The point is that <linux/phy/phy.h> will stop providing
<linux/regulator/consumer.h>, and this would break the transitive
include chain on armv7.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
Cc: Can Guo <quic_cang@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>

v7->v8: none
v6->v7: collect tag from Martin
v5->v6: patch is new
---
 drivers/ufs/host/ufs-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index c547d8643480..9a4913e254af 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -10,6 +10,7 @@
 #include <linux/devfreq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interconnect.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
-- 
2.34.1


