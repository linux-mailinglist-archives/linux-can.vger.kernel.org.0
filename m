Return-Path: <linux-can+bounces-4285-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AC8B2FD3F
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B0D189E0F7
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE162D8788;
	Thu, 21 Aug 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="G0jjUIge"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020100.outbound.protection.outlook.com [52.101.69.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F61DBB13;
	Thu, 21 Aug 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786871; cv=fail; b=asOPvMUo32YKEQPFFi2RfJrcxXhvp8xlpHLKsYmpKncxzInzBsPZ8UEKiaFiecbIbJMCO0qnlMUy9BqXNHlSjefXBhHmpkzJ8Eqk0m3ZSziVL7SICriZMqGewrd0TmDAIVLbP69YcpRxxtkKbRWU3GVDs3kKWful/07sgv4OzhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786871; c=relaxed/simple;
	bh=DS7gjzgEjNG0sCw6BVY0EXCzJWFRmndX8+TpagT/YVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+WN3R7cLT3v0fuYNfyJrEULcPD+2DtF/bRp7nnwiCCM9OWTLLiFamoX9ldMLd1AgDbhQ6g0l8sIdG46F8yskBBl34dZb0tsyjsoCKQISUrtBcLTmU1egPYREh5//sERMis0rKrpG3m5TM7Utk9Z7CP/cjJubTU4HvnEf3Zvt0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=G0jjUIge; arc=fail smtp.client-ip=52.101.69.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJEDvbRoU/JiIV7aQPMEOlKrr+9PBGGj+Z5Y4rBKphUuY+aiGSQsyAhAR19hnoMR5U3HcwBAUcExEb1LFOOdAjLmBL028QWx4n0eqfT8KwsJO/RocKNti4hbpyhXb+DaEtjHqqY97tbsZS+LSV1Hxhd1j4UOTikp15Vi9bLgzBbS9bG/rVk9tc4pMFURHQM9DdY77ILNJq8YyTdFU9Xu0J1s1yazm/IDXGgWPu0+DXV0/A1wqZeE4DLBL197h/PplyiIM1Lo4Jhr0ePys7MsXWrYn43C6ZqdQv9L80Ylu0ggBZB4/y1PLF1W5+QmQC4S/ynS/kloK6ichEKYyLCatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkW81A3VT/A2wrQn91KlNdIcVAfEB9583IE62X5OJ84=;
 b=DEg3m/LZMKkTMfAp3DyEy6MbvtPM2coYgWSqtb/P6lFhO7Ki+bmcZIur7/X9QX7WoSIxSTQH5ZVECIqJyPb+IF8k2nRhRUbY/qJQnPhWRHMLvirhCERMLXLyz5NdS7iTDhSD0MMvvlpi7vMBn1edFAXm1E0+wjlTetiC4RoYktDeWeEhIAkBoO5qajlRFE3IeV/eIOSOcGulzq3Brv/Nj0A7B4PNm5UM9j8ktPfG/YaNDWzlTuUGwSOH7WCLMaqIDwXhRBR3V1jOuye6tX9XzEaYr9pTggBRbDXyvKGaF6Ig87it2200YFDSi4K3MZbZFrWoMe5WkGEwhQTzDt2TdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkW81A3VT/A2wrQn91KlNdIcVAfEB9583IE62X5OJ84=;
 b=G0jjUIge7uF7w3Q2h90+8sXwqlDStyIn1etdFfkV5h0kSL27W9xp5ZpUSD3Tgr4BH3fk5y7+wZxtsMJ6INAWO2KwxXrNyiHwgGz8CUmuzl5PVYsvmKCEIDznP+EfQ3oNHFWAfeWixr/SI1VJOMLCjOR5fS98XRjOqo+N14HHQ4U=
Received: from DU2PR04CA0223.eurprd04.prod.outlook.com (2603:10a6:10:2b1::18)
 by VI1PR03MB10079.eurprd03.prod.outlook.com (2603:10a6:800:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 14:34:24 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::ff) by DU2PR04CA0223.outlook.office365.com
 (2603:10a6:10:2b1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 14:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:34:22
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 959487C16CD;
	Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 908D92EA436; Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
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
Subject: [PATCH v2 4/5] can: esd_usb: Rework display of error messages
Date: Thu, 21 Aug 2025 16:34:21 +0200
Message-Id: <20250821143422.3567029-5-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|VI1PR03MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f79837-be7a-4424-308a-08dde0bfd259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1ZGTkxRalRzbmR6Y1EyYVhFVld3WW16RUVUeFM4RHpZTS93UCtpdkoxY2o4?=
 =?utf-8?B?YzlrMzI1Mk54K3lHM0xNZHJjSXk4a25LWWVnSHdNaklpZ2Y4bkVSOVllOUpO?=
 =?utf-8?B?YVdyWnJndnBaTUJWbEV0SWRPKzVIZXBFc2RRbFFBdXVLMWc5WFUzRENWOGZl?=
 =?utf-8?B?eWtSZmFXWkhkaUt1aGlteVg3RU81M1ZXN1NXaVRGVElYOThrMDNwVjlSNDBx?=
 =?utf-8?B?NjU2UUpRcTV2WkZsTHl6MERDbEs1bWhLUUY1MnhWRkZVYXRlamdvRjVYYWto?=
 =?utf-8?B?eVI0UWFrUC9YZ0pNRmpxd01pTCtGV0U3d3crUVBBaWgrTW9UeTd2Z2RmVE81?=
 =?utf-8?B?MnN6SHZRZFNmclNVeldncWxuc2xNZGRKdmxJR1REL3VWRWxyaUZyT1NSLzJN?=
 =?utf-8?B?Y291QjNqdW9TeHlhMWRydFg1cjRtOTdRQ1B3YjJHVkc1OXJWR2hwRDRvM1lY?=
 =?utf-8?B?dXpRSzB4TUs5WjNvbU55eGtZaXhHT1VERGlHMWxuRDVpejZKSFZ3ZE9GNVl6?=
 =?utf-8?B?NTJTMzRTbmZURGZ3dVZ0TTg0enVnTW0xQ1Y5Rm9iYUJURzdibVdHb2kvbzJj?=
 =?utf-8?B?a0tQVFRHODNqMVllNHhhRGdhMk9wT0t3dGhTaTZycTRUdzY0TVBwejVjY3By?=
 =?utf-8?B?ZGZZTGJtbENWdXFRZFl4ZDZqNEcxbnhGaGJJdjVKNXNKMktBNm4ycUhRRStv?=
 =?utf-8?B?ZW1FSVJZa3dvbjNDNXUzUktHckc2SlFFSFZ1NVFtNmhFVVZpdFY5azMwekd6?=
 =?utf-8?B?YzFzN3RKeVIvdC9Ba0w3SVBZRW43QU9XM1lhVGpDcTdJZDdQQzlsUWc1M3NF?=
 =?utf-8?B?NVZjVE9hNkNjanQxbnJnYUV6NlFTK0lkRTl1L0lxK3hxMjFUdFhCYTVGZGpm?=
 =?utf-8?B?d3VBVFFkVjZYWGNaY3hrRVJTeHg4eTloTll2djZUb1U5VG82eWpva3Z1elNn?=
 =?utf-8?B?NktKcG1LNVVFZGJYeFJQS2t0bFBvcEI2M3dSOXlVOHVVa3lkM2cvV2E0aXI4?=
 =?utf-8?B?VTNFZkFzZnlSSkFobi9BQi9WRVI3dVpUbFFYSktlUUdacGxvem5QVkRRbEZ4?=
 =?utf-8?B?RUVoRWVGMGZlRXNaU1NVK2JabEpLTTRwWll2MkZCUmZJWlMvYk5WRnRoWEYv?=
 =?utf-8?B?ZEgvUzh0WjJLNHFWb1pvc050MTJxbjVhQlpSaFMzZ1FjRjZQOGxGL3NWZWl3?=
 =?utf-8?B?NjhxMGltemF2ZGE3TDI0Vkx4K0FnZHN2Ym0wTklGM0JhVyt1aDhmai84NkZC?=
 =?utf-8?B?dGVlMURyNW1HaGRzWko0dEhKdFRYWk9KZXdmY3FiUmRQYkd2d3cvMEJaUUJj?=
 =?utf-8?B?N1BvZENsRkFqU3lwb2JmRU9CWExCUlU3bWcwUnNuOXhlQjczbFdCY1MwQkpU?=
 =?utf-8?B?N2MyaGVYaEg3K1pMTTYwMGJ2TFNRMERuZnVMcU9VNm1lWmthNVhnSXN3dWxF?=
 =?utf-8?B?bnp2ZkFKa0pvZDErd3hCdVM5T0Y2ZmNQL0tsV2tNU3ZxOTRFWXFrbVdQZm1T?=
 =?utf-8?B?VktiS1kwMnp6bUtQRTJtMmNNWDZ1YytLRmxRWVVxK2s1NDcxdXNLQ2RHRGtr?=
 =?utf-8?B?aFlXcjFUdUlUbnJaT3RaNkdUWTdLM0dUMU9GMkNRT25SdFUrc1RFK2M3UnFw?=
 =?utf-8?B?bWFnYU9PdHlmaElVRDEwMjk0TFlHZHBCR3RRQjBuUHEyV3plMis2L1VBb1VG?=
 =?utf-8?B?Sk4vdkhuMEp2Q2VYWmtWcUVUdVpMeXR3TTNSZSsxOVVnRTI0emttbEVjM2Z1?=
 =?utf-8?B?OVBBR0RYTnI5T2p5dWRpZzNhaVRySHRRanMzaEE3TnNuK0R4anI0RFo1Rmkr?=
 =?utf-8?B?Q1V4SHpBeEErWGM5THdFWEo0RTVBMWx5TVFPWnBMM3hoWDQzV1hxYkdnZU5u?=
 =?utf-8?B?TWVhdWdmWndnemJBcDl1ZnRBNmM1Q3p3SDVudGV2RnZHSXRaa1ZaUnc3TTlF?=
 =?utf-8?B?V0dxclBHdjdXVGNzMFZDMzRSVFh0QlByNXpWRVljdWZXYUVrNlhlaDE2WHRh?=
 =?utf-8?B?QzBIRGdpOE4venpLaVVpRFpNeTBiMEswVEc0ZldRVGFrNlVKemdWYzJlaWVI?=
 =?utf-8?Q?glzzO0?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(19092799006);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:34:22.7838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f79837-be7a-4424-308a-08dde0bfd259
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB10079

- esd_usb_open(): Get rid of duplicate "couldn't start device: %d\n"
  message already printed from esd_usb_start().
- Fix duplicate printout of network device name when network device
  is registered. Add an unregister message for the network device
  as counterpart to the register message.
- Added the printout of error codes together with the error messages
  in esd_usb_close() and some in esd_usb_probe(). The additional error
  codes should lead to a better understanding what is really going
  wrong.
- Convert all occurrences of error status prints to use "ERR_PTR(err)"
  instead of printing the decimal value of "err".
- Rename retval to err in esd_usb_read_bulk_callback() to make the
  naming of error status variables consistent with all other functions.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 40 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 98ab7c836880..8e6688f10451 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -9,6 +9,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/err.h>
 #include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -487,7 +488,7 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 static void esd_usb_read_bulk_callback(struct urb *urb)
 {
 	struct esd_usb *dev = urb->context;
-	int retval;
+	int err;
 	int pos = 0;
 	int i;
 
@@ -503,7 +504,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 
 	default:
 		dev_info(dev->udev->dev.parent,
-			 "Rx URB aborted (%d)\n", urb->status);
+			 "Rx URB aborted (%pe)\n", ERR_PTR(urb->status));
 		goto resubmit_urb;
 	}
 
@@ -546,15 +547,15 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, ESD_USB_RX_BUFFER_SIZE,
 			  esd_usb_read_bulk_callback, dev);
 
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval == -ENODEV) {
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err == -ENODEV) {
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i])
 				netif_device_detach(dev->nets[i]->netdev);
 		}
