Return-Path: <linux-can+bounces-4075-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946DB100C0
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6703B712D
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9E226D03;
	Thu, 24 Jul 2025 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="B/khj0J9"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94670204F8C;
	Thu, 24 Jul 2025 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339049; cv=fail; b=BJOXSgSB9K6yPGsTDqZNIHNL7jQ3gxeS8vEXkKQaL14Jh4xsvvTRnAssSYo80WVMdV2wIr/VEYANqsyC04/SQKJvImPzIax+sY83SbgdUiS/UeJQZTFL9cxRdjjfW2uE92zGRBl5eolYVZ9IxQnzUH5LbQnO53M1wOVSEgQKMEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339049; c=relaxed/simple;
	bh=QS1XJI4KuQe3GV7B/ivovKsHrwDvmvnHpjxWQuu8dJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPGGOqJLDtStbGoODO5C5PxxWQEV/eEwMFpsZmib3Sq1XgNCaI9amL/eH3bnn1+ezFfnvNPsip8LMfoCHl/NS6iebEo1/Z3qiQIPjRC6ei5icGAkDl9aTbMATstGiP63gJpFck/YqrR5Wz4rWr0O6YYsTDZ4WXBzf64nhW8g7f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=B/khj0J9; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVIAwatHsdjS7YTDR+ohoTwR78YjdtSwViSIi29uQyw9sUzDo/rjcw/Ac0Xrd+GunDr1PILjDP02GAcLeq4lsxMvIz4LfLM91rmGeFSqH/2/ieol34dAbBGgFTGbfz99+5k++wt4Ow80E8yKS870o1YwjSmWW+/RXdYmRMI50xGRNIyGcUMiYTLB1jCkWpN12MPpwZQSA4uwxUwcYU+INQHeLoboQaQtDE9BRhtO/gMxwnJHQ9XbmzNsYO69o5Fio3xJxYzkMFkXls+3Is9vsbgIwQM1ImpGPzhqAC1enMOAjT7e7ztJrP6WTnmRW5ulaorQhDjrsw9kwgpsBHnI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ0/05NvSNfOrPhaF307RVF5gDPje2JCma+0fMRViI0=;
 b=DU8p4TAVOEfhQHw62Iv+WPNqv21aeOJrZ3DXNL/BdLgnjDy/XmvexOjqgKweseRM1mZb5Z4cYtWyjfv7rHSXNp296QIaLs1jeOvTE8BYJIA2tPSyQDtmyrWmWl+ryyePyUlwe1bFnhDsEr2E6vdAL03F+3uJxMleJZgUGTO5fPELk9Gaj/08IbM46WhIXXM4+Uy8BSyXyRA1Myx4IPmdNIcemVsnkVHuzZ8F7UWHyvfVT39eGnmqNX1heunSFfKhceNnQBQmCWfgwJJgfsXUnwj+bNJLwyhAwSxn7C8P/4LPBoQ4tb8+9yN6ZLuNGcOJ3KjEswJwZngsAT15Qdb3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ0/05NvSNfOrPhaF307RVF5gDPje2JCma+0fMRViI0=;
 b=B/khj0J9A6iP3ACPkcDjCE/MTktma/CaR9/V7uslX3S2VQGiq+kFghVF6sTSUzXxuQU9WplLYWrK0u25ouRIulno3cLWJv4YvTDi9MoswHCSzjfu2/8R97/1WDoIKpAhTDyujgYQCsSv24/bNlz48z7VyJ/PF1opGqhwght9/Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:18 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:18 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 05/10] can: kvaser_pciefd: Store device channel index
