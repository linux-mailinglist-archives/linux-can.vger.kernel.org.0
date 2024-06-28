Return-Path: <linux-can+bounces-868-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635091C6EB
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F891F244F8
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5DE770F6;
	Fri, 28 Jun 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="hK+qoWZB"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF21770F0
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604553; cv=fail; b=AaAcAkvpHL+RqLaR8Eutt7+A9CLhg7D7ZB8J6pzMX0xB3guYzbRuqtJiA7gqsBJjaFqmTUyjFikPhNYLtLC3Es9PTrpC5mk2dNzdq8o8m4vUX3MqH8KonIVMl8SuwLWMMyXKxRt2+GozLmYOTMnoaAsD2QI1I/DARqSu7fIKvLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604553; c=relaxed/simple;
	bh=J6o8VCRVzo4c3PlMMzw6y//VYXGtYGPg1K3O4UC8rIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDdJR6m6dgzkeMM3XxZAj4p9JpphD4uzKNnE+D8wqh8/csldDtUsRTVMdV0izkX8YgPRwLAUIiHpaluezsLgXoQAv48Jdp56tB1YgD+WNJTfCPAtZi01OfoO/b7L7gyXM+eP8xJp8CTMaf4ZKpEK8MEGTX4ywIZLLs2fDUBLMCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=hK+qoWZB; arc=fail smtp.client-ip=40.107.21.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tpe+rKPetPvEaznu7MgOcaah3tuVlaIvpImaQCxivK8FTx1Sv9w8lukCiqUB9qFKnf6sQaAjlF9C6eAI8pfk1MVBVJNcuAlw8tDhmSAD4eep8ECwKIH0YQ6pC1qL2kEsyZObqHr1CNuz155lMwNWaIUaUyAQPRqRRpYXaQ2ZCRQURmom3DeUn5bljX3oi+v+9BMYHWBctWkcW4xlptguviKcKUUJdvUvjBRj5L+USwuvH4T2V+WcptC0TJ48V526pFnTSWLs38HP6VOrP8UkxK6+PQsbl+/+eGUCZGYopgDYuiAfDR/VRmyY15Vc7U833M0fsorq6s5ejMIAYyYHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYEovHVzd0u4/HtoK1HdDtUn4mBLVMPjO/xnbjbDU0Q=;
 b=TmvaIqISf/FmU4cmN1WPZrttEctPqCEMjBlEwM6RxOG1q89vCe/Byc5MIu7MhPpotYnFEr9bJfL4ZFS3AC8hFMKBJqEXNfIHC5fRvxk2YmmrjMjB+Rv3fSc38i0EGoZtBpiiedzOJv0XGQcLTSsjmA3Dt4mSZXvo87ReqGHPkHFpmSWRfh1gCP32sn7R7IcxUQkIPhppM/eERnvaKds+pnwGw9oqfxC3m18SpsAeFxgYzaxGQbaM+Al9Zj5qOPzO+P13NA7wKFooQne/B02Cc9E9oSchST8GCBFlc1Ov3xlQvbxCBhASKl+jeskjOZs44lzNz0wz72N9modnAmLusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYEovHVzd0u4/HtoK1HdDtUn4mBLVMPjO/xnbjbDU0Q=;
 b=hK+qoWZBpiMCGZrTk2UOv9Ee0HuQyPNz0+5ix5V2pN9VOguLrA4VKqpMODT6wlwK3UhMbb7LvPl1l4HXD764BpB9wh/lh0jVKPi6c6ldPvT6gKHlKNPZMd39T7tO451TskIBEvRkHSYF2fQ1ZL+Cr1SDTuIVPRj6bX7+3dhoTlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by VI1P193MB0544.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 19:55:47 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:47 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 13/15] can: kvaser_usb: Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP
