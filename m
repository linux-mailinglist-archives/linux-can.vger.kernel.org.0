Return-Path: <linux-can+bounces-1240-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D80966015
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 13:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4151C22781
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647F18C35A;
	Fri, 30 Aug 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RcXFkpPl"
X-Original-To: linux-can@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2318E370;
	Fri, 30 Aug 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016098; cv=fail; b=I5sHCoQ1VS31GpU8jbFDAWF8ulDbUb1XeLEqOnNoWVlvObCOaixxrW5iz0BFrxdTo0aRXrB+5YsqnyydaZd8NHnUJH5JFlYBs47P2V22Mbm+DV37LnDaLbiBVrryxrA34EnGJd/ITvC8mObRevdT3/ZDS48Fei2Wx0W1ttaGaIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016098; c=relaxed/simple;
	bh=jzXZ0xGoGCQsZaTqDcPRYe7TA/Zfez+WpaQ/8MyEekE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nyC+1posGKIkDm+G1felvX9GuvMffxxNjjy+wQWB9weFaHPGZVaQ4LxIbDUHhuo/Cjup4J5NhjBkMlhlfVKFXTw4JBqJJt4IWg4gckgdS+ts2oyNQ5yM7URcQwOILzGPmDvpWnrbgRXUeisfkAJ/QAqifQ8P4kjSO05urxeXBVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RcXFkpPl; arc=fail smtp.client-ip=40.107.255.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaL6qayyIiyT8tn2D3420DSSAgFX9NfBr1gSQcgBBOFVdWI7id8o4T8TMN7pmshFYKmYBu2buQzBA1y+Q5daBBvwKAQ82+h8vWLjmPk8tV/i4R19QKE+rjHMl/URWg7Pm2A2EfG3/g4+fP2nXdt9JstdgeUec+wrsf74sj2kxxT4pbt1L5etkNRd/aXTLk32u7fF7X4Imfhiz/VfSvGU/Uk1gOeZ1kPnL4KovNLH20CzZHLv9bO+3MlxqQbANM2KlBBgasUdegGu1uFNILM7G4v9uuLLSRZb/y65qShJ6A7jx8NcG4Mzvey24xjtUgVLoWukr6iQGjf0U6bDZUhnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxd2B331TqcmmxZfB0KEF3o2pPqATjDrRXhpsGn3SyI=;
 b=RXMVZYJe3zBfqUraI9/H7dAFANyPLNPy3VgOURf3d1LDqE2ZRRadzeOa+Lf67CEtQ644gFOm01Dd7gXAs7jsSG0BjkcrspciUgUzOyNKwbDtL57R9v+z65rFyi2rwT1y5EQcEVdFHD3c3nd5qaZuD+5wSm9LcavMMRwJQpOIwMWJJncPPPC85jMRNObHw93WYneU0LMjn8dlvzUthYumhWv/fMJkxMm/e2pqfmjZC80I5UL4ScW66Z+pXjl3nUkAtMB9CzcSBb1o7591QGECUsQX+rRaC3f+SmsqH7uRi561UMk5mfolS1NOsXZzzEqu2Z05Xw0l+oobc5d+7Hthqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxd2B331TqcmmxZfB0KEF3o2pPqATjDrRXhpsGn3SyI=;
 b=RcXFkpPltFNJsU1XS8PW3kRcKp0mBGMaP6OTLE4jGDSC5Tiaw4shS+FnXERz5RF5bfVfWZ2OShx+EmIeDuwhKo1W4HUs8rTZlhesxCWothI86EgTZaYwZfDmDf1WNAo9gLjLbzWl5M0KtKYJNYLXqptgHKCohJuuFwgPF6aen/jo39Rk4nvWeLcS6xxEKbPWADzV4XzS7RjvD4TH79kusDdLujbYHYT0g0p4vq5pIwiXDXTbSMpnpolY3yuYdr7EFm3lU14FvPB7/HvvEhQpINo6SkRxFQHjay0rr/YcdWDFOEatj8/BWYdLqG+QyEgdAZO83M1Ef1X/jLt+DgnoIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB5867.apcprd06.prod.outlook.com (2603:1096:101:d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 11:08:09 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 11:08:09 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] can: kvaser_usb: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 19:06:51 +0800
