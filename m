Return-Path: <linux-can+bounces-4129-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789FB11EA2
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E31CE123A
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A22ECE9F;
	Fri, 25 Jul 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="G3rk+mfL"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2103.outbound.protection.outlook.com [40.107.247.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160FD2ECD01;
	Fri, 25 Jul 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446778; cv=fail; b=MFrecVl7TLc3Z5mUb6wjs3k7hNHqV3dGzOotOa+q8vaMPmbPENFYrD0wPVSAn18DxXFzWr2rnvx+GcxCpza8DsYxb9c6aeKSwmOd27hCLGkIs+2gjiOszoKja0YII02loYzoV6rCJJUp/y5Nadzm0WIy+nJ+lZgkGpYImh279Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446778; c=relaxed/simple;
	bh=yJDjAvmBWL78lH5VVCZlGz1pYb+bbFRDYNfcex87RNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFSSYUUd7Kub4ZnVRIBQ4jGwB6S22Toys9zteOlf+Ka4wyprbx9PcwkGaOPWYcKaYqKxvki5S4oAN7xM7B25slA7Q8SD40P9M1cVZaNkNK06YZk4y1qBm2kLm9BeSFattnrA9l4asnYtLZtywGgy9GNs3yybnLsC/XSpvkPcwVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=G3rk+mfL; arc=fail smtp.client-ip=40.107.247.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw/lTbC9f+FLfSo4c8OuOfYgGHIIAWhzdyz9o2jXPQNmEYoSuAmPiUVJ3TtVvoe3cRFfsDihv+99FR1OTik7jgbIuH8yHcbxwtVR7dKBESf6bKzIZYqoaGKbrTfLrUAFIMccyCjkL2uEAe55GcheVUr+M3kB9/gI9HHR+p3ftT0txtVnWH1YdMkbTM9R3R+XWK5Pdnr0eLVRlphdYsgEs+RiwMb5lOTBs/dAp6+fD4L/PleGcPZnncZtbgi8R00PL+Ji5Gyknj1MX5wvHyf6lhsAtGUV9BgdLVm3NENVkQ/hIITex1v5PjrW4GCaR8nVavE/BMH30zyKD1S7P5Mrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAAPQSkXENn3skWl4XBDdampErd1aWO05ZwNHWYTlUc=;
 b=x//QUU4hPjhKMFDGg9V0YF2y3vqrOtAgUJrK+PpQCWnpEXsy6baFixr6NRoDzRL52KVVhHBxG7IiDC0QKugB2hGxlEqXcnoT621X4CpMywZ2wswv07C0GmvMv7XnTa+MzpYkbG6vYO71+rs3D49cJTFjAbiJDclm6bwj2LvLceEQaP+bnoaO26bshDKyH6CKlB0jC1MUTN+s4joad8f56QqTafh+eXp9Wt7H5wyDMnCfVYprs3gI7nM0DdWQDjR112IkaPcVmq8JGc6NgfCP87REaorcy9P4j4njsi4/BNJT0Mc39v6vAojKnhoPCWWETEqv6xz1oqcSFOiGa48Tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAAPQSkXENn3skWl4XBDdampErd1aWO05ZwNHWYTlUc=;
 b=G3rk+mfLPeas1ohXg0l24pjijXBGWz1nm1AEVeo0TFsXET8uMzKAiBwnA5Bf6St9SCuBLq3UHVx9dctHOyNInvIdTu4S9KfZEPb4QFdvI9k9oCZkVr5uwwD8BqFVrUaG7TI24lS0PRA+uJDw4cTjKMk1vKopxDuO2lmywrxcu3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:48 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:48 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 05/10] can: kvaser_pciefd: Store device channel index