Date: Fri, 28 Jun 2024 21:55:12 +0200
Message-ID: <20240628195514.316895-14-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|VI1P193MB0544:EE_
X-MS-Office365-Filtering-Correlation-Id: a8347ca1-3c8d-43a0-1638-08dc97ac4de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOIPbJmY4V71hnTFP7Rwp5I2mDbXZsgWmPw7PT6b7+P/tonGMFt8RwddvN+N?=
 =?us-ascii?Q?OZBl23SsI+kVzw0YHA+9qRfPrwwbaeTUTKG9XfiNsGmhBnICBjB+WjGB3lcm?=
 =?us-ascii?Q?tdI9/b3ZwQZwK5oGrEsD3XmmJ9iWEtKC6D51Ml+Z7bG11nb8Q+LfIb61LFv3?=
 =?us-ascii?Q?YSEEIcFXePtO297ZIQ3PkH+96DMnM9QWOGWTsEfbowTOoH89FykijbyCTSBe?=
 =?us-ascii?Q?LwGEGy+Siw5n2uaeXrylvPOBjSyWOLofQaHUAlelaPZlG/tReOT3RdZCJZUS?=
 =?us-ascii?Q?7ypXaydDOLzz6U7FDy7C9glYtGxVdL/w5wfAAN7dlSn8I51Xh3gGTDClTfpD?=
 =?us-ascii?Q?nhcrADTENgka19bS1hNwy257WRpLotzLWm2/oDnXls40dKIGcRRfFCkFlXwf?=
 =?us-ascii?Q?uFyQDbnBQPMEDD35LamURwZ/J1Xg/FGGznoC1sbzgHRwANoS4/HsIxwXr/8v?=
 =?us-ascii?Q?4eTRB8h4Q/s4UQquDP9XGKVLqW5Vsi/zT7ZHe3cBGDHH/G+poDdN0+6cFjg5?=
 =?us-ascii?Q?v5hj5HM8Ok6SKq3fvbyONxr2JAXwVCYtD1aF+9JmsEckZVhbEwIIjFXQwiYo?=
 =?us-ascii?Q?FS2QwKxV27pF+vVz7gp4PW47QumSJBTPJQZHK3VybRuhCy3W8NLug2GH9bIs?=
 =?us-ascii?Q?ZkhG5s71gCwzp0KyExO1MBzlXTAW67BtDd9oKH5sXKBPpYSFctSbPoLQcP3a?=
 =?us-ascii?Q?y9Yoy0rbXQGWm+lyo2Z2na/gMQp/TyAP4YkDcgyHV9VkSJhSuDVUnZkae+Wk?=
 =?us-ascii?Q?9WfpxKdmtZbTInXU80dGintyiX92DSxo1e1ADBZMste5fnNEuwhd3zZ16Fc2?=
 =?us-ascii?Q?64H88FP8l5eVd2lp6tvCd8TmXeXVN3rjPNAEPwWy+Lsfytpe3F3UM51w0rSl?=
 =?us-ascii?Q?mvE/nLiwrueXrXczQSqjU4smczWC1F4I+ewpsC10dEIsuNv4ni8h3CnMu0dy?=
 =?us-ascii?Q?M/MxkCwoopza6N/odpEGtMmm9sM4TnPong8Cf1PW9YYiWv0FxjlXhOzYJSqr?=
 =?us-ascii?Q?2uwGJbHF2+B5g26PyAoO/3o6rE5eUbxex2xC3nQaBydKLHVd1ajuboeKFRa5?=
 =?us-ascii?Q?3PuxChQ34fn+R/eJopMMkXx35ZrHScP0zn4Ip52imD0DiDSosdrK5Z/iBJ2Y?=
 =?us-ascii?Q?KEcvdRy2boupFhVuSCYGhbBk3tXbimUp/WyiIxzvCYknPjIictKJML1yVVTA?=
 =?us-ascii?Q?s+a/SK6HPftoNqCCT9dirgkmOAUTJE3cdAD/OI0x6lKlhnhZnhqP5m7D5FnB?=
 =?us-ascii?Q?RpTScN9FEvxVz/ivONnp+uS+LkGJ5e/XCZ7OViEwVnfDvPf/kJ6nb89doWep?=
 =?us-ascii?Q?70/mGuHMa/7vQz9p8zrP+rIdaHHj3W1uc1uXIVgYPqF2eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1LGj60xaUhCbxsdFFylqw8FQInrkGMLw9gZ343gggsNURg/MSdJCBJXo/eZ?=
 =?us-ascii?Q?9RidnZej6MLe+4y/WKg9j1bCvh9MGrMqZ69bwJ/K4pQlL03aHewN+Z2+qJFZ?=
 =?us-ascii?Q?MgT2+MbE/yKIYM0mJhT5R7nF5aqNOkZxGhROgfshiaK2/euwhHP+vyshLhMM?=
 =?us-ascii?Q?kdr0KOclfHgmmYWCT0M/jaueCBnJiFlf1nXUuoK8IQwsVuMyWWhDf5rtj9gF?=
 =?us-ascii?Q?1j5tXLmxJc8sCoZvYmrKBP+lDlYLSSVWTVGwaDr2bcOfoRGb0A04KRaaZXKJ?=
 =?us-ascii?Q?quN3ljoDm7Il4QgDPOWszpFanJ0ikg2qP8J0QB/vLf9qzum3r+00ucv0v36K?=
 =?us-ascii?Q?rU6W964OHoD8Ohf8gx9ioUwtc8g9lIgcxfg0HsbrSINxU7t0UfvPN89eywLL?=
 =?us-ascii?Q?/6kSBeowp8i9zafxGmUwt4+QbxtK8Sv1FrGk6VgR6Sa/OJ2BArGl3MVma5X4?=
 =?us-ascii?Q?s4fOmX3mti6jVmClah/zUzmrVOwuklETmfih0MvoHiEKYJqvDvZ8u24U4zwo?=
 =?us-ascii?Q?YNWg/xGl++1OVgC1o2Um3XyX58ifgTcuIkyEjo2YGUY7CxZqbNaLBK8V741z?=
 =?us-ascii?Q?q/c8H81p1WIDFJI7e+YQ7aMbnBx5pikTgc6Cq0c98z148uinKcN6bJ2CYWy0?=
 =?us-ascii?Q?dP7AHqDiSO9VVaqGh/zH+lDTd0e8Uue4Xk2hO0LXgH9EC/XC86lsFBRc6IYf?=
 =?us-ascii?Q?t3ghfPzf4h/A7C8Oh2dJMw/Nd3O53Ix4JdJqVlCLkd4CG10ZUBumMaQvR9Tb?=
 =?us-ascii?Q?GjXZNYGrxg0LkPVe1MEFEBnZqPQj65frNi+UMbKvYKwMIYFF0Ff5oqtGgvak?=
 =?us-ascii?Q?tESrRpka546g7Ev54RzInhgcv4UUaEdaJI9u5QA12Hu18tzFNXitIGuzzAU9?=
 =?us-ascii?Q?RiRoBsWmeXt9ffliTjgY3ME29/g34E8EnvFFGgfVI+G10wDPg6mEUVmj+Wag?=
 =?us-ascii?Q?UCLJ+GJlMCpJycU9/bbCQZIBLGE6A8bS97xQ40Y9b/+MSFxp1q1qV84R6Sqc?=
 =?us-ascii?Q?TjrFYkfvHPcMut7+eFXfivHLF4PfUPR7cxRH8KEj/2oF/+B4b2c7CXzd43RJ?=
 =?us-ascii?Q?fFvU1cxWk5JC4NYwiFsl2zT/uN85l+KPRuPJCodQlQd3pfc2e2iNj6pQ7Hu2?=
 =?us-ascii?Q?T++ak291eUamV5xiXgVOeb0FvWrcOv5WYsCozbyChCLhOhODBkeY0pLib8Mw?=
 =?us-ascii?Q?HLDIs665NibRVyvMvGDn2jM1kAJFPElRkzK5Z9RxjQ0Qi79Ez9dlV/xcXJdG?=
 =?us-ascii?Q?ZP240AOuFUeh7ejYOFEKhE68qFGE1QILWuULIq01DlXviWhqjw0yZKGbipJC?=
 =?us-ascii?Q?QV3+FnL6Olz4PHzWqXb3dlGNp+7GVE51BMam6qnzFdQLrQbuiZng7eOSRIeB?=
 =?us-ascii?Q?IW0esjw5WIDn6cXy+iOYUnmB/6ha8/bkjhzWwGuUOY6gm6zEE9PJYfACP/22?=
 =?us-ascii?Q?4NZ4zimcLFDO7xzdXzPYAEop4sPF7N2UNEi1ABXGV9GQr6vc2vHeDBzGp8pa?=
 =?us-ascii?Q?oaGUtDnJckujj6U0mL8eiUlncnlPWZRzc7KXxOgZF00SA5gw9jMkpdY6M26Z?=
 =?us-ascii?Q?tldI4Xb2wAsyItfTejRLpJzoN4e+MIA7xcewdFMM?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8347ca1-3c8d-43a0-1638-08dc97ac4de7
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:47.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbN/mbBsMpE6UJsDW/Jd/YQw5wz00XwnVV2n64nCk0TBHbH8ssJ+dz0y8wKutISVaOwoM0mdMnlQ3ZXoeRgy1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P193MB0544

Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP, since all devices got
hardware timestamp support.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  1 -
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 26 ++++++-------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 5552140c0869..9fa02d8f49f9 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -41,7 +41,6 @@
 #define KVASER_USB_QUIRK_HAS_SILENT_MODE	BIT(0)
 #define KVASER_USB_QUIRK_HAS_TXRX_ERRORS	BIT(1)
 #define KVASER_USB_QUIRK_IGNORE_CLK_FREQ	BIT(2)
-#define KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP	BIT(3)
 
 /* Device capabilities */
 #define KVASER_USB_CAP_BERR_CAP			0x01
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 576ddf932f47..a4f32d57173a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -94,29 +94,26 @@
 #define USB_MINI_PCIE_1XCAN_PRODUCT_ID 0x011B
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
-	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+	.quirks = 0,
 	.ops = &kvaser_usb_hydra_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
 	.family = KVASER_USBCAN,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
-	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
@@ -124,14 +121,13 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
 		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
-	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+	.quirks = 0,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
@@ -862,14 +858,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	netdev->flags |= IFF_ECHO;
 
-	netdev->netdev_ops = &kvaser_usb_netdev_ops;
-	if (driver_info->quirks & KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP) {
-		netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
-		netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
-	} else {
-		netdev->netdev_ops = &kvaser_usb_netdev_ops;
-		netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
-	}
+	netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
+	netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
 
-- 
2.45.2


