Return-Path: <linux-can+bounces-7178-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FoSOHt6vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7178-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:36:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0042D33D4
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8094830447FE
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2815D41324F;
	Thu, 19 Mar 2026 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8O/iCzF"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605440759C;
	Thu, 19 Mar 2026 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959609; cv=fail; b=IGQfJYxmqaAzDDRgqZjm3oRHi4VDxW4hA0d0yhe1CtW7vfcM2Wl+iEXPEUJ65UDx2lTPFezROocivzUM6mQYKLnmD3CGxKNIp+XVQfSEUXqxQiBBBStKKeTq59ZyQzkjz8cmDy9xYJj2m3e8hbErsaCjJ/QBIC3hMsqK22zVUxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959609; c=relaxed/simple;
	bh=Hs5wODzNoB+/PIfZHucisR21duYlgWeS96Kusy2kcUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWwcwHQHVO/bWRvrNoWNKKxsDwfRp0Vt+WRk6RMqWe3pJjU79J2oIrvDCucFTTTgO9AsUmz17SOetgnpOIOroefz/eSFmIklkJRYS3Ol8XKoBz/NwDUza289I4fa1SRaym3jyn2//Y6ZdY0BFSKC9xwkckSxtXLLLIelIw92C+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f8O/iCzF; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdaTLKPpvKJ6rWFsiFKX9F/kw71mPiF/kPiJO8R810ORXEskTkTQPtbs1RldEntLQck6uI2DZmEt9RA2dAuBpiU8fOd0ajjQVs58KDwgF++j7l74V/1roiYTJaMqShFvzlfiX1Rym5S3Ke33ZPD7Ch4+xVNwflUZRI704nI8D8Rx/bVyG4MQT62tXr0G9h1YV30aYsfZ4cytrOrJTgBL6+quHs9sWkTb1q62e3HEuPkVAMwDExFtzMyOyYD8Z0XuKE0VYF/wSPBSPVvq9rxWr2R3Z0eEkrKBe3hGkDGk9WGUYmOKPspB4ENvvyUWcM51vbeJuiqx4HJmvEPaaCxjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weZH9OlprJdTy62yrRvsv63XQKmA5KVEQAc00/gVbNA=;
 b=MiHMLK0hZwnbw8BFs6qrwGMxB25mNe3QnaBxtimgRmZmUoU5Ap3Pk67OPABfWxUmT/K2EY47YaaPLeVlsJG1dR/nOTrSGgGHE3cJ0qD026QiMFZF+/5Bq41rsBDJ5nfl85kz1zNLp7x9Twr9++ewvgwuXCFjvEeA7AtBYNuZ0ESSu2/ATXjluh+y/xpkwyAtCEWbs1LpKUgcl/f3pnbdVbibwmp4+b18nHoAPqLfjbHd/jJEB/rxpUWw7S7Khy+N5mBSkImb0mJipQ28Yu1Qo4r1TmRCxr+XT8+lT6N/JF6X4/y58B+/PoBVy44za27Y74kWahR1O9kk0K+J8rpPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weZH9OlprJdTy62yrRvsv63XQKmA5KVEQAc00/gVbNA=;
 b=f8O/iCzFOw4Sk2CbzwFYYm1GHEQepEZgC1qIGzaMSVeJLXCsuOHfvtRggRL4LqxIAEu37aoeq+N/5kdRY6vYIG+yilwL6SfKCm1SbAa4r5kvJymsGGJuYGOXY5nEnD6pMW8GltQFd0x4oHhq3M8EQU9dSOB6d2t5OrU6vTG7njoB6iaYhYPgxgzCm0De82IVXTXmSSmBqI5Mm787GPTw51LY1ZLP2XPyErxGAjJGvT0JDtxt4MUDj+0qwRUz6QRv1ehfD8iu1b0eTWzXLs+AUOrGlWFCLJfjnwpr8iNHZ1jNaJThopltsiPpHSnoKiJh6QfAqfIZEAfIgDyx7uS5Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:57 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v5 phy-next 08/27] PCI: Remove device links to PHY
