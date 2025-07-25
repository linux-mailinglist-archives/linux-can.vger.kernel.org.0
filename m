Return-Path: <linux-can+bounces-4138-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10977B11EB5
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C0E1C26977
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393C2ECD33;
	Fri, 25 Jul 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="VwEKk8LB"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3782EBDF7;
	Fri, 25 Jul 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446911; cv=fail; b=pjV4ZpGUV5mEO8DMFcEgYrL0BHAEhamF50X5IILmiJlo8xHnHamjx+gRxgmM5ylt0Iwl04FMuzBh41VumsoT0GaC3poZS4/rH497e2D1YO7ArUSuctWiZRYEAyxU2zGtLYyuoe+feqB3ft2uQ8K6Vki2+cyrv7tWTPIehQua0JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446911; c=relaxed/simple;
	bh=W56PYIj5OVe8mq9yOG6jWNV8XLjxQ2L9qflJgDwTyMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ext+jS2SHKEj9944VUnRekc4Q7aHJfbHYwDHB3fPXOa1oqGjDYz/aZ6qy8nHQ2H6bgzzBOEWb2cq0vrLVR35OE/aIlCYwL7Z2xlGjmuLD03+dLbMjCc5N8K4yFjqMboQFlC012/aSpLFrAn/oQAJBBIjDaLVB/9j0DwftQ/wwdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=VwEKk8LB; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuoP/yhMATQKzfdycC7B3FNdPnaf4PL/OiqhsdS1zRX9/zFhldzKvHlxc8azNX3oRlCc0I8uHJXbuvQ5Ph6dOfcQyeSyeNByakKTPVtZtMXXpFVZCujqfx2Bl8fJyjw/yDRhJ+vhT7MpmM3JD/DCCZplN/WuMBQzuWDcl8LzOmR8tWZtoqaPYPK3VHqAYb+KBJsDV9uBmf+19f3AQAKgjzx4YFFC4MDlQX8O618IcNluKRVAhAMrwLPBVay28xUuNttuNsjuFAe7mU66rKReFuwbClWAHofd0qPaVVmUljVwLqRpFJogMlnxKD3dAKTQUAEaaydgSGwLTMf3vDglng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3DnSK7ebwPEsQ4o31CWywbZB4AqfpS6UsFBgsyNht8=;
 b=Iygri+A81l9DtSUcGk+XvVdWYUnXWUMM96dMzMyBuUjHZKM4cQrr7APV6YREYO4XQ44HNXtFbzpzMRv6EqEAc0bKZ/RCVXfNbt2J2hr8lP2SVnODvQOE/L1HtGAdR4sIvHHBKOlOsJ2lQ7FGv1j+muQYBPgtf2e4sd2Flt4xYVbNZmo3DyTQmlEelV5r/Xs+2rqT+1cyU3A7C6kFztMps9liIi2etxHunybkqPi1Bw6BiAthoIDSxkAmaQ1uOXhCtVoVQwf/EprvEUyIfJhgKq7OuavYyPPn7xYN50vBUB5PanrTpaLYR0+hsBc8vEAm4l1GNoTL3HuQlXZ0F3/ONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3DnSK7ebwPEsQ4o31CWywbZB4AqfpS6UsFBgsyNht8=;
 b=VwEKk8LBr54jAqKRkBJmPR2E9l/fwDCH+r56mwe2jxH4jMMxzozIkU1qnRiRnP4Dj2vC5ZPTmhbGs0/hgsq8L4u6xEPVEYHOTiPRsl8LdTJTZWx0CAlYePdjtJQ6sIlih0GdP7OmDNYkwY9sY+4SmH5Bl8PyEuC9KylGh+EPBB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:01 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:01 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 01/11] can: kvaser_usb: Add support to control CAN LEDs on device
