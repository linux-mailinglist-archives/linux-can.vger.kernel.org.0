Return-Path: <linux-can+bounces-7567-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOKoCX+K/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7567-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 411624F2BAF
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56B723014286
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA537C0FB;
	Fri,  8 May 2026 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="BUr3TU+5"
X-Original-To: linux-can@vger.kernel.org
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020110.outbound.protection.outlook.com [52.101.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29736BCC9;
	Fri,  8 May 2026 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223709; cv=fail; b=FpGVpeD5Eee0yCNWCzoxV1slfkGgt6NNLEa66KWn7qkeTK0Yu0IQW07NpTFnknsV6aGsfM4w0QOGjAwFcohfVMcyvF2aYB8Fe8XZah68+HAnWxtcSvcAiXOuw3aZ95sNPyhb4k9Mk80HKrpjsfa9Mqrva9bYgt//n+qGvmbJmPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223709; c=relaxed/simple;
	bh=FbdWE/fcRnnMTCLSGDrA3tFfNK9VVWIINr4ObctZnAc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JvN5d+lpHZXA8P2oWxjygzk3xr7yq5gFteVgU18R7wjVusc5DAiMAE8/nsghEj1na16d7rOZYqo2+R+nMeO/OPOwVLdZRVPS7/Ru+l4lxiwMs343wPJ036tbJfz4LCMdBJ+yU2SAfOwmy9Hg+JsUfaCHTznW9sRTz6fkuChVbmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=BUr3TU+5; arc=fail smtp.client-ip=52.101.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYoI+TSGs5CkBwhPO/EjMQ3rAoZyhVzAfCoEyn5jS1KIi7i5kiQisYEhDtXpJHWhe7WG4/f4BWA7Ek+grk+JvtcuJTTq6ArqLw+G1RWBzMuluYJdVgcMB0aGE7TyG6TUhPGttQNsALz/v6ZbgFb8zGRgsiemgg1ovDRplWxg9FtAr7p6iuq2ezv+RlPK8CvMD8r7yEYZpT0vqgg0KmCQwv/JLuMWCMXPkllfb1myv0wc8RNCY3CBuXv4cuTOqGYwWkye+LIExDMrD0ufiqNKBo4h13yok8fIChhPe8LIy2wmUuBeeMXmjhMwRcVuXq+EtRCWbhR6RU2oCuG/gSX2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyfBOmWLujL2NvJOBqGj98Hib3SiduX/VK5fzDMJqRU=;
 b=QwlXnqMxeMsYYObDo6lGiXO6OkBKJGUkDic0EU++MnREI70K9DvW9CsWflQ10gEmOWRaNXgsNwn1IglOB6EY4Z2AnQHNXoMWGiPGamlaKY7dXq5kfnQgWjnBhWU81CtmaWdXK83UcD91RS/zHZCKu2M9iZLbzSHepMLPKDyu2Ir+b+sZx8U1rLcOQdAk2vXMhDaOyS/V2yrwq6Vdi271TE6Lp6prZ81JX+dSkTh7+wP56bD/iGZBe6frZOFkHgi21rva3WFkq9XpK833tRiCVwHjHBVybf9qb9uIwTefLU+F08X4tyKVjdRD+LALQKPxEvmvM9Bo7OiBhZW7Agx6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyfBOmWLujL2NvJOBqGj98Hib3SiduX/VK5fzDMJqRU=;
 b=BUr3TU+5dte1g6gmBskN2i/VUFgy7QniUvA+6QlMXdnUNZpuoni9jY/99Fb43FsU5StAuJwKRLLeR5T6QXDXnr1pBObbGU1tyUaVhD359+NtuB6V7tAKfN3xV9TueEGpZ/s1Ehua2jDzztevoyIiZRm8v8VTbkz1XFd6nIFhCle3mHDTxhEZ9n+xPtqTso4gPiO7tFWvhzZUikpCzyblOQddW3nmt4TinG0Guv6NkHfCtRpG6cXrFwv0j3TCtC986EtV3qv47LynAyflWCHkb1iv8XGULwnBUqwphsUMwE2tA8jZCukeDknGJitFg90TGGgg+pSsvKX532XeiuH/LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB1876.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:32 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:32 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 RESEND 00/15] can: grcan: Enhance driver with CANFD Support and Improvements
