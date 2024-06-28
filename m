Return-Path: <linux-can+bounces-872-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF6F91C6EE
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09D51C2248C
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A527710C;
	Fri, 28 Jun 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="HWnXm6Hg"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03470770FD
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604555; cv=fail; b=lmj8gJauIEX8Ig9uDaLtrvG763pMLA842O2foXZ0aZhhe9Xj4ZR5t7ZDMimVfBC894Lo3vxR3fjwaD2dB3kud1dN057jo8XpOajeA6fBktkbbANgMrK8PJRrikDn2+++SYfwA/iUiJcg2nPkmSQ+BpIOWJwWffUk5B9+IvPe+R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604555; c=relaxed/simple;
	bh=kHs8gXZq6TXeetSdLnEgxEc5eVJgfCnO3sspK9PrDps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+xsbOGp7FkK10EAzkmEmTbqmvMF5ZQmzYgP1iUNW0Joli46JsRo0mJzRaLsgWlzTWqGAWOAn6emT35n5WmAE2mbucFz3HQLqJh83z1Ek301DOquXE7CCJmbBfcbll764OkR3jfxCyrPzLmmEK55wuvthWU9VzwrXS1+yHvHA24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=HWnXm6Hg; arc=fail smtp.client-ip=40.107.104.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYrPxTQMRfur5C+V/y01/56Wqo8IiEmzzPY9frEtS/R94WWuz7X0RcfmZDNgNdXjVZZuD12KsUq8N+gRdCTc/Tu3Jyx9SgoeqjEYUO9jmXuJgVnMvzIv8GrEJ7S6/GqKy1nhqqPG8lJ14XF2QClLZKPtFO8hxVFCiPNmKrVqQYEucLUmhxGZcfmq5bpOVS1HpgVXPvk6rdBfmsz01bGQWp+6PpxSJSJktwg1HdZRrv9/qI2dv9/ikBAqKiTL7n2g3la8Gs/IrCkpT5HZy2p5yxE3UjiDzbrjUV0I/VvZ1e4iy5kWe9ySMklyTb1sO2w5Vs2OKBXaMrBi5znW0TnMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAWT2Ag/PKwYzfBvsZLUcImxy3y6kSmQ3tryAOxXADE=;
 b=GiYR6kyx1Q2C4HTofF6Sqs/7Kh3y6I19GJXFR8b3rXBdiBjGpQ0AClrnmUn8LRHOUmYrfxecoHGBrGoCEi7/sY7ZjojbftGkR7MacD0lMuGp5Tq9E3k9JBXI3sbQEvoGiXu/ZamEy1HKAk526HnldZfZRs887ayU1dtuNtk690NlfVkmqRmdbMsMNgZNrE7HeaBdyPsua5EBYNkQf3xpxaOfItxuVyHLOvf2iFCp0/8ztqpludOrb4ZH8mGGzuCNLG+KB2Th5NqJ+XoZSiPR2iRSFk0+Sd5Y5ltDK/ZrJIhdunKj5PN1Ij3WGEGC+9tAPuf+bNOm9Hft6FoELZFt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAWT2Ag/PKwYzfBvsZLUcImxy3y6kSmQ3tryAOxXADE=;
 b=HWnXm6HgqBq9KvUGhgz/p8sjDkUe8D/sDel43Wyhu3qM/sYHOB+7y/ExC3iRi3EaJUdt33ARuXRPOrfZcdUecBrrlcYsZLbacvjG6brZOfNfVHfPYsl79WIBFKk5fJR4w7ob/ZGuHTcObHf2t/ubyWfuHjAN34e6otWlt60L/ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:44 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:44 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 05/15] can: kvaser_usb: leaf: Add struct for Tx ACK commands
