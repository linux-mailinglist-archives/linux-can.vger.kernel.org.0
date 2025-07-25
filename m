Return-Path: <linux-can+bounces-4128-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52658B11EA4
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6039A543378
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2AD2EBB9B;
	Fri, 25 Jul 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="dvwDEtrX"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2105.outbound.protection.outlook.com [40.107.247.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6A2EB5DC;
	Fri, 25 Jul 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446778; cv=fail; b=YDysItI+colbQfGwXRphN2wHdaLSitH3FcW4DggL0UgvQjIc6ynKXl8JNmJTvaKNkQcYczRlCnQmSEsxrowvNAGXixZoo2Yfrb6VR4ZwBi/DroG0tp31REDnKHDT+N5jl9ehM9bj6YHbFYI8+NDdza6cPJHtUYNNR2gP87gmw1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446778; c=relaxed/simple;
	bh=nWs6kcQHv1hsuWUkkKv4CDuPNTXL3q9eEdtSBbdp3LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKdp0ckpeoUGfrGMh6fRSxieCFeh5J3ClnyY6fDg3J4qWDKLhulZ4fzWL1kpjMiGrTQRCD7n0W+XkGI80fio08uTdJeAjN+KX72HBpijlX/EObu8w9YyhHuFgAYcIQjk1O1JHQZF+A0bcej1xtws5QUxFfaHwpwbgwWDKhZ+y7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=dvwDEtrX; arc=fail smtp.client-ip=40.107.247.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfJsjn4rlPAtrIsKcTZLmpYdYmG2uyxq5J+HSxmznAw9/3IZtgEy+xA7ME5uV/B5kYgNev5FrFcK4xbuVLxAENHCwEABj2c5z6u0cOhhNA1sqsqV5kETyDVDaw1I92esAicWS42uo5U97yjpGaVxDP76OwaRIg33Wq1waWDTUltlwUIWEoq1jS/lPRBx8bULiJhh7pKHqz4MHtaAjpB0ChUQLzKZhBGnw06vDuqcsbdYWcOesboVNt3PdRzezx/TEFJ6HQxn38bwv00OkkuIIqrHAl8J1vqzN8tdRGZE8kUswKWkc9vtKJTQX+dcd5vLhcTxRouHcvhwyOtNF0NL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJUuewZSbrRREP499hG2np5/NvfiiITElekog2yhay0=;
 b=tMK0o7h3Pv0lL/aFeB3ezzKz9Nj7a69QYuc/GRfxUOOo3awL5rGuIS7Aft+JT4BVYnXEorSBYTj4CCb5FT+LcwGcPu/eDQRPZxYIOY2DAf5J+ZKcGr6F1OH70i9f808mCD4Gt6YpwLP9X80OmNm4saIM0BEeovcGFjUo04ViWCUce1ojojNn5bwZUsS2ytEZwnvjwqKh4KW9yZNwbMTJHxG5ojVOLLYKQPqPSzL5Sjcngs990On5OoC4PVBRAOVpzaywfAPLJhd2qStfnlsSn7c3ofy5vcNEvyqCW6Mn9cwrsdWlSZdGNtV4Rp6NomLEjB30Itg9j7WBIVo1R03COw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJUuewZSbrRREP499hG2np5/NvfiiITElekog2yhay0=;
 b=dvwDEtrXN6lrN8NpH+LNNw2aYEKmAib/aNcpNjNbzZVkcmsaeA0n+BHFhjeVoM/p7hZxqP2Ai4+2SO5lYv3LQyy0NUCI7NUgR2ETw7oOshUwtsOIFqLfp4YZd4xNENsXnhfsV8jOAdLpA3YyRFGiemEWNVhqw3iuqj9gH2uFEls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:47 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:47 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 04/10] can: kvaser_pciefd: Store the different firmware version components in a struct
