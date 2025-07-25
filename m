Return-Path: <linux-can+bounces-4145-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56636B11ECC
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2B17AC105
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431392EE27E;
	Fri, 25 Jul 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="IRtLU86i"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977E2EE260;
	Fri, 25 Jul 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446919; cv=fail; b=cjK1h+tw06uq2RWFTPCPoaHHAPSZHxYZ4l20wkXmbzT176vS6uCfm/3vz78Ai1IK5HGivIlEnXuh5sBaWnZxA5rsF8wBWYPYOZbcftTTgi2RGxboxVjrb+fKzudKQOMDGiuIAay8nTLKbmlyNhRa+1ovf6lnAN3Bxmue6V5MApg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446919; c=relaxed/simple;
	bh=M9ahDl7oF75tDaexbcYZATGRGcqK3kLQYGJ4B0sEGTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tXRmwCvfp4E083W1SMTG+8Y8wL3Iau4Y1rQrvwbr+Q+/713y5uULpoQQMqgMeymJqFD6t0T8FER/9WwYlk5wypHs7FOcCpMo0wIaB5Z28CWOPsU10cl8MA8YoVrm2LGEOsE9H6A7ao+ZOlubeeWXEAH+vxxo2LCl3KeDAY/kOIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=IRtLU86i; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqocTF+QNrhqO7V83hDClpu+k0y9Zy5RKlDAZb51QXtIMzFiV3hctInW8wR0y2tQ+EzpBuzaN+PdBHycJJ1jKikUxv2mroK5x4wPKxoDMjqcvWvbzubh982p6AtKyNYnxltwYQZeK1PRY3taKsme6DEJ2GGwz7u1+WiLH1wwu3RhutJHzeuoGju5t99YkKdXcEYXpuQ0Nw5uv8NrEe0n6S+WsYRxinOXxH1gQjS/eWmgNCG1sVTXO+cjl3hkZ1kusk7o+eXnA+Y5oH0INgFqfzwQWnce1iZ07IUO31y4I7G+EPWDwZDkhc29gGl/SrVMELfEjOipj/0Im3469MohRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfuYwtPYhQOlSR6TxYVvnDHXGO6kBsHjjcLC/IobrUE=;
 b=X9ldPy/NHwdbnVm9UvX4udsF+Ilp8Nfzuht+OhRL4CSBB2MW7PU1UirFmOzpN4cesTEU9vroIk/lEQG5YNOL60rdZX9xCj4PSGtz9FyQ8WbY+tc92EiwfuMDm9vA+r5k/nHHQT7gC3C2+YoKqfzBEa+usRQFYoJxfurzyTGwr/+WMkwPMoRaGX/hbYxqRjjftSGCt0AC75OiiYADPem99fIZ6RvYkp0sn45sGBYgsXLw82N0lV7RZe3KaXUv3YKXmc/ZiP+FcWATDeQaUYLMAWDJVGSN9NOFpmpIq0p5U10Vn3kKbOQG+6x99qPsC5sua5A132p/DiXWQyaTRVI/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfuYwtPYhQOlSR6TxYVvnDHXGO6kBsHjjcLC/IobrUE=;
 b=IRtLU86iCbOWLmTbWQnaSokJ8DjxHdi98KE04LnXojbIK0V0HEU9FelJ0HkueZOaSxIFsW05y8EjF/IXc8/68O+dTYV+4t2uLipGCUy5Q62JApxZOTcRRAFM2uf3BN84I8j3MyEZSdV3qgYLNqkvePWNxqjioAFCCi7Yh38kRz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:07 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:07 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 11/11] Documentation: devlink: add devlink documentation for the kvaser_usb driver
