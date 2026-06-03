Return-Path: <linux-can+bounces-7743-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dSnmKrHXH2qPqwAAu9opvQ
	(envelope-from <linux-can+bounces-7743-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:28:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6457635367
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=QOPaQUdd;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7743-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7743-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 596D930A1CEB
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9543FE668;
	Wed,  3 Jun 2026 07:14:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C53FCB06;
	Wed,  3 Jun 2026 07:14:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470844; cv=fail; b=C5cKzpFyKvC3lxumKJScPylqk7zUqzkgSbGEbdr5uitJfNDfiQmAjoz/g+7bPZenVY55hoAh+0F7MmP6+QIDwUPG8xU0eSC4NdSLZDXq68N7T/IFmVEShucETSvF6eUgs6V51Sy0Vs3fYhgJ9e1QgNp/PhRRybGkZ8D1GsOc99w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470844; c=relaxed/simple;
	bh=dvqlA/+PsJJlEzncLWa+oyUQ9lH5CrO9L1+Eu35xP4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OipGqXr0h5ILVXDn8WB86F1IHb/S3SKYEpiBnG8cUFGliCP7hnZMMP2JSSFdQXtFZWeHyO3AnDD/dZ1LdqScnBpyLsDOlenMDl8WT7D+Cja9Tt1KnDGBBTBkZZvc7J6li/Huj12FE83dkh1ZEcaq03va/NjIaR9YDIoAPrQyehg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QOPaQUdd; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if2X0sWV9MiZZzThqCZ8jgOuKKhwm5mdkLRs/zBwNYzpEoFZhGzN9WlwIFecdIUbiJmC/+i8I1cEUAh0boGmt31fv1lknRtjEM3vwlaS4AKIxpta/R5ImmRR2puKLeAakejzhNVCExCdYB0ZGz9Beu1lGi+ZGX1ExxxBMAsYpFDN9SrbSiYGtWuGE80RBYlScR434a2j/4Z/ItHxT5GaEKgogjZVNTyt+EDyXF/pdyBYxxieCvv2/IVy8VqHVcGTRibhqQmj5/d1kBAFZJXdDzezNvwSH2ILlPuoSbRoRluNXz7XVRSFq0+rxfD6VBqgAQFuqqgZ/I7dGtDSALqr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuI02eGgTMohLDcKqbUKOD9e9B5e6+jwjve8/2Av1iA=;
 b=V8ZuZm4DZ2JDxq3lJ3D3JjXjXG80fZE2YdZ3VPD6jp3GiY1/uW6jzG9xGnngY5l9+OGFaJ8hPsXNjUwASsbrTaJ2be36rtWt1B45SpOS3MxNVM7L7eHh2jgWd7g5ltgOMEc0ogSCWPUBmhaqpaHN0IOeB9EzV7e+IZAD+xYiE1M8uV5yhEQRMTCIUW9M0gQKTFnKx+iQ3Mw+M7j9/YMQugmA+pELwCynCHFglHx8OY2vxFlzkyoiQ5wBR2IeBsYWTzR7YHDP0LwXDYGBOat371JfUI/nmoJA5QSp/aE1BAt2huu0fTXTdOWfp/UpC27wdVYEiVzxpOCqukzJefUssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuI02eGgTMohLDcKqbUKOD9e9B5e6+jwjve8/2Av1iA=;
 b=QOPaQUddK3MnExMgmtGzJiFTFbi7JOPfc/4IQgvgAdi3Ub+yKWwJfQSOnGPKVf5fu4eNiWnbcLO7gjOWDjXGpuQdiVTQqFSEWjq1VQQW0xRNhb0EhP5WqYH5TpU0og5pxVhmWAl0j8kzIeqeMFenctMNeBg2fJj4acQRthbaG3Q611W5GvC9o4ys1Ad0qGiy1eJxKP8mcWCqwFOX07R5qdz1nuAEizcoB2fyDhM/aW99XcaXgWxgP01OzYcpHYZqWwngXdLK6mc6uEjKCZ02HkKkQ3uWHOF+gbRD8XvjG/7QgDK6B3VvbELFK8sTnGWgmzmMO8nx5VeUY1Vd4/50dw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:13:58 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:13:58 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH RESEND v4 6/8] can: flexcan: add NXP S32N79 SoC support
