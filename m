Return-Path: <linux-can+bounces-4144-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7DB11EBF
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DD23B102C
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F82EE270;
	Fri, 25 Jul 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="T7DYK6NN"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8B2ED86B;
	Fri, 25 Jul 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446918; cv=fail; b=MgEZ7z/6uUbYB0HscJh8eblEptdg2KywJ+og3PqEvpZFjSCgE69EsaEQjA/FFocZg9RbaWuS2Gy90GtOwm48XgAny85buxppDGsXfihHU/31jYVqRyvGMPAxWYrbEOZSbWYbmqOhulg9y6racbNcWn9s532u/muFv7/X+1UXBTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446918; c=relaxed/simple;
	bh=ncl2Vg9OKYyYjmZrJHeYfRWzC7N06JBJDEc0rK1qLYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xh6ZcPbQhgiXXeY60w2sWBaqExr+2mnHMcL+AsfMZc2jD0komcPX2xshmRxjMvxXkpCtgmIeYhgTzL2ZFMJIgOJO3+GRjgDn95a/Pwnu++edRoUgb9R2mwSzTP4HmjXbBZKReGBlA40nWQ2DX0EkdKDA/3qZ2erBVW8omJ9zpnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=T7DYK6NN; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbDMU757v4nXjzpAMgTSgDIm/ube4Kh6xZs2y2uk2jxEbrkfFrfdCAjEuHpJF7W7u3Piv3EAVgU5RicHXQnQXgc5n9X4SVFZ54MH52BWCFArwQJE05XMhPuPHeYdunYScxt3gPhA1u3kOiRzZs8Vb9aUvxgnRY6QcR+ESutAk8Aiuy32siOw6SHa3cOH6uhcmdAONE431Jr26vIjuLQBEUkn/b6sn8/SOUjfj9ynnJxCh3DiMIgBw9P4GRX3mFj4iSA1YOMW4oKHGBs7hiiIM4sUkI7tgw1MtCKfdEtFfARP/5bR9fnuNVMxL76zIKHekxC9Pe91+PyiO69ScCUUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPFlurHclD4Bhc77W0oVcThHOl2QSPdEx/a5u3eI0dc=;
 b=Npa4E1Az449a4VJKMqNS/vFhF/k/vw7TlmQcjmonnP3oXkCKW0JZ7lAFbhDokvcC6ZUyKzKkgJBriO2yjvc4bbmj7U/it4rrws3+930y6wJcjfNZCdyNqworEhZBO7Mk1tZuidH1Nsdag4vV7wkRHGknb0PZqMLxfQpazbXz54CrT1hqwzGcvqvH1+gAssbkWAZCaAS82Eyl+v5A7oiBkUAnB99iRkn4hzfsFEnplvA2jz3JV6g65IlGUjSnXusE0a3vzxflCXFQEnF/vuXo62ZGuMPH7lc5KlJ7ByLyKuYxDpWxIHoiYBfoqTjf1yoEj3q1mJRfzFyiO7kq/xFYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPFlurHclD4Bhc77W0oVcThHOl2QSPdEx/a5u3eI0dc=;
 b=T7DYK6NNEnLY5BBYLSRZyJX6fPi76qvGFLb2P+jCXRb4ifSLk+U/1aydYqIxy7NuBBBWcwfKZXsj1hMxz9Vb2GTgR5AVg6hWCklgyUtyGp+udEfUMBTMRln7yarsvbvYLhWaWR8TICY/PNt7ZCpWLGVu3udhSVdePwveg5VRfXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:06 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:06 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 10/11] can: kvaser_usb: Add devlink port support
