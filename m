Return-Path: <linux-can+bounces-4350-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48EB33A2B
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12DA3BF9C5
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAD729C325;
	Mon, 25 Aug 2025 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WGR+pRks"
X-Original-To: linux-can@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013046.outbound.protection.outlook.com [40.107.44.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC31E51EF;
	Mon, 25 Aug 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112962; cv=fail; b=hRThBxiu2puxSARgpYGQADx6PkrED7qWKrpV8uQjU3ZhDpRXXzTtdOb7+U3lc5QEFwzQp/avU+e6IW/8GOy8HRqeC/ixx6DYUsLPXMagbL0d6OQ2e83py+wbn6f444KrOaXXxZfJePSELPzcNvzoL+9HIN2mA3MiAI50iq1Y65U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112962; c=relaxed/simple;
	bh=d/TYAlP1qcE8yq69ToxomNPA4C5qcbkMamWsV3N7t4k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cseW8XfnOHhzWAPZenbbd6IyWhXQokT6ZAwl7+CUWzCcTPSxKJpbvU0kZn2TgOfJy5yRoPopSnLGYTskOfljxWTRto7oGj48nbSZo3brRhXEY8nRsq83SvzAuCiUc567wieo4FMUNGHSB6PCUYaDPskz2wiQVDxCohxHoQk3pPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WGR+pRks; arc=fail smtp.client-ip=40.107.44.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN61p7GgTNDMLdGfOeqjGyrNOV2HIVVnKiF6oB/UTr3GXPpl7NH2e+Z8qopNL5Kjka5V17FvUI/ldJxXP9uHgXqucLTObakcUKlgBFIlWuLfP3hg1YkyohydAEfcTJx3YdVGlLbp2oDXWB5IC9JnABVqZetNfuhkkfYY/PoaIznDWcdTgIfFfkaYuDEVJtdH570BDMhf+GM8/nbyLBav1bPwLchIJQHedvsA/QNFmTlUW9wzYfI5OhJb0J75kMsy5tVwRK0ja0AXwc5Vz/dks95wqqXAImPLzN9rD1TwgZbkCBasYP0UrBCqA1ekJK3fuz+2Jl+EC4ROhkjQWxny6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ3gVLB4svR3Gbv8qZC1HHvVccHjc6YI4V1H9T2thcQ=;
 b=J47/x5/J0fVJ4DX8UjC8Sfb9nnsihCT0XO2IGjYhl+CbkvNeWiI5VpDkQNOVPvucrpqj6YZRV+EMhWBmlMI/anBKs6kfctprXv0RUvdL1aaazNZ7a7XHOHYiHDEvW+w179m9PT2GNYgLIHzacSklk5IY1Oc4/LueTU1SAaY/zZ0/PvigNL/nU5HrEOr0i41zyUdJkp4OSNxyfswRvkvK0jr6XVCyLw21rc6nDK5PbuK+1hsGE5WDK0B8tNnpCdAxX9sVdjMqrFf9RvZfiPfsk6a3ZaPN6BWS60ZLxH5+J9wVg3r8HYCOHHd1ykKR4nEazDs6bRHhf5pRJIBsLlaC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ3gVLB4svR3Gbv8qZC1HHvVccHjc6YI4V1H9T2thcQ=;
 b=WGR+pRksvwHXu1QrGWW0Pc3SuL6QbuqW1d3MiD1VVl7yNL8oC5cKqzYxiE27A23jhjf5DfhtMFTYP/eYbAHFdITZKC+poBhwAHGWugWqYv6s41TDJs4Ft5v6WvEyuEiC4bniQXCsfMDJkggRPTZXRPG+fekllthiFzRQMg3b9qeyndajiqW0FKSkZMnhDCbHFYYzZjpWS92alEnyMAMv3RrEkZKeoKBZyN+AdDMuKc1JacA0yqMAsZ07Jk+OxFUKKiCiXoNvTDP4MK3cOCleAbE6U1+NDMCDZ0qLdoC0igmbFNWYFIHG/I5MEUA0xeK/yjvAcVPPb1vJNMpiJpBZHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYSPR06MB7223.apcprd06.prod.outlook.com (2603:1096:405:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 09:09:14 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 09:09:14 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: rcsekar@samsung.com,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] can: m_can: use us_to_ktime() where appropriate
Date: Mon, 25 Aug 2025 17:09:04 +0800
Message-Id: <20250825090904.248927-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0334.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYSPR06MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: c36a12d0-931c-4481-2749-08dde3b71023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0v5ePlekx7XU3BrxHj4Y634Rgz4oAM/QNQ7AYhDUCIKVCdB4JULEjbdACiiH?=
 =?us-ascii?Q?SjE/CVL1ppFRGs/U+064PtJfb1XZD2RMgS7pcl89L6e7ziiDI/SWHXj/BGGl?=
 =?us-ascii?Q?yJUpLuXynfZQ2OXorJagi8vPGF/1ZseYPJxRkQQRegOrvIxkWwHHJJB4Scia?=
 =?us-ascii?Q?l4oYtLMzGR5nAiWTH6TyiUTZyES3nN7Ik37ob6tFyjDWJvB5gOPdg5IAv2nw?=
 =?us-ascii?Q?riqosUPFyvVdFzV5fiMgSNMWhUTaHDH/vDZZ/0nsQ2PPRTDFu3ktVeLfqvjO?=
 =?us-ascii?Q?otosH5awAr8zYdEupZSFyiRAjk1lG8ACJilKTdysS6UtIK8mhODd9nS0cru3?=
 =?us-ascii?Q?TYCOxDiRCXtAPAYgRyDEXSwv1qff4tgGBYUZI4QpD5KUb3fXJHXh2i2rWIfM?=
 =?us-ascii?Q?foXo765AjzuVn8F1SAu6g0ptXmRPrt716o5JlhObvtPEMF6SYD1UWrNn/+xK?=
 =?us-ascii?Q?ZX5q/pzOVYzTabk3qjtrtRq6a29rQIMSC8c8QY05Gu4kTmAjw2VMyj2frAoF?=
 =?us-ascii?Q?CqfLqB4joo6hvC1fPIdS5B4YvmRMP4jP9eH4KY40R3FvMGECBlqrvhraGnKJ?=
 =?us-ascii?Q?Iq5YymFousuHO5PwAlyEmnpJJZUg3ZWzp9e7TF6/iy9Zc4RaoFTjmgva6i/g?=
 =?us-ascii?Q?VQmaCv1MYe20jvhMlBTIqyOfGc/NeGfO8DmebzTVG/hHzz5n/O+0qRS4Exq6?=
 =?us-ascii?Q?ZqJLhEN92Vrto0e9uSE2GsOaGdYPq5EpUrQl6WXHc9Xq5YpGWl2lHG4myCow?=
 =?us-ascii?Q?JXrPDKQEngCqLmJePtt6gFdVID3POzWdpZCuuJiOfi8ER6qjk0EYsWotm14t?=
 =?us-ascii?Q?+IuwZ2Qv8z4A4bs9pl1guxePJXeRX0JPeZrUPd7ysXgukgvCemQ27iJfW5jP?=
 =?us-ascii?Q?SIAqO0CEyOiKRXSqxkz9KUATOYFXXCgaDKIkh1YGisiOz4iXHe5B6ojPa0Wz?=
 =?us-ascii?Q?zw1ZSrWmUMVPL2jWg6+Rh9Az4SY/wdboXPoBXh0oy0uzzXtx5zC/Z5v6dTSp?=
 =?us-ascii?Q?IwHH+il/EfsL4bAiapmE0WFpA2K3R9nWaXUdACpbhPuWJX+w/Ctm87Wf9Yrl?=
 =?us-ascii?Q?rXHev23SN3+T6BZnoLNmNMgcZlbYSIYmRgLe6BYLFPWUi5B1e9P1xyvuibPh?=
 =?us-ascii?Q?6uVRbOCMBry8nyp443W9VGECh/z0KvNjbDL6Z2c+E6hfYB74y8QoYte1NjpD?=
 =?us-ascii?Q?NEbUZ91K+v3iUS59WR8IIbnShoCmU1YMBWAHHgG/VeNK/hJfiYhJDhC/o0VT?=
 =?us-ascii?Q?/3Bmv+7VrjZB6XE1GA9EuZgOuTIkAkFnvr++wXZxlivsHvIK9HgqwWKT6oY+?=
 =?us-ascii?Q?f7ApSklsPfSwtcH7y/yne15VAjepp67QCv547Zbi3b5dk+jq2/L9fVIkslQT?=
 =?us-ascii?Q?MKdBKCJWyxW/Z96qtvfhT5WEsxpUY5ye6EqoChCpJFxGLT+bg7oZ9DcvIiix?=
 =?us-ascii?Q?Y2mc3A61zDhfdnU5YZZ/AL4xZ4M6QKFOqMJ//irXjDDsBTMT8p1MYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUNjINcbYRnWe7hYnhbXjGXixnv9U3WJ9TeqjpnmiHGLgostNvmtfgIIUt9h?=
 =?us-ascii?Q?KYv3hvKe1NLzqMTdkjm4wWL743nzF4/Q9/+wT6L7MiJJVAliNioVaM3PhZd9?=
 =?us-ascii?Q?leIvBrkGWWArbutFZLhlCIXu+1mAO4tdqVoEl0co0ntyk/SL0rgYodlNbMIJ?=
 =?us-ascii?Q?H/Al4z67MfqABRQfwWWg0LNu5WEJ8aTG1Qn4Em1GvN0CZdtMVeN8BdOd0RSb?=
 =?us-ascii?Q?5Ajd1v4wW8sCBubrXBOTudCPn/JVM4kJrRhNyapfFCd+xLtvRowKtnZ1D435?=
 =?us-ascii?Q?7hJrm7Ci6z21DKxPx5FEtrRUh4gUtn+n//yQAW0waIZ0QXXKo6d6nAlSyA25?=
 =?us-ascii?Q?YNk1whygFA02Mg8ETL+C8Wd3BY+Ax0O5ZNcC4mBqJ7ChMjCtJNprBpE1N7Jw?=
 =?us-ascii?Q?nfeEuNWzQBBDwzBwE2DEmPy9l5GvPMvavcA6BNiENO8B3bkTkSTiKUwGyaAi?=
 =?us-ascii?Q?BxnN6J6vatAI6DYQWwHVndGkx2RsuG9Tifu0QJGKt9KzQQmDd6iogAyI6ASW?=
 =?us-ascii?Q?feVNLsQjy2qBW+y3/iTIGs8MEhVH0HgQ2gNwV8Z6jKqMMDjZJbiskJ6zBWBJ?=
 =?us-ascii?Q?OgB6hH+hQqxUi8HDJV5yn7g18S/qnX+DsYorud5UHSkzqMxiLADz8qgIxOVc?=
 =?us-ascii?Q?TW7nnKECUVc+pB2Zef1HenmyDdtVRBszuZkMmenz8Wzv2OEWa7i96R4hlQr1?=
 =?us-ascii?Q?pWBeogrynZFjAdQ7q00Gk2QdF3uFHV1G9D4dTOeSzOkOyW8vVVLVCQMuyvku?=
 =?us-ascii?Q?GzEnRjWXg7wLNAj0r0XwYwT4zCJbndIYp/zx+fgOWvzpqBoR86PQVBYKy4kD?=
 =?us-ascii?Q?t1hL0EAYxIXKIcO7B4yCCGr9XjCcawEMDQrGeMJgrg/fcDXwAeA/zmZq5m2v?=
 =?us-ascii?Q?8L2GI8XJFf+bcvfVYkXpwoMZUsgQxFeJr3N8sM4csUZlWPj3VdiuDcBbaJqO?=
 =?us-ascii?Q?+Da1ULG2g6KuIoT6t2hz3dVy34IJ+1H2o8Wt8PWSxnXD/dMROBRTbFk/9hxU?=
 =?us-ascii?Q?Rf79wRlgYAdTIr8mjyno/edmdnY2cMmOBfwDnSkYmpv7rsh9VH3Gsf4GBgvi?=
 =?us-ascii?Q?fasDX+YiDILPdr51WMrZIKYU/HFpeo/gdCd1aGLUSmNf6XpePYvEA9+HdROI?=
 =?us-ascii?Q?BBoiZE8PpXK0i1DW1XnqJup3Dwatca9G86MCLYaMeyoj7tesgFJ6vLfNmBx1?=
 =?us-ascii?Q?qQEni+soZcb4rZrGBfOBUNIqz+sWLCmweZaI20CyCbJeAYYtWgNgy58kohol?=
 =?us-ascii?Q?cEN30VVTFTYH/mPhnFCftD4RUKdZCuzza49spCtUG5I3gFUB1G5xQD8SHowK?=
 =?us-ascii?Q?09bdqnsGNBquOeA4PelPVntt6GMpmolL2R8in28pjB7dvlrsZfZhF7I7xsyr?=
 =?us-ascii?Q?fuEPqw8cenlK2yHsmupUmyt2EYIw9Z78bEjhFx16fftqVsBjy6ZLchXeMso5?=
 =?us-ascii?Q?zMBiQo2ZYs1L+eZQFPbTIbgj3upWCLKG3U9ITjzfrHN3RJhBXhXlS/OiAkAg?=
 =?us-ascii?Q?VzCgQLnrzONca3oQzkBlM8FEkgu/I7Z/nV6ikr4YW4ALi5n1Gb+/qvZwbOCe?=
 =?us-ascii?Q?H6qYj+d5TnydwNum6eB1so+jTvxvEIkB27FPbc/4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36a12d0-931c-4481-2749-08dde3b71023
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:09:14.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpvBzG73/fxD9kZrJR3SttgOKnMnn3x7bsDTS5s4z7Ib9qDBWAcSa8R18W6MANjB/cn5VGKZqzbnDpOlVjJJUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7223

The tx_coalesce_usecs_irq are more suitable for using the
us_to_ktime(). This can make the code more concise and
enhance readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c966..32a57fbcce69 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2214,10 +2214,10 @@ static int m_can_set_coalesce(struct net_device *dev,
 
 	if (cdev->rx_coalesce_usecs_irq)
 		cdev->irq_timer_wait =
-			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
+			us_to_ktime(cdev->rx_coalesce_usecs_irq);
 	else
 		cdev->irq_timer_wait =
-			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
+			us_to_ktime(cdev->tx_coalesce_usecs_irq);
 
 	return 0;
 }
-- 
2.34.1


