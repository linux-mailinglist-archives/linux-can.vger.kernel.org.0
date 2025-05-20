Return-Path: <linux-can+bounces-3599-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2C4ABD725
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567891BA14F0
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662127C179;
	Tue, 20 May 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="bPXFLbjy"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2102.outbound.protection.outlook.com [40.107.249.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EF27C178;
	Tue, 20 May 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741438; cv=fail; b=E/LGIyUpHotrWy15PVH3dRvz8kBUcGgIQDp6KkyimnpsbwrszTYRDtaAPPoJ6RT++/uth+i3lVYXtbdVbXoh+WLC686SkR8631p/DDfJ7v4KkF7Wb0R2LThrtjLUTCKjhroemwGVdCCMuJIzrzb7BL6ifNG/Lg5EkxbCpilbaC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741438; c=relaxed/simple;
	bh=Z/1mkbGBPt28ZY5GSoaoOBRbblLpQd9urnZoP66nUjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fjo1FJVMnSYUo21zee0OYYXorIPLc1ixkS/z+zTyx9HWBpA9LVcshOLtRELWAFKr4jeb1NELLmtrfP5yq/jobC/c0MugeDj9TGdmuQUpaOVz7dtnuWKh6qk2XXT+YtS0iBMjmSn7c9m0S1RpE6SgpMNXW9e/2fhXaU2OBENW7/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=bPXFLbjy; arc=fail smtp.client-ip=40.107.249.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LclDcIUoxe6l2LpqIEtXvFi+Mc2H9al4+U5PZVzMkkIpHOfoj0YoiGrccG5N2Zn48E14/dhMhNv6qSeyyi4P+ctH2+OU7Hx0SH0KbFLoz/znmVNG/FAihZOucGgDtISNQJQeeRtzB3UO7SZ3k6ffwnftXNJY7HV2b+RS6yq+7z1oBL3LpAuogW16KPasAAMy6jXCOKkrMUWfpi3bvTakcyXwg+AvVHlAeXT4bM9lPTiY9GiEw/Bo7U2rnw9PG+ChS14kVHLm4r/2Ii8NJyYhT5CmMTgs6p7Mgo8lBJmlKeOpaPHo3aEAamLG+ZZa5OYrmxgEyWYhzzyom24WLgjv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWCRfpZU8UtdEYCNS194/0prlbqxIlTW5tIdtMA6OGY=;
 b=KN6Og/kEZVP9mF1adkGDmQIqAKEnPkl+QP4aZDUsgOr1c9njC3Oq1cuRToXeYrZb/JxsSoFs1jt6eAyt9FY86vOuVoX3+/CrlMfhDLW6hz8GlIzWLqHgrP8b0d0sG/g+C4prhZEaMc3b889u8Y+3lMP6B3CtuAUJrNugDDAkZOntSDYI1gLw3GWOE+y71UXbuRTEgBuERee9nqXhZ5lxqhCUwFzjsLbtC0M4KaS9ArGgXDLIluDYvzacqGEus3CKTeZZAkjsqOVDQpyEalCtaLVKM4l+d9UCP6m82OWj1jmgNLQV4s4RhyleCgFA7KFTGKI3oGaiPXiukaK7QCRuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWCRfpZU8UtdEYCNS194/0prlbqxIlTW5tIdtMA6OGY=;
 b=bPXFLbjyzQx37bOTiiNpObMPuYhvyY8bKWeB02INVbPfVVs++S/fo7/ejjp69XolKx5lFqPck6c3oI3hySFXhocmpf4/aRxX94OUQXWDlkZ8nbb6QYMc/cBNCWoWzsBD50kGzYLmwFEfct6OajgY1qKiuRJ27JkfHgHOcIp1/6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by DU2P193MB2226.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 20 May
 2025 11:43:45 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:43:45 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 2/3] can: kvaser_pciefd: Fix echo_skb race