Date: Fri, 25 Jul 2025 14:34:51 +0200
Message-ID: <20250725123452.41-11-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: b0003c94-7bbe-400b-3a68-08ddcb77af92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/fTyv0WSTiXfdeALvWckwv5JBkU8v2YHtI0eFot49hFpXFcOOMmzpUtR+gJq?=
 =?us-ascii?Q?lEHKX52LNLMnxr6Ean4sr+LZwE0XI/NT5ex6LdLeoOt2HzT0WnJ9yPtVOs0u?=
 =?us-ascii?Q?VLpdSyEZ4CFFGnDugPVjZBYxeu2osaXut0bRpSo6jMlRhXsVXgOaYtlzTvCm?=
 =?us-ascii?Q?11F7pNxGmEoTJnpOcnux/G6FPwFifAN4425Viyqg2LM07+pOFglquMQM4l4e?=
 =?us-ascii?Q?VNWYNnEWmYIWjuyMErPPCDJ//k7yuC5XnS21dVYpVtXK+5Y+kMtp5KepOH/X?=
 =?us-ascii?Q?lWeSdht/Ff4ypOHpbEDGAksZ86OCgpHFssBLw1cawWjUfYXPI3dlU8RbTnNf?=
 =?us-ascii?Q?o2CxyZY+7qWkg6gh6xUn8itZ2MeyXk9LgRM5Jke5fnygD0Z+o8v9Cx6opEI+?=
 =?us-ascii?Q?hk7P8P8vgE7RIHripXUTJhSeMsqZ+oH+eT1sBkdEGKnh6++yfNPhaCRWB8x9?=
 =?us-ascii?Q?HTy9509v+evmnq07H444184oO7WRKgGa9I2iC8rro9gohf8LaWhaW9iO8FDU?=
 =?us-ascii?Q?X42n+rF8iJS9Ktee1abuEAFafbOpB31cEGOxxDJ+I36fSwXAVQcgOl05VftH?=
 =?us-ascii?Q?AIo/7h2os6tN7wgxpAJAlp3EX7HdmCCbz7CdriNS8w0zf32lxom8z62ZGSrN?=
 =?us-ascii?Q?A7V9SOb/irktAZwL/apzXfT8IMnN8PRn2NMVXXUlVN3PQ/Pg2LSmi+ONANKB?=
 =?us-ascii?Q?boa/TvX+ct42ln0t9Vkg9BBi0Nna7PygcSykNY32CWrZGfPoos8gNlenhBtD?=
 =?us-ascii?Q?/A4O77/HIqtkAy7YJQTsuWifUn2s+kUdnRL/bSpLudtZR0GaVaeSo+mQARTG?=
 =?us-ascii?Q?/qWw20ctvBxBI9mAFSK3GKBy1QylsZ5ydpF/o6YSStsRN/lyU22BD2MG7hwd?=
 =?us-ascii?Q?HmOHuk6LsBT8u/y06Ny5uXay/FGQbBQtXF3ms/60bxGpS7ynN+7QLeTJUyBD?=
 =?us-ascii?Q?eAjJ+J/jzVvTj7RpKBI/1AJ1qRGQ9/si9wsR4hyp5yMSTt6Pm5ROXfwta455?=
 =?us-ascii?Q?CkQtJb8VneR7d1FgF90kf7v/K8no9/VoAZQ+AP6yjH1K8zfzaPZbsgSsikBd?=
 =?us-ascii?Q?SR8HUO3IgAVL4eWj37W1unwp9C5Na3wYk104IrTQk3sK3kiOPWDVAW7Y0oKj?=
 =?us-ascii?Q?JnjghmvzAvXqqUsPptNsrNBsF53uagHBrPYMfHRANZv9MNPcLvKAcDbY3cnh?=
 =?us-ascii?Q?ZVydaxiDEHeyvemCpVpN8MWNkiZXoxykVz7HEd+ILjj79bS4IKTfIQoh2HeQ?=
 =?us-ascii?Q?LyktOZyE7WmknaxIyCqgd7Yc83lUGQ2qqEW4rrrsS8DF+irqEa8mhG3tzkA0?=
 =?us-ascii?Q?XVozEz1rTgyLLBH7HHk6gFgYLAqHb7Sa5cDaF2jF2OS8Y7VJLJJUaywtYl2l?=
 =?us-ascii?Q?ruLF08M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FLiiK36x9MsAoxhpM9F6ith0gh2f4AzBXaAXJRm4HdSQNhb6dnqUwEH60wFU?=
 =?us-ascii?Q?hlFoaOP3FqmDpUApQSFSjfcHYsrAro6rMTQWVnksRbEPCIRgCNQqkgKV7JcD?=
 =?us-ascii?Q?ZtA16D+TUVvMsSczHCAWaRjvcixFgoMGyRnlAmnhpf7OR9aXgIrNvYyRL/oI?=
 =?us-ascii?Q?serosQAuvdY/sAX13wRg/PadpDzYn9stFjUOOTN/LOgRLR7Xl4s5awOLNnm0?=
 =?us-ascii?Q?oSIJdGssdAkhSvJ9EB/ZRpMT0KHrmTje4d1tdb086B2abIghCr9OSZ04EQTg?=
 =?us-ascii?Q?X9gh8+BGiAib/YoeMNArx60/AwkTmSpChpBFs6cBG8nXTwrT0h0+Mmvx3Dvq?=
 =?us-ascii?Q?O0jwsYLD9CWREDzVMRaixX7iCmMmywGF6NV0F2LaD1/q5j2r2Rc2ydoNARLW?=
 =?us-ascii?Q?5g8JFy5lNeluZ3gahGYpXHVWKzqdVcaOLzXJsO/y3FXkNr6ez/WsiOSo109d?=
 =?us-ascii?Q?iHTprPHc4jFzjUY/AxgFGm5l9SshuJm8/rJGL2EGv8TYK+ECDkLtJjkkitSn?=
 =?us-ascii?Q?I5qnzPfln+DodOTptUIE9A5//RwnfN33QskCZ6xnYYOS59OAZbjiWYFRfWOu?=
 =?us-ascii?Q?xvz/snwT1XFYR+3Z5iXcKjJEoyrXiJ0B+RSXnn3OL6izloc9o1E5kY6tja7B?=
 =?us-ascii?Q?1hiRq1i2KY8hezMCowuREqjVzhuKl44Nb/cAjdT7xEjvl8zINP/V3kE4fG+X?=
 =?us-ascii?Q?Wp461PJV+M5knkZ/9HnZYLy5iW4Sw7txCGzVeGeExhfPnodSKaK7CI9wPGnl?=
 =?us-ascii?Q?lz+GTqieAim3bkmqDchYLtmuuXyPptAyMWPvHrzcTml9Q2HHWRtU3Nz8Fx4j?=
 =?us-ascii?Q?Frt3yANXcP3gOP6EKVuD2vxJvIHAh7ve8NAoCrhmINx/exlkdsFs9UQOGodN?=
 =?us-ascii?Q?u7pWHPfY41KlWrjinOALPwbTgjkicS6B4RtL8ssd7udhvZMwWjtiiTPd+xJ3?=
 =?us-ascii?Q?tQ1DJLyLZm1t8whzMzDN4UW14ShJGs+n0dQp3QUDjw/7T6Vl8pm9npJUd4Pg?=
 =?us-ascii?Q?odOR+HT7WROg2GEimtWTdhSUMcGAke/r//m/RceSgPDVMAgSVpEqbANmMb5u?=
 =?us-ascii?Q?znIgbTTU6v0NFwZo1nai3zY0cY6BAFSK4OpOr6CXTX12c9uiT4Izy3HO0ZGn?=
 =?us-ascii?Q?N4KopWyg96Tiz/gIFDmaqnySCOSrUpKXRfSRUzfc6FV4CUwHruqEqassqCK5?=
 =?us-ascii?Q?Fx/Htn5SXp5eCvjYAVdChF/GW3qvvDYw2F7ztCh+MkxoPQ9MNZJnRt17Addi?=
 =?us-ascii?Q?xEICtsbEiYCocCdLwfAZLMFdNn482A3GufHkALJ2DK6aG8oU7U789hHTrpAf?=
 =?us-ascii?Q?ZKpd5CRrqE60jwC742j2hkR6yu6q661orxQAxCTvTwSYhcfKLYB2UDJD4G/S?=
 =?us-ascii?Q?vq4p1lWtqesdwgFyUbMr8W6Y+6xWoRbDJdRh80w1Dm0QtgKEs4stcRfImCa6?=
 =?us-ascii?Q?JAM4z6bFAfqEXHbJ6QRElTHX27mCRDeNh2ZryP30dsl6uHkTm+pRC8WnoQ0t?=
 =?us-ascii?Q?Yi8BO/tW843kRplUIKjRUH0k5TtVFhaHDMwWeaRnRLPI9r6zk5V8KiceCbU/?=
 =?us-ascii?Q?p4uV4u26bRgEpDog0zLiEf2KF1OSfaNQOPyMIa/yMlfPkRbcYIkskBvoVqXL?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0003c94-7bbe-400b-3a68-08ddcb77af92
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:06.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpj5fqER9WJdn4KG7LKlaCG6MlEd5PBmlYcOCqj8F3arJI7E07K9R1stCvCRQxxwcVATc6aQAPb8KrzeXbeTVpxdHh73ljp6wYo3ntQtfE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
  $ devlink dev
  usb/1-1.3:1.0

  $ devlink port
  usb/1-1.3:1.0/0: type eth netdev can0 flavour physical port 0 splittable false
  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 1 splittable false

  $ devlink port show can1
  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 0 splittable false

  $ devlink dev info
  usb/1-1.3:1.0:
    driver kvaser_usb
    serial_number 1020
    versions:
        fixed:
          board.rev 1
          board.id 7330130009653
        running:
          fw 3.22.527

  $ ethtool -i can1
  driver: kvaser_usb
  version: 6.12.10-arch1-1
  firmware-version: 3.22.527
  expansion-rom-version:
  bus-info: 1-1.3:1.0
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  4 +++
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 15 ++++++++---
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 25 +++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index d5f913ac9b44..46a1b6907a50 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -131,6 +131,7 @@ struct kvaser_usb {
 
 struct kvaser_usb_net_priv {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct can_berr_counter bec;
 
 	/* subdriver-specific data */
@@ -229,6 +230,9 @@ extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
 extern const struct devlink_ops kvaser_usb_devlink_ops;
 
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv);
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv);
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b9b2e120a5cd..90e77fa0ff4a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -818,6 +818,7 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 		if (ops->dev_remove_channel)
 			ops->dev_remove_channel(priv);
 
