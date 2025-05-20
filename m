Return-Path: <linux-can+bounces-3596-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F9EABD71F
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 13:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FC58C025C
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187A27C179;
	Tue, 20 May 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Ybe3rRiA"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2102.outbound.protection.outlook.com [40.107.249.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750027B4E4
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741428; cv=fail; b=io7yOmmnVJZZyZ/R4xv0haDjFv8Xuj2ENTYq+1mVLybjGrwhpi7PI8UHHR3UQPOv7QLpzlcnutQvUCJs+XVXDjDUBVynoZ2z8NlW1cpucr8bByJavsVFN6XAPrFfw4s0Z92HvfI8qAL94GfHCdH/vvVFhgSi3owJs/ikWhONFnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741428; c=relaxed/simple;
	bh=oWaUSynprCw5mZvgkDJJSKV7m5nIqcJVbq5pDFSAGZc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=su2xq8qo99jNq6JWVxiJYTxy+8xmIKhq9UGaZllbpN6Efcb9B/T0oRdQtYIC67E/qQY7wjNOf1/DypWCfMiPnadw+VsYdrfzekT7BcM4UX6I6kX+7OMEH9K9otDcKJ1xmFrT6rel/Lz0uAJ8+hHNg/bF9oVqs0SJnxhFa0reGEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Ybe3rRiA; arc=fail smtp.client-ip=40.107.249.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAq0jqzDahpRFO7xmSQ50JHhk38E6xO8FtMyXiFttR/6XYU9MaiEG6wo325uJ/wndQ/K+L1Z5aLwJbMK6iHM+2mrE/8C2RxrmJaas3O2NgJEWiqt3xdKwd+qgtTvyc/zQ6xjrrfBazB3O8BGycfkxouk8mVwE1wOtn2cXwXoGaBdq6p5SxfsgpMD+vsIDmThlxD7KNmZ6nDqYqbgNvGIJtve3vzZJyY28yVwx8Pjalc3Le4AM8ZJRkzBvXyopmyjUJfyT3RvHzcvwzzXojfno2x7UJjHvc55Aye6Q1igrRWPSAciKiw3irynCxcmamIb2K0BToyEhAtqBNiRfU4PGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wZwNb3Y93EscaXJmcPYBrD3rtj+eZu1khyA/vICaiE=;
 b=sf0NxTAubUnARttVewpQrOT/UTe97GWAjA41sOHlJCBljUGSzQ5KwWxuLW1hKNyGwuNVp7YSGqzqG1p1s53NL21M270UbgVeeTY1ivNdvt/JLIqT0KL5dg6WkB6E1fdZjy62RNpTb8s/D8dER3UzDQDsqxnn9kHeIymBP7gZiZz+md3hr8bmz6uwjASlXt9aazyc+hvbJY60G4JpMTiABJDHBOHtj0+FAbocHiXRAgbU3tWhwjmZuy4lRXgaUXeRbmcuQTAElVMb0a4gaJ1i+aZ9162ZA9znNUE5QPWnR/wd5XrP4yZRKD6KxI1zd/lHEPeZzVw9gftVqi4C+JN+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wZwNb3Y93EscaXJmcPYBrD3rtj+eZu1khyA/vICaiE=;
 b=Ybe3rRiAUUefthoVvpB3bzfcnLi+UEtYC6mFKAXgVQlrCypXKSO7N98yJmH6gEJweDv6yUW0XjyKstrlBBCKU3gnmiqAu5QDtSWHNAObneKxyw0/DgmQu0fPdCx5YERkdPaZEqtgJSSx+4/pm+lX1hNXvZE0602StmAcMauOUlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by DU2P193MB2226.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 20 May
 2025 11:43:42 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:43:42 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>
