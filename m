Return-Path: <linux-can+bounces-4110-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D7B10633
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8605A39F9
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494D2C1593;
	Thu, 24 Jul 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="kNfsEim8"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2104.outbound.protection.outlook.com [40.107.21.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7E2C15B7;
	Thu, 24 Jul 2025 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349146; cv=fail; b=Ifl0fmFon1PcLFtU89jlz1bn7yCwpnong+0viwqyKQV/Op+b7nLbB7Y0JqDId2U4UMLfgnkVN97/ecZrK5uAVxPMZFCpmYejugDVYnkwwkWNm3Gx4ntvQLVF6H2//qNoW5XMV0HqdflhqTQs/FpI5ps8LfkiS8YyTDEZ6goCa1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349146; c=relaxed/simple;
	bh=xRzukwZxa5y0dRcmHo+Defgcs9dizU3bwIW/8lZf+g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTeEVKL64iSGFkt/UCsqohTl4YwCvnFsfs0SFjy8Vw2Lk5eKU5kt/pG97i0/B4U9vc9b1l7j4xD5Sp80BNR2ndwreodOtes2uIXr+63qdmMX9MvbnqWHRajoeAr/SYVXcBxM9nLiRHEItgT3SVm2kHHcXp5K9bET4zlOugH0oFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=kNfsEim8; arc=fail smtp.client-ip=40.107.21.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm8LaYJrVmb/L8ZkUrJUsuVqEf8h6LZBXExWH5p4TPSpUo6pwKmtl3KGswayoRd4oenWJeQH0rI/5jCuuUvjMmwJTRfSmW6xPJVg9kQarg6G9wdY3pYLdYk4pqfXlIsEDoXI3KwZenycWL/M2j6jZgCIyvaXSJ2hmim709effkvKvSvFeW9xZpDnX8TfNd9PpX4sqNYRAp01jIpbuv4p61r2jLPRW3GipP6ssbbpeqbRNLlcb6gxEV30tN/MyCNT2vkSdwl/GhVXbKpG61uv4JxQXl/rNxZxuXv3BvYeVKGu1qpk+qxGH+Jdz3MPMmI4mCdhcmsVDZ67u3xJ8D8MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lewdPpCnGwOQfa76hPgo0dlhVs4CGvS+gqqa2rFe0rU=;
 b=cc+/HGGHRsfgFDzRZVLnLiuxlHbFYnDcwZboH8ajdaOia9dWeea6whxWewJ+9GNi3DxP37w/GRaBH7yP0k2ZslPMJiAZGqcEOCaHQP3+zDuPP3TXDTiNWwxOnUJ1ifRVhGorQZh0MF+YAiJY5RRLEQTjZ5DK/mZJPFkZ4mtPb4FmzjvmUFpE+C5Z4Nl5Iee9ZsMRppY62aodnk2MD/M8vXlGg1qtcpyS2Bjh50IFRGpl6nTH09XG/nDBes5FAg+Tte92iBBfZm4oy5GeIIBe2EBKnKlCXXHjQ6GLAtH6wT/QrnhOjyoRgexqQJuFb8Tvc51R94TSmPJk/yO4bb5mUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lewdPpCnGwOQfa76hPgo0dlhVs4CGvS+gqqa2rFe0rU=;
 b=kNfsEim8MyMuogqLtuW2zbQtklG+1RM+nXQa3Z6VCp1rEmxzIrH1mMXz7QMZYCtdO9Sbz9R+0G13xap3Isl2mdPvRoB51dcGK4ILn+efqT6iNfUw/1r1Sfmfi97mPDjC64cOC0yRyR11PkboXm4WPszmYXrcg5O81noIoLG5YxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB2411.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:31 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:30 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 11/11] Documentation: devlink: add devlink documentation for the kvaser_usb driver
