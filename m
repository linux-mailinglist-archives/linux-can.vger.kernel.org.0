Return-Path: <linux-can+bounces-4194-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87928B216EF
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FFB1A245BF
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EB2E2F06;
	Mon, 11 Aug 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="r/rxfd/B"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022121.outbound.protection.outlook.com [52.101.66.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874A2E2DFC;
	Mon, 11 Aug 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946377; cv=fail; b=GHSs3MsXxxrQqzzQZT8i7TYUl+x9ztEcinU+81tc6kgLqncLtXCbRZUSewoytYERqyxlh/ieZndxWRU7AJepqsoeMMcnPm0MvHlPhP64gYcakI9Y+aT/8WtbcbdrIUWDgT1JOYQK9VX5MdvhbobSzGoeMv1Gb8DFTDkSrAvPMh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946377; c=relaxed/simple;
	bh=VvLAVFz9bUzDIBGLcIYyEY8MSPP/nL6z6/pWbwsyBiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPckXuLuo3A07q9TsgHdIA2hXnpQo0CrWbxp/QhLGC/LLNMAeBdYmq9I9U/5WmWJRA2CfFg/hoQXvNNcwKfwLnZp1JT0QfL2ECo/ujUGTOn/sMKZNx1OqzNDjIc6v9ouTdMJFc3k0EcnOMJYSGXRvzx7v/922oqk8nBFn1ZFPvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=r/rxfd/B; arc=fail smtp.client-ip=52.101.66.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEiOB+evJljinW3WCdwKn70RldJLHMg8TxZAWV2XIzTeRlP+Wv1bzgajHPm3pFd/l/goSEXNBCvUizXi0Ne+TqnBBo8TULRudSva3gJvUSEpwY2eAY5y4cUKZPuUZm7lo0Z9Sr3NT1Fb3yAp+RwmYyLcPXaiaCBRu0QKY8llhk+TJooRP+sdTeMNAH9MJNMFybZSpXHLJNJj+iLdwbG31wqOT2In7YTo8A9I79CY+4ky2HT21v8BRS+pNnoqqYsLAOH7xN4tTDw2p99MsNL1ov0pmEtwby53qvwGIn/8KalT29KUv4ZoYeP9EDc/hxFp1VLQYAqEYDVINO0ykE8IZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4/OmsnBtuc8Y0xcMtM+NsGY8j2qWIFKAIFBarjRSfk=;
 b=drgJNw+pr2vos/lenknMXURawB3hKbOf5PnvLcxyKRYacnZCgCWqUn9exLZNtAiMvlbAZ02DnFKZ1wFsDXG8tTOTD1qFoJWDL6+ehpGmF3IJ9cVSUNMDeEXPbCU6trB3NH7UXtYj1NSrze7HNGNtyL5/FJA/fuy1xHd032A0l9/KK87miBa8p8KdV0pH8Z422jofvsm/0bGNcKzwQ1Gk8IxgbB+g1zMQmGwb+uO3iAxnQjNTsql0o7oF4GTBqldXVfJO76k3XGOnTFFGD/EDo6u3S7ND6qkDfJoIoJv6rOFov0fiX7S2xMGWLvfzmz0CY8CSyc1yhUDzo4Vb7jGk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4/OmsnBtuc8Y0xcMtM+NsGY8j2qWIFKAIFBarjRSfk=;
 b=r/rxfd/BZdOxp+fbG9Ivz7MARFoIdhbQUFTh3rrn6oG6yVrR98alm156R0E825eYnusW0CFsq6Uor9gTqvhlSjmJnhqOxiPifr5aRQlu2qqi5lStJleOn/n/lOn9GevnrTAh4bB8InSbnQXw7VNlX2oSVO7SQlv8pk6CW+OMciw=
Received: from AS4P195CA0028.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::13)
 by DU5PR03MB10421.eurprd03.prod.outlook.com (2603:10a6:10:523::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:06:12 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::2e) by AS4P195CA0028.outlook.office365.com
 (2603:10a6:20b:5d6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 21:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server id 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025
 21:06:12 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id EE9E77C1635;
	Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id E3F932EC3E0; Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
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
Subject: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with NULL
Date: Mon, 11 Aug 2025 23:06:06 +0200
Message-Id: <20250811210611.3233202-2-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|DU5PR03MB10421:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e716e8-f2c3-485e-332d-08ddd91ae6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|19092799006|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBRNnBpdXFGVVVRZGxEeEIybWNwUHNmUTJhc3c3Mmg5U3dPRENWUFd1ZHN4?=
 =?utf-8?B?VjJieFQ2UHpDak5mWmFVQ0VXMmxQUjRvd2dDSTdrdEM4MHdzaGlPM0owWFE0?=
 =?utf-8?B?VnkyZjdEMTY4Q0NmS0tDNUk0c0I5eW90RkpVdzhQYXJYQThZcDI0MzZad2hM?=
 =?utf-8?B?UTF5MGNGdCt4cFVPQ3pwN05WL0lSK3M4WEREUk85RXEvVWljdEVmaGc1aGNK?=
 =?utf-8?B?VUNobENCYkExWHhQcEIrM3lCRFNaS0VRUGRuemdJVFNCN0pKdHJscWlWZ21B?=
 =?utf-8?B?V25OQ3FZT1NVV2Y4NGxwbnVTdzBQaUJTS1hMNFhOZ013WElrMzhyZ0RuMVE3?=
 =?utf-8?B?MnU0RmxrdFg5b0NnQVphL2l6dVBoeWtWWlRBRVMzRU93NVQxU1lTY2N0YTZ6?=
 =?utf-8?B?S2hES0tnSFNVZEc3MjZ0ZUtJWm56NU51UUJZL2VQUHhLWm9IN0k5WnM0TzVV?=
 =?utf-8?B?Y3VtbEdYbmhWNlQyMDlla2thVDIwMm5TU3MyaFZHajkycWxMYjh6MHNkMTdE?=
 =?utf-8?B?R3Rrdkp2MzBNV0N6SzlHOHFEUHpUTHk1dmIxZ2RabVNvdDlKblY0RlE3YitK?=
 =?utf-8?B?YkFQRG1QU0FSVDNpa3ZMVUpXdlNWQVc2QnpxZmxGQ1lYUE5CUTZoQW1VaHpF?=
 =?utf-8?B?c292RStuc2E0QjZvRlRGckhpUmpkb0NYSnozc0R5WkZGSkRTWDBEQ0wvMGtu?=
 =?utf-8?B?S0ZOYTFPYmpvUCtxTE1GVTNFUVRyL3l6YkFLUGVVdytONm1FeFMwVFA5Szg2?=
 =?utf-8?B?ajhubGt4MU14aXExdlRxaC9uUm83b2VmWG9pNjdpVHhIVHB1SzlDV3F2NDQ1?=
 =?utf-8?B?bzBWRkhOWWh0U3pJSklIU0YrRzVwMHd2SnVhQytJYTJYZ1NBSHBYN2NKVVc4?=
 =?utf-8?B?ekJTNC9xazdNOWZFSW5sSC9RcEY5cTNQV0duSHBxY204dk4xWEVuWHYxT0lX?=
 =?utf-8?B?SGp6K2FGSlQrcDdyckxTWkY1MWRZVWxUK3MzYWVWaU4vUENRZ1BScSs4VnBt?=
 =?utf-8?B?NTJ4TFNhRUtvOTQxNHkxZXoxYTJXR0E0dGkrN1pYN0p3ajFvY0xZbWhYaDdw?=
 =?utf-8?B?VmFNM3ovK1lMODZQTHdkL2JRbU1LRFFqaEZFNStjdEkxd1BjOGFlWlUrMXJh?=
 =?utf-8?B?VEN3di9Nd0x0UWg3N2V2NWd2ck9CQmJCSUpHdUdzOFRCMkJUUUFhMGw4ZG4z?=
 =?utf-8?B?bnc2K0Y3d05IVUJWUGVFZVhSMWpLRkdXdGJZenBkR3NFUjlieWdvQm1UdDJ5?=
 =?utf-8?B?ZkpQckNZSUVkLzVGNmY1cVlOZ0Q2WlJkazIvdXMwRlNjOGtxS2JDTDk3L0ZV?=
 =?utf-8?B?NGVtT3lPNkNZS2x4bmdXZUE4UEJPTTV2cEF6aEVrY3gyekltQ05YUTIzN1U4?=
 =?utf-8?B?SG56TFR6dGpiVmx1SzlIZWZCUi9vL2x0SlFvQ2ZyMnViQnY5UC9MdkpocWxU?=
 =?utf-8?B?QmlRbGVZZWZ1WVBQa3BQRXNJNHN5d2JYeko4MGV4YUdMelNuM3ZUMjlxWWhx?=
 =?utf-8?B?ekhwNlZSRUxoT3RrdUZ3QzVtNjBLRGwyMVhndnJrY0NZZXd2aWJCY0JqT1pr?=
 =?utf-8?B?RWYvZVYzbUJkaFVVdzlSbnordXJreGVqWjllbWJPSlh1eTFjOW1iRkovSXhP?=
 =?utf-8?B?cG8yWXk0QWpSU1ZRKys5bE10a1RsSDFQQTg0WXF3cUR5NXlmcnAydE1JN29F?=
 =?utf-8?B?RFRzc1l6aUdtTUFkWEdlZG5kM0Z3MW5mWU1xL3JDMTFyQjZWN0lpVTg2Tmcz?=
 =?utf-8?B?eGNGNXJWdVhoWTIxdEVtSHBCK0pZOVBTU3lOcVpiWjNIekdtQnBVbzNJQ1g1?=
 =?utf-8?B?LzlHSnpGbUdWMjd5OFViaUFEWXVhYjROWDBHV3JacHBPUG5oNW1ZK3JRdEY3?=
 =?utf-8?B?cmNLZjJ4TGw5SmlxenNzOHFCMTV1KzljL2MxeTlJRVJnWkhRQ0hKdUtZb0xJ?=
 =?utf-8?B?N2VXTEJxbWx6ckhQaFhSZGpCclE0ekZmZGwvZWdZSkRxVmxpS1NoRVhBK1VZ?=
 =?utf-8?B?MmttTGlFVU9xd01uaFZUV2htK3R3d1h5MUZLV3JNbTN3cFR6SFM2NGI3RUUw?=
 =?utf-8?Q?HdrItH?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(82310400026)(19092799006)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:06:12.2085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e716e8-f2c3-485e-332d-08ddd91ae6f1
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10421

In esd_usb_start() kfree() is called with the msg variable even if the
allocation of *msg failed.

Move the kfree() call to a line before the allocation error exit label
out: and adjust the exits for other errors to the new free_msg: label
just before kfree().

In esd_usb_probe() add free_dev: label and skip calling kfree() if
allocation of *msg failed.

Fixes: fae37f81fdf3 ( "net: can: esd_usb2: Do not do dma on the stack" )
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 27a3818885c2..05ed664cf59d 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -3,7 +3,7 @@
  * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
- * Copyright (C) 2022-2024 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
+ * Copyright (C) 2022-2025 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
 
 #include <linux/can.h>
@@ -746,21 +746,22 @@ static int esd_usb_start(struct esd_usb_net_priv *priv)
 
 	err = esd_usb_send_msg(dev, msg);
 	if (err)
-		goto out;
+		goto free_msg;
 
 	err = esd_usb_setup_rx_urbs(dev);
 	if (err)
-		goto out;
+		goto free_msg;
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+free_msg:
+	kfree(msg);
 out:
 	if (err == -ENODEV)
 		netif_device_detach(netdev);
 	if (err)
 		netdev_err(netdev, "couldn't start device: %d\n", err);
 
-	kfree(msg);
 	return err;
 }
 
@@ -1279,7 +1280,7 @@ static int esd_usb_probe(struct usb_interface *intf,
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		err = -ENOMEM;
-		goto done;
+		goto bail;
 	}
 
 	dev->udev = interface_to_usbdev(intf);
@@ -1291,7 +1292,7 @@ static int esd_usb_probe(struct usb_interface *intf,
 	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg) {
 		err = -ENOMEM;
-		goto free_msg;
+		goto free_dev;
 	}
 
 	/* query number of CAN interfaces (nets) */
@@ -1334,9 +1335,10 @@ static int esd_usb_probe(struct usb_interface *intf,
 
 free_msg:
 	kfree(msg);
+free_dev:
 	if (err)
 		kfree(dev);
-done:
+bail:
 	return err;
 }
 
-- 
2.34.1