Date: Fri, 25 Jul 2025 14:32:24 +0200
Message-ID: <20250725123230.8-5-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123230.8-1-extja@kvaser.com>
References: <20250725123230.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|PAXP193MB1376:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cf28de-1c73-440b-b57d-08ddcb775ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGVpVw9YUM7a+UnbE8ROMtrpExTmjdwciyDspwL6pGKlhUMqBmicpOvIVSEV?=
 =?us-ascii?Q?EkcRRBUoLiUbVkWKaUlhkM0IVQE1Al8ogZeRN1Kij4cU4Exmo0E7QPxTaPPD?=
 =?us-ascii?Q?8ePZLDAHQoCgrEg1JGeg18RqH0fSGyuzzbMXbId1qgu3XrSKjcp1+T3nbDey?=
 =?us-ascii?Q?InG3iiLic6zbLgydtzJMFv5DSxjfjmD6+i49WimZvRaVBit3u/eCWxxJTqhI?=
 =?us-ascii?Q?Sy9uLgGYu0kNrUvPDzGMQb9exMnaVxk+Kjb1it9iIyQ9xHlT1hfaEK2djFgS?=
 =?us-ascii?Q?7TfxeqrQAxNnhJCYrUPKhrW+hQXXuZIgYoHaiWGuMWlw9hyb2qqPcRKlymPF?=
 =?us-ascii?Q?O6fHKUfuqAOHrY0AwVoqm2sfU1ArPZj0lOXAGPIzyUsKXyOvSqEOKpQ3u5cr?=
 =?us-ascii?Q?feHXTnbg56s9KZXImmBcsVlfuyC0MihxL7LYps67q7GggI3NW2Xsz/cd9Kuc?=
 =?us-ascii?Q?7oAPCvg1Pj0D24N374W2DzjQczgwuWELlUue7qNF9Ex/eC5boiueH20IbM5h?=
 =?us-ascii?Q?qpEV4Vdn8XDrx81jllpBynjjy7j7AXWHr6XIMvaClHAq3Ky3u7O87mEvKsUH?=
 =?us-ascii?Q?Fr8ObCoSTuD7BxupHQISN9halzQIfrw3eTC0gSurKQ5nhjjjamjCoX2aIvpG?=
 =?us-ascii?Q?djJPHCrEOigHDaN03TC/5f4KWJSo+pbr/uAq5Djf15bCkZGK3hTYD38tToOA?=
 =?us-ascii?Q?ZYM2Alxt74VV0QaoPOJge1LFi73SuSf1b1IPQSlpz7MlvLDWwr2XBef+iUwc?=
 =?us-ascii?Q?jd2mZPyCkinVJcyZRuS6ktBw9PTiRkhUiUBVoQ1at4qVQICBWdIybbnQQlbi?=
 =?us-ascii?Q?4tgH50UEQyL2V5cQ6deJ1npBRooa206KJTr+b2TtzVWuhBDGnH6tGFMlboot?=
 =?us-ascii?Q?JY7Y1n//qkGNzVFZMGaFdLQZb2vV//Jo7vhc44MzFQiZMTHeVg3lDGH4iKJp?=
 =?us-ascii?Q?uZAP+Q/QJtvwZGDbOhkooPVQFDdy+REkTk31+1a0JBiTCLJg2FNlNASpa5Go?=
 =?us-ascii?Q?W5GrR4Tefk619RPTVyHzEzIZv329DaumejsGmMenOZ1KA2CFKKl2XyVRlOsX?=
 =?us-ascii?Q?LzngfPOgCuQfX3cOkEzkF7vPzGBoFvb9IyXfQNYU8sSvw4V4+bQFWI9sBReC?=
 =?us-ascii?Q?hSt4+hCtdDvUeQdk0ZJ32KR8mnAi9GWr0M9iHF58l2Qt9RW6YqhoDIEi31XM?=
 =?us-ascii?Q?tlS6MYWv7mXVseJK9X6RcHQMcARweSfO667zq/2gO9omt/qFwdwsJclqvFZg?=
 =?us-ascii?Q?MfG3ZtEXEK2ymG+72jBXE4kJcnYHDutsEuCSSh3iRg0XRadNbTJeDnEcRofA?=
 =?us-ascii?Q?ikghEvjIeksIurBeeaj6GpRkg1rTnOVzixwcZdRivaDbds70glrWt2DhNi3m?=
 =?us-ascii?Q?dR4oUUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P6lrkTd/pcPILz1hiG5AZebZc7HltQzGbbopR4/BiCN4CiQ2+gzmO5JqjOOl?=
 =?us-ascii?Q?kHFOoO1fCvOGo9Nvptac1zMkbGx/Mu95iy4zM+D31lyxuFy/lXPrOA+mSUMr?=
 =?us-ascii?Q?h9d3y5dkmXDVC5JMtR1DSOyjD1tEeBPOVXBdqXW9FwcA6KIk6FYEWJP+oA0z?=
 =?us-ascii?Q?llqAgxFr1I+P+0vhRF54Sh5uDNcN3ggYdatFJkHmNWquOn7GAg00u1TSphzC?=
 =?us-ascii?Q?ZBlZjK+sL5QZAKSdpMqyHMIPH0XeCdbLo52/fbCyQ5I8TrZBwFRTdEZpPDnv?=
 =?us-ascii?Q?nQXN137OXrdbd/AMn0LV4ILPlI1OaAqPjgKrkNI818xM19BEuDQajAKOdMh5?=
 =?us-ascii?Q?21Jbnchja21JHW4I/hoGlDcY6esBJNv7e91+7Jzos8YAh73Mv/jH+OUHWbdx?=
 =?us-ascii?Q?7DLQ7s3monCr2XhybmWdrNiL6NPgsuhgLyTN2WEnPhVuYZjGXbyK9kJkUhYB?=
 =?us-ascii?Q?aTVIylVf8c1W3jMFnWAymPbZ6fzBlIRmbCfrmGaCJRg5euLu3KXjp0+n6ECz?=
 =?us-ascii?Q?jjPFMujy1bmF8DuOByyqmHrJ3zINMrBpd7jlrErerIb2VpYQE5m8SWgZZM5e?=
 =?us-ascii?Q?TEeXWOPm5edKRyAvu1hvi5yAaNZm35I2+c6w4qHwH3Idc0OB7b6IrhOEqNVu?=
 =?us-ascii?Q?dXGLlS4Czd0Z/HogPry54ZlQDzXZEIl5/VaCP1Dkf2OpMxie6wiLCF4fO3LT?=
 =?us-ascii?Q?evI/v+U4sJ5qOzR3d6T5Z9tSea57d9K1e2rHMWX0/mGwwowePD4bj30WskjA?=
 =?us-ascii?Q?k+xpf04W99mqTO0iFyzorbgmhiahkreYbGjuzvxFx5rLTkJ+WIapCKDCkvsh?=
 =?us-ascii?Q?o1atTlASsOjEJ7HqgN9aWR/yX9sqycONryIk3Plx95wPld/m1liwMpAXOpkq?=
 =?us-ascii?Q?n5xzN4hpWo/1F39wEZNzkl9cZooA1/kb0aJm9bn4cOyVhtK1Xd0CdYRKWBkb?=
 =?us-ascii?Q?zwBnhVCT4ck14gIWVRHhYyP2BDvwPuJ8X/3ch8jSk7+bbesHa2TAgXRjTLOI?=
 =?us-ascii?Q?eWtJI53pLSZuNWXGZuXpbMozcuqVG62Vn96oBPwkAl+IyqgPKhb8dBVPEcVy?=
 =?us-ascii?Q?OK2WmmRpYHj8JFvl7+Mt2JaefeDOuk2Ueb2QgPbOXvOrHusFQWchc8QVTVx4?=
 =?us-ascii?Q?nwmyMDv5ASYXxqLy3psm1hbDBge57bounsA5HgOd1ycmKZK59+FIyIyLbhBQ?=
 =?us-ascii?Q?5uRnG2Dkm0ebNcQHDbESYUKx0IICfKZawgxolEUMhvFsLAcBniip80Aw1h4J?=
 =?us-ascii?Q?azOIGJOnQaMRiLTe7oYSlYdpwvW3UjDG19+KtKGzvVF17RntHYHWa+jUnitE?=
 =?us-ascii?Q?9gBgMN9IO7CvJUuhWgSl+qGZyjLJ6zJrD8dbBNvzE8RBGUDGs507SVC57Z+l?=
 =?us-ascii?Q?byANeDh3P4VpAGrrSuVPNybbHzQa0zgmm199PP8aL6IQLHv/I0X9BM6m/T9f?=
 =?us-ascii?Q?1EcbSQklNIGwNTdYQQhcbONNTBq7WsLR/QP5KYnV8Ac041p6ChYqqd7Ol244?=
 =?us-ascii?Q?RD5YcPjmHvX9GYc//CzCMdCwBELAihIPI8AQtgm1X+L/PiIlvHj65S4XGbVi?=
 =?us-ascii?Q?GvbmBW0dxW1PfF7c5MwjnNeUNvoOPPFUQ2cflIESg3xK+GcCtBFd1y4bAOBX?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cf28de-1c73-440b-b57d-08ddcb775ca2
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:47.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tIHefkd0QppzAW6AKJDktLYNU+dNfKup1nWtpmGs+gS7kB5zHzHyFCCYPvvMtpsHn2cSKnoTBcyn29vtM+bhXz6XZRVf8VDlFv5y2vYfoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

