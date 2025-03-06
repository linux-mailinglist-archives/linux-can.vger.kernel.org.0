Return-Path: <linux-can+bounces-2983-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628EA54323
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 07:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4418940BF
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1E1A2557;
	Thu,  6 Mar 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dzP234fM"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BD1A238E;
	Thu,  6 Mar 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244309; cv=fail; b=c5BynrDv8N5fdQ10qM7m22PQ/zqAdaKXZRYAt9pC6KvuMyHwUlPhmUbQnRfCdLVQVMdLb1KuEyF0uS0LIfUSOhspuilIOPKQ00Q4EjVcI8j/NQcLzRHT0cWv5M6Jssf749WuV6jo8YfQGodLzVB8DisXy8wEGZ1SLSNeEJInfCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244309; c=relaxed/simple;
	bh=wkCKlLwYWtRshW+u66KWT3Qhrjc0FhgaN0QwKbygaCA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cv8s3g6Ewe2EJH0ja3+1SNSnTRwWLnBU7AGs2RHjsuz7+8kaDfq5Z2AwWCmdH0RZWu3Ped2f0h2N0+DT0svOMKcJXAMselvPVGxc1jH8w9EDlkKN5D5akhl1lJ5ymicq3qsn++EzuTKy4j67+ezySe8m1r2a6865nsu41B6Tm6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dzP234fM; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZvRpivLI3XCIeZ9bVnEDb2wqbP/P3IM6rqBqObU9l+KS8TX2W6P03b7oXGAMooqQHm11eM/3HsXrHGs2eqI1j1gIrM2irWszrC2Ohwk4G3P6rSRASpnTyoZzOfx0NQ449+agXId/T/QVG39B5E0ll+XtM8btZCumkVbhXusn5k+8eWthz+xRYQmLKYrz4wkYwT2rftT1kv6JNkHCI+ay8mKFOfPWrQltOxoDq3IaQxr2TzhElSqQMtowFI0RGc3d4mDhrID6KgpYedsgT2nKfeLVctR6sRIVJrPA9jgCGVrbLEm2YCcDnX++GKv/jRApSwkFbXcVt/XbcUXTzHw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc1tlJ6WfouTFbMdQrw+mLhl1x52UzEqk5vuHa/vqOc=;
 b=hi2cg+farYKuCg/kLpoWwyz2/4xm4bwmNeiHTeG1cl3QtCLfNuI3Qgkdl2mavklgG8QmgofntL4hDWqj37MVrI+RrHhSxPiiKYQO5kQyrjGDRhEIZ0TN97U/1LiNGexhgD9tfizdKFMg+n+glxI/ptrT22TEYzcujxczOcQUeNtp7A24f3N+U9tbiYxmTLA4p3v8gLNWf1uWY+/UheSQfsWMyX4emLKMtoHJyUfefDTcS2DOUXOSJTIMeRUmrd/rhlwBwBbg8wNA9POgJgUG8aZyV+kUPpPKhwvfTtd1Nq1cI3bRvrSbZV3Hh0CaCXuvMXZ6c6imgzW2+ZeZLmqOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc1tlJ6WfouTFbMdQrw+mLhl1x52UzEqk5vuHa/vqOc=;
 b=dzP234fMh8ubkWXBZyddw4lNnZqaRvbDVmpN/wQmva7icM9HR0BXReJJP4ZYRZxRXc3cTOsLrOKTC6ifb57/YELXFqiAsCXa3mQIR8ZcbDTAFBiv1s3s/ByVXiONK8B9MG9d6uIHCwMczucqFLHSQl1wwiSRCzgQR0o2PenV8NXYwXd1gUjo6jw/hHFr0SXUYLcxzohthh1yzacjqXFLfVN6Iwf67xzkj9rUf0JB4M2t5Sac7inFwdzRQgKydG8mqu5ORDFBDq6Ek68Sd7P/+D8VqYDWSOvxS88jgrdOlo+p+FfqoYUkwkg07w/2f2ZnJRnKxR1FbwJxFWncQahBZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10584.eurprd04.prod.outlook.com (2603:10a6:150:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 06:58:23 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 06:58:23 +0000
From: haibo.chen@nxp.com
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: haibo.chen@nxp.com,
	ciprianmarian.costea@oss.nxp.com,
	han.xu@nxp.com,
	u.kleine-koenig@baylibre.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when resume has no issue
Date: Thu,  6 Mar 2025 14:59:20 +0800
Message-Id: <20250306065921.2329517-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: 19100719-74fc-4bf8-93a3-08dd5c7c48ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGk3AhSl7bUk7JUqHox3OjIRXEKPHlPn1jZ/w7bRoP08G9w7FxxNVmaRWm4+?=
 =?us-ascii?Q?oqOlEUtGv2UffSaMxEXGLSMk+P1WsNyYLgIWwTNYyPZw91wIMuz+hX6sH8Mv?=
 =?us-ascii?Q?Wm0Yjs99evBBGDkB9T5m5m4w9SYXfSalOJnfc6HXHYAKGpvhpBEt3QiJO8X2?=
 =?us-ascii?Q?msHrxXtKEDft9mNqmhul4OYnbwMPiIfMSxEt30Oa/GCr4Zfs2jKfQiY+eV22?=
 =?us-ascii?Q?OPqKcNi4Hqqoo4YLoeEcByoJzoERxheeYQNAbV/Vl6Mr6CUre8WeF10QxZLh?=
 =?us-ascii?Q?KVRwtleDdH8Xm6ILlI0Pa23k8LdE3nesF2fGrZFqf/HjFV/YXxrKcMoN2cXo?=
 =?us-ascii?Q?NvljW2MuVo5U6NzutKxuk2CGGyYamzJ1Ljglwq+wTXl7MFbuno/m+3b+psFa?=
 =?us-ascii?Q?4/qyoGo1yVSFySYQ/OlZyxsuxzwZBeFDyyyBsuf0QNLuNIqy8n6vDH9mu7rK?=
 =?us-ascii?Q?KR24B14ZLq9g+d5JHALbn5I8iSNoXvuJ8aRIDeTPjvcq01PCI+0YK0e+z/av?=
 =?us-ascii?Q?/0kx8KY6TE7N7A2+Gyp5n0SruHd+6o5GNDmKqklcp5hhWCVAg28s6+ZQXtIw?=
 =?us-ascii?Q?jNX+UciUPd5rsG+/kxa8mCyGVxE0WUwxOzNgiS+ivf5hnfG9YVm2eZ2yCt8T?=
 =?us-ascii?Q?VDXpyYdiCYByQfNb7Sse3iocWAKDoTy8FXchis+UyyAuy1LK/giXl8A2jaJk?=
 =?us-ascii?Q?7yWKL7I6RXEonJ/Zf1pUhtsRn817E61SJ6coI8Z4BDYG7teS1fupoz8DFzDr?=
 =?us-ascii?Q?n4Vf0Fz2+Tb2v7H+3PrfKSxjkuYIZYzj6T93JoJ5VgplPFKWw34os9xDqkQI?=
 =?us-ascii?Q?A1c6yXZLHDFVDHyjBQ3w34ELQYQUOnALi5xw5NpElKr564aMvGexWgbs+WUq?=
 =?us-ascii?Q?rz7Gr3fwwr3gO61INgtYsBoclommzgyQNuNb5OpYfyVi/NhZ9ViVqpaOUVYT?=
 =?us-ascii?Q?E/zCHY2MhA6zCRtIRchrNENjqejwNDsNH808RXfEKsLXl0/2tSgmNVvocUIu?=
 =?us-ascii?Q?i5FBtCTFdcGA0zAZnF2rgNNHmiCD9RhwvsaubbCUUkEmyNc6lBYXonAAmdvi?=
 =?us-ascii?Q?vo1ZsZr26rHGsM3epuy6u94SKwUqsVKbaU5ylahYBJyAB+sN2haP1EgdVMHp?=
 =?us-ascii?Q?UsXqdY3QjBNAHD12UGnSLx1ip1TrxOFTLVe5FXlGRVf4K1I09HRJaJZU8sbF?=
 =?us-ascii?Q?PuPNnzRrslI92F4KTOavX7o4UzPiocRdErdPCDNwDsWjo+6s1VgnFcy3uJ4r?=
 =?us-ascii?Q?iWCikqMslDS8YMl18kLulZV7DVIbT+w8aRfTykCT3kQ26b8yqEq+zJRvS6rK?=
 =?us-ascii?Q?s+4WNdR7Pfd/YjsotUZ+UwyU73jbl4U/k09bw/dIZRFO/tJxkSO5VOqLwDnY?=
 =?us-ascii?Q?6iAnKkxbIiGo/rQ47sWFyAijqgsR8o8NN+KBU8I/+YtFQo9wbkX0xQLwAbKd?=
 =?us-ascii?Q?JsvhmNS97utR1ilgpbANclQ7/0v3rOhy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CE+lIqED5a+nLcdfpcG6V2i8Gmw6HtB8RqgRqOyT/K8Ijz+pN4Ec28wx5ONo?=
 =?us-ascii?Q?l8WzJ1aUktuqV5nQdoYUEclfwg4z3+7/7hmp+j5JAjyTLlNVA0KZC4Lqm03V?=
 =?us-ascii?Q?qeRWVmMucOsTYUVGtEhT3HDs6N2F8nzlSjGSDP7iR1Ng2lGDTVe/C1j0Hh5w?=
 =?us-ascii?Q?diCfrwPkqX6D6/YkXSXTW70lc4JgbsQkGGyQwqk2czEEOwECL+fmfaM5mCc5?=
 =?us-ascii?Q?dSMdl3sIZtSsbib7zg4smH6CHq+Rrn1X81MLEBjktmXODhSpfnhr6ZMCbZ6k?=
 =?us-ascii?Q?QYLFf2U3EDNdy9VxoY49oVG480ntqXssWBfx0FD0/qGrfQPXR/vbovqaWUZk?=
 =?us-ascii?Q?Z+dPOnYcwC7PA2JnZG6VY9aWrC4qycRoqA+pc7dqMOUAvBoTpArm/weMxLX5?=
 =?us-ascii?Q?N+vmZIxxyhEzSy3b/xNAYbJoCGpkml+ni9UlNRM2RrKLe/S4DwHe2tmxscQp?=
 =?us-ascii?Q?NlQrxaG1jv4ynUju0AljrvOTLjRUOpYg1o7ygU52vGF25FFMNW4efTHfPdfe?=
 =?us-ascii?Q?ON4GtwQTApVTblZhGh+aWUOxrpYOHVXxJITSz/2MnlH/Kf6/KTlJ3Ge56Q/+?=
 =?us-ascii?Q?EB3xlwROh1ra713tKWwnM2gyEiOVZyhyDXt4KLlQXTvoNjr2QryIe7k3MfLl?=
 =?us-ascii?Q?Es7vvfJJZGMCL0DlEWEwxWQ8fUCxcLrxDZmmGWAPdNfNAKYkSFSjcFWGSXn6?=
 =?us-ascii?Q?gismR/1+h4OhhMOnYXjohBvwPXCxO9plAJ4+4J3DBjxZP/ruXIUhnO/SyCjp?=
 =?us-ascii?Q?ZxIs7veuqmI4+EFKZaosIz8a+6x4BqwWFj1yjBJ4rT2/b+eH8IpvHIe8vMiH?=
 =?us-ascii?Q?9AqsIgMxluOeW/pRa8W0IWZzHoEvK8IfRzSfsJ7BKxVi/bM6dS4B1q+M04bB?=
 =?us-ascii?Q?dqV7v9fnhI1F1RxvACv3evnH83xiLAtNBDnomPrRqpDB1V0OAHG+FikDY8kV?=
 =?us-ascii?Q?bsiq4yPx4r+2/f5hRHMcfRv7k4NOqZIawPz9m/JqxFA7xKBbkcKNgK4Ji7m/?=
 =?us-ascii?Q?5iNGt06Ib/l4btMuen2E6zW6VRi1joFDT5AzKzBrlGuh4YEHLAJnxSafLd5t?=
 =?us-ascii?Q?yUaYTwN0x6jUH9XZf51FDQKnN4ohIkf+sv/4aI/xHI9L4cOI4z66aKRJrZnM?=
 =?us-ascii?Q?gVVJOQsO1vQ4crhgQdqJ2kHZrqvq4vzHm6VoDij52lLsplYSeylaGSuNm/18?=
 =?us-ascii?Q?JMuXUmDBzdXDef5cv/cu3PtibtaKCmnUno1PdTbqtlYc+C+xe173qlpO5y3u?=
 =?us-ascii?Q?qCnlalx6UqXRKBfz4h99NJqCqjZeNOuLZW/5kVMcbe/Ek3x8sFgxIpK34l5E?=
 =?us-ascii?Q?Z7HlWGIFh+Y+E9a/Jnvf+QXdnow3c3as9nZg4XMQz7olms3IU1G3GFuaJy2z?=
 =?us-ascii?Q?FoLWvE4x5UkN1khIQy4H9Vo0zDdHPeiQaVxrOLg80Zmg5EEQHjrCTeSHFfGo?=
 =?us-ascii?Q?UQQl0Gzaos1LaQTRWd5cx8T2TGtqC7dVslGGvMdU4HdV7kFig3hl/JOgGHs1?=
 =?us-ascii?Q?kUMDiCawtoS7WT2SK1lyVE3uLdj/neENnPXOOSVHF/3DfPgt1Y8q3aaly3h0?=
 =?us-ascii?Q?oA3Rni//70ApJKMLWMfV1oiYsEHJ9RxxdCy5usMk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19100719-74fc-4bf8-93a3-08dd5c7c48ef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:58:22.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdr2ynXEd+ciHlspVHmfhsZXsHjr1INofb3E/sDVBP+13niLHRyGEn7nPz/yIZbowfRvqBgwgrvybM65+0/Yyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10584

From: Haibo Chen <haibo.chen@nxp.com>

Only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process has
no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b347a1c93536..8415ef71f1b1 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2311,7 +2311,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -2332,6 +2331,7 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			flexcan_chip_interrupts_enable(dev);
 		}
 	}
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	return 0;
 }
-- 
2.34.1


