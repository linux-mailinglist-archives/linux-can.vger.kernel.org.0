Return-Path: <linux-can+bounces-4105-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C53B1062B
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274865A3307
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB02BFC8F;
	Thu, 24 Jul 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="km8uCW22"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2132.outbound.protection.outlook.com [40.107.103.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F822BE7BE;
	Thu, 24 Jul 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349139; cv=fail; b=dUgxz/FyJUL6eSX4eR/GUQTw4m9UdgD/gMpBKkEigD+7HwCDSW2y9HYILB1Ejl/TWtwbWCDANgb5SEg3f6USTRMCbbXPM9s3D6YJewwWWh1iDNW9zwAcYVmPHLr3mF4FD23C5c/IHFLZx8/FxDYWLkjxjW0cdxEpm5vhPA5m4OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349139; c=relaxed/simple;
	bh=qP19QcMrnGr/eikgZjiZrmIhDoBUEac3rNggxHSPyw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brc3ompLQkgACKdSG1Da2cAuPHCsWYUV0NDJl79VR2muk1KJGqVDUmC/hGeqmVXXTlQQZw9OzCaX1A5XMzJijQ31B0/yjJJQOC60EJXbyIqJyWz16NZEID8kMKLF1k0YsMMb/wLMAmJ+Wmp2aFHIw/lj6JKNgwYygidKaPhAq4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=km8uCW22; arc=fail smtp.client-ip=40.107.103.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOwmbcitWC9ypK55X/91PQZcykqMCE7ceivn8zo1HNe3VBTGOI4Lq/omuBpwmFvR8aFDdFA3vIxGqRenvHsTDMwKGH4r6ruLUboRnwsSMvmRx2xcwJ1i6kkNXTeLL4zAf8jYU8eIJQgZFLE94tlrDvyFSopyJs6NyZw6aK3FjI3L9PST1dCtMkBH957AnvLW7ECD9IN0tVKc+VaahIxuZqucrC1WxN8E+GmBKCcr0GPfttTZdycvdGV+6x04ifldRHisJe3czeOoqV8EfET/VlRqiULVmV/lp9lbaBSwtl+1KEmP0YYSefUk/FF5Fg4GfCfuQSYWFAftEGGG3PaoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoshB1q1XQ5jDb8MLEQPfOFsESmHVe3yzFtRrfO11gU=;
 b=Gk5ijVM/ckhvJZ7pb7ZzEo7PGHeK0gd6AfKd5gfFl4VR6EAICUo/81RnJTBOoT6yHxeZp02e5qpZEYcXyWVW1CXXhguije5e22VbeSwaNgXesBSoIufddP+ktE5h+Sa+Wi7U2jSjCWJfSEjqJh+AnHoLRvzxGIhmvtjto7Vmxo6mOytcVaLbfOie1gPgRe2LxbOcRw8sSp6rqBHmoudGysLIwJTVbMTj9Mz/ZC59khfbm9DNtQIuu+jxiWWJmL9oVjsZHWWLchHUJPbxb9/Zi/rvx9ZZmmDcJAJo0AVtuW1i6MrDHOURkW4sOkhmR5Gu5YGvUsmwm6lAgXEVxn7EBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoshB1q1XQ5jDb8MLEQPfOFsESmHVe3yzFtRrfO11gU=;
 b=km8uCW228bbjzBdbDP7/uf0y12RqYWZsxA3aFx3O2qMr5UN3XYJikdObzdW3+wCIVVXgpYZG2oNNkkC9Bjh/NvWX34kj0PMR3/1nT9US1lw1tL/zM5GZSPq/9/Pm0mUFnJlu7IJ5GGD1Cx7rYyzC98grCo8ENTCNLOFxny8Ei6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:26 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:26 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 06/11] can: kvaser_usb: Store the different firmware version components in a struct
