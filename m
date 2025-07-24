Return-Path: <linux-can+bounces-4095-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960CB101E6
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38804E01E5
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1C26FD9D;
	Thu, 24 Jul 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="OCJAO2ef"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901326E713;
	Thu, 24 Jul 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342253; cv=fail; b=EVMomyM1hdWcZMXf0NRJhkTBuLK5DOveEiNF8GBA7LIuxGSKNq2ZtlGviiduSM5NL0yINprI6qi/Q3qkJwJVQJ3Hs+HZaVGjhpkjbrbwfz7XZ8tsOA6acfrqLKUsFe57bPY48Q4ymBsMDelnNJqwI3jkxFujRY2hDl9zQjwCpI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342253; c=relaxed/simple;
	bh=V6lX0am4bVehUza/+EyDjxlE/3wjiR5Lvp8qBeLGT6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSegJt1kNFbiBTS7I+ueaNmDQ3Y/GG0+rAKXoNMgcpDKsYlgh1yXn6wL9jep9l+Tw53PyKS2kNYUnTsDDy7XzavlaPl0qDRF7yfFM2kfDUCAP6FBAUBRUtrkhbuG4nXSbd33+tXSF4cE7TJKj3xETE3+GdDv9IsB+o2chCQU9k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=OCJAO2ef; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8VlJo7gj5Lbx9P64lXzagirpV5JExhmDuioEGRio7IGSKgDw+3TLz6NEyJetkjuoF4jMtyZN7l4Q2IM/aeeLeQkMvcnitt1AdhbIqrjrTh2s49T8eZSLgHN2gYt92/nOkrRvximfPjaNm6ucdTz6IocoqcO16yYs+JujcXIUm428rhM2Nayci5R4tQrIyc3KdjJdrLFgRlaN8vwFaD+vPXsDwhVNaggem6FfHBnoRzWxjokVPkQJ/vlQU9vF1FEtGtjoXo3ENL1BmroKXRCe3yzpV+VdBk+U9PQpSPZ2iHHOODeBRhxo9TRpkjhVoyOcf10YCRfBaN93a/tPF0LYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJpEUCm3JauC2FYf6SPRn0y/0W7/sY27pk06khTrJCg=;
 b=cciwDWXxtZzZxoH01PBgMYTi2CU+ggcitKti52LxNDqyLHnii8uSSQRbn1TL6z2uOrNWgN4/JI0thcJzylOOinHViUfEkQD+i7rDJNzyPjbEr1cfqgpSVvHj/eLjmgOcYotbhB/qYZpSj4LWjfc2iEBDpagFUNE5u0QiaumhPJo0SvZDHbJ/MPJBAwbp/vs0MKZEdGEExeKLEXArhDYS7mWa2Ho+4qcn4DdszuNFKfVKdSjRy4llB3TJRvBywxv5TK+b2YhdtpNkZiRstdpUURAWEp1a5LlLN8xKz/t5mtAGjkvgsVoyodYowadswgzwVqY+NVNZgIXIe8360OdbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJpEUCm3JauC2FYf6SPRn0y/0W7/sY27pk06khTrJCg=;
 b=OCJAO2efzYW7jPcTg1D5+gt2/zCtoa+tOwvwM+pY2aYK+alf4Zp3cZNH7kzg27hjNxKoG2JYoTfQETbbFKSBsvDAhDivirNZ66ftkRGHFfoB9CotRS+/rqt/SVCdmFD4gHSgx/YUZHiH6ElM/xYUGuQn54WbBifix+o89JZKNw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AMBP193MB2850.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:6ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:40 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:40 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 10/10] Documentation: devlink: add devlink documentation for the kvaser_pciefd driver