Date: Tue, 20 May 2025 13:43:31 +0200
Message-ID: <20250520114332.8961-3-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250520114332.8961-1-axfo@kvaser.com>
References: <20250520114332.8961-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|DU2P193MB2226:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c661e9a-6153-4a17-81f1-08dd979393d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aX6fg1S5oRCRCrzHkk/pGKJL8n5baYzZk58xVNRwdvxUaej7+0I2bzEaodpf?=
 =?us-ascii?Q?QNS5u5kWLFrkxh9f7WfIK9wMjzA622eO1nQQCRdJrH+k2f2cAREmA8a6gId9?=
 =?us-ascii?Q?21I9407JaTDzCDa8plmpbLyKIOD0U3k4Y7SXvkmu5YdHP0vNUB0qIN5EqQrr?=
 =?us-ascii?Q?WPQ1RbMARJIN/+KW1iMjf2npGW7tnZrDfXKKWZseryjfnXb8Z7NIoqnamWoj?=
 =?us-ascii?Q?T8U+jSG37tJZnR39544M908jVkdo6BAHsYzBO4cVKWvQ65KwIECQw7SmJ3lf?=
 =?us-ascii?Q?qYv5/4WYvSskmIDyj0nHm3bH5oGJOTCFUk+3vePsq+gB5/4vRsvQF5JBG8A2?=
 =?us-ascii?Q?AFO0GFhu3wUJnaP5JfEKZpYnW71Hmm1qHi5j6g2WyvPgj+p2epmksapTBKwn?=
 =?us-ascii?Q?JaZyOfKkXnPGbTPdj8VAlOkdw/jbYE56uK7u+ZlENbV/l1si9YfAdlxTJkDi?=
 =?us-ascii?Q?a+JejTpoz/jPP60G8HI+0HNm6HhdJ8xa3LeOfxpQslppf3FHI5/GHyZ9KF3H?=
 =?us-ascii?Q?r7XxAhbXHWTsPKd1BTOUM5/4L8D+HqKIWiHZZi6JLBRH4PV1rm4wfrWXjJPo?=
 =?us-ascii?Q?93Xm4Kpv0kfgz70eIWV3s6Px5XWq92A7mBnZGsLkMdGGq+bhMnpVkkupQyFT?=
 =?us-ascii?Q?ynUoJe7V75ua0Nt8w7S1CGdlbO+9rFXAQAk5cWE7wbJmPiQM+6KwA/js5wPv?=
 =?us-ascii?Q?h+zOuJi5KI7w4lvZO3itFwSFrIWPvZns0go86VkVZE53PeoALPIZfofwjZ1C?=
 =?us-ascii?Q?I+qKUUl9WCj7/KQy/Q37WT1ov3LGZ4ZlojOj6wTOV4/SjUzriHg311r/Z/tg?=
 =?us-ascii?Q?CY8EJ9rugKy0bfVCZmxvBlOtpHcnL8x14LaCA79n51n6m7ytMadV/WaAGPB0?=
 =?us-ascii?Q?eCVsVciaKYZ4qXiEhHpiQOfUcwpP4gowepZ6+DsExOfH3yZtPtHNgmg3uzxz?=
 =?us-ascii?Q?Si8bMkUt3IpZbtah8PyYvaXR4gSnU8pcS4S3WjUJleiZaaR/y9fUWKX5rMFL?=
 =?us-ascii?Q?D5t9b3LajAuQWqxTDLDUHXCV/TCRWFz2RkbrIZQ390WXsK1rn30pSOig+yni?=
 =?us-ascii?Q?ILhE6jxISiV9sGFfO31gSYbm7Ss9+ICnHVf9XR3bUXKAPrtuZRH9xZ/Mr2Zb?=
 =?us-ascii?Q?rq8Ia4YXmk6bFokciXJKbVVhZSMjjxnLbx6BynWL4sP3VkR2rIMAQCDQhtuc?=
 =?us-ascii?Q?xiCz8YLJZ2AiLUPM6hiK8wHCTqIAYdtpQnwvYjAckLhpaYkTAJvuKRsssPSB?=
 =?us-ascii?Q?aeLuFljqslaRJ+fNVDvJgb3SFWB1amfTrXaxX6or8HlehZt6iUsJkRESAcO7?=
 =?us-ascii?Q?/Y1hEf9l0maKL9p7kl/JiV8Ynl97kve3Kt8InGxsoBDVBCCb6ejA4zQ7jAdf?=
 =?us-ascii?Q?91gyAK9GsVH5Zg93PbA6w/7XQwlGwZsiaTYhWOid70hEa8EGwYRFb5uCSDwT?=
 =?us-ascii?Q?JlXGUMEK93w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ii4vp5ODD0Gq3jjg/qu+qBeR7Faj2sZi2fbvmIJYKkmhkXHumTAvE3tyLJ75?=
 =?us-ascii?Q?QDWAAoNt7WT6bcEEqjIKwUkLVMW1WVSBL8/N7QGu6zrFzDcurxjr4DMp3YN+?=
 =?us-ascii?Q?5pRvtsWfAH5WCKM3+0UgavT02o8z9m65j9KkeFEjgN1fy0fkZVPt8rw0z/LJ?=
 =?us-ascii?Q?KPBoz4ZkP+qt0GWoLcua4iGed5+SLZYS3jIcQy9X8HYM6ugVZHCYdV/zySKk?=
 =?us-ascii?Q?byha7QG2MDF5AAA9apgr0a1foZ20VG6OqiHCTwM+tdYaUUZllJ0rnDY8uMA2?=
 =?us-ascii?Q?YgjIVNJe2vsXpOU31W+hhEChEp053HPfSsCF3f+uTkTUnB/HezVNiQTAuI8U?=
 =?us-ascii?Q?an7zCRhkHQXYVusKUSlJ+ScDGBV4ZZ9GGeq+JDHpo947X24sSZns7s7E7gkt?=
 =?us-ascii?Q?4p3F5uHOoiAEL7XwIpegf0RpKEHDFW6Y7vgYnywguwZC2Ig4gw4pJmj9EBmu?=
 =?us-ascii?Q?a3I5WD8EBoIA8IG6ruIuzgrf6OSvxMKfkv5oJjSeJqKtJLVjKCxVUUXXiAYv?=
 =?us-ascii?Q?R84DHCFoergAKoAomF6lmiw+HM7eacat04tTVhxc9/Z404lS6D9DQXYXz3NL?=
 =?us-ascii?Q?d0VDUk/QRBlL4XedImlncJQ/Hj6/at0ztoM2p7R3ARn1Aket6MM8p0ozhgML?=
 =?us-ascii?Q?T9YMrA0PPgDYYG6wdYRjH2QE8qMEXDOGMmFnJOKmEBopyF4WEXNM25s1mrD6?=
 =?us-ascii?Q?X1Vp30nKBTPOwl5v8h+m/6CD2i+At2MOcrs+i5OcUhlj0rIC7e+09YINlgH4?=
 =?us-ascii?Q?c+/NiIXW0lBq0IjYFq9iGnlq7MsEDF9KgALU98iMDss5sOO35jzrrJjkb/vR?=
 =?us-ascii?Q?5eiZzWwNdqaDC3HKQvPSP8omHW4w5C7U6F2PM26XsWDKy+iZNrB+kkS4U9nv?=
 =?us-ascii?Q?OVwDcQDwNLfN5gs+YjOBMHSPA0hTjU+Zu142ctOCbqHP8J4SYw/gn1QPxZyL?=
 =?us-ascii?Q?AWSfLT1RHZMBIV94jc1tnFhTgmN6CFwFuasZ6wICIVC1VMCzlsBsWbmSGube?=
 =?us-ascii?Q?3CC4N2yq46TyQp2f0E+GaYKWQwdsrMAsVMHEWFpNzZzOjGFN5X/acCO85c/t?=
 =?us-ascii?Q?pgXHEWikzajUb4KjEGwz8bKP1RRyKbuxM4P2VgbGPf2hBnJ7rwmQs5RjhkmP?=
 =?us-ascii?Q?iRr66DedbNSRDZDRphQp3zq+B3HeEX21KrmeYyQAiOLWnQGYMLMIZfm2MBcc?=
 =?us-ascii?Q?BMArvgmeaVf08RkkX/WocurGjHjmk06mu5ijqSkyr2qmUp6ZslDeDbzf6Gm/?=
 =?us-ascii?Q?v4we7bXJw8yDoOr/BVY3CzIevrZ5tW/i3KKqkUUvD0xn15cn4hy2Xq7O/yrx?=
 =?us-ascii?Q?dDHZcWC3UoqB9U8g25J/r3006mdUiKPcoY6CqeWwjLYkxAr5g3ufM2oyCiiD?=
 =?us-ascii?Q?03GHMhHEOcoRHOdDrzGmYbRvq1ji3RBwKpy/y0mkF7YDB2/dGwVfwcTvfNP8?=
 =?us-ascii?Q?iNsYuGF3MXXTHQhVOhUzOdn/mdoeaH/kw8m/NicsFyD7/fuZ0Ep5iQLxXVtY?=
 =?us-ascii?Q?O/fdcnIhNsA8t0XL4rAhEO7FdhTFD9yy0aV/0VjcNRRIALmW5QQuyDMGn3u5?=
 =?us-ascii?Q?ZlvHJVa+sfKk8RwdeJJN1w+xQ4OxjvOkKULnDGOL?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c661e9a-6153-4a17-81f1-08dd979393d5
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:43:45.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKrB2HNVPhq+pYwY9ZUQ9HcIjMKwHnKbthAVi0Dffu4wYp4Fn4EytWiRAjXgk0/pT7X/UQLt1fHYo8grYcoBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2226