Date: Fri, 25 Jul 2025 14:34:42 +0200
Message-ID: <20250725123452.41-2-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e8608b-5e0f-4f82-6b7a-08ddcb77acb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJkOgp1ZK+6IEnQ8GN8W0PF2pnKuoTJMBIo9L2Gi6Qbrl7Ih6C6fF9B7tR4c?=
 =?us-ascii?Q?QUZFn87eRT+bTtYusfEcFk8koAynSFE6aimNJJpk49aeAX9pxIMzIYAt+W/P?=
 =?us-ascii?Q?Kn77h7QDOieKhylLIm5demtXwKDnGpQBhJ1JKMTx8V335nNkqzaOPRKai6Mz?=
 =?us-ascii?Q?dToAN5ZhfTXPW2WIegCKInk0f3koaUoOwuP/O35V1vY7vJbpIjrvdjETpSha?=
 =?us-ascii?Q?in01GgjcusgA1bGEq3fxJQonQTi5OpbPm9L7hetsrHK2dIy9OkwN1VfJ5+YS?=
 =?us-ascii?Q?uG/oCy3b0rCLzgfmlGxR+ZTmGMTZ3c49fybq27ZVZpGNS597lCz9N88QCUkN?=
 =?us-ascii?Q?jwcV1g6errDA4sHog/eGMa4AWtJ2ic9JYmY54zFnIeHJeIGYfA5JfY3jcAw9?=
 =?us-ascii?Q?YNWY/FVFfUBy0idJwh9s1eH7Up/z5JXgpiShIoapa4lEPAjaOhvEAw2e2QcH?=
 =?us-ascii?Q?mP3nhoX5FwsyqsKaoSaH6ZTytsa4jHVH3Jj+suUrJnKT5e+aFpfyTHWT9xIx?=
 =?us-ascii?Q?dVIlndrtTMhF1QeNtk3/GlQCcTg4cP/ASvG0wPw/yuQUTC875y4XeF0HRNWz?=
 =?us-ascii?Q?Ag4537IObVuzo5oExSIg6U5yAU0+rFzNTrQBn0cAGbJSLMd5kXeUw+DF3t5A?=
 =?us-ascii?Q?H5svP7b0AzU4YzKCHsXXM9nbcJ4B7fiIqFYWBCAefze5QSFvvPPRVA2IUEvu?=
 =?us-ascii?Q?ixmvVx7ctK5nMmXJOeYreumfmJBvdeSgQlqOMGKZV+tYOk6DvoCjpTdW39Ty?=
 =?us-ascii?Q?bS8toynL8a29VGyjpanBYgTuF4i0lMUuMPWTMRwZRInAnofoBWA4WMVgvdob?=
 =?us-ascii?Q?3QHLO0OQzkTC6fb2hgVwJQjjTQB/t3IcriQtZCIfSmbcKekCIdKYcTZzWyCR?=
 =?us-ascii?Q?QzsDgCCyYzmlmPf5E/s18jKfCVWvkdIK8ocQ399PVaz6mkCkbQbhEtZKmlEc?=
 =?us-ascii?Q?VLd9Wf3MKCg1fTdoR/hWBu8QK+koR0KmrixoCJlUtsXCp/jAWwVn4dGwrDa1?=
 =?us-ascii?Q?SIEGqIUUm/y2lJuE820SgxOffW+KQ1sH0YI063GAG2CIuraxHha+l5QkB3o/?=
 =?us-ascii?Q?+vDFlJdRUB6K1KiqIhW0q32yaOLGs+d8oZo/vLp+4DbBiwsb3KnxrNhe1oKQ?=
 =?us-ascii?Q?Zkc71KB0Uu2iwFVMWOVdmAxgbFqwfrE8KZC4ut0X37WI193lmu1Qa4N/43OL?=
 =?us-ascii?Q?t1e+kO1KP3gtgeU4Zl1CvEhIfuD25mKYtqaVvFktnVr3jvZ8vpZHoiAjVaka?=
 =?us-ascii?Q?G3Et0DFhG2QlEN0bLWQDozqnkzS24GP7rXMyAQRk+coUAxL05eU/MZlY7zvN?=
 =?us-ascii?Q?9vpuasyNDtVnjq2g5CXuactwxWxjRWkq9kINyVvgrFmJMScMWSOn5IvkrPsA?=
 =?us-ascii?Q?oObKp/eypVOTw0Sp2Y0chEObMIla6pRVyLAws4bdJNNmnB/kCZGiHRoR/l9z?=
 =?us-ascii?Q?zkMAZbYjjhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pK1xAcrZpzhiH6YLT+BLQAY4l4qvzI8G2sMh74p0BfpNHhMUuP+x0Eo7cUO0?=
 =?us-ascii?Q?YU6yEufC5fM4/iYwL41WfJVap/i4hC641mdSxckjOImRjy0CqtCZJu4M8g+V?=
 =?us-ascii?Q?0ZOWZDoBVkk9DQ20/4c4uPPg97DKzZZ1tfDp9Uk2e2Trbe0WTnXjQ4CzxEC/?=
 =?us-ascii?Q?M3/q8oH/TJN4NUynNqNyFnRTU1ApMKKySPIAOMrSRy+FhQkiiTh15+MPFi0I?=
 =?us-ascii?Q?nPh6sx2k9f31+4HQmiKCVTtfnmxJMNbDmAZUpoCpUebVTRDXrDiQo1otFWv1?=
 =?us-ascii?Q?Y77XOr/lokukgLHL9jH5DcBotZgtl3zv+K8ZNcyUIHQkWfEqXqnrnZIshyUc?=
 =?us-ascii?Q?9jXFP1zOZbVVpkiclF0clr7qJ4TOWDDyx4VrhxmGYRcH24m2rmO76KadJQiX?=
 =?us-ascii?Q?lN8mHX+Q28WAyYfs8NIslnGB8NBsuXsTEfE9CxfYJsmBPKmPXqj/vimZ733y?=
 =?us-ascii?Q?DSdIyMEsscPfLo+xQDh9K5IqDTQYTOVfYhda7UL8AslhlpyVipD8aIjx9zaP?=
 =?us-ascii?Q?J18RUy1mTumipXdH8eaoUY12yUEEMugPOiJcSX6RP0en3qK2XdMUfpHICFQT?=
 =?us-ascii?Q?zXz7H/bKjGzDCuQqJXrYXsPpaCRpx6lxLMR0JXaTQWTx0j16m6bnDo6wlpkf?=
 =?us-ascii?Q?/aT1zLTCcI+QMJXjEZpDGNPLLLcAzXGh3LZ8mQBwYhRoBYqDYb1GXafgpMue?=
 =?us-ascii?Q?UApEwoG/O5SLVSg6SM8kL1XRaY3e8u0qA9aPZ8HnCVtAcen1uHRFB+SMCHZ9?=
 =?us-ascii?Q?MxmAaeg7SZcR4VTXXwdvcGdPmRPJVZatCmExaf9BTs0HTh87Z8Xi7ciGSEQq?=
 =?us-ascii?Q?MWVB3IMipzdJtf3emmxBVFkzrmBgcsZsfsliLlb5oTguVhOba1dmeUOzHUjf?=
 =?us-ascii?Q?WG2vADHA7K0hmwXesvgo1e1/fKluPZpfS3d3WPbQrjWG9UIXofaHXafGJmu0?=
 =?us-ascii?Q?fGsOWI7C3aKuQyU4+Jr7zh5KTmlHSKvNWmk/zO/rQHhhyWD1nLfagkdQiVRg?=
 =?us-ascii?Q?v0gRIO7359ZkDY+RZ0l4uVD6urLbALijVdc7yL2IoTk1Jc+mxHKWNmWMpl+q?=
 =?us-ascii?Q?B1LXp4lSRMKrNf5oai32n5FCzea5broklNjUIZW8ZMNt31mACXYq7qOqLCfW?=
 =?us-ascii?Q?Wk/OUKW33nTgCN0JYavjO5Z5Ku9H/bPXE7n9t1DzlxwsHu0BqNbWsFJ17fdD?=
 =?us-ascii?Q?3JQimdQJ7tlJiRlIpY66fURY3FUA9agZieuExU4jF1ezSI6wktUz2LWCExZr?=
 =?us-ascii?Q?VpKthlhd2hVUIXJ6b0JNpjCAw9OobJrqzgxcXctYU9nqLicH/0ETmpopu4Pr?=
 =?us-ascii?Q?KniHdyEOkOtwk60iV1fbPiKeMBhkUWrBQwe8+SlO9291sLkpIkFjyZ7EMpDp?=
 =?us-ascii?Q?cVneQzeor44PvC9S+TyHhhHF28ssMpnBfeyh6WehjzTvilJ9a4bM1cn2ncWN?=
 =?us-ascii?Q?dVsMdTVPvEqgQw8s0AewxtHke1CE6cnNiUROHEPh3+yG2XsrDLotrk38luGU?=
 =?us-ascii?Q?A8DEORkT2iMHdmz0dv3D6MeBOlG2hdy0D9PL0yxkIw1Ed0YAVnqgYF59oaP5?=
 =?us-ascii?Q?L0GQzwYNEEfyNivhTOhKMrk8ZxeFT4P05p12siWcq1GUsPWYb/UF4FKNoMFc?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e8608b-5e0f-4f82-6b7a-08ddcb77acb1
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:01.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6y2dqs0A9FcYJhb2J7SQ9T5Ke1QaLdWMIlNN5iTAtPeQ9rQinnhZBPxNvokoQLTp2fiKRyHzji0hH2LreFwd/8usu52H4TkN6snQs8JOJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Add support to turn on/off CAN LEDs on device.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Fix GCC compiler array warning (-Warray-bounds) reported by
    Simon Horman [1]
  - Add tag Reviewed-by Vincent Mailhol