Message-Id: <20240830110651.519119-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ce2b34-bb4e-450d-ca77-08dcc8e40833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HBrxGK1gtEsGw1O2knz9ETQUjyJAybRU2HQvaoYjSVp/I8LerG5NLKPKca1f?=
 =?us-ascii?Q?iGAgU80x5VV62Kcj9rWWooU4QsvERgaQGWIoG69X0EoNRxytDHC2aY04xn2C?=
 =?us-ascii?Q?DtWt369KvPrNx8AfyYCLLFMtu1XKuSX/k0x0LnFXMPAoaRpo3jeYyx7rcUvb?=
 =?us-ascii?Q?ijNADn49Z/IPWx8JG1XeuCDqU/Zkn4vrBT1HnLCaNMDuHekD6fBhy98Zx9JS?=
 =?us-ascii?Q?pM16a5tOaY/083vjzwMVksBv0vFX0Wpy+bg23LOFDB847YBH0MbJaFbag79Y?=
 =?us-ascii?Q?DpJrGulAmGnS0Im1tnNQpqJtWQnjq3OcM3cPln++pv8tbyJtYkDaFq7AzqKg?=
 =?us-ascii?Q?QR9vbtI41BdEWHisCCL/VcvMPVXKhjexY+s+m9r5r174UPxkdylbzsaXwsOV?=
 =?us-ascii?Q?1vSLaxAkCUWA+FEthpAk9lg3MFf6HmfsWS/fubgFyfB/Y7DeJBIg30j+bdBh?=
 =?us-ascii?Q?OqBOB6d55xrXKUGcuENyjz46iPLn9FLpEhD3BE/lTDFjBSkgZubAxfc3XnN9?=
 =?us-ascii?Q?bBYJx97L8D3W5CaQGlPPbCZTbblRPRfpd0CvLyhjPCzDsMx+8CSlTLjgrpX6?=
 =?us-ascii?Q?COKed1EwbdhPaQ19yU9y/9PqMtLqXjqFihCWj1uz7kZe+p+9oFGFLW74GoOI?=
 =?us-ascii?Q?5USiC0cWpm+anunLV+Eho3hEzG7e1bcm+Nd1EKolc3PIPVrtlUDKgNAXuQKm?=
 =?us-ascii?Q?yoxileslavNLFD3UXzbcZCPcQwUnl3ub8IF8NzRe9qtn74Ydf9yhgLSd7CfG?=
 =?us-ascii?Q?X4VJHcMfJ8v6mKzvsESe5DO+o+zsvXQiNvoDxTm1KhB+2wsUZaq4poG/gMGp?=
 =?us-ascii?Q?dP4aGC7BOkvdroa7UxNXPtaT95BnkpvC/3yfiyWELU8WAyhJvrTpG1ZscU1A?=
 =?us-ascii?Q?g0CmsF+iHxLhfUlBeZLRmJS44PVvVrBrZUnuDSS53t+At7uiAP30XFbv1uHi?=
 =?us-ascii?Q?1AP40+KbF3nZnWgp65ZjQq3EbM/3gsrymuDdCpjcobLV5xEUKnb5zl2xBfYA?=
 =?us-ascii?Q?ze8fnvknDPFqKYsaUz2yelypT5S8NWtUVo9AbmteKhSjoPPSjV5phyyjf8Wj?=
 =?us-ascii?Q?vYjnKaV7BJmKSdmL4Lpfi3atpmR8W9kcCc3s1NoJyG7Y5aFEMxrv/AuM52no?=
 =?us-ascii?Q?VkwzHTitNDY7JoucjBCGvjhit3eEPr++Q9QGTcoXIzETn41OqCW8rZI3s8gW?=
 =?us-ascii?Q?EWMo6vCjLc28KCvYitySaMN1q4HXAAlpGGH0CdfPm/VK1wFRth3dfEUEwJup?=
 =?us-ascii?Q?z1+019a/H6LMQu5udZgkqet24ZodlV7IIdZpeHiOTxuAXwu2kqsQ4eis/sw+?=
 =?us-ascii?Q?9i4Cljn3YlqF5Eu7oknfgarhiDEyRIq8X+wXB/G5jVQ8ALgG6lD5BZqHljk8?=
 =?us-ascii?Q?A/k974neD7Mb4/z+riW7vHXHHKCw2F7tgjsdxmS6HSaqhy3Wug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GGJ7f3ZvWC63qVOjvBZ2/NHu2httE4CL5SidghyqIFNXiwKMmR0hqv4xwcAW?=
 =?us-ascii?Q?rMlecKhRdiquVWxkdTw0hYvTIvCtGxGoKHs1x7hIICGCJRIH8eEnOkUzdv6y?=
 =?us-ascii?Q?D2dnem4LqyUoL/F3uUBmMSfK18ow/3geF4tNI7Ew//1rG3JBo2sD+ir9Pby/?=
 =?us-ascii?Q?U0RGNcUSnnTiHQOdkS8FpRrxBjD/NDVp9hEXd3jS/uxZLLXcy+XoexW1WV4e?=
 =?us-ascii?Q?B+53zZQdFT4mh7rHBjHiKWQ+zEXME1fSdHc8rcShl+jNNtKXsRYPvMZ/+T+v?=
 =?us-ascii?Q?pXG3BQFaopophXLENakfGPDWzRkMglx2IcjZRod1cUrBFwK0QK6IIhvFvxNr?=
 =?us-ascii?Q?+exx3A6kXYHjS2XvMWEBXAz6xvv1TmrbhxFHXB9vOuI9UD4fwSyQoo7GYWBK?=
 =?us-ascii?Q?XXh7fwTL24i6qzWLUj+d16S/zZ6ZhbIUT2d0IfvIGhTbTSKJIDW2zw0no5OT?=
 =?us-ascii?Q?efi9z60Smhtj1B6OGtfaIVnFC+qaRXjvwsQD1y2Rcp6wqrjECV5ytE+aOebK?=
 =?us-ascii?Q?h0fgndHYDmOlFFHKJujVQwA6LAR9lt83qi+jt/YHDjHM1KoPKfqI6HYcQ6Bc?=
 =?us-ascii?Q?UZnoS7r5exIiubK5b41f4T7S7lN87MPB29gkuBWiQwMNj1ieJ+bojt/dobS7?=
 =?us-ascii?Q?xTWxYcoU27EjkOJVsXIdn1lW714/0RwiEDVaV8lsD9+k+nq0a+7DC2n0u1Ew?=
 =?us-ascii?Q?am/45VyM6BhrIHYu83vkhW8C7A1dGJklbtmphw5wgMUcLuTXpYRgkaUyTQ6Y?=
 =?us-ascii?Q?dQXggGJrXNadF771yptOAMnLDStVmXPNGxhMjLVgXwNJj71xX2Iu8NeiXnL3?=
 =?us-ascii?Q?eTGxQ8F2NJr4gwhl8bD48qvrfrlcAf+FHVKgfwPBfWeWhRT+j083kH2JEr5g?=
 =?us-ascii?Q?N2myS9KJDaUET87MDm23zCRldJqzmtGyX/jCGwrOLq2OUhWFmq+BmTEj7yQX?=
 =?us-ascii?Q?0ycgA9u2CG+kApIi9103MAa5ngq5fiWYFZxLDdb32nV7gP+1RMJoij/0TSWp?=
 =?us-ascii?Q?GUbug+yllGBNgg+1NB5Y5d1C8858Amjcl53qz1lGEiLiVNzeXFBQKPx/DgOp?=
 =?us-ascii?Q?9L5SPSdjouV4mYssFrb4mKt8fr/55H216e+xCrMpOwAzSu3nYUNDOGjcBAMV?=
 =?us-ascii?Q?dOL+uQ7hJm53dsKjznOFROfdBBTGXOn/LyCwXq3vXIH5rGYSsAaGYmNLLowf?=
 =?us-ascii?Q?twfihkZ5RWcHs5aeNh/LayV+yd4F9ZKmLOEkofHuag5Fhpg8ZjUbwklJTU1z?=
 =?us-ascii?Q?GhpaZ9tLKC2MdK2qJvYhTlRnXxyAUvYZKCaBApWWFEXTLHvNd+K0jP/aP3R+?=
 =?us-ascii?Q?NyubBOMUiJ3UW7F6AvZZq6z80k0Wv7by3tDGKnwc72ITtLFSUx1qeBygqdwK?=
 =?us-ascii?Q?9lgkrmuWj8XObPUzZ74/Xan6ltEoLeOJYHaj0HNfJ4CcLo8NDB/SmTDhNaoB?=
 =?us-ascii?Q?tq60rC9FNOGJQP4B90UnkTi9fn0VHQOsKQX/gyD1/KNbr6urdWBaucfpyHWY?=
 =?us-ascii?Q?jtYdpTZjWxIDGv2LiHZ0kCZ6ujkuc6MPj8nFEg9RJpKyif2N8dacZOdjDIi6?=
 =?us-ascii?Q?ClCzwng1NdMASCW2Ddt7zjjFRpImFl880x8g21p7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ce2b34-bb4e-450d-ca77-08dcc8e40833
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:08:09.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmBq4JIECtlxkOIvzBqy8IklGwHaNZ3OBHflSIhg/elf4XiSu8NCHh55iUFLBnX1u6WvlmjnAMSRTqQiKjKgkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5867