The functions kvaser_pciefd_start_xmit() and
kvaser_pciefd_handle_ack_packet() raced to stop/wake TX queues and
get/put echo skbs, as kvaser_pciefd_can->echo_lock was only ever taken
when transmitting and KCAN_TX_NR_PACKETS_CURRENT gets decremented
prior to handling of ACKs. E.g., this caused the following error:

    can_put_echo_skb: BUG! echo_skb 5 is occupied!

Instead, use the synchronization helpers in netdev_queues.h. As those
piggyback on BQL barriers, start updating in-flight packets and bytes
counts as well.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 93 +++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 9cc9176c2058..a61cbade96d9 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -16,6 +16,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/timer.h>
+#include <net/netdev_queues.h>
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Kvaser AB <support@kvaser.com>");
@@ -410,10 +411,13 @@ struct kvaser_pciefd_can {
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
 	u8 cmd_seq;
+	u8 tx_max_count;
+	u8 tx_idx;
+	u8 ack_idx;
 	int err_rep_cnt;
-	int echo_idx;
+	unsigned int completed_tx_pkts;
+	unsigned int completed_tx_bytes;
 	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
-	spinlock_t echo_lock; /* Locks the message echo buffer */
 	struct timer_list bec_poll_timer;
 	struct completion start_comp, flush_comp;
 };
