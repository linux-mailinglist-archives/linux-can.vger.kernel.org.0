Return-Path: <linux-can+bounces-4282-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E4B2FD33
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16311D24392
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96417285417;
	Thu, 21 Aug 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="NiwpqEiu"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023131.outbound.protection.outlook.com [52.101.83.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8A229B21;
	Thu, 21 Aug 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786869; cv=fail; b=jFhJQMDO86pk/HPnH/wZejlPu4RM4Dq1Q6VFKbQwqiW3lLucUMFk40In+lnKfbGSNhtt8Rg6kSeuNs3tfdAUGnfs24pO2qIoIGClpyi/0GQZ38EjgFQMimNUGXb5WW/QrLc5/7TWOmbqbbVTQWjcE+Ntf5eybSxTW98Uxvp52w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786869; c=relaxed/simple;
	bh=c5AExYKwR4cB+iChdkuAgPns9ZOzi3b0lXtQM8jFgTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdERjMq9x082km3olFvbdfSlFMKAtu555XiP9+hJkXslJ7PpHDCgjrzSV3qsdPQQKxN4o3AqOr4nW6hA3zuiZJOqy302EDURFq3ybZJkUqLJz2TMs9MYpcDPgHd3EqBTK9fvS/RXsQi1xTpCm/MZihKOws8yMKCTSKkJmBLxZDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=NiwpqEiu; arc=fail smtp.client-ip=52.101.83.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smykyLxoqqcKemnA8GY/EhQHeloRS7hysbnW0hx2DfbnM1PcrzegkxDZGBZFpbs5JeEbUgkptvCrDJPl0xb6mmHL3ovOk5bXb4Sw2w3J/GQUFsdH8xCchdoBDov64wdfY8JdXWkVd8hZu+9ZzwCI1KbQk4oZrXvAYoKaM5YadAst1MSPmqlG/DsJRw5X9uTromq+/+sTWaVL2zEZAgVyujjuM88IpZaP4J7IIzrrH3niV3c25gfDjxyIKCgiFaq+RqQdrxhcRiJtZ8KoQUc2zIsWb8eRUmFHa9MI8grVZJzgqYIdu6r5QyYosOh6xmW2WAJkBpzaV6AcNOSDVTgAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4HLOKqXmN2i+n+znyzIF4Xo07gEwNZppzZnHsns6+E=;
 b=KlEhDBG8hvg7g+LVcyryS5daMRZi22q44+hSrKwfILvzle6OKP+wqYXM0uTM9Z1nVHq8a2pqnlPi0KzWwnw0pP6SEpT9Xb8i4WxuSNv+Jo4kEpj+cuPwILmPL5V3m1MIx7+fx16Z+7qqlxAtFmsHSazSyYx12sBI+0HJDxx3SPri2eVZPd1jZivqjRa/JielhXVRa9dej8LzVP8G07mK2M0ge21PTYwf671aMHZwA3VMFK8XUigNkpkJnO6ZR7SZc+1IGv0pu+CVyjFSVptKECn4Ev3l5cg01CjPxvrO5wJVy/FEq9ML8KcT8W/ch8IoDI1ZA78e26XDeaZDNfmx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4HLOKqXmN2i+n+znyzIF4Xo07gEwNZppzZnHsns6+E=;
 b=NiwpqEiulYOeFZ7YW3+lWOAjxaZSIBGd4tsp19zB2mevW+349Wn/uY63nLroLO17o5Wf0svuSKhegB5K+HyBak3Ob+TVdugA4M/sGXHbtXHgqmRtbTL9c3EGzqu+GuzEyfBeDrn5UHm6WLrjCA8PQkp0ffyLzLh2V1Uo03zuVo8=
Received: from DUZPR01CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::13) by AM9PR03MB6834.eurprd03.prod.outlook.com
 (2603:10a6:20b:286::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 14:34:23 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::8c) by DUZPR01CA0086.outlook.office365.com
 (2603:10a6:10:46a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 14:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server id 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:34:22
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 86F097C16C8;
	Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 7CEB92EC522; Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: Simon Horman <horms@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/5] can: esd_usb: Fix handling of TX context objects