+		kvaser_usb_devlink_port_unregister(priv);
 		free_candev(priv->netdev);
 	}
 }
@@ -891,20 +892,28 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	if (ops->dev_init_channel) {
 		err = ops->dev_init_channel(priv);
 		if (err)
-			goto err;
+			goto candev_free;
+	}
+
+	err = kvaser_usb_devlink_port_register(priv);
+	if (err) {
+		dev_err(&dev->intf->dev, "Failed to register devlink port\n");
+		goto candev_free;
 	}
 
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&dev->intf->dev, "Failed to register CAN device\n");
-		goto err;
+		goto unregister_devlink_port;
 	}
 
 	netdev_dbg(netdev, "device registered\n");
 
 	return 0;
 
-err:
+unregister_devlink_port:
+	kvaser_usb_devlink_port_unregister(priv);
+candev_free:
 	free_candev(netdev);
 	dev->nets[channel] = NULL;
 	return err;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index aa06bd1fa125..e838b82298ae 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -5,6 +5,7 @@
  */
 #include "kvaser_usb.h"
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 #define KVASER_USB_EAN_MSB 0x00073301
@@ -60,3 +61,27 @@ static int kvaser_usb_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_usb_devlink_ops = {
 	.info_get = kvaser_usb_devlink_info_get,
 };
+
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = priv->channel,
+	};
+	devlink_port_attrs_set(&priv->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(priv->dev),
+				    &priv->devlink_port, priv->channel);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(priv->netdev, &priv->devlink_port);
+
+	return 0;
+}
+
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv)
+{
+	devlink_port_unregister(&priv->devlink_port);
+}
-- 
2.49.0


