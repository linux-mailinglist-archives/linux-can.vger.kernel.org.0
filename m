Return-Path: <linux-can+bounces-4372-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFEEB351E5
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 04:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EF11B2841C
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 02:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B2A279346;
	Tue, 26 Aug 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="U9RWVBgB"
X-Original-To: linux-can@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012058.outbound.protection.outlook.com [40.107.75.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477823D7CB;
	Tue, 26 Aug 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176707; cv=fail; b=YLRNLWO/FdtmV8qR5G2+erkUoVk6IvFRRILpOdYvbAXV6LkpFG23k1DQzzZ2KsDjzcPpXSkvkym1RQghzFjhAfWMqCKHUAdBjx+qu2weI2MOTj2TAVRKT3CWOliMyJZlY4z1sH8UNcxXgS+SNp1YUaObIp7c32LsM0V2qVLqE3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176707; c=relaxed/simple;
	bh=GoBEXiaye1NNJ7o5H5wkIpPdc66LCxGTZFkTBowkl24=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=plnQgp9o/fTn1+JXzXEHKk4AcNL8HM0n79A1YcZw5T9TPHF6HTekLfVe7+B6rtLKlUgy3OIEjPMM/sLQmNcmbIsZukEnGhmxRi1ctWqLWwNZ6HxPc/HiVVvr0yQMmhebuesmAiDeJAyOaRI6sV0BTK9qog2JjxgKVjQfhho9aSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=U9RWVBgB; arc=fail smtp.client-ip=40.107.75.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3S4vHEl0Qp+Vd3WdyK2iFIml+n+Q0KdFmi6GtRaPHqByDK6mRskDhuwUKXzQIaUFQZXmDdB2+d5q6BCp1Raaf7eBSpxGag9fiz/rmkIbSO0bEsGSK5CdvEdacV6tqqhpqqqum3ojiQnMuFhXLWsqyLHx15igKADGKpoy6p0xi4z/ctl3YUKFWlK3XV7CRipJdYc4KHMCyliYFqUfWQEdcCkZeruYc8oNrDEAiTKwveKtg3aS61AwL246Dm7gcY4MVcaDaGljoVnftTYN/ps8lHftxvbYjjzgpKy5mzGIQsF2dkHLGIHGM93GiX+tHLPd2+7YIyFVVaupDrDb9R52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XpJ28IIWri3k6WUpaP9iYCIo1D4G5MDSH4fe14xBW4=;
 b=LZ+f2wa95cC6T+QD7eA8HlRKzKcRaZCtU7jn3TyW87S3OvKRBW0REQNDvcnj1xRDw42a1xYOjLxgEmeukkL9+76zTpxYeaTM+cdvRMU/wNBYINjvQbKC3q3CAgYGl7BzYNFXqN15tRGrTp4Apx8FSXKYq6NOqiUyML+kc67UWb+mLAdyW3X6GqWGxQ/G9bLDYyC1fPyZEk83BkWhSHUE5SJ/0JGDK+OF9KRIYfvXxYEqTW6myR5qcbhuGPXKu7/Z8lR557CqgrwYf06Q3aBL5PhFTLJ3DQo4s/SxsGMk6eMwnuamdv4Tl3QHsOIB4qPc3Yfd9fHafTj2nfr/xrFeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XpJ28IIWri3k6WUpaP9iYCIo1D4G5MDSH4fe14xBW4=;
 b=U9RWVBgBBo+SROYHxXUVbhaZKVLGU8LQrXK+KUVJmXL5zb1V872gQlj9Em2/K0hrFoDUlwCj5BAGmRW9cyKov4N353lkGfqvcMCQfHAPYLUn8zfRrb94YiQHUUZGEGlsgR7yJbfW4aizhMGGft1lpyc2SQz2y4H4WdazqbyBdcXsYrUSEGAbDBovueyvD7ita1Vd8n9vhIqRQBcoTCzGJfUqtrm856ZlW/z8Z+KsnyXYcmB0ff39KeQ76n1NXDhBAtU4Nfp9P6bvWkBZeYa7dSvTQBB2Jay3BP4QAnr8a2LKZ3wt5RSFPXxWu8lLpoKqITgoSZqQAgqpEQApbUuYkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6734.apcprd06.prod.outlook.com (2603:1096:820:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 02:51:41 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 02:51:40 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: rcsekar@samsung.com,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Markus.Elfring@web.de
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] can: m_can: use us_to_ktime() in m_can_set_coalesce()
Date: Tue, 26 Aug 2025 10:51:31 +0800
Message-Id: <20250826025131.112900-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: ec916793-d77c-4309-0904-08dde44b7bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V7GAD80knha+9fv0JgnaZJ1ucRPeyrEVCSs/adwAfs+HyU0Yb+LTJALULlPO?=
 =?us-ascii?Q?/dkIMZQs8/q6hK6pn92K6nytf37P4pBsLqsXKIX1l6B4Nh6MNFPsW4QWaCav?=
 =?us-ascii?Q?HMwXPk8JcjPsu6JWQBjIOwQp2CRhBO8NvyxbA9MKJLq5osGAMoi9Cd17v/gC?=
 =?us-ascii?Q?pgRZk88m0xgZ5UMlNVpJDB4hPWBmQWCd8Jw8lIrADhBRd98CGA/gvz29HyCs?=
 =?us-ascii?Q?tZPsbXWzt17jnFJPrI9+ekjkhX983jhwXzg63hYDH44FB+ynpabtJI+ud7ja?=
 =?us-ascii?Q?6upVLhjfaJOhl7laaT7fiQ3olzgBWygMXBxBbrO3KDNg3zvBZEd1+wl+CAsZ?=
 =?us-ascii?Q?5M1v3ZvUhBC/9dmevRXHcynUF0cBJhFuw3+4hHfLI7UtQhOdl5WEWCPTw4+C?=
 =?us-ascii?Q?sXlLRbulYxnmjDTygDbzTmA223Ij3Y6cn3/OmuxobHo0DrRdp0QpJtjfObMz?=
 =?us-ascii?Q?GWJlEBFo2WpU205cGWy1+io5A/a8viwfmBQrdrXLdp8hjbroGzNM6LmDQp6d?=
 =?us-ascii?Q?86rxz69p+rs6M+b3cAIcrIc6K1QCMd03lvpzb9aZYFt23YldjA4ZsSB//pFT?=
 =?us-ascii?Q?hkyakRQRrSKxChhuC2EfGzJWpKpgQOVy0smowszvgwkcVKItg3jFhVUkbPOa?=
 =?us-ascii?Q?lz11EOlG3QDw+01tKC3hjzHBhUl+aCzBN/WnHrj9qP8tVfETZsi1axplJ3u8?=
 =?us-ascii?Q?AWiCXjiJAWlfLka9IG3ExJSvPD+DTHlpuCYWs9ry8jXtIQRv2s6Qucm9+5cM?=
 =?us-ascii?Q?n2wFVdvou3u/J4Mp8pDKE2iJzYhyjMDqN77xesvz0wbefdvPvKgsrZLoEvt2?=
 =?us-ascii?Q?n2chUr/UU6a0gQElR/aOmErcck7NVtgf7R8o4s0HcKOUbMxA6l1Zrlq9o6Hj?=
 =?us-ascii?Q?+cyAWz2CpLN0UikgpfPhnG/uU3qr1IOYixVEYXzEx+ChF/H0xf4qdYfgVwyB?=
 =?us-ascii?Q?ji8gKngDGvKJ5Jc//oozZfCGjmkrM54CiAEZj8dO6fduFNp0soo2JX5BJtkt?=
 =?us-ascii?Q?o+aPlfccMv2joCZfqCSg+9y7+ifBPcMWRL/Hc9quZ+89CSBGP3EyBFzD8wqz?=
 =?us-ascii?Q?Gb9prbgR9Q8SDycXQaXCoSKSGxtgvjf9TgXvl8nn4a40vNVIsVoLTjVXfxSt?=
 =?us-ascii?Q?UQ+5FLqzcWK17gZ1eqbpIAYw5Kl9sNxgAfedYKNVb+3Nf+81Wo4rRO6KLzLf?=
 =?us-ascii?Q?4WaH/FwI7lXtvh37FASe3OJuttFAwPPVcMmjildB6nAwEhma5xdIbyteJUe5?=
 =?us-ascii?Q?pOxTS2ilvODgSpAKHifCG1tnIUYo4xvKpxNna7SGAFtgMg4KgZouTn/rVPtC?=
 =?us-ascii?Q?tWl7goQD6YVc6YXxRBCx940xzCixyKKvaEU99NLqAIV6M4AQYDR2qXo0O6Y4?=
 =?us-ascii?Q?e3n3AWgokg7R0nqAubHEaSIUc0++MwlrBSTiAOC6WQQg1AQG6fPnHW/AmQeb?=
 =?us-ascii?Q?NVDGd1Z5uKuNKq1rmXkRgnbhLGkvC4Ugd75iRIvmXq2769DtcU3KYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5YSsk5FceTS2BH5tjLjPMfefL1EJ+l95rT/m2l+xJibRyucYfR+OhZaGtZ/?=
 =?us-ascii?Q?4SLvPHIaNwriunkT8fG9ohvgj3qsqjO1CUqP5wK3odTtlja7uGalq0G/m5o2?=
 =?us-ascii?Q?TS+VpSSzRbKj/TEnNzEz80JeDFdXXjvHGTTdaulrpzgrmnI3RKYMBHjdSc5m?=
 =?us-ascii?Q?balptiYz1iXc2xipdoPsW1mACL60CDdWadkhcNJDIUsKi0zAnoLaB/ujO3tV?=
 =?us-ascii?Q?8u+qFrCY4/oaHekT0Ffky7z5rSCcEfnEOwXTT3N/ayPDr13zqx3y85CO5xiG?=
 =?us-ascii?Q?7YN9HbyHATb+zOWFQvT04LIw2BfHz3KWr8bjnX7n8i64saJYQzYzh5blxOxV?=
 =?us-ascii?Q?kLD2siUhCUZzDTtUsFU4Oz04AUwQz5sA6Zmt/EAcHGgxkX2RvVYPnYKM3Plj?=
 =?us-ascii?Q?jbie8i9lo3RsvvUVigeW9nq+gXILHAw1zWxNqNz/pLQzwJvu/oZHHnJ051hR?=
 =?us-ascii?Q?e12TpDSQCb8mks2d2tggro5XK6qTPzKbBJzX5Lo1FDlPIf+DowNSn2ggjKAo?=
 =?us-ascii?Q?0X1Akv0Gbw24n85GupOTQv0UQO47HtpmGgSvcIbzcrvItSJna1G4hOjKniuo?=
 =?us-ascii?Q?XWf0bY8nkRMupqlshE3XhqFinr/L3PxdI4vTIEZtWjSvNgFQoOkpYi9otBPl?=
 =?us-ascii?Q?UOgdPxIi6RCBHDN5CzULVZBiByqh3rsBhY31UTeA4TnONUAnpumNjOgtsRp3?=
 =?us-ascii?Q?Q+k8LuF09ekPPy1wJZORm/7MNFy/dLWGNOf5PPQUGyV1D9ZLn4w9gdYsG4br?=
 =?us-ascii?Q?YSjb+h1W/LsXkroqwHJIjQY6Nq7fac9UGQmHHkVv2hOR9dNw/rwyo+uONXqP?=
 =?us-ascii?Q?okeO+9CJQfecNueXmD+hBBC5VW/rLgLTyHFHOM51xyBVwT85c3xrrDgcIOBs?=
 =?us-ascii?Q?cT/+moBXDIQ8aY6t0Bk6Z0wZEG5TRVGzi/4cPTbzBxo6Drcvbjx8XP7EzMlD?=
 =?us-ascii?Q?sBos7Ek6DVlG58nlGLn8pSYGDwqpKYKYeLowyiUTmaCYizyGJhqfwL6gMOiz?=
 =?us-ascii?Q?p2eUk4LungjF/9NFDS+KKA5HbgH7bjUhRYbbychvBmnubDNxNXz0Un8F/7oS?=
 =?us-ascii?Q?uSSbW7WDQH15rpCqL3k1b5saMAz5D9+Jiaw+JdqGdlPOYHkxYytKm2D9sOMm?=
 =?us-ascii?Q?RK1qUZ/4Jwn3fAXm721+YQfofow7m9hPUjGdsLWVejksDpSKAMNsCTPwgorA?=
 =?us-ascii?Q?v5oyDWt7QQxl7ZSYbaSSOnITZWU60eQmASneCfxIfxOInxwWhDbNeAcR/ck/?=
 =?us-ascii?Q?t55YkcpN4in3fIuL/ZwOcjaTGIIXiTKKbvoTpAZNJuPawH0wxYWrS42xJFov?=
 =?us-ascii?Q?RSA5ADy1h0lseIt2Wac3N71P/mG4j+cWCdce/JRmzA9paTZB6bcKWfDcUD0u?=
 =?us-ascii?Q?I3685jrVbFVVXwXV4u1LlrmrGPkkO7vz8RNApEZljphIhQMwSrdl2xQd0cCz?=
 =?us-ascii?Q?FNKg0yMvJaQ9M6ekv2XFcd/70ZelqIN8fZNWaZOooE8wSLwQYb9WEkWgZuGc?=
 =?us-ascii?Q?grbi5onnxHdiZKOHFwFHxITS+TOpzBYh+iP5HCXOOb9UJ45v6qyg21jG1qmm?=
 =?us-ascii?Q?j7N+I5PQjGAawPiXHTMv0M8WTtj2bZeO9Bw86dR2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec916793-d77c-4309-0904-08dde44b7bad
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:51:40.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIStaP1j4kqd7i1Cv20V++KPC1rkYQ8J07vDuHS1/TSmkOyx4RW3k+qQuLYjhVdyE8UHdIG27sr7ceK4v70BEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6734

Replace the if-else statement with a ternary operator to
set cdev->irq_timer_wait. Use us_to_ktime() instead of
ns_to_ktime() with NSEC_PER_USEC multiplication. Simplify
the assignment of cdev->irq_timer_wait by combining
conditional checks into a single line.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
v2: Simplify code. Modify title and content.
---
 drivers/net/can/m_can/m_can.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c966..d4621346e76a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2211,13 +2211,9 @@ static int m_can_set_coalesce(struct net_device *dev,
 	cdev->tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
 	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
 	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
-
-	if (cdev->rx_coalesce_usecs_irq)
-		cdev->irq_timer_wait =
-			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
-	else
-		cdev->irq_timer_wait =
-			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
+	cdev->irq_timer_wait = us_to_ktime(cdev->rx_coalesce_usecs_irq ?
+					   cdev->rx_coalesce_usecs_irq :
+					   cdev->tx_coalesce_usecs_irq);
 
 	return 0;
 }
-- 
2.34.1


