Return-Path: <linux-can+bounces-7190-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HEyDlF8vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7190-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:44:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE82D392D
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D7ED308F6D8
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FE42B742;
	Thu, 19 Mar 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mpTUNtRX"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DF42849F;
	Thu, 19 Mar 2026 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959621; cv=fail; b=BO8azyKNbjfwr6ErMgNd5Oz5AWAi3Nnyve28bC6eK6rTnrE/qpMlvkE6GkcSQrHYNBVs+hSzZJi5UzotSFZnwaGvsLGu72gGUsbTK0dtCx2CPBlso4Jn2rZR7pQyqUtACuTeRKcROLF3yP+hIJI1VH42ubnobgXiAiby1CzixTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959621; c=relaxed/simple;
	bh=qzYS5j2ZVmNuh1ubVH4p/XPJcHsH+3hZg3BiOdeFEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqZqTid/rqtnAXgiLlv1O2SNH16EMslBdh6Hk4vXU7rmeAngOTVW1Bu8ZA6AfbcBnnnYiYv5aZUjHcQ5W0J1nuzPdHA4Rm4yf2u/wlFufSNWqw+MqBEJg1XgUzrn0a6Gvv3LLLNkjnIhoC0DMxtIGYps9To0y6g/KXQBpq3PY60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mpTUNtRX; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDvcpnslL37fDNJ4vCwCywpQA0XXNDE8AS8NULVMLKozL6C2fEe3NduUxJBMCsXUCv6S3DKTuq4Q3ZnQ5sDDMkP0k8tURNkebSiQsaSf6GsVobKPmoU6wDv+pomIFBRD/aIXoIWmncjV48rs2S8VypdeFgO/7fKst6k2fHVa/vCKSiGztigUZlylzJ7387QqEQzkwdwBpuYL//ItSbF9Uxot6RdaqIG+qCHNc8HEOGrsWwYBbfCzUc46z70gKpL+ndN5STa6RmOdeL3GnJwsjkWws3jTAk7Vsg+XzRdym8PfDEjeAfJzKTPjOQAfv2qmJ/b63Z4SVPmb8ZDip1XhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC305IUHuX90Klnz80YBcCnVe+f2O6QrwiT52q7VFp8=;
 b=OGfLB2beso/ACHSohXkj8DCP/xYPEtjOGdpsw9Au4L52F0T6TXp48xb6hCCg3BHun+uXTHh6iIL6uJMThLmLfTNzehAlwVBQQLQok5zPXr7eRcM9eaBucoXYFLPeXwVHPBHXs4A3aEo8FoE+rG/BuSQ3R+ydUnni4Y67W4Q/VAUUiDBNkc8Vh7j6Gh2tWjUeBh98LmYr5SfG+JmKqEgCO2lybmyRhvqOXgSG3tSYzylIbfuIcKR7BfVBCh5dyUJ+PK1TgjfLiiRLO9MqvGLOrAPsiIeSbTtfNdhTxQT7CBJATq3c31ZIVUyZtqTvVIg4XgLkJvX1i8dvVDgqVeiR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC305IUHuX90Klnz80YBcCnVe+f2O6QrwiT52q7VFp8=;
 b=mpTUNtRXWwqgL3nyTxfgu9TZLfskIjF4eSwtYN9vbmV5+KinuUMCgI89k0HISiCRKEIFIJHQLpEsqjZEH9UYXyAbr6fMfJ3VI3zvNhEeeLuYDSAewp/TN389Qcdujg/6GM9UISEzThT20r7IdNnsoV+MpqOqEEpQfuzwHjNao9IAY5S7LFTeTO/nFXMFjw/hJG1cDlLn52jXtJoMZLtmzZfZaVRcEM0VqxgDSE4fJoUvoj3wfRi0JGElBYoNYYxYdOjm0O0tuLi98++uCbUBH+MBv7kyJk1H01JkAc8YazGjRcmXTWSDTT6zzpZiVDeniIrR3E/791C1z/9kb4Gijg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:29 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:24 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Linus Walleij <linusw@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 phy-next 22/27] pinctrl: tegra-xusb: include PHY provider header