Date: Fri,  8 May 2026 09:01:06 +0200
Message-ID: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A0B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::212) To GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:188::6)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB1876:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c414d7-b0b3-47e3-bd9c-08deaccfa2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UxCY+Jy2I4v5QvpdwyXDpvvGhr/gnYX4U2Q6H1m5MtDb+lXRwmsYP++KKcFxphpUU71rcC9tPI2aCCQYjBd/pWdi8INmonkIbfG4/4io+RX8QpMUfZAtJYxWIkoaGmAEVoHaf2x18rQNTHzIjuJNwDo1k+Df7NcZ7AarnklqSg1AviurBLtb64A8pzrT4QndkunZRHKvkPKXlOQ76D7iBsJUNSp/SZ0XdexNb66yFYA4bm+ks7ht4JkjsGgLB1S1oML3QYdCQz6FzTwZhynr+z+yIzkD8h8pevnb4H1wwKL48KhHn9+HT0m4SEwyBU0liBVa/O54uvSoSfqDuIjVXAsMZ5lEE/t9jIbhY9pOpFdiInIb2xzT1/7pnCKa13F5+IqZF+Q0kOXhs/Ib5FTPI7dG3dnAYLOrtgHOxdgmxhiz0u3d360ShoXq4RtaStG7+F+44kzHa5rEShrCJ9tDhbWaTChF/LPFnoYyebNeaged8eyQiysL6u6geegZvRc60NT3NX5lkMGcBUts+9jVqgLeVAXihV6rI/P3P4ByVeAZpjrLYXRTZkk8gbSxs/AdiDaoFh9ecS1tQmixjaaX8KFYrYs2fZ6GsG88hxVHWDaFRvxXCmTcQ+5hNCDukMTvmOhJFdp/wUkzavkMhBYAVF+1NrhBIpUWY+7vsZf5zPSyVOyGe7VFKMns2LcUGokZD2Tf97CrXhQVSmwPKAzTr7dzYnay4F2+LeyoFZmNwT+PnYfKGKMQyfyyDYHZBuQ9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fB18j135sTBOCTqjdouATYHdFq8nuQLXqFQg4SjSaPUCi2dGhXXjVBN/cvvs?=
 =?us-ascii?Q?j9qYy3FXtAiZ4AV0U4muFwgUyTCljp9d9RtdnLHFwms4Fvzbm2rhWeP8i51v?=
 =?us-ascii?Q?rP+Bo6PyxL6D4X1zeu8TCnXt61RQRhybtmFoyy5XRZXeCmNGRLU55B6ECdUV?=
 =?us-ascii?Q?onZWbDSPJZjLAeHcg4I0Fe46xQNkyxufHNYyoEyoG8UzE1v1Y0MzQmZfRzm2?=
 =?us-ascii?Q?FHRFb3/JN4/0bD8neqhwh57GrsUr4bD4auIsy5P7lGROkMkI66PGw3Toex7t?=
 =?us-ascii?Q?YnD63KSOfnEbBc5cgykbnMGV0uEzEx3sAfYySiIdUICXZQF2zTbLcO1wTTO7?=
 =?us-ascii?Q?fl5rXonCrfn2F2OqO0uYZ81umUoH1v3yryhTsLWgkj3BdF5O+4CeL7xre7Ee?=
 =?us-ascii?Q?rzQl4rIMWYe7YFPv0cv1dFXoCyR5xMzd/c12GMDabMpveugIMJw4IXuYdOr0?=
 =?us-ascii?Q?cjXwb5kikdbH+Av+h3axBYBWrWACP+4OCiWlyclIADHV9Gi6dpJxdSEhb5md?=
 =?us-ascii?Q?lZ/wb5GDDfbh98W3Xfj5cyqUEJfooz0Y76UD7SRHPj/ozSXr95r1cOH4Hee6?=
 =?us-ascii?Q?ZF3GqjutvkNSeJ5kcQw+p12HJiwLQBNAv3aFQdvf1b5JRc2wCs/1tJ7rUFtR?=
 =?us-ascii?Q?MWzOW7YyYw3DAmPvJX71xtRklU2cinklEo8CvKAlpnJZNXhfrsMyyg17WytA?=
 =?us-ascii?Q?F5qqVn0TnQBszNZfDtEVn0nmL1r6jECB10lqS1WVdus0T4GUqBb5zTZTrHVj?=
 =?us-ascii?Q?asqDZAHox0kx+d/IWP5CEMtdn1WAu2wK5PgTz6NIzN71QHQpLkJ6tR/aGf38?=
 =?us-ascii?Q?rlkaiqLMcOF3QQzyRWyuhtgihgV0A81tPDYO2tNLWhMVwxO2zKyEk4tddBZh?=
 =?us-ascii?Q?W/FSsav5SzYfnb99sOYlshWSjQ4Y4VGnQLbr7gxWT80Sr+ZrMY0Bm7JgNO0h?=
 =?us-ascii?Q?KysktCIX1vW+v7C+vo9NBq3A1Web6OZ588RwCgPrIktdq3zlgtxisZqSTwFC?=
 =?us-ascii?Q?+LHo6HdGo5Q5K++2OgLur24XP8f2AC+EwSwKusn9yRUuevxAgABSkFvlJ0xa?=
 =?us-ascii?Q?gFTMgsYTO6FHnsb1hoHqeREAAOyHfgf8bMwlYUPnH1634hg5TU9rJiqIe6Oo?=
 =?us-ascii?Q?uUlFjui/o66sPqXFVKfaQ9rIyfFYTrTLakoUsdueouBXeojk5bvbtTDH0kDD?=
 =?us-ascii?Q?FPUMWZKeR2081hKe0CJ5l2GDhoJ1a1RQ+AKBx8ioFUtnBf6bpAhefywNoFLf?=
 =?us-ascii?Q?dnTZIC2TJ7vHWtPeyA102C3YqBhTfqwb5gdL3K2IUaQGuAIBaQphkWhIUEwA?=
 =?us-ascii?Q?9Vu26zZJQr8CKiOSHnnvdPvhABudf01VyjYuH6MtsSUKYT3/YIrVBkd00ECR?=
 =?us-ascii?Q?RykcN/oiYFMPrVRFOri+YLA5zuku6uG4qKf7igUuVIk2Bd+aB0jFjIFUcZv+?=
 =?us-ascii?Q?X82PhiUqgRNlzwQsP8SfS8QmfP29Xr3H4mrYAEBCzKQxQsLGd5ERaU5Ot8D0?=
 =?us-ascii?Q?+oOP8mFumcBL2qS4alJUgORXOjC1xttykj+s+mlH3pHZb+4A/twTLSchIDPD?=
 =?us-ascii?Q?qvUx87g/JH4AEfkj1yhk4bZGmW4CfEfvgiy87/RJXrCZFURXvTtwFA/h72WT?=
 =?us-ascii?Q?Zrz+HcwkSy02zmJbD3/hZUhS6U2SGNYIiaH2r7YVJZuGEi7HcPPKk1h8wGiq?=
 =?us-ascii?Q?A7zrntkMVxiL6BPwJw2j8Wd2Zbs0GXwJ0RD7gUAQ3StekJFGFhpdh2Ni0l7v?=
 =?us-ascii?Q?Nj/toTxOuXRRT8nm5OlAuuT3f+ZRyJY=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c414d7-b0b3-47e3-bd9c-08deaccfa2d2
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:32.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImbYoe4HxPDFtTLy8qh5hkjX0ktsrqnV7uL9194diMJb9RqlBWKD1/lLjU07vAnfbGDYce89BjKFAzkyxS50hBO6Ctp6myPU/JEo1nP2FtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1876
X-Rspamd-Queue-Id: 411624F2BAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7567-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch series updates the GRCAN driver to support the GRCANFD core
from the GRLIB IP core library.