Date: Fri, 25 Jul 2025 14:34:52 +0200
Message-ID: <20250725123452.41-12-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 991be7b9-3aea-46bd-520f-08ddcb77afe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZRd+q5SvmNYiQEk4XUrapumxzgxqxCBb4dV5KFEJ7v1xMA0A1QxZ5n3uipy?=
 =?us-ascii?Q?jugORZf6EhpGmN3uAHBmKbDrrWL9fuIsy4hnSHhRkxjsX2UxGIqPvd+2sPao?=
 =?us-ascii?Q?PvbG8giySq374FRjPcVdI17PcepY8H73MUhm/r5Jk22NMUhoxe3KBmIDBLjM?=
 =?us-ascii?Q?wNlJtgZ5mI5qHFcaPezk6x0At1w7KJCfmw0BwTCyQLYr1y0F1dWrKjbAOTZp?=
 =?us-ascii?Q?isdGPUlHmrfCDzycYNzNDWrAtG+jMW/cPU0AvrDPkGf9sU/Esm8xPgf3al2A?=
 =?us-ascii?Q?w5PDeBeQf0OiGIUKKYFyMf8Mom2JJOwuuKmgPCWIXjkd7WkaJIc37TM4lULd?=
 =?us-ascii?Q?Or5cvhaOsY5MLenIr1J0YqhCFDb5ib7OEUxWEC5nKfkuqQ1UoTL13RhRzxNg?=
 =?us-ascii?Q?nGerIIV4TaLGoKpo+N8DAcr8g0/lRC5L+PFqyH3U83Qc2K2EK9yHjYUDcTy9?=
 =?us-ascii?Q?MuJopkPHX4u6R8dJ7K4D858dOy4caL47BvSdG6C9nJVEcFwUnpxFis/jy69V?=
 =?us-ascii?Q?nLtpkgBSRrnqtv3tqc3qLFW8JrxYWgvSZ3csDkh3UwvjNWS8Zucvfwyd2uVH?=
 =?us-ascii?Q?w1MUcpJniI24mCUgy9dIAbt5izRuVCF/jhLpPJhfPz/wvjv5YJKQw+JyqRii?=
 =?us-ascii?Q?SCzWNX15TnS3jo997MFvkrhEfwmv4u6XHVz/jhfB8HCgPsgg6MhDVnVDLeo0?=
 =?us-ascii?Q?sjSBrKM+etzWQk8iHUsnSuRmxdQAD6ZbtuYOdTAyKClPXL5ziI5hDSZOqRri?=
 =?us-ascii?Q?jeyPHPQStjTmK6+nJmtqs9pbVM8DgpP6P8ilGZp6X5TnjcjGQKaFXILkIbjY?=
 =?us-ascii?Q?04SjpHQnCx0xt0pVCMAnqIqER8dj9XJrgbrwvbPsD/t3hIb15dp2kAsHxp3c?=
 =?us-ascii?Q?8Jfmqvji9yreEtlfzSwtSdZt5kx9/2ER6Ggojib+cihVjTMZroro0o5nfBkj?=
 =?us-ascii?Q?XNvkYhSvXubZWTd3HnW+SbhdASknmgBd2RltTLfHTRjDlhRybUki+n4XrLu3?=
 =?us-ascii?Q?wL0SwflivvPbalxyvKcZXKhZp1nnDcxtxe9JrEQsSG6b5kwrCNBGTOA1G2BO?=
 =?us-ascii?Q?hOb8z7ur8D4x/bo8LtW5QtQs2jf0AdWWZW/CurHQqo5hUAumwgpCYSprymTo?=
 =?us-ascii?Q?37R3UVcfzy5eHsA0YQReUM/ZpnLz1C9tN97N2f4OL/7YikMr6WDHAmSFigy+?=
 =?us-ascii?Q?Dj/LMkvrOIdYeDOLRzeeR95g+bD/Cf/YOBDq3DKCDY7tNQD6OeuJB61sWsX4?=
 =?us-ascii?Q?mRILNxDAWU8RXxmLb7jNJNgphPEau0hv9km7+WhsP867PXqSc2I0XQvBctbM?=
 =?us-ascii?Q?z5S+xcah9zvDqC4yNtmy2e+u21RTM45nsuiRWlYZ3AJxvU5bUNCurUc1y7xO?=
 =?us-ascii?Q?uN0njYsZdT0TXiu0Ns9pyHQaO/YrQhARuXgjGJ2O7PF6wm1/KlJdPsLXLQQU?=
 =?us-ascii?Q?czA5bRVUOu4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kuF+q1vPZGhyPGR5S1+VWgrdjMYKLzuKQdbV+gGP+CtQMQ81IlYsnOpjx4jw?=
 =?us-ascii?Q?y8fZeto/A3efIlBCQj81dAvu/1Cun0UZY8o8aiUVcDQodNKRwtcGtGkzJiXb?=
 =?us-ascii?Q?+fSwjhUPvP2aV7zZ5+wc//+nT3NA+ULs6HWey/dZV79wE2XWn4TOlDA/IT69?=
 =?us-ascii?Q?jFw+gGftkAqlKyRZL4GUf08zc5vqjHUBS70//v6vz0vlm/dS1+HYxg1IH76Q?=
 =?us-ascii?Q?uHee/bI6pxVW5uWf7uVD4l+XC/tkvjwbcXE/8WQn1ipeU2xhQbHz7MI7ehNO?=
 =?us-ascii?Q?/HeQoCOL0ampXtJP2yjXbX9HIbIVlcMWqPE5K60atXiiDBdDgwPGvVCMt1gA?=
 =?us-ascii?Q?4OrI+yJAR8PWiYj+XYNNoN+T0GDC3vB67ZOB4moTIrdlHJ7uhFE7c1L9A2cJ?=
 =?us-ascii?Q?Mbs2Jtm78NKs9hnXJnO/TfD9cxZEYUWQJBUTQRfq9GErQuZx6/1AbpecTLfi?=
 =?us-ascii?Q?VzT8GZmBHcN+jFT3OdyKjpJXlC7Li2s+ZRhTK+9nnp08LPwWhlgEpEYuwbhh?=
 =?us-ascii?Q?SPX+QLqKStgAgisJwM35/YlTaxL9uIJYdMsoUAPE9oe+WUGPZAtZO+yN49cW?=
 =?us-ascii?Q?6e6TqTp5PfkurQNr/YkhMPuiUJO9HVDM8So7QBsf8Oj6w5XTZMxlRVwoqOGC?=
 =?us-ascii?Q?YUqcIVG7518iYC0k2Ocz5cdRx7u1s/OQC0fcB+zJNS3x7baM4GMPXYy0ga5H?=
 =?us-ascii?Q?GLga3PJ+/MOmRYudgs4sxw8BOIQz+U6kmZcq0fEXV2kZVNs4oLtMpiBSgAZl?=
 =?us-ascii?Q?ZLyP2lZ7VkdebERLrE9K392UnFWadrE3c6+vdsIRRyKuloFW5R1Rten06mlx?=
 =?us-ascii?Q?0b4U2StFBBcXV8Nq5lAHlRMkK9YT+tvUdYOhMNU3qDlIOMWPKcuKRt/rTs0S?=
 =?us-ascii?Q?D/5D9bOpvScb1kdJ+Re8qIftFLOtU3LG8NS8YHXfrtgiSKXCmYIi/KINd3fu?=
 =?us-ascii?Q?rhCCp7xmDxIm6XKOrRsaYrnxaPD3lVkWEO3nDy1Nhjj68pwUptDPojyHznYM?=
 =?us-ascii?Q?XNk46NWeK1I01VGFhdh1r+sqlrGmEfWajMYTuu0qtnyP4CcG5N61dmsZ2Aw3?=
 =?us-ascii?Q?ssDDOiFZGVUwB9B++w20af2LmgTQsUThk/3P+K6Bgdj/SogMBOSd967n9KoR?=
 =?us-ascii?Q?Pq4Kw16Ic6X9ZD0eCAsULypMdxnuKcTy2IAHEBY/iyfzhvdyNlQ/xdokZg8V?=
 =?us-ascii?Q?T2FRno59bTuOpucI6Lz6wDVzrs2Ap2HCLFAJNk4fNvoIiY9hAio0/IQ7xNkl?=
 =?us-ascii?Q?5bhORCB74pO2Dm1Bd/T1DQJXnMOsT80lv1SAABs5hYzfQP5DwHwUFor3ECBS?=
 =?us-ascii?Q?QiYtaYlIT5krrcc+q2d72ycE8wqC35GHVpNCsW+dLNo8X+EwKsDH9GSkU6cu?=
 =?us-ascii?Q?eeFchPKWpGB3CMU+ZelXWH1FAcba3UtnSnbfpwTdtdMy9+AM211jiCfutF0z?=
 =?us-ascii?Q?y1gVKpXrHxBIKSfu9/Oif8Aqxs+QpLkDtQoe3OTFn53KhWAT7lghDrevG1lK?=
 =?us-ascii?Q?A+LCn0hlYPm61yjNnIby/HJvf0Wawlgnh5PoU8Lah5dLknqExU8HEoFUvVXz?=
 =?us-ascii?Q?/0xuiIk5jc6viJhrZF6JJKU8w4gVweghsWX6T99/3fG62ZAee8PqUbHp27ft?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991be7b9-3aea-46bd-520f-08ddcb77afe3
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:07.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hqi1uHSQ83qvwaGgxzQgZUI3x/jCPS6h0eahV0+S+XRjPCSp2tBDOnFb3OUpCxjuG/srZOsd++Bf5JaE7udwni1WOCeXa9ugf+TixczInmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

