Return-Path: <linux-can+bounces-881-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9C91C6F8
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B577B284AED
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35974C09;
	Fri, 28 Jun 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="BPkjUJts"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E978C8F
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604565; cv=fail; b=Youutca6zBB1SY03mAokJodg6fXBz9K2e/7FYPmTrDla5fPfu1qlgIQdZHKLcSFJU3b73/plPl8ZDJo4CR+Bwl52yzGfIQxkfqIehagNpvEoQmlUSuhOiA22Egy5TgLYAQZXtNFffcOEPjGXlx8BuAlKvnZlR0cuZg02sSsPoVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604565; c=relaxed/simple;
	bh=egoH4A+iRgkXwqGQPl14MOQktEbVDHrRkFPKtrfAmoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3OYWoFjhvys5OqKiCk3cxLSifQSbanXSFtzpcbc0IgiYj97+8Rbpy2kxsyxL2i+lW0jhS6JHFjPq+d0S2NbwIAc3eXZt9iXVKyaUqtkp9dKrM2/D4h7/dhoNJBiPfUeq9hnJy7RmCpX8GEFEek9QfyuTWxTkKnMxL/33BEvnT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=BPkjUJts; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZN7zKJqe+5bWUvHdyhYjlAC5q5KrIZU4kitTpnSUy0bE+ZZf88jadAt59HJTZRQ5VCTChRCspJulMX1jn5tqpO+HQPrjtHKml0Aj6omdD0bPDSQMhs5bwcg8HF3rExp0oektTWg4jg/TRd4kVL0Smur6BEenBuHfv5twyYrYCtl3gafgkqvQL69i6+tIxDjuSnsEMH5th2O3p8ognFs0+4Y/aTYmniX1nbNg5fa6R+maQ6GmcS1Ljx4HvESObCHaLQFrlshCDyTkfC7OAuHpGWlx5Q23RhToPoshmlyCZc3sjxJVEc2aHdpibpBY1GQVr15kaHRlfkoSZ8rSZdqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN8qBTvFUlQ7JvCIzvPdBo0odlw72zYK+3OSIQ7a56s=;
 b=eglaDHMoJjo8tdE6AYGkPftvbOZ/KMxDsjmKcEqr+zkKaMJZC+Hl4jL29tFd52b2/QrTGx/bPmUciuMalfRtE1k1S43b5odF2O704Ijr5eVQE0TEi5Co0XuzOZ6iuC3u/wOjGouHCEn9jSrP/FOjAN62+oYmiG8+5V71FOzhUQLDhUoHjJ7ggKoEcryi872dpApFp8HOpgkWhSicuwOL0xdL+3Kp58Oe+kgryz2khV2xBWgg8GyVChnvDF3wtIuotw/3t3+k3T0cLoxNPofc/xFPq96Y6JwTpG2o23/5AkVUAo0aBy5vMzW3UXJ0MXNhpiUdX4mleybNR+oOcZLUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN8qBTvFUlQ7JvCIzvPdBo0odlw72zYK+3OSIQ7a56s=;
 b=BPkjUJtswEH1qT/N+F9FXKt+cOBDyzSZepi9PnS/B/zLHb7rN44Ag2y0GFeCG2RIQw3RGn+Y8wO49WiQ+ZpTTPbozWCQq7GwvhJGvZ9qNo6XlLpr+E/yd1wvoCZAM2sSxsh+ULfzqfFi6wrqwt1JCY8fVxArLH66ldXq1TmbDsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:53 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:53 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 15/15] can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to kvaser_usb_{ethtool,netdev}_ops
