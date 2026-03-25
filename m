Return-Path: <linux-can+bounces-7248-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJo/Nv/Tw2lLuQQAu9opvQ
	(envelope-from <linux-can+bounces-7248-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 13:24:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8D324D2F
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 13:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D1D319E3A9
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7793D0932;
	Wed, 25 Mar 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UGTYVciV"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D43CFF75;
	Wed, 25 Mar 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438999; cv=fail; b=bfN30Z2nQHrWN2wAuJQzQuQaewkGlxpi+GxrKhlpIWW90XMAbfFVkBsc3T1lv/OgIKNMiHfeceRsZzalQULwxIsa4IDIIRuvEJpYTLIvufLsc7qMR20k+vvaBqHLz0zIn0gv4j4dlUbtSTy3IlwqHw3VJxEPfXnfa4LvI62X+Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438999; c=relaxed/simple;
	bh=rkDWyxlGPECYdum0VZpfyB4sdIg61BGNWdDdFIHSLlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fmvY1c4xn21KmCN/t65QJ72fHVXUpsu1XPdzwFWdUZNICWjLsuUtNxHtgQFFvoKktGtfzZ8Dbmj9OKIBf7TRr5MN5XQerXHQSOBHONGVnWOZR6oBSvzclZHo5U/l3md2F6mTlhvEkZjz0AFvSnrJUTNM4r80Q0VKcO6ehOVVmXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UGTYVciV; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH8ZZQzS2OdB6qF4VXP16jqy/py/KwYbSEWi4QMr5oREoIF0sd6flhhIWocF2d46TCg/pZDGH8wfmtql+BRGcA7v61BUr9a1nSKEc8RtfNZcItViIxbicO186k/0r2qsfPQfIBTIxUSYXri0eKwFniFyhPoQUczblcnTeib+uNLxX9c1oiqy88qlrpKrRguwL85Gd5+zbR6O6s8ZKWlndGsSqA1d3PWfo+CBMG52EBkHp2JLGi/qQWal1U7ijsJOISnuYe+sy69cPa5iK7SE3H793auHu9xD26Sjd51xHhZLinnei/EJ8UFbX8ItO+hFHt5kmnw8AqrJRjaUaJCmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vFKXGa9EyD8gCXVhuW4dfTTmiqy4V75PSWVxTxMQzg=;
 b=jFHsQgypE2B+Al12DONj51EYkCGZVj7Ws1EretlxmcCTgbL48Y4hX0h0YqMmaP/UbvMvJs+8VjXo6YwTb3VMeKMGLXDr7lFK8g6uX0AAjisIg0seD7ONO+paMfXNp7Lmn3iTkGciCqpEvBaAflqRsYQn84G25F28fjN1jWBduFh355tHbgllVtw7beOzmUoATxkhnqbPYHBXqQM1o3+L9eAi3uNOsoMtwWIEGaTyO8APOt7xtlOmouUpysgZJLdJgmzjaxNvtOhE+TBdIsfVXtFwx/bsLB1DJlL7RMLkEqlqVxh1ZNRzCrkyANGjp5z+o1f7u90D8VYl7tWGRHvvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vFKXGa9EyD8gCXVhuW4dfTTmiqy4V75PSWVxTxMQzg=;
 b=UGTYVciVvvAlZoVyaHQ4sIVKvJkenXwmIYlUaIAfT7iwuIBSU3AIfwawHFV6Us0h7VexloxUEmSv8c+eZg/y/Z0vqwTKaCTWeE7aHcrY6HASM56funP/+uvZrLur9BNAgrumKOwJIDknHSO6/yPkYITfjBhLoRMIItipy+Yc1yYytQiDs8HJamwFns3mQqO9s0puCNSw6uET+r9ZqDQ7qsDreAERcrdDMa4bqh5RcPUtz3SyDAavX8yr29bHlZehkdc7AySXTPKonW4eCFucVo5vuMma76+FOC9D9+/vzqLqDUZF4r7JFmU9d00Eite8YBEfEwl2yOB/FQw7JiEyCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:43:14 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:43:13 +0000
Date: Wed, 25 Mar 2026 13:43:09 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH v5 phy-next 10/27] scsi: ufs: qcom: keep parallel track
 of PHY power state