Date: Fri, 20 Mar 2026 00:32:22 +0200
Message-ID: <20260319223241.1351137-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f28ee1e-abad-4dd7-49e9-08de860776ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b1+ggEdvQmRVaLFs/aE+ktNUbpz+YUB9Y3E/sm83daGHRUwr7fjww5JzrsltPKEyiu634h5LJmmCkDD4ms3ECRfQPXh0JAZuxdzWM90yZG/9Bc3VDEdFaVxQ5Pk0JsbKUPl29UE44yRB7sU4fLWSrkBqtjnMBbOGS1jmiNcofiYytG/0gc0PB3XpNLx3R+UDZf2hjlW4Bf7oOIdnfz557C+6EQXrxqDg5TZryPuAI9OFRKhg+uW1qZQm5G+j3NhdItEByxEu45MbChaJlcPyq2XgFFQG0FKABfuCFfWvf/A6Gy1VtIgerpCcX7iLw0qJ5P4FdnwUa7Xvk6408gk5os7CaaOfE4bl6aqIX2Py4p1/up5agU6XEQ/+tubghT57XiHgFXsbIdNQ21dTtJ1/1TtUjLuiL1rwg8Ozmam4mRO62sCNPzllz3jzUKtrL5poYXU5RJYxLW14kXi4rcw5pDvcPTDLtphDCg4ixft5XH2Ez2UPtdBVkJv51mknYWX9vG7CdJ8sGjNj4wHvhkDq+kdSuuvmGiJfhIgObVj4I33e2v4VTP6PqRNJkLk9aCRZo/T2/cAwLGfqLpGAVotxRVBBi/yKiwloqRKfJ4Y2MoJDJvD0P/eRS19WpjRdAVpOyh5DSsImGl6nyZYlJqFu9XElSlGX9Zckw+jP6UAeYogKSvrVPa1QSt6VrQwH73sytFldf5D8jRgHP5C9nU81Nx1g7sZiaBDOi1GIkvPKJJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2Eremg4YTIzYzRSbWs0UnAxeGlNSWZBUGlPVVlSdWZaUmE0cUV0eGplWExp?=
 =?utf-8?B?L29Udmw4VmJNWDNSQTNCK1d2VUJkekdaazAwa2xoQTErTjJtUnUwTmJiR203?=
 =?utf-8?B?azFoQy9scXYvU3lCUnhHbFVUZ3RoZ05aenBlYk04dk5pYUx0OHdlQnNyeVVu?=
 =?utf-8?B?QTBIcFNOZVQ5U2phamp0Yi9CYzhEQ1hLU0JZTEtYV3R3dENlMUNtTXIzZ1JV?=
 =?utf-8?B?dHBpUFEzRHFoanpMcFV6ZE1HMnFOaGNYSzBZQ1ZFTW5nbEtCNjBQQVowTXZF?=
 =?utf-8?B?c25HM080eEVMVHRXUjhhcVZKQW0rWEEzTTdPUmhocWZSL3dJQXRwTXoxV2VI?=
 =?utf-8?B?MUpPQXpnNE9weU9xRjk1QW9xQis0SjlPOHI1QW9OT25ZOGs5YU1naXQwRW5F?=
 =?utf-8?B?UTB2Vjl0Y1p0VGtzc0hmblpIVExBRSszY3R2R3RqVXVpSDkzYXdpMEpVVVhl?=
 =?utf-8?B?Y00ydFZUNWI3cnREWHZrMzRza2syVWY2cnhWb0ppWTA4c2Y3dTlocmRIVEoz?=
 =?utf-8?B?QUFDcGE0YlRLYk1iUGdKT1lCNUJYTk45RzBhOGV2VEZjNUI4VVoxMG9wTHRZ?=
 =?utf-8?B?Ym02K0liNmJVUmZ6QldSbm96ODNQb2gwTm1FdkxTTGxndnZSOEJnZTF1bi9L?=
 =?utf-8?B?OEtJQ2Z2cXJIU1NJWmpRaU1STHhwRlg1Rk1qdXFaaE9JOXpWdXhPdTdVREpw?=
 =?utf-8?B?L1pxdVBPRkRLeWthd0tFNndtMUtlNk1pbTN6MUZQSWRYcDhwa3pqbExzOHVz?=
 =?utf-8?B?bk4xWXFmOWVGZCtUdzhtZER0cGh0b0xrVkVGaEZoMUMwUUk4UzdIc0FKVVh1?=
 =?utf-8?B?Rnpkd1FvYzJ4RmlNSnArMHVEOXJwNExDOGp5dXFnd0p0eU1mbnV4Y3AzSmU5?=
 =?utf-8?B?N0FjbXlERkttTFhMVUM1bTZieHBsVXJwMThrQjBJTHNHbkFIVVZoUWpHRnkr?=
 =?utf-8?B?cjFYR1J6VGtXQUVkcWkvNG5pU3lHYnJ6aHUxUkt5QlJCQ081UHVSS01CcmdF?=
 =?utf-8?B?N0kwaUV2RGJoQ2VqK2FqUUhCcTlqN1IxYjI5K29YTC9BM1Fwa1I5NG95c091?=
 =?utf-8?B?cVdwZkU1U0c3YnowUmdsUlltOE5OblNxL1BBWGhpL0RPNi9ucWxEZjZ3Vkw2?=
 =?utf-8?B?VWRMMTJHT3lrSDhJdjFQckJxN1JVRDRJOEJVUzB6WmpwckhDczljem1kMkN5?=
 =?utf-8?B?NTkwV3k5Wml6VVdsV01WTk5sWE1pTXk5YkwrNEtVaHdJcHd3UVloN3VycXFM?=
 =?utf-8?B?NDlkVGZ6TjJWcm1Yb1NSS2VIWTRsSEJGK1c3THJyWU5uaGhxY0c4dGtVMkt2?=
 =?utf-8?B?d2xPS1k1bHZrd0kwQ2p6VVFRYzR3ZnRXYmxER1ZVUDV4czZUTTlWTFNWU3ps?=
 =?utf-8?B?SHlDLzBLK0l6NlB6R0VUUVZURk5RNEc2dEZLWVRSM3lnd2g5VE1CTTVydm9E?=
 =?utf-8?B?dHZ6cCt2QjczK0FuTytRRmpTcjRvc1ZpV0dtNmtzWkZQVElyOGk5UDUxMzZL?=
 =?utf-8?B?WFczcTQrdkVZMjNpeEg0MFZaSE41QTNiV29rSytqVmZYdTJlVnZGUE4yMkU0?=
 =?utf-8?B?SCtNbG1QUnNBZDlzUGJIY1BSdjh0WGtwR3QySWFjTVdVRlZVRHk0N09qMmhH?=
 =?utf-8?B?ZHJleTVGVjUxRG96bUxmZ3E5WWJOdzRkY1Jtd3VhczRWQWUyMytObFdEVVRz?=
 =?utf-8?B?UDZpeWFVYkR1aWlIT2VrajdLMndIUnFrTk92aE9WTlV1QzFBWnFlYkNwOGhS?=
 =?utf-8?B?YXZaWjV1MlYrNGtWcjd1N1JqMjNVSjNiTzZBNlVUMmhPYnZlVGhTSUttTkRs?=
 =?utf-8?B?N20xQnI0aENzYUQxZENDTE14ZUtSbWx2ZWxjVENlZTFjdkRoUjF6Ylg5SlpE?=
 =?utf-8?B?SG8zV2UweFFEZ0dyRTRrYnkxUjFaK1F1WmMvMkxXc2R1MUdqOHlmbkpZNkFB?=
 =?utf-8?B?cTJuRW9BZERTNEhkTlNEYjBYVGEvbHNDaXZUa1Q0anlLNzJEbHBNQTR6TERa?=
 =?utf-8?B?UFZLQndRbGtjTVVHOXc3WTcwZ1dEV2JNYVJyOHdRY1J5Y1g4VmFoa1lGNklU?=
 =?utf-8?B?cE5yMmk4ZlR1NTZjbmJJWnlVME04M2cwdmFBZXB6dnZFbHhVQzZKY1RRVlM5?=
 =?utf-8?B?V2ZUSU9iNkZTMHJvVmlkUlpQbGlJeUl0RnprNnd2Q0ZaczdhdjZxY3g1R0tJ?=
 =?utf-8?B?RWR4anlZYXovWFB3T0g5MHR0YkZYdnpVN3YxS1ZkaDEwcDEzWUhlakdjQUpV?=
 =?utf-8?B?bHZFWVNHdjhnVVEveHdISklabEVWbEo2a0VENElJT0hzQ0dTam0rSVpORmRB?=
 =?utf-8?B?b3hKM0QwaUdEQis3TkFkemJwOGlNdW84cy9zd1JLRzB2eGJXUFNGcjVHeVZ0?=
 =?utf-8?Q?4rtM6KSbmoGZjZnCgNOHyxZlbv2yRChFnJNDif+qxToBy?=
