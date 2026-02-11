Return-Path: <linux-can+bounces-6541-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C4XNrYLjWkCyQAAu9opvQ
	(envelope-from <linux-can+bounces-6541-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 00:07:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC171283B1
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 00:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34F103025158
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5E3570CE;
	Wed, 11 Feb 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MmDBD+IH"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD625357711;
	Wed, 11 Feb 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851246; cv=fail; b=ITXrCo2iBGYDLvXbvOm6Q/Wdf7ETDduJu+vMHTshcfnLmw6ChWQ/CimNXo5iglzXAAsiutlmsR2bgiSX08Vbxd/Jeub0xfiW5VFyPk40xEBr2e/aP9y4kUZTKrx/sRu8vs8iNmG3YPORotqKuTBkxyKhvQtQIny86/vVotOYhlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851246; c=relaxed/simple;
	bh=LXdYQ3dSBBJlnxgzKKhvwd7MM3I+PsrxJ4AaD0fiK8c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eUUK6eoKgozvRZdT5u6iHL3JCpqaGBYhiVidYkA7AZg1829ANm9/xQR9guYCeyQxVGNSs3nwA+CaBMZNmL3WVKG7mAmCPl42BVB+mlAwmDCFhK3x1Y4uDB1x3uYr6ExDxhxBGNLmHFgy9oxBW1KBhPktwlpQputyu1N8Ld4NqYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MmDBD+IH; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLEaG/MZYB5JhU+1dIQ+gxrmQOriuiXpOo0+2RwET3QXcyX6pjPFNIFz9/p5YmbIVifN3bPPJnVnKRJRVEdfFvgzqTWOfxEGJZfDouaA4nGTc0+iPZkiNdwK9H5LCzmTXLMiV2uXkjJ+/pGQZJ9gZUYNE0q+/kfhkYUUzQXzgZSEQiGHgjeWY/TNRdtVpl0QdKK2RM/+iprsLItzcDh/u0ytiacfGflrPvNK4USqmqelo+MoJYMkfNaUJmW5fnahpNHr7BL/1cCWUd156d3s6VjuwPd5Ze+d4hr+2H6EqiYOxJDpj28QjJHtAEB7ucNL1p32JIpEa7BHnHAC/CtKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On2s94EgzRljbcxrrzrcZ9dqwP3yk6YYzJcH9ez4PJ0=;
 b=QSqqaUlgCYiXZeCikjhVfx2XJxNUw0oLMuh9/ZIFHHdlEXzRIZe1oBpXtPhyJeXnxpWxWnxd04SShuRMFrEEbSieElAYGJ7QcPlN6NsKojHPH0tOPO3j6coQ2ld4TQpbxLW6rF8NpT6VPU+xi1e18qka0bW6kxpfoRA2gRE/Jqge3d2HdzqZ6Psp4qvS9XuA+QaPouhlKmzv6KUlRilWN+iUzxRy9jSouPO/LX3HUN1n56U8N6Uxwug3fRxyYkhIex3KfIyAMYVlv00zLp1R/0ctCcgVM4BD3CUovndq9ZwbWvghu9rjufQUe0ZQiTPvLU4lnQFozhl4twhNACqKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On2s94EgzRljbcxrrzrcZ9dqwP3yk6YYzJcH9ez4PJ0=;
 b=MmDBD+IHUDRIYmkGvrbZsRc4LOISG7tJt0+aE5+/80zalDS4Bksfrfh/a5cRy+IiHiaxSvmIMqLTP1JufJVQ1MIGTS5CN9WG8kLMYJpGsLkVxqEE2I0lLVKu7/nB94VxyzOGPkljrJCiKiAlnChYSfIFXrfwTp8FMUWuLy0SGBBx7MAJkikMoDk97R95O1sXHO12/OZBF5tHNZ+FsYDrBNKYm8g2lthfmd0EdPgSvPsa0OokARDDO1Lp49sUEkgInUh2j5mAhJMSEAKlKtUOI6OTsLobiRpcegvCt8Wvcev+N+JfZTvPDmAgekK5nlRPIOTPoVLlKcgsorj8zxcyag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8558.eurprd04.prod.outlook.com (2603:10a6:102:215::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 23:07:21 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 23:07:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: can: nxp,sja1000: add reference to fsl,imx-weim-peripherals.yaml
Date: Wed, 11 Feb 2026 18:07:05 -0500
Message-ID: <20260211230705.3824184-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:806:24::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 609c0cb8-08e5-4ab4-94f7-08de69c24f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbpfJsGugcoJ2nm8EZfM3JJiXr7lFu+PrURAJMtuVcn2zwrnP8Ca43g5h504?=
 =?us-ascii?Q?qRiV6aIkUgqYaJlAfjL0cgzDk8buExve54Q4uQ2Dqdud8KQTkFvW0tyvy0xr?=
 =?us-ascii?Q?XGh8SoVOPQkFsu3VFxFdcqBuVQ0tYSZh3zuFAFU17ahI8BLhU2R0W3J9Hvpp?=
 =?us-ascii?Q?yvnO59fdjLnhZ8XAEPPaEes7L2cl2pevXY5u9TJqK9+iIGizKcRkEc+jO4No?=
 =?us-ascii?Q?ub08lU9NaF9MvlL2zY5JygpgiHMOUobRyRBEdwdWIr2zCapmQWIyP9hX/o3p?=
 =?us-ascii?Q?iJfRmzwU+F9Kix18K2my5eZZJE7Y5V5lxjxPHUTIII+hEXqHsISTrsapeLYr?=
 =?us-ascii?Q?uZxn3V3/Bj/y5j7qtOg1Iiv19ZmNHYPEC6r+Slr8xrRsE5n0R+Oak17vIECi?=
 =?us-ascii?Q?9AAXqM7ONrjqZKFsWsfQbkQ1LyxM4SdR09P9rSCwMQQoMpMBwQNsSS8bytYx?=
 =?us-ascii?Q?rkzBjCxLQsyrQIjUUKRCVChMUtfcWKgumgb5MGsax+hakua2fpKvxx7B7LKI?=
 =?us-ascii?Q?olKl4K/OCE7oMB5Ir3CZImV4UGdVdHX/RRTpRapcILphScZJw6fHOKlp2loy?=
 =?us-ascii?Q?PtOezkRalo1fOsng8TY1a97ZfoZxt/L+UIxevasxfSidpfhl8le+MyMB+FL/?=
 =?us-ascii?Q?nJTQibmqe3t5OF1baDCV1TuxkUYTc3q0O7dN3BwWCi5Z5Q+X+J87XQg6BfgF?=
 =?us-ascii?Q?OfXy45xNsKZ98z5e138NBEep6FE+dNlb3SMr3BASumx7bxmuv9W3FOQavlUN?=
 =?us-ascii?Q?EarykhtlZXKj3u6aGu1O71/aAc4tYJfVgb7lf/vvSigaE1KaLJelTbZ/sAU6?=
 =?us-ascii?Q?YUv/KfyAjoki1pF8LDbvQ1G1Fq/OlskDR4dlfUqNpZQNkpJBZush6XMJj61G?=
 =?us-ascii?Q?s9XcQjvdfyRAuUoMUm1V1X1QKmq3i9IaxnAnGW6UbVozbsOYT2nhAOwwMACN?=
 =?us-ascii?Q?a/MLd5ihwlCgJwKXhs/wxMOg6Xf0vNbe+qQ8al2eSIYSAXstiOHgFlctAkrG?=
 =?us-ascii?Q?CF1DCwFpRwzTIW3LyPmpIb4F4zqJL/sJjMOkuSzNWs5yL7k0iFow32ESmGUZ?=
 =?us-ascii?Q?WSE8u0R38rsfFchb8Dl+gI7RVmWjDSucNeWToBADOzQ7LXRCqF4B1+AS+TQ/?=
 =?us-ascii?Q?rdWfI4SeOjuw5uIoe0B9Nhjzwy0AawgY9uj4K2L8q6/F3iDio1RvGSdfuaPA?=
 =?us-ascii?Q?x7+gJJW8cL1ayOmsP8cIYgRoMH86w/vS9HDip1Kn6mBiPMepUoSesfcBqk3k?=
 =?us-ascii?Q?v2p/3O9e/n5+KTzbGmjyBkgQRC63P182bBeaGxWRJd/eyqNtxgP1h9JI/Vs6?=
 =?us-ascii?Q?NlT6on6Ye10S+8JFoFrYjLrwGJAL+ojYG/e7WEBWNkNCcdscNSDOOgyqTIL+?=
 =?us-ascii?Q?kjXTF40Ehd1H0TpamteT96QRj8H72wQZr/I166G9bYWVbpJ49X8hBqNRX+uf?=
 =?us-ascii?Q?fiQlQO5DKsZUUz+EgFCV9YN6DQpo2iU3jJAr+Pd0jO5bjlH0x/mus496DKFp?=
 =?us-ascii?Q?DiZZt7u3UrOF8NA0++W4eC767COKtqg4kaSvIaoYahZl3WAtkN4gDnPDyxYV?=
 =?us-ascii?Q?xB8FBtdGdWBWVvWdOHjN2QIzs6Tq24di5cNcu5K7PobBC5vOIJpqp8ccBGG1?=
 =?us-ascii?Q?/N5AAFoXr2uVDTu6a2XwsHU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQ0r6ZTWlcLqrA5Hkm8RxmYGanzGwHmCwaPxztcO3NdclEuy0i3MlgW9v+k5?=
 =?us-ascii?Q?Lvy8aWLQ965BZWDrcVRLeUvDko83Lhu0KeZAFamtT0EZDF1TKAlM8ks5mBMs?=
 =?us-ascii?Q?tgZFdGBAjDVM5tCf0/b6G+863bKjCkm7seNfVEe/b6OhK8SbWkjoNFmf+xNy?=
 =?us-ascii?Q?zDsT8y4WNOzHiy1958Wce5GlRgs/Y3dB+t7Spq8y9xEbFKrv3h/VQegjXHhK?=
 =?us-ascii?Q?7per8d9zofwsusCQTA3R04o9Zvgau4/2WSVuDcorcNyj+jDIGSFYxG4P+beh?=
 =?us-ascii?Q?333DIjtTAAXRL9mw7cEteTmd1uGIaQejjNmcgfUHEVFu7qvZLPG8vbD/fz4N?=
 =?us-ascii?Q?WCveGfGgsaYbNrt3CM8ZnW48cEzqfScE0xZfKfXIauc4K4JKAE8ZA3nAelVw?=
 =?us-ascii?Q?h6aQbO/S0rFqXCfW8z211AJ/yS9B4NOSTKQF6N1bZX1hlceGNBnX5vWP3ZBA?=
 =?us-ascii?Q?C+jaGvvVH2dN/Jc5sXI87oZc/evqlNCWV6CQt96ihzp0rn5BDnmKL4nsxpKS?=
 =?us-ascii?Q?Jtfnx7Mrw9OdCpSHueqX0zfD7bZptKtmHUj79uf0QGW/kP1uScQob2RxgDSC?=
 =?us-ascii?Q?PCjwqLzt+qOXrNTV65edokbXQw9mtN1EVdk0KcxqPyZB5ebJ3mvSaYMFGb8A?=
 =?us-ascii?Q?/5253l6zBEcIY2YYo5tQJkKwIq0ZQy4/7yvtt7qK9OiLRwI5v5oxPxrQcFif?=
 =?us-ascii?Q?h+gz/HKD6OsPeRKePzg8a2bo1EyoWz3ktriBLUyuNOVBD/JjRaxFdqorFL8k?=
 =?us-ascii?Q?/oJP5k8GSsxlGECsQFMzMqC4Eybv3PDaRL3m4w4ZMKSL679vjejmu9TVsbEs?=
 =?us-ascii?Q?96z6Lj2LxpJut1r9at4Fq/tXpOLsjC9fpk+IeZCd+toYa6pC4hFD6z+YQXdA?=
 =?us-ascii?Q?P//G519C6CV3xUBYIsaeXuKKcaEUk+pA8DaYszHCgRv0kWy212Q9WhZawuwG?=
 =?us-ascii?Q?4MLchPxY/rOrZgbjOqU4yFpdEeUw/z7vpOiZUjNZEQEKq1eAVQTRVW3u32Gb?=
 =?us-ascii?Q?QwGdd8NY31hm7KwmbnhwMorSQn0PkkyJJoio5KvpTHDTV+WKDIp/Cf4INQgy?=
 =?us-ascii?Q?docO6/7KehRqk9th+dvm8iBc3eSkK5dBXUIf0UeBp9B2Km9VItjQsEJ4JIfk?=
 =?us-ascii?Q?yVJsNuA7iuXkdB6nCbkJFNi4/yh4hCzmKCDyWiPns06U8h2iL80QIdoS6diK?=
 =?us-ascii?Q?xdpapJoU1yQpfOzz/nIz0W7vRRDhkn/ZyZsBSaXlCzoouG9zbLnc4v8U4C4s?=
 =?us-ascii?Q?OhSsc5vFpr8wHmuwhWDHDuxwB2+Zkh5FaPodKWLUKYTrMxBbtGIoH+aIqCM2?=
 =?us-ascii?Q?Zw+Yk+Gb545LZ8W2jWF90lbZrkFa1F19+uRlZMfOumfl+Id2dXKOc9YfQuW1?=
 =?us-ascii?Q?zIoUhKSwT27d0zYsU6JmoaDOXnqKxDaN0/KMMlgOWPRRdLUGRPgi21uXT1yx?=
 =?us-ascii?Q?qdPmrDfOzo8T4MqBG8xy9+GL29YmS8QzLi0fwN2qJqtmMi79wlJz85z+m9W8?=
 =?us-ascii?Q?xaMe0L8EKwEmMHk7d6ksWtVzbZNR+6hj9zfr3G9EDbKvV6d9MEqY07tv+sja?=
 =?us-ascii?Q?sPLlwHYqToLvapF0aqURaIYHViMI50NDNupZ9AJdXS3aGBuj3eue9hCfdtE9?=
 =?us-ascii?Q?pIq0CQ/uKafxq3/2WMcrqkvCCzuNKVxoxmpBxKl5sHJOPoFUi1mefkcHMgY9?=
 =?us-ascii?Q?5a7ku/NSIJkNh8CiPP0UcG5w8X8oqECBHxL6kWShpfzue9I1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609c0cb8-08e5-4ab4-94f7-08de69c24f4d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 23:07:21.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VZgdPQs16Z42tuqT7CYWnXd/Ykx34uty/KqnEpvcDYtEDmdpi44BTIyx/y+djKYZBxTgi4xWxblHA1jVmMa5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8558
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6541-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,i.mx:url,0.0.0.4:email]
X-Rspamd-Queue-Id: 5BC171283B1
X-Rspamd-Action: no action

Add a reference to fsl,imx-weim-peripherals.yaml to allow vendor-specific
properties for memory access timings.

Memory-mapped devices are less common today, with most peripherals using
SPI or I2C. Since there is no generic YAML schema for memory-mapped
peripherals, reference the i.MX WEIM schema here.

Fix below CHECK_DTBS warings:
arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dtb: can@4,0 (nxp,sja1000): Unevaluated properties are not allowed ('fsl,weim-cs-timing' was unexpected)
        from schema $id: http://devicetree.org/schemas/net/can/nxp,sja1000.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
index ec0c2168e4b9e..eb82ac27c7727 100644
--- a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
+++ b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
@@ -87,6 +87,7 @@ required:
 
 allOf:
   - $ref: can-controller.yaml#
+  - $ref: /schemas/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
   - if:
       properties:
         compatible:
-- 
2.43.0