Date: Thu, 24 Jul 2025 09:30:21 +0200
Message-ID: <20250724073021.8-11-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
References: <20250724073021.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AMBP193MB2850:EE_
X-MS-Office365-Filtering-Correlation-Id: bc69d8a9-1c07-4919-dcf5-08ddca83fdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vkCiwXnJy+ixv9wLNa+0GJc+ojPU//yoiDwUArhfN7wKOyfyV/Krl/IyU0ur?=
 =?us-ascii?Q?jdeJKBwOVIgj2UIUGWJVIKxNxb1JQf6Zdre4WCItTaSD1C4EX0I1eVVC+Bo7?=
 =?us-ascii?Q?4fll0V0fM2mPwJCfIesPjGFbgtg4EW3fTPl+o7p/Io/R+R0n65YooNAoDXVK?=
 =?us-ascii?Q?vWTFgITq7JRGPmAvXLV1RlDZOxhK3Zfmsd06KzQ1/9KAja/+lGI1K/YVR5RQ?=
 =?us-ascii?Q?Qebicnh+Mca1rzo9Rhbmf4C2b9+Qccdoa3golTkn8FEgGjGXvbH5jgYOt8Pi?=
 =?us-ascii?Q?VJuBUyh1C8pzV/I4Xaq2Wy1vj/wBjM59ysWD/V+O87JRWWwDXZKI1YrQnJPl?=
 =?us-ascii?Q?g9ycgO4pYdNaQxNybN3gd912/0esFr0Vox53xPXoJm7d1x4IUr9GsvVDkvVh?=
 =?us-ascii?Q?K+Jg2c3tPTxmCTsPNnV2r9q2mbzwQBcBm58AaLLtVo1YwUlps9oTmbEywlja?=
 =?us-ascii?Q?HMDMMTWzHPGYgbOteipxweoGljTb0G10/iiCjwekIagGy/AfNIwa9CgfFNeI?=
 =?us-ascii?Q?EjpS2MkSaIMgOjiLrXA74TP4zB2p1vRlMFyXw4y7fZFVncp4W2bbLKXvxMVS?=
 =?us-ascii?Q?6v3jkOj3WnWS9KgpU/GQHh52IdN3nHkjGJkzplapXhIoJvSKdlrQpxCsndv3?=
 =?us-ascii?Q?RZIUnEreqlZx8RIAeYananIILIWGDJvrq9SjpWQovyK663YlPE1bIX93mF77?=
 =?us-ascii?Q?tj19Ksq/ihp2afOuAmoBGsTpVUkzuefzWvJz7zFcHrxxph1sstuhzfdtMB3U?=
 =?us-ascii?Q?acRw+5s9cO8fmjIhD6SbHXKV/UKTyWsQfn8jEVrmn/xS9nX13d+sZfT1r4/b?=
 =?us-ascii?Q?+8WIaQhyduPNA0ljDLkthvCRBtKH1W+TTQnqW0wVeckSNtLZjkywgQpSgFkB?=
 =?us-ascii?Q?eSe0TbPmhnHb9NEyi92wu8u7JQt/pVA82wxwtPbf/v9tFz+HOajnJAL7bvKS?=
 =?us-ascii?Q?8wZzNPxl6F+/m0xqYTMgkVx+3ioUibJn8IqLN1B2PIt3tbKZ5AbKL+7hp5vH?=
 =?us-ascii?Q?Hg2EzetuYSSw7RfVTfzAtg3YsAAmBHy11jK9cRs9z9RZdntkm4J9lRHCLd6R?=
 =?us-ascii?Q?evVbbmEMlg+oq3wS5xnjJdFeXHfRkNsJt43wzJd4eeKX+9BQJn2uBmZgCSaV?=
 =?us-ascii?Q?1V2VXNpwNu3h/31draXnIBvra/tKNEHyRdMVuDBtV94LxKAu+GdLkhhex4kN?=
 =?us-ascii?Q?QwP4FM1aFiqLUjp2OhhL6Tk44QHsKwvtX13m9sKMQb5pcNXMWFs0XJbYU1lr?=
 =?us-ascii?Q?AqhDSAP/5iO5hOABYmKAQixNPglTBxMkxLLcpc6HQxZh2VK8Raa/cdyN/6JT?=
 =?us-ascii?Q?LiC6cLIQXeOcbWX7iVzZA4IUk4FfjmwETn9ffC1LBbv3EZhECWb6mU2aFj9G?=
 =?us-ascii?Q?mY4ZUZZkBntKzFL0GMhayKbruKB3Xc457pE05iuD1+9nh5foQxCpnSjxtIQb?=
 =?us-ascii?Q?j22JMG9sT6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRpji2DfOAotb7XzCFkWyRfRTbPTvWfdyGla04BWMAFpl9bXNYPmYCFsFSAQ?=
 =?us-ascii?Q?V5Om5/j0G4CFabOLa3PRJL/reIiaMBs3RytjCN6DYBlRKKq4vulrVmvpXS6Q?=
 =?us-ascii?Q?4YvH0nxRPLjJoth0t9UNbZUr5vQP4jvwYj3WryCEelk84fR0CyRxcqyyvhb/?=
 =?us-ascii?Q?f9PFr1WMaqEDnNOZzgVhbpbGdlLvJJEFkjQafhCszig1dQ6d9f0E7plzxj9v?=
 =?us-ascii?Q?wyWiguoVxlSpsqfHqVH66FMh3m824mqam7nTZ54zR6iTCwKq9Ha8B89xgHBy?=
 =?us-ascii?Q?naKv0yxHPOU4+GfWiqNeb1doXsY6pOG1kdUzzNXf0vsZXN13am8EBTiSdkwm?=
 =?us-ascii?Q?EMwOXUPfSDWu2JqfrA0F+tSTd936EORLqFWEfo+dyfgm18BYb4XQlmx+IiEW?=
 =?us-ascii?Q?3+LZP/ylvKxrblfNbCVZmMlO4tonljib2s2DYosPdSpvj+0sb6/juai74vKM?=
 =?us-ascii?Q?tirUL5eOswADw5VdXBPNBucgTSMrTok8Qq9QBuxX5K74tBPfGAgAdDHadWVk?=
 =?us-ascii?Q?UKZeY33Z+unSB8mm7GiBj7Daqz/NGrxi9Zi/gon7Tcze7vWTpSNcQX49xegK?=
 =?us-ascii?Q?QG1BiacdEROoeYMsucr8jLZ8GTv5b5y2j5MPWlyYC6+smuxdZaTJgUxCqx6V?=
 =?us-ascii?Q?2E1BqQ2AwR9QeMicUHNTpsACqQKcG6OMQKpu3HTifJLTbhRDCwizArkyhgVP?=
 =?us-ascii?Q?A5+rCujE+ilqXzbIDaSluW0iJB/Pq2Xc2L+5aN8CV7f3J09Bw4iuwyGnj19j?=
 =?us-ascii?Q?9lQn7IB+SkziFUqE+InRMuvqxHTGk3dgoz/thPm+z1o3RKf+fWSZuUJtAyrg?=
 =?us-ascii?Q?cPVYxtGY+uzAgSm9mo1DdHoQS8m6YgzAPOynqLhm7QMRR5YNp+AnQhZiCiN1?=
 =?us-ascii?Q?amkdvmB1S/34DeFXVwNCCH5PpG8bQBpoLHETu2pzCxB7CFcoRCp7mXbOKZc0?=
 =?us-ascii?Q?4CBxVg83vULeZwljVkGjpW+yTB4hWQIZdwXT3pozlKd3CeseJbgCOcq3joWW?=
 =?us-ascii?Q?UJKQa3otHMR2srkeGwx5+REojoAWmOYS8B4Pvao0zuPPAuGllGshIxaH5ZLV?=
 =?us-ascii?Q?yKDAyrAMwW+e2O8+6/SWBnYcao5YFcaJFJJ8pZVrUvKz2IObR2uT0Z5uEmC6?=
 =?us-ascii?Q?Y4airzHonCsx+yBtDWsXhNRWWD0OJEQB5Ho8GLt0SVeBCGNqX96A6sftYFkZ?=
 =?us-ascii?Q?zezm7WgSoE/w9XJQe+L0RFOHTWGMk5kCThLcQoSKMQ42XHcbV4gqcCbSVSOG?=
 =?us-ascii?Q?ApLSv8yN/x5c2fm08dr3ADTsMVseD3tcHLCXwKBiD62f1Lu/hnsZlca3XSIK?=
 =?us-ascii?Q?9wCwDfkQ4pwW1Eb5wMPYBduNiSa88FgStlZmR6od0irKrvuAvqwP0TQjWXfR?=
 =?us-ascii?Q?eH7W3qkpkNMM0pSAkQ8/cLpwhtG9WAJkcpUi1qqvrNUbkWmx4uMLaUBOLlOy?=
 =?us-ascii?Q?bdr+sMxVGekhUEFvWk7UyTM8gfVBkCEazz0/xlkCa8qFkwMS8CgWHaVUKK9C?=
 =?us-ascii?Q?bRYxR1QF4E0rmv30boz1VPpjqpm/wvdSA4KGwM671stVU3VNW0dAg7zyaH+y?=
 =?us-ascii?Q?durli/pIFm0CamFsNqGSlWkvXHuLRzb/Hb8Dq710sUEAtJJs1E8yPGmlwaSu?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc69d8a9-1c07-4919-dcf5-08ddca83fdd0
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:40.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGAVaZZemFh9lc7O0aYqnbikSy0Uo/KHWQhiVv3Xz1yusEPLQYo4bpvORd4ha3GNBpQ60rq2KeQR4YV+zLZPjTGDcLn6WLOU7Z8UuMXs+Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP193MB2850

List the version information reported by the kvaser_pciefd driver
through devlink.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - New in v2. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr/T/#mb9ede2edcf5f7adcb76bc6331f5f27bafb79294f

 Documentation/networking/devlink/index.rst    |  1 +
 .../networking/devlink/kvaser_pciefd.rst      | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b5933..ef3dd3c2a724 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    ionic
    ice
    ixgbe
+   kvaser_pciefd
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/kvaser_pciefd.rst b/Documentation/networking/devlink/kvaser_pciefd.rst
new file mode 100644
index 000000000000..075edd2a508a
--- /dev/null
+++ b/Documentation/networking/devlink/kvaser_pciefd.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+kvaser_pciefd devlink support
+=============================
+
+This document describes the devlink features implemented by the
+``kvaser_pciefd`` device driver.
+
+Info versions
+=============
+
+The ``kvaser_pciefd`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+   :widths: 5 5 90
+
+   * - Name
+     - Type
+     - Description
+   * - ``fw``
+     - running
+     - Version of the firmware running on the device. Also available
+       through ``ethtool -i`` as ``firmware-version``.
-- 
2.49.0


