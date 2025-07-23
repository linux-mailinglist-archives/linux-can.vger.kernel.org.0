Return-Path: <linux-can+bounces-4050-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7658B0ED60
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E37AFB1C
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CC279DB6;
	Wed, 23 Jul 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="bMOlPFvI"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2106.outbound.protection.outlook.com [40.107.103.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453927CCE0
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259744; cv=fail; b=OUua8wGm/6ulOkbk7u4ALB2aYcF4U5L1FcUDMYXhLi2tgKDJy86ku7U/Mm9gzVocgWcKGiYMBjkkGL7DMeuOYq9YZRi/czuuv+3rzO1YmdsNbgCFmBjg6VOx+VYk7XYa2K6E199bUh9ux61uENKIHfWWvL6FoUAv55qsdT+Recw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259744; c=relaxed/simple;
	bh=+bIAWoUuRlVfxhyXylhyG57iaGlsTO0mhV1JtV584l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4A+WrbFzUpRKREpQEq7AGgecRNRg0GTzWxYgh7oLbFSwzySBBvvxfXYmdQxOe9ETSHTx8nGBbax+fS1MtZxiThww3k2NTPfYVQXeg+SoSHZ0zEl27ARlcASUHRxijwhHHOJ+NNEBtD4l3lm8YXLVJQcXpV6dXJ9UsNUt1SLg24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=bMOlPFvI; arc=fail smtp.client-ip=40.107.103.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj3M+Yl1wVsU2pXSLuxqwvjZUEHjqDnkWSpjqmeuwW0Hpsd/tIyJ2fW1mCMrD5/hp/jE6eii0/g685dHWIyMDjj0e3/Db18mpmjrPfkbln846lfqFz081QWc+qRCEbgcF/OdD2HSUpg4ZsLvX5WYmygfFWw/gC5b3zE4xJuIUhFQ2iJmX2TGlm7qj7XVOzHIVqJY0nGDHIgqnZB9SrVpTyMihUn87mwyH6F5frI4GBQS03QJ1ekQMOt4Pm6ZhmVpcJB8LCIZ/z1mRA3nDih2ZzIWca4O8iFW25qNdt9hZjy6Is4xoNJzXebEkKEbMZos9oYkDckUiZOKDQbERUBFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1tTgFioUe9+RiDuQyyXcQEQAzJdxn+CwgOq+Wk8ChI=;
 b=s+8K23fG32IDCxwEpx8ol3UGJS3d+zU51ZNkvvJGrxRRvddWH1kiiSUm5mLYoZqCk3Kqwj/AgWLDx1qY98n1gzcV6IR6EL6IUo2X3cobxXCKpkoOidrYLvUvOhLkUDsneRvVmf1sZsgZ8nPydrv2If/alXpv6C99VPTj6C1wBFx4XYpXZckdWrOVkhmx1EpazxQ54y+cadlM81egAMpWwQy33QecGFAfglilGViIow4fbv5QYqzH4ect0Lme//RGvR/+mfLLE7J6oAx0a0IN/BDDMcV0mQkIsa3q4u5CWblTm7Hkm0UhLCAcDhvDXMaEi0VDrVDIdTM7eUghhYGI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1tTgFioUe9+RiDuQyyXcQEQAzJdxn+CwgOq+Wk8ChI=;
 b=bMOlPFvIlNqKXAVT1FIl+r/EHvMfe0mg/j/E6JTVC1xkyomiCDm7x68xM3UoYCFIQdk5iCuLygKhtc4HDOu+xGUIWvafviH7sgu8y5GgHlRGBu61hR+o+XBlXfdX8Zhoae//0zdRF7TIQKZaF77j1teydVricwByQYXyiAMLIXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:33 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:33 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 5/9] can: kvaser_usb: Store the different firmware version components in a struct
Date: Wed, 23 Jul 2025 10:35:04 +0200
Message-ID: <20250723083508.40-6-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: f080f99c-d90a-435b-1a09-08ddc9c3e3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6fNnE2DI0v38gu1nV03MnrX3szjIfW1f046FGEx+rDsO2cEiGfTmo5xf/x0?=
 =?us-ascii?Q?f+KRYTI6DHsLfMHxdUZ93mo7RapxxnUeJ+IwvWNsV6KBFSAVg7E7e5EymdU/?=
 =?us-ascii?Q?U7RAu/kdLDUcOSmEnqS2F5ec2LjHmg0zfgJEv5l2IJ5ZmNT1rd2Z2WCggyDp?=
 =?us-ascii?Q?HhSFMD24ZBJp8W2m9akZqbO7q+tH4IvMnzOCx+/d4eUdPcrlL93YPpOW9S2V?=
 =?us-ascii?Q?A7vUfaumf4NyNrSNA7MSOYTDcWt4oR/AsBETXmfD+L2FsASNxN+h8Wb6nvUR?=
 =?us-ascii?Q?YPDCSWwD3TFPrn+t4XPdYAG6Kmvl2Iz+rpnT3BuE0bElyuJT5VS6E9snUwxA?=
 =?us-ascii?Q?dZsV1PSvEFbm2PW7bQyUBFjnoKupQWW1jFy5ZU3YNdJbsFjUEkbB9bDjEI5Z?=
 =?us-ascii?Q?MC/RE030le0tRYrxK8YFk2hSHwcFTDJr/J8dxPuKqiz3tIRtkCJciCkEH8ZI?=
 =?us-ascii?Q?Q/rIb/cV46au+4AO+rd+Qmf76JC7kiEdNV8uEklY9oV3Z6af3n+n+4jLF8bK?=
 =?us-ascii?Q?CN2T+pQ/m1uubl3iDwGi+RlrUCsZXm67v12EFNR94UulojhnjDjM24C99ZAK?=
 =?us-ascii?Q?72tlgw3tVtGR1c73mQzM//zdUvZHXKc2LikbZrbymZUN6PJYzk0j+s41vehJ?=
 =?us-ascii?Q?uKYVubgZB+5DeFUNC7ajf3R3uzniR/FuLdvX31A2TXWgRipUQx0wuU29UyaK?=
 =?us-ascii?Q?2eeevHJJu7oI22gailavx+M/NCQMtc9vVc7xgczGmoofdCAQLbyddiOPHfgw?=
 =?us-ascii?Q?Vs4UeHC2REiN8RV0JboMBE4fkblpjXidXx18kz5yj8HRopw5e9JdWZl6KW/6?=
 =?us-ascii?Q?26PtT5yunhkz6b6PbPso4rl+vbbv9ZeSqAy9vhcw3/+1OWmN/wzZcyUPXc8g?=
 =?us-ascii?Q?siGPT/kwgerSic8kGU2G8LzOdmaqrrA1Ss97N+YNqhrzfdLFbuZa1H6eZiGy?=
 =?us-ascii?Q?qxGyBpZ+KHfJ5qx/u28zuw+IuHqUB+FDVc+4ojXXtYuUDkj+wClku/UlCSY0?=
 =?us-ascii?Q?Knu1/E3lnwlAehp0HZpd5oQWvQ6pVr8G47P+i0Rxh748oFTvMl19rzZSt630?=
 =?us-ascii?Q?BesZRgv/rblTuzKhqQHlddNVS/5t+/HR+jZa0AZ85JTxDEDDxh8O4scvjUE3?=
 =?us-ascii?Q?clBKj5qHUaZZqvZqNs9HQOk3rTPkE5AqODH+XI+uK8j/PTUbGJAyyLqpfMQ6?=
 =?us-ascii?Q?A/EcbjqliDBDj4ImKVzqW0WYDfEYHINZm49LIULAbvF1/Q4uq854dyvXTF8k?=
 =?us-ascii?Q?THAePwAoJJFrUC4ay0PHK6Vup8gQ5O0LC1uhmY7zz2odUtolv0DAuD26xuKI?=
 =?us-ascii?Q?U2VVqAAcaYAXpaFkyCbBmzZLfCfGEEv9zTgfmmzwgcZzydNIAD9bQCL2wQ0Y?=
 =?us-ascii?Q?F0wdRY/jMIPLeJHO0uRzNcdY4oJB1ZDCcZIRnMMMHmxgLUqWB29hdDBogL+y?=
 =?us-ascii?Q?px4w9no8kPI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7qtHK6NPE1ns+by+CPj9l2oVJL9a8TxV8Ef42p8jQxtKIx9DIwqfYBJfDgZB?=
 =?us-ascii?Q?Lf1tnrgXAaBBP4j5hfvXuvyS8SE8+WFir80C/Cub5N9RfkKzaT77AKUmG7B+?=
 =?us-ascii?Q?O5NopEvHQMsTOpmyI3Frycd71JNXzcJL37iRFEp7YMB/hcP88oAb7qjm/HJR?=
 =?us-ascii?Q?Uaenw2acQ6wSjG+QT2KJMBfa6K5Y0JyBkaB7EhCoTogXhvEzc53P1WLDuQz/?=
 =?us-ascii?Q?grkMt+WSYw+sWayxHibq3SN8vg+fxcUh8+elVWygiite8i/wbc/5uR21uVoO?=
 =?us-ascii?Q?18VT9X9Gbk8l0uR0/kYEQ8/V/mLqMLbXL0+2gDxmeQvM6Zu0IgFjVx2sUsvo?=
 =?us-ascii?Q?TQiqafajI9xPdssyqZzXFY+MpDfNn3TEAAdx5GQUV5Yz217TeMZwPDYlXWFz?=
 =?us-ascii?Q?wu1r9ni95RIlpY+mnLshfZ+zFJuj/aAToM4efKtGJWGi/Y1eUdTfAUZIa1wo?=
 =?us-ascii?Q?yIV/LJHHA1Qe6PMP4mJ+fdDMOwVpWkfmYGpKS48nlUdaFt0kBOrBgzVOXz6S?=
 =?us-ascii?Q?47yEOnSl7H+VK4l3z7lZGV5eh42uM1fpfVxY/HQlcIide3HgBKrGIpw+M8iy?=
 =?us-ascii?Q?d8s50gSTIbly51R1UAsnHPS1F77Aqdf5s4Ts2LJ5g2LIoOuhx91ywDZmzyVX?=
 =?us-ascii?Q?QrdiSYhWCWVIS/DlTpvRRz9oGt1CTgIJUyvpBkV3ingcBe3xv+I/GSkAhky1?=
 =?us-ascii?Q?R3XSOTz4o+yHvw/a9NNdJmxh5/ruqwptM/T+ojaByWK0UHO3fN7rRvzvcKhz?=
 =?us-ascii?Q?I/A6X6V4LOBpezGOP2o10Rc5wb3AryvGTZYGtNxTXvGz9BGk7/d3vJwH9f+B?=
 =?us-ascii?Q?o/CAcgHPjd/XYYgaMdNnpN4/TQ+lF/lQxeVC3ZJlcR+36pVcnS2jG7CoaJjv?=
 =?us-ascii?Q?ZlkxIe8RZIR395idpjrsyHTQjdOr7dBpegEkn4yIcevqYqWGCwmNrqmJwiI/?=
 =?us-ascii?Q?K1TlwKMQwEKa5Wc+KgItskFWgUPqTSlokRayTu+AH8iFFPqrjdg9cBTUhukB?=
 =?us-ascii?Q?rVhdzIkaAZkpE13985VFF3RUFYQcxPvbXodcUkha2arm76oC9YpqDld8pIya?=
 =?us-ascii?Q?rpx2bQKpNmAT08/NPaXUtilF/NWcIo3y5ZXHxvU7ndMhE+Tzqgw/2qQZI1lf?=
 =?us-ascii?Q?HrZmDaIjMQTdqUEwrQUtY4CHpCvUnERPWhRYReU/tAmqCLdsVpBNORn+xfhm?=
 =?us-ascii?Q?qD4BfIJq/7Zc7LF/2UYL7VsJEnr3hZskHIztdzS6NwlZ6G8vfx3gltdHkzFO?=
 =?us-ascii?Q?80iJwE+Uqo+k0DqoWsld8indnyaUJgzsDE010qNzau7BNorSjHfcicu9SUEY?=
 =?us-ascii?Q?gHRaayUdS2floq+/eXo6EwzK4tK8IhyHNNRtX/aWDRQ9NUQ9WytDWfgUizk9?=
 =?us-ascii?Q?pgjIGwmdIAklTTSsSsl7JJU+gZgDWyEbJg1uUNmoN8R97Y8CXOiD4CvFEh+s?=
 =?us-ascii?Q?h6aqp+bzV7tD166HRg0+4A0TCOVhqfyskfjJB/H4yq/74CrkIL2F4rW/+86z?=
 =?us-ascii?Q?HZpTLmJGGdB71crApZJChjipuyKsuSibxNgzrjojS7LXL1HfEBMSeFmYE7hs?=
 =?us-ascii?Q?Q7CxQMf7yIjBAnGLOSeGEKEH8aDqwk/iFjDvNBbzsKV/adNWw14NjAN8czBd?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f080f99c-d90a-435b-1a09-08ddc9c3e3cf
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:33.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6dICbqFIhZYpPzzFTz5kWLRL4m3DtFjsQbXNPxY+9M/aJwac1SCr0qe0tm/PhWP6eTtMhrTDD1oqHvrZbKYztmSex69cWTJrZJ7cSeqa10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Store firmware version in kvaser_usb_fw_version struct, specifying the
different components of the version number.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 12 +++++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  8 ++++----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 15 +++++++++++++--
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index fba972e7220d..a36d86494113 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -47,6 +47,10 @@
 #define KVASER_USB_CAP_EXT_CAP			0x02
 #define KVASER_USB_HYDRA_CAP_EXT_CMD		0x04
 
+#define KVASER_USB_SW_VERSION_MAJOR_MASK GENMASK(31, 24)
+#define KVASER_USB_SW_VERSION_MINOR_MASK GENMASK(23, 16)
+#define KVASER_USB_SW_VERSION_BUILD_MASK GENMASK(15, 0)
+
 struct kvaser_usb_dev_cfg;
 
 enum kvaser_usb_leaf_family {
@@ -83,6 +87,12 @@ struct kvaser_usb_tx_urb_context {
 	u32 echo_index;
 };
 
+struct kvaser_usb_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 struct kvaser_usb_busparams {
 	__le32 bitrate;
 	u8 tseg1;
@@ -101,7 +111,7 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
-	u32 fw_version;
+	struct kvaser_usb_fw_version fw_version;
 	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 264840d84987..68f23cd61ec6 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -965,10 +965,10 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (WARN_ON(!dev->cfg))
 		return -ENODEV;
 
-	dev_dbg(&intf->dev, "Firmware version: %d.%d.%d\n",
-		((dev->fw_version >> 24) & 0xff),
-		((dev->fw_version >> 16) & 0xff),
-		(dev->fw_version & 0xffff));
+	dev_dbg(&intf->dev, "Firmware version: %u.%u.%u\n",
+		dev->fw_version.major,
+		dev->fw_version.minor,
+		dev->fw_version.build);
 
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 758fd13f1bf4..4107b39e396b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1839,6 +1839,7 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 	size_t cmd_len;
 	int err;
 	u32 flags;
+	u32 fw_version;
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
@@ -1863,7 +1864,10 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 	if (err)
 		goto end;
 
-	dev->fw_version = le32_to_cpu(cmd->sw_detail_res.sw_version);
+	fw_version = le32_to_cpu(cmd->sw_detail_res.sw_version);
+	dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK, fw_version);
+	dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK, fw_version);
+	dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK, fw_version);
 	flags = le32_to_cpu(cmd->sw_detail_res.sw_flags);
 
 	if (flags & KVASER_USB_HYDRA_SW_FLAG_FW_BAD) {
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index a67855521ccc..b4f5d4fba630 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -741,9 +741,13 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
 static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 						   const struct leaf_cmd_softinfo *softinfo)
 {
+	u32 fw_version;
 	u32 sw_options = le32_to_cpu(softinfo->sw_options);
 
-	dev->fw_version = le32_to_cpu(softinfo->fw_version);
+	fw_version = le32_to_cpu(softinfo->fw_version);
+	dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK, fw_version);
+	dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK, fw_version);
+	dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK, fw_version);
 	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
 
 	if (sw_options & KVASER_USB_LEAF_SWOPTION_EXT_CAP)
@@ -784,6 +788,7 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 {
 	struct kvaser_cmd cmd;
 	int err;
+	u32 fw_version;
 
 	err = kvaser_usb_leaf_send_simple_cmd(dev, CMD_GET_SOFTWARE_INFO, 0);
 	if (err)
@@ -798,7 +803,13 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 		kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.softinfo);
 		break;
 	case KVASER_USBCAN:
-		dev->fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
+		fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
+		dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK,
+						  fw_version);
+		dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK,
+						  fw_version);
+		dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK,
+						  fw_version);
 		dev->max_tx_urbs =
 			le16_to_cpu(cmd.u.usbcan.softinfo.max_outstanding_tx);
 		dev->cfg = &kvaser_usb_leaf_usbcan_dev_cfg;
-- 
2.49.0


