Return-Path: <linux-can+bounces-3296-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E27A75FFC
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 09:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD151682FA
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 07:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106D1ACEDC;
	Mon, 31 Mar 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="JKN5KJre"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2121.outbound.protection.outlook.com [40.107.104.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4081C173C
	for <linux-can@vger.kernel.org>; Mon, 31 Mar 2025 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405941; cv=fail; b=SYVvGt+aRGSh0w7+A05Z8dpvNHylUTbX7irN++awT3x4udTlBzqJdCalPfxzbHD15v8waMpjhg9a9W22vy6VD2AiaKV9BjJMHqlze6vH3st3vk3WyXGP7PFXH/C0vtwN/lWBStmAOP4o/z281EhBckJCIoPidclFCLH7UVjkRzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405941; c=relaxed/simple;
	bh=7j8DwT+l26SABu7gqMVgPAEWcH6k7RZQUbr7dS7t12E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iNSZBvLwd5dDZf3hSRIalngSv5MpdWPK7eK6Lu8gwRk6aEU6jTXlbBgIonJ/Bww6TkZhvAr3XM4m6XcLrxU1ik8KHgYefTPuq14n+jnSm5owP5K6PgTXK7xryD9Es/iJY7F+nMqrjP4TFkLfnVynVxNqsDydqQN1L4TkP9lxubU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=JKN5KJre; arc=fail smtp.client-ip=40.107.104.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m955tr2BUeR+aR0yKN7741wa2hiHQOzXmhuS+2zFz7D7eGiF2UrPUCCv6x13IRvxBnL15wbkv+n/TGc59pVjG/aaVWxAUAauehskeR2oQFU0C/b5oc+JyU6PpibISBXFTlStEOwvmX4kuIX5yaEclrQzh5re/qcLRdFSyLt2ay/jvAwLVQpyM+D194gYC0AJZvqmzWh/ioU6yVKVhTG2+NHG6Q102FpHvkc1pwnmU9JgF6S8MCfo4tJhydqCvJ+m4w5pnBHOTBWFTeX7ce7cNLfSABXjqW8KccwUvFplAjFQslyk9Fy6cNquZYYG0MtXz5amYzOPr0unuo5kUuix5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7T8vnO8/j3yB9Th3KdKR1XTLjWoQH78AEjsiD8+zEs=;
 b=wk7HBzfinkFlTSabqRMMnz3klkMJiBh6WaKOYpfP4vdbJvnwQH/s/dJ84CVSfSta3hB5n16tCOlPx7ytkm2SkoeD/OFPN1PkbcSn+MRRDl2NL+riUCm1YxXjGHGaggbpabjkdnATjh9bAliHI0zVvtHYtflxvdqEMK33ffgVdBS7vPATp0N7XYPZ4nuXI3sF0I3/3+ieSyXb5sn9Jgs1Uzemvv02TpdT8ihvp2Empk35+yhbPjBefx1A60+ibt+muLOXH7g1qh6QDBPbeVm3L3ng0sSz8VqaPhep9rFYZtpwfHciSSU7kzfZ0DPkoEv3MrC/RCgvRZAIToIw59Rizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7T8vnO8/j3yB9Th3KdKR1XTLjWoQH78AEjsiD8+zEs=;
 b=JKN5KJreyjFt8IPYGm8dgMPj67UE+0R8OisYV6uOWsg7/eE7H0KH1Zj2AothQTyU0RwDFu+DJsptwWuQAaBp55dsoOtoeeSVxbT0t1n9E48BhiLESqfA2geujy34ZUEy/7+JIRGPA7330FXkkxu85eMesXOMQd+St5cazX4Ybg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by PR3P193MB0556.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.21; Mon, 31 Mar
 2025 07:25:35 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%4]) with mapi id 15.20.8606.021; Mon, 31 Mar 2025
 07:25:34 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>