Date: Fri, 25 Jul 2025 14:32:25 +0200
Message-ID: <20250725123230.8-6-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: bcd32bce-4af8-4ca1-be56-08ddcb775cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLDU/AQBaEWcjprO0Sl0G8tjD2gC10kTFQNY/7+ghaBO/GqEPK5ax4W3x24x?=
 =?us-ascii?Q?I2Vx54FFta02Conp8GKkoPFpZBI0jlU2nzxn217pcCs6CmQkucGrq06W8hgc?=
 =?us-ascii?Q?K8EcdqiAQa2OCuiIW2hlhaiOzb40CFDf+IUIo2R02EWhkDwKch4WJcmekFjs?=
 =?us-ascii?Q?7N/h7i6a3qkXRp49o/vCHMCVpykfXkiDywb5LGcWyX/HI2X95lGfYKE5gM+O?=
 =?us-ascii?Q?P56DJA1tXSK6pLI2zTHFuQoJuNzVK1Uu11E+l2OLomWClXiO059D2dkIXKjC?=
 =?us-ascii?Q?Sp+rEc1AUjjbdopEI79LEEDa3drcTlIrnBjWMxeceJlsTW8/LNEi26euwQI6?=
 =?us-ascii?Q?YCdwmhKTPFmMQFIkvY1y2zSHTw4oIPHq06n5EOgEkSnNauRw9rDEK/MdpWGP?=
 =?us-ascii?Q?eP4t+ISyOiyhHDFuACiEE/kytm/EpuYEsstpM7Dzy6fiPKJYAcTonE9ibJWp?=
 =?us-ascii?Q?LQi+wiv8CgbSA7mnyOi+O2U1l7i4ruhbKcRsQiOLRZIzVipEgW2wPGlcyYUk?=
 =?us-ascii?Q?/MjaW3QRIDRpMX/2wV3JvoqGi3NJ5d/sqcRjEtA/jc3WSXP/jz4/bBDoi4jP?=
 =?us-ascii?Q?VBdOqGDCI+1PEndwzeWBf/x5ZOP8CWdmo1kb2MYtigUjB1dnM9C3IRsLENEL?=
 =?us-ascii?Q?XtsYLR98gVYHiClxH5Qrj8vb7dRfXNgBvj8Sj2HvjZpFxPMCZEhfDNC+j94t?=
 =?us-ascii?Q?FNlw4ucYjeoppYjHrwn9pt3AqW4c0gWB+UeBUj5voTUw59XC335TKqiP6zr4?=
 =?us-ascii?Q?Aee++CKeOtiPL6UIlfXTxTQWszy6sJocuDLXqsLZCZxR9LN0p2jvtO1wdz9O?=
 =?us-ascii?Q?wME4LqvR8b+0s4hB4ZC51xoNfU6RaUX36Jt/uStBccLBDWHJUVzYImscLA5g?=
 =?us-ascii?Q?BZuqabrA46NijdN7QyqdjCt9POEPMGt3gbqF3yoGXsOqvkjQaRwINHPCxqvk?=
 =?us-ascii?Q?6sLAIPwmJUbJ1LxL/eLgAyi57yCblK0d3g4tLlm3qR+SxrSpK0xp/3Fcp7h9?=
 =?us-ascii?Q?mvcciGxnzlcRMLyxBTDJcrrwrb3/x0nhKlRB4MI5YZXwnlE+c/cLZ2hxDCVF?=
 =?us-ascii?Q?EjqyNEUvlrnqezlUp5CS9WBeCJuuXiie80v3dZa0YE8Hv+ekK3DTjGl84dMp?=
 =?us-ascii?Q?E7GQUDWzhEtYhJfWsTg3MHdqhM11QUyIN0t4q5Hh7Ma8NNUUU5UK1lS2Nqca?=
 =?us-ascii?Q?7wy631hZNvfyiYyaFibis+Ggezo6jZE1Hv4HZ/lvujiKcY3HKd0miy/DmW7b?=
 =?us-ascii?Q?Ezy/NYPeWFlnBkij1vYT2YfKvNF0FrSAjN22oOSIKr1C8Q1IqOQGH4Mxlkfg?=
 =?us-ascii?Q?qrVgsQe1dzzE7H2TUe1FxppGwWMkkqVqKD0rqz02uHhFlQJWTFGRS6JHEqm4?=
 =?us-ascii?Q?6cU+1XJmAfzz2B3imlOtV7Uxl6xYvgjCpR23t6TtEiYYP2RzHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnzTwU5txdGlu7d6JlJbkm9KF6hw0CsPuErv9JmZFOXl/CK5K+xdbMxvxsog?=
 =?us-ascii?Q?jLCu5NfuXJkMLbbTK+o5YVdVAa8ixFo60s7NPPMQ/I7uuQi/vS075EP6oRyV?=
 =?us-ascii?Q?JCzLlc/7JXEKmit2KkgHa1IRxNQmK9uyd55jHFm/ql1OG/Q+uvTctAW2DO0p?=
 =?us-ascii?Q?6epPvWWl+Sk9da1hGmBehCbT8CWhhKxYqskRja44vA0t1P/P3zHs/7LzR/Wb?=
 =?us-ascii?Q?rihn6ETigG5Tqj9q17cbRZFMh+aaC0+bbaoyfFQvs1M4dpVA/b+0rtJiIdpS?=
 =?us-ascii?Q?8Neav9/3AZ9uPdCanlMbIVfZX04hUx77Z/eEB6rvL7fTCmb/+9oI9yh8cvVH?=
 =?us-ascii?Q?AhmBmp8VQTA34m06f0E89qEuK1AefNAxQh1AGL8AbQBx7cexfcBVxgNKUgi0?=
 =?us-ascii?Q?4Cn+DK2MU6wW0qgSS9bKIqXSE+bkV0bE36K1oMjlr67rY48tCOCUE8eGq0zq?=
 =?us-ascii?Q?VIuPVCk09iE9KuFa+9NE9USFEYj9L9ZhD6ZPDHJXW1c1QlG6slzVVypSx25L?=
 =?us-ascii?Q?F8dfy+7ivZ41jlTncdILYCpDyvkFCUXYILFvdpEJFu4alue5JP2ZYD1ugW8F?=
 =?us-ascii?Q?95WHk42OdnJuZ6p5MG1cZkCE5GD1nMrdt6aE3B9RKpPNCOnSjs3pdv6kLeCD?=
 =?us-ascii?Q?XnQxkVXPhSYRmBlbsKb1od0bpk0D+30FQwCYAIcGSO3HqRVDr4qB+0I/4OyU?=
 =?us-ascii?Q?V7WxhGbKEFi7qwjVVyAEJRDrdpsHLRn6JlsZmv9Re2cLpBE+oMBZebQPb8hm?=
 =?us-ascii?Q?e7g92pKtvEMXl96uCz0hQOSGWMWo5IQ7EQUR805+I/JyoV3lOSX32ybAyYXC?=
 =?us-ascii?Q?D7rJ84LjPFEE2ar78aT7ipRXamDDLWtpBqbv+qsljWKhRqaKiWOYqIF0rQZI?=
 =?us-ascii?Q?KKPSRetHrQAgkEQWxNI8+6TLaNiAwdX31Um87e2cOF8SHTT22mSIPk7ufVxI?=
 =?us-ascii?Q?8sMQExlvOeH4XrhOawpp2sLsTAqPPnwMRQ3SgDqIjo6fBiSI7Z0qYOKMfiD9?=
 =?us-ascii?Q?YKXJPvnd+lA3G0Fxn31g7hTjAMoRnIwef0u3YlaIXvzQGUQzhDcBSRpKRAbN?=
 =?us-ascii?Q?gdeesalqIgtP53zpEGfoOmqGAZFYt33vb9RGRMy70bWytmLKK8TBcdKhJD7m?=
 =?us-ascii?Q?0tiz+qyseIIkBopC5ivN0Hklaq8ZE/wITCMmNHG1huRlJWF9nZUDkTECatz9?=
 =?us-ascii?Q?eLD792XTB2nTNRXl1Qqw6/488M6sVLJqG6kAY6aWkbbEXOJzsu10PcmN3B/3?=
 =?us-ascii?Q?OF8kTyZ5SJ00jxI6KKeJdHiaK/LVXHwBMFpTqME0pv3d+Y/B4EjOQwWqzDNz?=
 =?us-ascii?Q?xVIgeepbSeL+Q7wkK++MSwGiC2upI4of9bVOwzcIY05P0ldnQJoOWAxs7kUD?=
 =?us-ascii?Q?58DFQF2AR90yIaFgkTafTmzX6GFCwo/+1TnuBnUUm5qY+YSoyshZboyOMkRA?=
 =?us-ascii?Q?hnPZ1E7mbP+55xQXqLgp49kwOh+8znxHaoTgJTNP2Jjvz8yCkeE+lfcPLwkl?=
 =?us-ascii?Q?odWQBPTdcqsjRlNxKkvLdDEsc1C453UgkT1UdYuMCOdoQhbii9GCQjuh9f/L?=
 =?us-ascii?Q?gduhRQurJOg5PnKJtdQvWvbSrevP5W2i7JBBEnKuuf+jFVW6REukYkZp0f3z?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd32bce-4af8-4ca1-be56-08ddcb775cf8
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:48.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG25lfTqj9pfyiX8XQbBSsIblCIfZ+gXaodjABUOHVTFv966NRn0uu/sW2jcKUDxwBVtjZ0w4wl0Cgm3z+cbWDuweX7q0Chx9LHl9vmPyx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

Store device channel index in netdev.dev_port.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Add tag Reviewed-by Vincent Mailhol

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