-	} else if (retval) {
+	} else if (err) {
 		dev_err(dev->udev->dev.parent,
-			"failed resubmitting read bulk urb: %d\n", retval);
+			"failed resubmitting read bulk urb: %pe\n", ERR_PTR(err));
 	}
 }
 
@@ -579,7 +580,7 @@ static void esd_usb_write_bulk_callback(struct urb *urb)
 		return;
 
 	if (urb->status)
-		netdev_info(netdev, "Tx URB aborted (%d)\n", urb->status);
+		netdev_info(netdev, "Tx URB aborted (%pe)\n", ERR_PTR(urb->status));
 
 	netif_trans_update(netdev);
 }
@@ -854,7 +855,7 @@ static int esd_usb_start(struct esd_usb_net_priv *priv)
 	if (err == -ENODEV)
 		netif_device_detach(netdev);
 	if (err)
-		netdev_err(netdev, "couldn't start device: %d\n", err);
+		netdev_err(netdev, "couldn't start device: %pe\n", ERR_PTR(err));
 
 	kfree(msg);
 	return err;
@@ -896,7 +897,6 @@ static int esd_usb_open(struct net_device *netdev)
 	/* finally start device */
 	err = esd_usb_start(priv);
 	if (err) {
-		netdev_warn(netdev, "couldn't start device: %d\n", err);
 		close_candev(netdev);
 		return err;
 	}