Date: Fri, 28 Jun 2024 21:55:04 +0200
Message-ID: <20240628195514.316895-6-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d5af5a-c839-40f6-3ced-08dc97ac4bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMBRvX3EGyzmwUhuxVST/awMU/uwYggN8znp3jPg/CiikIIuf+vMOl4TtJw3?=
 =?us-ascii?Q?b+JsiLX9s3F5No1WPzNy8jr3plISsOBL91efqih8/Pb0Nj6QKkfe7oIUZHDb?=
 =?us-ascii?Q?J7bC1oO5KjJQi2NkPs9WHFowyGMZqd/QUkFiAYxk7FBC6d/rvgflEEWSDxuU?=
 =?us-ascii?Q?xltwrJhd2UupDhIqzljqoEG3MUWBnJECdCm7KKNcpBong/s2YhbeczOf0+ib?=
 =?us-ascii?Q?nTWKKidaplEHq9VK2rAMNk3knnN7aAyvpp2IT8P8Nfp1XfPOiuRJe+QTKE6/?=
 =?us-ascii?Q?E2FRC/GsfrFCR79uZ8gXvQuEZoL9WWHiFAVYk3OmQ4/T8FM8WeFII7KogiF6?=
 =?us-ascii?Q?Fqjc7yOCwMt1X9fnq5DkNaXqiho3ql0p/nxSw9+IVeT+7XpIY45oINr9tc5V?=
 =?us-ascii?Q?tD9G09KVXUSbWnLbSz3sU/qjKV1ZeljmxFQzbjzzWBZcgydU7cKz/sszwgOC?=
 =?us-ascii?Q?Bxgsh+vuToPGpwahDgXG+Nuld1SLACBCD8Rn34Mlpt6mpyf7lOh61ppqIa9l?=
 =?us-ascii?Q?FwZOyEUNM5afOGhd9Atbuw3iROLoiNWIcmYiOmxa4G1JpP+xpKhmTZGP50I4?=
 =?us-ascii?Q?1f1uzCeu2+EowhG1054hzvuybGEMi/BsJERAuk/bKYkAYUUD9YBb9hPCkGNQ?=
 =?us-ascii?Q?eaz3SiMTl7/YN0BYyxOtcyLneXzWaLYej7BzhmiOaoAjROKvAOKoFBoNtVcb?=
 =?us-ascii?Q?fWmFogXBNjxx8jKVpHdrYxDvmvDf+R/X0b3x0jW8FfCD2vcj4DNviAIPED2l?=
 =?us-ascii?Q?kvgHsDfLTvUtHjISiOEVJXdTwaz6+vBD21ymndHUoysD/PEQfx4eEYrT5XaZ?=
 =?us-ascii?Q?FeNfP3vG4Gse+HR2/d96ukhB8Xbk3Wo6aB35i39Zb80gFzYN5kpfbjsqNBbl?=
 =?us-ascii?Q?jwZI8K6F2LEJonZCnsoGwsZ5T0OppCCY5XdEOeUrCsi3gJloMzF3KKTi1aeN?=
 =?us-ascii?Q?Aqo1E4yxYKtzZP6++wXW9wOeadoV11WiKVy5YjHK0cTnFrqe+VnokZUCemUi?=
 =?us-ascii?Q?UKhXI90dwwC0Z0n8c3TL4JJoHxv+kPE6OgnD1TbxQ1wzsfG4APc4zQigG5TX?=
 =?us-ascii?Q?4PQvXnIupRzDZ1Nx/QRzwq8hCT6lfYJSpb5raau64/aBfynWbdT+M9G0tHCQ?=
 =?us-ascii?Q?u7pTxblLynRYaIeVtjccedFHZKykdvhnLsUztTJmlZgEcl95jqvkdKkHCmKn?=
 =?us-ascii?Q?FDYcPpVbAORnP+iYK2Q3nG0giGW0URvDFpOcCZhhO1EegdcVP+PN/wguVU/g?=
 =?us-ascii?Q?bBS98BEt514UivJbsg/kIwlyoCf9isCeP7gNj5ROZW6YRNq+59+6I8/HoK8N?=
 =?us-ascii?Q?lUgyB8RgqxVrb/Ym9eWXPUUNgl5CXpyMGu0M/wvh3nlbbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdGxuU6zrnJdfsruwjzLlDPJb/WuAYLywVd8QaLrdGx7fsuZdhGXJdgquFRP?=
 =?us-ascii?Q?BkY2aHEJYBy3ZFI3NUe79+2yYIFvTF+2e19UR13F3pjK8AE5scgVpYVXL5Be?=
 =?us-ascii?Q?z+O706TjVyGQGhOgE7zIWCvKAyKm7c6efnGVyRDIMSNRcc4C7dRjuFTLSNAx?=
 =?us-ascii?Q?Izv7GfkYLXWCxGuxNv/jokG8Jce7CXCjZXlsni7gxfrBnPv7fkPtaiGbNmZK?=
 =?us-ascii?Q?+Cood+hMKdjHh2tkbXmHfc12DOKIPLetYCbH5oyZD5/9a7w2bh49kSXTGGwP?=
 =?us-ascii?Q?kN9SFN+eRf7/lX42+wO0Idt0FR4XrBIJ3uSSx5EeeBmz46rkOrfhh3Wv97x4?=
 =?us-ascii?Q?nEpf2o+BM0uPmeKWXXwLGOzK6Uyy0uxgvPeJgKbNW2Fic0bZnaIq9HFYc+pg?=
 =?us-ascii?Q?1KP9y0MzmUlX+qNv6CK/1ShT6c+6n6Z5FBvcziS5zlCBr/bYB+e8fbPfBxdm?=
 =?us-ascii?Q?C5+JCFA2PpBWsKHOvwXTCMoIWVe9MfeS8XgPBFOGLk1RQQqguSi+wVslOCw/?=
 =?us-ascii?Q?ONlRD7Vh5dzm9Z4Mat3Ut+4yOsMcy/tAJABT15TntGlnqIgayMYd3kF9mhLF?=
 =?us-ascii?Q?0dlzqjn8TfYqUL08LU1U0HRO0cF1Oh5L0wdKjqeULyCwszL9U06S80kv+d9q?=
 =?us-ascii?Q?n0c82NF6D9KaEoOatdMR64g/NboIWo2PNbCsSLctKSOmcuQ65yBCxfrmzN2z?=
 =?us-ascii?Q?URRDCIYw+DFFXHb8NrAuDZx6VOtwqS6BUGmvr4pbSHtj6e2qaH3o7rUao/u6?=
 =?us-ascii?Q?f65QlGm7NIOcYh1l7Yt1lRor5pJGFDpWkcbyYx8/aL0YC9311TgiFjXDy4bq?=
 =?us-ascii?Q?7+GzkM21r+yO7vmi7TdmEHPzM+F2m934dpt9Rm3isE1QvmnWkzE5ds4cEGIs?=
 =?us-ascii?Q?HQFBKi3l9pJshkexx/Ohdo4OINwiPCYRXmGWBK8QuZk6/apbdS7bTNVbcoE1?=
 =?us-ascii?Q?HT6LLYrMQaCF9p9Z080nT287KpPfMYfqcglQbonmxoPK+/m9PvREOzZMp20u?=
 =?us-ascii?Q?eJvjMqMjxnVa6+wVbl3PdwAJO0XHuuNRUhgPYGQQ9+F5mvffDchqj84J9poZ?=
 =?us-ascii?Q?0edgZEercW82/kLwv5XR21PIyDWffCbdyA2DkZEODC99BX56dS/5WDkVgNLQ?=
 =?us-ascii?Q?lURftITV0mJpQXx4OriYkG3qNYHfirgDIpSPj1AqnOuXOW7Gr1ugSiOMTJhZ?=
 =?us-ascii?Q?qcd1ZM7EB7s6EIoDC8/D0L+ZvlmoSXaRHa2X3+d5cvn71fTzyTjeChHDzPXB?=
 =?us-ascii?Q?gW0Iabb8wowS1IfKhZAd5evL2cJy9+D6z1KuH5+G5xuI1YsslCsOB+LE7IP+?=
 =?us-ascii?Q?WBIDtK7QM+2GyI8hnrruvCWN4TcZmE/G1OLHaEYtFoBJC6F2Qj7wm9U6uCD3?=
 =?us-ascii?Q?Q/PsvbiYWDb3N5C7YWaxl+fkanggXclXbfk/KDUhmIb7izELuhsSZzRm4CWI?=
 =?us-ascii?Q?9Tbb43BPQc1DskaFzTLaFZRZ8EKkHLeJQnN5D9SH5jeU4DYvcMnFQNzrUHND?=
 =?us-ascii?Q?OoGctG8uGoezBu48qbJKcdrwaCPpUIRUiwqQEjvGq/9Rd0je6VKj7qcNoJ6k?=
 =?us-ascii?Q?/2iaB4PfjFd6+OANmFpqyGtjtp8BG8YLpQZnC56D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d5af5a-c839-40f6-3ced-08dc97ac4bc2
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:44.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABrNCW6IS59ECIzUAgzpvQtOkQjHPv3d7PsC5weGAWtb5vPlbEKc0B+w4i/x33IAPE/LLy8KMpsKTinyrVglmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Add, struct leaf_cmd_tx_acknowledge, for Tx ACK commands received from leaf
devices (M32C and leafimx28).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 23bd7574b1c7..70511e151a3b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -235,6 +235,13 @@ struct kvaser_cmd_tx_acknowledge_header {
 	u8 tid;
 } __packed;
 
+struct leaf_cmd_tx_acknowledge {
+	u8 channel;
+	u8 tid;
+	__le16 time[3];
+	u8 padding[2];
+} __packed;
+
 struct leaf_cmd_can_error_event {
 	u8 tid;
 	u8 flags;
@@ -347,6 +354,7 @@ struct kvaser_cmd {
 			struct leaf_cmd_error_event error_event;
 			struct kvaser_cmd_cap_req cap_req;
 			struct kvaser_cmd_cap_res cap_res;
+			struct leaf_cmd_tx_acknowledge tx_ack;
 		} __packed leaf;
 
 		union {
@@ -370,7 +378,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
-	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
+	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.leaf.tx_ack),
 	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.leaf.softinfo),
 	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
-- 
2.45.2


