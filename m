Return-Path: <linux-can+bounces-4039-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77431B0ED4E
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA384961B6D
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B225A631;
	Wed, 23 Jul 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="doblUUde"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AC27AC3A
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259597; cv=fail; b=uXosAhdnLPqfg8Tk1KPWLIMlUd0bdlwe82MOV+aq78YnjnOdrqhFpZmFdkG3y81xAHhfoPslAJcJQmcpto/SgnS2KbdV0FFwj+BilOmdK9JhonrGJRIQgK54BIsyVcfnWnD8nrOFvTaKk2k8yFlMbNl8EI+yawSwaZY9J8T1+6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259597; c=relaxed/simple;
	bh=yvcuLNl+UgM9v0L4uJPefyzhXogOOsVA6zbwT9nbymE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEc+KM1JVfjk+YK8mbs39x6xp21euvzKaTxGD8dOhoT7ci9Dqf3sOAPKdcob9IxrG1dWxl3ZOvpdyID4X2j3vTeQakXHbbxiB5eH1vrkTeEeELPyHLUnhQPDcbl7fRvbWU6ONh3tVHskYWTGgffWbFbPe/mQqALXymjIa/+JbzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=doblUUde; arc=fail smtp.client-ip=40.107.20.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZ0UJyNm1XjRYSYX7ajVtWuBIhefuGOyeYE/6/J8c7iaeQNkJJU+xFUiqIsRoOVae1yJ97uXwjQroVithQF9R04Vxn+M9anu6AMDoIenIVy0aVaj9qX7tT68JLcVHn2zbc0mmHT8Ec2Ft7FRgjkux2YwLHZtkEptFUG7oChtYNqYlINcFYpYUhb2vOGnQcw8Fv91VScinNYyAmPi5ckCV1p++M0tfA7ygiFx5I6v0BbPuhtVOwAnXUNjHAWhm5hQTBD4QA01+4ciK7U6YR44kuw5wM7yE0b4/frgELfD2XGN4OkYstK6FmxLZrlmcfDPtmgOtWbXWz4fwpZBHmh4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC4VxCGIbnItqsR6tbdT8MvGnX867zdca6XNDO+DcW0=;
 b=yjUD8PF9NJ9oB+q/1j4ZUSjqMl3cNexQpVI57Jxj+SB729RWyPl5t5cnbICHCo4/To06gaQPiU5kAfyes848ARSz+0Xiudgj2wnA5MK6gIXM7Z0NQWkR3fdJHJOcbq1UAQ5+uI5QkWjjAxPnYQl1ruXVG+B8QdUmxOIlyThBXhbhNfhbRKy9A4c7lsdxvBpcCvwb2rJH4FHxteVlQ0ZKfKtHReTrUV4h777rCn+7+3YTDN4ICQhsmy5TtRr/4nqPeDWcTajwlDEtoWrurjaLztNYM5GiIB0q9xwFR5YI2txCwwBynr4fEO6dtkHcN0274ZMm4WIxjmo1r2VIp0BB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC4VxCGIbnItqsR6tbdT8MvGnX867zdca6XNDO+DcW0=;
 b=doblUUde/4CFBiBJmQlRzN5E5zdls1xQXDCHCW3TvsEgUmVwfMNoLDG6+7UykxDdEed0zEq5J2bAjXGbCEHMwZrllwtWPusrdE2odCwK6GH3YtcCx6rF6DYDWbwjzU8JFxXJ+K9VuA7v8Tu0PvWIIhvIf5DVPpqahlDqxXZAi4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:08 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:08 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 4/9] can: kvaser_pciefd: Store the different firmware version components in a struct