Date: Thu, 21 Aug 2025 16:34:19 +0200
Message-Id: <20250821143422.3567029-3-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821143422.3567029-1-stefan.maetje@esd.eu>
References: <20250821143422.3567029-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|AM9PR03MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 191e5655-7d11-4745-b4a1-08dde0bfd262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|19092799006|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzNDRG52dFpoZ1pIVktNcjZONkhxNnJmOEh0azhZOUIrSzV3U001TDZsWitz?=
 =?utf-8?B?WHRkMTBVQ28zaEE4dll5ajg1aWFWdStQNkQrOUtaWTRxRHJxU3VzNy9YbE50?=
 =?utf-8?B?elhUV3F6K0s1S04rSzZlLytSYzA0bW5TR1FObFBZZWVnV2o4dDJUQ0cydXJ2?=
 =?utf-8?B?ajJhL2VQOU9mZmZhb1p5SGVEeFN1aE9ERGRsZmJWT0Y5STdtQllrY0UxZ3Q0?=
 =?utf-8?B?Q0ZtZklhT2dmTHBrdGVodklEK09pT3c5cW1kSGRTZG8wWFB4RElQUmxtM092?=
 =?utf-8?B?dEhHbWlERzFKZE1tcUxnVE1kUC9zZGlTODZCcTNQWWRrdHlBYUZtd2FZcUFP?=
 =?utf-8?B?T3VCY0k1ZERLU0tOcnlYTC8zU3plczkwSlRJd0V6anU5VlV4dmlTdXBKdmli?=
 =?utf-8?B?MDdkL2YyUzRDSUhKcEF4Q1Q3Q2lEbktQcEVKLzBrRlRmN2NQRTdDWlBHSk94?=
 =?utf-8?B?VENVLzJ6Nnk0RVhQL0RaUjJzKzgwR21UbEhFMFBMRnZwVXpmZ2JoNURsakVW?=
 =?utf-8?B?VGNHWkVLOHRhQytrOHZFNU1mbXdyeGMySFEyN0VQTkdlOTUwZWR5Uk8zdDg0?=
 =?utf-8?B?SUVkZU5Pc3JzWjR5T3habjFtZ1d3Qk1IRmNsTDljSlhvelk5MjhESWYrVWNL?=
 =?utf-8?B?Z1A2dFlVbXpYZzBYYTVnbk1ySFdTMzlndmhrcllKWURGWDRBV25QL0xmdHEw?=
 =?utf-8?B?aXZTR0labmxtYkY4cS9mamc3M3QvU05Kb2JONzFTR0NxVnBsaDBtblB4SXV3?=
 =?utf-8?B?MXRFSHB4NGxiWmQzNUdTakdxVDE1MFNQWDFyQXNIdXhYak1PVysxb0ZkU0lR?=
 =?utf-8?B?NmNWRFdoeUd1dUh0Unludkh4UmtFK1NpV21ETVNibWdIbVc1UVFISTdyYVVo?=
 =?utf-8?B?VGJtamU2clI3US9YbVFiRXR2dUJvWEEzTkxYTDZ3ZGxYaGVDTXRsT2tpOEZL?=
 =?utf-8?B?UmFHb3FCTEhUZmNUaDZKZ3pZTEhjdWFRbk1CL2ljTXJmQm5ZcGVYZVpDdk44?=
 =?utf-8?B?VXkyRmNKa3VaNHBMbUd3eXlxWUZBaGpTTHJqdysrNkNMdVdoaHFaV25wc2sr?=
 =?utf-8?B?eHpLUDYxZVdDbDMzS3FFS1NuSW5YQit2RmhVaURPSXFoV2JkeHU0dVNYckpP?=
 =?utf-8?B?SnY1ZHR6UGNRbDA3eTMyMkF6RjFBdUQyY1lOZERXTktFNHVhRWlkVjk5bGJT?=
 =?utf-8?B?OG1laVBMRk9KVHo3bldNeGhUcndJUk5tazVDdStBaXZBdXc0OWg2WTZQUk1q?=
 =?utf-8?B?TG5QNUgyRzIvdFpLZDhZdWdGUnhtbHlWcGJNMHdaNURtRlhLMkQyMU1TOGFt?=
 =?utf-8?B?S3RMdVd1ZUprNDZmRGVxTTROMHBXUHBJeGNOMDdrbjZyMklscGhlYWxLdDNp?=
 =?utf-8?B?dng2V1J3bThiUW5ta0RsUHVaVDdPVTlUVkxadktJcEZQTVFJVmFBdVRyV215?=
 =?utf-8?B?UitaaEhSbmZsSCtiSzJYRENvclJUZTdwdk5Zalo2b1QrNnpWMDV3ajRMdmhQ?=
 =?utf-8?B?RXdSVGNYYzZGR3I0YkFrZ25rQkVTUHROUHUxbytYcEY4M0ZSbG1rYjV6VVBK?=
 =?utf-8?B?eWFmcURXSFpmeUg4bXQ3bjJ3ak8xNjZpR0xaYmhXaW1Ea0NDQmM5UVNkZSs3?=
 =?utf-8?B?UjBBOWlQOTBVZkhsSDFZa0cvLzdJVUNsZDlPem1FUGkySDdMdjd4NDdhc0Qz?=
 =?utf-8?B?S095c0JBOCtpaXRzNERIc2NkTjlRditvU2ZnYjgwemU0VEFQQW12RkhhOU5Q?=
 =?utf-8?B?TksyZHEyQkZrT1N1djczODJoTmlHZmtFYng2eHgvcjNtKzFDSnlTU1VkbDh6?=
 =?utf-8?B?d09zczgvTU00SkJlbzNoR3hDUGhBUkU0anNLMEdrTG02WENQc245S1Vwa2NF?=
 =?utf-8?B?ay9jYjh6L0p6UC9uQm12aDF0MHFoa3FHVHhCa1VmdHlTZlRBMll1M3k5ZEVG?=
 =?utf-8?B?NlZtbEFUMS9uTnZHa3l5S0pKSTBFWlk1YmlUMUpQZkV6S3hqbzAvVU42S1Bz?=
 =?utf-8?B?eUdDOUxVV05tTnZVcDB6aGNOWllNeW5wVXJPVkhzbERTbVVFYkJkNld3RnVt?=
 =?utf-8?Q?quqiIj?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(376014)(19092799006)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:34:22.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e5655-7d11-4745-b4a1-08dde0bfd262
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6834

