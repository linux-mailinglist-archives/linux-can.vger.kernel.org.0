Return-Path: <linux-can+bounces-4132-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855EB11EA6
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968371CE4C2D
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED01A2EBDC1;
	Fri, 25 Jul 2025 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="i279dInD"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2105.outbound.protection.outlook.com [40.107.247.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B22D027F;
	Fri, 25 Jul 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446782; cv=fail; b=a8uOYEqlgcVFoMGzLzAs0yH68bp3lPN0bHNuR6bKJmsZF8btaLZFAXya9agf1Upy46ztWa0m97mvXZG0Tn1+kM5qpsKZSM+DYcXS/O4X2HHRh40/yTRdChB2hSIGaXQfIaLwkzMzBTHllTGpcvTXnK/nVXTR2/CFbOX34r6aplc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446782; c=relaxed/simple;
	bh=Ib7z+XbAosNNcxKEVYm06n/bd51vcuskucv1tJseOco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HeaWy9N2u3znnwPbSWWWNXHSXoUnYv3nlgQpUvcCPL9QZieWUoh9mmi51c1giEtENNvaCPj3M/A2P1T9cvOSF22GtSm8riipnAkOix+i5ltk4yfrkFn9E7tmVkRgfbOkqDgwLIgqyX/hBVg4il7Dtiku0pKXcxNVrpcsILJB4dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=i279dInD; arc=fail smtp.client-ip=40.107.247.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/IJ3rO2d9uTLRo6wD3wZSAuPM6euWkOGsSohWJ4Ta7Oh7jiV4j4xNr7qhxItf1Ix9RA3D5YnpE3nUW/UAC9OQNG7qvN9t8SPjIjp2tjxJqBmOb4Knb6P86NxKk4JBL+Qily2QTGAonBZlAC6R5cHkBGmGCNrPR/c+63rt+WpxO/Mk9dYTWzv7Bta5/UOPD8k2m6v7cKMVv0FaGt0XxdCWgN+MYbkEi3CWqtYXqukULLIydK0VG07/9wHmxchcD4z6+gaHZnCPEPdDOs5PBJ6S7UG9YzTOAwHyQm1bye0PeQRFt5ZAoyh9bHr3Q2fESqkPy4gdy+21GP3yYb98tnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8eQPTvNJkHCbd92JJBQi3eDWgUK9Lun8+msay82Ooo=;
 b=Qj9/uEuVu/uNWA/qvBM19rcCDAiSvkE3JGpeDOevJZEmpZZgbX+J5SGga0Ll5Yxg3j3X1Bu8fc69Ta4BMxLZnm9Xnz9rdg9e+COVtTt3aWo4ISVAHEr/YEnrKJ4+7DsGTmhC4sFkHFUfqH3n69q6BRI962pplg+D3L5gMXPZcUs3TjBVkCeGhGwu5a7XDpAjWCyZPiTXHO8CzsXzJm6E2UTklMm18c5BFXmycjVlhiGFl7x7Rqi0Cvq4v4c8JIyNmlXkEtuLzyK3wMqjMeUtVHuH9qZiDwkVNEvDd3ui86LsznxFeHcscrujgkBs1vmxZyr5MoCZhvP7wq9uWFIjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8eQPTvNJkHCbd92JJBQi3eDWgUK9Lun8+msay82Ooo=;
 b=i279dInDhQb6/NNtlqI1SDzTLy61qT/N2Po6bzdczpUMg1uBi+3gARr/eG2xco7WRdv0QsX+GD7CtI08IdyOQ336HyvB4GsmmHJ+Jy+UTr3Zp1HJ08PILYkV2bHbBclebSOj9X91iRY1L0TzdkWFV62S2/4OV40LqTmwSKHFjX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:49 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:49 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 08/10] can: kvaser_pciefd: Expose device firmware version via devlink info_get()
