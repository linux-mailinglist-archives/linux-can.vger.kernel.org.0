Return-Path: <linux-can+bounces-6897-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KL1FyR1qGm5ugAAu9opvQ
	(envelope-from <linux-can+bounces-6897-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:08:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB151205CFB
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF50308BCFD
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBFF3DFC69;
	Wed,  4 Mar 2026 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WE6XrZlZ"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54523DEAC2;
	Wed,  4 Mar 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647236; cv=fail; b=JISoeuxO2p6LMk9/lWDLA1u4JryTStnTByn0OD+0HBAGNDsquliaL9q1pVHiVRVqYptvQG0fe4FLZESY4NR4+bbhenHVMguSgOlZijJ5FJfJCbb8pVeLflJOHaOmfAROusBN8a7RMl5dLRBK+A9xTnW9QSb1dUVbu5SRSBcVxLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647236; c=relaxed/simple;
	bh=cVGPoNRNxOIIxu16Bj5tu6cReqd4SOWqS3AZXVsFO58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmGzxpCuWFsda7FdYln3774fLm2zGoNH+VGBf8j0fHOiF0aFVa+iqXwEIcoyCui36LBXeyh2eBPDTaqpgq3BDmffe7RfnuwJtkp7dOVVhJW0AaNZFLRRZAUszlmDgk3QqxrEJfcVD6qC4je314NaoT1df3DTdbyKcsrgqdS+ZZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WE6XrZlZ; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy2jTesp6PSv95Y6JsIDVtgN9uYw/peQMlyDyeOKNyHt7hDeaiX9tsS4MDN0ISXfdNeu8uLbUeMqiszbouKoUDDQXFsPf0gVXtnoeliNgafn0mYD8xnZZrtQG/MG2de1TYsQ1VkVpm+5IxYPAsCqBUbmziJO5MV2YbWR58fHdsfE9IOS1LEcE5cNnwMvVs3qV3aFmfWrOAkHRfsjEJp7BUAXOcs7/69bDywQxK4xVvzKlnKUrx60ifYFoqqDzRNAipzLQ49KGPJnmMWkEDVRdO1Vd8IpEEV+1NAit8gqWAqVfZ5pCuHS6ltkVq6uxTGnmrTOK01b6M9xF0KuQMxFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Si4PwJsdNvR/xDnH8AppSR4Su+J7AJ9Tap4qjYd4Rdc=;
 b=Xwel8RC2bLqHXSurrW5obQ3qgio60TVTLbDpDq4LZ8J65u/3G/DnzLip26pEvw+lHJ9Da6Z0lkX2xc4Q9EQeJNtLP3/HLEuWOwGOpuPhuo5iDyMjk3xjpySPH/ou1fmArxhFyZW6NUrH3yLDtejiLzKwDgwYiivIHesukcHKhxQTuyfa0UkTFi4fYnRTDgxCYQexMiQi09SPXG4O3j1vl1GogAOR8SkxmY1jfEqCCGgD0Bjx14UI3SdMB4r/i+Zq5vsDXOwC7RufEKKXdFSuXCfbya9gOdA5E2upaMWwfU9kgJZHpNOYMo9nT6W3mNfv76DNmbUslf99lrQwhc0wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si4PwJsdNvR/xDnH8AppSR4Su+J7AJ9Tap4qjYd4Rdc=;
 b=WE6XrZlZ8aErgvQVZL3QEfU+LoXxdM3bxpMhs/MGl5wZOMHq3ZXf8eIRhfd7zI11HBdwOFMECk2wfAP/0P9/MLiVnCKY19P7UZR69fycd5soIVqOmGxEOGUd7oNuJukDKmFp/IkDuMc2fscSZqOPZqTnfhfr/ga5I+NcwYvf1kwfAU0K7kAuTDxjMOyUxNV4uyBFhSSco3C/hPEzjXi1zfxEKxxdUPTbVFTWF5BspXEFjX2hcaR0jga91JGMMWucm6bHCQDhWHUnISwsyfTggWKpkgDYGhnoliT/gg+qjBgZxzvBTpR6JP8M556boj1NUsl3TsSrTKkBeWpQWqQrew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 18:00:15 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 18:00:15 +0000
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
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH phy-next 10/22] drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
Date: Wed,  4 Mar 2026 19:57:23 +0200
Message-ID: <20260304175735.2660419-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b62702-7eec-4399-3b93-08de7a17e323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|10070799003|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	w52iYoCk83n6bjzz3cpe+P+RxiNXu8shHys9wIT6SG5LRErb+gq5fUuE01sGaqLk0MItRE+dDogoJz8ulu1HpQ5RlEKM7FemNVvTHXXGEwtl9vbx6CFTNhGsxKVOqYwYrgrJ4WOecnikgclluwiaAkwE8avOyiGE0cB0cWQT6+sQ1aB1E2wfciBUkzWvZhSuWNwV9J61WO+RV2x+Lbttk29GkPR9mntUQwuH39vbqUQiHrZLDOwheNKP8qQwQxrA1XlLPSFIyrO3/Go5bPiWCQU6AB5nSrRculm2yA67936mHofbJjezyYvqrNh62G0dUHWXuHuyExEWdH1VbJrGhkM+tMMh0e/uGlmu2Tva5/FzTO3yJHl0JQo//vswDgy3zpJy0LKJhcXr8pCzZ3KZl5I3t8lWm3upie0bdiEZFg6MDgZ2+8nYstkE13nsCH9RJUdRIkp01lzi1aAmb+LfSZH5AfUrxGBZiT/HBSrR/DM0cpVM+u5foZetPT9FKslKFcD674MxH1qVu05yXjgfmw6e9TEiIhn1PYuOXYhVjvXVf48TGm4BPqATkm4nQSuveNJN4/+d/JR5NKzIu3yUWEaiE6Apm2EoK97iMszWZnBo+LbZH7xmIFOuN7wVJUzjyd7+T5o3FFCgzty4vuA28lqKXF5O0TMha9E/ekknwS7RyBG0kolSmerJUBbvFRWwR+pxSP7IcdfxSrI17KLMGefYCZTrC4G9nARbttxTCRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(10070799003)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVIrdmQzeTFwUVVJalNjcXhDTW9Pd1FnZmxncWFkVWI4d2x0N2lWZ2V3RDJP?=
 =?utf-8?B?YmtiUkU2NzJlYTRnYkxGSVlOWE1sTENlQWtxbU5PRGdtU29RaFFBbjc0UnpK?=
 =?utf-8?B?L3JRa0lnUHJITFF5VTdJdFJzeWZFYWs1UnB4R28yOXU0TWpKblNISFRkSTdY?=
 =?utf-8?B?a1dhWUpEZ0FET01TNHYwcjd4bUFjd20xOEUwNWg5RUN0Z24rOGVNNFM0SzhN?=
 =?utf-8?B?VnRvTitiUHU2WFJqSitnemxTK2xWSkt6VElFcllLcWpGbnBqamVnQnQ3Tjdr?=
 =?utf-8?B?Q1djWXZVdmpCYURmUmQrY2gyVllBdEM0L0JCcW9JSGdXMjBSaFdPM3Jad0c2?=
 =?utf-8?B?NHB2ZVc3dkttN3VoaHpEZlhwWEw4QTRncmJUajRGakhKZ1hCa2xxVWwwL2xD?=
 =?utf-8?B?MnppOXZRZnhCM3dYbEJ5UmlrS1owZ0x6UDdSM0xPYnM5ZE1KWTZ1QmlEVXhj?=
 =?utf-8?B?M3VOalN1RzkwZTg0cE8rWXVFS3pXVHY4SVdIZW0wV2JQMXl3NStFQjZtYWIx?=
 =?utf-8?B?ZVBwS0lPcG9ycjM4Y2ZuQTkxaHVmZ0N0RGowT0ZOTzQ0SG1nY0FONk1aTk1O?=
 =?utf-8?B?azl4MHVQWkJPVXhSM0pVV2sraExpSDVkTWNQSHB1Q3pFeWNvaFRLeWswZUZN?=
 =?utf-8?B?VUFnZnNhN0ZtNlQxM2dsUFFkODJmenl1TjBBNjl0OVJ2RVZYWGc5VE5MVGVi?=
 =?utf-8?B?UWFRTVdkZkJzUVdXajhmZmszSmtXSkJIMjUwRjZYOFRaeFc3QW1FQlNUZjRK?=
 =?utf-8?B?Z1FPajFtd2pmbklDdDMxcnBFREFleEVHVloyTUE1UVRHQm44U1VkMENqbTNl?=
 =?utf-8?B?a01BeW4wRENoMTBDU3VoSDRoVXVvTUFYQ2hVRHUwaXdENzhFL2dwQ0NuajZX?=
 =?utf-8?B?U05RWlE1YzFDMzJOblo4dlNXbVhYUkEweUh0cWF3NUg2M29jZUwyaDlRa3Vt?=
 =?utf-8?B?TWlIVDB1UDZWdDFSbUFod1lWVXVRcFI5NXBDRzVPSUUyeDgwdXlQUXpoR1Bp?=
 =?utf-8?B?VDdCTndEZUE0ZW43dU4zR0hDUVBCTjhYcUp2YmNNRFY5a0dlUW5JYXNiWjB0?=
 =?utf-8?B?MU91UmxkNGMvM3V1QkhjNkxqNk1raW1wRDVlZVJkSEhKZklUdm93Q1NuOVo4?=
 =?utf-8?B?cFBlVllmdGVRWkZkZU5vOWVjWEhLRE8yMWhvL3VoaVhyTUErUmJ4MjRwT3lU?=
 =?utf-8?B?RnV6VEg4VnEzckRvWHFCUG4zTGw3Z29saURRRDBUUEpKUndvU0ZmTlR3d2dp?=
 =?utf-8?B?M0F1MTUrelM3QVBkQkhrbXVrMG03SXpucUUyTzFWQ21HbFc1KzN4aHFWS05s?=
 =?utf-8?B?ZEx1NEZ0ZTR1RGdqV0t1VXo3WjIzK0RkVnBEV0FML2prZnoySGtmNk5hTmx3?=
 =?utf-8?B?YW5TMHpCVVpYQ0ZVL1k0YmI5TDlMb3I5Zk14LzQvME1ib0ZWK1FUdEhhMjZT?=
 =?utf-8?B?ZDRvQllkOHdLaTNBQWg5MnVkbWdoa3Z6MzY2a2doR1Foc1Rjajg0SmFuNEFq?=
 =?utf-8?B?WGh2VGh6SjV5TTN1d0dpT1AzN2l4TVN3Vmw3QlQxNGowWENuSHNsamsva1ZI?=
 =?utf-8?B?UXBoeFpGbzFGY2xNcExiNkQ1cGJ1M3ZTSlpSVTI4K0tubCtidXR5V3E3UGc3?=
 =?utf-8?B?bElsc0xLb2JEWVhhMXZ1aEl3VTcvNnpzUWRzdW5LK0JrZXczNjBXQzU1YVRU?=
 =?utf-8?B?c09KNnYxakIwWHNUcjg5dnRMMkhpdy9zTTZoYnE3dVB5S2pFSzFHNi81REl3?=
 =?utf-8?B?MHBFZzZzbG9USGcybVhkTXVLWm9UQlB2dFVJMlJGT2RhVXR1cjc4ZSs1cmFG?=
 =?utf-8?B?SDVob2lBVEJhbWh0aTBieEhYaU5aWExaTFg0VW1CQmZRTEc1NnRwR2cvVnpK?=
 =?utf-8?B?eVQyeUN5R3JEVjg4OHdGdVZTQVVrOTM1Mm5zclNoWUZlL0Y3aUg1bHkwQ1Fk?=
 =?utf-8?B?NmNzT3lQS0lPVFJZN2g4emdER3A0S2JGcGVZWjA3VWZGa2RZcjZMUUhOenNr?=
 =?utf-8?B?OTQrZitVbUY2MjV5ZWhpVCtBaG1OaFpiT2h4bHpOMTVqQkEvSmFhNHpxbTBG?=
 =?utf-8?B?UEFvZHNmRVlUUWVLTy9LcjQyeTRkd0VHdXoxMFh0MGtRUTBQUmNiSFV6MUlq?=
 =?utf-8?B?aE00S0RXcVV3MDNhYjVIL0NtSWdkbnBwc1NUZWJQaHZCK1dUeGZqbUJFQ0Jq?=
 =?utf-8?B?Z3VjQ1ViWGVWbFdnKzhrdG5Kd1ozSW9zelZ4Y1VKa1ZrdFBYUmlVZ1BxR2ox?=
 =?utf-8?B?M3lUUU5UOWdGVkVnQnBwUTdDc0xtRFUvcTAxM0VoUnNTMzhWYXppcWRQQjBa?=
 =?utf-8?B?ZlpYWU9DQ3lJTllPbkFadE9vZDRYQW9ocW9sSEF6OEtZN0hwSzZieXd0WG1M?=
 =?utf-8?Q?vtFMejc2pXr0q+lv3wFY7+N4O2SuE054vK9sxBehAd8cV?=