Date: Fri, 20 Mar 2026 00:32:36 +0200
Message-ID: <20260319223241.1351137-23-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0179.eurprd09.prod.outlook.com
 (2603:10a6:800:120::33) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 822c7698-da91-43b4-b203-08de8607886b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	onCgVTAk70a4M2O4RudA7QSI81iTbBosvmvH0BuoINLGkPHkfGseztUl9DYdc6gOF+ZxBGoFiZgZd321segY3gaaXMvudt1KpHyGXfTI/iCbMJz5SuL6uhrZHp1N5hKzvN8Tk3pI6gaShJmB4vUc7yahFDjAxVxdevYSrIIQLSGLyadwo8Lht4x15HUAiTzy7RlzuY+uerxo2Y+vcqZzxEp3H1Em8OgmCtz9Bc4rso+05FLIzAw/qKgGCvvhzRKuHaptR/S6g5R2hbDFzu8WqPGeym11FIsoEMGwaYEXel757F9S4JBd77b7qa8XHxfCC3H4qbSDybyrgldbigysk536PK9FE3euUC5g25f5Qjk8QL+/8xym/u5Rpi8Qt1P41/wmeXgixXkae01+4SI3T8YpZtUgU+Svd+DmPcNOIg6+y31Mwuxil+DX+/w9rmQObtKRQL2bn4bIZHCeSKxUTFaXqt+migea5l6GGWfzce3tuzwBpEh9K7jzqmwGdANrqEDnje2BBSq2exaFNPq646E3yj3KWREtii0VHA9k/CBXkayPYi1jAdzptXmxYeW1chOfqLLRtpGFhuM2p5jx7OA2xCt2p3t2WSS21bFxYtjE7ImFqvbEe7f1Ro4xqtHeY7uxQzcY9L11/3miOBk9U+swn3kMd2gJHUpMteoN1aGCyGABpCWRgszQVKXf6wSQuiX1r5krP1Dn9D9RoYDFCbW1ylAVuKJX5Ox5TB3opsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FUnHB1ch8GRQ+JG9a3EmUcQfV0h/uqSqo3yETMF0FK0dt4TRYopFnYpoG35Z?=
 =?us-ascii?Q?20pzOwxJchtPKzTrQ5ZHZL7L2nVfLHqLGD30k2Rp+vuhuY6nCSU9bgv19tjZ?=
 =?us-ascii?Q?i2F8BiOsxBAxoOiN/bEnFI+GVz3zpmmAMVi8aPfExDfGXb1/yjQtckuw6DcO?=
 =?us-ascii?Q?1aR5MJHQ90VPE7xgkfbCV3wbeWXm3aOTOHFK4Os2CVOUgzCD/kvCN9pEaL83?=
 =?us-ascii?Q?qEC6c+bJklMGNzF5+y3sesQ34vw4ek3oQir6WyrV6R1nPTVuOK7pzp0E0Dpe?=
 =?us-ascii?Q?yAhHatHgcmmJFKWi1/rzdP0c09rTQiHg7dmAFENring1RgWsALTofHAk+q4s?=
 =?us-ascii?Q?jTwa60AVoq4nIaGYkfezLwCPO0LDhMnHo+y8AGiYOQzow9d5+wXRz4hIraZ4?=
 =?us-ascii?Q?0KAg3ppyT+eeDQSR7oGVDZT8462uKdevmIyPvj4mlH1uKjTiLabKZQ/foCQy?=
 =?us-ascii?Q?PzxzUnbv5fTIv/591m0kK2DEg2zaLNy5xIBTAZkNvlbi9mjemsnp8wHTmFrT?=
 =?us-ascii?Q?ndxc5uSA06ay1xCNdyF8KB9Un/HTbulQpKztppCYJ1Y9o2kF58BSRBU8qdRw?=
 =?us-ascii?Q?0pGW/SiqpT8b575Zr5Ni5thSY0NEpJS6i4qy4vX+4SRChjRUg/3MpTwlLkq4?=
 =?us-ascii?Q?TTC1bWlxhQ+ouccYECdR+5QF3u6PuymYSkItd3L8V4wGZ95Zg352uBGrz7w4?=
 =?us-ascii?Q?m7DBxaSg+wqnTwulOmpcxQ5a9pLDru93NYYHZRwEJrWGHvxLxb9phqxOkqrn?=
 =?us-ascii?Q?DvZ63mQ4W1+TvZMBh3WEplSTUmRvMuWgUGfA+nIpRDrTf9k4tX9Uf043u1NX?=
 =?us-ascii?Q?abDx1mHTBb8mzvwgxxh4m7Xyq11axqtan3ABLR8EWzz6y3jaVoiedsB0mBAH?=
 =?us-ascii?Q?gPGA1k+hctln7HzYEJq5sBvCYmRSk8RTu7Y0d+xKhmn2vlgmYYt+rGNfaz5r?=
 =?us-ascii?Q?YMo1z/dDnR5dDMkTkqBGk3QtkFZS9rrN4xSl8z/pCrtWAGdsjt9PUd2GzxXo?=
 =?us-ascii?Q?TLdD44IaR1aK+aL5XdGu30Y80cts5pN1FzSJ0MOr8H4XyPYOMpmTnpultexo?=
 =?us-ascii?Q?FLHRUQwSZQFiVxQ/ZMyHiVwGWV+i1ts4NRzT2ypNdV9OaUlWbntQgHjCbJ1f?=
 =?us-ascii?Q?et/RqlqaRAehMKvHXirFqDYyMGBKNoe9yOW1Rd1Vjxfe+Nekyo1tLCzFmn9d?=
 =?us-ascii?Q?BNYhqrKQ3ECwGP7cyFnz01CB8avslMZwgTWT7jDpwIFlpSByPvIxQzrOByDr?=
 =?us-ascii?Q?2GOIFumamMaP6/dWSt/6zEh/WVgzqNtPeeRQpHw8qt+mottfMKMEnmUl0DG7?=
 =?us-ascii?Q?82IR8+90U0XOEh93aOaarEDjluaJ9HlPLBp0tgMJNvto2bDsallOJkyw+lza?=
 =?us-ascii?Q?xRNbJv8558wFoLO2Iz+w2aUPM49pvrP3LM7hwpb8YV5KUuRARw6KX8Tl6GD3?=
 =?us-ascii?Q?Vn63bLcffV3Ms6G/SfpXYDAzteLBrE120JtGHyx8rwAL45k+yvmMTV2MZo4c?=
 =?us-ascii?Q?lJ1HbdLH4qJUpq0DvgfOK+08s3qUl4VAKEhKWOxlFo3C90glD5djHqNRu9m6?=
 =?us-ascii?Q?eoT5AVS/Pk6toMuC4yLtmrIyxJpSjTW5jBAqPPqauH7EYA3p5v0Vw1N839mk?=
 =?us-ascii?Q?wtRXuFR26+N1hSo8LRyI8fF6wAoQ/OyOBGROqmk//dydgY71a/DdNqUhI/Ef?=
 =?us-ascii?Q?ymOlXe5OJ0yMjfrvGF7hDxA3nFIiK2Z/tAcO7WiOespEibQdxfz2eDMKIosi?=
 =?us-ascii?Q?fciz7+opGAO3ckiZ4LhpqRdHIdtlxd3qKvhZu8PjSG2/BsEMHnjIoOdYh8R4?=
X-MS-Exchange-AntiSpam-MessageData-1: IvLklBIawi7NFwONAO2fn78ne4kS66zUN5I=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822c7698-da91-43b4-b203-08de8607886b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:24.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTtpjpmeAYysScTqJ2epcGE2g1UlfkrvOc9o8NbngNcANzIvAo2KREjd+gByFgBTwOxfnItkU9vDdbWamNteTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7190-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.949];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: CCBE82D392D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tegra-xusb pinctrl driver is also a PHY provider (calls
devm_phy_create() for PCIe and SATA). However, according to Vinod Koul,
having PHY provider drivers outside of drivers/phy/ is discouraged,
although it would be difficult for me to address a proper movement here.

Include the private provider API header from drivers/phy/, but leave a
FIXME in place. It will have to be moved, eventually.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
Cc: Linus Walleij <linusw@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

v2->v5: none
v1->v2: collect tag
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index c6a51bb21215..6b609bf685c7 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -7,7 +7,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
@@ -19,6 +18,7 @@
 
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 
+#include "../../phy/phy-provider.h" /* FIXME */
 #include "../core.h"
 #include "../pinctrl-utils.h"
 
-- 
2.43.0