Date: Fri, 25 Jul 2025 14:32:28 +0200
Message-ID: <20250725123230.8-9-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123230.8-1-extja@kvaser.com>
References: <20250725123230.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|PAXP193MB1376:EE_
X-MS-Office365-Filtering-Correlation-Id: a23c2b2e-5d19-41ba-2676-08ddcb775df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hLpMzQB6h8QTzSVa+t6DDuzCfh28Tgebstqo11va9bfI+KMsZSX8ImmuqAe?=
 =?us-ascii?Q?Hgx5CjB7nNkqPcF/uopZvOa6FKvPkCUqUvd0PbKOgrE1UBoXHZG+zs8OmB9I?=
 =?us-ascii?Q?+z3+J+Zlufz2eAW8HUo417T8ko3n135UG1U1EzunhrPyqygdC/HOaC/RucFn?=
 =?us-ascii?Q?id0psyb8ZAOKKsfmnPRPs0y0jgIVbfCi5wJsEoKynMXn+7HVNlsuFEeflqMx?=
 =?us-ascii?Q?4U5RjBmA960jXm8zI+kcUCMLF7JOR/jZowTYjHjPPRTw8fT64kCfoWAa4V9d?=
 =?us-ascii?Q?HD500JE0Ln9jOG5ugoXDDDb5rXMWGWOfGsl2aIz82p1HojEWTdw9KnnF5+jd?=
 =?us-ascii?Q?3vbZSa0+BUleEOz6ZeCFEGKN5rE3HNzMQWpFRaydDni/R8aOMmArmE+s8ayF?=
 =?us-ascii?Q?DwD7FLGwTBnAwykhiE1hzpla0raEADyuyw8lCQZi6zEwvTOAap1Ro3j8XrXY?=
 =?us-ascii?Q?2iHZNerw724GlRwiBwd390QTB3ealVIfWbtjgQ1X1QKkzk+IQzdWK8IT8uvR?=
 =?us-ascii?Q?vybQ8kg8Fy971NH5l9MRXcpcOb9j07NhFPjdyLPNtAn2/82CErtwWoBtuvgZ?=
 =?us-ascii?Q?ZNfIcqhYiAnsmiQ6q0zaQ3cha2n4wnLe5ElXZbw70LmyRqwQ0WZOrqHXltP5?=
 =?us-ascii?Q?pTJ+e1UsCD8jPb8/3y1N9nOYHpaffYLtmeK4g1gq7hIFA8Dp2YQ8jzKtY1Jc?=
 =?us-ascii?Q?VSnxOgjxGZ8CvDEcmn6gWvNfyuN2/0j1fq+YFK7EGX/XRxg5clmw3z9ZnmRF?=
 =?us-ascii?Q?MQ9lwLqlE/3/f4VSSEcEKmACNB4Bqto1KMuCrL9ClCUKkUGqzx1N3MMPV5iQ?=
 =?us-ascii?Q?MRD6YMOLe1QmfECbhXA8LJBSwNzTYBgC9mCLm+ZPUejGZV1RJhPx0EhUszCv?=
 =?us-ascii?Q?51YwCbF9oBesl8n541SQtl0f/bE16MB5FzqzdigdCun8PlI/tk8JwBNax4sQ?=
 =?us-ascii?Q?9rPpHclCc1lzpQe7JJXEJ4tBNVYQNqeNXv+kRjtoQMvkXxVlZI7OuLbQepi2?=
 =?us-ascii?Q?vq2eLaUzQGKRrAnxRlDW4tGwKH6S+68LFNAXA2KQSlvBw2+qrJE6L/eDR7vY?=
 =?us-ascii?Q?sOI55uSVT8ofKKo790yp5JoUh5MM1X0Pb9v8EZA4Nfd2zJiuJN+P88w3E7eX?=
 =?us-ascii?Q?Ha6AiU/Tmef41vuP4nopOG5OYmez5cBr3l8yx/Y3pS6ArY97NZwXNSC9xrfN?=
 =?us-ascii?Q?vRLQaaHn2b5UGMrFhYL0ZZ4u26p2zPRPm8QjJtE5MhY/Ezq2f20haewS34nC?=
 =?us-ascii?Q?wkJR9IhxFGRn0OzrJvmBcAkpO+i6jvI1GkDgLhHfbaXWACu+cvNAk0M6+Kxe?=
 =?us-ascii?Q?RY+Euza03N4Fs/6CZCbjW8EoPO6u7m4lum9mEAxHdnJqf7gH5yYvISd/PXg7?=
 =?us-ascii?Q?OrW53io=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4qPiqiKbZmwEf/eYrsacv+eyk0MOkN1fFp7YPatHC13JqHyo+gbRqmg+213M?=
 =?us-ascii?Q?d8Zh8e5tQVTAVxwxYjKYHUENttMjsQZ7v3lbCCxJ25vipAD18BYo7I/BGZ5t?=
 =?us-ascii?Q?zBt8kaN4IAU4rmlTG/fWQytL/vjD6tNfQYzdry7jEa2LBqZD5UWAJFzJzJG2?=
 =?us-ascii?Q?G2YGQuhh0D0OfCwVR1Vf4Yf/84wOh8lVC4KuEErb67h2A/38w9ntijGR3VLJ?=
 =?us-ascii?Q?FtDp4rA7TMJiSoguAhVv5tXiM9vybGs12A/EhmJCyBQmIDxvjyNqT97dhqUO?=
 =?us-ascii?Q?ER9TVyWOYEdhtM1dClshW/9OaJp9HYJ5zI858vP/DGCmYxymmYizNmtruCi+?=
 =?us-ascii?Q?EsmIkvylOgFtTeYATQLhYwsngLOwpezp6TIMPPqvxI0lHVNR5nNGccYsbFTP?=
 =?us-ascii?Q?yMrem9hyk/SZmDIWLeCqqUJBMYUrYmgb3kKXYemqS52VKTJYBkWE7heabsQO?=
 =?us-ascii?Q?dWp0/wHLViKdZ+CwF4FJZSMggepdwyP7mRZazKbdzm2TcMExkXAXC54eikpi?=
 =?us-ascii?Q?HCp/xyKEujSjDO1RgPPmfK/5UUifLTwYwKt5xplvhk/MYkWhLYY+msfbw6lq?=
 =?us-ascii?Q?006HLTWREXFR8SDruJqNA4qAlnyQXP4bAHDsc0G60rh7pGo8dqaTsBY+kKyG?=
 =?us-ascii?Q?nIzxLMYHGB1oc4dJz4FWJ/wc+KpoS7JnZVSw28t3gS4izAu5TrN+upYC5ddJ?=
 =?us-ascii?Q?5HksbN57caLzzNQWxYTJQx35M0KRDbKDw9WREfZfzDAearfiPpWgK+Uvu87d?=
 =?us-ascii?Q?oWJVW1uzZsAgLfs5fKB9P9IsaZs0hz2AVjq24FdhusLeqhF2nK8eiAdCtsS2?=
 =?us-ascii?Q?ScSEKuDAXXup2WGTBEAIeCAmXoJw9ctUsdNWwrGf/8b2txK0IXYnSNnHvkWk?=
 =?us-ascii?Q?AUteq3zMfzaBxUdHF+uscaCbSuP2gKAqKdHpSi+azJG87SY8K2/aofWmRxOc?=
 =?us-ascii?Q?ynrj38oT6qKbw5Hp/xxymmV1CFXyzAG9II0eQxe6KX7ieWpiaIAo9V3UynOl?=
 =?us-ascii?Q?AI+rwUksW4IgS3vlhAePfD9nrqvQ4xSdw34hzS8nL07YXzTfg1yTUX3LPkho?=
 =?us-ascii?Q?Y2ZSayVCDvgw/Dk32V1dqJlf0U9ljrpHFdONdsHI+g1oW23nc1Uc+t9Dj/NC?=
 =?us-ascii?Q?q0SIBVP4/63amiBR8eNqDb1o5hsa1bHlbWg6oyxJoZ4NVXTu1hdgo6InHoxl?=
 =?us-ascii?Q?hSzQrIuYoQ7oEgklPDiMjDgUvT8gRfp1ulatgRJUznPRjki1Nbmsynkx4DHJ?=
 =?us-ascii?Q?fTx7BB3l29kCQEwi43RZ2x3bHjOU4pAgmg3FKlD1TXHypimNXtvrO7xWWB47?=
 =?us-ascii?Q?aQ0tELovIxUQvT5OsoUgpWXg+WeMp81/6EXNqzHYKj7O+H91B75b/ZaBDvHB?=
 =?us-ascii?Q?qtk6ifeSOqiZnoBPEy33l/Jl7aKDLXrCv/98BRtrLYLB7tkXrH7xvSTQhA1R?=
 =?us-ascii?Q?O8L8vLTpumrUGi6h6g3CFwLJGYbZmsayJEOn0dnF7oMuCYtds5h9c9FLOuV4?=
 =?us-ascii?Q?CHTNrdBOAerNdU8+x1aU07xpWR8OofUP+SmYKiWr+0RwnRBBGljuNw/BgSHm?=
 =?us-ascii?Q?scJ8Bu2r58WF6Mhq2l9x5haZi7VPqKyx6Og6eNKrBGaHztj+hcD0cNAXt5Un?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23c2b2e-5d19-41ba-2676-08ddcb775df4
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:49.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDjkT4XcBQYWCE6NsZA8QxAimEAdzqOYT9I+wuiQhNv2fa1s8C30XJwPErzPDU0Bu2sX3HkHVW4KXgWTloHjA4qQbcJtBuP0rx19Ew6JuBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