[1] https://lore.kernel.org/linux-can/aa90e02d-25d5-4f76-bd91-26795825c8a6@wanadoo.fr/T/#m1ea1889968a91b2610990c7f39feab74b72b4850

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  9 ++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 53 ++++++++++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 54 +++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index f6c77eca9f43..032dc1821f04 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -54,6 +54,11 @@ enum kvaser_usb_leaf_family {
 	KVASER_USBCAN,
 };
 
+enum kvaser_usb_led_state {
+	KVASER_USB_LED_ON = 0,
+	KVASER_USB_LED_OFF = 1,
+};
+
 #define KVASER_USB_HYDRA_MAX_CMD_LEN		128
 struct kvaser_usb_dev_card_data_hydra {
 	u8 channel_to_he[KVASER_USB_MAX_NET_DEVICES];
@@ -149,6 +154,7 @@ struct kvaser_usb_net_priv {
  * @dev_get_software_details:	get software details
  * @dev_get_card_info:		get card info
  * @dev_get_capabilities:	discover device capabilities
+ * @dev_set_led:		turn on/off device LED
  *
  * @dev_set_opt_mode:		set ctrlmod
  * @dev_start_chip:		start the CAN controller
@@ -176,6 +182,9 @@ struct kvaser_usb_dev_ops {
 	int (*dev_get_software_details)(struct kvaser_usb *dev);
 	int (*dev_get_card_info)(struct kvaser_usb *dev);
 	int (*dev_get_capabilities)(struct kvaser_usb *dev);
+	int (*dev_set_led)(struct kvaser_usb_net_priv *priv,
+			   enum kvaser_usb_led_state state,
+			   u16 duration_ms);
 	int (*dev_set_opt_mode)(const struct kvaser_usb_net_priv *priv);
 	int (*dev_start_chip)(struct kvaser_usb_net_priv *priv);
 	int (*dev_stop_chip)(struct kvaser_usb_net_priv *priv);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 8e88b5917796..a4402b4845c6 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -12,6 +12,7 @@
  *    distinguish between ERROR_WARNING and ERROR_ACTIVE.
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
@@ -67,6 +68,8 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt;
 #define CMD_SET_BUSPARAMS_RESP			85
 #define CMD_GET_CAPABILITIES_REQ		95
 #define CMD_GET_CAPABILITIES_RESP		96
+#define CMD_LED_ACTION_REQ			101
+#define CMD_LED_ACTION_RESP			102
 #define CMD_RX_MESSAGE				106
 #define CMD_MAP_CHANNEL_REQ			200
 #define CMD_MAP_CHANNEL_RESP			201
@@ -217,6 +220,22 @@ struct kvaser_cmd_get_busparams_res {
 	u8 reserved[20];
 } __packed;
 
+/* The device has two LEDs per CAN channel
+ * The LSB of action field controls the state:
+ *   0 = ON
+ *   1 = OFF
+ * The remaining bits of action field is the LED index
+ */
+#define KVASER_USB_HYDRA_LED_IDX_MASK GENMASK(31, 1)
+#define KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX 3
+#define KVASER_USB_HYDRA_LEDS_PER_CHANNEL 2
+struct kvaser_cmd_led_action_req {
+	u8 action;
+	u8 padding;
+	__le16 duration_ms;
+	u8 reserved[24];
+} __packed;
+
 /* Ctrl modes */
 #define KVASER_USB_HYDRA_CTRLMODE_NORMAL	0x01
 #define KVASER_USB_HYDRA_CTRLMODE_LISTEN	0x02
@@ -299,6 +318,8 @@ struct kvaser_cmd {
 		struct kvaser_cmd_get_busparams_req get_busparams_req;
 		struct kvaser_cmd_get_busparams_res get_busparams_res;
 
+		struct kvaser_cmd_led_action_req led_action_req;
+
 		struct kvaser_cmd_chip_state_event chip_state_event;
 
 		struct kvaser_cmd_set_ctrlmode set_ctrlmode;
@@ -1390,6 +1411,7 @@ static void kvaser_usb_hydra_handle_cmd_std(const struct kvaser_usb *dev,
 	/* Ignored commands */
 	case CMD_SET_BUSPARAMS_RESP:
 	case CMD_SET_BUSPARAMS_FD_RESP:
+	case CMD_LED_ACTION_RESP:
 		break;
 
 	default:
@@ -1946,6 +1968,36 @@ static int kvaser_usb_hydra_get_capabilities(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
+				    enum kvaser_usb_led_state state,
+				    u16 duration_ms)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_cmd *cmd;
+	size_t cmd_len;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->header.cmd_no = CMD_LED_ACTION_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+	kvaser_usb_hydra_set_cmd_dest_he(cmd, dev->card_data.hydra.sysdbg_he);
+	kvaser_usb_hydra_set_cmd_transid(cmd, kvaser_usb_hydra_get_next_transid(dev));
+
+	cmd->led_action_req.duration_ms = cpu_to_le16(duration_ms);
+	cmd->led_action_req.action = state |
+				     FIELD_PREP(KVASER_USB_HYDRA_LED_IDX_MASK,
+						KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX +
+						KVASER_USB_HYDRA_LEDS_PER_CHANNEL * priv->channel);
+
+	ret = kvaser_usb_send_cmd(dev, cmd, cmd_len);
+	kfree(cmd);
+
+	return ret;
+}
+
 static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 {
 	struct kvaser_usb *dev = priv->dev;
@@ -2149,6 +2201,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 	.dev_get_software_details = kvaser_usb_hydra_get_software_details,
 	.dev_get_card_info = kvaser_usb_hydra_get_card_info,
 	.dev_get_capabilities = kvaser_usb_hydra_get_capabilities,
+	.dev_set_led = kvaser_usb_hydra_set_led,
 	.dev_set_opt_mode = kvaser_usb_hydra_set_opt_mode,
 	.dev_start_chip = kvaser_usb_hydra_start_chip,
 	.dev_stop_chip = kvaser_usb_hydra_stop_chip,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 6a45adcc45bd..a67855521ccc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2015 Valeo S.A.
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
@@ -81,6 +82,8 @@
 #define CMD_FLUSH_QUEUE_REPLY		68
 #define CMD_GET_CAPABILITIES_REQ	95
 #define CMD_GET_CAPABILITIES_RESP	96
+#define CMD_LED_ACTION_REQ		101
+#define CMD_LED_ACTION_RESP		102
 
 #define CMD_LEAF_LOG_MESSAGE		106
 
@@ -173,6 +176,21 @@ struct kvaser_cmd_busparams {
 	struct kvaser_usb_busparams busparams;
 } __packed;
 
+/* The device has one LED per CAN channel
+ * The LSB of action field controls the state:
+ *   0 = ON
+ *   1 = OFF
+ * The remaining bits of action field is the LED index
+ */
+#define KVASER_USB_LEAF_LED_IDX_MASK GENMASK(31, 1)
+#define KVASER_USB_LEAF_LED_YELLOW_CH0_IDX 2
+struct kvaser_cmd_led_action_req {
+	u8 tid;
+	u8 action;
+	__le16 duration_ms;
+	u8 padding[24];
+} __packed;
+
 struct kvaser_cmd_tx_can {
 	u8 channel;
 	u8 tid;
@@ -359,6 +377,8 @@ struct kvaser_cmd {
 		struct kvaser_cmd_cardinfo cardinfo;
 		struct kvaser_cmd_busparams busparams;
 
+		struct kvaser_cmd_led_action_req led_action_req;
+
 		struct kvaser_cmd_rx_can_header rx_can_header;
 		struct kvaser_cmd_tx_acknowledge_header tx_acknowledge_header;
 
@@ -409,6 +429,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
+	[CMD_LED_ACTION_RESP]		= CMD_SIZE_ANY,
 };
 
 static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
@@ -423,6 +444,8 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
+	/* ignored events: */
+	[CMD_LED_ACTION_RESP]		= CMD_SIZE_ANY,
 };
 
 /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
@@ -924,6 +947,34 @@ static int kvaser_usb_leaf_get_capabilities_leaf(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_leaf_set_led(struct kvaser_usb_net_priv *priv,
+				   enum kvaser_usb_led_state state,
+				   u16 duration_ms)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_cmd *cmd;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->id = CMD_LED_ACTION_REQ;
+	cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_led_action_req);
+	cmd->u.led_action_req.tid = 0xff;
+
+	cmd->u.led_action_req.duration_ms = cpu_to_le16(duration_ms);
+	cmd->u.led_action_req.action = state |
+				       FIELD_PREP(KVASER_USB_LEAF_LED_IDX_MASK,
+						  KVASER_USB_LEAF_LED_YELLOW_CH0_IDX +
+						  priv->channel);
+
+	ret = kvaser_usb_send_cmd(dev, cmd, cmd->len);
+	kfree(cmd);
+
+	return ret;
+}
+
 static int kvaser_usb_leaf_get_capabilities(struct kvaser_usb *dev)
 {
 	int err = 0;
@@ -1638,6 +1689,8 @@ static void kvaser_usb_leaf_handle_command(struct kvaser_usb *dev,
 		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
 		break;
+	case CMD_LED_ACTION_RESP:
+		break;
 
 	default:
 warn:		dev_warn(&dev->intf->dev, "Unhandled command (%d)\n", cmd->id);
@@ -1927,6 +1980,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_get_software_details = NULL,
 	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
 	.dev_get_capabilities = kvaser_usb_leaf_get_capabilities,
+	.dev_set_led = kvaser_usb_leaf_set_led,
 	.dev_set_opt_mode = kvaser_usb_leaf_set_opt_mode,
 	.dev_start_chip = kvaser_usb_leaf_start_chip,
 	.dev_stop_chip = kvaser_usb_leaf_stop_chip,
-- 
2.49.0


