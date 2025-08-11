Return-Path: <linux-can+bounces-4197-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B6B216F8
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 23:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11FF46478C
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E02E3AE6;
	Mon, 11 Aug 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="mv/5okgB"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022130.outbound.protection.outlook.com [52.101.66.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BC2E2F02;
	Mon, 11 Aug 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946379; cv=fail; b=Nae9ZjPitITeiXjTnRO4vWKzofaMjy9MBiiiFZVqsIXW7jWT07AjgzP8ZY0asnWAWIKmJJt0GDC8PwfkUMdiJs5au8aGeDYXwC829CXA6Iv0OGeiQWLuV5UTMczAPr+SvwAv/OeLdf7lJHTruZLCshpTeYmo8FGK5WnSeE19Ub4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946379; c=relaxed/simple;
	bh=Q5ZBauqYTT/cgN0beWCwNj2KufPgMg7A+o1hfXgoSks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFPmZYrGcQFOzGn0egQZwalOVaeVynSSsJZBUoLhY2XpR5UCY9FXlxVQTPNPletsXup4q75/2OZeM5hzJCd6Aq0GuxXg/m5Ii0UoGIEnTvEyRkaAN/tM584q93FGfQwcfyy0PmSX4eua3SokBdQ4YSHD5jmTjT6kSSIhCNWsgEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=mv/5okgB; arc=fail smtp.client-ip=52.101.66.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYw0vEDQ1RuwEwaJg8z0BPI4ddkcc0Mm3OCWjDdPUyXHaW4UV68CLbDNTufXFIMkI76BZ31N3yH3pNDgQ4qQbVUdLuKxn8Zrr5T9CWPsQvQT2cgjLw3LJOYfKEwG6F3GSnu1QfEPUYw27qHHQBcDriQE6ZTnY2aeDc8GL7Nd1HZBF9mbnZysR71aSbl4XvODYmbZdw3mSpIR1R4jZAXEpUJI8Z+p/mjIp/j7Ly601XaK9+INV+ryp8qBHEJdZyKySQ2fK2f8M9dlOcVKtZK4/CuV9T1rgcGOm3Caj+iO3qxnaHF7ljSFeHFzuCGCoufpW+TJ4VKZkmzjYO6wH3tUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbi+DxdYo81CJ9iJZKQdXvP5u+HDJWzYMVM6eEWvWbg=;
 b=ZGDBu1f4sg41eT27w9YNHWpxlB62cX1CQWFz5cMLNUY8GEFT3Zm7c9jKUMLJcPxMTYR0f40PWw2lW/5KvI9MSmHjWwfuu/jAM9qDi++iH4pktdtNkBJRPPiwQpR2+vO3rU4iD06M9fC8mIMKwEO/w9DN2romM9HvScylRLvVZwYyvgbHLWBLpSPdQ0tL0XnZ7X4+nP5c59pJHPUdCSJPt1KvCIGI/RRAVVhQiVf5GttywElVGkeDGKgkMZWzNFmqbV/KA5dYpI8ihTCLUw/NEZl3bYks+Tp3ab2PmQAAvFn2deTVnyOIvS+jQvTeLVU/iBopnEWgREKPw9zwgorJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbi+DxdYo81CJ9iJZKQdXvP5u+HDJWzYMVM6eEWvWbg=;
 b=mv/5okgBceHYZkrJRK+RFhBVWLvxVqTHYgWifJ3whokT1vZaisLCN2flYFOyzHQ6XY97oqfjLy5uyf6jbN4Q9t/vLI1G/OL4UfErTJbLtxYz2PJ61nqT+75ssNwakeIjjoU74zxAaA7blEHXm+lDQ+IObFTczdMAOsljohTYSGM=
Received: from DU7P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::31)
 by AS2PR03MB9564.eurprd03.prod.outlook.com (2603:10a6:20b:597::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:06:12 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::24) by DU7P189CA0017.outlook.office365.com
 (2603:10a6:10:552::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 21:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server id 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025
 21:06:12 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 024947C16CE;
	Mon, 11 Aug 2025 23:06:12 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id F21E02EC1DC; Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: Simon Horman <horms@kernel.org>,
	Olivier Sobrie <olivier@sobrie.be>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	netdev@vger.kernel.org
Subject: [PATCH 5/6] can: esd_usb: Rework display of error messages
Date: Mon, 11 Aug 2025 23:06:10 +0200
Message-Id: <20250811210611.3233202-6-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811210611.3233202-1-stefan.maetje@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|AS2PR03MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b5cda9-18f6-4db3-12fc-08ddd91ae6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|19092799006|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmpkcWpnYm81TkExYjMyV25xZEVMbDU3MzBlOG8wVE4wN1pIa2NqbE9YWDd3?=
 =?utf-8?B?QngwRWxpVksxczFySnpyTE8yRVZBS1g5dWM1RmJoWjZWQTV1bHN3Ym9mYk0x?=
 =?utf-8?B?YXd2Q0JVcVZWcmViUXFuY0hiS3BEcktMQVpJVEE5b1BxS0J1b1pya2FHZldn?=
 =?utf-8?B?ZXlDTm8rT0NvMUpsVENVMG5uU2hXSkNiVFJISTR2d2VVZkNkVnF0NGMzcjJF?=
 =?utf-8?B?YlplTktsQ0hXK0hDRDd1UHRsZ0VvWTdGTGFicVZnM3cxQU5SdWYwVUFTd2dB?=
 =?utf-8?B?KzJDVFBHY213a1ZoTkZQZm8yeXRRV2l3cy84dXVXZW9PbXU1a1c2d2wvblNV?=
 =?utf-8?B?d3B1cTBONHdtTGdWajU0MUJEZmpJMVVPcGo2aFA4TlRmV0UwYkRNcVkzZHJS?=
 =?utf-8?B?U1ZWaWUyZ1N0a1lZSjQ1Yy9WZnV6RVM2T1B0dnVIZDVlbWV3WUwxS1o2MWhM?=
 =?utf-8?B?cFhtY0dQTEF2R0JpcEVCMlBoeTV2dzlvcHArOUVUL3BWNmNQTWphWnBWSmtP?=
 =?utf-8?B?ZFJ3aDN6Rmt5Nnk5RjNYTkcxbEN2Mkp1U0tTNmtldTh4OE0wak1qc3dqcGF3?=
 =?utf-8?B?WnhYTGZuQllNZTVTQ2t0azlUdnR0RWM3YlBPbGxCQmlRdSs3SGwzVGR0bmlh?=
 =?utf-8?B?Si9GVFFQUjNBOW1CM3h4N3k1cVAzM1NZdHlHNDMxdVpSeWcrWFprcHlQbTVY?=
 =?utf-8?B?V0lsQVllb1prV3d0M2NuS3BWZE1GL29XSVlTNmx6Wmd1STQyendESXIwdEtV?=
 =?utf-8?B?dWFjblh4WWErbk12TGdCeGVwU0NpYWoxOGZKNk92eDRmdmVBL0tVMkNXTWZz?=
 =?utf-8?B?YWswUWd4L3dMWGVrdnB5TWxBdmh1MEN0aWFBajRqdnZuVUp5WGJxMGFrYXZw?=
 =?utf-8?B?ZG4vUG04Tk8vTXFBNnBWT2cwajVqSjNBNmpGNGM1cjI2R0RURlg2b09taWdR?=
 =?utf-8?B?YW5jT0JJUXpaY3ROQk5seHg3elRWSGd0YldHNFRmL2RWS1BZcVpocGlVbk5C?=
 =?utf-8?B?MUlkb01NOGFodGRHMmFUTi8yejVLSGM3N3pIb25RdlFCNmQwMzFOSXMwM2Z5?=
 =?utf-8?B?RGJsbGwvbVN4aUU1aGc4a29wekNtUDBncGhnR2w3dTdXTHNxOUNrczZ6aC8z?=
 =?utf-8?B?dkl6NUZPYWF4c1N0OHJLdzVXQzZCVzlhWnZHbCtMQjQzeGRGbmlhOC9pWDJ2?=
 =?utf-8?B?SFpNM0FlNHFrYXF2WXlxUFlFK3U3L1FWdTkvYkwyVU8wY25TcHFjeHdjejJz?=
 =?utf-8?B?VHFLQm9RMVNpVmw3U3oyWGlNeHdOVXU0eG1YdTI5Nis4VFduaDlaTytyaHlH?=
 =?utf-8?B?bS84UjduenBrTStMMXBYb24rd3JiNGZIa0lDQmwyeFl6amUxMmRQaWlsak5M?=
 =?utf-8?B?eFlFTmt6OW5vWjd2UmdYSGpML01CZ1ZHWnVrdlhEYnZuRFc0MW5wR1UzR2pk?=
 =?utf-8?B?TUpOaTFpeXpnaU55a0lFQmJWSmx6dEhBbVMxQlhEc242bm1xdXlrVGdicW1U?=
 =?utf-8?B?alJoRkVhOFhXeThYSFZPT040QWxrbEx3WDBmSEQ5dFI4UEtieWFNMFh1NHV3?=
 =?utf-8?B?ck5nSUdscFBFRTh0ZlVjdkpzcWVQNDhIM1FrN0Z6RUlmOVladEJaZmtRM2M2?=
 =?utf-8?B?Q1dtTklOUTRjUVZ0YW9jOFFiWkpGV2JoWCs2UHIzVkNDdzU5RFhUVDBkanhn?=
 =?utf-8?B?bVl2NEE3ODVxT0NOU0JxNG0xOVR2VW05T09MMWM2NkoyN2V5MVFTTWlyTFVs?=
 =?utf-8?B?S1BnaTAyWWxyU3UyUWZTYlAwTUwvekw2eDJjaG9jUVZleEZzYlM4cFJhMjlk?=
 =?utf-8?B?V2w4amExcG8vbS9sVzNrSFluL0FrZStYb3dQMkJLYnpiQm1rY3dTNG5UajZr?=
 =?utf-8?B?UUdubmVxNlc5RmxZVnQrZDZKNmNlMkkzQ2J3WS92cVBMMjBZYjR3dHhPYW9L?=
 =?utf-8?B?L3Y3M25kMUczRThoOXl1RCsxeGpTOC8wbHNpaXJPUkVPUXYrbGQyZC9BclBG?=
 =?utf-8?B?YXBPMnZWcGIwWkUxbHRVRTB4WmVtVDJDd2J6REc2RnFpcDBzamZtWndHbS94?=
 =?utf-8?Q?F48wdU?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(82310400026)(19092799006)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:06:12.3169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b5cda9-18f6-4db3-12fc-08ddd91ae6fe
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9564

- esd_usb_open(): Get rid of duplicate "couldn't start device: %d\n"
  message already printed from esd_usb_start().
- Added the printout of error codes together with the error messages
  in esd_usb_close() and some in esd_usb_probe(). The additional error
  codes should lead to a better understanding what is really going
  wrong.
- Fix duplicate printout of network device name when network device
  is registered. Add an unregister message for the network device
  as counterpart to the register message.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 41ff453f87b8..3c348af566ec 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -882,7 +882,6 @@ static int esd_usb_open(struct net_device *netdev)
 	/* finally start device */
 	err = esd_usb_start(priv);
 	if (err) {
-		netdev_warn(netdev, "couldn't start device: %d\n", err);
 		close_candev(netdev);
 		return err;
 	}
@@ -1037,6 +1036,7 @@ static int esd_usb_close(struct net_device *netdev)
 {
 	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	union esd_usb_msg *msg;
+	int err;
 	int i;
 
 	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
@@ -1050,8 +1050,9 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
 	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = 0;
-	if (esd_usb_send_msg(priv->usb, msg) < 0)
-		netdev_err(netdev, "sending idadd message failed\n");
+	err = esd_usb_send_msg(priv->usb, msg);
+	if (err < 0)
+		netdev_err(netdev, "sending idadd message failed: %d\n", err);
 
 	/* set CAN controller to reset mode */
 	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
@@ -1059,8 +1060,9 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->setbaud.net = priv->index;
 	msg->setbaud.rsvd = 0;
 	msg->setbaud.baud = cpu_to_le32(ESD_USB_NO_BAUDRATE);
-	if (esd_usb_send_msg(priv->usb, msg) < 0)
-		netdev_err(netdev, "sending setbaud message failed\n");
+	err = esd_usb_send_msg(priv->usb, msg);
+	if (err < 0)
+		netdev_err(netdev, "sending setbaud message failed: %d\n", err);
 
 	priv->can.state = CAN_STATE_STOPPED;
 
@@ -1344,7 +1346,7 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	}
 
 	dev->nets[index] = priv;
-	netdev_info(netdev, "device %s registered\n", netdev->name);
+	netdev_info(netdev, "registered\n");
 
 done:
 	return err;
@@ -1383,13 +1385,13 @@ static int esd_usb_probe(struct usb_interface *intf,
 	/* query number of CAN interfaces (nets) */
 	err = esd_usb_req_version(dev, buf);
 	if (err < 0) {
-		dev_err(&intf->dev, "sending version message failed\n");
+		dev_err(&intf->dev, "sending version message failed: %d\n", err);
 		goto free_buf;
 	}
 
 	err = esd_usb_recv_version(dev, buf);
 	if (err < 0) {
-		dev_err(&intf->dev, "no version message answer\n");
+		dev_err(&intf->dev, "no version message answer: %d\n", err);
 		goto free_buf;
 	}
 
@@ -1435,6 +1437,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
+				netdev_info(netdev, "unregister\n");
 				unregister_netdev(netdev);
 				free_candev(netdev);
 			}
-- 
2.34.1