In addition to GRCANFD support, the updates include enhancements for
compatibility with NOEL-V (RISC-V) systems, such as matching drivers
using the 'compatible' identifier and adding support for reading clock
frequency via the common clock framework where available. The series
also includes improvements like functions for configuring
nominal bit-timing and optimizations for DMA operations.

This series also updates the driver documentation and bindings.
The old text binding is converted to YAML, a new vendor prefix
is added to reflect the updated ownership and an entry for the
driver is added to the MAINTAINERS file.

Arun Muthusamy (10):
  dt-bindings: net: can: gaisler,grcan: Convert to DT schema
  MAINTAINERS: Add maintainers for GRCAN CAN network driver
  can: grcan: Replace bit timing macros with literal values
  can: grcan: Simplify timing configuration
  can: grcan: add FD capability detection and nominal bit-timing
  can: grcan: Refactor GRCAN DMA buffer to use structured memory layout
  can: grcan: Add CANFD TX support alongside legacy CAN
  can: grcan: Add CANFD RX support alongside legacy CAN
  can: grcan: Update echo skb handling to match variable length CANFD
    frame
  can: grcan: Advertise CANFD capability

Daniel Hellstrom (4):
  can: grcan: Add clock handling
  can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
  can: grcan: Add saving and restoring of CAN FD baud-rate registers
  can: grcan: Reserve space between cap and next register to align with
    address layout

