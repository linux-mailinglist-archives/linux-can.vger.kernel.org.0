Return-Path: <linux-can+bounces-2665-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC3A17012
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 17:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E13B7A1D12
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962E1E9B11;
	Mon, 20 Jan 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pIoNqRNU"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013023.outbound.protection.outlook.com [52.101.67.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D81E9B18
	for <linux-can@vger.kernel.org>; Mon, 20 Jan 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390235; cv=fail; b=g+s6fRfnExL1as3yCQgoLP5J4xZRbyOBGapVkBizeCrqg7XB9jSfOKpX7+KJJ6CGPD+5eBzwrVUZyVlAZtqhaxVFsGO4tLVVf1a+YPEyxjdjFKqjnaQJQaI9LTRcDCKmjm+tLFW2HRBSshhcBMinLjG7qBAgR8FTY+TtKAh4+Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390235; c=relaxed/simple;
	bh=jzHgRxzhfOUQgEMUFRmDFm8DS21JWtXKnYzo8dLSYA0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YRV05lMo+QHOL5B4lPYVgIHAZhPfzCI271Vcpbm8n+Qeixn7WBONAtw5/8MbddbG5qeaBo9ndubHvUHARX5jUVqtxNNiI94rBORkojJTgKaGrbyRcqWuZYRrhcu7/7c1vOps6xigdtyoM/sn5+ykRnx17LkUxzZ3AOiFFjf8kWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=pIoNqRNU; arc=fail smtp.client-ip=52.101.67.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy6Seq8REKVUWzkUf8fY5OJGWTuAIy74bDU04dkVzc0gh0tGba/Y6y2bIPzQ7W2f/G/l4DBV69aPnSsL1Z5h9zOO6I9cBGrkHlJCda0iuJeswpZwdCR/xd/Rwo8oggFvecb/KT6UMaSRJwR2P05vpbzLAaAMaoHgwYpsMAlB7T0VxVgYxusWVqXS4NbkZB59+V8mlCg1qqrqkZN9njmN9kv4mF2QPDPhetbHe+DnvnEilq2xb3DrZP6Gz7/YTj4vQ2aDoQiLF6A58+oHjIDG6jxhpKY5mYqal96tLJzonQBpxCek6Y6xfrTDYlWu++0Q0x/PNm3xu6sZM5igvsHTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcjY5EQl6eRrhFURA4wNll8GwXlVwYaIhd6isW8wh9g=;
 b=yGa/xIP9/gbR+od4M1D93Ic3eAy3XjJ1Lu0IpJosSwdZhOHMWaQW2jNsXBwFjMKimO7d4duG+8KgpgoXFfla6cgmVqsWUGH5N7oARlHTOxOlrPZ/OxyR2RA73E1I00TqgUxhSvQNSwQr3RiFxO51oNMQgXV/9yK6P7NTsqJ+nDdcUHslPRrZWbDErGOmAsT6w5j5Evq0WgbWlpW1jjLnjINlMbTlnVoBlxO1YofXf+jpthKZV8b+qZuM++RmWZeS+LrY5eUh4RaEigrz4zSBgdc1ql2RtJHxMYyCMbRuoc9+fvN/kz6lU7nw7oWrKOpG+BjkWBbFmxV8c+IMw/3dSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcjY5EQl6eRrhFURA4wNll8GwXlVwYaIhd6isW8wh9g=;
 b=pIoNqRNU1vbjIdPggUZOccM6rtbyU3AN8dzQ0PAZJtQdGUptMBmIIyoTjobtVsrBEkAXHHwQiqa6xLbUXou56WmAtD7mmztuOudq7Q55oPq4gacR+zTC0sJ7sF4dDwD5teIU1pEiOrEsojQ8hpDbVB9XJKRC/kMEv8qF3CEXLh7IrLx3HtS03nUa1mfvNuz+/GGWxjilkIl5saD1e1y1TRJH6Na3CdoFgdFJd0FjbayFOpO2B6zPd3CBYTyEKowTV0boNEZ5QCYafsziUmsXvDk9gpltKOOwWgJKFct6BcsFbZS0SumW/jXmTm+dCfsSDaMtW+4VTElbPCMxL/xleQ==
