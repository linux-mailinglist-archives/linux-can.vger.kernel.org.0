Return-Path: <linux-can+bounces-4099-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F57B10622
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA3E5A27F8
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A7284B3C;
	Thu, 24 Jul 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Y66kJmKU"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2132.outbound.protection.outlook.com [40.107.103.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1726B769;
	Thu, 24 Jul 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349130; cv=fail; b=M3m7xBzafnMHUWg6YFehoLfhYDcSxPVizYsuRcSgr3A87X5P92wjR3vFU9Avd9QWXuTGNw1kUZH61+iIgu6/AbY4vDOdGfSWM6V0/7KL9qi8bTi7VLApyNiuMw7Z70vZxYOXvSB4N5tMVpSCOieUETd0By3ODOIrAWh/VZyRW/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349130; c=relaxed/simple;
	bh=VgKk04WnTM6JwMbpF5z3ttBTiQ7vTkPr8aR/3QZ2qA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjqklpO4xkGUuYqFFUYzOCVkOUhk021xhfDyFgWEyHuCBaYnQ33F6HO9ldAor4yYMSEmRIFOMJGpSgndqEAZbZZuJpVwxNgIPU+uzT1czkR3au1AqtVZWjAoDZzu/+5Hj42i2c1unZ5iYj+rznDLTpcS6cPzaoL4Xdy/zBqbgkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Y66kJmKU; arc=fail smtp.client-ip=40.107.103.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6sGeWHLsk3UZAJl7WjJisDJXsr60UT3DR9XrrxvUOzkT16tLOy8EG1V+i8hDJ//7+Z4ZOo7lolfADA3hXCEVUD72eSxvvI3U/r7phKoZO9Cfbcp8QrRMhinJYpma51JnluD/Eh/lNeJ4sd4mO3sEcn4jbbDCGohn5PWDy8Ms/WZGiM4ZmiC1QHA+DS4loOC64OLAEUo6ohQAMMLFf5fyg7ewbhyx3OqqZap9UDyVVeCgpBN4YPbJKeCi1gUo858L63xU/0rhNTJ26PRLkktW22LodK4jyWFk5ZXBpF7qhvYH7cNuG6K4Q+D20mgJS70QvuwXvLX/4SPNAONa+wfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFH4lAA0tG45yn9BLN8Ygxv0k173+5pVbcY/h+KoAcs=;
 b=ift+6IcL3XcJ/Xv422eKB8GcnevgUmpMHEiXoChhULKP8Eg4icLY9nymHi8Fix6WJOulIdgEV+hInewTe05K7ck4aep94E4WACJiBiC/oUI8KrUzp76nPWmKJjQbZxAKYXz0+Ww5w1aFJhI9XcYdqbgwjkznSEVyCtBcOWtmTgI0igsIt4axqMQG2nXoRKaMhMQ69MZpb41mqfWb0Onwo+SKD4ZmjNYEKIOX2oJoCqAYmNRoGXkyYOkgskuEQ8T3e1Ma/64PsJkFc0WwUrf8H9ITBD9syiew8+C5lkCf7WDwat5DD0A2IoHlwbcmbpNFSiN4beCNpQ+YHTtv87lu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFH4lAA0tG45yn9BLN8Ygxv0k173+5pVbcY/h+KoAcs=;
 b=Y66kJmKUFoKql8FQbXrsjm+Z1LBYuCtqFbNJ0s2+khkb9oje78rxBsbdS9VWwwfY8q6Oa7j/NI/G5ktA9kWwsPHiYs1/q7F36htPNwu/i067EbtnD9KUMQzsTH/7HxId5weFwPlzh8I4qaiWKvHcVQVil0Iw+SDmcIDSp6Z9lq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:23 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:23 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 01/11] can: kvaser_usb: Add support to control CAN LEDs on device