@@ -714,6 +718,9 @@ static int kvaser_pciefd_open(struct net_device *netdev)
 	int ret;
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
 
+	can->tx_idx = 0;
+	can->ack_idx = 0;
+
 	ret = open_candev(netdev);
 	if (ret)
 		return ret;
@@ -745,21 +752,26 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		timer_delete(&can->bec_poll_timer);
 	}
 	can->can.state = CAN_STATE_STOPPED;
+	netdev_reset_queue(netdev);
 	close_candev(netdev);
 
 	return ret;
 }
 
+static unsigned int kvaser_pciefd_tx_avail(const struct kvaser_pciefd_can *can)
+{
+	return can->tx_max_count - (READ_ONCE(can->tx_idx) - READ_ONCE(can->ack_idx));
+}
+
 static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
-					   struct kvaser_pciefd_can *can,
+					   struct can_priv *can, u8 seq,
 					   struct sk_buff *skb)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	int packet_size;
-	int seq = can->echo_idx;
 
 	memset(p, 0, sizeof(*p));
-	if (can->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+	if (can->ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		p->header[1] |= KVASER_PCIEFD_TPACKET_SMS;
 
 	if (cf->can_id & CAN_RTR_FLAG)
@@ -782,7 +794,7 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 	} else {
 		p->header[1] |=
 			FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK,
-				   can_get_cc_dlc((struct can_frame *)cf, can->can.ctrlmode));
+				   can_get_cc_dlc((struct can_frame *)cf, can->ctrlmode));
 	}
 
 	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_PACKET_SEQ_MASK, seq);
