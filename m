Return-Path: <linux-can+bounces-4108-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C80B10640
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7E61CE6994
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A162C15A2;
	Thu, 24 Jul 2025 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="NQYNBJvZ"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439592C08C0;
	Thu, 24 Jul 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349143; cv=fail; b=AufKN8MJudnZcJMZ/uw8po/7WN8+kVhHMU8Iih3N+JSMlFqWaMvEPugzjEnOTQJ/wcet/M4BfHJCbl7JFsSFUrB3/QIp3UKEFEy7/siTCnmh0uNxRpNkunk0To7cyQpgySqKMJpFEtV5+yCvNjiSVlKD6cUybO8cCPF/W+owI6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349143; c=relaxed/simple;
	bh=nawgd4laMf3BKdtwNper4oPuHxadM8ddSCBivavG3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5FM06pjkEIeoJESLVr+dCz2DvPblWgXNDO6ZhDm095GFoLE9nT+n0zoQZbKCU9Wpe542n8qQuTB34c/mIXUjOfdPHWy2pq6mt5AIfSVBNRoD+fSX4ZHyMPSEKm/4MKMlmAalG/R83oP5vw+xLbWBKhiO0Wp+mgrPKdhJDjyffs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=NQYNBJvZ; arc=fail smtp.client-ip=40.107.105.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4N14xgo6V+UfR6TKg5jgiUQvo1U+D7fAkunia/BuJxGTWm7rRHg9jy/p2KUCIeGvDNLEGgckxtuIRj2gPAaqf/4wzbeKwQPmY55iWPk72jD9R7lOeLyYE/E/KIbliE+XHx0YqAlpxKIf1tsbVae/yphe6Z6eOZghPPYRinQiYUv5cpfTW5pzFRLZXC397fR7Nw8Y9jbAYFK/ThVBjOmU9C4DH0+lGtt4nCLIboBBqnat8Yy1cmGTLINu5/S6iMcgYB5JOXTCVJXx8J0BMFtyU1PFzEAv6tvZ83mKhbgP2QtbwS3qqxFPWZagqf7mhOShVysumLd4cQcIezB9ZQxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xENNZxBA5olB3o1JCXi2V4N+Jo6ndq8Gpxmf/HHXWY8=;
 b=hC7abUmdVBVDjCHbjjJWN7tUrHZRxpAMo1R58JJyzZrGKUDJ+LhBSWXZnDypxXl9XUlA6zsy/sr8XEwk57PhSMAbQF2EgTJHz8Mi6LhC3Htib5PPtPfY2Jvl/b8vrIxoZeDwVoTxSIFgy6GeowDAnfU5ICvNJbDdsHBWREMTZXrGdKxHTpIPwR2Tf4IaMASt8kl/CSClxCo4PAUVmldqrF4vkeTv4AXfuTjUqdnQTxfkknUfzyxe1EwJyx4ofGCRbqoDEghqsFbbervAsnjC6uW5XUyB6mczWD/KQr3zzjJ63mYi+/9/TN5ZbWbZBh4hsH7ZQF2xPtd5cz+x5WbaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xENNZxBA5olB3o1JCXi2V4N+Jo6ndq8Gpxmf/HHXWY8=;
 b=NQYNBJvZWTgIzgv4g5NF2VH4vQxK0jvtXmwDJMbPaGJ36lxPEV79Em5iQbDfULIuxhBrkfB4pLobFmdp4yl+WjZnhhgq2vvD6WmlGr0GdaUenAZC7pkIBmoyt/1w4P4iI68B+vEBZIXsRNf+fVtr7RRjfbzGJDBXWCo+b6ulpwI=
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
Subject: [PATCH v2 09/11] can: kvaser_usb: Expose device information via devlink info_get()
Date: Thu, 24 Jul 2025 11:25:03 +0200
Message-ID: <20250724092505.8-10-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5abebead-9179-4cc1-3e38-08ddca940793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?10Ha23XEYgKXHm9mbB8vmmvDxjTK8DddU4ESe+Xxdmjwd3QuPoOMnmSIvdW/?=
 =?us-ascii?Q?l0Pf7skQIxaygjELWsjg5j0Y860isy6xjkXEIyEvQoi+v6NgHnZi3sQB5VGi?=
 =?us-ascii?Q?9NwV3fX8nJoZZ6uobJ8Do5VLdSQlNX1WIjDG+8nnQ1oUCZSpYtidMJ1HCc8h?=
 =?us-ascii?Q?EhFMwb0VgdBsJlSvaS6DeRxRY4+tDq5aosmwjdxEf9vBT8aQRJdaKSNsPJ5S?=
 =?us-ascii?Q?ZHzEWu3LWxlETRPBgXwGpdYw1UR9WhnB2DksLJlf7rawGsKcFEgtmoQ1bsLs?=
 =?us-ascii?Q?fHFu7yJlWIsA7rqtf9ztEE4bv40Y90UTAfwDabEEGACwIAR6nDV9rJAh6VlK?=
 =?us-ascii?Q?YTQcunZnyBrp2pMrh0Jw6fSWEH7kus4P5CYN5HVga/VTS6s1pF6IWBySfjUj?=
 =?us-ascii?Q?ZmqJf1ruVINLVtiMmEslZCLzTmdpoUGttErxaY03cmUxQCCzTX0OKK/qjIu+?=
 =?us-ascii?Q?7qni9Nxyxoyx0XbtIxP5NSMt8a4XUWAQowl7jbk+8ECeVsVLBeHv5M0SMB1J?=
 =?us-ascii?Q?148dDoYavZt15af73zJwbEcli2X/3Vsg9ZAnKS0EBg5CX7dDacq8Z26FQDSA?=
 =?us-ascii?Q?czYnp5CCr88r+qLTFOhiXYWM/+66elNFL6/M2RpmZC4121T3sfHr1YbnITPa?=
 =?us-ascii?Q?pys30JSPwebgdDPATneTl/YeihCn7p2DJDsmzWv+ch253Is7cOZo8fEDGEv+?=
 =?us-ascii?Q?h8Q6SAmC1Rgnk/ZSIO2q/+HKxk7LVujl5BX2lVI1ayOdAqN6b56xdEIZvlbp?=
 =?us-ascii?Q?XZh0M+bISg40xt7ZKcZ2Py7WPXk3+fO1wuMWT0JTns6glGOMqFKNoqmM4zu8?=
 =?us-ascii?Q?MR+Mr/OghjaAV+yOlzVd8xPk5U2O2LlT+SB+2rFkNvTB1v2JlF7fj5TBAbzq?=
 =?us-ascii?Q?nJvy6p+DI2uk/zTwdPcR362FdPtLSKQeZZyNWH96PKGwYqfeq3tH5kS3NQL9?=
 =?us-ascii?Q?mVZFRJlWPYDielwdPcWOU+5XQLMf62Eq+Vje65RFS+5woM4essQ0+SYuyClL?=
 =?us-ascii?Q?jd8OZecdLkngUmWqANirQVqb7Jl3dWHcuVnHXmb9sLvGzpJrYehayln0EI+Z?=
 =?us-ascii?Q?3rRPXtrbT5NHoptuN5QXrfY/V1/W8amuhYupKPyPRvzzzKo83b2lup9q/smR?=
 =?us-ascii?Q?VxNOcszytVrqDNHlPXrLhxWgEyJXR7yD8yMFCo9UEoW2oFYon5BO3wYAOKRd?=
 =?us-ascii?Q?m1qdtilMHp+lT1vHHdy6TomvzlNH4Sm28YzoQ1OKQ0kkkLKdzUGIhpnBcQmW?=
 =?us-ascii?Q?9QKPpJ2QaS4jNB4fcFXxovJgzotwUwJ0vvaWh2QucbT9nvdDctQPVjBu7eks?=
 =?us-ascii?Q?U97mPdk3nSFEDkba3xRo0WoBRmv1zjJ1EaMGDDdg5FAU3sTLE64sjYXgul3y?=
 =?us-ascii?Q?dQYW6OM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XjivbbmwJ92HSLFHPzKBQPQj0MGL3pUyERfj9zORvIrZuV6oKpKs+YUYlR0?=
 =?us-ascii?Q?m64F1eGZGHdCJes+zXiPzNFCzxNg5zebU69zcWJ24kTIjB0G9USRSTVvknej?=
 =?us-ascii?Q?L7UXkCmTNg+8tx19+2T1ArgCqovqmaR2aSA4AeZ+6zdv7SF+bu3horw5bE8N?=
 =?us-ascii?Q?WmP5GGVDl7nXN0aUmFidRzmsoqm5kWrVV6iEUXkjm4n0fLZfHuDRt0Vb0aKA?=
 =?us-ascii?Q?rTvGbEb6szdvbHYobNCbFsDdDNc/vztk/9KG9/2i7Y+biMcRpa3GXMHjrtCn?=
 =?us-ascii?Q?jsC2jQ8JJuXBLAbxp7XdULNelReFu1E1mEjZCNMJaKKJI+ElevAFisd5uv7T?=
 =?us-ascii?Q?HxkbWPZbigS3YytR2wWXQrUFLYbHccXe/+bCT2bwsvjeeAkLD7XDjoGQIBtD?=
 =?us-ascii?Q?/k980fWr+dwqQpC8LhzMdaUgkib39TH72CVlNRvMVGiNB7AqVWJujJ5D/D2g?=
 =?us-ascii?Q?rRblXxXJilCDu3EIF8GzBEvesyjft4V/2AkUR/I5JhDIBqDY+QC8dLiyA49V?=
 =?us-ascii?Q?hiz0jH6DcQuJL6L/KLoxoWmdWAbfp3btQzuEjwNTN4cF40JmsxDT7IyBcbfY?=
 =?us-ascii?Q?r8H0YAxZ4Bf3nbTxPk5DmhhKioPOw0Vq12LBfDbQaZKVHImMTrz8EF5Rnn4d?=
 =?us-ascii?Q?W792hskKA0osFBiZQOC7nSFSteuZ8xYh3UISdLE9lATWK+gbFwGE4jZg68dv?=
 =?us-ascii?Q?Riubl6f5PkrsBKGvAuAnkNlRfoNMKJU86u2AsBo6bDEvWXflaKDBnXGHwlhd?=
 =?us-ascii?Q?qzLA0lu74rJejxKNfpBouB9EiMAnOxxUNkchtJJ72axtIETa52tUOIIcAF/l?=
 =?us-ascii?Q?R5/h4XHUZi3+46skO74QnwYidUkaynRnz7sJeQfJdFIpPzmBzafpfCo9IQoR?=
 =?us-ascii?Q?otyIraYN3JY0YE454xK5sakDceaHL7hexnyuwy3ZNlD6XbVxby+o6KRoqOQg?=
 =?us-ascii?Q?8a8bJXITOBJqJcWx01rdjVzUJ9Qi/LFxFJJTF5YGXlq1dy9jHcJuC/3ojnPN?=
 =?us-ascii?Q?4ldCZksmzOrLOxCay6uAQ717J0tk1isJHmPQgcC2UNet2eV90fGwRj+LtkFm?=
 =?us-ascii?Q?TKgFPvRtjTJuZUFkTDMh+t5C35d3n9/3vCHPr92k7dTaJ8yovRWtXqBbLtfK?=
 =?us-ascii?Q?JzWxlr1VzD318BPbA3AsIQVx7UoW0M7n/2uHyUTPyo5yaWOtl3G1WlfrrZic?=
 =?us-ascii?Q?L1nIf38r0vREL4D2Q8JkGwcFpkWvx+72KZh4/8g5qFWLzNXYEIWi0vDIJV5C?=
 =?us-ascii?Q?iXNlMtskLVtzt5grYnDEjDWcUgJORT6Ot0eZ8627D6CaaLJcjJbbVSaMhQOM?=
 =?us-ascii?Q?JakCZrSiAKL/VElljdA+jbzTP7kRoZnySiVrogf13C0rW5EI+E3Yyb7n9Tla?=
 =?us-ascii?Q?EaofWslii1mEomH5H3+ROb3bPfbTtXSaeCsDktl/08dUJpD86azhx6Qx39yh?=
 =?us-ascii?Q?ikfimn0V9OdsYP31BGGHYX+0/BO7NRlbZw8suHTFTvwC+TUa3pKYGSu+dzaR?=
 =?us-ascii?Q?Ha0rYpmJRN4VO8PqrXQ3KYgAR3zxHRWS566+qAD7/2C8PQYpe0fFzqz0b5hR?=
 =?us-ascii?Q?uEHtRWQarHtfJqCEhHGWwHiSg78FQw8z6s7pld3HoHPUgRaeI8CfPv1vj1EI?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abebead-9179-4cc1-3e38-08ddca940793
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:29.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaSXz35a7wF5cDwFD0pfLRXl/Tg8KbdfJIugIqUKqTvnH1xcLwbTaRzRxlVyrJlj+mZHEHeslTxHwKdBd/o4yiHD3EkrwSFwZ0IGbPfF1C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Expose device information via devlink info_get():
  * Serial number
  * Firmware version
  * Hardware revision
  * EAN (product number)

