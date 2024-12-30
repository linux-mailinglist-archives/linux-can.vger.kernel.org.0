Return-Path: <linux-can+bounces-2513-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4E9FE70C
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 15:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0303A1947
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224C25948F;
	Mon, 30 Dec 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="HjwNwtRd"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2118.outbound.protection.outlook.com [40.107.249.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D171A7AFD
	for <linux-can@vger.kernel.org>; Mon, 30 Dec 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568871; cv=fail; b=Ak8Ca1GEecOSSCdMTdh7OAqg//mVtZ6PbpZNmB5SBfM3MVnZ+behwJ/T9HCcBTXw1GWOIVyPj9oA9I8W1SmOxVhP6G9JRXk7nguSVxW69K+Ve84g5nIaOgSBMc6YDZ2iAxqPZEaeCenSaq6cTVLRGrSTE4ZIoxEO4lOGwu1luS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568871; c=relaxed/simple;
	bh=ZYj0ABYzCiHZIALGGovL9z2t5KMfDZh+idGjUVDG+ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhSs8Bynml2Lv1fLpwi+IlxjQ+pSzMMc65T5AQM7oUBL5/8Bbq+3vVvGflXohuobrOEdHt2vmJ4rn+nLLHIuloiXOBTGO4lt9CCLUbo74poxilrW+9iJieDaNXsqWOgdElJX9vNGlSWJbh4RJgoSjXgbAh14dBAE+vPYBxuXgKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=HjwNwtRd; arc=fail smtp.client-ip=40.107.249.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJrDn7qKFtOTX1PZ9uou5m1+vih/0b+8SZESnkc3+qqU1Rrzc6a0MUntxemk0I9Xjb+HIp6kO5uyRCyHrP3DUZzaKPkEFE1Ya8LbpQ0+uYBEijz7IQwSJYe0MlmGSH19HWqNoWx6tPoK/Pnf1YiwRCNDotRh44SHpnXQ5/DkB0ixcoPyCFL8gG6YTUrArix6J+k1ldZJ1nWJM+eYZn/IXzbn1zVEnU3tX/bB03Kg4L3MbGue2FO3jIm1Zec7OriXsYdL8Jzmx4SLULp1VSeOf9Q5fFMmBtZZshZyMpkKjmPlITQuMnOkK42GB65GXRAK0Gg56vRAmyq3zDklUXsySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWQYDZGcVmCZQF3PwP7JJjEADP3xKFMN9HhcSaOqp8g=;
 b=W3g7CZ/e4HOpXMVmgFlPCt//SOqWqObudHh23I+OCg0oeMqhkEb2dI4Tm9TylFINVAEG03SykYfUPhj+zqIvudqmE6uWNJGBPq29tzYd/+TxsTUIPbhZhCa9gbhZSEYNhCMaSepAgZd7ygNmSMg+h89OnMMRGp1rRgzM2AJ3YhmTcDRWu5XveNo7t6AFmeW6634u/THQDuVNwCr1Fkmf/T7tLedJyJTAs4vmO5hVg8N4c3CQ7KKk/L3+NcNsQSF69yssZFK3Jw72Yn7pSQgOYpNmctHZqSL2JQJcaZGcJwRRYxUQayXexEgU6Puy4kj78swAYhnGlyq02+F/MF+dSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWQYDZGcVmCZQF3PwP7JJjEADP3xKFMN9HhcSaOqp8g=;
 b=HjwNwtRdIG6iCjgzs4I/2voECQgaSG8TyuQnQ/H801WxLsIAmohDUjW+QMzxXkOP2392OAZwzWmOT5d1DUdzsamX530lqD3IbEcAqDp12heuMXtRkO2mIIEZBn/GLByFnRKRL62LlcuzSeEP7nSUrr78GOFS54m1td2PtC3MEC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB0820.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 30 Dec
 2024 14:27:42 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 14:27:42 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>,
	Alison Below <alisonbelow@gmail.com>
Subject: [PATCH 4/4] can: kvaser_pciefd: Add support for CAN_CTRLMODE_BERR_REPORTING
Date: Mon, 30 Dec 2024 15:26:45 +0100
Message-ID: <20241230142645.128244-4-extja@kvaser.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241230142645.128244-1-extja@kvaser.com>
References: <20241230142645.128244-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E44.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::51) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB0820:EE_
X-MS-Office365-Filtering-Correlation-Id: 498b9e86-da16-43e5-a303-08dd28de1ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQH/h82Ih6ved/rgQBxz6+Bif6NqQyrnWVDYMTAbsec9ChORtnm7x/SIQsYc?=
 =?us-ascii?Q?o5EawxKhq2pebRl0UGDga+GQYxnFN/6XC2TiAv2fKtHRxKCm07WlJnsv4kBp?=
 =?us-ascii?Q?iHvIpH8QpGRmzqm5o0K8Fs8lAu/RFOQgQblNSS0okHnyqFPeEkXhkPrPlTQs?=
 =?us-ascii?Q?73PTU25AUfrah2SLwPv1jYF98SbtIfd1v+NBTjdUtvT8Sim6kT0dkCC6JZIo?=
 =?us-ascii?Q?d2/bi2d4kctft+hJBRcVrJtAdyWorBMqE8sntdCnlLtBbY1ATppnUX94ut5F?=
 =?us-ascii?Q?wu5pQ0qPGTUc4wmQpKxeK/B/ixC6iin5R6lJcJti0SgGFvaAJQJ9hAi7ngo2?=
 =?us-ascii?Q?xuFh6BTaHqLqvTEG0cKDbBSoPEGxumtaPFU8LAg8W8TsXcJHn8pRpFlf2V7x?=
 =?us-ascii?Q?xRCgN2EAN945pRr7WpKcrqiNIVxfbKRTFwRi5wJnj9Mov3CasDZ3KctpNOpG?=
 =?us-ascii?Q?ziN/mHbaqJAXvdBXGRk09t1vXEC7+iDVmJ2gR7KTWoJDt9mZeST8vYJPKQLb?=
 =?us-ascii?Q?KZPzRPqgin+IIDwF7+6dtTcDeSG1DKgpPMaaJRckzrZbcKwQHTtP2TdzS6cW?=
 =?us-ascii?Q?5N/x7+xLwJ7L8wcPW7HZD0KmB+yDY4I2dXE7Nubm6+/EATjbV3iaAfVpc61V?=
 =?us-ascii?Q?Td4Sp3t7XmnIGU+/HPhWQsVKH9NChs8SsYgRaFGNxIpWGMLKRs3ay7e9YFU0?=
 =?us-ascii?Q?AVzo8LvyFC8zwKE5rtnuU7s2jdvVuWucM+VTjuNVhNG8ZdC9DyL5CqNOavsn?=
 =?us-ascii?Q?x6/AyrenILfCO0uf/OsmZJHlt5NrHb35BroZiHx1jOS9DyBZ37CsiWQ6YZpl?=
 =?us-ascii?Q?i3vkLLxbmA3z8XLfS9CQwa2aGw/EikGdm8s2aA670VGZecClTGnrm98WWBo0?=
 =?us-ascii?Q?wdUaJINdEE5Ptys/mDPxFcW/6Cq0chM7gowKR3vek/Z3Ri4x75bLCqXS9D8a?=
 =?us-ascii?Q?5g5oRh4p77rTUdPR6xnVxmmu/8patSDPFDEEeXr43zCUJDbnV3ktfBCQa1f0?=
 =?us-ascii?Q?ot7VGVFa2MxDfR7WIBnyXHQVHJhAo/P5+sqY/P+iej3hMhdh9fpx5JWWGl+b?=
 =?us-ascii?Q?TjVT5AKdOhonD55RNL3n+c5dHQFz9sXVjFN0pW9rfLTUkPZihttTXfeni2jr?=
 =?us-ascii?Q?0iGk7maQoY4TUwSC9Ept5eHzmlLnbGE2sQRUgCmO1yfAb8rj4iU+qySms8rL?=
 =?us-ascii?Q?/wfUkztatwoj42lx9X3ayqUMMF0WLJ2WjaVDC+nQm//18aqYL7+Ejv888pLD?=
 =?us-ascii?Q?l1lq5AQA2v7Tx7hwZi0rqsFz4iVE643FO/j8CkzerAERktEYeXhwrq7vfuer?=
 =?us-ascii?Q?NyXQr/la9l9qAFj6uc2EIMcfUxL3QX8fzY6oK4+UL74P/w4ArR7bRmcIrs2C?=
 =?us-ascii?Q?PNjg1YA1+TqlwUfQIsuTjNO6VflL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X3wUUA54otNGKKQLukSrUTHdsWdWRD44WI704a+3JwswdUkk5z7gpmDHQqrm?=
 =?us-ascii?Q?Xsr5LALmEXO+U5/XiDPNmN8yY3mGADkJW7USZkluvY7OhfroYNv80YFyxnHr?=
 =?us-ascii?Q?1FqxzqV5ZD7kajlg+g8ggtCF/zQycry5pv6tI0RUhtrKimnbR9MfnkKbVXRL?=
 =?us-ascii?Q?Wb8Dq342fyTK2b++BDFs+naq9PnwRbZH/C9gmvIDocTruYUygPTCeGcCRONJ?=
 =?us-ascii?Q?MJA0VbKwcSA+A8MIDuR5z/zmh72L55DVhoZZmwEl4Ao0/9wFfmQYzjQKVmPo?=
 =?us-ascii?Q?SIh67rGenslREtNRGprqrt3cTwSU9Akr6h+/TFZH+QtotO2zMWXocEda02Av?=
 =?us-ascii?Q?UX/HuZ0jLFxYW+JeFyginejlKwhLUAFhKEppCxSO86juryUvwNBD1KZjW5X1?=
 =?us-ascii?Q?7n71fwvt0rApQMVyn+VIwFOgdvarpr4A+a6s62D88aIsa9PNkS28m1F+ZQSw?=
 =?us-ascii?Q?hbW2qR5TlurSbY8EkEGhd7/f5dvMZSDWKKuNTzikTo2dAjANTWzTiRvtgP9V?=
 =?us-ascii?Q?OykBQdVOsR6SiDFsEyVY6DwQDl+bI3ey+RqPjTBnNyVCjswNAR/DhoxDXZw+?=
 =?us-ascii?Q?g3c838/227fOcNvvfzWy3chAJXQCqEbuhKXBz5j/O52R2el1DExq7l0r5STJ?=
 =?us-ascii?Q?uRN/iIGHkDKKDUST27sDKr237Amc36Mr08gLcrAZudo3/aI4sCM4zoYLeFXK?=
 =?us-ascii?Q?Qzprm6E+ZXYXrUD2znrLiX34CAYNzHzA2VzEX87/8JRsemFvPSYflLziGo9L?=
 =?us-ascii?Q?vwmrAEecQjGRrD981HQQMjnfnP7EBlrhCnw+K0ob5q54S/lZm/AW5AjWvJ2d?=
 =?us-ascii?Q?GWMKlf9AbfJl6o0zhq8gAUHJ4yHZKvDC5FJ6GwlHwY2s9OBEo4dKuOkSUQ+t?=
 =?us-ascii?Q?7/pVC0Ln4+Mw3OREsCCxdAXY6Nnl5btC+2RO+DYhYljFVzPFmDmB7fmf5adL?=
 =?us-ascii?Q?OFP7D6q+UTUg9GrQWqHyuX3gMq0fzk8ag863ARdpCQ8aAdku+mByCA3XbEkb?=
 =?us-ascii?Q?LC1OkYjfIKjZ0hNcPQdcI9YNLUggtK/EnsPJEmTnKdqFfo7WCvODEwsWno8Q?=
 =?us-ascii?Q?qg6j9tfwhyuRRKOwfUwtvSO0wtRhC2gpXJPI09q1XqC9wTOdApfUJBDQeTp1?=
 =?us-ascii?Q?MfdkiH/C12Nz8ox/Aj9XbhvBW1yoXyEeqfZyNgIi583zkbjbjZvlNqz/lNfm?=
 =?us-ascii?Q?8irxnEOqZt1lFLofxCK3xlOLqH6qHa3yci/kZ0UR9VHSgNAWdCou01EOVZtF?=
 =?us-ascii?Q?lKdtISbJCNq7aMT4DDQtURHhpd6uONnqNKrz/2PdRuWYpCDZ5Az2M8Vkt28g?=
 =?us-ascii?Q?aTtdwj7dQxonQf/YMTLjQpyFkBZNb4NmE0ntVGXKQyEuCMMX56KxQrvTYooR?=
 =?us-ascii?Q?6Ib00yuAqdsV7A+E4Mub+VFF7Aa8jOojVRO8mLXYsYBzulqHodLWooVqFUjm?=
 =?us-ascii?Q?gr8Zwf1zw2rPHxm2h5ZDJ9tnn151SXw4YjqgaL9spTPoAjCdsqzf38cQtymI?=
 =?us-ascii?Q?ogMZkhrwMU49a5To9kSH7b9jnVJg9EITyxXOd0K5FVVbotBwwRtsi4vc0LPT?=
 =?us-ascii?Q?wpLDFZw4PqweRXSmCYvSI5f0hImvE+dE5vSTdRjfpzQ4thh1qsHd6wOvmwIw?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498b9e86-da16-43e5-a303-08dd28de1ebb
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 14:27:42.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1mavTuagL772vvoTqJnQ/HsKYaEZotmXfHJlmaYyceVCIJ2XEgReu7LEy+ny96RrffTxVurRUGJxEv6TYrdD3RQGfoBrXD37JMPyQ864Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0820