X-MS-Exchange-AntiSpam-MessageData-1: Sv4acrWldxtEobics2NAUBvNiaVYsf+3l+8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f28ee1e-abad-4dd7-49e9-08de860776ba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:55.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sFrD40j2iFJQHgT1kH5mbxBhy8larv6YU3uB+5CXNIiJ4dqDZZNcDmWjNzrf9SGX7D355KvV/KYtO3w0bvj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7178-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: CA0042D33D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is practically a full revert of commit
7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
and a partial revert of the device link pieces from commits
dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
49229238ab47 ("PCI: keystone: Cleanup PHY handling")

The trouble with these commits is that they dereference fields inside
struct phy from a consumer driver, which will become no longer possible.

Since commit 987351e1ea77 ("phy: core: Add consumer device link
support") from 2019, the PHY core also adds a device link to order PHY
provider and consumer suspend/resume operations. All reverted commits
are from 2017-2018, and what they do should actually be redundant now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>

v3->v5: none
v2->v3:
- remove dangling set but unused phy_count local variable in
  cdns_plat_pcie_probe()
v1->v2:
- fully remove struct device link **link from struct cdns_pcie and from
  cdns_plat_pcie_probe() error path
- collect tag
- adjust commit title
---
 .../controller/cadence/pcie-cadence-plat.c    |  4 ---
 drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 --
 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
 drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
 5 files changed, 5 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index b067a3296dd3..fc39c01b7964 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
-	int phy_count;
 	bool is_rc;
 	int ret;
 
@@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
-	phy_count = cdns_plat_pcie->pcie->phy_count;
-	while (phy_count--)
-		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index a1eada56edba..0ac980249941 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	struct device_node *np = dev->of_node;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	int i;
 	int ret;
 	const char *name;
@@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
 		phy[i] = devm_phy_get(dev, name);
@@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 			ret = PTR_ERR(phy[i]);
 			goto err_phy;
 		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
 	}
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
-	pcie->link = link;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
@@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	return 0;
 
 err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