Store firmware version in kvaser_pciefd_fw_version struct, specifying the
different components of the version number.
And drop debug prinout of firmware version, since later patches will expose
it via the devlink interface.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Drop debug prinout, since it will be exposed via devlink.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m2003548deedfeafee5c57ee2e2f610d364220fae

 drivers/net/can/kvaser_pciefd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4bdb1132ecf9..7153b9ea0d3d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -325,6 +325,12 @@ struct kvaser_pciefd_driver_data {
 	const struct kvaser_pciefd_dev_ops *ops;
 };
 
+struct kvaser_pciefd_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
 	.serdes = 0x1000,
 	.pci_ien = 0x50,
@@ -437,6 +443,7 @@ struct kvaser_pciefd {
 	u32 bus_freq;
 	u32 freq;
 	u32 freq_to_ticks_div;
+	struct kvaser_pciefd_fw_version fw_version;
 };
 
 struct kvaser_pciefd_rx_packet {
@@ -1205,14 +1212,12 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 	u32 version, srb_status, build;
 
 	version = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_VERSION_REG);
+	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
 				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
-
-	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
-	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
+	pcie->fw_version.major = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version);
+	pcie->fw_version.minor = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version);
+	pcie->fw_version.build = FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build);
 
 	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
-- 
2.49.0