Date: Wed,  3 Jun 2026 09:13:40 +0200
Message-ID: <20260603071342.641874-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: bdeabf49-85b6-4661-eed9-08dec13fadff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 nNVhgc0lksMegnmQ4R3k5j5fttlZMnvgXUt7pUJMQqxE3CY1KUmzJ2ee/cpvWwmKsKviwGnZPFURZ8VAWstsMv35wh6CdDwb3UOvXLQ1VowGaWmxViCC1ZjSG/UlI1vn+7592WV8sxMnLe5S1V7fgkjBk22luLCAtwd28+NqkA2YAfmpWr2uoMeDVs/DhHGLHC5oZeuelPK0DMuzgfiZZpxfQ1CjyIClXoQVqFqcH0f8Yg1igoy8w4RfmeuQXlbDpg0QQ/+EhnrabO4QYZzK9/4Y/kOBQOu/EUEV30uNgkg8aCD7GSNr8muneox+wDMIgSnrk3z3QgPNpIHDdkr8wkkcWnLQGMJxgtAEwtpLy8MqCgzVG5BRa16Z0TIUfsXBCabLZWr4UMOgUQ5rl/nfyHzClwcMCAeGPRNSwdOx+w5SVAvUcOgqyk7TqPi9AXkQ4OcNJyGcZ6bBjkS1mYueE5SCiNrBB/iy+pKK6WiJNKDt4O5C1mUQRwtTDqdHAIlvUwYI69S0sykUjoP2mbARS6KJAdEOwFQljU3w9ofQZLtNYC9GRCztMMZTtPra7re1s65Vxj7e7Ok6VyQxbEDj0WeXlBgZIlFh7RHWW9zMrzL1mGjoQnfjc5ya/sQxNZkNVXNRjl3x+G2KMStNQlGxPGJGYdzkFbSkJjb4WJO8cxgy9Vh+uYZAvwlRXqJnpVHU
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bmh1V25adWY5ZkRzbWJxalZCWVc4SVRCUUdYZnNLajFvNnM3S2poUDRyU3pJ?=
 =?utf-8?B?QjVJazVZUnkyV2VZbDZ6QVhiUC9xcnlEMXZmWno5d1gvQkVpQ3l5NHBNQU4v?=
 =?utf-8?B?Qzd3U2VreFdTazRSaVArVi9mdm0ya1FoUC9ITVZOdFcyS3lSSWpKZll6aVZr?=
 =?utf-8?B?dFlWcFRDOElKSHg2TzdnY2dnK2ZFcTNGc3lkTVM1T2oxMUUwM2lYRS96Z1FV?=
 =?utf-8?B?d1YzRkVNUlNiVTJBY1c3YkVJRkQ2N2gxTThwaGRpMlcyNC9pQXlIK3NjSnVR?=
 =?utf-8?B?cHJDRGlwVTlwbEZvS1JNV2s2RTFScEJWckJrb08rdFViSTdaTWM1K0Y3Wm5y?=
 =?utf-8?B?cTE0Unh6T2VFLzhtN0N0VCtJaFUweTd4eEx4QnRDSTVtRzkvZzlSY0ltL2RZ?=
 =?utf-8?B?Y1VGbDhYSm1RcXNZSy8wSWpsM08rSGR6S3B4Y1F3MUgyZmM0aHAvQXFXcVV5?=
 =?utf-8?B?c0dkdTdibWduY1dUVDA2MTZHa2hGSjJQVkFQS0w4S1NBVHUvdkJ2K3daYzAx?=
 =?utf-8?B?eXMvZFdOaUJzRFkzRG5LaDV1b29HK3g3TzhoYnZGS3hKTldZVHdUUUdVbkFz?=
 =?utf-8?B?MnhhZzJUbFAyMEI1clB1WGYwWGRDbkpGRjFEM3g5VFRZRmZmRElKaGRML0dC?=
 =?utf-8?B?dWtTVjYzdkJhNWtUWi9hVnNyTjdkRmtiQnVjdzdpb2hyNWJQNFZEdkhSbko4?=
 =?utf-8?B?SEtvUG53QjNpbEh2YlhGOWNZUUNrbVRwY0NDMEFLbzMzWlFPcldNcFFkd2FN?=
 =?utf-8?B?Rnc0OHB6VjBQcTlBYks4akg3d2xQWGE1YlNrQU9xS0ZXSEpOT0VCTjJrRGgr?=
 =?utf-8?B?Y3pCL2orWS9ELzBSYWlhSXp5bkJoOXBCUUJOaXp0OTFUZG5Pd3phZnFBaHlW?=
 =?utf-8?B?cWptbGJrY2xKbHhOdW50dktLRU1IaTM2ajBOc2lrWWt0NUlSZUVPeGxuZ1RU?=
 =?utf-8?B?RUE1cFlTTkwzbEVVd1p0L05GdFBEY2xqR2NRNG5IZHd1SXZMM2dQNGtyaHhI?=
 =?utf-8?B?eWUxSHpySjNtaU5EYlBnU2pEa0xNUnhFUzVzbWxCUExjQno1c2xPaVFOdGJH?=
 =?utf-8?B?c0tPdSsyRDErb1pzeTJTaWQwekhna1RmUG1icDNhQlJFYTVEM0Q5cG84S0R3?=
 =?utf-8?B?c3pibjh4dUpzdXdKUXpNU3ZwQ3hjRUJZRUM0VVJwbktHS09RQk1sYyszRkJ1?=
 =?utf-8?B?dGpwMVBjSFJ0NHB6L1hucm04eStXZWJEekptK2ZkdzRtb2g2RkVZNVY2akp6?=
 =?utf-8?B?bUh4R0J6bDQ2OTRFNFdoNThXQWdqcGcxRkpHdExLYnZhVzg0M1dUUnFSMmJ5?=
 =?utf-8?B?WW8xOVlzNkp5ZXd3dDVSb0JZUURUUmRPVXR2WDZIL1NnTXhmaHV2aHYrOHFr?=
 =?utf-8?B?ekIrcWF3TXUzamdrV0lXaWJ2WVZKcmh4T1RML0hHbHY3S3VuWWdpejZvR0pU?=
 =?utf-8?B?Y1h6eTBGMktlVnB3SmZETDdCS1JMRlJERWhNUm5sNDEzZlpFaWpEamdvUDdo?=
 =?utf-8?B?VEZuaFN6OGVRSkZLRm5PQm53amFHQXRNSXZCMUpWMGd6TXBXdjhZb2c1YUpl?=
 =?utf-8?B?WVpUcENnNjJHOEZUTzVzcDdlWHR4aHVpYTA5NVl1THlsakxwU0xmZFJVSVBh?=
 =?utf-8?B?MzBzdmhFQlQxby9zdkQ0TFRCZWJzR3ppTDhqTTU1NStrWFI2VUNta2pqSXYz?=
 =?utf-8?B?NUk4NUNXSlh2Rnl1bVY1MkhBM0FLOE1kSzFQRC9yaEFVSlRnMXhUa2hDMzRB?=
 =?utf-8?B?WmkxV1NTUEMxY09ZUVJ1aFUreHY5VDU3c2MxQjYzaEF3cDI3VUZEUHBzS0Vr?=
 =?utf-8?B?K0FkQW5zUnhoR3RmZDNxTm5ES2NCK3BBRDBUSVhwOTJJRytNemJhYXp2MTdF?=
 =?utf-8?B?K2V3SHhqc3VrbEk4TkN0N3d6aHdlTzY3NExIdGZzREVEaUZsOXRaZjNkOXA5?=
 =?utf-8?B?aGMzR3BNNjRkZlQ3U3MvWE5oUmFEYjBzMzQxaDJNQ05zczlidThMdmVVYVRC?=
 =?utf-8?B?cVlzQTJKY1RPb3kwMFVGTHljTGhTUjhlWElhQU1wU1pKcnpUN29yd0JPaVpH?=
 =?utf-8?B?NUF5R2hsbnMwM2tTMFgyMGJnbk9yNCtLU0hodWFKcEoycWsva01EWU1NeW9y?=
 =?utf-8?B?bTgzWG12elk5SEorMktmTGE2WUc3Z2pJalgrVXh0Rm9qREUzeVBUSUJ4YjY0?=
 =?utf-8?B?VFZUUE8rUndjS1A4RTdoOFJ3S09NZURaUklSanJ0T3h6dGdhREoyR0cwNEFn?=
 =?utf-8?B?VzVnMG82QmNoWWtGckJRS1RYcUFLTXNmYjB4ZzREc0xlTW9HbEZKdmxrMW16?=
 =?utf-8?B?aGV4bks2aHplSjZVbVBZbEh1YW9mRDVaY2FvS0NtdjZiZDgvK09YNWRqRVV1?=
 =?utf-8?Q?WDR83ixeqixBaTDc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdeabf49-85b6-4661-eed9-08dec13fadff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:58.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01V58R+7pkePjorjTtPmobjRvq3DEy6yrUDE2T8PrYTBiFM/zTzZGlOUjMTjL6uM/J4TdTm5kcGjQ55+hayrXJYEAnh/j0G6zbnSO85BoiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7743-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid,nxp.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6457635367

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for mailboxes 0-127
- one for signaling bus errors and device state changes

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 23ddf7910641..9ae0d9eb4ccc 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -397,6 +397,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_IRQ_BERR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2232,6 +2241,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0


