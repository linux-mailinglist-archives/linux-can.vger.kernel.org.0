Return-Path: <linux-can+bounces-4109-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44528B10632
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351475A3CE2
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71A2C3248;
	Thu, 24 Jul 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="cajsrrkw"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2132.outbound.protection.outlook.com [40.107.103.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB52C1593;
	Thu, 24 Jul 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349144; cv=fail; b=tko1ymXSs0SH98wGqvtL8SO7x+S6TYdcLIShUyZLcDC7p/nD//g0NOb/9VVqO+gJu/IGiTjdYqtfNio6gUcTF4F5IQbx6gbhyMBxCF230VI92X3rJnfM+Sc2n2TBpoxDv/8Sb3l6ddiml2SulIxVpezuacEs1rJOqKtpVrmbNRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349144; c=relaxed/simple;
	bh=o+IKfHOz1EZRu3fjTMDej2WclAiojD88jwu2LDB+pP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C21T8aK8mmn2bcximAKnfZLyujsTD7BZy+9YhN0BuTSCE6JCjoK5DbG4MlDE4QeEYtsMTOBXhJbOYBQ8vjAE1XieH6bJAzldPtsfr0aDTVC25wfRS5HoROXE65kFvY09xkFja7FrVXYTNcT/3UMrUsU5t2zAK117OGk/QtDci8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=cajsrrkw; arc=fail smtp.client-ip=40.107.103.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdJcgpSBH2VwND4YsrBVeFdADVG8Hil8/xgop5CbTw2G9Gy1BGXs+FC0vKTXrY8NCaWlkh0YtensEc5e3hdlF5lVvmlpyglCGujPAv7TZh7DdJSuXhBMCGj8llsnz3gtPK1sskM4/+eBY4M37hJbLZpoqSJOWAELjYlaOt2XfR67nDJ1ZBFoMOv+gclOZwGFWm211bL3xNCze9Ib+SETRQ+pPWZN/4//hTNv/GY/Yvn9ppzX4nzOdvmeFCMzsWv2e6ZNI9/wijDK70g50CmIf2wIPJTGlUo57PLONoov/c2FIrZVsmkXeIv4wT+TV3LrQsQ36G/LRTBPNy8B/HjVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCTnepvrwH2rXXU9aq8Nmd6hcxSR2RpDhwEmvc1rrAs=;
 b=fUMGwNPmk/tcSKzpqqDYic2TOkzk4KOXoCLK8Cm3NNeJSG7dhe5e+bNmxg6WILVQaToUxCwJOLbEpg9thFrqBTU+wVqQunS8RPJnjb8hkBIFTT6pKLsL0jG1SgGIvytnl2fk6XHUGNChuKE0lZYxT9SQhF4uY0ubHSqYqRMMofQ9KWcEAH1yWOwWr8MijMrggTQWdtnmqKafA1Eq/OvaKzxsu2BN6EUDdiKrNwL6BLo5WsHC02jBCa8kLlLbFIbKyq+2x4Pgeq0/ikMUicIFQ/Bx50fe+swvtYGwUKWuRs2yxryNjkVLHojGeZQ7yENw4YcYhVbWuH8QkkyKXpKMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCTnepvrwH2rXXU9aq8Nmd6hcxSR2RpDhwEmvc1rrAs=;
 b=cajsrrkw4WDlnIq8Va//OIiDa/BknnCcWqfjGvg62euH+ri3/SMORzUXOzWhrRpdu/Au4GoxhkrTvTR5ePUvpSCefXTWU2ZX1TSdNonyqu7r9xENKW1cCDS/4evBCKJy1lSeZ+9LokEDtXz+UU+8Btys4Ys7GuvTFLmysJm52b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:29 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:29 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 10/11] can: kvaser_usb: Add devlink port support
Date: Thu, 24 Jul 2025 11:25:04 +0200
Message-ID: <20250724092505.8-11-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724092505.8-1-extja@kvaser.com>
References: <20250724092505.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB9P193MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc4b77f-89fc-45e0-658c-08ddca940800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T0Lk/5D3LXvQok7bNMM/SQ/TixvCRYujV8sN/CDdG5lIq2u0Y7OGbX3qr/IU?=
 =?us-ascii?Q?BwjcgNpbyaDSW7LkW038ab+vYSt/uWXOlAjf2W2iBGulEZsnsjXzVRRl5ZBw?=
 =?us-ascii?Q?6Sz4aLcp0LLVgb33nYQgXl6NNa09l+jlefYb2V0sr8gBgLamedxZ3INuN57f?=
 =?us-ascii?Q?Ao+C9sXe6hXYpi1qiFVAU5Dvqh0UVd1/i9qAPg6xqe+bL67dv6XeeaUTI8nL?=
 =?us-ascii?Q?QgIMVQmZr5K/HyFcTDtjoaVbftKqOnBuAmhkGDAB/8TSvYmUnytbvnw6Q/hp?=
 =?us-ascii?Q?tXZwbJFdqd1GzFr8IiIB7hwWce/z1I0p+g+IhKlzj8r9v0DLB16y15zTM28J?=
 =?us-ascii?Q?U6Czk1u33mYgbdFqdM571412gjW/dF/xF1QWH2ETq9A5QghVJn4TqUXFSvyz?=
 =?us-ascii?Q?pxzeGpePRhFmSUCj+/k8CY01Kzc+MDp0jmJOuSj2eFcuy+pqqzpYKkX9N2ZG?=
 =?us-ascii?Q?3+Gl/+aoVuO7XCjZN0ayuV0+MhEH3WB3WlglqnSsyaRmuLl6HCBCMIx35YHn?=
 =?us-ascii?Q?ZIIULNCycK7EiOXHxrvH38UmwJFWryg4BkhfABkUEaBGEG9PYSQd6OtuKHRk?=
 =?us-ascii?Q?D4A2m7zQ3uotSOdU2LP/pbOsfQOxp96qrOIupy+gzLa77ADJn37Rm34+gidQ?=
 =?us-ascii?Q?4Pnq3izb1/j7YLrEp7XUz8Fa5NyyoFRgsrTwjDeuYlzh/icH326HY2W8qarN?=
 =?us-ascii?Q?s2x03/lhq+bEp1l4K2ZbSzapykEIhARj6DB4peSmLDyZGKpLV+ZyKwRKHWw+?=
 =?us-ascii?Q?9TM4GWIFSAfjdX7UQIcCjGlRAS42w2PTGDCNRFvjQLEzQArLfQev7Uu9YT8N?=
 =?us-ascii?Q?0hFVByMR/UNdHgDxlquJEqaBdKuTalv60MmwQLtAgED/t631u60v2zfzJ62K?=
 =?us-ascii?Q?9oX2ix5iwovlm4yBK4SND1b/BlvN6HFSNOjgNDYZsV4os9ScsV3TTf+BKMYz?=
 =?us-ascii?Q?4JnqQBvw8CbEJvmIct92DQB943j21c3dYVOIU9mogWo1tfo7RCqr5/kNVOkR?=
 =?us-ascii?Q?wh3ZIa9lDWDpIxYNFYI7NTM9+cNTbdvfQ+a5aILaYJm3bhSPPSCWVQYFvCTQ?=
 =?us-ascii?Q?pfbPS7f6f166eN03XiFb8GHI8x39/YKt7MW3KH3huFJcdxtgIVmtax4xQx5Y?=
 =?us-ascii?Q?UJXsfeMd31KAcVozAJK3UNwlpqm8XiqsOWrnDlYU8YsRkXWfbOU84wBjqfrd?=
 =?us-ascii?Q?j9f6qDPXenzeAHqEi9RALBqb/yF7bt+MijkiHrZo6qC29CU+lTk6Hl7/h1uB?=
 =?us-ascii?Q?Ue1ndBQeG3TwO74w3H6zQSkPB5G6zlyrzY/K3JA4aKJlr+B1b6Q4d2BRMNUE?=
 =?us-ascii?Q?Gf7LzA0svdGDsCoZbLNH98YxxqktNYeLj81DRTlSD5nvz233uTMWD1SWUf1S?=
 =?us-ascii?Q?QwfTE0Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmg8SPrq0XvBi7yy64nTnn4mTQ2E5U1B3a3eD++Onor2SpF7/gPJiHoeNwsV?=
 =?us-ascii?Q?s3SiLAhIvhNDU9PBvMluTwQSmZYEv5BUeeAifxqz1i8dn2nwzW0DfxoTdIov?=
 =?us-ascii?Q?QBjZ+S8tYrCWgxJZwTkwJ9bVqBc/eE6nnpy0o3WC0JfNMg4MSksKSszqmPQe?=
 =?us-ascii?Q?S8bziTUOiK601CTH+6IAx6STlrjD5DOgxxBgIU37orAqsD0tAkSckBhCMj2X?=
 =?us-ascii?Q?hyfQuxoqgZNlvw4AGq6Thfhk73f87EzAwY6TO5vY56CbeJH6u5ZCTcExDYhM?=
 =?us-ascii?Q?tPkk7N6tdMRS3995l9EkGDuSrnbnFk6iywmBwu6KXl0jK+X8QVAPfXkfCgOR?=
 =?us-ascii?Q?WjLkNeueEWDawNqKY8O0b/CZBHtSwKb5QnbTAv9Outtog805fUmRYBOedjjA?=
 =?us-ascii?Q?n54MCpBa6KIJvuA9BtV3HzupaGuWpHQAfO3R567rxXPrUrQYtALQ1DfYjIxw?=
 =?us-ascii?Q?cWCCdpzP5L04wuVrIFpTHjzU32R1yn20ojJeJqHBYWR2kpnfopYjLmOVXeFB?=
 =?us-ascii?Q?lArDVLJBZaAbWhXouiA0UnPupa9Y1jMmSAqG2bXNxP2Ljw9iS4if+3D/Gp2G?=
 =?us-ascii?Q?091okXwLUlQ5pnneIXBp0GWp/7OoFsBx6apBebqUXW6P1ZyXInryufpt9xHX?=
 =?us-ascii?Q?bS2bGajBg2UigwMcwESvBsDsk/UKrHTpQ9gjlfRGWOyBcGQnUYgTz+fS7IsB?=
 =?us-ascii?Q?TX0as5OKx+yXqtxVlgtUSj3qfGwTPkszGtGhHyfAN+3E1avVcdq74/g4bw+p?=
 =?us-ascii?Q?nZQMyPHpM0ImpIRtamFLRTa3XC1dOHEZoSrRfGSfvYum3k5hlZTS/5eXxS+z?=
 =?us-ascii?Q?6S+N6YuKeSRYdtp3k/PzCAuCuWeO2soRo4B/Pe9viC2FkKL6uACmALNpyGyn?=
 =?us-ascii?Q?DB5tYdlE8T+vFxn6k2/yLB27xbRv2OiCAq3WTi8uKdyk/X6+zohCI9ldIkos?=
 =?us-ascii?Q?b9pm67DAwqFk8DlNSoZAl4eniomk9fMdG4InoALilx7Q1Z87KUqXfFcTXzVZ?=
 =?us-ascii?Q?I2gCc3y/UUjBurWbqU8KFXRIbCl1Q5xysR1puk/Lr9bu5QVX8ahpsXbmatxn?=
 =?us-ascii?Q?Tm5L6qT+KwC0+UXPON2yN7PgemSehitcWNgShFv4wLyXG2mwz17I2yUE0eQb?=
 =?us-ascii?Q?4SpMYSQLZHG+hsn6jdA1e+EZwt9YECnL2XyYAL7klIPjw/QczouSWNH4U9Ft?=
 =?us-ascii?Q?Yd1uvCI8W301YyFpGBF0N6FhNYWEyjX40M/DrwpVSEckEC48j3K7wFSlXXUp?=
 =?us-ascii?Q?LUsf+Dg81Wpxw+er5ch//n3V9DVbVkSm3Bg5rkFJa6l9Uk6m79wGo2RfzRNG?=
 =?us-ascii?Q?nSZEIRIe0myFTJy01AUEWzveOGLI8JK1PaSbjvBAJlVv1xT3TQbmIrZI7O9P?=
 =?us-ascii?Q?ORqfJ2ynX5SgMpww8i/OU1rzfOEAIftbWpQCtDXfiHzEEk8KAvmliaub4dG7?=
 =?us-ascii?Q?l2VR4KZpdqHhe9u66zQmFA0g+PoiCsqWgjkz8LZo4Ux637sun4k/SWJmU1gr?=
 =?us-ascii?Q?PjelLVDcYGu0od3OhvwAKmBMLYz4yVO150ePoAk6ZTWj9U9G60TSj7aYRiA4?=
 =?us-ascii?Q?t++JFi3kqenR1CCIw5WhFP4i11ZxrlnMpumlV0lMWcwLFWJ8uBNTbHgOwW9c?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc4b77f-89fc-45e0-658c-08ddca940800
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:29.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeMRcojy4DBFE9BOZNSfvIAsrHe4W3hlcymKv2YEpCcjkZ7mqc+6pRiwNRMZXe+RviLo1NGvVbqtHO4x41aAbI+t9RM/OMLBguiyiOH5iJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
  $ devlink dev
  usb/1-1.3:1.0

  $ devlink port
  usb/1-1.3:1.0/0: type eth netdev can0 flavour physical port 0 splittable false
  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 1 splittable false

  $ devlink port show can1
  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 0 splittable false

  $ devlink dev info
  usb/1-1.3:1.0:
    driver kvaser_usb
    serial_number 1020
    versions:
        fixed:
          board.rev 1
          board.id 7330130009653
        running:
          fw 3.22.527

  $ ethtool -i can1
  driver: kvaser_usb
  version: 6.12.10-arch1-1
  firmware-version: 3.22.527
  expansion-rom-version:
  bus-info: 1-1.3:1.0
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  4 +++
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 15 ++++++++---
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 25 +++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index d5f913ac9b44..46a1b6907a50 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -131,6 +131,7 @@ struct kvaser_usb {
 
 struct kvaser_usb_net_priv {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct can_berr_counter bec;
 
 	/* subdriver-specific data */
@@ -229,6 +230,9 @@ extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
 extern const struct devlink_ops kvaser_usb_devlink_ops;
 
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv);
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv);
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b9b2e120a5cd..90e77fa0ff4a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -818,6 +818,7 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 		if (ops->dev_remove_channel)
 			ops->dev_remove_channel(priv);
 
+		kvaser_usb_devlink_port_unregister(priv);
 		free_candev(priv->netdev);
 	}
 }
