Return-Path: <linux-can+bounces-2976-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB6A4D214
	for <lists+linux-can@lfdr.de>; Tue,  4 Mar 2025 04:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC943AC94E
	for <lists+linux-can@lfdr.de>; Tue,  4 Mar 2025 03:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523AA1946A0;
	Tue,  4 Mar 2025 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hyrRVw4Y"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFA14F9FB;
	Tue,  4 Mar 2025 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059388; cv=fail; b=EprB0IRsmT46V/ubidDo2X6Dd9MGbvnpG2Jo3DNDtEXqBFyMTG/5F9Hy3L5HRplbVimkmYJiBRcTxOc3kHJXHJDhPdi9iIFHnxEgMyUHorB7vUt/hA4tTAm41n4ZmVi324WmYft/0YVfkj+iulJRhNgWFSP+yCOySbMOZfWXjNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059388; c=relaxed/simple;
	bh=3uvCqUpJOFMn634DirJNrs+WxrDcvLPMHd2cIViilbg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Widw0TSQYz7kIM2jydhBXmWaPErkrRSvutDtPbSHhKg5+p7a4jJggRBQVYGXTmlJfYEyyBLrHVKontBvlcmfSZCR/nVrUWti2Yi1NmOP93zPScuXdAnyKY1ZiHOESsqXoOCmdB2n/7y8l73QKXr9/bm4NiQ10Y4OuG0nleXOYQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hyrRVw4Y; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd9XQwuSAHzxUMcv7YMQ0h4NsyqTab+Zz4r7CiiqtTnnm0P4D2FVrlaVPTjmVsvxsQVRPEg8CQ1ws1tW6MhKo16fFOT5OJSbNLxU8Abyew622WBzWmJit1baGV0vt15p/a8RdEex9Tmc8keitr1kL1SYoA6dSJrh2EVJfHzL9URf4lNt9/7q7C52CN44tGHRPjRmngkHNDyRiMMry/4L2JlJjOHzwjBW4QXOx9IWHGjI1p9K2o9HuJJo4D9IJu45ccl4D6RMRf2a5TMxwTPNRq5rUr7O94j5AoVvRZBeU0Z0PD2XB+6jOjF3MaCVNJpYASaT6plP1N/K519LSEePeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N36ItraY9+BXp0pxvQMiMT4jxPC3lTWRc1bJ8oVcSnY=;
 b=BQlQ/M+SqUUsb1Pg4iIebV5kUh99vWD0l+6Oqrk3MB+ZMSGV54BhUCGmb3BvY0BFLQSMMzfIYEM7ZaPW4XKhlL2ek/sxJAxkaGLKqAWkCNh3vjccHhE8VjRaoVONzlcAtn058xfjUy17PmNxk9DMamLdy0dq8SfE+TpZRBlPpijUKn1lHOpAMvmT4uAKVLs3N8KM/IkcvYCVDHHiIkEmHYe2WhWrdncGc8OTWLbIXQjy9PheQM0vcJGR/9jm2VvEs92Lt7d5kwa4TuKJ06N6kXN57eAcr15Rs9/YMhq2F8fWmJ6qsx4CjNcbfZXb8pUDuJzSyNpL07jngtjGczCwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N36ItraY9+BXp0pxvQMiMT4jxPC3lTWRc1bJ8oVcSnY=;
 b=hyrRVw4YyGgbk7DanvIOTmKsW+k2ac30rASkeJqy/QBOsveXvZOXysJ8J5MRbN0zcsDd3kxrUPigQIFVHendO/e0rt6mu+kYzySSe/MUVC2lKgdhd1g12rsbPTUzXT3rHo7buM35M1+6ZbHwBBCTlirhrlUEv7jifOmG5LxyOl+5XIhJdrZBhrre9iFc82Npax/YPZEalmmE7C7O0uZlKcHRty/FxuUlQ+VkQzq48by4auy5qL+/ui9yFJ9r18kHUU+PgI/Cl9I3k5XjTHG+Je4x6y4k17m/0KchfjGryEgd0AvrGld3avZFNrJbm3fvnN/l/v3xlRMud8ivJ9EDxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 03:36:23 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 03:36:23 +0000
From: haibo.chen@nxp.com
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: ciprianmarian.costea@oss.nxp.com,
	haibo.chen@nxp.com,
	u.kleine-koenig@baylibre.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] can: flexcan: disable transceiver during system PM