dev_err_probe() is used to log an error message during the probe process 
of a device. 

It can simplify the error path and unify a message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 42 +++++++------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 35b4132b0639..bcf8d870af17 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -898,10 +898,8 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	ops = driver_info->ops;
 
 	err = ops->dev_setup_endpoints(dev);
-	if (err) {
-		dev_err(&intf->dev, "Cannot get usb endpoint(s)");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
 
 	dev->udev = interface_to_usbdev(intf);
 
@@ -912,26 +910,20 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev->card_data.ctrlmode_supported = 0;
 	dev->card_data.capabilities = 0;
 	err = ops->dev_init_card(dev);
-	if (err) {
-		dev_err(&intf->dev,
-			"Failed to initialize card, error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err,
+					"Failed to initialize card\n");
 
 	err = ops->dev_get_software_info(dev);
-	if (err) {
-		dev_err(&intf->dev,
-			"Cannot get software info, error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err,
+					"Cannot get software info\n");
 
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
-		if (err) {
-			dev_err(&intf->dev,
-				"Cannot get software details, error %d\n", err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(&intf->dev, err,
+						"Cannot get software details\n");
 	}
 
 	if (WARN_ON(!dev->cfg))
@@ -945,18 +937,16 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
-	if (err) {
-		dev_err(&intf->dev, "Cannot get card info, error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err,
+					"Cannot get card info\n");
 
 	if (ops->dev_get_capabilities) {
 		err = ops->dev_get_capabilities(dev);
 		if (err) {
-			dev_err(&intf->dev,
-				"Cannot get capabilities, error %d\n", err);
 			kvaser_usb_remove_interfaces(dev);
-			return err;
+			return dev_err_probe(&intf->dev, err,
+						"Cannot get capabilities\n");
 		}
 	}
 
-- 
2.34.1