Date: Thu, 24 Jul 2025 11:24:55 +0200
Message-ID: <20250724092505.8-2-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb6f6e53-76ae-49a0-3b4a-08ddca94041e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPonIET9F92KDJiydL7xYLB9dvu/v087R0HB2UUmHHaBiNQpldzZLiNJDFdU?=
 =?us-ascii?Q?ceDWGdBTyCiSKTfIZUXPLcqYHpHhFvuDJx0iWQ4vjqJPz+ug73AemT571SKy?=
 =?us-ascii?Q?+ju/SMTJIMerG0W60PreGpPwkyJNge2LAcxZGxW49MfYfoBqGnQgnx3L6YCH?=
 =?us-ascii?Q?FpRU9Km/aQHl+k8ufsTY6+hnfM926xVLRgz1+4XagmpTdZBNARnMZsKGNdDB?=
 =?us-ascii?Q?NEzdgz9yldzdXHFh92uxF30xjtgJM7/eifXtiIt68KF+J9gH7swlgHoJHudO?=
 =?us-ascii?Q?3bOQAt/MoZiL0/9TJAl2d28kXr481I+TH9LzGChHFqQt2n7s/TjQkU6Upxk8?=
 =?us-ascii?Q?OT1hYgNiPKMb97rdfHNCUpwocYe5yMqlQc0zjBvnnui0WGBkHInEV2KUOulM?=
 =?us-ascii?Q?NUa+fx4TwCRfq9P7YiDqtRqPvizIVJuPVM3nVcJmqAoc0aRql7M/7UldDDXf?=
 =?us-ascii?Q?hRy14ZfL1zc0+b8lTH1IwmTcYL4MmrFbOT/Blrf/Lmuwj9cUXJxtu2L0Lphx?=
 =?us-ascii?Q?mxRtjPIz6cZb9sQczrcbmveSaiffTHMOkvFWVozpbjgBJQUDZnZ1AGLZHysi?=
 =?us-ascii?Q?dQ5BPou1M/2/wfyAN0b805cgDvf+lLKCB4uP67sZMHDTHAKZz+vhudsQuSaE?=
 =?us-ascii?Q?DqjjlhGX8CLCruH+y0EvOvvkggCwcaEktneL6AD2U+PaqM1fPvoAxcNX0O6E?=
 =?us-ascii?Q?Dpn7x2eXcYNXPmhTIk8Hvb/1ahhkDrn0lhvdAGx/1l6qOH0bxAzaXaiFW5Ww?=
 =?us-ascii?Q?w83EQre4tCDgEnVvW1+sKP8zjVxgcKqBE9ZrdRmN1y6vyEmqBVySDjz7S94D?=
 =?us-ascii?Q?sNCDdIh1uHAjv20iLf3uWDMN94oLvY5g873jOfArqe09dL/mGF5HjBwlVvTS?=
 =?us-ascii?Q?bMNLvXmcYa1hUNiWnUI0jrGe5TJrZAPUR92IVX0IWkuZFeA5PJibWslxn0xB?=
 =?us-ascii?Q?/g+o6z3yyMYcvyOjbwnibB9sEopGUL99F6VYDYxYpLd70TNlkN7hx2eNexEl?=
 =?us-ascii?Q?ZBd/bL90h5dBUbvRCgO9Us5gPlWlQ8C8QDT3io/DCbwuLOzVyLQ0KW29Cfak?=
 =?us-ascii?Q?pZBQUGUs61g0E2Mgmrs21UtLXU2OdBbFxIfxmoCo7voyz6sEDex0fNauZEPK?=
 =?us-ascii?Q?UJL6dsSaroegAjg+OOUBDxngHzr/z+OnuSqbyNDh0Vaupbf0/Nv7HVUlzoGC?=
 =?us-ascii?Q?p6YrbD3J9Ai6jQBAJSaF53AurvJ3+1OnenogaAAeiceuckl40KFTwzQcSnHu?=
 =?us-ascii?Q?V2mAZXnPyzzGkQWUD7JW+pRtfeL5bAOJjwf20lSwb6zL1z37TKyBab6MoWc/?=
 =?us-ascii?Q?dZYiancVu3dB7wO6Wx8azrdAz5hVUZtLhoDsi17I7YhqTHhygGYmrYzaiE7R?=
 =?us-ascii?Q?gBwrG4AaGsodur/54E2IoTRKSw7Y7nZv9GiPHClCxW6IoPbJ10HPNokEbKrP?=
 =?us-ascii?Q?rcE5+iRQuWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XLKatHPFrsP+pDpUrbRFECGAUPKX7DVUg3Ke/tAUdXXdunBh08Vd8/VA3Yn?=
 =?us-ascii?Q?OIVCVO06AuG3p8rfS0EyV/mwNzXa1kHW88S7aDnRkCLF/by3I7g649Ocn/qw?=
 =?us-ascii?Q?ON1HWVkWXNqhKxi3NeHKiUWc1phhlbaQl60XoyK4Gs8fKKafDcFSibqeEQl6?=
 =?us-ascii?Q?xDxy4krvqPvjgP+5j46Kdxp2wotOgOFGRaUvLYvsbOEBiezWIkTi96F0pbdU?=
 =?us-ascii?Q?vQALm+U1vwOa1CDsmRpbiHb10L40iCJdF67Mlr22QtBBmCfgcpRsHQdVMAt5?=
 =?us-ascii?Q?mlNgmk07RiCpybCV8rxzQ3ubqtiuLlln4CMQSqTFPqO5is10ot6nyZdBK7GE?=
 =?us-ascii?Q?EsRGr3RjLrrYyLQA0ap97qEtj6H9uGTOYd73Ha/Xbp6hQi9CyKdqGvmOIJkZ?=
 =?us-ascii?Q?W854q2/hk3gXZWNzfnWCWJeZ1DNSO1QGFus60rVuHbK4NLtoXdMxUGQdZy/X?=
 =?us-ascii?Q?in9BLIVGhYn7Qmjq87KEOVcT0mjuA1z3DrfuHhl3Blv3BgRCo9dvZa6o+tpe?=
 =?us-ascii?Q?REMRGvP5QShMl3XQbbLLFfd8sSyhPs0qPSbjrGBlY2mWiVND8D1qee0VZMzR?=
 =?us-ascii?Q?EPdE9XhS5nvxfEIH1AEPFrFZRpmxK8ZLPMu0/uY2hGw6a31VJfeoyHO2ENJm?=
 =?us-ascii?Q?zVhIsKqT/7sBG44UanUEo1jTjAnjTOn94PhG0P3LU9l/R3gxB6tY1qze8wv8?=
 =?us-ascii?Q?dCM0UHg8v4QiZ1tQboR9USfC9hnDNCmmVuF/9vXZX9yv0dF1jesHgCs1Ify1?=
 =?us-ascii?Q?0DCT0+KLRf5hxvXrjuRLLad/eecnTMlRzgT0AIGAbdz6i7jQw+nW+lrnLgwh?=
 =?us-ascii?Q?MnGGEve/4aUdztXS6U2Y4dMFnVJKyFPkbGlaY6xMi+Z8ayui9UZFR8LZVIOT?=
 =?us-ascii?Q?QV3isTj0T8fnNf0CCTvDKNQXauFtYkrtaUkdbrzOk89xMI60/i0R4DFqEtOI?=
 =?us-ascii?Q?RHWmuXaWV3osGrjVNPg6X/B0s6j0WcnthWqHVdlWQqa3PfQ4wypb0t3sdjBv?=
 =?us-ascii?Q?w7j1rIVpW2eVOKL96WaP3WlHLIlGQUcZuUdai+XsKyGnYwPVSGa8jiGMqE3k?=
 =?us-ascii?Q?5MRua9sAnz26shHJOcQLGH/QO93zrpe14UX/vs+PfssdzPSXfji8CuufFvhO?=
 =?us-ascii?Q?oSJD8CWZRHfAJ6EllDZCpxM++GgFHADb9oxRseq92lAJbtJJtYTq+8lVD99H?=
 =?us-ascii?Q?ry7+g2BbbAvXRDeKDw8pFykOWLeyt45NNqeDGKorfYUdMxhYV3mXQutMZjL1?=
 =?us-ascii?Q?+8h+D7STnV92FNH71/2Yu5K+gPPlqtoahd1/z/KCGq287Iv9714y9X94pBW8?=
 =?us-ascii?Q?a3mxNDvvFTsXrDpX1dgTN8m84MXfyg9lGUZR7TNaTHxhieknRhb32fu9aNK0?=
 =?us-ascii?Q?jQ3UoHqLMK9gQMi2AFX77iYd3u1u4PpHYmj91fWHuRIUrRdG8PuxxdxSO4np?=
 =?us-ascii?Q?U7vSSKfcMFlnL5xQ6hdQ07FVJinBO2kWljrf0OuX8fbvOA3Eb8Vrtxd8USS/?=
 =?us-ascii?Q?3gIPTQ+BxdP2CnYTDG2OuwOCxUveOO38Fq2cXQP+fafbFvkVvwEL6chBCZFe?=
 =?us-ascii?Q?tIcqt7cF7kqzi5QrFkbLYSNLUqP2M5aPNzo7enN8dmNyt6+jsU/F0ZVDPWtw?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6f6e53-76ae-49a0-3b4a-08ddca94041e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:23.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z+xfVSSCTc0iTx+uI1TiKauA7KwLIk2GyzXw26d4sYOxKXC5dVOsQbg77v5WSn4wGfpqCqRBxtcPr7Ik6UnPJTWKByIHijiVAyoanTxwMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Add support to turn on/off CAN LEDs on device.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  9 ++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 51 ++++++++++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 54 +++++++++++++++++++
 3 files changed, 114 insertions(+)

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
index 8e88b5917796..758fd13f1bf4 100644
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
@@ -1946,6 +1968,34 @@ static int kvaser_usb_hydra_get_capabilities(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
+				    enum kvaser_usb_led_state state,
+				    u16 duration_ms)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_cmd *cmd;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->header.cmd_no = CMD_LED_ACTION_REQ;
+	kvaser_usb_hydra_set_cmd_dest_he(cmd, dev->card_data.hydra.sysdbg_he);
+	kvaser_usb_hydra_set_cmd_transid(cmd, kvaser_usb_hydra_get_next_transid(dev));
+
+	cmd->led_action_req.duration_ms = cpu_to_le16(duration_ms);
+	cmd->led_action_req.action = state |
+				     FIELD_PREP(KVASER_USB_HYDRA_LED_IDX_MASK,
+						KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX +
+						KVASER_USB_HYDRA_LEDS_PER_CHANNEL * priv->channel);
+
+	ret = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	kfree(cmd);
+
+	return ret;
+}
+
 static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 {
 	struct kvaser_usb *dev = priv->dev;
@@ -2149,6 +2199,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
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


