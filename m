Return-Path: <linux-can+bounces-4125-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93108B11E9C
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2625A2FEB
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4C92EBDE8;
	Fri, 25 Jul 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="eDEAyXUk"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2105.outbound.protection.outlook.com [40.107.247.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4023F40A;
	Fri, 25 Jul 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446776; cv=fail; b=bmPDnHqFUcUAc2mu7+30XesvTm5u0edbL1iusjk6NTlt6KQUp3xok6WpgSkvgolLHEPbD5Bf7diUTy0ObWCeu0VQgL9BqN2RFYSX0IaxyGn9LShM/cplo7cAzU2JWdhhVt4ySFhFM29EeqLj7/NHSTwCAmJTCalwijvszVyCDU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446776; c=relaxed/simple;
	bh=wDvgn3T+rAhqsv0srQBOp+avCDf12WCBGtkF0FNwAy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GyRGIcD7GvDTIaHMMgDKuLRN3cYryLAq+9rt0hyG8yRsJv23C16xX4naLAYUnrdl001AN56UN35FD/m9wcuBnMC7x4MK213MLvI0tWOSWX10ib52fvl3oOwbKSS0GnzvnnonRQrjT+HzOhwN7iN5mQJWK9P7UUlFLWd1DCfFwKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=eDEAyXUk; arc=fail smtp.client-ip=40.107.247.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHJHw1M9I6OZTA5+XBHJfQqLX7c2+cFD9p+PVnGz9VoxtvDcBdbRFbCtaZ2q0IB+kgxfkNqmpiPkza7UprTMYVlkjYRZ8o+T0H7a23orrU24c00SF2d321to7xt4TgE96bdx4tZTcIkNrubrWQYSrNT7whORZpOx+56GLRfQ06NMc/1TA/IbsqQXRr5Ze+JByWxcndVaZj4MrR/CdPqEXYAdp3tIi/x1pQE68RcaJC0tUORxj5FCRUAwXoabwTzXpBesuC4RvWaTk87IQJUM/CbGjzmW5ljcXOcDZMgJ3RkmflxstGVcaNCbUJWpGTlo9gWMZK2YHJEwKpP98Ux7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeCfp/qofGpopyyavy8UsfUbNkEVArb/ToXx4f7jq4I=;
 b=tacMu+LezLNrNgQbruIxwUSnx9qDSxEcxIqpJKDCOThyZe/ILR6kZNz24OcGFNT8HVJz/1Zg9Yanj2GyYuFkSv07OZwfjHSc5TPqvbSZSzMHf24If5UHZKuTEe9avpI0LE7LnvolxqWjwwi89k/NBwZtf/IL+ibwSIiRVZvLSZ2JektdgMsy61bwwou6X65SURaiA5iKY/9AAiQKsow6WOll+ISvD8iNO0p8OKnKJYCglhZ6lt9rPvNTJb2cUpEPlrNE99q1nmRyRhaM7Vd9csCX1lep4kXY3xTKJ4rQCJ0wyBVFQaeVKHejwnmC1kaOUprV28hTevyjfWAnPHG/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeCfp/qofGpopyyavy8UsfUbNkEVArb/ToXx4f7jq4I=;
 b=eDEAyXUkak7ZARd65nMXXERK/oJJoOxnDzdJHysAD2DsUgdCzP8DRKRKtYEarqtily/S3ELebgbSbZsb3zhMbN9tlXQmh0UqhRw+ptPkZJP+iLc0vNz0dH8TaJAeyJsfUhN4ZiQ44qJPL75uoqS8hmYsqvzxxw2tk/UFjHDJYhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:46 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:46 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 02/10] can: kvaser_pciefd: Add support for ethtool set_phys_id()