Received: from AS9PR06CA0163.eurprd06.prod.outlook.com (2603:10a6:20b:45c::24)
 by DB9PR10MB7172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:451::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Mon, 20 Jan
 2025 16:23:50 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:45c::4) by AS9PR06CA0163.outlook.office365.com
 (2603:10a6:20b:45c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 16:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Mon, 20 Jan 2025 16:23:49 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 20 Jan
 2025 17:23:49 +0100
Received: from GRB-C-0009M.ot.de.bosch.com (10.139.217.196) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Mon, 20 Jan 2025 17:23:49 +0100
From: <mark.jonas@de.bosch.com>
To: <linux-can@vger.kernel.org>
CC: <mkl@pengutronix.de>, Zhu Yi <yi.zhu5@cn.bosch.com>, Hubert Streidl
	<hubert.streidl@de.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
Subject: [can-utils][PATCH 1/3] cangen: support socket priority
Date: Mon, 20 Jan 2025 17:23:30 +0100
Message-ID: <20250120162332.19157-1-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|DB9PR10MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c1cd5e-82ca-4249-0826-08dd396ed2b1
X-LD-Processed: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?QJkZTwPTTeauFRjqGniP5DPWN6CJuK1u6YhIh5rwaTZNEhES00vEX6Wl0ABd?=
 =?us-ascii?Q?/y8kLS5uOn8QlQEh2xSw4MrNfDk72dxSUWgE88w2Ys/4mY3YQVFEkuZzWKYC?=
 =?us-ascii?Q?mW4pgjCRPMfsGeUC9TlbyGTBgsi9KZMLp+nRl5M/uD1ojRsKnriAJFetFayn?=
 =?us-ascii?Q?Nj96qwOfXXTf/9Xqk7qKrXNTy2zOfnBnrK8F6cWzWsAVgZ2+jrZyvUSRcEzK?=
 =?us-ascii?Q?Jj3HewGhBHREfPh3zR8mNol2N9LnaITbdJ6B+fU5bE69NZGVXV1C1LkHCEal?=
 =?us-ascii?Q?E2xYNT5edhlnpoqgbinsNLlA1hClN5BJ1LrgX2CrCpQ7pybkGE8chIePqETe?=
 =?us-ascii?Q?uVyX2SWlsEON3P8JHNUVrBKWef11mKX8lLlC9U8hKBLMavKCWOFV2B7gr99B?=
 =?us-ascii?Q?Mj6RMck4kPTEoaPJcihlSNGeI3VTGEWkwHPE5hogCMYBD5nQyeto7jhtCC0Z?=
 =?us-ascii?Q?QRPTYK2S2g46rU6obBcZjtB7O83VuCkQIMNuGKtZy/XPJLyBQuH0P/M5Ziyw?=
 =?us-ascii?Q?8dPPIbC6LEjU1kpq4/y6ni2s+uFeSnIu64S/Nn244IBXp+x8rZyLLoJa+4fC?=
 =?us-ascii?Q?LWXqtRpyHxzW3PoDq8G0L5HN29bPy1Z368j2rl3nZM/m9aw1mSx6DehG585k?=
 =?us-ascii?Q?N0uzgIEttM7YJOV9d6bvobLyP2lG28eDo9mJYTh0E+c1SgdQecGO63UinjrY?=
 =?us-ascii?Q?vRKcrQ44EN/2V+IyaqCKZElNdnFfqNYRov9WmukRYRe4TWobU4aIa3FSzxpR?=
 =?us-ascii?Q?P0ctBEBK0Cw+e8j6mramYVsI6WpYqcUW5dnUGMEILthy7xSqq88xhWsfO6nU?=
 =?us-ascii?Q?zt457kR65jWkgNeVUaKQ9O4myUtrs0yEgMM+vtSYcIMoeEAiP6VXi2vUvr+Q?=
 =?us-ascii?Q?tKemc65cwHVTOquhW46EmP/V3GisMtvidUswn5EvqigJ9ZXVj41L6r5J91RI?=
 =?us-ascii?Q?miypWpH/ac5TUj255cSrccCoz7++b5R/i5HEDh1QHIzsFS0i7qxIMJgnQO89?=
 =?us-ascii?Q?k16nWcyZLGBvhPhIPwfZjpkvkNIVj6WuFpBGHdXhbpArGNQmFShaJmMYKXC4?=
 =?us-ascii?Q?8kKg6E+328Dl9e36JHwMX8aKNU+346bxphPyTnmWEo67rfs2sT5SsmmfI+EK?=
 =?us-ascii?Q?Smua/IgsPeHvPMI/LofstnhpnOGaiCjDt3XqvN95o3H/h4kfGWRkQ0oUrK0c?=
 =?us-ascii?Q?OkWHuuKtTT9i7gEKWgD30CGPbZLfB8f7LUVPraZSj/8DPK4/9503wUKztiyq?=
 =?us-ascii?Q?2ktP8OeRGQkoCGvFQuAI4kauiijtSRF70rW0kaDclUj3DD4UCm4dgQBouwxO?=
 =?us-ascii?Q?8UkC31SVS+sW5djWKdpoWZsudN9vHituTBnyrI0u/E55iV26dPx5VqGVcRCN?=
 =?us-ascii?Q?7upHUXwltTObB7rBJb7WEaVDiDmn2wyO/+IRvegRHXBVT5AKAoVHC5dvaP/J?=
 =?us-ascii?Q?TwAJamU07etZXbHe9OEVZHU+g24wPQ/sDhVHNeS/Bg+S2Z95RfL5uw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:23:49.9700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c1cd5e-82ca-4249-0826-08dd396ed2b1
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7172

From: Zhu Yi <yi.zhu5@cn.bosch.com>

Add '-P' option for allow user to set the socket priority. This can be
useful in conjuction with queuing discipline.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 cangen.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/cangen.c b/cangen.c
index d9a0448..1346eb7 100644
--- a/cangen.c
+++ b/cangen.c
@@ -189,6 +189,7 @@ static void print_usage(char *prg)
 	fprintf(stderr, "         -A <mode>     (CAN XL AF generation mode - see below, no e/o mode)\n");
 	fprintf(stderr, "         -V <mode>     (CAN XL VCID generation mode - see below, no e/o mode)\n");
 	fprintf(stderr, "         -p <timeout>  (poll on -ENOBUFS to write frames with <timeout> ms)\n");
+	fprintf(stderr, "         -P <priority> (set socket priority using SO_PRIORITY)\n");
 	fprintf(stderr, "         -n <count>    (terminate after <count> CAN frames - default infinite)\n");
 	fprintf(stderr, "         -i            (ignore -ENOBUFS return values on write() syscalls)\n");
 	fprintf(stderr, "         -x            (disable local loopback of generated CAN frames)\n");
@@ -479,6 +480,7 @@ int main(int argc, char **argv)
 	uint64_t incdata = 0;
 	__u8 *data; /* base pointer for CC/FD or XL data */
 	int incdlc = 0;
+	int priority = -1;
 	unsigned long rnd;
 	unsigned char fixdata[CANFD_MAX_DLEN];
 	unsigned char rand_position[CANFD_MAX_DLEN] = { 0 };
@@ -512,7 +514,7 @@ int main(int argc, char **argv)
 		{ 0,		0,			0, 0 },
 	};
 
-	while ((opt = getopt_long(argc, argv, "g:atefbEXR8mI:L:D:F:S:A:V:p:n:ixc:vh?", long_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "g:atefbEXR8mI:L:D:F:S:A:V:p:P:n:ixc:vh?", long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'g':
 			gap = strtod(optarg, NULL);
@@ -682,6 +684,14 @@ int main(int argc, char **argv)
 			}
 			break;
 
+		case 'P':
+			priority = atoi(optarg);
+			if (priority < 0) {
+				printf("socket priority has to be >= 0\n");
+				return 1;
+			}
+			break;
+
 		case 'i':
 			ignore_enobufs = true;
 			break;
@@ -750,6 +760,14 @@ int main(int argc, char **argv)
 	 */
 	setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
 
+	/*
+	 * user can use tc to configure the queuing discipline (e.g. mqprio),
+	 * together with SO_PRIORITY option to specify the message send from
+	 * this socket should go to which queue.
+	 */
+	if (priority >= 0)
+		setsockopt(s, SOL_SOCKET, SO_PRIORITY, &priority, sizeof(priority));
+
 	if (loopback_disable) {
 		const int loopback = 0;
 
-- 
2.34.1