Ludwig Rydberg (1):
  dt-bindings: Add vendor prefix for Frontgrade Gaisler AB

Changes in v7:
- No functional changes in v7 compared to v6 except resolving a conflict
  with the treewide change for kcalloc to kzalloc_objs in
  patch 0014-can-grcan-Update-echo-skb-handling-to-match-variable.patch.
- Link to v6: https://lore.kernel.org/all/20260306162934.22955-1-arun.muthusamy@gaisler.com/

Changes in v6:
- can: Implemented anonymous unions for cleaner buffer access.
- can: Removed unnecessary patch.
- can: Replaced GRCAN_CLASSIC_DATA_SIZE with CAN_MAX_DLEN.
- Link to v5: https://lore.kernel.org/all/20260216135344.23246-6-arun.muthusamy@gaisler.com/

Changes in v5:
- can: Removed pointer arithmetic from opaque buffers.
- can: Refactor GRCAN DMA buffer to use structured memory layout.
- Link to v4: https://lore.kernel.org/all/20260128144921.5458-13-arun.muthusamy@gaisler.com/

Changes in v4:
- can: Removed unnecessary saving and restoring of registers.
- can: Corrected spacing inconsistencies.
- can: Revised how timing information is logged.
- can: Eliminated redundant checks for platform data,
- can: Recalculated the number of descriptors needed for both CAN and
    CANFD.
- can: Eliminated multiple independent queue stop conditions.
- can: Aligned the order of patches.
- Link to v3: https://lore.kernel.org/all/20260122121038.7910-1-arun.muthusamy@gaisler.com/

Changes in v3:
- can: Replaced custom bit shifting with FIELD_PREP and GENMASK.
- can: Factorized common elements of struct canfd_frame and
    struct can_frame, excluding DLC assignment.
- can: Split the patch to separate code refactoring from the
    introduction of the new feature.
- can: Remove Unused macros
- Link to v2: https://lore.kernel.org/all/20251223105604.12675-1-arun.muthusamy@gaisler.com/

Changes in v2:
- bindings: Updated commit message to explain the removal of freq
  and systemid in the new binding.
- can: S-o-b is placed last in commit messages.
- can: Add values are directly added to the struct can_bittiming_const.
- can: Replaced custom bit shifting with FIELD_PREP and GENMASK for clarity.
- can: Drop do_set_bittiming() callback
- can: Remove forward declarations, unnecessary parentheses, redundant comments
- can: Adjust line breaks according to new character limits
- can: Eliminating unnecessary defines
- can: Enhance code efficiency with memcpy, use standard API to fetch device specific data and
  error handling.
- Link to v1: https://lore.kernel.org/all/20251118092115.3455-1-arun.muthusamy@gaisler.com/

 .../bindings/net/can/gaisler,grcan.yaml       |  62 +++
 .../devicetree/bindings/net/can/grcan.txt     |  28 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/net/can/Kconfig                       |   6 +-
 drivers/net/can/grcan.c                       | 516 +++++++++++++-----
 6 files changed, 445 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt


base-commit: f1359c240191e686614847905fc861cbda480b47
--
2.51.0