Date: Thu, 24 Jul 2025 11:25:05 +0200
Message-ID: <20250724092505.8-12-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724092505.8-1-extja@kvaser.com>
References: <20250724092505.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|PAXP193MB2411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7537d5-9abd-4eed-40b6-08ddca940860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+UzCCcH7+p/8dQJwSUmGiZ/oNgykaxnTDZcWuMAfQAoRtkTIGb2MLNisY89M?=
 =?us-ascii?Q?CVqlbizUY0ePluVmd5K2yFvbly/q9II6nPgn+XrDld/cWdW880HcJIUNOLVc?=
 =?us-ascii?Q?YAmRw7twRs4IGiv2G9VU3uWRAft3Ro84DbJxE7YzchrshKazZ/rA1K5Z+Aot?=
 =?us-ascii?Q?D604eZINPLevtG1zxB870R/I/PcsnP+ZTX3+Sqm+sDHA92b1KSndx9f+hlgM?=
 =?us-ascii?Q?ipqFhMKRVSlyUiSMHGkD1aWBX9u7T+uzRTnqaS8zYOwswo2rCz4n0LWPg4Et?=
 =?us-ascii?Q?xA7i8b0UZpB1q2d+8mj1UbhfOQJqoB8lrEppXBdEKOSyqupG0y1HnXnWzRzT?=
 =?us-ascii?Q?cQ3g4pzD2+kfje89WgmyC3mZ68mV3OhaWHCmp5V9RAxdlZMl4q7UieHT0cLx?=
 =?us-ascii?Q?O69CzpSSUN11UqrFInE6chUSD+YBOXP6JkmCuvJVSSRHpiZ+lx+t+HY/tMq4?=
 =?us-ascii?Q?eZdqb3SAHDJ+Zcm1sq1L92qHpoZO5DfqUeLvH3imZFTmUUbpnT/mlHEUrRrH?=
 =?us-ascii?Q?m/qMx/nt6GWzNLYOWBgAFIIRa27nQL3AfKHsl2SQShaPAZqh4PYgCoGjmD1E?=
 =?us-ascii?Q?I7SmkVq0cpOSuvVqlxba9rV4of7y7yE8R7ysjGFkWiylgGTXiyzBlpvDcUtc?=
 =?us-ascii?Q?zxVKHmnMe7H1fOJ2nZPPzjGOcZouxY++o9hA11EKUMciFgwGSNJwod6YObCq?=
 =?us-ascii?Q?qCdDUJqEvVcu8i3Z7HKEc5T2RbV5DIqhKklC/5zdfFbX23EIW8malBlASUvn?=
 =?us-ascii?Q?GwnandcmL1O8DjpvQ3HDLdeYrz3VP6UF+zsxuu/7qm3GudZwbww1afpU/ai/?=
 =?us-ascii?Q?NQZkilkhesexWdXlIiaRhAvH6PsyJ+f9SE5JByR8ggX8VeR0mSi3PtJUjuVJ?=
 =?us-ascii?Q?dvcn8QdUF7yg0yoFe6zoFD2vfMJLhZsE9JCW8SGbafYiXdLsWqZm/BP9ft/d?=
 =?us-ascii?Q?wM4dJk31MDcpOC4N+Rs9SabgLqVoEZ8jfyPTXGYYfmpsUt7hNtkOee8WBgsm?=
 =?us-ascii?Q?fAqWWRytJaR35jczjErvOJldcjTQVqzb1YUQHhz3geH3H5jrkkc9F1gGLlvr?=
 =?us-ascii?Q?5ktWoHhBITcgHKAlkYVskNH7UXRLA1KBmi9TRESSBtz1a6C+ruwAg0EDdUbn?=
 =?us-ascii?Q?Vx+w81SjOccXHBsVVvmHUSjcupEw4S8spV4DGXuH3u1Bo2FkIGgHY2aspQZA?=
 =?us-ascii?Q?/4GBnNOXBehpeZDpR/KxUXYCOwL7NjkCUCZKJwJimcUE8Jq/VXUljimDXQ5e?=
 =?us-ascii?Q?MWZ0u/OerXqVl2OkmPKiMw51+iqFXGtT3J10bMLJhiQ+tnKF3/WHuS7Dtzun?=
 =?us-ascii?Q?9nf+eX+M7KaOJ0dRmpTXJ4vCeUWHRzzUYBjZearLSm7BLC7w9EnnzaIEWT9J?=
 =?us-ascii?Q?II/AE9izrnwFEovZq1Jeiux5foNsE02izuDQzWeV5fcRGcX8wr8sCfOqliZ2?=
 =?us-ascii?Q?WPRnygx/NLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VyMYgRyhgxgKNW9nJ34IoO2tOwoQbtW5IcQ2b86gMuS44tkqCNL+MaX0wXt?=
 =?us-ascii?Q?ONgmMRM+ZKEbUqibaq4gkhdVJV7ofmpBCrBjMkm45tfzo0Wo3cuaBXKhxFXb?=
 =?us-ascii?Q?QOeOhfbKVoUm0kbx8EA+FW6hbOuPyLuNxvw8pFcpNGtjPKFznoMMSYYkthyB?=
 =?us-ascii?Q?I0Byxn91DvzNGSvxFNfvMHxgDWIDNByde9ZzKcZ/QEqKm7aj/TfZVZY/KM8H?=
 =?us-ascii?Q?ZT7no/W6aTTXoY80QWqypz1w7RJ6nD2fw33vS1syfupaXcLjFCPSuMZ3k9LF?=
 =?us-ascii?Q?3JVVRnT7W+RIINkqbRA6fY+9hUFsDeM85DWe3TF5//BVwZ5LRi8Mz/R/v9WI?=
 =?us-ascii?Q?tgk27Qk4ED9EO28LOD5XdCnWftMTwdzMvm1yVfBixZ1QsD9HDraJAJS9Nanw?=
 =?us-ascii?Q?t/GsCJPlS4XMRyjuFEdqpaW5jYMG5RWtEiUeaHBhLQsMGe2rUJLAqA2XR/2i?=
 =?us-ascii?Q?C3D9N/GNeJLom+8uZGMrXPvL2SFYq5aoYgpQWGQn530LTNkogVq42zmODGYN?=
 =?us-ascii?Q?Dt0aiRYjVdqeorJELDaBpko7StE80bL7aaGcVkfbG2SXzjB09qB6hX3tq/QN?=
 =?us-ascii?Q?6fnIiRtRLIK8UAIB+uAvmjVJOu7o6dk9FoGGvZn2N2uk9XzAWCimIkHMuA8i?=
 =?us-ascii?Q?aj+uovpicwq9gVDGXpRRQ1GxrcjuP0b66oaRqi8VWz+eVS96VflTFvSx8/v7?=
 =?us-ascii?Q?+5fpDjl2dvOZ/TnnCAPWMv90C+RaIj7qud7eGBn3Ggo3rPcva1ku5yvuf1vh?=
 =?us-ascii?Q?zjpQfP+StZOPVW7i8NWz2afYRN1wdYDpk18GTYYWZnslxI9pF3IhnZlmEAVA?=
 =?us-ascii?Q?vy3SD39kf8f9gE2jo1Tmf35joIgupQn4FrHA+Nz9l312gqfPAK+PmxpR5GNY?=
 =?us-ascii?Q?EropvVNOY9bZXEaiyiX7a7W5EXAw83G7m/xodHOGgurBxfWC4S8OcoXMY8cq?=
 =?us-ascii?Q?kTWtub2uCnb2sB88VCDdXj+2VGSp+zJo56haAQbmeguHcbqm4EESjsWjEaM/?=
 =?us-ascii?Q?skX781jdxi0mJPg9diEAUdYFycLP1LUABalBM1JWqimH3yZOYJ4LFELIs92A?=
 =?us-ascii?Q?zH/pYGAF01/0DVmqdsld0E3nCxPsBV5Gjm5UCSBJkDFKnNNX24ydNcSI7noo?=
 =?us-ascii?Q?b0jeJy7jHkEwnz6FOl8VY5EPpUJZ1CMMaFpbT5imqOvRALWiQczH5A/nGWqh?=
 =?us-ascii?Q?GZgKAI4LyyNuNoq7zZ/5HH2L8q0MNF0QkPWaZv/+iRHhCdz03YDg/NArXKAi?=
 =?us-ascii?Q?ki2sF6EkqqngL4MP8lJNalH2bdr7pYSbA774K/d3HfoIvHoQPvfMbWQxIA1W?=
 =?us-ascii?Q?hUAbZDpdz953Wkv1Ts9nizHHLJNl/8hiHtt04MdQcQKDORSf13/FSr1iHKaF?=
 =?us-ascii?Q?DSSR1/hB/EI6AxlGgm/qaUmGAcsAZsArpagQdUaEy3veX6x4YIImBWWt2lYf?=
 =?us-ascii?Q?PCElmv/zxPOUWd+JwYcUYlX07huJWZAzIjuYIlQ4w25x+8Rw5fC7yzo5BlQ+?=
 =?us-ascii?Q?HXx6JawkTec7Kn22SVTRt8Dab/IWGbQWEz0z8RB1HLvt/dToLwC0nsSglxML?=
 =?us-ascii?Q?whNFbHH9A+f9gK6Ymt/Ed2h7/bT3VzIsuu9CNh996RWhMj/nzo+ifEdHsQgq?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7537d5-9abd-4eed-40b6-08ddca940860
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:30.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKmIX3crzSnup+hXDELJ3J4TGmpa8lxrbDyCz7Pv4XsqJsf4b74nYgW2fqL/nvbA2sQMHqS90Jja3+FwqNHqDv+acm88BGzqQhdTb7cyNeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2411

List the version information reported by the kvaser_usb driver
through devlink.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - New in v2. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr/T/#mb9ede2edcf5f7adcb76bc6331f5f27bafb79294f
---
 Documentation/networking/devlink/index.rst    |  1 +
 .../networking/devlink/kvaser_usb.rst         | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/networking/devlink/kvaser_usb.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b5933..26c28d0e8905 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    ionic
    ice
    ixgbe
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