Date: Fri, 25 Jul 2025 14:32:22 +0200
Message-ID: <20250725123230.8-3-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: f20aa2e0-c6dd-4690-3c91-08ddcb775bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xPDAkrJtgEBLtT43+ZXPAI0fKx6WMdySeIL1LOLX+OytECiegrR1LBC4zOQc?=
 =?us-ascii?Q?ZJqr5iu9I7+4mdDS+Fdrx4Y5DXEQ+XxV9znMM1hFkMpD9JyPyLTtC6t8Fgze?=
 =?us-ascii?Q?OwUUln6m3evCykxONkj07Fax/8nRmLVHS3DVuJpdeP8heHdxz5P/AIgtn1kf?=
 =?us-ascii?Q?GUmRVwuedeHmSzs8tksC4A0aAMgx6aLQLuuPGR7/Kp4X4zdUwoUc7Gvqnd4O?=
 =?us-ascii?Q?/oy1I6ZV3Iq1lHoLhciT1MvJ7bh+5bucZdThEBBAZk+7vmth12zB9yvErfKh?=
 =?us-ascii?Q?4DkjrU8k+c2PNfKBrRfuDBGy1sGMMxmrplQooJGYa05zYfecvBF50Lq3ds24?=
 =?us-ascii?Q?OtSQxjzWf+J/yRWR1rdtUxNJ224xe2AnODPxPUMFzXG0NZzFCnHELr4+8iIp?=
 =?us-ascii?Q?DpqBoduft7UNGlKoqoTKje6q6YJKt1ee4ZAVcXkhSfWLDhTeqlY3WiqntYq9?=
 =?us-ascii?Q?rD7fr1HIVl9mK+nlBskI/EO1CBA3jfLDsuGibBjY1A8z0lsB3CI9zAtawZqZ?=
 =?us-ascii?Q?uB3G4creifwymHVeF5lC7uC2oIKXqyNp7xAez8mtQqFuJWNKeYNpXlDq2kzg?=
 =?us-ascii?Q?Oz3FHGX3uKRga+cquRaBPk/suxM/FIPbFucZGMrtLDFc8vNYYFrQeaxdcNfY?=
 =?us-ascii?Q?lprBDBcgTVchrh9yO2ToAI+YJZrMSxjBmUt0AnZucgYbB7A7Ckg+UZkjZ0ve?=
 =?us-ascii?Q?ZufFx5h2fm8wpHYy+nLxeTSPdS7+3Fu3YpINEB7/Nmo55h+J5MgB76+Ee3hn?=
 =?us-ascii?Q?EQY2kxldAPTXviEYLO8J3lhiz+542ibGnIIndfWReqZaQWC74mqV/QO/HDZF?=
 =?us-ascii?Q?kePW7TEVdYUfdeEIguBjNnXYn6iRQsvV+qjyuDUWXKyUUW91zeTWK3lEZ4w6?=
 =?us-ascii?Q?Zl1gc/s2U4JrUY5yKSmQQScLgRHVS2QC1LmFO766lg2e685plZo2fLGrUy1V?=
 =?us-ascii?Q?QDR1PqG09398xQvfPC0P8B2Ic3beQMnJS8hga5OJutFcYdcBbYau3j0Ssg76?=
 =?us-ascii?Q?2udbqMfXAIlEGovnZ2+6ntsrFq2k3lrmqgECnRoXAyacR05S+hpzoLbmL+wh?=
 =?us-ascii?Q?hJjyaPrxD73J3yQy2haxI7Q8/aP2y6zDWfnfoGeJyjWC+C7TAJ35RUowByFN?=
 =?us-ascii?Q?jTP2ME3KjTFtG0fk7wEWKPYaLof5I4zxhHXRt5+MOeizP8YuqxbnL47MJLVI?=
 =?us-ascii?Q?xoCRmHxOXGdZPFoA0EBOdhNt76r+PRJziAgHkpsLn029GOg4Yb/l9KENPe4C?=
 =?us-ascii?Q?5RJbvSSuUh8JazBcvCHI4S7Xr21MCMNLo06MU1qEkVTJxubWp+wUNaSSJ0MK?=
 =?us-ascii?Q?IpaXQ712FNMgAgTSVUzKfgVLXHI/BbmZeL5XIKfoI9S4ikGPNkCh7Ca2FDvp?=
 =?us-ascii?Q?Bs64ArQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35pgdnYkgwaIKwUXPXH8RMjzGYQ/Bmpqa5jdmDZOFxrRC2H1dP8uW0f1fijq?=
 =?us-ascii?Q?MIhPbibWHPikjRXBVqo/Cq4qMvbO3cp1CUFXb1HZfXZy3Sm9kMMtdMSrDoxI?=
 =?us-ascii?Q?EMwXZ5t1e/C6NbyYt4jJAStaxCTCQcSzwsrU9QtkYJ3f0oWJnekCAcxZ3Wnp?=
 =?us-ascii?Q?MDSFzUWRTQZsDT5iQp/qRZvuKdD0YJNJuwrubKsGv5mNXMcAqLjPZgP6f7HH?=
 =?us-ascii?Q?ULaqLfnFUhoCK6HgltKAkEe+4o+7BI+Kl+uGpp0CY7O8h1gX6ZQqxjd/zthJ?=
 =?us-ascii?Q?zsIc9CGtS9l6y4eH7rMQdU01zvj0MlSbIEdPwAX6AkjnX/hjSKVF7BJvqm2G?=
 =?us-ascii?Q?7JO86HjSEOd6fURR3DY36Mz9mfn/frB38trNnFSvuftMMA/QzYimmsLHwKmL?=
 =?us-ascii?Q?Oh1i8C8Dbni2+fr24z63xCzKBYIZFcr1Yk5Pt/9N0d8/rqncrMp3FBKLidu6?=
 =?us-ascii?Q?itDczNpcig/iTCRG2GAcmULJ91214y9Xb/IsOz8PhONCcjwb4O4Ln0I49RaS?=
 =?us-ascii?Q?6kTafHw1ydlEd2MX6QxhZUhTn+khQTiuFXGkwe16q/yPEUQQmLGlhp2gGyJT?=
 =?us-ascii?Q?xr9MKOryPC54vWwW/ya6kjb+yrdYYklp8OxdiVYJ2vp/gpNTpnif/KK7TyOs?=
 =?us-ascii?Q?FLh483N8LAxvOveCqFHu66PokQO7oloiueE0RlOWc5r+JtttTnntuFVLXDqR?=
 =?us-ascii?Q?P59KbM9jpz15+kImLk6R9osfeQPNTd18a/puFwe/vZsR8JwFmJBtOHEIAtv0?=
 =?us-ascii?Q?F55hlHybr9HBJmuI8t0DkothjfxptEnpd4X6GlHqLWG49XAxRUjFg2F/nLST?=
 =?us-ascii?Q?iYvrUan8aiGLILCZX2CiFfR81BgabQpyhFJGGTR06n1yoNt5IF4BQ016I/z6?=
 =?us-ascii?Q?8Fw3OPTuR+3wPMKvDguuen98f2JMhPzLOgkEbjuRiRL61QJdAT2UthI5lA+c?=
 =?us-ascii?Q?+6jPRLxeQULMyn4hBUQL6k/zVHOR2KRfsKunKotXZ8C237BHXTK4EstSctAY?=
 =?us-ascii?Q?+A4sMIHw1M3RgkK0HQenPebepnIRbETZKLZkr9g5uQTidXDWAQ6JZByORhMn?=
 =?us-ascii?Q?KjF2VL92odsDsisQM714aq4F2cWKyjAWfJ/fcZpUSpg/Q5NIplbEU1QA14Z6?=
 =?us-ascii?Q?Cq4+ELsS2oZb1vXLunwBhuxpLjK2IDEA/nQ/CqmsKqdDenAD7mlxS+Z6u2qs?=
 =?us-ascii?Q?ryouFR4/jeXZkT8F+6PqISwJPwmHNdiQCnghfRWUP1lMt+DTCdC6lUGr/8cF?=
 =?us-ascii?Q?GXNWwszaO84vRX+IjvVj/dPr8s0D9gOs4S7RGsuzcaIMMinf6fYKcIZC6xXl?=
 =?us-ascii?Q?ZPeE3ZEcELTQIduhPTcR3gkUSLTD4doezs3NvELu5cEcy4UMtnndOfo82dGV?=
 =?us-ascii?Q?zdhV1yrAZzfWJnRm3XDh9PmwQsZf2jMA4+rQ0r6JDfZ+SCIcayfdK0UM2qI4?=
 =?us-ascii?Q?jm8Wv71NpupZLK5efllChyccuyZcgYI10kD2UIpdgWy76ulbVhtImusG8DHt?=
 =?us-ascii?Q?Ef9BHQnViw5xHfW3ht/v6JFQ+nShVUZluF4iTVyyIPBk0h8ayAUsqQFKvDtn?=
 =?us-ascii?Q?OOi12VHPQUVTohgyK0cBxfdfSMgp0FdmG2ou/P+23zme6/YN/R6fXX5J4kLW?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20aa2e0-c6dd-4690-3c91-08ddcb775bf3
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:46.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV7fpG7xF2cv4guT/x/b8kXxdPfeLtmm3vOSUNIGTcnEqw+8EHnYCN/bcd5jK2LttBxrSKhei5UHntjqwJNYeNlD2J5XTflBQU535kUI7Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Return inside the switch-case. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#md10566c624e75c59ec735fed16d5ec4cbdb38430

 drivers/net/can/kvaser_pciefd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index c8f530ef416e..ed1ea8a9a6d2 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -968,8 +968,32 @@ static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
+				     enum ethtool_phys_id_state state)
+{
+	struct kvaser_pciefd_can *can = netdev_priv(netdev);
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		return 3; /* 3 On/Off cycles per second */
+
+	case ETHTOOL_ID_ON:
+		kvaser_pciefd_set_led(can, true);
+		return 0;
+
+	case ETHTOOL_ID_OFF:
+	case ETHTOOL_ID_INACTIVE:
+		kvaser_pciefd_set_led(can, false);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.set_phys_id = kvaser_pciefd_set_phys_id,
 };
 
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
-- 
2.49.0