@@ -1023,7 +1023,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 		if (err == -ENODEV)
 			netif_device_detach(netdev);
 		else
-			netdev_warn(netdev, "failed tx_urb %d\n", err);
+			netdev_warn(netdev, "failed tx_urb %pe\n", ERR_PTR(err));
 
 		goto releasebuf;
 	}
@@ -1051,6 +1051,7 @@ static int esd_usb_close(struct net_device *netdev)
 {
 	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	union esd_usb_msg *msg;
+	int err;
 	int i;
 
 	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
@@ -1064,8 +1065,9 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
 	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = 0;
-	if (esd_usb_send_msg(priv->usb, msg) < 0)
-		netdev_err(netdev, "sending idadd message failed\n");
+	err = esd_usb_send_msg(priv->usb, msg);
+	if (err < 0)
+		netdev_err(netdev, "sending idadd message failed: %pe\n", ERR_PTR(err));
 
 	/* set CAN controller to reset mode */
 	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
@@ -1073,8 +1075,9 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->setbaud.net = priv->index;
 	msg->setbaud.rsvd = 0;
 	msg->setbaud.baud = cpu_to_le32(ESD_USB_NO_BAUDRATE);
-	if (esd_usb_send_msg(priv->usb, msg) < 0)
-		netdev_err(netdev, "sending setbaud message failed\n");
+	err = esd_usb_send_msg(priv->usb, msg);
+	if (err < 0)
+		netdev_err(netdev, "sending setbaud message failed: %pe\n", ERR_PTR(err));
 
 	priv->can.state = CAN_STATE_STOPPED;
 
@@ -1351,14 +1354,14 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 
 	err = register_candev(netdev);
 	if (err) {
-		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
+		dev_err(&intf->dev, "couldn't register CAN device: %pe\n", ERR_PTR(err));
 		free_candev(netdev);
 		err = -ENOMEM;
 		goto done;
 	}
 
 	dev->nets[index] = priv;
-	netdev_info(netdev, "device %s registered\n", netdev->name);
+	netdev_info(netdev, "registered\n");
 
 done:
 	return err;
@@ -1390,13 +1393,13 @@ static int esd_usb_probe(struct usb_interface *intf,
 	/* query number of CAN interfaces (nets) */
 	err = esd_usb_req_version(dev);
 	if (err < 0) {
-		dev_err(&intf->dev, "sending version message failed\n");
+		dev_err(&intf->dev, "sending version message failed: %pe\n", ERR_PTR(err));
 		goto bail;
 	}
 
 	err = esd_usb_recv_version(dev);
 	if (err < 0) {
-		dev_err(&intf->dev, "no version message answer\n");
+		dev_err(&intf->dev, "no version message answer: %pe\n", ERR_PTR(err));
 		goto bail;
 	}
 
@@ -1439,6 +1442,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
+				netdev_info(netdev, "unregister\n");
 				unregister_netdev(netdev);
 				free_candev(netdev);
 			}
-- 
2.34.1