X-MS-Exchange-AntiSpam-MessageData-1: pIiQWIJaZ7O3K8bHXQqYrdVbaDoq6vLAo7o=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b62702-7eec-4399-3b93-08de7a17e323
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:00:15.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Fz01k1OvEd5QS/3cAm1420N8xO+MI054H4/E5TgZsJOX3yv/5aGCqNBJGMsADgzOXK4gzmcCIC/LdD+7VPZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275
X-Rspamd-Queue-Id: BB151205CFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-6897-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,intel.com:email,clkspec.np:url,ffwll.ch:email,sntech.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

The dw_hdmi-rockchip driver validates pixel clock rates against the
HDMI PHY's internal clock provider on certain SoCs like RK3328.
This is currently achieved by dereferencing hdmi->phy->dev.of_node
to obtain the provider node, which violates the Generic PHY API's
encapsulation (the goal is for struct phy to be an opaque pointer).

Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
on the "hdmi" PHY index within the controller's DT node. This provides
a parallel path to the clock provider's OF node without relying on the
internal structure of the struct phy handle.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 25 ++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..7abb42e486c0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -537,21 +537,22 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev_of_node(dev);
 	struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi *hdmi;
-	int ret;
+	int ret, index;
 
-	if (!pdev->dev.of_node)
+	if (!np)
 		return -ENODEV;
 
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
+	match = of_match_node(dw_hdmi_rockchip_dt_ids, np);
 	plat_data = devm_kmemdup(&pdev->dev, match->data,
 					     sizeof(*plat_data), GFP_KERNEL);
 	if (!plat_data)
@@ -564,9 +565,9 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	plat_data->priv_data = hdmi;
 	encoder = &hdmi->encoder.encoder;
 
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, np);
 	rockchip_drm_encoder_set_crtc_endpoint_id(&hdmi->encoder,
-						  dev->of_node, 0, 0);
+						  np, 0, 0);
 
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
@@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
 	}
 
-	if (hdmi->phy) {
+	index = of_property_match_string(np, "phy-names", "hdmi");
+	if (index >= 0) {
 		struct of_phandle_args clkspec;
 
-		clkspec.np = hdmi->phy->dev.of_node;
-		hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
-		if (IS_ERR(hdmi->hdmiphy_clk))
-			hdmi->hdmiphy_clk = NULL;
+		if (!of_parse_phandle_with_args(np, "phys", "#phy-cells", index,
+						&clkspec)) {
+			hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
+			if (IS_ERR(hdmi->hdmiphy_clk))
+				hdmi->hdmiphy_clk = NULL;
+		}
 	}
 
 	if (hdmi->chip_data == &rk3568_chip_data) {
-- 
2.43.0