Example output:
  $ devlink dev
  usb/1-1.2:1.0

  $ devlink dev info
  usb/1-1.2:1.0:
    driver kvaser_usb
    serial_number 1020
    versions:
        fixed:
          board.rev 1
          board.id 7330130009653
        running:
          fw 3.22.527

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5

 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index 9a3a8966a0a1..3568485a3e84 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -6,5 +6,58 @@
 
 #include <net/devlink.h>
 
+#include "kvaser_usb.h"
+
+#define KVASER_USB_EAN_MSB 0x00073301
+
+static int kvaser_usb_devlink_info_get(struct devlink *devlink,
+				       struct devlink_info_req *req,
+				       struct netlink_ext_ack *extack)
+{
+	struct kvaser_usb *dev = devlink_priv(devlink);
+	char buf[] = "73301XXXXXXXXXX";
+	int ret;
+
+	if (dev->serial_number) {
+		snprintf(buf, sizeof(buf), "%u", dev->serial_number);
+		ret = devlink_info_serial_number_put(req, buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->fw_version.major) {
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 dev->fw_version.major,
+			 dev->fw_version.minor,
+			 dev->fw_version.build);
+		ret = devlink_info_version_running_put(req,
+						       DEVLINK_INFO_VERSION_GENERIC_FW,
+						       buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->hw_revision) {
+		snprintf(buf, sizeof(buf), "%u", dev->hw_revision);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->ean[1] == KVASER_USB_EAN_MSB) {
+		snprintf(buf, sizeof(buf), "%x%08x", dev->ean[1], dev->ean[0]);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct devlink_ops kvaser_usb_devlink_ops = {
+	.info_get = kvaser_usb_devlink_info_get,
 };
-- 
2.49.0


