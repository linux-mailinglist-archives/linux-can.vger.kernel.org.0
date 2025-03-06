Return-Path: <linux-can+bounces-2984-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA82A54325
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 07:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0664B7A6292
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8A31A5BB5;
	Thu,  6 Mar 2025 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nCHkw/e6"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18A1A3149;
	Thu,  6 Mar 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244311; cv=fail; b=YJzivfE6sJzvqw6IRWDI7J5PUVeZUzOJQHGuigM2jgWKy5igNoUkPDm8O+Tx2Ilr3QRlg1PHLEokT18YUiLeb4ClMdCP6kw6dLSci3IJ/bguyonIPeEJNiu9QXMwEU0RdOIt3a0j+N8lB7Ay034//FbzkHLCGYjq7i4NKlFrvWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244311; c=relaxed/simple;
	bh=O0xRRzzr9plG0P1PggEulZfQVnFAabIEx2Loz8MIa1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJcYmJBfnF8OxobdiDTbZtj7cHS6uxrT3X2vULLOR1lov+HpPgvWD42K2d5OzeQKVJqD+q30LmKQc35E5Idyfg2mGhf7pcDdR+IyhS8FT5yoGYTMa9RtmW03vccJ2edBB2rXQGXIa4k3eI5uRzpDuF1HlgvOlun4x8aMkyKuBUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nCHkw/e6; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6ES02hJx65NXOqcvT40kvtK7cdDzX1Oj8fUr6ERLEmbpS5xOGZ605v0sJVRRwTKBjULRWenPzkpiQeLYFt2ScCXx2+MPFldD/C7lOyP2aoLjQdQ5AyThy79vt5p1y7VXGgQp944LemLo3BAwbn2K3ETLWmLsf29dHGjM6MpdnUoonfw9H85QMvR31mrcNEUAlID6vfE1ErTyUNjJvGDt3nEuTlpwz4SNtS4ZAQ7lgxb32VKn4qABCpm0OOi22/eD0W6ufxy/Q0zp7T/PHXGkSXJIDmt3csag43Rors6p2ytpdPvoej+oP1Ks7z/uN8MxWJdMXlJD7EDazi5Vpi3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7f3JW6N+y80iIwm10xvm5spsgrnC8dv49K1pydxwDI=;
 b=PRy5ZJPjGhFiZHQiWasZS5Zut8v4ziG2VO65D7j3aCnNH2tViCQZUiMnd+u7RK1TzVt8GbXI8h0tQhUJiGs7TWN78stLQknq8d28STKgcI3Pofrqy0gnasryWn91a85+COSSAwAUblq/k0y2lGJmobLEbRbyJcy7/RgzcOg8fC0qFWG1e5ymMBaWy1Uj11xoLoXgj9EWObC0UZTPpnb/mnlc6/I3x+J8pjf/EHIAQCvqu3XcIQikVTPR9U2RTeNjpiYqzROoISsmp/Lk0HtOpAWB4QHyOqZWqiA80xs4FVi1ZzRUVKprBTMK4BOG+nbH2eFoL19XhPP/ogcnbXGxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7f3JW6N+y80iIwm10xvm5spsgrnC8dv49K1pydxwDI=;
 b=nCHkw/e6HYlgaBupVVk/p1IXgDNqc16+yPg+rew4M7lVUbIWTjbwk2bj1CL0klGhDgr7XH6SMMYBMqqF6/SjzBofz3izZhbErryPnCvy5H+g8GWoayI9ECiF8guYv0GtSgbuXSN2A8w9X0dS/xPD8joO1tDXI3txhre9MJkTE00CpdxD+7Y2Wj91qM47o2V0Dv1wH6iiF+qCNYVjfkxOtA9SVX92fDVqjjkCIuRuwQafe+Ql/hZYWQj7bSlnTSHYKbWA/67RG7wQbT6AGDJms4pr2oGbeM/ZONg/+48ooszGNDlEW/e0Xu4TQX1Kj2/tw96Oq6BWFmwck4V9p+KEOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10584.eurprd04.prod.outlook.com (2603:10a6:150:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 06:58:26 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 06:58:26 +0000
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
Subject: [PATCH v2 2/2] can: flexcan: disable transceiver during system PM
Date: Thu,  6 Mar 2025 14:59:21 +0800
Message-Id: <20250306065921.2329517-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306065921.2329517-1-haibo.chen@nxp.com>
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77fc44cc-0478-470f-6967-08dd5c7c4b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dA/qb3yPkuqzGwfwBWfZxq69qMjWf4Gczuhm4gMashPm/1/gWAXPga1XParv?=
 =?us-ascii?Q?TmsrEaVWOmUaCwTxnu3ZBGPG9WgF6RdcEUNKytv5DoICo6i1qPDU++l131Z+?=
 =?us-ascii?Q?XWMzKfXCQf7Bqoddh8n60YfAfdqYMEzhm1yeWFiXlLXDhqpGIL4jF/I99428?=
 =?us-ascii?Q?+ufP7oLYw0MFMsDKEDcVTjezzkXMVzmR8N+fxUkF8ar3MTJ8gQ/eRJFIbUB5?=
 =?us-ascii?Q?9egZqEmZgl94PRn6+VE9BY8aYSpvjlT8tA5nmzVsgahxmvAypK53bHi+u6Rl?=
 =?us-ascii?Q?jYCMZlrzRHlaurubaCnVxG9/KRQbpoIlQPmTMZouSHYypQeFAAkKWej5sT37?=
 =?us-ascii?Q?iXlADGPVuAQc6qr9I7rmcpNKhPbi3gXomrZ36B8PFOcz16nOTqCSkJeCKdaQ?=
 =?us-ascii?Q?uHF6f0ENpLcfceYU42pjPy/siXFsaQz7gr9nxqL0i64vYbN3nyAxTVXn9j0W?=
 =?us-ascii?Q?3e9y7t/GkfzUIa2knH5bGnr3PuSbmCagrCMwBo6d267nMjViD2N7YlfOLDnz?=
 =?us-ascii?Q?7G5jzP7uX7ebLHgFL/zfCIp9NmylJByUOMEPZJpqf+Aj7+tE9flIg/PzLHXK?=
 =?us-ascii?Q?4YDrBPYHEgw1Hx+mFEfoM79WABkq0G95vgetBi4F20fO8w2wGPc6hXl63Y+y?=
 =?us-ascii?Q?pNPo3ebaw4ydQqdkAhcHvJZVQoi2Y+IQYHYjBmeSMETWZjvHXsTKGyN0KRvu?=
 =?us-ascii?Q?oquX8i6fjtn29ODMkUdTFKK0/VkJeb5CnGMuo5iV8UzRMlQfCsEnyRJHu00e?=
 =?us-ascii?Q?97doDIqchEon3bhcvg/UrIpBUZom2ozVQM7WG1XhM6aqsa/+OjdqQaGggRp/?=
 =?us-ascii?Q?NA+fEV1SLt64qsO7PjtcbZW0L4YgUE2i4wIYFJMMkLeIMkKgp2Vxpb9J5VFk?=
 =?us-ascii?Q?I0iFRH3np2ZldbXDnn2yNGlc/wfdevSS1kGBbwKofU+u6R7xJoNjQdj7ZX4+?=
 =?us-ascii?Q?qDZxgVgB/NcPRhDgsheoZJeLFJtpFns9qsKOduj5alpK85WifBQi868K/JCp?=
 =?us-ascii?Q?jOzvG788caeqEGTnG48f5NbwrnTYU4OS4xk8dX4BI3gUr8ImLmktzr/2O3YK?=
 =?us-ascii?Q?xzxg5F/cipDkVoFH6WwXFc7LDnBZc12mKbYvzp3k4BkUtIc+I98aekRwByFJ?=
 =?us-ascii?Q?Zr/JUCaEEEtk1XYlUIZVSNuppSGVGRSgdXTIt1jjUrktCEUzoCf96kpDWN9e?=
 =?us-ascii?Q?Cc6+lmtQLyf/GOQY8uhbcbBqHyJOW2IGjiU6+UT/enIRhC3dDrJGgVxfkulr?=
 =?us-ascii?Q?PlfJVJLKGf2Jd+YqUvvkQ7qmAJFVUlBbFGPWo7bY8JircuuqtwTWRwEQkymt?=
 =?us-ascii?Q?5K64V9CttFG1J4wGUMDiLnaCeXTb7pQYcMvbx4Ch9BM+H/x/bp/PlXK2t5z7?=
 =?us-ascii?Q?ox2D9sc2kv/syiyYJKs67ryEM9T7FmQkN+YIp2O5Olb0cjlxc7YctY6cm4j5?=
 =?us-ascii?Q?Xf5BbJltePGOCXcvzaaZ3Pb1/Qwir58p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?veHKUpI4nwA2kw5Sygf7Omi7P5jZc1MgTMvrKbU27Y8k8JMcyqXk4fJeZyyV?=
 =?us-ascii?Q?zWdjRBzC99Sx8AUOoIG/t1vV25+7MpYHIIWG9W/+6gOYTcMg7Cq/oXSuo3xj?=
 =?us-ascii?Q?NqExys8YScIpdLYLK55b6o561TqU9x0ADG2nvXeZmqUu/qA41gDs26I6J8tW?=
 =?us-ascii?Q?lQtmyt1i7CP51GvC9IOSuvs92aGSManXBrIOWCpdalsG0raCfXus8kuEJqVF?=
 =?us-ascii?Q?NHZcv3g6+o6KIPhac7hKi8Ow3xV1tErnwHS2ok2SZf19nuG6hPEP/fYR0H+H?=
 =?us-ascii?Q?Q9Vf8l3FxcDbXVwB3Z6ItUwtWbu6DdSFo/2wASulLU3zdLP75fY+1nT/axrv?=
 =?us-ascii?Q?VKYJ6SoX/GG579tjpDvSrTP4VWZ0v1Yo+oQRuIbSHjN7w8dPftGLU+hnaZD8?=
 =?us-ascii?Q?PsEqRwcWD/twvnS/MPyKyUMurvWD6vR5FeEqVkpY1hDhddCwKub4TrQ2Ra+q?=
 =?us-ascii?Q?PxA0iu/hwyCVy+qeNPDXi5HfrVztc4Bwxn0y05v2n2dEbW9DI3ZX+NXSG9++?=
 =?us-ascii?Q?uuNj3DrJGPiw2xvJ1+3oWU7UPvSb7jIG4S97Eq2mPAKAq2lqKKgDfp2Tr7NF?=
 =?us-ascii?Q?Rj+4oJCfNPYJanC8IWIScMbeiYsTRftBNVU8j1qwZXLJP0KC4JWT/o1DNU8K?=
 =?us-ascii?Q?cKJ4/vhATyJNykAVEVj2AlfvUVyLl7mp+0a63tTQXFwheLOeGB1rwND5+fmm?=
 =?us-ascii?Q?YiniyAi53HrBVeRqtOk2Mop/mmy18y9COwNqCCnMkxn5RM5a+5DE7QChTlDo?=
 =?us-ascii?Q?sedKePeaKmwnPhJTmY+PnlEnP1kIuQqKcCZWEt2btvlldg5fBQhz3zVxuY8F?=
 =?us-ascii?Q?KYyD3GKA/BFvIT36fq1Cd5D3oY/V1jBiVG0Te0q7NHR9cd2NFTajY0NzzPbN?=
 =?us-ascii?Q?qIsi4HEkF+PCf0JJuyfP0qWfQTmaCKeZd2UF8c67OxGgqDnUR1NHOgIJLqBd?=
 =?us-ascii?Q?EUtGXxND0pD59epJdj/QbZyvoUVCew42cB9LNuiWq6x/wiCUwga+LDZt/SPu?=
 =?us-ascii?Q?/aofmYFVrdE16g/+V6DHCmv8iFQAfWjU06aigoqdzZ5wtKHBlIltzxDchROq?=
 =?us-ascii?Q?YgFugd3DE0krqZ6Pr2IIDVnMKBM/yzG1ii71+7Ti9ZgNoGINIjbXexuSEOK1?=
 =?us-ascii?Q?uDc/UnUqYBWIM60EcJS7tuUNAkkXzPKgudNY+PPM2srcD4teJJqZIamrrMNX?=
 =?us-ascii?Q?CFRKNfO6ST0lhm83xMq/DfZgLpzIBh4IFYK4NhSU9PW6W9+Q+k+joSW1qWLu?=
 =?us-ascii?Q?e7HygZFH5CBeux9cP2UfMW4C2f4xHjK20Mhj7iXyfa+WK31u0lvYTyMozXVc?=
 =?us-ascii?Q?GzYPZpBrct1DHCAea0RA6mskJpLybJCKQIfv0i0p/WUR22veWmRBHrAU4k8M?=
 =?us-ascii?Q?uRUNNfxlclXDG1MWNWJWDZNE2CNKE5tJ5uyr0UUhCGxAlCHZLWm3N217xGcz?=
 =?us-ascii?Q?zDKUQcRLZJdzPA394fbE9eU9PYAUq2neMVlv1agW2YFUowgGmgYIOcvsRVb8?=
 =?us-ascii?Q?ExiH9F+uFNsEZj9Fn8EDcLd9VNeCbJ03Ho+ucPJoAgJSt9Prj6Z3DBiN56Em?=
 =?us-ascii?Q?qM+QlqCzPUcvDqEXB1JmAiGvrTVLFu+GSQsti92b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fc44cc-0478-470f-6967-08dd5c7c4b07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:58:26.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QftixZDLH1pPdgY1laDlsmep8eW+CuiS4FIhUwQuD728n4zbVxyoGOsVbo62E1AtuImCP3eZDhfo8pSj2bo7NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10584

From: Haibo Chen <haibo.chen@nxp.com>

During system PM, if no wakeup requirement, disable transceiver to
save power.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes for V2:
- add return check for flexcan_transceiver_disable
- disable transceiver if flexcan_chip_start() failed
---
 drivers/net/can/flexcan/flexcan-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 8415ef71f1b1..6c59c2cfcf05 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2292,6 +2292,9 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 				return err;
 
 			flexcan_chip_interrupts_disable(dev);
+			err = flexcan_transceiver_disable(priv);
+			if (err)
+				return err;
 
 			err = pinctrl_pm_select_sleep_state(device);
 			if (err)
@@ -2324,10 +2327,16 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 
-			err = flexcan_chip_start(dev);
+			err = flexcan_transceiver_enable(priv);
 			if (err)
 				return err;
 
+			err = flexcan_chip_start(dev);
+			if (err) {
+				flexcan_transceiver_disable(priv);
+				return err;
+			}
+
 			flexcan_chip_interrupts_enable(dev);
 		}
 	}
-- 
2.34.1


