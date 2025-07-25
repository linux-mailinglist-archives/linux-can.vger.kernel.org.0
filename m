Return-Path: <linux-can+bounces-4140-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50980B11EBB
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A763E5A14DD
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B72ED15F;
	Fri, 25 Jul 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="fg/+X8Ik"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423F2ECD3E;
	Fri, 25 Jul 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446913; cv=fail; b=n0zNrZqr7mzwZc78y6zsoGuNH6Nv9bAkoyNZjaQOvOG0lXdrbdowvXddyVh5IM53DYwXKZBbCSadRK1ofa9HaLbNCyLCWtXYRsM3Ras2O6l9YGan2A+zEyx64DmvJbsf0Jg9QRfewIPefIhk4Q4/9qAucNOgdW8uVVnQ46sknrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446913; c=relaxed/simple;
	bh=5ojhtOPazZeNTNFXPt/VpoQFgh9xn5a02OfbHBFUdEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGtZj7EDoUB/b7eMLX4RTULSCGvQvoe8LGjwV+MUHZwGexbpNgnYLo16BzOFixxlxU7cc6+HbfZhqDIfmnoe+NQxW9jIqkFbbRRZ4mdjufmLCSjzA0RvTOLg7i0d0RDq52dyxxUHCkMjpgvHnYsyDgrY37XUxUThi5W3lbju7Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=fg/+X8Ik; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDd5CYuxzi9PRBz5C5rcKadhPfqKa6xQi5q/BxRRU7dpKd26c1jhVhU01dP9VKt9oR52ucmm5ZpDKczNKHyiOc1zJTe7ohh9kh09ZLaiZ1NSvGs8AJkVk7LUoRbWvgAiGv5icm/zfgXYsykAUDwlLX1PMXBehyc66QtsqeqZd8duZPEErmBHuRbbS44EEoqp5zSoaH2JmFCeNkTiZngh8WWso1bzfV5cNNqXt5xZrv981h/a82xbdkFnhoKYTrsj5Bo4qsy0bEOWP+qWJJMb3k24ihcJyoI5nWRWHNkJiP5c1jek3L/1BHXPhKsunJcdzocNYRc9HdGP1NA8BQM48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6/V8WJlbfvD7aQv22HnphZcEX17o8x9b81oLhDFpuY=;
 b=TiWx33l7cWvIt1UNmi2f+KuOrPWZzjuHfsJY7Zy2rt1tu7Qoj56OqjK9a1Y8EG5oVJjYuLN+P4eKSE5JW5ll7n07da+1H84KqD7HrTAr4Wr54vjbOVp7lLASyEDJgMg0FkJdVS0z69Cw04qxUxYu30G+DNh77/tuFW240d66M2A+zU+CXTSP7IA39qerktH7Aq6cmKRoWcgel7/OE1rCWpE6xlA7M7u6ELqO9HwiNcajuvMZTKQlFxNiBKaepX96avcv9RD8qwhfzwS5nxJIhTTL+QMF9HvOWnoRZMWzT79PyjXxcUvYD3yd3YobBlsjk+KA1ajXuHHjCjYBOxUwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6/V8WJlbfvD7aQv22HnphZcEX17o8x9b81oLhDFpuY=;
 b=fg/+X8Ikib3vvuA6B/r8rJTu376SDtZXagWJ/jdNDY1SERDHmF4ql/x6EWwvPOLayKtBFK1mYiaEVMKRdh726YNGI2VeQuXNInjGqN/J1Pvl4rtuuLEVmJkx0wZvGB0i3fJRZyaWqLrUtsVJlF5Ng64SZRikvRYnfvy+FOGqRKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:04 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:04 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 06/11] can: kvaser_usb: Store the different firmware version components in a struct