Add support for CAN_CTRLMODE_BERR_REPORTING,
allowing Bus Error Reporting to be enabled or disabled.
Previously, Bus Error Reporting was always active.

Co-developed-by: Alison Below <alisonbelow@gmail.com>
Signed-off-by: Alison Below <alisonbelow@gmail.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index e12ff12c4ba3..fa04a7ced02b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -999,7 +999,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 					      CAN_CTRLMODE_FD |
 					      CAN_CTRLMODE_FD_NON_ISO |
-					      CAN_CTRLMODE_CC_LEN8_DLC;
+					      CAN_CTRLMODE_CC_LEN8_DLC |
+					      CAN_CTRLMODE_BERR_REPORTING;
 
 		status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
 		if (!(status & KVASER_PCIEFD_KCAN_STAT_FD)) {
@@ -1304,7 +1305,7 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	struct can_berr_counter bec;
 	enum can_state old_state, new_state, tx_state, rx_state;
 	struct net_device *ndev = can->can.dev;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	struct can_frame *cf = NULL;
 
 	old_state = can->can.state;
@@ -1313,7 +1314,8 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	bec.rxerr = FIELD_GET(KVASER_PCIEFD_SPACK_RXERR_MASK, p->header[0]);
 
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
-	skb = alloc_can_err_skb(ndev, &cf);
+	if (can->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		skb = alloc_can_err_skb(ndev, &cf);
 	if (new_state != old_state) {
 		kvaser_pciefd_change_state(can, &bec, cf, new_state, tx_state, rx_state);
 	}
@@ -1328,18 +1330,19 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	can->bec.txerr = bec.txerr;
 	can->bec.rxerr = bec.rxerr;
 
-	if (!skb) {
-		ndev->stats.rx_dropped++;
-		return -ENOMEM;
+	if (can->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		if (!skb) {
+			netdev_warn(ndev, "No memory left for err_skb\n");
+			ndev->stats.rx_dropped++;
+			return -ENOMEM;
+		}
+		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
+		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+		netif_rx(skb);
 	}
 
-	kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
-	cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
-	cf->data[6] = bec.txerr;
-	cf->data[7] = bec.rxerr;
-
-	netif_rx(skb);
-
 	return 0;
 }
 
-- 
2.46.0