List the version information reported by the kvaser_usb driver
through devlink.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tags {Reviewed,Suggested}-by Vincent Mailhol

Changes in v2:
  - New in v2. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr/T/#mb9ede2edcf5f7adcb76bc6331f5f27bafb79294f
---
 Documentation/networking/devlink/index.rst    |  1 +
 .../networking/devlink/kvaser_usb.rst         | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/networking/devlink/kvaser_usb.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index ef3dd3c2a724..9be7247f81d2 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -86,6 +86,7 @@ parameters, info versions, and other features it supports.
    ice
    ixgbe
    kvaser_pciefd
+   kvaser_usb
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/kvaser_usb.rst b/Documentation/networking/devlink/kvaser_usb.rst
new file mode 100644
index 000000000000..403db3766cb4
--- /dev/null
+++ b/Documentation/networking/devlink/kvaser_usb.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+kvaser_usb devlink support
+==========================
+
+This document describes the devlink features implemented by the
+``kvaser_usb`` device driver.
+
+Info versions
+=============
+
+The ``kvaser_usb`` driver reports the following versions
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
+   * - ``board.rev``
+     - fixed
+     - The device hardware revision.
+   * - ``board.id``
+     - fixed
+     - The device EAN (product number).
+   * - ``serial_number``
+     - fixed
+     - The device serial number.
-- 
2.49.0