Date: Tue,  4 Mar 2025 11:37:31 +0800
Message-Id: <20250304033731.1762899-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM9PR04MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 645c94d1-4948-4ba1-b3ac-08dd5acdbc5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AtChXy3wYHYRUgUdpKye/F8UR91J+HxN+ggTS2nlsm+vXwwUyP6PyjPCZpQs?=
 =?us-ascii?Q?YTHqvjStMlp9FBNtDJAzyYDcau6Ebn4TLZP63VnOMs37I3Lm/nKfSuWDxRWk?=
 =?us-ascii?Q?5pOQvqSDhZoIXCtUjGaSLahOpFKxbblvlwhyKTDA6Vgu55o2+8qdpRk7x2eW?=
 =?us-ascii?Q?L+yJjUjLe0/HsCU2tkDIfAl4VrikviD5CrNhnVziXbYpjgPW2RFucCU4LU0J?=
 =?us-ascii?Q?sKUYhukjMSSmtXGy0bFxCr0cX/yNp3wdSIArPFEyj9c52XJivd4jlw/V0dPV?=
 =?us-ascii?Q?MktUjmWd/3PYuDIgTKlP5xdvhaYaTkZnufFEv69gwpXTKrIC+rZXBxmNtPOR?=
 =?us-ascii?Q?ZqN6QypvHP/LmRNbr8ILMQAfkubiXcTO1U4y6TD89Ivap9OBwCkznckjKhRW?=
 =?us-ascii?Q?/2LU6M2tPuqf9AdeQcojKwbfYA4TektcWYjolApL+sdXaLbsFJMc+Pxkedls?=
 =?us-ascii?Q?gHaUCWnvKPNgSvgBKBaR3GORgKka40lEWEUpIDyyhsxdiOP/XL5rK+8RB3PC?=
 =?us-ascii?Q?ntEnIFEiQukHTRVzKfT1dR5apN7idgJBF4jTdvRA4yxhihpKnoxedYXx4GEa?=
 =?us-ascii?Q?OWIGqpieOiYXY+W3iVYKQoFhyUerqQye0xrrSyPV9XYNIxe6acHesbGzE/eE?=
 =?us-ascii?Q?S5YIq1vQO7DtM0G+r5/oQ082IxUq53QqNUmzl0l1lnK5jnVOw6R2M3cOZK3b?=
 =?us-ascii?Q?SXemhCdT9GTk2lVj20IB1GRLhwuQkWK7sSen21NMfWKXJ4+zTdQnvv65Mu6H?=
 =?us-ascii?Q?6xcEuM0JDRdmVU8BLLocxEQiH2R87jPtYY2zEwxslYgUFMvu+vGx3iYxH0l3?=
 =?us-ascii?Q?wcN3WQrtpcUZFf3MVKC/y4cr0IAdb9TlK6ajYruD2Z7KgvSp/Z9S7Rkly1ZU?=
 =?us-ascii?Q?iEuxMGdKR1iwlDWeXmyHnXTEki+7XP5Xt2Wx1nc27NLxTyZjPVPJFEfKLHUH?=
 =?us-ascii?Q?MKjp6Yn0YSZqBxoMl94jqYSGcp0AEiQjoxWkwIGUDUDd23yIb3CF3GsMaorE?=
 =?us-ascii?Q?8DYzAW9wZIPYbNYih5Ia7fUd+IoikQqgrDC6Em5ju4qDFws1zw8RTWyXtD5L?=
 =?us-ascii?Q?D66XyJJSW/Zw9jvgmPt8iEFv8IIR61JRfOCELMkPpWvucxg5AZAUewm53QmC?=
 =?us-ascii?Q?x8+p0NykJ6NxgnzPFoxKJakAsUYmXTNEProrzPW/8tp2w/3dsvh7SyeoHxZK?=
 =?us-ascii?Q?R2liKJIXbxPvvlucAYtKIkIl4t33vJFeupuShhELhHwZT8zzxs7YDUb7Yu4/?=
 =?us-ascii?Q?FLFesjZCR8F1gaVSf1zS0E5uU1daosdndbRVEMJd+pPjoiPe7zLl7/p0LMGo?=
 =?us-ascii?Q?zftJZlH2AX+Cpm4a6n4Qpf8UL0P47cwSzKUOYyKZ8KyFM5BfzkTQ09ea27EP?=
 =?us-ascii?Q?OG1LI5hWB2KxRTgiorlO2ErSAo05RmUBLBL46p4sehdVvAeK+cxh0XsM12e+?=
 =?us-ascii?Q?Wa/OvNLqxdFQLZyG/c+CiDzkPS/OK21T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?muGmXtBuV/3CFOhwpsXOCmmFAr+CXPFtp1vzcVWhQpJG5rSyJ5TmiAVQkCXE?=
 =?us-ascii?Q?KLXC+r/R9BQkf7//LpdfceFtiBKtRvZBwKCtWcmCYpVgOAYQ4+qIFhnhs16Y?=
 =?us-ascii?Q?hjRV1vAdFkgNA8S/ktG7kaznQ3ZXjucUjCCnPGi7nOxIM5H7j39Vobv4lPyE?=
 =?us-ascii?Q?Jg1gI190qQK6+YO4v/+zxCT4xh+AlKe/SJmAyVdjjmMr+6+24QjaGZjfe52Y?=
 =?us-ascii?Q?aH6/438bvTVt6QYyui5Q/kN+1GSy2QvDzOQn42eLVrzA2lU8gIqZPYCWXt3Y?=
 =?us-ascii?Q?JOi1kzQThquE0pkURYT1jxxXjgShWSnyOPfTPta/wvMNZ+tt3fh5nHay3khK?=
 =?us-ascii?Q?AedXSvQDOszSGyAIO/rLzeuw7/gHnUPP2cYLcN6kbfnD6LqEW3gN0GzN2oJf?=
 =?us-ascii?Q?OltY2b1wng37rw75FU/NXLGaAawWqMfk46haZ5cGWExdCBu+UBknuaxLOG3x?=
 =?us-ascii?Q?621lWAZ91RmW8OpAFrPcWMBIW2jV7jrjgrABmvWWh0lS/gsmB5OM3xONNS80?=
 =?us-ascii?Q?0Mb4oGEnKSa7yQyadVKuWoNLOwEOc1m4YBmVgZLbYGL62Mbw7vgEtRnJCQH9?=
 =?us-ascii?Q?utO9JHeMZ9OCEsT5ZnKrJq01yAXezxRhairzgaYn/VaaRwFqJPg6zipM2C6x?=
 =?us-ascii?Q?BzX+hnhYc6yYr85N3bV43OimP4gAwjcVbYwsMi+h5Th7deyqEL+/m5/8zAoA?=
 =?us-ascii?Q?101fH+86BBBzXnifPE5haPhZXH11vuTXPEv9R5U+sck2zwiWpUFtV3v75XWR?=
 =?us-ascii?Q?MWjZK8d3eJULvhk29873i+xplATT+NfwtydqZBL3WiLveQWlzqh8fY0mrEoA?=
 =?us-ascii?Q?UDXxJjfHvTSj5i8fkBDsoxH5OfSgaLp6EEj6dTOz+twTjywhcebMgsgOQS7i?=
 =?us-ascii?Q?64ZO6XJ7WxUxWy89iixoNeVw44U6UcY6fClNLl2KZ0QpBiK8gU+CCvndunsV?=
 =?us-ascii?Q?dhHq/0RZ7qnEFzqgZNSqJOe+CCHweQ0nPDFdzlCQqn1lZC9tnrq2FsUYP6nL?=
 =?us-ascii?Q?CvSFPQ3h632dmICs00XTB3dewm94/AIMqFbQnPdD/xCn/87RCbanN8UE3xhT?=
 =?us-ascii?Q?31+69WnjAXXD9snh5FDXROUBhkGwN+JNEZtgC1EtQAwmeYnb4oy4DN43Yxry?=
 =?us-ascii?Q?4J8oT6O0GJ+hmOKvASEzIThDUGmw2Sp7lXkvIfKW/CkjcUexdhGjSw3/M7Ie?=
 =?us-ascii?Q?1uH1A7To0YSNO5HuSavOjN7aOUnV8kZJwbs83L10BqYlsRXyeNkrOGY2F+nB?=
 =?us-ascii?Q?qgpv1BNqLRfwq/mzhy9wQto5TKYQ6zG9zLg9OSsZmJjU1YxTc+xVMAC1xgAl?=
 =?us-ascii?Q?6pq3sIfdBfDdXmw7hepGDEYaspSUxUCs6dSDqxdzTnKJbZqMuKSlIGx2XdW8?=
 =?us-ascii?Q?KmqHCG33VdPr0uE3k9bIRxaigX2NQtPOEVExkfL1J2PJX+CayCu1/KvC4bmR?=
 =?us-ascii?Q?EGPcQDCOOPvsCNeN/HhsImsIt4mTT27CrRudlDhqjBg7JQxsJ9d5lFEPlklj?=
 =?us-ascii?Q?NJgSvMurU9mEpvPHox5lOpJb98Jx0jNSGQXRuddUacs0qqfcVewS3w6tT4kJ?=
 =?us-ascii?Q?Jn+130CLx2GAASFODx8hGs9jDOF/FTNkG1GtndzC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645c94d1-4948-4ba1-b3ac-08dd5acdbc5f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 03:36:23.4950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5MwWQ0CpSkPZwYmQwEWNA9UZzNp0hqOS5/noHMwlp2mNJI1pIN4f4XBZc+G4O/YTJ1r7iuG/Qjzf2K7IDTjSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524

From: Haibo Chen <haibo.chen@nxp.com>

During system PM, if no wakeup requirement, disable transceiver to
save power.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b347a1c93536..74f3137295fb 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2292,6 +2292,7 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 				return err;
 
 			flexcan_chip_interrupts_disable(dev);
+			flexcan_transceiver_disable(priv);
 
 			err = pinctrl_pm_select_sleep_state(device);
 			if (err)
@@ -2325,6 +2326,10 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 
+			err = flexcan_transceiver_enable(priv);
+			if (err)
+				return err;
+
 			err = flexcan_chip_start(dev);
 			if (err)
 				return err;
-- 
2.34.1