Date: Fri, 25 Jul 2025 14:34:47 +0200
Message-ID: <20250725123452.41-7-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13fe19f3-a945-45bb-b3f7-08ddcb77ae4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/e49uQ7q49z/rAyQfKbwpHhc8v0Tq9IrJT7jlJ5501TKHev6d4CdSYsM3s4l?=
 =?us-ascii?Q?HJX6PYiUNY/MkXHfOG4K5y6OJgAKEXyw9WbOBTiE5YVbuR9KWx1DoMkTjkyn?=
 =?us-ascii?Q?Xl1JpeV6etdtCciKjf0H1BqJDMX50PfqUgfdK+rKbggpAQ/0fQRSsnOkheQG?=
 =?us-ascii?Q?J2aOmwHoIR0mMAbE0QMMb5BBgEQUyD2WBPkMHdHFCPx8uFFKW1rZUyR3J/OH?=
 =?us-ascii?Q?+I1Xfugcs8H08RDljQnvSuOnKOY483OQKW5wX87nTEiWqlgL1OQzP8Gzp4Rq?=
 =?us-ascii?Q?CZu+ktUvLhAxVecfZbrGm2Dmz3YlCZQjZiwR4IxrbWjrvL2H+mlYJEv8LSbf?=
 =?us-ascii?Q?/RgggMMgNXcPskWuUfF4txLl7Qk1Y9kVhJj8xRU9g/ctLBad8NbVLDn76WfJ?=
 =?us-ascii?Q?Omn4yar5eLljvCsXJRJ1kjHyMgwaR95KPOhr0pPbXQscTDVKyTF35B0ws7sa?=
 =?us-ascii?Q?Vg7ZQoOG0DcEmg+Eu8MoYE1fxMtzgLWkpGvigr2lDEwCaeQMhatfvYa5+F9l?=
 =?us-ascii?Q?aRF29dkzuP0UBodOLOFjA/xs03l9jT7ipXsnhe4cFMSYzMDiemdQxxgYMj3b?=
 =?us-ascii?Q?792rHntqaL/eB0V7mMMPuRkER9jIB/jfD5Rks/uS4VQi6OPvLBYFrN16sHq9?=
 =?us-ascii?Q?7WJWQBYAU/SLRevJTlahv4Nb+9IKWw2RI6SVNf/OGs2W8X8JeHw9+zB4uoFj?=
 =?us-ascii?Q?1++oel1lRUXQjY0DMlDH5bxP4GeGYEbJlPdr3+3V9gOeEA5WESbUkQIb3Gjw?=
 =?us-ascii?Q?uMRyBMYgwgy1fjLejPD/FWisqkXtpj3vM3uHBnMA/03HsJVUSzj1t+8GeUuX?=
 =?us-ascii?Q?gBuIrZvBQMQE4PcbYze8pPFdneFlpeJnBibQLdGP9xiszZCBOGHOGnkDfSfz?=
 =?us-ascii?Q?j4Ez2ue6jtcb6G505jWCdEAHkPcVrwqWDutDrRYxc4Cash1P1606odvvu2oQ?=
 =?us-ascii?Q?Xjpq4AAocQpga6GCy44mVYOsst44gTa246ZX2qdKBOjTLrBanACbq1I2e8g8?=
 =?us-ascii?Q?DjmhyeLb+uaY6qo6xrTxHYWoxuYmaW2m7N5/ei99a8NX2tgHQqp16hLCDAoZ?=
 =?us-ascii?Q?0c4xBnS0GjQOAtmdZSvNrDVdivVU7WWQcOgfogk+QFDUv/oZ2Pv0luKHlWeI?=
 =?us-ascii?Q?WjcIsnZwENR2o+WDYRdFrCDq67Ocdu9XbSx7NkvgmOife00hU5ogsQS7VFyZ?=
 =?us-ascii?Q?JgHrR4SjTnImuPk5qCJ+zqzCp5hZEdxw8jdGNZVzUxsGrTWefCUEwLxoUeml?=
 =?us-ascii?Q?RsRIT6viBoX3g1qirzrmQ+gFB0KZxQntM74aVniPLANeW8DDgC4IaG90VrKa?=
 =?us-ascii?Q?+qAyEBC4g8tQ/uVxpt0zNTa1I34DRjGELcRSLiRwdPcSTAOAGHtRcrxLJsSP?=
 =?us-ascii?Q?hN9ZfgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HNJlE8GN1zm9I62/Aem1w4VtIXhzO7taLZRue121coCrZE5bibhAH086TheE?=
 =?us-ascii?Q?wzSXQ14Zf8oDMdd/Tvgxag4aVoYXk7Wh9x0D2lqbYD/zH612V8iL44ZTV7h/?=
 =?us-ascii?Q?o+T57wYGDlVYd+jAXKMrRmSsbaL5dk0m0jI03sAVOWVtY31VKyfgS1TuKd1K?=
 =?us-ascii?Q?kYtKWyynIiCHHExylgqXINiqKal9Oy7EQCFd+O5XlS1RwkgdMtuvUPsXp/6N?=
 =?us-ascii?Q?iD7XiGeHtT10E4bjpd3kaDLqK+Omcct1XGtHulITBmOOXDozZUHE7MN1zXiX?=
 =?us-ascii?Q?KIDWI+9bOVIZqcsOc5ngCzH+guf5ZrDFOkCqDZwbIieCYnZLDzOl0Q+D8kkt?=
 =?us-ascii?Q?Olq7XIm6L1ehrl4/OmyyQhGC8at8ySba3bUYLAPwwIf9hU5QvFeTNkN5yvsK?=
 =?us-ascii?Q?9jhJEbm5eh7OF4cHgxGOha5VgF4XafATBhqA95roJ4cai3GASVjm0W6UgaCH?=
 =?us-ascii?Q?pfrdOcB38vbc/H8DixVIUJafk2jJNz71Nc+YGMkq9bYwZXi33YpsRtFyPPEh?=
 =?us-ascii?Q?K7of8Dy4eiQ/8HImbPplNRC5yR3KZmPN72iY+ay9LaRou73ek0zd5swQniNm?=
 =?us-ascii?Q?N8YjW3G2EEprNiviy1agTVkHk0wEu1nymTt1TOJK4W6xcrfBm7d+bfzaiV0n?=
 =?us-ascii?Q?ryfrNgLSMD4Af/4lT9T2N/wrHQ0pKZ1fyo4Y5bHbrqWsovCUzCM/NOZ5GNns?=
 =?us-ascii?Q?gv4uX/CGSFONE+AuWuc5xAXgQNbwKx6c0mevv+VO29y4WKF+UOadm7XTYYw4?=
 =?us-ascii?Q?Z7UDZJSALU4xkxy+4WDOaRzEi2t2vziUv6qMiJJCCuEwymdaoQo81SHMoFt0?=
 =?us-ascii?Q?2dXpiR9RQhlrFTdNN3CI5lFNyHd4cg1xxzwrUDKACSCD+TOTGN+ePaqLTmx2?=
 =?us-ascii?Q?K9PZIAe/2JLM/MbvftpBS14hzk6sfbRFKZMQxFNwxTEoUfqIW8mXpQ63v4fG?=
 =?us-ascii?Q?/AB0RYQxgp7XvosIRGfs3Y3Pu3MEW9kIgz1PTC6sKhBxDWTW6r3X/zDcnOqv?=
 =?us-ascii?Q?Eo80ywHFYQaBx0N2QRLexjq3kl1Bj33InRKcoYZ2w0cLyt6PQ54kwfsJ/zy6?=
 =?us-ascii?Q?LFWzhfu5kvjEEYToJIqfFlSOQPX/PO36PyrQTixU/HIPGWPs7hOsHI950Kjl?=
 =?us-ascii?Q?NBPbrSr2xIWl+GhywZiC6RdkyvnJbnBpBwFVBTp6OwBFKui1FL1lfr38DG+P?=
 =?us-ascii?Q?K3FF+vWVzqMkjci3rI8pYu9fVyELW/Hf2PbNyOLiew/AGR/UWp9vb/26O1ey?=
 =?us-ascii?Q?XcRl9mOXqlI98k0dBXxvG/9rrnRa2xWqMF2/UBZelyGSGfrC6q3dA9To+5Mm?=
 =?us-ascii?Q?JSGH0brYifLXojWmbwo2jtn+TJUZLknDxxJC1YHzCpv4OVp15SVDLvE0Cjit?=
 =?us-ascii?Q?p9nXUb+fUXsnbTUcWOaKaUdIedB99X5vP5+vOs5fvOs4YOStE4vLrecI8g8h?=
 =?us-ascii?Q?w1uq++Y8hOVSpocepcxOWx4FtcpML4tqQKb5yvKBgeSN1M+I0Re8FmdRMECN?=
 =?us-ascii?Q?ICHfmmACsdlyRN9ybN3v8nfezTc9DF4CMihiF8inovTbC7K/UeS1mZA3tADx?=
 =?us-ascii?Q?4UTTVnfyqi6ac0TjS/UOujC1LosyKUjqYUVeOPjV10IigAbZS97oLKAuTPut?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fe19f3-a945-45bb-b3f7-08ddcb77ae4d
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:04.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19sFrTPnr52xKzgULCAb6zL/5h5d/EESZis7kYzJbzNhtWe/lZ/C4PFgZ8SscIpJfH+b6bU/cjRM7IVjLQ6qs04QZVcUa6h+ncdIDM8tcnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Store firmware version in kvaser_usb_fw_version struct, specifying the
different components of the version number.
And drop debug prinout of firmware version, since later patches will expose
it via the devlink interface.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Drop debug prinout, since it will be exposed via devlink.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m2003548deedfeafee5c57ee2e2f610d364220fae

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 12 +++++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  5 -----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 15 +++++++++++++--
 4 files changed, 29 insertions(+), 9 deletions(-)

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
index 46e6cda0bf8d..2313fbc1a2c3 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -963,11 +963,6 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (WARN_ON(!dev->cfg))
 		return -ENODEV;
 
-	dev_dbg(&intf->dev, "Firmware version: %d.%d.%d\n",
-		((dev->fw_version >> 24) & 0xff),
-		((dev->fw_version >> 16) & 0xff),
-		(dev->fw_version & 0xffff));
-
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index a4402b4845c6..388ebf2b1a5b 100644
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