Date: Fri, 28 Jun 2024 21:55:14 +0200
Message-ID: <20240628195514.316895-16-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99bb4f09-3d13-4ba5-e6b6-08dc97ac4e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/drMOTzVIFe+bMU8tXL8TGkUiGt3MNZ5QmFOLJHzpZJCW+pShAgySsGJKry?=
 =?us-ascii?Q?cbHD/bM/LduVEqRJKe35+IKm25T/AWTdWCAtFiap1vjbh+sxiY58KHdmc0I7?=
 =?us-ascii?Q?J8oaciYnOhOJnwzxbW5cbqXEEPIva3A+eJHmiJ0FPzRROmvOwKm6DEwoEu0C?=
 =?us-ascii?Q?va5MhC0TbuCgzjiH4XHIGrr7Li7fDb2LRQvbw+7djr8ZiHf4701wS5qv7saU?=
 =?us-ascii?Q?h63TuZ3cBu68UdSfePJ6DL9qDt9ko1vrQpadbgpnBKglVtksgindV5WBtqts?=
 =?us-ascii?Q?KNlYcoZCmR4yjSoFkgZQ5+4OOUVTSNWAHzj6ZHQwvcJg8IatNpWZc4T6i6aP?=
 =?us-ascii?Q?KxbPX4B73apm0DSfs7i1CCgOiINOyO3LyMl+RA/c5Luyrr2Zx1PgEo77mrcN?=
 =?us-ascii?Q?inXvoneeba+usgDjSmKAlrjJUQtq1e0g/fA5m1Bi30cKAuDIcuqq64pzdkmu?=
 =?us-ascii?Q?xE9FkHSbo7BGB/gn4RWK46p2K0PtuE9jo4tQWWLJkfYJfY5OELse3WqoE+IL?=
 =?us-ascii?Q?PvKToLKMBYOiwMiaw9wXuDPGYRIbleErlLwY7apYC/cFUAq8SXWCTZapJldV?=
 =?us-ascii?Q?VAj4P4SU56cfkjzXBAjaIPj1T5drP69t9FJ0qi1K2JOnM3DLnr4TtzxfAGMq?=
 =?us-ascii?Q?I+//9hqWwFq1SgK+kLohMICf4S6ahxeePa+o3dJys5WfNqmptDT/SxXfP1/o?=
 =?us-ascii?Q?10f5LIrSJn8zM8ZrxwAbg9kSUdH2B+BzSF/BF4Msimw7+9/VB/iMCmKVjhTj?=
 =?us-ascii?Q?lM75xwYanu3VOx7HnTjLIa5fte3+rxnufla+/S2/CPqf3AHcP26PUoT4Mr0+?=
 =?us-ascii?Q?7iT4nRzOlPJRtjFbY9EdNvDCkeFMf5b7sAv16TPDCIPjGNasd8U7PYP+q5uB?=
 =?us-ascii?Q?treecLvywRL1KcXIfIbNWMudRwsNsw8hqRw8g37hyWS0bCI8gqX3992eFZr+?=
 =?us-ascii?Q?KPcNkGuM96pod6IVDdAKlDhVvNu7Gda1MnfsTAq1Tbw8EsgGx6XgU+6MbbyL?=
 =?us-ascii?Q?fHWwYNUM9u9K1d59GRb/zYSzIEj6+3bZ10Hawp4OJPiwZ3+qxeqTabOZptp3?=
 =?us-ascii?Q?8eVFJRgdM4e6TKl2+CWqQpwUKrUp795C0Jx1ajpMqsmCr5SJnQAzi8bNI83n?=
 =?us-ascii?Q?OUphlcEevNnnFAGNLxZDNxdy75Gr1CCgl066AiUhrMm7ABwhVdIKMwu+32YI?=
 =?us-ascii?Q?h4Ah8s/xy9k3LxjpCIJJUESYLytwa06j7Naa6TXzfwNTZs3NtHbevK8zpFUK?=
 =?us-ascii?Q?rdlghUIDD9yVUEZD8XsamlwJ1KMT+OjO60+1nBViOokH4wTTmmgHZ9Uv8+Lq?=
 =?us-ascii?Q?6VQ9EOJdGitneBjJnjBWuijDKbSEnSwbnRvX3ypet0TUxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9i4GZ7Z7/d7GR++hJmwSsnYI2a1oIrCFqYFFGv6eykoOUQ6Sm/WKs+eXJa0i?=
 =?us-ascii?Q?JHMLO8svcCkXASgchPi35+UD5xyl+spE5Anlfg3umgBpJ2GhU4tmiOhR9a5T?=
 =?us-ascii?Q?LBSNtfZLdem/q7zL/bplOrkIaoj2WGEyGCUoQTAxO3Hsbl3lKbxw1re+ODZl?=
 =?us-ascii?Q?7AtP3xVAfZHb0RxsfF4GRFzOkUqat1G5GDiitQAzvnXKD+joS59FzzRK0h9K?=
 =?us-ascii?Q?vthbQTBdV5DKVXA/kfZe3lIOTTY3yDb+BZ2sRXcP4G/AEBOIgk0KVldbdvjz?=
 =?us-ascii?Q?cB337WR9y/MT2/+rHN4DZK7hhhA4TLjqZ7qaiOqIjtsHtwjvEZCjUif81zpE?=
 =?us-ascii?Q?QzuhGwe0qhdqag61VuG/j28+ljcqXks/iDc+c1V2xABK1wmhhMm+rSAAKL+0?=
 =?us-ascii?Q?Zx2+unMrXdtvFte0t4nlEHaP5P/SvElSaCw8X0OTJiPnOA1huDMUORyQ8G6r?=
 =?us-ascii?Q?21vuT/kfhCNbO8VxgVY1lyLzb0ZQ6ckGcD3EShk3qpZGrdfMk1pHPHoiQ9/y?=
 =?us-ascii?Q?DvMbKQZpuU3G50OLxmOqewHSUiowLGjlbKWoReWSRmxqGGYDPGBNVeEnuoZs?=
 =?us-ascii?Q?x3k6+15d6HTiShmQPGUP1689rwk7sfv3oxsBr++7G2HCZbKIXQRaOd0joime?=
 =?us-ascii?Q?nBmVyQ9AFYvXl3VHz5YbfeB7uwzXisT4DnFJx1dbG2/NTUjeoob0A+5DNCNT?=
 =?us-ascii?Q?nEr04W11z7JAOvw6QpBBm+WqQbq860Yh6p8tAHrERdtLi8x62QAdkcioNWq2?=
 =?us-ascii?Q?avVm04hT+emCPHVmg/0mTnBXdocyOSm0bUH1cWcpexE+b2TzbnmXlnVt2UMy?=
 =?us-ascii?Q?KJWIK7iCWolmRf6DoC9j7rVyi89xpfqNQM8mCrl42indZnLR2j8GoHC7tBkX?=
 =?us-ascii?Q?U7lw/8NhjmtpSxmGa2uAHT5WPGIIpP8YTT89BASHGqPxWxrJRohLxk7/BbuI?=
 =?us-ascii?Q?WD7IFl6dtI0J/R7GBj+lumTCh+ISrEgpaidjd+ufvYml690oa0/aNoSBSKI6?=
 =?us-ascii?Q?whpb0hBC558l9lRjMdb1+rRvYnVlDHUCEsjfFbXUcc7yYwf8DyDTVoQh1WEg?=
 =?us-ascii?Q?TUbc3w2LmKemxe+g/Vn2ZqOWSfXQjErfyD3Kj38jnWSYgXDGVaAR+zqQmnKf?=
 =?us-ascii?Q?1Rwta6Da8wBdZyQrgnbWcFl8OI37NnDqE0sNNwDAP9R2bGd6iWSGM2zJyL4y?=
 =?us-ascii?Q?bUOfEVUY0bZQWf11cBoOqr0xWAfeH15j61DvTs+xUHA12AgiirnE15C/XlpO?=
 =?us-ascii?Q?pExibF9L9TGdYau6J+Dc7NHPYReIR2oifY2+ivgZ4ALKapmc4nbRg4PFuwWx?=
 =?us-ascii?Q?U1Jib82tSYacvYOdvHW5SoxXWx/DLnKLHrSaRoeAT+Ms7zj8Afph+FrKWirE?=
 =?us-ascii?Q?N4W3yStz58CB2wHWKalkRKgpBjs7x0MonR2fL338yb7U2lRiM6heKkfpQRs8?=
 =?us-ascii?Q?CRjxCJcekcLQK3tmlGlXsw7pu2wOaZ0ynHKC/teIKJNeITCv8Cc0NJYEfHhl?=
 =?us-ascii?Q?dhxqbPoBSDx8v+WkOxW8Bak23LrxDPMLO7dHXediU6wmIhvttsW7OWxaRYKE?=
 =?us-ascii?Q?6eZrolhjGd6XU8BcwqiIhbvKjVz8Ut1zOiqA8uzz?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bb4f09-3d13-4ba5-e6b6-08dc97ac4e7e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:48.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3DaTDaYfqUZg+AMMNRRVlD+AGVVcFIA+Hdl7PUneYu5yq2uN225F6rIBjpqCfDWRfsdsm9boR/c3S7SUYkH4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Now when we only got one set of ethtool_ops and netdev_ops, remove the
"hwts" suffix from the struct variables
kvaser_usb_{ethtool,netdev}_ops_hwts.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 4b6c23121b5d..35b4132b0639 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,7 +753,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
+static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
@@ -761,7 +761,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
+static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
@@ -847,8 +847,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	netdev->flags |= IFF_ECHO;
 
-	netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
-	netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
+	netdev->netdev_ops = &kvaser_usb_netdev_ops;
+	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
 
-- 
2.45.2