@@ -797,22 +809,24 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
-	unsigned long irq_flags;
 	struct kvaser_pciefd_tx_packet packet;
+	unsigned int seq = can->tx_idx & (can->can.echo_skb_max - 1);
+	unsigned int frame_len;
 	int nr_words;
-	u8 count;
 
 	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
+	if (!netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1))
+		return NETDEV_TX_BUSY;
 
-	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
+	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, &can->can, seq, skb);
 
-	spin_lock_irqsave(&can->echo_lock, irq_flags);
 	/* Prepare and save echo skb in internal slot */
-	can_put_echo_skb(skb, netdev, can->echo_idx, 0);
-
-	/* Move echo index to the next slot */
-	can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
+	WRITE_ONCE(can->can.echo_skb[seq], NULL);
+	frame_len = can_skb_get_frame_len(skb);
+	can_put_echo_skb(skb, netdev, seq, frame_len);
+	netdev_sent_queue(netdev, frame_len);
+	WRITE_ONCE(can->tx_idx, can->tx_idx + 1);
 
 	/* Write header to fifo */
 	iowrite32(packet.header[0],
@@ -836,14 +850,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
 	}
 
-	count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-			  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-	/* No room for a new message, stop the queue until at least one
-	 * successful transmit
-	 */
-	if (count >= can->can.echo_skb_max || can->can.echo_skb[can->echo_idx])
-		netif_stop_queue(netdev);
-	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
+	netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1);
 
 	return NETDEV_TX_OK;
 }
@@ -970,6 +977,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
+		can->completed_tx_pkts = 0;
+		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
 
@@ -983,11 +992,10 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+		can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
-		can->echo_idx = 0;
-		spin_lock_init(&can->echo_lock);
+		can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
@@ -1510,19 +1518,21 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
 		int echo_idx = FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[0]);
-		int len;
-		u8 count;
+		unsigned int len, frame_len = 0;
 		struct sk_buff *skb;
 
+		if (echo_idx != (can->ack_idx & (can->can.echo_skb_max - 1)))
+			return 0;
 		skb = can->can.echo_skb[echo_idx];
-		if (skb)
-			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
-		len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+		if (!skb)
+			return 0;
+		kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
+		len = can_get_echo_skb(can->can.dev, echo_idx, &frame_len);
 
-		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
-			netif_wake_queue(can->can.dev);
+		/* Pairs with barrier in kvaser_pciefd_start_xmit() */
+		smp_store_release(&can->ack_idx, can->ack_idx + 1);
+		can->completed_tx_pkts++;
+		can->completed_tx_bytes += frame_len;
 
 		if (!one_shot_fail) {
 			can->can.dev->stats.tx_bytes += len;
@@ -1638,11 +1648,26 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 {
 	int pos = 0;
 	int res = 0;
+	unsigned int i;
 
 	do {
 		res = kvaser_pciefd_read_packet(pcie, &pos, dma_buf);
 	} while (!res && pos > 0 && pos < KVASER_PCIEFD_DMA_SIZE);
 
+	/* Report ACKs in this buffer to BQL en masse for correct periods */
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
+
+		if (!can->completed_tx_pkts)
+			continue;
+		netif_subqueue_completed_wake(can->can.dev, 0,
+					      can->completed_tx_pkts,
+					      can->completed_tx_bytes,
+					      kvaser_pciefd_tx_avail(can), 1);
+		can->completed_tx_pkts = 0;
+		can->completed_tx_bytes = 0;
+	}
+
 	return res;
 }
 
-- 
2.47.2