Message-ID: <20260325114309.3k7xkfrffpxp5xq4@skbuf>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
 <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 67580038-d939-42e6-4c8c-08de8a63b29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|10070799003|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TDkLjGCk59oxN3k1h6kJNSkkPPysnIDson/TIrmVIcgitvLI2U93YTY2h5IX9usTD1geEAZ53Ta6v0FnQog3RBCtFzfHVKXaH8a2ff+rlHWLfgsg9du5zgtMxyZJgBake3QxQHNMd4ckY6vKFn28qt69ebzHZpOoazQTPfLWJcNebOe6B+SWwTDfSRRaZbwCa8WYbvaeylgThEXQ6Nlpti7VB6lVDGN9l4e4vVHVP8LYtcaql8naBE8KChH8wHvm7PoL3LuO3b95RRUc2jOiHyoeYKKDkhYZjFAPdjuySt25aZmAYS+rD/zTGzBD7TRxEMTa2Yq59185y5tT5M4LbVPUEPB0kPc2nKfKZ6Oi318nbm3MzmSXRBGQ1uCs97WsEvPFz3FhOyHOIVGj69f/Txivn2ZqNChAq2pqVJzGsRrJ4y+sFQUCJ+32svBOCqZSvfDuAdL5NMB9RZVRSYIbldyr/5pHJVmcpp7HnkDsO0Xp7LMXNnrdwvHhnY7Wycwh3c2siHVVUYE7D3AI3NsznE8KL2L5RrGUMeZkhFNUI2wLHDkQIbmfnmszrPjZ2FOBKJCNUniOSvl+RhyVz/g3r0ctq7EWzftn2L3TxEmo+V0i+VoLQzqcyWHWEVmrBUyX8hG7yf8ZI3fY2O6uan4h9DAZ9FllPesQnXvPRt8rzInQEhwDlGaA02TR70y/I7uyzbthwQKYJtS7abjrALnkrYQhqpaeOp3d7bYwFWQfHmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(10070799003)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWJmwLPIaoPbZ3tsima06lFTVXZJ+kNEMNmQ1rLIvpkStZFV4qgzde6HZnQF?=
 =?us-ascii?Q?INw6NbJlg+GlePToErCCZ5GWtlT85g8ZhEu/wuJ+GG1U57oDOvLwnH6Ghdz3?=
 =?us-ascii?Q?u26jhEN0CJLnhrhVECS087aURkMMqM61Qf/J4oYxdPgqc7xUZekWNrZHFTiz?=
 =?us-ascii?Q?HN8DkgshAIi7ZEtgpxdMivW2xo7WnG9LbWm/Al2dJtGtJz8QSW9hCAdXb+Ik?=
 =?us-ascii?Q?71QtFJcf4Q63lOkk+KGeSPWbfYrWb+G6c8n+xxDmez/7ITXrk5dIj44vYZ8I?=
 =?us-ascii?Q?LQjWW433kNESUzpCrCkHdBxfILWUhsRT5LxsUDKki46x8r6Ehc7HgIzB8EAC?=
 =?us-ascii?Q?M5I3xb02ApH4fs6UXNUik9AZuY/HlkdJfuR6wEEb7emsbrYaY9nn7gvkPX+f?=
 =?us-ascii?Q?dqEJtgmAY1MKmS28xFpp56nIZxtUyx8UYfxEdlpGbCdXBaj6Dn4fytOsEC2D?=
 =?us-ascii?Q?66F5QRM6NKDBtzK4BXaXm1tOydMVgathTqf1rQOtwctkPBn9SbigyrcOeiNl?=
 =?us-ascii?Q?f1LjUfWjhwLcjBRROm3s4Ff0fhc3YRKNIjTTnLbVZCSvuhu0TcutpzDS+kab?=
 =?us-ascii?Q?VJdg40ueQCZf7wUCKuBo9AY4Fgl4jFUTxNdYbnkI0V0mL0jXcKgRDFCj7vRI?=
 =?us-ascii?Q?+VOP+JSPVfMOaWV7X9DFYMS/5M/CCjGgiM4+Mz6s7ZIwG4ZYW2PKWIA1aX8h?=
 =?us-ascii?Q?B/Xpboh9OSQYsMd9AWc1CZz0qls8+RKQkbkJTjOKyncNLv3qYhgj/SFF6BF6?=
 =?us-ascii?Q?Ot9tJhW+GXU0XVe6TL5LqpMv4eKbxSPCgHsB5F0R6XwhODXOMuyTH2yWo3q7?=
 =?us-ascii?Q?s7MxjJzLUusLxLpLTMua31TsI8NuDjvlVMLzzbJ8Lv6Y2nno1uO3X1ORjhJ5?=
 =?us-ascii?Q?j/lj05Ws2T2x9zp8t9pojrZUhBZWR+A5fj7jdES3A+PZi6Q0TVsB+rDk2Wgy?=
 =?us-ascii?Q?xUV+PERtmnZn5kandwsQ4qhxUoYbGpu3Zv95c5+ASG0mAWK1dDM0hCsy2vTE?=
 =?us-ascii?Q?QtFnu4yf4JGlF3wZ5bPV8KyI3KGkxAUSWfVRRrCNlBa8lEyPx47xPXJo383j?=
 =?us-ascii?Q?txIWhHhIGItWBw2omRI5Uzqte2oJQsZ5M2U4aRMc+jFEMQFla/Shl4BCFHwX?=
 =?us-ascii?Q?Z2w63YAe1TBhkrY1+TaAxh6mOXGiH57xRbb9/X/oWAjQT3vczTlq3RCZhFqm?=
 =?us-ascii?Q?L7BCKQ+Ij8vN1MGCjNbPaIg+qwAFR+O27C/oav7zDm8u+U/K/q3qQ8YK27ls?=
 =?us-ascii?Q?9IjO0MfZ94aNAGD108EVSM0RFoM1sr6furWDySPe1f85ZXEVdcrMkhTRCgGd?=
 =?us-ascii?Q?AvFqg+5XNokX+gObHI5bccsihztYFauMyTsC2GuuPQgkoyDe3erpPYvaqQL8?=
 =?us-ascii?Q?qVUSjf8B9dZLZOk5yJL7hn3KAKq38jbLTmjiD8fcvxbRuLKO1Mx1wM8/6mCQ?=
 =?us-ascii?Q?Fc6gH/MWrMcGhWSzK/Dslqk2j7Ubuf0tk6B+Xu3im8EK0ak7JwDJpooWX+Iz?=
 =?us-ascii?Q?Dr6noHzzYyvCBIkXKNtId5PlZobxXghD5sroRSJb4Kfwuzaes7JCr/6A2o1H?=
 =?us-ascii?Q?UZRmsqWudf7MOom+wAtGgrjvjDQ2we0Qye8+xFX/bXhyQ1j+cv2UcDI7DWcN?=
 =?us-ascii?Q?ThBIH0KpxG8VemFn1KiHZ5rXEKvMIyIhwLOj4pRPSNvRaWZn3sXE183/tZne?=
 =?us-ascii?Q?ocNRFgVxkGc8nat2Jft2SlaXZuJYscv5Lpw3K8Qe12IzBuvivu5eEP3X8XN9?=
 =?us-ascii?Q?mVKyWcGIjUJ0oNnObUiC0B1mNf92rabwNV8vH/jsvrrlrbc1jAHH+OXqRziH?=