Subject: [PATCH v3 0/3] can: kvaser_pciefd: Fix ISR race conditions
Date: Tue, 20 May 2025 13:43:29 +0200
Message-ID: <20250520114332.8961-1-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0108.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::9)
 To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|DU2P193MB2226:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b824ad-87ec-4b01-943b-08dd979391c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fXVpH2v7EsCOPksfjiORIaurRTm1ir/6J6axYQdjT/Tlx4YolADTHUK2C1ed?=
 =?us-ascii?Q?RQ2JKteiGfBBkGaCsOs2jPECzyGaRtq2Xh1PuAJ4pIhghY9mmupXr2kGE98B?=
 =?us-ascii?Q?DR6trlM2SCoIZDQEJ3L0Q5tcxJYkrH/Y9KrOpafiL7f7VoBeyM1t9qF2Af8U?=
 =?us-ascii?Q?7mYqNTwndTvoQYXSZ04dUV+hln7cypEKgRTtETM4mcE6dQN+fxMnRqNuHDvT?=
 =?us-ascii?Q?iWGBLdZsJl4kXepKUKDlOWX2gIwiBdUgpH+yugXwv0sxrjsXG9Kj5GVhxjL4?=
 =?us-ascii?Q?jngggDph1Nt0w8cN2aCEzkamcY24dV25hx+bp5amMHWi7EyUXTcHU/pEuy59?=
 =?us-ascii?Q?tc1ZGwxsWMtF22FZiRL+KnD7edpVrAZfrOoQxLtxAF0vtDTjayFsPH+OCWUM?=
 =?us-ascii?Q?Wq9uczCC194VoSi4eizQ58Cu4VUcWKDrSLWZSnX0mmexK+UHxz4xHurQX6wi?=
 =?us-ascii?Q?1nCV+9vJjD6sRuwP2lkYWnMmo7qPeJCHxmN03x3hjHiJ/IaYjiC/+iBl2Thm?=
 =?us-ascii?Q?jW7V7ojzzG+NdnnEOhHt6bQkXnwGUbk/8L2ExmuEWkk4RIFjReAZL1hn4U/j?=
 =?us-ascii?Q?e8/yrl46k0EV6BMTaxJbRLG3kmAIFhNp7PSCJalbnN1sq0JGn8cE74zDVSpo?=
 =?us-ascii?Q?wFU8PbCF2PaqcvNiP64kvpk9cDgXWJX77ejMQTcLGz90aYGrds5hla5VDUAl?=
 =?us-ascii?Q?tdtA2vk3Yf62osH+GCoopnQP8cS82VZECzxLymKhKVA3wSzrh9+VNcystR7s?=
 =?us-ascii?Q?ysn0g8W6AwCSb2gLdRwc4I7mEADq104iv8GuppRPxqyry3qRDjx2PKhHi5AD?=
 =?us-ascii?Q?jf5H3Em9kS5d+KiF8+RDlYmnTgz91FsqDtvmYL/ALzNYiNzT4IX0EVWbq8fp?=
 =?us-ascii?Q?QFhvh6D7uFER4XhOh31GmTGJ6wQPI4tSIk2dIjHY9bIIYF4Zfkn8U++SKsjO?=
 =?us-ascii?Q?Sh/tbfy5Bv1LbTIUYU6EEs46tuxxaS8t+LB353ENsPw4Yu28eNBEVZZvW0Ra?=
 =?us-ascii?Q?ZnKVLXGvA9m9Qlk0YGf0L3s8I9RPlDAp/21KbKE7+SYUJalha2iZEqvsw6Jh?=
 =?us-ascii?Q?femeFuX53IWW+0RSPP536/GBpEf3SRdu6WwiH2YQUl60ysJiB9lHo9O43DrA?=
 =?us-ascii?Q?0wQQ3/h85iBMOC+04PMDZgS9qdtNWyG4hukbYPOOYXHe5B+ELRmvjVL04vh6?=
 =?us-ascii?Q?i7BLQJucCAlg6UQsfZhp3344eYDL+PTbS50arcjW9WuBIiMk061eUQMIMLeS?=
 =?us-ascii?Q?QPVUMhGtEFA4ERXUxk3UyL8I6EUXG0HU528AkTq2T22efkNWVLpTTetY99VC?=
 =?us-ascii?Q?YGlhfJgS0qcPzNW+rzlk/RzlUbGIKe+CPVRMsF47JDxhHMnYDeaKno2R85LG?=
 =?us-ascii?Q?1aNrolsBRfNDAyQ42yE6X8+aKOGpBLbowNA2gEN5vWDJI/yBwI+O9ET5/R+Q?=
 =?us-ascii?Q?wlho2r+T+xk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?021FN44/pM/MTX1hifYXwALhXM14uehucMPrTEdHY21bzKPnoan/5UzzPoC6?=
 =?us-ascii?Q?lSJdO1xLAzCLjO9p4nyFq1gbaTYFQsCUdia3SEoen8AX2b2iBTyXIFX4k2Sw?=
 =?us-ascii?Q?5BuCyhO7BD3+rtMAun5qgnrxiZ0FAhAx++SVh28nBGZEamtRRSxHQsPNbypl?=
 =?us-ascii?Q?n41erVrr4AuWt2Jhh5ZxF+cpsyinhzaDpu7QxgibkaCo7omyHmGrl+3U6rlJ?=
 =?us-ascii?Q?y5RIVY+VaB/muKWutuuGk4OLK0FpnbMdrBNaWU7u1NyIaJtbP7PDXRcdxXDu?=
 =?us-ascii?Q?q5QdAbK2+PXgqF3T/uepnWTK2hQVev5E9z82pg4WR0Pfr23Oo1ETvvY/jEXw?=
 =?us-ascii?Q?71nYL6TO2Sx9ZRXf/Un8LX3rLyWNx+luISk2wBKVnJArrDWToU0qkff6ojem?=
 =?us-ascii?Q?lm+jA2ZL/e6wESqi0yC0Dnn1TmQtFaEkC7DwYCMJTgdFwfln8AxxzxrO8zNJ?=
 =?us-ascii?Q?9kjs3zpbYNtQ449kXxn0ZFoX+cBeaYjmH8volOa3pX+p8P5/QDINl1yd8K8t?=
 =?us-ascii?Q?pK9Sika+dPV+zkVQiU/u5Ffl6Q+ABlrV0Lm30TwBFtQwV6pJ14gOwP5AhRIX?=
 =?us-ascii?Q?9DJvZ/XiFC6o5HCfJN3QHOohGzjNIaligR8boUGrp75yaV6Kl5K5rjx5/jVn?=
 =?us-ascii?Q?ZVMOlVv/itDnNR9UwbCSdVzzY10DjlD38d2vc4EqbEtw8FvlHCygf4qGKNqL?=
 =?us-ascii?Q?ioKxo3oTrP8xJvwUrZEeuQrdktTr2dGHy+HpO4rf7jS/UO+ENy/1Wxa2+Z9S?=
 =?us-ascii?Q?bFns4FKsxyD+CtsDoCQmog5mDOQ0U5VoP3SQUVgjXb7/t3lX7O9vd8LTIXB3?=
 =?us-ascii?Q?e2q44P0IAgjI1x0mitMC4R6QQ6f8gV6vO5Ism8T8t6U15ubOHlPN9ONRPCpn?=
 =?us-ascii?Q?ZTH2kYbHbjSdyUxEHwFENjR9seCJJM3APLHiuqTnrqnfZGz76eoljLyRUSWc?=
 =?us-ascii?Q?LmQTUqnx9Ol9aYMaBlM6mo167T/sCvQr6iiZ2piPctDHSos58+KWt++qaNk6?=
 =?us-ascii?Q?k10jyxdbBIIATSZliaPbhCr6fK28NrHEx4Qn1TBDZXPY2Kcs7aW09CskR/lz?=
 =?us-ascii?Q?LHGVDy8rnH5OKiu1KNPXXBPAZ/+nOhFwtAiJEUZfz16N6eKYLmpsJvWrk4OS?=
 =?us-ascii?Q?r7YDSTqwnkF2wjO5g5AsYc7EUnlo8VsCzkTNqIdRyv+Ud2cJdn7+W+eVhuBG?=
 =?us-ascii?Q?n79Y7v+zmyhtRB6x6upco1eVpe25Tn7rpOG6PHnv7LLUc4JuWjhZrKKfXGtx?=
 =?us-ascii?Q?RGUqRTg5leFpkFgdUaS658bjPHGb70HyiBiSuVe7h/AIXkSKvuG/37+ij9bb?=
 =?us-ascii?Q?MDkT8aGnVvGmE7MM3lk/3vKJwfYUylslbvUvg6a813CMj+9JfbjZBMuAWURb?=
 =?us-ascii?Q?iYF+49GShaWGPc9TPsS29+d0a3lI5NqS5GUxBWoCMUqb1WTGgP5nXmOjxKo8?=
 =?us-ascii?Q?uEPrhFl91DH4WvhxoaSAIwq5s2EM9bZjHOqvb8r9tpwYYID60UseAtG4G8Eg?=
 =?us-ascii?Q?ksC09oNeMGFQ62D6OocudissjVaOIE64rwGpldFibAgfU/7f+h4xAturRAN+?=
 =?us-ascii?Q?xnTjV4Dc80LvQ9J7TsrddJBHb7RUDPvkPHbv0rP0?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b824ad-87ec-4b01-943b-08dd979391c6
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:43:41.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylcITZgZ7lJa0qiY0nVFvLAJEXX0qhv2PzcrK5xCyZnmsTvDt9BDPhuD8MlQrKhJGBlGcguzFRMCNcsSWGyabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2226

This patch series fixes a couple of race conditions in the
kvaser_pciefd driver surfaced by enabling MSI interrupts and the new
Kvaser PCIe 8xCAN.

Changes since version 2:
* Rebase onto linux-can/main to resolve del_timer()/timer_delete()
  merge conflict.
* Reword 2nd commit message slightly.

Changes since version 1:
* Change type of srb_cmd_reg from "__le32 __iomem *" to
  "void __iomem *".
* Maintain TX FIFO count in driver instead of querying HW.
* Stop queue at end of .start_xmit() if full.

Axel Forsman (3):
  can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
  can: kvaser_pciefd: Fix echo_skb race
  can: kvaser_pciefd: Continue parsing DMA buf after dropped RX

 drivers/net/can/kvaser_pciefd.c | 184 ++++++++++++++++++--------------
 1 file changed, 103 insertions(+), 81 deletions(-)

-- 
2.47.2