Subject: [PATCH 0/3] can: kvaser_pciefd: Fix ISR race conditions
Date: Mon, 31 Mar 2025 09:25:25 +0200
Message-ID: <20250331072528.137304-1-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
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
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|PR3P193MB0556:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fe92ff-16c3-41dc-478f-08dd70253a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjnf0enACDfMtTTQA+x/S76mWXPrkJaDiOlXDkV/s7RFhjGmej5rm44GxG6j?=
 =?us-ascii?Q?Nxria+bGSJ0JFIX8ALyiWW9cdHQoPlSoUWJ26inNOmXJ3x8A6pi+ObW4xWoU?=
 =?us-ascii?Q?K35LH6isSJTbhIYQtQ9NP+8cw0vjFGVE20ECqBi0lzNik6usW1408fIcmcHv?=
 =?us-ascii?Q?uJAsIBfxExXBLmhl8j89tIS5gvVzpThS97V6JXuZKcrVdNynVKKSwJAGyxOo?=
 =?us-ascii?Q?Dl1Kk2cMk9/XXl1CB5xk7r31CE6tgsSm4JB9rl9ylRlGCxJ+Lnqn9+IUZrqM?=
 =?us-ascii?Q?pVsDrfm4X4eiqUEPydP6UJk61HylNPonaln9ynqsjuHJ3FDBVFQGizsiN5x9?=
 =?us-ascii?Q?dpLpA/Fqr4UPto51QfE2xplgKK6kqnxvmjz9mZZEatCwTlCnNCYUspA9MmPn?=
 =?us-ascii?Q?+NIzR5nKFg54Ho6T9CFHVMxQdMNN2NhbvzY+RIJZjSID+Di8PWSeEZyO7rn8?=
 =?us-ascii?Q?J8LwgNiIsq8/Rl1LWlOp7duDo95ctzRSFwfMfHxUHlUpLhKluX4jQLD++wz/?=
 =?us-ascii?Q?fy6j65dNN5ov+ht+oIxSNVQec0uEf4RMFuJULknvodl6F2fBKGhuI9pzguIo?=
 =?us-ascii?Q?WX2ONcBzRedWOzTHuAN8qjG82JgRZq2VDcIqVKqZk3xiWeS+qxnXYQqQHK74?=
 =?us-ascii?Q?fnk1KF4ti5aot+z+JFF9ioW14W2gBBClY5ev7v/7WhT2I8QMPBmIfJP8/3R4?=
 =?us-ascii?Q?J22lq7/Dprv5b4n8hNLHxYWAjm6D/T+HWKJsI+zJ1bJd3XLI/1sraov8wH+d?=
 =?us-ascii?Q?a2XlL9R+gSqi2heWFXw6Lme1Ppc6qUdw1wS3NIjSAKq981gjGMXmiWpeDRtw?=
 =?us-ascii?Q?kJqayWVb86/4qDW8aeySkC2WSwHwf3wwbebil4q5YGKduJjaY5vkVyyE1iv1?=
 =?us-ascii?Q?Ym4QIxYI7s0IAWmr0cye4xihc4UURoLuvR28RceaqwxkCApvpzuz4H3P7LH7?=
 =?us-ascii?Q?4OpNGMxiTmwMFMQ/nPjarbTwr5p5W+zG5vqlutETrgW9xfh3NpyrG6f8C12O?=
 =?us-ascii?Q?ApHYcJ1v6X9tEJCdO2c3fFrnhHlb+kSitCtacZUb3cZNc3BER6LW1fBMlfOt?=
 =?us-ascii?Q?4nKD96kN/OKcQVizBcQXcgitez0GzflPmrwri88ipvu1e9aRwzSdbIG32L7F?=
 =?us-ascii?Q?iZbhHRDuE5YgXTBZh4Rl/uk7fjBIg+BoQvTFHYAIW13zl7lXOj1+siCG3leg?=
 =?us-ascii?Q?VOkeAVz3jvCCvShS9r3Y39OS67GV7n9d1ubD4ad4E+uWYzxVR7SBk1rCCkZS?=
 =?us-ascii?Q?xUcT55AA5PIIYI1/DOG/HlB0PCAO2jgzXEPmUUWD7RA+TDMU6hPSxTKq647n?=
 =?us-ascii?Q?dKHtYBvpRLBqCDKWGt7WGqrm6P5Ph43jQzBormcZNC82oLX+/9lSPhOhMGA5?=
 =?us-ascii?Q?Hq9Z+NtG0nrOacB6RYmGeYBVu4xv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6l3r0aGyhv+vgRNOA9FRxYzZVXcQgopg+uVMn+YVYp+HudPK0aa7TOB1NIh9?=
 =?us-ascii?Q?Ed3REWLFmCyKkSXbgTrBH2M1FNdmQpqfk14ZkSrOdcc75YN16pJPnORyKXis?=
 =?us-ascii?Q?xvX7gjdw98wbQXrUigebsi0nXJr/fB45XGCYZm9wUJmueOUnC4+8dUobiZya?=
 =?us-ascii?Q?zYeoBpt0mGz5RDuiUhQtIKC16tmj4BwA1fsgOH/ocyRrGgz3bxVFakM5y/u7?=
 =?us-ascii?Q?EsV6XL+CKC43WLCkKhM1+d6PjsZoJsrVMbhUw/MVLUbKjgM1hqNKzllHVZBG?=
 =?us-ascii?Q?ymHnyKr/W7pTVw7KdvVbnPAHXVlAEhDO2Edvyx7HfaX4PNBE9CZEs2i7UiLb?=
 =?us-ascii?Q?/AGpT/9iWXHSffNqibCW7D7OhiGXy2fvD+BnmaZXcIPxUIbxguBcYGmoJaBO?=
 =?us-ascii?Q?8z1bLBbgVzuGhsxZzBEF7jx4W2X4oofr5CvsrKWjT7dS6eCQOsrftbaose79?=
 =?us-ascii?Q?vL4l6N0BJzgFvNhlyYzbBZuqvCr5UhF6kSIKJncaSwIehI0oMdKy1TvuonSd?=
 =?us-ascii?Q?jLBtbdOT1xno4+bRrOJb6IfZSCk2xVjFxKitysjTNPh/I6bTn4gmEjI/J10B?=
 =?us-ascii?Q?/PC0DGSxLoz2q1tQyqpyVdPiQXxmv4DUIm/5s8tRZJwipNfFQB96LvLKxQi3?=
 =?us-ascii?Q?DIUtPMHLmO5zwih8BtGZS6WZh0wrocd8cVloQcnUR9Q0BFd3ZFnNk9QhnBv4?=
 =?us-ascii?Q?FkGr5XWUF2FRQUpl5rEROAKYgSXS7/MI6ebzpUVcvTezx1lXOlvTiZ9plOdO?=
 =?us-ascii?Q?rXaJFz+RNkd12kbJ23Wp26UA+mYdzjEE5/nrOgs7jpCs64Dh1X25e5t2B+rv?=
 =?us-ascii?Q?IA7Ky+9sjSlp5UeCPfgTosLbjpkXW6DdKz9tjfYsAhbDHmfq5yJAbQhC1sHm?=
 =?us-ascii?Q?wTlVVV1zY+hFq4dkUkPNTTH3w6ueSCdqzvm+lJ8xIJPWc8uSfpyl2CZI5m2V?=
 =?us-ascii?Q?AfttQ2HprEDd4iDKxqRmRRNhcR+Ekj4fZL672co5qSzUeg98V9Aoz7lyAF9d?=
 =?us-ascii?Q?fqIpTuHQFkD56ElJYhiBw+ueGMXJXYTHRlJ3gGbAMOoR7vPna3XZfbjMj8Yn?=
 =?us-ascii?Q?tGFSaoK0G/g5QzwweUPlm+uIvu78pRdioM3+gElGQTCAABSHzCPzv1+RJo2/?=
 =?us-ascii?Q?vasD0lOe+OmVgPD06+eWm4obVGLmYMjJTpFljxVnwACg2N84BgS73S2hxHz6?=
 =?us-ascii?Q?hF7hjd1HGmnL5OF0NZe+7dubTyGFYc1U8Q0AC3X1O3v8mAJ1oOhhCJfhrLu7?=
 =?us-ascii?Q?fNm45I7LJBKkgAmTCcSVIhNJj9sVNKi3r9MUmVsd/LShRIzIr1JlgvKY2ILx?=
 =?us-ascii?Q?ZM1/m6VAmR9aCbja4oOchsK8QnUT41e1gxUtCPvaBtQSsWH0Hg82ZxzrxYKT?=
 =?us-ascii?Q?B19wAEda0V1XsjxULKnSnSewnrFzyQy4siYSSIHuIQd9irVkbvFaOG3RxrHm?=
 =?us-ascii?Q?MbTH1uorPuiu8uJqepTtmTo4ghq+IENHU+At3SHVQ5uyPrzoIN+fMvevoYIs?=
 =?us-ascii?Q?uiL5Mr2CxvkpHbKxUU8+ixpS/zcpHAY4v+71LKMcIO0UpGbwij9tEZnd79ql?=
 =?us-ascii?Q?zpu1pZ5DrnqzK6F1Gf1cRR968vqp42Wq8NKY0xyF?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fe92ff-16c3-41dc-478f-08dd70253a10
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 07:25:34.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cp5XaxAMj1tUnqnk/h3O855fbvrQcRwnLVPiLy++uc+cigM+PAB716hkl9bhCBmtVXPXLUXmxnaeMjfmYET4lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0556

This patch series fixes a couple of race conditions in the
kvaser_pciefd driver surfaced by enabling MSI interrupts and the new
Kvaser PCIe 8xCAN.

Axel Forsman (3):
  can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
  can: kvaser_pciefd: Fix echo_skb race conditions
  can: kvaser_pciefd: Continue parsing DMA buf after dropped RX

 drivers/net/can/kvaser_pciefd.c | 161 ++++++++++++++++++--------------
 1 file changed, 92 insertions(+), 69 deletions(-)

-- 
2.47.2