Date: Thu, 24 Jul 2025 08:36:46 +0200
Message-ID: <20250724063651.8-6-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724063651.8-1-extja@kvaser.com>
References: <20250724063651.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM0P193MB0562:EE_
X-MS-Office365-Filtering-Correlation-Id: d285b88b-1a18-4da5-de52-08ddca7c8924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUIXXlnaOZP0pE8M+8NHmBVvZrVosOruZ+n/oeS0bvfcllrHygmaan+G6fVL?=
 =?us-ascii?Q?6Ov3HaGRHo4aKyl+u5+Ciu7MmBXlmgg94iA5SnkJ8O1Oeiaiuar6/iczmyFh?=
 =?us-ascii?Q?WCTSkzXpyDcd5GzrhpR0AsJWsauJcM296VAx3m3xqcerVXx3Q2bpJIWPi44A?=
 =?us-ascii?Q?H2vr9186gUJAC8OXkqCQPGmVUoBrWAEoNVBDJk6aG3McCqtDA6BiczXrOem6?=
 =?us-ascii?Q?clKlIQNC+9kp1o0sCamIyvh1GWh1AakgJyiPlsl3ola2a9o9iux4zQzSNnkd?=
 =?us-ascii?Q?dVEuNP9etvNR/NciE7ZuM2AB0JiPB+fF+oIXaehRTCuohb84ZH5J+m84oA8t?=
 =?us-ascii?Q?40sMKlWwPHYo+zwPIydvPLUT7TrtNMP5S3+wYg3xVMao4mXZyWAnYavhk5jM?=
 =?us-ascii?Q?Q033ts6SHAny8PzhA8kN68SRDhp3J/enwtsqQR4yIXbP3h/d1Av2DFSlMcOM?=
 =?us-ascii?Q?y63uj3ClmokExBJ3T7aC038hg5MBOoKO102Tg+fM3HAbHc2qEekwteN77si7?=
 =?us-ascii?Q?NgYzNFr7gXe5R03Pji22eMTTofWf7MnxFx8oqAG7gd5Iu7vL93AtqvqAhW50?=
 =?us-ascii?Q?pxXa3kjFAMgndDCUOlcq+b2Bisa7ZN5fD2VpiI8VSr9aVGB7776Ih0XNkDaC?=
 =?us-ascii?Q?9JUwkQwaDVf+UE5+nkDxOjy1UzmsH/Pw3Rg0HUHZvizhq3hcxhDTKBNdUsYG?=
 =?us-ascii?Q?JVlsietw+gPA4htB+mNg63O6zJCe+OXV6QELLsKJ+EB0Gf3NUkRtK9kDyyPS?=
 =?us-ascii?Q?JttTbYkI9JiDR9l1ZCl2cZlD9a5b1cfFfSUiGi5kXG0c1BH7gNXc1YinFptf?=
 =?us-ascii?Q?y0kqzQ9nUvYYM8DEmO0g6d12d91IArjkjDgKcoPUa8ieH5Jy9KycAKKp12vl?=
 =?us-ascii?Q?jU034HUGgE6PpgVgVfQ+8X0zU4b608ANaW17jvKc0hMei2b7Q+zmwqQ4Na1F?=
 =?us-ascii?Q?dTwysJEjPAMFQMkXrbXax9saWdSp8g6PMMT3nV3yfJc5Ho+i2Rh5lTxoNe2Z?=
 =?us-ascii?Q?Kq1YLnRrNm7WPZimg2y4XoF1oZe8eriM+lcYoBaSnlWjgHJ54/uDlws5iOx0?=
 =?us-ascii?Q?Q//+gWj/p44RifTTjGIfqFioOSnjghbWqQewVsdlwUVaFitftRk6eYi8vSSs?=
 =?us-ascii?Q?oT1fXeD/Sr1vOldhBIVikFD8a4FgPcwV8FTRGWi533sHCexvRnU56acBuo9p?=
 =?us-ascii?Q?bjYWSaMwbba78UjXvH+uBrtCbLU4g4vS8ra0JXcegd1ZDNDoYCg3qqOY5UbZ?=
 =?us-ascii?Q?Oue8s7L84Hvt5RmfWdYiqWwiqvAacUaV3h1d+7AVO/IjJoYvUnFTvm2P0u/w?=
 =?us-ascii?Q?ChSCHTgrSvZybNMsYzQxPdZdkfHeJRQK3KF7BQdWcCrv/+5R+021JhmzDcPW?=
 =?us-ascii?Q?DXSM9sF1G/z8iIdSXq0oABWrLHtD9iwtkvO9PlvAxVmmO7aFNz7I4J2iivpK?=
 =?us-ascii?Q?jlBghkFHnF4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBBnrK3+RBamM2rqCFivJ3zxrP26hW0olC1SlHv/Ca73vNygg12lmlHBCEfr?=
 =?us-ascii?Q?zawT3eEmctuuCGy625B71sr2T6Nkbqy0q0x1ROBlaW6P1RvT9F/mzLkoAkM5?=
 =?us-ascii?Q?xyv1kj5I2Y9dtIYstNC0UW54u6g2e+YFwGfsL2z/ft0+u46atXPqhOkPiquh?=
 =?us-ascii?Q?5Rw5hVFX4GD9mwyqf/R+4egYgmUkJdgy8zwAdy7QpQpkE2O08YOEmXNDQ1mF?=
 =?us-ascii?Q?hIxXtBfAhMypj+XPJmJzZ5AzTbzx9mHuhq7Fuhx8eXuWwvnXOVvF0heDIeJf?=
 =?us-ascii?Q?IYbbwos4enop0KkgD80gLLNpCyAxN2xI3bx8uGRNy2ItSA7rhGIB6/rVo84G?=
 =?us-ascii?Q?DuSmX7bQv3Gg/h02XshFgPBl+t6zqVN/V7rHpPj/GqmUkjn7/zYZ9z3VfF0F?=
 =?us-ascii?Q?U8rG/lgPspBL6IkAufrC+L/yhDGukZwYlHhsjDIsMOO5H+/821DDJBVU6C2L?=
 =?us-ascii?Q?51dj2WKIL7QHciLbhMUwjLX/VA9BuFV/F92bfd0mPf5VZHaZWBo/hjhJdULQ?=
 =?us-ascii?Q?/NERVmU3Fp72nBm8a1GThbZwyYPd0QmGwv5uZ5j5pqNTfV5G8qyLQFKX1OF4?=
 =?us-ascii?Q?EtVAX4poDU6bs3aVrlKYuj+Sc5/UAA+nZDsMvV3ddLG93kT3DQ6m2VDr3Y8m?=
 =?us-ascii?Q?P273Rm6+LkCA0kWqWN+3Kp6P1/VwVdi2l/Jk5nkdx9VyBAj7cvTe6dBg9InH?=
 =?us-ascii?Q?xKGKD4TxCoLdil6PZbP4MWXdhIHYMPr57vTn99sIGh/W0zL4+u/zOlQRqzh8?=
 =?us-ascii?Q?Mzmhqt+Xnz/IfZ1+9Nv0t80L3JcTry/krtSYsN4jMnqoaEjCvL9KewPqjd6m?=
 =?us-ascii?Q?jhQqBqigOiHZ56G3NaitP9xFHXcwkzgY74VbE+Slp0Wsga/nmaZ2xsRYsjlm?=
 =?us-ascii?Q?Nuzb840CgfxGgDMAHNrfJfuLVIfHwDYh7wO6x/ujtysQwi7qCNkzdPjiOTHa?=
 =?us-ascii?Q?gbo6KgmRsdcxbhceZFKgPeZkpU+uu/eIDuPl+00yi8NloHaWOd4T7YwQI8d5?=
 =?us-ascii?Q?Iw0V2lKvnp97/o0tgtQPX683xXlFwju+Gqt4vmRa8ssX3MySlIQGKrXSBF2Q?=
 =?us-ascii?Q?8xyiAjLQ5glVoLwIgMOoLCo4lfgFKsOigXwIV8hjx8NlXa9WsqK6ITsaIRxG?=
 =?us-ascii?Q?0LawHCZMoSsWKKeK0z2tgIdHWTFH5WeaYdpyTqMJ34Fezu9KjVaARXOKHNlb?=
 =?us-ascii?Q?q7rj9Q/OPYMacg7iZjdeVbS69TnLkAmHDt4hwlP1VzKggq2hYN9WnIW/A+jp?=
 =?us-ascii?Q?7H/qV8ywg5cM+BE6+cqoU6yfslbj8o/6uzZm1TDWESxppcqJUaDJdURGTyIk?=
 =?us-ascii?Q?dpinug1oYFjTT3e9WzQB9SasnreTvbSn0To5oHfO1bkJrae/11kpGoMMuLS5?=
 =?us-ascii?Q?twvJfDWtzHvhWLTeHHvSQ/gLB4DY1bOa4D9mROo72Zz6KX3+MfA+04l5E9Cv?=
 =?us-ascii?Q?Uv2HyGhOyhZl983OZXx14VVUEfSl1hNtBoyWdG23tp+sXWBqbh8h6vwFSBnb?=
 =?us-ascii?Q?+WOJFxDmkfS5PLfGZfHCGd52wRLjVR0eygJJmXnqarOAvDv3etG7JyzucYT2?=
 =?us-ascii?Q?ymhppJgb20597Jfj96ICzfQoidU5ojLCrahnz/O92Gav2pmX7p8yzEQM4Uh4?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d285b88b-1a18-4da5-de52-08ddca7c8924
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:18.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmDpfcj5xTdueJGQ3w7Cr7HSlgTAnvGFCNLaTTd0nCKwUlT8sWa5BiIKM/1a5ZCuRPtg1iPBWLV20gG8g7Ntq7TbjjgVeT2utORzxU6NQlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

Store device channel index in netdev.dev_port.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add Fixes tag.

 drivers/net/can/kvaser_pciefd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 7153b9ea0d3d..8dcb1d1c67e4 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1028,6 +1028,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
+		can->can.dev->dev_port = i;
 
 		init_completion(&can->start_comp);
 		init_completion(&can->flush_comp);
-- 
2.49.0