@@ -891,20 +892,28 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	if (ops->dev_init_channel) {
 		err = ops->dev_init_channel(priv);
 		if (err)
-			goto err;
+			goto candev_free;
+	}
+
+	err = kvaser_usb_devlink_port_register(priv);
+	if (err) {
+		dev_err(&dev->intf->dev, "Failed to register devlink port\n");
+		goto candev_free;
 	}
 
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&dev->intf->dev, "Failed to register CAN device\n");
-		goto err;
+		goto unregister_devlink_port;
 	}
 
 	netdev_dbg(netdev, "device registered\n");
 
 	return 0;
 
-err:
+unregister_devlink_port:
+	kvaser_usb_devlink_port_unregister(priv);
+candev_free:
 	free_candev(netdev);
 	dev->nets[channel] = NULL;
 	return err;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index 3568485a3e84..3728e5d5793a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
  */
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 #include "kvaser_usb.h"
@@ -61,3 +62,27 @@ static int kvaser_usb_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_usb_devlink_ops = {
 	.info_get = kvaser_usb_devlink_info_get,
 };
+
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = priv->channel,
+	};
+	devlink_port_attrs_set(&priv->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(priv->dev),
+				    &priv->devlink_port, priv->channel);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(priv->netdev, &priv->devlink_port);
+
+	return 0;
+}
+
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv)
+{
+	devlink_port_unregister(&priv->devlink_port);
+}
-- 
2.49.0