Expose device firmware version via devlink info_get().

Example output:
  $ devlink dev
  pci/0000:07:00.0
  pci/0000:08:00.0
  pci/0000:09:00.0

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

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Move include of kvaser_picefd.h to previous patch to avoid transient
    Sparse warning reported by Simon Horman [3]
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]
  - Replaced fixed-size char array with a string literal to let the compiler
    determine the buffer size automatically. Suggested by Vincent Mailhol [2]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5
[2] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m97df78a8b0bafa6fe888f5fc0c27d0a05877bdaf
[3] https://lore.kernel.org/linux-can/20250725-furry-precise-jerboa-d9e29d-mkl@pengutronix.de/T/#mbdd00e79c5765136b0a91cf38f0814a46c50a09b

 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
index 7c2040ed53d7..1fbb40dbbb7a 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -7,5 +7,29 @@
 
 #include <net/devlink.h>
 
+static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
+					  struct devlink_info_req *req,
+					  struct netlink_ext_ack *extack)
+{
+	struct kvaser_pciefd *pcie = devlink_priv(devlink);
+	char buf[] = "xxx.xxx.xxxxx";
+	int ret;
+
+	if (pcie->fw_version.major) {
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 pcie->fw_version.major,
+			 pcie->fw_version.minor,
+			 pcie->fw_version.build);
+		ret = devlink_info_version_running_put(req,
+						       DEVLINK_INFO_VERSION_GENERIC_FW,
+						       buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct devlink_ops kvaser_pciefd_devlink_ops = {
+	.info_get = kvaser_pciefd_devlink_info_get,
 };
-- 
2.49.0