Date: Thu, 24 Jul 2025 11:25:00 +0200
Message-ID: <20250724092505.8-7-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: b720b16d-304b-4abf-72fa-08ddca9405f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5GDmXwCPNDEOgDTe7nnkFhO5IfT/CX8Abcr+ej+/MVux6MlSO/9aCWfO78d?=
 =?us-ascii?Q?/bBwRmRyE7HWYQMvbyJwy/JI2YNWcWE1qt/UZ+NDqxV2ejlLy+X3YMoM1JiZ?=
 =?us-ascii?Q?MSC7TistAGK0i9oax2JTCqZDulkkOXr0ExTubG6DS2OrVGEJyUAzosX/6ZWO?=
 =?us-ascii?Q?7JBvJZnmxo9OceTptwdfMEJYMKAuN5VrZSBB53iNQU57JjaL+7GIPyjP1tWQ?=
 =?us-ascii?Q?qOD+nWVDVjNyoyQwgxObDOMbAQEn+NF6RGMOoqo1s/0Q26eAkgq2JUTJpgem?=
 =?us-ascii?Q?gwm8KlO5WWC4eGtzSZ/sPf8cnQ4ZKCHYpiWdNm38MkEttK1sxvjDperW1hau?=
 =?us-ascii?Q?lCJjjnnGF7sZTp8zlBckpmd0NyynYMxFVu88at/b+hxMMKtJE1wpletbsBRk?=
 =?us-ascii?Q?84a2Kr1HBkP/JtozmiNa7sF1n5c40ANAlNv9ozK2roHERpj7i+eV8ggX0eJX?=
 =?us-ascii?Q?m3G7wv0CBKOmlpPbfDwFCoBDTYY+ON0V4ijaRmHogaKVafSbiRG0vLZKJAQQ?=
 =?us-ascii?Q?8vkE7+w+oPfMTrOGkufmaWh1dlFYuBiBRstSZkzX8Qh2NVWA4alwR9B+jocc?=
 =?us-ascii?Q?ZgLExtZKuCrluqXjGILhGHc1+z6PxYSEwrVfeBgb5pdFvW6rrfvvfncFKY7F?=
 =?us-ascii?Q?HU/EQzuQ8HZfn+55Vw5kQVSZm7mNI7m8Rnh+0F5kVr1H3o9zi/hoDNSCBclO?=
 =?us-ascii?Q?kXk737VQa25PyYUQAgqKLGHfkkvlXc8VFT8RS3eYS0EOieWdQ1VHQ40PYfR8?=
 =?us-ascii?Q?OyEQ7VNxQ69OCxQx4LL+VEO5yWHIx1rrKlTj3iAqBjnoFmbz69zxKtlHPom4?=
 =?us-ascii?Q?FiVhSuHQIX/mMX0RVs7jW2xxJyizAYEfOv4b9K3g41bFEAeVptTdHIhx7k/u?=
 =?us-ascii?Q?UquzOm/YgffgjMlREYHyFdTqNupiumsSG1TLVDcwHGGCfYPAvqBJ+/deFK48?=
 =?us-ascii?Q?hcoZxi1HYFE25v7dcGhdiveblDd8M4vAqxHkCpZVCrKQFLwjP0f+B34d+eth?=
 =?us-ascii?Q?CizZf5YIB/Zx+UjQPrfsyNv3/6ltmaND4kWq+9ROkkPvYP/505DHT49CbU1a?=
 =?us-ascii?Q?/auudAFtb0f4JULJpSEL12pBGAcdkMXxzXCrgeJ1/zisyWYnIf88NYN6yZ/h?=
 =?us-ascii?Q?SzwT2qPnB8wwwBVplCeaMJ90yMsSabFLSeZaRWVBxFCw1iLetBUHE4iS7Xw+?=
 =?us-ascii?Q?RfPf+k8ngLJ7vQP06UmOABx43UTtVQQytLcxfKZDrrPaJovvB8tedO9bJW27?=
 =?us-ascii?Q?0OXmrKM2sjdX1la3qfb7AUdSCworGIgsjEW2RsHiLT22QJJOEUFXK9elsb/E?=
 =?us-ascii?Q?+R7b2pgl0zI2wUP1dt7Sf7i0v4S49lH76QQ1CT+ghiKj/oJ9FlQBjDaqfo/r?=
 =?us-ascii?Q?c/iOJuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vw6X5ip0oLRMlq91f2EU+d1bpILuefhA5QXplmuVgqw0KfZw3RxwqujN44NZ?=
 =?us-ascii?Q?910kfQFnpheD5OwkOmAevWekNB6asGgrj6Zm/ZJRScSsnoP4UxCqZBVCpqU0?=
 =?us-ascii?Q?k01v7FqIvphQW6K5HN5f167ACwHpI6rOMeaN3tMluw0c4lYvB+3m01eGOWpT?=
 =?us-ascii?Q?Tgv4HzvDHlcfVIfY4tg6DU8zKCxbTVZHck+5dI0o5twX3XTg8sG+T+856tCz?=
 =?us-ascii?Q?X/PZbPedQQsdITSogQIZZwMsH6cAKrUuq7qC9hyMRjBjBp/wI17YQVne2i2Z?=
 =?us-ascii?Q?k5ot6UnRNh4PzfZyY4nKv1afNoCi1hdm7qvpaDLONW4aEV/t2tdLrw8ZCCDy?=
 =?us-ascii?Q?33103RJQ4+Dwt8fhWdbQgrxg/CbbAkIAkyzEA6+NgoGthNeyQaHSuKJwE36C?=
 =?us-ascii?Q?mc15IgFVBBAAlOHiHgz46AAcVySrgdGULudFR4f5894j+nO1gHDXg2SruZzt?=
 =?us-ascii?Q?zDB8QELFtYvZcEXJ4M2wFw+L3qOXUV8IBdVTTu7meiHA/56+8dCg61dIh4G0?=
 =?us-ascii?Q?YPwbFgdP5WoddR1E0icHzXOsx76wr4i4xAGpb2BUPwo32CbvjILiqPApWiHk?=
 =?us-ascii?Q?OhReHIzcRJCaRO6WJ9VPn7xNpUo4IvXEfFCrPrYXGYGQ62Ga5brbDhTvMvAx?=
 =?us-ascii?Q?ot3aKUqsyyhKhqCeLj+6LR8Tp3gVU/RNBt8YIECIUljxaFL8uLxo72F3ZnKn?=
 =?us-ascii?Q?lv4Kl2HTTMuJO4eEYGFOEHY3t3J3VfTv7BBssEfKb6JbYZP3eX4lPT3yE3t2?=
 =?us-ascii?Q?xECAD0iFcY/LTauJ198ObIMF1dvqRuPX/o/h41kfe6uX6IyfXCqOlKtuwHEy?=
 =?us-ascii?Q?e7qxuy7KOKAaFioFRuX7Mf1xrC9H45lJutzK8uX/q5RWoFtrKainEoiBMfrB?=
 =?us-ascii?Q?qeYePAf9LsQp6Nyr9CdsJhtps4k45BlF4KU7ghyeFOGJGwQgqyecf20JI2eb?=
 =?us-ascii?Q?C++hc2sGvUnnTgxQ6eGQOjj2Y7fQE903w8QsNuTus1CWaeztucfG/FgUk7nl?=
 =?us-ascii?Q?v4XbceOt/jVHRfagPoaCJIpBHx4nLIwj3FQFL2xb3cqowIbXb/4l/aJltNqu?=
 =?us-ascii?Q?25sdDNdJEDjhBmUfqkCYIH/7OhqUiNpHlyz5Qv8+5TDUQrZOCPfdpxh6DNyM?=
 =?us-ascii?Q?rpDv0Djs3bf8Q2APuZhnUs/uRjlsXbef5mSrD24pqLRuQ8RPBKMC+lv+ouxy?=
 =?us-ascii?Q?nn0mwLwMJjUEIPCJQUljy+12t85+5Iyhr445zz3kT5gWo55YY7d4GfFey+ny?=
 =?us-ascii?Q?tI+atGRArLJd97C81fxty0MEOiS0MDqHm+8Gw2Q+bkvSFPiWGAzqGNsPz7gW?=
 =?us-ascii?Q?saSoMpiO3i/n9mTGy0nSbKV874onioufeQF+tW7gifQXt+msG+Me6HJIcOSe?=
 =?us-ascii?Q?oIcl0D5Y9iDzxitCxfSO0ap3JsAS3vz5Fp2yajc1uViVdiQJCqkVRGYN1yNu?=
 =?us-ascii?Q?T8vjX+OX+/0xzw/Q8TZU5MlZUWUCNJqAMWsk64dQub5CToNBzBLIKwsbldwL?=
 =?us-ascii?Q?3pTv9Qf3CO6+72k1Mh3+xCRTCeUL7Z5jh3Sbbu3BN13KIE7fw/B59By64xAt?=
 =?us-ascii?Q?TxerwQXBWL0mVcFAFn8HQ+cb1WN8pB5qz60HQaEra1hcdmQpjxpv1mzi6At/?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b720b16d-304b-4abf-72fa-08ddca9405f7
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:26.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyWRNfPMVjKcjmRLQ0V3OYYVaebFYo395QBA0Fo6Q4vmJkgDhYeJ72tdvGwtV+HfCzf7LWIxILtuQwz/wN2lGq9eh5pvH2l7fWKX7p0utuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Store firmware version in kvaser_usb_fw_version struct, specifying the
different components of the version number.
And drop debug prinout of firmware version, since later patches will expose
it via the devlink interface.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Drop debug prinout, since it will be exposed via devlink.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m2003548deedfeafee5c57ee2e2f610d364220fae

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 12 +++++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  5 -----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 15 +++++++++++++--
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index fba972e7220d..a36d86494113 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -47,6 +47,10 @@
 #define KVASER_USB_CAP_EXT_CAP			0x02
 #define KVASER_USB_HYDRA_CAP_EXT_CMD		0x04
 