For each TX CAN frame submitted to the USB device the driver saves the
echo skb index in struct esd_tx_urb_context context objects. If the
driver runs out of free context objects CAN transmission stops.

This patch fixes some spots where such context objects are not freed
correctly.

In esd_usb_tx_done_msg() the check for netif_device_present() is moved
after the identification and release of TX context and the release of
the echo skb. This is allowed even if netif_device_present() would
return false because the mentioned operations don't touch the device
itself but only free local acquired resources. This keeps the context
handling with the acknowledged TX jobs in sync.

In esd_usb_start_xmit() a check is performed to see whether a context
object could be allocated. Added a netif_stop_queue() there before the
function is aborted. This makes sure the network queue is stopped and
avoids getting tons of log messages in a situation without free TX
objects. The adjacent log message now also prints the active jobs
counter making a cross check between active jobs and "no free context"
condition possible.

In esd_usb_start_xmit() the error handling of usb_submit_urb() missed to
free the context object together with the echo skb and decreasing the
job count.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index fb0563582326..4ba6b6abd928 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -460,9 +460,6 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	struct net_device *netdev = priv->netdev;
 	struct esd_tx_urb_context *context;
 
-	if (!netif_device_present(netdev))
-		return;
-
 	context = &priv->tx_contexts[msg->txdone.hnd & (ESD_USB_MAX_TX_URBS - 1)];
 
 	if (!msg->txdone.status) {
@@ -478,6 +475,9 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	context->echo_index = ESD_USB_MAX_TX_URBS;
 	atomic_dec(&priv->active_tx_jobs);
 
+	if (!netif_device_present(netdev))
+		return;
+
 	netif_wake_queue(netdev);
 }
 
@@ -975,9 +975,11 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 		}
 	}
 
-	/* This may never happen */
+	/* This should never happen */
 	if (!context) {
-		netdev_warn(netdev, "couldn't find free context\n");
+		netdev_warn(netdev, "No free context. Jobs: %d\n",
+			    atomic_read(&priv->active_tx_jobs));
+		netif_stop_queue(netdev);
 		ret = NETDEV_TX_BUSY;
 		goto releasebuf;
 	}
@@ -1008,6 +1010,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	if (err) {
 		can_free_echo_skb(netdev, context->echo_index, NULL);
 
+		/* Release used context on error */
+		context->echo_index = ESD_USB_MAX_TX_URBS;
 		atomic_dec(&priv->active_tx_jobs);
 		usb_unanchor_urb(urb);
 
-- 
2.34.1