X-MS-Exchange-AntiSpam-MessageData-1: CXDuAeGTiO7U+w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67580038-d939-42e6-4c8c-08de8a63b29c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:43:13.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmhYKydPcdenRdeevcDFt6W4GzHXcXgFQUtOM6MfznRNXgTLw9sJ3AC3Crse1GiM4KbF/sRfeu0rtEGrlVqcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7248-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 3CF8D324D2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:00:10AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 20, 2026 at 12:32:24AM +0200, Vladimir Oltean wrote:
> > As explained in the similar ufs-exynos.c change, PHY consumer drivers
> > should not look at the phy->power_count, because in the general case
> > there might also be other consumers who have called phy_power_on() too,
> > so the fact that the power_count is non-zero does not mean that we did.
> > 
> > Moreover, struct phy will become opaque soon, so the qcom UFS driver
> > will not be able to apply this pattern. Keep parallel track of the PHY
> > power state, instead of looking at a field which will become unavailable
> > (phy->power_count).
> > 
> > About treating the phy_power_off() return code: from an API perspective,
> > this should have probably returned void, otherwise consumers would be
> > stuck in a state they can't escape. The provider, phy-qcom-qmp-ufs.c,
> > does return 0 in its power_off() implementation. I consider it safe to
> > discard potential errors from phy_power_off() instead of complicating
> > the phy_powered_on logic.
> > 
> 
> You could even simplify the code by getting rid of the 'phy_powered_on' check
> altogether. There is no real need to track the PHY power state in this driver.
> It is safe to call phy_power_off() without any checks.
> 
> - Mani

Ok.. as the author of commit 7bac65687510 ("scsi: ufs: qcom: Power off
the PHY if it was already powered on in ufs_qcom_power_up_sequence()"),
I assume you have hardware to test. Would you mind writing a patch that
I could pick up to replace this one with?

I suppose that the power_count test is somehow no longer necessary after
commit 77d2fa54a945 ("scsi: ufs: qcom : Refactor phy_power_on/off
calls"), but frankly I don't see it - the ufshcd state machine is a bit
too complicated for me to just statically analyze.