+#define KVASER_USB_SW_VERSION_MAJOR_MASK GENMASK(31, 24)
+#define KVASER_USB_SW_VERSION_MINOR_MASK GENMASK(23, 16)
+#define KVASER_USB_SW_VERSION_BUILD_MASK GENMASK(15, 0)
+
 struct kvaser_usb_dev_cfg;
 
 enum kvaser_usb_leaf_family {
@@ -83,6 +87,12 @@ struct kvaser_usb_tx_urb_context {
 	u32 echo_index;
 };
 
+struct kvaser_usb_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 struct kvaser_usb_busparams {
 	__le32 bitrate;
 	u8 tseg1;
@@ -101,7 +111,7 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
-	u32 fw_version;
+	struct kvaser_usb_fw_version fw_version;
 	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 46e6cda0bf8d..2313fbc1a2c3 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -963,11 +963,6 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (WARN_ON(!dev->cfg))
 		return -ENODEV;
 
-	dev_dbg(&intf->dev, "Firmware version: %d.%d.%d\n",
-		((dev->fw_version >> 24) & 0xff),
-		((dev->fw_version >> 16) & 0xff),
-		(dev->fw_version & 0xffff));
-
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 758fd13f1bf4..4107b39e396b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1839,6 +1839,7 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 	size_t cmd_len;
 	int err;
 	u32 flags;
+	u32 fw_version;
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
@@ -1863,7 +1864,10 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 	if (err)
 		goto end;
 
-	dev->fw_version = le32_to_cpu(cmd->sw_detail_res.sw_version);
+	fw_version = le32_to_cpu(cmd->sw_detail_res.sw_version);
+	dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK, fw_version);
+	dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK, fw_version);
+	dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK, fw_version);
 	flags = le32_to_cpu(cmd->sw_detail_res.sw_flags);
 
 	if (flags & KVASER_USB_HYDRA_SW_FLAG_FW_BAD) {
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index a67855521ccc..b4f5d4fba630 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -741,9 +741,13 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
 static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 						   const struct leaf_cmd_softinfo *softinfo)
 {
+	u32 fw_version;
 	u32 sw_options = le32_to_cpu(softinfo->sw_options);
 
-	dev->fw_version = le32_to_cpu(softinfo->fw_version);
+	fw_version = le32_to_cpu(softinfo->fw_version);
+	dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK, fw_version);
+	dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK, fw_version);
+	dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK, fw_version);
 	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
 
 	if (sw_options & KVASER_USB_LEAF_SWOPTION_EXT_CAP)
@@ -784,6 +788,7 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 {
 	struct kvaser_cmd cmd;
 	int err;
+	u32 fw_version;
 
 	err = kvaser_usb_leaf_send_simple_cmd(dev, CMD_GET_SOFTWARE_INFO, 0);
 	if (err)
@@ -798,7 +803,13 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 		kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.softinfo);
 		break;
 	case KVASER_USBCAN:
-		dev->fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
+		fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
+		dev->fw_version.major = FIELD_GET(KVASER_USB_SW_VERSION_MAJOR_MASK,
+						  fw_version);
+		dev->fw_version.minor = FIELD_GET(KVASER_USB_SW_VERSION_MINOR_MASK,
+						  fw_version);
+		dev->fw_version.build = FIELD_GET(KVASER_USB_SW_VERSION_BUILD_MASK,
+						  fw_version);
 		dev->max_tx_urbs =
 			le16_to_cpu(cmd.u.usbcan.softinfo.max_outstanding_tx);
 		dev->cfg = &kvaser_usb_leaf_usbcan_dev_cfg;
-- 
2.49.0