Date: Wed, 23 Jul 2025 10:32:31 +0200
Message-ID: <20250723083236.9-5-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ffef470-6984-4532-a3c4-08ddc9c38d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SBvVE0WlnwBAT0WvFcMXkOBzqVF2DkIyzvYFpyC3fRbJHLTx5wb/vQzYnd1/?=
 =?us-ascii?Q?gkTVmUGga13miFGRHEdcx+m9suxA56FkkIThVBU1A7B33c9L+mtJaFkSW7AD?=
 =?us-ascii?Q?gGrp4AsN9XwSnSNN7jSOLJ+ur94rDVLH8ODHjn403C2AlyvkWIeHe73Z7L5q?=
 =?us-ascii?Q?p+jVnpFr7x0ka+mRAkJHFVYedeJf28ThPzxfWJHLoZpp/x27Z45lP/zxUv9R?=
 =?us-ascii?Q?XEvoFWASg+K9DYLY3fuK7wMfc5bJwae1vudECYWFllPkcKHF5ECbR23tovFC?=
 =?us-ascii?Q?7Rn/G1md9aMcuJbJ7BXGmhiIM315P/2LFs4gI4haAjH7TSbgx+k/OcgX1JNl?=
 =?us-ascii?Q?y6iM3Q6AMdZpgG26U3h2kpivzzruoxhpYtcxbOyPAtWRnqyVCjO7oX0UdVwY?=
 =?us-ascii?Q?HhOY/Rchh+gzMO+4Rq/8YIBaYtTEvx6cRfORx2SKKW5Cu0o/IEx3WP3g3LgS?=
 =?us-ascii?Q?yuHGn1HufC07YajUGlbVJevcB6eFyLFVd4q/QIQOn10GgI/CVJSgGIS0GuEB?=
 =?us-ascii?Q?kQufhCN6cQhU/uv/DVz/fZyKhdfS+h4Sud9ylfhWtmSfcI32fgvFjJ9cCX6s?=
 =?us-ascii?Q?ms/gBjOzJJsBTaTyw2UO+3QvSFr/1Y2xuHlErSYQXXGm0IrgSRATevCMyLpj?=
 =?us-ascii?Q?xNw/lXdGEq/gKvdR2ZeGa1yMNOFkxi2jJx+tXAJ5901GrTy15wMzLDBf2OVB?=
 =?us-ascii?Q?Ey3rG1n5IgN7cp/8HhSYqeIHAchswm0+WpPMvtjx73L+aAexXYRnsA5lLEZf?=
 =?us-ascii?Q?rb4OOJaodVSUNOSMydCtGAGpyJ5ODTpHVzza2DASfdlBASf8NZ6ZP7eSA/QQ?=
 =?us-ascii?Q?ltQDuEHil8W8wVdVEhxh6znVf/A/5ntuGC1NIbuAut4k4+RwhvbBaAom3QQU?=
 =?us-ascii?Q?wZNekTb5iRNtjAI+DoVGY+OXERRNzu4QDjzwk0SRyQAsxPLbvyUX0Yt9y9zo?=
 =?us-ascii?Q?GqU5N1KWU3USDLFflaSHyJ3emSHHgULxTY1robYv+lPXnC2SWNlgfHt1Kx8m?=
 =?us-ascii?Q?64Wfipu2Q5jvKVcBclSfAUuCMAfLT1dLz2Z4EyZt5yU/Rj98NLNy/GH6La1z?=
 =?us-ascii?Q?fn9QYVXhoIYrECTP/mWGMLOWKPTzowcS3poCCAhWHTeUpV1h06I/BUhxzb7/?=
 =?us-ascii?Q?cAego7exuBZ/qK2nWgXjtdPmoHG9ugE2RZaFubgyq6CNEvTLlpNorGxr3zZb?=
 =?us-ascii?Q?GydQcDUpzvgcddFip4BfgvB+9F7vCnYlqdjJq7wrdtF7XcuSwT4Mtqa2bMGl?=
 =?us-ascii?Q?hkCxwTWOZ89KVEkIJOgdis1MFJkeiyyh5rscpRlrkhd7wobeh2uU6gqdGAxp?=
 =?us-ascii?Q?gqLwh8MuBHWGF2+MHh2TKJAJq8X6xvu7omPIp0KEFei+tvp6myAWP2ATgbN/?=
 =?us-ascii?Q?q0XAparjHWPTeUmXjvi1/uIf6BOJWuNUM1Pi4kc4z8v5EjEL/oqE+jAXfp9s?=
 =?us-ascii?Q?ejN6NP+60hQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAJDh1L4uWzACHecKqBG3wrp83/UgjpjzX0YJ6KpaZ+2Z+7SoxPbMc3cWOwQ?=
 =?us-ascii?Q?feWqkPoFNx0Sr1hxNEBeHu5fFKgneyGyZKfWTWH4BFEjcNs4W5YdfABqSZOD?=
 =?us-ascii?Q?WNq2VNL0YHL9mjet0pExA/nEQG8w3GXMrxupUzYwA2OTWApwr2ClD23Y1Gis?=
 =?us-ascii?Q?tcFIx6/ekkg2OuI4hyPCLrjqsjx5XTiqtxk6WB+3zpOp4TAFs9TYr5jR8V6A?=
 =?us-ascii?Q?yFiJ7fhdqhyX8bPLE9YtQeeFFy78Wbu8Veo3pNGGsnlij2eOlhTdhqnueMgK?=
 =?us-ascii?Q?7nyzpVQCajHDRz3++Kzv8tzNmZRHq8GVLJicO1GqxIgsxptUlmaQ5oQWp/U+?=
 =?us-ascii?Q?TSHCsKpLwZ66YEDpc5fZZOIgw9qiaH/usqCM8EsyVUYfsDBKpx+gvxxTtshz?=
 =?us-ascii?Q?+YyJgCWXf+h1fuvV6Vs/gX47l6j/93Wsriu7t+4zl0gOZUoHC542q0SvFgTj?=
 =?us-ascii?Q?X9yKb9sscbB+71Y87IXllUnSSvy+MXkw68vGZbe6mo2Kn8ejRAFLwnhD7xyu?=
 =?us-ascii?Q?zggiAdXcmiwswNXmCqCcTr4zJTO9tTwms4oq0Fak8mHJQctgcTCVRWA5wPqh?=
 =?us-ascii?Q?mdpbuXLYMUbvCbCyTLLCctDYbaLqtqkiBgsG7eBfSTmBXMIHy94kqljqhtdI?=
 =?us-ascii?Q?yM8j1cbBhH+akyOqr/X+m5o88AenoHey17Rc5aQ/mfrsPNmHDywZ81Ohstcm?=
 =?us-ascii?Q?ripMrNpYyzrUIQW7L0xRc4ei6CAkvXP9NwMUT/zvfS5vFtP8l4Bs0pl5SzoP?=
 =?us-ascii?Q?jr0O04pI2h/AcxBG0Jmp/Psdh7wIpgOm+/vBUjTSOc9EXGdwMPtyKyI7oLWT?=
 =?us-ascii?Q?Q+hyHEulzP0pUp4Uq9Q2PGv1fXP18x6Y80rMjwsQAQTq4hPmn5MvntJnn8yI?=
 =?us-ascii?Q?mecwKx0h8ptGhhuAu6k11nMkL+x2QEq7uDNqvT7gwFEjddi2wTuXeziITP0f?=
 =?us-ascii?Q?VfKwfTDlSG7gO5whdFsRjiGC2INt0CMbq0oXV+M8KZqmCCnz29X5c+E2niYc?=
 =?us-ascii?Q?N9YLBBqLbmp0sDFH8th57pb0de7BpKZPhZpUuAb/VDWVqIjiu2rH9NJsqLAU?=
 =?us-ascii?Q?lOsr1/jMKqRGziRqFAHL97sFui2NnVu+etCtB1YjssKOGPDbQKFsI0X5SBnL?=
 =?us-ascii?Q?TyP7uN89aYSjzlgAUI+JEfqq1kBdW0agNZrncCloHW8neD3s2fwyoNttlnjv?=
 =?us-ascii?Q?3oEt+TdAn97UQNVq8PRwXN+duOLv+8Ia0C1FHPSlxNeyqFc9CtZI2JTRBfUQ?=
 =?us-ascii?Q?YYHfzsnIDNMWJDq8a1rtEZou2jx827y6Ap7q1/dH92WxYSXjx1JQxPahSU8i?=
 =?us-ascii?Q?XsVnEb9EnTTXxrL9JLdtAQ43mAEKmEo+IsgMTrZ7cYhCdltkRiSfHMVxxEcp?=
 =?us-ascii?Q?ksjXtmMcmYWjB7uO8fdF9YSm/QSCdNTimMln2vBjgMet7qWR5y1rZMHMicC0?=
 =?us-ascii?Q?Vpe/IZr6pGw2GUAIOBDMxTUH3jbQoiNa8CTDvIaWuZ+A1HgE4iQrrjrmy9as?=
 =?us-ascii?Q?pfKFlhJKsTege866lnCPxVrjTANLvOGupCJA3Ha5UpNBVhEsTrzYFrj3Xkga?=
 =?us-ascii?Q?XAJ7XxaHGuCwobkArwg3Kwyq38uVHsxJGvh/Ttdj8xCYkDkDJGf/hb6mkLeu?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffef470-6984-4532-a3c4-08ddc9c38d44
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:08.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aaGnjod8OhsakU1v6Twj3T7xKd/YcTSO2zAcuhWv0NT9jnpGFsWFznzNrokl3XhlwGCrVZd+WQGrMLuzTvpZjhtybgM5c9ko9c7AEsab9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

Store firmware version in kvaser_pciefd_fw_version struct, specifying the
different components of the version number.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index f2722473b865..eba19819ca43 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -325,6 +325,12 @@ struct kvaser_pciefd_driver_data {
 	const struct kvaser_pciefd_dev_ops *ops;
 };
 
+struct kvaser_pciefd_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
 	.serdes = 0x1000,
 	.pci_ien = 0x50,
@@ -437,6 +443,7 @@ struct kvaser_pciefd {
 	u32 bus_freq;
 	u32 freq;
 	u32 freq_to_ticks_div;
+	struct kvaser_pciefd_fw_version fw_version;
 };
 
 struct kvaser_pciefd_rx_packet {
@@ -1207,14 +1214,16 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 	u32 version, srb_status, build;
 
 	version = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_VERSION_REG);
+	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
 				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
-
-	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
-	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
+	pcie->fw_version.major = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version);
+	pcie->fw_version.minor = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version);
+	pcie->fw_version.build = FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build);
+	dev_dbg(&pcie->pci->dev, "Version %u.%u.%u\n",
+		pcie->fw_version.major,
+		pcie->fw_version.minor,
+		pcie->fw_version.build);
 
 	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
-- 
2.49.0