+	while (--i >= 0)
 		devm_phy_put(dev, phy[i]);
-	}
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 443033c607d7..35b0b33bc6fb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -82,7 +82,6 @@ struct cdns_plat_pcie_of_data {
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
- * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
@@ -95,7 +94,6 @@ struct cdns_pcie {
 	bool			             is_rc;
 	int			             phy_count;
 	struct phy		             **phy;
-	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d5d26229063f..b91ab37845c9 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -9,7 +9,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -683,7 +682,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	int i;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	void __iomem *base;
 	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
@@ -731,10 +729,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	dra7xx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(dra7xx->clk))
 		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
@@ -749,12 +743,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 		phy[i] = devm_phy_get(dev, name);
 		if (IS_ERR(phy[i]))
 			return PTR_ERR(phy[i]);
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
-		}
 	}
 
 	dra7xx->base = base;
@@ -856,10 +844,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
 
-err_link:
-	while (--i >= 0)
-		device_link_del(link[i]);
-
 	return ret;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 642e4c45eefc..07698c645e02 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -130,7 +130,6 @@ struct keystone_pcie {
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
-	struct device_link	**link;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*intx_irq_domain;
 	struct device_node	*np;
@@ -1118,7 +1117,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct device_link **link;
 	struct gpio_desc *gpiod;
 	struct resource *res;
 	void __iomem *base;
@@ -1189,31 +1187,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < num_lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_optional_get(dev, name);
 		if (IS_ERR(phy[i])) {
 			ret = PTR_ERR(phy[i]);
-			goto err_link;
-		}
-
-		if (!phy[i])
-			continue;
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
+			goto err;
 		}
 	}
 
 	ks_pcie->np = np;
 	ks_pcie->pci = pci;
-	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
 	ks_pcie->phy = phy;
 
@@ -1223,7 +1207,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(gpiod);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get reset GPIO\n");
-		goto err_link;
+		goto err;
 	}
 
 	/* Obtain references to the PHYs */
@@ -1238,7 +1222,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		goto err_link;
+		goto err;
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
@@ -1325,25 +1309,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 
-err_link:
-	while (--i >= 0 && link[i])
-		device_link_del(link[i]);
-
+err:
 	return ret;
 }
 
 static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
-	struct device_link **link = ks_pcie->link;
-	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-	while (num_lanes--)
-		device_link_del(link[num_lanes]);
 }
 
 static struct platform_driver ks_pcie_driver = {
-- 
2.43.0


